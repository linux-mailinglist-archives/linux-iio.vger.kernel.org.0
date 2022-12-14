Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37C664CBB5
	for <lists+linux-iio@lfdr.de>; Wed, 14 Dec 2022 14:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237426AbiLNN6s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Dec 2022 08:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238471AbiLNN6q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Dec 2022 08:58:46 -0500
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FAB20197;
        Wed, 14 Dec 2022 05:58:44 -0800 (PST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 52E3F20180B;
        Wed, 14 Dec 2022 14:58:43 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1BBF1201082;
        Wed, 14 Dec 2022 14:58:43 +0100 (CET)
Received: from local (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D39E0180219B;
        Wed, 14 Dec 2022 21:58:41 +0800 (+08)
From:   haibo.chen@nxp.com
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        haibo.chen@nxp.com
Subject: [PATCH v2 3/3] arm64: dts: imx93: add ADC support
Date:   Wed, 14 Dec 2022 21:35:39 +0800
Message-Id: <1671024939-29322-3-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1671024939-29322-1-git-send-email-haibo.chen@nxp.com>
References: <1671024939-29322-1-git-send-email-haibo.chen@nxp.com>
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
index 5d79663b3b84..d29a8d375aa4 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -266,6 +266,18 @@ anatop: anatop@44480000 {
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
2.34.1

