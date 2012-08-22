unit LedSettingForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CnAAFont, CnAACtrls, StdCtrls, CnButtons, ExtCtrls, CnPanel,
  Mask, RzEdit, CnSpin, LedBasic;

type
  TFormSetting = class(TForm)
    cnpnlLeft: TCnPanel;
    cnpnlLSNPanel: TCnPanel;
    cnbtnAddScreen: TCnBitBtn;
    cnbtnDelScreen: TCnBitBtn;
    lstScreens: TListBox;
    alblScreenTitle: TCnAALabel;
    grpParaSetting: TGroupBox;
    lblWidth: TLabel;
    lblHeight: TLabel;
    seWidth: TCnSpinEdit;
    seHeight: TCnSpinEdit;
    lblColorStyle: TLabel;
    lblModeStyle: TLabel;
    cbbColorStyle: TComboBox;
    cbbModeStyle: TComboBox;
    grpTemplet: TGroupBox;
    lblFontName: TLabel;
    lblFontSize: TLabel;
    cbbFontSize: TComboBox;
    cbbFontName: TComboBox;
    lblEffect: TLabel;
    cbbEffect: TComboBox;
    lblRunSpeed: TLabel;
    lblStayTime: TLabel;
    seRunSpeed: TCnSpinEdit;
    seStayTime: TCnSpinEdit;
    lblFontColor: TLabel;
    cbbFontColor: TComboBox;
    mmoText: TMemo;
    cnbtnTest: TCnBitBtn;
    cnbtnSave: TCnBitBtn;
    cnbtnCancel: TCnBitBtn;
    alblTextSource: TCnAALabel;
    edtTextSource: TEdit;
    grpHardSetting: TGroupBox;
    lbl3: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    cbbTransMode: TComboBox;
    cbbCardType: TComboBox;
    grpNet: TGroupBox;
    lbl8: TLabel;
    edtIP: TEdit;
    grpCom: TGroupBox;
    lbl9: TLabel;
    lbl10: TLabel;
    cbbComNO: TComboBox;
    cbbBaudrate: TComboBox;
    edtScreenID: TEdit;
    procedure rbClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cnbtnAddScreenClick(Sender: TObject);
    procedure cnbtnDelScreenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cnbtnTestClick(Sender: TObject);
    procedure lstScreensClick(Sender: TObject);
    procedure cnbtnSaveClick(Sender: TObject);
    procedure cnbtnCancelClick(Sender: TObject);
    procedure CtrlChange(Sender: TObject);
  private
    { Private declarations }
    FLedManager: TLedManager;

    procedure Init;
    procedure LoadSetting;
    procedure SaveSetting;
    procedure SaveDefSetting;
    function GetCurScreen: TLedScreen;
    procedure ShowCtrl;
    procedure StartChangeOrSave;
    procedure endChangeOrSave;
    procedure RefreshListBox;
    procedure ListBoxSelectFirst;
    procedure ListBoxSelectLast;
    procedure SetObjectToCtrl(AScreen: TLedScreen);
    procedure SetCtrlToObject;

    procedure AddLSNScreen;
    procedure AddCPScreen;
    procedure DelScreen(Index: Integer);
  public
    { Public declarations }
    property LedManager: TLedManager read FLedManager;
  end;

var
  FormSetting: TFormSetting;

implementation

uses LSNScreen, LSNWindow, LedIniOptions, CPScreen, CPWindow;

{$R *.dfm}

{ TFormSetting } 

procedure TFormSetting.CtrlChange(Sender: TObject);
begin   
  SetCtrlToObject;
end;        

procedure TFormSetting.cnbtnTestClick(Sender: TObject);
var
  curScreen: TLedScreen;
begin
  curScreen := GetCurScreen;
  if curScreen = nil then
  begin
    Exit;
  end;

  { DONE : ��ʱӦ�ò�����Ϣ������ }

  LedManager.SendTextTo(curScreen.ScreenType, curScreen.ID, 1, mmoText.Text);
end;

procedure TFormSetting.lstScreensClick(Sender: TObject);
var
  curScreen: TLedScreen;
begin
  StartChangeOrSave;

  curScreen := GetCurScreen;
  if curScreen <> nil then
  begin
    SetObjectToCtrl(curScreen);
  end;

  endChangeOrSave;
