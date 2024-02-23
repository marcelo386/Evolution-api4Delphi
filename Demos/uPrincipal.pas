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
  uWhatsAppBusinessClasses, IniFiles, System.IOUtils, Vcl.Buttons, Vcl.Imaging.pngimage, System.NetEncoding, uEvolutionAPI;

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
    edtPHONE_NUMBER_ID: TEdit;
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

  private
    procedure CarregarImagemBase64(const Base64Str: string; const Image: TImage);
    procedure ProcessQRCodeImage;
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

  if Trim(edtPHONE_NUMBER_ID.Text) = '' then
  begin
    ShowMessage('INFORM THE "INSTANCE NAME " ');
    edtPHONE_NUMBER_ID.SetFocus;
    Exit;
  end;


  EvolutionAPI1.urlServer := 'http://localhost';
  EvolutionAPI1.Token := edtTokenAPI.Text;
  EvolutionAPI1.instanceName := edtPHONE_NUMBER_ID.Text;
  sResponse := EvolutionAPI1.CreateInstanceBasic(edtPHONE_NUMBER_ID.Text, edtTokenAPI.Text, '', true);

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
  EvolutionAPI1.instanceName := edtPHONE_NUMBER_ID.Text;
  sResponse := EvolutionAPI1.MarkIsRead(ed_num.Text, edtMessage_id.Text);

  memResponse.Lines.Add(sResponse);
end;

procedure TfrmPrincipal.btnArquivoClick(Sender: TObject);
var
  caption, Type_File : string;
  caminhoArquivo : string;
  isFigurinha : Boolean;
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

  {if Trim(edtURL.Text) = '' then
  begin
    ShowMessage('INFORM THE URL LINK FILE TO BE SENT');
    edtURL.SetFocus;
    Exit;
  end;}

  //sResponse := EvolutionAPI1.UploadMedia('');
  //sResponse := EvolutionAPI1.PostMediaFile('','');
  //memResponse.Lines.Add(sResponse);

  {OpenDialog1.Execute();

  if FileExists(OpenDialog1.FileName) then
    caminhoArquivo := OpenDialog1.FileName
  else
    Exit;

  isFigurinha := False;}

  Type_File := 'image';

  //EvolutionAPI1.Token := edtTokenAPI.Text;
  //EvolutionAPI1.PHONE_NUMBER_ID := edtPHONE_NUMBER_ID.Text;
  //sResponse := EvolutionAPI1.SendFile(ed_num.Text, mem_message.Text, 'image', edtURL.Text);



  //sResponse := EvolutionAPI1.SendFile(ed_num.Text, mem_message.Text, 'document', 'https://we.tl/t-Xy3U9kbKUH');
  //memResponse.Lines.Add(sResponse);

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
  EvolutionAPI1.instanceName := edtPHONE_NUMBER_ID.Text;
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
  EvolutionAPI1.instanceName := edtPHONE_NUMBER_ID.Text;
  sResponse := EvolutionAPI1.SendContact(ed_num.Text, edtNumberShared.Text, edtNameContactShared.Text, '');

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
  EvolutionAPI1.instanceName := edtPHONE_NUMBER_ID.Text;
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
  EvolutionAPI1.instanceName := edtPHONE_NUMBER_ID.Text;
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
  EvolutionAPI1.instanceName := edtPHONE_NUMBER_ID.Text;
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

  {if Trim(mem_message.Text) = '' then
  begin
    ShowMessage('INFORM THE BODY MESSAGE TO BE SENT');
    mem_message.SetFocus;
    Exit;
  end;}

  sLocation :=
      '  "location": { ' +
      '      "longitude": -70.4078, ' +
      '      "latitude": 25.3789, ' +
      '      "name": "Cristo Rendedor", ' +
      '      "address": "Rio de Janeiro-RJ" ' +
      ' } ';

  EvolutionAPI1.Token := edtTokenAPI.Text;
  EvolutionAPI1.instanceName := edtPHONE_NUMBER_ID.Text;
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
  EvolutionAPI1.instanceName := edtPHONE_NUMBER_ID.Text;
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
  EvolutionAPI1.instanceName := edtPHONE_NUMBER_ID.Text;
  //function TEvolutionAPI.SendReplies(waid, message_id, reply_body, reply_remoteJid, message_body, fromMe: string; previewurl: string): string;
  sResponse := EvolutionAPI1.SendReplies(ed_num.Text, edtMessage_id.Text, mem_message.Text, edtRemoteJidQuoted.Text, mem_Quoted_message.Text, 'true', 'false');

  memResponse.Lines.Add(sResponse);
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
  EvolutionAPI1.instanceName := edtPHONE_NUMBER_ID.Text;
  sResponse := EvolutionAPI1.SendText(ed_num.Text, mem_message.Text);

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
  EvolutionAPI1.instanceName := edtPHONE_NUMBER_ID.Text;
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
  edtPHONE_NUMBER_ID.Text := ArquivoConfig.ReadString('CONFIGURACAO', 'PHONE_NUMBER_ID', '');
  edtPORT_SERVER.Text := ArquivoConfig.ReadString('CONFIGURACAO', 'PORT_SERVER', '8080');
  edtPortWebhook.Text := ArquivoConfig.ReadString('CONFIGURACAO', 'PORT_Webhook', '8020');
  edtDDI_Default.Text := ArquivoConfig.ReadString('CONFIGURACAO', 'DDI_Default', '55');

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

  ArquivoConfig.writeString('CONFIGURACAO', 'TokenAPI', edtTokenAPI.Text);
  ArquivoConfig.writeString('CONFIGURACAO', 'PHONE_NUMBER_ID', edtPHONE_NUMBER_ID.Text);
  ArquivoConfig.writeString('CONFIGURACAO', 'PORT_SERVER', edtPORT_SERVER.Text);
  ArquivoConfig.writeString('CONFIGURACAO', 'PORT_Webhook', edtPortWebhook.Text);
  ArquivoConfig.writeString('CONFIGURACAO', 'DDI_Default', edtDDI_Default.Text);

  ArquivoConfig.UpdateFile;

  FreeAndNil(ArquivoConfig);

  LerConfiguracoes;
end;

procedure TfrmPrincipal.EvolutionAPI1Response(Sender: TObject; Response: string);
var
  Result: uWhatsAppBusinessClasses.TResultClass;
begin

  memResponse.Lines.Add('' + Response + #13#10);

  try
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


end;

procedure TfrmPrincipal.EvolutionAPI1RetSendMessage(Sender: TObject; Response: string);
begin
  memResponse.Lines.Add(Response);
end;

procedure TfrmPrincipal.CarregarImagemBase64(const Base64Str: string; const Image: TImage);
var
  Stream: TMemoryStream;
  Decoder: TBase64Encoding;
begin
  Stream := TMemoryStream.Create;
  Decoder := TBase64Encoding.Create;
  try
    try
      // Decodifica a string Base64 para um array de bytes
      Stream.WriteBuffer(Decoder.DecodeStringToBytes(Base64Str), Length(Base64Str) div 2);
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
