@echo off
tasklist /fi "imagename eq bochs.exe" | find ":" > nul
taskkill /f /im "bochs.exe"  > nul