> Find the original article written by Swapnil Bhartiya here: http://www.muktware.io/arch-linux-guide-the-always-up-to-date-arch-linux-tutorial/

# Arch Linux guide: the always up-to-date Arch Linux tutorial
[Download the latest ISO image of Arch
Linux](https://www.archlinux.org/download/). Once you have downloaded the
image it’s time to create a bootable USB drive. If you are on a Linux or Mac
OS machine, you can use the ‘dd’ utility. If you are on a Windows system then
you will have to use tools such as [Rufus](https://rufus.akeo.ie/) or
[USBWriter](http://sourceforge.net/p/usbwriter/wiki/Documentation/). If you
have Cygwin installed on your Windows machine, then you can also use the ‘dd’
utility. Plug in the USB device and run _lsblk_ command to print a list of
connected storage devices. Identify the USB device that you are going to use
as install media. In my case the USB device was ‘/dev/sde’. Now we will use
the dd utility to convert the Arch Linux iso image and copy it to the USB
device. Open the terminal and run the ‘dd’ command using the following
pattern:

    
    
    sudo dd if=/path_to_arch_.iso of=/dev/sdX bs=1M

In my case that will be:

    
    
    sudo dd if=/path_to_arch_.iso of=/dev/sde bs=1M

Just replace ‘sde’ with your block device. _Note: If you are on Mac OS X use
bs=1m instead of upper case M._ Once the command runs successful you have a
bootable installation media of Arch Linux. You can use the same utility to
create bootable installation media of other Linux distributions.


## How to set-up up wireless network

Now you have bootable installation media of Arch Linux. You may have to change
bios settings on your system so that it boots into the USB drive instead of
internal hard drive. Plug in the Arch Linux USB drive and configure the BIOS.
Once all set and you booted into Arch Linux, you will see the following
screen. Choose the appropriate version (32bit or 64bit) of Arch that you want
to install on your machines. Once you selected the desired version of Arch you
will be greeted by login prompt. Since were are going to download packages
from the internet and install them, the first thing we need to do is ensure we
are connected to the Internet. If you do have Ethernet cable, please use it to
reduce complications.

### Setting up wireless connection

If you don’t have a wired connection, then let’s connect using wireless. There
is only one caveat though. I am assuming you have well supported wireless
card; otherwise you will have to install drivers manually and covering all of
those is beyond the scope of this article, please check
[this](https://wiki.archlinux.org/index.php/Wireless_network_configuration#Broadcom)
page. There can still be one deal breaker and that’s if you have certain
wireless chips which are not fully supported, such as the one on my Dell
Inspiring Netbook. In cases like those you ‘will’ have to use wired connection
to download appropriate drivers for the card. I will not address that problem
in this tutorial and we assume you have a supported card. So let’s run
‘ifconfig’ or ‘ip link’ command that will list all network devices.

    
    
    # ip link

Note down the name of the device you want to use. Wired devices will start
with something like ‘en’ whereas wireless devices will start with ‘wl’. In my
case wired device was enp0s3 and wireless devices was ‘wlp2s0’ Now run the
following command to set-up the wireless devices (replace wlp2s0 with the name
of your wireless devices)

    
    
    # wifi-menu -o wlp2s0

You will see something like this. ![arch-wfi](http://www.muktware.io/wp-
content/uploads/2016/04/arch-wfi-1024x920.jpg) Use arrow keys on your keyboard
to select the wireless network you want to connect to then hit enter or use
‘Tab’ key to go to ‘Ok’ button and hit enter. The next window will give you
the option to change the name, leave it as it is. The third window will ask
for the password for the network and you are all set. Now let’s ping Google to
see if we are connected:

    
    
    # ping  -c 3 [www.google.com](http://www.google.com)

If you can see the ping, it’s time to proceed.


## Prepare hard drive for installation (MBR/BIOS)

Working with storage devices from the command line is the trickiest and the
most complicated thing. The good news is that in the Linux world, you won’t
end up formatting your drive so easily as you could on Windows. Just the other
day I ended up erasing everything on my 1.5TB hard drive while installing
Windows 10 on a system; the whole drive detecting and writing changes
immediately is such a poor design. So don’t be intimidated. Just keep one
thing in mind, in this article we are going to format the entire hard drive;
it will wipe all partitions on it. If you have other operating systems
installed on your drive and you want to dual boot, or you want to install Arch
on an existing partition without destroying other partitions on the hard drive
then stop now and check out this article. _Another important point, this
chapter is intended for BIOS/MBR partition, **if you are using UEFI system
then [refer to the UEFI/GPT article](http://www.muktware.io/arch-linux-guide-
the-always-up-to-date-arch-linux-tutorial/6/).** However, keep in mind that
you need BIOS/MBR partition if you are dual booting with Windows._ So all of
that out of the way, we have to now partition our hard drive. We are using the
‘Parted’ tool. Run the lsblk command to see the connected storage devices
(check the block devices article). Now down the name of the block device and
run the _parted_ command on that drive:

    
    
    # parted /dev/sdX

Replace ‘sdX’ with your block device name, in my case it was:

    
    
    # parted /dev/sda

You will notice # replaced by ‘parted’ that means you are running the parted
command. We have to first create a partition table with msdos.

    
    
    (parted) mklabel msdos

It will warn you about destroying all data. Type _Yes_. Now we have to create
partitions (keep a note, this tutorial is for MBR/BIOS systems, if you are
using a [UEFI based system](http://www.muktware.io/arch-linux-guide-the-
always-up-to-date-arch-linux-tutorial/6/) then refer to **this** article). Use
the following pattern to create partitions:

    
    
    (parted) mkpart part-type fs-type start end

We first need to create the root, so the part-type will be primary; the file
system will be ext4.

    
    
    (parted) mkpart primary ext4 1MiB 30GiB

Now we will set boot flag on it:

    
    
    (parted) set 1 boot on

_Note: I allocated 30GB to the root partition because I install multiple
desktop environments and it’s better to have more space. In addition to that I
don’t create separate home partition, it’s created inside the root partition,
so I give root as much space I would to the home partition. I don’t save any
of my files on home partitions, I keep everything on a different physical hard
drives or independent file server so that these installations of broken
systems won’t affect my files. So for me 20 or 30GB is more than sufficient._
Once root is created we have to create swap and other partitions, if you need.
While creating these partitions, keep in mind the start and end is important:
the start point will be where you ended the previous one. As you can see
below, the end point for root partition becomes the start point of the next
partition, which I my case is swap. Let’s create the swap partition:

    
    
    (parted) mkpart primary linux-swap 30GiB 38GiB

Here I have created 8GB swap, you can allocate as much swap partition as you
need based on your RAM. If you want to create more partitions, then just
follow the pattern – end point of the previous partition becomes the start
point for the next. Just keep in mind on MBR you can create only 4 primary
partitions. And if you want to use all of the remaining storage then use 100%
for end point. If you are done partitioning, quite _parted_ and check the
partition structure using the _lsblk_ command. Create file systems Now we need
to format the partitions with appropriate file systems. The root partition
must be formatted as ext4

    
    
    # mkfs.ext4 /dev/sdxY

In my case root was /dev/sda1, so it’s:

    
    
    # mkfs.ext4 /dev/sda1

We are not going to touch swap. However, we have to set it up and activate it:

    
    
    # mkswap /dev/sdxY
    # swapon /dev/sdxY

In my case it was:

    
    
    # mkswap /dev/sda2
    # swapon /dev/sda2

Now we have to mount the root partition to the ‘mnt’ directory:

    
    
    # mount /dev/sdxN /mnt

In my case it was sda1:

    
    
    # mount /dev/sda1 /mnt

We are all set, now it’s time to proceed to installation.


## Prepare hard drive for installation (GPT/EFI)

This chapter is intended for UEFI/GPT partition, _**if you are using BIOS
system then [use my MBR/BIOS guide.](http://www.muktware.io/arch-linux-guide-
the-always-up-to-date-arch-linux-tutorial/5/)**_ Keep in mind that you do need
BIOS/MBR partition if you are dual booting with Windows. So all of that out of
the way, we have to now partition our hard drive. We are using the ‘Parted’
tool. Run the lsblk command to see the connected storage devices (check the
block devices article). Now down the name of the block device and run the
_parted_ command on that drive:

    
    
    # parted /dev/sdX

Replace ‘sdX’ with your block device name, in my case it was:

    
    
    # parted /dev/sda

You will notice # replaced by ‘parted’ that means you are running the parted
command. We have to first create a partition table with gpt.

    
    
    (parted) mklabel gpt

It will warn you about destroying all data. Type _Yes_. Now we have to create
partitions (keep a note, this tutorial is for UEFI systems, _**if you are
using non-UEFI based system [then refer to my MBR/BIOS
article](http://www.muktware.io/arch-linux-guide-the-always-up-to-date-arch-
linux-tutorial/5/)**_). Use the following pattern to create partitions:

    
    
    (parted) mkpart part-type fs-type start end

We first need to create a partition for UEFI, so the part-type will be ESP
(EFI System Partition); the file system will be FAT 32 and then we have to
give at least 512MB for this partition. So the start will be 1MiB and end will
be 513MiB.

    
    
    (parted) mkpart ESP fat32 1MiB 513MiB

We will set boot flag on it:

    
    
    (parted) set 1 boot on

Once UEFI partition is created, we have to create a root partition, swap and
other partitions if you need. While creating these partitions, keep in mind
the start and end is important: the start point will be where you ended the
previous one (as you can see below, the start point for root is 513MiB, that’s
the end point for the previous partition). Let’s first create the root
partition.

    
    
    (parted) mkpart primary ext4 513MiB 20GiB

_Note: I allocated 30GB to the root partition because I install multiple
desktop environments and it’s better to have more space. In addition to that I
don’t create separate home partition, it’s created inside the root partition,
so I give root as much space I would to the home partition. I don’t save any
of my files on home partitions, I keep everything on a different physical hard
drives or independent file server so that these installations of broken
systems won’t affect my files. So for me 20 or 30GB is more than sufficient._
Now it’s time to create swap:

    
    
    mkpart primary linux-swap 20GiB 28GiB

Here I have created 8GB swap, you can allocate as much swap partition as you
need based on your RAM. If you want to create more partitions, then just
follow the pattern. If you want to use all of the remaining storage, then use
100% for end point. If you are done partitioning, quite parted and check the
partition structure using the _lsblk_ command.

### Create file systems and mount devices (UEFI/GPT)

Now we need to format the file system. The UEFI partition must be formatted as
FAT32

    
    
    # mkfs.fat -F32 /dev/sdxY

Root must be formatted as ext4:

    
    
    # mkfs.ext4 /dev/sdxY

And we are not going to touch swap. However, we have to set it up and activate
it:

    
    
    # mkswap /dev/sdxY
    # swapon /dev/sdxY

(Please replace sdxY with partition you created for swap, in my case it was
sda3)

    
    
    # mkswap /dev/sda3
    # swapon /dev/sda3

We are all set, now it’s time to mount boot and root partitions. First we
mount root:

    
    
    # mount /dev/sdxY /mnt

In my case it was sda2:

    
    
    # mount /dev/sda2 /mnt

Now we have to create a directory ‘boot’ so we can mount the UEFI partition at
boot:

    
    
    # mkdir -p /mnt/boot

Then mount the ESP to boot:

    
    
    # mount /dev/sdxY /mnt/boot

In my case it will be:

    
    
    # mount /dev/sda1 /mnt/boot

We are all set to proceed to installation.

## How to set-up boot manager, root password and hostname

Now it’s time to configure boot-loader. Install the packages grub and os-
prober (you need os-prober if you have other OSes installed on your system and
you need to multi-boot).

    
    
    pacman -S grub os-prober

If you are using GPT/UEFI then also install efibootmgr

    
    
    pacman -S grub efubootmgr os-prober

**For BIOS/MTP**  
Now run the following command:

    
    
    # grub-install --recheck --target=i386-pc /dev/sdX

Here sdX will be the drive and not a partition, so in my case it was:

    
    
    # grub-install --recheck --target=i386-pc /dev/sda

Now generate grub.cfg:

    
    
    # grub-mkconfig -o /boot/grub/grub.cfg

**For UEFI/GPT**  
Run the following command:

    
    
    # grub-install --target=x86_64-efi --efi-directory=_esp_ --bootloader-id=**grub**
    

Then run:

    
    
     grub-mkconfig -o _esp_/grub/grub.cfg

We are all set with the OS install, we have to now install other components
and configure the system.

Set up hostname

Let’s give our system a decent host name:

    
    
    # echo swapnil > /etc/hostname

Now let’s create the password for the root. Run the following command:

    
    
    # passwd

Then exit the chroot environment

    
    
    # exit

Then unmount the partition

    
    
    # umount -R /mnt

And shutdown the system:

    
    
    # shutdown

Now remove the USB drive that you used to install Arch and reboot the system.
If everything was installed properly, you should boot into Arch Linux.

## How to create users on your system

We now have a completely working Arch Linux system. However, we still have a
lot of things to do. The first thing we need to do is create a user. I will be
using the ‘useradd’ command to achieve it. Here is the command to create new
user:

    
    
    # useradd -m -G _additional_groups_ -s _login_shell__username_

Here ‘wheel’ and ‘users’ will be the additional groups, shell will be bash and
user will be swapnil; of course you will change the username.

    
    
    # useradd -m -G wheel,users -s /bin/bash swapnil

Now we will create password for this user:

    
    
    # passwd swapnil

Let’s now install _sudo_ so that this user can perform administrative tasks :

    
    
    # pacman -S sudo

Now let’s give our user the Sudo powers. Edit the _sudoers_ file using the
_visudo_ command:

    
    
    # EDITOR=nano visudo

Un-comment this line in this file:

    
    
    %wheel ALL=(ALL) ALL

Save and close the file with ‘Ctrl+x’ and then type ‘y’ to confirm. I also
suggest installing the bash-completion package which makes helps with auto
completion of commands, paths and package names.

    
    
    # pacman -S bash-completion

Alternatively, you can use ‘zsh’ shell which has more features than bash.


## How to configure repositories

It’s time to configure repositories before we head out to install the
remaining components of our operating system. All repository information is
saved in the ‘pacman.conf’ file, so we are going to edit this file with nano
editor.

    
    
    # nano /etc/pacman.conf

Here you will see all the available repositories. By default only stable
repositories are enabled, but you can un-comment other repositories if you
need alpha or pre-release packages. However, let’s start with only stable
packages so that you don’t nuke your Arch system. If you are using 64 system,
you can still install 32 bit applications on your system. All you need to do
is enable the ‘mutilib’ repo. This will ceate a separate directory for 32-bit
applications. Scroll down in the ‘pacman.conf’ file and un-comment the
‘multilib’ repo:

    
    
    [multilib]
    Include = /etc/pacman.d/mirrorlist

Then save and close the config file. Now it’s time to update the repositories
by running this command:

    
    
    # pacman -Sy

**Note:** You must always update repos before installing any packages. If you need packages that are not available through the official repo and you don’t want to compile them, you can always add more repositories to the config file. We will talk about that later, let’s stick to the installation process. 


## How to install X-server and graphics drivers

We now have to install the display server, graphics drivers and other crucial
components before we install the final piece of an operating system: the
desktop environment.

    
    
    # pacman -S xorg-server xorg-server-utils

It will ask you to install libgl package, choose the one for your GPU. If you
have Intel card, then use mesa-libgl, if you have latest nvidia card then
nvidia-libgl. It’s time to now install GPU driver: **Intel GPU:**

    
    
    pacman -S xf86-video-intel

**Nvidia** (latest card, for older cards, check [this ](https://wiki.archlinux.org/index.php/NVIDIA#Installing)page):
    
    
    pacman -S nvidia nvidia-libgl

**ATI/AMD:**
    
    
    pacman -S xf86-video-ati lib32-mesa-libgl

If you are using a laptop you will also need to install the drivers for input
devices like touch-pad:

    
    
    # pacman -S xf86-input-synaptics

We are all set to install the desired desktop environment. I will try to
include all those desktop environments that I have tried so far. If you want
me to write about your preferred DE, let me know and I will give it a try.


## How to install software in Arch Linux with pacman

You now have a complete Arch Linux system. In this article I am going to talk
about some of the basics of managing software installation (and removal) and
system maintenance. First of all you must update the database before
installing any package:

    
    
    sudo pacman –Sy

To run system update with updating database:

    
    
    sudo pacman –Syu

To install a package

    
    
    pacman –S package_name

Example

    
    
    pacman –S gimp

If you want to install multiple packages that share the same pattern in their
name. Let’s say we want to install several Virtualbox packages that have
virtualbox-guest in the name. Usually you will have to list out each of these
packages:

    
    
    swapnil$ sudo pacman -S virtualbox-guest-dkms
    virtualbox-guest-dkms         virtualbox-guest-modules-lts
    virtualbox-guest-iso          virtualbox-guest-utils
    virtualbox-guest-modules      virtualbox-guest-utils-nox

But you can make it easier by using this pattern:

    
    
    swapnil$ sudo pacman -S virtualbox-guest-{dkms,iso,modules,dkms,utils}

**Optimize Pacman:** Once in a while you need to optimize pacman:
    
    
    sudo pacman-optimize

**Removing packages: **To remove a package without touching its repositories:
    
    
    pacman –R package_name

To remove a package and its dependencies:

    
    
    pacman –Rns

(If these dependencies are required by other packages, pacman will show
error.) If you do want to remove a package with its dependenices and the
packages that rely on those dependencies:

    
    
    # pacman -Rsc _package_name_

You need to be extra careful before running this command as it can remove a
lot of needed applications and packages. If you want to remove a package that
is required by another package without removing the dependent package, use
this command:

    
    
    # pacman -Rdd _package_name_

Keep it clean. Pacman saves the downloaded packages in ‘/var/cache/pacman/pkg’
directory. So once in a while you need to clean it up to removed the older or
uninstalled packages:

    
    
    pacman -Sc

If you think that you many need to rollback to older package then you can run
‘paccache –r’ command that purges all cached version of packages leaving only
3 most recent version of packages. That’s pretty much all that you need to
know to get started with Arch Linux.


## How to use AUR aka Arch User Repository

Arch has a very huge repository of packages, however not everything is
available through repos and oftentimes you may have to compile packages from
AUR. While you can do it manually and it’s very easy, I tend to use tools like
‘yaourt’ to compile packages.

### How to manually compile packages from AUR

You can search for the desired package in [AUR](https://aur.archlinux.org/)
and then download the snapshot. In this example were installing Geary email
client. And we have downloaded the git snapshot. Now extract the downloaded
package.

    
    
    tar –xvf gearty-git.tar

cd to the extracted folder

    
    
    cd geary-git

And run the following command as regular user (non-root)

    
    
    makepkg –sri

It will ask you to enter root password when required. If no error are reported
it will proceed to install. Once it a wile it will seek your confirmation to
install packages and dependencies. That’s how simple it is to compile packages
on Arch.

### Using Yaourt to install AUR packages

Only flip side of this approach is that you have to open a browser to search
for packages. The good news is there are many unofficial tools that enable an
Arch user to search for packages without leaving the command line and compile
them with ease. My favorite is yaourt. _Let’s install Yaourt._ Yaourt needs
package query, so first cone the git repo of package query:

    
    
    git clone https://aur.archlinux.org/package-query.git

Now cd into the downloaded package:

    
    
    cd package-query

And now run the makepkg command:

    
    
    makepkg –sri

As usual it will ask you password, once the package is compiled and install,
cd out of the package-query directory:

    
    
    cd ..

Now download the yaourt package from GIT

    
    
    git clone https://aur.archlinux.org/yaourt.git

Change directory ‘cd yaourt’ and run makepkg:

    
    
    makepkg -si

Once installed get out the yaourt directory:

    
    
    cd ..

Now you have Yaourt installed on your system.

### How to use Yaourt

The first rule of Arch Club is: always refresh repository info before
installing any package:

    
    
    yaourt -Syu --aur

This command sync database, upgrades installed packages and aur packages.

### Installing packages with yaourt

The good news is that yaourt can also install those packages that are already
available in the repo. So if you want to install GIMP, you can either use
pacman:

    
    
    sudo pacman –S _package_name_

Example

    
    
    sudo pacman –S gimp

Or you can user yaourt:

    
    
    yaourt  -S gimp

If you want to search only AUR skipping packages from official repo then use
without –S or use –aur flag:

    
    
    yaourt --aur gimp

Now let’s try to install Plex Media Server which is not in the official repos.

    
    
    yaourt plex-media

You will see a list of packages related to Plex Media Server. It also shows
how many people have installed it.

    
    
    swapnil$ yaourt plex-media
    1 **aur/****plex-media-player****1.0.4-2****(2)
    **    Next generation Plex Desktop Client
    2 **aur/****plex-media-server****0.9.15.2.1663-4****(198)
    **    Plex Media Server
    3 **aur/****plex-media-server-plexpass****0.9.15.2.1663-1****(63)
    **    Plex Media Server (PlexPass version)
    **==> ****Enter n° of packages to be installed (ex: 1 2 3 or 1-3)**

Now all you need is enter the number of that package, in my case it’s the
second package, so entered 2 and hit Enter key. Yaourt starts its magic and
starts installing packages. Yaourt will also show if there were any bugs and
errors reported by other users during compiling so play close attention. If
there is any comment, Yaourt offers to edit the package file with your desired
editor to make suggested changes. Otherwise whenever Yaourt propose to edit a
file, and no edits are required, just say no. Be extra careful because as
Yaourt install each package, it will throw numerous conformation messages as
and when it has to install a dependency. That’s how you install applications
and packages in Arch Linux. _Kinda neat, right?_


## How to install and configure Gnome on Arch Linux

Now we have a working Arch Linux system and all we need is install Gnome
desktop and configure it. First let’s install Gnome:

    
    
    pacman -S gnome gnome-extra

If you are going to use only Gnome on this system then you need to enable
Gnome Display Manage aka _gdm_ and set it to start at system reboot:

    
    
    systemctl start gdm.service
    systemctl enable gdm.service

If everything went well, you should see the login screen for Gnome. Log into
the system with the user you previously created.

### Things to do after installing Gnome

The base package of Gnome doesn’t come with many necessary packages so we are
going to install them one by one. None of this is mandatory; you can should
install only what you need in your system. First of all we need to update the
repo database and install any updates pending:

    
    
    pacman –Syu

Now it’s time to install some needed Gnome packages. I am going to install
Gnome Tweak Tool, Gnome Software, Gnome Initial Set-up. As I explained in the
Packman article you can bundle package with same name together so run the
following command to install these packages:

    
    
    sudo pacman -S gnome-{tweak-tool,software,initial-setup,shell-extensions}

Now you can open Gnome Tweak Tool and customize Gnome the way you like. Since
we have already installed many extensions you won’t have to worry about
installing them from Gnome Extensions web site. Let’s now install some needed
packages. These are the ones I use:

  * VLC: video playback
  * Clementine: music playback
  * Handbrake: video conversion
  * GIMP: Image Editing
  * LibreOffice: Productivity Suit
  * DigiKam: Image management
  * Transmission: To download torrent files of distros

    
    
    sudo pacman –S vlc clementine handbrake-cli handbrake-gtk gimp libreoffice-fresh digikam transmission-gtk

That’s pretty much takes care of most of my needs.

### Use Google Drive

With version 3.18, Gnome has added the capability to mount Google Drive as a
remote directory. This allows you to access your Google Drive from within
Files as there is no official Google Drive client for Linux (bad Google). You
can easily copy paste files to and from the Drive folder. However, keep in
mind, it’s mounted as a remote directory, none of the files are stored on your
system locally. So if you are offline on your laptop or PC you won’t be able
to access these files. In order to use Google Drive feature, open Online
Accounts and then log into the Google Drive account that you want to mount on
your system. Just follow the instructions and then in the last window you can
choose which Google services do you want to integrate with the Gnome desktop.
Now open Files and in the left panel you will see the Google Drive for that
account is listed. Just click on it and you will have access to your Google
Drive, right from the file manager. Gnome does an excellent job at integrating
email client, Evolution, Calendar and address book with accounts that were
enabled under the Online Accounts settings. Go ahead and enjoy Gnome on your
Arch Linux system.