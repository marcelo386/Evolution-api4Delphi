unit uFunctionGroup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtDlgs, System.ImageList, Vcl.ImgList, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TfrmFunctionGroup = class(TForm)
    ScrollBox1: TScrollBox;
    gbGrupos: TGroupBox;
    listaGrupos: TListView;
    pnlTopoGrupos: TPanel;
    btnListarGrupos: TBitBtn;
    gbacoes: TGroupBox;
    btnCriarVotacao: TButton;
    btnPromover: TButton;
    btnDespromover: TButton;
    btnSairGrupo: TButton;
    btnDeletarGrupo: TButton;
    btnGerarLinkConvite: TButton;
    btnCancelaLink: TButton;
    btnMudarImagemGrupo: TButton;
    btnAdminOnly: TButton;
    btnMsgAll: TButton;
    btnDescricaoGrupo: TButton;
    Button1: TButton;
    pnlEsquerda: TPanel;
    lbl_idParticipant: TLabel;
    lbl_idGroup: TLabel;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Lbl_InviteCode: TLabel;
    gbNovoGrupo: TGroupBox;
    edtNomeGrupo: TLabeledEdit;
    edtTelefoneNovoParticipante: TLabeledEdit;
    btnCriarGrupo: TBitBtn;
    gbGrupoLink: TGroupBox;
    edtLinkConvite: TLabeledEdit;
    btnEntrarLink: TBitBtn;
    eChoicesPool: TEdit;
    Memo1: TMemo;
    edtIdGrupo: TEdit;
    pnlGruposParticipantes: TPanel;
    GroupBox1: TGroupBox;
    gbAdmin: TGroupBox;
    listaAdministradores: TListView;
    gbParticipantes: TGroupBox;
    lblIdParticipante: TLabel;
    listaParticipantes: TListView;
    pnlParticipantesBotoes: TPanel;
    btnRemovePartici: TButton;
    pnltopopartici: TPanel;
    edtNovoParticipante: TLabeledEdit;
    btnAddPArtici: TButton;
    ImageList1: TImageList;
    OpenPictureDialog1: TOpenPictureDialog;
    Button2: TButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnListarGruposClick(Sender: TObject);
    procedure listaGruposClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnCriarGrupoClick(Sender: TObject);
    procedure btnAddPArticiClick(Sender: TObject);
    procedure btnRemoveParticiClick(Sender: TObject);
    procedure btnPromoverClick(Sender: TObject);
    procedure btnDespromoverClick(Sender: TObject);
    procedure btnSairGrupoClick(Sender: TObject);
    procedure btnDeletarGrupoClick(Sender: TObject);
    procedure btnGerarLinkConviteClick(Sender: TObject);
    procedure btnCancelaLinkClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnMudarImagemGrupoClick(Sender: TObject);
  private
    { Private declarations }
    procedure AddGroupList(ANumber: string);
    procedure AddGroupAdmins(ANumber: string);
    procedure AddGroupContacts(ANumber: string);
  public
    { Public declarations }
  end;

var
  frmFunctionGroup: TfrmFunctionGroup;

implementation

{$R *.dfm}

uses uPrincipal, uResponseFetchAllGroupsClass, uResponseAllparticipantsClass, uResponseInfoGroupClass;

procedure TfrmFunctionGroup.AddGroupAdmins(ANumber: string);
var
  Item: TListItem;
begin
  Item := listaAdministradores.Items.Add;
  Item.Caption := ANumber;
  Item.SubItems.Add(Item.Caption + 'SubItem 1');
  Item.SubItems.Add(Item.Caption + 'SubItem 2');
  Item.ImageIndex := 0;
end;

procedure TfrmFunctionGroup.AddGroupContacts(ANumber: string);
var
  Item: TListItem;
begin
  Item := listaParticipantes.Items.Add;
  Item.Caption := ANumber;
  Item.SubItems.Add(Item.Caption + 'SubItem 1');
  Item.SubItems.Add(Item.Caption + 'SubItem 2');
  Item.ImageIndex := 0;
end;

procedure TfrmFunctionGroup.AddGroupList(ANumber: string);
var
  Item: TListItem;
begin
  Item := listaGrupos.Items.Add;
  Item.Caption := ANumber;
  Item.SubItems.Add(Item.Caption + 'SubItem 1');
  Item.SubItems.Add(Item.Caption + 'SubItem 2');
  Item.ImageIndex := 0;
end;

procedure TfrmFunctionGroup.BitBtn1Click(Sender: TObject);
var
  ResponseFindGroup, groupJid: string;
