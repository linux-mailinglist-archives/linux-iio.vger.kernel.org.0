Return-Path: <linux-iio+bounces-21258-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E02CAF6457
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 23:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC85D4E3A1E
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 21:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF80241679;
	Wed,  2 Jul 2025 21:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="rwSUEglH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BCF23B616
	for <linux-iio@vger.kernel.org>; Wed,  2 Jul 2025 21:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751492923; cv=none; b=sx4Et9M53Oaq5FZqiSma1ArnxHUUyCebWydLSff6enVr1IlcrgI+qdLPUU8M0UA3WgpE3lZ64weqGi9GdwInz939oHmSgFh1u3Z7ESh/opLwAv6I+dA0FMH77MKL6wDFqEEzJwWF8CNauYIDl7jbbVCDTkFyuWi3muOKF/A6vno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751492923; c=relaxed/simple;
	bh=Ay+jX/XQ+lgyHRaO0A+yg+dqWvhepcP2lGXbEZ+ANbw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BWrqnQv15KPe1hkpNgCI/2qh5oDc44wGPRBz10fytsWKqc+rIvb5HBa0pJDo3mV/UZ7B74rxoKMSPw5tCN6ekdWU+zk8kBb5mO75XvHi327pcrAGcD43BYlsa+JmzG/fE9ghB43vgzF70mICFx48EMYVwXQH8XhU4J79HQiAW2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=rwSUEglH; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 33642 invoked from network); 2 Jul 2025 23:48:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1751492915; bh=FnhMLudv+q/D/hSONBTmJZVo154ineWrRQ/21yucmkM=;
          h=From:To:Subject;
          b=rwSUEglHOPVgT4/GIJwGZNEcF1GJVdBKcJRwuyU/NIAVHU+i9oiuZESyRE3iWDxNl
           j8AFXvIL3d4Isad15BsyOOdhoEQvJphwlfFmdkoVM1RmoW33Kq0VKS2q8v3aMtEMnI
           Wmnr2eMYaNNoFCeGcgxu7gwMsYmeGmRnv8VBOPk0Jp35Dfx9dlNH2hUqWu3h3/TJ6U
           eXH/Q1Li32civ9iShojvR47LYWdB2lYkmr+uUnrnbda5NcU/shWYGZuh2izRRpjbCJ
           v6rnKJ4Ddq9zqbxeZGigWQlt32R1fxY+veqdd+75p6sEYSgau8VM2Yc/PFBU3bYXFC
           YwCiyif19cQ9A==
Received: from 83.5.239.54.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.5.239.54])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <jic23@kernel.org>; 2 Jul 2025 23:48:35 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	olek2@wp.pl,
	zhiyong.tao@mediatek.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 2/2] arm64: dts: mediatek: add thermal sensor support on mt7981
Date: Wed,  2 Jul 2025 23:48:30 +0200
Message-Id: <20250702214830.255898-3-olek2@wp.pl>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702214830.255898-1-olek2@wp.pl>
References: <20250702214830.255898-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: b00664f4f4ac2cf6bacf908830148b39
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [0YOR]                               

The temperature sensor in the MT7981 is same as in the MT7986.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 32 ++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
index 5cbea9cd411f..759b9e8059d9 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
@@ -76,7 +76,7 @@ watchdog: watchdog@1001c000 {
 			#reset-cells = <1>;
 		};
 
-		clock-controller@1001e000 {
+		apmixedsys: clock-controller@1001e000 {
 			compatible = "mediatek,mt7981-apmixedsys";
 			reg = <0 0x1001e000 0 0x1000>;
 			#clock-cells = <1>;
@@ -184,6 +184,32 @@ spi@1100b000 {
 			status = "disabled";
 		};
 
+		thermal@1100c800 {
+			compatible = "mediatek,mt7981-thermal",
+				     "mediatek,mt7986-thermal";
+			reg = <0 0x1100c800 0 0x800>;
+			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&infracfg CLK_INFRA_THERM_CK>,
+				 <&infracfg CLK_INFRA_ADC_26M_CK>;
+			clock-names = "therm", "auxadc";
+			nvmem-cells = <&thermal_calibration>;
+			nvmem-cell-names = "calibration-data";
+			#thermal-sensor-cells = <1>;
+			mediatek,auxadc = <&auxadc>;
+			mediatek,apmixedsys = <&apmixedsys>;
+		};
+
+		auxadc: adc@1100d000 {
+			compatible = "mediatek,mt7981-auxadc",
+				     "mediatek,mt7986-auxadc",
+				     "mediatek,mt7622-auxadc";
+			reg = <0 0x1100d000 0 0x1000>;
+			clocks = <&infracfg CLK_INFRA_ADC_26M_CK>;
+			clock-names = "main";
+			#io-channel-cells = <1>;
+			status = "disabled";
+		};
+
 		pio: pinctrl@11d00000 {
 			compatible = "mediatek,mt7981-pinctrl";
 			reg = <0 0x11d00000 0 0x1000>,
@@ -211,6 +237,10 @@ efuse@11f20000 {
 			reg = <0 0x11f20000 0 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			thermal_calibration: thermal-calib@274 {
+				reg = <0x274 0xc>;
+			};
 		};
 
 		clock-controller@15000000 {
-- 
2.39.5


