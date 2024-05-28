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
  RESTRequest4D, REST.Types, REST.Client, System.Net.Mime, uEvolutionAPI.Emoticons, System.MaskUtils;


type
  {Events}
  TOnRetSendMessage = Procedure(Sender : TObject; Response: string) of object;
  TResponseEvent = Procedure(Sender : TObject; Response: string) of object;
  TResponseMessageUpdateEvent = Procedure(Sender : TObject; Response: string) of object;
  TResponseMessageDeleteEvent = Procedure(Sender : TObject; Response: string) of object;

  TResponseQrcodeUpdateEvent = Procedure(Sender : TObject; Response: string) of object;
  TResponseConnectionUpdateEvent = Procedure(Sender : TObject; Response: string) of object;
  TResponseCallEvent = Procedure(Sender : TObject; Response: string) of object;
  TResponseSEND_MESSAGEEvent = Procedure(Sender : TObject; Response: string) of object;
  TResponseMESSAGES_SETEvent = Procedure(Sender : TObject; Response: string) of object;

  TResponseCONTACTS_SETEvent = Procedure(Sender : TObject; Response: string) of object;
  TResponseCONTACTS_UPSERTEvent = Procedure(Sender : TObject; Response: string) of object;
  TResponseCONTACTS_UPDATEEvent = Procedure(Sender : TObject; Response: string) of object;

  TResponsePRESENCE_UPDATEEvent = Procedure(Sender : TObject; Response: string) of object;

  TResponseCHATS_SETEvent = Procedure(Sender : TObject; Response: string) of object;
  TResponseCHATS_UPSERTEvent = Procedure(Sender : TObject; Response: string) of object;
  TResponseCHATS_UPDATEEvent = Procedure(Sender : TObject; Response: string) of object;
  TResponseCHATS_DELETEEvent = Procedure(Sender : TObject; Response: string) of object;

  TResponseGROUPS_SETEvent = Procedure(Sender : TObject; Response: string) of object;
  TResponseGROUPS_UPSERTEvent = Procedure(Sender : TObject; Response: string) of object;
  TResponseGROUP_UPDATEEvent = Procedure(Sender : TObject; Response: string) of object;
  TResponseGROUP_PARTICIPANTS_UPDATEEvent = Procedure(Sender : TObject; Response: string) of object;

  TEvolutionAPI = class(TComponent)

  private
    FDDIDefault: Integer;
    FToken: string;
    FOnRetSendMessage: TOnRetSendMessage;
    FOnResponse: TResponseEvent;
    FOnResponseMessageUpdate: TResponseMessageUpdateEvent;
    FOnResponseMessageDelete: TResponseMessageDeleteEvent;
    FOnResponseQrcodeUpdate: TResponseQrcodeUpdateEvent;

    FPort: Integer;
    FEmoticons: TEvolutionAPIEmoticons;
    Fwebhook_by_events: Boolean;
    FNumber: string;
    FinstanceName: string;
    FurlWebhook: string;
    Fqrcode: Boolean;
    FurlServer: string;
    FPortWebhook: Integer;
    FOnResponseConnectionUpdate: TResponseConnectionUpdateEvent;
    FOnResponseCallUpdate: TResponseCallEvent;

    FOnResponseSEND_MESSAGE: TResponseSEND_MESSAGEEvent;
    FOnResponseMESSAGES_SET: TResponseMESSAGES_SETEvent;
    FOnResponseCONTACTS_SET: TResponseCONTACTS_SETEvent;
    FOnResponseCONTACTS_UPSERT: TResponseCONTACTS_UPSERTEvent;
    FOnResponseCONTACTS_UPDATE: TResponseCONTACTS_UPDATEEvent;
    FOnResponseCHATS_SET: TResponseCHATS_SETEvent;

    FOnResponsePRESENCE_UPDATE: TResponsePRESENCE_UPDATEEvent;
    FOnResponseCHATS_UPSERT: TResponseCHATS_UPSERTEvent;
    FOnResponseCHATS_UPDATE: TResponseCHATS_UPDATEEvent;
    FOnResponseCHATS_DELETE: TResponseCHATS_DELETEEvent;
    FOnResponseGROUPS_UPSERT: TResponseGROUPS_UPSERTEvent;
    FOnResponseGROUP_PARTICIPANTS_UPDATE: TResponseGROUP_PARTICIPANTS_UPDATEEvent;
    FOnResponseGROUP_UPDATE: TResponseGROUP_UPDATEEvent;
    FOnResponseGROUPS_SET: TResponseGROUPS_SETEvent;
    FLengthDDD: Integer;

    FLengthPhone: Integer;
    FAllowOneDigit: Boolean;
    FLengthDDI: integer;

    function CaractersWeb(vText: string): string;

  protected


  public
    //Individual
    function CreateInstanceBasic(instanceName, tokenInstancia, number: string; qrcode: Boolean): string;
    function CreateInstanceWithWebhook(instanceName, token, number, urlWebhook, eventos: string; qrcode, webhook_by_events: Boolean): string;
    function SetWebhook(url, events: string; webhook_by_events, webhook_base64: Boolean): string;
    function SetSettings(reject_call, msg_call, groups_ignore, always_online, read_messages, read_status: string): string;
    function SendText(waid, body: string; previewurl: string = 'false'): string;
    function SendFile(waid, body, typeFile, url: string; const filename: string = ''): string;
    function SendFileBase64(waid, body, typeFile, Base64: string; const filename: string = ''): string;
    function SendNarratedAudio(waid, url: string): string;
    function SendNarratedAudioBase64(waid, Base64: string): string;
    function SendSticker(waid, url: string): string;
    function SendStickerBase64(waid, Base64: string): string;
    function SendButton(waid, body, actions, header, footer: string): string;
    function SendListMenu(waid, body, sections, header, footer, Button_Text: string): string;
    function SendContact(waid, phoneNumber, formatted_name, options: string): string;
    function SendLocation(waid, body, Location, header, footer: string): string;
    function SendReaction(waid, message_id, emoji, fromMe: string): string;
    function SendReplies(waid, message_id, reply_body, reply_remoteJid, message_body, fromMe: string; previewurl: string = 'false'): string;
    function MarkIsRead(waid, message_id, fromMe: string): string;
    function DeleteMessage(waid, message_id, fromMe, paticipant: string): string;
    function EditMessage(waid, message_id, fromMe, number, newMessageEdit: string): string;
    function CheckNumberExists(numbers: string): string;
    function fetchProfilePictureUrl(waid: string): string;
    function connectionState(instanceName: string): string;
    function logout(instanceName: string): string;
    function DeleteInstance(instanceName: string): string;
    function RestartInstance(instanceName: string): string;
    function InstanceConnect(instanceName: string): string;
    function fetchInstances: string;
    function findWebhook(instanceName: string): string;

    function findContacts: string;
    function findChats: string;
    function findMessages(remoteJid: string): string;
    function getBase64FromMediaMessage(id, convertToMp4: string): string;


    function UploadMedia(FileName: string): string;
    function PostMediaFile(FileName, MediaType: string): string;
    function DownloadMedia(id, MimeType: string): string;
    function DownloadMediaURL(url, MimeType, FileName: string): string;

    function GetContentTypeFromDataUri(const ADataUri: string): string;
    function GetContentTypeFromExtension(const AContentType: string): string;
    function GetExtensionTypeFromContentType(const AFileExtension: string): string;
    function GetTypeFileFromContentType(const AContentType: string): string;
    function GetTypeFileFromExtension(const AFileExtension: string): string;

    Function  FormatOut(PNum:String): String;

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
    property Port              : Integer                 read FPort               write FPort               Default 8080;
    property PortWebhook       : Integer                 read FPortWebhook        write FPortWebhook        Default 8020;
    property DDIDefault        : Integer                 read FDDIDefault         write FDDIDefault         Default 55;

    property LengthDDI         : integer                 read FLengthDDI          write FLengthDDI Default 2;
    property LengthDDD         : Integer                 read FLengthDDD          write FLengthDDD Default 2;
    property LengthPhone       : Integer                 read FLengthPhone        write FLengthPhone Default 9;
    property AllowOneDigitMore : Boolean                 read FAllowOneDigit      write FAllowOneDigit default True;

    property OnRetSendMessage           : TOnRetSendMessage               read FOnRetSendMessage            write FOnRetSendMessage;
    property OnResponse                 : TResponseEvent                  read FOnResponse                  write FOnResponse;
    property OnResponseMessageUpdate    : TResponseMessageUpdateEvent     read FOnResponseMessageUpdate     write FOnResponseMessageUpdate;
    property OnResponseMessageDelete    : TResponseMessageDeleteEvent     read FOnResponseMessageDelete     write FOnResponseMessageDelete;


    property OnResponseQrcodeUpdate     : TResponseQrcodeUpdateEvent      read FOnResponseQrcodeUpdate      write FOnResponseQrcodeUpdate;
    property OnResponseConnectionUpdate : TResponseConnectionUpdateEvent  read FOnResponseConnectionUpdate  write FOnResponseConnectionUpdate;
    property OnResponseCallUpdate       : TResponseCallEvent              read FOnResponseCallUpdate        write FOnResponseCallUpdate;

    property OnResponseSEND_MESSAGE     : TResponseSEND_MESSAGEEvent      read FOnResponseSEND_MESSAGE      write FOnResponseSEND_MESSAGE;
    property OnResponseMESSAGES_SET     : TResponseMESSAGES_SETEvent      read FOnResponseMESSAGES_SET      write FOnResponseMESSAGES_SET;
    property OnResponseCONTACTS_SET     : TResponseCONTACTS_SETEvent      read FOnResponseCONTACTS_SET      write FOnResponseCONTACTS_SET;
    property OnResponseCONTACTS_UPSERT  : TResponseCONTACTS_UPSERTEvent   read FOnResponseCONTACTS_UPSERT   write FOnResponseCONTACTS_UPSERT;
    property OnResponseCONTACTS_UPDATE  : TResponseCONTACTS_UPDATEEvent   read FOnResponseCONTACTS_UPDATE   write FOnResponseCONTACTS_UPDATE;

    property OnResponsePRESENCE_UPDATE  : TResponsePRESENCE_UPDATEEvent   read FOnResponsePRESENCE_UPDATE   write FOnResponsePRESENCE_UPDATE;

    property OnResponseCHATS_SET        : TResponseCHATS_SETEvent         read FOnResponseCHATS_SET         write FOnResponseCHATS_SET;
    property OnResponseCHATS_UPSERT     : TResponseCHATS_UPSERTEvent      read FOnResponseCHATS_UPSERT      write FOnResponseCHATS_UPSERT;
    property OnResponseCHATS_UPDATE     : TResponseCHATS_UPDATEEvent      read FOnResponseCHATS_UPDATE      write FOnResponseCHATS_UPDATE;
    property OnResponseCHATS_DELETE     : TResponseCHATS_DELETEEvent      read FOnResponseCHATS_DELETE      write FOnResponseCHATS_DELETE;

    property OnResponseGROUPS_SET       : TResponseGROUPS_SETEvent        read FOnResponseGROUPS_SET        write FOnResponseGROUPS_SET;
    property OnResponseGROUPS_UPSERT    : TResponseGROUPS_UPSERTEvent     read FOnResponseGROUPS_UPSERT     write FOnResponseGROUPS_UPSERT;
    property OnResponseGROUP_UPDATE     : TResponseGROUP_UPDATEEvent      read FOnResponseGROUP_UPDATE      write FOnResponseGROUP_UPDATE;
    property OnResponseGROUP_PARTICIPANTS_UPDATE  : TResponseGROUP_PARTICIPANTS_UPDATEEvent   read FOnResponseGROUP_PARTICIPANTS_UPDATE   write FOnResponseGROUP_PARTICIPANTS_UPDATE;

  {
  TResponseSEND_MESSAGEEvent = Procedure(Sender : TObject; Response: string) of object;
  TResponseMESSAGES_SETEvent = Procedure(Sender : TObject; Response: string) of object;

  TResponseCONTACTS_SETEvent = Procedure(Sender : TObject; Response: string) of object;
  TResponseCONTACTS_UPSERTEvent = Procedure(Sender : TObject; Response: string) of object;
  TResponseCONTACTS_UPDATEEvent = Procedure(Sender : TObject; Response: string) of object;

  TResponsePRESENCE_UPDATEEvent = Procedure(Sender : TObject; Response: string) of object;

  TResponseCHATS_SETEvent = Procedure(Sender : TObject; Response: string) of object;
  TResponseCHATS_UPSERTEvent = Procedure(Sender : TObject; Response: string) of object;
  TResponseCHATS_UPDATEEvent = Procedure(Sender : TObject; Response: string) of object;
  TResponseCHATS_DELETEEvent = Procedure(Sender : TObject; Response: string) of object;

  TResponseGROUPS_UPSERTEvent = Procedure(Sender : TObject; Response: string) of object;
  TResponseGROUP_UPDATEEvent = Procedure(Sender : TObject; Response: string) of object;
  TResponseGROUP_PARTICIPANTS_UPDATEEvent = Procedure(Sender : TObject; Response: string) of object;
    }

    property Emoticons                : TEvolutionAPIEmoticons       read FEmoticons                 write FEmoticons;

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

