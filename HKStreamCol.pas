unit HKStreamCol;

{
----------------------------------------------------------------
THKStreams v1.6 by Harry Kakoulidis 12/1999
kcm@mailbox.gr
http://kakoulidis.homepage.com

This is Freeware. Please copy HKStrm16.zip unchanged.
If you find bugs, have options etc. Please send at my e-mail.

The use of this component is at your own risk.
I do not take any responsibility for any damages.

----------------------------------------------------------------
Update v1.6

  * Compability problem with Delphi 3
    pointed out by Glenn (buddyboy@idcomm.com)

  * Wrong password event idea by Lai xiaolong (laixl@mei29.scgb.com)

  * Bug with empty streams pointed
    out by Simon Horup, Crystal Art Software (info@casdk.com)

  * Bug with corrupted compressed files pointed out by
    Tsahi Chitin (TUtils@poboxes.com)	

----------------------------------------------------------------
}


interface

uses
  HKStreamRoutines,Windows, Messages, SysUtils, Classes, Graphics, Controls;

type
 TGoodbytes = array[1..8] of byte;
 ECorruptFile = class(Exception);

const
 EncryptedByte : array[false..true] of Byte = (ord(' '),ord('*'));
 CompressedByte : array[false..true] of byte = (ord(' '),ord('&'));
 Goodbytes : TGoodbytes = (1,2,3,4,5,6,7,8);

type
  TOnAskForKey = Function(sender : TObject) : string of object;

  THKStreams = class(TComponent)
  private
   FCompressed,FEncrypted : Boolean;
   FKey : String;
   FOnAskForKey : TOnAskForKey;
   FOnCorrupt : TNotifyEvent;
   procedure WriteStr(S: String; Stream: TStream);
   function ReadStr(Stream: TStream): string;
   Procedure LoadFromStreamNor(ms : TStream);
   Procedure SaveToStreamNor(ms : TStream);
    function CheckGood(ms: TStream): boolean;
    procedure FoundCorrupt;
  public
   StreamList : TStringList;
   Constructor Create(AOWner : TComponent); override;
   Destructor Destroy; override;
   Procedure LoadFromFile(const Filename : string);
   Procedure SaveToFile(const Filename : string);
   Procedure AddStream(Const ID : string; Source : TStream);
   Procedure RemoveStream(Const ID : String);
   Procedure LoadFromStream(ms : TStream);
   Procedure SaveToStream(ms : TStream);
   Procedure GetStream(Const ID : string; Dest : TStream);
   Procedure ClearStreams;
  published
   property Compressed : boolean read FCompressed write FCompressed;
   property Encrypted : boolean read FEncrypted write FEncrypted;
   Property Key : string read FKey write FKey;
   Property OnAskForKey : TOnAskForKey read FOnAskForKey write FOnAskForKey;
   property OnCorrupt : TNotifyEvent read FOnCorrupt write FOnCorrupt;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('HAKA',[THKStreams]);
end;

{ THKStreams }

procedure THKStreams.AddStream(const ID: string; Source: TStream);
var ms : TFileStream;
    j:INTEGER;
    a:string;
begin
 a:=extractfilename(id);
 if (length(id)>0) and (assigned(source)) then begin
  ms:=TFileStream.Create(a+'.$$$',fmcreate,fmShareExclusive);
  ms.CopyFrom(source,0);
  Streamlist.AddObject(ID,ms);
 end;
end;

procedure THKStreams.ClearStreams;
var q,a:integer;
    p,id:string;
begin
 with StreamList do begin
  for a:=0 to count-1 do
   begin
   TFileStream(objects[a]).free;
   id:=streamlist[a];
   p:=extractfilename(id);
   deletefile(p+'.$$$');
   end;
  deletefile('Lhauxil.$$$');
  deletefile('Chauxil.$$$');
  clear;
 end;
end;

constructor THKStreams.Create(AOWner: TComponent);
begin
 inherited Create(AOwner);
 FCompressed:=True;
 FEncrypted:=False;
 StreamList:=TStringList.create;
 StreamList.Sorted:=true;
end;

destructor THKStreams.Destroy;
begin
 ClearStreams;
 inherited Destroy;
end;

procedure THKStreams.GetStream(const ID: string; Dest: TStream);
var i:integer;
begin
 if (length(id)>0) then begin
  i:=Streamlist.IndexOf(ID);
  if i>=0 then
   dest.CopyFrom(TFileStream(Streamlist.objects[i]),0);
  dest.Position:=0;
 end;
end;

procedure THKStreams.LoadFromFile(const Filename: string);
var fs:TFileStream;
begin
 Fs:=TFileStream.Create(FileName,fmOpenRead);
 try
  LoadFromStream(fs);
 finally
  FS.free;
 end;
end;

Procedure THKStreams.FoundCorrupt;
begin
 if assigned(FOnCorrupt) then FOnCorrupt(Self);
 raise ECorruptFile.Create('File is corrupt.');
end;



