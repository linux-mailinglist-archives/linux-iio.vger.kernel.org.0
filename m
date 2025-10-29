Return-Path: <linux-iio+bounces-25623-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4A9C1B7CD
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 15:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E836F1887B6E
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 14:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E306834B41C;
	Wed, 29 Oct 2025 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="u4f+gfDT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A7C34A793
	for <linux-iio@vger.kernel.org>; Wed, 29 Oct 2025 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749239; cv=none; b=UdMHmP0FvBHwKxQpQUmWvj2iJYUnBIp+UTefHwljusfZEbzleyF3Lj5gWRBn98g/R7iGXnxsr3oLFs0tMy3kEzgrhYlEDcqjJ/AQGZ9GfuAGW9jcl9iKQPCfk56AM+JGNT654PPEX0KfMrdH3nEcxzBF3lbfvkwXZS/flGCR578=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749239; c=relaxed/simple;
	bh=Iq9TOV4FcGWhqql6PtEpR26BCz7j6f4oU9hSvDKk5F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hswAplYu+Xq0pjd6YG26r7zu7HfBv0XD4CEwYGwERM5/m1L4c144yLo17AeJcR3exG+oOxsp1YXWXGu7Kv8hlYT5ZOEzdcNWdXZfEhDcC0mUP6JMWyrAQ1Bv1NL1ccW40bymwELxBNWyx39xZGRbXU4kClZL9TWxLjkmr4MTRv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=u4f+gfDT; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 750034E413CD;
	Wed, 29 Oct 2025 14:47:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4976B606E8;
	Wed, 29 Oct 2025 14:47:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE80F102F24F9;
	Wed, 29 Oct 2025 15:47:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761749235; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=32YjyCAMTifsZOSn5l7Q5VxrAGZMoiALl3BPu6raayM=;
	b=u4f+gfDTXduqu9W7spUIVYKchETYLNw5B2oR8VBj90ITnXSO1Y16cEBeONKQZrDZnfuwqC
	Xv4qm9pYmTJ9OWEoedNtYUhXC+DtjqvhoHc21uqJlxqiLs1DYETffMGNB31fQfVjUMlxMz
	01hHuByXGZu4RlNaEw12qLrg5jx3RdHVswTpVM09T4Kx39xQiMlMxlnib0wiBzREG6kH7E
	t6cnsgah5vuLOjJZNoggroLarmHEc5wJAyMTNwPNmCeWV4IIRIi+feUo5ZNl0gfOQsOaXY
	Y3ivh2xfYVVoThuWA+v7WoguQD8PrbV9vCFSxnGdcfxhjYSG4rsC4PUC7z/wGA==
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
Subject: [PATCH v2 3/4] ARM: dts: renesas: r9a06g032: Add the ADC device
Date: Wed, 29 Oct 2025 15:46:43 +0100
Message-ID: <20251029144644.667561-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029144644.667561-1-herve.codina@bootlin.com>
References: <20251029144644.667561-1-herve.codina@bootlin.com>
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