function TEvolutionAPI.CheckNumberExists(numbers: string): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
begin
  Result := '';

  try
    json :=
      '{ ' +
      '   "numbers": [' + numbers + '] ' +
      '} ';

    UTF8Texto := UTF8Encode(json);

    try
      response:= TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/chat/whatsappNumbers/' + instanceName)
        .ContentType('application/json')
        .AddHeader('ApiKey', Token)
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

      //RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
      //Result := RetEnvMensagem.key.id;

      Result := Response;
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

function TEvolutionAPI.connectionState(instanceName: string): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
begin
  Result := '';

  try
    try
      response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/instance/connectionState/' + instanceName)
        .ContentType('application/json')
        .AddHeader('ApiKey', Token)
        //.AddBody(UTF8Texto)
        .Get
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

      //RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
      //Result := RetEnvMensagem.key.id;

      Result := Response;
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

function TEvolutionAPI.CreateInstanceBasic(instanceName, tokenInstancia, number: string; qrcode: Boolean): string;
var
  response: string;
  json: string;
  RetEnvMensagem: uRetMensagem.TRetCreateInstanceClass;
  UTF8Texto: UTF8String;
begin
  Result := '';
  try

    json :=
      '{' +
      '  "instanceName": "' + instanceName + '", ' +
      '  "token": "' + tokenInstancia + '", ' +
      '  "qrcode": true, ' +
      '  "number": "' + number + '"  ' +
      '}';

    UTF8Texto := UTF8Encode(json);

    try
      response := TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/instance/create')
        .ContentType('application/json')
        //.Token(token);
        .AddHeader('apikey', token)
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

      //RetEnvMensagem := TRetEnvMenssageClass.FromJSON(response);
      //Result := RetEnvMensagem.key.id;
      Result := Response;
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

