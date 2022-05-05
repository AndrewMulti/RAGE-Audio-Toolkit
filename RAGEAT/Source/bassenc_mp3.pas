{
  BASSenc_MP3 2.4 Delphi unit
  Copyright (c) 2018 Un4seen Developments Ltd.

  See the BASSENC_MP3.CHM file for more detailed documentation
}

Unit BASSenc_MP3;

interface

{$IFDEF MSWINDOWS}
uses BASSenc, Windows;
{$ELSE}
uses BASSenc;
{$ENDIF}

const
{$IFDEF MSWINDOWS}
  bassencmp3dll = 'bassenc_mp3.dll';
{$ENDIF}
{$IFDEF LINUX}
  bassencmp3dll = 'libbassenc_mp3.so';
{$ENDIF}
{$IFDEF MACOS}
  bassencmp3dll = 'libbassenc_mp3.dylib';
{$ENDIF}

function BASS_Encode_MP3_GetVersion: DWORD; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencmp3dll;

function BASS_Encode_MP3_Start(handle:DWORD; options:PChar; flags:DWORD; proc:uint; user:Pointer): HENCODE; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencmp3dll;
function BASS_Encode_MP3_StartFile(handle:DWORD; options:PChar; flags:DWORD; filename:PChar): HENCODE; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencmp3dll;

implementation

end.
