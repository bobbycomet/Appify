; Inno Setup script for Appify (Windows).
; Build:  ISCC.exe /DMyAppVersion=3.0.7 windows\appify.iss
; Expects the PyInstaller one-folder build in ..\dist\Appify\ (see windows\build.ps1).

#ifndef MyAppVersion
  #define MyAppVersion "0.0.0"
#endif
#define MyAppName "Appify"
#define MyAppExe  "Appify.exe"

[Setup]
; Fixed GUID so upgrades replace the previous install. Never change it.
AppId={{7B6A3C52-4F1E-4A87-9C0D-5E2B8D91A4F3}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher=BobbyComet
AppPublisherURL=https://github.com/bobbycomet/Appify
AppSupportURL=https://github.com/bobbycomet/Appify/issues
AppUpdatesURL=https://github.com/bobbycomet/Appify/releases
VersionInfoVersion={#MyAppVersion}
DefaultDirName={autopf}\{#MyAppName}
DisableProgramGroupPage=yes
; Per-user install by default (no admin prompt, and the in-app updater can
; upgrade silently). The wizard still offers an "all users" option.
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
OutputDir=..\release
OutputBaseFilename=Appify-Setup-{#MyAppVersion}
SetupIconFile=appify.ico
UninstallDisplayIcon={app}\{#MyAppExe}
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
; Lets the in-app updater run this installer while Appify is open.
CloseApplications=yes
RestartApplications=no

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "..\dist\Appify\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExe}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExe}"; Tasks: desktopicon

[Run]
; Interactive install: "Launch Appify" checkbox on the last page.
Filename: "{app}\{#MyAppExe}"; Description: "{cm:LaunchProgram,{#MyAppName}}"; Flags: nowait postinstall skipifsilent
; Silent install (this is how the in-app updater runs it): relaunch automatically.
Filename: "{app}\{#MyAppExe}"; Flags: nowait; Check: WizardSilent
