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
unit uRetMensagem;


interface

uses
  System.SysUtils, System.Classes, System.JSON, Generics.Collections, Rest.Json;

type
  TContact = class
  private
    FInput: string;
    FWaID: string;
  public
    property Input: string read FInput write FInput;
    property WaID: string read FWaID write FWaID;
  end;

  TMessage = class
  private
    FID: string;
  public
    property ID: string read FID write FID;
  end;

  TImages = class
  private
    FID: string;
  public
    property ID: string read FID write FID;
  end;

  TMessagePayload = class
  private
    FMessagingProduct: string;
    FContacts: TArray<TContact>;
    FMessages: TArray<TMessage>;
    FImage: TArray<TImages>;
  public
    property MessagingProduct: string            read FMessagingProduct  write FMessagingProduct;
    property Contacts:         TArray<TContact>  read FContacts          write FContacts;
    property Messages:         TArray<TMessage>  read FMessages          write FMessages;
    property Image:            TArray<TImages>    read FImage             write FImage;

    function ToJSON: string;
    class function FromJSON(const AJSON: string): TMessagePayload;
  end;


TQrcodeClass = class
private
  FBase64: String;
  FCode: String;
  FCount: Extended;
  FPairingCode: String;
public
  property base64: String read FBase64 write FBase64;
  property code: String read FCode write FCode;
  property count: Extended read FCount write FCount;
  property pairingCode: String read FPairingCode write FPairingCode;
  function ToJsonString: string;
  class function FromJsonString(AJsonString: string): TQrcodeClass;
end;

TSettingsClass = class
private
  FAlways_online: Boolean;
  FGroups_ignore: Boolean;
  FMsg_call: String;
  FRead_messages: Boolean;
  FRead_status: Boolean;
  FReject_call: Boolean;
public
  property always_online: Boolean read FAlways_online write FAlways_online;
  property groups_ignore: Boolean read FGroups_ignore write FGroups_ignore;
  property msg_call: String read FMsg_call write FMsg_call;
  property read_messages: Boolean read FRead_messages write FRead_messages;
  property read_status: Boolean read FRead_status write FRead_status;
  property reject_call: Boolean read FReject_call write FReject_call;
  function ToJsonString: string;
  class function FromJsonString(AJsonString: string): TSettingsClass;
end;

TTypebotClass = class
private
  FEnabled: Boolean;
public
  property enabled: Boolean read FEnabled write FEnabled;
  function ToJsonString: string;
  class function FromJsonString(AJsonString: string): TTypebotClass;
end;

TSqsClass = class
private
public
  function ToJsonString: string;
  class function FromJsonString(AJsonString: string): TSqsClass;
end;

TRabbitmqClass = class
private
public
  function ToJsonString: string;
  class function FromJsonString(AJsonString: string): TRabbitmqClass;
end;

TWebsocketClass = class
private
public
  function ToJsonString: string;
  class function FromJsonString(AJsonString: string): TWebsocketClass;
end;

TWebhookClass = class
private
public
  function ToJsonString: string;
  class function FromJsonString(AJsonString: string): TWebhookClass;
end;

THashClass = class
private
  FApikey: String;
public
  property apikey: String read FApikey write FApikey;
  function ToJsonString: string;
  class function FromJsonString(AJsonString: string): THashClass;
end;

TInstanceClass = class
private
  FInstanceId: String;
  FInstanceName: String;
  FStatus: String;
public
  property instanceId: String read FInstanceId write FInstanceId;
  property instanceName: String read FInstanceName write FInstanceName;
  property status: String read FStatus write FStatus;
  function ToJsonString: string;
  class function FromJsonString(AJsonString: string): TInstanceClass;
end;

TRetCreateInstanceClass = class
private
  FHash: THashClass;
  FInstance: TInstanceClass;
  FQrcode: TQrcodeClass;
  FRabbitmq: TRabbitmqClass;
  FSettings: TSettingsClass;
  FSqs: TSqsClass;
  FTypebot: TTypebotClass;
  FWebhook: TWebhookClass;
  FWebsocket: TWebsocketClass;
public
  property hash: THashClass read FHash write FHash;
  property instance: TInstanceClass read FInstance write FInstance;
  property qrcode: TQrcodeClass read FQrcode write FQrcode;
  property rabbitmq: TRabbitmqClass read FRabbitmq write FRabbitmq;
  property settings: TSettingsClass read FSettings write FSettings;
  property sqs: TSqsClass read FSqs write FSqs;
  property typebot: TTypebotClass read FTypebot write FTypebot;
  property webhook: TWebhookClass read FWebhook write FWebhook;
  property websocket: TWebsocketClass read FWebsocket write FWebsocket;
  constructor Create;
  destructor Destroy; override;
  function ToJsonString: string;
  class function FromJsonString(AJsonString: string): TRetCreateInstanceClass;
end;

TExtendedTextMessageClass = class
private
  FText: String;
public
  property text: String read FText write FText;
  function ToJsonString: string;
  class function FromJsonString(AJsonString: string): TExtendedTextMessageClass;
end;

TMessageClass = class
private
  FExtendedTextMessage: TExtendedTextMessageClass;
public
  property extendedTextMessage: TExtendedTextMessageClass read FExtendedTextMessage write FExtendedTextMessage;
  constructor Create;
  destructor Destroy; override;
  function ToJsonString: string;
  class function FromJsonString(AJsonString: string): TMessageClass;
end;

TKeyClass = class
private
  FFromMe: Boolean;
  FId: String;
  FRemoteJid: String;
