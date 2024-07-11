unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ZAbstractConnection, ZConnection, Grids, DBGrids, StdCtrls;

type
  TForm1 = class(TForm)
    lbl1: TLabel;
    lbl2: TLabel;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    btn4: TButton;
    dbgrd1: TDBGrid;
    ZConnection1: TZConnection;
    ZPenjualan: TZQuery;
    DataSource: TDataSource;
    edt1: TEdit;
    edt2: TEdit;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure dbgrd1CellClick(Column: TColumn);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
   a: string;
implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
begin  //simpan
try
    // Menyusun perintah SQL untuk menyisipkan data
    Form1.ZSatuan.SQL.Clear;
    Form1.ZSatuan.SQL.Add('INSERT INTO satuan (nama, deskripsi) VALUES (:nama, :deskripsi)');

    // Menetapkan nilai parameter
    Form1.ZSatuan.Params.ParamByName('nama').AsString := edt1.Text;
    Form1.ZSatuan.Params.ParamByName('deskripsi').AsString := 'Deskripsi default'; // Ganti dengan deskripsi yang diinginkan atau ambil dari komponen lain

    // Mengeksekusi perintah SQL
    Form1.ZSatuan.ExecSQL;

    // Menyusun perintah SQL untuk membuka data yang telah dimasukkan
    Form1.ZSatuan.SQL.Clear;
    Form1.ZSatuan.SQL.Add('SELECT * FROM satuan');
    Form1.ZSatuan.Open;

    // Menampilkan pesan sukses
    ShowMessage('Data Berhasil di Simpan!');
  except
    on E: Exception do
      ShowMessage('Terjadi kesalahan: ' + E.Message);
  end;
end;


procedure TForm1.btn2Click(Sender: TObject);
begin
  try
    // Validasi Nama
    if Trim(edt1.Text) = '' then
    begin
      ShowMessage('Nama tidak boleh kosong.');
      Exit;
    end;

    // Validasi Deskripsi
    if Trim(edt2.Text) = '' then
    begin
      ShowMessage('Deskripsi tidak boleh kosong.');
      Exit;
    end;

    // Menyiapkan perintah SQL untuk memperbarui deskripsi berdasarkan nama
    Form1.ZSatuan.SQL.Clear;
    Form1.ZSatuan.SQL.Add('UPDATE satuan SET deskripsi = :deskripsi WHERE nama = :nama');

    // Menetapkan nilai parameter
    Form1.ZSatuan.Params.ParamByName('deskripsi').AsString := edt2.Text;  // Deskripsi baru
    Form1.ZSatuan.Params.ParamByName('nama').AsString := edt1.Text;  // Nama dari baris yang akan diperbarui

    // Mengeksekusi perintah SQL
    Form1.ZSatuan.ExecSQL;

    // Menyiapkan perintah SQL untuk membuka data yang telah diperbarui
    Form1.ZSatuan.SQL.Clear;
    Form1.ZSatuan.SQL.Add('SELECT * FROM satuan');
    Form1.ZSatuan.Open;

    // Menampilkan pesan sukses
    ShowMessage('Deskripsi berhasil diupdate untuk nama yang dimasukkan!');
  except
    on E: Exception do
      ShowMessage('Terjadi kesalahan: ' + E.Message);
  end;
end;



procedure TForm1.dbgrd1CellClick(Column: TColumn);
begin
edt1.Text:= Form1.ZSatuan.Fields[1].AsString;
a:= Form1.ZSatuan.Fields[0].AsString;
end;

procedure TForm1.btn3Click(Sender: TObject);
begin
with Form1.ZSatuan do
begin
  SQL.Clear;
  SQL.Add('delete from satuan where id="'+a+'"');
  ExecSQL;

  SQL.Clear;
  SQL.Add('select * from satuan');
  Open;
end;
ShowMessage('Data Berhasil di Delete!');
end;

procedure TForm1.btn4Click(Sender: TObject);
begin
edt1.Text :='';
edt2.Text :='';
end;

end.
