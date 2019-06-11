#!/bin/bash

PKG_MANAGER="${PKG_MANAGER}"
if [ -f /etc/redhat-release ]; then
    PKG_MANAGER="yum"
fi

# install i3
sudo ${PKG_MANAGER} update
sudo ${PKG_MANAGER} install -y i3

#install i3blocks
sudo ${PKG_MANAGER} install -y i3blocks


# install deps
sudo ${PKG_MANAGER} install -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf xutils-dev libtool automake

# install xcb
cd /tmp
git clone https://github.com/Airblader/xcb-util-xrm
cd xcb-util-xrm
git submodule update --init
./autogen.sh --prefix=/usr
make
sudo make install


# install i3-gaps
cd /tmp
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
git checkout gaps && git pull
autoreconf --force --install
rm -rf build
mkdir build
cd build
../configure --prefix=/usr --sysconfdir=/etc
make
sudo make install


# install rofi
sudo ${PKG_MANAGER} install rofi

# install compton
sudo ${PKG_MANAGER} install compton

# install feh
sudo ${PKG_MANAGER} install feh

# install deps for termite
sudo ${PKG_MANAGER} install -y git g++ libgtk-3-dev gtk-doc-tools gnutls-bin valac intltool libpcre2-dev libglib3.0-cil-dev libgnutls28-dev libgirepository1.0-dev libxml2-utils gperf


# install vte lib
cd /tmp 
git clone https://github.com/thestinger/vte-ng.git
echo export LIBRARY_PATH="/usr/include/gtk-3.0:$LIBRARY_PATH"
cd vte-ng
./autogen.sh
make && sudo make install

# install termite
cd /tmp
git clone --recursive https://github.com/thestinger/termite.git
cd termite
make
sudo make install
sudo ldconfig
sudo mkdir -p /lib/terminfo/x
sudo ln -s /usr/local/share/terminfo/x/xterm-termite /lib/terminfo/x/xterm-termite
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/termite 60

# install conky
sudo ${PKG_MANAGER} install conky

# install font-awesome
sudo ${PKG_MANAGER} install fonts-font-awesome

# install py3status
sudo ${PKG_MANAGER} install py3status

# Optional: install neofetch
sudo ${PKG_MANAGER} install neofetch

# Optional: install cmatrix
sudo ${PKG_MANAGER} install cmatrix


