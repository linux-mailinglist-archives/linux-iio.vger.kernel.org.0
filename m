Return-Path: <linux-iio+bounces-25848-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3030C2C5F2
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 15:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5574434A54A
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 14:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F96D30E85B;
	Mon,  3 Nov 2025 14:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qUH30Rqx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9237A31063B
	for <linux-iio@vger.kernel.org>; Mon,  3 Nov 2025 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179585; cv=none; b=KYaZaGD39zs8gRtqvDcHyugAo+mJQBAfG680pS0A+wZfQqaHWQsMc7/lp5d1nXGXTqYvlyUtt2s1MEwoNMyK6I7oXL+qn6Icu/mX/VgSloixduO1RVL9pbA4iWYIeEPZvRKSjOIsHT6poc1SyyrlCZSyeULAgq+EOdmIMcL/srM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179585; c=relaxed/simple;
	bh=Iq9TOV4FcGWhqql6PtEpR26BCz7j6f4oU9hSvDKk5F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUInIYVDFRk8NxZE3bQ5cv17WCB2JNwjT2Gck2L0FSSANP+r1iJCd7vSpXtTnOHpij344wfaM6ndBp6qBCRR+4idPcA0Cm8lsfiP79cHQVSxus4f8zu3DYhfq8UQ41O0bzFq3ej+qfFRg1JRWwzPEYQ1EMKzVW7qeucREurSQ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qUH30Rqx; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 63185C0D7AB;
	Mon,  3 Nov 2025 14:19:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3221560628;
	Mon,  3 Nov 2025 14:19:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6686A10B5011E;
	Mon,  3 Nov 2025 15:19:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762179581; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=32YjyCAMTifsZOSn5l7Q5VxrAGZMoiALl3BPu6raayM=;
	b=qUH30Rqxf6gKxJv6daWGKMfSi/t29GIexoC3CPpoEzBUN+bHVcJFrddf3HUYW67vFZY08f
	ihBzlOM1nTv5ZycqN52zspuJNgMZ8Z8zomdB1PiVnKK6YEbiO7YGMSvbOwVzlPQ7wAvwu1
	h7GNr7yio/+v6f9mZ6I59wkfNy6GeVtyEgkvu/G391Zkhd6h4+WH9m2qBGlsBpAiacF011
	fVLzUEoqR+9qaBxH0iHP5C+nEq7Fm7aIdBB8+tg86T+ClzGYyagr/IuUuRNHouPiDQUxDh
	lO0KLphHf9eCodca5wvEvZ672vKCNb/Vo722+sH/YmqZKMwqoTArOeTYX+WiIw==
From: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pascal Eberhard <pascal.eberhard@se.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 3/4] ARM: dts: renesas: r9a06g032: Add the ADC device
Date: Mon,  3 Nov 2025 15:18:33 +0100
Message-ID: <20251103141834.71677-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103141834.71677-1-herve.codina@bootlin.com>
References: <20251103141834.71677-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The ADC available in the r9a06g032 SoC can use up to two internal ADC
cores (ADC1 and ADC2) those internal cores are handled through ADC
controller virtual channels.

Describe this device.

Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/renesas/r9a06g032.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/renesas/r9a06g032.dtsi b/arch/arm/boot/dts/renesas/r9a06g032.dtsi
index 13a60656b044..2c1577923223 100644
--- a/arch/arm/boot/dts/renesas/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/renesas/r9a06g032.dtsi
@@ -290,6 +290,16 @@ i2c2: i2c@40064000 {
 			status = "disabled";
 		};
 
+		adc: adc@40065000 {
+			compatible = "renesas,r9a06g032-adc", "renesas,rzn1-adc";
+			reg = <0x40065000 0x200>;
+			clocks = <&sysctrl R9A06G032_HCLK_ADC>, <&sysctrl R9A06G032_CLK_ADC>;
+			clock-names = "pclk", "adc";
+			power-domains = <&sysctrl>;
+			#io-channel-cells = <1>;
+			status = "disabled";
+		};
+
 		pinctrl: pinctrl@40067000 {
 			compatible = "renesas,r9a06g032-pinctrl", "renesas,rzn1-pinctrl";
 			reg = <0x40067000 0x1000>, <0x51000000 0x480>;
-- 
2.51.0