end;

procedure TFormSetting.rbClick(Sender: TObject);
begin     
  SetCtrlToObject;
  
end;

procedure TFormSetting.FormShow(Sender: TObject);
begin     
  StartChangeOrSave;
  LoadSetting;

  RefreshListBox;
  

  endChangeOrSave;
end;       

procedure TFormSetting.cnbtnSaveClick(Sender: TObject);
begin        
  StartChangeOrSave;
  { ����������Ϣ��ini�ļ� }
  SaveSetting;

  endChangeOrSave;
            
  ModalResult := mrOk;
end;

procedure TFormSetting.cnbtnCancelClick(Sender: TObject);
begin
  { ȡ�����ã����������� }
  Close;
end;

procedure TFormSetting.cnbtnAddScreenClick(Sender: TObject);
begin        
  StartChangeOrSave;

  AddLSNScreen;
  RefreshListBox;
  

  endChangeOrSave;
end;

procedure TFormSetting.cnbtnDelScreenClick(Sender: TObject);
begin
  StartChangeOrSave;

  DelScreen(lstScreens.Count - 1);
  RefreshListBox;


  endChangeOrSave;
end;

procedure TFormSetting.FormCreate(Sender: TObject);
begin
  Init;
end;   

procedure TFormSetting.DelScreen(Index: Integer);
begin
  if (0 <= Index) and (Index < FLedManager.ScreenCount) then
  begin
    FLedManager.DeleteScreen(Index);
  end;
end;   

procedure TFormSetting.AddCPScreen;
var
  aScreen: TCPScreen;
  aWindow: TCPWindow;
begin
  aScreen := TCPScreen.Create;
  aWindow := TCPWindow.Create;
  aScreen.ID := FLedManager.GetNewScreenID(CPScreenType);
  { ������ʾ��Ĭ��ֵ }
  aScreen.Width := IniOptions.LSNDefWidth;
  aScreen.Heigth := IniOptions.LSNDefHeigth;
  aScreen.IsSendByNet := IniOptions.LSNDefIsSendByNet;
  aScreen.IP := IniOptions.LSNDefIP;
  aScreen.Port := IniOptions.LSNDefPort;
  aScreen.IDCode := IniOptions.LSNDefIDCode;
  aScreen.ComNO := IniOptions.LSNDefComNO;
  aScreen.Baudrate := IniOptions.LSNDefBaudrate;
  aScreen.Timeout := IniOptions.DefTimeout;

  aWindow.X := IniOptions.LSNDefWindowX;
  aWindow.Y := IniOptions.LSNDefWindowY;
  aWindow.Width := IniOptions.LSNDefWindowWidth;
  aWindow.Heigth := IniOptions.LSNDefWindowHeigth;
  aWindow.FontName := IniOptions.LSNDefWindowFontName;
  aWindow.FontSize := IniOptions.LSNDefWindowFontSize;
  aWindow.Color := IniOptions.LSNDefWindowFontColor;
  aWindow.Effect := IniOptions.LSNDefWindowEffect;
  aWindow.RunSpeed := IniOptions.LSNDefWindowRunSpeed;
  aWindow.StayTime := IniOptions.LSNDefWindowStayTime;
  aWindow.Alignment := IniOptions.LSNDefWindowAlignment;

  aScreen.AddWindow(aWindow);
  FLedManager.AddScreen(aScreen);
end;

procedure TFormSetting.AddLSNScreen;
var
  aScreen: TLSNScreen;
  aWindow: TLSNWindow;
