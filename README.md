Awaiting packages script
==================

Simple script for all those Gentoo  users  who  are waiting for a certain package to became stable - especially when this package is still unstable at this moment (with no stable version).

##Dependencies##
* _eix_
* bash
* Gentoo OS :)

##Simple usage##
run: _awaiting-packages.sh -a <any-package-atom>_ to start waiting for cartain package.
For more info, how to remove or list all packages you are waiting for, check help _awaiting-packages.sh --help_

###Recommended usage###
My personal advise how to use this script is to create a simple script that calls _eix-sync_ command first and then _waiting-packages.sh_
Place this new script into _/usr/bin_ directory and name it e.g. _sync-eix_. From now on, instead of running _eix-sync_ to synchronize your portage, run _sync-eix_.
This will not only synchronize your portage as before, but also run this script afterwards.
