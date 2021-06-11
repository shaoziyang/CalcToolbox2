unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls,
  LCLType, Grids, StdCtrls, EditBtn, IniFiles, process, Math, Clipbrd, Menus,
  Buttons, Spin, ButtonPanel, fileinfo, Types, TypInfo, DateUtils, FileUtil,
  lclintf, LCLTranslator,
  RichMemo, UBigFloatV3, MD5, sha1,
  uPSComponent, uPSComponent_Default, uPSComponent_COM, uPSComponent_Forms,
  uPSComponent_Controls, uPSComponent_StdCtrls,
  SynEdit, SynHighlighterPython, SynHighlighterCpp, SynHighlighterPas;

const
  GITHUB_URL = 'https://github.com/shaoziyang/CalcToolbox2';
  GITEE_URL = 'https://gitee.com/shaoziyang/CalcToolbox2';
  VERSION = '2.0.0.0';
{$ifdef Windows}
  MICROPYTHON_BIN_NAME = 'interpreter\micropython\micropython.exe';
  PATHSEP = '\';
{$else}
{$ifdef Linux}
  MICROPYTHON_BIN_NAME = 'interpreter/micropython/micropython';
  PATHSEP = '/';
{$endif}
{$endif}

  TimeBetweenLineOffset = 13;

  {$I NewFileTemplate.pas}

  ScriptName: array of string = ('LittleC', 'graph', 'micropython', 'pascal');
  ScriptSym: array of string = ('LittleC', 'Graph', 'MPY', 'Pascal');

type

  { TfrmMain }

  TfrmMain = class(TForm)
    ApplicationProperties: TApplicationProperties;
    btnScriptCaret_LittleC: TToolButton;
    btnScriptCaret_Graph: TToolButton;
    btnScriptCaret_MPY: TToolButton;
    btnScriptCaret_Pascal: TToolButton;
    btnScriptClear_LittleC: TToolButton;
    btnScriptClear_Graph: TToolButton;
    btnScriptClear_MPY: TToolButton;
    btnScriptClear_Pascal: TToolButton;
    btnScriptCmd_MPY: TToolButton;
    btnCrcCalc: TBitBtn;
    btnCrcXOR: TBitBtn;
    btnCrcSUM16: TBitBtn;
    btnCrcSUM8: TBitBtn;
    btnCrc_CRC16_CCITT: TToolButton;
    btnCrc_CRC16_CCITT_FALSE: TToolButton;
    btnCrc_CRC16_DNP: TToolButton;
    btnCrc_CRC16_IBM: TToolButton;
    btnCrc_CRC16_MAXIM: TToolButton;
    btnCrc_CRC16_MODBUS: TToolButton;
    btnCrc_CRC16_USB: TToolButton;
    btnCrc_CRC16_X25: TToolButton;
    btnCrc_CRC16_XMODEM: TToolButton;
    btnCrc_CRC32: TToolButton;
    btnCrc_CRC32_MPEG2: TToolButton;
    btnCrc_CRC32_JAMCRC: TToolButton;
    btnCrc_CRC4_ITU: TToolButton;
    btnCrc_CRC5_EPC: TToolButton;
    btnCrc_CRC5_ITU: TToolButton;
    btnCrc_CRC5_USB: TToolButton;
    btnCrc_CRC6_ITU: TToolButton;
    btnCrc_CRC7_MMC: TToolButton;
    btnCrc_CRC8: TToolButton;
    btnCrc_CRC8_ITU: TToolButton;
    btnCrc_CRC8_MAXIM: TToolButton;
    btnCrc_CRC8_ROHC: TToolButton;
    btnScriptNew_LittleC: TToolButton;
    btnScriptNew_Graph: TToolButton;
    btnScriptNew_MPY: TToolButton;
    btnScriptNew_Pascal: TToolButton;
    ilBookmark1: TImageList;
    ilBookmark3: TImageList;
    ilBookmark4: TImageList;
    ilBookmark2: TImageList;
    lbOptionEditor: TLabel;
    btnScriptOpen_LittleC: TToolButton;
    btnScriptOpen_Graph: TToolButton;
    btnScriptOpen_MPY: TToolButton;
    btnScriptOpen_Pascal: TToolButton;
    btnScriptPanelMode_LittleC: TToolButton;
    btnScriptPanelMode_Graph: TToolButton;
    btnScriptPanelMode_MPY: TToolButton;
    btnScriptPanelMode_Pascal: TToolButton;
    btnScriptRun_LittleC: TToolButton;
    btnScriptRun_Graph: TToolButton;
    btnScriptRun_MPY: TToolButton;
    btnScriptRun_Pascal: TToolButton;
    btnScriptSaveAs_LittleC: TToolButton;
    btnScriptSaveAs_Graph: TToolButton;
    btnScriptSaveas_MPY: TToolButton;
    btnScriptSaveAs_Pascal: TToolButton;
    btnScriptSavePic_Graph: TToolButton;
    btnScriptSave_LittleC: TToolButton;
    btnScriptSave_Graph: TToolButton;
    btnScriptSave_MPY: TToolButton;
    btnScriptSave_Pascal: TToolButton;
    OpenGITEE: TSpeedButton;
    OpenGITHUB: TSpeedButton;
    Panel4: TPanel;
    PSImport_ComObj: TPSImport_ComObj;
    PSImport_Controls: TPSImport_Controls;
    PSImport_DateUtils: TPSImport_DateUtils;
    PSImport_Forms: TPSImport_Forms;
    PSImport_StdCtrls: TPSImport_StdCtrls;
    rmoAboutChangeLog: TRichMemo;
    rmoAboutReadme: TRichMemo;
    rmoAboutAddNew: TRichMemo;
    scbOption3: TScrollBox;
    ShowGear: TSpeedButton;
    btnScriptShowGraphForm: TToolButton;
    btnScriptStop_LittleC: TToolButton;
    btnScriptStop_Graph: TToolButton;
    btnScriptStop_MPY: TToolButton;
    btnScriptStop_Pascal: TToolButton;
    ButtonPanelOption: TButtonPanel;
    chkOptionButtonFlatsytle: TCheckBox;
    chkOptionTrayIcon: TCheckBox;
    chkOptionErrlogEn: TCheckBox;
    chkOptionRMCCopy: TCheckBox;
    chkOptionTabAlternateColor: TCheckBox;
    chkOptionTableFlatsytle: TCheckBox;
    chkOptionCloseToTray: TCheckBox;
    chkOptionMinimizeToTray: TCheckBox;
    chkChecksumFileCRC32: TCheckBox;
    chkChecksumFileMD5: TCheckBox;
    chkChecksumFileSHA1: TCheckBox;
    chkCrcHexMode: TCheckBox;
    chkCrcInvIn: TCheckBox;
    chkCrcInvOut: TCheckBox;
    chkChecksumFileAutoVerify: TCheckBox;
    chkChecksumFileAutosavetofile: TCheckBox;
    cbbOptionLanguage: TComboBox;
    btnOptionTabAlternateColor: TColorButton;
    dlgOpen_Graph: TOpenDialog;
    dlgOpen_LittleC: TOpenDialog;
    dlgOpen_MPY: TOpenDialog;
    dlgOpen_Pascal: TOpenDialog;
    dlgSave_Graph: TSaveDialog;
    dlgSave_LittleC: TSaveDialog;
    dlgSave_MPY: TSaveDialog;
    dlgSave_Pascal: TSaveDialog;
    edtBaseCustom: TSpinEdit;
    edtCalcExpr: TEditButton;
    edtCrcHexResult: TEdit;
    edtCrcInitV: TEdit;
    edtCrcPolygon: TEdit;
    edtCrcResult: TEdit;
    edtCrcXOROUT: TEdit;
    edtDecimalDigitsConvertTemperature: TSpinEdit;
    dlgFont: TFontDialog;
    edtOptionPythonPath: TFileNameEdit;
    edtOptionLittleCPath: TFileNameEdit;
    edtOptionMPYPath: TFileNameEdit;
    gbOptionCalcInterpreter: TGroupBox;
    gbOptionLittleC: TGroupBox;
    ilICO: TImageList;
    ilOption: TImageList;
    ilTray: TImageList;
    ilMain: TImageList;
    ilConvert: TImageList;
    imgLogo: TImage;
    ilAbout: TImageList;
    lbOptionLittleCBinFilePath: TLabel;
    lbOptionMaxLineNumberOfScriptOutput: TLabel;
    lbDecimalDigits: TLabel;
    lbCalcExpression: TLabel;
    lbCalcResult: TLabel;
    lbConvertTimeDay: TLabel;
    lbConvertTimeDaysBetween: TLabel;
    lbConvertTimeHour: TLabel;
    lbConvertTimeHoursBetween: TLabel;
    lbConvertTimeMilliSecondsBetween: TLabel;
    lbConvertTimeMinute: TLabel;
    lbConvertTimeMinutesBetween: TLabel;
    lbConvertTimeMonth: TLabel;
    lbConvertTimeMonthsBetween: TLabel;
    lbConvertTimeSecond: TLabel;
    lbConvertTimeSecondsBetween: TLabel;
    lbConvertTimeTimeBetween: TLabel;
    lbConvertTimeValue: TLabel;
    lbConvertTimeWeeksBetween: TLabel;
    lbConvertTimeYear: TLabel;
    lbConvertTimeHoursOfTheYear: TLabel;
    lbConvertTimeMinutesOfTheDay: TLabel;
    lbConvertTimeSecondsOfTheDay: TLabel;
    lbConvertTimeSecondsOfTheMonth: TLabel;
    lbConvertTimeMinutesOfTheMonth: TLabel;
    lbConvertTimeHoursOfTheMonth: TLabel;
    lbConvertTimeSecondsOfTheYear: TLabel;
    lbConvertTimeMinutesOfTheYear: TLabel;
    lbConvertTimeWeeksOfTheYear: TLabel;
    lbConvertTimeDaysOfTheYear: TLabel;
    lbConvertTimeYearsBetween: TLabel;
    lbCalcVarAndFunc: TLabel;
    dlgLoadCalcWorkspace: TOpenDialog;
    lbAboutFreeware: TLabel;
    lbDigitBaseBase: TLabel;
    lbDigitBaseCustom: TLabel;
    lbDigitBaseNumber: TLabel;
    lbChecksumFiles: TLabel;
    lbCrcHexResult: TLabel;
    lbCrcDecimalResult: TLabel;
    lbOptionInterpreter: TLabel;
    lbOptionInterface: TLabel;
    lbOptionGeneral: TLabel;
    lbOptionLanguage: TLabel;
    lbOptionFont: TLabel;
    lbChecksumFileHint: TLabel;
    lbChecksumFileDescription: TLabel;
    lbName: TLabel;
    lbTinyCWebSite1: TLabel;
    lbTinyCWebSite2: TLabel;
    lbVer: TLabel;
    mmoScriptOut_LittleC: TMemo;
    mmoScriptOut_Graph: TMemo;
    mmoScriptOut_MPY: TMemo;
    mmoScriptOut_Pascal: TMemo;
    mmoOut_Temp: TMemo;
    mmoTmp: TMemo;
    miTrayExit: TMenuItem;
    miTrayN1: TMenuItem;
    miTrayOption: TMenuItem;
    mmoCRC: TMemo;
    mmoLicense: TMemo;
    PageControl1: TPageControl;
    pcConstant: TPageControl;
    Panel2: TPanel;
    pmScriptHis_LittleC: TPopupMenu;
    pmScriptHis_Graph: TPopupMenu;
    pmScriptHis_Pascal: TPopupMenu;
    pmScriptNew_LittleC: TPopupMenu;
    pmScriptNew_Graph: TPopupMenu;
    pmScriptNew_Pascal: TPopupMenu;
    pnlOptionTv: TPanel;
    pnlBase: TPanel;
    pnlCalcExpr: TPanel;
    pnlConvertTime: TPanel;
    pnlConvertTimeValue: TPanel;
    pcConvert: TPageControl;
    pnlAbout: TPanel;
    Panel3: TPanel;
    pnlOptionFontPreview: TPanel;
    pcDigit: TPageControl;
    pcScript: TPageControl;
    pcMain: TPageControl;
    pcChecksum: TPageControl;
    Panel1: TPanel;
    pmTray: TPopupMenu;
    pmTrayShow: TMenuItem;
    pnlCalcVar: TPanel;
    pmHisCalc: TPopupMenu;
    pmScriptHis_MPY: TPopupMenu;
    pmScriptNew_MPY: TPopupMenu;
    ProcessLittleC: TProcess;
    ProcessMPY: TProcess;
    ProcessPY: TProcess;
    PSImport_Classes: TPSImport_Classes;
    PSScript: TPSScript;
    dlgSaveCalcWorkspace: TSaveDialog;
    rbOptionCalcUseMPY: TRadioButton;
    rbOptionCalcUsePython: TRadioButton;
    rbCrc12bits: TRadioButton;
    rbCrc16bits: TRadioButton;
    rbCrc32bits: TRadioButton;
    rbCrc4bits: TRadioButton;
    rbCrc5bits: TRadioButton;
    rbCrc6bits: TRadioButton;
    rbCrc7bits: TRadioButton;
    rbCrc8bits: TRadioButton;
    scbOption0: TScrollBox;
    scbOption1: TScrollBox;
    scbOption2: TScrollBox;
    sgBase: TStringGrid;
    sgChecksumFile: TStringGrid;
    btnOptionSelectFont: TSpeedButton;
    btnCrcBufLen: TSpeedButton;
    sgConvertTemperature: TStringGrid;
    sgConvertTimeValue: TStringGrid;
    edtOptionMaxLineNumberOfScriptOutput: TSpinEdit;
    splScript_LittleC: TSplitter;
    splScript_Graph: TSplitter;
    Splitter1: TSplitter;
    SplitterCalc: TSplitter;
    sgCalcExpr: TStringGrid;
    mmoCalcFunc: TSynEdit;
    sgConvertTime: TStringGrid;
    splScript_MPY: TSplitter;
    splScript_Pascal: TSplitter;
    sgOptionTableDemo: TStringGrid;
    SynCppSyn: TSynCppSyn;
    synEditScript_LittleC: TSynEdit;
    synEditScript_Graph: TSynEdit;
    synEditScript_MPY: TSynEdit;
    synEditScript_Pascal: TSynEdit;
    SynPasSyn: TSynPasSyn;
    SynPythonSyn: TSynPythonSyn;
    btnCalcWorkspaceName: TToolButton;
    btnCalcClearHis: TToolButton;
    tlbScript_LittleC: TToolBar;
    ToolBar16: TToolBar;
    ToolBar8: TToolBar;
    tlbScript_MPY: TToolBar;
    ToolButton17: TToolButton;
    ToolButton28: TToolButton;
    ToolButton30: TToolButton;
    ToolButton32: TToolButton;
    ToolButton33: TToolButton;
    ToolButton34: TToolButton;
    ToolButton35: TToolButton;
    ToolButton38: TToolButton;
    ToolButton40: TToolButton;
    ToolButton42: TToolButton;
    ToolButton43: TToolButton;
    ToolButton44: TToolButton;
    tsAboutChangelog: TTabSheet;
    tsAboutLicense: TTabSheet;
    tsAboutNote: TTabSheet;
    TabSheet: TTabSheet;
    tsAboutHelp: TTabSheet;
    tsSolve: TTabSheet;
    ToolBar7: TToolBar;
    btnConvertTemperatureDecimalPlaces: TToolButton;
    ToolButton1: TToolButton;
    tsConvertTemperature: TTabSheet;
    tsConvertTime: TTabSheet;
    tvOption: TTreeView;
    tsOption: TTabSheet;
    TmrRun: TTimer;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    ToolBar3: TToolBar;
    tbChecksumCRCPoly: TToolBar;
    ToolBar6: TToolBar;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    btnCrc_CRC8_CDMA2000: TToolButton;
    btnCrc_CRC8_WCDMA: TToolButton;
    btnCrc_CRC32_BZIP2: TToolButton;
    btnCrc_CRC32_POSIX: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    btnDigitBaseCustom: TToolButton;
    ToolButton2: TToolButton;
    ToolButton21: TToolButton;
    btnCrcPolygon: TToolButton;
    btnCrcInitV: TToolButton;
    ToolButton5: TToolButton;
    btnCrcXOROUT: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    tsDigitBigint: TTabSheet;
    tsDigitBigfloat: TTabSheet;
    tsScriptPascal: TTabSheet;
    tsScriptMpy: TTabSheet;
    tsScriptLittleC: TTabSheet;
    tsScriptGraph: TTabSheet;
    tsDigitBase: TTabSheet;
    tmrICO: TTimer;
    tbCalc: TToolBar;
    btnCalcSave: TToolButton;
    btnCalcSaveAs: TToolButton;
    btnCalcOpen: TToolButton;
    btnCalcNew: TToolButton;
    TrayIcon: TTrayIcon;
    tsAbout: TTabSheet;
    tsChecksum: TTabSheet;
    tsDigit: TTabSheet;
    tsConvert: TTabSheet;
    tsChecksumCrc: TTabSheet;
    tsChecksumFile: TTabSheet;
    tsCalc: TTabSheet;
    tsScript: TTabSheet;
    tsContant: TTabSheet;
    procedure ApplicationPropertiesException(Sender: TObject; E: Exception);
    procedure btnCalcClearHisClick(Sender: TObject);
    procedure btnCalcNewClick(Sender: TObject);
    procedure btnCalcOpenClick(Sender: TObject);
    procedure btnCalcSaveAsClick(Sender: TObject);
    procedure btnCalcSaveClick(Sender: TObject);
    procedure btnCrcCalcClick(Sender: TObject);
    procedure btnCrcSUM8Click(Sender: TObject);
    procedure btnCrcXORClick(Sender: TObject);
    procedure btnCrc_CRC16_CCITTClick(Sender: TObject);
    procedure btnCrc_CRC16_CCITT_FALSEClick(Sender: TObject);
    procedure btnCrc_CRC16_DNPClick(Sender: TObject);
    procedure btnCrc_CRC16_IBMClick(Sender: TObject);
    procedure btnCrc_CRC16_MAXIMClick(Sender: TObject);
    procedure btnCrc_CRC16_MODBUSClick(Sender: TObject);
    procedure btnCrc_CRC16_USBClick(Sender: TObject);
    procedure btnCrc_CRC16_X25Click(Sender: TObject);
    procedure btnCrc_CRC16_XMODEMClick(Sender: TObject);
    procedure btnCrc_CRC32Click(Sender: TObject);
    procedure btnCrc_CRC32_BZIP2Click(Sender: TObject);
    procedure btnCrc_CRC32_JAMCRCClick(Sender: TObject);
    procedure btnCrc_CRC32_MPEG2Click(Sender: TObject);
    procedure btnCrc_CRC32_POSIXClick(Sender: TObject);
    procedure btnCrc_CRC4_ITUClick(Sender: TObject);
    procedure btnCrc_CRC5_EPCClick(Sender: TObject);
    procedure btnCrc_CRC5_ITUClick(Sender: TObject);
    procedure btnCrc_CRC5_USBClick(Sender: TObject);
    procedure btnCrc_CRC6_ITUClick(Sender: TObject);
    procedure btnCrc_CRC7_MMCClick(Sender: TObject);
    procedure btnCrc_CRC8Click(Sender: TObject);
    procedure btnCrc_CRC8_CDMA2000Click(Sender: TObject);
    procedure btnCrc_CRC8_ITUClick(Sender: TObject);
    procedure btnCrc_CRC8_MAXIMClick(Sender: TObject);
    procedure btnCrc_CRC8_ROHCClick(Sender: TObject);
    procedure btnCrc_CRC8_WCDMAClick(Sender: TObject);
    procedure btnScriptRun_GraphClick(Sender: TObject);
    procedure btnScriptRun_PascalClick(Sender: TObject);
    procedure btnScriptStop_PascalClick(Sender: TObject);
    procedure OpenGITEEClick(Sender: TObject);
    procedure OpenGITHUBClick(Sender: TObject);
    procedure btnOptionSelectFontClick(Sender: TObject);
    procedure btnOptionTabAlternateColorColorChanged(Sender: TObject);
    procedure btnScriptClear_GraphClick(Sender: TObject);
    procedure btnScriptClear_LittleCClick(Sender: TObject);
    procedure btnScriptClear_PascalClick(Sender: TObject);
    procedure btnScriptNew_GraphClick(Sender: TObject);
    procedure btnScriptNew_LittleCClick(Sender: TObject);
    procedure btnScriptNew_PascalClick(Sender: TObject);
    procedure btnScriptOpen_GraphClick(Sender: TObject);
    procedure btnScriptOpen_LittleCClick(Sender: TObject);
    procedure btnScriptOpen_PascalClick(Sender: TObject);
    procedure btnScriptPanelMode_MPYClick(Sender: TObject);
    procedure btnScriptClear_MPYClick(Sender: TObject);
    procedure btnScriptCmd_MPYClick(Sender: TObject);
    procedure btnScriptNew_MPYClick(Sender: TObject);
    procedure btnScriptOpen_MPYClick(Sender: TObject);
    procedure btnScriptRun_LittleCClick(Sender: TObject);
    procedure btnScriptRun_MPYClick(Sender: TObject);
    procedure btnScriptSaveAs_GraphClick(Sender: TObject);
    procedure btnScriptSaveAs_LittleCClick(Sender: TObject);
    procedure btnScriptSaveas_MPYClick(Sender: TObject);
    procedure btnScriptSaveAs_PascalClick(Sender: TObject);
    procedure btnScriptSave_GraphClick(Sender: TObject);
    procedure btnScriptSave_LittleCClick(Sender: TObject);
    procedure btnScriptSave_MPYClick(Sender: TObject);
    procedure btnScriptSave_PascalClick(Sender: TObject);
    procedure btnScriptStop_LittleCClick(Sender: TObject);
    procedure btnScriptStop_MPYClick(Sender: TObject);
    procedure chkChecksumFileCRC32Change(Sender: TObject);
    procedure chkOptionButtonFlatsytleChange(Sender: TObject);
    procedure chkOptionTableFlatsytleChange(Sender: TObject);
    procedure edtBaseCustomChange(Sender: TObject);
    procedure edtCalcExprButtonClick(Sender: TObject);
    procedure edtCalcExprKeyDown(Sender: TObject; var Key: word;
      Shift: TShiftState);
    procedure edtCalcExprKeyPress(Sender: TObject; var Key: char);
    procedure edtCrcHexResultClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormDropFiles(Sender: TObject; const FileNames: array of string);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure FormWindowStateChange(Sender: TObject);
    procedure gbOptionCalcInterpreterResize(Sender: TObject);
    procedure lbTinyCWebSite2Click(Sender: TObject);
    procedure miTrayExitClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure pcMainChange(Sender: TObject);
    procedure pmScriptHis_LittleCPopup(Sender: TObject);
    procedure pmScriptHis_MPYPopup(Sender: TObject);
    procedure PSScriptCompile(Sender: TPSScript);
    procedure sgBaseEditingDone(Sender: TObject);
    procedure sgCalcExprKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure sgCalcExprMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure sgChecksumFileClick(Sender: TObject);
    procedure sgChecksumFileHeaderSized(Sender: TObject; IsColumn: boolean;
      Index: integer);
    procedure sgConvertTimeButtonClick(Sender: TObject; aCol, aRow: integer);
    procedure sgConvertTimeEditingDone(Sender: TObject);
    procedure sgConvertTimeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure sgOptionTableDemoClick(Sender: TObject);
    procedure synEditScript_LittleCStatusChange(Sender: TObject;
      Changes: TSynStatusChanges);
    procedure synEditScript_MPYStatusChange(Sender: TObject;
      Changes: TSynStatusChanges);
    procedure synEditScript_PascalStatusChange(Sender: TObject;
      Changes: TSynStatusChanges);
    procedure tmrICOTimer(Sender: TObject);
    procedure TrayIconClick(Sender: TObject);
    procedure tvOptionSelectionChanged(Sender: TObject);
  private
    CalcWorkspaceFileName: string;

    procedure sgAddLine(var sg: TStringGrid; maxcount: integer = 200);
    procedure sgScrollToLastLine(var sg: TStringGrid);

    procedure SaveCalcWorkspace(filename: string);
    procedure LoadCalcWorkspace(filename: string);
    procedure pmAdd(var pm: TPopupMenu; filename: string; maxcount: integer = 12);

    procedure miHisCalcClick(Sender: TObject);

    function getCrcBit: integer;
    procedure setCrcBit(bit: integer);
    procedure setCrcMode(bit: integer; poly: longword; v0: longword;
      XOROUT: longword; InvIn: boolean; InvOut: boolean);

    procedure updateLanguageList;
    procedure saveOption;
    procedure loadOption;
    procedure applyOption;

  private
    procedure clearConvert;
    procedure findConvert(lang: string);
    procedure loadConvert(filename: string);
    procedure sgConvertEditingDone(Sender: TObject);

  private
    procedure clearConstant;
    procedure findConstant(lang: string);
    procedure loadConstant(filename: string);

  private
    // Script
    Compiled_PascalScript: boolean;

    procedure mmoOutAdd(var mmo: TMemo; msg: string);
    procedure mmoOutAdd_MPY(msg: string);
    procedure mmoOutAdd_LittleC(msg: string);
    procedure mmoOutAdd_Graph(msg: string);
    procedure mmoOutAdd_Pascal(msg: string);

    procedure StrToPmScriptNew(pmstr: array of string; pm: TPopupMenu);
    procedure pmNewOnClick(Sender: TObject);

    procedure pmScriptHisAdd(var pm: TPopupMenu; FileName: string);
    procedure pmScriptHisClick(Sender: TObject);

    procedure LoadScriptFile(syn: TSynEdit; FileName: string);
    procedure SaveScriptFile(syn: TSynEdit; FileName: string);

  public
    // Option
    MinimizeToTray, CloseToTray: boolean;
    TableFlatStyle, ButtonFlatStyle: boolean;
    TabAlternateColorEn: boolean;
    TabAlternateColor: TColor;
    RMCCopy: boolean;

    MaxLineNumberOfScriptOutput: integer;

    winstat: TWindowState;
    DateTimefmt: TFormatSettings;

    path_MPY, path_Python, path_LittleC: string;
    CalcUseMpy: boolean;

    errlog_en: boolean;
    errlogfile: string;
    procedure errlog(msg: string);

    procedure setLang(lang: string);
  public
    UpTime, RunTimeM: integer;
    function RunTimeToDHMStr(T: integer): string;

  public
    function ChrToByte(ch: char): byte;
    function Chr2ToByte(c1: char; c2: char): byte;
    function BigBytes(s: string): string;
    function IntToByteStr(d: dword): string;
    procedure StrToBytes(s: string; n: integer; var buf: SysUtils.TByteArray);
    procedure StrToByteBuf(s: string; out bs: string);

    function StrToXY(dat: string; out x, y: integer): boolean;
  public
    procedure MPYRunTmpScript(sc: string; out res, err: string);
    procedure PYRunTmpScript(sc: string; out res, err: string);

  public
    procedure ConvertTime(d: TDateTime);
    procedure ConvertTime2(d: TDateTime);
    procedure TimeBetween;

  end;

