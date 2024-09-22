{
####################################################################################################################
  Obs:
     - C�digo aberto a comunidade Delphi, desde que mantenha os dados dos autores e mantendo sempre o nome do IDEALIZADOR
       Marcelo dos Santos de Oliveira;

####################################################################################################################
                                  Evolu��o do C�digo
####################################################################################################################
  Autor........: Marcelo Oliveira
  Email........: marcelo.broz@hotmail.com
  Data.........: 21/02/2024
  Identificador: @Marcelo
  Modifica��o..:
####################################################################################################################
}
unit uEvolutionAPI;

interface

uses
  System.SysUtils, System.Classes, System.JSON, System.Net.HttpClient, System.Net.URLClient, IdSSLOpenSSL, IdHTTP,
  uRetMensagem, StrUtils, Horse, Horse.Commons,  Horse.Core, web.WebBroker, System.NetEncoding, System.TypInfo,
  RESTRequest4D, REST.Types, REST.Client, System.Net.Mime, uEvolutionAPI.Emoticons, System.MaskUtils, uDownloadMediaClass;


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
  TResponseCheckNumberExistsEvent = Procedure(Sender : TObject; Response: string) of object;
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

    FOnResponseCheckNumberExists: TResponseCheckNumberExistsEvent;
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

    wpu_url: string;
    Fversion2latest: Boolean;


    function CaractersWeb(vText: string): string;


  protected


  public
    //Send Individual
    function SendText(waid, body: string; previewurl: string = 'false'; quoted: string = ''; mentionsEveryOne: string = 'false'; mentioned: string = ''): string;
    function SendFile(waid, body, typeFile, url: string; const filename: string = ''; quoted: string = ''; mentionsEveryOne: string = 'false'; mentioned: string = '' ): string;
    function SendFileBase64(waid, body, typeFile, Base64: string; const filename: string = ''; quoted: string = ''; mentionsEveryOne: string = 'false'; mentioned: string = '' ): string;
    function SendNarratedAudio(waid, url: string): string;
    function SendNarratedAudioBase64(waid, Base64: string): string;
    function SendSticker(waid, url: string): string;
    function SendStickerBase64(waid, Base64: string): string;
    function SendContact(waid, phoneNumber, formatted_name, options: string): string;
    function SendLocation(waid, body, Location, latitude, longitude, address, name: string): string;
    function SendReaction(waid, message_id, emoji, fromMe: string): string;
    function SendPoll(waid, pollMessage: string; name: string = ''; selectableCount: Integer = 1): string;

    //Deprecated v2.0
    function SendButton(waid, body, actions, header, footer: string): string; deprecated;
    function SendListMenu(waid, body, sections, header, footer, Button_Text: string): string;
    function SendReplies(waid, message_id, reply_body, reply_remoteJid, message_body, fromMe: string; previewurl: string = 'false'): string;
    function SendGhostMetionText(groupJid, body: string; previewurl: string = 'false'): string;

    //Send Status
    function SendStatus(stype, content, backgroundColor, font, statusJidList: string; allContacts: string = 'true'): string;
    function SendStatusMedia(stype, urlFile, backgroundColor, font, statusJidList: string; allContacts: string = 'true'; caption: string = ''): string;


    //Message
    function DeleteMessage(waid, message_id, fromMe, paticipant: string): string;
    function EditMessage(waid, message_id, fromMe, number, newMessageEdit: string): string;
    function findMessages(remoteJid: string): string;

    //Chats
    function CheckNumberExists(numbers: string): string;
    function MarkIsRead(waid, message_id, fromMe: string): string;
    function findContacts: string;
    function findChats: string;

    //Instance
    function CreateInstanceBasic(instanceName, tokenInstancia, number: string; qrcode: Boolean): string;
    function CreateInstanceWithWebhook(instanceName, token, number, urlWebhook, eventos: string; qrcode, webhook_by_events: Boolean): string;
    function SetWebhook(url, events: string; webhook_by_events, webhook_base64: Boolean): string;
    function SetSettings(reject_call, msg_call, groups_ignore, always_online, read_messages, read_status: string): string;
    function fetchProfilePictureUrl(waid: string): string;
    function connectionState(instanceName: string): string;
    function logout(instanceName: string): string;
    function DeleteInstance(instanceName: string): string;
    function RestartInstance(instanceName: string): string;
    function InstanceConnect(instanceName: string): string;
    function RegisterMobileCode(instanceName, mobileCode: string): string;
    function fetchInstances: string;
    function findWebhook(instanceName: string): string;


    //Download Files
    function getBase64FromMediaMessage(id, convertToMp4: string): string;
    function Base64ToSaveFile(Base64, mediaType, mimetype, FileName: string): string;

    //Groups and Comunitys
    function CreateGroup(nameGroup, description, participants: string): string;
    function fetchAllGroups(getParticipants: Boolean): string;
    function findParticipants(groupJid: string): string;
    function updateParticipant(action, participants, groupJid: string): string;
    function updateGroupPicture(urlImage, groupJid: string): string;
    function updateGroupSubject(subject, groupJid: string): string;
    function updateGroupDescription(description, groupJid: string): string;
    function updateGroupSetting(action, groupJid: string): string;
    function updateToggleEphemeral(expiration, groupJid: string): string;
    function LeaveGroup(groupJid: string): string;
    function fetchinviteCode(groupJid: string): string;
    function acceptInviteCode(inviteCode: string): string;
    function revokeInviteCode(groupJid: string): string;
    function sendInviteUrl(groupJid, description, numbers: string): string;
    function findGroupInviteCode(inviteCode: string): string;
    function findGroupJid(groupJid: string): string;

    //Util
    function GetContentTypeFromDataUri(const ADataUri: string): string;
    function GetContentTypeFromExtension(const AContentType: string): string;
    function GetExtensionTypeFromContentType(const AFileExtension: string): string;
    function GetTypeFileFromContentType(const AContentType: string): string;
    function GetTypeFileFromExtension(const AFileExtension: string): string;

    Function FormatOut(PNum:String): String;

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
    property version2latest    : Boolean                 read Fversion2latest     write Fversion2latest         Default false;


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
    property OnResponseCheckNumberExists: TResponseCheckNumberExistsEvent read FOnResponseCheckNumberExists write FOnResponseCheckNumberExists;
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


