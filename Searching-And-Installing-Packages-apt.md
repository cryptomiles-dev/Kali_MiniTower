This guide explains how to use the Advanced Package Tool (apt) to search for and install software packages on your Raspberry Pi 5. These instructions apply to Raspberry Pi systems running Debian-based distributions like Raspberry Pi OS, Kali Linux, or Parrot OS.

Step 1: Update Your Package Index
Before installing or searching for packages, update your system’s package index to ensure you have the latest information about available packages.

Run the following command in the terminal:

bash
Copy code
sudo apt update
If you also want to upgrade your existing packages, use:

bash
Copy code
sudo apt upgrade
Step 2: Search for Packages
To find a package, use the apt search command followed by the package name or a keyword.

Example:
If you want to search for a package related to "Wireshark," type:

bash
Copy code
apt search wireshark
This will display a list of available packages with "wireshark" in their name or description.

Step 3: Get Details About a Package
To see detailed information about a package, use:

bash
Copy code
apt show <package-name>
Example:
bash
Copy code
apt show wireshark
This will display details such as the package's description, dependencies, and size.

Step 4: Install a Package
Once you know the package name, install it using:

bash
Copy code
sudo apt install <package-name>
Example:
To install Wireshark, run:

bash
Copy code
sudo apt install wireshark
When prompted, confirm the installation by typing Y and pressing Enter.

Step 5: Remove a Package (Optional)
If you need to uninstall a package, use:

bash
Copy code
sudo apt remove <package-name>
Example:
To remove Wireshark, run:

bash
Copy code
sudo apt remove wireshark
If you want to remove configuration files as well, use:

bash
Copy code
sudo apt purge <package-name>
Step 6: Clean Up Unused Packages (Optional)
After removing a package or upgrading your system, you can clean up unused packages to free up space:

bash
Copy code
sudo apt autoremove
To remove cached package files:

bash
Copy code
sudo apt clean
