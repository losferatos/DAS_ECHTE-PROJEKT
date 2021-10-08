On Error Resume Next

'Setting up the script to work with the file system.
Set WshShell = WScript.CreateObject("WScript.Shell")
Set FileSysObj = CreateObject("Scripting.FileSystemObject")

'Connecting to Active Directory to get user’s data.
Set objSysInfo = CreateObject("ADSystemInfo")
Set UserObj = GetObject("LDAP://" & objSysInfo.UserName)
strAppData = WshShell.ExpandEnvironmentStrings("%APPDATA%")
SigFolder = StrAppData & "\Microsoft\Signatures\"
Set Sigfile.charset = "utf-8"
SigFile = SigFolder & UserObj.sAMAccountName & "1.htm"


'Setting placeholders for the signature.
strUserName = UserObj.sAMAccountName
strFullName = UserObj.displayname
strTitle = UserObj.title
strMobile = UserObj.mobile
strEmail = UserObj.mail
strCompany = UserObj.company
strOfficePhone = UserObj.telephoneNumber

'test vars
strName = objUser.FullName
'strDepartment = objUser.Department
strOffice = UserObj.office 
strFirstName = UserObj.givenName
strLastName = UserObj.sn
strDepartment = UserObj.Department



'Creating HTM signature file for the user's profile, if the file with such a name is found, it will be overwritten.
Set CreateSigFile = FileSysObj.CreateTextFile (SigFile, True, True)

'Signature’s HTML code.
CreateSigFile.Writeline "<!doctype html>"
CreateSigFile.Writeline "<head>"
'CreateSigFile.Writeline "<meta http-equiv='content-type' content='text/html; charset=utf-8'>"
CreateSigFile.Writeline "<title>Signature</title>"
CreateSigFile.WriteLine "<META content=" & """text/html; charset=utf-8" & """ http-equiv=" & """Content-Type" & """>"
CreateSigFile.Writeline "<meta name='viewport' content='width=device-width, initial-scale=1'>"
CreateSigFile.Writeline "<link rel='stylesheet' href='https://www.w3schools.com/w3css/4/w3.css'> "
CreateSigFile.Writeline "<style>"
CreateSigFile.Writeline "body {font-family: Arial, sans-serif;}"
CreateSigFile.Writeline ".bg {"
CreateSigFile.Writeline "background-color: #f2f2f2;"
CreateSigFile.Writeline "display: inline-block;"
CreateSigFile.Writeline "width: 350px;"
CreateSigFile.Writeline "padding: 15px;"
CreateSigFile.Writeline "}"
CreateSigFile.Writeline ".infotext {padding: 15px;}"
CreateSigFile.Writeline ".bg p {margin: 0px;}"
CreateSigFile.Writeline "</style>"
CreateSigFile.Writeline "</head>"
CreateSigFile.Writeline "<body>"
CreateSigFile.Writeline "<div class=infotext>"
CreateSigFile.Writeline "<p>Mit freundlichen Gr&#252;&#223;en</p>"
CreateSigFile.Writeline "<p><i>"& strFirstName & " " & strLastName &"</i></p>"
CreateSigFile.Writeline "<p class='w3-small'><b>"& strTitle &"</b></p>"
CreateSigFile.Writeline "</div>"
CreateSigFile.Writeline "<div class='bg'>"
CreateSigFile.Writeline "<img src='https://i.ibb.co/92Jccsk/image002.png' alt='Max-Taut-Schule' width='255' height='69'> "
CreateSigFile.Writeline "<p class='w3-small'>Fischerstra&#223;e 36, 10317 Berlin, Raum: " & strOffice & "</p>"
CreateSigFile.Writeline "<p class='w3-small'>Telefon: "& strOfficePhone &"</p>"
CreateSigFile.Writeline "<p class='w3-small'>Telefax:</p>"
CreateSigFile.Writeline "<p class='w3-small'>E-Mail: "& strEmail &"</p>"
CreateSigFile.Writeline "<p class='w3-small'>Website:	www.max-taut-schule.de</p>"
CreateSigFile.Writeline "</div>"
CreateSigFile.Writeline "</body>"
CreateSigFile.Writeline "</html>"
CreateSigFile.Close

'Applying the signature in Outlook’s settings.
Set objWord = CreateObject("Word.Application")
Set objSignatureObjects = objWord.EmailOptions.EmailSignature

'Setting the signature as default for new messages.
objSignatureObjects.NewMessageSignature = strUserName & "1"

'Setting the signature as default for replies & forwards.
objSignatureObjects.ReplyMessageSignature = strUserName & "1"
objWord.Quit