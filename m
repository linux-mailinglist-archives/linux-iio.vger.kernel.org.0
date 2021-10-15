Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB6A42EBD3
	for <lists+linux-iio@lfdr.de>; Fri, 15 Oct 2021 10:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237392AbhJOITy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Oct 2021 04:19:54 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:37027 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237150AbhJOISR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Oct 2021 04:18:17 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id D25A820007;
        Fri, 15 Oct 2021 08:16:09 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ryan Barnett <ryan.barnett@collins.com>,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH v6 47/48] ARM: dts: am43xx: Describe the magnetic reader/ADC1 hardware module
Date:   Fri, 15 Oct 2021 10:15:05 +0200
Message-Id: <20211015081506.933180-48-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211015081506.933180-1-miquel.raynal@bootlin.com>
References: <20211015081506.933180-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This hardware module is close to the am33xx ADC module but instead of
featuring a touchscreen it has a magnetic reader capability.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/am437x-l4.dtsi     | 31 ++++++++++++++++++++++++++--
 arch/arm/boot/dts/am43xx-clocks.dtsi |  7 +++++++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-l4.dtsi b/arch/arm/boot/dts/am437x-l4.dtsi
index ba58e6b0da1d..8f2268c02778 100644
--- a/arch/arm/boot/dts/am437x-l4.dtsi
+++ b/arch/arm/boot/dts/am437x-l4.dtsi
@@ -2378,11 +2378,38 @@ hdq: hdq@0 {
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
+				dmas = <&edma 54 0>, <&edma 55 0>;
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
index 314fc5975acb..66e892fa3398 100644
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

