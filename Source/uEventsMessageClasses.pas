unit uEventsMessageClasses;


interface

uses Generics.Collections, Rest.Json;

type

  TDeviceListMetadataClass = class
  private
    FRecipientKeyHash: String;
    FRecipientTimestamp: String;
    FSenderKeyHash: String;
    FSenderTimestamp: String;
  public
    property recipientKeyHash: String read FRecipientKeyHash write FRecipientKeyHash;
    property recipientTimestamp: String read FRecipientTimestamp write FRecipientTimestamp;
    property senderKeyHash: String read FSenderKeyHash write FSenderKeyHash;
    property senderTimestamp: String read FSenderTimestamp write FSenderTimestamp;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TDeviceListMetadataClass;
  end;

  TQuotedMessageClass = class
  private
    FConversation: String;
  public
    property conversation: String read FConversation write FConversation;
    //function ToJsonString: string;
    //class function FromJsonString(AJsonString: string): TQuotedMessageClass;
  end;

  TMessageContextInfoClass = class
  private
    FDeviceListMetadata: TDeviceListMetadataClass;
    FDeviceListMetadataVersion: Extended;
    Fbase64: string;
    FstanzaId: string;
    Fparticipant: string;
    FQuotedMessage: TQuotedMessageClass;
  public
    property deviceListMetadata: TDeviceListMetadataClass read FDeviceListMetadata write FDeviceListMetadata;
    property deviceListMetadataVersion: Extended read FDeviceListMetadataVersion write FDeviceListMetadataVersion;
    property base64: string read Fbase64 write Fbase64;
    property stanzaId: string read FstanzaId write FstanzaId;
    property participant: string read Fparticipant write Fparticipant;
    property quotedMessage: TQuotedMessageClass read FQuotedMessage write FQuotedMessage;

    //participant
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TMessageContextInfoClass;
  end;

  TOptionsClass = class
  private
    FOptionName: String;
  public
    property optionName: String read FOptionName write FOptionName;
    //function ToJsonString: string;
    //class function FromJsonString(AJsonString: string): TOptionsClass;
  end;

  TPollCreationMessageV3Class = class
  private
    FName: String;
    FOptions: TArray<TOptionsClass>;
    FSelectableOptionsCount: Extended;
  public
    property name: String read FName write FName;
    property options: TArray<TOptionsClass> read FOptions write FOptions;
    property selectableOptionsCount: Extended read FSelectableOptionsCount write FSelectableOptionsCount;
    //destructor Destroy; override;
    //function ToJsonString: string;
    //class function FromJsonString(AJsonString: string): TPollCreationMessageV3Class;
  end;


  TExtendedTextMessageClass = class
  private
    FContextInfo: TMessageContextInfoClass;
    FInviteLinkGroupTypeV2: String;
    FPreviewType: String;
    FText: String;
  public
    property contextInfo: TMessageContextInfoClass read FContextInfo write FContextInfo;
    property inviteLinkGroupTypeV2: String read FInviteLinkGroupTypeV2 write FInviteLinkGroupTypeV2;
    property previewType: String read FPreviewType write FPreviewType;
    property text: String read FText write FText;
    //constructor Create;
    //destructor Destroy; override;
    //function ToJsonString: string;
    //class function FromJsonString(AJsonString: string): TExtendedTextMessageClass;
  end;

  TStickerMessageClass = class
  private
    FDirectPath: String;
    FFileEncSha256: String;
    FFileLength: String;
    FFileSha256: String;
    FIsAnimated: Boolean;
    FIsAvatar: Boolean;
    FMediaKey: String;
    FMediaKeyTimestamp: String;
    FMimetype: String;
    FStickerSentTs: String;
    FUrl: String;
  public
    property directPath: String read FDirectPath write FDirectPath;
    property fileEncSha256: String read FFileEncSha256 write FFileEncSha256;
    property fileLength: String read FFileLength write FFileLength;
    property fileSha256: String read FFileSha256 write FFileSha256;
    property isAnimated: Boolean read FIsAnimated write FIsAnimated;
    property isAvatar: Boolean read FIsAvatar write FIsAvatar;
    property mediaKey: String read FMediaKey write FMediaKey;
    property mediaKeyTimestamp: String read FMediaKeyTimestamp write FMediaKeyTimestamp;
    property mimetype: String read FMimetype write FMimetype;
    property stickerSentTs: String read FStickerSentTs write FStickerSentTs;
    property url: String read FUrl write FUrl;
    //function ToJsonString: string;
    //class function FromJsonString(AJsonString: string): TStickerMessageClass;
  end;


  TVideoMessageClass = class
  private
    FDirectPath: String;
    FFileEncSha256: String;
    FFileLength: String;
    FFileSha256: String;
    FHeight: Extended;
    FJpegThumbnail: String;
    FMediaKey: String;
    FMediaKeyTimestamp: String;
    FMimetype: String;
    FSeconds: Extended;
    FStreamingSidecar: String;
    FUrl: String;
    FWidth: Extended;
    Fcaption: String;
  public
    property caption: String read Fcaption write Fcaption;
    property directPath: String read FDirectPath write FDirectPath;
    property fileEncSha256: String read FFileEncSha256 write FFileEncSha256;
    property fileLength: String read FFileLength write FFileLength;
    property fileSha256: String read FFileSha256 write FFileSha256;
    property height: Extended read FHeight write FHeight;
    property jpegThumbnail: String read FJpegThumbnail write FJpegThumbnail;
    property mediaKey: String read FMediaKey write FMediaKey;
    property mediaKeyTimestamp: String read FMediaKeyTimestamp write FMediaKeyTimestamp;
    property mimetype: String read FMimetype write FMimetype;
    property seconds: Extended read FSeconds write FSeconds;
    property streamingSidecar: String read FStreamingSidecar write FStreamingSidecar;
    property url: String read FUrl write FUrl;
    property width: Extended read FWidth write FWidth;
    //function ToJsonString: string;
    //class function FromJsonString(AJsonString: string): TVideoMessageClass;
  end;

  TDocumentMessageClass = class
  private
    FDirectPath: String;
    FFileEncSha256: String;
    FFileLength: String;
    FFileName: String;
    FFileSha256: String;
    FJpegThumbnail: String;
    FMediaKey: String;
    FMediaKeyTimestamp: String;
    FMimetype: String;
    FPageCount: Extended;
    FThumbnailDirectPath: String;
    FThumbnailEncSha256: String;
    FThumbnailHeight: Extended;
    FThumbnailSha256: String;
    FThumbnailWidth: Extended;
    FUrl: String;
    Fcaption: String;
  public
    property caption: String read Fcaption write Fcaption;
    property directPath: String read FDirectPath write FDirectPath;
    property fileEncSha256: String read FFileEncSha256 write FFileEncSha256;
    property fileLength: String read FFileLength write FFileLength;
    property fileName: String read FFileName write FFileName;
    property fileSha256: String read FFileSha256 write FFileSha256;
    property jpegThumbnail: String read FJpegThumbnail write FJpegThumbnail;
    property mediaKey: String read FMediaKey write FMediaKey;
    property mediaKeyTimestamp: String read FMediaKeyTimestamp write FMediaKeyTimestamp;
    property mimetype: String read FMimetype write FMimetype;
    property pageCount: Extended read FPageCount write FPageCount;
    property thumbnailDirectPath: String read FThumbnailDirectPath write FThumbnailDirectPath;
    property thumbnailEncSha256: String read FThumbnailEncSha256 write FThumbnailEncSha256;
    property thumbnailHeight: Extended read FThumbnailHeight write FThumbnailHeight;
    property thumbnailSha256: String read FThumbnailSha256 write FThumbnailSha256;
    property thumbnailWidth: Extended read FThumbnailWidth write FThumbnailWidth;
    property url: String read FUrl write FUrl;
    //function ToJsonString: string;
    //class function FromJsonString(AJsonString: string): TDocumentMessageClass;
  end;


  TImageMessageClass = class
  private
    FDirectPath: String;
    FFileEncSha256: String;
    FFileLength: String;
    FFileSha256: String;
    FHeight: Extended;
    FJpegThumbnail: String;
    FMediaKey: String;
    FMediaKeyTimestamp: String;
    FMidQualityFileSha256: String;
    FMimetype: String;
    FScanLengths: TArray<Extended>;
    FScansSidecar: String;
    FUrl: String;
    FWidth: Extended;
    Fcaption: String;
  public
    property caption: String read Fcaption write Fcaption;
    property directPath: String read FDirectPath write FDirectPath;
    property fileEncSha256: String read FFileEncSha256 write FFileEncSha256;
    property fileLength: String read FFileLength write FFileLength;
    property fileSha256: String read FFileSha256 write FFileSha256;
    property height: Extended read FHeight write FHeight;
    property jpegThumbnail: String read FJpegThumbnail write FJpegThumbnail;
    property mediaKey: String read FMediaKey write FMediaKey;
    property mediaKeyTimestamp: String read FMediaKeyTimestamp write FMediaKeyTimestamp;
    property midQualityFileSha256: String read FMidQualityFileSha256 write FMidQualityFileSha256;
    property mimetype: String read FMimetype write FMimetype;
    property scanLengths: TArray<Extended> read FScanLengths write FScanLengths;
    property scansSidecar: String read FScansSidecar write FScansSidecar;
    property url: String read FUrl write FUrl;
    property width: Extended read FWidth write FWidth;
    //function ToJsonString: string;
    //class function FromJsonString(AJsonString: string): TImageMessageClass;
  end;

  TAudioMessageClass = class
  private
    FDirectPath: String;
    FFileEncSha256: String;
    FFileLength: String;
    FFileSha256: String;
    FMediaKey: String;
    FMediaKeyTimestamp: String;
    FMimetype: String;
    FPtt: Boolean;
    FSeconds: Extended;
    FUrl: String;
    FWaveform: String;
  public
    property directPath: String read FDirectPath write FDirectPath;
    property fileEncSha256: String read FFileEncSha256 write FFileEncSha256;
    property fileLength: String read FFileLength write FFileLength;
    property fileSha256: String read FFileSha256 write FFileSha256;
    property mediaKey: String read FMediaKey write FMediaKey;
    property mediaKeyTimestamp: String read FMediaKeyTimestamp write FMediaKeyTimestamp;
    property mimetype: String read FMimetype write FMimetype;
    property ptt: Boolean read FPtt write FPtt;
    property seconds: Extended read FSeconds write FSeconds;
    property url: String read FUrl write FUrl;
    property waveform: String read FWaveform write FWaveform;
    //function ToJsonString: string;
    //class function FromJsonString(AJsonString: string): TAudioMessageClass;
  end;

  TContactMessageClass = class
  private
    FDisplayName: String;
    FVcard: String;
  public
    property displayName: String read FDisplayName write FDisplayName;
    property vcard: String read FVcard write FVcard;
    //function ToJsonString: string;
    //class function FromJsonString(AJsonString: string): TContactMessageClass;
  end;

  TContactsArrayMessageClass = class
  private
    FContacts: TArray<TContactMessageClass>;
    FDisplayName: String;
  public
    property contacts: TArray<TContactMessageClass> read FContacts write FContacts;
    property displayName: String read FDisplayName write FDisplayName;
    //destructor Destroy; override;
    //function ToJsonString: string;
    //class function FromJsonString(AJsonString: string): TContactsArrayMessageClass;
  end;

  TKeyEditedMessageClass = class
  private
    FFromMe: Boolean;
    FId: String;
    FRemoteJid: String;
  public
    property fromMe: Boolean read FFromMe write FFromMe;
    property id: String read FId write FId;
    property remoteJid: String read FRemoteJid write FRemoteJid;
    //function ToJsonString: string;
    //class function FromJsonString(AJsonString: string): TKeyClass;
  end;

  TEditedMessageNewMsgClass = class
  private
    FConversation: String;
  public
    property conversation: String read FConversation write FConversation;
    //function ToJsonString: string;
    //class function FromJsonString(AJsonString: string): TEditedMessageClass_001;
  end;

  TProtocolMessageClass = class
  private
    FEditedMessage: TEditedMessageNewMsgClass;
    FKey: TKeyEditedMessageClass;
    FTimestampMs: String;
    FType: String;
  public
    property editedMessage: TEditedMessageNewMsgClass read FEditedMessage write FEditedMessage;
    property key: TKeyEditedMessageClass read FKey write FKey;
    property timestampMs: String read FTimestampMs write FTimestampMs;
    property &type: String read FType write FType;
    //constructor Create;
    //destructor Destroy; override;
    //function ToJsonString: string;
    //class function FromJsonString(AJsonString: string): TProtocolMessageClass;
  end;

  TMessageEditedClass = class
  private
    FProtocolMessage: TProtocolMessageClass;
  public
    property protocolMessage: TProtocolMessageClass read FProtocolMessage write FProtocolMessage;
    //constructor Create;
    //destructor Destroy; override;
    //function ToJsonString: string;
    //class function FromJsonString(AJsonString: string): TMessageClass;
  end;

  TEditedMessageClass = class
  private
    FMessage: TMessageEditedClass;
  public
    property message: TMessageEditedClass read FMessage write FMessage;
    //constructor Create;
    //destructor Destroy; override;
    //function ToJsonString: string;
    //class function FromJsonString(AJsonString: string): TEditedMessageClass;
  end;

  TKeyReactionMessageClass = class
  private
    FFromMe: Boolean;
    FId: String;
    FRemoteJid: String;
  public
    property fromMe: Boolean read FFromMe write FFromMe;
    property id: String read FId write FId;
    property remoteJid: String read FRemoteJid write FRemoteJid;
    //function ToJsonString: string;
    //class function FromJsonString(AJsonString: string): TKeyClass;
  end;

  TReactionMessageClass = class
  private
    FKey: TKeyReactionMessageClass;
    FSenderTimestampMs: String;
    FText: String;
  public
    property key: TKeyReactionMessageClass read FKey write FKey;
    property senderTimestampMs: String read FSenderTimestampMs write FSenderTimestampMs;
    property text: String read FText write FText;
    //constructor Create;
    //destructor Destroy; override;
    //function ToJsonString: string;
    //class function FromJsonString(AJsonString: string): TReactionMessageClass;
  end;

  TLocationMessageClass = class
  private
    FDegreesLatitude: Extended;
    FDegreesLongitude: Extended;
    FJpegThumbnail: String;
    Fname: String;
    Faddress: String;
  public
    property degreesLatitude: Extended read FDegreesLatitude write FDegreesLatitude;
    property degreesLongitude: Extended read FDegreesLongitude write FDegreesLongitude;
    property jpegThumbnail: String read FJpegThumbnail write FJpegThumbnail;
    property address: String read Faddress write Faddress;
    property name: String read Fname write Fname;

    //function ToJsonString: string;
    //class function FromJsonString(AJsonString: string): TLocationMessageClass;
  end;

  TMessageClass = class
  private
    FConversation: String;
    FMessageContextInfo: TMessageContextInfoClass;
    FAudioMessage: TAudioMessageClass;
    FImageMessage: TImageMessageClass;
    FDocumentMessage: TDocumentMessageClass;
    FVideoMessage: TVideoMessageClass;
    FStickerMessage: TStickerMessageClass;
    FContactMessage: TContactMessageClass;
    FContactsArrayMessage: TContactsArrayMessageClass;
    FExtendedTextMessage: TExtendedTextMessageClass;
    FReactionMessage: TReactionMessageClass;
    FEditedMessage: TEditedMessageClass;
    FLocationMessage: TLocationMessageClass;
    FPollCreationMessageV3: TPollCreationMessageV3Class;

  public
    property conversation: String read FConversation write FConversation;
    property messageContextInfo: TMessageContextInfoClass read FMessageContextInfo write FMessageContextInfo;
    property audioMessage: TAudioMessageClass read FAudioMessage write FAudioMessage;
    property imageMessage: TImageMessageClass read FImageMessage write FImageMessage;
    property documentMessage: TDocumentMessageClass read FDocumentMessage write FDocumentMessage;
    property videoMessage: TVideoMessageClass read FVideoMessage write FVideoMessage;
    property stickerMessage: TStickerMessageClass read FStickerMessage write FStickerMessage;
    property contactMessage: TContactMessageClass read FContactMessage write FContactMessage;
    property contactsArrayMessage: TContactsArrayMessageClass read FContactsArrayMessage write FContactsArrayMessage;
    property extendedTextMessage: TExtendedTextMessageClass read FExtendedTextMessage write FExtendedTextMessage;
    property reactionMessage: TReactionMessageClass read FReactionMessage write FReactionMessage;
    property editedMessage: TEditedMessageClass read FEditedMessage write FEditedMessage;
    property locationMessage: TLocationMessageClass read FLocationMessage write FLocationMessage;
    property pollCreationMessageV3: TPollCreationMessageV3Class read FPollCreationMessageV3 write FPollCreationMessageV3;

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
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TKeyClass;
  end;

  TDisappearingModeClass = class
  private
    FInitiatedByMe: Boolean;
    FInitiator: String;
    FTrigger: String;
  public
    property initiatedByMe: Boolean read FInitiatedByMe write FInitiatedByMe;
    property initiator: String read FInitiator write FInitiator;
    property trigger: String read FTrigger write FTrigger;
    //function ToJsonString: string;
    //class function FromJsonString(AJsonString: string): TDisappearingModeClass;
  end;

  TContextInfoClass = class
  private
    FDisappearingMode: TDisappearingModeClass;
    FEphemeralSettingTimestamp: String;
    FExpiration: Extended;
  public
    property disappearingMode: TDisappearingModeClass read FDisappearingMode write FDisappearingMode;
    property ephemeralSettingTimestamp: String read FEphemeralSettingTimestamp write FEphemeralSettingTimestamp;
    property expiration: Extended read FExpiration write FExpiration;
    //constructor Create;
    //destructor Destroy; override;
    //function ToJsonString: string;
    //class function FromJsonString(AJsonString: string): TContextInfoClass;
  end;

  TDataClass = class
  private
    FKey: TKeyClass;
    FMessage: TMessageClass;
    FMessageTimestamp: Int64;
    FMessageType: String;
    FOwner: String;
    FPushName: String;
    FSource: String;
    FremoteJid: String;
    FfromMe: String;
    Fid: String;
    FchatId: String;
    Fdate: String;
    Foffline: Boolean;
    Fstatus: String;
    FisVideo: Boolean;
    FisGroup: Boolean;
    Fdatetime: Int64;
    FContextInfo: TContextInfoClass;
  public
    property key: TKeyClass read FKey write FKey;
    property message: TMessageClass read FMessage write FMessage;
    property messageTimestamp: Int64 read FMessageTimestamp write FMessageTimestamp;
    property messageType: String read FMessageType write FMessageType;
    property owner: String read FOwner write FOwner;
    property pushName: String read FPushName write FPushName;
    property source: String read FSource write FSource;
    property remoteJid: String read FremoteJid write FremoteJid;
    property fromMe: String read FfromMe write FfromMe;
    property id: String read Fid write Fid;
    property chatId: String read FchatId write FchatId;
    property date: String read Fdate write Fdate;
    property status: String read Fstatus write Fstatus;
    property offline: Boolean read Foffline write Foffline;
    property isVideo: Boolean read FisVideo write FisVideo;
    property isGroup: Boolean read FisGroup write FisGroup;
    property datetime: Int64 read Fdatetime write Fdatetime;
    property contextInfo: TContextInfoClass read FContextInfo write FContextInfo;

    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TDataClass;
  end;

  TResultEventClass = class
  private
    FApikey: String;
    FData: TDataClass;
    //FDate_time: String;
    FDestination: String;
    FEvent: String;
    FInstance: String;
    FSender: String;
    FServer_url: String;
  public
    property apikey: String read FApikey write FApikey;
    property data: TDataClass read FData write FData;
    //property date_time: String read FDate_time write FDate_time;
    property destination: String read FDestination write FDestination;
    property event: String read FEvent write FEvent;
    property instance: String read FInstance write FInstance;
    property sender: String read FSender write FSender;
    property server_url: String read FServer_url write FServer_url;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TResultEventClass;
  end;