function TEvolutionAPI.CreateInstanceWithWebhook(instanceName, token, number, urlWebhook, eventos: string; qrcode, webhook_by_events: Boolean): string;
var
  response: string;
  json: string;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
  UTF8Texto: UTF8String;
begin
  Result := '';
  try

    json :=
      '{' +
      '  "instanceName": "' + instanceName + '", ' +
      '  "token": "' + token + '", ' +
      '  "qrcode": true, ' +
      '  "webhook": "' + urlWebhook + '", ' +
      '  "webhook_by_events": true, ' +
      '  "events": [' + eventos + '], '+
      '  "number": "' + number + '"  ' +
      '}';

    UTF8Texto := UTF8Encode(json);

    try
      response := TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/instance/create')
        .ContentType('application/json')
        .AddHeader('apikey', token)
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

      //RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
      //Result := RetEnvMensagem.key.id;
      Result := Response;
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

function TEvolutionAPI.DeleteInstance(instanceName: string): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
begin
  Result := '';

  try
    try
      response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/instance/delete/' + instanceName)
        .ContentType('application/json')
        .AddHeader('ApiKey', Token)
        //.AddBody(UTF8Texto)
        .Delete
        .Content;
      //gravar_log(response);
    except
      on E: Exception do
      begin
        //
        //gravar_log('ERROR ' + e.Message + SLINEBREAK);
        Result := 'Error: ' + e.Message + SLineBreak;
        Exit;
      end;
    end;

    try
      if Assigned(FOnRetSendMessage) then
        FOnRetSendMessage(Self, Response);

      //RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
      //Result := RetEnvMensagem.key.id;

      Result := Response;
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

function TEvolutionAPI.DeleteMessage(waid, message_id, fromMe, paticipant: string): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
begin
  Result := '';


  try
    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    if Trim(fromMe) = '' then
      fromMe := 'true';

    json :=
      '{ ' +
      '  "id": "' + message_id + '", ' +
      '  "remoteJid": "' + waid + '", ' +
      '  "fromMe": ' + fromMe + ' ' +
        // optional
      //'  "paticipant": "' + paticipant + '" ' +
      IfThen( Trim(paticipant) <> '' ,'        ,"paticipant": "' + paticipant + '"  ', '') +
      '} ';

    UTF8Texto := UTF8Encode(json);
    try
      response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/chat/deleteMessageForEveryone/' + instanceName)
        .ContentType('application/json')
        .AddHeader('ApiKey', Token)
        .AddBody(UTF8Texto)
        .Delete
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
        FOnRetSendMessage(Self, 'deleteMessage: ' + Response);

      RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
      Result := RetEnvMensagem.key.id;
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

function TEvolutionAPI.DownloadMedia(id, MimeType: string): string;
var
  response: string;
  json: string;
  //MessagePayload: uRetMensagemApiOficial.TMessagePayload;
  //UrlMediaFile: TUrlMedia;
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
        .AddHeader('ApiKey', Token)
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

      //UrlMediaFile := TUrlMedia.FromJsonString(response);
      //Result := UrlMediaFile.url;
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
  //UrlMediaFile: TUrlMedia;
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
        .AddHeader('ApiKey', Token)
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

function TEvolutionAPI.EditMessage(waid, message_id, fromMe, number, newMessageEdit: string): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
begin
  Result := '';


  try
    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    if Trim(fromMe) = '' then
      fromMe := 'true';

    if Trim(number) = '' then
      number := waid;

    json :=
      '{ ' +
      '   "number": ' + '"' + number + '", ' +
      '   "text": ' + '"' + newMessageEdit + '", ' +
      '   "key": { ' +
      '       "remoteJid": "' + waid + '", ' +
      '       "fromMe": ' + fromMe + ', ' +
      '       "id": "' + message_id + '" ' +
      '     } ' +
      '} ';

    UTF8Texto := UTF8Encode(json);
    try
      response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/chat/updateMessage/' + instanceName)
        .ContentType('application/json')
        .AddHeader('ApiKey', Token)
        .AddBody(UTF8Texto)
        .Put
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
        FOnRetSendMessage(Self, 'editMessage: ' + Response);

      RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
      Result := RetEnvMensagem.key.id;
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

function TEvolutionAPI.fetchInstances: string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
begin
  Result := '';

  try
    try
      response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/instance/fetchInstances/')
        .ContentType('application/json')
        .AddHeader('ApiKey', Token)
        //.AddBody(UTF8Texto)
        .Get
        .Content;
      //gravar_log(response);
    except
      on E: Exception do
      begin
        //
        //gravar_log('ERROR ' + e.Message + SLINEBREAK);
        Result := 'Error: ' + e.Message + SLineBreak;
        Exit;
      end;
    end;

    try
      if Assigned(FOnRetSendMessage) then
        FOnRetSendMessage(Self, Response);

      //RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
      //Result := RetEnvMensagem.key.id;

      Result := Response;
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