begin
  groupJid := '';
  ResponseFindGroup := frmPrincipal.EvolutionAPI1.findGroupJid(groupJid);

end;

procedure TfrmFunctionGroup.btnAddPArticiClick(Sender: TObject);
var
  Response: String;
begin
  frmPrincipal.EvolutionAPI1.Token := frmPrincipal.edtTokenAPI.Text;
  frmPrincipal.EvolutionAPI1.instanceName := frmPrincipal.edtInstanceName.Text;
  Response := frmPrincipal.EvolutionAPI1.updateParticipant('add', edtNovoParticipante.Text, edtIdGrupo.Text);

end;

procedure TfrmFunctionGroup.btnCancelaLinkClick(Sender: TObject);
var
  Response: String;
begin
  frmPrincipal.EvolutionAPI1.Token := frmPrincipal.edtTokenAPI.Text;
  frmPrincipal.EvolutionAPI1.instanceName := frmPrincipal.edtInstanceName.Text;
  Response := frmPrincipal.EvolutionAPI1.revokeInviteCode(edtIdGrupo.Text);

end;

procedure TfrmFunctionGroup.btnCriarGrupoClick(Sender: TObject);
var
  Response: String;
begin
  frmPrincipal.EvolutionAPI1.Token := frmPrincipal.edtTokenAPI.Text;
  frmPrincipal.EvolutionAPI1.instanceName := frmPrincipal.edtInstanceName.Text;
  Response := frmPrincipal.EvolutionAPI1.CreateGroup(edtNomeGrupo.Text, '' , edtTelefoneNovoParticipante.Text);


end;

procedure TfrmFunctionGroup.btnDeletarGrupoClick(Sender: TObject);
var
  Response: String;
begin
  {frmPrincipal.EvolutionAPI1.Token := frmPrincipal.edtTokenAPI.Text;
  frmPrincipal.EvolutionAPI1.instanceName := frmPrincipal.edtInstanceName.Text;
  Response := frmPrincipal.EvolutionAPI1.LeaveGroup(edtIdGrupo.Text);}

end;

procedure TfrmFunctionGroup.btnDespromoverClick(Sender: TObject);
var
  Response: String;
begin
  frmPrincipal.EvolutionAPI1.Token := frmPrincipal.edtTokenAPI.Text;
  frmPrincipal.EvolutionAPI1.instanceName := frmPrincipal.edtInstanceName.Text;
  Response := frmPrincipal.EvolutionAPI1.updateParticipant('demote', edtNovoParticipante.Text, edtIdGrupo.Text);

end;

procedure TfrmFunctionGroup.btnGerarLinkConviteClick(Sender: TObject);
var
  Response: String;
begin
  frmPrincipal.EvolutionAPI1.Token := frmPrincipal.edtTokenAPI.Text;
  frmPrincipal.EvolutionAPI1.instanceName := frmPrincipal.edtInstanceName.Text;
  Response := frmPrincipal.EvolutionAPI1.fetchinviteCode(edtIdGrupo.Text);

end;

procedure TfrmFunctionGroup.btnListarGruposClick(Sender: TObject);
var
  Response: string;
  ListAllGroups: uResponseFetchAllGroupsClass.TResponseAllGroupsClass;
var
  i: integer;
  TextGroup: String;
begin
  frmPrincipal.EvolutionAPI1.Token := frmPrincipal.edtTokenAPI.Text;
  frmPrincipal.EvolutionAPI1.instanceName := frmPrincipal.edtInstanceName.Text;
  Response := frmPrincipal.EvolutionAPI1.fetchAllGroups(False);
  Response := '{"result":' + Response + '}';

  ListAllGroups := uResponseFetchAllGroupsClass.TResponseAllGroupsClass.FromJsonString(Response);

  listaGrupos.Clear;

  //for i := 0 to (ListAllGroups.Items.count) - 1 do
  for i := 0 to Length(ListAllGroups.result) -1 do
  begin
    TextGroup := ListAllGroups.result[i].id + ' - ' + ListAllGroups.result[i].subject;
    //TextGroup := UnicodeToUtf8(AllGroups.Numbers[i]);
    //UnicodeToUtf8(TextGroup, AllGroups.Numbers[i], 0);
    //TextGroup := ConvertUnicodeEscapeToUTF8(UTF8Encode(AllGroups.Numbers[i]));
    AddGroupList(TextGroup);
  end;
end;

procedure TfrmFunctionGroup.btnMudarImagemGrupoClick(Sender: TObject);
var
  Response: String;
