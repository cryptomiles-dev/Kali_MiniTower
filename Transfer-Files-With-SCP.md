
# SCP Linux - Securely Copy Files Using SCP examples
This post includes SCP examples. SCP or secure copy allows the secure transferring of files between a local host and a remote host or between two remote hosts. It uses the same authentication and security as the Secure Shell (SSH) protocol from which it is based. SCP is loved for its simplicity, security, and pre-installed availability.

## SCP examples  


Copy file from a remote host to local host SCP example:

`scp username@from_host:file.txt /local/directory/`  

Copy file from local host to a remote host SCP example:

`scp file.txt username@to_host:/remote/directory/`  

Copy directory from a remote host to local host SCP example:

`scp -r username@from_host:/remote/directory/  /local/directory/`  

Copy directory from local host to a remote host SCP example:

`scp -r /local/directory/ username@to_host:/remote/directory/`  

Copy file from remote host to remote host SCP example:

`scp username@from_host:/remote/directory/file.txt username@to_host:/remote/directory/`  

Copying files with a Specific Port – In this example, we specify a custom SSH port (2222) for the SCP connection:

`scp -P 2222 username@from_host:file.txt /local/directory/`  

Copying files with compression – The `-C` option enables compression during the file transfer, which can be useful for large files:

`scp -C username@from_host:file.txt /local/directory/`  

Limiting Bandwidth during Transfer – This limits the bandwidth usage to 1000 Kbit/s during the transfer:

`scp -l 1000 username@from_host:file.txt /local/directory/`  

Preserving File Attributes – The `-p` option preserves modification times, access times, and modes from the original file:

`scp -p username@from_host:file.txt /local/directory/`  

## Advanced SCP examples on Linux:  

Using SSH Options – You can pass additional SSH options like `-o` to customize the SSH connection. In this example, we use ProxyJump to go through a jump host before connecting to the source host:

`scp -o "ProxyJump user@jump_host" username@from_host:file.txt /local/directory/`  

Quiet Mode – The `-q` option disables the progress meter and warning/diagnostic messages, making the transfer quieter:

`scp -q username@from_host:file.txt /local/directory/`  

Verbose Mode for Debugging – The `-v` option enables verbose mode, which prints debugging messages. This is helpful for troubleshooting connection and configuration issues:

`scp -v username@from_host:file.txt /local/directory/`  

Recursive Copy with Compression and SSH Options – This example combines multiple options to perform a recursive copy with compression and custom SSH options:

`scp -r -C -o "ProxyJump user@jump_host" username@from_host:/remote/directory/ /local/directory/`  

---  

## Notes:  

— Remember that when using advanced options, it’s essential to ensure compatibility with the remote host’s configuration and permissions. Always test thoroughly in a safe environment before using these options in production.

— SCP example:  `scp -r  root@123.123.123.123:/var/www/html/ /home/hydn/backups/test/` 

— Host can be IP or domain name. Once you click return, you will be prompted for an SSH password.

— Although this page covers SCP Linux, the instructions will also work for Mac using “Terminal.” You can also use [WinSCP](http://winscp.net/) to accomplish this on a Windows PC/server.

— When copying a source file to a target file that already exists, SCP will replace the contents of the target file. So be careful.

---

## SCP options summary:  

–**r** Recursively copy entire directories. Note that this follows symbolic links encountered in the tree traversal.
**\-C** Compression enabled. Passes the -C flag to ssh to enable compression.
**\-l** limit – Limits the used bandwidth, specified in Kbit/s.
**\-o** ssh\_option – Can be used to pass options to ssh in the format used in ssh\_config.
**\-P** port – Specifies the port to connect to on the remote host. Note that this option is written with a capital ‘P.’
**\-p** Preserves modification times, access times, and modes from the original file.
**\-q** Quiet mode: disables the progress meter as well as warning and diagnostic messages from ssh.
**\-v** Verbose mode. Print debugging messages about progress. This is helpful in debugging connection, authentication, and configuration problems.