function TEvolutionAPI.acceptInviteCode(inviteCode: string): string;
var
  response, url: string;
  json: string;
  UTF8Texto: UTF8String;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
begin
  Result := '';

  try
    try
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/group/acceptInviteCode/' + instanceName + '?inviteCode=' + inviteCode else
        wpu_url := urlServer + ':' + Port.ToString + '/group/acceptInviteCode/' + instanceName + '?inviteCode=' + inviteCode;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/group/acceptInviteCode/' + instanceName + '?inviteCode=' + inviteCode)
        .ContentType('application/json')
        .AddHeader('ApiKey', Token)
        //.AddBody(UTF8Texto)
        .Get
        .Content;
      //gravar_log(response);
    except
      on E: Exception do
      begin
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

function TEvolutionAPI.Base64ToSaveFile(Base64, mediaType, mimetype, FileName: string): string;
var
  LInput: TMemoryStream;
  LOutput: TMemoryStream;
  AStr: TStringList;
  Nome_Arquivo, extensao, diretorio: string;
begin
  diretorio := ExtractFilePath(ParamStr(0)) + 'temp\';
  Sleep(1);

  if not DirectoryExists(diretorio) then
    CreateDir(diretorio);

  try
    Result := '';
    LInput := TMemoryStream.Create;
    LOutput := TMemoryStream.Create;
    AStr := TStringList.Create;

    AStr.Add(Base64);
    AStr.SaveToStream(LInput);
    LInput.Position := 0;
    TNetEncoding.Base64.Decode(LInput, LOutput);
    LOutput.Position := 0;

    extensao := GetExtensionTypeFromContentType(mimetype);

    try
      if FileName <> '' then
        Nome_Arquivo := ExtractFilePath(ParamStr(0)) + 'temp\' + mediaType + '-' + FormatDateTime('YYYYMMDDhhmmsszzz', now) + '.' + FileName else
        Nome_Arquivo := ExtractFilePath(ParamStr(0)) + 'temp\' + mediaType + '-' + FormatDateTime('YYYYMMDDhhmmsszzz', now) + '.' + extensao;
      LOutput.SaveToFile(Nome_Arquivo);
      Result := Nome_Arquivo;

    except
      on E: Exception do
      begin
        Result := 'ERROR';

        //Exit;
      end
    end;

  finally
    try LInput.DisposeOf; except end;
    try LOutput.DisposeOf; except end;
    try AStr.DisposeOf; except end;
  end;

end;

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
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/chat/whatsappNumbers/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/chat/whatsappNumbers/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/chat/whatsappNumbers/' + instanceName)
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
      if Assigned(FOnResponseCheckNumberExists) then
        FOnResponseCheckNumberExists(Self, Response);

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
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/instance/connectionState/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/instance/connectionState/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/instance/connectionState/' + instanceName)
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

function TEvolutionAPI.CreateGroup(nameGroup, description, participants: string): string;
var
  response: string;
  json: string;
  RetEnvMensagem: uRetMensagem.TRetCreateInstanceClass;
  UTF8Texto: UTF8String;
