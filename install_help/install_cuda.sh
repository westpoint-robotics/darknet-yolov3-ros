# https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html
# Native Linux Distribution Support in CUDA 10.0
# Distribution 			Kernel* 	GCC 	GLIBC 	ICC 	PGI 	XLC 	CLANG
# Ubuntu 16.04.5 (**) 	4.4 		5.4.0 	2.23 	18.0 	18.x 	NO 		6.0.0


# Upgrade to newest kernel
sudo apt-get -y update && sudo apt-get -y dist-upgrade && sudo reboot

# Install clang and clang6.0
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
sudo apt-add-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-6.0 main"
sudo apt-get update && sudo apt install clang && sudo apt-get install -y clang-6.0

sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.8 100
sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-6.0 1000
sudo update-alternatives --install /usr/bin/clang++ clang /usr/bin/clang-3.8 100
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.8 100
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-6.0 1000
sudo update-alternatives --config clang
sudo update-alternatives --config clang++

# Go to https://www.pgroup.com/products/community.htm, download linux x86-64, extract to folder
# cd /path/to/pgi/folder/
sudo sh install
# follow instructions

uname -r 		# 4.15.0-39-generic
gcc --version 	# gcc (Ubuntu 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609
ldd --version 	# ldd (Ubuntu GLIBC 2.23-0ubuntu10) 2.23

sudo apt-get install linux-headers-$(uname -r)

# download the cuda toolkit
https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1604&target_type=debnetwork
cd ~/Downloads && sudo dpkg -i cuda-repo-ubuntu1604_10.0.130-1_amd64.deb
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
sudo apt-get update && sudo apt-get install cuda

# sudo dpkg-reconfigure gdm3

# A modprobe blacklist file has been created at /etc/modprobe.d to prevent Nouveau from loading. This can be reverted by deleting /etc/modprobe.d/nvidia-graphics-drivers.conf.
# A new initrd image has also been created. To revert, please replace /boot/initrd-4.15.0-39-generic with /boot/initrd-$(uname -r)-backup.

echo 'export PATH=/usr/local/cuda-10.0/bin${PATH:+:${PATH}}$' >> ~/.bashrc

sudo reboot

# check cuda version:
cat /proc/driver/nvidia/version
nvcc -V

# ~~~~~~~~~~~~~~~~~~ driver issues
# If the driver stops working try this:
# sudo subl /etc/ld.so.conf.d/cuda-10-0.conf 
sudo sh -c "echo '/usr/lib/nvidia-410' >> /etc/ld.so.conf.d/cuda-10-0.conf "

sudo update-initramfs && sudo update-grub && sudo reboot