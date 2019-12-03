Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A18810F8BF
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2019 08:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfLCHcV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Dec 2019 02:32:21 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:60339 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfLCHcU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Dec 2019 02:32:20 -0500
Received: from droid12-sz.software.amlogic (10.28.8.22) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.1591.10; Tue, 3 Dec 2019
 15:32:44 +0800
From:   Xingyu Chen <xingyu.chen@amlogic.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Xingyu Chen <xingyu.chen@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Qianggui Song <qianggui.song@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, <linux-iio@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH] arm64: dts: a1: add saradc controller
Date:   Tue, 3 Dec 2019 15:32:12 +0800
Message-ID: <1575358332-44866-1-git-send-email-xingyu.chen@amlogic.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.28.8.22]
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The saradc controller in Meson-A1 is the same as the Meson-G12 series SoCs,
so we use the same compatible string.

Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>

---
This patch is based on A1 clock patchset at [0].

[0] https://lore.kernel.org/linux-amlogic/20191129144605.182774-1-jian.hu@amlogic.com
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index 7210ad0..cad1756 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -93,6 +93,21 @@
 				clock-names = "xtal", "pclk", "baud";
 				status = "disabled";
 			};
+
+			saradc: adc@2c00 {
+				compatible = "amlogic,meson-g12a-saradc",
+					     "amlogic,meson-saradc";
+				reg = <0x0 0x2c00 0x0 0x48>;
+				#io-channel-cells = <1>;
+				interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&xtal>,
+					 <&clkc_periphs CLKID_SARADC>,
+					 <&clkc_periphs CLKID_SARADC_CLK>,
+					 <&clkc_periphs CLKID_SARADC_SEL>;
+				clock-names = "clkin", "core", "adc_clk",
+					      "adc_sel";
+				status = "disabled";
+			};
 		};
 
 		gic: interrupt-controller@ff901000 {
-- 
2.7.4