begin
  Result := '';
  try
    json :=
      '{ ' +
      '  "subject": "' + nameGroup + '", ' +
      '  "description": "' + description + '", ' +
      '  "participants": [ ' + participants +
      '  ] ' +
      '} ';

    UTF8Texto := UTF8Encode(json);

    try
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/group/create/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/group/create/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
      //response := TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/group/create/' + instanceName)
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
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/instance/create' else
        wpu_url := urlServer + ':' + Port.ToString + '/instance/create';

      response:= TRequest.New.BaseURL(wpu_url)
      //response := TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/instance/create')
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
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/instance/create' else
        wpu_url := urlServer + ':' + Port.ToString + '/instance/create';

      response:= TRequest.New.BaseURL(wpu_url)
      //response := TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/instance/create')
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
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/instance/delete/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/instance/delete/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/instance/delete/' + instanceName)
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
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/chat/deleteMessageForEveryone/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/chat/deleteMessageForEveryone/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/chat/deleteMessageForEveryone/' + instanceName)
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
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/chat/updateMessage/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/chat/updateMessage/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/chat/updateMessage/' + instanceName)
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

function TEvolutionAPI.fetchAllGroups(getParticipants: Boolean): string;
var
  response, url: string;
  json: string;
  UTF8Texto: UTF8String;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
begin
  Result := '';

  try
    try
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/group/fetchAllGroups/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/group/fetchAllGroups/' + instanceName;


      if getParticipants then
        wpu_url := wpu_url + '?getParticipants=true'
      else
        wpu_url := wpu_url + '?getParticipants=false';

      response:= TRequest.New.BaseURL(wpu_url)
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
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/instance/fetchInstances' else
        wpu_url := urlServer + ':' + Port.ToString + '/instance/fetchInstances';

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/instance/fetchInstances/')
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

function TEvolutionAPI.fetchinviteCode(groupJid: string): string;
var
  response, url: string;
  json: string;
  UTF8Texto: UTF8String;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
begin
  Result := '';

  try
    try
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/group/inviteCode/' + instanceName + '?groupJid=' + groupJid else
        wpu_url := urlServer + ':' + Port.ToString + '/group/inviteCode/' + instanceName + '?groupJid=' + groupJid;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/group/inviteCode/' + instanceName + '?groupJid=' + groupJid)
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
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/chat/fetchProfilePictureUrl/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/chat/fetchProfilePictureUrl/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/chat/fetchProfilePictureUrl/' + instanceName + '')
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
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/chat/findChats/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/chat/findChats/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/chat/findChats/')
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
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/chat/findContacts/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/chat/findContacts/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/chat/findContacts/')
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

function TEvolutionAPI.findGroupInviteCode(inviteCode: string): string;
var
  response, url: string;
  json: string;
  UTF8Texto: UTF8String;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
begin
  Result := '';

  try
    try
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/group/inviteInfo/' + instanceName + '?inviteCode=' + inviteCode else
        wpu_url := urlServer + ':' + Port.ToString + '/group/inviteInfo/' + instanceName + '?inviteCode=' + inviteCode;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/group/inviteInfo/' + instanceName + '?inviteCode=' + inviteCode)
        .ContentType('application/json')
        .AddHeader('ApiKey', Token)
        //.AddBody(UTF8Texto)
        .Get
        .Content;
      //gravar_log(response);
    except
      on E: Exception do
      begin
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

function TEvolutionAPI.findGroupJid(groupJid: string): string;
var
  response, url: string;
  json: string;
  UTF8Texto: UTF8String;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
begin
  Result := '';

  try
    try
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/group/findGroupInfos/' + instanceName + '?groupJid=' + groupJid else
        wpu_url := urlServer + ':' + Port.ToString + '/group/findGroupInfos/' + instanceName + '?groupJid=' + groupJid;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/group/findGroupInfos/' + instanceName + '?groupJid=' + groupJid)
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
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/chat/findMessages/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/chat/findMessages/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/chat/findMessages/' + instanceName + '')
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

function TEvolutionAPI.findParticipants(groupJid: string): string;
var
  response, url: string;
  json: string;
  UTF8Texto: UTF8String;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
