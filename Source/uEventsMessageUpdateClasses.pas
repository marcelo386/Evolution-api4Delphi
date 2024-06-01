unit uEventsMessageUpdateClasses;

interface

uses Generics.Collections, Rest.Json;

type

  TPollUpdatesClass = class
  private
    FName: String;
    FVoters: TArray<String>;
  public
    property name: String read FName write FName;
    property voters: TArray<String> read FVoters write FVoters;
  end;

  TDataClass = class
  private
    FDatetime: Int64;
    FFromMe: Boolean;
    FId: String;
    FOwner: String;
    FRemoteJid: String;
    FStatus: String;
    FPollUpdates: TArray<TPollUpdatesClass>;
  public
    property datetime: Int64 read FDatetime write FDatetime;
    property fromMe: Boolean read FFromMe write FFromMe;
    property id: String read FId write FId;
    property owner: String read FOwner write FOwner;
    property remoteJid: String read FRemoteJid write FRemoteJid;
    property status: String read FStatus write FStatus;
    property pollUpdates: TArray<TPollUpdatesClass> read FPollUpdates write FPollUpdates;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TDataClass;
  end;

  TResultEventMessageUpdateClass = class
  private
    FApikey: String;
    FData: TDataClass;
    FDate_time: String;
    FDestination: String;
    FEvent: String;
    FInstance: String;
    FSender: String;
    FServer_url: String;
  public
    property apikey: String read FApikey write FApikey;
    property data: TDataClass read FData write FData;
    property date_time: String read FDate_time write FDate_time;
    property destination: String read FDestination write FDestination;
    property event: String read FEvent write FEvent;
    property instance: String read FInstance write FInstance;
    property sender: String read FSender write FSender;
    property server_url: String read FServer_url write FServer_url;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TResultEventMessageUpdateClass;
  end;

implementation

{TDataClass}


function TDataClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TDataClass.FromJsonString(AJsonString: string): TDataClass;
begin
  result := TJson.JsonToObject<TDataClass>(AJsonString)
end;

{TResultEventMessageUpdateClass}

constructor TResultEventMessageUpdateClass.Create;
begin
  inherited;
  FData := TDataClass.Create();
end;

destructor TResultEventMessageUpdateClass.Destroy;
begin
  FData.free;
  inherited;
end;

function TResultEventMessageUpdateClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TResultEventMessageUpdateClass.FromJsonString(AJsonString: string): TResultEventMessageUpdateClass;
begin
  result := TJson.JsonToObject<TResultEventMessageUpdateClass>(AJsonString)
end;

end.
