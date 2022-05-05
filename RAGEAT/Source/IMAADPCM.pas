unit IMAADPCM;

interface

uses
  System.SysUtils, System.Classes, Vcl.Dialogs;

type
  TADPCMState = class
    valprev: smallint;
    index: byte;
  end;

  procedure EncodeAudio(ins, outs, states: TMemoryStream; BlockSize: integer);
  function DecodeAdpcm(input: byte; state: TADPCMState): smallint;
  function EncodeAdpcm(input: smallint; state: TADPCMState): byte;

const
  indexTable: array[0..15] of integer = (-1, -1, -1, -1, 2, 4, 6, 8, -1, -1, -1, -1, 2, 4, 6, 8);
  stepsizeTable: array[0..88] of integer = (7, 8, 9, 10, 11, 12, 13, 14, 16, 17,
                                     19, 21, 23, 25, 28, 31, 34, 37, 41, 45,
                                     50, 55, 60, 66, 73, 80, 88, 97, 107, 118,
                                     130, 143, 157, 173, 190, 209, 230, 253, 279, 307,
                                     337, 371, 408, 449, 494, 544, 598, 658, 724, 796,
                                     876, 963, 1060, 1166, 1282, 1411, 1552, 1707, 1878, 2066,
                                     2272, 2499, 2749, 3024, 3327, 3660, 4026, 4428, 4871, 5358,
                                     5894, 6484, 7132, 7845, 8630, 9493, 10442, 11487, 12635, 13899,
                                     15289, 16818, 18500, 20350, 22385, 24623, 27086, 29794, 32767);

implementation

function DecodeADPCM(input: byte; state: TADPCMState): smallint;
var
  index, step, valpred, delta, vpdiff: integer;
  sign: boolean;
begin
  index:=state.index;
  step:=stepsizeTable[index];
  valpred:=state.valprev;
  delta:=input;
  index:=index+indexTable[delta];
  if index<0 then index:=0;
  if index>88 then index:=88;
  if (delta and 8 = 8) then sign:=true else sign:=false;
  delta:=delta and 7;
  vpdiff:=step shr 3;
  if (delta and 4 = 4) then vpdiff:=vpdiff+step;
  if (delta and 2 = 2) then vpdiff:=vpdiff+step shr 1;
  if (delta and 1 = 1) then vpdiff:=vpdiff+step shr 2;
  if sign then valpred:=valpred-vpdiff
  else valpred:=valpred+vpdiff;
  if valpred>32767 then valpred:=32767
  else if valpred<-32768 then valpred:=-32768;
  state.valprev:=valpred;
  state.index:=index;
  Result:=valpred;
end;

function EncodeADPCM(input: smallint; state: TADPCMState): byte;
var
  index, step, valpred, delta, code, diff, tempstep, diffq: integer;
  sign: boolean;
begin
  index:=state.index;
  step:=stepsizeTable[index];
  valpred:=state.valprev;
  delta:=input;
  diff:=delta-valpred;
  if diff>=0 then code:=0
  else begin
    code:=8;
    diff:=diff*(-1);
  end;
  tempstep:=step;
  if diff>=tempstep then begin
    code:=code or 4;
    diff:=diff-tempstep;
  end;
  tempstep:=tempstep shr 1;
  if diff>=tempstep then begin
    code:=code or 2;
    diff:=diff-tempstep;
  end;
  tempstep:=tempstep shr 1;
  if diff>=tempstep then code:=code or 1;
  diffq:=step shr 3;
  if (code and 4 = 4) then diffq:=diffq+step;
  if (code and 2 = 2) then diffq:=diffq+step shr 1;
  if (code and 1 = 1) then diffq:=diffq+step shr 2;
  if (code and 8 = 8) then sign:=true else sign:=false;
  if sign then valpred:=valpred-diffq
  else valpred:=valpred+diffq;
  if valpred>32767 then valpred:=32767
  else if valpred<-32768 then valpred:=-32768;
  index:=index+indexTable[code];
  if index<0 then index:=0;
  if index>88 then index:=88;
  state.valprev:=valpred;
  state.index:=index;
  Result:=code and 15;
end;

procedure EncodeAudio(ins, outs, states: TMemoryStream; BlockSize: integer);
var
  i, j, m, k, bufferSize: integer;
  inBuf: array of smallint;
  outBuf, aout: array of byte;
  inbuf1, inbuf2, prevval: smallint;
  prevind: byte;
  tempstate: TADPCMState;
begin
  bufferSize:=BlockSize div 2;
  SetLength(inBuf, bufferSize);
  SetLength(outBuf, bufferSize);
  m:=1;
  tempstate:=TADPCMState.Create;
  tempstate.valprev:=0;
  tempstate.index:=0;
  for i:=0 to (bufferSize div 2-1) do begin
    ins.Read(inbuf1, 2);
    ins.Read(inbuf2, 2);
    outBuf[i]:=EncodeADPCM(inbuf1, tempstate) or (EncodeADPCM(inbuf2, tempstate) shl 4);
    k:=m*2048-1;
    if i=0 then begin
      states.Write(tempstate.valprev, 2);
      states.Write(tempstate.index, 1);
    end;
    if i=k then begin
      prevval:=tempstate.valprev;
      prevind:=tempstate.index;
    end;
    if i=k+1 then begin
      states.Write(prevval, 2);
      states.Write(prevind, 1);
      m:=m+1;
    end;
  end;
  outs.Write(outBuf[0], bufferSize div 2);
  SetLength(inBuf, 0);
  SetLength(outBuf, 0);
end;

end.
