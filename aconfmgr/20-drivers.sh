
AddPackage nvidia-dkms # NVIDIA kernel modules - module sources
# AddPackage nvidia # NVIDIA kernel modules
AddPackage nvidia-prime # NVIDIA Prime Render Offload configuration and utilities
AddPackage nvidia-settings # Tool for configuring the NVIDIA graphics driver

AddPackage xf86-video-amdgpu # X.org amdgpu video driver

AddPackage lib32-nvidia-utils # NVIDIA drivers utilities (32-bit)
AddPackage lib32-vulkan-icd-loader # Vulkan Installable Client Driver (ICD) Loader (32-bit)
AddPackage lib32-vulkan-radeon # Open-source Vulkan driver for AMD GPUs - 32-bit

AddPackage --foreign nvidia-prime-rtd3pm # Configure your discrete NVIDIA GPU to power down when not in use.
