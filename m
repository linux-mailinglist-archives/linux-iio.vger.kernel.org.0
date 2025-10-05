Return-Path: <linux-iio+bounces-24736-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4EBBB95EF
	for <lists+linux-iio@lfdr.de>; Sun, 05 Oct 2025 13:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5EBC3AC543
	for <lists+linux-iio@lfdr.de>; Sun,  5 Oct 2025 11:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285382773CB;
	Sun,  5 Oct 2025 11:15:04 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05581275AFA;
	Sun,  5 Oct 2025 11:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759662903; cv=none; b=tHemRskMAW8CqTDYYrH6VyeW7MtsxYpKlMgPFwBGNKPBOmBHNlpvE4iyS+iED5Fwy4Ur/cOLbRvB2XQMECtZNN5tTakKGFBOcYq3TuqB5Yxu3Yaf82KERuSwCyzgN8tAbQnLOUNu+wl0w/R7K8zokknT/e39dzeYrErih0Y84Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759662903; c=relaxed/simple;
	bh=ujGjY6RglhSnCCR8wWBzsB/sZtCynLq5C9mq7ypzR/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxUE71/Nj0g3daBtW3cCL0Ww/lW39Ng5KkzxlScOOVM233ZOKK4N24bm+QjcvOeaTXaZ1qIfjihx4O0b/rfmPdfRxWnZDM5CqKvrYZvb2ItpoxVhw62dO6ft/wdfZiSpnOodW/A6Mxu8xwwBqhF++vf6SEPzl26TVNN4TGNcX/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: t+KpznjFSgGvMuUALA8+Ig==
X-CSE-MsgGUID: Lo8JF4YtQY++wYiQ1fWmNw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 05 Oct 2025 20:15:01 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.25])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 912B040065D7;
	Sun,  5 Oct 2025 20:14:57 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: 
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/6] arm64: dts: renesas: r9a09g087: Add ADCs support
Date: Sun,  5 Oct 2025 14:13:20 +0300
Message-ID: <20251005111323.804638-5-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251005111323.804638-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251005111323.804638-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Renesas RZ/T2H (R9A09G087) includes three 12-Bit successive
approximation A/D converters, two 4-channel ADCs, and one 15-channel
ADC.

Add support for all of them.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
index 88669868f0ee..53d9266e58ca 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
@@ -666,6 +666,72 @@ gic: interrupt-controller@83000000 {
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
 		};
 
+		adc0: adc@90014000 {
+			compatible = "renesas,r9a09g087-adc", "renesas,r9a09g077-adc";
+			reg = <0 0x90014000 0 0x400>;
+			interrupts = <GIC_SPI 698 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 699 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 700 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 701 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 702 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 851 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 852 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "adi", "gbadi", "gcadi",
+					  "cmpai", "cmpbi", "wcmpm", "wcmpum";
+			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKL>,
+				 <&cpg CPG_MOD 206>;
+			clock-names = "adclk", "pclk";
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+			status = "disabled";
+		};
+
+		adc1: adc@90014400 {
+			compatible = "renesas,r9a09g087-adc", "renesas,r9a09g077-adc";
+			reg = <0 0x90014400 0 0x400>;
+			interrupts = <GIC_SPI 703 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 704 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 705 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 706 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 707 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 853 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 854 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "adi", "gbadi", "gcadi",
+					  "cmpai", "cmpbi", "wcmpm", "wcmpum";
+			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKL>,
+				 <&cpg CPG_MOD 207>;
+			clock-names = "adclk", "pclk";
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+			status = "disabled";
+		};
+
+		adc2: adc@80008000 {
+			compatible = "renesas,r9a09g087-adc", "renesas,r9a09g077-adc";
+			reg = <0 0x80008000 0 0x400>;
+			interrupts = <GIC_SPI 708 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 709 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 710 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 711 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 712 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 855 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 856 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "adi", "gbadi", "gcadi",
+					  "cmpai", "cmpbi", "wcmpm", "wcmpum";
+			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKL>,
+				 <&cpg CPG_MOD 225>;
+			clock-names = "adclk", "pclk";
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+			status = "disabled";
+		};
+
 		ohci: usb@92040000 {
 			compatible = "generic-ohci";
 			reg = <0 0x92040000 0 0x100>;
-- 
2.51.0


