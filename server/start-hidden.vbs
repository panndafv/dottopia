' Starts the DOTOPIA keeper (run.ps1) without a console window. Used by the "DOTOPIA" scheduled task.
Set fso = CreateObject("Scripting.FileSystemObject")
here = fso.GetParentFolderName(WScript.ScriptFullName)
CreateObject("WScript.Shell").Run "powershell.exe -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File """ & here & "\run.ps1""", 0, False