begin
  aScreen := TLSNScreen.Create;
  aWindow := TLSNWindow.Create;
  aScreen.ID := FLedManager.GetNewScreenID(LSNScreenType);
  { ������ʾ��Ĭ��ֵ }
  aScreen.Width := IniOptions.LSNDefWidth;
  aScreen.Heigth := IniOptions.LSNDefHeigth;
  aScreen.IsSendByNet := IniOptions.LSNDefIsSendByNet;
  aScreen.IP := IniOptions.LSNDefIP;
  aScreen.Port := IniOptions.LSNDefPort;
  aScreen.IDCode := IniOptions.LSNDefIDCode;
  aScreen.ComNO := IniOptions.LSNDefComNO;
  aScreen.Baudrate := IniOptions.LSNDefBaudrate;
  aScreen.ColorStyle := IniOptions.LSNDefColorStyle;
  aScreen.ModeStyle := IniOptions.LSNDefModeStyle;
  aScreen.TimerON := IniOptions.LSNDefTimerON;
  aScreen.TemperatureON := IniOptions.LSNDefTemperatureON;
  aScreen.MainON := IniOptions.LSNDefMainON;
  aScreen.TitleON := IniOptions.LSNDefTitleON;
  aScreen.TitleStyle := IniOptions.LSNDefTitleStyle;

  aWindow.X := IniOptions.LSNDefWindowX;
  aWindow.Y := IniOptions.LSNDefWindowY;
  aWindow.Width := IniOptions.LSNDefWindowWidth;
  aWindow.Heigth := IniOptions.LSNDefWindowHeigth;
  aWindow.FontName := IniOptions.LSNDefWindowFontName;
  aWindow.FontSize := IniOptions.LSNDefWindowFontSize;
  aWindow.Color := IniOptions.LSNDefWindowFontColor;
  aWindow.Effect := IniOptions.LSNDefWindowEffect;
  aWindow.RunSpeed := IniOptions.LSNDefWindowRunSpeed;
  aWindow.StayTime := IniOptions.LSNDefWindowStayTime;
  aWindow.Alignment := IniOptions.LSNDefWindowAlignment;
  aWindow.AddStyle := IniOptions.LSNDefWindowAddStyle;

  aScreen.AddWindow(aWindow);
  FLedManager.AddScreen(aScreen);    
end;

procedure TFormSetting.Init;
begin
  FLedManager := TLedManager.Create;

end;

procedure TFormSetting.LoadSetting;
begin
  IniOptions.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'LedManager.ini');
  FLedManager.LoadFrom(IniOptions);
end;

procedure TFormSetting.SaveSetting;
var
  i, j: Integer;
  tmpKVList: TStrings;
begin
  { TODO : δ����cp2500 }
  { ��Led������Ϣ������ini�ļ��� }
  //������ʾ������
  for i := IniOptions.ScreenCount - 1 downto 0 do
  begin
    //��������ļ�ini�е�������ʾ�����Ժ��ټ���
    IniOptions.DeleteScreen(i);
  end;
  for i := IniOptions.WindowCount - 1 downto 0 do
  begin
    //��������ļ�ini�е�������ʾ�����������/���ڣ��Ժ��ټ���
    IniOptions.DeleteWindow(i);
  end;

  FLedManager.SaveTo(IniOptions);

  IniOptions.SaveToFile(ExtractFilePath(ParamStr(0)) + 'LedManager.ini');
end;

procedure TFormSetting.RefreshListBox;
var
  curScreen: TLedScreen;
begin
  lstScreens.Items := FLedManager.ScreenNames;
  ListBoxSelectLast;
  curScreen := GetCurScreen;
  if curScreen <> nil then
  begin
    SetObjectToCtrl(curScreen);
  end;
end;

procedure TFormSetting.SetObjectToCtrl(AScreen: TLedScreen);
var
  i: Integer;
  lsnScreen: TLSNScreen;
