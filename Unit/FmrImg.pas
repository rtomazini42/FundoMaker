unit FmrImg;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.ExtCtrls, System.ImageList, FMX.ImgList,
  FMX.Controls.Presentation, FMX.Edit, FMX.ComboEdit, FMX.StdCtrls, System.IOUtils, Math;

type
  TfmrImage = class(TForm)
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    ImgFundo: TImage;
    ImgLogo: TImage;
    ComboEdit1: TComboEdit;
    Rectangle3: TRectangle;
    RecFundoLogo: TRectangle;
    Layout1: TLayout;
    Layout3: TLayout;
    ComboEdit3: TComboEdit;
    Rectangle4: TRectangle;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure ComboEdit1Change(Sender: TObject);
    procedure ComboEdit3Change(Sender: TObject);
    procedure Rectangle4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function CentralizaECortaImagem(const Image: TBitmap): TBitmap;
    var
     Logo: TBitmap;
  end;

var
  fmrImage: TfmrImage;


implementation

{$R *.fmx}

procedure TfmrImage.ComboEdit1Change(Sender: TObject);
var
  SelectedImage: string;
  Bitmap: TBitmap;
  ProjectFolderPath: string;
  ImagePath: string;
begin
  SelectedImage := ComboEdit1.Text; // Nome do arquivo selecionado
  if SelectedImage <> '' then
  begin
    // Caminho da pasta de imagens
    ProjectFolderPath := ExtractFilePath(ParamStr(0)) + 'Imgs\Background';
    Bitmap := TBitmap.Create;
    try
      {$IFDEF WIN32} // Compilação condicional para Windows 32 bits
        Bitmap.LoadFromFile(ProjectFolderPath + '\' + SelectedImage);
      {$ENDIF}

      {$IFDEF WIN64} // Compilação condicional para Windows 64 bits
        Bitmap.LoadFromFile(ProjectFolderPath + '\' + SelectedImage);
      {$ENDIF}


      ImgFundo.Bitmap.Assign(Bitmap);
    finally
      Bitmap.Free;
    end;
  end;
end;



procedure TfmrImage.ComboEdit3Change(Sender: TObject);
begin
  if ComboEdit3.Text = 'Vazio' then
  begin
    RecFundoLogo.Visible := False;
  end
  else if ComboEdit3.Text = 'Preto 30%' then
  begin
    RecFundoLogo.Visible := True;
    RecFundoLogo.Fill.Color := TAlphaColors.Black;
    RecFundoLogo.Opacity := 0.3;
  end
  else if ComboEdit3.Text = 'Preto 50%' then
  begin
    RecFundoLogo.Visible := True;
    RecFundoLogo.Fill.Color := TAlphaColors.Black;
    RecFundoLogo.Opacity := 0.5;
  end
  else if ComboEdit3.Text = 'Preto 70%' then
  begin
    RecFundoLogo.Visible := True;
    RecFundoLogo.Fill.Color := TAlphaColors.Black;
    RecFundoLogo.Opacity := 0.7;
  end
  else if ComboEdit3.Text = 'Preto 100%' then
  begin
    RecFundoLogo.Visible := True;
    RecFundoLogo.Fill.Color := TAlphaColors.Black;
    RecFundoLogo.Opacity := 1.0;
  end
  else if ComboEdit3.Text = 'Branco 30%' then
  begin
    RecFundoLogo.Visible := True;
    RecFundoLogo.Fill.Color := TAlphaColors.White;
    RecFundoLogo.Opacity := 0.3;
  end
  else if ComboEdit3.Text = 'Branco 50%' then
  begin
    RecFundoLogo.Visible := True;
    RecFundoLogo.Fill.Color := TAlphaColors.White;
    RecFundoLogo.Opacity := 0.5;
  end
  else if ComboEdit3.Text = 'Branco 70%' then
  begin
    RecFundoLogo.Visible := True;
    RecFundoLogo.Fill.Color := TAlphaColors.White;
    RecFundoLogo.Opacity := 0.7;
  end
  else if ComboEdit3.Text = 'Branco 100%' then
  begin
    RecFundoLogo.Visible := True;
    RecFundoLogo.Fill.Color := TAlphaColors.White;
    RecFundoLogo.Opacity := 1.0;
  end;
end;

procedure TfmrImage.FormShow(Sender: TObject);
var
  ProjectFolderPath: string;
  SearchRec: TSearchRec;
begin
  ImgLogo.Bitmap.Assign(Logo);
  // Caminho da pasta de imagens
  //ProjectFolderPath := ExtractFilePath(ParamStr(0)) + 'Imgs\Background';
  ProjectFolderPath := TPath.Combine(ExtractFilePath(ParamStr(0)), 'Imgs\Background');
  // Limpa o ComboBox
  ComboEdit1.Items.Clear;
  if FindFirst(IncludeTrailingPathDelimiter(ProjectFolderPath) + '*.*', faAnyFile, SearchRec) = 0 then
  begin
    try
      repeat
        if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
          ComboEdit1.Items.Add(SearchRec.Name);
      until FindNext(SearchRec) <> 0;
    finally
      FindClose(SearchRec);
    end;
  end;
  Self.Updated;
end;




procedure TfmrImage.Rectangle4Click(Sender: TObject);
var
  CompositeImage: TBitmap;
  ProjectFolderPath: string;
  CorDestaque: TAlphaColor;
begin
  // Criar um bitmap para compor as imagens
  CompositeImage := TBitmap.Create;
  try
    // Definir o tamanho do bitmap composto
    CompositeImage.Width := 715;
    CompositeImage.Height := 512;

    // Calcula as coordenadas para centralizar a imagem do logo com o tamanho de 256x256
    var LogoX := (CompositeImage.Width - 256) / 2;
    var LogoY := (CompositeImage.Height - 256) / 2;

    // Desenhar as imagens nos componentes no bitmap composto
    CompositeImage.Canvas.BeginScene;
    try
      //fundo
      CompositeImage.Canvas.DrawBitmap(ImgFundo.Bitmap,
        RectF(0, 0, 715, 512),
        RectF(0, 0, 715, 512), 1.0);

        //Detaque
            if ComboEdit3.Text = 'Preto 30%' then
            begin
              CorDestaque := TAlphaColors.Black;
              CompositeImage.Canvas.Fill.Color := CorDestaque;
              CompositeImage.Canvas.FillRect(RectF(0, 128, 715, 384), 0, 0, [], 0.3);
            end
            else if ComboEdit3.Text = 'Preto 50%' then
            begin
              CorDestaque := TAlphaColors.Black;
              CompositeImage.Canvas.Fill.Color := CorDestaque;
              CompositeImage.Canvas.FillRect(RectF(0, 128, 715, 384), 0, 0, [], 0.5);
            end
            else if ComboEdit3.Text = 'Preto 70%' then
            begin
              CorDestaque := TAlphaColors.Black;
              CompositeImage.Canvas.Fill.Color := CorDestaque;
              CompositeImage.Canvas.FillRect(RectF(0, 128, 715, 384), 0, 0, [], 0.7);
            end
            else if ComboEdit3.Text = 'Preto 100%' then
            begin
              CorDestaque := TAlphaColors.Black;
              CompositeImage.Canvas.Fill.Color := CorDestaque;
              CompositeImage.Canvas.FillRect(RectF(0, 128, 715, 384), 0, 0, [], 1);
            end
            else if ComboEdit3.Text = 'Branco 30%' then
            begin
              CorDestaque := TAlphaColors.White;
              CompositeImage.Canvas.Fill.Color := CorDestaque;
              CompositeImage.Canvas.FillRect(RectF(0, 128, 715, 384), 0, 0, [], 0.3);
            end
            else if ComboEdit3.Text = 'Branco 50%' then
            begin
              CorDestaque := TAlphaColors.White;
              CompositeImage.Canvas.Fill.Color := CorDestaque;
              CompositeImage.Canvas.FillRect(RectF(0, 128, 715, 384), 0, 0, [], 0.5);
            end
            else if ComboEdit3.Text = 'Branco 70%' then
            begin
              CorDestaque := TAlphaColors.White;
              CompositeImage.Canvas.Fill.Color := CorDestaque;
              CompositeImage.Canvas.FillRect(RectF(0, 128, 715, 384), 0, 0, [], 0.7);
            end
            else if ComboEdit3.Text = 'Branco 100%' then
            begin
              CorDestaque := TAlphaColors.White;
              CompositeImage.Canvas.Fill.Color := CorDestaque;
              CompositeImage.Canvas.FillRect(RectF(0, 128, 715, 384), 0, 0, [], 1);
            end;


      {CorDestaque := TAlphaColors.Black;
      CompositeImage.Canvas.Fill.Color := CorDestaque;
      CompositeImage.Canvas.FillRect(RectF(0, 128, 715, 384), 0, 0, [], 0.4);}

        //logo
        ImgLogo.Bitmap := CentralizaECortaImagem(ImgLogo.Bitmap);
      CompositeImage.Canvas.DrawBitmap(ImgLogo.Bitmap,
        RectF(0, 0, ImgLogo.Bitmap.Width, ImgLogo.Bitmap.Height),
        RectF(LogoX, LogoY, LogoX + 256, LogoY + 256), 1.0);
      CompositeImage.Canvas.Fill.Bitmap.Bitmap.Assign(RecFundoLogo.Fill.Bitmap.Bitmap);
    finally
      CompositeImage.Canvas.EndScene;
    end;

    // Caminho da pasta para salvar a imagem composta
    ProjectFolderPath := ExtractFilePath(ParamStr(0)) + 'Imgs\Composite';
    // Verifica se a pasta de destino existe, caso contrário, cria
    if not TDirectory.Exists(ProjectFolderPath) then
      TDirectory.CreateDirectory(ProjectFolderPath);
    // Salva o bitmap composto
    CompositeImage.SaveToFile(ProjectFolderPath + '\CompositeImage.jpg'); // Substitua pelo formato desejado
    // Exibe uma mensagem de sucesso
    ShowMessage('Imagem composta salva com sucesso!');
  finally
    CompositeImage.Free;
  end;
end;



function TfmrImage.CentralizaECortaImagem(const Image: TBitmap): TBitmap;   //função antiga
var
  ObjRect: TRect;
  ObjWidth, ObjHeight, MaxSize: Integer;
  X, Y, OffsetX, OffsetY: Integer;
  BitmapData, ResultData: TBitmapData;
begin
  // Encontre a região do objeto no fundo branco
  ObjRect := Rect(0, 0, 0, 0);
  if Image.Map(TMapAccess.Read, BitmapData) then
  try
    for Y := 0 to Image.Height - 1 do
    begin
      for X := 0 to Image.Width - 1 do
      begin
        if BitmapData.GetPixel(X, Y) <> TAlphaColors.White then
        begin
          if (ObjRect.Left = 0) or (X < ObjRect.Left) then
            ObjRect.Left := X;
          if (ObjRect.Right = 0) or (X > ObjRect.Right) then
            ObjRect.Right := X;
          if (ObjRect.Top = 0) or (Y < ObjRect.Top) then
            ObjRect.Top := Y;
          if (ObjRect.Bottom = 0) or (Y > ObjRect.Bottom) then
            ObjRect.Bottom := Y;
        end;
      end;
    end;
  finally
    Image.Unmap(BitmapData);
  end;

   // Verifique se o objeto foi encontrado
   if (ObjRect.Left = 0) and (ObjRect.Right = 0) and (ObjRect.Top = 0) and (ObjRect.Bottom = 0) then
   begin
     ShowMessage('Nenhum objeto encontrado na imagem.');
     Exit(nil);
   end;

   // Centralize o objeto na imagem
   ObjWidth := ObjRect.Right - ObjRect.Left +1;
   ObjHeight := ObjRect.Bottom - ObjRect.Top +1;
   MaxSize := Max(ObjWidth, ObjHeight);

   OffsetX := (MaxSize - ObjWidth) div 2;
   OffsetY := (MaxSize - ObjHeight) div 2;

   // Crie uma nova imagem quadrada com fundo branco
   Result := TBitmap.Create;
   Result.SetSize(MaxSize, MaxSize);
   Result.Clear(TAlphaColors.Null);

   // Copie o objeto centralizado para a nova imagem
   if Result.Map(TMapAccess.Write, ResultData) and Image.Map(TMapAccess.Read, BitmapData) then
     try
       for Y:=0 to ObjHeight-1 do begin
         for X:=0 to ObjWidth-1 do begin
           ResultData.SetPixel(OffsetX + X, OffsetY + Y, BitmapData.GetPixel(ObjRect.Left + X, ObjRect.Top + Y));
         end;
       end;
     finally
       Result.Unmap(ResultData);
       Image.Unmap(BitmapData);
     end;

end;


end.
