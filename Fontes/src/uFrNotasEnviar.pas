unit uFrNotasEnviar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls;

type
  TFrNotasEnviar = class(TFrame)
    Panel1: TPanel;
    Panel2: TPanel;
    btnEnviarSefaz: TButton;
    btnImprimir: TButton;
    DBGrid1: TDBGrid;
    dsoNotasEnviar: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
