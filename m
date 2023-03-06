Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F2F6AC9F6
	for <lists+linux-iio@lfdr.de>; Mon,  6 Mar 2023 18:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjCFRY6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Mar 2023 12:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjCFRYv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Mar 2023 12:24:51 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C2B65123;
        Mon,  6 Mar 2023 09:24:18 -0800 (PST)
Received: from stefanw-SCHENKER ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N79ly-1qeX0L0Rhc-017Uxu; Mon, 06 Mar 2023 18:23:17 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-imx@nxp.com, Li Yang <leoyang.li@nxp.com>,
        Denis Ciocca <denis.ciocca@st.com>, soc@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 7/8] ARM: dts: imx6ull: Add chargebyte Tarragon support
Date:   Mon,  6 Mar 2023 18:22:48 +0100
Message-Id: <20230306172249.74003-8-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230306172249.74003-1-stefan.wahren@i2se.com>
References: <20230306172249.74003-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ErkC1hCD923LMyJISgaXdyPPR7O3qKYGs7UlCfoUDde/9Il6/dg
 Mfkqha85ZNsa8Qh8jttjFsBMwgyKKQy7WlVWLeBQk2uT/U5Kul4RX9zLcyr1JKsjH5YuVNX
 HaNvcyEZ7poeaQgnZNbK64w1qgjVF3KZEMvWEIhWlBgK9/JKZBLqZaeMZW/Wi5U93YxuWjL
 lfQIgMCB1P81sNNMMhYjA==
UI-OutboundReport: notjunk:1;M01:P0:fOMgDhWXsZw=;De5zXZ2oC9Eh7xTu9PvZLN1my2i
 xcJzvFhig34s9zBl+2wV5L8npndtUBSm8GFGrLFKvyUSB2I6Ep/f3dVYIcQnKqHPXP/763BJl
 m8ejH84WvBs5e8j8VKNbDj+rb7cShN+tTAHCMhagfV8zg0YPp0Ovh+zsLEr7KQFwdzRNe/vNR
 fe749WuiiLPXHDph4QoolyzZx8a6KCo6aOQSFcKnD4YXu+oo3Azsfd94XnLqAULpp5dvVKimI
 BvVATeAWzkjceJSXCPKlaNdii+n80GEsLalrzHZDsEHax8i6W5+6XISEN1qY/6ApLmj/A+0+C
 msnjcD2I+mJk0n0B482BqoG2FlQLBDGRZ+pqDc0uC2ON/5rNVwNVdI/e7Pfz67XgOg4UoOg8q
 MpbDzNo+IOihm3aO0qEp5nVX9YrJXJTrEjA5bcHescxDJimociiaGZFczpY4n4m/hsmtUBOXU
 cq7aCSKySQIWUEavfVJ8PSpa7fBXISZ/BakIo28UcEBTrj7G43pS3tDRL0Ku702Fot/Yb8gsP
 4qCirMGCmTWMHjsTfaJLpTwBif/RJecCNKX92pDe95NSHhQSjfUB4YgQe2odbFx83fQke2Z7D
 AGsNz6iCu8GY9Dx7d+kpjWstho4eKiebi9I26shQ1Dy4e5zUOAXzDY/Fjh2U2J6zcfDtQxV9z
 SbquJLniNSurMf6F5U60BvApWJqgaTx0/yZSTkJckA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Stefan Wahren <stefan.wahren@chargebyte.com>

This adds the support for chargebyte Tarragon, which is an Electrical
Vehicle Supply Equipment (EVSE) for AC charging stations
(according to IEC 61851, ISO 15118).

The Tarragon board is based on an i.MX6ULL SoC and is available in
4 variants (Master, Slave, SlaveXT, Micro), which provide more or
less peripherals.

Supported features:
  * 512 MB DDR RAM
  * eMMC
  * Debug UART
  * 100 Mbit Ethernet
  * USB 2.0 Host interface
  * Powerline communication (QCA700x)
  * 2x RS485
  * Digital in- and outputs (12 V)
  * One-Wire master for external temp sensors
  * 2x relay outputs
  * 2x motor interfaces

Link: https://chargebyte.com/products/charging-station-communication/charge-control-c
Signed-off-by: Stefan Wahren <stefan.wahren@chargebyte.com>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/Makefile                    |   4 +
 .../arm/boot/dts/imx6ull-tarragon-common.dtsi | 858 ++++++++++++++++++
 arch/arm/boot/dts/imx6ull-tarragon-master.dts |  82 ++
 arch/arm/boot/dts/imx6ull-tarragon-micro.dts  |  10 +
 arch/arm/boot/dts/imx6ull-tarragon-slave.dts  |  32 +
 .../arm/boot/dts/imx6ull-tarragon-slavext.dts |  64 ++
 6 files changed, 1050 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ull-tarragon-common.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-tarragon-master.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-tarragon-micro.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-tarragon-slave.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-tarragon-slavext.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index efe4152e5846..aae52a6380bc 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -755,6 +755,10 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ull-phytec-segin-lc-rdk-nand.dtb \
 	imx6ull-phytec-tauri-emmc.dtb \
 	imx6ull-phytec-tauri-nand.dtb \
