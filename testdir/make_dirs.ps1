#Lese PasswortListe ein - Quelle: "names.txt"
$passwords = Get-Content C:\Users\Heide\Desktop\testdir\names.txt
Write-Output "Habe" $passwords.length "Passworte gelesen"
#wird durch password generator ersetzt!

#Frage Klassennamen ab
$klassenname = Read-Host "Klassenname: "

#Zufallsauswahl der Passwörter 
$usedPasswords = @()

$counter = 0
while ($counter -lt 10) {
    $getRandom = Get-Random -Minimum 0 -Maximum $passwords.length
    $usedPasswords += $passwords[$getRandom] 
    $counter++
}

#Klassenordner erstellen
mkdir $klassenname

#Erstelle Output Liste mit user:pass
$output = @()
for ($i = 0; $i -le $usedPasswords.length -1; $i++) {
    $output += $klassenname + "-" + $i.ToString() + ":   " + $usedPasswords[$i] 
    $temp = $klassenname + $i
    mkdir $klassenname\$temp
}

$output | Out-File $klassenname".txt"