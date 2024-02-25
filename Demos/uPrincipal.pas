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
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, System.ImageList, Vcl.ImgList, uWPPCloudAPI,
  uWhatsAppBusinessClasses, IniFiles, System.IOUtils, Vcl.Buttons, Vcl.Imaging.pngimage, System.NetEncoding, DateUtils,
  uEvolutionAPI, uEventsMessageClasses, uEventsMessageUpdateClasses;

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
    btnImagemBotao: TButton;
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
    Label3: TLabel;
    memResponse: TMemo;
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
    Label8: TLabel;
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

  private
    procedure CarregarImagemBase64(const Base64Str: string; const Image: TImage);
    procedure ProcessQRCodeImage;
    function BooleanToStr(Operador: Boolean): String;
    { Private declarations }
  public
    { Public declarations }
    sResponse: string;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses uRetMensagem;

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

  //SendReaction(waid, message_id, emoji: string)
  EvolutionAPI1.Token := edtTokenAPI.Text;
  EvolutionAPI1.instanceName := edtInstanceName.Text;
  sResponse := EvolutionAPI1.MarkIsRead(ed_num.Text, edtMessage_id.Text, 'false');

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

  EvolutionAPI1.urlServer := 'http://localhost';
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

  if mem_message.Text = '' then
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
      '  "sections": [  ' +
      '    {   ' +
      '      "title": "SECTION_1_TITLE", ' +
      '      "rows": [ ' +
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
      '    }, ' +
      '    { ' +
      '      "title": "SECTION_2_TITLE",  ' +
      '      "rows": [  ' +
      '        {  ' +
      '          "id": "SECTION_2_ROW_1_ID", ' +
      '          "title": "SECTION_2_ROW_1_TITLE", ' +
      '          "description": "SECTION_2_ROW_1_DESCRIPTION" ' +
      '        }, ' +
      '        {  ' +
      '          "id": "SECTION_2_ROW_2_ID", ' +
      '          "title": "SECTION_2_ROW_2_TITLE", ' +
      '          "description": "SECTION_2_ROW_2_DESCRIPTION"  ' +
      '        } ' +
      '      ] ' +
      '     } ' +
      '    ] ';



  EvolutionAPI1.Token := edtTokenAPI.Text;
  EvolutionAPI1.instanceName := edtInstanceName.Text;
  sResponse := EvolutionAPI1.SendListMenu(ed_num.Text, mem_message.Text, sSections, edtHeader.Text, edtFooter.Text, edtButtonText.Text);

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
  sResponse := EvolutionAPI1.SendReaction(ed_num.Text, edtMessage_id.Text, sEmoji);

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
  sResponse := EvolutionAPI1.SendReplies(ed_num.Text, edtMessage_id.Text, mem_message.Text, edtRemoteJidQuoted.Text, mem_Quoted_message.Text, 'true', 'false');

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

  memResponse.Lines.Add(sResponse);
  memResponse.Lines.Add('');

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

procedure TfrmPrincipal.LerConfiguracoes;
var
  NomeArquivo: string;
  ArquivoConfig: TCustomIniFile;
begin
  NomeArquivo := TPath.Combine(ExtractFilePath(ParamStr(0)), 'EvolutionAPI.ini ');
  ArquivoConfig := TMemIniFile.Create(NomeArquivo);

  edtTokenAPI.Text := ArquivoConfig.ReadString('CONFIGURACAO', 'TokenAPI', '');
  edtInstanceName.Text := ArquivoConfig.ReadString('CONFIGURACAO', 'InstanceName', '');
  edtPORT_SERVER.Text := ArquivoConfig.ReadString('CONFIGURACAO', 'PORT_SERVER', '8080');
  edtPortWebhook.Text := ArquivoConfig.ReadString('CONFIGURACAO', 'PORT_Webhook', '8020');
  edtDDI_Default.Text := ArquivoConfig.ReadString('CONFIGURACAO', 'DDI_Default', '55');
  edtNumberWhatsApp.Text := ArquivoConfig.ReadString('CONFIGURACAO', 'NumberWhatsApp', '');

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
  ArquivoConfig.writeString('CONFIGURACAO', 'InstanceName', edtInstanceName.Text);
  ArquivoConfig.writeString('CONFIGURACAO', 'PORT_SERVER', edtPORT_SERVER.Text);
  ArquivoConfig.writeString('CONFIGURACAO', 'PORT_Webhook', edtPortWebhook.Text);
  ArquivoConfig.writeString('CONFIGURACAO', 'DDI_Default', edtDDI_Default.Text);
  ArquivoConfig.writeString('CONFIGURACAO', 'NumberWhatsApp', edtNumberWhatsApp.Text);

  ArquivoConfig.UpdateFile;

  FreeAndNil(ArquivoConfig);

  LerConfiguracoes;
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
begin

  memResponse.Lines.Add('' + Response + #13#10);

  try
    Result := TResultEventClass.FromJsonString(Response);

    memResponse.Lines.Add('instance: ' + Result.instance);
    memResponse.Lines.Add('event: ' + Result.event);
    memResponse.Lines.Add('sender: ' + Result.sender);

    if Assigned(Result.data) then
    begin
      memResponse.Lines.Add('pushName: ' + Result.data.pushName);
    end;

    if Assigned(Result.data.key) then
    begin
      memResponse.Lines.Add('remoteJid: ' + Result.data.key.remoteJid);
      memResponse.Lines.Add('fromMe: ' + BooleanToStr(Result.data.key.fromMe));
      memResponse.Lines.Add('id: ' + Result.data.key.id);
    end;

    if Assigned(Result.data.message) then
    begin
      memResponse.Lines.Add('conversation: ' + Result.data.message.conversation);

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

procedure TfrmPrincipal.EvolutionAPI1ResponseMessageUpdate(Sender: TObject; Response: string);
var
  Result: uEventsMessageUpdateClasses.TResultEventMessageUpdateClass;
begin

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

procedure TfrmPrincipal.EvolutionAPI1RetSendMessage(Sender: TObject; Response: string);
begin
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
