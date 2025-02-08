Return-Path: <linux-iio+bounces-15187-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F84A2D8E3
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 22:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E985E188932F
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 21:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFCE2441BF;
	Sat,  8 Feb 2025 21:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="dg7Nqf7A"
X-Original-To: linux-iio@vger.kernel.org
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660282441A4;
	Sat,  8 Feb 2025 21:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739049411; cv=none; b=D6Nugn23da/utv2y988zK8OphDZdTzhrov2GheD2OdAsFpRETFZVYcN3QR3V71HYUt4GsbP9UwLHRYfCgASVe3jTHU+KfoJev7JSj1REbGkVWiQsHvYhu0S7w5UB4ie8SGUdUK/qfOlvelOPw0ZsQ3moMPLU9b6HRxMra7IGuqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739049411; c=relaxed/simple;
	bh=vPyN0byjiX1ogFw2gBtCFjfv8lniT3rcPJVsAzn2rcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/pPhtnJBSbhTcMjovsWymXRucRcx7d2FVnYbC+Zj79sB/uO/uMsug08wGdgbHiXjqKpfqWUBBTzCurNM1LjP3I/Nv8D5piWHgmthQbtB4riO3Ida0180Re2RnQ7sE91LbC0K01IVy/h+LHrUMjKxlI7MkSoYMuzZHklWb9MbJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=dg7Nqf7A; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 68D9841B6E;
	Sat,  8 Feb 2025 21:16:48 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Aren Moynihan <aren@peacevolution.org>,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>,
	Julien Stephan <jstephan@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Ondrej Jirman <megi@xff.cz>,
	Dragan Simic <dsimic@manjaro.org>,
	phone-devel@vger.kernel.org
Subject: [PATCH v5 8/8] arm64: dts: allwinner: pinephone: add power supplies to stk3311
Date: Sat,  8 Feb 2025 16:13:26 -0500
Message-ID: <20250208211325.992280-10-aren@peacevolution.org>
In-Reply-To: <20250208211325.992280-2-aren@peacevolution.org>
References: <20250208211325.992280-2-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
X-Spam-Level: **
X-Spamd-Bar: ++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1739049409;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=I6BlN6EJ3tr8v9Bkl3osVeEnBo4ZKpH0ucFgYQMPJag=;
	b=dg7Nqf7Akrsc0TvG+ztOY/9QZ6wccJ6QE7qJRpYGOMcGJPPS7Y5JaoJMf1fAuFpSteeaOq
	arynTZbN1Idv+KM0sP0slzwJwemq+0i0I8mj/ZCqgWVIAiJlki7KXnv4sFhtrK3t0+ZnzP
	WUh6z1s7yRZN4jbah+9X5ULbSKhNR/Q=

From: Ondrej Jirman <megi@xff.cz>

This allows the driver to properly handle powering this device, and
disable power during suspend.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---

Notes:
    Changes in v2:
     - add leda-supply

 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index a2ceb08a91950..d70fbc06b8d23 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -278,6 +278,8 @@ light-sensor@48 {
 		reg = <0x48>;
 		interrupt-parent = <&pio>;
 		interrupts = <1 0 IRQ_TYPE_EDGE_FALLING>; /* PB0 */
+		vdd-supply = <&reg_ldo_io0>;
+		leda-supply = <&reg_dldo1>;
 	};
 
 	/* Accelerometer/gyroscope */
-- 
2.48.1


