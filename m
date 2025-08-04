Return-Path: <linux-iio+bounces-22279-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B922B19F6E
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 12:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1A6165D2C
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 10:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190772550DD;
	Mon,  4 Aug 2025 10:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="M39levsm"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F102512E6;
	Mon,  4 Aug 2025 10:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754301889; cv=none; b=WnkSLDGBGySFHRaMF1ozQtOwWiyhnr3r2d7keid4JMygCYyA7iFEqN7i2dNww9tsk/UF0NS2a3eu9x5PkpA6en1vZhsn4k+3ClVJDvmWvz2m7swKp2zYavuV8TifRiUa1+Mt82+Vppq6DpWNaU3ob5l9FPWT1ORiYQ76XM3mZsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754301889; c=relaxed/simple;
	bh=0I0mIx+jCtAYkBXL2kVeCEA9sezb9K7m6lEQk5mGw1w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1V/TJ50pwRET2fQ0iaGLr3ZfSXGZvK/NVUdaKej58XtTIzhZEcdmomPf4ahp4AIIpVtpkElY0RnzYTuOLOjMTWoEwoMT7cm3kbK2Jh4MdkC1Agvw3qVIM6YblNBWTGtii6xYANx6BX+CNa0SXvBbLGYbOvJzwbV82IMUrDskiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=M39levsm; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1754301887; x=1785837887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0I0mIx+jCtAYkBXL2kVeCEA9sezb9K7m6lEQk5mGw1w=;
  b=M39levsmX9H+CV2G0mBcxkf5HUwSEsU79h6fZX3jRn70cB/9XZOzIMGh
   Pi3iIVknXGtByHgaFt8TKosld2IX406pYnuavJezbplu3Cqp2BKtu/JfA
   14aFFqI6+W0odJkrn2alxHa0Wwfl0fSn1ekJKY5Tca02bb6N2BaDK2SNh
   OEdxzzbB6Vr/VYWbj/JKInXUt4Nzh+53dYUXikedQrYxuYFbNDgtfGkvW
   q1glv/BM86g9gmTWlUYID6oYjq8xZmUtWAKNt/4GEa/uY1euCRFjrsqSG
   E/IkmXaYHIYS9oOHGyb5lu9lZa0eIEaeI3Wt5dhc9koAtaPcLoOI7woYp
   g==;
X-CSE-ConnectionGUID: wNfd+jCsRiWEXMNUBP5DNg==
X-CSE-MsgGUID: n+pSyMdtR/KhPy3oIEgnMA==
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="212197476"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Aug 2025 03:04:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 4 Aug 2025 03:04:04 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 4 Aug 2025 03:03:58 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <eugen.hristev@linaro.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH 15/15] ARM: dts: microchip: sama7d65: add thermal zones node
Date: Mon, 4 Aug 2025 15:32:19 +0530
Message-ID: <20250804100219.63325-16-varshini.rajendran@microchip.com>
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

Add thermal zones node with its associated trips and cooling-maps.
It uses CPUFreq as cooling device for temperatures in the interval
[90, 100) degrees Celsius and describe the temperature of 100 degrees
Celsius as critical temperature. System will be is shutting down when
reaching critical temperature.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 42 +++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index aefdd72cb59c..a4e5ef6a9cf2 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -16,6 +16,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/mfd/at91-usart.h>
 #include <dt-bindings/nvmem/microchip,sama7g5-otpc.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	model = "Microchip SAMA7D65 family SoC";
@@ -35,6 +36,7 @@ cpu0: cpu@0 {
 			clocks = <&pmc PMC_TYPE_CORE PMC_CPUPLL>;
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>; /* min followed by max */
 		};
 	};
 
@@ -110,6 +112,46 @@ thermal_sensor: thermal-sensor {
 		io-channel-names = "sensor-channel";
 	};
 
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&thermal_sensor>;
+
+			trips {
+				cpu_normal: cpu-alert0 {
+					temperature = <90000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				cpu_hot: cpu-alert1 {
+					temperature = <95000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				cpu_critical: cpu-critical {
+					temperature = <100000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_normal>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+
+				map1 {
+					trip = <&cpu_hot>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		ranges;
-- 
2.34.1


