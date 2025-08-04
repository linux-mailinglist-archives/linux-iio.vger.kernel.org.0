Return-Path: <linux-iio+bounces-22274-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9DEB19F5D
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 12:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5BC164FB4
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 10:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A9924BC0A;
	Mon,  4 Aug 2025 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="B4sxkIqD"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195292288EE;
	Mon,  4 Aug 2025 10:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754301845; cv=none; b=le+hvjCV2HNpF3W37AsCvMFZgHi5it1FLeUeg6A/5Ky6Y3yzOBUi/vLu2Vood3/Rhsozy7k7kc6hdulCb+XlRtV2ElxsUiSDKbqYokXm1zs8GMNX1r9BgXo4/StweRT9N9w39kz6+qmtLkRMsarbZckxAHsClkyuFBrqna7CWH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754301845; c=relaxed/simple;
	bh=wSwA6wL4bDtKgaXwJ1S3APBLP/C0XSRWfQu/1acFsUE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oopsryDnMKxMDUn3cR8Uoj3BvgFbkzhvZXAVtzyPMcmORDGGvD8NRAVVLaNXdt7FuxSztuG/RV9w9GAZM2g8ybu9P1Cr3Wl9cP19OPJjVwKrno4uHzN0B86mum0mk9CJrLuR594vxxuI/pVfV68h/jPd1ewhTfpUNaAG6cWarwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=B4sxkIqD; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1754301844; x=1785837844;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wSwA6wL4bDtKgaXwJ1S3APBLP/C0XSRWfQu/1acFsUE=;
  b=B4sxkIqDiYwsUdHWrejUNyW37YOH+OIYANqwSegW7cGP84VXTmsfQkpq
   jmsUJy12/ppzP8HZuLY+g6jbDmNvPQ11VSgze6AJc1IpkoIkVzQmOIu2K
   yUbScc+FmnhlrDzWucXUy/JsVquchnRXMRJCNdxnqaxhD55aE1hz/eGON
   1YFqSBEnw75A05FCMVPH99Hs2H/BUt+mUjtEXyYUSOHbA5VgoDe2lpZar
   oQhi+cPgwSBqhwTVBkl7ACaaQI6jX4ruwCmsBkUIGcWF1BHOYDZogdtbj
   uo4WZ6V6vWLPJzaOplxQ4F9kpUtTWCKAvhhqIQcy0dOSHLpp6OHqjkTRl
   A==;
X-CSE-ConnectionGUID: +866aF0tQ+SVcfcIeqWRcg==
X-CSE-MsgGUID: +YCYjADVTiWX8fEDnlqPuA==
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="44245539"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Aug 2025 03:04:02 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 4 Aug 2025 03:03:32 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 4 Aug 2025 03:03:26 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <eugen.hristev@linaro.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Romain Sioen
	<romain.sioen@microchip.com>
Subject: [PATCH 10/15] ARM: dts: microchip: sama7d65: add node for the ADC
Date: Mon, 4 Aug 2025 15:32:14 +0530
Message-ID: <20250804100219.63325-11-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804100219.63325-1-varshini.rajendran@microchip.com>
References: <20250804100219.63325-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add node for the ADC controller in sama7d65 SoC. Also add corresponding
regulator and pinmux for the ADC.

Signed-off-by: Romain Sioen <romain.sioen@microchip.com>
Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 .../dts/microchip/at91-sama7d65_curiosity.dts | 23 +++++++++++++++
 arch/arm/boot/dts/microchip/sama7d65.dtsi     | 29 +++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
index 7250823a6f59..7ecc748456ba 100644
--- a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
@@ -41,6 +41,14 @@ reg_5v: regulator-5v {
 
 };
 
+&adc {
+	vddana-supply = <&vddout25>;
+	vref-supply = <&vddout25>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc_default &pinctrl_adtrg_default>;
+	status = "okay";
+};
+
 &dma0 {
 	status = "okay";
 };
@@ -278,6 +286,16 @@ &main_xtal {
 };
 
 &pioa {
+	pinctrl_adc_default: adc_default {
+		pinmux = <PIN_PC5__GPIO>;
+		bias-disable;
+	};
+
+	pinctrl_adtrg_default: adtrg-default {
+		pinmux = <PIN_PB7__ADTRG>;
+		bias-pull-up;
+	};
+
 	pinctrl_gmac0_default: gmac0-default {
 		pinmux = <PIN_PA26__G0_TX0>,
 			 <PIN_PA27__G0_TX1>,
@@ -373,3 +391,8 @@ input@0 {
 &slow_xtal {
 	clock-frequency = <32768>;
 };
+
+&vddout25 {
+	vin-supply = <&vdd_3v3>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index 2e20a7532c03..1f249323d08a 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/clock/at91.h>
 #include <dt-bindings/dma/at91.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/iio/adc/at91-sama5d2_adc.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/mfd/at91-usart.h>
@@ -83,6 +84,16 @@ slow_xtal: clock-slowxtal {
 		};
 	};
 
+	vddout25: fixed-regulator-vddout25 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VDDOUT25";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
+		regulator-boot-on;
+		status = "disabled";
+	};
+
 	ns_sram: sram@100000 {
 		compatible = "mmio-sram";
 		reg = <0x100000 0x20000>;
@@ -199,6 +210,24 @@ chipid@e0020000 {
 			reg = <0xe0020000 0x8>;
 		};
 
+		adc: adc@e1000000 {
+			compatible = "microchip,sama7d65-adc";
+			reg = <0xe1000000 0x200>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&pmc PMC_TYPE_GCK 25>;
+			assigned-clocks = <&pmc PMC_TYPE_GCK 25>;
+			assigned-clock-rates = <100000000>;
+			clock-names = "adc_clk";
+			dmas = <&dma0 AT91_XDMAC_DT_PERID(0)>;
+			dma-names = "rx";
+			atmel,min-sample-rate-hz = <200000>;
+			atmel,max-sample-rate-hz = <20000000>;
+			atmel,trigger-edge-type = <IRQ_TYPE_EDGE_RISING>;
+			atmel,startup-time-ms = <4>;
+			#io-channel-cells = <1>;
+			status = "disabled";
+		};
+
 		dma2: dma-controller@e1200000 {
 			compatible = "microchip,sama7d65-dma", "microchip,sama7g5-dma";
 			reg = <0xe1200000 0x1000>;
-- 
2.34.1


