@ECHO OFF
REM setx DROPBOX "c:\dropbox\"
copy Vim\host_vimrc.txt %USERPROFILE%\_vimrc
copy Vim\host_vsvimrc %USERPROFILE%\_vsvimrc

copy PowerShell\profile.ps1 %USERPROFILE%\Documents\WindowsPowerShell\

REM copy AutoHotKey\AutoHotKey.ahk