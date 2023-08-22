unit Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts,
  System.Actions, FMX.ActnList, FMX.StdActns, FMX.MediaLibrary.Actions;

type
  TfmrPrincipal = class(TForm)
    topo: TRectangle;
    Label1: TLabel;
    Logo: TPath;
    BtnUpar: TRectangle;
    Path1: TPath;
    Layout1: TLayout;
    LayBtn1: TLayout;
    Label4: TLabel;
    LayBtn4: TLayout;
    Rectangle3: TRectangle;
    Path3: TPath;
    Label6: TLabel;
    LayBtn3: TLayout;
    Rectangle4: TRectangle;
    Path4: TPath;
    Label7: TLabel;
    LayBtn2: TLayout;
    Rectangle5: TRectangle;
    Path5: TPath;
    Label8: TLabel;
    RecBtn4: TRectangle;
    RecBtn3: TRectangle;
    RecBtn2: TRectangle;
    RecBtn1: TRectangle;
    Layout2: TLayout;
    Rectangle1: TRectangle;
    Layout3: TLayout;
    Label2: TLabel;
    Path2: TPath;
    Layout4: TLayout;
    OpenDialog1: TOpenDialog;
    ActionList1: TActionList;
    TakePhotoFromLibraryAction1: TTakePhotoFromLibraryAction;
    procedure LayBtn1MouseEnter(Sender: TObject);
    procedure RecBtn1MouseEnter(Sender: TObject);
    procedure RecBtn1MouseLeave(Sender: TObject);
    procedure RecBtn2MouseEnter(Sender: TObject);
    procedure RecBtn2MouseLeave(Sender: TObject);
    procedure RecBtn3MouseEnter(Sender: TObject);
    procedure RecBtn3MouseLeave(Sender: TObject);
    procedure RecBtn4MouseEnter(Sender: TObject);
    procedure RecBtn4MouseLeave(Sender: TObject);
    procedure RecBtn1Click(Sender: TObject);
    procedure RecBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    var
     LogoImg: TBitmap;
  end;

var
  fmrPrincipal: TfmrPrincipal;


implementation

{$R *.fmx}

uses
   {$IFDEF WIN32}
    ShellAPI,
    {$ENDIF}
FmrImg;





procedure TfmrPrincipal.LayBtn1MouseEnter(Sender: TObject);
begin
  RecBtn1.Fill.Color := TAlphaColors.Darkblue;
end;

procedure TfmrPrincipal.RecBtn1Click(Sender: TObject);
var

  ProjectFolderPath: string;
begin
   LogoImg := TBitmap.Create;
   ProjectFolderPath := ExtractFilePath(ParamStr(0)); // Obt�m o caminho da pasta do projeto
   OpenDialog1.InitialDir := ProjectFolderPath + 'Imgs\Background';
  {$IFDEF MSWINDOWS} // Compila��o condicional para Windows
    OpenDialog1.Filter := 'Imagens|*.jpg;*.jpeg;*.png;*.bmp';
    if OpenDialog1.Execute then
    begin
      LogoImg.LoadFromFile(OpenDialog1.FileName);
    end;
  {$ENDIF}
   {$IFDEF ANDROID}
  // Plataforma Android: Usar a fun��o TakePhotoFromLibrary
  FPermissionCamera := JStringToString(TJManifest_permission.JavaClass.CAMERA);
  FPermissionReadExternalStorage := JStringToString(TJManifest_permission.JavaClass.READ_EXTERNAL_STORAGE);
  FPermissionWriteExternalStorage := JStringToString(TJManifest_permission.JavaClass.WRITE_EXTERNAL_STORAGE);
   PermissionsService.RequestPermissions([FPermissionReadExternalStorage, FPermissionWriteExternalStorage], LoadPicturePermissionRequestResult, DisplayRationale);

  {$ENDIF}
end;

procedure TfmrPrincipal.RecBtn1MouseEnter(Sender: TObject);
begin
    RecBtn1.Fill.Color := TAlphaColors.Lightskyblue;
    path1.Fill.Color  := TAlphaColors.Lightyellow;
end;

procedure TfmrPrincipal.RecBtn1MouseLeave(Sender: TObject);
begin
    RecBtn1.Fill.Color := TAlphaColors.White;
    path1.Fill.Color  := TAlphaColors.White;
end;

procedure TfmrPrincipal.RecBtn2MouseEnter(Sender: TObject);
begin
    RecBtn2.Fill.Color := TAlphaColors.Lightskyblue;
    path5.Fill.Color  := TAlphaColors.Lightyellow;
end;

procedure TfmrPrincipal.RecBtn2MouseLeave(Sender: TObject);
begin
    RecBtn2.Fill.Color := TAlphaColors.White;
    path5.Fill.Color  := TAlphaColors.White;
end;

procedure TfmrPrincipal.RecBtn3Click(Sender: TObject);
begin
  fmrImage := TfmrImage.Create(Application); // Crie uma inst�ncia do formul�rio TImagem
  fmrImage.Logo := LogoImg;
  fmrImage.Show; // Exiba o formul�rio TImagem
end;

procedure TfmrPrincipal.RecBtn3MouseEnter(Sender: TObject);
begin
    RecBtn3.Fill.Color := TAlphaColors.Lightskyblue;
    path4.Fill.Color  := TAlphaColors.Lightyellow;
end;

procedure TfmrPrincipal.RecBtn3MouseLeave(Sender: TObject);
begin
    RecBtn3.Fill.Color := TAlphaColors.White;
    path4.Fill.Color  := TAlphaColors.White;
end;

procedure TfmrPrincipal.RecBtn4MouseEnter(Sender: TObject);
begin
    RecBtn4.Fill.Color := TAlphaColors.Lightskyblue;
    path3.Fill.Color  := TAlphaColors.Lightyellow;
end;

procedure TfmrPrincipal.RecBtn4MouseLeave(Sender: TObject);
begin
    RecBtn4.Fill.Color := TAlphaColors.White;
    path3.Fill.Color  := TAlphaColors.White;

end;

end.
