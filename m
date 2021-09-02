Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08903FF697
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 23:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347795AbhIBVyW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Sep 2021 17:54:22 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:40643 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347444AbhIBVyP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 17:54:15 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id E359B240005;
        Thu,  2 Sep 2021 21:53:13 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 45/46] ARM: dts: am43xx: Describe the magnetic reader/ADC1 hardware module
Date:   Thu,  2 Sep 2021 23:51:43 +0200
Message-Id: <20210902215144.507243-46-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210902215144.507243-1-miquel.raynal@bootlin.com>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This hardware module is close to the am33xx ADC module but instead of
featuring a touchscreen it has a magnetic reader capability.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm/boot/dts/am437x-l4.dtsi     | 31 ++++++++++++++++++++++++++--
 arch/arm/boot/dts/am43xx-clocks.dtsi |  7 +++++++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-l4.dtsi b/arch/arm/boot/dts/am437x-l4.dtsi
index 370c4e64676f..7a3dcfc7bfc9 100644
--- a/arch/arm/boot/dts/am437x-l4.dtsi
+++ b/arch/arm/boot/dts/am437x-l4.dtsi
@@ -2350,11 +2350,38 @@ hdq: hdq@0 {
 		};
 
 		target-module@4c000 {			/* 0x4834c000, ap 114 72.0 */
-			compatible = "ti,sysc";
-			status = "disabled";
+			compatible = "ti,sysc-omap4", "ti,sysc";
+			reg = <0x4c000 0x4>,
+			      <0x4c010 0x4>;
+			reg-names = "rev", "sysc";
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			clocks = <&l3s_clkctrl AM4_L3S_ADC1_CLKCTRL 0>;
+			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x4c000 0x2000>;
+
+			magadc: magadc@0 {
+				compatible = "ti,am4372-magadc";
+				reg = <0x0 0x2000>;
+				interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&adc_mag_fck>;
+				clock-names = "fck";
+				dmas = <&edma 54 0>, <&edma 55 0>;;
+				dma-names = "fifo0", "fifo1";
+				status = "disabled";
+
+				mag {
+					compatible = "ti,am4372-mag";
+				};
+
+				adc {
+					#io-channel-cells = <1>;
+					compatible ="ti,am4372-adc";
+				};
+			};
 		};
 
 		target-module@80000 {			/* 0x48380000, ap 123 42.0 */
diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/am43xx-clocks.dtsi
index c726cd8dbdf1..59b1f592a743 100644
--- a/arch/arm/boot/dts/am43xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
@@ -444,6 +444,13 @@ wdt1_fck: wdt1_fck@422c {
 		reg = <0x422c>;
 	};
 
+	adc_mag_fck: adc_mag_fck@424c {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&sys_clkin_ck>, <&dpll_per_m2_ck>;
+		reg = <0x424c>;
+	};
+
 	l3_gclk: l3_gclk {
 		#clock-cells = <0>;
 		compatible = "fixed-factor-clock";
-- 
2.27.0

