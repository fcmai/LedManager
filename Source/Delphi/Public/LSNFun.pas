unit LSNFun;

interface

uses
  Windows;


{����LED��ʾ��̬���ӿ⺯������}
//1.��������ͨѶʵ��
function CreateComm():boolean;stdcall;
//2.ɾ������ͨѶʵ��
function DeleteComm():boolean;stdcall;
//3.���ò���
procedure SetScreenPara(FPNO:integer;FColorStyle:integer;FWidth,FHeight:integer;FModeStyle:integer;FTimerOn,FTemperatureOn,FMAINOn,FTitleOn:Boolean;FTitleStyle:integer);stdcall;
//4.���ز���
function SendScreenPara(ComNo:integer;Baud:integer;hParent: Thandle):integer;stdcall;
//5.����ͼƬ����
procedure AddBmp(FInMode, FRunSpeed, FShowTime: integer;FBeginY :integer; FHexFile,FBmpFile: PChar;FAddstyle:integer);stdcall;
//6.�����ַ�������
procedure AddString(FInMode, FRunSpeed, FShowTime: integer;FBeginY:integer;FFontName:PChar;FFontSize,FFontColor:integer;FHexFile,FInString: PChar;FAddstyle:integer);stdcall;
//7.��������RTF�ļ�
procedure AddRtf(FInMode, FRunSpeed, FShowTime: integer;FBeginY:integer;FHexFile,FInFiles: PChar;FAddstyle:integer);stdcall;
//8.������Ļ��ͼƬ����
procedure AddBmp_Title(FInMode, FRunSpeed, FShowTime: integer;FBeginY :integer; FHexFile,FBmpFile: PChar;FAddstyle:integer);stdcall;stdcall;
//9.������Ļ���ַ�������
procedure AddString_Title(FInMode, FRunSpeed, FShowTime: integer;FBeginY:integer;FFontName:PChar;FFontSize,FFontColor:integer;FHexFile,FInString: PChar;FAddstyle:integer);stdcall; 
//10.������Ļ��RTF�ļ�
procedure AddRtf_Title(FInMode, FRunSpeed, FShowTime: integer;FBeginY:integer;FHexFile,FInFiles: PChar;FAddstyle:integer);stdcall; 
//11.У��ʱ��
function AdjustTime(ComNo:integer;Baud:integer;PNO:integer;hParent: Thandle):integer;stdcall; 
//12.����ʱ�Ӹ�ʽ
function SendTimerPara(ComNo:integer;Baud:integer;PNO:integer;FTimerModel,FTimerStyle,FTimerColor,FTimerX,FTimerY:INTEGER;FTimersec,FTimermin,FTimerhour,FTimerday,FTimermon,FTimerweek,FTimeryear:boolean;hParent: Thandle):integer;stdcall; 
//13 ���ʹ�������
function SendDATAToComm(ComNo:integer;Baud:integer;DATAName:Pchar;hParent: Thandle):integer; stdcall; 
//14 ������ʾ��
function PowerDisplay(ComNo:integer;Baud:integer;PNO:integer;PwState:integer;hParent: Thandle):integer;stdcall; 
//15 ���ڷ��ͽ��Ȳ�ѯ
function GetProcessCount():integer;stdcall; 
//16  �ֿⷽʽ�����������ݵ�����
function SendString_Lib(ComNo:integer;Baud:integer;FInMode, FRunSpeed, FShowTime: integer;FBeginY:integer;FFontColor:integer;FInString: PChar;hParent: Thandle):integer;stdcall; 
//17  �ֿⷽʽ������Ļ�����ݵ�����
function SendString_Title_Lib(ComNo:integer;Baud:integer;FInMode, FRunSpeed, FShowTime: integer;FBeginY:integer;FFontColor:integer;FInString: PChar;hParent: Thandle):integer;stdcall; 
//18  ���ù㲥����ģʽ
procedure SetBoardCase(BC:boolean);stdcall; 
{����Ϊ UDP Socket ����}
//19 UDP���ز���
function SendScreenPara_UDP(IP:Pchar;Port:integer;hParent: Thandle):integer;stdcall; 
//20 UDP У��ʱ��
function AdjustTime_UDP(IP:Pchar;Port:integer;PNO:integer;hParent: Thandle):integer;stdcall; 
//21 UDP ����ʱ�Ӹ�ʽ
function SendTimerPara_UDP(IP:Pchar;Port:integer;PNO:integer;FTimerModel,FTimerStyle,FTimerColor,FTimerX,FTimerY:INTEGER;
                       FTimersec,FTimermin,FTimerhour,FTimerday,FTimermon,FTimerweek,FTimeryear:boolean;hParent: Thandle):integer;stdcall; 
