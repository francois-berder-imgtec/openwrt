
define KernelPackage/serial-sc16is7xx
  TITLE:= SC16IS7xx Serial driver
  SUBMENU:=$(OTHER_MENU)
  KCONFIG:= \
    CONFIG_SPI=y \
    CONFIG_SPI_MASTER=y \
    CONFIG_SERIAL_SC16IS7XX \
    CONFIG_SERIAL_SC16IS7XX_CORE \
    CONFIG_SERIAL_SC16IS7XX_SPI=y \
    CONFIG_SERIAL_SC16IS7XX_I2C=n
  FILES:= $(LINUX_DIR)/drivers/tty/serial/sc16is7xx.ko
  AUTOLOAD:= $(call AutoProbe, sc16is7xx.ko)
  DEPENDS:=@TARGET_pistachio_marduk
  $(call AddDepends/serial)
endef

$(eval $(call KernelPackage,serial-sc16is7xx))


define KernelPackage/sound-pistachio-soc
  TITLE:=SoC Audio support for the Pistachio SOC
  KCONFIG:= \
    CONFIG_SND_MIPS=y \
    CONFIG_SND_SOC_IMG=y \
    CONFIG_SND_SOC_IMG_I2S_IN \
    CONFIG_SND_SOC_IMG_I2S_OUT \
    CONFIG_SND_SOC_IMG_PARALLEL_OUT \
    CONFIG_SND_SOC_IMG_SPDIF_IN \
    CONFIG_SND_SOC_IMG_SPDIF_OUT \
    CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC \
    CONFIG_SND_SOC_IMG_PISTACHIO_BUB \
    CONFIG_SND_SOC_IMG_PISTACHIO \
    CONFIG_SND_SOC_IMG_PISTACHIO_EVENT_TIMER=y \
    CONFIG_SND_SOC_IMG_PISTACHIO_EVENT_TIMER_ATU=y
  FILES:= \
    $(LINUX_DIR)/sound/soc/codecs/snd-soc-tpa6130a2.ko \
    $(LINUX_DIR)/sound/soc/img/img-i2s-in.ko \
    $(LINUX_DIR)/sound/soc/img/img-i2s-out.ko \
    $(LINUX_DIR)/sound/soc/img/img-parallel-out.ko \
    $(LINUX_DIR)/sound/soc/img/img-spdif-in.ko \
    $(LINUX_DIR)/sound/soc/img/img-spdif-out.ko \
    $(LINUX_DIR)/sound/soc/img/pistachio-event-timer-module.ko \
    $(LINUX_DIR)/sound/soc/img/pistachio-internal-dac.ko \
    $(LINUX_DIR)/sound/soc/img/pistachio.ko
  AUTOLOAD:=$(call AutoProbe,img-i2s-in.ko img-i2s-out.ko img-parallel-out.ko img-spdif-in.ko img-spdif-out.ko pistachio-event-timer-module.ko pistachio-internal-dac.ko snd-soc-tpa6130a2.ko pistachio.ko)
  DEPENDS:=@TARGET_pistachio_marduk +kmod-sound-soc-core +kmod-serial-sc16is7xx
  $(call AddDepends/sound)
endef

$(eval $(call KernelPackage,sound-pistachio-soc))


define KernelPackage/marduk-cc2520
  SUBMENU:=$(WPAN_MENU)
  TITLE:=CC2520 transceiver driver for Marduk Board
  DEPENDS:=@TARGET_pistachio_marduk +kmod-mac802154 +kmod-ieee802154_6lowpan \
    +kmod-nhc_udp +kmod-nhc_fragment +kmod-nhc_dest +kmod-nhc_hop \
    +kmod-nhc_mobility +kmod-nhc_routing +kmod-nhc_ipv6
  KCONFIG:=CONFIG_IEEE802154_CC2520 \
    CONFIG_SPI=y \
    CONFIG_SPI_MASTER=y
  FILES:=$(LINUX_DIR)/drivers/net/ieee802154/cc2520.ko
  AUTOLOAD:=$(call AutoLoad,92,cc2520)
endef

$(eval $(call KernelPackage,marduk-cc2520))


define KernelPackage/nhc_dest
  SUBMENU:=$(OTHER_MENU)
  TITLE:=6LoWPAN IPv6 Destination Options Header compression
  DEPENDS:=@!LINUX_3_18 +kmod-6lowpan
  KCONFIG:= \
    CONFIG_6LOWPAN_NHC_DEST \
    CONFIG_6LOWPAN_NHC=y
  FILES:=$(LINUX_DIR)/net/6lowpan/nhc_dest.ko
  AUTOLOAD:=$(call AutoProbe,nhc_dest)