var
  frmMain: TfrmMain;
  ini: TIniFile;
  lang: string;
  ReadonlyMode: boolean;
  r: float;
  AppPath: string;

implementation

uses
  uCRC, uBase;

{$R *.lfm}

{ pascal script addon functions }

procedure PSWrite(const v: array of variant);
var
  i: integer;
  s, ss: string;
begin
  s := '';
  for i := low(v) to high(v) do
  begin
    ss := v[i];
    s  := s + ss;
  end;
  frmMain.mmoOutAdd_Pascal(s);
  Application.ProcessMessages;
end;

procedure PSWriteln(const v: array of variant);
begin
  PSWrite(v);
  PSWrite([#13#10]);
end;

function PSFormat(const Fmt: string; const Args: array of const): string;
begin
  Result := Format(Fmt, Args);
  Application.ProcessMessages;
end;

function PSlog(x: double): double;
begin
  Result := ln(x);
  Application.ProcessMessages;
end;

function PSlog2(x: double): double;
begin
  Result := log2(x);
  Application.ProcessMessages;
end;

function PSlog10(x: double): double;
begin
  Result := log10(x);
  Application.ProcessMessages;
end;

function PSlogN(n, x: double): double;
begin
  Result := logN(n, x);
  Application.ProcessMessages;
end;

function PSPower(x, y: double): double;
begin
  Result := power(x, y);
  Application.ProcessMessages;
end;

function PSExp(x: double): double;
begin
  Result := exp(x);
  Application.ProcessMessages;
end;

function PStan(x: double): double;
begin
  Result := tan(x);
  Application.ProcessMessages;
end;

function PSarcsin(x: double): double;
begin
  Result := arcsin(x);
  Application.ProcessMessages;
end;

function PSarccos(x: double): double;
begin
  Result := arccos(x);
  Application.ProcessMessages;
end;

function PSarctan(x: double): double;
begin
  Result := arctan2(x, 1);
  Application.ProcessMessages;
end;

function PSsinh(x: double): double;
begin
  Result := sinh(x);
  Application.ProcessMessages;
end;

function PScosh(x: double): double;
begin
  Result := cosh(x);
  Application.ProcessMessages;
end;

function PStanh(x: double): double;
begin
  Result := tanh(x);
  Application.ProcessMessages;
end;

function PSfloor(x: double): double;
begin
  Result := floor(x);
  Application.ProcessMessages;
end;

function PSceil(x: double): double;
begin
  Result := ceil(x);
  Application.ProcessMessages;
end;

function PSRandom: double;
begin
  Result := Random;
  Application.ProcessMessages;
end;

function PSRandomRange(x, y: integer): integer;
begin
  Result := Randomrange(x, y);
  Application.ProcessMessages;
end;

function PSReadln(const question: string): string;
begin
  Result := InputBox(question, '', '');
  Application.ProcessMessages;
end;

procedure PSclear;
begin
  frmMain.mmoScriptOut_Pascal.Lines.Clear;
  Application.ProcessMessages;
end;

procedure PSsleep(x: integer = 1000);
begin
  Sleep(x);
  Application.ProcessMessages;
end;

procedure PSbeep;
begin
  beep;
  Application.ProcessMessages;
end;

{ pascal script end }

{ TfrmMain }

procedure TfrmMain.tmrICOTimer(Sender: TObject);
begin

  tmrICO.Tag := tmrICO.Tag + 1;
  if tmrICO.Tag > 1023 then
  begin
    tmrICO.Tag      := 0;
    tmrICO.Interval := Random(4) * 40 + 100;
  end;

  if (tmrICO.Tag mod 4) = 0 then
  begin
    ilTray.Tag := (ilTray.Tag + 1) mod ilTray.Count;
    ilTray.GetIcon(ilTray.Tag, TrayIcon.Icon);
  end;

  ShowGear.ImageIndex :=
    (ShowGear.ImageIndex + ilOption.Count + ShowGear.Tag) mod ilOption.Count;
  if (tmrICO.Tag mod 32) = 0 then
  begin
    ilICO.Tag := (ilICO.Tag + 1) mod ilICO.Count;
    ilICO.GetIcon(ilICO.Tag, frmMain.Icon);

    if Random(2) = 0 then
      ShowGear.Tag := 1
    else
      ShowGear.Tag := -1;
  end;

end;

procedure TfrmMain.TrayIconClick(Sender: TObject);
begin
  // resotre main form
  if WindowState = wsMinimized then
    WindowState := winstat;
  Show;
  Application.BringToFront;
end;

procedure TfrmMain.tvOptionSelectionChanged(Sender: TObject);
var
  scb: TScrollBox;
begin
  scb := TScrollBox(FindComponent('scbOption' + IntToStr(tvOption.Selected.Index)));
  if scb = nil then
    Exit;
  scb.Align := alClient;
  scb.BringToFront;
end;

procedure TfrmMain.sgAddLine(var sg: TStringGrid; maxcount: integer);
begin
  if sg.RowCount > maxcount then
    sg.DeleteRow(1);
  sg.RowCount := sg.RowCount + 1;
end;

procedure TfrmMain.sgScrollToLastLine(var sg: TStringGrid);
begin
  sg.TopRow := sg.RowCount - 1;
end;

procedure TfrmMain.SaveCalcWorkspace(filename: string);
var
  fini: TIniFile;
  i: integer;
  s: string;
begin
  fini := TIniFile.Create(filename);
  try
    fini.EraseSection('workspace');
    fini.WriteString('workspace', 'expr', edtCalcExpr.Text);
    s := mmoCalcFunc.Lines.CommaText;
    s := '"' + s + '"';
    fini.WriteString('workspace', 'func', s);
    fini.WriteInteger('workspace', 'hisnum', sgCalcExpr.RowCount - 1);
    for i := 1 to sgCalcExpr.RowCount - 1 do
    begin
      fini.WriteString('workspace', 'expr' + IntToStr(i), sgCalcExpr.Cells[1, i]);
      fini.WriteString('workspace', 'res' + IntToStr(i), sgCalcExpr.Cells[2, i]);
    end;

    fini.UpdateFile;
    mmoCalcFunc.Modified := False;
    btnCalcSave.Enabled  := False;
  finally
    btnCalcWorkspaceName.Caption :=
      '<' + ChangeFileExt(ExtractFileName(filename), '') + '>';
    fini.Free;
  end;
end;

procedure TfrmMain.LoadCalcWorkspace(filename: string);
var
  fini: TIniFile;
  s1, s2: string;
  i: integer;
begin
  sgCalcExpr.RowCount := 1;
  fini := TIniFile.Create(filename);
  try
    edtCalcExpr.Text := fini.ReadString('workspace', 'expr', '');
    s1 := fini.ReadString('workspace', 'func', '');
    mmoCalcFunc.Lines.CommaText := s1;
    for i := 1 to fini.ReadInteger('workspace', 'hisnum', 0) do
    begin
      sgAddLine(sgCalcExpr);
      s1 := fini.ReadString('workspace', 'expr' + IntToStr(i), '');
      s2 := fini.ReadString('workspace', 'res' + IntToStr(i), '');
      if s1 <> '' then
      begin
        sgCalcExpr.Cells[1, i] := s1;
        sgCalcExpr.Cells[2, i] := s2;
      end;
    end;

    sgScrollToLastLine(sgCalcExpr);
    sgCalcExpr.Tag      := sgCalcExpr.RowCount - 1;
    mmoCalcFunc.Modified := False;
    btnCalcSave.Enabled := False;
  finally
    CalcWorkspaceFileName := filename;
    btnCalcWorkspaceName.Caption :=
      '<' + ChangeFileExt(ExtractFileName(filename), '') + '>';
    fini.Free;
  end;
end;

procedure TfrmMain.pmAdd(var pm: TPopupMenu; filename: string; maxcount: integer);
var
  mi: TMenuItem;
begin
  if FileName = '' then
    Exit;

  mi := pm.Items.Find(filename);
  // Add new history file
  if mi = nil then
  begin
    // max history files
    if pm.Items.Count > maxcount then
      pm.Items.Delete(maxcount - 1);

    mi := TMenuItem.Create(pm);
    mi.Caption := filename;
    if pm = pmHisCalc then
    begin
      mi.OnClick := @miHisCalcClick;
    end;

    mi.GroupIndex := 1;
    mi.RadioItem  := True;
    mi.AutoCheck  := True;

    pm.Items.Insert(0, mi);
    pm.Items[0].Checked := True;
  end
  else
  begin
    // move filename to first
    if mi.MenuIndex = 0 then
      Exit;
    pm.Items.Remove(mi);
    pmAdd(pm, filename, maxcount);
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  i: integer;
  BuildNum: string;
  FileVerInfo: TFileVersionInfo;
begin
  FileVerInfo := TFileVersionInfo.Create(nil);
  try
    FileVerInfo.ReadFileInfo;
    BuildNum := 'V' + FileVerInfo.VersionStrings.Values['FileVersion'];
  finally
    FileVerInfo.Free;
  end;

  lbVer.Caption := BuildNum;

  tsSolve.TabVisible := False;
  tsScriptGraph.TabVisible := False;
  tsDigitBigint.TabVisible := False;
  tsDigitBigfloat.TabVisible := False;

  AppPath := ExtractFilePath(Application.ExeName);
  ini     := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  errlogfile := ChangeFileExt(Application.ExeName, '.err');

  updateLanguageList;

  try
    UpTime      := ini.ReadInteger('run', 'UpTime', 0);
    RunTimeM    := MinuteOf(now);
    imgLogo.Tag := ini.ReadInteger('run', 'count', 0) + 1;
    ini.WriteInteger('run', 'count', imgLogo.Tag);
    ReadonlyMode := False;
  except

    ReadonlyMode := True;
  end;

  // option
  loadOption;
  applyOption;
  tvOption.Select(tvOption.Items[0]);
  tvOptionSelectionChanged(nil);


  // last
  Left   := ini.ReadInteger('last', 'Left', Left);
  Top    := ini.ReadInteger('last', 'Top', Top);
  Width  := ini.ReadInteger('last', 'Width', Width);
  Height := ini.ReadInteger('last', 'Height', Height);

  pcMain.ActivePageIndex := ini.ReadInteger('last', 'page', 0);

  {// check micropython exist
  if not FileExists(AppPath + MICROPYTHON_BIN_NAME) then
  begin
    ShowMessage('MicroPython is not found, path:' + #13#10#13#10 +
      AppPath + #13#10 + MICROPYTHON_BIN_NAME + #13#10#13#10 +
      'Please reinstall CalcToolbox!');
    tsCalc.Enabled := False;
  end
  else
  begin
    ProcessMPY.Executable := AppPath + MICROPYTHON_BIN_NAME;
  end;}

  // Calc
  pnlCalcVar.Width      := ini.ReadInteger('calc', 'pnlvar_width', pnlCalcVar.Width);
  CalcWorkspaceFileName := ini.ReadString('calc', 'Workspace',
    'script/calc/Workspace.calc');
  if CalcWorkspaceFileName = '' then
    CalcWorkspaceFileName := 'script/calc/Workspace.calc';

  for i := ini.ReadInteger('calc', 'WorkspaceHisfileCount', 0) downto 1 do
  begin
    pmAdd(pmHisCalc, ini.ReadString('calc', 'WorkspaceHisfile' + IntToStr(i), ''));
  end;

  if (ini.ReadInteger('calc', 'WorkspaceHisfileCount', 0) = 0) then
    pmAdd(pmHisCalc, CalcWorkspaceFileName);

  // Checksum
  pcChecksum.ActivePageIndex := ini.ReadInteger('Checksum', 'page', 0);

  //   CRC
  edtCrcPolygon.Text   := ini.ReadString('CRC', 'poly', '1021');
  edtCrcInitV.Text     := ini.ReadString('CRC', 'v0', '0');
  edtCrcXOROUT.Text    := ini.ReadString('CRC', 'XOROUT', '0');
  chkCrcInvIn.Checked  := ini.ReadBool('CRC', 'InvIn', False);
  chkCrcInvOut.Checked := ini.ReadBool('CRC', 'InvOut', False);
  setCrcBit(ini.ReadInteger('CRC', 'bit', 16));
  chkCrcHexMode.Checked := ini.ReadBool('CRC', 'HEXmode', True);
  mmoCRC.Text := ini.ReadString('CRC', 'dat', '20210331');

  //   File
  chkChecksumFileCRC32.Checked := ini.ReadBool('ChecksumFile', 'CRC32', True);
  chkChecksumFileMD5.Checked   := ini.ReadBool('ChecksumFile', 'MD5', True);
  chkChecksumFileSHA1.Checked  := ini.ReadBool('ChecksumFile', 'SHA1', True);
  chkChecksumFileAutoVerify.Checked := ini.ReadBool('ChecksumFile', 'AutoVerify', False);
  chkChecksumFileAutosavetofile.Checked :=
    ini.ReadBool('ChecksumFile', 'AutoSaveToFile', False);

  sgChecksumFile.Columns[0].Tag := ini.ReadInteger('ChecksumFile', 'Width0', 180);
  sgChecksumFile.Columns[1].Tag := ini.ReadInteger('ChecksumFile', 'Width1', 72);
  sgChecksumFile.Columns[2].Tag := ini.ReadInteger('ChecksumFile', 'Width2', 160);
  sgChecksumFile.Columns[3].Tag := ini.ReadInteger('ChecksumFile', 'Width3', 160);
  if sgChecksumFile.Columns[0].Tag > 0 then
    sgChecksumFile.Columns[0].Width := sgChecksumFile.Columns[0].Tag;
  if sgChecksumFile.Columns[1].Tag > 0 then
    sgChecksumFile.Columns[1].Width := sgChecksumFile.Columns[1].Tag;
  if sgChecksumFile.Columns[2].Tag > 0 then
    sgChecksumFile.Columns[2].Width := sgChecksumFile.Columns[2].Tag;
  if sgChecksumFile.Columns[3].Tag > 0 then
    sgChecksumFile.Columns[3].Width := sgChecksumFile.Columns[3].Tag;


  // Digit
  //   Base
  edtBaseCustom.Value := ini.ReadInteger('base', 'custom', 3);

  // Convert

  //   Time
  sgConvertTime.Height := ini.ReadInteger('convert', 'TimeHeight', 84);

  // Script
  pcScript.PageIndex := ini.ReadInteger('Script', 'page', 2);

  //   Little C
  StrToPmScriptNew(NewFileTemplate_LittleC, pmScriptNew_LittleC);
  if ini.ReadBool('LittleC', 'Vert', False) then
    splScript_LittleC.Align := alTop
  else
    splScript_LittleC.Align := alLeft;
  btnScriptPanelMode_MPYClick(btnScriptPanelMode_LittleC);

  dlgSave_LittleC.FileName := ini.ReadString('LittleC', 'File', '');
  if dlgSave_LittleC.FileName <> '' then
    LoadScriptFile(synEditScript_LittleC, dlgSave_LittleC.FileName);

  for i := 1 to ini.ReadInteger('LittleC', 'HisFileCount', 0) do
    pmScriptHisAdd(pmScriptHis_LittleC, ini.ReadString('LittleC',
      'HisFile' + IntToStr(i), ''));

  //   MPY
  StrToPmScriptNew(NewFileTemplate_MPY, pmScriptNew_MPY);
  if ini.ReadBool('MPY', 'Vert', False) then
    splScript_MPY.Align := alTop
  else
    splScript_MPY.Align := alLeft;
  btnScriptPanelMode_MPYClick(btnScriptPanelMode_MPY);

  dlgSave_MPY.FileName := ini.ReadString('MPY', 'File', '');
  if dlgSave_MPY.FileName <> '' then
    LoadScriptFile(synEditScript_MPY, dlgSave_MPY.FileName);

  for i := 1 to ini.ReadInteger('MPY', 'HisFileCount', 0) do
    pmScriptHisAdd(pmScriptHis_MPY, ini.ReadString('MPY', 'HisFile' + IntToStr(i), ''));

  //   Paascal
  StrToPmScriptNew(NewFileTemplate_Pascal, pmScriptNew_Pascal);
  if ini.ReadBool('pascal', 'Vert', False) then
    splScript_Pascal.Align := alTop
  else
    splScript_Pascal.Align := alLeft;
  btnScriptPanelMode_MPYClick(btnScriptPanelMode_Pascal);
  Compiled_PascalScript := False;

  dlgSave_Pascal.FileName := ini.ReadString('pascal', 'File', '');
  if dlgSave_Pascal.FileName <> '' then
    LoadScriptFile(synEditScript_Pascal, dlgSave_Pascal.FileName);

  for i := 1 to ini.ReadInteger('pascal', 'HisFileCount', 0) do
    pmScriptHisAdd(pmScriptHis_Pascal, ini.ReadString('pascal', 'HisFile' +
      IntToStr(i), ''));

  //   graph
  StrToPmScriptNew(NewFileTemplate_Graph, pmScriptNew_Graph);
  if ini.ReadBool('graph', 'Vert', False) then
    splScript_Graph.Align := alTop
  else
    splScript_Graph.Align := alLeft;
  btnScriptPanelMode_MPYClick(btnScriptPanelMode_Graph);

  dlgSave_Graph.FileName := ini.ReadString('graph', 'File', '');
  if dlgSave_Graph.FileName <> '' then
    LoadScriptFile(synEditScript_Graph, dlgSave_Graph.FileName);

  for i := 1 to ini.ReadInteger('graph', 'HisFileCount', 0) do
    pmScriptHisAdd(pmScriptHis_Graph, ini.ReadString('graph', 'HisFile' +
      IntToStr(i), ''));
end;

procedure TfrmMain.edtCalcExprKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    edtCalcExprButtonClick(Sender);
  end;
end;

procedure TfrmMain.edtCrcHexResultClick(Sender: TObject);
begin
  Clipboard.AsText := TEdit(Sender).Text;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if TrayIcon.Visible and CloseToTray then
  begin
    CanClose := False;
    Hide;
  end
  else
  begin
    CanClose := True;
  end;
end;

procedure TfrmMain.edtCalcExprButtonClick(Sender: TObject);
var
  res, err, s: string;
  errline, ep: integer;
begin
  edtCalcExpr.Text := Trim(edtCalcExpr.Text);
  if edtCalcExpr.Text = '' then
    Exit;

  s := 'from math import *' + #13#10 + mmoCalcFunc.Lines.Text + #13#10 +
    'print("\n",' + edtCalcExpr.Text + ')';

  if CalcUseMpy then
    MPYRunTmpScript(s, res, err)
  else
    PYRunTmpScript(s, res, err);

  if err <> '' then
  begin
    beep;
    ep := pos('line ', err) + 5;
    s  := '';
    while err[ep] in ['0'..'9'] do
    begin
      s  := s + err[ep];
      ep := ep + 1;
    end;
    errline := StrToIntDef(s, 0);
    if (errline > 0) and (errline < (mmoCalcFunc.Lines.Count + 3)) then
    begin
      mmoCalcFunc.CaretX := 0;
      mmoCalcFunc.CaretY := errline - 1;
      mmoCalcFunc.SelectLine();
      mmoCalcFunc.SetFocus;
    end
    else
      edtCalcExpr.SetFocus;
  end;

  if res <> '' then
  begin
    if sgCalcExpr.Cells[1, sgCalcExpr.RowCount - 1] <> edtCalcExpr.Text then
    begin
      sgAddLine(sgCalcExpr);
      sgCalcExpr.Cells[1, sgCalcExpr.RowCount - 1] := edtCalcExpr.Text;
      sgCalcExpr.Cells[2, sgCalcExpr.RowCount - 1] := trim(res);
    end;
    sgScrollToLastLine(sgCalcExpr);
  end;
  sgCalcExpr.Tag := sgCalcExpr.RowCount - 1;
end;

procedure TfrmMain.edtCalcExprKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
var
  n: integer;
begin
  case Key of
    38: // UP
      n := -1;
    40: // DOWN
      n := 1;
    else
      inherited;
      Exit;
  end;
  Key := 0;

  if sgCalcExpr.RowCount < 2 then
    Exit;

  sgCalcExpr.Tag := (sgCalcExpr.Tag + n + sgCalcExpr.RowCount - 1) mod
    (sgCalcExpr.RowCount - 1);
  if (sgCalcExpr.TopRow >= (sgCalcExpr.Tag + 0)) then
    sgCalcExpr.TopRow := sgCalcExpr.Tag + 0
  else if ((sgCalcExpr.TopRow + sgCalcExpr.VisibleRowCount) <=
    (sgCalcExpr.Tag + 1 + 2)) then
    sgCalcExpr.TopRow  := sgCalcExpr.Tag + 1 + 2 - sgCalcExpr.VisibleRowCount;
  sgCalcExpr.Selection := Rect(1, sgCalcExpr.Tag + 1, 2, sgCalcExpr.Tag + 1);
  edtCalcExpr.Text     := sgCalcExpr.Cells[1, sgCalcExpr.Tag + 1];
end;

procedure TfrmMain.btnCalcNewClick(Sender: TObject);
begin
  mmoCalcFunc.Clear;
  sgCalcExpr.RowCount := 1;
  btnCalcWorkspaceName.Caption := 'workspace';
end;

procedure TfrmMain.btnCalcClearHisClick(Sender: TObject);
begin
  sgCalcExpr.RowCount := 1;
end;

procedure TfrmMain.ApplicationPropertiesException(Sender: TObject; E: Exception);
begin
  errlog(E.Message);
end;

procedure TfrmMain.btnCalcOpenClick(Sender: TObject);
begin
  if dlgLoadCalcWorkspace.Execute then
  begin
    CalcWorkspaceFileName := dlgLoadCalcWorkspace.FileName;
    pmAdd(pmHisCalc, CalcWorkspaceFileName);
    LoadCalcWorkspace(CalcWorkspaceFileName);
  end;
end;

procedure TfrmMain.btnCalcSaveAsClick(Sender: TObject);
begin
  if dlgSaveCalcWorkspace.Execute then
  begin
    CalcWorkspaceFileName := dlgSaveCalcWorkspace.FileName;
    pmAdd(pmHisCalc, CalcWorkspaceFileName);
    SaveCalcWorkspace(CalcWorkspaceFileName);
  end;
end;

procedure TfrmMain.btnCalcSaveClick(Sender: TObject);
begin
  if (CalcWorkspaceFileName = 'workspace.calc') or (CalcWorkspaceFileName = '') then
  begin
    btnCalcSaveAsClick(Sender);
  end
  else
  begin
    SaveCalcWorkspace(CalcWorkspaceFileName);
  end;
end;

procedure TfrmMain.btnCrcCalcClick(Sender: TObject);
const
  MaxLen = 4096;
var
  poly, v0, xorout, len, bit: dword;
  _poly, _v0, _xorout: integer;
  bufN, i, j: integer;
  buf: SysUtils.TByteArray;
  s: string;
begin
  bit := getCrcBit;

  if not TryStrToInt('0x' + edtCrcPolygon.Text, _poly) or not
    TryStrToInt('0x' + edtCrcInitV.Text, _v0) or not
    TryStrToInt('0x' + edtCrcXOROUT.Text, _xorout) then
  begin
    beep();
    Exit;
  end;

  poly   := _poly;
  v0     := _v0;
  xorout := _xorout;

  if chkCrcHexMode.Checked then
  begin

    if mmoCRC.Modified then
    begin
      StrToByteBuf(mmoCRC.Text, s);
      mmoCRC.Text     := s;
      mmoCRC.Modified := False;
    end;

    s    := mmoCRC.Text;
    bufN := (Length(s) + 2) div 3;
    if bufN = 0 then
      Exit;

    for i := 1 to ((bufN + MaxLen - 1) div MaxLen) do
    begin
      if i * MaxLen < bufN then
        len := MaxLen
      else
        len := bufN - (i - 1) * MaxLen;
      StrToBytes(s, len, buf);
      v0 := CalcCrc(buf, len, bit, poly, v0, xorout, chkCrcInvIn.Checked,
        chkCrcInvOut.Checked);
      Delete(s, 1, len * 3);
    end;
    if chkCrcInvOut.Checked then
    begin
      case bit of
        8: v0  := invByte(v0);
        12,
        16: v0 := invWord(v0);
        32: v0 := invDWord(v0);
      end;
    end;
    v0 := v0 xor xorout;
    btnCrcBufLen.Caption := Format('<%d>', [bufN]);
    edtCrcHexResult.Text := IntToByteStr(v0);
    edtCrcResult.Text := IntToStr(v0);
  end
  else
  begin
    s    := mmoCRC.Text;
    bufN := Length(s);
    for i := 1 to ((bufN + MaxLen - 1) div MaxLen) do
    begin
      if i * MaxLen <= bufN then
        len := MaxLen
      else
        len := bufN mod MaxLen;

      for j := 0 to len - 1 do
        buf[j] := Ord(s[j + 1]);

      v0 := CalcCrc(buf, len, bit, poly, v0, xorout, chkCrcInvIn.Checked,
        chkCrcInvOut.Checked);
      Delete(s, 1, len);
    end;
    if chkCrcInvOut.Checked then
    begin
      case bit of
        8: v0  := invByte(v0);
        12,
        16: v0 := invWord(v0);
        32: v0 := invDWord(v0);
      end;
    end;
    v0 := v0 xor xorout;
    btnCrcBufLen.Caption := Format('<%d>', [bufN]);
    edtCrcHexResult.Text := IntToByteStr(v0);
    edtCrcResult.Text := IntToStr(v0);

  end;
end;

procedure TfrmMain.btnCrcSUM8Click(Sender: TObject);
var
  i, len: integer;
  s: string;
  sum: word;
begin
  sum := 0;
  if chkCrcHexMode.Checked then
  begin
    StrToByteBuf(mmoCRC.Text, s);
    mmoCRC.Text := s;
    len := (Length(s) + 2) div 3;
    for i := 1 to len do
    begin
      sum := sum + Chr2ToByte(s[i * 3 - 2], s[i * 3 - 1]);
    end;
  end
  else
  begin
    s   := mmoCRC.Text;
    len := Length(s);
    for i := 1 to len do
      sum := sum + Ord(s[i]);
  end;

  sum := sum mod TToolButton(Sender).Tag;
  btnCrcBufLen.Caption := Format('<%d>', [len]);
  edtCrcHexResult.Text := IntToByteStr(sum);
  edtCrcResult.Text := IntToStr(sum);
end;

procedure TfrmMain.btnCrcXORClick(Sender: TObject);
var
  i, len: integer;
  s: string;
  sum: word;
begin
  if chkCrcHexMode.Checked then
  begin
    StrToByteBuf(mmoCRC.Text, s);
    mmoCRC.Text := s;
    len := (Length(s) + 2) div 3;
    if len = 0 then
      Exit;
    sum := Chr2ToByte(s[1], s[2]);
    for i := 2 to len do
    begin
      sum := sum xor Chr2ToByte(s[i * 3 - 2], s[i * 3 - 1]);
    end;
  end
  else
  begin
    s   := mmoCRC.Text;
    len := Length(s);
    if len = 0 then
      Exit;
    sum := Ord(s[1]);
    for i := 2 to len do
      sum := sum xor Ord(s[i]);
  end;

  btnCrcBufLen.Caption := Format('<%d>', [len]);
  edtCrcHexResult.Text := IntToByteStr(sum);
  edtCrcResult.Text    := IntToStr(sum);
end;

procedure TfrmMain.btnCrc_CRC16_CCITTClick(Sender: TObject);
begin
  setCrcMode(16, $1021, 0, 0, True, True);
end;

procedure TfrmMain.btnCrc_CRC16_CCITT_FALSEClick(Sender: TObject);
begin
  setCrcMode(16, $1021, $FFFF, 0, False, False);
end;

procedure TfrmMain.btnCrc_CRC16_DNPClick(Sender: TObject);
begin
  setCrcMode(16, $3D65, 0, $FFFF, True, True);
end;

procedure TfrmMain.btnCrc_CRC16_IBMClick(Sender: TObject);
begin
  setCrcMode(16, $8005, 0, 0, True, True);
end;

procedure TfrmMain.btnCrc_CRC16_MAXIMClick(Sender: TObject);
begin
  setCrcMode(16, $8005, 0, $FFFF, True, True);
end;

procedure TfrmMain.btnCrc_CRC16_MODBUSClick(Sender: TObject);
begin
  setCrcMode(16, $8005, $FFFF, 0, True, True);
end;

procedure TfrmMain.btnCrc_CRC16_USBClick(Sender: TObject);
begin
  setCrcMode(16, $8005, $FFFF, $FFFF, True, True);
end;

procedure TfrmMain.btnCrc_CRC16_X25Click(Sender: TObject);
begin
  setCrcMode(16, $1021, $FFFF, $FFFF, True, True);
end;

procedure TfrmMain.btnCrc_CRC16_XMODEMClick(Sender: TObject);
begin
  setCrcMode(16, $1021, 0, 0, False, False);
end;

procedure TfrmMain.btnCrc_CRC32Click(Sender: TObject);
begin
  setCrcMode(32, $04C11DB7, $FFFFFFFF, $FFFFFFFF, True, True);
end;

procedure TfrmMain.btnCrc_CRC32_BZIP2Click(Sender: TObject);
begin
  setCrcMode(32, $04C11DB7, $FFFFFFFF, $FFFFFFFF, False, False);
end;

procedure TfrmMain.btnCrc_CRC32_JAMCRCClick(Sender: TObject);
begin
  setCrcMode(32, $04C11DB7, $FFFFFFFF, 0, True, True);
end;

procedure TfrmMain.btnCrc_CRC32_MPEG2Click(Sender: TObject);
begin
  setCrcMode(32, $04C11DB7, $FFFFFFFF, 0, False, False);
end;

procedure TfrmMain.btnCrc_CRC32_POSIXClick(Sender: TObject);
begin
  setCrcMode(32, $04C11DB7, 0, $FFFFFFFF, False, False);
end;

procedure TfrmMain.btnCrc_CRC4_ITUClick(Sender: TObject);
begin
  setCrcMode(4, 3, 0, 0, True, True);
end;

procedure TfrmMain.btnCrc_CRC5_EPCClick(Sender: TObject);
begin
  setCrcMode(5, 9, 9, 0, False, False);
end;

procedure TfrmMain.btnCrc_CRC5_ITUClick(Sender: TObject);
begin
  setCrcMode(5, $15, 0, 0, True, True);
end;

procedure TfrmMain.btnCrc_CRC5_USBClick(Sender: TObject);
begin
  setCrcMode(5, 5, $1F, $1F, True, True);
end;

procedure TfrmMain.btnCrc_CRC6_ITUClick(Sender: TObject);
begin
  setCrcMode(6, 3, 0, 0, True, True);
end;

procedure TfrmMain.btnCrc_CRC7_MMCClick(Sender: TObject);
begin
  setCrcMode(7, 9, 0, 0, False, False);
end;

procedure TfrmMain.btnCrc_CRC8Click(Sender: TObject);
begin
  setCrcMode(8, 7, 0, 0, False, False);
end;

procedure TfrmMain.btnCrc_CRC8_CDMA2000Click(Sender: TObject);
begin
  setCrcMode(8, $9B, $FF, 0, False, False);
end;

procedure TfrmMain.btnCrc_CRC8_ITUClick(Sender: TObject);
begin
  setCrcMode(8, 7, 0, $55, False, False);
end;

procedure TfrmMain.btnCrc_CRC8_MAXIMClick(Sender: TObject);
begin
  setCrcMode(8, $31, 0, 0, True, True);
end;

procedure TfrmMain.btnCrc_CRC8_ROHCClick(Sender: TObject);
begin
  setCrcMode(8, 7, $FF, 0, True, True);
end;

procedure TfrmMain.btnCrc_CRC8_WCDMAClick(Sender: TObject);
begin
  setCrcMode(8, $9B, 0, 0, True, True);
end;

procedure TfrmMain.btnScriptRun_GraphClick(Sender: TObject);
begin
  //  12
end;

procedure TfrmMain.btnScriptRun_PascalClick(Sender: TObject);
var
  res: boolean;
  i: integer;
begin
  if btnScriptStop_Pascal.Enabled then
    Exit;

  synEditScript_Pascal.Cursor  := crHourGlass;
  btnScriptStop_Pascal.Enabled := True;
  btnScriptRun_Pascal.Enabled  := False;

  try
    try
      PSScript.Script.Text  := synEditScript_Pascal.Text;
      Compiled_PascalScript := PSScript.Compile;
      Application.ProcessMessages;

      if not Compiled_PascalScript then
      begin
        if PSScript.CompilerMessageCount > 0 then
          for i := 0 to PSScript.CompilerMessageCount - 1 do
            mmoScriptOut_Pascal.Lines.add(PSScript.CompilerErrorToStr(i));
        Exit;
      end;
      Application.ProcessMessages;

      res := PSScript.Execute;
      if not res then
        mmoScriptOut_Pascal.Lines.add('Run-time error:' +
          PSScript.ExecErrorToString);

    except
      on E: Exception do
      begin
        mmoScriptOut_Pascal.Lines.add(E.Message);
      end;
    end;

  finally
    btnScriptStop_Pascal.Enabled := False;
    btnScriptRun_Pascal.Enabled  := True;
    synEditScript_Pascal.Cursor  := crDefault;
  end;
end;

procedure TfrmMain.btnScriptStop_PascalClick(Sender: TObject);
begin
  btnScriptStop_Pascal.Enabled := False;
  btnScriptRun_Pascal.Enabled  := True;
  PSScript.Stop;
end;

procedure TfrmMain.OpenGITEEClick(Sender: TObject);
begin
  OpenURL(GITEE_URL);
end;

procedure TfrmMain.OpenGITHUBClick(Sender: TObject);
begin
  OpenURL(GITHUB_URL);
end;

procedure TfrmMain.btnOptionSelectFontClick(Sender: TObject);
begin
  if dlgFont.Execute then
  begin
    pnlOptionFontPreview.Caption :=
      dlgFont.Font.Name + ', ' + IntToStr(dlgFont.Font.Size);
    pnlOptionFontPreview.Font    := dlgFont.Font;
  end;
end;

procedure TfrmMain.btnOptionTabAlternateColorColorChanged(Sender: TObject);
begin
  sgOptionTableDemo.AlternateColor := btnOptionTabAlternateColor.ButtonColor;
end;

procedure TfrmMain.btnScriptClear_GraphClick(Sender: TObject);
begin
  mmoScriptOut_Graph.Clear;
end;

procedure TfrmMain.btnScriptClear_LittleCClick(Sender: TObject);
begin
  mmoScriptOut_LittleC.Clear;
end;

procedure TfrmMain.btnScriptClear_PascalClick(Sender: TObject);
begin
  mmoScriptOut_Pascal.Clear;
end;

procedure TfrmMain.btnScriptNew_GraphClick(Sender: TObject);
begin
  synEditScript_Graph.Clear;
  dlgSave_Graph.FileName := '';
  tsScriptGraph.Caption  := ScriptName[tsScriptGraph.PageIndex] + ' - newfile';
  btnScriptSave_Graph.Enabled := True;
  synEditScript_Graph.Modified := True;
end;

procedure TfrmMain.btnScriptNew_LittleCClick(Sender: TObject);
begin
  synEditScript_LittleC.Clear;
  dlgSave_LittleC.FileName := '';
  tsScriptLittleC.Caption  := ScriptName[tsScriptLittleC.PageIndex] + ' - newfile';
  btnScriptSave_LittleC.Enabled := True;
  synEditScript_LittleC.Modified := True;
end;

procedure TfrmMain.btnScriptNew_PascalClick(Sender: TObject);
begin
  synEditScript_Pascal.Clear;
  dlgSave_Pascal.FileName := '';
  tsScriptPascal.Caption  := '*' + ScriptName[tsScriptPascal.PageIndex] + ' - newfile';
  Compiled_PascalScript   := False;
  btnScriptSave_Pascal.Enabled := True;
  synEditScript_Pascal.Modified := True;
end;

procedure TfrmMain.btnScriptOpen_GraphClick(Sender: TObject);
begin
  if dlgOpen_Graph.Execute then
  begin
    LoadScriptFile(synEditScript_Graph, dlgOpen_Graph.FileName);
    pmScriptHisAdd(pmScriptHis_Graph, dlgOpen_Graph.FileName);
    dlgSave_Graph.FileName := dlgOpen_Graph.FileName;
  end;
end;

procedure TfrmMain.btnScriptOpen_LittleCClick(Sender: TObject);
begin
  if dlgOpen_LittleC.Execute then
  begin
    LoadScriptFile(synEditScript_LittleC, dlgOpen_LittleC.FileName);
    pmScriptHisAdd(pmScriptHis_LittleC, dlgOpen_LittleC.FileName);
    dlgSave_LittleC.FileName := dlgOpen_LittleC.FileName;
  end;
end;

procedure TfrmMain.btnScriptOpen_PascalClick(Sender: TObject);
begin
  if dlgOpen_Pascal.Execute then
  begin
    LoadScriptFile(synEditScript_Pascal, dlgOpen_Pascal.FileName);
    pmScriptHisAdd(pmScriptHis_Pascal, dlgOpen_Pascal.FileName);
    dlgSave_Pascal.FileName := dlgOpen_Pascal.FileName;
  end;

end;

procedure TfrmMain.btnScriptPanelMode_MPYClick(Sender: TObject);
var
  spl: TSplitter;
  syn: TSynEdit;
  btn: TToolButton;
  mmo: TMemo;
  s: string;
begin
  btn := TToolButton(Sender);
  s   := btn.Name;
  Delete(s, 1, Length('btnScriptPanelMode_'));
  spl := TSplitter(FindComponent('splScript_' + s));
  syn := TSynEdit(FindComponent('synEditScript_' + s));
  if spl.Align = alTop then
  begin
    syn.Align := alLeft;
    syn.Width := ini.ReadInteger(s, 'Width', 320);
    spl.Align := alLeft;
    spl.Left  := syn.Left + 10;
    btn.ImageIndex := 43;
    if ((syn.Width + 40) > Width) then
      syn.Width := Width - 40;
  end
  else
  begin
    syn.Align  := alTop;
    syn.Height := ini.ReadInteger(s, 'Height', 300);
    spl.Align  := alTop;
    spl.Top    := syn.Top + 10;
    btn.ImageIndex := 44;
    if ((syn.Height + 70) > Height) then
      syn.Height := Height - 70;
  end;

end;

procedure TfrmMain.btnScriptClear_MPYClick(Sender: TObject);
begin
  mmoScriptOut_MPY.Clear;
end;

procedure TfrmMain.btnScriptCmd_MPYClick(Sender: TObject);
var
  AProcess: TProcess;
  s, tmpfile: string;
begin
  tmpfile := GetTempFileName + '.py';
  mmoOut_Temp.Lines.Text := 'import sys' + #13#10 + 'sys.path.append("./lib")';
  mmoOut_Temp.Lines.SaveToFile(tmpfile);
  AProcess := TProcess.Create(nil);
  AProcess.Executable := ProcessMPY.Executable;
  AProcess.Options := AProcess.Options + [poNewConsole];
  AProcess.Parameters.Add('-i');
  AProcess.Parameters.Add(tmpfile);
  AProcess.Execute;
  AProcess.Free;
end;

procedure TfrmMain.btnScriptNew_MPYClick(Sender: TObject);
begin
  synEditScript_MPY.Clear;
  dlgSave_MPY.FileName := '';
  tsScriptMpy.Caption  := ScriptName[tsScriptMpy.PageIndex] + ' - newfile';
  btnScriptSave_MPY.Enabled := True;
  synEditScript_MPY.Modified := True;
end;

procedure TfrmMain.btnScriptOpen_MPYClick(Sender: TObject);
begin
  if dlgOpen_MPY.Execute then
  begin
    LoadScriptFile(synEditScript_MPY, dlgOpen_MPY.FileName);
    pmScriptHisAdd(pmScriptHis_MPY, dlgOpen_MPY.FileName);
    dlgSave_MPY.FileName := dlgOpen_MPY.FileName;
  end;
end;

procedure TfrmMain.btnScriptRun_LittleCClick(Sender: TObject);
var
  CharBuffer: array [0..511] of char;
  ReadCount: integer;
  filename: string;
begin
  if btnScriptStop_LittleC.Enabled then
    Exit;

  if synEditScript_LittleC.Modified then
  begin
    if dlgSave_LittleC.FileName = '' then
    begin
      // new file
      filename := GetTempFileName + '.c';
      synEditScript_LittleC.Lines.SaveToFile(filename);
    end
    else
    begin
      // file has been changed
      filename := GetTempFileName(ExtractFilePath(dlgSave_LittleC.FileName),
        'LC_') + '.c';
      synEditScript_LittleC.Lines.SaveToFile(filename);
    end;
  end
  else
  begin
    // file has been saved and not changed
    filename := dlgSave_MPY.FileName;
  end;

  synEditScript_LittleC.Cursor  := crHourGlass;
  btnScriptStop_LittleC.Enabled := True;
  btnScriptRun_LittleC.Enabled  := False;

  try

    ProcessLittleC.Parameters.Clear;
    ProcessLittleC.Parameters.Add('-run');
    ProcessLittleC.Parameters.Add(filename);
    ProcessLittleC.Execute;

    while ProcessLittleC.Running or (ProcessLittleC.Output.NumBytesAvailable > 0) or
      (ProcessLittleC.Stderr.NumBytesAvailable > 0) do
    begin
      Application.ProcessMessages;
      while ProcessLittleC.Output.NumBytesAvailable > 0 do
      begin
        ReadCount := Min(512, ProcessLittleC.Output.NumBytesAvailable);
        //Read up to buffer, not more
        ProcessLittleC.Output.Read(CharBuffer, ReadCount);
        mmoOutAdd_LittleC(Copy(CharBuffer, 0, ReadCount));
        Application.ProcessMessages;
      end;
      // read stderr and write to our stderr
      while ProcessLittleC.Stderr.NumBytesAvailable > 0 do
      begin
        ReadCount := Min(512, ProcessLittleC.Stderr.NumBytesAvailable);
        //Read up to buffer, not more
        ProcessLittleC.Stderr.Read(CharBuffer, ReadCount);
        mmoOutAdd_LittleC(Copy(CharBuffer, 0, ReadCount));
        Application.ProcessMessages;
      end;
    end;

  finally
    btnScriptStop_LittleC.Enabled := False;
    btnScriptRun_LittleC.Enabled  := True;
    synEditScript_LittleC.Cursor  := crDefault;
    if synEditScript_LittleC.Modified then
      DeleteFile(filename);
  end;
end;

procedure TfrmMain.btnScriptRun_MPYClick(Sender: TObject);
var
  CharBuffer: array [0..511] of char;
  ReadCount: integer;
  filename: string;
begin
  if not FileExists(ProcessMPY.Executable) then
  begin
    mmoOutAdd_MPY('## micropython not found' + #13#10);
    Exit;
  end;

  if btnScriptStop_MPY.Enabled then
    Exit;

  if synEditScript_MPY.Modified then
  begin
    if dlgSave_MPY.FileName = '' then
    begin
      // new file
      filename := GetTempFileName + '.py';
      synEditScript_MPY.Lines.SaveToFile(filename);
    end
    else
    begin
      // file has been changed
      filename := GetTempFileName(ExtractFilePath(dlgSave_MPY.FileName), 'MPY_') + '.py';
      synEditScript_MPY.Lines.SaveToFile(filename);
    end;
  end
  else
  begin
    // file has been saved and not changed
    filename := dlgSave_MPY.FileName;

  end;

  synEditScript_MPY.Cursor  := crHourGlass;
  btnScriptStop_MPY.Enabled := True;
  btnScriptRun_MPY.Enabled  := False;

  try

    ProcessMPY.Parameters.Clear;
    ProcessMPY.Parameters.Add(filename);
    ProcessMPY.Execute;

    while ProcessMPY.Running or (ProcessMPY.Output.NumBytesAvailable > 0) or
      (ProcessMPY.Stderr.NumBytesAvailable > 0) do
    begin
      while ProcessMPY.Output.NumBytesAvailable > 0 do
      begin
        ReadCount := Min(512, ProcessMPY.Output.NumBytesAvailable);
        //Read up to buffer, not more
        ProcessMPY.Output.Read(CharBuffer, ReadCount);
        mmoOutAdd_MPY(Copy(CharBuffer, 0, ReadCount));
      end;
      // read stderr and write to our stderr
      while ProcessMPY.Stderr.NumBytesAvailable > 0 do
      begin
        ReadCount := Min(512, ProcessMPY.Stderr.NumBytesAvailable);
        //Read up to buffer, not more
        ProcessMPY.Stderr.Read(CharBuffer, ReadCount);
        mmoOutAdd_MPY(Copy(CharBuffer, 0, ReadCount));
      end;
      Application.ProcessMessages;
    end;

  finally
    btnScriptStop_MPY.Enabled := False;
    btnScriptRun_MPY.Enabled  := True;
    synEditScript_MPY.Cursor  := crDefault;
    if synEditScript_MPY.Modified then
      DeleteFile(filename);
  end;
end;

procedure TfrmMain.btnScriptSaveAs_GraphClick(Sender: TObject);
begin
  if dlgSave_Graph.Execute then
  begin
    SaveScriptFile(synEditScript_Graph, dlgSave_Graph.FileName);
    pmScriptHisAdd(pmScriptHis_Graph, dlgSave_Graph.FileName);
    pmScriptHis_Graph.Items[0].Checked := True;
  end;
end;

procedure TfrmMain.btnScriptSaveAs_LittleCClick(Sender: TObject);
begin
  if dlgSave_LittleC.Execute then
  begin
    SaveScriptFile(synEditScript_LittleC, dlgSave_LittleC.FileName);
    pmScriptHisAdd(pmScriptHis_LittleC, dlgSave_LittleC.FileName);
    pmScriptHis_LittleC.Items[0].Checked := True;
  end;
end;

procedure TfrmMain.btnScriptSaveas_MPYClick(Sender: TObject);
begin
  if dlgSave_MPY.Execute then
  begin
    SaveScriptFile(synEditScript_MPY, dlgSave_MPY.FileName);
    pmScriptHisAdd(pmScriptHis_MPY, dlgSave_MPY.FileName);
    pmScriptHis_MPY.Items[0].Checked := True;
  end;
end;

procedure TfrmMain.btnScriptSaveAs_PascalClick(Sender: TObject);
begin
  if dlgSave_Pascal.Execute then
  begin
    SaveScriptFile(synEditScript_Pascal, dlgSave_Pascal.FileName);
    pmScriptHisAdd(pmScriptHis_Pascal, dlgSave_Pascal.FileName);
    pmScriptHis_Pascal.Items[0].Checked := True;
  end;
end;

procedure TfrmMain.btnScriptSave_GraphClick(Sender: TObject);
begin
  if dlgSave_Graph.FileName = '' then
  begin
    if not dlgSave_Graph.Execute then
      Exit;
  end;
  SaveScriptFile(synEditScript_Graph, dlgSave_Graph.FileName);
  pmScriptHisAdd(pmScriptHis_Graph, dlgSave_Graph.FileName);
  pmScriptHis_Graph.Items[0].Checked := True;
end;

procedure TfrmMain.btnScriptSave_LittleCClick(Sender: TObject);
begin
  if dlgSave_LittleC.FileName = '' then
  begin
    if not dlgSave_LittleC.Execute then
      Exit;
  end;
  SaveScriptFile(synEditScript_LittleC, dlgSave_LittleC.FileName);
  pmScriptHisAdd(pmScriptHis_LittleC, dlgSave_LittleC.FileName);
  pmScriptHis_LittleC.Items[0].Checked := True;
end;

procedure TfrmMain.btnScriptSave_MPYClick(Sender: TObject);
begin
  if dlgSave_MPY.FileName = '' then
  begin
    if not dlgSave_MPY.Execute then
      Exit;
  end;
  SaveScriptFile(synEditScript_MPY, dlgSave_MPY.FileName);
  pmScriptHisAdd(pmScriptHis_MPY, dlgSave_MPY.FileName);
  pmScriptHis_MPY.Items[0].Checked := True;
end;

procedure TfrmMain.btnScriptSave_PascalClick(Sender: TObject);
begin
  if dlgSave_Pascal.FileName = '' then
  begin
    if not dlgSave_Pascal.Execute then
      Exit;
  end;
  SaveScriptFile(synEditScript_Pascal, dlgSave_Pascal.FileName);
  pmScriptHisAdd(pmScriptHis_Pascal, dlgSave_Pascal.FileName);
  pmScriptHis_Pascal.Items[0].Checked := True;
end;

procedure TfrmMain.btnScriptStop_LittleCClick(Sender: TObject);
begin
  btnScriptStop_LittleC.Enabled := False;
  btnScriptRun_LittleC.Enabled  := True;
  if ProcessLittleC.Running then
  begin
    ProcessLittleC.Terminate(0);
  end;
end;

procedure TfrmMain.btnScriptStop_MPYClick(Sender: TObject);
begin
  btnScriptStop_MPY.Enabled := False;
  btnScriptRun_MPY.Enabled  := True;
  if ProcessMPY.Running then
  begin
    ProcessMPY.Terminate(0);
  end;
end;

procedure TfrmMain.chkChecksumFileCRC32Change(Sender: TObject);
begin
  sgChecksumFile.Columns[TCheckBox(Sender).Tag].Visible := TCheckBox(Sender).Checked;
end;

procedure TfrmMain.chkOptionButtonFlatsytleChange(Sender: TObject);
begin
  btnOptionTabAlternateColor.Flat := chkOptionButtonFlatsytle.Checked;
end;

procedure TfrmMain.chkOptionTableFlatsytleChange(Sender: TObject);
begin
  sgOptionTableDemo.Flat := chkOptionTableFlatsytle.Checked;
end;

procedure TfrmMain.edtBaseCustomChange(Sender: TObject);
begin
  sgBase.Cells[0, 5] := 'custom [' + IntToStr(edtBaseCustom.Value) + ']';
  sgBase.Selection   := Rect(1, 5, 1, 5);
  sgBaseEditingDone(Sender);
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
var
  i, j: integer;
begin
  try

    ini.WriteInteger('last', 'Left', Left);
    ini.WriteInteger('last', 'Top', Top);
    ini.WriteInteger('last', 'Width', Width);
    ini.WriteInteger('last', 'Height', Height);

    ini.WriteInteger('last', 'page', pcMain.ActivePageIndex);

    // Calc
    ini.WriteInteger('calc', 'pnlvar_width', pnlCalcVar.Width);
    ini.WriteString('calc', 'workspace', CalcWorkspaceFileName);
    SaveCalcWorkspace(CalcWorkspaceFileName);

    ini.WriteInteger('calc', 'WorkspaceHisfileCount', pmHisCalc.Items.Count);
    for i := 1 to pmHisCalc.Items.Count do
    begin
      ini.WriteString('calc', 'WorkspaceHisfile' + IntToStr(i),
        pmHisCalc.Items[i - 1].Caption);
    end;

    // Checksum
    ini.WriteInteger('Checksum', 'page', pcChecksum.ActivePageIndex);

    //   crc
    ini.WriteString('CRC', 'poly', edtCrcPolygon.Text);
    ini.WriteString('CRC', 'v0', edtCrcInitV.Text);
    ini.WriteString('CRC', 'XOROUT', edtCrcXOROUT.Text);
    ini.WriteBool('CRC', 'InvIn', chkCrcInvIn.Checked);
    ini.WriteBool('CRC', 'InvOut', chkCrcInvOut.Checked);
    ini.WriteInteger('CRC', 'bit', getCrcBit);
    ini.WriteBool('CRC', 'HEXmode', chkCrcHexMode.Checked);
    ini.WriteString('CRC', 'dat', mmoCRC.Text);

    //   File
    ini.WriteBool('ChecksumFile', 'CRC32', chkChecksumFileCRC32.Checked);
    ini.WriteBool('ChecksumFile', 'MD5', chkChecksumFileMD5.Checked);
    ini.WriteBool('ChecksumFile', 'SHA1', chkChecksumFileSHA1.Checked);
    ini.WriteBool('ChecksumFile', 'AutoVerify', chkChecksumFileAutoVerify.Checked);
    ini.WriteBool('ChecksumFile', 'AutoSaveToFile',
      chkChecksumFileAutosavetofile.Checked);

    ini.WriteInteger('ChecksumFile', 'Width0', sgChecksumFile.Columns[0].Tag);
    ini.WriteInteger('ChecksumFile', 'Width1', sgChecksumFile.Columns[1].Tag);
    ini.WriteInteger('ChecksumFile', 'Width2', sgChecksumFile.Columns[2].Tag);
    ini.WriteInteger('ChecksumFile', 'Width3', sgChecksumFile.Columns[3].Tag);

    // Digit
    //   Base
    ini.WriteInteger('base', 'custom', edtBaseCustom.Value);


    // Convert
    ini.WriteInteger('convert', 'page', pcConvert.ActivePageIndex);
    clearConvert;

    //   Time
    ini.WriteInteger('convert', 'TimeHeight', sgConvertTime.Height);


    // constant
    ini.WriteInteger('constant', 'page', pcConstant.ActivePageIndex);
    clearConstant;

    // Script
    ini.WriteInteger('Script', 'Page', pcScript.PageIndex);

    // Little C
    ini.EraseSection('LittleC');
    ini.WriteBool('LittleC', 'Vert', splScript_LittleC.Align = alLeft);
    if splScript_LittleC.Align = alLeft then
      ini.WriteInteger('LittleC', 'Width', synEditScript_LittleC.Width)
    else
      ini.WriteInteger('LittleC', 'Height', synEditScript_LittleC.Height);

    ini.WriteString('LittleC', 'File', dlgSave_LittleC.FileName);

    ini.WriteInteger('LittleC', 'HisFileCount', pmScriptHis_LittleC.Items.Count);
    for i := 0 to pmScriptHis_LittleC.Items.Count - 1 do
      ini.WriteString('LittleC', 'HisFile' + IntToStr(i + 1),
        pmScriptHis_LittleC.Items[i].Caption);

    //  micropython
    ini.EraseSection('MPY');
    ini.WriteBool('MPY', 'Vert', splScript_MPY.Align = alLeft);
    if splScript_MPY.Align = alLeft then
      ini.WriteInteger('MPY', 'Width', synEditScript_MPY.Width)
    else
      ini.WriteInteger('MPY', 'Height', synEditScript_MPY.Height);

    ini.WriteString('MPY', 'File', dlgSave_MPY.FileName);

    ini.WriteInteger('MPY', 'HisFileCount', pmScriptHis_MPY.Items.Count);
    for i := 0 to pmScriptHis_MPY.Items.Count - 1 do
      ini.WriteString('MPY', 'HisFile' + IntToStr(i + 1),
        pmScriptHis_MPY.Items[i].Caption);

    //  pascal
    ini.EraseSection('pascal');
    ini.WriteBool('pascal', 'Vert', splScript_Pascal.Align = alLeft);
    if splScript_Pascal.Align = alLeft then
      ini.WriteInteger('pascal', 'Width', synEditScript_Pascal.Width)
    else
      ini.WriteInteger('pascal', 'Height', synEditScript_Pascal.Height);

    ini.WriteString('pascal', 'File', dlgSave_Pascal.FileName);

    ini.WriteInteger('pascal', 'HisFileCount', pmScriptHis_Pascal.Items.Count);
    for i := 0 to pmScriptHis_Pascal.Items.Count - 1 do
      ini.WriteString('pascal', 'HisFile' + IntToStr(i + 1),
        pmScriptHis_Pascal.Items[i].Caption);

    ini.UpdateFile;
  finally
    ini.Free;
  end;
end;

procedure TfrmMain.FormDropFiles(Sender: TObject; const FileNames: array of string);
var
  i, j, num: integer;
begin
  if (pcMain.ActivePage = tsChecksum) and (pcChecksum.ActivePage = tsChecksumFile) then
  begin
    sgChecksumFile.RowCount := 1;
    num := Length(FileNames);
    j   := 0;
    for i := 1 to num do
    begin
      if FileExists(FileNames[i - 1]) then
      begin
        sgChecksumFile.RowCount := sgChecksumFile.RowCount + 1;
        j := j + 1;
        sgChecksumFile.Cells[1, j] := FileNames[i - 1];
        if chkChecksumFileCRC32.Checked then
          try
            if FileSize(FileNames[i - 1]) > 0 then
              sgChecksumFile.Cells[2, j] := IntToHex(Crc32File(FileNames[i - 1]), 8)
            else
              sgChecksumFile.Cells[2, j] := '00000000';
          except

          end;
        if chkChecksumFileMD5.Checked then
          try
            sgChecksumFile.Cells[3, j] :=
              MDPrint(MDFile(FileNames[i - 1], MD_VERSION_5));
          except

          end;
        if chkChecksumFileSHA1.Checked then
          try
            sgChecksumFile.Cells[4, j] := SHA1Print(SHA1File(FileNames[i - 1]));
          except

          end;
      end;
    end;
  end;
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  case Key of
    VK_F9:
    begin
      if pcMain.ActivePage = tsScript then
      begin
        case pcScript.ActivePageIndex of
          0: btnScriptRun_LittleCClick(Sender);
          1: btnScriptRun_GraphClick(Sender);
          2: btnScriptRun_MPYClick(Sender);
          3: btnScriptRun_PascalClick(Sender);
        end;
      end;
    end;
    VK_S:
    begin
      if (Shift = [ssCtrl]) and (pcMain.ActivePage = tsScript) then
      begin
        case pcScript.ActivePageIndex of
          0: btnScriptSave_LittleCClick(Sender);
          1: btnScriptSave_GraphClick(Sender);
          2: btnScriptSave_MPYClick(Sender);
          3: btnScriptSave_PascalClick(Sender);
        end;
      end;
    end;

  end;
end;

procedure TfrmMain.FormKeyPress(Sender: TObject; var Key: char);
begin
  if pcMain.ActivePage = tsCalc then
  begin
    if not mmoCalcFunc.Focused then
    begin
      edtCalcExpr.SetFocus;
    end;
  end;

end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  LoadCalcWorkspace(CalcWorkspaceFileName);

  sgChecksumFile.Columns[1].Visible := chkChecksumFileCRC32.Checked;
  sgChecksumFile.Columns[2].Visible := chkChecksumFileMD5.Checked;
  sgChecksumFile.Columns[3].Visible := chkChecksumFileSHA1.Checked;

  pcMainChange(Sender);
end;

procedure TfrmMain.FormWindowStateChange(Sender: TObject);
begin
  if WindowState = wsMinimized then
  begin
    if TrayIcon.Visible and MinimizeToTray then
    begin
      Hide;
    end;
  end
  else
    winstat := WindowState;
end;

procedure TfrmMain.gbOptionCalcInterpreterResize(Sender: TObject);
begin
  edtOptionPythonPath.Width  := gbOptionCalcInterpreter.Width - 50;
  edtOptionMPYPath.Width     := edtOptionPythonPath.Width;
  edtOptionLittleCPath.Width := edtOptionPythonPath.Width;

  lbTinyCWebSite2.Left := edtOptionPythonPath.BoundsRect.Right - lbTinyCWebSite2.Width;
  lbTinyCWebSite1.Left := lbTinyCWebSite2.Left - lbTinyCWebSite1.Width - 24;
end;

procedure TfrmMain.lbTinyCWebSite2Click(Sender: TObject);
begin
  OpenURL(TLabel(Sender).Hint);
end;

procedure TfrmMain.miTrayExitClick(Sender: TObject);
begin
  TrayIcon.Visible := False;
  Close;
end;

procedure TfrmMain.OKButtonClick(Sender: TObject);
begin
  saveOption;
  applyOption;
end;

procedure TfrmMain.pcMainChange(Sender: TObject);
begin
  frmMain.AllowDropFiles := (pcMain.ActivePage = tsChecksum) and
    (pcChecksum.ActivePage = tsChecksumFile);

  if (pcMain.ActivePage = tsCalc) then
    edtCalcExpr.SetFocus;
end;

procedure TfrmMain.pmScriptHis_LittleCPopup(Sender: TObject);
begin
  if pmScriptHis_LittleC.Items.Count = 0 then
    btnScriptOpen_LittleCClick(Sender);
end;

procedure TfrmMain.pmScriptHis_MPYPopup(Sender: TObject);
begin
  if pmScriptHis_MPY.Items.Count = 0 then
    btnScriptOpen_MPYClick(Sender);
end;

procedure TfrmMain.PSScriptCompile(Sender: TPSScript);
begin
  Sender.AddFunction(@PSwriteln, 'procedure Writeln(s:array of Variant);');
  Sender.AddFunction(@PSwrite, 'procedure Write(s: array of Variant);');
  Sender.AddFunction(@PSFormat,
    'function format(const Fmt: string; const Args: array of const): string;');
  Sender.AddFunction(@PSclear, 'procedure clear;');
  Sender.AddFunction(@PSreadln, 'function Readln(question: string): string;');
  Sender.AddFunction(@PSreadln, 'function Read(question: string): string;');
  Sender.AddFunction(@PSlog, 'function ln(x: double): double;');
  Sender.AddFunction(@PSlog2, 'function log2(x: double): double;');
  Sender.AddFunction(@PSlog10, 'function log10(x: double): double;');
  Sender.AddFunction(@PSlogN, 'function logN(n, x: double): double;');
  Sender.AddFunction(@PSexp, 'function exp(x: double): double;');
  Sender.AddFunction(@PStan, 'function tan(x: double): double;');
  Sender.AddFunction(@PSarcsin, 'function arcsin(x: double): double;');
  Sender.AddFunction(@PSarccos, 'function arccos(x: double): double;');
  Sender.AddFunction(@PSarctan, 'function arctan(x: double): double;');
  Sender.AddFunction(@PSsinh, 'function sinh(x: double): double;');
  Sender.AddFunction(@PScosh, 'function cosh(x: double): double;');
  Sender.AddFunction(@PStanh, 'function tanh(x: double): double;');
  Sender.AddFunction(@PSfloor, 'function floor(x: double): double;');
  Sender.AddFunction(@PSceil, 'function ceil(x: double): double;');
  Sender.AddFunction(@PSpower, 'function power(x,y: double): double;');
  Sender.AddFunction(@PSRandom, 'function random: double;');
  Sender.AddFunction(@PSRandomRange, 'function RandomRange(x,y: integer): integer;');
  Sender.AddFunction(@PSbeep, 'procedure beep;');
  Sender.AddFunction(@PSsleep, 'procedure sleep(x:integer);');

end;

procedure TfrmMain.sgBaseEditingDone(Sender: TObject);
var
  sx, sy: integer;
  dat, base: integer;
  s: string;
  neg: boolean;
begin
  sx := sgBase.Selection.Location.x;
  sy := sgBase.Selection.Location.y;
  s  := sgBase.Cells[sx, sy];

  s := Trim(s);
  if s = '' then
    Exit;

  neg := s[1] = '-';

  case sy of
    1: base := 2;
    2: base := 8;
    3: base := 10;
    4: base := 16;
    5: base := edtBaseCustom.Value;
    else
      Exit;
  end;

  dat := StrToBase(s, base, neg, system.maxLongint);

  sgBase.Cells[1, 1] := BaseToStr(dat, 1, 2, neg, '0');
  sgBase.Cells[1, 2] := BaseToStr(dat, 1, 8, neg, '0');
  sgBase.Cells[1, 3] := BaseToStr(dat, 1, 10, neg, '0');
  sgBase.Cells[1, 4] := BaseToStr(dat, 1, 16, neg, '0');
  sgBase.Cells[1, 5] := BaseToStr(dat, 1, edtBaseCustom.Value, neg, '0');
end;

procedure TfrmMain.sgCalcExprKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  edtCalcExprKeyDown(Sender, Key, Shift);
  edtCalcExpr.SetFocus;
end;

procedure TfrmMain.miHisCalcClick(Sender: TObject);
begin
  // load history file
  LoadCalcWorkspace(TMenuItem(Sender).Caption);
  // move to first
  pmAdd(pmHisCalc, TMenuItem(Sender).Caption);
end;

function TfrmMain.getCrcBit: integer;
begin
  if rbCrc4bits.Checked then
    Result := 4;
  if rbCrc5bits.Checked then
    Result := 5;
  if rbCrc6bits.Checked then
    Result := 6;
  if rbCrc7bits.Checked then
    Result := 7;
  if rbCrc8bits.Checked then
    Result := 8;
  if rbCrc12bits.Checked then
    Result := 12;
  if rbCrc16bits.Checked then
    Result := 16;
  if rbCrc32bits.Checked then
    Result := 32;

end;

procedure TfrmMain.setCrcBit(bit: integer);
begin
  case bit of
    4: rbCrc4bits.Checked   := True;
    5: rbCrc5bits.Checked   := True;
    6: rbCrc6bits.Checked   := True;
    7: rbCrc7bits.Checked   := True;
    8: rbCrc8bits.Checked   := True;
    12: rbCrc12bits.Checked := True;
    16: rbCrc16bits.Checked := True;
    32: rbCrc32bits.Checked := True;
    else
      exit;
  end;
end;

procedure TfrmMain.setCrcMode(bit: integer; poly: longword; v0: longword;
  XOROUT: longword; InvIn: boolean; InvOut: boolean);
begin
  setCrcBit(bit);
  edtCrcPolygon.Text   := IntToHex(poly, 2);
  edtCrcInitV.Text     := IntToHex(v0, 2);
  edtCrcXOROUT.Text    := IntToHex(XOROUT, 2);
  chkCrcInvIn.Checked  := InvIn;
  chkCrcInvOut.Checked := InvOut;

  btnCrcCalcClick(nil);
end;

procedure TfrmMain.updateLanguageList;
var
  r: TSearchRec;
  s: string;
  p1, p2: integer;
begin
  cbbOptionLanguage.Clear;
  if FindFirst(AppPath + 'lang' + PATHSEP + '*.mo', faAnyFile, r) = 0 then
  begin
    repeat
      s  := r.Name;
      p1 := pos('.', s) + 1;
      p2 := pos('.', s, p1);
      s  := Copy(s, p1, p2 - p1);
      if s <> '' then
        cbbOptionLanguage.Items.Add(s);
    until FindNext(r) <> 0;
    FindClose(r);
  end;
  if FindFirst(AppPath + 'lang' + PATHSEP + '*.po', faAnyFile, r) = 0 then
  begin
    repeat
      s  := r.Name;
      p1 := pos('.', s) + 1;
      p2 := pos('.', s, p1);
      s  := Copy(s, p1, p2 - p1);
      if (cbbOptionLanguage.Items.IndexOf(s) = -1) and (s <> '') then
        cbbOptionLanguage.Items.Add(s);
    until FindNext(r) <> 0;
    FindClose(r);
  end;

end;

procedure TfrmMain.saveOption;
begin
  lang := cbbOptionLanguage.Text;
  ini.WriteString('Option', 'lang', lang);

  ini.WriteString('Option', 'FontName', dlgFont.Font.Name);
  ini.WriteInteger('Option', 'FontSize', dlgFont.Font.Size);

  TrayIcon.Visible := chkOptionTrayIcon.Checked;
  CloseToTray      := chkOptionCloseToTray.Checked;
  MinimizeToTray   := chkOptionMinimizeToTray.Checked;
  ini.WriteBool('Option', 'TrayIcon', TrayIcon.Visible);
  ini.WriteBool('Option', 'MinimizeToTray', MinimizeToTray);
  ini.WriteBool('Option', 'CloseToTray', CloseToTray);

  TableFlatStyle := chkOptionTableFlatsytle.Checked;
  ini.WriteBool('Option', 'TableFlatStyle', TableFlatStyle);
  ButtonFlatStyle := chkOptionButtonFlatsytle.Checked;
  ini.WriteBool('Option', 'ButtonFlatStyle', ButtonFlatStyle);

  TabAlternateColorEn := chkOptionTabAlternateColor.Checked;
  TabAlternateColor   := btnOptionTabAlternateColor.ButtonColor;
  ini.WriteBool('Option', 'TabAlternateColorEn', TabAlternateColorEn);
  ini.WriteInteger('Option', 'TabAlternateColor', TabAlternateColor);

  RMCCopy := chkOptionRMCCopy.Checked;
  ini.WriteBool('Option', 'RMCCopy', RMCCopy);
  errlog_en := chkOptionErrlogEn.Checked;
  ini.WriteBool('option', 'errlog', errlog_en);
  MaxLineNumberOfScriptOutput := edtOptionMaxLineNumberOfScriptOutput.Value;
  ini.WriteInteger('Option', 'MaxLineNumberOfScriptOutput', MaxLineNumberOfScriptOutput);

  path_MPY    := edtOptionMPYPath.Text;
  path_Python := edtOptionPythonPath.Text;
  ini.WriteString('Option', 'path_micropython', path_MPY);
  ini.WriteString('Option', 'path_python', path_Python);

  CalcUseMPY := rbOptionCalcUseMPY.Checked;
  ini.WriteBool('Option', 'CalcUseMPY', CalcUseMPY);

  path_LittleC := edtOptionLittleCPath.Text;
  ini.WriteString('Option', 'path_LittleC', path_LittleC);

  ini.UpdateFile;
end;

procedure TfrmMain.loadOption;
var
  i: integer;
begin
  try
    errlog_en := ini.ReadBool('option', 'errlog', True);
    chkOptionErrlogEn.Checked := errlog_en;

    TrayIcon.Visible := ini.ReadBool('Option', 'TrayIcon', True);
    MinimizeToTray   := ini.ReadBool('Option', 'MinimizeToTray', False);
    CloseToTray      := ini.ReadBool('Option', 'CloseToTray', False);
    chkOptionTrayIcon.Checked := TrayIcon.Visible;
    chkOptionMinimizeToTray.Checked := MinimizeToTray;
    chkOptionCloseToTray.Checked := CloseToTray;

    TableFlatStyle  := ini.ReadBool('Option', 'TableFlatStyle', False);
    chkOptionTableFlatsytle.Checked := TableFlatStyle;
    ButtonFlatStyle := ini.ReadBool('Option', 'ButtonFlatStyle', True);
    chkOptionButtonFlatsytle.Checked := ButtonFlatStyle;

    TabAlternateColorEn := ini.ReadBool('Option', 'TabAlternateColorEn', True);
    TabAlternateColor   := ini.ReadInteger('Option', 'TabAlternateColor', $00F8FAFA);
    chkOptionTabAlternateColor.Checked := TabAlternateColorEn;
    btnOptionTabAlternateColor.ButtonColor := TabAlternateColor;

    RMCCopy := ini.ReadBool('Option', 'RMCCopy', True);
    chkOptionRMCCopy.Checked := RMCCopy;
    MaxLineNumberOfScriptOutput :=
      ini.ReadInteger('Option', 'MaxLineNumberOfScriptOutput', 256);
    edtOptionMaxLineNumberOfScriptOutput.Value := MaxLineNumberOfScriptOutput;

    dlgFont.Font.Name := ini.ReadString('Option', 'FontName', 'default');
    dlgFont.Font.Size := ini.ReadInteger('Option', 'FontSize', 0);

    path_MPY    := ini.ReadString('Option', 'path_micropython', MICROPYTHON_BIN_NAME);
    path_Python := ini.ReadString('Option', 'path_python', 'python.exe');
    edtOptionMPYPath.Text := path_MPY;
    edtOptionPythonPath.Text := path_Python;
    CalcUseMPY  := ini.ReadBool('Option', 'CalcUseMPY', True);
    if CalcUseMpy then
      rbOptionCalcUseMPY.Checked    := True
    else
      rbOptionCalcUsePython.Checked := True;

    path_LittleC := ini.ReadString('Option', 'path_LittleC', '');
    edtOptionLittleCPath.Text := path_LittleC;

    lang := ini.ReadString('Option', 'lang', 'en');
    i    := cbbOptionLanguage.Items.IndexOf(lang);
    if i = -1 then
      cbbOptionLanguage.ItemIndex := 0
    else
    begin
      cbbOptionLanguage.ItemIndex := i;
    end;

  except
    on E: Exception do
      errlog(E.Message);
  end;

end;

procedure TfrmMain.applyOption;
var
  i: integer;
begin
  SetLang(lang);

  Font.Name := dlgFont.Font.Name;
  Font.Size := dlgFont.Font.Size;
  pnlOptionFontPreview.Caption :=
    dlgFont.Font.Name + ', ' + IntToStr(dlgFont.Font.Size);
  pnlOptionFontPreview.Font := dlgFont.Font;

  ProcessMPY.Executable     := path_MPY;
  ProcessPY.Executable      := path_Python;
  ProcessLittleC.Executable := path_LittleC;


  for i := 0 to ComponentCount - 1 do
  begin
    if IsPublishedProp(Components[i], 'Flat') then
    begin
      if (Components[i] is TStringGrid) then
        SetPropValue(Components[i], 'Flat', TableFlatStyle)
      else
      if not (Components[i].GetParentComponent = pnlAbout) then
        SetPropValue(Components[i], 'Flat', ButtonFlatStyle);
    end;

    try
      if IsPublishedProp(Components[i], 'AlternateColor') then
        if TabAlternateColorEn then
          SetPropValue(Components[i], 'AlternateColor', TabAlternateColor)
        else
          SetPropValue(Components[i], 'AlternateColor',
            GetPropValue(Components[i], 'Color'));
    except

    end;
  end;
end;

procedure TfrmMain.clearConvert;
var
  i: integer;
  s: string;
  sg: TStringGrid;
  tlb: TToolBar;
  edt: TSpinEdit;
begin
  for i := pcConvert.PageCount - 1 downto 1 do
  begin
    try
      s := pcConvert.Pages[i].Name;
      if StrLComp(PChar(s), PChar('tsConvert_'), Length('tsConvert_')) = 0 then
      begin
        Delete(s, 1, Length('tsConvert_'));

        sg  := TStringGrid(pcConvert.Pages[i].FindSubComponent('sgConvert_' + s));
        tlb := TToolBar(pcConvert.Pages[i].FindSubComponent('tlbConvert_' + s));
        edt := TSpinEdit(tlb.FindSubComponent('edtDDConvert_' + s));

        ini.WriteInteger('convert', s + '_ColWidth1', sg.ColWidths[0]);
        ini.WriteInteger('convert', s + '_ColWidth2', sg.ColWidths[1]);
        ini.WriteInteger('convert', s + '_Decimal', edt.Value);
      end;
    except

    end;
    pcConvert.Pages[i].Free;
  end;

end;

procedure TfrmMain.findConvert(lang: string);
var
  r: TSearchRec;
  s: string;
begin
  if FindFirst(AppPath + 'convert' + PATHSEP + '*.' + lang, faAnyFile, r) = 0 then
  begin
    repeat
      s := r.Name;
      loadConvert(s);
    until FindNext(r) <> 0;
    FindClose(r);
  end;

  if FindFirst(AppPath + 'convert' + PATHSEP + '*.', faAnyFile, r) = 0 then
  begin
    repeat
      s := r.Name;
      loadConvert(s);
    until FindNext(r) <> 0;
    FindClose(r);
  end;

  pcConvert.PageIndex := min(pcConvert.PageCount - 1,
    ini.ReadInteger('convert', 'page', 0));
end;

procedure TfrmMain.loadConvert(filename: string);
var
  ci: TIniFile;
  ts: TTabSheet;
  tbDecimalPlaces: TToolBar;
  btnDecimalPlaces: TToolButton;
  edtDecimalPlaces: TSpinEdit;
  sg: TStringGrid;
  s, sf: string;
  i: integer;
  mmo: TMemo;
begin

  ci := TIniFile.Create(AppPath + 'convert' + PATHSEP + filename);
  try
    s := ci.ReadString('basic', 'Caption', '');
    if s = '' then
      Exit;
    ts := TTabSheet.Create(pcConvert);
    ts.PageControl := pcConvert;
    ts.Caption := s;
    i  := pos(lang, filename);
    if (i > 0) and ((i + Length(lang) - 1) = Length(filename)) then
    begin
      Delete(filename, length(filename) - Length(lang), Length(lang) + 1);
      filename := filename + '_' + lang;
    end;
    ts.Name := 'tsConvert_' + filename;
    tbDecimalPlaces := TToolBar.Create(ts);
    tbDecimalPlaces.Name := 'tlbConvert_' + filename;
    tbDecimalPlaces.Parent := ts;
    tbDecimalPlaces.Align := alTop;
    tbDecimalPlaces.EdgeBorders := [];
    tbDecimalPlaces.AutoSize := True;
    tbDecimalPlaces.Transparent := True;
    tbDecimalPlaces.ShowCaptions := True;

    btnDecimalPlaces := TToolButton.Create(tbDecimalPlaces);
    btnDecimalPlaces.Parent := tbDecimalPlaces;
    btnDecimalPlaces.Caption := lbDecimalDigits.Caption;
    btnDecimalPlaces.AutoSize := True;
    btnDecimalPlaces.Enabled := False;

    edtDecimalPlaces      := TSpinEdit.Create(tbDecimalPlaces);
    edtDecimalPlaces.Name := 'edtDDConvert_' + filename;
    edtDecimalPlaces.Parent := tbDecimalPlaces;
    edtDecimalPlaces.MaxValue := 15;
    edtDecimalPlaces.MinValue := 0;
    edtDecimalPlaces.AutoSize := True;
    edtDecimalPlaces.Value :=
      ini.ReadInteger('convert', filename + '_Decimal',
      ci.ReadInteger('basic', 'DefaultDecimalPlaces', 1));

    s := ci.ReadString('basic', 'info', '');
    if s <> '' then
    begin
      with TToolButton.Create(tbDecimalPlaces) do
      begin
        parent := tbDecimalPlaces;
        style  := tbsSeparator;
      end;
      with TToolButton.Create(tbDecimalPlaces) do
      begin
        parent  := tbDecimalPlaces;
        style   := tbsButton;
        Enabled := False;
        Caption := s;
        ShowCaption := True;
      end;
    end;

    mmo      := TMemo.Create(ts);
    mmo.Name := 'mmoConvert_' + filename;
    mmo.Parent := ts;
    mmo.Align := alTop;
    mmo.Height := 120;
    mmo.Visible := False;
    mmo.WordWrap := False;
    mmo.Lines.Clear;
    mmo.Lines.Add('from math import *' + #13#10);
    mmo.Lines.Add('#' + ci.ReadString('basic', 'VAR1', 'X'));
    mmo.Lines.Add('#' + ci.ReadString('basic', 'VAR2', 'Y') + #13#10);

    sg      := TStringGrid.Create(ts);
    sg.Parent := ts;
    sg.Name := 'sgConvert_' + filename;
    sg.Align := alClient;
    sg.Flat := TableFlatStyle;
    sg.AutoEdit := True;
    if TabAlternateColorEn then
      sg.AlternateColor := TabAlternateColor
    else
      sg.AlternateColor := sg.Color;
    sg.Options := sg.Options + [goFixedVertLine, goFixedHorzLine,
      goColSizing, goDblClickAutoSize, goFixedColSizing, goVertLine,
      goHorzLine, goEditing, goAlwaysShowEditor] - [goRangeSelect, goSmoothScroll];
    sg.ColCount     := 3;
    sg.RowCount     := ci.ReadInteger('basic', 'RowCount', 10) + 1;
    sg.FixedRows    := 1;
    sg.FixedCols    := 2;
    sg.AutoFillColumns := True;
    sg.ShowHint     := False;
    sg.ColWidths[0] := ini.ReadInteger('convert', filename + '_ColWidth1', 180);
    sg.ColWidths[1] := ini.ReadInteger('convert', filename + '_ColWidth2', 180);
    sg.Cells[2, 0]  := lbConvertTimeValue.Caption;
    for i := 1 to sg.RowCount - 1 do
    begin
      sg.Cells[0, i] := ci.ReadString('item', Format('Row_%d_1', [i]), '');
      sg.Cells[1, i] := ci.ReadString('item', Format('Row_%d_2', [i]), '');
      s := trim(ci.ReadString('item', Format('Row_%d_fomula1', [i]), ''));
      if (s = '') or (sg.Cells[0, i] = '') then
        sf := ''
      else
        sf := s;
      s := Format('def func_%d_1():', [i]) + #13#10 + '    try:' +
        #13#10 + '        return ' + sf + #13#10 + '    except:' +
        #13#10 + '        return("error")' + #13#10;
      mmo.Lines.Add(s);
      s := trim(ci.ReadString('item', Format('Row_%d_fomula2', [i]), ''));
      if (s = '') or (sg.Cells[0, i] = '') then
        sf := ''
      else
        sf := s;
      s := Format('def func_%d_2():', [i]) + #13#10 + '    try:' +
        #13#10 + '        print(' + sf + ')' + #13#10 + '    except:' +
        #13#10 + '        print("error")' + #13#10;
      mmo.Lines.Add(s);

    end;
    sg.OnMouseDown   := @sgConvertTimeMouseDown;
    sg.OnEditingDone := @sgConvertEditingDone;

    s := 'def run():' + #13#10;
    for i := 1 to sg.RowCount - 1 do
      s := s + '    ' + Format('func_%d_2()', [i]) + #13#10;
    mmo.Lines.Add(s);
  finally
    ci.Free;
  end;
end;

procedure TfrmMain.sgConvertEditingDone(Sender: TObject);
var
  X: double;
  sy, i: integer;
  sc, s, res, err, var1, var2: string;
  mmo: TMemo;
  ts: TTabSheet;
  dd: integer;
  edt: TSpinEdit;
  tlb: TToolBar;
  sg: TStringGrid;
begin
  sg := TStringGrid(Sender);
  if sg.Modified then
    sg.Modified := False
  else
    exit;
  sy := sg.Row;
  if not TryStrToFloat(sg.Cells[2, sy], X) then
  begin
    Exit;
  end;

  try
    ts := TTabSheet(sg.Parent);
    s  := sg.Name;
    Delete(s, 1, Length('sgConvert_'));
    mmo  := TMemo(ts.FindSubComponent('mmoConvert_' + s));
    tlb  := TToolBar(ts.FindSubComponent('tlbConvert_' + s));
    edt  := TSpinEdit(tlb.FindSubComponent('edtDDConvert_' + s));
    DD   := edt.Value;
    sc   := mmo.Lines.Text;
    var1 := mmo.Lines[2];
    Delete(var1, 1, 1);
    var2 := mmo.Lines[3];
    Delete(var2, 1, 1);

    sc := sc + #13#10 + var1 + '=' + sg.Cells[2, sy] + #13#10;
    sc := sc + var2 + Format('=func_%d_1()', [sy]) + #13#10 + 'run()';

    MPYRunTmpScript(sc, res, err);
    if err = '' then
    begin
      mmoTmp.Lines.Text := res;
      for i := 0 to mmoTmp.Lines.Count - 1 do
      begin
        try
          if mmoTmp.Lines[i] = '' then
            sg.Cells[2, i + 1] := ''
          else
          begin
            X := StrToFloat(mmoTmp.Lines[i]);
            sg.Cells[2, i + 1] := FloatToStrF(X, ffFixed, 0, DD);
          end;
        except
          sg.Cells[2, i + 1] := 'error';
        end;

      end;
    end
    else
      ShowMessage(err);

  except
    on E: Exception do
      errlog(E.Message);
  end;

end;

procedure TfrmMain.clearConstant;
var
  i, j: integer;
  s: string;
  sg: TStringGrid;
begin
  for i := pcConstant.PageCount - 1 downto 0 do
  begin
    try
      s := pcConstant.Pages[i].Name;
      if StrLComp(PChar(s), PChar('tsConstant_'), Length('tsConstant_')) = 0 then
      begin
        Delete(s, 1, Length('tsConstant_'));

        sg := TStringGrid(pcConstant.Pages[i].Components[0]);

        for j := 0 to sg.ColCount - 1 do
          ini.WriteInteger('constant', s + '_ColWidth' + IntToStr(j), sg.ColWidths[j]);
      end;
    except

    end;
    pcConstant.Pages[i].Free;
  end;
end;

procedure TfrmMain.findConstant(lang: string);
var
  r: TSearchRec;
  s: string;
begin

  if FindFirst(AppPath + 'constant' + PATHSEP + '*.' + lang, faAnyFile, r) = 0 then
  begin
    repeat
      s := r.Name;
      loadConstant(s);
    until FindNext(r) <> 0;
    FindClose(r);
  end;
  if FindFirst(AppPath + 'constant' + PATHSEP + '*.', faAnyFile, r) = 0 then
  begin
    repeat
      s := r.Name;
      loadConstant(s);
    until FindNext(r) <> 0;
    FindClose(r);
  end;

  pcConstant.PageIndex := min(pcConstant.PageCount - 1,
    ini.ReadInteger('constant', 'page', 0));
end;

procedure TfrmMain.loadConstant(filename: string);
var
  ci: TIniFile;
  ts: TTabSheet;
  sg: TStringGrid;
  s: string;
  i, j: integer;
begin
  ci := TIniFile.Create(AppPath + 'constant' + PATHSEP + filename);
  try
    s := ci.ReadString('basic', 'Caption', '');
    if s = '' then
      Exit;
    ts := TTabSheet.Create(pcConstant);
    ts.PageControl := pcConstant;
    ts.Caption := s;
    i  := pos(lang, filename);
    if (i > 0) and ((i + Length(lang) - 1) = Length(filename)) then
    begin
      Delete(filename, length(filename) - Length(lang), Length(lang) + 1);
      filename := filename + '_' + lang;
    end;
    ts.Name := 'tsConstant_' + filename;

    sg      := TStringGrid.Create(ts);
    sg.Parent := ts;
    sg.Name := 'sgConstant_' + filename;
    sg.Hint := ci.ReadString('basic', 'info', '');
    sg.Align := alClient;
    sg.Flat := TableFlatStyle;
    sg.AutoEdit := True;
    if TabAlternateColorEn then
      sg.AlternateColor := TabAlternateColor
    else
      sg.AlternateColor := sg.Color;
    sg.Options := sg.Options + [goFixedVertLine, goFixedHorzLine,
      goColSizing, goDblClickAutoSize, goFixedColSizing, goVertLine, goHorzLine] -
      [goRangeSelect, goSmoothScroll];
    sg.RowCount := ci.ReadInteger('basic', 'RowCount', 2) + 1;
    for i := 1 to ci.ReadInteger('head', 'count', 2) do
      sg.Columns.Add;
    sg.FixedRows := 1;
    sg.FixedCols := 0;
    sg.AutoFillColumns := True;

    for i := 0 to sg.ColCount - 1 do
    begin
      sg.Columns[i].Title.Caption :=
        ci.ReadString('head', 'head' + IntToStr(i + 1), '');
      sg.Columns[i].SizePriority := 0;
      sg.ColWidths[i] := ini.ReadInteger('constant', filename +
        '_ColWidth' + IntToStr(i), 120);
    end;

    for i := 1 to sg.RowCount - 1 do
    begin
      for j := 0 to sg.ColCount - 1 do
        sg.Cells[j, i] := ci.ReadString('item', Format('Row_%d_%d', [i, j + 1]), '');
    end;
    sg.OnMouseDown := @sgConvertTimeMouseDown;

  finally
    ci.Free;
  end;
end;

procedure TfrmMain.mmoOutAdd(var mmo: TMemo; msg: string);
var
  i, n: integer;
begin
  // add msg to last line end
  // process \n
  // reduce flash on update
  if msg = '' then
    Exit;
  mmoOut_Temp.Text := msg;
  n := mmo.Lines.Count;
  if n > 0 then
    n := n - 1;

  mmo.Lines[n] := mmo.Lines[n] + mmoOut_Temp.Lines[0];
  for i := 1 to mmoOut_Temp.Lines.Count - 1 do
    mmo.Lines.Append(mmoOut_Temp.Lines[i]);
  if (msg[Length(msg)] = #10) then
    mmo.Lines.Add('');
  mmo.Lines.BeginUpdate;
  while mmo.Lines.Count > MaxLineNumberOfScriptOutput do
  begin
    mmo.Lines.Delete(0);
  end;
  mmo.Lines.EndUpdate;
end;

procedure TfrmMain.mmoOutAdd_MPY(msg: string);
begin
  mmoOutAdd(mmoScriptOut_MPY, msg);
end;

procedure TfrmMain.mmoOutAdd_LittleC(msg: string);
begin
  mmoOutAdd(mmoScriptOut_LittleC, msg);
end;

procedure TfrmMain.mmoOutAdd_Graph(msg: string);
begin
  mmoOutAdd(mmoScriptOut_Graph, msg);
end;

procedure TfrmMain.mmoOutAdd_Pascal(msg: string);
begin
  mmoOutAdd(mmoScriptOut_Pascal, msg);
end;

procedure TfrmMain.StrToPmScriptNew(pmstr: array of string; pm: TPopupMenu);
var
  n, i: integer;
  s: string;
  mi: TMenuItem;
begin
  s := pm.Name;
  n := pos('_', s);
  if n < 2 then
    Exit;
  Delete(s, 1, n - 1);
  n := Length(pmstr) div 2;
  for i := 0 to n - 1 do
  begin
    mi      := TMenuItem.Create(pm);
    mi.Caption := pmstr[i * 2];
    mi.Tag  := i * 2;
    mi.Hint := pmstr[i * 2 + 1];
    mi.OnClick := @pmNewOnClick;
    mi.Name := 'pmNew' + IntToStr(i) + s;
    pm.Items.Add(mi);
  end;
end;

procedure TfrmMain.pmNewOnClick(Sender: TObject);
var
  edt: TSynEdit;
  s: string;
  n: integer;
  dlg: TSaveDialog;
  btn: TToolButton;
begin
  s := TMenuItem(Sender).Name;
  n := pos('_', s);
  if n < 2 then
    Exit;
  Delete(s, 1, n - 1);
  edt := TSynEdit(FindComponent('synEditScript' + s));
  if edt = nil then
    Exit;
  edt.Clear;
  edt.Text := TMenuItem(Sender).Hint;
  edt.Modified := True;
  dlg := TSaveDialog(FindComponent('dlgSave' + s));
  dlg.FileName := '';
  TTabSheet(edt.Parent).Caption :=
    '*' + ScriptName[pcScript.ActivePageIndex] + ' - newfile';
  btn := TToolButton(FindComponent('btnScriptSave' + s));
  btn.Enabled := True;
end;

procedure TfrmMain.LoadScriptFile(syn: TSynEdit; FileName: string);
var
  btn: TToolButton;
begin
  syn.Lines.LoadFromFile(FileName);
  syn.Modified := False;
  TTabSheet(syn.Parent).Caption :=
    ScriptName[TTabSheet(syn.Parent).PageIndex] + ' - ' + ExtractFileName(FileName);
  btn := TToolButton(FindComponent('btnScriptSave_' +
    ScriptSym[TTabSheet(syn.Parent).PageIndex]));
  btn.Enabled := False;
  syn.Modified := False;
end;

procedure TfrmMain.SaveScriptFile(syn: TSynEdit; FileName: string);
var
  btn: TToolButton;
begin
  syn.Lines.SaveToFile(FileName);
  syn.Modified := False;
  TTabSheet(syn.Parent).Caption :=
    ScriptName[TTabSheet(syn.Parent).PageIndex] + ' - ' + ExtractFileName(FileName);
  btn := TToolButton(FindComponent('btnScriptSave_' +
    ScriptSym[TTabSheet(syn.Parent).PageIndex]));
  btn.Enabled := False;
end;

procedure TfrmMain.pmScriptHisAdd(var pm: TPopupMenu; FileName: string);
var
  mi: TMenuItem;
  s: string;
begin
  if FileName <> '' then
  begin
    mi := pm.Items.Find(FileName);
    // Add new history file
    if mi = nil then
    begin
      // max 8 history files
      if pm.Items.Count > 8 then
        pm.Items.Delete(7);

      s := pm.Name;
      Delete(s, 1, Length('pmScriptHis_'));
      mi      := TMenuItem.Create(pm);
      mi.Hint := s;
      mi.Caption := FileName;
      mi.OnClick := @pmScriptHisClick;

      mi.GroupIndex := 10;
      mi.RadioItem  := True;
      mi.AutoCheck  := True;

      pm.Items.Insert(0, mi);

    end
    else
    begin
      // move filename to first
      if mi.MenuIndex = 0 then
        Exit;
      pm.Items.Remove(mi);
      pmScriptHisAdd(pm, FileName);
    end;
  end;
end;

procedure TfrmMain.pmScriptHisClick(Sender: TObject);
var
  s: string;
  syn: TSynEdit;
  dlg: TSaveDialog;
begin
  s   := TMenuItem(Sender).Hint;
  syn := TSynEdit(FindComponent('synEditScript_' + s));
  LoadScriptFile(syn, TMenuItem(Sender).Caption);
  TSaveDialog(FindComponent('dlgSave_' + s)).FileName := TMenuItem(Sender).Caption;
end;

procedure TfrmMain.errlog(msg: string);
var
  f: Textfile;
begin
  if not errlog_en then
    Exit;

  AssignFile(f, errlogfile);
  if FileExists(errlogfile) then
    Append(f)
  else
    Rewrite(f);
  writeln(f, DateTimeToSTr(now), ' ', msg);
  CloseFile(f);
end;

procedure TfrmMain.setLang(lang: string);
var
  i, x, y: integer;
  cm: TComponent;
  cname: string;
begin
  SetDefaultLang(lang, 'lang');

  clearConvert;
  findConvert(lang);

  clearConstant;
  findConstant(lang);

  // Words can't be auto translate
  for i := 0 to ComponentCount - 1 do
  begin
    if (Components[i] is TLabel) then
    begin
      cm := Components[i].GetParentComponent;
      if (cm = pnlOptionTv) then
      begin
        tvOption.Items[TLabel(Components[i]).Tag].Text :=
          TLabel(Components[i]).Caption;
      end
      else
      begin
        if (cm is TPanel) and (not (cm as TPanel).Visible) then
        begin
          cname := cm.Name;
          Delete(cname, 1, 3);
          cm := FindComponent('sg' + cname);
          if (cm is TStringGrid) then
          begin
            if StrToXY(TLabel(Components[i]).Hint, x, y) then
            begin
              if TStringGrid(cm).Columns.Count > 0 then
                TStringGrid(cm).Columns[x - TStringGrid(cm).FixedCols].Title.Caption :=
                  TLabel(Components[i]).Caption
              else
                TStringGrid(cm).Cells[x, y] := TLabel(Components[i]).Caption;
            end;
          end;
        end;
      end;
    end;

  end;

end;

function TfrmMain.RunTimeToDHMStr(T: integer): string;
var
  D, H, M: integer;
begin
  D := T div (60 * 24);
  T := T mod (60 * 24);
  H := T div 60;
  M := T mod 60;
  if (D = 0) and (H = 0) then
  begin
    if M = 0 then
      Result := ''
    else
      Result := IntToStr(M) + 'm';
  end
  else
  begin
    if D = 0 then
      Result := IntToStr(H) + 'h ' + IntToStr(M) + 'm'
    else
      Result := IntToStr(D) + 'd ' + IntToStr(H) + 'h ' + IntToStr(M) + 'm';
  end;
end;

function TfrmMain.ChrToByte(ch: char): byte;
begin
  case ch of
    '0'..'9': Result := Ord(ch) - Ord('0');
    'A'..'F': Result := Ord(ch) - Ord('A') + 10;
    'a'..'f': Result := Ord(ch) - Ord('a') + 10;
    else
      Result := 0;
  end;
end;

function TfrmMain.Chr2ToByte(c1: char; c2: char): byte;
begin
  Result := ChrToByte(c1) * 16 + ChrToByte(c2);
end;

function TfrmMain.BigBytes(s: string): string;
var
  i: integer;
  ss: string;
begin
  ss := '';
  for i := 1 to Length(s) do
  begin
    case i mod 3 of
      0: insert(s[i], ss, 1);
      1: insert(s[i], ss, 1);
      2: insert(s[i], ss, 2);
    end;
  end;
  Result := ss;
end;

function TfrmMain.IntToByteStr(d: dword): string;
begin
  Result := '';
  if d = 0 then
  begin
    Result := '00';
    Exit;
  end;
  while d > 0 do
  begin
    if Result <> '' then
      Result := Result + ' ';
    Result := Result + Format('%.02X', [d mod 256]);
    d := d div 256;
  end;
  Result := BigBytes(Result);
end;

procedure TfrmMain.StrToBytes(s: string; n: integer; var buf: SysUtils.TByteArray);
var
  i, j: integer;
begin
  if Length(buf) < n then
    exit;

  if Length(s) < (3 * n - 1) then
    for i := 1 to n do
      s := s + '   ';

  j := 1;
  for i := 0 to n - 1 do
  begin
    buf[i] := Chr2ToByte(s[j], s[j + 1]);
    j      := j + 2;
    if s[j] = ' ' then
      j := j + 1;
  end;

end;

procedure TfrmMain.StrToByteBuf(s: string; out bs: string);
var
  i, N: integer;
  b: byte;
begin
  i  := 1;
  N  := Length(s);
  bs := '';

  while True do
  begin
    while s[i] = ' ' do
      i := i + 1;

    if i < N then
    begin
      b := Chr2ToByte(s[i], s[i + 1]);
      i := i + 2;
    end
    else
    begin
      if i = N then
      begin
        b := Chr2ToByte(' ', s[i]);
        i := i + 1;
      end
      else
      begin
        Exit;
      end;
    end;
    if bs <> '' then
      bs := bs + ' ';
    bs   := bs + Format('%.02X', [b]);
  end;
end;

function TfrmMain.StrToXY(dat: string; out x, y: integer): boolean;
var
  p1, p2: integer;
  s1, s2: string;
begin
  Result := False;
  dat    := Trim(dat);
  p1     := 1;
  while p1 <= Length(dat) do
  begin
    if dat[p1] in ['0'..'9'] then
      p1 := p1 + 1
    else
      Break;
  end;
  s1 := Copy(dat, 1, p1 - 1);
  while p1 <= Length(dat) do
  begin
    if not (dat[p1] in ['0'..'9']) then
      p1 := p1 + 1
    else
      Break;
  end;
  p2 := p1;
  while p2 <= Length(dat) do
  begin
    if dat[p2] in ['0'..'9'] then
      p2 := p2 + 1
    else
      Break;
  end;
  s2 := Copy(dat, p1, p2 - p1);
  if (s1 = '') or (s2 = '') then
    Exit;
  if TryStrToInt(s1, x) and TryStrToInt(s2, y) then
    Result := True;
end;

procedure TfrmMain.MPYRunTmpScript(sc: string; out res, err: string);
var
  tmpfile: string;
  F: TextFile;
  CharBuffer: array [0..511] of char;
  ReadCount: integer;
begin
  tmpfile := GetTempFileName + '.py';
  AssignFile(F, tmpfile);
  Rewrite(F);
  writeln(F, sc);
  CloseFile(F);

  ProcessMPY.Parameters.Clear;
  ProcessMPY.Parameters.Add(tmpfile);
  ProcessMPY.Execute;

  res := '';
  err := '';

  while ProcessMPY.Running or (ProcessMPY.Output.NumBytesAvailable > 0) or
    (ProcessMPY.Stderr.NumBytesAvailable > 0) do
  begin
    while ProcessMPY.Output.NumBytesAvailable > 0 do
    begin
      ReadCount := Min(512, ProcessMPY.Output.NumBytesAvailable);
      //Read up to buffer, not more
      ProcessMPY.Output.Read(CharBuffer, ReadCount);
      res := res + Copy(CharBuffer, 0, ReadCount);
      Application.ProcessMessages;
    end;
    // read stderr and write to our stderr
    while ProcessMPY.Stderr.NumBytesAvailable > 0 do
    begin
      ReadCount := Min(512, ProcessMPY.Stderr.NumBytesAvailable);
      //Read up to buffer, not more
      ProcessMPY.Stderr.Read(CharBuffer, ReadCount);
      err := err + Copy(CharBuffer, 0, ReadCount);
      Application.ProcessMessages;
    end;
    Application.ProcessMessages;
  end;

end;

procedure TfrmMain.PYRunTmpScript(sc: string; out res, err: string);
var
  tmpfile: string;
  F: TextFile;
  CharBuffer: array [0..511] of char;
  ReadCount: integer;
begin
  tmpfile := GetTempFileName + '.py';
  AssignFile(F, tmpfile);
  Rewrite(F);
  writeln(F, sc);
  CloseFile(F);

  ProcessPY.Parameters.Clear;
  ProcessPY.Parameters.Add(tmpfile);
  ProcessPY.Execute;

  res := '';
  err := '';

  while ProcessPY.Running or (ProcessPY.Output.NumBytesAvailable > 0) or
    (ProcessPY.Stderr.NumBytesAvailable > 0) do
  begin
    while ProcessPY.Output.NumBytesAvailable > 0 do
    begin
      ReadCount := Min(512, ProcessPY.Output.NumBytesAvailable);
      //Read up to buffer, not more
      ProcessPY.Output.Read(CharBuffer, ReadCount);
      res := res + Copy(CharBuffer, 0, ReadCount);
      Application.ProcessMessages;
    end;
    // read stderr and write to our stderr
    while ProcessPY.Stderr.NumBytesAvailable > 0 do
    begin
      ReadCount := Min(512, ProcessPY.Stderr.NumBytesAvailable);
      //Read up to buffer, not more
      ProcessPY.Stderr.Read(CharBuffer, ReadCount);
      err := err + Copy(CharBuffer, 0, ReadCount);
      Application.ProcessMessages;
    end;
  end;
end;

procedure TfrmMain.ConvertTime(d: TDateTime);
begin
  try
    sgConvertTime.Cells[1, 1] := IntToStr(DateTimeToUnix(d));

    sgConvertTime.Cells[2, 1] := IntToStr(YearOf(d));
    sgConvertTime.Cells[3, 1] := IntToStr(MonthOf(d));
    sgConvertTime.Cells[4, 1] := IntToStr(DayOf(d));
    sgConvertTime.Cells[5, 1] := IntToStr(HourOf(d));
    sgConvertTime.Cells[6, 1] := IntToStr(MinuteOf(d));
    sgConvertTime.Cells[7, 1] := IntToStr(SecondOf(d));

    sgConvertTimeValue.Cells[1, 1] :=
      Format('(%d, %d, %d, %d, %d, %d, %d, %d, %d)',
      [YearOf(d), MonthOf(d), DayOf(d), HourOf(d), MinuteOf(d),
      SecondOf(d), DayOfTheWeek(d) - 1, DayOfTheYear(d), 0]);

    sgConvertTimeValue.Cells[1, 2] := IntToStr(WeekOfTheYear(d));
    sgConvertTimeValue.Cells[1, 3] := IntToStr(DayOfTheYear(d));
    sgConvertTimeValue.Cells[1, 4] := IntToStr(HourOfTheYear(d));
    sgConvertTimeValue.Cells[1, 5] := IntToStr(MinuteOfTheYear(d));
    sgConvertTimeValue.Cells[1, 6] := IntToStr(SecondOfTheYear(d));

    sgConvertTimeValue.Cells[1, 7] := IntToStr(HourOfTheMonth(d));
    sgConvertTimeValue.Cells[1, 8] := IntToStr(MinuteOfTheMonth(d));
    sgConvertTimeValue.Cells[1, 9] := IntToStr(SecondOfTheMonth(d));

    sgConvertTimeValue.Cells[1, 10] := IntToStr(MinuteOfTheDay(d));
    sgConvertTimeValue.Cells[1, 11] := IntToStr(SecondOfTheDay(d));

  except

  end;
end;

procedure TfrmMain.ConvertTime2(d: TDateTime);
begin
  sgConvertTime.Cells[1, 2] := IntToStr(DateTimeToUnix(d));
  sgConvertTime.Cells[2, 2] := IntToStr(YearOf(d));
  sgConvertTime.Cells[3, 2] := IntToStr(MonthOf(d));
  sgConvertTime.Cells[4, 2] := IntToStr(DayOf(d));
  sgConvertTime.Cells[5, 2] := IntToStr(HourOf(d));
  sgConvertTime.Cells[6, 2] := IntToStr(MinuteOf(d));
  sgConvertTime.Cells[7, 2] := IntToStr(SecondOf(d));
end;

procedure TfrmMain.TimeBetween;
var
  d1, d2: TDateTime;
  n1, n2: int64;
begin
  if TryStrToInt64(sgConvertTime.Cells[1, 1], n1) and
    TryStrToInt64(sgConvertTime.Cells[1, 2], n2) then
  begin
    d1 := UnixToDateTime(n1);
    d2 := UnixToDateTime(n2);

    sgConvertTimeValue.Cells[1, TimeBetweenLineOffset + 1] :=
      IntToStr(YearsBetween(d1, d2));
    sgConvertTimeValue.Cells[1, TimeBetweenLineOffset + 2] :=
      IntToStr(MonthsBetween(d1, d2));
    sgConvertTimeValue.Cells[1, TimeBetweenLineOffset + 3] :=
      IntToStr(DaysBetween(d1, d2));
    sgConvertTimeValue.Cells[1, TimeBetweenLineOffset + 4] :=
      IntToStr(HoursBetween(d1, d2));
    sgConvertTimeValue.Cells[1, TimeBetweenLineOffset + 5] :=
      IntToStr(MinutesBetween(d1, d2));
    sgConvertTimeValue.Cells[1, TimeBetweenLineOffset + 6] :=
      IntToStr(SecondsBetween(d1, d2));
    sgConvertTimeValue.Cells[1, TimeBetweenLineOffset + 7] :=
      IntToStr(MilliSecondsBetween(d1, d2));
    sgConvertTimeValue.Cells[1, TimeBetweenLineOffset + 8] :=
      IntToStr(WeeksBetween(d1, d2));
  end;

end;

procedure TfrmMain.sgCalcExprMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
var
  cx, cy, m: integer;
begin
  m := Ord(TShiftStateEnum(Shift));
  case m of
    8:// Mouse Left
    begin
      sgCalcExpr.MouseToCell(X, Y, cx, cy);
      sgCalcExpr.Tag   := cy - 1;
      //sgCalcExpr.ran
      edtCalcExpr.Text := sgCalcExpr.Cells[cx, cy];
      edtCalcExpr.SetFocus;
    end;
    16:// Mouse Right
    begin
      if RMCCopy then
      begin
        sgCalcExpr.MouseToCell(X, Y, cx, cy);
        Clipboard.AsText := sgCalcExpr.Cells[cx, cy];
      end;
    end;
    24:// Mouse Left+Right
    begin
      btnCalcClearHisClick(Sender);
    end;
  end;
end;

procedure TfrmMain.sgChecksumFileClick(Sender: TObject);
var
  sx, sy: integer;
begin
  sx := TStringGrid(Sender).Selection.Location.x;
  sy := TStringGrid(Sender).Selection.Location.y;
  lbChecksumFileHint.Visible := TStringGrid(Sender).Cells[sx, sy] <> '';
  if lbChecksumFileHint.Visible then
  begin
    lbChecksumFileHint.Caption := TStringGrid(Sender).Cells[sx, sy];
    Clipboard.AsText := lbChecksumFileHint.Caption;
  end;
end;

procedure TfrmMain.sgChecksumFileHeaderSized(Sender: TObject;
  IsColumn: boolean; Index: integer);
begin
  // store column width
  sgChecksumFile.Columns[Index - 1].Tag := sgChecksumFile.Columns[Index - 1].Width;
end;

procedure TfrmMain.sgConvertTimeButtonClick(Sender: TObject; aCol, aRow: integer);
begin
  if (aCol = 1) then
  begin
    case aRow of
      1: ConvertTime(now);
      2: ConvertTime2(now);
    end;
    TimeBetween;
  end;
end;

procedure TfrmMain.sgConvertTimeEditingDone(Sender: TObject);
var
  d: TDateTime;
  year, mon, day, hour, min, sec: dword;
  n: int64;
  sx, sy: integer;
begin

  sx := sgConvertTime.Col;
  sy := sgConvertTime.Row;

  if sx = 1 then
  begin
    try
      if TryStrToInt64(sgConvertTime.Cells[1, sy], n) then
      begin
        d := UnixToDateTime(n);
        if sy = 1 then
          ConvertTime(d)
        else
          ConvertTime2(d);
      end

    except
    end;
  end
  else
  begin
    year := 0;
    mon  := 0;
    day  := 0;
    hour := 0;
    min  := 0;
    sec  := 0;
    TryStrToDWord(sgConvertTime.Cells[2, sy], year);
    TryStrToDWord(sgConvertTime.Cells[3, sy], mon);
    TryStrToDWord(sgConvertTime.Cells[4, sy], day);
    TryStrToDWord(sgConvertTime.Cells[5, sy], hour);
    TryStrToDWord(sgConvertTime.Cells[6, sy], min);
    TryStrToDWord(sgConvertTime.Cells[7, sy], sec);
    if TryEncodeDateTime(year, mon, day, hour, min, sec, 0, d) then
    begin
      if sy = 1 then
        ConvertTime(d)
      else
        ConvertTime2(d);
    end
    else
      beep;
  end;

  TimeBetween;
end;

procedure TfrmMain.sgConvertTimeMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
var
  cx, cy: integer;
begin
  if (Button = mbRight) and RMCCopy then
  begin
    TStringGrid(Sender).MouseToCell(X, Y, cx, cy);
    Clipboard.AsText := TStringGrid(Sender).Cells[cx, cy];
  end;
end;

procedure TfrmMain.sgOptionTableDemoClick(Sender: TObject);
begin
  btnOptionTabAlternateColor.Click;
end;

procedure TfrmMain.synEditScript_LittleCStatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
begin
  if synEditScript_LittleC.Modified then
  begin
    if not btnScriptSave_LittleC.Enabled then
    begin
      btnScriptSave_LittleC.Enabled := True;
      tsScriptLittleC.Caption := '*' + tsScriptLittleC.Caption;
    end;
  end;
  btnScriptCaret_LittleC.Caption :=
    Format('%d: %d', [synEditScript_LittleC.CaretY, synEditScript_LittleC.CaretX]);
  if synEditScript_LittleC.SelAvail then
    btnScriptCaret_LittleC.Caption :=
      btnScriptCaret_LittleC.Caption + ' Sel: ' +
      IntToStr(Length(synEditScript_LittleC.SelText));
end;

procedure TfrmMain.synEditScript_MPYStatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
begin
  if synEditScript_MPY.Modified then
  begin
    if not btnScriptSave_MPY.Enabled then
    begin
      btnScriptSave_MPY.Enabled := True;
      tsScriptMpy.Caption := '*' + tsScriptMpy.Caption;
    end;
  end;
  btnScriptCaret_MPY.Caption :=
    Format('%d: %d', [synEditScript_MPY.CaretY, synEditScript_MPY.CaretX]);
  if synEditScript_MPY.SelAvail then
    btnScriptCaret_MPY.Caption :=
      btnScriptCaret_MPY.Caption + ' Sel: ' +
      IntToStr(Length(synEditScript_MPY.SelText));
end;

procedure TfrmMain.synEditScript_PascalStatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
begin
  if synEditScript_Pascal.Modified then
  begin
    if not btnScriptSave_Pascal.Enabled then
    begin
      btnScriptSave_Pascal.Enabled := True;
      tsScriptPascal.Caption := '*' + tsScriptPascal.Caption;
    end;
  end;
  btnScriptCaret_Pascal.Caption :=
    Format('%d: %d', [synEditScript_Pascal.CaretY, synEditScript_Pascal.CaretX]);
  if synEditScript_Pascal.SelAvail then
    btnScriptCaret_Pascal.Caption :=
      btnScriptCaret_Pascal.Caption + ' Sel: ' +
      IntToStr(Length(synEditScript_Pascal.SelText));
end;

end.