begin
  frmPrincipal.EvolutionAPI1.Token := frmPrincipal.edtTokenAPI.Text;
  frmPrincipal.EvolutionAPI1.instanceName := frmPrincipal.edtInstanceName.Text;
  Response := frmPrincipal.EvolutionAPI1.updateGroupPicture('url', edtIdGrupo.Text);

end;

procedure TfrmFunctionGroup.btnPromoverClick(Sender: TObject);
var
  Response: String;
begin
  frmPrincipal.EvolutionAPI1.Token := frmPrincipal.edtTokenAPI.Text;
  frmPrincipal.EvolutionAPI1.instanceName := frmPrincipal.edtInstanceName.Text;
  Response := frmPrincipal.EvolutionAPI1.updateParticipant('promote', edtNovoParticipante.Text, edtIdGrupo.Text);

end;

procedure TfrmFunctionGroup.btnRemoveParticiClick(Sender: TObject);
var
  Response: String;
begin
  frmPrincipal.EvolutionAPI1.Token := frmPrincipal.edtTokenAPI.Text;
  frmPrincipal.EvolutionAPI1.instanceName := frmPrincipal.edtInstanceName.Text;
  Response := frmPrincipal.EvolutionAPI1.updateParticipant('remove', edtNovoParticipante.Text, edtIdGrupo.Text);

end;

procedure TfrmFunctionGroup.btnSairGrupoClick(Sender: TObject);
var
  Response: String;
begin
  frmPrincipal.EvolutionAPI1.Token := frmPrincipal.edtTokenAPI.Text;
  frmPrincipal.EvolutionAPI1.instanceName := frmPrincipal.edtInstanceName.Text;
  Response := frmPrincipal.EvolutionAPI1.LeaveGroup(edtIdGrupo.Text);

end;

procedure TfrmFunctionGroup.Button1Click(Sender: TObject);
var
  Response: String;
begin
  frmPrincipal.EvolutionAPI1.Token := frmPrincipal.edtTokenAPI.Text;
  frmPrincipal.EvolutionAPI1.instanceName := frmPrincipal.edtInstanceName.Text;
  Response := frmPrincipal.EvolutionAPI1.sendInviteUrl(edtIdGrupo.Text, '', edtNovoParticipante.Text );

end;

procedure TfrmFunctionGroup.Button2Click(Sender: TObject);
var
  Response, groupJid, vTexto: string;
  ResponseInfoGroup: uResponseInfoGroupClass.TInfoGroupClass;
begin
  groupJid := edtIdGrupo.Text;
  Response := frmPrincipal.EvolutionAPI1.findGroupJid(groupJid);
  Response := Response;

  //ResponseInfoGroup :=
  ResponseInfoGroup := uResponseInfoGroupClass.TInfoGroupClass.FromJsonString(Response);

  vTexto := ResponseInfoGroup.id + ' - ' + ResponseInfoGroup.subject;
  ShowMessage('Info: ' + vTexto);
end;

procedure TfrmFunctionGroup.listaGruposClick(Sender: TObject);
var
  Response, TextParticipant: string;
  ListAllparticipants: uResponseAllparticipantsClass.TAllparticipantsClass;
  i : Integer;
begin
  if listaGrupos.ItemIndex <>  - 1 then
  begin
    lbl_idGroup.Caption :=  Copy(listaGrupos.Items[listaGrupos.Selected.Index].SubItems[1], 0,
      Pos('@', listaGrupos.Items[listaGrupos.Selected.Index].SubItems[1]))+'g.us';

    edtIdGrupo.Text := lbl_idGroup.Caption;

    Response := frmPrincipal.EvolutionAPI1.findParticipants(lbl_idGroup.Caption);
    Response := Response;

    ListAllparticipants := uResponseAllparticipantsClass.TAllparticipantsClass.FromJsonString(Response);
    listaParticipantes.Clear;
    listaAdministradores.Clear;

    for i := 0 to Length(ListAllparticipants.participants) -1 do
    begin
      TextParticipant := ListAllparticipants.participants[i].id + ' - ' + ListAllparticipants.participants[i].name;
      //TextGroup := UnicodeToUtf8(AllGroups.Numbers[i]);
      //UnicodeToUtf8(TextGroup, AllGroups.Numbers[i], 0);
      //TextGroup := ConvertUnicodeEscapeToUTF8(UTF8Encode(AllGroups.Numbers[i]));
      AddGroupContacts(TextParticipant);

      if (ListAllparticipants.participants[i].admin = 'admin')
      or (ListAllparticipants.participants[i].admin = 'superadmin') then
        AddGroupAdmins(TextParticipant);

    end;
  end;
end;

end.