begin
  Result := '';

  try
    try
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/group/participants/' + instanceName + '?groupJid=' + groupJid else
        wpu_url := urlServer + ':' + Port.ToString + '/group/participants/' + instanceName + '?groupJid=' + groupJid;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/group/participants/' + instanceName + '?groupJid=' + groupJid)
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
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/webhook/find/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/webhook/find/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/webhook/find/' + instanceName)
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
  ResponseDownloadMedia: uDownloadMediaClass.TResultDownloadMediaClass;
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
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/chat/getBase64FromMediaMessage/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/chat/getBase64FromMediaMessage/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
      //response := TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/chat/getBase64FromMediaMessage/' + instanceName)
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

    if pos('@s.whatsapp.net', waid) = 0 then
      waid := waid + '@s.whatsapp.net';

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
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/chat/markMessageAsRead/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/chat/markMessageAsRead/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/chat/markMessageAsRead/' + instanceName)
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
      '          "title": "N�O" ' +
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
  RetEnvMensagem2 : uRetMensagem.TRetSendMessageClass;
  UTF8Texto: UTF8String;
begin
  Result := '';
  try
    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    if version2latest then
    begin
      json :=
        '{ ' +
        '    "number": "' + waid + '", ' +
        '    "contact": [ ' +
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
    end
    else
    begin
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
    end;

    UTF8Texto := UTF8Encode(json);
    try
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/message/sendContact/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/message/sendContact/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/message/sendContact/' + instanceName)
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


      if version2latest then
      begin
        RetEnvMensagem2 := TRetSendMessageClass.FromJsonString(response);
        Result := RetEnvMensagem2.key.id;
      end
      else
      begin
        RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
        Result := RetEnvMensagem.key.id;
      end;

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

function TEvolutionAPI.SendFile(waid, body, typeFile, url: string; const filename: string = ''; quoted: string = ''; mentionsEveryOne: string = 'false'; mentioned: string = ''): string;
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

    if version2latest then
    begin
      json :=
        '{ ' +
        '    "number": "' + waid + '", ' +
        '    "mediatype": "' + typeFile + '" ' +
        //'    "mimetype": "' + typeFile + '" ' +
        IfThen( Trim(fileName) <> '' ,'        ,"fileName": "' + filename + '"  ', '') +
        IfThen( Trim(body) <> '' ,'        ,"caption": "' + body + '"  ', '') +
        '    ,"media": "' + url + '" ' +
        '} ';
    end
    else
    begin
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
    end;

    UTF8Texto := UTF8Encode(json);
    try
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/message/sendMedia/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/message/sendMedia/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
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

function TEvolutionAPI.SendFileBase64(waid, body, typeFile, Base64: string; const filename: string = ''; quoted: string = ''; mentionsEveryOne: string = 'false'; mentioned: string = ''): string;
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

    if version2latest then
    begin
      json :=
        '{ ' +
        '    "number": "' + waid + '", ' +
        '    "mediatype": "' + typeFile + '" ' +
        //'    "mimetype": "' + typeFile + '" ' +
        IfThen( Trim(fileName) <> '' ,'        ,"fileName": "' + filename + '"  ', '') +
        IfThen( Trim(body) <> '' ,'        ,"caption": "' + body + '"  ', '') +
        '    ,"media": "' + Base64 + '" ' +
        '} ';
    end
    else
    begin
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
    end;

    UTF8Texto := UTF8Encode(json);

    try
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/message/sendMedia/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/message/sendMedia/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
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

function TEvolutionAPI.SendGhostMetionText(groupJid, body, previewurl: string): string;
var
  response: string;
  json: string;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
  url: string;
  UTF8Texto: UTF8String;
begin
  Result := '';
  try

    body := CaractersWeb(body);

    json :=
      '{ ' +
      '    "number": "' + groupJid + '", ' +
      '    "options": { ' +
      '        "delay": 1200, ' +
      '        "presence": "composing", ' +
      //'        "linkPreview": ' + previewurl +  ' ' +
      '        "mentions": { ' +
      '            "everyOne": true ' +
      '        } ' +
      '    }, ' +
      '    "textMessage": { ' +
      '        "text": "' + body + '" ' +
      '    } ' +
      '} ';

    UTF8Texto := UTF8Encode(json);

    url := urlServer + ':' + Port.ToString + '/message/sendText/' + instanceName;

    try
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/message/sendText/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/message/sendText/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/message/sendText/' + instanceName)
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

function TEvolutionAPI.sendInviteUrl(groupJid, description, numbers: string): string;
var
  response: string;
  json: string;
  RetEnvMensagem: uRetMensagem.TRetCreateInstanceClass;
  UTF8Texto: UTF8String;