implementation

{TDeviceListMetadataClass}


function TDeviceListMetadataClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TDeviceListMetadataClass.FromJsonString(AJsonString: string): TDeviceListMetadataClass;
begin
  result := TJson.JsonToObject<TDeviceListMetadataClass>(AJsonString)
end;

{TMessageContextInfoClass}

constructor TMessageContextInfoClass.Create;
begin
  inherited;
  FDeviceListMetadata := TDeviceListMetadataClass.Create();
  FQuotedMessage := TQuotedMessageClass.Create();
end;

destructor TMessageContextInfoClass.Destroy;
begin
  FDeviceListMetadata.free;
  FQuotedMessage.free;
  inherited;
end;

function TMessageContextInfoClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TMessageContextInfoClass.FromJsonString(AJsonString: string): TMessageContextInfoClass;
begin
  result := TJson.JsonToObject<TMessageContextInfoClass>(AJsonString)
end;

{TMessageClass}

constructor TMessageClass.Create;
begin
  inherited;
  FMessageContextInfo := TMessageContextInfoClass.Create();
  FAudioMessage := TAudioMessageClass.Create();
  FImageMessage := TImageMessageClass.Create();
  FDocumentMessage := TDocumentMessageClass.Create();
  FVideoMessage := TVideoMessageClass.Create();
  FStickerMessage := TStickerMessageClass.Create();
  FContactMessage := TContactMessageClass.Create();
  FContactsArrayMessage := TContactsArrayMessageClass.Create();
  FExtendedTextMessage := TExtendedTextMessageClass.Create();
  FReactionMessage := TReactionMessageClass.Create();
  FEditedMessage := TEditedMessageClass.Create();
  FLocationMessage := TLocationMessageClass.Create();
  FPollCreationMessageV3 := TPollCreationMessageV3Class.Create();
