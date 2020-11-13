Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2922D2B26C1
	for <lists+linux-iio@lfdr.de>; Fri, 13 Nov 2020 22:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgKMV3N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Nov 2020 16:29:13 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:52620 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgKMV3M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Nov 2020 16:29:12 -0500
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 4B00A3ACF5C
        for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2020 21:27:35 +0000 (UTC)
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 98D0AC0004;
        Fri, 13 Nov 2020 21:27:08 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 9/9] ARM: dts: at91: remove deprecated ADC properties
Date:   Fri, 13 Nov 2020 22:26:50 +0100
Message-Id: <20201113212650.507680-10-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201113212650.507680-1-alexandre.belloni@bootlin.com>
References: <20201113212650.507680-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

atmel,adc-res, atmel,adc-res-names and the trigger nodes are not parsed by
the driver anymore and the information is now defined in the driver data.

Also remove the leftover #address-cells and #size-cells that were used when
the trigger nodes had a unit-address.

Finally, the default is already to use the highest resoution. Remove
atmel,adc-use-res from the SoC dtsi.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/boot/dts/at91sam9260.dtsi | 25 -------------------------
 arch/arm/boot/dts/at91sam9g45.dtsi | 27 ---------------------------
 arch/arm/boot/dts/at91sam9rl.dtsi  | 25 -------------------------
 arch/arm/boot/dts/at91sam9x5.dtsi  | 28 ----------------------------
 arch/arm/boot/dts/sama5d3.dtsi     | 22 ----------------------
 arch/arm/boot/dts/sama5d4.dtsi     | 22 ----------------------
 6 files changed, 149 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 82c5d7fd9811..019f1c3d4d30 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -697,8 +697,6 @@ spi1: spi@fffcc000 {
 			};
 
 			adc0: adc@fffe0000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
 				compatible = "atmel,at91sam9260-adc";
 				reg = <0xfffe0000 0x100>;
 				interrupts = <5 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -708,29 +706,6 @@ adc0: adc@fffe0000 {
 				atmel,adc-channels-used = <0xf>;
 				atmel,adc-vref = <3300>;
 				atmel,adc-startup-time = <15>;
-				atmel,adc-res = <8 10>;
-				atmel,adc-res-names = "lowres", "highres";
-				atmel,adc-use-res = "highres";
-
-				trigger0 {
-					trigger-name = "timer-counter-0";
-					trigger-value = <0x1>;
-				};
-				trigger1 {
-					trigger-name = "timer-counter-1";
-					trigger-value = <0x3>;
-				};
-
-				trigger2 {
-					trigger-name = "timer-counter-2";
-					trigger-value = <0x5>;
-				};
-
-				trigger3 {
-					trigger-name = "external";
-					trigger-value = <0xd>;
-					trigger-external;
-				};
 			};
 
 			rtc@fffffd20 {
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 19fc748a87c5..2ab730fd6472 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -812,8 +812,6 @@ ac97: sound@fffac000 {
 			};
 
 			adc0: adc@fffb0000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
 				compatible = "atmel,at91sam9g45-adc";
 				reg = <0xfffb0000 0x100>;
 				interrupts = <20 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -822,31 +820,6 @@ adc0: adc@fffb0000 {
 				atmel,adc-channels-used = <0xff>;
 				atmel,adc-vref = <3300>;
 				atmel,adc-startup-time = <40>;
-				atmel,adc-res = <8 10>;
-				atmel,adc-res-names = "lowres", "highres";
-				atmel,adc-use-res = "highres";
-
-				trigger0 {
-					trigger-name = "external-rising";
-					trigger-value = <0x1>;
-					trigger-external;
-				};
-				trigger1 {
-					trigger-name = "external-falling";
-					trigger-value = <0x2>;
-					trigger-external;
-				};
-
-				trigger2 {
-					trigger-name = "external-any";
-					trigger-value = <0x3>;
-					trigger-external;
-				};
-
-				trigger3 {
-					trigger-name = "continuous";
-					trigger-value = <0x6>;
-				};
 			};
 
 			isi@fffb4000 {
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index 5653e70c84b4..730d1182c73e 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -266,8 +266,6 @@ spi0: spi@fffcc000 {
 			};
 
 			adc0: adc@fffd0000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
 				compatible = "atmel,at91sam9rl-adc";
 				reg = <0xfffd0000 0x100>;
 				interrupts = <20 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -277,29 +275,6 @@ adc0: adc@fffd0000 {
 				atmel,adc-channels-used = <0x3f>;
 				atmel,adc-vref = <3300>;
 				atmel,adc-startup-time = <40>;
-				atmel,adc-res = <8 10>;
-				atmel,adc-res-names = "lowres", "highres";
-				atmel,adc-use-res = "highres";
-
-				trigger0 {
-					trigger-name = "timer-counter-0";
-					trigger-value = <0x1>;
-				};
-				trigger1 {
-					trigger-name = "timer-counter-1";
-					trigger-value = <0x3>;
-				};
-
-				trigger2 {
-					trigger-name = "timer-counter-2";
-					trigger-value = <0x5>;
-				};
-
-				trigger3 {
-					trigger-name = "external";
-					trigger-value = <0x13>;
-					trigger-external;
-				};
 			};
 
 			usb0: gadget@fffd4000 {
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 4cdb05079cc7..395e883644cd 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -795,8 +795,6 @@ uart1: serial@f8044000 {
 			};
 
 			adc0: adc@f804c000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
 				compatible = "atmel,at91sam9x5-adc";
 				reg = <0xf804c000 0x100>;
 				interrupts = <19 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -808,32 +806,6 @@ adc0: adc@f804c000 {
 				atmel,adc-vref = <3300>;
 				atmel,adc-startup-time = <40>;
 				atmel,adc-sample-hold-time = <11>;
-				atmel,adc-res = <8 10>;
-				atmel,adc-res-names = "lowres", "highres";
-				atmel,adc-use-res = "highres";
-
-				trigger0 {
-					trigger-name = "external-rising";
-					trigger-value = <0x1>;
-					trigger-external;
-				};
-
-				trigger1 {
-					trigger-name = "external-falling";
-					trigger-value = <0x2>;
-					trigger-external;
-				};
-
-				trigger2 {
-					trigger-name = "external-any";
-					trigger-value = <0x3>;
-					trigger-external;
-				};
-
-				trigger3 {
-					trigger-name = "continuous";
-					trigger-value = <0x6>;
-				};
 			};
 
 			spi0: spi@f0000000 {
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index e0807b723533..7c979652f330 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -305,8 +305,6 @@ ssc1: ssc@f800c000 {
 			};
 
 			adc0: adc@f8018000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
 				compatible = "atmel,sama5d3-adc";
 				reg = <0xf8018000 0x100>;
 				interrupts = <29 IRQ_TYPE_LEVEL_HIGH 5>;
@@ -335,26 +333,6 @@ &pinctrl_adc0_ad11
 				atmel,adc-vref = <3000>;
 				atmel,adc-sample-hold-time = <11>;
 				status = "disabled";
-
-				trigger0 {
-					trigger-name = "external-rising";
-					trigger-value = <0x1>;
-					trigger-external;
-				};
-				trigger1 {
-					trigger-name = "external-falling";
-					trigger-value = <0x2>;
-					trigger-external;
-				};
-				trigger2 {
-					trigger-name = "external-any";
-					trigger-value = <0x3>;
-					trigger-external;
-				};
-				trigger3 {
-					trigger-name = "continuous";
-					trigger-value = <0x6>;
-				};
 			};
 
 			i2c2: i2c@f801c000 {
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 04f24cf752d3..05c55875835d 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -661,31 +661,9 @@ adc0: adc@fc034000 {
 				atmel,adc-startup-time = <40>;
 				atmel,adc-use-external-triggers;
 				atmel,adc-vref = <3000>;
-				atmel,adc-res = <8 10>;
 				atmel,adc-sample-hold-time = <11>;
-				atmel,adc-res-names = "lowres", "highres";
 				atmel,adc-ts-pressure-threshold = <10000>;
 				status = "disabled";
-
-				trigger0 {
-					trigger-name = "external-rising";
-					trigger-value = <0x1>;
-					trigger-external;
-				};
-				trigger1 {
-					trigger-name = "external-falling";
-					trigger-value = <0x2>;
-					trigger-external;
-				};
-				trigger2 {
-					trigger-name = "external-any";
-					trigger-value = <0x3>;
-					trigger-external;
-				};
-				trigger3 {
-					trigger-name = "continuous";
-					trigger-value = <0x6>;
-				};
 			};
 
 			aes@fc044000 {
-- 
2.28.0

