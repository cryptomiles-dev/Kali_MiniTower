


### 1. **Install the Desktop Environments (if not already installed)**

By default, Kali comes with **Xfce** as the main desktop environment, but you may need to install other environments like **KDE Plasma** or **GNOME** if they weren’t part of your initial installation.

To install **KDE Plasma** or **GNOME**, you can use the following commands in a terminal:

- **Install KDE Plasma:**
```
sudo apt update  
sudo apt install kali-desktop-kde
```

- **Install GNOME:**
```
sudo apt update  
sudo apt install kali-desktop-gnome
```
After installation, you’ll be able to choose between them at the login screen.

### 2. **Switch Between Desktop Environments at Login**

Once you have the additional desktop environments installed, switching between them is quite simple. Here’s how to do it:

- **Log out** of your current session (you’ll need to be logged out to switch desktop environments).
- At the **login screen** (usually **LightDM** or **GDM**, depending on the desktop environment):
    - **Look for a session chooser** icon. This is typically a gear icon or a menu button next to the username or password fields.
    - **Click the session chooser** (gear icon or menu), and you should see a list of available desktop environments.
    - Choose the desktop environment you want to switch to:
        - **KDE Plasma**
        - **GNOME**
        - **Xfce** (or any other environment you installed).
- After selecting your desired desktop environment, **enter your credentials** and log in.

The next time you log in, it will remember the desktop environment you selected, so you won’t need to choose it again unless you want to switch.

### 3. **Switching Desktop Environments from the Command Line (without logging out)**

If you’re already logged in and want to start a new desktop environment **without logging out**, you can switch the session by running the following command in the terminal:
```
sudo service gdm3 stop  # If you are using GNOME  
sudo service lightdm stop  # If you are using Xfce or other environments   

sudo service gdm3 start  # To switch to GNOME  
sudo service lightdm start  # To switch to Xfce or other environments
```  

However, this method is less common, and the graphical method (logging out and selecting a session) is recommended for ease of use.

### 4. **Setting a Default Desktop Environment (Optional)**

If you prefer one desktop environment to always be the default when you log in (and don’t want to manually select it every time), you can set your default environment by configuring the display manager.

For example, if you want **LightDM** (which is typically used with Xfce and other lightweight environments) to always load **Xfce**, you can configure it by setting the `lightdm` session:

`sudo dpkg-reconfigure lightdm`

You’ll be prompted to choose which display manager you want to use (if multiple are installed). Select the one associated with your desired desktop environment (e.g., **LightDM** for Xfce).

After selecting the default display manager, you can continue logging in, and it will automatically load the last desktop environment you chose.

### Summary

To switch between different desktop environments in Kali Linux:

1. **Install** the desktop environments you want to use if they aren't already installed (using `sudo apt install kali-desktop-kde`, `sudo apt install kali-desktop-gnome`, etc.).
2. **Log out** of your current session.
3. On the **login screen**, select the desktop environment you want to use from the session chooser.
4. Log in again, and the new desktop environment will load.

With this setup, you can enjoy the flexibility of choosing between **Xfce**, **KDE Plasma**, **GNOME**, or any other desktop environment Kali includes!  
