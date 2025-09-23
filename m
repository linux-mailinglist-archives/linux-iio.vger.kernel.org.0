Return-Path: <linux-iio+bounces-24377-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA45B96BE9
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 18:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D07ED16FDA7
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 16:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97352F7ABE;
	Tue, 23 Sep 2025 16:06:34 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F73255F31;
	Tue, 23 Sep 2025 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643594; cv=none; b=hyAZNI8CNbXC69u8bfO7mYWZPvdGNFSTguvjpw7IeK3uix6f17CFFhtA1Jhr7XBW7c83bwIN72FZvg2OpeK9S0W6AhrVbhqBcAK1/Tx6iAEVKWLp6QgAeKyhuG8LqAXHYSEqtUYQZumrbCpGan/3W+NGTcCn2izwraOk+Xd45zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643594; c=relaxed/simple;
	bh=x1yOWnf7BlpJEG8EWYAT2jSSVwYz8D6FZmHjS8CE+Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCNpQd5kvMiSiXaasaolmSbtgdEZz47sy03UfC+4cbnDggQqFcnPPVL8mlmkbn3mq5hIkzeE2aTNc5zRrDMHeI/jqbIqPQ2YXe/Kn4qZaZosuqTcWgznGI0+ZBW7r0+/AIQWy04RXR7nneuUVBuegKcgzXYbLdjDYGL10/mK0k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: g+WV/4OcS0mIeK8LcGHjUg==
X-CSE-MsgGUID: 9N/xtJKaSUy+b3nLRtg+bQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 24 Sep 2025 01:06:31 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.64])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 745BA400C752;
	Wed, 24 Sep 2025 01:06:26 +0900 (JST)
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
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH 5/7] arm64: dts: renesas: r9a09g087: Add ADCs support
Date: Tue, 23 Sep 2025 19:05:19 +0300
Message-ID: <20250923160524.1096720-6-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923160524.1096720-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20250923160524.1096720-1-cosmin-gabriel.tanislav.xa@renesas.com>
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
---
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
index 88669868f0ee..faca2fd47257 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
@@ -666,6 +666,75 @@ gic: interrupt-controller@83000000 {
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
 		};
 
+		adc0: adc@90014000 {
+			compatible = "renesas,r9a09g087-adc";
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
+			renesas,max-channels = <4>;
+			status = "disabled";
+		};
+
+		adc1: adc@90014400 {
+			compatible = "renesas,r9a09g087-adc";
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
+			renesas,max-channels = <4>;
+			status = "disabled";
+		};
+
+		adc2: adc@80008000 {
+			compatible = "renesas,r9a09g087-adc";
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
+			renesas,max-channels = <15>;
+			status = "disabled";
+		};
+
 		ohci: usb@92040000 {
 			compatible = "generic-ohci";
 			reg = <0 0x92040000 0 0x100>;
-- 
2.51.0


