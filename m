Return-Path: <linux-iio+bounces-11474-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5F99B335B
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 15:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8182BB241BF
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 14:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180DA1DED4F;
	Mon, 28 Oct 2024 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="FkSuad9R"
X-Original-To: linux-iio@vger.kernel.org
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDD81DDC2F;
	Mon, 28 Oct 2024 14:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125339; cv=none; b=LRiZs9Xo8mi0i0W6ifdD5Nha+K1L0/PkMp6RQZxsgbws2sul63ZDS+j5uR92gaxS2GuUC7dC5dKdX/dCCmjQwJ9pMx61ZllsbfNnlj+b1dsHsUSkHk9l1Fe+MlTPCsUk8PBDBwGEWWqU/z8CERy7l7Tq0N8ygc5OUWSZD44xuX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125339; c=relaxed/simple;
	bh=Az7W1ohdHrR78IqIcSfKr8mkmXTqZ+V08E1PhLHn4d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvtsjepH/M5f1gGnNE2ZdgL4c/t1iFE7dut8UWglSaD3Spin3+ifn3vkkt/JN5FPT6bnx5Vw1mRGZO0XR6sEcGgTAE96ilBydzgSu2ZjhFvxdm0pZDno37qGFkosvEALAyMOc45NYfIRylB5OwNypR1fkiSBDuGZ7gMyO7cgytc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=FkSuad9R; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id D87254C77B;
	Mon, 28 Oct 2024 14:22:15 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Aren Moynihan <aren@peacevolution.org>,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ondrej Jirman <megi@xff.cz>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Dragan Simic <dsimic@manjaro.org>,
	phone-devel@vger.kernel.org
Subject: [PATCH v3 6/6] arm64: dts: allwinner: pinephone: Add power supplies to stk3311
Date: Mon, 28 Oct 2024 10:20:00 -0400
Message-ID: <20241028142000.1058149-7-aren@peacevolution.org>
In-Reply-To: <20241028142000.1058149-1-aren@peacevolution.org>
References: <20241028142000.1058149-1-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
X-Spam-Level: ****
X-Spamd-Bar: ++++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1730125337;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=1Fb34FGXqzMNx+nxE4qoPozuG7GAzwlPuHgHmRcGRGE=;
	b=FkSuad9R/jOLZe6Le3I3hEkUAGnymubOEJP9B67v9DKLxDo0Kv1JVBbAyoZo6mAvNAhWwl
	CEgB3woOmCngbAnZe2SqrND+rM0eK4TqqQs3T0Xez4k8T4NTn+CU3f795Y1nQvttv5Qf22
	9EbvET02emJZvfxMPsW9m7Ucx4vHdW8=

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
index 6d152066a59a..618341b63db2 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -260,6 +260,8 @@ light-sensor@48 {
 		reg = <0x48>;
 		interrupt-parent = <&pio>;
 		interrupts = <1 0 IRQ_TYPE_EDGE_FALLING>; /* PB0 */
+		vdd-supply = <&reg_ldo_io0>;
+		leda-supply = <&reg_dldo1>;
 	};
 
 	/* Accelerometer/gyroscope */
-- 
2.47.0


