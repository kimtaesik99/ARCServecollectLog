$mailto = "Thomas Kim<thomaskim@kts.com>"
$mailfrom = "ARCServ<arcalert@kts.com>"
$smtpsvr = "xx.xxx.xxx.xxx"
$enc = New-Object System.Text.utf8encoding
$bkresult = Get-Content C:\tool\bkresult.txt | %{ $_.split("|")[6];}
$bkname = Get-Content C:\tool\bkresult.txt | %{ $_.split("|")[8];}
$bkhostname = Get-Content C:\tool\bkresult.txt | %{ $_.split("|")[3];}
$errmsg = Get-Content C:\tool\bklog.txt | Select-String "ません" | Select-Object -last 1

if ("$bkresult" -eq "  FINISHED  ")
{
Send-MailMessage -To $mailto -From $mailfrom -Subject $bkhostname": バックアップジョブ$bkname Succeed" -Body " 次のバックアップジョブが正常に終了しました。`r`n バックアップジョブ : $bkname `r`n バックアップホスト : $bkhostname" -SmtpServer $smtpsvr -Encoding $enc
}

elseif ("$bkresult" -eq "  CANCELLED  ")
{
Send-MailMessage -To $mailto -From $mailfrom -Subject $bkhostname": バックアップジョブ$bkname Canceled" -Body " 次のバックアップジョブが取り消されました。`r`n バックアップジョブ : $bkname `r`n バックアップホスト : $bkhostname`r`n 詳細はARCServeバックアップマネージャのログを確認してください。" -SmtpServer $smtpsvr -Encoding $enc
}

elseif ("$bkresult" -eq "  INCOMPLETE  ")
{
Send-MailMessage -To $mailto -From $mailfrom -Subject $bkhostname": バックアップジョブ$bkname Incomplete" -Body " 次のバックアップジョブが未完了で終了しました。`r`n バックアップジョブ : $bkname `r`n バックアップホスト : $bkhostname`r`n 詳細はARCServeバックアップマネージャのログを確認してください。" -SmtpServer $smtpsvr -Encoding $enc
}

else
{
Send-MailMessage -To $mailto -From $mailfrom -Subject $bkhostname": バックアップジョブ$bkname Failed" -Body " 次のバックアップジョブが失敗しました。`r`n バックアップジョブ : $bkname `r`n バックアップホスト : $bkhostname`r`n 詳細はARCServeバックアップマネージャのログを確認してください。`r`n `r`n $errmsg" -SmtpServer $smtpsvr -Encoding $enc
}

