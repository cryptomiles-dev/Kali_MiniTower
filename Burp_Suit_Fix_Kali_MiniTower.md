
# Update Java To Install Burp Suite CE

In this guide we will install Java 23 arm64 binaries from BellSoft so we can then install Burp Suite CE.

1. First make sure we are up to date:  
`sudo apt update`   
`sudo apt upgrade -y`  

2. Check current Java version - should be Java 21:  
`java --version`  

3. Install dependancies:  
`sudo apt install libasound2 libc6 libfreetype6 libfontconfig1 libx11-6 libxau6 libxcb1 libxdmcp6 libxext6 libxi6 libxrender1 libxtst6 zlib1g`  

4. Download arm64 Java 23 binaries from BellSoft:  
`wget https://download.bell-sw.com/java/23.0.1+13/bellsoft-jdk23.0.1+13-linux-aarch64.deb`

5. Install the `.deb` package with `dpkg`:
`sudo dpkg -i bellsoft-jdk23.0.1+13-linux-aarch64.deb`  

6. Verify Java version:  
`java --version`  

5. Reboot  
`sudo reboot`  

7. Verify Java version - again:  
`java --version`  

8. Install Burp Suite CE  
`sudo apt install -y burpsuite`

9. Reboot:  
`sudo reboot`  

You shoud now have Burp Suite CE installed and it can be launched from the desktop.

10. **optional** Prevent future updates from possibly reverting Java back:  
`sudo update-alternatives --set java /usr/lib/jvm/bellsoft-java23-aarch64/bin/java`  


