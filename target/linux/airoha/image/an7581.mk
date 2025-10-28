define Device/FitImageLzma
	KERNEL_SUFFIX := -uImage.itb
	KERNEL = kernel-bin | lzma | fit lzma $$(KDIR)/image-$$(DEVICE_DTS).dtb
	KERNEL_NAME := Image
endef

define Device/airoha_an7581-evb
  $(call Device/FitImageLzma)
  DEVICE_VENDOR := Airoha
  DEVICE_MODEL := AN7581 Evaluation Board (SNAND)
  DEVICE_PACKAGES := kmod-leds-pwm kmod-i2c-an7581 kmod-pwm-airoha kmod-input-gpio-keys-polled
  DEVICE_DTS := an7581-evb
  DEVICE_DTS_CONFIG := config@1
  KERNEL_LOADADDR := 0x80088000
  IMAGE/sysupgrade.bin := append-kernel | pad-to 128k | append-rootfs | pad-rootfs | append-metadata
endef
TARGET_DEVICES += airoha_an7581-evb

define Device/airoha_an7581-evb-emmc
  DEVICE_VENDOR := Airoha
  DEVICE_MODEL := AN7581 Evaluation Board (EMMC)
  DEVICE_DTS := an7581-evb-emmc
  DEVICE_PACKAGES := kmod-i2c-an7581
endef
TARGET_DEVICES += airoha_an7581-evb-emmc

define Device/gemtek_w1700k
  $(call Device/FitImageLzma)
  DEVICE_VENDOR := Gemtek
  DEVICE_MODEL := W1700K
  DEVICE_ALT0_VENDOR := CenturyLink
  DEVICE_ALT0_MODEL := W1700K
  DEVICE_ALT1_VENDOR := Lumen
  DEVICE_ALT1_MODEL := W1700K
  DEVICE_ALT2_VENDOR := Quantum Fiber
  DEVICE_ALT2_MODEL := W1700K
  DEVICE_PACKAGES := airoha-en7581-npu-firmware \
		    kmod-i2c-an7581 kmod-hwmon-nct7802 \
		    kmod-mt7996-firmware kmod-phy-realtek
  KERNEL_LOADADDR := 0x80088000
  IMAGE/sysupgrade.bin := sysupgrade-tar | append-metadata
SOC := an7581
endef
TARGET_DEVICES += gemtek_w1700k

define Device/bell_xg-040g-md
  $(call Device/FitImageLzma)
  DEVICE_VENDOR := Nokia Bell
  DEVICE_MODEL := Nokia Bell XG-040G-MD
  DEVICE_PACKAGES := airoha-en7581-npu-firmware kmod-phy-airoha-en8811h \
                    kmod-i2c-an7581 kmod-input-gpio-keys-polled
  DEVICE_DTS_CONFIG := config@1
  KERNEL_LOADADDR := 0x80088000
  UBINIZE_OPTS := -E 5
  BLOCKSIZE := 128k
  PAGESIZE := 2048
  KERNEL_SIZE := 10240k
  IMAGE_SIZE := 261120k
  KERNEL_IN_UBI := 1
  UBINIZE_OPTS := -m 2048 -p 128KiB -s 2048
  IMAGES += factory.bin sysupgrade.bin
  IMAGE/factory.bin := append-kernel | pad-to $$$$(KERNEL_SIZE) | append-ubi
  IMAGE/sysupgrade.bin := sysupgrade-tar | append-metadata
  SOC := an7581
endef
TARGET_DEVICES += bell_xg-040g-md