

# Restore MiniTower Image  

Included on the USB drive is a copy of the original image the device shipped with.   If you want to revert back to how the device was when you first got it then flash the MicroSd card (or other MicroSd card at least 32GB).

To do this you can use Raspberry Pi Imager from a Windows or Mac computer, or use the any Linux distribution.  

## Restore MiniTower to it's original state

**NOTE** In this guide I use `Kali-MiniTower.img.xz` but the image you recieve may have a slightly different name.    
If the restore image you recived has a different name then in the commands below replace `Kali-MiniTower.img.xz` with the name of your restore image (make sure to include the `.img.xz` extension)   
If you want to restore the MiniTower back to the way the device was when you first got it you can flash the included image onto the 32GB MicroSd card (or other MicroSd card at least 32GB).
To do this you can use Raspberry Pi Imager from a Windows or Mac computer, or use the any Linux distribution.  

## To use Raspberry Pi Imager:  

1. Download and install the appropriate Windows/Mac version from  
https://www.raspberrypi.com/software/  

2. Run Raspberry Pi Imager and under Raspberry Pi Device select Raspberry Pi 5  
3. Under Operating system select Choose OS > then scroll to the bottom and select Use custom  
4. Navigate to the the image included on the USB drive then select the image titled `Kali-MiniTower.img.xz`  
5. Select Storage and select your MicroSD card drive **Be careful here**  
	[If you select the wrong drive on this step you will do bad things!]
6. Click next
7. A Would you like to apply customizations pop up will appear.  Select NO

Thats it!  Raspberry Pi Imager will burn the MicroSd card, verify it, then notify you that it has successfully completed.  
Now remove the MicroSD card and insert the MicroSD card into the MiniTower and boot it up.  **Note** The MicroSd slot is on the back bottom of the board.


## To use the MiniTower (or any other Linux distro)  

1. Insert the USB and identify it: `lsblk`
2. Open a terminal and navigate to the image location: `cd /path/to/image`
3. Uncompress the image  
`xzcat Kali-MiniTower.img.xz > Kali-MiniTower.img`  
4. Check where to write it - ie the MicroSd card location - To be certain so you dont do bad things here!
`lsblk`
5. Write the image  
`sudo dd if=Kali-MiniTower.img of=/dev/sdX bs=4M status=progress && sync`
	Replace `/dev/sdX` with the correct location discovered in step 2 for example `/dev/sda`