begin
  Result := '';
  try
    json :=
      '{ ' +
      '  "groupJid": "'    + groupJid + '", ' +
      '  "description": "' + description + '", ' +
      '  "numbers": [ '    + numbers +
      '  ] ' +
      '} ';

    UTF8Texto := UTF8Encode(json);

    try
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/group/sendInvite/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/group/sendInvite/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
      //response := TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/group/sendInvite/' + instanceName)
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
      '{' +
      '"number": "' + waid + '", ' +
      '"options": { ' +
      '    "delay": 1200, ' +
      '    "presence": "composing" ' +
      '}, ' +
      '"listMessage": { ' +
      IfThen( Trim(header) <> '' ,'    "title": "List Title", ', ' ') +
      '    "description": "' + body + '", ' +
      '    "buttonText": "'  + Button_Text + '", ' +
      '    "footerText": "'  + footer + '", ' +
      '    "sections": [ '   + Sections +
      '        ] ' +
      '    } ' +
      '} ';

    UTF8Texto := UTF8Encode(json);

    try
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/message/sendList/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/message/sendList/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/message/sendList/' + instanceName + '')
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

function TEvolutionAPI.SendLocation(waid, body, Location, latitude, longitude, address, name: string): string;
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
    if version2latest then
    begin
      json :=
        '{ ' +
        '    "number": "' + waid + '", ' +
        '    "latitude": ' + latitude + ', ' +
        '    "longitude": ' + longitude + ', ' +
        '    "address": "' + address + '", ' +
        '    "name": "' + name + '" ' +
        '} ';
    end
    else
    begin
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
    end;

    UTF8Texto := UTF8Encode(json);

    try
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/message/sendLocation/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/message/sendLocation/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/message/sendLocation/' + instanceName)
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

    if version2latest then
    begin
      json :=
        '{ ' +
        '    "number": "' + waid + '", ' +
        '    "mediatype": "audio" ' +
        '    "encoding": true, ' +
        //'    "mimetype": "' + typeFile + '" ' +
        '    ,"media": "' + url + '" ' +
        '} ';
    end
    else
    begin
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
    end;

    UTF8Texto := UTF8Encode(json);
    try
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/message/sendWhatsAppAudio/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/message/sendWhatsAppAudio/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
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

    if version2latest then
    begin
      json :=
        '{ ' +
        '    "number": "' + waid + '", ' +
        '    "mediatype": "audio" ' +
        '    "encoding": true, ' +
        //'    "mimetype": "' + typeFile + '" ' +
        '    ,"media": "' + Base64 + '" ' +
        '} ';
    end
    else
    begin
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
    end;

    UTF8Texto := UTF8Encode(json);
    try
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/message/sendWhatsAppAudio/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/message/sendWhatsAppAudio/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/message/sendWhatsAppAudio/' + instanceName + '')
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

function TEvolutionAPI.SendPoll(waid, pollMessage: string; name: string; selectableCount: Integer): string;
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

    if version2latest then
    begin
      json :=
        '{ ' +
        '    "number": "' + waid + '", ' +
        '    "name": "' + name + '", ' +
        '    "selectableCount": ' + selectableCount.toString + ', ' +
        '    "values":  [' + pollMessage + '] ' +
        '    ' +
        '} ';
    end
    else
    begin
      json :=
        '{ ' +
        '    "number": "' + waid + '", ' +
        '    "options": { ' +
        '        "delay": 1200, ' +
        '        "presence": "composing" ' +
        '    }, ' +
        '    "pollMessage":  ' + pollMessage +
        '    ' +
        '} ';
    end;

    UTF8Texto := UTF8Encode(json);
    try
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/message/sendPoll/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/message/sendPoll/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/message/sendPoll/' + instanceName + '')
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

    if version2latest then
    begin
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
    end
    else
    begin
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
    end;

    UTF8Texto := UTF8Encode(json);
    try
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/message/sendReaction/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/message/sendReaction/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/message/sendReaction/' + instanceName)
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
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/message/sendText/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/message/sendText/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/message/sendText/' + instanceName)
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

function TEvolutionAPI.SendStatus(stype, content, backgroundColor, font, statusJidList, allContacts: string): string;
var
  response: string;
  json: string;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
  url: string;
  UTF8Texto: UTF8String;
begin
  Result := '';
  try
    content := CaractersWeb(content);

    json :=
      '{ ' +
      '    "statusMessage": {' +
      '       "type": "' + stype + '", ' + //Text
      '       "content": "' + content + '", ' + //Text or Url
      '       "backgroundColor": "' + backgroundColor + '", ' +  // Optional for text only. Accepts any color code. Examples:
                                                                 // #FFFFFF = White
                                                                 // #0000FF = Blue
                                                                 // #008000 = Green
                                                                 // #FFFF00 = Yellow
                                                                 // #FF0000 = Red
                                                                 // #800080 = Purple
                                                                 // #808080 = Gray
                                                                 // #FFC0CB = Pink
      '       "font": "' + font + '", ' +
      '       "allContacts": "' + allContacts + '", ' +  //"true" to send to all contacts or
                                                         //"false" to send to statusJidList below
      '       "statusJidList": [' + statusJidList + '] ' +

      '    } ' +
      '} ';

    UTF8Texto := UTF8Encode(json);

    url := urlServer + ':' + Port.ToString + '/message/sendStatus/' + instanceName;

    try
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/message/sendStatus/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/message/sendStatus/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/message/sendText/' + instanceName)
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

      //RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
      //Result := RetEnvMensagem.key.id;

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

