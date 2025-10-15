Return-Path: <linux-iio+bounces-25097-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E31BDF0A1
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 16:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00FBC19C3281
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 14:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC9E280335;
	Wed, 15 Oct 2025 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FpjD/eAH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D0827FD45
	for <linux-iio@vger.kernel.org>; Wed, 15 Oct 2025 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760538609; cv=none; b=YtGlBV9TSKPwZ5hEjlYZQSwthxLevHpeATpkI2Ip+WcMY9pM5EgWvUYJCkh5WhJId9z0pljsBKbHp/aFQkyLhU6jhFUsN/n2mGXJmD54rQ9+2sYLX/0Tptc5bnfMk9z7fJzdH0ahtlULTZV9CZbGcEWWDHzxSHc0zImRmuDzG3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760538609; c=relaxed/simple;
	bh=+74GyJc9+OI2SVGARFkyM2gLYhgmnpB+FeCJMuuSkwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqtPXrtT1xRoBUoddC3dGWir2cyn0vruTYdx0mT7z2N3mkfN+4vkLpcr5lbX8hsvvrg7EYGg4NSxRFWXyO5IYq0JBBGpAdZi6VwKQYBljjH3mAmRHvqJ6gmkpYAKQTgKK/auEaW1YO2SyFZuW5dSyQDg2ypFIsXpQXRpzM/cVzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FpjD/eAH; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6297D4E410D8;
	Wed, 15 Oct 2025 14:30:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 39D23606F9;
	Wed, 15 Oct 2025 14:30:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C32C6102F22BD;
	Wed, 15 Oct 2025 16:30:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760538605; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=1MTlS3wR1Q1h02kAZB6qYeyhSzxbvaTHAjx55R/rBto=;
	b=FpjD/eAHJnsLuu+zsjyVwvMJVbYfaBWlH+izpawdTUD+bMl9PaglfmhfFWOduZfC63t9nx
	Mosj6AK5Fma5syuYvi0JIJrjhTuofsGkGWxZaXxCvR2m8GfXXQeneQxmfxqEq1MBQMnMJC
	GvmZIZ0QH651FzogjMOgp7i4X44bDlzR5sRXbYMXUKXWKukPu1z0dRb7PxqGCHcBsX23I0
	0qt+qM5Z5927aU3W7AeHBsd1xBv2V5DuL2LcZ4XOruljQjqpIL3FlB+AFprP7soBc/Bg5n
	VToqXRkrX/09iAgkuZxuV00zHvv1VYCEZAIHbdsRk9XYyO6Hkq6fVcB8fYQydw==
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
Subject: [PATCH 3/4] ARM: dts: renesas: r9a06g032: Add the ADC device
Date: Wed, 15 Oct 2025 16:28:15 +0200
Message-ID: <20251015142816.1274605-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015142816.1274605-1-herve.codina@bootlin.com>
References: <20251015142816.1274605-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The ADC available in the r9a06g032 SoC can use up to two internal ACD
cores (ADC1 and ADC2) those internal cores are handled through ADC
controller virtual channels.

Describe this device.

Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.com>
---
 arch/arm/boot/dts/renesas/r9a06g032.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/renesas/r9a06g032.dtsi b/arch/arm/boot/dts/renesas/r9a06g032.dtsi
index 13a60656b044..2bc07372bafa 100644
--- a/arch/arm/boot/dts/renesas/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/renesas/r9a06g032.dtsi
@@ -290,6 +290,16 @@ i2c2: i2c@40064000 {
 			status = "disabled";
 		};
 
+		adc: adc@40065000 {
+			compatible = "renesas,r9a06g032-adc", "renesas,rzn1-adc";
+			reg = <0x40065000 0x200>;
+			clocks = <&sysctrl R9A06G032_HCLK_ADC>, <&sysctrl R9A06G032_CLK_ADC>;
+			clock-names = "pclk", "adc-clk";
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