//22 UDP ������ʾ����
function SendDATA_UDP(IP:Pchar;Port:integer;Baud:integer;DATAName:Pchar;hParent: Thandle):integer; stdcall; 
//23 UDP ������ʾ��
function PowerDisplay_UDP(IP:Pchar;Port:integer;PNO:integer;PwState:integer;hParent: Thandle):integer;stdcall; 
//24 UDP ���������ֿ����ݵ�����
function SendString_Lib_UDP(IP:Pchar;Port:integer;Baud:integer;FInMode, FRunSpeed, FShowTime: integer;
                        FBeginY:integer;FFontColor:integer;FInString: PChar;hParent: Thandle):integer;stdcall; 
//25 UDP ������Ļ���ֿ����ݵ�����
function SendString_Title_Lib_UDP(IP:Pchar;Port:integer;Baud:integer;FInMode, FRunSpeed, FShowTime: integer;
                              FBeginY:integer;FFontColor:integer;FInString: PChar;hParent: Thandle):integer;stdcall; 
//26 Ԥ��������ʾת������
procedure MainPreview(PreviewFile:Pchar;OutFile:pchar;PageNo:integer);stdcall; 
//27 Ԥ����Ļ����ʾת������
procedure TitlePreview(PreviewFile:Pchar;OutFile:pchar;PageNo:integer);stdcall; 
//28 ����������ʾ����
function AdjustBright(ComNo:integer;Baud:integer;PNO:integer;Brightness:integer;hParent: Thandle):integer;stdcall; 
//29 UDP ����������ʾ����
function AdjustBright_UDP(IP:Pchar;Port:integer;PNO:integer;Brightness:integer;hParent: Thandle):integer;stdcall; 
//30 �ֿⷽʽ������ɫ����ӿ�
procedure SetStringColor_Lib(FColorGroup:integer;FColorCount:integer;FFontColor:integer;FCountBegin,FCountEnd:integer);stdcall; 
//31 ��Ļ�ֿⷽʽ������ɫ����ӿ�
procedure SetStringColor_Title_Lib(FColorGroup:integer;FColorCount:integer;FFontColor:integer;FCountBegin,FCountEnd:integer);stdcall; 


implementation

{����LED��ʾ��̬���ӿ⺯������}
//1.��������ͨѶʵ��
function CreateComm():boolean;stdcall;External 'ListenDisplay.dll';
//2.ɾ������ͨѶʵ��
function DeleteComm():boolean;stdcall;External 'ListenDisplay.dll';
//3.���ò���
procedure SetScreenPara(FPNO:integer;FColorStyle:integer;FWidth,FHeight:integer;FModeStyle:integer;FTimerOn,FTemperatureOn,FMAINOn,FTitleOn:Boolean;FTitleStyle:integer);stdcall;External 'ListenDisplay.dll';
//4.���ز���
function SendScreenPara(ComNo:integer;Baud:integer;hParent: Thandle):integer;stdcall;External 'ListenDisplay.dll';
//5.����ͼƬ����
procedure AddBmp(FInMode, FRunSpeed, FShowTime: integer;FBeginY :integer; FHexFile,FBmpFile: PChar;FAddstyle:integer);stdcall;External 'ListenDisplay.dll';
//6.�����ַ�������
procedure AddString(FInMode, FRunSpeed, FShowTime: integer;FBeginY:integer;FFontName:PChar;FFontSize,FFontColor:integer;FHexFile,FInString: PChar;FAddstyle:integer);stdcall;External 'ListenDisplay.dll';
//7.��������RTF�ļ�
procedure AddRtf(FInMode, FRunSpeed, FShowTime: integer;FBeginY:integer;FHexFile,FInFiles: PChar;FAddstyle:integer);stdcall;External 'ListenDisplay.dll';
//8.������Ļ��ͼƬ����
procedure AddBmp_Title(FInMode, FRunSpeed, FShowTime: integer;FBeginY :integer; FHexFile,FBmpFile: PChar;FAddstyle:integer);stdcall;stdcall;External 'ListenDisplay.dll';
//9.������Ļ���ַ�������
procedure AddString_Title(FInMode, FRunSpeed, FShowTime: integer;FBeginY:integer;FFontName:PChar;FFontSize,FFontColor:integer;FHexFile,FInString: PChar;FAddstyle:integer);stdcall;External 'ListenDisplay.dll';
//10.������Ļ��RTF�ļ�
procedure AddRtf_Title(FInMode, FRunSpeed, FShowTime: integer;FBeginY:integer;FHexFile,FInFiles: PChar;FAddstyle:integer);stdcall;External 'ListenDisplay.dll';
//11.У��ʱ��
function AdjustTime(ComNo:integer;Baud:integer;PNO:integer;hParent: Thandle):integer;stdcall;External 'ListenDisplay.dll';
//12.����ʱ�Ӹ�ʽ
function SendTimerPara(ComNo:integer;Baud:integer;PNO:integer;FTimerModel,FTimerStyle,FTimerColor,FTimerX,FTimerY:INTEGER;FTimersec,FTimermin,FTimerhour,FTimerday,FTimermon,FTimerweek,FTimeryear:boolean;hParent: Thandle):integer;stdcall;External 'ListenDisplay.dll';
//13 ���ʹ�������
function SendDATAToComm(ComNo:integer;Baud:integer;DATAName:Pchar;hParent: Thandle):integer; stdcall;External 'ListenDisplay.dll';
//14 ������ʾ��
function PowerDisplay(ComNo:integer;Baud:integer;PNO:integer;PwState:integer;hParent: Thandle):integer;stdcall;External 'ListenDisplay.dll';
//15 ���ڷ��ͽ��Ȳ�ѯ
function GetProcessCount():integer;stdcall;External 'ListenDisplay.dll';
//16  �ֿⷽʽ�����������ݵ�����
function SendString_Lib(ComNo:integer;Baud:integer;FInMode, FRunSpeed, FShowTime: integer;FBeginY:integer;FFontColor:integer;FInString: PChar;hParent: Thandle):integer;stdcall;External 'ListenDisplay.dll';
//17  �ֿⷽʽ������Ļ�����ݵ�����
function SendString_Title_Lib(ComNo:integer;Baud:integer;FInMode, FRunSpeed, FShowTime: integer;FBeginY:integer;FFontColor:integer;FInString: PChar;hParent: Thandle):integer;stdcall;External 'ListenDisplay.dll';
//18  ���ù㲥����ģʽ
procedure SetBoardCase(BC:boolean);stdcall;External 'ListenDisplay.dll';
{����Ϊ UDP Socket ����}
//19 UDP���ز���
function SendScreenPara_UDP(IP:Pchar;Port:integer;hParent: Thandle):integer;stdcall;External 'ListenDisplay.dll';
//20 UDP У��ʱ��
function AdjustTime_UDP(IP:Pchar;Port:integer;PNO:integer;hParent: Thandle):integer;stdcall;External 'ListenDisplay.dll';
//21 UDP ����ʱ�Ӹ�ʽ
function SendTimerPara_UDP(IP:Pchar;Port:integer;PNO:integer;FTimerModel,FTimerStyle,FTimerColor,FTimerX,FTimerY:INTEGER;
                       FTimersec,FTimermin,FTimerhour,FTimerday,FTimermon,FTimerweek,FTimeryear:boolean;hParent: Thandle):integer;stdcall;External 'ListenDisplay.dll';
