# PCIe ReBAR patch for the Linux NVIDIA kernel driver

Resizable BAR support is a PCIe extension that allows resizing a PCIe device's
mappable memory/register space (also referred to as BARs - after the Base
Address Register that sets up the region). An important use case are GPUs.
While data center GPUs, generally have BAR sizes that match the size of
video memory, consumer and workstation GPUs generally declare only have 256MiB worth
of BARs mapping GPU memory to maintain compatibility with 32bit operating systems.
However, for performance (particularly when using PCIe P2P), it is desirable to be
able to map the entirety of GPU memory, necessitating resizable BARs.

However, while PCIe ReBAR has been a standard for more than 10 years, it was ill
used until a few years ago and thus support is lacking. On very recent motherboards
(generally after 2020), a BIOS update might be available that causes the firmware
to read and reserve space for a ReBAR expansion (or even perform the BAR resize
itself). However, older motherbards do not have this support.

Fortunately for us, the Linux kernel has some support to do its own PCIe enumeration
without relying on the firmware to do everything. Linux even has support for resizable
BARs, though in practice there are a number of important limitations:

- There is currently no support for movable BARs in Linux. This means that if there
 are adjacent address space allocations, it is quite possible for BAR resizing to fail.
 There was a WIP patch series to resolve this issue at https://patchwork.ozlabs.org/project/linux-pci/cover/20201218174011.340514-1-s.miroshnichenko@yadro.com/, but it appears to have faded out.

- The resize must be explicitly requested by the driver, which the official NVidia linux
  kernel driver currently does not do. The patch in this repository address this part.

## Requirements

This is tested with:
  - NVidia 495.46 Drivers
  - Linux 5.16