public
  property fromMe: Boolean read FFromMe write FFromMe;
  property id: String read FId write FId;
  property remoteJid: String read FRemoteJid write FRemoteJid;
  function ToJsonString: string;
  class function FromJsonString(AJsonString: string): TKeyClass;
end;

TRetEnvMenssageClass = class
private
  FKey: TKeyClass;
  FMessage: TMessageClass;
  FMessageTimestamp: String;
  FStatus: String;
public
  property key: TKeyClass read FKey write FKey;
  property message: TMessageClass read FMessage write FMessage;
  property messageTimestamp: String read FMessageTimestamp write FMessageTimestamp;
  property status: String read FStatus write FStatus;
  constructor Create;
  destructor Destroy; override;
  function ToJsonString: string;
  class function FromJsonString(AJsonString: string): TRetEnvMenssageClass;
end;



implementation

{ TMessagePayload }

class function TMessagePayload.FromJSON(const AJSON: string): TMessagePayload;
begin
  Result := TJson.JsonToObject<TMessagePayload>(AJSON);
end;

function TMessagePayload.ToJSON: string;
begin
  Result := TJson.ObjectToJsonString(Self);
end;

{TQrcodeClass}


function TQrcodeClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TQrcodeClass.FromJsonString(AJsonString: string): TQrcodeClass;
begin
  result := TJson.JsonToObject<TQrcodeClass>(AJsonString)
end;

{TSettingsClass}


function TSettingsClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TSettingsClass.FromJsonString(AJsonString: string): TSettingsClass;
begin
  result := TJson.JsonToObject<TSettingsClass>(AJsonString)
end;

{TTypebotClass}


function TTypebotClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TTypebotClass.FromJsonString(AJsonString: string): TTypebotClass;
begin
  result := TJson.JsonToObject<TTypebotClass>(AJsonString)
end;

{TSqsClass}


function TSqsClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TSqsClass.FromJsonString(AJsonString: string): TSqsClass;
begin
  result := TJson.JsonToObject<TSqsClass>(AJsonString)
end;

{TRabbitmqClass}


function TRabbitmqClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TRabbitmqClass.FromJsonString(AJsonString: string): TRabbitmqClass;
begin
  result := TJson.JsonToObject<TRabbitmqClass>(AJsonString)
end;

{TWebsocketClass}


function TWebsocketClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TWebsocketClass.FromJsonString(AJsonString: string): TWebsocketClass;
begin
  result := TJson.JsonToObject<TWebsocketClass>(AJsonString)
end;

{TWebhookClass}


function TWebhookClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TWebhookClass.FromJsonString(AJsonString: string): TWebhookClass;
begin
  result := TJson.JsonToObject<TWebhookClass>(AJsonString)
end;

{THashClass}


function THashClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function THashClass.FromJsonString(AJsonString: string): THashClass;
begin
  result := TJson.JsonToObject<THashClass>(AJsonString)
end;

{TInstanceClass}


function TInstanceClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TInstanceClass.FromJsonString(AJsonString: string): TInstanceClass;
begin
  result := TJson.JsonToObject<TInstanceClass>(AJsonString)
end;

{TRetCreateInstanceClass}

constructor TRetCreateInstanceClass.Create;
begin
  inherited;
  FInstance := TInstanceClass.Create();
  FHash := THashClass.Create();
  FWebhook := TWebhookClass.Create();
  FWebsocket := TWebsocketClass.Create();
  FRabbitmq := TRabbitmqClass.Create();
  FSqs := TSqsClass.Create();
  FTypebot := TTypebotClass.Create();
  FSettings := TSettingsClass.Create();
  FQrcode := TQrcodeClass.Create();
end;

destructor TRetCreateInstanceClass.Destroy;
begin
  FInstance.free;
  FHash.free;
  FWebhook.free;
  FWebsocket.free;
  FRabbitmq.free;
  FSqs.free;
  FTypebot.free;
  FSettings.free;
  FQrcode.free;
  inherited;
end;

function TRetCreateInstanceClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TRetCreateInstanceClass.FromJsonString(AJsonString: string): TRetCreateInstanceClass;
begin
  result := TJson.JsonToObject<TRetCreateInstanceClass>(AJsonString)
end;

{ TRetEnvMenssageClass }

constructor TRetEnvMenssageClass.Create;
begin
  inherited;
  FKey := TKeyClass.Create();
  FMessage := TMessageClass.Create();
end;

destructor TRetEnvMenssageClass.Destroy;
begin
  FKey.free;
  FMessage.free;
  inherited;
end;

class function TRetEnvMenssageClass.FromJsonString(AJsonString: string): TRetEnvMenssageClass;
begin
  result := TJson.JsonToObject<TRetEnvMenssageClass>(AJsonString)
end;

function TRetEnvMenssageClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

{ TKeyClass }

class function TKeyClass.FromJsonString(AJsonString: string): TKeyClass;
begin
  result := TJson.JsonToObject<TKeyClass>(AJsonString)
end;

function TKeyClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

{ TMessageClass }

constructor TMessageClass.Create;
begin
  inherited;
  FExtendedTextMessage := TExtendedTextMessageClass.Create();
end;

destructor TMessageClass.Destroy;
begin
  FExtendedTextMessage.free;
  inherited;
end;

class function TMessageClass.FromJsonString(AJsonString: string): TMessageClass;
begin
  result := TJson.JsonToObject<TMessageClass>(AJsonString)
end;

function TMessageClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

{ TExtendedTextMessageClass }

class function TExtendedTextMessageClass.FromJsonString(AJsonString: string): TExtendedTextMessageClass;
begin
  result := TJson.JsonToObject<TExtendedTextMessageClass>(AJsonString);
end;

function TExtendedTextMessageClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

end.