function TEvolutionAPI.fetchProfilePictureUrl(waid: string): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  RetfetchProfilePictureUrl: uRetMensagem.TfetchProfilePictureUrlClass;
begin
  Result := '';

  try
    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    json :=
      '{ ' +
      '    "number": "' + waid + '" ' +
      '} ';

    UTF8Texto := UTF8Encode(json);
    try
      response:= TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/chat/fetchProfilePictureUrl/' + instanceName + '')
        .ContentType('application/json')
        .AddHeader('ApiKey', Token)
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

      RetfetchProfilePictureUrl := TfetchProfilePictureUrlClass.FromJsonString(response);
      Result := RetfetchProfilePictureUrl.profilePictureUrl;
      //Result := Response;
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

function TEvolutionAPI.findChats: string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
begin
  Result := '';

  try
    try
      response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/chat/findChats/')
        .ContentType('application/json')
        .AddHeader('ApiKey', Token)
        //.AddBody(UTF8Texto)
        .Get
        .Content;
      //gravar_log(response);
    except
      on E: Exception do
      begin
        //
        //gravar_log('ERROR ' + e.Message + SLINEBREAK);
        Result := 'Error: ' + e.Message + SLineBreak;
        Exit;
      end;
    end;

    try
      if Assigned(FOnRetSendMessage) then
        FOnRetSendMessage(Self, Response);

      //RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
      //Result := RetEnvMensagem.key.id;

      Result := Response;
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

function TEvolutionAPI.findContacts: string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
begin
  Result := '';

  (*

    /*
      Here it is possible to list all contacts or just one,
      using the 'where' option.
    */
    {
      "where": {
    //    "id": "{{remoteJid}}" /* Optional */
      }
    }
  *)

  try
    try
      response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/chat/findContacts/')
        .ContentType('application/json')
        .AddHeader('ApiKey', Token)
        //.AddBody(UTF8Texto)
        .Post
        .Content;
      //gravar_log(response);
    except
      on E: Exception do
      begin
        //
        //gravar_log('ERROR ' + e.Message + SLINEBREAK);
        Result := 'Error: ' + e.Message + SLineBreak;
        Exit;
      end;
    end;

    try
      if Assigned(FOnRetSendMessage) then
        FOnRetSendMessage(Self, Response);

      //RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
      //Result := RetEnvMensagem.key.id;

      Result := Response;
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

function TEvolutionAPI.findMessages(remoteJid: string): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
begin
  Result := '';

  try
    if (length(remoteJid) = 11) or (length(remoteJid) = 10) then
      remoteJid := DDIDefault.ToString + remoteJid;

    json :=
      '{ ' +
      '  "where": { ' +
      '    "key": { ' +
      '      "remoteJid": "' + remoteJid + '" ' +
      '    } ' +
      '  } ' +
      '} ';

    UTF8Texto := UTF8Encode(json);
    try
      response:= TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/chat/findMessages/' + instanceName + '')
        .ContentType('application/json')
        .AddHeader('ApiKey', Token)
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

      //RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
      //Result := RetEnvMensagem.key.id;

      Result := Response;
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

function TEvolutionAPI.findWebhook(instanceName: string): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
begin
  Result := '';

  try
    try
      response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/webhook/find/' + instanceName)
        .ContentType('application/json')
        .AddHeader('ApiKey', Token)
        //.AddBody(UTF8Texto)
        .Get
        .Content;
      //gravar_log(response);
    except
      on E: Exception do
      begin
        //
        //gravar_log('ERROR ' + e.Message + SLINEBREAK);
        Result := 'Error: ' + e.Message + SLineBreak;
        Exit;
      end;
    end;

    try
      if Assigned(FOnRetSendMessage) then
        FOnRetSendMessage(Self, Response);

      //RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
      //Result := RetEnvMensagem.key.id;

      Result := Response;
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

function TEvolutionAPI.FormatOut(PNum: String): String;
var
  LDDi, LDDD, Lresto, LMask : String;

begin
 LDDi   := Copy(PNum, 0, FLengthDDI);
 LDDD   := Copy(PNum, FLengthDDI + 1, FLengthDDD);
 Lresto := Copy(PNum, FLengthDDI + FLengthDDD + 1); // + 1, LengthPhone);
 if Length(Lresto) <= 8 then
    LMask := '0000\-0000;0;' else
    LMask := '0\.0000\-0000;0;';

 Result :=  '+' + LDDi + ' (' + LDDD + ') ' + FormatMaskText(LMask, Lresto );
end;

function TEvolutionAPI.getBase64FromMediaMessage(id, convertToMp4: string): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
begin
(*
  In this endpoint it is possible to extract the Base64 of the media
  received in the messages, passing the message ID as a parameter.
  Make sure that the received message is stored in MongoDB or in a file,
  otherwise the error 400 - Bad Request will be displayed.
  If the media type is audio, the mimetype audio/ogg is returned by default.
  If you need an MP4 file, check the "convertToMp4" option as "true"
*)
  Result := '';
  try
    if Trim(convertToMp4) = '' then
      convertToMp4 := 'false';

    Json :=
      '{ ' +
      '    "message": { ' +
      '        "key": { ' +
      '            "id": "' + id + '" ' +
      '        } ' +
      '    }, ' +
      '    "convertToMp4": ' + convertToMp4 + ' ' +
      '} ';

    UTF8Texto := UTF8Encode(json);

    try
      response := TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/chat/getBase64FromMediaMessage/' + instanceName)
        .ContentType('application/json')
        .AddHeader('ApiKey', Token)
        .AddBody(UTF8Texto)
        .Put
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

function TEvolutionAPI.MarkIsRead(waid, message_id, fromMe: string): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
begin
  Result := '';
  try
    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    if Trim(fromMe) = '' then
      fromMe := 'false';

    json :=
      '{ ' +
      '  "read_messages": [ ' +
      '    { ' +
      '      "remoteJid": "' + waid + '", ' +
      '      "fromMe": ' + fromMe + ', ' +
      '      "id": "' + message_id + '" ' +
      '    } ' +
      '  ] ' +
      '} ';

    UTF8Texto := UTF8Encode(json);

    try
      response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/chat/markMessageAsRead/' + instanceName)
        .ContentType('application/json')
        .AddHeader('ApiKey', Token)
        .AddBody(UTF8Texto)
        .Put
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
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
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
        .AddHeader('ApiKey', Token)
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

      RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
      Result := RetEnvMensagem.key.id;
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
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
  UTF8Texto: UTF8String;