begin
  if AScreen = nil then
  begin
    Exit;
  end;   
  { TODO : ���ݿ��ƿ����ͽ��б��� }
  if curScreen.ScreenType = CPScreenType then
  begin
    SetCPInfo2Ctrl(curScreen);
  end
  else
  begin
    SetLSNInfo2Ctrl
  end;

  lsnScreen := AScreen as TLSNScreen;
  grpHardSetting.Caption := IntToStr(lsnScreen.ID) + '����ʾ��Ӳ������';
  seWidth.Value := lsnScreen.Width;
  seHeight.Value := lsnScreen.Heigth;
  rbRs.Checked := not lsnScreen.IsSendByNet;
  rbNet.Checked := lsnScreen.IsSendByNet;
  edtIP.Text := lsnScreen.IP;
  edtIPPort.Text := IntToStr(lsnScreen.Port);
  if (0 < lsnScreen.ComNO) and (lsnScreen.ComNO <= 16) then
  begin
    cbbPort.ItemIndex := lsnScreen.ComNO - 1;
  end;
  for i := 0 to cbbBaudrate.Items.Count - 1 do
  begin
    if lsnScreen.Baudrate = StrToInt(cbbBaudrate.Items[i]) then
    begin
      cbbBaudrate.ItemIndex := i;
      Break;
    end;
  end;
  cbbColorStyle.ItemIndex := lsnScreen.ColorStyle - 1;
  cbbModeStyle.ItemIndex := lsnScreen.ModeStyle - 1;
  cbbFontName.Text := lsnScreen.Windows[0].FontName;
  for i := 0 to cbbFontSize.Items.Count - 1 do
  begin
    if lsnScreen.Windows[0].FontSize = StrToInt(cbbFontSize.Items[i]) then
    begin
      cbbFontSize.ItemIndex := i;
      Break;
    end;
  end;
  cbbFontColor.ItemIndex := lsnScreen.Windows[0].Color - 1;
  cbbEffect.ItemIndex := lsnScreen.Windows[0].Effect;
  seRunSpeed.Value := lsnScreen.Windows[0].RunSpeed;
  seStayTime.Value := lsnScreen.Windows[0].StayTime;
  edtTextSource.Text := lsnScreen.Windows[0].TextSource;
end;

procedure TFormSetting.ShowCtrl;
begin
  grpNet.Visible := (cbbTransMode.ItemIndex = 0);
  grpCom.Visible := (cbbTransMode.ItemIndex > 0);
end;

procedure TFormSetting.SetCtrlToObject;
var
  lsnScreen: TLSNScreen;
begin
  if not Self.Enabled then
  begin
    Exit;
  end;
  lsnScreen := GetCurScreen as TLSNScreen;
  if lsnScreen = nil then
  begin
    Exit;
  end;
  lsnScreen.Width := seWidth.Value;
  lsnScreen.Heigth := seHeight.Value;
  lsnScreen.IsSendByNet := not rbRs.Checked;
  lsnScreen.IP := edtIP.Text;
  lsnScreen.Port := StrToInt(edtIPPort.Text);
  lsnScreen.ComNO := cbbPort.ItemIndex + 1;
  lsnScreen.Baudrate := StrToInt(cbbBaudrate.Text);
  lsnScreen.ColorStyle := cbbColorStyle.ItemIndex + 1;
  lsnScreen.ModeStyle := cbbModeStyle.ItemIndex + 1;
  lsnScreen.Windows[0].FontName := cbbFontName.Text;
  lsnScreen.Windows[0].FontSize := StrToInt(cbbFontSize.Text);
  lsnScreen.Windows[0].Color := cbbFontColor.ItemIndex + 1;
  lsnScreen.Windows[0].Effect := cbbEffect.ItemIndex;
  lsnScreen.Windows[0].RunSpeed := seRunSpeed.Value;
  lsnScreen.Windows[0].StayTime := seStayTime.Value;
  lsnScreen.Windows[0].TextSource := edtTextSource.Text;
end;

procedure TFormSetting.ListBoxSelectFirst;
begin
  if lstScreens.Count > 0 then
  begin
    lstScreens.Selected[0] := True;
  end;
end;

procedure TFormSetting.ListBoxSelectLast;
begin     
  if lstScreens.Count > 0 then
  begin
    lstScreens.Selected[lstScreens.Count - 1] := True;
  end;
end;

function TFormSetting.GetCurScreen: TLedScreen;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to lstScreens.Count - 1 do
  begin
    if lstScreens.Selected[i] then
    begin
      Result := LedManager.Screens[i];
      Break;
    end;
  end;
end;

procedure TFormSetting.endChangeOrSave;
begin
  { TODO : Panel�Ŀ���Ӧ�ͺ� }
  cnpnlLSNPanel.Enabled := True;
  cnpnlLSNPanel.Visible := True;
  Self.Enabled := True;
  Screen.Cursor := crDefault;
end;

procedure TFormSetting.StartChangeOrSave;
begin
  { TODO : Panel�Ŀ���Ӧ�ͺ� }
  Screen.Cursor := crHourGlass; 
  Self.Enabled := False;
  cnpnlLSNPanel.Visible := False;
  cnpnlLSNPanel.Enabled := False;
end;

procedure TFormSetting.SaveDefSetting;
begin
{ TODO : ����ΪĬ������ }
end;

end.
