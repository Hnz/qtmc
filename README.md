About                                                                 {#index}
=====

QtMC is a Media Center built using Qt and QML.


Requirements
============

* Qt (>= 4.7.4)
* Qt Mobility (=> 1.2)
* liblastfm


Building and Installing
=======================

    mkdir build
    cd build
    cmake ..
    make

The binary will be created in <build-folder>/bin
To install, use:

    make install


Installing from repository
==========================

QtMC uses the Open Build Service (http://www.open-build-service.org) to build
yum and apt repositories. To add the repositories and install QtMC, run the
following commands as root:

Fedora 16
---------

    cd /etc/yum.repos.d
    wget http://download.opensuse.org/repositories/home:/Hanzzzz:/qtmc/Fedora_16/home:Hanzzzz:qtmc.repo
    yum install qtmc

OpenSUSE 12.1
-------------

    zypper ar http://download.opensuse.org/repositories/home:/Hanzzzz:/qtmc/openSUSE_12.1/home:Hanzzzz:qtmc.repo
    zypper install qtmc

Ubuntu 12.04
------------

    echo "deb http://download.opensuse.org/repositories/home:/Hanzzzz:/qtmc/xUbuntu_12.04/ ./" \
    > /etc/apt/sources.list.d/qtmc.list
    wget -qO- http://download.opensuse.org/repositories/home:/Hanzzzz:/qtmc/xUbuntu_12.04/Release.key \
    | apt-key add -
    apt-get update
    apt-get install qtmc

This is the preferred method of installation on supported platforms.


Source Archive
==============

Use the following command to generate a source archive:

    make package_source


Translation
===========

To update the translation, run the following command:

    lupdate-qt4 . -ts translations/qtmc_nl.ts

Then, edit the file _translations/qtmc_nl.ts using Qt Linguist.

_**Note**: lupdate is sometimes named lupdate-qt4_


License
=======

_Copyright 2012 Hans van Leeuwen <hansvl@gmail.com>_

QtMC is LGPLv3-licensed. See LICENSE-file for details