function TEvolutionAPI.SendStatusMedia(stype, urlFile, backgroundColor, font, statusJidList, allContacts, caption: string): string;
var
  response: string;
  json: string;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
  url: string;
  UTF8Texto: UTF8String;
begin
  Result := '';
  try

    json :=
      '{ ' +
      '    "statusMessage": {' +
      '       "type": "' + stype + '", ' + //image or video ou audio
      '       "content": "' + urlFile + '", ' + //url image or video or audio
      '       "caption": "' + caption + '", ' + //Optional for image or video
      '       "backgroundColor": "' + backgroundColor + '", ' +  // Optional for text only. Accepts any color code. Examples:
                                                                 // #FFFFFF = White
                                                                 // #0000FF = Blue
                                                                 // #008000 = Green
                                                                 // #FFFF00 = Yellow
                                                                 // #FF0000 = Red
                                                                 // #800080 = Purple
                                                                 // #808080 = Gray
                                                                 // #FFC0CB = Pink
      '       "font": "' + font + '", ' +
      '       "allContacts": "' + allContacts + '", ' +  //"true" to send to all contacts or
                                                         //"false" to send to statusJidList below
      '       "statusJidList": [' + statusJidList + '] ' +

      '    } ' +
      '} ';

    UTF8Texto := UTF8Encode(json);

    url := urlServer + ':' + Port.ToString + '/message/sendStatus/' + instanceName;

    try
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/message/sendStatus/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/message/sendStatus/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/message/sendText/' + instanceName)
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

      //RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
      //Result := RetEnvMensagem.key.id;

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

    if version2latest then
    begin
      json :=
        '{ ' +
        '    "number": "' + waid + '", ' +
        '    "sticker": "' + url + '" ' +
        '} ';
    end
    else
    begin
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
    end;

    UTF8Texto := UTF8Encode(json);
    try
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/message/sendSticker/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/message/sendSticker/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/message/sendSticker/' + instanceName + '')
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

    if version2latest then
    begin
      json :=
        '{ ' +
        '    "number": "' + waid + '", ' +
        '    "sticker": "' + Base64 + '" ' +
        '} ';
    end
    else
    begin
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
    end;

    UTF8Texto := UTF8Encode(json);
    try
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/message/sendSticker/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/message/sendSticker/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
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

function TEvolutionAPI.SendText(waid, body: string; previewurl: string = 'false'; quoted: string = ''; mentionsEveryOne: string = 'false'; mentioned: string = ''): string;
var
  response: string;
  json: string;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
  RetEnvMensagem2 : uRetMensagem.TRetSendMessageClass;
  UTF8Texto: UTF8String;
begin
  Result := '';
  try
    if (length(waid) = 11) or (length(waid) = 10) then
      waid := DDIDefault.ToString + waid;

    if pos('@s.whatsapp.net', waid) = 0 then
      waid := waid + '@s.whatsapp.net';

    body := CaractersWeb(body);

    if version2latest then
    begin
      json :=
        '{ ' +
        '    "number": "' + waid + '", ' +
        '    "text": "' + body + '", ' +
        '    "delay": 500' + ',' +
        '    "linkPreview": ' + previewurl +  ' ' +
        '} ';
    end
    else
    begin
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
    end;

    UTF8Texto := UTF8Encode(json);

    if (Port = 80) or (Port = 0) then
      wpu_url := urlServer + '/message/sendText/' + instanceName else
      wpu_url := urlServer + ':' + Port.ToString + '/message/sendText/' + instanceName;

    try
      response:= TRequest.New.BaseURL(wpu_url)
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
        Result := 'Error: ' + e.Message + ' url: ' + wpu_url + ' json: ' + json;
        Exit;
      end;
    end;


    try
      if Assigned(FOnRetSendMessage) then
        FOnRetSendMessage(Self, Response);

      if version2latest then
      begin
        RetEnvMensagem2 := TRetSendMessageClass.FromJsonString(response);
        Result := RetEnvMensagem2.key.id;
      end
      else
      begin
        RetEnvMensagem := TRetEnvMenssageClass.FromJsonString(response);
        Result := RetEnvMensagem.key.id;
      end;

      //Result := Response;
    except
      on E: Exception do
      begin
        Result := 'Error: ' + e.Message  + ' url:' + wpu_url;
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
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/settings/set/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/settings/set/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
      //response := TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/settings/set/' + instanceName)
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
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/webhook/set/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/webhook/set/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
      //response := TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/webhook/set/' + instanceName)
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

