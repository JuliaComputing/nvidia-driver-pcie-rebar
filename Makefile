all:
	sudo patch -N /usr/src/nvidia-495.46/nvidia-uvm/uvm_migrate_pageable.c 5.16-dkms.patch || echo "patch failed or already applied"
	sudo patch -N /usr/src/nvidia-495.46/nvidia/nv-pci.c 495.46-pcie-rebar.patch || echo "patch failed or already applied"
	sudo dkms uninstall -m nvidia -v 495.46 || echo "dkms uninstall failed, probably not yet installed"
	sudo dkms remove -m nvidia -v 495.46 || echo "dkms remove failed, probably not yet installed"
	sudo dkms add -m nvidia -v 495.46 || echo "dkms add failed, probably already added"
	sudo dkms build -m nvidia -v 495.46
	sudo dkms install -m nvidia -v 495.46
