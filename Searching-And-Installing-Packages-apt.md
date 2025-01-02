

#### This guide explains how to use the Advanced Package Tool `apt` to search for and install software packages on your Raspberry Pi 5. These instructions apply to Raspberry Pi systems running Debian-based distributions like Raspberry Pi OS, Kali Linux, or Parrot OS.

---

## Step 1: Update Your Package Index  

Before installing or searching for packages, update your system’s package index to ensure you have the latest information about available packages.

Run the following command in the terminal:

`sudo apt update`

If you also want to upgrade your existing packages, use:

`sudo apt upgrade`

---

## Step 2: Search for Packages  

To find a package, use the `apt search` command followed by the package name or a keyword.

### Example:

If you want to search for a package related to "Wireshark," type:

`apt search wireshark`

This will display a list of available packages with "wireshark" in their name or description.

---

## **Step 3: Get Details About a Package**

To see detailed information about a package, use:

`apt show <package-name>`

This will display details such as the package's description, dependencies, and size.

---

## **Step 4: Install a Package**

Once you know the package name, install it using:

`sudo apt install <package-name>`

When prompted, confirm the installation by typing `Y` and pressing Enter.

---

## **Step 5: Remove a Package (Optional)**

If you need to uninstall a package, use:

`sudo apt remove <package-name>`

If you want to remove configuration files as well, use:

`sudo apt purge <package-name>`

---

## Step 6: Clean Up Unused Packages (Optional)

After removing a package or upgrading your system, you can clean up unused packages to free up space:

`sudo apt autoremove`

To remove cached package files:

`sudo apt clean`  