endef

define KernelPackage/nhc_dest/description
  6LoWPAN IPv6 Destination Options Header compression
endef

$(eval $(call KernelPackage,nhc_dest))


define KernelPackage/nhc_fragment
  SUBMENU:=$(OTHER_MENU)
  TITLE:=6LoWPAN IPv6 Fragment Header compression
  DEPENDS:=@!LINUX_3_18 +kmod-6lowpan
  KCONFIG:= \
    CONFIG_6LOWPAN_NHC_FRAGMENT \
    CONFIG_6LOWPAN_NHC=y
  FILES:=$(LINUX_DIR)/net/6lowpan/nhc_fragment.ko
  AUTOLOAD:=$(call AutoProbe,nhc_fragment)
endef

define KernelPackage/nhc_fragment/description
  6LoWPAN IPv6 Fragment Header compression
endef

$(eval $(call KernelPackage,nhc_fragment))


define KernelPackage/nhc_hop
  SUBMENU:=$(OTHER_MENU)
  TITLE:=6LoWPAN IPv6 Hop-by-Hop Options Header compression
  DEPENDS:=@!LINUX_3_18 +kmod-6lowpan
  KCONFIG:= \
    CONFIG_6LOWPAN_NHC_HOP \
    CONFIG_6LOWPAN_NHC=y
  FILES:=$(LINUX_DIR)/net/6lowpan/nhc_hop.ko
  AUTOLOAD:=$(call AutoProbe,nhc_hop)
endef

define KernelPackage/nhc_hop/description
  6LoWPAN IPv6 Hop-by-Hop Options Header compression
endef

$(eval $(call KernelPackage,nhc_hop))


define KernelPackage/nhc_ipv6
  SUBMENU:=$(OTHER_MENU)
  TITLE:=6LoWPAN IPv6 Header compression
  DEPENDS:=@!LINUX_3_18 +kmod-6lowpan
  KCONFIG:= \
    CONFIG_6LOWPAN_NHC_IPV6 \
    CONFIG_6LOWPAN_NHC=y
  FILES:=$(LINUX_DIR)/net/6lowpan/nhc_ipv6.ko
  AUTOLOAD:=$(call AutoProbe,nhc_ipv6)
endef

define KernelPackage/nhc_ipv6/description
  6LoWPAN IPv6 Header compression
endef

$(eval $(call KernelPackage,nhc_ipv6))


define KernelPackage/nhc_mobility
  SUBMENU:=$(OTHER_MENU)
  TITLE:=6LoWPAN IPv6 Mobility Header compression
  DEPENDS:=@!LINUX_3_18 +kmod-6lowpan
  KCONFIG:= \
    CONFIG_6LOWPAN_NHC_MOBILITY \
    CONFIG_6LOWPAN_NHC=y
  FILES:=$(LINUX_DIR)/net/6lowpan/nhc_mobility.ko
  AUTOLOAD:=$(call AutoProbe,nhc_mobility)
endef

define KernelPackage/nhc_mobility/description
  6LoWPAN IPv6 Mobility Header compression
endef

$(eval $(call KernelPackage,nhc_mobility))


define KernelPackage/nhc_routing
  SUBMENU:=$(OTHER_MENU)
  TITLE:=LoWPAN IPv6 Routing Header compression
  DEPENDS:=@!LINUX_3_18 +kmod-6lowpan
  KCONFIG:= \
    CONFIG_6LOWPAN_NHC_ROUTING \
    CONFIG_6LOWPAN_NHC=y
  FILES:=$(LINUX_DIR)/net/6lowpan/nhc_routing.ko
  AUTOLOAD:=$(call AutoProbe,nhc_routing)
endef

define KernelPackage/nhc_routing/description
  LoWPAN IPv6 Routing Header compression
endef

$(eval $(call KernelPackage,nhc_routing))


define KernelPackage/nhc_udp
  SUBMENU:=$(OTHER_MENU)
  TITLE:=6LoWPAN IPv6 UDP compression
  DEPENDS:=@!LINUX_3_18 +kmod-6lowpan
  KCONFIG:= \
    CONFIG_6LOWPAN_NHC_UDP \
    CONFIG_6LOWPAN_NHC=y
  FILES:=$(LINUX_DIR)/net/6lowpan/nhc_udp.ko
  AUTOLOAD:=$(call AutoProbe,nhc_udp)
endef

define KernelPackage/nhc_fragment/description
  6LoWPAN IPv6 UDP compression
endef

$(eval $(call KernelPackage,nhc_udp))