+	imx6ull-tarragon-master.dtb \
+	imx6ull-tarragon-micro.dtb \
+	imx6ull-tarragon-slave.dtb \
+	imx6ull-tarragon-slavext.dtb \
 	imx6ull-tqma6ull2-mba6ulx.dtb \
 	imx6ull-tqma6ull2l-mba6ulx.dtb \
 	imx6ulz-14x14-evk.dtb \
diff --git a/arch/arm/boot/dts/imx6ull-tarragon-common.dtsi b/arch/arm/boot/dts/imx6ull-tarragon-common.dtsi
new file mode 100644
index 000000000000..1099dd688e80
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-tarragon-common.dtsi
@@ -0,0 +1,858 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+//
+// Copyright (C) 2023 chargebyte GmbH
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pwm/pwm.h>
+#include "imx6ull.dtsi"
+
+/ {
+	aliases {
+		mmc0 = &usdhc2; /* eMMC */
+	};
+
+	chosen {
+		stdout-path = &uart4;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>;
+	};
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		pinctrl-0 = <&pinctrl_emmc_rst>;
+		pinctrl-names = "default";
+		reset-gpios = <&gpio4 10 GPIO_ACTIVE_LOW>;
+	};
+
+	reg_dcdc_3v3: regulator-dcdc-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "dcdc-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_1v8: regulator-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "ldo-1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_status_leds>;
+
+		led1 {
+			label = "evse:green:led1";
+			function = LED_FUNCTION_BOOT;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio3 14 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "timer";
+		};
+
+		led2 {
+			label = "evse:yellow:led2";
+			function = LED_FUNCTION_PROGRAMMING;
+			color = <LED_COLOR_ID_YELLOW>;
+			gpios = <&gpio3 15 GPIO_ACTIVE_HIGH>;
+		};
+
+		led3 {
+			label = "evse:red:led3";
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&adc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc_motor
+		     &pinctrl_adc_cp
+		     &pinctrl_adc_pp>;
+	vref-supply = <&vgen1_reg>;
+	status = "okay";
+};
+
+&cpu0 {
+	clock-frequency = <792000000>;
+};
+
+&ecspi2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi2>;
+	num-cs = <3>;
+	cs-gpios = <&gpio1 29 GPIO_ACTIVE_HIGH
+		    &gpio3 2  GPIO_ACTIVE_HIGH
+		    &gpio3 4  GPIO_ACTIVE_HIGH>;
+};
+
+&ecspi4 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_qca700x_mains_spi>;
+	num-cs = <1>;
+	cs-gpios = <&gpio2 15 GPIO_ACTIVE_HIGH>;
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet1
+		     &pinctrl_enet1_phy_rst
+		     &pinctrl_enet_mdio>;
+	phy-supply = <&reg_dcdc_3v3>;
+	phy-mode = "rmii";
+	phy-reset-gpios = <&gpio5 6 GPIO_ACTIVE_LOW>;
+	phy-reset-duration = <25>;
+	phy-handle = <&ethphy0>;
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_enet1_phy_int>;
+			interrupt-parent = <&gpio2>;
+			interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+			interrupts-extended = <&gpio2 7 IRQ_TYPE_EDGE_FALLING>;
+			clocks = <&clks IMX6UL_CLK_ENET_REF>;
+			clock-names = "rmii-ref";
+			max-speed = <100>;
+			smsc,disable-energy-detect;
+		};
+	};
+};
+
+&gpio1 {
+	gpio-line-names = "",				/* 0 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",				/* 5 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",				/* 10 */
+			  "",
+			  "",
+			  "CP_INVERT",
+			  "",
+			  "",				/* 15 */
+			  "",
+			  "",
+			  "",
+			  "MOTOR_1_FAULT_N",
+			  "",				/* 20 */
+			  "",
+			  "ROTARY_SWITCH_1_2_N",
+			  "ROTARY_SWITCH_1_4_N",
+			  "ROTARY_SWITCH_1_8_N",
+			  "MOTOR_2_FAULT_N";		/* 25 */
+};
+
+&gpio3 {
+	gpio-line-names = "",				/* 0 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",				/* 5 */
+			  "EXT_GPIO",
+			  "MOTOR_1_DRIVER_IN1_N",
+			  "MOTOR_1_DRIVER_IN2",
+			  "MOTOR_2_DRIVER_IN1",
+			  "STM32_BOOT0",		/* 10 */
+			  "STM32_RST_N",
+			  "RELAY_1_ENABLE",
+			  "RELAY_2_ENABLE",
+			  "",
+			  "",				/* 15 */
+			  "QCA700X_MAINS_BOOTLOADER_N",
+			  "QCA700X_CP_RST_N",
+			  "QCA700X_CP_BOOTLOADER_N",
+			  "",
+			  "DIGITAL_OUT_1",		/* 20 */
+			  "DIGITAL_OUT_2",
+			  "DIGITAL_OUT_3",
+			  "DIGITAL_OUT_4",
+			  "DIGITAL_OUT_5",
+			  "DIGITAL_OUT_6",		/* 25 */
+			  "ROTARY_SWITCH_2_8_N",
+			  "ROTARY_SWITCH_2_4_N",
+			  "ROTARY_SWITCH_2_2_N";
+};
+
+&gpio4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pmic>;
+
+	gpio-line-names = "",				/* 0 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",				/* 5 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",				/* 10 */
+			  "",
+			  "",
+			  "BOARD_VARIANT_1",
+			  "BOARD_VARIANT_2",
+			  "BOARD_VARIANT_0",		/* 15 */
+			  "BOARD_VARIANT_3",
+			  "",
+			  "ROTARY_SWITCH_2_1_N",
+			  "",
+			  "DIGITAL_IN_5",		/* 20 */
+			  "",
+			  "",
+			  "DIGITAL_IN_6",
+			  "",
+			  "DIGITAL_IN_1",		/* 25 */
+			  "DIGITAL_IN_2",
+			  "DIGITAL_IN_4",
+			  "DIGITAL_IN_3";
+
+	pmic-int-hog {
+		gpio-hog;
+		gpios = <19 0>;
+		input;
+	};
+};
+
+&gpio5 {
+	gpio-line-names = "ROTARY_SWITCH_1_1_N",	/* 0 */
+			  "",
+			  "RELAY_2_SENSE",
+			  "RELAY_1_SENSE",
+			  "",
+			  "",				/* 5 */
+			  "",
+			  "QCA700X_MAINS_RST_N",
+			  "MOTOR_2_DRIVER_IN2",
+			  "",
+			  "CP_POSITIVE_PEAK_RST",	/* 10 */
+			  "CP_NEGATIVE_PEAK_RST";
+};
+
+&i2c4 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	pinctrl-1 = <&pinctrl_i2c4_gpio>;
+	scl-gpios = <&gpio1 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio1 21 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	pfuze3001: pmic@8 {
+		compatible = "fsl,pfuze3001";
+		reg = <0x08>;
+
+		regulators {
+			sw1_reg: sw1 {
+				regulator-name = "SW1";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw2_reg: sw2 {
+				regulator-name = "SW2";
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3_reg: sw3 {
+				regulator-name = "SW3";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1650000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			snvs_reg: vsnvs {
+				regulator-name = "VSNVS";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vgen1_reg: vldo1 {
+				regulator-name = "VLDO1";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen2_reg: vldo2 {
+				regulator-name = "VLDO2";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+				regulator-always-on;
+			};
+
+			vgen3_reg: vccsd {
+				regulator-name = "VCCSD";
+				regulator-min-microvolt = <2850000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen4_reg: v33 {
+				regulator-name = "V33";
+				regulator-min-microvolt = <2850000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen5_reg: vldo3 {
+				regulator-name = "VLDO3";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen6_reg: vldo4 {
+				regulator-name = "VLDO4";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+		};
+	};
+
+	onewire@18 {
+		compatible = "maxim,ds2484";
+		reg = <0x18>;
+	};
+
+	accelerometer@19 {
+		compatible = "st,iis328dq";
+		reg = <0x19>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_accelerometer_int1_snvs>;
+		vdd-supply = <&reg_dcdc_3v3>;
+		vddio-supply = <&reg_dcdc_3v3>;
+		st,drdy-int-pin = <1>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <5 IRQ_TYPE_EDGE_RISING>;
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog_pins
+		     &pinctrl_gpio_motor
+		     &pinctrl_board_var
+		     &pinctrl_digital_input
+		     &pinctrl_digital_output
+		     &pinctrl_rotary_switch1
+		     &pinctrl_rotary_switch2>;
+
+	tarragon {
+		pinctrl_status_leds: status-ledsgrp {
+			fsl,pins = <
+				MX6UL_PAD_LCD_DATA09__GPIO3_IO14            0xb0
+				MX6UL_PAD_LCD_DATA10__GPIO3_IO15            0xb0
+				MX6UL_PAD_LCD_DATA14__GPIO3_IO19            0xb0
+			>;
+		};
+
+		pinctrl_adc_motor: adc-motorgrp {
+			fsl,pins = <
+				MX6UL_PAD_GPIO1_IO00__GPIO1_IO00            0xb0
+				MX6UL_PAD_GPIO1_IO01__GPIO1_IO01            0xb0
+				MX6UL_PAD_GPIO1_IO04__GPIO1_IO04            0xb0
+			>;
+		};
+
+		pinctrl_gpio_motor: gpio-motorgrp {
+			fsl,pins = <
+				MX6UL_PAD_LCD_DATA02__GPIO3_IO07            0x400000b0
+				MX6UL_PAD_LCD_DATA03__GPIO3_IO08            0x400000b0
+				MX6UL_PAD_LCD_DATA04__GPIO3_IO09            0x400000b0
+				MX6UL_PAD_UART1_RTS_B__GPIO1_IO19           0xb0
+				MX6UL_PAD_UART3_RX_DATA__GPIO1_IO25         0xb0
+			>;
+		};
+
+		pinctrl_adc_cp: adc-cpgrp {
+			fsl,pins = <
+				MX6UL_PAD_GPIO1_IO02__GPIO1_IO02            0xb0
+				MX6UL_PAD_GPIO1_IO03__GPIO1_IO03            0xb0
+			>;
+		};
+
+		pinctrl_adc_pp: adc-ppgrp {
+			fsl,pins = <
+				MX6UL_PAD_GPIO1_IO05__GPIO1_IO05            0xb0
+			>;
+		};
+
+		pinctrl_usb_pwr: usb-pwrgrp {
+			fsl,pins = <
+				MX6UL_PAD_SD1_CMD__USB_OTG1_PWR             0xb0
+			>;
+		};
+
+		pinctrl_usb: usbgrp {
+			fsl,pins = <
+				MX6UL_PAD_SD1_CLK__USB_OTG1_OC              0x70b0
+				MX6UL_PAD_SD1_DATA0__ANATOP_OTG1_ID         0x70b0
+			>;
+		};
+
+		pinctrl_enet_mdio: enet-mdiogrp {
+			fsl,pins = <
+				MX6UL_PAD_GPIO1_IO06__ENET1_MDIO            0x10b0
+				MX6UL_PAD_GPIO1_IO07__ENET1_MDC             0x10b0
+			>;
+		};
+
+		pinctrl_enet1_phy_int: enet1-phy-intgrp {
+			fsl,pins = <
+				MX6UL_PAD_ENET1_RX_ER__GPIO2_IO07           0x10b0
+			>;
+		};
+
+		pinctrl_enet1: enet1grp {
+			fsl,pins = <
+				MX6UL_PAD_ENET1_RX_DATA0__ENET1_RDATA00     0x100b0
+				MX6UL_PAD_ENET1_RX_DATA1__ENET1_RDATA01     0x100b0
+				MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN          0x100b0
+				MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1      0x400000b1
+				MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00     0xb0
+				MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01     0xb0
+				MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN          0xb0
+			>;
+		};
+
+		pinctrl_fan_enable: fan-enablegrp {
+			fsl,pins = <
+				MX6UL_PAD_LCD_DATA00__GPIO3_IO05            0x400000b0
+			>;
+		};
+
+		pinctrl_pwm_digital_input_ref: pwm-digital-input-refgrp {
+			fsl,pins = <
+				MX6UL_PAD_GPIO1_IO09__PWM2_OUT              0xb0
+			>;
+		};
+
+		pinctrl_pwm_fan: pwm-fangrp {
+			fsl,pins = <
+				MX6UL_PAD_JTAG_TCK__PWM7_OUT                0x60a0
+			>;
+		};
+
+		pinctrl_pwm_cp: pinctrl-pwm-cpgrp {
+			fsl,pins = <
+				MX6UL_PAD_JTAG_TRST_B__PWM8_OUT             0x60a0
+			>;
+		};
+
+		pinctrl_rs485_1: rs485-1grp {
+			fsl,pins = <
+				MX6UL_PAD_UART1_CTS_B__GPIO1_IO18           0xb0
+				MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX       0xb0
+				MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX       0xb0
+			>;
+		};
+
+		pinctrl_rs485_2: rs485-2grp {
+			fsl,pins = <
+				MX6UL_PAD_CSI_DATA03__GPIO4_IO24            0x10b0
+				MX6UL_PAD_CSI_DATA01__UART5_DCE_RX          0x10b0
+				MX6UL_PAD_CSI_DATA00__UART5_DCE_TX          0x10b0
+			>;
+		};
+
+		pinctrl_stm32: stm32grp {
+			fsl,pins = <
+				MX6UL_PAD_ENET2_RX_DATA1__UART6_DCE_RX      0x10b0
+				MX6UL_PAD_ENET2_RX_DATA0__UART6_DCE_TX      0x10b0
+			>;
+		};
+
+		pinctrl_ext_uart: ext-uartgrp {
+			fsl,pins = <
+				MX6UL_PAD_ENET2_TX_DATA0__UART7_DCE_RX      0xb0
+				MX6UL_PAD_ENET2_RX_EN__UART7_DCE_TX         0xb0
+			>;
+		};
+
+		pinctrl_i2c4: i2c4grp {
+			fsl,pins = <
+				MX6UL_PAD_UART2_RX_DATA__I2C4_SDA           0x400008b0
+				MX6UL_PAD_UART2_TX_DATA__I2C4_SCL           0x400008b0
+			>;
+		};
+
+		pinctrl_i2c4_gpio: i2c4-gpiogrp {
+			fsl,pins = <
+				MX6UL_PAD_UART2_RX_DATA__GPIO1_IO21         0x400008b0
+				MX6UL_PAD_UART2_TX_DATA__GPIO1_IO20         0x400008b0
+			>;
+		};
+
+		pinctrl_ecspi2: ecspi2grp {
+			fsl,pins = <
+				MX6UL_PAD_UART4_RX_DATA__GPIO1_IO29         0x10b0
+				MX6UL_PAD_LCD_HSYNC__GPIO3_IO02             0xb0
+				MX6UL_PAD_LCD_RESET__GPIO3_IO04             0xb0
+				MX6UL_PAD_UART4_TX_DATA__ECSPI2_SCLK        0x10b0
+				MX6UL_PAD_UART5_RX_DATA__ECSPI2_MISO        0x10b0
+				MX6UL_PAD_UART5_TX_DATA__ECSPI2_MOSI        0x10b0
+			>;
+		};
+
+		pinctrl_qca700x_cp_int: qca700x-cp-intgrp {
+			fsl,pins = <
+				MX6UL_PAD_SD1_DATA1__GPIO2_IO19             0x10b0
+			>;
+		};
+
+		pinctrl_qca700x_cp_rst: qca700x-cp-rstgrp {
+			fsl,pins = <
+				MX6UL_PAD_LCD_DATA12__GPIO3_IO17            0x400000b0
+			>;
+		};
+
+		pinctrl_qca700x_cp_btld: qca700x-cp-btldgrp {
+			fsl,pins = <
+				MX6UL_PAD_LCD_DATA13__GPIO3_IO18            0x400000b0
+			>;
+		};
+
+		pinctrl_qca700x_mains_spi: qca700x-mains-spigrp {
+			fsl,pins = <
+				MX6UL_PAD_ENET2_RX_ER__GPIO2_IO15           0x10b0
+				MX6UL_PAD_ENET2_TX_DATA1__ECSPI4_SCLK       0x10b0
+				MX6UL_PAD_ENET2_TX_CLK__ECSPI4_MISO         0x10b0
+				MX6UL_PAD_ENET2_TX_EN__ECSPI4_MOSI          0x10b0
+			>;
+		};
+
+		pinctrl_qca700x_mains_btld: qca700x-mains-btldgrp {
+			fsl,pins = <
+				MX6UL_PAD_LCD_DATA11__GPIO3_IO16            0x400000b0
+			>;
+		};
+
+		pinctrl_uart4: uart4grp {
+			fsl,pins = <
+				MX6UL_PAD_LCD_CLK__UART4_DTE_RX             0xb0
+				MX6UL_PAD_LCD_ENABLE__UART4_DTE_TX          0xb0
+			>;
+		};
+
+		pinctrl_digital_input: digital-inputgrp {
+			fsl,pins = <
+				MX6UL_PAD_CSI_DATA04__GPIO4_IO25            0xb0
+				MX6UL_PAD_CSI_DATA05__GPIO4_IO26            0xb0
+				MX6UL_PAD_CSI_DATA07__GPIO4_IO28            0xb0
+				MX6UL_PAD_CSI_DATA06__GPIO4_IO27            0xb0
+				MX6UL_PAD_CSI_HSYNC__GPIO4_IO20             0xb0
+				MX6UL_PAD_CSI_DATA02__GPIO4_IO23            0xb0
+			>;
+		};
+
+		pinctrl_board_var: board-vargrp {
+			fsl,pins = <
+				MX6UL_PAD_NAND_CLE__GPIO4_IO15              0xb0
+				MX6UL_PAD_NAND_CE0_B__GPIO4_IO13            0xb0
+				MX6UL_PAD_NAND_CE1_B__GPIO4_IO14            0xb0
+				MX6UL_PAD_NAND_DQS__GPIO4_IO16              0xb0
+			>;
+		};
+
+		pinctrl_pmic: pmicgrp {
+			fsl,pins = <
+				MX6UL_PAD_GPIO1_IO08__USDHC2_VSELECT        0x70b1
+				MX6UL_PAD_CSI_VSYNC__GPIO4_IO19             0xb0
+			>;
+		};
+
+		pinctrl_digital_output: digital-outputgrp {
+			fsl,pins = <
+				MX6UL_PAD_LCD_DATA15__GPIO3_IO20            0x400000b0
+				MX6UL_PAD_LCD_DATA16__GPIO3_IO21            0x400000b0
+				MX6UL_PAD_LCD_DATA17__GPIO3_IO22            0x400000b0
+				MX6UL_PAD_LCD_DATA18__GPIO3_IO23            0x400000b0
+				MX6UL_PAD_LCD_DATA19__GPIO3_IO24            0x400000b0
+				MX6UL_PAD_LCD_DATA20__GPIO3_IO25            0x400000b0
+			>;
+		};
+
+		pinctrl_usdhc2: usdhc2grp {
+			fsl,pins = <
+				MX6UL_PAD_NAND_RE_B__USDHC2_CLK             0x7071
+				MX6UL_PAD_NAND_WE_B__USDHC2_CMD             0x7071
+				MX6UL_PAD_NAND_DATA00__USDHC2_DATA0         0x7071
+				MX6UL_PAD_NAND_DATA01__USDHC2_DATA1         0x7071
+				MX6UL_PAD_NAND_DATA02__USDHC2_DATA2         0x7071
+				MX6UL_PAD_NAND_DATA03__USDHC2_DATA3         0x7071
+				MX6UL_PAD_NAND_DATA04__USDHC2_DATA4         0x7071
+				MX6UL_PAD_NAND_DATA05__USDHC2_DATA5         0x7071
+				MX6UL_PAD_NAND_DATA06__USDHC2_DATA6         0x7071
+				MX6UL_PAD_NAND_DATA07__USDHC2_DATA7         0x7071
+			>;
+		};
+
+		pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+			fsl,pins = <
+				MX6UL_PAD_NAND_RE_B__USDHC2_CLK             0x70b1
+				MX6UL_PAD_NAND_WE_B__USDHC2_CMD             0x70b1
+				MX6UL_PAD_NAND_DATA00__USDHC2_DATA0         0x70b1
+				MX6UL_PAD_NAND_DATA01__USDHC2_DATA1         0x70b1
+				MX6UL_PAD_NAND_DATA02__USDHC2_DATA2         0x70b1
+				MX6UL_PAD_NAND_DATA03__USDHC2_DATA3         0x70b1
+				MX6UL_PAD_NAND_DATA04__USDHC2_DATA4         0x70b1
+				MX6UL_PAD_NAND_DATA05__USDHC2_DATA5         0x70b1
+				MX6UL_PAD_NAND_DATA06__USDHC2_DATA6         0x70b1
+				MX6UL_PAD_NAND_DATA07__USDHC2_DATA7         0x70b1
+			>;
+		};
+
+		pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+			fsl,pins = <
+				MX6UL_PAD_NAND_RE_B__USDHC2_CLK             0x70f1
+				MX6UL_PAD_NAND_WE_B__USDHC2_CMD             0x70f1
+				MX6UL_PAD_NAND_DATA00__USDHC2_DATA0         0x70f1
+				MX6UL_PAD_NAND_DATA01__USDHC2_DATA1         0x70f1
+				MX6UL_PAD_NAND_DATA02__USDHC2_DATA2         0x70f1
+				MX6UL_PAD_NAND_DATA03__USDHC2_DATA3         0x70f1
+				MX6UL_PAD_NAND_DATA04__USDHC2_DATA4         0x70f1
+				MX6UL_PAD_NAND_DATA05__USDHC2_DATA5         0x70f1
+				MX6UL_PAD_NAND_DATA06__USDHC2_DATA6         0x70f1
+				MX6UL_PAD_NAND_DATA07__USDHC2_DATA7         0x70f1
+			>;
+		};
+
+		pinctrl_emmc_rst: emmc-rstgrp {
+			fsl,pins = <
+				MX6UL_PAD_NAND_ALE__GPIO4_IO10              0x400010b0
+			>;
+		};
+
+		pinctrl_rotary_switch1: rotary-switch1grp {
+			fsl,pins = <
+				MX6UL_PAD_UART2_CTS_B__GPIO1_IO22           0xb0
+				MX6UL_PAD_UART2_RTS_B__GPIO1_IO23           0xb0
+				MX6UL_PAD_UART3_TX_DATA__GPIO1_IO24         0xb0
+			>;
+		};
+
+		pinctrl_rotary_switch2: rotary-switch2grp {
+			fsl,pins = <
+				MX6UL_PAD_CSI_PIXCLK__GPIO4_IO18            0xb0
+				MX6UL_PAD_LCD_DATA23__GPIO3_IO28            0xb0
+				MX6UL_PAD_LCD_DATA22__GPIO3_IO27            0xb0
+				MX6UL_PAD_LCD_DATA21__GPIO3_IO26            0xb0
+			>;
+		};
+
+		pinctrl_wdog2: wdoggrp {
+			fsl,pins = <
+				MX6UL_PAD_LCD_VSYNC__WDOG2_WDOG_B           0x10b0
+			>;
+		};
+
+		pinctrl_hog_pins: hog-pinsgrp {
+			fsl,pins = <
+				MX6UL_PAD_LCD_DATA07__GPIO3_IO12            0x400000b0
+				MX6UL_PAD_LCD_DATA08__GPIO3_IO13            0x400000b0
+				MX6UL_PAD_JTAG_TDI__GPIO1_IO13              0x400070a0
+				MX6UL_PAD_LCD_DATA05__GPIO3_IO10            0x400000b0
+				MX6UL_PAD_LCD_DATA06__GPIO3_IO11            0x400000b0
+			>;
+		};
+	};
+};
+
+&iomuxc_snvs {
+	pinctrl-names = "default_snvs";
+	pinctrl-0 = <&pinctrl_cp_peak_snvs
+		     &pinctrl_gpio_motor_snvs
+		     &pinctrl_rotary_switch1_snvs
+		     &pinctrl_relay_sense_snvs>;
+
+	tarragon {
+		pinctrl_cp_peak_snvs: cp-peak-snvsgrp {
+			fsl,pins = <
+				MX6ULL_PAD_BOOT_MODE0__GPIO5_IO10           0x400010b0
+				MX6ULL_PAD_BOOT_MODE1__GPIO5_IO11           0x400010b0
+			>;
+		};
+
+		pinctrl_gpio_motor_snvs: gpio-motor-snvsgrp {
+			fsl,pins = <
+				MX6ULL_PAD_SNVS_TAMPER8__GPIO5_IO08         0x400000b0
+			>;
+		};
+
+		pinctrl_enet1_phy_rst: enet1-phy-rstgrp {
+			fsl,pins = <
+				MX6ULL_PAD_SNVS_TAMPER6__GPIO5_IO06         0x400010b0
+			>;
+		};
+
+		pinctrl_qca700x_mains_rst: qca700x-mains-rstgrp {
+			fsl,pins = <
+				MX6ULL_PAD_SNVS_TAMPER7__GPIO5_IO07         0x400000b0
+			>;
+		};
+
+		pinctrl_qca700x_mains_int: qca700x-mains-intgrp {
+			fsl,pins = <
+				MX6ULL_PAD_SNVS_TAMPER9__GPIO5_IO09         0x10b0
+			>;
+		};
+
+		pinctrl_fan_sense_snvs: fan-sense-snvsgrp {
+			fsl,pins = <
+				MX6ULL_PAD_SNVS_TAMPER1__GPIO5_IO01         0x100a0
+			>;
+		};
+
+		pinctrl_accelerometer_int1_snvs: accelerometer-int1-snvsgrp {
+			fsl,pins = <
+				MX6ULL_PAD_SNVS_TAMPER5__GPIO5_IO05         0x10b0
+			>;
+		};
+
+		pinctrl_relay_sense_snvs: relay-sense-snvsgrp {
+			fsl,pins = <
+				MX6ULL_PAD_SNVS_TAMPER3__GPIO5_IO03         0x100a0
+				MX6ULL_PAD_SNVS_TAMPER2__GPIO5_IO02         0x100a0
+			>;
+		};
+
+		pinctrl_rotary_switch1_snvs: rotary-switch1-snvsgrp {
+			fsl,pins = <
+				MX6ULL_PAD_SNVS_TAMPER0__GPIO5_IO00         0xb0
+			>;
+		};
+	};
+};
+
+&pwm2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm_digital_input_ref>;
+	status = "okay";
+};
+
+&pwm8 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm_cp>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rs485_1>;
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+	fsl,dte-mode;
+	status = "okay";
+};
+
+&uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rs485_2>;
+};
+
+&uart6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_stm32>;
+	status = "okay";
+};
+
+&uart7 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ext_uart>;
+	status = "okay";
+};
+
+&usbotg1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb
+		     &pinctrl_usb_pwr>;
+	dr_mode = "host";
+	power-active-high;
+	disable-over-current;
+	status = "okay";
+};
+
+&usbotg2 {
+	dr_mode = "host";
+	disable-over-current;
+	status = "okay";
+};
+
+&usbphy1 {
+	fsl,tx-cal-45-dn-ohms = <35>;
+	fsl,tx-cal-45-dp-ohms = <35>;
+};
+
+&usbphy2 {
+	fsl,tx-cal-45-dn-ohms = <35>;
+	fsl,tx-cal-45-dp-ohms = <35>;
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
+	vmmc-supply = <&sw2_reg>;
+	vqmmc-supply = <&reg_1v8>;
+	mmc-pwrseq = <&emmc_pwrseq>;
+	bus-width = <8>;
+	broken-cd;
+	non-removable;
+	status = "okay";
+};
+
+&wdog1 {
+	status = "disabled";
+};
+
+&wdog2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog2>;
+	fsl,ext-reset-output;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6ull-tarragon-master.dts b/arch/arm/boot/dts/imx6ull-tarragon-master.dts
new file mode 100644
index 000000000000..67007ce383e3
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-tarragon-master.dts
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+//
+// Copyright (C) 2023 chargebyte GmbH
+
+#include "imx6ull-tarragon-common.dtsi"
+
+/ {
+	model = "chargebyte Tarragon Master";
+	compatible = "chargebyte,imx6ull-tarragon-master", "fsl,imx6ull";
+
+	fan0: pwm-fan {
+		compatible = "pwm-fan";
+		pwms = <&pwm7 0 40000 PWM_POLARITY_INVERTED>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_fan_sense_snvs>;
+		fan-supply = <&reg_fan>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+	};
+
+	reg_fan: regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "fan-supply";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_fan_enable>;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		gpio = <&gpio3 5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-boot-on;
+	};
+};
+
+&ecspi2 {
+	status = "okay";
+
+	qca700x_cp: ethernet@0 {
+		reg = <0x0>;
+		compatible = "qca,qca7000";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_qca700x_cp_int
+			     &pinctrl_qca700x_cp_rst
+			     &pinctrl_qca700x_cp_btld>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <19 IRQ_TYPE_EDGE_RISING>;
+		spi-cpha;
+		spi-cpol;
+		spi-max-frequency = <16000000>;
+	};
+};
+
+&ecspi4 {
+	status = "okay";
+
+	qca700x_mains: ethernet@0 {
+		reg = <0x0>;
+		compatible = "qca,qca7000";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_qca700x_mains_int
+			     &pinctrl_qca700x_mains_rst
+			     &pinctrl_qca700x_mains_btld>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <9 IRQ_TYPE_EDGE_RISING>;
+		spi-cpha;
+		spi-cpol;
+		spi-max-frequency = <16000000>;
+	};
+};
+
+&fec1 {
+	status = "okay";
+};
+
+&pwm7 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm_fan>;
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6ull-tarragon-micro.dts b/arch/arm/boot/dts/imx6ull-tarragon-micro.dts
new file mode 100644
index 000000000000..e471c2005bee
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-tarragon-micro.dts
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+//
+// Copyright (C) 2023 chargebyte GmbH
+
+#include "imx6ull-tarragon-common.dtsi"
+
+/ {
+	model = "chargebyte Tarragon Micro";
+	compatible = "chargebyte,imx6ull-tarragon-micro", "fsl,imx6ull";
+};
diff --git a/arch/arm/boot/dts/imx6ull-tarragon-slave.dts b/arch/arm/boot/dts/imx6ull-tarragon-slave.dts
new file mode 100644
index 000000000000..cee223b5f8e1
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-tarragon-slave.dts
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+//
+// Copyright (C) 2023 chargebyte GmbH
+
+#include "imx6ull-tarragon-common.dtsi"
+
+/ {
+	model = "chargebyte Tarragon Slave";
+	compatible = "chargebyte,imx6ull-tarragon-slave", "fsl,imx6ull";
+};
+
+&ecspi2 {
+	status = "okay";
+
+	qca700x_cp: ethernet@0 {
+		reg = <0x0>;
+		compatible = "qca,qca7000";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_qca700x_cp_int
+			     &pinctrl_qca700x_cp_rst
+			     &pinctrl_qca700x_cp_btld>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <19 IRQ_TYPE_EDGE_RISING>;
+		spi-cpha;
+		spi-cpol;
+		spi-max-frequency = <16000000>;
+	};
+};
+
+&fec1 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6ull-tarragon-slavext.dts b/arch/arm/boot/dts/imx6ull-tarragon-slavext.dts
new file mode 100644
index 000000000000..7fd53b7a4372
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-tarragon-slavext.dts
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+//
+// Copyright (C) 2023 chargebyte GmbH
+
+#include "imx6ull-tarragon-common.dtsi"
+
+/ {
+	model = "chargebyte Tarragon SlaveXT";
+	compatible = "chargebyte,imx6ull-tarragon-slavext", "fsl,imx6ull";
+
+	fan0: pwm-fan {
+		compatible = "pwm-fan";
+		pwms = <&pwm7 0 40000 PWM_POLARITY_INVERTED>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_fan_sense_snvs>;
+		fan-supply = <&reg_fan>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+	};
+
+	reg_fan: regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "fan-supply";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_fan_enable>;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		gpio = <&gpio3 5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-boot-on;
+	};
+};
+
+&ecspi2 {
+	status = "okay";
+
+	qca700x_cp: ethernet@0 {
+		reg = <0x0>;
+		compatible = "qca,qca7000";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_qca700x_cp_int
+			     &pinctrl_qca700x_cp_rst
+			     &pinctrl_qca700x_cp_btld>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <19 IRQ_TYPE_EDGE_RISING>;
+		spi-cpha;
+		spi-cpol;
+		spi-max-frequency = <16000000>;
+	};
+};
+
+&fec1 {
+	status = "okay";
+};
+
+&pwm7 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm_fan>;
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
-- 
2.34.1