function THKStreams.CheckGood(ms : TStream) : boolean;
var
 GoodTest : TGoodBytes; a:integer;
begin
 ms.Position:=0;
 ms.read(GoodTest,sizeof(TGoodBytes));
 result:=true;
 for a:=1 to sizeof(TGoodBytes) do
  if goodbytes[a] <> GoodTest[a] then begin
   FoundCorrupt;
   result:=false;
   exit;
  end;
end;

procedure THKStreams.LoadFromStream(ms: TStream);
var
e,c:byte; AKey : string;
CMEM,MEM:TFilestream;
begin
 AKey:=FKey;
 Cmem:=TFileStream.Create('Chauxil.$$$',fmcreate);
 mem:=TFileStream.Create('Lhauxil.$$$',fmcreate);
 try
  ms.Position:=0;
  ms.read(c,sizeof(c));
  ms.read(e,sizeof(e));
  CMem.copyfrom(ms,ms.size-2);
  CMEm.position:=0;
  if (e = EncryptedByte[True]) then begin
   If not assigned(FOnAskForKey) then AKey:=FKey else AKey:=FOnAskForKey(Self);
   try DecryptStream(CMem,AKEy);
   except on Exception do begin foundcorrupt; end; end;
  end;
  if not (c = CompressedByte[True]) then
   if not CheckGood(CMem) then exit;
  CMem.Position:=0;
  if (c = CompressedByte[True]) then
   try
    LHAExpand(Cmem,Mem)
   except
    on Exception do begin
     FoundCorrupt;
    end;
   end
   else Mem.copyfrom(Cmem,0);
  LoadFromStreamNor(Mem);
 finally
  CMem.Free;
  mem.free;
 end;
 FKey:=AKey;
 FCompressed:=(C = CompressedByte[True]);
 FEncrypted:=(e = EncryptedByte[True]);
end;

procedure THKStreams.LoadFromStreamNor(ms: TStream);
var
 Mem : TFileStream;
 Count,size,a : integer;
 ID : string;
begin
 if not CheckGood(ms) then exit;
 ClearStreams;
 ms.Position:=sizeof(TGoodBytes);
 ms.read(count,sizeof(count));
 for a:=0 to count - 1 do begin
  ID:=ReadStr(ms);
  mem:=TFileStream.create(extractfilename(id)+'.$$$',fmCreate,fmShareExclusive);
  ms.read(Size,sizeof(size));
  if size<>0 then
  mem.CopyFrom(ms,size);
  Streamlist.AddObject(ID,mem);
 end;
end;

function THKStreams.ReadStr(Stream: TStream): string;
var
 i:word;
 s:string;
begin
 stream.Read(i,sizeof(i));
 setlength(s,i);
 stream.Read(pchar(s)^,i);
 result:=s;
end;

procedure THKStreams.RemoveStream(const ID: String);
var i:integer;
begin
 if (length(id)>0) then begin
  i:=Streamlist.IndexOf(ID);
  if i>=0 then
   TFileStream(Streamlist.objects[i]).free;
   Streamlist.Delete(i);
 end;
end;

procedure THKStreams.SaveToFile(const Filename: string);
var fs:TFileStream;
begin
 Fs:=TFileStream.Create(FileName,fmCreate);
 try
  SaveToStream(fs);
 finally
  FS.free;
 end;
end;


procedure THKStreams.SaveToStream(ms: TStream);
var
 e,c:byte;
 CMem,MEM:TFilestream;
begin
 Cmem:=TFileStream.Create('Chauxil.$$$',fmcreate);
 mem:=TFileStream.Create('Lhauxil.$$$',fmcreate);
 try
  SaveToStreamNor(mem);
  mem.position:=0;
  c:=CompressedByte[FCompressed];
  e:=EncryptedByte[FEncrypted and (FKey<>'')];
  ms.Write(c,sizeof(c));
  ms.write(e,sizeof(e));
  if FCompressed
   then LHACompress(mem,CMem)
   else CMem.CopyFrom(mem,0);
  if (FEncrypted) and (FKey<>'')
   then EncryptStream(CMem,Fkey);
  ms.CopyFrom(CMem,0);
 finally
  mem.free;
  CMem.free;
 end;
end;

procedure THKStreams.SaveToStreamNor(ms : TStream);
var
 Count,size,a : integer;
begin
 ms.write(goodbytes,sizeof(Tgoodbytes));
 count:=Streamlist.Count;
 ms.write(count,sizeof(count));
 for a:=0 to count-1 do begin
  Writestr(Streamlist.strings[a],ms);
  size:=TFileStream(Streamlist.Objects[a]).size;
  ms.Write(size,sizeof(size));
  ms.CopyFrom(TFileStream(StreamList.Objects[a]),0);
 end;
end;

procedure THKStreams.WriteStr(S: String; Stream: TStream);
var
 i:word;
begin
 i:=length(s);
 stream.Write(i,sizeof(i));
 stream.write(pchar(s)^,i);
end;

end.
