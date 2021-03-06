# This flags will be used only by the Marvell arch files compilation.

###################################################################################################
# General definitions
###################################################################################################
CPU_ARCH    = ARM
CHIP        = 88F6281
VENDOR      = Marvell
ifeq ($(CONFIG_CPU_BIG_ENDIAN),y)
ENDIAN      = BE
else
ENDIAN      = LE
endif

###################################################################################################
# directory structure
###################################################################################################
# Main directory structure
SRC_PATH          = .
PLAT_PATH	  = ../plat-orion
PLAT_DRIVERS	  = $(PLAT_PATH)/mv_drivers_lsp
HAL_DIR           = $(PLAT_PATH)/mv_hal
COMMON_DIR        = $(PLAT_PATH)/common
OSSERV_DIR        = $(PLAT_PATH)/linux_oss
LSP_DIR           = $(SRC_PATH)
CONFIG_DIR        = $(LSP_DIR)/config

# HALs
HAL_ETHPHY_DIR    = $(HAL_DIR)/eth-phy
HAL_FLASH_DIR     = $(HAL_DIR)/flash
HAL_RTC_DIR       = $(HAL_DIR)/rtc/integ_rtc
HAL_VOICEBAND     = $(HAL_DIR)/voiceband
HAL_SLIC_DIR      = $(HAL_VOICEBAND)/slic
HAL_DAA_DIR       = $(HAL_VOICEBAND)/daa
HAL_SATA_DIR      = $(HAL_DIR)/sata/CoreDriver/
HAL_QD_DIR        = $(HAL_DIR)/qd-dsdt
HAL_SFLASH_DIR    = $(HAL_DIR)/sflash
HAL_CNTMR_DIR     = $(HAL_DIR)/cntmr
HAL_GPP_DIR       = $(HAL_DIR)/gpp
HAL_TWSI_DIR      = $(HAL_DIR)/twsi
HAL_TWSI_ARCH_DIR = $(SOC_TWSI_DIR)/Arch$(CPU_ARCH)
HAL_UART_DIR      = $(HAL_DIR)/uart
HAL_ETH_DIR       = $(HAL_DIR)/eth/gbe
HAL_ETH_NFP_DIR	  = $(HAL_DIR)/eth/nfp
HAL_CPU_DIR       = $(HAL_DIR)/cpu
ifeq ($(CONFIG_MV_INCLUDE_TDM),y)
HAL_TDM_DIR       = $(HAL_DIR)/voiceband/tdm
endif
ifeq ($(CONFIG_MV_INCLUDE_USB),y)
HAL_USB_DIR       = $(HAL_DIR)/usb
endif
ifeq ($(CONFIG_MV_INCLUDE_CESA),y)
HAL_CESA_DIR	  = $(HAL_DIR)/cesa
HAL_CESA_AES_DIR  = $(HAL_DIR)/cesa/AES
endif
ifeq ($(CONFIG_MV_INCLUDE_SPI),y)
HAL_SPI_DIR       = $(HAL_DIR)/spi
endif
ifeq ($(CONFIG_MV_INCLUDE_TS),y)
HAL_TS_DIR      = $(HAL_DIR)/ts
endif
ifeq ($(CONFIG_MV_INCLUDE_LCD),y)
HAL_LCD_DIR      = $(HAL_DIR)/lcd
endif

# Environment components
KW_FAM_DIR	    = $(LSP_DIR)/kw_family
SOC_DEVICE_DIR      = $(KW_FAM_DIR)/device
SOC_CPU_DIR         = $(KW_FAM_DIR)/cpu
BOARD_ENV_DIR       = $(KW_FAM_DIR)/boardEnv
SOC_ENV_DIR         = $(KW_FAM_DIR)/ctrlEnv
SOC_SYS_DIR	    = $(KW_FAM_DIR)/ctrlEnv/sys

#####################################################################################################
# Include path
###################################################################################################

LSP_PATH_I       = $(srctree)/arch/arm/mach-kirkwood
PLAT_PATH_I	 = $(srctree)/arch/arm/plat-orion

HAL_PATH         = -I$(PLAT_PATH_I)/$(HAL_DIR) -I$(PLAT_PATH_I)/$(HAL_SATA_DIR)
KW_FAM_PATH      = -I$(LSP_PATH_I)/$(KW_FAM_DIR)
QD_PATH          = -I$(PLAT_PATH_I)/$(HAL_QD_DIR)/Include  -I$(PLAT_PATH_I)/$(HAL_QD_DIR)/Include/h/msApi 	\
                   -I$(PLAT_PATH_I)/$(HAL_QD_DIR)/Include/h/driver -I$(PLAT_PATH_I)/$(HAL_QD_DIR)/Include/h/platform

COMMON_PATH   	 = -I$(PLAT_PATH_I)/$(COMMON_DIR) -I$(srctree)

OSSERV_PATH      = -I$(PLAT_PATH_I)/$(OSSERV_DIR)
LSP_PATH         = -I$(LSP_PATH_I)/$(LSP_DIR)
CONFIG_PATH      = -I$(LSP_PATH_I)/$(CONFIG_DIR)
DRIVERS_LSP_PATH = -I$(PLAT_PATH_I)/$(PLAT_DRIVERS)

EXTRA_INCLUDE  	 = $(OSSERV_PATH) $(COMMON_PATH) $(HAL_PATH)  $(KW_FAM_PATH) \
                   $(LSP_PATH) $(CONFIG_PATH) $(DRIVERS_LSP_PATH)

###################################################################################################
# defines
###################################################################################################
MV_DEFINE = -DMV_LINUX -DMV_CPU_$(ENDIAN) -DMV_$(CPU_ARCH)


ifeq ($(CONFIG_MV_GATEWAY),y)
EXTRA_INCLUDE	+= $(QD_PATH)
EXTRA_CFLAGS    += -DLINUX
endif

ifeq ($(CONFIG_MV_INCLUDE_SWITCH),y)
EXTRA_INCLUDE   += $(QD_PATH)
EXTRA_CFLAGS    += -DLINUX
endif

ifeq ($(CONFIG_MV_CESA_TEST),y)
EXTRA_CFLAGS 	+= -DCONFIG_MV_CESA_TEST
endif

ifeq ($(CONFIG_SATA_DEBUG_ON_ERROR),y)
EXTRA_CFLAGS    += -DMV_LOG_ERROR
endif

ifeq ($(CONFIG_SATA_FULL_DEBUG),y)
EXTRA_CFLAGS    += -DMV_LOG_DEBUG
endif

ifeq ($(CONFIG_MV_SATA_SUPPORT_ATAPI),y)
EXTRA_CFLAGS    += -DMV_SUPPORT_ATAPI
endif

ifeq ($(CONFIG_MV_SATA_ENABLE_1MB_IOS),y)
EXTRA_CFLAGS    += -DMV_SUPPORT_1MBYTE_IOS
endif

ifeq ($(CONFIG_MV88F6281),y)
EXTRA_CFLAGS    += -DMV88F6281
endif

ifeq ($(CONFIG_MV_CESA_CHAIN_MODE_SUPPORT),y)
EXTRA_CFLAGS    += -DMV_CESA_CHAIN_MODE_SUPPORT
endif

EXTRA_CFLAGS 	+= $(EXTRA_INCLUDE) $(MV_DEFINE)

EXTRA_AFLAGS 	+= $(EXTRA_CFLAGS)
