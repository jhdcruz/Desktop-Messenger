# define installer name
OutFile "Desktop-Messenger-x86_64.exe"

# Install Directory
InstallDir "$PROGRAMFILES\Desktop Messenger"

# For removing Start Menu shortcut in Windows 7
RequestExecutionLevel user
 
Page license
Page directory
Page instfiles

# default section start
Section "Installation"
 
    # define output path
    SetOutPath $INSTDIR
    
    # specify file to go in output path
    File "../dist/Desktop-Messenger-win32-ia32/*" /r
    
    # define uninstaller name
    WriteUninstaller "$INSTDIR\uninstaller.exe"

    # create a shortcut named "new shortcut" in the start menu programs directory
    # point the new shortcut at the program uninstaller
    CreateShortCut "$DESKTOP\Desktop Messenger.lnk" "$INSTDIR\Desktop-Messenger.exe"
    CreateShortCut "$SMPROGRAMS\Desktop Messenger.lnk" "$INSTDIR\Desktop-Messenger.exe"
 
SectionEnd
 
# create a section to define what the uninstaller does.
# the section will always be named "Uninstall"
Section "Uninstall"
 
    # Always delete uninstaller first
    Delete "$INSTDIR\uninstaller.exe"
    
    # now delete installed file
    Delete "$INSTDIR\*.*"
    Delete "$INSTDIR\Desktop Messenger"
    # second, remove the link from the start menu
    Delete "$SMPROGRAMS\Desktop Messenger.lnk"
    Delete "$DESKTOP\Desktop Messenger.lnk"

SectionEnd