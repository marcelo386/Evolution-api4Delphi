{
####################################################################################################################
  Obs:
     - Código aberto a comunidade Delphi, desde que mantenha os dados dos autores e mantendo sempre o nome do IDEALIZADOR
       Marcelo dos Santos de Oliveira;

####################################################################################################################
                                  Evolução do Código
####################################################################################################################
  Autor........: Marcelo Oliveira
  Email........: marcelo.broz@hotmail.com
  Data.........: 21/02/2024
  Identificador: @Marcelo
  Modificação..:
####################################################################################################################
}
unit uEvolutionAPI;

interface

uses
  System.SysUtils, System.Classes, System.JSON, System.Net.HttpClient, System.Net.URLClient, IdSSLOpenSSL, IdHTTP,
  uRetMensagem, StrUtils, Horse, Horse.Commons,  Horse.Core, web.WebBroker,
  RESTRequest4D, REST.Types, REST.Client, System.Net.Mime, uEvolutionAPI.Emoticons;


type
  {Events}
  TOnRetSendMessage = Procedure(Sender : TObject; Response: string) of object;
  TResponseEvent = Procedure(Sender : TObject; Response: string) of object;

  TEvolutionAPI = class(TComponent)

  private
    FDDIDefault: Integer;
    FToken: string;
    FOnRetSendMessage: TOnRetSendMessage;
    FOnResponse: TResponseEvent;
    FPort: Integer;
    FEmoticons: TEvolutionAPIEmoticons;
    Fwebhook_by_events: Boolean;
    FNumber: string;
    FinstanceName: string;
    FurlWebhook: string;
    Fqrcode: Boolean;
    FurlServer: string;
    function CaractersWeb(vText: string): string;

  protected


  public
    //Individual
    function SendText(waid, body: string; previewurl: string = 'false'): string;
    function SendFile(waid, body, typeFile, url: string; const filename: string = ''): string;
    function SendButton(waid, body, actions, header, footer: string): string;
    function SendListMenu(waid, body, sections, header, footer, Button_Text: string): string;
    function SendContact(waid, phoneNumber, formatted_name, options: string): string;
    function SendLocation(waid, body, Location, header, footer: string): string;
    function SendReaction(waid, message_id, emoji: string): string;
    function SendReplies(waid, message_id, reply_body: string; previewurl: string = 'false'): string;
    function MarkIsRead(waid, message_id: string): string;

    function UploadMedia(FileName: string): string;
    function PostMediaFile(FileName, MediaType: string): string;
    function DownloadMedia(id, MimeType: string): string;
    function DownloadMediaURL(url, MimeType, FileName: string): string;

    function GetContentTypeFromDataUri(const ADataUri: string): string;
    function GetContentTypeFromExtension(const AContentType: string): string;
    function GetExtensionTypeFromContentType(const AFileExtension: string): string;
    function GetTypeFileFromContentType(const AContentType: string): string;

    procedure StartServer;
    procedure StopServer;

  published
    property Token             : string                  read FToken              write FToken;
    property instanceName      : string                  read FinstanceName       write FinstanceName;
    property number            : string                  read FNUMBER             write FNUMBER;
    property urlWebhook        : string                  read FurlWebhook         write FurlWebhook;
    property webhook_by_events : Boolean                 read Fwebhook_by_events  write Fwebhook_by_events;
    property qrcode            : Boolean                 read Fqrcode             write Fqrcode;

    property urlServer         : string                  read FurlServer          write FurlServer;


    property Port              : Integer                 read FPort               write FPort               Default 8020;

    property DDIDefault        : Integer                 read FDDIDefault         write FDDIDefault         Default 55;

    property OnRetSendMessage  : TOnRetSendMessage       read FOnRetSendMessage   write FOnRetSendMessage;
    property OnResponse        : TResponseEvent          read FOnResponse         write FOnResponse;
    property Emoticons         : TEvolutionAPIEmoticons  read FEmoticons          Write FEmoticons;

  end;



procedure Register;

implementation

uses
  uWhatsAppBusinessClasses;

procedure Register;
begin
  RegisterComponents('EvolutionAPI', [TEvolutionAPI]);
end;

{ TWPPCloudAPI }


