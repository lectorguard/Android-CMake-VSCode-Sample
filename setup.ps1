scoop bucket add main
scoop install gradle@8.12.1
echo "Installed Gradle"
scoop bucket add java
scoop install corretto17-jdk@17.0.14.7.1
echo "Installed Corretto JDK"
scoop install android-clt@11076708
echo "Installed Android SDK - Command Line Tools"
Start-Process -FilePath "sdkmanager" -ArgumentList "--licenses" -NoNewWindow -Wait 
code --install-extension vadimcn.vscode-lldb@1.11.1
code --install-extension nisargjhaveri.android-debug@0.1.2
echo "Installed vs code extensions"
code %cd%