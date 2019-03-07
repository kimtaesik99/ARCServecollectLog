@echo off

timeout /t 30

"C:\Program Files (x86)\CA\ARCserve Backup\ca_qmgr.exe" -list 3 > c:\tool\bkresult.txt

"C:\Program Files (x86)\CA\ARCserve Backup\ca_log.exe" -activity.log > c:\tool\bklog.txt

powershell c:\tool\sendmail.ps1

exit
