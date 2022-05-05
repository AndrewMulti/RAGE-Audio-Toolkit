{
  BASSenc_OGG 2.4 Delphi unit
  Copyright (c) 2016-2020 Un4seen Developments Ltd.

  See the BASSENC_OGG.CHM file for more detailed documentation
}

Unit BASSenc_OGG;

interface

{$IFDEF MSWINDOWS}
uses BASSenc, Windows;
{$ELSE}
uses BASSenc;
{$ENDIF}

const
  // BASS_Encode_OGG_NewStream flags
  BASS_ENCODE_OGG_RESET = $1000000;
  
{$IFDEF MSWINDOWS}
  bassencoggdll = 'bassenc_ogg.dll';
{$ENDIF}
{$IFDEF LINUX}
  bassencoggdll = 'libbassenc_ogg.so';
{$ENDIF}
{$IFDEF ANDROID}
  bassencoggdll = 'libbassenc_ogg.so';
{$ENDIF}
{$IFDEF MACOS}
  {$IFDEF IOS}
    bassencoggdll = 'libbassenc_ogg.a';
  {$ELSE}
    bassencoggdll = 'libbassenc_ogg.dylib';
  {$ENDIF}
{$ENDIF}

function BASS_Encode_OGG_GetVersion: DWORD; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencoggdll;

function BASS_Encode_OGG_Start(handle:DWORD; options:PChar; flags:DWORD; proc:ENCODEPROC; user:Pointer): HENCODE; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencoggdll;
function BASS_Encode_OGG_StartFile(handle:DWORD; options:PChar; flags:DWORD; filename:PChar): HENCODE; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencoggdll;
function BASS_Encode_OGG_NewStream(handle:HENCODE; options:PChar; flags:DWORD): BOOL; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF}; external bassencoggdll;

implementation

end.
