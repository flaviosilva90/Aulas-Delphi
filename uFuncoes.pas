unit uFuncoes;

interface

uses
  uDtm,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls, Vcl.ActnMenus,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.StdCtrls;

type

   TFuncoes = Class

    public
     //functions
     class function RegistroExistente(SQL: string): boolean;
     class function RegistroNovo(Chv_Prima, Tabela : string): string;
     class function RegistroInserir(Tabela, Campos, Valores: string): boolean;
     class function RegistroEditar(Tabela, Mudancas, Condicao: string): boolean;
     class function RegistroExcluir(Tabela, Condicao: string): boolean;
     //procedures
     class procedure RegistroPesquisa(v_query: TFDQuery; Condicao, Tabela : string);
     class procedure CombosCarregar(cbx: TComboBox; Tabela, Id, Campo: String);
end;

implementation


{ TFuncoes }

class procedure TFuncoes.CombosCarregar(cbx: TComboBox; Tabela, Id, Campo: String);
var
  v_query: TFDQuery;
begin
  cbx.Clear;
  cbx.AddItem('0-',nil);
  v_query := TFDQuery.Create(nil);
  try
       v_query.Sql.Text := 'select * from '+Tabela;
       v_query.Connection := DtmBancos.FDConexaoLocal;
       try
            v_query.open;
            while not v_query.Eof do
            begin
              cbx.AddItem(v_query.FieldByName(Id).AsString +'-'+ v_query.FieldByName(Campo).AsString,nil);
              v_query.Next;
            end;
            v_query.close;
       except
            on e: exception do begin
                  MessageDlg('Erro de Sintaxe.'+ #13 +' Contate Suporte: '+ e.Message, mterror, [mbok],0);
                  raise;
            end;
       end;
  finally
       v_query.free;
  end;
end;

class function TFuncoes.RegistroEditar(Tabela, Mudancas,
  Condicao: string): boolean;
var
  v_query: TFDQuery;
begin
  result := false;
  v_query := TFDQuery.Create(nil);
  try
     v_query.Sql.Text := 'update '+Tabela+' set '+Mudancas+' where '+Condicao+';';
     v_query.Connection := DtmBancos.FDConexaoLocal;
     try
          v_query.ExecSQL;
          Result := true;
          v_query.close;
     except
          on e: exception do begin
                Result := False;
                MessageDlg('Erro de Sintaxe.'+ #13 +' Contate Suporte: '+ e.Message, mterror, [mbok],0);
                raise;
          end;
     end;
  finally
     v_query.free;
  end;
end;

class function TFuncoes.RegistroExcluir(Tabela, Condicao: string): boolean;
var
  v_query: TFDQuery;
begin
  result := false;
  v_query := TFDQuery.Create(nil);
  try
     v_query.Sql.Text := 'delete from '+Tabela+' where '+Condicao+';';
     v_query.Connection := DtmBancos.FDConexaoLocal;
     try
          v_query.ExecSQL;
          Result := true;
          v_query.close;
     except
          on e: exception do begin
                Result := False;
                MessageDlg('Erro de Sintaxe.'+ #13 +' Contate Suporte: '+ e.Message, mterror, [mbok],0);
                raise;
          end;
     end;
  finally
     v_query.free;
  end;
end;

class function TFuncoes.RegistroExistente(SQL: string): boolean;
var
  v_query: TFDQuery;
begin
  result := false;
  v_query := TFDQuery.Create(nil);
  try
       v_query.Sql.Text := SQL;
       v_query.Connection := DtmBancos.FDConexaoLocal;
       try
            v_query.open;
            if v_query.IsEmpty then
              Result := false
            else
              Result := true;
            v_query.close;
       except
            on e: exception do begin
                  MessageDlg('Erro de Sintaxe.'+ #13 +' Contate Suporte: '+ e.Message, mterror, [mbok],0);
                  raise;
            end;
       end;
  finally
       v_query.free;
  end;
end;

class function TFuncoes.RegistroInserir(Tabela, Campos,
  Valores: string): boolean;
var
  v_query: TFDQuery;
begin
  result := false;
  v_query := TFDQuery.Create(nil);
  try
     v_query.Sql.Text := 'insert into '+Tabela+' ('+Campos+') values ('+Valores+');';
     v_query.Connection := DtmBancos.FDConexaoLocal;
     try
          v_query.ExecSQL;
          Result := true;
          v_query.close;
     except
          on e: exception do begin
                Result := False;
                MessageDlg('Erro de Sintaxe.'+ #13 +' Contate Suporte: '+ e.Message, mterror, [mbok],0);
                raise;
          end;
     end;
  finally
     v_query.free;
  end;
end;

class function TFuncoes.RegistroNovo(Chv_Prima, Tabela: string): string;
var
  v_query: TFDQuery;
begin
  result := '0';
  v_query := TFDQuery.Create(nil);
  try
       v_query.Sql.Text := 'Select max('+Chv_Prima+')+1 as new_reg from '+Tabela;
       v_query.Connection := DtmBancos.FDConexaoLocal;
       try
            v_query.open;
            if not v_query.Eof then
              Result := v_query.FieldByName('new_reg').AsString
            else
              Result := '0';
            v_query.close;
       except
            on e: exception do begin
                  MessageDlg('Erro de Sintaxe.'+ #13 +' Contate Suporte: '+ e.Message, mterror, [mbok],0);
                  raise;
            end;
       end;
  finally
       v_query.free;
  end;
end;

class procedure  TFuncoes.RegistroPesquisa(v_query: TFDQuery; Condicao, Tabela: string);
begin
  try
     v_query.Sql.Text := 'Select * from '+Tabela+ ' where '+Condicao;
     v_query.Connection := DtmBancos.FDConexaoLocal;
     try
        v_query.open;
     except
        on e: exception do begin
              MessageDlg('Erro de Sintaxe.'+ #13 +' Contate Suporte: '+ e.Message, mterror, [mbok],0);
              raise;
        end;
     end;
  finally
  end;

end;

end.
