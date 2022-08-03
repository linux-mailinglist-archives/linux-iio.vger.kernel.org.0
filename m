Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A355588974
	for <lists+linux-iio@lfdr.de>; Wed,  3 Aug 2022 11:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbiHCJ3V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Aug 2022 05:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237462AbiHCJ3M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Aug 2022 05:29:12 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DB45A15E;
        Wed,  3 Aug 2022 02:29:11 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0E89F1A08B7;
        Wed,  3 Aug 2022 11:29:10 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CAA251A089D;
        Wed,  3 Aug 2022 11:29:09 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 497D9180031A;
        Wed,  3 Aug 2022 17:29:08 +0800 (+08)
From:   haibo.chen@nxp.com
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        haibo.chen@nxp.com
Subject: [PATCH 3/3] arm64: dts: imx93: add ADC support
Date:   Wed,  3 Aug 2022 17:12:27 +0800
Message-Id: <1659517947-11207-3-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1659517947-11207-1-git-send-email-haibo.chen@nxp.com>
References: <1659517947-11207-1-git-send-email-haibo.chen@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Add ADC support for imx93-11x11-evk board.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 12 ++++++++++++
 arch/arm64/boot/dts/freescale/imx93.dtsi          | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 69786c326db0..cab5f4d66bf9 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -15,6 +15,13 @@ chosen {
 		stdout-path = &lpuart1;
 	};
 
+	reg_vref_1v8: regulator-adc-vref {
+		compatible = "regulator-fixed";
+		regulator-name = "vref_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -27,6 +34,11 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 	};
 };
 
+&adc1 {
+	vref-supply = <&reg_vref_1v8>;
+	status = "okay";
+};
+
 &mu1 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index f83a07c7c9b1..78182f3a7942 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -165,6 +165,18 @@ anatop: anatop@44480000 {
 				compatible = "fsl,imx93-anatop", "syscon";
 				reg = <0x44480000 0x10000>;
 			};
+
+			adc1: adc@44530000 {
+				compatible = "nxp,imx93-adc";
+				reg = <0x44530000 0x10000>;
+				interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_ADC1_GATE>;
+				clock-names = "ipg";
+				status = "disabled";
+			};
 		};
 
 		aips2: bus@42000000 {
-- 
2.25.1

