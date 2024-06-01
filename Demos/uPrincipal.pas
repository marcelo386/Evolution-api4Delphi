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
  Data.........: 01/03/2023
  Identificador: @Marcelo
  Modificação..:
####################################################################################################################
}
unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, System.ImageList, Vcl.ImgList,
  IniFiles, System.IOUtils, Vcl.Buttons, Vcl.Imaging.pngimage, System.NetEncoding, DateUtils,
  uEvolutionAPI, uEventsMessageClasses, uEventsMessageUpdateClasses, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, System.StrUtils, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  System.JSON, REST.Types, REST.Response.Adapter;

type
  TfrmPrincipal = class(TForm)
    edtTokenAPI: TEdit;
    Label1: TLabel;
    ImageList1: TImageList;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    ed_num: TLabeledEdit;
    mem_message: TMemo;
    edtURL: TLabeledEdit;
    PageControl1: TPageControl;
    tsImage: TTabSheet;
    Image1: TImage;
    lblCaminhoImagem: TLabel;
    tsBase64: TTabSheet;
    Memo1: TMemo;
    gbAcoesBasicas: TGroupBox;
    btnLocalizacaoBotao: TButton;
    btnLink: TButton;
    btnDownloadMedia: TButton;
    btnImagem: TButton;
    btnVideoBotao: TButton;
    btnVideo: TButton;
    btnListaMenu: TButton;
    btnBotaoSimples: TButton;
    btnTextoSimples: TButton;
    btnAudio: TButton;
    btnContato: TButton;
    btnSticker: TButton;
    btnLocalizacao: TButton;
    btnArquivo: TButton;
    Button2: TButton;
    edtHeader: TLabeledEdit;
    edtFooter: TLabeledEdit;
    edtButtonText: TLabeledEdit;
    edtNumberShared: TLabeledEdit;
    edtNameContactShared: TLabeledEdit;
    btnReagir: TButton;
    edtMessage_id: TLabeledEdit;
    btnResponder: TButton;
    BitBtn2: TButton;
    OpenDialog1: TOpenDialog;
    edtInstanceName: TEdit;
    Label5: TLabel;
    BitBtn1: TBitBtn;
    Label6: TLabel;
    edtPORT_SERVER: TEdit;
    Label7: TLabel;
    edtDDI_Default: TEdit;
    Image2: TImage;
    EvolutionAPI1: TEvolutionAPI;
    Label4: TLabel;
    edtPortWebhook: TEdit;
    Image3: TImage;
    bCreateInstanceBasic: TBitBtn;
    edtRemoteJidQuoted: TLabeledEdit;
    mem_Quoted_message: TMemo;
    Label9: TLabel;
    Label10: TLabel;
    edtURLWebhook: TEdit;
    bSetWebhook: TBitBtn;
    Label11: TLabel;
    edtEventsSubscribe: TEdit;
    Label12: TLabel;
    edtNumberWhatsApp: TEdit;
    Label13: TLabel;
    edtUrlServerEvolutionAPI: TEdit;
    BitBtn3: TBitBtn;
    cFromMe: TComboBox;
    Label14: TLabel;
    ProgressBar1: TProgressBar;
    IdHTTP1: TIdHTTP;
    BitBtn4: TBitBtn;
    bFetchInstances: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    whatsOff: TImage;
    whatsOn: TImage;
    lblNumeroConectado: TLabel;
    FDMemTable1: TFDMemTable;
    DataSource1: TDataSource;
    PageControl2: TPageControl;
    TabSheet1: TTabSheet;
    Label8: TLabel;
    memResponse: TMemo;
    TabSheet2: TTabSheet;
    DBGrid1: TDBGrid;
    StatusBar1: TStatusBar;
    edtTokenAPIGeral: TEdit;
    Label15: TLabel;
    TimerInicio: TTimer;
    Button1: TButton;
    BitBtn5: TBitBtn;
    procedure btnTextoSimplesClick(Sender: TObject);
    procedure btnBotaoSimplesClick(Sender: TObject);
    procedure btnListaMenuClick(Sender: TObject);
    procedure btnContatoClick(Sender: TObject);
    procedure btnLinkClick(Sender: TObject);
    procedure btnImagemClick(Sender: TObject);
    procedure btnLocalizacaoClick(Sender: TObject);
    procedure btnReagirClick(Sender: TObject);
    procedure btnResponderClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure btnArquivoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SalvarIni;
    procedure LerConfiguracoes;
    procedure BitBtn1Click(Sender: TObject);
    procedure EvolutionAPI1Response(Sender: TObject; Response: string);
    procedure EvolutionAPI1RetSendMessage(Sender: TObject; Response: string);
    procedure bCreateInstanceBasicClick(Sender: TObject);
    procedure btnAudioClick(Sender: TObject);
    procedure btnStickerClick(Sender: TObject);
    procedure bSetWebhookClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure EvolutionAPI1ResponseMessageUpdate(Sender: TObject; Response: string);
    procedure Button2Click(Sender: TObject);
    procedure EvolutionAPI1ResponseCallUpdate(Sender: TObject; Response: string);
    procedure EvolutionAPI1ResponseCHATS_DELETE(Sender: TObject; Response: string);
    procedure EvolutionAPI1ResponseCHATS_SET(Sender: TObject; Response: string);
    procedure EvolutionAPI1ResponseCHATS_UPDATE(Sender: TObject; Response: string);
    procedure EvolutionAPI1ResponseCHATS_UPSERT(Sender: TObject; Response: string);
    procedure EvolutionAPI1ResponseConnectionUpdate(Sender: TObject; Response: string);
    procedure EvolutionAPI1ResponseCONTACTS_SET(Sender: TObject; Response: string);
    procedure EvolutionAPI1ResponseCONTACTS_UPDATE(Sender: TObject; Response: string);
    procedure EvolutionAPI1ResponseCONTACTS_UPSERT(Sender: TObject; Response: string);
    procedure EvolutionAPI1ResponseGROUPS_SET(Sender: TObject; Response: string);
    procedure EvolutionAPI1ResponseGROUPS_UPSERT(Sender: TObject; Response: string);
    procedure EvolutionAPI1ResponseGROUP_PARTICIPANTS_UPDATE(Sender: TObject; Response: string);
    procedure EvolutionAPI1ResponseGROUP_UPDATE(Sender: TObject; Response: string);
    procedure EvolutionAPI1ResponseMESSAGES_SET(Sender: TObject; Response: string);
    procedure EvolutionAPI1ResponsePRESENCE_UPDATE(Sender: TObject; Response: string);
    procedure EvolutionAPI1ResponseQrcodeUpdate(Sender: TObject; Response: string);
    procedure EvolutionAPI1ResponseSEND_MESSAGE(Sender: TObject; Response: string);
    procedure BitBtn4Click(Sender: TObject);
    procedure bFetchInstancesClick(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure TimerInicioTimer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnLocalizacaoBotaoClick(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure btnDownloadMediaClick(Sender: TObject);

  private
    procedure CarregarImagemBase64(const Base64Str: string; const Image: TImage);
    procedure ProcessQRCodeImage;
    procedure gravar_log(linha: string);
    procedure JsonToDataset(aDataset: TDataSet; aJSON, RootElement: string);
    procedure AutoSizeDBGrid(const xDBGrid: TDBGrid);
    function GerarGUID: string;
    function BooleanToStr(Operador: Boolean): String;
    function Descriptografar(mediakey, CaminhoArqOriginal,
      CaminhoArqDescriptogrado, Telefone: string): Boolean;
    function DownloadFile(url, mediakey, mimetype, Telefone, TipoArq, Extensao: string;
      var AFileName: string; var AFileNameFinal: string): Boolean;
    { Private declarations }
  public
    { Public declarations }
    sResponse: string;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses uRetMensagem, uFetchInstancesClass, uConnectionUpdateClass, uQrcodeUpdateClass, uDownloadMediaClass;

const
  AutoFileType = 7; // Default define automaticamente o tipo de arquivo
  ManualFileType = 9;

type
  TArgArray = record // argumentos passados a DLL
    Arg0, Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8: PAnsiChar;
  end;

function InitModule(SecurityCode: Integer): Integer; cdecl;
  external 'WhatsDll.dll';
function Decrypt(ArgCnt: Integer; ArgsArray: Pointer; Callback: Pointer;
  var ErrorText: PAnsiChar): Integer; cdecl; external 'WhatsDll.dll';

// Function necessária a DLL. Não alterar
function NewArg(S: ansistring): PAnsiChar;
begin
  try
    GetMem(Result, Length(S) + 4);
    ZeroMemory(Result, Length(S) + 4);
    if (Length(S) <> 0) then
      CopyMemory(Result, @S[1], Length(S));
  except
    on E: Exception do
  end;
end;

procedure Callback(Progress: Integer); cdecl;
begin
  try
    //application.ProcessMessages;
    frmPrincipal.ProgressBar1.Position := Progress;
  except
    on E: Exception do
  end;
end;

procedure TfrmPrincipal.AutoSizeDBGrid(const xDBGrid: TDBGrid);
var
  I, TotalWidht, VarWidth, QtdTotalColuna : Integer;
  xColumn : TColumn;
begin
  // Largura total de todas as colunas antes de redimensionar
  TotalWidht := 0;
  // Como dividir todo o espaço extra na grade
  VarWidth := 0;
  // Quantas colunas devem ser auto-redimensionamento
  QtdTotalColuna := 0;

  for I := 0 to -1 + xDBGrid.Columns.Count do
  begin
    TotalWidht := TotalWidht + xDBGrid.Columns[I].Width;
    if xDBGrid.Columns[I].Field.Tag <> 0 then
      Inc(QtdTotalColuna);
  end;

  // Adiciona 1px para a linha de separador de coluna
  if dgColLines in xDBGrid.Options then
    TotalWidht := TotalWidht + xDBGrid.Columns.Count;

  // Adiciona a largura da coluna indicadora
  if dgIndicator in xDBGrid.Options then
    TotalWidht := TotalWidht + IndicatorWidth;

  // width vale "Left"
  VarWidth :=  xDBGrid.ClientWidth - TotalWidht;


  // Da mesma forma distribuir VarWidth para todas as colunas auto-resizable
  if QtdTotalColuna > 0 then
    VarWidth := varWidth div QtdTotalColuna;

  for I := 0 to -1 + xDBGrid.Columns.Count do
  begin
    xColumn := xDBGrid.Columns[I];
    if xColumn.Field.Tag <> 0 then
    begin
      xColumn.Width := xColumn.Width + VarWidth;
      if xColumn.Width < xColumn.Field.Tag then
        xColumn.Width := xColumn.Field.Tag;
    end;
  end;
end;

procedure TfrmPrincipal.bCreateInstanceBasicClick(Sender: TObject);
var
  RetCreateInstance: uRetMensagem.TRetCreateInstanceClass;
  Base64QrCode: TStringList;
begin
  if Trim(edtTokenAPI.Text) = '' then
  begin
    ShowMessage('INFORM THE TOKEN API');
    edtTokenAPI.SetFocus;
    Exit;
  end;

  if Trim(edtInstanceName.Text) = '' then
  begin
    ShowMessage('INFORM THE "INSTANCE NAME " ');
    edtInstanceName.SetFocus;
    Exit;
  end;


  EvolutionAPI1.urlServer := 'http://localhost';
  EvolutionAPI1.Token := 'B6D711FCDE4D4FD5936544120E713976'; //edtTokenAPI.Text;
  EvolutionAPI1.instanceName := edtInstanceName.Text;
  sResponse := EvolutionAPI1.CreateInstanceBasic(edtInstanceName.Text, edtTokenAPI.Text, edtNumberWhatsApp.Text, true);

  EvolutionAPI1.Token := edtTokenAPI.Text;

  RetCreateInstance := TRetCreateInstanceClass.FromJsonString(sResponse);
  CarregarImagemBase64(RetCreateInstance.qrcode.base64, Image3);

  {try
    Base64QrCode := TStringList.Create(nil);
    Base64QrCode.Text := RetCreateInstance.qrcode.base64;
  finally
    Base64QrCode.Free;
  end;}


  memResponse.Lines.Add(sResponse);
end;

procedure TfrmPrincipal.BitBtn1Click(Sender: TObject);
begin
  SalvarIni;
end;

procedure TfrmPrincipal.BitBtn2Click(Sender: TObject);
begin
  if Trim(ed_num.Text) = '' then
  begin
    ShowMessage('INFORM THE DESTINATION WHATSAPP NUMBER');
    ed_num.SetFocus;
    Exit;
  end;

  if Trim(edtMessage_id.Text) = '' then
  begin
    ShowMessage('INFORM THE "MESSAGE ID" TO BE SENT REACTION');
    edtMessage_id.SetFocus;
    Exit;
  end;


  EvolutionAPI1.Token := edtTokenAPI.Text;
  EvolutionAPI1.instanceName := edtInstanceName.Text;
  sResponse := EvolutionAPI1.MarkIsRead(ed_num.Text, edtMessage_id.Text, cFromMe.Text);

  memResponse.Lines.Add(sResponse);
end;

procedure TfrmPrincipal.BitBtn3Click(Sender: TObject);
var
  //Result: uEventsMessageClasses.TResultEventClass;
  Result: uEventsMessageUpdateClasses.TResultEventMessageUpdateClass;
  Response: string;
begin
  Response := '{"event":"messages.update","instance":"testeapi2","data":{"remoteJid":"5517981388414@s.whatsapp.net","id":"BAE5135866706C39","fromMe":true,"status":"READ","datetime":1708880950011,"owner":"testeapi2"}';
  Response := Response + ',"destination":"http://192.168.0.155:3000/webhook","date_time":"2024-02-25T14:09:10.011Z","sender":"551734226371@s.whatsapp.net","server_url":"localhost","apikey":"B6D711FCDE4D4FD5936544120E713976zz"}';

  try
    Result := TResultEventMessageUpdateClass.FromJsonString(Response);
  finally

  end;
end;

procedure TfrmPrincipal.BitBtn4Click(Sender: TObject);
var
  I : Integer;
begin
  if Trim(edtUrlServerEvolutionAPI.Text) = '' then
  begin
    ShowMessage('INFORM THE URL SERVER API');
    edtTokenAPI.SetFocus;
    Exit;
  end;

  if Trim(edtTokenAPI.Text) = '' then
  begin
    ShowMessage('INFORM THE TOKEN API');
    edtTokenAPI.SetFocus;
    Exit;
  end;

  if Trim(edtInstanceName.Text) = '' then
  begin
    ShowMessage('INFORM THE "INSTANCE NAME " ');
    edtInstanceName.SetFocus;
    Exit;
  end;


  //EvolutionAPI1.urlServer := 'http://localhost';
  //EvolutionAPI1.Token := 'B6D711FCDE4D4FD5936544120E713976'; //edtTokenAPI.Text;
  EvolutionAPI1.urlServer := edtUrlServerEvolutionAPI.Text;
  EvolutionAPI1.Token := edtTokenAPI.Text;
  EvolutionAPI1.instanceName := edtInstanceName.Text;
  EvolutionAPI1.Port := StrToIntDef(edtPORT_SERVER.Text, 8080);
  sResponse := EvolutionAPI1.InstanceConnect(edtInstanceName.Text);

  EvolutionAPI1.Token := edtTokenAPI.Text;

  memResponse.Lines.Add(sResponse);

  try
    //sResponse := Trim(Copy(sResponse,1,length(sResponse)-1));
    //{"instance":
    //sResponse := '[' + Copy(sResponse,13,length(sResponse)) + ']';

    sResponse := '[' + sResponse + ']';

    JsonToDataset(FDMemTable1, sResponse, 'instance');

    For I := 0 to FDMemTable1.FieldCount - 1 do
      FDMemTable1.Fields[i].Tag := 120;
    AutoSizeDBGrid(DBGrid1);

  except on E: Exception do
  end;
end;

procedure TfrmPrincipal.BitBtn5Click(Sender: TObject);
var
  I : Integer;
begin
  if Trim(edtUrlServerEvolutionAPI.Text) = '' then
  begin
    ShowMessage('INFORM THE URL SERVER API');
    edtTokenAPI.SetFocus;
    Exit;
  end;

  if Trim(edtTokenAPI.Text) = '' then
  begin
    ShowMessage('INFORM THE TOKEN API');
    edtTokenAPI.SetFocus;
    Exit;
  end;

  if Trim(edtInstanceName.Text) = '' then
  begin
    ShowMessage('INFORM THE "INSTANCE NAME " ');
    edtInstanceName.SetFocus;
    Exit;
  end;


  //EvolutionAPI1.urlServer := 'http://localhost';
  //EvolutionAPI1.Token := 'B6D711FCDE4D4FD5936544120E713976'; //edtTokenAPI.Text;
  EvolutionAPI1.urlServer := edtUrlServerEvolutionAPI.Text;
  EvolutionAPI1.Token := edtTokenAPI.Text;
  EvolutionAPI1.instanceName := edtInstanceName.Text;
  EvolutionAPI1.Port := StrToIntDef(edtPORT_SERVER.Text, 8080);

  sResponse := EvolutionAPI1.RegisterMobileCode(edtInstanceName.Text, '1234');

  EvolutionAPI1.Token := edtTokenAPI.Text;

  memResponse.Lines.Add(sResponse);

  try
    //sResponse := Trim(Copy(sResponse,1,length(sResponse)-1));
    //{"instance":
    //sResponse := '[' + Copy(sResponse,13,length(sResponse)) + ']';

    sResponse := '[' + sResponse + ']';

    JsonToDataset(FDMemTable1, sResponse, 'instance');

    For I := 0 to FDMemTable1.FieldCount - 1 do
      FDMemTable1.Fields[i].Tag := 120;
    AutoSizeDBGrid(DBGrid1);

  except on E: Exception do
  end;
end;

procedure TfrmPrincipal.bFetchInstancesClick(Sender: TObject);
var
  I : Integer;
  Result: uFetchInstancesClass.TRootClass;
begin
  if Trim(edtUrlServerEvolutionAPI.Text) = '' then
  begin
    ShowMessage('INFORM THE URL SERVER API');
    edtTokenAPI.SetFocus;
    Exit;
  end;

  if Trim(edtTokenAPI.Text) = '' then
  begin
    ShowMessage('INFORM THE TOKEN API');
    edtTokenAPI.SetFocus;
    Exit;
  end;

  if Trim(edtInstanceName.Text) = '' then
  begin
    ShowMessage('INFORM THE "INSTANCE NAME " ');
    edtInstanceName.SetFocus;
    Exit;
  end;


  //EvolutionAPI1.urlServer := 'http://localhost';
  //EvolutionAPI1.Token := 'B6D711FCDE4D4FD5936544120E713976'; //edtTokenAPI.Text;
  EvolutionAPI1.urlServer := edtUrlServerEvolutionAPI.Text;
  EvolutionAPI1.Token := edtTokenAPIGeral.Text;
  EvolutionAPI1.instanceName := edtInstanceName.Text;
  EvolutionAPI1.Port := StrToIntDef(edtPORT_SERVER.Text, 8080);
  sResponse := EvolutionAPI1.fetchInstances;

  EvolutionAPI1.Token := edtTokenAPI.Text;

  memResponse.Lines.Add(sResponse + #13#10);
  gravar_log(sResponse + #13#10);


  try
    //sResponse := Copy(sResponse,2,length(sResponse));
    //sResponse := Copy(sResponse,1,length(sResponse)-1);
    sResponse := '{"FetchInstances":' +  sResponse + '}';
    memResponse.Lines.Add(sResponse + #13#10);

    Result := uFetchInstancesClass.TRootClass.FromJsonString(sResponse);

    //Result := uFetchInstancesClass.TResultClass.FromJsonString('{"FetchInstances":' +  sResponse + '}');

    sResponse := Result.ToJsonString;
    sResponse := StringReplace(sResponse, '{"fetchinstances":', '', [rfReplaceAll, rfIgnoreCase]);
    sResponse := Copy(sResponse,1, length(sResponse)-1);
    sResponse := Trim(sResponse);
    gravar_log(sResponse);

    memResponse.Lines.Add(sResponse);

    JsonToDataset(FDMemTable1, sResponse, 'Instance');


    For I := 0 to FDMemTable1.FieldCount - 1 do
      FDMemTable1.Fields[i].Tag := 120;
    AutoSizeDBGrid(DBGrid1);

  except on E: Exception do
  end;

  lblNumeroConectado.Caption := '';

  if FDMemTable1.Active then
    if FDMemTable1.RecordCount > 0 then
    begin
      if FDMemTable1.Locate('instance.instanceName', edtInstanceName.Text, []) then
      begin
        try
          lblNumeroConectado.Caption := FDMemTable1.FieldByName('instance.owner').AsString;
          lblNumeroConectado.Caption := Copy(lblNumeroConectado.Caption,1, pos('@', lblNumeroConectado.Caption) -1);
          gravar_log('Número Conectado: ' + lblNumeroConectado.Caption);
        except on E: Exception do
          lblNumeroConectado.Caption := '';
        end;

        StatusBar1.Panels[0].Text := lblNumeroConectado.Caption;

        try
          StatusBar1.Panels[4].Text := FDMemTable1.FieldByName('instance.profileName').AsString;
        except on E: Exception do
        end;


        try
          if (FDMemTable1.FieldByName('instance.owner').AsString <> '') and (FDMemTable1.FieldByName('instance.status').AsString = 'open')  then //status
          begin
            whatsOn.Visible := True;
            whatsOff.Visible := False;
            StatusBar1.Panels[1].Text := 'Online';
          end
          else
          begin
            whatsOn.Visible := False;
            whatsOff.Visible := True;
            StatusBar1.Panels[1].Text := 'Offline';
          end;
        except
          on E: Exception do
          begin
            whatsOn.Visible := False;
            whatsOff.Visible := True;
            StatusBar1.Panels[1].Text := 'Offline';
          end;
        end;


      end;
    end;

end;

procedure TfrmPrincipal.BitBtn6Click(Sender: TObject);
var
  I : Integer;
begin
  if Trim(edtUrlServerEvolutionAPI.Text) = '' then
  begin
    ShowMessage('INFORM THE URL SERVER API');
    edtTokenAPI.SetFocus;
    Exit;
  end;

  if Trim(edtTokenAPI.Text) = '' then
  begin
    ShowMessage('INFORM THE TOKEN API');
    edtTokenAPI.SetFocus;
    Exit;
  end;

  if Trim(edtInstanceName.Text) = '' then
  begin
    ShowMessage('INFORM THE "INSTANCE NAME " ');
    edtInstanceName.SetFocus;
    Exit;
  end;


  //EvolutionAPI1.urlServer := 'http://localhost';
  //EvolutionAPI1.Token := 'B6D711FCDE4D4FD5936544120E713976'; //edtTokenAPI.Text;
  EvolutionAPI1.urlServer := edtUrlServerEvolutionAPI.Text;
  EvolutionAPI1.Token := edtTokenAPI.Text;
  EvolutionAPI1.instanceName := edtInstanceName.Text;
  EvolutionAPI1.Port := StrToIntDef(edtPORT_SERVER.Text, 8080);
  sResponse := EvolutionAPI1.connectionState(edtInstanceName.Text);

  EvolutionAPI1.Token := edtTokenAPI.Text;

  memResponse.Lines.Add(sResponse);

  try
    //sResponse := Trim(Copy(sResponse,1,length(sResponse)-1));
    //{"instance":
    //sResponse := '[' + Copy(sResponse,13,length(sResponse)) + ']';

    sResponse := '[' + sResponse + ']';

    JsonToDataset(FDMemTable1, sResponse, 'instance');

    For I := 0 to FDMemTable1.FieldCount - 1 do
      FDMemTable1.Fields[i].Tag := 120;
    AutoSizeDBGrid(DBGrid1);

  except on E: Exception do
  end;
end;

procedure TfrmPrincipal.BitBtn7Click(Sender: TObject);
var
  I : Integer;
begin
  if Trim(edtUrlServerEvolutionAPI.Text) = '' then
  begin
    ShowMessage('INFORM THE URL SERVER API');
    edtTokenAPI.SetFocus;
    Exit;
  end;

  if Trim(edtTokenAPI.Text) = '' then
  begin
    ShowMessage('INFORM THE TOKEN API');
    edtTokenAPI.SetFocus;
    Exit;
  end;

  if Trim(edtInstanceName.Text) = '' then
  begin
    ShowMessage('INFORM THE "INSTANCE NAME " ');
    edtInstanceName.SetFocus;
    Exit;
  end;


  //EvolutionAPI1.urlServer := 'http://localhost';
  //EvolutionAPI1.Token := 'B6D711FCDE4D4FD5936544120E713976'; //edtTokenAPI.Text;
  EvolutionAPI1.urlServer := edtUrlServerEvolutionAPI.Text;
  EvolutionAPI1.Token := edtTokenAPI.Text;
  EvolutionAPI1.instanceName := edtInstanceName.Text;
  EvolutionAPI1.Port := StrToIntDef(edtPORT_SERVER.Text, 8080);
  sResponse := EvolutionAPI1.RestartInstance(edtInstanceName.Text);

  EvolutionAPI1.Token := edtTokenAPI.Text;

  memResponse.Lines.Add(sResponse);

  try
    JsonToDataset(FDMemTable1, sResponse, '');

    For I := 0 to FDMemTable1.FieldCount - 1 do
      FDMemTable1.Fields[i].Tag := 120;
    AutoSizeDBGrid(DBGrid1);

  except on E: Exception do
  end;
end;

procedure TfrmPrincipal.BitBtn8Click(Sender: TObject);
var
  I : Integer;
begin
  if Trim(edtUrlServerEvolutionAPI.Text) = '' then
  begin
    ShowMessage('INFORM THE URL SERVER API');
    edtTokenAPI.SetFocus;
    Exit;
  end;

  if Trim(edtTokenAPI.Text) = '' then
  begin
    ShowMessage('INFORM THE TOKEN API');
    edtTokenAPI.SetFocus;
    Exit;
  end;

  if Trim(edtInstanceName.Text) = '' then
  begin
    ShowMessage('INFORM THE "INSTANCE NAME " ');
    edtInstanceName.SetFocus;
    Exit;
  end;


  //EvolutionAPI1.urlServer := 'http://localhost';
  //EvolutionAPI1.Token := 'B6D711FCDE4D4FD5936544120E713976'; //edtTokenAPI.Text;
  EvolutionAPI1.urlServer := edtUrlServerEvolutionAPI.Text;
  EvolutionAPI1.Token := edtTokenAPI.Text;
  EvolutionAPI1.instanceName := edtInstanceName.Text;
  EvolutionAPI1.Port := StrToIntDef(edtPORT_SERVER.Text, 8080);
  sResponse := EvolutionAPI1.logout(edtInstanceName.Text);

  EvolutionAPI1.Token := edtTokenAPI.Text;

  memResponse.Lines.Add(sResponse);

  try
    JsonToDataset(FDMemTable1, sResponse, '');

    For I := 0 to FDMemTable1.FieldCount - 1 do
      FDMemTable1.Fields[i].Tag := 120;
    AutoSizeDBGrid(DBGrid1);

  except on E: Exception do
  end;
end;

procedure TfrmPrincipal.BitBtn9Click(Sender: TObject);
var
  I : Integer;
begin
  if Trim(edtUrlServerEvolutionAPI.Text) = '' then
  begin
    ShowMessage('INFORM THE URL SERVER API');
    edtTokenAPI.SetFocus;
    Exit;
  end;

  if Trim(edtTokenAPI.Text) = '' then
  begin
    ShowMessage('INFORM THE TOKEN API');
    edtTokenAPI.SetFocus;
    Exit;
  end;

  if Trim(edtInstanceName.Text) = '' then
  begin
    ShowMessage('INFORM THE "INSTANCE NAME " ');
    edtInstanceName.SetFocus;
    Exit;
  end;


  //EvolutionAPI1.urlServer := 'http://localhost';
  //EvolutionAPI1.Token := 'B6D711FCDE4D4FD5936544120E713976'; //edtTokenAPI.Text;
  EvolutionAPI1.urlServer := edtUrlServerEvolutionAPI.Text;
  EvolutionAPI1.Token := edtTokenAPI.Text;
  EvolutionAPI1.instanceName := edtInstanceName.Text;
  EvolutionAPI1.Port := StrToIntDef(edtPORT_SERVER.Text, 8080);
  sResponse := EvolutionAPI1.DeleteInstance(edtInstanceName.Text);

  EvolutionAPI1.Token := edtTokenAPI.Text;

  memResponse.Lines.Add(sResponse);

  try
    JsonToDataset(FDMemTable1, sResponse, '');

    For I := 0 to FDMemTable1.FieldCount - 1 do
      FDMemTable1.Fields[i].Tag := 120;
    AutoSizeDBGrid(DBGrid1);

  except on E: Exception do
  end;

end;

procedure TfrmPrincipal.bSetWebhookClick(Sender: TObject);
begin
  if Trim(edtURLWebhook.Text) = '' then
  begin
    ShowMessage('INFORM THE URL Webhook');
    edtURLWebhook.SetFocus;
    Exit;
  end;

  if Trim(edtEventsSubscribe.Text) = '' then
  begin
    ShowMessage('INFORM THE Events Subscribe');
    edtEventsSubscribe.SetFocus;
    Exit;
  end;

    (*
    "events": [
        // "APPLICATION_STARTUP",
        "QRCODE_UPDATED",
        "MESSAGES_SET",
        "MESSAGES_UPSERT",
        "MESSAGES_UPDATE",
        "MESSAGES_DELETE",
        "SEND_MESSAGE",
        // "CONTACTS_SET",
        // "CONTACTS_UPSERT",
        // "CONTACTS_UPDATE",
        // "PRESENCE_UPDATE",
        // "CHATS_SET",
        // "CHATS_UPSERT",
        // "CHATS_UPDATE",
        // "CHATS_DELETE",
        // "GROUPS_UPSERT",
        // "GROUP_UPDATE",
        // "GROUP_PARTICIPANTS_UPDATE",
        "CONNECTION_UPDATE",
        "CALL"
        // "NEW_JWT_TOKEN",
        // "TYPEBOT_START",
        // "TYPEBOT_CHANGE_STATUS"]
      *)

  EvolutionAPI1.urlServer := edtUrlServerEvolutionAPI.Text; //'http://localhost';
  EvolutionAPI1.Token := edtTokenAPI.Text;
  EvolutionAPI1.instanceName := edtInstanceName.Text;
  sResponse := EvolutionAPI1.SetWebhook(edtURLWebhook.Text, edtEventsSubscribe.Text, True, False);

  memResponse.Lines.Add(sResponse);

end;

procedure TfrmPrincipal.btnArquivoClick(Sender: TObject);
var
  caption, Type_File : string;
  caminhoArquivo, FileName : string;
  Extensao: string;
  isFigurinha : Boolean;
  LStream     : TMemoryStream;
  LBase64File : TBase64Encoding;
  LExtension  : String;
  LBase64     : String;
begin
  if Trim(ed_num.Text) = '' then
  begin
    ShowMessage('INFORM THE DESTINATION WHATSAPP NUMBER');
    ed_num.SetFocus;
    Exit;
  end;

  caminhoArquivo := '';

  OpenDialog1.Execute();

  if FileExists(OpenDialog1.FileName) then
    caminhoArquivo := OpenDialog1.FileName
  else
    Exit;

  Extensao := LowerCase(ExtractFileExt(caminhoArquivo));
  FileName := ExtractFileName(caminhoArquivo);

  LStream     := TMemoryStream.Create;
  LBase64File := TBase64Encoding.Create;
  try
    try
      LStream.LoadFromFile(caminhoArquivo);
      if LStream.Size = 0 then
      Begin
        //Int_OnErroInterno(Self, 'SendFileMessageEx: ' + Format(MSG_WarningErrorFile, [phoneNumber]), phoneNumber);
        Exit;
      end;

      LStream.Position := 0;
      LBase64 := LBase64File.EncodeBytesToString(LStream.Memory, LStream.Size);
      //LBase64      := StrExtFile_Base64Type(caminhoArquivo) + LBase64;
    except
      //Int_OnErroInterno(Self, 'SendFileMessageEx: ' + MSG_ExceptMisc, phoneNumber);
    end;
  finally
    FreeAndNil(LStream);
    FreeAndNil(LBase64File);
  end;

  //Type_File := 'image';
  Type_File := EvolutionAPI1.GetTypeFileFromExtension(Extensao);

  if Type_File <> 'document' then
    FileName := '';

  EvolutionAPI1.Token := edtTokenAPI.Text;
  EvolutionAPI1.instanceName := edtInstanceName.Text;

  if Type_File = 'document' then
    sResponse := EvolutionAPI1.SendFileBase64(ed_num.Text, mem_message.Text, Type_File, LBase64, FileName)
  else
  if Type_File = 'audio' then
    sResponse := EvolutionAPI1.SendNarratedAudioBase64(ed_num.Text, LBase64)
  else
  if Type_File = 'sticker' then
    sResponse := EvolutionAPI1.SendStickerBase64(ed_num.Text, LBase64)
  else
    sResponse := EvolutionAPI1.SendFileBase64(ed_num.Text, mem_message.Text, Type_File, LBase64, '');

  memResponse.Lines.Add(sResponse);
  memResponse.Lines.Add('');

end;

procedure TfrmPrincipal.btnAudioClick(Sender: TObject);
begin
  if Trim(ed_num.Text) = '' then
  begin
    ShowMessage('INFORM THE DESTINATION WHATSAPP NUMBER');
    ed_num.SetFocus;
    Exit;
  end;

  {if Trim(mem_message.Text) = '' then //Opocional
  begin
    ShowMessage('INFORM THE BODY MESSAGE TO BE SENT');
    mem_message.SetFocus;
  end;}

  if Trim(edtURL.Text) = '' then
  begin
    ShowMessage('INFORM THE URL LINK FILE TO BE SENT');
    edtURL.SetFocus;
    Exit;
  end;

  EvolutionAPI1.Token := edtTokenAPI.Text;
  EvolutionAPI1.instanceName := edtInstanceName.Text;
  sResponse := EvolutionAPI1.SendFile(ed_num.Text, mem_message.Text, 'image', edtURL.Text);

  //sResponse := EvolutionAPI1.SendFile(ed_num.Text, mem_message.Text, 'document', 'https://we.tl/t-Xy3U9kbKUH');

  memResponse.Lines.Add(sResponse);
end;

procedure TfrmPrincipal.btnBotaoSimplesClick(Sender: TObject);
var
  sAction : string;
begin
  if Trim(ed_num.Text) = '' then
  begin
    ShowMessage('INFORM THE DESTINATION WHATSAPP NUMBER');
    ed_num.SetFocus;
    Exit;
  end;

  if Trim(mem_message.Text) = '' then
  begin
    ShowMessage('INFORM THE BODY MESSAGE TO BE SENT');
    mem_message.SetFocus;
    Exit;
  end;

  sAction :=
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
      ' } ';


  EvolutionAPI1.Token := edtTokenAPI.Text;
  EvolutionAPI1.instanceName := edtInstanceName.Text;
  sResponse := EvolutionAPI1.SendButton(ed_num.Text, mem_message.Text, sAction, edtHeader.Text, edtFooter.Text);

  memResponse.Lines.Add(sResponse);
end;

procedure TfrmPrincipal.btnContatoClick(Sender: TObject);
begin
  if Trim(ed_num.Text) = '' then
  begin
    ShowMessage('Informe o Número do WhatsApp');
    ed_num.Setfocus;
    Exit;
  end;

  if edtNumberShared.Text = '' then
  begin
    ShowMessage('Informe o Número do WhatsApp que deseja Compartilhar');
    mem_message.Setfocus;
    Exit;
  end;

  EvolutionAPI1.Token := edtTokenAPI.Text;
  EvolutionAPI1.instanceName := edtInstanceName.Text;
  sResponse := EvolutionAPI1.SendContact(ed_num.Text, edtNumberShared.Text, edtNameContactShared.Text, '');
  memResponse.Lines.Add('');
end;

procedure TfrmPrincipal.btnDownloadMediaClick(Sender: TObject);
var
  ResponseDownloadMedia: uDownloadMediaClass.TResultDownloadMediaClass;
begin
  EvolutionAPI1.Token := edtTokenAPI.Text;
  EvolutionAPI1.instanceName := edtInstanceName.Text;
  sResponse := EvolutionAPI1.getBase64FromMediaMessage(edtMessage_id.Text, 'false');
  memResponse.Lines.Add(sResponse);

  ResponseDownloadMedia := uDownloadMediaClass.TResultDownloadMediaClass.FromJsonString(sResponse);


  {ResponseDownloadMedia.base64;
  ResponseDownloadMedia.mediatype;
  ResponseDownloadMedia.mimetype;
  ResponseDownloadMedia.caption;}

  EvolutionAPI1.Base64ToSaveFile(ResponseDownloadMedia.base64, ResponseDownloadMedia.mediatype, ResponseDownloadMedia.mimetype, '');

end;

procedure TfrmPrincipal.btnImagemClick(Sender: TObject);
begin
  if Trim(ed_num.Text) = '' then
  begin
    ShowMessage('INFORM THE DESTINATION WHATSAPP NUMBER');
    ed_num.SetFocus;
    Exit;
  end;

  {if Trim(mem_message.Text) = '' then //Opocional
  begin
    ShowMessage('INFORM THE BODY MESSAGE TO BE SENT');
    mem_message.SetFocus;
  end;}

  if Trim(edtURL.Text) = '' then
  begin
    ShowMessage('INFORM THE URL LINK FILE TO BE SENT');
    edtURL.SetFocus;
    Exit;
  end;

  EvolutionAPI1.Token := edtTokenAPI.Text;
  EvolutionAPI1.instanceName := edtInstanceName.Text;
  sResponse := EvolutionAPI1.SendFile(ed_num.Text, mem_message.Text, 'image', edtURL.Text);

  //sResponse := EvolutionAPI1.SendFile(ed_num.Text, mem_message.Text, 'document', 'https://we.tl/t-Xy3U9kbKUH');

  memResponse.Lines.Add(sResponse);

end;

procedure TfrmPrincipal.btnLinkClick(Sender: TObject);
begin
  if Trim(ed_num.Text) = '' then
  begin
    ShowMessage('INFORM THE DESTINATION WHATSAPP NUMBER');
    ed_num.SetFocus;
  end;

  {if Trim(mem_message.Text) = '' then
  begin
    ShowMessage('INFORM THE BODY MESSAGE TO BE SENT');
    mem_message.SetFocus;
  end;}

  if Trim(edtURL.Text) = '' then
  begin
    ShowMessage('INFORM THE URL LINK PREVIEW TO BE SENT');
    edtURL.SetFocus;
  end;

  EvolutionAPI1.Token := edtTokenAPI.Text;
  EvolutionAPI1.instanceName := edtInstanceName.Text;
  sResponse := EvolutionAPI1.SendText(ed_num.Text, edtURL.Text, 'true');

  memResponse.Lines.Add(sResponse);
  memResponse.Lines.Add('');

end;

procedure TfrmPrincipal.btnListaMenuClick(Sender: TObject);
var
  sSections : string;
begin
  if Trim(ed_num.Text) = '' then
  begin
    ShowMessage('INFORM THE DESTINATION WHATSAPP NUMBER');
    ed_num.SetFocus;
    Exit;
  end;

  if Trim(mem_message.Text) = '' then
  begin
    ShowMessage('INFORM THE BODY MESSAGE TO BE SENT');
    mem_message.SetFocus;
    Exit;
  end;

  if Trim(edtButtonText.Text) = '' then
  begin
    ShowMessage('INFORM THE BUTTON TEXT');
    edtButtonText.SetFocus;
    Exit;
  end;


  sSections :=
      '    {   ' +
      '      "title": "SECTION_1_TITLE", ' +
      '      "rows": [ ' +
      '        { ' +
      '          "title": "SECTION_1_ROW_1_TITLE", ' +
      '          "description": "SECTION_1_ROW_1_DESCRIPTION", ' +
      '          "rowId": "SECTION_1_ROW_1_ID" ' +
      '        }, ' +
      '        {  ' +
      '          "title": "SECTION_1_ROW_2_TITLE", ' +
      '          "description": "SECTION_1_ROW_2_DESCRIPTION", ' +
      '          "rowId": "SECTION_1_ROW_2_ID" ' +
      '        } ' +
      '      ] ' +
      '    }, ' +
      '    { ' +
      '      "title": "SECTION_2_TITLE",  ' +
      '      "rows": [  ' +
      '        {  ' +
      '          "title": "SECTION_2_ROW_1_TITLE", ' +
      '          "description": "SECTION_2_ROW_1_DESCRIPTION", ' +
      '          "rowId": "SECTION_2_ROW_1_ID" ' +
      '        }, ' +
      '        {  ' +
      '          "title": "SECTION_2_ROW_2_TITLE", ' +
      '          "description": "SECTION_2_ROW_2_DESCRIPTION",  ' +
      '          "rowId": "SECTION_2_ROW_2_ID" ' +
      '        } ' +
      '      ] ' +
      '     } ';




  EvolutionAPI1.Token := edtTokenAPI.Text;
  EvolutionAPI1.instanceName := edtInstanceName.Text;
  sResponse := EvolutionAPI1.SendListMenu(ed_num.Text, mem_message.Text, sSections, edtHeader.Text, edtFooter.Text, edtButtonText.Text);

  memResponse.Lines.Add(sResponse);
end;

procedure TfrmPrincipal.btnLocalizacaoBotaoClick(Sender: TObject);
var
  sPollMessage : string;
begin
  if Trim(ed_num.Text) = '' then
  begin
    ShowMessage('INFORM THE DESTINATION WHATSAPP NUMBER');
    ed_num.SetFocus;
    Exit;
  end;

  sPollMessage :=
      '{ ' +
      '   "name": "Main text of the poll", ' +
      '   "selectableCount": 1, ' +
      '   "values": [ ' +
      '      "Question 1", ' +
      '      "Question 2", ' +
      '      "Question 3" ' +
      '   ] ' +
      '} ';

  EvolutionAPI1.Token := edtTokenAPI.Text;
  EvolutionAPI1.instanceName := edtInstanceName.Text;
  sResponse := EvolutionAPI1.SendPoll(ed_num.Text, sPollMessage);

  memResponse.Lines.Add(sResponse);
end;

procedure TfrmPrincipal.btnLocalizacaoClick(Sender: TObject);
var
  sLocation : string;
begin
  if Trim(ed_num.Text) = '' then
  begin
    ShowMessage('INFORM THE DESTINATION WHATSAPP NUMBER');
    ed_num.SetFocus;
    Exit;
  end;

  sLocation :=
      '    "locationMessage": { ' +
      '        "name": "Cristo Rendedor", ' +
      '        "address": "Rio de Janeiro-RJ", ' +
      '        "latitude": 25.3789, ' +
      '        "longitude": -70.4078 ' +
      '    } ';

  EvolutionAPI1.Token := edtTokenAPI.Text;
  EvolutionAPI1.instanceName := edtInstanceName.Text;
  sResponse := EvolutionAPI1.SendLocation(ed_num.Text, mem_message.Text, sLocation, edtHeader.Text, edtFooter.Text);

  memResponse.Lines.Add(sResponse);
end;

procedure TfrmPrincipal.btnReagirClick(Sender: TObject);
var
  sEmoji : string;
begin
  if Trim(ed_num.Text) = '' then
  begin
    ShowMessage('INFORM THE DESTINATION WHATSAPP NUMBER');
    ed_num.SetFocus;
    Exit;
  end;

  if Trim(edtMessage_id.Text) = '' then
  begin
    ShowMessage('INFORM THE "MESSAGE ID" TO BE SENT REACTION');
    edtMessage_id.SetFocus;
    Exit;
  end;

  sEmoji := '\uD83D\uDE00';

  //SendReaction(waid, message_id, emoji: string)
  EvolutionAPI1.Token := edtTokenAPI.Text;
  EvolutionAPI1.instanceName := edtInstanceName.Text;
  sResponse := EvolutionAPI1.SendReaction(ed_num.Text, edtMessage_id.Text, sEmoji, cFromMe.Text);

  memResponse.Lines.Add(sResponse);
end;

procedure TfrmPrincipal.btnResponderClick(Sender: TObject);
begin
  if Trim(ed_num.Text) = '' then
  begin
    ShowMessage('INFORM THE DESTINATION WHATSAPP NUMBER');
    ed_num.SetFocus;
    Exit;
  end;

  if Trim(edtMessage_id.Text) = '' then
  begin
    ShowMessage('INFORM THE "MESSAGE ID" TO BE SENT REACTION');
    edtMessage_id.SetFocus;
    Exit;
  end;

  if Trim(mem_message.Text) = '' then
  begin
    ShowMessage('INFORM THE REPLY BODY MESSAGE TO BE SENT');
    mem_message.SetFocus;
    Exit;
  end;


  //SendReaction(waid, message_id, emoji: string)
  EvolutionAPI1.Token := edtTokenAPI.Text;
  EvolutionAPI1.instanceName := edtInstanceName.Text;
  //function TEvolutionAPI.SendReplies(waid, message_id, reply_body, reply_remoteJid, message_body, fromMe: string; previewurl: string): string;
  sResponse := EvolutionAPI1.SendReplies(ed_num.Text, edtMessage_id.Text, mem_message.Text, edtRemoteJidQuoted.Text, mem_Quoted_message.Text, cFromMe.Text, 'false');

  memResponse.Lines.Add(sResponse);
end;

procedure TfrmPrincipal.btnStickerClick(Sender: TObject);
begin
//

end;

procedure TfrmPrincipal.btnTextoSimplesClick(Sender: TObject);
begin
  if Trim(ed_num.Text) = '' then
  begin
    ShowMessage('INFORM THE DESTINATION WHATSAPP NUMBER');
    ed_num.SetFocus;
    Exit;
  end;

  if Trim(mem_message.Text) = '' then
  begin
    ShowMessage('INFORM THE BODY MESSAGE TO BE SENT');
    mem_message.SetFocus;
    Exit;
  end;

  EvolutionAPI1.Token := edtTokenAPI.Text;
  EvolutionAPI1.instanceName := edtInstanceName.Text;
  sResponse := EvolutionAPI1.SendText(ed_num.Text, mem_message.Text);

  edtMessage_id.Text := sResponse;
  cFromMe.ItemIndex := 0;

  memResponse.Lines.Add(sResponse);
  memResponse.Lines.Add('');

end;

procedure TfrmPrincipal.Button1Click(Sender: TObject);
begin
  if Trim(ed_num.Text) = '' then
  begin
    ShowMessage('INFORM THE DESTINATION WHATSAPP NUMBER');
    ed_num.SetFocus;
    Exit;
  end;

  if Trim(edtMessage_id.Text) = '' then
  begin
    ShowMessage('INFORM THE "MESSAGE ID" TO BE EDIT MESSAGE');
    edtMessage_id.SetFocus;
    Exit;
  end;

  if Trim(mem_message.Text) = '' then
  begin
    ShowMessage('INFORM THE BODY EDIT MESSAGE TO BE UPDATE');
    mem_message.SetFocus;
    Exit;
  end;

  //SendReaction(waid, message_id, emoji: string)
  EvolutionAPI1.Token := edtTokenAPI.Text;
  EvolutionAPI1.instanceName := edtInstanceName.Text;
  sResponse := EvolutionAPI1.editMessage(ed_num.Text, edtMessage_id.Text, cFromMe.Text, ed_num.Text, mem_message.Text);

  memResponse.Lines.Add(sResponse);
end;

procedure TfrmPrincipal.Button2Click(Sender: TObject);
begin
  if Trim(ed_num.Text) = '' then
  begin
    ShowMessage('INFORM THE DESTINATION WHATSAPP NUMBER');
    ed_num.SetFocus;
    Exit;
  end;

  if Trim(edtMessage_id.Text) = '' then
  begin
    ShowMessage('INFORM THE "MESSAGE ID" TO BE SENT REACTION');
    edtMessage_id.SetFocus;
    Exit;
  end;

  //SendReaction(waid, message_id, emoji: string)
  EvolutionAPI1.Token := edtTokenAPI.Text;
  EvolutionAPI1.instanceName := edtInstanceName.Text;
  sResponse := EvolutionAPI1.DeleteMessage(ed_num.Text, edtMessage_id.Text, cFromMe.Text, '');

  memResponse.Lines.Add(sResponse);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  EvolutionAPI1.Port := 8080;
  EvolutionAPI1.PortWebhook := 8020;
  LerConfiguracoes;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  EvolutionAPI1.Token := edtTokenAPI.Text;
  EvolutionAPI1.instanceName := edtInstanceName.Text;
  EvolutionAPI1.DDIDefault := StrToIntDef(edtDDI_Default.Text, 55);
  EvolutionAPI1.Port := StrToIntDef(edtPORT_SERVER.Text, 8080);
  EvolutionAPI1.PortWebhook := StrToIntDef(edtPortWebhook.Text, 8020);
  EvolutionAPI1.StartServer;


end;

function TfrmPrincipal.GerarGUID: string;
var
  Guid: TGUID;
begin
  Guid := TGUID.NewGuid;
  Result := Guid.ToString;
end;

procedure TfrmPrincipal.gravar_log(linha: string);
var
  nomearq, diretorio: string;
  arq: TextFile;
begin
  try
    diretorio := ExtractFilePath(ParamStr(0)) + 'Log\';
    Sleep(1);

    if not DirectoryExists(diretorio) then
      CreateDir(diretorio);

    nomearq := ExtractFilePath(ParamStr(0)) + 'Log' + '\Log' + FormatDateTime('YYYY-MM-DD',now) + '.log';
    //nomearq := 'ServidorMultiAtendimento.log';
    AssignFile(arq, nomearq);
    try
      if FileExists(nomearq) then
        Append(arq)
      else
        Rewrite(arq);

      Writeln(arq, FormatDateTime('DD/MM/YYYY', Date) + ' ' +
        FormatDateTime('HH:MM:SS:ZZ', time) + ' ' + linha);
      Flush(arq);
    finally
      CloseFile(arq);
    end;
  except
  end;

end;

procedure TfrmPrincipal.JsonToDataset(aDataset: TDataSet; aJSON, RootElement: string);
var
  JObj: TJSONArray;
  vConv : TCustomRESTResponseDataSetAdapter;//TCustomJSONDataSetAdapter;
  //vConv : TCustomJSONDataSetAdapter;
begin
  if (aJSON = EmptyStr) then
  begin
    Exit;
  end;

  JObj := TJSONObject.ParseJSONValue(aJSON) as TJSONArray;
  //vConv := TCustomJSONDataSetAdapter.Create(Nil);
  vConv := TCustomRESTResponseDataSetAdapter.Create(Nil);

  try
    vConv.Dataset := aDataset;
    if trim(RootElement) <> '' then
    begin
      vConv.RootElement := RootElement;
      vConv.NestedElements := True;
    end;

    vConv.UpdateDataSet(JObj);

    vConv.RootElement := RootElement;
  finally
    vConv.Free;
    JObj.Free;
  end;
end;

procedure TfrmPrincipal.LerConfiguracoes;
var
  NomeArquivo: string;
  ArquivoConfig: TCustomIniFile;
begin
  NomeArquivo := TPath.Combine(ExtractFilePath(ParamStr(0)), 'EvolutionAPI.ini ');
  ArquivoConfig := TMemIniFile.Create(NomeArquivo);

  edtTokenAPI.Text := ArquivoConfig.ReadString('CONFIGURACAO', 'TokenAPI', '');
  edtTokenAPIGeral.Text := ArquivoConfig.ReadString('CONFIGURACAO', 'TokenAPIGeral', 'B6D711FCDE4D4FD5936544120E713976');
  edtInstanceName.Text := ArquivoConfig.ReadString('CONFIGURACAO', 'InstanceName', '');
  edtPORT_SERVER.Text := ArquivoConfig.ReadString('CONFIGURACAO', 'PORT_SERVER', '8080');
  edtPortWebhook.Text := ArquivoConfig.ReadString('CONFIGURACAO', 'PORT_Webhook', '8020');
  edtDDI_Default.Text := ArquivoConfig.ReadString('CONFIGURACAO', 'DDI_Default', '55');
  edtNumberWhatsApp.Text := ArquivoConfig.ReadString('CONFIGURACAO', 'NumberWhatsApp', '');
  edtURLWebhook.Text :=  ArquivoConfig.ReadString('CONFIGURACAO', 'URLWebhook', 'http://localhost:3000/webhook');
  edtEventsSubscribe.Text := ArquivoConfig.ReadString('CONFIGURACAO', 'EventsSubscribe', '"QRCODE_UPDATED", "MESSAGES_UPSERT", "MESSAGES_UPDATE", "SEND_MESSAGE", "CONNECTION_UPDATE"');

  ArquivoConfig.UpdateFile;

  FreeAndNil(ArquivoConfig);

end;

procedure TfrmPrincipal.ProcessQRCodeImage;
begin

end;

procedure TfrmPrincipal.SalvarIni;
var
  NomeArquivo: string;
  ArquivoConfig: TCustomIniFile;
begin
  NomeArquivo := TPath.Combine(ExtractFilePath(ParamStr(0)), 'EvolutionAPI.ini ');
  ArquivoConfig := TMemIniFile.Create(NomeArquivo);

  ArquivoConfig.writeString('CONFIGURACAO', 'UrlServerEvolutionAPI', edtUrlServerEvolutionAPI.Text);
  ArquivoConfig.writeString('CONFIGURACAO', 'TokenAPI', edtTokenAPI.Text);
  ArquivoConfig.writeString('CONFIGURACAO', 'TokenAPIGeral', edtTokenAPIGeral.Text);
  ArquivoConfig.writeString('CONFIGURACAO', 'InstanceName', edtInstanceName.Text);
  ArquivoConfig.writeString('CONFIGURACAO', 'PORT_SERVER', edtPORT_SERVER.Text);
  ArquivoConfig.writeString('CONFIGURACAO', 'PORT_Webhook', edtPortWebhook.Text);
  ArquivoConfig.writeString('CONFIGURACAO', 'DDI_Default', edtDDI_Default.Text);
  ArquivoConfig.writeString('CONFIGURACAO', 'NumberWhatsApp', edtNumberWhatsApp.Text);
  ArquivoConfig.writeString('CONFIGURACAO', 'URLWebhook', edtURLWebhook.Text);
  ArquivoConfig.writeString('CONFIGURACAO', 'EventsSubscribe', edtEventsSubscribe.Text);

  ArquivoConfig.UpdateFile;

  FreeAndNil(ArquivoConfig);

  LerConfiguracoes;
end;

procedure TfrmPrincipal.TimerInicioTimer(Sender: TObject);
begin
  TimerInicio.Enabled := False;

  frmPrincipal.bFetchInstancesClick(Self);

end;

function TfrmPrincipal.BooleanToStr(Operador: Boolean): String;
begin
  if Operador then
    result := 'True'
  else
    result := 'False';
end;

procedure TfrmPrincipal.EvolutionAPI1Response(Sender: TObject; Response: string);
var
  Result: uEventsMessageClasses.TResultEventClass;
  url, mimetype, mediaKey, filename: string;
  anexoCriptografado, anexo, extensao, remoteJid, sType, anexo_renomeado, caption: string;

var
  ChatId, IdMensagem, S_Type, Body, S_Caption, fromId, phone_number_id, profile_name,
    clienturl,  wlo_NomeArquivo,
    SelectButtonId, SelectRowId, idMensagemOrigem, description,
    Title, Footer, quotedMsg_body, quotedMsg_caption, S_Type_origem, status, recipient_id : string;
    sDataEnv, sDataRec, reaction_emoji, reaction_message_id, wlo_ack, wlo_status,
    error_Message, error_Code, error_title, error_data_details, instanceName, event,
    sSender, FromMe, latitude, longitude, localidade, base64localidade : string;
    auxData: Int64;
  eh_arquivo : Boolean;
begin

  memResponse.Lines.Add('MESSAGES_UPSERT');
  memResponse.Lines.Add('' + Response + #13#10);

  try
    Result := TResultEventClass.FromJsonString(Response);

    memResponse.Lines.Add('instance: ' + Result.instance);
    memResponse.Lines.Add('event: ' + Result.event);
    memResponse.Lines.Add('sender: ' + Result.sender);

    instanceName := Result.instance;
    event := Result.event;
    fromId := Result.sender;

    if Assigned(Result.data) then
    begin
      memResponse.Lines.Add('pushName: ' + Result.data.pushName);
      profile_name := Result.data.pushName;
    end;

    if Assigned(Result.data.key) then
    begin
      edtMessage_id.Text := Result.data.key.id;
      FromMe := BooleanToStr(Result.data.key.fromMe);

      phone_number_id := Result.data.key.remoteJid;
      IdMensagem := Result.data.key.id;

      if Result.data.key.fromMe then
        cFromMe.ItemIndex := 0 else
        cFromMe.ItemIndex := 1;

      remoteJid := Result.data.key.remoteJid;
      ChatId := Result.data.key.remoteJid;

      memResponse.Lines.Add('remoteJid: ' + Result.data.key.remoteJid);
      memResponse.Lines.Add('fromMe: ' + BooleanToStr(Result.data.key.fromMe));
      memResponse.Lines.Add('id: ' + Result.data.key.id);
    end;

    if Assigned(Result.data.message) then
    begin
      memResponse.Lines.Add('conversation: ' + Result.data.message.conversation);

      sType := Result.data.messageType;

      Body := Result.data.message.conversation;

      if Assigned(Result.data.message.extendedTextMessage) then
      begin
        if Assigned(Result.data.message.extendedTextMessage.contextInfo) then
        begin
          if Result.data.message.extendedTextMessage.contextInfo.stanzaId <> '' then
          begin
            idMensagemOrigem := Result.data.message.extendedTextMessage.contextInfo.stanzaId;
            memResponse.Lines.Add('idMensagemOrigem: ' + idMensagemOrigem);
          end;

          if Assigned(Result.data.message.extendedTextMessage.contextInfo.QuotedMessage) then
          begin
            if Result.data.message.extendedTextMessage.contextInfo.QuotedMessage.Conversation <> '' then
            begin
              quotedMsg_body := Result.data.message.extendedTextMessage.contextInfo.QuotedMessage.Conversation;
              S_Type_origem := 'extendedTextMessage';
              memResponse.Lines.Add('quotedMsg_body: ' + quotedMsg_body);
            end;

          end;
        end;

        if Result.data.message.extendedTextMessage.text <> '' then
          Body := Result.data.message.extendedTextMessage.text;
      end;

      //Contact
      if Assigned(Result.data.message.contactMessage) then
      begin
        if Result.data.message.contactMessage.vcard <> '' then
        begin
          Body := Result.data.message.contactMessage.vcard;
          memResponse.Lines.Add('vcard: ' + Result.data.message.contactMessage.vcard);
          memResponse.Lines.Add('displayName: ' + Result.data.message.contactMessage.displayName);
          //memResponse.Lines.Add('displayName: ' + Result.data.message.contactMessage.displayName);
        end;
      end;

      //Localidade
      if Assigned(Result.data.message.locationMessage) then
      begin
        if Result.data.message.locationMessage.degreesLatitude > 0 then
        begin
          latitude := FloatToStr(Result.data.message.locationMessage.degreesLatitude);
          longitude := FloatToStr(Result.data.message.locationMessage.degreesLongitude);
          localidade := Result.data.message.locationMessage.name + ' ' + Result.data.message.locationMessage.address;
          base64localidade := Result.data.message.locationMessage.jpegThumbnail;
        end;
      end;

      //reactionMessage
      if Assigned(Result.data.message.reactionMessage) then
      begin
        if Result.data.message.reactionMessage.text <> '' then
        begin
          reaction_emoji := Result.data.message.reactionMessage.text;
          memResponse.Lines.Add('reaction_emoji: ' + reaction_emoji);
          Exit;
        end;
      end;

      //editedMessage
      if Assigned(Result.data.message.editedMessage) then
      begin
        if Assigned(Result.data.message.editedMessage.message) then
          if Assigned(Result.data.message.editedMessage.message.protocolMessage) then
            if Assigned(Result.data.message.editedMessage.message.protocolMessage.editedMessage) then
            begin
              if Result.data.message.editedMessage.message.protocolMessage.editedMessage.conversation <> '' then
              begin
                Body := Result.data.message.editedMessage.message.protocolMessage.editedMessage.conversation;
                IdMensagem := Result.data.message.editedMessage.message.protocolMessage.key.id;
                //remoteJid := Result.data.message.editedMessage.message.protocolMessage.key.remoteJid;
                remoteJid := Copy(remoteJid, 1, Pos('@', remoteJid) -1 );

                memResponse.Lines.Add('edited Message: ' + Body);
                memResponse.Lines.Add('remoteJid: ' + remoteJid);
                memResponse.Lines.Add('IdMensagem: ' + IdMensagem);
                Exit;
              end;
            end;
      end;


      if Assigned(Result.data.message.documentMessage)
      and (Result.data.messageType = 'documentMessage') then
      begin
        memResponse.Lines.Add('url: ' + Result.data.message.documentMessage.url);
        memResponse.Lines.Add('mimetype: ' + Result.data.message.documentMessage.mimetype);
        memResponse.Lines.Add('mediaKey: ' + Result.data.message.documentMessage.mediaKey);
        memResponse.Lines.Add('fileName: ' + Result.data.message.documentMessage.fileName);
        memResponse.Lines.Add('caption: ' + Result.data.message.documentMessage.caption);
        url := Result.data.message.documentMessage.url;
        mimetype := Result.data.message.documentMessage.mimetype;
        mediaKey := Result.data.message.documentMessage.mediaKey;
        caption := Result.data.message.documentMessage.caption;
        filename := Result.data.message.documentMessage.filename;
        extensao := ExtractFileExt(filename);

        if DownloadFile(url, mediaKey, mimetype, remoteJid, UpperCase(sType), extensao, anexoCriptografado, anexo) then
        begin
          Descriptografar(mediaKey, anexoCriptografado, anexo, remoteJid);

          if (FileExists(anexo)) and (pos('.txt', anexo) > 0) then
          begin
            anexo_renomeado := StringReplace(anexo, '.txt', '.' + extensao, []);
            memResponse.Lines.Add('Anexo Renomeado: ' + anexo_renomeado + ' ...');

            if not RenameFile(anexo, anexo_renomeado) then
            begin
              memResponse.Lines.Add('Error renaming file!');
              gravar_log('Error renaming file!');
            end
            else
            begin
              anexo := anexo_renomeado;
              memResponse.Lines.Add('Anexo Renomeado: ' + anexo_renomeado + ' OK');
              gravar_log('Anexo Renomeado: ' + anexo_renomeado + ' OK');
            end;
          end;
        end;

      end
      else
      if Assigned(Result.data.message.imageMessage)
      and (Result.data.messageType = 'imageMessage') then
      begin
        memResponse.Lines.Add('url: ' + Result.data.message.imageMessage.url);
        memResponse.Lines.Add('mimetype: ' + Result.data.message.imageMessage.mimetype);
        memResponse.Lines.Add('mediaKey: ' + Result.data.message.imageMessage.mediaKey);
        memResponse.Lines.Add('caption: ' + Result.data.message.imageMessage.caption);
        //memResponse.Lines.Add('fileName: ' + Result.data.message.imageMessage.fileName);
        url := Result.data.message.imageMessage.url;
        mimetype := Result.data.message.imageMessage.mimetype;
        mediaKey := Result.data.message.imageMessage.mediaKey;
        filename := '';//Result.data.message.imageMessage.filename;
        caption := Result.data.message.imageMessage.caption;

        if DownloadFile(url, mediaKey, mimetype, remoteJid, UpperCase(sType), extensao, anexoCriptografado, anexo) then
        begin
          Descriptografar(mediaKey, anexoCriptografado, anexo, remoteJid);
        end;
      end
      else
      if Assigned(Result.data.message.audioMessage)
      and (Result.data.messageType = 'audioMessage') then
      begin
        memResponse.Lines.Add('url: ' + Result.data.message.audioMessage.url);
        memResponse.Lines.Add('mimetype: ' + Result.data.message.audioMessage.mimetype);
        memResponse.Lines.Add('mediaKey: ' + Result.data.message.audioMessage.mediaKey);
        //memResponse.Lines.Add('fileName: ' + Result.data.message.audioMessage.fileName);
        url := Result.data.message.audioMessage.url;
        mimetype := Result.data.message.audioMessage.mimetype;
        mediaKey := Result.data.message.audioMessage.mediaKey;
        filename := '';//Result.data.message.audioMessage.filename;


        if DownloadFile(url, mediaKey, mimetype, remoteJid, UpperCase(sType), extensao, anexoCriptografado, anexo) then
        begin
          Descriptografar(mediaKey, anexoCriptografado, anexo, remoteJid);
        end;
      end
      else
      if Assigned(Result.data.message.videoMessage)
      and (Result.data.messageType = 'videoMessage') then
      begin
        memResponse.Lines.Add('url: ' + Result.data.message.videoMessage.url);
        memResponse.Lines.Add('mimetype: ' + Result.data.message.videoMessage.mimetype);
        memResponse.Lines.Add('mediaKey: ' + Result.data.message.videoMessage.mediaKey);
        memResponse.Lines.Add('caption: ' + Result.data.message.videoMessage.caption);
        //memResponse.Lines.Add('fileName: ' + Result.data.message.videoMessage.fileName);
        url := Result.data.message.videoMessage.url;
        mimetype := Result.data.message.videoMessage.mimetype;
        mediaKey := Result.data.message.videoMessage.mediaKey;
        filename := '';//Result.data.message.videoMessage.filename;
        caption := Result.data.message.videoMessage.caption;

        if DownloadFile(url, mediaKey, mimetype, remoteJid, UpperCase(sType), extensao, anexoCriptografado, anexo) then
        begin
          Descriptografar(mediaKey, anexoCriptografado, anexo, remoteJid);
        end;
      end
      else
      if Assigned(Result.data.message.stickerMessage)
      and (Result.data.messageType = 'stickerMessage') then
      begin
        memResponse.Lines.Add('url: ' + Result.data.message.stickerMessage.url);
        memResponse.Lines.Add('mimetype: ' + Result.data.message.stickerMessage.mimetype);
        memResponse.Lines.Add('mediaKey: ' + Result.data.message.stickerMessage.mediaKey);
        //memResponse.Lines.Add('fileName: ' + Result.data.message.stickerMessage.fileName);
        url := Result.data.message.stickerMessage.url;
        mimetype := Result.data.message.stickerMessage.mimetype;
        mediaKey := Result.data.message.stickerMessage.mediaKey;
        filename := '';//Result.data.message.stickerMessage.filename;

        if DownloadFile(url, mediaKey, mimetype, remoteJid, UpperCase(sType), extensao, anexoCriptografado, anexo) then
        begin
          Descriptografar(mediaKey, anexoCriptografado, anexo, remoteJid);

          if (FileExists(anexo)) and (pos('.jpg', anexo) > 0) and (UpperCase(sType) = 'STICKERMESSAGE') then
          begin
            extensao := '.webp';
            anexo_renomeado := StringReplace(anexo, '.jpg', '.' + extensao, []);
            memResponse.Lines.Add('Anexo Renomeado: ' + anexo_renomeado + ' ...');

            if not RenameFile(anexo, anexo_renomeado) then
            begin
              //GeraLog('RenameFile', 'Error renaming file!');
              memResponse.Lines.Add('Error renaming file!');
            end
            else
            begin
              anexo := anexo_renomeado;
              memResponse.Lines.Add('Anexo Renomeado: ' + anexo_renomeado + ' OK');
            end;
          end;
        end;
      end;

      if Assigned(Result.data.message.messageContextInfo) then
      begin
        //memResponse.Lines.Add('fromMe: ' + BooleanToStr(Result.data.key.fromMe));
        if Assigned(Result.data.message.messageContextInfo.deviceListMetadata) then
        begin
          memResponse.Lines.Add('senderKeyHash: ' + Result.data.message.messageContextInfo.deviceListMetadata.senderKeyHash);
          //memResponse.Lines.Add('senderTimestamp: ' + DateTimeToStr(UnixToDateTime( StrToIntDef(Result.data.message.messageContextInfo.deviceListMetadata.senderTimestamp,0) , False)));
          memResponse.Lines.Add('recipientKeyHash: ' + Result.data.message.messageContextInfo.deviceListMetadata.recipientKeyHash);
          //memResponse.Lines.Add('recipientTimestamp: ' + DateTimeToStr(UnixToDateTime( StrToIntDef(Result.data.message.messageContextInfo.deviceListMetadata.recipientTimestamp,0) , False)));
        end;

        memResponse.Lines.Add('deviceListMetadataVersion: ' + FloatToStr(Result.data.message.messageContextInfo.deviceListMetadataVersion));
      end;
    end;

    if Assigned(Result.data) then
    begin
      memResponse.Lines.Add('messageType: ' + Result.data.messageType);
      memResponse.Lines.Add('messageTimestamp: ' + DateTimeToStr(UnixToDateTime(Result.data.messageTimestamp, False)));
      memResponse.Lines.Add('source: ' + Result.data.source);
    end;

    memResponse.Lines.Add('apikey: ' + Result.apikey);
    memResponse.Lines.Add('date_time: ' + Result.date_time);
    memResponse.Lines.Add('destination: ' + Result.destination);
    memResponse.Lines.Add('');

  except on E: Exception do
    memResponse.Lines.Add('ERROR ' + e.Message);
  end;


  {try
    Result := TResultClass.FromJsonString(Response);
    memResponse.Lines.Add('id: ' + Result.entry[0].id);

    if Assigned(Result.entry[0].changes[0]) then
    begin
      if Assigned(Result.entry[0].changes[0].value) then
      begin
        if Assigned(Result.entry[0].changes[0].value.messages[0]) then
        begin
          memResponse.Lines.Add('Type: ' + Result.entry[0].changes[0].value.messages[0].&type);
          if Assigned(Result.entry[0].changes[0].value.messages[0].button) then
            memResponse.Lines.Add('Text: ' + Result.entry[0].changes[0].value.messages[0].button.Text);

          if Assigned(Result.entry[0].changes[0].value.messages[0].text) then
            memResponse.Lines.Add('Body Text: ' + Result.entry[0].changes[0].value.messages[0].text.body);

          //Response Button
          try
            if Assigned(Result.entry[0].changes[0].value.messages[0].interactive.button_reply) then
            begin
              memResponse.Lines.Add('Texto Botão: ' + Result.entry[0].changes[0].value.messages[0].interactive.button_reply.title);
              memResponse.Lines.Add('ID Botão: ' + Result.entry[0].changes[0].value.messages[0].interactive.button_reply.id);
            end;
          except on E: Exception do
          end;

          //Response List
          try
            if Assigned(Result.entry[0].changes[0].value.messages[0].interactive.list_reply) then
            begin
              memResponse.Lines.Add('Description Lista: ' + Result.entry[0].changes[0].value.messages[0].interactive.list_reply.description);
              memResponse.Lines.Add('ID Lista: ' + Result.entry[0].changes[0].value.messages[0].interactive.list_reply.id);
              memResponse.Lines.Add('Title Lista: ' + Result.entry[0].changes[0].value.messages[0].interactive.list_reply.title);
            end;
          except on E: Exception do
          end;

          if Assigned(Result.entry[0].changes[0].value.messages[0].image) then
          begin
            memResponse.Lines.Add('Image id: ' + Result.entry[0].changes[0].value.messages[0].image.id);
            memResponse.Lines.Add('Image MimeType: ' + Result.entry[0].changes[0].value.messages[0].image.mime_type);

            sResponse := EvolutionAPI1.DownloadMedia(Result.entry[0].changes[0].value.messages[0].image.id, Result.entry[0].changes[0].value.messages[0].image.mime_type);
            memResponse.Lines.Add('url: ' + sResponse);
          end;

          if Assigned(Result.entry[0].changes[0].value.messages[0].context) then
          begin
            memResponse.Lines.Add('id mensagem Origem: ' + Result.entry[0].changes[0].value.messages[0].context.id);
            //memResponse.Lines.Add('From mensagem Origem: ' + Result.entry[0].changes[0].value.messages[0].context.From);
          end;

        end;
      end;
    end;

  except on E: Exception do
  end;
  }

end;

procedure TfrmPrincipal.EvolutionAPI1ResponseCallUpdate(Sender: TObject; Response: string);
begin
  memResponse.Lines.Add('CALL_UPDATE');
  memResponse.Lines.Add('' + Response + #13#10);
end;

procedure TfrmPrincipal.EvolutionAPI1ResponseCHATS_DELETE(Sender: TObject; Response: string);
begin
  memResponse.Lines.Add('CHATS_DELETE');
  memResponse.Lines.Add('' + Response + #13#10);
end;

procedure TfrmPrincipal.EvolutionAPI1ResponseCHATS_SET(Sender: TObject; Response: string);
begin
  memResponse.Lines.Add('CHATS_SET');
  memResponse.Lines.Add('' + Response + #13#10);
end;

procedure TfrmPrincipal.EvolutionAPI1ResponseCHATS_UPDATE(Sender: TObject; Response: string);
begin
  memResponse.Lines.Add('CHATS_UPDATE');
  memResponse.Lines.Add('' + Response + #13#10);
end;

procedure TfrmPrincipal.EvolutionAPI1ResponseCHATS_UPSERT(Sender: TObject; Response: string);
begin
  memResponse.Lines.Add('CHATS_UPSERT');
  memResponse.Lines.Add('' + Response + #13#10);
end;

procedure TfrmPrincipal.EvolutionAPI1ResponseConnectionUpdate(Sender: TObject; Response: string);
var
  Result: uConnectionUpdateClass.TResponseClass;
begin
  memResponse.Lines.Add('CONNECTION_UPDATE');
  memResponse.Lines.Add('' + Response + #13#10);
  try
    try
      Result := uConnectionUpdateClass.TResponseClass.FromJsonString(Response);

      memResponse.Lines.Add('instance: ' + Result.instance);

      if Assigned(Result.data) then
      begin
        memResponse.Lines.Add('state: ' + Result.data.state);
        memResponse.Lines.Add('statusReason: ' + FloatToStr(Result.data.statusReason));

        edtInstanceName.Text := Result.data.instance;
        edtTokenAPI.Text := Result.apikey;
        edtNumberWhatsApp.Text := Copy(Result.sender, 1, pos('@', Result.sender)-1);

        if Result.data.statusReason = 200 then
        begin
          whatsOn.Visible := True;
          whatsOff.Visible := False;
          StatusBar1.Panels[1].Text := 'Online';
          bFetchInstancesClick(Self);
        end
        else
        if Result.data.statusReason = 401 then
        begin
          whatsOn.Visible := False;
          whatsOff.Visible := True;
          StatusBar1.Panels[1].Text := 'Offline';
          bFetchInstancesClick(Self);
        end
        else
        begin
          //bFetchInstancesClick(Self);
        end;
      end;

      memResponse.Lines.Add('sender: ' + Result.sender);
      memResponse.Lines.Add('server_url: ' + Result.server_url);
      memResponse.Lines.Add('apikey: ' + Result.apikey + #13#10);

    except on E: Exception do
      Exit;
    end;

  finally
    Result.Free
  end;
end;

procedure TfrmPrincipal.EvolutionAPI1ResponseCONTACTS_SET(Sender: TObject; Response: string);
begin
  memResponse.Lines.Add('CONTACTS_SET');
  memResponse.Lines.Add('' + Response + #13#10);
end;

procedure TfrmPrincipal.EvolutionAPI1ResponseCONTACTS_UPDATE(Sender: TObject; Response: string);
begin
  memResponse.Lines.Add('CONTACTS_UPDATE');
  memResponse.Lines.Add('' + Response + #13#10);
end;

procedure TfrmPrincipal.EvolutionAPI1ResponseCONTACTS_UPSERT(Sender: TObject; Response: string);
begin
  memResponse.Lines.Add('CONTACTS_UPSERT');
  memResponse.Lines.Add('' + Response + #13#10);
end;

procedure TfrmPrincipal.EvolutionAPI1ResponseGROUPS_SET(Sender: TObject; Response: string);
begin
  memResponse.Lines.Add('GROUPS_SET');
  memResponse.Lines.Add('' + Response + #13#10);
end;

procedure TfrmPrincipal.EvolutionAPI1ResponseGROUPS_UPSERT(Sender: TObject; Response: string);
begin
  memResponse.Lines.Add('GROUPS_UPSERT');
  memResponse.Lines.Add('' + Response + #13#10);
end;

procedure TfrmPrincipal.EvolutionAPI1ResponseGROUP_PARTICIPANTS_UPDATE(Sender: TObject; Response: string);
begin
  memResponse.Lines.Add('GROUP_PARTICIPANTS_UPDATE');
  memResponse.Lines.Add('' + Response + #13#10);
end;

procedure TfrmPrincipal.EvolutionAPI1ResponseGROUP_UPDATE(Sender: TObject; Response: string);
begin
  memResponse.Lines.Add('GROUP_UPDATE');
  memResponse.Lines.Add('' + Response + #13#10);
end;

procedure TfrmPrincipal.EvolutionAPI1ResponseMESSAGES_SET(Sender: TObject; Response: string);
begin
  memResponse.Lines.Add('MESSAGES_SET');
  memResponse.Lines.Add('' + Response + #13#10);
end;

procedure TfrmPrincipal.EvolutionAPI1ResponseMessageUpdate(Sender: TObject; Response: string);
var
  Result: uEventsMessageUpdateClasses.TResultEventMessageUpdateClass;
  m, e: integer;
begin
  memResponse.Lines.Add('MESSAGES_UPDATE');

  memResponse.Lines.Add('' + Response + #13#10);

  try
    Result := TResultEventMessageUpdateClass.FromJsonString(Response);

    memResponse.Lines.Add('instance: ' + Result.instance);
    memResponse.Lines.Add('event: ' + Result.event);
    memResponse.Lines.Add('sender: ' + Result.sender);

    if Assigned(Result.data) then
    begin
      memResponse.Lines.Add('remoteJid: ' + Result.data.remoteJid);
      memResponse.Lines.Add('datetime: ' + DateTimeToStr(UnixToDateTime(Result.data.datetime, False)));
      memResponse.Lines.Add('fromMe: ' + BooleanToStr(Result.data.fromMe) );
      memResponse.Lines.Add('id: ' + Result.data.id);
      memResponse.Lines.Add('status: ' + Result.data.status);
      memResponse.Lines.Add('owner: ' + Result.data.owner);

      //Votes
      if Assigned(Result.data.pollUpdates) then
      begin
        for m := 0 to Length(Result.data.pollUpdates) -1 do
        begin
          try
            memResponse.Lines.add('pollUpdates.name: ' + AnsiUpperCase(Result.data.pollUpdates[m].name));
            for e := 0 to Length(Result.data.pollUpdates[m].voters) -1 do
              memResponse.Lines.add('pollUpdates.voters: ' + Result.data.pollUpdates[m].voters[e]);
          except on E: Exception do
          end;
        end;
      end;
    end;

    memResponse.Lines.Add('apikey: ' + Result.apikey);
    memResponse.Lines.Add('date_time: ' + Result.date_time);
    memResponse.Lines.Add('destination: ' + Result.destination);
    memResponse.Lines.Add('server_url: ' + Result.server_url);
    memResponse.Lines.Add('');

  except on E: Exception do
    memResponse.Lines.Add('ERROR ' + e.Message);
  end;

end;

procedure TfrmPrincipal.EvolutionAPI1ResponsePRESENCE_UPDATE(Sender: TObject; Response: string);
begin
  memResponse.Lines.Add('PRESENCE_UPDATE');
  memResponse.Lines.Add('' + Response + #13#10);
end;

procedure TfrmPrincipal.EvolutionAPI1ResponseQrcodeUpdate(Sender: TObject; Response: string);
var
  Result: uQrcodeUpdateClass.TResponseQrCodeClass;
begin
  memResponse.Lines.Add('QRCODE_UPDATE');
  memResponse.Lines.Add('' + Response + #13#10);
  try
    try
      Result := uQrcodeUpdateClass.TResponseQrCodeClass.FromJsonString(Response);

      memResponse.Lines.Add('instance: ' + Result.instance);

      if Assigned(Result.data) then
      begin
        if Assigned(Result.data.qrcode) then
        begin
          memResponse.Lines.Add('code: ' + Result.data.qrcode.code);
          memResponse.Lines.Add('bse64: ' + Result.data.qrcode.base64);

          CarregarImagemBase64(Result.data.qrcode.base64, Image3);

          edtInstanceName.Text := Result.data.qrcode.instance;
          edtTokenAPI.Text := Result.apikey;
        end;
      end;

      memResponse.Lines.Add('sender: ' + Result.sender);
      memResponse.Lines.Add('server_url: ' + Result.server_url);
      memResponse.Lines.Add('apikey: ' + Result.apikey + #13#10);

    except on E: Exception do
      Exit;
    end;

  finally
    Result.Free
  end;

end;

procedure TfrmPrincipal.EvolutionAPI1ResponseSEND_MESSAGE(Sender: TObject; Response: string);
begin
  memResponse.Lines.Add('SEND_MESSAGE webhook');
  memResponse.Lines.Add('' + Response + #13#10);
end;

procedure TfrmPrincipal.EvolutionAPI1RetSendMessage(Sender: TObject; Response: string);
begin
  memResponse.Lines.Add('SEND_MESSAGE');
  memResponse.Lines.Add(Response);
end;

procedure TfrmPrincipal.CarregarImagemBase64(const Base64Str: string; const Image: TImage);
var
  LInput: TMemoryStream;
  LOutput: TMemoryStream;
  AStr: TStringList;

  {Stream: TMemoryStream;
  Decoder: TBase64Encoding;}
  Base64StrAux: string;
begin
  //Stream := TMemoryStream.Create;
  //Decoder := TBase64Encoding.Create;

  LInput := TMemoryStream.Create;
  LOutput := TMemoryStream.Create;
  try
    try
      //remover data:image/png;base64,
      Base64StrAux := StringReplace(Base64Str, 'data:image/png;base64,', '', []);
      AStr := TStringList.Create;

      AStr.Add(Base64StrAux);
      AStr.SaveToStream(LInput);
      LInput.Position := 0;
      TNetEncoding.Base64.Decode(LInput, LOutput);
      LOutput.Position := 0;

      // Decodifica a string Base64 para um array de bytes
      {Stream.WriteBuffer(Decoder.DecodeStringToBytes(Base64StrAux), Length(Base64StrAux) div 2);
      // Posiciona o ponteiro do fluxo no início
      Stream.Position := 0;
      // Carrega o fluxo de memória no componente TImage}
      //Image.Picture.Bitmap.LoadFromStream(Stream);
      LOutput.SaveToFile(ExtractFilePath(ParamStr(0)) + '\QrCode.png');
      Image.Picture.LoadFromStream(LOutput);
    except
      on E: Exception do
        ShowMessage('Erro ao carregar imagem: ' + E.Message);
    end;
  finally
    //Stream.Free;
    //Decoder.Free;
    AStr.Free;
    LInput.Free;
    LOutput.Free;
  end;
end;

function TfrmPrincipal.Descriptografar(mediakey, CaminhoArqOriginal, CaminhoArqDescriptogrado, Telefone: string): Boolean;
var
  Args: TArgArray;
  Err: PAnsiChar;
  Res: Integer;
begin
  Result := False;

  // DLL deve estar na mesma pasta do executável

  { Task := TTask.Create(
    Procedure
    begin }

  ProgressBar1.Position := 0;
  // InitModule(xxxxxxx);  // Seu número de série
  try
    // InitModule(18352850); // Seu número de série
    //18352437
    InitModule(18352456);

    gravar_log('frmPrincipal.Descriptografar( ' + mediakey + ', ' + CaminhoArqOriginal + ', ' +
      CaminhoArqDescriptogrado + ', ' + Telefone + ' )');

    // passe somente os argumentos indicados
    Args.Arg0 := NewArg('');
    Args.Arg1 := NewArg('--key');
    Args.Arg2 := NewArg(mediakey); // Media Key <<<<<<<
    Args.Arg3 := NewArg('--out');
    Args.Arg4 := NewArg(CaminhoArqDescriptogrado); // Arquivo de Saída
    // arquivo de saida <<<<<<
    Args.Arg5 := NewArg('--in');
    Args.Arg6 := NewArg(CaminhoArqOriginal); // Arquivo de Entrada  <<<<<
    Args.Arg7 := NewArg('');
    Args.Arg8 := NewArg('');

    Err := nil;
    Res := Decrypt(AutoFileType, @Args, @Callback, Err);

    FreeMem(Args.Arg0);
    FreeMem(Args.Arg1);
    FreeMem(Args.Arg2);
    FreeMem(Args.Arg3);
    FreeMem(Args.Arg4);
    FreeMem(Args.Arg5);
    FreeMem(Args.Arg6);
    FreeMem(Args.Arg7);
    FreeMem(Args.Arg8);

    if (Res = ERROR_SUCCESS) then
    begin
      memResponse.Lines.Add('Decriptação finalizada');
      gravar_log('Decriptação finalizada');
      ProgressBar1.Position := 0;
      Result := True;
      // MessageBox(frmPrincipal.Handle, 'Decriptação finalizada.', 'Done', MB_ICONINFORMATION)
    end
    else
    begin
      gravar_log('Decriptação falhou ' + PChar(WideString(Err)));
      memResponse.Lines.Add('Decriptação falhou ' + PChar(WideString(Err)));
      ProgressBar1.Position := 0;
      Result := False;
      // MessageBox(frmPrincipal.Handle, PChar(WideString(Err)), 'Erro!', MB_ICONERROR);
    end;

  except
    on E: Exception do
      gravar_log('ERRO Descriptografar ' + E.Message);
  end;

  { end);

    Task.Start; }

end;

function TfrmPrincipal.DownloadFile(url, mediakey, mimetype, Telefone, TipoArq, Extensao: string; var AFileName, AFileNameFinal: string): Boolean;
var
  IdHTTP1: TIdHTTP;
  Stream: TMemoryStream;
  FileName, FileNameFinal, AuxEntensao: string;
  diretorio, imagem, arq : string;
  Tentativas: Integer;
  ErroBaixarArquivo : Boolean;
begin
  Result := false;

  // Url := 'https://mmg.whatsapp.net/d/f/At9EfaNcUPVY_LvjD2ZQf2GyvypGHKORyinezQ8GdxvL.enc';
  // Filename := 'At9EfaNcUPVY_LvjD2ZQf2GyvypGHKORyinezQ8GdxvL.jpg';

  gravar_log('DownloadFile(' + url + ', ' + mediakey + ', ' + mimetype + ', ' + Telefone + ', ' + TipoArq + ', ' + Extensao + ')');

  diretorio := ExtractFilePath(ParamStr(0)) + 'temp\';
  Sleep(1);

  if not DirectoryExists(diretorio) then
    CreateDir(diretorio);

  arq     :=  GerarGUID;
  imagem  :=  diretorio + arq;
  Sleep(1);

  case AnsiIndexStr(UpperCase(TipoArq), ['AUDIOMESSAGE', 'IMAGEMESSAGE', 'VIDEOMESSAGE', 'AUDIOMESSAGE', 'DOCUMENTMESSAGE', 'STICKERMESSAGE']) of
    0:
      begin
        FileName := imagem + '.enc';
        FileNameFinal := imagem + '.mp3';
      end;
    1:
      begin
        if mimetype = 'image/gif' then
        begin
          FileName := imagem + '.enc';
          FileNameFinal := imagem + '.mp4';
        end
        else
        begin
          FileName := imagem + '.enc';
          FileNameFinal := imagem + '.jpg';
        end;
      end;
    2:
      begin
        if mimetype = 'image/gif' then
        begin
          FileName := imagem + '.enc';
          FileNameFinal := imagem + '.mp4';
        end
        else
        begin
          FileName := imagem + '.enc';
          FileNameFinal := imagem + '.mp4';
        end;
      end;
    3:
      begin
        FileName := imagem + '.enc';
        FileNameFinal := imagem + '.mp3';
      end;
    4:
      begin
        FileName := imagem + '.enc';
        FileNameFinal := imagem + '.txt';
      end;
    5:
      begin
        FileName := imagem + '.enc';
        FileNameFinal := imagem + '.jpg';
      end
      else
      begin
        FileName := imagem + '.enc';
        FileNameFinal := imagem + '.txt';
      end;
  end;

  AFileName := FileName;
  AFileNameFinal := FileNameFinal;

  //if cExibeLog.Checked then
  begin
    memResponse.Lines.Add('FileName: ' + FileName);
    memResponse.Lines.Add('FileNameFinal: ' + FileNameFinal);
  end;

  gravar_log('FileName: ' + FileName);
  gravar_log('FileNameFinal: ' + FileNameFinal);

  Tentativas := 0;

  while Tentativas < 10 do
  begin
    IdHTTP1 := TIdHTTP.Create(self);
    //IdHTTP1.OnWork := IdHTTPWork;
    //IdHTTP1.OnWorkbegin := IdHTTPWorkbegin;

    Stream := TMemoryStream.Create;
    try
      try
        IdHTTP1.Get(url, Stream);
        Stream.SaveToFile(FileName);

        //Descriptografar(mediakey, FileName, FileNameFinal, Telefone);
        ErroBaixarArquivo := False;
        Result := True;
        Break;

      except
        on E: Exception do
        begin
          ErroBaixarArquivo := True;
          Result := False;
          gravar_log('Falhou o DownloadFile Tentativas(' + IntToStr(Tentativas) + ')' + #13#10 + ' MSG. ORIGINAL: ' + e.Message);
        end;
      end;

    finally
      Stream.DisposeOf;
      IdHTTP1.DisposeOf;
    end;

    Sleep(500);
    Inc(Tentativas);
  end;


  { end);

    Task.Start; }

end;

{procedure TfrmPrincipal.CarregarImagemBase64(const Base64Str: string; const Image: TImage);
const
  MaxLineLength = 76; // Tamanho máximo de linha para quebrar a string Base64
var
  Stream: TMemoryStream;
  Decoder: TBase64Encoding;
  Base64List: TStringList;
  Base64Part: string;
begin
  Stream := TMemoryStream.Create;
  Decoder := TBase64Encoding.Create;
  Base64List := TStringList.Create;
  try
    try
      // Divida a string Base64 em partes para evitar estouro de memória
      while Length(Base64Str) > MaxLineLength do
      begin
        Base64Part := Copy(Base64Str, 1, MaxLineLength);
        Base64List.Add(Base64Part);
        Delete(Base64Str, 1, MaxLineLength);
      end;
      if Length(Base64Str) > 0 then
        Base64List.Add(Base64Str);

      // Decodifica cada parte e escreve no fluxo de memória
      for Base64Part in Base64List do
        Stream.WriteBuffer(Decoder.DecodeStringToBytes(Base64Part)^, Length(Base64Part) div 2);

      // Posiciona o ponteiro do fluxo no início
      Stream.Position := 0;

      // Carrega o fluxo de memória no componente TImage
      Image.Picture.Bitmap.LoadFromStream(Stream);
    except
      on E: Exception do
        ShowMessage('Erro ao carregar imagem: ' + E.Message);
    end;
  finally
    Stream.Free;
    Decoder.Free;
    Base64List.Free;
  end;
end;}




end.