begin
  Result := '';
  try
    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    json :=
      '{ ' +
      '    "number": "' + waid + '", ' +
      '    "options": { ' +
      '        "delay": 1200, ' +
      '        "presence": "composing" ' +
      '    }, ' +
      '    "contactMessage": [ ' +
      '        { ' +
      '            "fullName": "' + formatted_name + '", ' +
      '            "wuid": "' + phoneNumber + '", ' +
      '            "phoneNumber": "' + phoneNumber + '" ' +
      //'            "organization": "Company Name", /* Optional */ ' +
      //'            "email": "email", /* Optional */ ' +
      //'            "url": "url page" /* Optional */ ' +
      '        } ' +
      '    ] ' +
      '} ';

      (*
      '        }, ' +
      '        { ' +
      '            "fullName": "Contact Name", ' +
      '            "wuid": "559911111111", ' +
      '            "phoneNumber": "+55 99 9 1111-1111", ' +
      '            "organization": "Company Name", /* Optional */ ' +
      '            "email": "email", /* Optional */ ' +
      '            "url": "url page" /* Optional */ ' +
      '        } ' +
      '    ] ' +
      '} ';*)

    UTF8Texto := UTF8Encode(json);
    try

      response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/message/sendContact/' + instanceName)
        .ContentType('application/json')
        .AddHeader('ApiKey', Token)
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
        //Exit;
      end;
    end;

    try
      if Assigned(FOnRetSendMessage) then
        FOnRetSendMessage(Self, Response);

      RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
      Result := RetEnvMensagem.key.id;
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
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
begin
  Result := '';
  try
    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    body := CaractersWeb(body);

    json :=
      '{ ' +
      '    "number": "' + waid + '", ' +
      '    "options": { ' +
      '        "delay": 1200, ' +
      '        "presence": "composing" ' +
      '    }, ' +
      '    "mediaMessage": { ' +
      '        "mediatype": "' + typeFile + '" ' +
      IfThen( Trim(fileName) <> '' ,'        ,"fileName": "' + filename + '"  ', '') +
      IfThen( Trim(body) <> '' ,'        ,"caption": "' + body + '"  ', '') +
      '        ,"media": "' + url + '" ' +
      '    } ' +
      '} ';

    UTF8Texto := UTF8Encode(json);
    try
      response:= TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/message/sendMedia/' + instanceName + '')
        .ContentType('application/json')
        .AddHeader('ApiKey', Token)
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

      RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
      Result := RetEnvMensagem.key.id;
      //Result := Response;
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

function TEvolutionAPI.SendFileBase64(waid, body, typeFile, Base64: string; const filename: string): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
  LLine: string;
  LBase64: TStringList;
  i : integer;
begin
  Result := '';
  LLine := '';

  LBase64 := TStringList.Create;
  try
    LBase64.Text := Base64;
    for i := 0 to LBase64.Count -1  do
      LLine := LLine + LBase64[i];
    Base64 := LLine;

    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    body := CaractersWeb(body);

    json :=
      '{ ' +
      '    "number": "' + waid + '", ' +
      '    "options": { ' +
      '        "delay": 1200, ' +
      '        "presence": "composing" ' +
      '    }, ' +
      '    "mediaMessage": { ' +
      '        "mediatype": "' + typeFile + '", ' +
      IfThen( Trim(fileName) <> '' ,'        "fileName": "' + filename + '",  ', '') +
      IfThen( Trim(body) <> '' ,'        "caption": "' + body + '",  ', '') +
      '        "media": "' + Base64 + '" ' +
      '    } ' +
      '} ';

    UTF8Texto := UTF8Encode(json);

    try
      response:= TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/message/sendMedia/' + instanceName + '')
        .ContentType('application/json')
        .AddHeader('ApiKey', Token)
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

      RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
      Result := RetEnvMensagem.key.id;
      //Result := Response;
    except
      on E: Exception do
      begin
        Result := 'Error: ' + e.Message;
      end;
    end;


  finally
    freeAndNil(LBase64);
  end;

end;

function TEvolutionAPI.SendListMenu(waid, body, sections, header, footer, Button_Text: string): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
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
        .AddHeader('ApiKey', Token)
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

      RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
      Result := RetEnvMensagem.key.id;
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
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
begin
  Result := '';

  try
    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    body := CaractersWeb(body);

    (*json :=
      '{ ' +
      '  "messaging_product": "whatsapp", ' +
      //'  "recipient_type": "individual", ' +
      '  "to": "' + waid + '", ' +
      '  "type": "location", ' +
      Location +
      '}';*)

    json :=
      '{ ' +
      '    "number": "' + waid + '", ' +
      '    "options": { ' +
      '        "delay": 1200, ' +
      '        "presence": "composing" ' +
      '    }, ' +
      Location +

      (*'    "locationMessage": { ' +
      '        "name": "Bora Bora", ' +
      '        "address": "French Polynesian", ' +
      '        "latitude": -16.505538233564373, ' +
      '        "longitude": -151.7422770494996 ' +
      '    } ' +*)

      '} ';

    UTF8Texto := UTF8Encode(json);

    try
      response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/message/sendLocation/' + instanceName)
        .ContentType('application/json')
        .AddHeader('ApiKey', Token)
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

      RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
      Result := RetEnvMensagem.key.id;
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

function TEvolutionAPI.SendNarratedAudio(waid, url: string): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
begin
  Result := '';

  try
    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    json :=
      '{ ' +
      '    "number": "' + waid + '", ' +
      '    "options": { ' +
      '        "delay": 1200, ' +
      '        "presence": "recording", ' +
      '        "encoding": true ' +
      '    }, ' +
      '    "audioMessage": { ' +
      '        "audio": "' + url + '" ' +
      '    } ' +
      '} ';

    UTF8Texto := UTF8Encode(json);
    try
      response:= TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/message/sendWhatsAppAudio/' + instanceName + '')
        .ContentType('application/json')
        .AddHeader('ApiKey', Token)
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

      RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
      Result := RetEnvMensagem.key.id;
      //Result := Response;
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

function TEvolutionAPI.SendNarratedAudioBase64(waid, Base64: string): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
  LLine: string;
  LBase64: TStringList;
  i : integer;
begin
  Result := '';
  LLine := '';

  LBase64 := TStringList.Create;
  try
    LBase64.Text := Base64;
    for i := 0 to LBase64.Count -1  do
      LLine := LLine + LBase64[i];
    Base64 := LLine;

    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    json :=
      '{ ' +
      '    "number": "' + waid + '", ' +
      '    "options": { ' +
      '        "delay": 1200, ' +
      '        "presence": "recording", ' +
      '        "encoding": true ' +
      '    }, ' +
      '    "audioMessage": { ' +
      '        "audio": "' + Base64 + '" ' +
      '    } ' +
      '} ';

    UTF8Texto := UTF8Encode(json);
    try
      response:= TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/message/sendWhatsAppAudio/' + instanceName + '')
        .ContentType('application/json')
        .AddHeader('ApiKey', Token)
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

      RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
      Result := RetEnvMensagem.key.id;
      //Result := Response;
    except
      on E: Exception do
      begin
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;


  finally
    freeAndNil(LBase64);
  end;

