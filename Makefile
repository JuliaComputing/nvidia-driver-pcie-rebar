nvidia-%:
# Uncomment the following line to install patch for kernel 5.16 when using the nvidia supplied installer
#	sudo patch -N /usr/src/nvidia-$*/nvidia-uvm/uvm_migrate_pageable.c 5.16-dkms.patch || echo "patch failed or already applied"
	sudo patch -N /usr/src/nvidia-$*/nvidia/nv-pci.c 495.46-pcie-rebar.patch || echo "patch failed or already applied"
	sudo dkms uninstall -m nvidia -v $* --all || echo "dkms uninstall failed, probably not yet installed"
	sudo dkms remove -m nvidia -v $* --all|| echo "dkms remove failed, probably not yet installed"
	sudo dkms add -m nvidia -v $* || echo "dkms add failed, probably already added"
	sudo dkms build -m nvidia -v $* --force
	sudo dkms install -m nvidia -v $* --force

