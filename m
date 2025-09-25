Return-Path: <linux-iio+bounces-24452-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB11BA1E05
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 00:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 816FF2A6CAC
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 22:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B8D322DC3;
	Thu, 25 Sep 2025 22:41:26 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8136432255F;
	Thu, 25 Sep 2025 22:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758840086; cv=none; b=E5sXHLySKJ+TD8u0KVePh+L52G9HxCYLfx/PwQe6siAKHUoJeT/jId+yS42h4qSC0QsERErA5K3uGXmFh8pNnZssktWyKbKNqwwPG90GdZ5l+ZDg4A8/hiwWniEXfZEmOvBHAbDD+JkBLhIdSPSBh38G6mi57tUI/5n1U1666qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758840086; c=relaxed/simple;
	bh=XQ3XKuMVVnlhB58MduVr+0rxBWpHh/TwGzeY/ypNSww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TuLqRRS7UUhWD+bFVQabwGLUcnw8tZ05cOduZTZVZdAbUxxnGHVmqPFfmJd1lEarIDuc1fmpxljycn0idgvWTpKkrNUp6vEOyOH2aEcgw8KlAj29DpSRMuISwa+AO28XLLwtn7uVvqm0o5mt7IciR7WDBOxdR37zKAydQn9+BtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: UbvgbOxuQkevSeE/LpEPiQ==
X-CSE-MsgGUID: dKA9uqVaTFaETcRXlICIlg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 26 Sep 2025 07:41:23 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.2])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0AB3D400CF0A;
	Fri, 26 Sep 2025 07:41:18 +0900 (JST)
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
Subject: [PATCH v2 6/7] arm64: dts: renesas: rzt2h/rzn2h-evk: enable ADCs
Date: Fri, 26 Sep 2025 01:40:08 +0300
Message-ID: <20250925224013.2146983-7-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925224013.2146983-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20250925224013.2146983-1-cosmin-gabriel.tanislav.xa@renesas.com>
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


