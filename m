Return-Path: <linux-iio+bounces-24378-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2033B96BE0
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 18:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75A713B986F
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 16:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEAE3191C8;
	Tue, 23 Sep 2025 16:06:41 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A6F255F31;
	Tue, 23 Sep 2025 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643600; cv=none; b=GJqZsRb8TyZUijE3J3jhpz5KTPeF6PnvPOXsa7MVtgZGwd8Q7CGcuzSzNa3+LH73FRu6QTIKH+DOpCR9JQp/3t22FrLSpYQa2nL2pdQEIBVCkHJ3Q9VgHul8EB4Irkk+1lJ6DZZsQFOtrkEBaJ/Z+2Ft+H9MJqV/20HKjhe+cFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643600; c=relaxed/simple;
	bh=XQ3XKuMVVnlhB58MduVr+0rxBWpHh/TwGzeY/ypNSww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HFKwc46TUInG3aqesWbWPfrdoVGMoPK9TBLvMF1nuqxu0U1ObM1lL1AflAo7YPIkbr8+w9VV12sat+X4L3/Nq3KnlXWKOkO7N7cEwpQRki5BnlX1MKRDTF5t2HbtgLCOTAMx0Vq9DVb39Z7++FFFpW8oruckU8kToarMznADafk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: N4UvnteMQ+S8MeSLsrrAvA==
X-CSE-MsgGUID: UJ/s2eGKTxSiRuTyRZA/9g==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 24 Sep 2025 01:06:38 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.64])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 049D94008A2F;
	Wed, 24 Sep 2025 01:06:32 +0900 (JST)
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
Subject: [PATCH 6/7] arm64: dts: renesas: rzt2h/rzn2h-evk: enable ADCs
Date: Tue, 23 Sep 2025 19:05:20 +0300
Message-ID: <20250923160524.1096720-7-cosmin-gabriel.tanislav.xa@renesas.com>
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

The ADCs on RZ/T2H and RZ/N2H are exposed on the evaluation kit boards.

Enable them.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 .../dts/renesas/r9a09g077m44-rzt2h-evk.dts    | 28 +++++++
 .../dts/renesas/r9a09g087m44-rzn2h-evk.dts    | 64 +++++++++++++++
 .../dts/renesas/rzt2h-n2h-evk-common.dtsi     | 79 +++++++++++++++++++
 3 files changed, 171 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
index 9170c563208a..e94b84393bd9 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
@@ -252,3 +252,31 @@ usb_pins: usb-pins {
 			 <RZT2H_PORT_PINMUX(0, 1, 0x13)>; /* OVRCUR */
 	};
 };
+
+&adc2 {
+	status = "okay";
+
+	channel@0 {
+		reg = <0x0>;
+	};
+
+	channel@1 {
+		reg = <0x1>;
+	};
+
+	channel@2 {
+		reg = <0x2>;
+	};
+
+	channel@3 {
+		reg = <0x3>;
+	};
+
+	channel@4 {
+		reg = <0x4>;
+	};
+
+	channel@5 {
+		reg = <0x5>;
+	};
+};
diff --git a/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
index 279f2510044b..d27da157c6d6 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
@@ -305,3 +305,67 @@ usb_pins: usb-pins {
 			 <RZT2H_PORT_PINMUX(2, 3, 0x13)>; /* OVRCUR */
 	};
 };
+
+&adc2 {
+	status = "okay";
+
+	channel@0 {
+		reg = <0x0>;
+	};
+
+	channel@1 {
+		reg = <0x1>;
+	};
+
+	channel@2 {
+		reg = <0x2>;
+	};
+
+	channel@3 {
+		reg = <0x3>;
+	};
+
+	channel@4 {
+		reg = <0x4>;
+	};
+
+	channel@5 {
+		reg = <0x5>;
+	};
+
+	channel@6 {
+		reg = <0x6>;
+	};
+
+	channel@7 {
+		reg = <0x7>;
+	};
+
+	channel@8 {
+		reg = <0x8>;
+	};
+
+	channel@9 {
+		reg = <0x9>;
+	};
+
+	channel@a {
+		reg = <0xa>;
+	};
+
+	channel@b {
+		reg = <0xb>;
+	};
+
+	channel@c {
+		reg = <0xc>;
+	};
+
+	channel@d {
+		reg = <0xd>;
+	};
+
+	channel@e {
+		reg = <0xe>;
+	};
+};
diff --git a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
index 9ca26725a3e9..a7123a9ec684 100644
--- a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
@@ -338,3 +338,82 @@ &wdt2 {
 	status = "okay";
 	timeout-sec = <60>;
 };
+
+/*
+ * ADC0 AN000 can be connected to a potentiometer on the board or
+ * exposed on ADC header.
+ *
+ * T2H:
+ * SW17[1] = ON, SW17[2] = OFF - Potentiometer
+ * SW17[1] = OFF, SW17[2] = ON  - CN41 header
+ * N2H:
+ * DSW6[1] = OFF, DSW6[2] = ON - Potentiometer
+ * DSW6[1] = ON, DSW6[2] = OFF - CN3 header
+ */
+&adc0 {
+	status = "okay";
+
+	channel@0 {
+		reg = <0x0>;
+	};
+
+	channel@1 {
+		reg = <0x1>;
+	};
+
+	channel@2 {
+		reg = <0x2>;
+	};
+
+	channel@3 {
+		reg = <0x3>;
+	};
+};
+
+/*
+ * ADC1 AN100 can be exposed on ADC header or on mikroBUS connector.
+ *
+ * T2H:
+ * SW18[1] = ON, SW18[2] = OFF - CN42 header
+ * SW18[1] = OFF, SW18[2] = ON - mikroBUS
+ * N2H:
+ * DSW6[3] = ON, DSW6[4] = OFF - CN4 header
+ * DSW6[3] = OFF, DSW6[4] = ON - mikroBUS
+ *
+ * ADC1 AN101 can be exposed on ADC header or on Grove2 connector.
+ *
+ * T2H:
+ * SW18[3] = ON, SW18[4] = OFF - CN42 header
+ * SW18[3] = OFF, SW18[4] = ON - Grove2
+ * N2H:
+ * DSW6[5] = ON, DSW6[6] = OFF - CN4 header
+ * DSW6[5] = OFF, DSW6[6] = ON - Grove2
+ *
+ * ADC1 AN102 can be exposed on ADC header or on Grove2 connector.
+ *
+ * T2H:
+ * SW18[5] = ON, SW18[6] = OFF - CN42 header
+ * SW18[5] = OFF, SW18[6] = ON - Grove2
+ * N2H:
+ * DSW6[7] = ON, DSW6[8] = OFF - CN4 header
+ * DSW6[7] = OFF, DSW6[8] = ON - Grove2
+ */
+&adc1 {
+	status = "okay";
+
+	channel@0 {
+		reg = <0x0>;
+	};
+
+	channel@1 {
+		reg = <0x1>;
+	};
+
+	channel@2 {
+		reg = <0x2>;
+	};
+
+	channel@3 {
+		reg = <0x3>;
+	};
+};
-- 
2.51.0


