echo off
title Linking Configs

echo Linking gitconfig...
rm C:\users\whengely\.gitconfig
mklink /H C:\users\whengely\.gitconfig .\gitconfig

echo Linking cmder...
rm C:\cmder\vendor\conemu-maximus5\ConEmu.xml
mklink /H C:\cmder\vendor\conemu-maximus5\ConEmu.xml .\cmder.xml 

echo Linking VSCode...
rm %APPDATA%\Code\User\settings.json
mklink /H %APPDATA%\Code\User\settings.json .\vscode.settings.json

echo Done!
