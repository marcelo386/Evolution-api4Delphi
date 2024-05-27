unit uFetchInstancesClass;

//  *************************************************
//    Generated By: JsonToDelphiClass - 0.65
//    Project link: https://github.com/PKGeorgiev/Delphi-JsonToDelphiClass
//    Generated On: 2024-04-17 23:44:16
//  *************************************************
//    Created By  : Petar Georgiev - 2014
//    WebSite     : http://pgeorgiev.com
//  *************************************************

interface

uses Generics.Collections, Rest.Json;

type

TInstanceClass = class
private
  FApikey: String;
  FInstanceId: String;
  FInstanceName: String;
  FOwner: String;
  FProfileName: String;
  FProfilePictureUrl: String;
  FProfileStatus: String;
  FServerUrl: String;
  FStatus: String;
public
  property apikey: String read FApikey write FApikey;
  property instanceId: String read FInstanceId write FInstanceId;
  property instanceName: String read FInstanceName write FInstanceName;
  property owner: String read FOwner write FOwner;
  property profileName: String read FProfileName write FProfileName;
  property profilePictureUrl: String read FProfilePictureUrl write FProfilePictureUrl;
  property profileStatus: String read FProfileStatus write FProfileStatus;
  property serverUrl: String read FServerUrl write FServerUrl;
  property status: String read FStatus write FStatus;
  function ToJsonString: string;
  class function FromJsonString(AJsonString: string): TInstanceClass;
end;

TItemClass = class
private
  FInstance: TInstanceClass;
public
  property instance: TInstanceClass read FInstance write FInstance;
  constructor Create;
  destructor Destroy; override;
  function ToJsonString: string;
  class function FromJsonString(AJsonString: string): TItemClass;
end;

TResultClass = class
private
  FItems: TArray<TItemClass>;
public
  property Items: TArray<TItemClass> read FItems write FItems;
  destructor Destroy; override;
  function ToJsonString: string;
  class function FromJsonString(AJsonString: string): TResultClass;
end;

implementation

{TInstanceClass}


function TInstanceClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TInstanceClass.FromJsonString(AJsonString: string): TInstanceClass;
begin
  result := TJson.JsonToObject<TInstanceClass>(AJsonString)
end;

{TItemClass}

constructor TItemClass.Create;
begin
  inherited;
  FInstance := TInstanceClass.Create();
end;

destructor TItemClass.Destroy;
begin
  FInstance.free;
  inherited;
end;

function TItemClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TItemClass.FromJsonString(AJsonString: string): TItemClass;
begin
  result := TJson.JsonToObject<TItemClass>(AJsonString)
end;

{TResultClass}

destructor TResultClass.Destroy;
var
  LItemsItem: TItemClass;
begin

 for LItemsItem in FItems do
   LItemsItem.free;

  inherited;
end;

function TResultClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TResultClass.FromJsonString(AJsonString: string): TResultClass;
begin
  result := TJson.JsonToObject<TResultClass>(AJsonString)
end;

end.