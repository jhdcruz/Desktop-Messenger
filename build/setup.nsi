;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This file must be in the same directory as the output folder;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; App Information
!define APPNAME "Desktop Messages"
!define DESCRIPTION "Android Messages for Desktop"
!define PUBLISHER "jhdcruz"
; These will be displayed by the "Click here for support information" link in "Add/Remove Programs"
!define HELPURL "https://github.com/jhdcruz/Desktop-Messages/issues" ; "Support Information" link
!define UPDATEURL "https://github.com/jhdcruz/Desktop-Messages/releases" ; "Product Updates" link
!define ABOUTURL "https://github.com/jhdcruz/Desktop-Messages/blob/master/README.md" ; "Publisher" link

; Must be integers for describing versions
!define VERSIONMAJOR 1
!define VERSIONMINOR 0
!define VERSIONBUILD 0

;Require admin rights on NT6+ (When UAC is turned on)
RequestExecutionLevel admin 
 
InstallDir "$PROGRAMFILES\${APPNAME}"
 
; rtf or txt file - remember if it is txt, it must be in the DOS text format (\r\n)
LicenseData "..\LICENSE.txt"

; This will be in the installer/uninstaller's title bar
Name "${APPNAME}"
Icon "..\build\icon.ico"
OutFile "desktop-messages.exe"
 
Section "install"

	SetShellVarContext all

	; Files for the install directory - to build the installer, these should be in the same directory as the install script (this file)
	SetOutPath $INSTDIR

	; Files added here should be removed by the uninstaller (see section "uninstall")
	File "Desktop-Messages-win32-ia32\*"
 
	; Uninstaller - See function un.onInit and section "uninstall" for configuration
	WriteUninstaller "$INSTDIR\uninstall.exe"
 
	; Start Menu
	CreateShortCut "$SMPROGRAMS\${APPNAME}.lnk" "$INSTDIR\Desktop Messages.exe" "" "$INSTDIR\icon.png"
 
	; Registry information for add/remove programs
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "DisplayName" "- ${APPNAME} - ${DESCRIPTION}"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "UninstallString" "$\"$INSTDIR\uninstall.exe$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "QuietUninstallString" "$\"$INSTDIR\uninstall.exe$\" /S"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "InstallLocation" "$\"$INSTDIR$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "DisplayIcon" "$\"$INSTDIR\icon.png$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "Publisher" "$\"${PUBLISHER}$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "HelpLink" "$\"${HELPURL}$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "URLUpdateInfo" "$\"${UPDATEURL}$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "URLInfoAbout" "$\"${ABOUTURL}$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "DisplayVersion" "$\"${VERSIONMAJOR}.${VERSIONMINOR}.${VERSIONBUILD}$\""
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "VersionMajor" ${VERSIONMAJOR}
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "VersionMinor" ${VERSIONMINOR}
	; There is no option for modifying or repairing the install
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "NoModify" 1
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "NoRepair" 1

SectionEnd
 
; Uninstaller 
Section "uninstall"
 
	; Remove Start Menu launcher
	Delete "$SMPROGRAMS\${APPNAME}.lnk"
 
	; Remove files
	Delete $INSTDIR\*.*
	Delete $INSTDIR\locales
	Delete $INSTDIR\swiftshaders
	Delete $INSTDIR\resources
 
	; Always delete uninstaller as the last action
	Delete $INSTDIR\uninstall.exe
 
	; Try to remove the install directory - this will only happen if it is empty
	RMDir $INSTDIR
 
	; Remove uninstaller information from the registry
	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}"

SectionEnd
; source: `https://nsis.sourceforge.io/A_simple_installer_with_start_menu_shortcut_and_uninstaller`