end;

function TEvolutionAPI.SendReaction(waid, message_id, emoji, fromMe: string): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
begin
  Result := '';

  try
    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    if Trim(fromMe) = '' then
      fromMe := 'false';

    json :=
      '{ ' +
      '  "reactionMessage": { ' +
      '    "key": { ' +
      //'      "remoteJid": "' + waid + '@s.whatsapp.net", // or {{groupJid}}@g.us" ' +
      '      "remoteJid": "' + waid + '", ' +
      '      "fromMe": ' + fromMe + ', ' +
      '      "id": "' + message_id + '" ' +
      '    }, ' +
      '    "reaction": "' + emoji + '" ' +
      '  } ' +
      '} ';
(*
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
*)

    UTF8Texto := UTF8Encode(json);
    try
      response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/message/sendReaction/' + instanceName)
        .ContentType('application/json')
        .AddHeader('ApiKey', Token)
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

      Result := Response;
      //RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
      //Result := RetEnvMensagem.key.id;
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

function TEvolutionAPI.SendReplies(waid, message_id, reply_body, reply_remoteJid, message_body, fromMe: string; previewurl: string): string;
var
  response: string;
  json: string;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
  UTF8Texto: UTF8String;
begin
  Result := '';

  try
    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    reply_body := CaractersWeb(reply_body);

    if Trim(fromMe) = '' then
      fromMe := 'true';

    json :=
      '{ ' +
      '    "number": "' + waid + '", ' +
      '    "options": { ' +
      '        "delay": 1200, ' +
      '        "presence": "composing", ' +
      '        "quoted": { ' +
      '            "key": { ' +
      '                "remoteJid": "' + reply_remoteJid + '@s.whatsapp.net", ' +
      '                "fromMe": ' + fromMe + ', ' +
      '                "id": "' + message_id + '", ' +
      '                "participant": "" ' +
      '            }, ' +
      '            "message": { ' +
      '                "conversation": "' + message_body + '" ' +
      '            } ' +
      '        } ' +
      '    }, ' +
      '    "textMessage": { ' +
      '        "text": "' + reply_body + '" ' +
      '    } ' +
      '}';

      (*'{ ' +
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
      '}';*)

    UTF8Texto := UTF8Encode(json);

    try
      response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/message/sendText/' + instanceName)
        .ContentType('application/json')
        .AddHeader('ApiKey', Token)
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

      RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
      Result := RetEnvMensagem.key.id;
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

function TEvolutionAPI.SendSticker(waid, url: string): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
begin
  Result := '';

  try
    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    json :=
      '{ ' +
      '    "number": "' + waid + '", ' +
      '    "options": { ' +
      '        "delay": 1200, ' +
      '        "presence": "composing" ' +
      '    }, ' +
      '    "stickerMessage": { ' +
      '        "image": "' + url + '" ' +
      '    } ' +
      '} ';

    UTF8Texto := UTF8Encode(json);
    try
      response:= TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/message/sendSticker/' + instanceName + '')
        .ContentType('application/json')
        .AddHeader('ApiKey', Token)
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

      RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
      Result := RetEnvMensagem.key.id;
      //Result := Response;
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

function TEvolutionAPI.SendStickerBase64(waid, Base64: string): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
  LLine: string;
  LBase64: TStringList;
  i : integer;
begin
  Result := '';

  LBase64 := TStringList.Create;
  try
    LBase64.Text := Base64;
    for i := 0 to LBase64.Count -1  do
      LLine := LLine + LBase64[i];
    Base64 := LLine;

    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    json :=
      '{ ' +
      '    "number": "' + waid + '", ' +
      '    "options": { ' +
      '        "delay": 1200, ' +
      '        "presence": "composing" ' +
      '    }, ' +
      '    "stickerMessage": { ' +
      '        "image": "' + Base64 + '" ' +
      '    } ' +
      '} ';

    UTF8Texto := UTF8Encode(json);
    try
      response:= TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/message/sendSticker/' + instanceName + '')
        .ContentType('application/json')
        .AddHeader('ApiKey', Token)
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

      RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
      Result := RetEnvMensagem.key.id;
      //Result := Response;
    except
      on E: Exception do
      begin
        Result := 'Error: ' + e.Message;
        Exit;
      end;
    end;

  finally
    freeAndNil(LBase64);
  end;

end;

function TEvolutionAPI.SendText(waid, body, previewurl: string): string;
var
  response: string;
  json: string;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
  url: string;
  UTF8Texto: UTF8String;
begin
  Result := '';
  try
    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    body := CaractersWeb(body);

    json :=
      '{ ' +
      '    "number": "' + waid + '", ' +
      '    "options": { ' +
      '        "delay": 1200, ' +
      '        "presence": "composing", ' +
      '        "linkPreview": ' + previewurl +  ' ' +
      '    }, ' +
      '    "textMessage": { ' +
      '        "text": "' + body + '" ' +
      '    } ' +
      '} ';

    UTF8Texto := UTF8Encode(json);

    url := urlServer + ':' + Port.ToString + '/message/sendText/' + instanceName;

    try
      response:= TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/message/sendText/' + instanceName)
        .ContentType('application/json')
        .AddHeader('ApiKey', Token)
        .AddBody(UTF8Texto)
        .Post
        .Content;
      //gravar_log(response);
    except
      on E: Exception do
      begin

        //gravar_log('ERROR ' + e.Message + SLINEBREAK);
        Result := 'Error: ' + e.Message + ' url: ' + url + ' json: ' + json;
        Exit;
      end;
    end;


    try
      if Assigned(FOnRetSendMessage) then
        FOnRetSendMessage(Self, Response);

      RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
      Result := RetEnvMensagem.key.id;

      //Result := Response;
    except
      on E: Exception do
      begin
        Result := 'Error: ' + e.Message  + ' url:' + url;
        Exit;
      end;
    end;

  finally
  end;


end;

function TEvolutionAPI.SetSettings(reject_call, msg_call, groups_ignore, always_online, read_messages, read_status: string): string;
var
  response: string;
  json: string;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
  UTF8Texto: UTF8String;
begin
  Result := '';
  try
    if Trim(msg_call) = '' then
      msg_call := 'I do not accept calls';

    json :=
        '{ ' +
        '  "reject_call": ' + reject_call + ', ' +
        '    "msg_call": "' + msg_call + '", ' +
        '    "groups_ignore": ' + groups_ignore + ', ' +
        '    "always_online": ' + always_online + ', ' +
        '    "read_messages": ' + read_messages + ', ' +
        '    "read_status": ' + read_status + ' ' +
        '} ';

    UTF8Texto := UTF8Encode(json);

    try
      response := TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/settings/set/' + instanceName)
        .ContentType('application/json')
        .AddHeader('apikey', token)
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

      //RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
      //Result := RetEnvMensagem.key.id;
      Result := Response;
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

