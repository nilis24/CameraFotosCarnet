; Inno Setup script for the Windows installer.
; Expects the windeployqt output in ..\dist (override with /DSourceDir=...).
; This file must stay saved as UTF-8 with BOM because of the accented app name.

#define MyAppName "Càmera per fotos de carnet"
#define MyAppDirName "CameraFotosCarnet"
#define MyAppExeName "appCameraFotosCarnet.exe"

#ifndef MyAppVersion
  #define MyAppVersion "dev"
#endif

#ifndef SourceDir
  #define SourceDir "..\dist"
#endif

[Setup]
; AppId identifies the app across versions so updates replace the old install. Never change it.
AppId={{32C6F694-0194-44B6-A7CC-055CBD6BD1C9}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
DefaultDirName={autopf}\{#MyAppDirName}
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
; Installs for the current user without admin rights; the user can choose "all users" instead
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
SetupIconFile=..\assets\icon.ico
UninstallDisplayIcon={app}\{#MyAppExeName}
OutputDir=Output
OutputBaseFilename=CameraFotosCarnet-{#MyAppVersion}-win64-setup
Compression=lzma2
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "catalan"; MessagesFile: "compiler:Languages\Catalan.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "{#SourceDir}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent
