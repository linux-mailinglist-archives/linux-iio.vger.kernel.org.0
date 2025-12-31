Return-Path: <linux-iio+bounces-27454-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D30A5CEC914
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 22:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 028283031CEB
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 21:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A197530DEC0;
	Wed, 31 Dec 2025 21:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OE1s0UBq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0952F1FD5;
	Wed, 31 Dec 2025 21:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767215675; cv=none; b=BsK64v4B3mENjFd7bR4dqfIyFqV9Ps/uk4b78gA7nQvu1RnTuL8j/xX8V+tK4I704b+LsvNy9xpivpiN3xGL27T+vi6dP5r1Q3X3d41B6DOBqsYfiYjf+n71SQAjCuZ6FdPAT4M066GqURa03IveMT311Zu9QlhCQG6VZ1qyGQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767215675; c=relaxed/simple;
	bh=whyQymEuKoQPya6K6m/OkXij0pAB0J+H6jrBiCCUzB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UM2j3yjVpsjkusZcaKtIzfFEHecw5JEs3TKHPrv8c1NPUHqjBaIdNSOWhPyIbBvFfravyRA42wtvZIkXyFxIfsRIv3CjutfN1pYjfcXJuSN2IIeE0XhyrBXZcr8GKQz25nxKk+1en041JzIqtkwUY0B+KoBHOd46np5MzbsCxDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OE1s0UBq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B53C16AAE;
	Wed, 31 Dec 2025 21:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767215674;
	bh=whyQymEuKoQPya6K6m/OkXij0pAB0J+H6jrBiCCUzB0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OE1s0UBqkbN26uFy3VYYZD1mXU1YaulOdCTNWR7lPxHyOl96twJ20ZlX+bB/7QC+b
	 TsYXvm95nlsa+FTxwdDG0qYtB8tifBwWB97untRgmb2kAFlNVAn1WqbZHNkeT8Vdw/
	 tDbaAti6YAbRQGVknBNFyDaoWguswu/SJfsdT99ISKDp/ejTNGcCQLv4b72SNk5vDq
	 8t0U3ok5hJ2AW4S6acx8NstFCP8q+SAjveQEkNl1cMV1pX+YUUNwVAdYvB8rZR81eL
	 rjzuuTaHs1AVnQ3gjMgik7Y/oLdt2ARYwtUFYHXBnpRYrmO2NRxFTkyEjgDypAZIGM
	 +hmJTJ4n2sp1w==
From: akemnade@kernel.org
Date: Wed, 31 Dec 2025 22:14:17 +0100
Subject: [PATCH 2/2] ARM: dts: ti/omap: omap4-epson-embt2ws: fix typo in
 iio device property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251231-mpu9150-v1-2-08ecf085c4ae@kernel.org>
References: <20251231-mpu9150-v1-0-08ecf085c4ae@kernel.org>
In-Reply-To: <20251231-mpu9150-v1-0-08ecf085c4ae@kernel.org>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 Andreas Kemnade <akemnade@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1141; i=akemnade@kernel.org;
 h=from:subject:message-id; bh=z+7X+G6XUh0LFLv4u0xBI8oqiZVKwYqo5TbWTH8Z7tQ=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDJmhk/QeffEXCdvNdL3rtq7Whx/dVdtuvPqo32wx4d7q/
 9cUtlz17ChlYRDjYpAVU2T5Za3g9knlWW7w1Ah7mDmsTCBDGLg4BWAizm4M/30skpzfafnOruyR
 CNfc0Ke7gCH+h9rB/c15FzqkBHJOyTL84Tn0iPNCyNzUyX0aRuzRN/flSOsl18ion/q9O1e0zW0
 lCwA=
X-Developer-Key: i=akemnade@kernel.org; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

From: Andreas Kemnade <andreas@kemnade.info>

Define interrupts properly. Unfortunately, this hides a bug in the linux
driver, so it needs to be used with the driver fixed only.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts b/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
index c90f43cc2fae9..a9f0cfd7c999d 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
+++ b/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
@@ -346,7 +346,7 @@ mpu9150h: imu@68 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&mpu9150h_pins>;
 		interrupt-parent = <&gpio2>;
-		interrupt = <19 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
 	};
 };
 
@@ -408,7 +408,7 @@ mpu9150: imu@68 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&mpu9150_pins>;
 		interrupt-parent = <&gpio2>;
-		interrupt = <7 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
 		vddio-supply = <&cb_v18>;
 		vdd-supply = <&cb_v33>;
 		invensense,level-shifter;

-- 
2.47.3