function TEvolutionAPI.SetWebhook(url, events: string; webhook_by_events, webhook_base64: Boolean): string;
var
  response: string;
  json: string;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
  UTF8Texto: UTF8String;
begin
  Result := '';
  try
    json :=
      '{' +
      '  "url": "' + url + '", ' +
      '  "webhook_by_events": true, ' +
      '  "webhook_base64": false, ' +
      '  "events": [' + events + '] '+
      '}';

    UTF8Texto := UTF8Encode(json);

    try
      response := TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/webhook/set/' + instanceName)
        .ContentType('application/json')
        .AddHeader('apikey', token)
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

      //RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
      //Result := RetEnvMensagem.key.id;
      Result := Response;
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

  THorse
    .Post('/responsewebhook/message-update',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        Response: string;
      begin
        Response := 'save response message-update webhook ok';
        Res.Send(Response);

        Response := Req.Body;
        if Assigned(FOnResponseMessageUpdate) then
          FOnResponseMessageUpdate(Self, Response);
      end
    );

  THorse
    .Post('/responsewebhook/message-delete',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        Response: string;
      begin
        Response := 'save response message-delete webhook ok';
        Res.Send(Response);

        Response := Req.Body;
        if Assigned(FOnResponseMessageDelete) then
          FOnResponseMessageDelete(Self, Response);
      end
    );

  THorse
    .Post('/responsewebhook/qrcode-updated',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        Response: string;
      begin
        Response := 'save response qrcode-updated webhook ok';
        Res.Send(Response);

        Response := Req.Body;
        if Assigned(FOnResponseQrcodeUpdate) then
          FOnResponseQrcodeUpdate(Self, Response);
      end
    );

  THorse
    .Post('/responsewebhook/connection-update',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        Response: string;
      begin
        Response := 'save response connection-update webhook ok';
        Res.Send(Response);

        Response := Req.Body;
        if Assigned(FOnResponseConnectionUpdate) then
          FOnResponseConnectionUpdate(Self, Response);
      end
    );

  THorse
    .Post('/responsewebhook/call',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        Response: string;
      begin
        Response := 'save response call webhook ok';
        Res.Send(Response);

        Response := Req.Body;
        if Assigned(FOnResponseCallUpdate) then
          FOnResponseCallUpdate(Self, Response);
      end
    );

  THorse
    .Post('/responsewebhook/send-message',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        Response: string;
      begin
        Response := 'save response call webhook ok';
        Res.Send(Response);

        Response := Req.Body;
        if Assigned(FOnResponseSEND_MESSAGE) then
          FOnResponseSEND_MESSAGE(Self, Response);
      end
    );

  THorse
    .Post('/responsewebhook/message-set',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        Response: string;
      begin
        Response := 'save response message-set webhook ok';
        Res.Send(Response);

        Response := Req.Body;
        if Assigned(FOnResponseMESSAGES_SET) then
          FOnResponseMESSAGES_SET(Self, Response);
      end
    );

  THorse
    .Post('/responsewebhook/contacts-set',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        Response: string;
      begin
        Response := 'save response contacts-set webhook ok';
        Res.Send(Response);

        Response := Req.Body;
        if Assigned(FOnResponseCONTACTS_SET) then
          FOnResponseCONTACTS_SET(Self, Response);
      end
    );

  THorse
    .Post('/responsewebhook/contacts-upsert',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        Response: string;
      begin
        Response := 'save response contacts-upsert webhook ok';
        Res.Send(Response);

        Response := Req.Body;
        if Assigned(FOnResponseCONTACTS_UPSERT) then
          FOnResponseCONTACTS_UPSERT(Self, Response);
      end
    );

  THorse
    .Post('/responsewebhook/contacts-update',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        Response: string;
      begin
        Response := 'save response contacts-update webhook ok';
        Res.Send(Response);

        Response := Req.Body;
        if Assigned(FOnResponseCONTACTS_UPDATE) then
          FOnResponseCONTACTS_UPDATE(Self, Response);
      end
    );

  THorse
    .Post('/responsewebhook/chats-set',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        Response: string;
      begin
        Response := 'save response chats-set webhook ok';
        Res.Send(Response);

        Response := Req.Body;
        if Assigned(FOnResponseCHATS_SET) then
          FOnResponseCHATS_SET(Self, Response);
      end
    );

  THorse
    .Post('/responsewebhook/chats-upsert',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        Response: string;
      begin
        Response := 'save response chats-upsert webhook ok';
        Res.Send(Response);

        Response := Req.Body;
        if Assigned(FOnResponseCHATS_UPSERT) then
          FOnResponseCHATS_UPSERT(Self, Response);
      end
    );

  THorse
    .Post('/responsewebhook/chats-delete',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        Response: string;
      begin
        Response := 'save response chats-delete webhook ok';
        Res.Send(Response);

        Response := Req.Body;
        if Assigned(FOnResponseCHATS_DELETE) then
          FOnResponseCHATS_DELETE(Self, Response);
      end
    );

  THorse
    .Post('/responsewebhook/chats-update',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        Response: string;
      begin
        Response := 'save response chats-update webhook ok';
        Res.Send(Response);

        Response := Req.Body;
        if Assigned(FOnResponseCHATS_UPDATE) then
          FOnResponseCHATS_UPDATE(Self, Response);
      end
    );

  THorse
    .Post('/responsewebhook/group-update',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        Response: string;
      begin
        Response := 'save response group-update webhook ok';
        Res.Send(Response);

        Response := Req.Body;
        if Assigned(FOnResponseGROUP_UPDATE) then
          FOnResponseGROUP_UPDATE(Self, Response);
      end
    );

  THorse
    .Post('/responsewebhook/groups-updsert',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        Response: string;
      begin
        Response := 'save response groups-updsert webhook ok';
        Res.Send(Response);

        Response := Req.Body;
        if Assigned(FOnResponseGROUPS_UPSERT) then
          FOnResponseGROUPS_UPSERT(Self, Response);
      end
    );

  THorse
    .Post('/responsewebhook/group-participants-update',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      var
        Response: string;
      begin
        Response := 'save response group-participants-update webhook ok';
        Res.Send(Response);

        Response := Req.Body;
        if Assigned(FOnResponseGROUP_PARTICIPANTS_UPDATE) then
          FOnResponseGROUP_PARTICIPANTS_UPDATE(Self, Response);
      end
    );