function TEvolutionAPI.updateGroupDescription(description, groupJid: string): string;
var
  response: string;
  json: string;
  RetEnvMensagem: uRetMensagem.TRetCreateInstanceClass;
  UTF8Texto: UTF8String;
begin
  Result := '';
  try
    json :=
      '{ ' +
      '  "description": "' + description + '" ' +
      '} ';

    UTF8Texto := UTF8Encode(json);

    try
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/group/updateGroupDescription/' + instanceName + '?groupJid=' + groupJid else
        wpu_url := urlServer + ':' + Port.ToString + '/group/updateGroupDescription/' + instanceName + '?groupJid=' + groupJid;

      response:= TRequest.New.BaseURL(wpu_url)
      //response := TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/group/updateGroupDescription/' + instanceName + '?groupJid=' + groupJid)
        .ContentType('application/json')
        //.Token(token);
        .AddHeader('apikey', token)
        .AddBody(UTF8Texto)
        .Put
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

function TEvolutionAPI.updateGroupPicture(urlImage, groupJid: string): string;
var
  response: string;
  json: string;
  RetEnvMensagem: uRetMensagem.TRetCreateInstanceClass;
  UTF8Texto: UTF8String;
begin
  Result := '';
  try
    json :=
      '{ ' +
      '  "image": "' + urlImage + '" ' +
      '} ';

    UTF8Texto := UTF8Encode(json);

    try
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/group/updateGroupPicture/' + instanceName + '?groupJid=' + groupJid else
        wpu_url := urlServer + ':' + Port.ToString + '/group/updateGroupPicture/' + instanceName + '?groupJid=' + groupJid;

      response:= TRequest.New.BaseURL(wpu_url)
      //response := TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/group/updateGroupPicture/' + instanceName + '?groupJid=' + groupJid)
        .ContentType('application/json')
        //.Token(token);
        .AddHeader('apikey', token)
        .AddBody(UTF8Texto)
        .Put
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

function TEvolutionAPI.updateGroupSetting(action, groupJid: string): string;
var
  response: string;
  json: string;
  RetEnvMensagem: uRetMensagem.TRetCreateInstanceClass;
  UTF8Texto: UTF8String;
begin
  Result := '';
  try
    json :=
      '{ ' +
      '  "action": "' + action + '" ' + // announcement = Only Admins send messages
                                        // not_announcement = All Members send messages
                                        // locked = Only Admins edit group settings
                                        // unlocked = All Members edit group settings
      '} ';

    UTF8Texto := UTF8Encode(json);

    try
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/group/updateSetting/' + instanceName + '?groupJid=' + groupJid else
        wpu_url := urlServer + ':' + Port.ToString + '/group/updateSetting/' + instanceName + '?groupJid=' + groupJid;

      response:= TRequest.New.BaseURL(wpu_url)
      //response := TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/group/updateSetting/' + instanceName + '?groupJid=' + groupJid)
        .ContentType('application/json')
        //.Token(token);
        .AddHeader('apikey', token)
        .AddBody(UTF8Texto)
        .Put
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

function TEvolutionAPI.updateGroupSubject(subject, groupJid: string): string;
var
  response: string;
  json: string;
  RetEnvMensagem: uRetMensagem.TRetCreateInstanceClass;
  UTF8Texto: UTF8String;
begin
  Result := '';
  try
    json :=
      '{ ' +
      '  "subject": "' + subject + '" ' +
      '} ';

    UTF8Texto := UTF8Encode(json);

    try
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/group/updateGroupSubject/' + instanceName + '?groupJid=' + groupJid else
        wpu_url := urlServer + ':' + Port.ToString + '/group/updateGroupSubject/' + instanceName + '?groupJid=' + groupJid;

      response:= TRequest.New.BaseURL(wpu_url)
      //response := TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/group/updateGroupSubject/' + instanceName + '?groupJid=' + groupJid)
        .ContentType('application/json')
        //.Token(token);
        .AddHeader('apikey', token)
        .AddBody(UTF8Texto)
        .Put
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

function TEvolutionAPI.updateParticipant(action, participants, groupJid: string): string;
var
  response: string;
  json: string;
  RetEnvMensagem: uRetMensagem.TRetCreateInstanceClass;
  UTF8Texto: UTF8String;
