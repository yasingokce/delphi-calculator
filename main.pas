unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  IdBaseComponent, IdNetworkCalculator;

type
  TForm1 = class(TForm)
    DortBtn: TButton;
    BesBtn: TButton;
    AltiBtn: TButton;
    BirBtn: TButton;
    DokuzBtn: TButton;
    SifirBtn: TButton;
    ikiBtn: TButton;
    SekizBtn: TButton;
    YediBtn: TButton;
    UcBtn: TButton;
    EditsPanel: TPanel;
    NumbersPanel: TPanel;
    OperatorsPanel: TPanel;
    CBtn: TButton;
    VirgulBtn: TButton;
    DeleteBtn: TButton;
    ArtiBtn: TButton;
    EksiBtn: TButton;
    CarpiBtn: TButton;
    BoluBtn: TButton;
    EqualBtn: TButton;
    arkaPanel: TPanel;
    ramPanel: TPanel;
    multiPanel: TPanel;

    procedure SifirBtnClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure DeleteBtnClick(Sender: TObject);
    procedure VirgulBtnClick(Sender: TObject);
    procedure CBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ArtiBtnClick(Sender: TObject);
    procedure EqualBtnClick(Sender: TObject);
    procedure CalcAll;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    { Private declarations }
  public
    { Public declarations }

    numFirst: double;
    numSecond: double;
    // ------ for form name ------- //
    cArti: string;
    cEksi: string;
    cBol: string;
    cCarp: string;
    cStandart: string;
    currentOperation: integer;

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  numFirst := 0;
  numSecond := 0;
  // ------ for form name ------- //
  cArti := 'Calculator +';
  cEksi := 'Calculator -';
  cBol := 'Calculator /';
  cCarp := 'Calculator x';
  cStandart := 'Calculator';
  ramPanel.Caption := cStandart;
  EditsPanel.Caption := '0';
end;

procedure TForm1.DeleteBtnClick(Sender: TObject);
// ----- silme butonu ------ //
var
  s: string;
begin
  if EditsPanel.Caption = '' then
  begin
    numFirst := 0;
    numSecond := 0;
    EditsPanel.Caption := '0';
    ramPanel.Caption := cStandart;
  end
    else
  begin
    s := copy(EditsPanel.Caption, 1, length(EditsPanel.Caption) - 1);
    EditsPanel.Caption := s;
    multiPanel.Caption := s;
  end;
end;

procedure TForm1.ArtiBtnClick(Sender: TObject);
// operatör butonlarý
var
  opt: string;
begin
  opt := ((Sender as TButton).Caption);
  if opt = '+' then
  begin
    CalcAll;
    currentOperation := 1;
    EditsPanel.Caption := '';
    ramPanel.Caption := cArti;
    multiPanel.Caption := multiPanel.Caption + '+';
  end
    else if opt = '-' then
  begin
    CalcAll;
    currentOperation := 2;
    EditsPanel.Caption := '';
    ramPanel.Caption := cEksi;
    multiPanel.Caption := multiPanel.Caption + '-';
  end
    else if opt = 'X' then
  begin
    CalcAll;
    currentOperation := 3;
    EditsPanel.Caption := '';
    ramPanel.Caption := cBol;
    multiPanel.Caption := multiPanel.Caption + '*';
  end
    else if opt = '/' then
  begin
    CalcAll;
    currentOperation := 4;
    EditsPanel.Caption := '';
    ramPanel.Caption := cCarp;
    multiPanel.Caption := multiPanel.Caption + '/';
  end;
end;

procedure TForm1.CalcAll;
begin
  if (numFirst <> 0) then // first boþsa dolsun   ve sonra second dolsun
  begin
    numSecond := strtofloat(EditsPanel.Caption);
    if currentOperation = 1 then
    begin
      numFirst := numFirst + numSecond;
    end
      else if currentOperation = 2 then
    begin
      numFirst := numFirst - numSecond;
    end
      else if currentOperation = 3 then
    begin
      numFirst := numFirst * numSecond;
    end
      else if currentOperation = 4 then
    begin
      numFirst := numFirst / numSecond;
    end;
  end
    else
  begin
    numFirst := strtofloat(EditsPanel.Caption);
  end;

end;

procedure TForm1.EqualBtnClick(Sender: TObject);
begin
  CalcAll;
  multiPanel.Caption := '';
  EditsPanel.Caption := FloatToStr(numFirst);
  numFirst := 0;
  numSecond := 0;
  currentOperation := -1;
  ramPanel.Caption := cStandart;
end;

procedure TForm1.SifirBtnClick(Sender: TObject);
begin
  if currentOperation < 0 then
  begin
    EditsPanel.Caption := '';
    currentOperation := 0;
  end;
  // ---- herhangi bir rakama basýlana kadar ilk eleman sýfýr ------ //
  if EditsPanel.Caption = '0' then
  begin
    EditsPanel.Caption := (Sender As TButton).Caption;
    multiPanel.Caption := (Sender As TButton).Caption;
  end
    else
  begin
    EditsPanel.Caption := EditsPanel.Caption + (Sender As TButton).Caption;
    multiPanel.Caption := multiPanel.Caption + (Sender As TButton).Caption;
  end;
end;

procedure TForm1.CBtnClick(Sender: TObject);
// -------- cancel all ---------- //
begin
  numFirst := 0;
  numSecond := 0;
  EditsPanel.Caption := '0';
  ramPanel.Caption := cStandart;
  multiPanel.Caption := '';
end;

procedure TForm1.VirgulBtnClick(Sender: TObject);
var
  s: string;
begin
  if (pos(',', EditsPanel.Caption) <> 0) then
  begin
    // ----- iki kere virgül koyma -------- //
  end
    else
  begin
    EditsPanel.Caption := EditsPanel.Caption + VirgulBtn.Caption;
    multiPanel.Caption := multiPanel.Caption + VirgulBtn.Caption;
  end;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
// ---- artý eksi çarpý bölü butonlarýný kullanma yeteneði---//
begin
  if (Key = VK_MULTIPLY) then
    BoluBtn.click;
  if (Key = VK_DIVIDE) then
    CarpiBtn.click;
  if (Key = VK_ADD) then
    ArtiBtn.click;
  if (Key = VK_SUBTRACT) then
    EksiBtn.click;
  if (Key = VK_BACK) then
    DeleteBtn.click;
  if (Key = VK_OEM_COMMA) then
    VirgulBtn.click;
end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: char);
// ---- rakamlarý kullanma yeteneði---//
begin
  if (Key = '1') then
    BirBtn.click;
  if (Key = '2') then
    ikiBtn.click;
  if (Key = '3') then
    UcBtn.click;
  if (Key = '4') then
    DortBtn.click;
  if (Key = '5') then
    BesBtn.click;
  if (Key = '6') then
    AltiBtn.click;
  if (Key = '7') then
    YediBtn.click;
  if (Key = '8') then
    SekizBtn.click;
  if (Key = '9') then
    DokuzBtn.click;
  if (Key = '0') then
    SifirBtn.click;
end;

// -------- form close destroy ------------- //
procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Form1 := nil;
end;

end.