{
    FOnResponseSEND_MESSAGE: TResponseSEND_MESSAGEEvent;
    FOnResponseMESSAGES_SET: TResponseMESSAGES_SETEvent;
    FOnResponseCONTACTS_SET: TResponseCONTACTS_SETEvent;
    FOnResponseCONTACTS_UPSERT: TResponseCONTACTS_UPSERTEvent;
    FOnResponseCONTACTS_UPDATE: TResponseCONTACTS_UPDATEEvent;
    FOnResponseCHATS_SET: TResponseCHATS_SETEvent;

    FOnResponsePRESENCE_UPDATE: TResponsePRESENCE_UPDATEEvent;
    FOnResponseCHATS_UPSERT: TResponseCHATS_UPSERTEvent;
    FOnResponseCHATS_UPDATE: TResponseCHATS_UPDATEEvent;
    FOnResponseCHATS_DELETE: TResponseCHATS_DELETEEvent;
    FOnResponseGROUPS_UPSERT: TResponseGROUPS_UPSERTEvent;
    FOnResponseGROUP_PARTICIPANTS_UPDATE: TResponseGROUP_PARTICIPANTS_UPDATEEvent;
    FOnResponseGROUP_UPDATE: TResponseGROUP_UPDATEEvent;
    FOnResponseGROUPS_SET: TResponseGROUPS_SETEvent;
}


  if PortWebhook = 0 then
    PortWebhook := 8020;

  THorse.MaxConnections := 500;
  THorse.Port := PortWebhook;
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

function TEvolutionAPI.RestartInstance(instanceName: string): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
begin
  Result := '';

  try
    try
      response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/instance/restart/' + instanceName)
        .ContentType('application/json')
        .AddHeader('ApiKey', Token)
        //.AddBody(UTF8Texto)
        .Put
        .Content;
      //gravar_log(response);
    except
      on E: Exception do
      begin
        //
        //gravar_log('ERROR ' + e.Message + SLINEBREAK);
        Result := 'Error: ' + e.Message + SLineBreak;
        Exit;
      end;
    end;

    try
      if Assigned(FOnRetSendMessage) then
        FOnRetSendMessage(Self, Response);

      //RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
      //Result := RetEnvMensagem.key.id;

      Result := Response;
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

function TEvolutionAPI.UploadMedia(FileName: string): string;
var
  http: TIdHTTP;
  ssl: TIdSSLIOHandlerSocketOpenSSL;
  postData: TStringStream;
  response, json, media_id: string;
  Retorno: IResponse;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
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
                .AddHeader('ApiKey', Token)
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
            //RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
            //Result := RetEnvMensagem.key.id;
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

function TEvolutionAPI.GetTypeFileFromExtension(const AFileExtension: string): string;
var
  TypeFileList: TStringList;
begin
  TypeFileList := TStringList.Create;

  try
    // Mapeamento de extensões para tipos de conteúdo
    TypeFileList.Values['.html'] := 'document';
    TypeFileList.Values['.htm'] := 'document';
    TypeFileList.Values['.txt'] := 'document';
    TypeFileList.Values['.log'] := 'document';
    TypeFileList.Values['.csv'] := 'document';
    TypeFileList.Values['.jpg'] := 'image';
    TypeFileList.Values['.jpeg'] := 'image';
    TypeFileList.Values['.png'] := 'image';
    TypeFileList.Values['.gif'] := 'image';
    TypeFileList.Values['.bmp'] := 'image';
    TypeFileList.Values['.ico'] := 'image';
    TypeFileList.Values['.svg'] := 'image';
    TypeFileList.Values['.pdf'] := 'document';
    TypeFileList.Values['.doc'] := 'document';
    TypeFileList.Values['.docx'] := 'document';
    TypeFileList.Values['.xls'] := 'document';
    TypeFileList.Values['.xlsx'] := 'document';
    TypeFileList.Values['.ppt'] := 'document';
    TypeFileList.Values['.pptx'] := 'document';
    TypeFileList.Values['.zip'] := 'document';
    TypeFileList.Values['.rar'] := 'document';
    TypeFileList.Values['.tar'] := 'document';
    TypeFileList.Values['.7z'] := 'document';
    TypeFileList.Values['.mp3'] := 'audio';
    TypeFileList.Values['.wav'] := 'audio';
    TypeFileList.Values['.mp4'] := 'video';
    TypeFileList.Values['.avi'] := 'video';
    TypeFileList.Values['.mkv'] := 'video';
    TypeFileList.Values['.xml'] := 'text';
    TypeFileList.Values['.json'] := 'document';
    TypeFileList.Values['.ogg'] := 'audio';
    TypeFileList.Values['.webm'] := 'video';
    TypeFileList.Values['.flv'] := 'video';
    TypeFileList.Values['.wmv'] := 'video';
    TypeFileList.Values['.aac'] := 'audio';
    TypeFileList.Values['.flac'] := 'audio';
    TypeFileList.Values['.css'] := 'document';
    TypeFileList.Values['.js'] := 'document';
    TypeFileList.Values['.ttf'] := 'document';
    TypeFileList.Values['.otf'] := 'document';
    TypeFileList.Values['.woff'] := 'document';
    TypeFileList.Values['.woff2'] := 'document';
    TypeFileList.Values['.webp'] := 'sticker';
    // Adicione mais extensões e tipos de conteúdo conforme necessário

    Result := TypeFileList.Values[AFileExtension];
  finally
    TypeFileList.Free;
  end;
end;

function TEvolutionAPI.InstanceConnect(instanceName: string): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
begin
  Result := '';

  try
    try
      response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/instance/connect/' + instanceName)
        .ContentType('application/json')
        .AddHeader('ApiKey', Token)
        //.AddBody(UTF8Texto)
        .Get
        .Content;
      //gravar_log(response);
    except
      on E: Exception do
      begin
        //
        //gravar_log('ERROR ' + e.Message + SLINEBREAK);
        Result := 'Error: ' + e.Message + SLineBreak;
        Exit;
      end;
    end;

    try
      if Assigned(FOnRetSendMessage) then
        FOnRetSendMessage(Self, Response);

      //RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
      //Result := RetEnvMensagem.key.id;

      Result := Response;
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

function TEvolutionAPI.logout(instanceName: string): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
begin
  Result := '';

  try
    try
      response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/instance/logout/' + instanceName)
        .ContentType('application/json')
        .AddHeader('ApiKey', Token)
        //.AddBody(UTF8Texto)
        .Delete
        .Content;
      //gravar_log(response);
    except
      on E: Exception do
      begin
        //
        //gravar_log('ERROR ' + e.Message + SLINEBREAK);
        Result := 'Error: ' + e.Message + SLineBreak;
        Exit;
      end;
    end;

    try
      if Assigned(FOnRetSendMessage) then
        FOnRetSendMessage(Self, Response);

      //RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
      //Result := RetEnvMensagem.key.id;

      Result := Response;
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

end.
