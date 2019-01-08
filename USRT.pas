unit USRT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComObj, ActiveX, Spin;

type
  TFrmPrincipal = class(TForm)
    BtnAtivar: TButton;
    BtnProcurar: TButton;
    MmoLog: TMemo;
    SePorta: TSpinEdit;
    procedure BtnAtivarClick(Sender: TObject);
    procedure BtnProcurarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;
  IP: string = '';

implementation

{$R *.dfm}

procedure RunDosInMemo(DosApp: string; AMemo: TMemo);
 const
  ReadBuffer = 2400;
 var
  Security: TSecurityAttributes;
  ReadPipe, WritePipe: THandle;
  start: TStartUpInfo;
  ProcessInfo: TProcessInformation;
  Buffer: PChar;
  BytesRead: DWORD;
  Apprunning: DWORD;
begin
  with Security do
  begin
    nlength := SizeOf(TSecurityAttributes);
    binherithandle := true;
    lpsecuritydescriptor := nil;
  end;
  if Createpipe (ReadPipe, WritePipe, @Security, 0) then
  begin
    Buffer := AllocMem(ReadBuffer + 1);
    FillChar(Start, Sizeof(Start), #0);
    start.cb := SizeOf(start);
    start.hStdOutput := WritePipe;
    start.hStdInput := ReadPipe;
    start.dwFlags := STARTF_USESTDHANDLES + STARTF_USESHOWWINDOW;
    start.wShowWindow := SW_HIDE;

    if CreateProcess(nil, PChar(DosApp), @Security, @Security, True, NORMAL_PRIORITY_CLASS, nil, nil, start, ProcessInfo) then
    begin
      repeat
        Apprunning := WaitForSingleObject(ProcessInfo.hProcess, 100);
        Application.ProcessMessages;
      until (Apprunning <> WAIT_TIMEOUT);
      repeat
        BytesRead := 0;
        ReadFile(ReadPipe,Buffer[0], ReadBuffer, BytesRead, nil);
        Buffer[BytesRead] := #0;
        OemToAnsi(Buffer, Buffer);
        AMemo.Text := AMemo.text + string(Buffer);
      until (BytesRead < ReadBuffer);
    end;
    FreeMem(Buffer);
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
    CloseHandle(ReadPipe);
    CloseHandle(WritePipe);
  end;
end;

procedure TFrmPrincipal.BtnProcurarClick(Sender: TObject);
 var
  i: Integer;
  Tmp: string;
begin
  MmoLog.Clear;
  MmoLog.Lines.Add('Listando....');
  MmoLog.Lines.Add('===================================>');
  RunDosInMemo('arp -a', MmoLog);
  MmoLog.Lines.Add('');
  for i := 0 to MmoLog.Lines.Count - 1 do
  begin
    if (Pos('88-f7-c7-6e-bc-94', MmoLog.Lines[i]) > 0) then
      IP := MmoLog.Lines.Strings[i];
  end;
  if (IP = '') then
  begin
    ShowMessage('ERRO! Roteador não encontrado, verifique sua instalação!');
    MmoLog.Lines.Add('===================================>');
    MmoLog.Lines.Add('ERRO! Roteador não encontrado');
    Exit;
  end;
  BtnAtivar.Enabled := True;
  ShowMessage('SUCESSO! Encontrado!');
  MmoLog.Lines.Add('===================================>');
  MmoLog.Lines.Add('SUCESSO! Roteador encontrado!');
  MmoLog.Lines.Add('===================================>');
  Tmp := IP;
  IP := Trim(Tmp);
  IP := Copy(IP, 1, Pos('88-f7-c7-6e-bc-94', IP) - 1);
  Tmp := IP;
  IP := Trim(Tmp);
  MmoLog.Lines.Add('O endereço do Roteador é ' + IP);
end;

procedure TFrmPrincipal.BtnAtivarClick(Sender: TObject);
var
  NATUPnP, PortMapping: OleVariant;
begin
  BtnAtivar.Enabled := False;
  NATUPnP := CreateOLEObject('HNetCfg.NATUPnP');
  PortMapping := NATUPnP.StaticPortMappingCollection;
  try
    PortMapping.Add(SePorta.Value, 'TCP', 8080, IP, True, 'teste');
  except
    ShowMessage('ERRO! A porta selecionada já está em uso!');
    Exit;
  end;
  ShowMessage('SUCESSO! SecurityRobot ativado com êxito na porta ' + IntToStr(SePorta.Value) + '.');
end;

end.