//22 UDP ������ʾ����
function SendDATA_UDP(IP:Pchar;Port:integer;Baud:integer;DATAName:Pchar;hParent: Thandle):integer; stdcall;External 'ListenDisplay.dll';
//23 UDP ������ʾ��
function PowerDisplay_UDP(IP:Pchar;Port:integer;PNO:integer;PwState:integer;hParent: Thandle):integer;stdcall;External 'ListenDisplay.dll';
//24 UDP ���������ֿ����ݵ�����
function SendString_Lib_UDP(IP:Pchar;Port:integer;Baud:integer;FInMode, FRunSpeed, FShowTime: integer;
                        FBeginY:integer;FFontColor:integer;FInString: PChar;hParent: Thandle):integer;stdcall;External 'ListenDisplay.dll';
//25 UDP ������Ļ���ֿ����ݵ�����
function SendString_Title_Lib_UDP(IP:Pchar;Port:integer;Baud:integer;FInMode, FRunSpeed, FShowTime: integer;
                              FBeginY:integer;FFontColor:integer;FInString: PChar;hParent: Thandle):integer;stdcall;External 'ListenDisplay.dll';
//26 Ԥ��������ʾת������
procedure MainPreview(PreviewFile:Pchar;OutFile:pchar;PageNo:integer);stdcall;External 'ListenDisplay.dll';
//27 Ԥ����Ļ����ʾת������
procedure TitlePreview(PreviewFile:Pchar;OutFile:pchar;PageNo:integer);stdcall;External 'ListenDisplay.dll';
//28 ����������ʾ����
function AdjustBright(ComNo:integer;Baud:integer;PNO:integer;Brightness:integer;hParent: Thandle):integer;stdcall;External 'ListenDisplay.dll';
//29 UDP ����������ʾ����
function AdjustBright_UDP(IP:Pchar;Port:integer;PNO:integer;Brightness:integer;hParent: Thandle):integer;stdcall;External 'ListenDisplay.dll';
//30 �ֿⷽʽ������ɫ����ӿ�
procedure SetStringColor_Lib(FColorGroup:integer;FColorCount:integer;FFontColor:integer;FCountBegin,FCountEnd:integer);stdcall;External 'ListenDisplay.dll';
//31 ��Ļ�ֿⷽʽ������ɫ����ӿ�
procedure SetStringColor_Title_Lib(FColorGroup:integer;FColorCount:integer;FFontColor:integer;FCountBegin,FCountEnd:integer);stdcall;External 'ListenDisplay.dll';


end.
 