

Included on the USB drive is a copy of the original image the device shipped with.   If you want to revert back to how the device was when you first got it then flash the MicroSd card (or other MicroSd card at least 32GB).

To do this you can use Raspberry Pi Imager from a Windows or Mac computer, or use the any Linux distribution.  

## To use Raspberry Pi Imager:  

1. Download and install the appropriate Windows/Mac version from  
https://www.raspberrypi.com/software/  

2. Select Raspberry Pi 5 for Raspberry Pi Device  
3. Select Choose OS > scroll to the bottom and select Use custom  
4. Select the included image titled Kali-MiniTower.img.xz  
5. Select Storage and select your MicroSD card drive **Be careful here**  
	[If you select the wrong drive on this step you will do bad things!]
6. Click next to start burning the MicroSD card.

Thats it!  Now just insert the MicroSD card into the MiniTower and boot it up.


## To use the MiniTower (or any other Linux distro)  

1. Uncompress the image  
`xzcat Kali-MiniTower.img.xz > Kali-MiniTower.img`  
2. Check where to write it - ie the MicroSd card location  
`lsblk`
3. Write the image  
`sudo dd if=Kali-MiniTower.img of=/dev/sdX bs=4M status=progress && sync`
	Replace /dev/sdX with the correct location discovered in step 2 for example /dev/sda