end;

destructor TMessageClass.Destroy;
begin
  FMessageContextInfo.free;
  FAudioMessage.free;
  FImageMessage.free;
  FDocumentMessage.free;
  FVideoMessage.free;
  FStickerMessage.free;
  FContactMessage.free;
  FContactsArrayMessage.free;
  FExtendedTextMessage.free;
  FReactionMessage.free;
  FEditedMessage.free;
  FLocationMessage.free;
  FPollCreationMessageV3.free;
  inherited;
end;

function TMessageClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TMessageClass.FromJsonString(AJsonString: string): TMessageClass;
begin
  result := TJson.JsonToObject<TMessageClass>(AJsonString)
end;

{TKeyClass}


function TKeyClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

constructor TKeyClass.Create;
begin
  inherited;
end;

destructor TKeyClass.Destroy;
begin

  inherited;
end;

class function TKeyClass.FromJsonString(AJsonString: string): TKeyClass;
begin
  result := TJson.JsonToObject<TKeyClass>(AJsonString)
end;

{TDataClass}

constructor TDataClass.Create;
begin
  inherited;
  FKey := TKeyClass.Create();
  FMessage := TMessageClass.Create();
end;

destructor TDataClass.Destroy;
begin
  FKey.free;
  FMessage.free;
  inherited;
end;

function TDataClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TDataClass.FromJsonString(AJsonString: string): TDataClass;
begin
  result := TJson.JsonToObject<TDataClass>(AJsonString)
end;

{TResultEventClass}

constructor TResultEventClass.Create;
begin
  inherited;
  FData := TDataClass.Create();
end;

destructor TResultEventClass.Destroy;
begin
  FData.free;
  inherited;
end;

function TResultEventClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TResultEventClass.FromJsonString(AJsonString: string): TResultEventClass;
begin
  AJsonString := AJsonString;
  result := TJson.JsonToObject<TResultEventClass>(AJsonString)
end;

end.