begin
  Result := '';
  try
    json :=
      '{ ' +
      '  "action": "' + action + '", ' +// add = Add new member on group
                                        // remove = Remove existing member on group
                                        // promote = Promote to group admin
                                        // demote = Demote to group user
      '  "participants": [ ' + participants +
      '  ] ' +
      '} ';

    UTF8Texto := UTF8Encode(json);

    try
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/group/updateParticipant/' + instanceName + '?groupJid=' + groupJid else
        wpu_url := urlServer + ':' + Port.ToString + '/group/updateParticipant/' + instanceName + '?groupJid=' + groupJid;

      response:= TRequest.New.BaseURL(wpu_url)
      //response := TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/group/updateParticipant/' + instanceName + '?groupJid=' + groupJid)
        .ContentType('application/json')
        //.Token(token);
        .AddHeader('apikey', token)
        .AddBody(UTF8Texto)
        .Put
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

function TEvolutionAPI.updateToggleEphemeral(expiration, groupJid: string): string;
var
  response: string;
  json: string;
  RetEnvMensagem: uRetMensagem.TRetCreateInstanceClass;
  UTF8Texto: UTF8String;
begin
  Result := '';
  try
    json :=
      '{ ' +
      '  "expiration": "' + expiration + '" ' + // 0 = Off
                                                // 86400 = 24 Hours
                                                // 604800 = 7 Days
                                                // 7776000 = 90 Days
      '} ';

    UTF8Texto := UTF8Encode(json);

    try
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/group/toggleEphemeral/' + instanceName + '?groupJid=' + groupJid else
        wpu_url := urlServer + ':' + Port.ToString + '/group/toggleEphemeral/' + instanceName + '?groupJid=' + groupJid;

      response:= TRequest.New.BaseURL(wpu_url)
      //response := TRequest.New.BaseURL(urlServer + ':' + Port.ToString + '/group/toggleEphemeral/' + instanceName + '?groupJid=' + groupJid)
        .ContentType('application/json')
        //.Token(token);
        .AddHeader('apikey', token)
        .AddBody(UTF8Texto)
        .Put
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

function TEvolutionAPI.RegisterMobileCode(instanceName, mobileCode: string): string;
var
  response: string;
  json: string;
  UTF8Texto: UTF8String;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
begin
  Result := '';

  json :=
    '{ ' +
    '    "mobileCode": "' + mobileCode + '" ' +
    '} ';

  UTF8Texto := UTF8Encode(json);

  try
    try
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/instance/registerMobileCode/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/instance/registerMobileCode/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/instance/registerMobileCode/' + instanceName)
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
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/instance/restart/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/instance/restart/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/instance/restart/' + instanceName)
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

function TEvolutionAPI.revokeInviteCode(groupJid: string): string;
var
  response, url: string;
  json: string;
  UTF8Texto: UTF8String;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
begin
  Result := '';

  try
    try
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/group/revokeInviteCode/' + instanceName + '?groupJid=' + groupJid else
        wpu_url := urlServer + ':' + Port.ToString + '/group/revokeInviteCode/' + instanceName + '?groupJid=' + groupJid;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/group/revokeInviteCode/' + instanceName + '?groupJid=' + groupJid)
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
    // Mapeamento de extens�es para tipos de conte�do
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
    // Adicione mais extens�es e tipos de conte�do conforme necess�rio

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
    // Adicione mais tipos de conte�do e extens�es conforme necess�rio

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
    // Mapeamento de extens�es para tipos de conte�do
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
    // Adicione mais extens�es e tipos de conte�do conforme necess�rio

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
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/instance/connect/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/instance/connect/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/instance/connect/' + instanceName)
        .ContentType('application/json')
        .AddHeader('ApiKey', Token)
        //.AddBody(UTF8Texto)
        .Get
        //.Post
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

function TEvolutionAPI.LeaveGroup(groupJid: string): string;
var
  response, url: string;
  json: string;
  UTF8Texto: UTF8String;
  RetEnvMensagem: uRetMensagem.TRetEnvMenssageClass;
begin
  Result := '';

  try
    try
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/group/leaveGroup/' + instanceName + '?groupJid=' + groupJid else
        wpu_url := urlServer + ':' + Port.ToString + '/group/leaveGroup/' + instanceName + '?groupJid=' + groupJid;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/group/leaveGroup/' + instanceName + '?groupJid=' + groupJid)
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
      if (Port = 80) or (Port = 0) then
        wpu_url := urlServer + '/instance/logout/' + instanceName else
        wpu_url := urlServer + ':' + Port.ToString + '/instance/logout/' + instanceName;

      response:= TRequest.New.BaseURL(wpu_url)
      //response:= TRequest.New.BaseURL(urlServer+ ':' + Port.ToString + '/instance/logout/' + instanceName)
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
