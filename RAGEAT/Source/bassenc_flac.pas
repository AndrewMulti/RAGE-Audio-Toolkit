{
  BASSenc_FLAC 2.4 Delphi unit
  Copyright (c) 2017-2020 Un4seen Developments Ltd.

  See the BASSENC_FLAC.CHM file for more detailed documentation
}

Unit BASSenc_FLAC;

interface

{$IFDEF MSWINDOWS}
uses BASSenc, Windows;
{$ELSE}
uses BASSenc;
{$ENDIF}

const
  // BASS_Encode_FLAC_NewStreams flags
  BASS_ENCODE_FLAC_RESET = $1000000;

{$IFDEF MSWINDOWS}
  bassencflacdll = 'bassenc_flac.dll';
{$ENDIF}
{$IFDEF LINUX}
  bassencflacdll = 'libbassenc_flac.so';
{$ENDIF}
{$IFDEF ANDROID}
  bassencflacdll = 'libbassenc_flac.so';
{$ENDIF}
{$IFDEF MACOS}
  {$IFDEF IOS}
    bassencflacdll = 'libbassenc_flac.a';
  {$ELSE}
    bassencflacdll = 'libbassenc_flac.dylib';
  {$ENDIF}
{$ENDIF}

function BASS_Encode_FLAC_GetVersion: DWORD; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencflacdll;

function BASS_Encode_FLAC_Start(handle:DWORD; options:PChar; flags:DWORD; proc:ENCODEPROC; user:Pointer): HENCODE; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencflacdll;
function BASS_Encode_FLAC_StartFile(handle:DWORD; options:PChar; flags:DWORD; filename:PChar): HENCODE; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencflacdll;
function BASS_Encode_FLAC_NewStream(handle:HENCODE; options:PChar; flags:DWORD): BOOL; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencflacdll;

implementation

end.