function TEvolutionAPI.CaractersWeb(vText: string): string;
begin
  vText  := StringReplace(vText, sLineBreak,' \n' , [rfReplaceAll] );
  vText  := StringReplace(vText, '<br>'    ,' \n' , [rfReplaceAll] );
  vText  := StringReplace(vText, '<br />'  ,' \n' , [rfReplaceAll] );
  vText  := StringReplace(vText, '<br/>'   ,' \n' , [rfReplaceAll] );
  vText  := StringReplace(vText, #13       ,''    , [rfReplaceAll] );
  vText  := StringReplace(vText, '\r'      ,''    , [rfReplaceAll] );
  vText  := StringReplace(vText, '"'       ,'\"' , [rfReplaceAll] );
  vText  := StringReplace(vText, #$A       ,' \n'   , [rfReplaceAll] );
  vText  := StringReplace(vText, #$A#$A    ,' \n'   , [rfReplaceAll] );
  Result := vText;
end;

function TEvolutionAPI.DownloadMedia(id, MimeType: string): string;
var
  response: string;
  json: string;
  //MessagePayload: uRetMensagemApiOficial.TMessagePayload;
  UrlMediaFile: TUrlMedia;
  UTF8Texto: UTF8String;
begin
  Result := '';
  try
    {if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;
    }

    //body := CaractersWeb(body);

    (*json :=
      '{ ' +
      '  "messaging_product": "whatsapp", ' +
      '  "recipient_type": "individual", ' +
      '  "to": "' + waid + '", ' +
      '  "type": "text", ' +
      '  "text": {  ' + // the text object
      '    "preview_url": ' + previewurl + ',  ' +
      '    "body": "' + body + '"  ' +
      '    } ' +
      '}'; *)

    UTF8Texto := UTF8Encode(json);

    try
      response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/' + id + '')
        .ContentType('application/json')
        .TokenBearer(Token)
        //.AddBody(UTF8Texto)
        .Get
        .Content;
      //gravar_log(response);
    except
      on E: Exception do
      begin
        //
        //gravar_log('ERROR ' + e.Message + SLINEBREAK);
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;


    try
      if Assigned(FOnRetSendMessage) then
        FOnRetSendMessage(Self, Response + #13#10);

      UrlMediaFile := TUrlMedia.FromJsonString(response);
      Result := UrlMediaFile.url;
    except
      on E: Exception do
      begin
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;

  finally
  end;

end;

function TEvolutionAPI.DownloadMediaURL(url, MimeType, FileName: string): string;
var
  response: string;
  UrlMediaFile: TUrlMedia;
  Stream: TStream;
  FileStream: TFileStream;
  Buffer: array[0..8191] of Byte; // Buffer para ler/gravar dados
  BytesRead: Integer;
begin
  Result := '';
  try
    try
      Stream := TStream.Create;

      Stream := TRequest.New.BaseURL(url)
        //.ContentType('application/json')
        .ContentType(MimeType)
        //.AcceptEncoding('UTF8')
        .TokenBearer(Token)
        .Get
        .ContentStream;
    except
      on E: Exception do
      begin
        Result := 'Error: ' + e.Message;
        //Exit;
      end;
    end;

    try
      if Assigned(Stream) then
      begin
        FileStream := TFileStream.Create(FileName, fmCreate);
        try
          Stream.Position := 0; // Certifique-se de que a posição do stream está no início

          repeat
            BytesRead := Stream.Read(Buffer, SizeOf(Buffer));
            if BytesRead > 0 then
              FileStream.Write(Buffer, BytesRead);
          until BytesRead = 0;
        finally
          FileStream.Free;
        end;
      end
      else
      begin
        Result := 'Error: Stream is not assigned';
      end;

      if Result = '' then
      begin
        Result := FileName;
        if Assigned(FOnRetSendMessage) then
          FOnRetSendMessage(Self, Result + #13#10);
      end;
    except
      on E: Exception do
      begin
        Result := 'Error: ' + e.Message;
      end;
    end;


  finally
    try
      //FreeAndNil(Stream);
    except
    end;

  end;

end;

function TEvolutionAPI.MarkIsRead(waid, message_id: string): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  MessagePayload: uRetMensagem.TMessagePayload;
begin
  Result := '';
  try
    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    json :=
      '{ ' +
      '  "messaging_product": "whatsapp", ' +
      '  "status": "read", ' +
      '  "message_id": "' + message_id + '" ' +
      '}';

    UTF8Texto := UTF8Encode(json);

    try
      response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/' + instanceName + '/messages')
        .ContentType('application/json')
        .TokenBearer(Token)
        .AddBody(UTF8Texto)
        .Post
        .Content;


      //gravar_log(response);
    except
      on E: Exception do
      begin
        //gravar_log('ERROR ' + e.Message + SLINEBREAK);
        Result := 'Error: ' + e.Message + SLineBreak + json + SLineBreak;
        Exit;
      end;
    end;

    Result := response;


  finally
  end;

end;

function TEvolutionAPI.SendButton(waid, body, actions, header, footer: string): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  MessagePayload: uRetMensagem.TMessagePayload;
begin
  Result := '';
  try

    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    body := CaractersWeb(body);

    json :=
      '{ ' +
      '  "messaging_product": "whatsapp", ' +
      '  "recipient_type": "individual", ' +
      '  "to": "' + waid + '", ' +
      '  "type": "interactive", ' +
      '  "interactive": {  ' +
      '  "type": "button", ' +
      IfThen( Trim(header) <> '' ,
      '  "header": { ' +
      '    "type": "text",  ' +
      '    "text": "' + header + '"  ' +
      '  }, ', '') +

      '  "body": { ' +
      '    "text": "' + body + '" ' +
      '  }, ' +

      IfThen( Trim(footer) <> '' ,
      '  "footer": { ' +
      '    "text": "' + footer + '" ' +
      '  }, ', '') +
      actions +

      (*
      '  "action": { ' +
      '    "buttons": [ ' +
      '      {  ' +
      '        "type": "reply", ' +
      '        "reply": { ' +
      '          "id": "UNIQUE_BUTTON_ID_1", ' +
      '          "title": "SIM" ' +
      '        } ' +
      '      }, ' +
      '      {  ' +
      '        "type": "reply", ' +
      '        "reply": { ' +
      '          "id": "UNIQUE_BUTTON_ID_2", ' +
      '          "title": "NÃO" ' +
      '        } ' +
      '      } ' +
      '    ]  ' +
      '  } ' +
      ' } ' +
      *)

      '}';

    UTF8Texto := UTF8Encode(json);

    try
      response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/' + instanceName + '/messages')
        .ContentType('application/json')
        .TokenBearer(Token)
        .AddBody(UTF8Texto)
        .Post
        .Content;

      //gravar_log(response);
    except
      on E: Exception do
      begin
        //
        //gravar_log('ERROR ' + e.Message + SLINEBREAK);
        Result := 'Error';
        Exit;
      end;
    end;

    try
      if Assigned(FOnRetSendMessage) then
        FOnRetSendMessage(Self, Response);

      MessagePayload := TMessagePayload.FromJSON(response);
      Result := MessagePayload.Messages[0].ID;
    except
      on E: Exception do
      begin
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;


  finally
  end;

end;

function TEvolutionAPI.SendContact(waid, phoneNumber, formatted_name, options: string): string;
var
  http: TIdHTTP;
  ssl: TIdSSLIOHandlerSocketOpenSSL;
  postData: TStringStream;
  response: string;
  json: string;
  MessagePayload: uRetMensagem.TMessagePayload;
  UTF8Texto: UTF8String;
begin
  Result := '';
  try

    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    //body := CaractersWeb(body);

    json :=
      '{ ' +
      '  "messaging_product": "whatsapp", ' +
      '  "recipient_type": "individual", ' +
      '  "to": "' + waid + '", ' +
      '  "type": "contacts", ' +
      '  "contacts": [{  ' +
      '    "addresses": [{ ' +
      '        "street": "STREET", ' +
      '        "city": "VOTUPORANGA", ' +
      '        "state": "SP", ' +
      '        "zip": "", ' +
      '        "country": "", ' +
      '        "country_code": "55", ' +
      '        "type": "HOME" ' +
      '      }, ' +
      '      { ' +
      '        "street": "STREET", ' +
      '        "city": "CITY", ' +
      '        "state": "STATE", ' +
      '        "zip": "ZIP", ' +
      '        "country": "COUNTRY", ' +
      '        "country_code": "55", ' +
      '        "type": "WORK" ' +
      '      }], ' +
      '    "birthday": "", ' +
      '    "emails": [{ ' +
      '        "email": "", ' +
      '        "type": "WORK" ' +
      '      }, ' +
      '      { ' +
      '        "email": "", ' +
      '        "type": "HOME" ' +
      '      }], ' +
      '    "name": { ' +
      '      "formatted_name": "' + formatted_name + '", ' +
      '      "first_name": "' + formatted_name + '", ' +
      '      "last_name": "", ' +
      '      "middle_name": "", ' +
      '      "suffix": "", ' +
      '      "prefix": "" ' +
      '    }, ' +
      '    "org": { ' +
      '      "company": "", ' +
      '      "department": "", ' +
      '      "title": "" ' +
      '    }, ' +
      '    "phones": [{ ' +
      '       "phone": "' + phoneNumber + '", ' +
      '       "type": "HOME", ' +
      '       "wa_id": "' + phoneNumber + '" ' +
      '     } ' +
      //'     { ' +
      //'       "phone": "PHONE_NUMBER", ' +
      //'       "type": "WORK", ' +
      //'       "wa_id": "PHONE_OR_WA_ID" ' +
      '      ] ' +
      '  }] ' +
      '}';

    UTF8Texto := UTF8Encode(json);
    try

      response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/' + instanceName + '/messages')
        .ContentType('application/json')
        .TokenBearer(Token)
        .AddBody(UTF8Texto)
        .Post
        .Content;


      //gravar_log(response);
    except
      on E: Exception do
      begin
        //gravar_log('ERROR ' + e.Message + SLINEBREAK);
        //MemoLogApiOficial.Lines.Add(json + SLINEBREAK);
        Result := 'Error ' + e.Message + SLINEBREAK;
        //MemoLogApiOficial.Lines.Add(response);
        Exit;
      end;
    end;

    try
      if Assigned(FOnRetSendMessage) then
        FOnRetSendMessage(Self, Response);

      MessagePayload := TMessagePayload.FromJSON(response);
      Result := MessagePayload.Messages[0].ID;
    except
      on E: Exception do
      begin
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;

  finally
  end;

end;

function TEvolutionAPI.SendFile(waid, body, typeFile, url: string; const filename: string = ''): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  MessagePayload: uRetMensagem.TMessagePayload;
begin
  Result := '';
  try
    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    body := CaractersWeb(body);

    json :=
      '{ ' +
      '  "messaging_product": "whatsapp", ' +
      '  "recipient_type": "individual", ' +
      '  "to": "' + waid + '", ' +
      '  "type": "' + typeFile + '", ' +
      '  "' + typeFile + '": {  ' +
      '    "link": "' + url + '"  ' +
      //'    ,"caption": "' + body + '"  ' +
      IfThen( Trim(body) <> '' ,' ,"caption": "' + body + '"  ', '') +
      IfThen( Trim(filename) <> '' ,' ,"filename": "' + filename + '"  ', '') +
      '    } ' +
      '}';

    UTF8Texto := UTF8Encode(json);
    try
      response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/' + instanceName + '/messages')
        .ContentType('application/json')
        .TokenBearer(Token)
        .AddBody(UTF8Texto)
        .Post
        .Content;

      //gravar_log(response);
    except
      on E: Exception do
      begin
        //
        //gravar_log('ERROR ' + e.Message + SLINEBREAK);
        //MemoLogApiOficial.Lines.Add(json + SLINEBREAK);
        if Assigned(FOnRetSendMessage) then
          FOnRetSendMessage(Self, 'Error: ' + e.Message);
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;

    try
      if Assigned(FOnRetSendMessage) then
        FOnRetSendMessage(Self, Response);

      MessagePayload := TMessagePayload.FromJSON(response);
      Result := MessagePayload.Messages[0].ID;
    except
      on E: Exception do
      begin
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;

    //MemoLogApiOficial.Lines.Add(response);
    //MemoLogApiOficial.Lines.Add('');
    //MemoLogApiOficial.Lines.Add('Unique id: ' + MessagePayload.Messages[0].ID);
    //gravar_log('Unique id: ' + MessagePayload.Messages[0].ID);
  finally
  end;

end;

function TEvolutionAPI.SendListMenu(waid, body, sections, header, footer, Button_Text: string): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  MessagePayload: uRetMensagem.TMessagePayload;
begin
  Result := '';
  try
    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    body := CaractersWeb(body);

    json :=
      '{ ' +
      '  "messaging_product": "whatsapp", ' +
      '  "recipient_type": "individual", ' +
      '  "to": "' + waid + '", ' +
      '  "type": "interactive", ' +
      '  "interactive": {  ' +
      '    "type": "list", ' +
      IfThen( Trim(header) <> '' ,
      '    "header": { ' +
      '      "type": "text",  ' +
      '      "text": "' + header + '"  ' +
      '    }, ', '') +

      '    "body": { ' +
      '      "text": "' + body + '" ' +
      '    }, ' +

      IfThen( Trim(footer) <> '' ,
      '    "footer": { ' +
      '      "text": "' + footer + '" ' +
      '    }, ', '') +

      '    "action": { ' +
      '      "button": "' + Button_Text + '", ' +

      Sections +
      (*
      '      "sections": [  ' +
      '      {   ' +
      '        "title": "SECTION_1_TITLE", ' +
      '        "rows": [ ' +
      '        { ' +
      '          "id": "SECTION_1_ROW_1_ID", ' +
      '          "title": "SECTION_1_ROW_1_TITLE", ' +
      '          "description": "SECTION_1_ROW_1_DESCRIPTION" ' +
      '        }, ' +
      '        {  ' +
      '          "id": "SECTION_1_ROW_2_ID", ' +
      '          "title": "SECTION_1_ROW_2_TITLE", ' +
      '          "description": "SECTION_1_ROW_2_DESCRIPTION" ' +
      '        } ' +
      '      ] ' +
      '      }, ' +
      '      { ' +
      '        "title": "SECTION_2_TITLE",  ' +
      '        "rows": [  ' +
      '        {  ' +
      '          "id": "SECTION_2_ROW_1_ID", ' +
      '          "title": "SECTION_2_ROW_1_TITLE", ' +
      '          "description": "SECTION_2_ROW_1_DESCRIPTION" ' +
      '        }, ' +
      '        {  ' +
      '          "id": "SECTION_2_ROW_2_ID", ' +
      '          "title": "SECTION_2_ROW_2_TITLE", ' +
      '          "description": "SECTION_2_ROW_2_DESCRIPTION"  ' +
      '          } ' +
      '         ] ' +
      '        } ' +
      '      ] ' +
      *)

      '  } ' +
      ' } ' +
      '}';

    //json := Trim(json);
    //json := EscapeJsonString(json);
    UTF8Texto := UTF8Encode(json);

    try

      response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/' + instanceName + '/messages')
        .ContentType('application/json')
        .TokenBearer(Token)
        .AddBody(UTF8Texto)
        .Post
        .Content;

      //gravar_log(response);
    except
      on E: Exception do
      begin

        //MemoLogApiOficial.Lines.Add(json + SLINEBREAK);
        //gravar_log('ERROR ' + e.Message + SLINEBREAK);
        Result := 'Error';
        Exit;
      end;
    end;

    try
      if Assigned(FOnRetSendMessage) then
        FOnRetSendMessage(Self, Response);

      MessagePayload := TMessagePayload.FromJSON(response);
      Result := MessagePayload.Messages[0].ID;
    except
      on E: Exception do
      begin
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;


  finally
  end;

end;

function TEvolutionAPI.SendLocation(waid, body, Location, header, footer: string): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  MessagePayload: uRetMensagem.TMessagePayload;
begin
  Result := '';

  try
    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    body := CaractersWeb(body);

    json :=
      '{ ' +
      '  "messaging_product": "whatsapp", ' +
      //'  "recipient_type": "individual", ' +
      '  "to": "' + waid + '", ' +
      '  "type": "location", ' +

      (*
      IfThen( Trim(header) <> '' ,
      '  "header": { ' +
      '    "type": "text",  ' +
      '    "text": "' + header + '"  ' +
      '  }, ', '') +

      IfThen( Trim(body) <> '' ,
      '  "body": { ' +
      '    "text": "' + body + '" ' +
      '  }, ', '') +

      IfThen( Trim(footer) <> '' ,
      '  "footer": { ' +
      '    "text": "' + footer + '" ' +
      '  }, ', '') +
      *)

      Location +
      '}';

    UTF8Texto := UTF8Encode(json);

    try

      response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/' + instanceName + '/messages')
        .ContentType('application/json')
        .TokenBearer(Token)
        .AddBody(UTF8Texto)
        .Post
        .Content;
      //gravar_log(response);
    except
      on E: Exception do
      begin
        //
        //gravar_log('ERROR ' + e.Message + SLINEBREAK);
        Result := 'Error: ' + e.Message + SLineBreak + json + SLineBreak;
        Exit;
      end;
    end;

    try
      if Assigned(FOnRetSendMessage) then
        FOnRetSendMessage(Self, Response);

      MessagePayload := TMessagePayload.FromJSON(response);
      Result := MessagePayload.Messages[0].ID;
    except
      on E: Exception do
      begin
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;

  finally
  end;

end;

function TEvolutionAPI.SendReaction(waid, message_id, emoji: string): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  MessagePayload: uRetMensagem.TMessagePayload;
begin
  Result := '';


  try
    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    json :=
      '{ ' +
      '  "messaging_product": "whatsapp", ' +
      '  "recipient_type": "individual", ' +
      '  "to": "' + waid + '", ' +
      '  "type": "reaction", ' +
      '  "reaction": { ' +
      '    "message_id": "' + message_id + '", ' +
      '    "emoji": "' + emoji + '" ' +
      '  } ' +
      '}';

    UTF8Texto := UTF8Encode(json);
    try
      response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/' + instanceName + '/messages')
        .ContentType('application/json')
        .TokenBearer(Token)
        .AddBody(UTF8Texto)
        .Post
        .Content;
      //gravar_log(response);
    except
      on E: Exception do
      begin
        //
        //gravar_log('ERROR ' + e.Message + SLINEBREAK);
        Result := 'Error: ' + e.Message + SLineBreak + json + SLineBreak;
        Exit;
      end;
    end;

    try
      if Assigned(FOnRetSendMessage) then
        FOnRetSendMessage(Self, 'EMOJI: ' + Response);

      MessagePayload := TMessagePayload.FromJSON(response);
      Result := MessagePayload.Messages[0].ID;
    except
      on E: Exception do
      begin
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;

  finally

  end;

end;

function TEvolutionAPI.SendReplies(waid, message_id, reply_body: string; previewurl: string): string;
var
  response: string;
  json: string;
  MessagePayload: uRetMensagem.TMessagePayload;
  UTF8Texto: UTF8String;
begin
  Result := '';

  try


    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    reply_body := CaractersWeb(reply_body);

    json :=
      '{ ' +
      '  "messaging_product": "whatsapp", ' +
      '   "context": { ' +
      '     "message_id": "' + message_id + '" ' +
      '   }, ' +
      '  "to": "' + waid + '", ' +
      '  "type": "text", ' +
      '  "text": {  ' + // the text object
      '    "preview_url": ' + previewurl + ',  ' +
      '    "body": "' + reply_body + '"  ' +
      '    } ' +
      '}';

    UTF8Texto := UTF8Encode(json);

    try
      response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/' + instanceName + '/messages')
        .ContentType('application/json')
        .TokenBearer(Token)
        .AddBody(UTF8Texto)
        .Post
        .Content;
      //gravar_log(response);
    except
      on E: Exception do
      begin
        //
        //gravar_log('ERROR ' + e.Message + SLINEBREAK);
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;


    try
      if Assigned(FOnRetSendMessage) then
        FOnRetSendMessage(Self, Response);

      MessagePayload := TMessagePayload.FromJSON(response);
      Result := MessagePayload.Messages[0].ID;
    except
      on E: Exception do
      begin
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;


  finally
  end;

end;

function TEvolutionAPI.SendText(waid, body, previewurl: string): string;
var
  response: string;
  json: string;
  MessagePayload: uRetMensagem.TMessagePayload;
  UTF8Texto: UTF8String;
begin
  Result := '';
  try
    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    body := CaractersWeb(body);

    json :=
      '{ ' +
      '  "messaging_product": "whatsapp", ' +
      '  "recipient_type": "individual", ' +
      '  "to": "' + waid + '", ' +
      '  "type": "text", ' +
      '  "text": {  ' + // the text object
      '    "preview_url": ' + previewurl + ',  ' +
      '    "body": "' + body + '"  ' +
      '    } ' +
      '}';

    UTF8Texto := UTF8Encode(json);

    try
      response:= TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/' + instanceName + '/messages')
        .ContentType('application/json')
        .TokenBearer(Token)
        .AddBody(UTF8Texto)
        .Post
        .Content;
      //gravar_log(response);
    except
      on E: Exception do
      begin
        //
        //gravar_log('ERROR ' + e.Message + SLINEBREAK);
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;


    try
      if Assigned(FOnRetSendMessage) then
        FOnRetSendMessage(Self, Response);

      MessagePayload := TMessagePayload.FromJSON(response);
      Result := MessagePayload.Messages[0].ID;
    except
      on E: Exception do
      begin
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;

    //MemoLogApiOficial.Lines.Add(response);
    //MemoLogApiOficial.Lines.Add('');
    //MemoLogApiOficial.Lines.Add('Unique id: ' + MessagePayload.Messages[0].ID);
    //gravar_log('Unique id: ' + MessagePayload.Messages[0].ID);
  finally
  end;


end;

procedure TEvolutionAPI.StartServer;
begin
  THorse
    .Post('/responsewebhook',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        Response: string;
      begin
        Response := 'save response webhook ok';
        Res.Send(Response);

        Response := Req.Body;
        if Assigned(FOnResponse) then
          FOnResponse(Self, Response);
      end
    );

  if Port = 0 then
    Port := 8020;

  THorse.MaxConnections := 500;
  THorse.Port := Port;
  THorse.Listen;
end;

procedure TEvolutionAPI.StopServer;
begin
  THorse.StopListen;
end;

function TEvolutionAPI.PostMediaFile(FileName, MediaType: string): string;
var
  RESTClient: TRESTClient;
  RESTRequest: TRESTRequest;
  RESTResponse: TRESTResponse;
  MediaID: string;
  AccessToken: string;
  FilePath: string;
  //MediaType: string;
  MessagingProduct: string;
  RequestBody: TMultipartFormData;
begin
  MediaID := instanceName;//'123456';
  AccessToken := Token;//'<ACCESS_TOKEN>';
  FilePath := 'C:\Users\megao\Desktop\Temp\ArquivosTesteEnviar\Carta de Cobrança2.pdf';
  MediaType := 'document/pdf';
  MessagingProduct := 'whatsapp';

  // Criando o objeto TRESTClient e configurando as propriedades básicas
  RESTClient := TRESTClient.Create(urlServer+ ':' + Port.ToString + '/');
  RESTClient.Accept := 'application/json';
  RESTClient.ContentType := 'multipart/form-data';
  RESTClient.Params.AddItem('access_token', AccessToken, pkGETorPOST);

  // Criando o objeto TRESTRequest e configurando as propriedades básicas
  RESTRequest := TRESTRequest.Create(RESTClient);
  RESTRequest.Method := rmPOST;
  RESTRequest.Resource := MediaID + '/media';

  // Criando o objeto TMultipartFormData e adicionando os campos da requisição
  RequestBody := TMultipartFormData.Create;
  //RequestBody.AddFile('file', FilePath, MediaType);
  //RequestBody.AddField('type', MediaType, 'text/plain');
  //RequestBody.AddField('messaging_product', MessagingProduct, 'text/plain');

  RequestBody.AddFile('file', FilePath);
  RequestBody.AddField('type', MediaType);
  RequestBody.AddField('messaging_product', MessagingProduct);

  // Configurando o corpo da requisição com o objeto TMultipartFormData
  RESTRequest.AddParameter('multipart/form-data', RequestBody.ToString, pkREQUESTBODY);
  //RESTRequest.AddParameter('multipart/form-data', RequestBody);

  // Executando a requisição e obtendo a resposta
  RESTResponse := TRESTResponse.Create(RESTRequest);
  try
    try
      RESTRequest.Execute;
      Result := RESTResponse.Content;
    except
      on E: Exception do
      begin
        Result := e.Message;
        Exit;
      end;
    end;


    // processar a resposta aqui...
  finally
    RESTResponse.Free;
  end;
end;

function TEvolutionAPI.UploadMedia(FileName: string): string;
var
  http: TIdHTTP;
  ssl: TIdSSLIOHandlerSocketOpenSSL;
  postData: TStringStream;
  response, json, media_id: string;
  Retorno: IResponse;
  MessagePayload: uRetMensagem.TMessagePayload;
  UTF8Texto: UTF8String;
  Stream: TFileStream;
  //Buffer: TBytes;
  Reader: TStreamReader;
  LStream: TStream;
  Str: string;
var
  FileStream: TFileStream;
  MemoryStream: TMemoryStream;
  Buffer: array[0..8191] of Byte; // Buffer para ler/gravar dados
  BytesRead: Integer;
begin
  try
    // Crie um objeto TFileStream para ler o arquivo PDF
    FileStream := TFileStream.Create('C:\Users\megao\Desktop\Temp\ArquivosTesteEnviar\Carta_de_Cobrança2.pdf', fmOpenRead);

    //FileName := 'Carta_de_Cobrança2.pdf';
    FileName := '\\localhost\ArquivosTesteEnviar\Carta_de_Cobrança2.pdf';

    // Crie um objeto TMemoryStream para armazenar os dados do arquivo PDF
    MemoryStream := TMemoryStream.Create;
    LStream := TStream.Create;

    try
      // Copie os dados do TFileStream para o TMemoryStream
      MemoryStream.CopyFrom(FileStream, 0);
      //LStream.CopyFrom(FileStream, 0);
      //LStream.CopyFrom(FileStream, 0);
      //TMemoryStream(LStream).LoadFromFile('C:\Users\megao\Desktop\Temp\ArquivosTesteEnviar\Carta_de_Cobrança2.pdf');
      LStream := MemoryStream;

      {LStream.Position := 0; // Certifique-se de que a posição do LStream está no início

      repeat
        BytesRead := LStream.Read(Buffer, SizeOf(Buffer));
        if BytesRead > 0 then
          FileStream.Write(Buffer, BytesRead);
      until BytesRead = 0;
      }

      try
        //LStream := TFileStream.Create('C:\Users\megao\Desktop\Temp\ArquivosTesteEnviar\Carta_de_Cobrança2.pdf', fmOpenRead or fmShareDenyWrite);

        //Stream := TFileStream.Create('C:\Users\megao\Desktop\Comunidade_48x48.png', fmOpenRead or fmShareDenyWrite);
        //FileName := '\\LAPTOP-3HVUPL9K\ArquivosTesteEnviar\Carta de Cobrança2.pdf';
        //FileName := '\\localhost\ArquivosTesteEnviar\Carta_de_Cobrança2.pdf';
        try
          //SetLength(Buffer, Stream.Size);
          //Stream.Read(Buffer[0], Length(Buffer));
          //Reader := TStreamReader.Create(Stream);
          //Str := Reader.ReadToEnd();

          json :=
            '  { ' +
            '    "messaging_product": "whatsapp", ' +
            '    "file": "' + FileName + '",' +
            '    "type": "document/pdf" ' +
            '  } ';

          UTF8Texto := UTF8Encode(json);


          try
            //
            try
              response := TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/' + instanceName + '/media')
                //.ContentType('multipart/form-data')
                //.ContentType('application/json')
                .TokenBearer(Token)
                .AddParam('messaging_product', 'whatsapp')
                .AddParam('type', 'application/pdf')
                .AddParam('file', FileName)
                //.AddFile('file', FileName)
                //.AddFile('stream', MemoryStream, FileName, ctAPPLICATION_PDF)
                //.AddFile('stream', LStream)
                //.AddBody(UTF8Texto)
                .Post
                .Content;
                //.Post.Content;

              //Response := Retorno.Content;
            except
              on E: Exception do
              begin
                Result := 'Error: ' + e.Message;
                Exit;
              end;
            end;



            if Assigned(FOnRetSendMessage) then
              FOnRetSendMessage(Self, Response);
            //MessagePayload := TMessagePayload.FromJSON(response);
            //Result := MessagePayload.Messages[0].ID;
            Result := response;

          finally
            postData.Free;
            ssl.Free;
            http.Free;
          end;
          //WriteLn(Format('Received %d bytes of data.', [Length(Buffer)]));
        finally
          //Stream.Free;
          //Reader.Free;
        end;
        //WriteLn('Finished reading the file.');
      except
        on E: Exception do
        begin
          //WriteLn('Encountered an error while reading the file: ' + E.Message);
          Exit;
        end;
      end;
          // Agora você tem o arquivo PDF carregado no TMemoryStream
          // Você pode fazer o que quiser com os dados, como exibi-los em um componente PDF ou manipulá-los de outras maneiras.

    finally
      MemoryStream.Free;
      FileStream.Free;
    end;
  except
    on E: Exception do
      //ShowMessage('Ocorreu um erro: ' + E.Message);
      exit;
  end;

end;

function TEvolutionAPI.GetContentTypeFromDataUri(const ADataUri: string): string;
begin
  //data:audio/mpeg;
  if pos('data:', ADataUri) > 0 then
    Result := Copy(ADataUri,5,pos(';', ADataUri)-1) else
    Result := 'text/plain';
end;

function TEvolutionAPI.GetContentTypeFromExtension(const AContentType: string): string;
var
  ContentTypeList: TStringList;
begin
  ContentTypeList := TStringList.Create;
  try
    // Mapeamento de extensões para tipos de conteúdo
    ContentTypeList.Values['.html'] := 'text/html';
    ContentTypeList.Values['.htm'] := 'text/html';
    ContentTypeList.Values['.txt'] := 'text/plain';
    ContentTypeList.Values['.log'] := 'text/plain';
    ContentTypeList.Values['.csv'] := 'text/csv';
    ContentTypeList.Values['.jpg'] := 'image/jpeg';
    ContentTypeList.Values['.jpeg'] := 'image/jpeg';
    ContentTypeList.Values['.png'] := 'image/png';
    ContentTypeList.Values['.gif'] := 'image/gif';
    ContentTypeList.Values['.bmp'] := 'image/bmp';
    ContentTypeList.Values['.ico'] := 'image/x-icon';
    ContentTypeList.Values['.svg'] := 'image/svg+xml';
    ContentTypeList.Values['.pdf'] := 'application/pdf';
    ContentTypeList.Values['.doc'] := 'application/msword';
    ContentTypeList.Values['.docx'] := 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
    ContentTypeList.Values['.xls'] := 'application/vnd.ms-excel';
    ContentTypeList.Values['.xlsx'] := 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
    ContentTypeList.Values['.ppt'] := 'application/vnd.ms-powerpoint';
    ContentTypeList.Values['.pptx'] := 'application/vnd.openxmlformats-officedocument.presentationml.presentation';
    ContentTypeList.Values['.zip'] := 'application/zip';
    ContentTypeList.Values['.rar'] := 'application/x-rar-compressed';
    ContentTypeList.Values['.tar'] := 'application/x-tar';
    ContentTypeList.Values['.7z'] := 'application/x-7z-compressed';
    ContentTypeList.Values['.mp3'] := 'audio/mpeg';
    ContentTypeList.Values['.wav'] := 'audio/wav';
    ContentTypeList.Values['.mp4'] := 'video/mp4';
    ContentTypeList.Values['.avi'] := 'video/x-msvideo';
    ContentTypeList.Values['.mkv'] := 'video/x-matroska';
    ContentTypeList.Values['.xml'] := 'text/xml';
    ContentTypeList.Values['.json'] := 'application/json';
    ContentTypeList.Values['.ogg'] := 'audio/ogg';
    ContentTypeList.Values['.webm'] := 'video/webm';
    ContentTypeList.Values['.flv'] := 'video/x-flv';
    ContentTypeList.Values['.wmv'] := 'video/x-ms-wmv';
    ContentTypeList.Values['.aac'] := 'audio/aac';
    ContentTypeList.Values['.flac'] := 'audio/flac';
    ContentTypeList.Values['.css'] := 'text/css';
    ContentTypeList.Values['.js'] := 'application/javascript';
    ContentTypeList.Values['.ttf'] := 'font/ttf';
    ContentTypeList.Values['.otf'] := 'font/otf';
    ContentTypeList.Values['.woff'] := 'font/woff';
    ContentTypeList.Values['.woff2'] := 'font/woff2';
    // Adicione mais extensões e tipos de conteúdo conforme necessário

    Result := ContentTypeList.Values[AContentType];
  finally
    ContentTypeList.Free;
  end;
end;


function TEvolutionAPI.GetExtensionTypeFromContentType(const AFileExtension: string): string;
var
  ContentTypeList: TStringList;
begin
  ContentTypeList := TStringList.Create;
  try
    ContentTypeList.Values['text/html'] := '.html';
    ContentTypeList.Values['text/plain'] := '.txt';
    ContentTypeList.Values['text/csv'] := '.csv';
    ContentTypeList.Values['image/jpeg'] := '.jpg';
    ContentTypeList.Values['image/png'] := '.png';
    ContentTypeList.Values['image/gif'] := '.gif';
    ContentTypeList.Values['image/bmp'] := '.bmp';
    ContentTypeList.Values['image/x-icon'] := '.ico';
    ContentTypeList.Values['image/svg+xml'] := '.svg';
    ContentTypeList.Values['application/pdf'] := '.pdf';
    ContentTypeList.Values['application/msword'] := '.doc';
    ContentTypeList.Values['application/vnd.openxmlformats-officedocument.wordprocessingml.document'] := '.docx';
    ContentTypeList.Values['application/vnd.ms-excel'] := '.xls';
    ContentTypeList.Values['application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'] := '.xlsx';
    ContentTypeList.Values['application/vnd.ms-powerpoint'] := '.ppt';
    ContentTypeList.Values['application/vnd.openxmlformats-officedocument.presentationml.presentation'] := '.pptx';
    ContentTypeList.Values['application/zip'] := '.zip';
    ContentTypeList.Values['application/x-rar-compressed'] := '.rar';
    ContentTypeList.Values['application/x-tar'] := '.tar';
    ContentTypeList.Values['application/x-7z-compressed'] := '.7z';
    ContentTypeList.Values['audio/mpeg'] := '.mp3';
    ContentTypeList.Values['audio/wav'] := '.wav';
    ContentTypeList.Values['audio/ogg; codecs=opus'] := '.ogg';
    ContentTypeList.Values['video/mp4'] := '.mp4';
    ContentTypeList.Values['video/x-msvideo'] := '.avi';
    ContentTypeList.Values['video/x-matroska'] := '.mkv';
    ContentTypeList.Values['text/xml'] := '.xml';
    ContentTypeList.Values['application/json'] := '.json';
    ContentTypeList.Values['audio/ogg'] := '.ogg';
    ContentTypeList.Values['video/webm'] := '.webm';
    ContentTypeList.Values['video/x-flv'] := '.flv';
    ContentTypeList.Values['video/x-ms-wmv'] := '.wmv';
    ContentTypeList.Values['audio/aac'] := '.aac';
    ContentTypeList.Values['audio/flac'] := '.flac';
    ContentTypeList.Values['text/css'] := '.css';
    ContentTypeList.Values['application/javascript'] := '.js';
    ContentTypeList.Values['font/ttf'] := '.ttf';
    ContentTypeList.Values['font/otf'] := '.otf';
    ContentTypeList.Values['font/woff'] := '.woff';
    ContentTypeList.Values['font/woff2'] := '.woff2';
    // Adicione mais tipos de conteúdo e extensões conforme necessário

    Result := ContentTypeList.Values[AFileExtension];
  finally
    ContentTypeList.Free;
  end;
end;


function TEvolutionAPI.GetTypeFileFromContentType(const AContentType: string): string;
begin
  if AnsiLowerCase(Copy(AContentType, 1, pos('/', AContentType)-1)) = 'image' then
    Result := 'image'
  else
  if AnsiLowerCase(Copy(AContentType, 1, pos('/', AContentType)-1)) = 'audio' then
    Result := 'audio'
  else
  if AnsiLowerCase(Copy(AContentType, 1, pos('/', AContentType)-1)) = 'video' then
    Result := 'video'
  else
  if AnsiLowerCase(Copy(AContentType, 1, pos('/', AContentType)-1)) = 'text' then
    Result := 'document'
  else
    Result := 'document';
end;

end.
