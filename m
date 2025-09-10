Return-Path: <linux-iio+bounces-23918-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DE7B5102C
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 09:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49CF0461273
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 07:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD67B30DEDA;
	Wed, 10 Sep 2025 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="g5XK6ZUL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C13C30F7E3;
	Wed, 10 Sep 2025 07:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491094; cv=none; b=SiLVaMmJQmq8TLG5/IzPCtp/bxKADudshwjZ401M2uhnqVOlN7ulrV/gLTphD42qD7uqo3MmyCwLX3V+Yw1y1nJGg0MQcbcEqFgpI0rssKcOd5tbCn3sDg/TXdzi1FI8BO6rqRY0sPl9mnmajMtEaibIe63RUV6jm+/vq+Xuz7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491094; c=relaxed/simple;
	bh=1scJCB+806UtNfxHO3wDXIOqiSHVx3IrG0YVu0piZBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RcyNza9MWQVy6tDXe1LFxdr2cO6bFt3WTWoe8p48a4scSpGncVmNTnwDQK95DuegA5vDacgP1t/53x1xhDcw9cUkAdT6jY0aQy/GtQNgb4BnhI3SABirjTKq1S/gV29QjJkHc1Zb8JzIHsA/FMbsXEttr9pHBxTL42+dZzJTmpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=g5XK6ZUL; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3503:4a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 12611173BEF;
	Wed, 10 Sep 2025 10:58:04 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757491084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AfJ3WGDj3DCbzW0qEw5j4fk1Oo5dl0J3mYsDlxO0xPM=;
	b=g5XK6ZULBWfMavS2bQ7oqpVH2NX2kidmhUIMqkUzaNQibg8chlHbW71tiowyFynOUhVeDA
	tM2U0lT2dUkiGnw6nbEnCEWYx+reMxnp6H7RMDpI5RhvYswabFJntO58UvitHyd3hZQ2OU
	Yl/wb5QQX8V6n2q8Udp++baKx7C9lzgyt6SmMW/esUL4pBlApaFbcFgWU3UzHmGt1HyrUW
	dIkEgKuG4DSAVyTdjlIk2CNSXX+WrBG4OxDRLZJw3w2DszJUc5Co3ZObEdBQIpizYnSi1Z
	C6Ymtd/xbLUYURDpMBVDQAwkCAa2by3ijE/lB8ttorkkiteTP+k1E0+4IGSSCQ==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 10 Sep 2025 10:57:12 +0300
Subject: [PATCH v2 07/14] iio: accel: bma220: reset registers during init
 stage
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-bma220_improvements-v2-7-e23f4f2b9745@subdimension.ro>
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
In-Reply-To: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Petre Rodan <petre.rodan@subdimension.ro>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3680;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=1scJCB+806UtNfxHO3wDXIOqiSHVx3IrG0YVu0piZBk=;
 b=owEBbQKS/ZANAwAIAc8mmZmETn8wAcsmYgBowS+H+lbBm1fJRNRUAbqlyfztjKh1lRU6RZSq2
 JRxA60heJqJAjMEAAEIAB0WIQTYCn/BdhUZNew+X6nPJpmZhE5/MAUCaMEvhwAKCRDPJpmZhE5/
 MOxmEAC+9O+71EeYTsLfT7dvbo3t7T3N74DOKhNgg+kC1FIwVWuzEIcB5whTkTYo3Jk8ASAQ6ds
 9URirDv13cWoUT0XO/cg6wpjjA0dgUKKV59iULxlcvb5rIdc9IA+TZWHcFo9SpWt3e0aIsjIVRb
 AU2zKMXdgccGORaZSBTkLTcRB1sUs+1QP1A8Drox2Q5Sp45r+vubybEer65UsmZky37rlrYH0zX
 AdeHPRM66ffFAtChvG3rIYNcHoUzuzhkM36mfZrzuDzNxy+KZtjxk429kAyWF4dxV9Eby/eycgf
 J0n+zhkTtC0kbfyytr9S3BylW2zKQsW7hJBAajbGiYupbIW9winyB/ZiZGq5TVil01ILJHzl1eX
 4MtODErwYCUoWrWsUpoUk9/bcLo2lww58+0y2NrDsVa/taZBGPKSvMoOfsjMoCBv4wqQ7dJHO7u
 A0JYN0UB8kOZLJKM8i9UjNrlFsf1EFcbkt4dkV20fb3X3reZ0cVTlgjBA2jz6plmKw7bXQGCG5J
 dGkWmJ1wdh8BCnBCne33PS3Vl6VlhhEPPoYzpNGw0z6J4ieLlupAGXg/X8p6jCSR3FCDTW1AI1i
 EDcxuWR7aNSB4ksNlq1rh+Fx9LRCgHEnGJSsD3JK7rP0cor7VlPo1Bx+0qQDJjtc+wGXEKKy7+B
 3sTSgwPHpXIF4Fw==
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Bring all configuration registers to default values during device probe().

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/accel/bma220_core.c | 71 ++++++++++++++++++++++++++++-------------
 1 file changed, 49 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index b6f1374a9cca52966c1055113710061a7284cf5a..322df516c90a7c645eeca579cae9803eb31caad1 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -29,12 +29,15 @@
 #define BMA220_REG_ACCEL_Z			0x04
 #define BMA220_REG_RANGE			0x11
 #define BMA220_REG_SUSPEND			0x18
+#define BMA220_REG_SOFTRESET			0x19
 
 #define BMA220_CHIP_ID				0xDD
 #define BMA220_READ_MASK			BIT(7)
 #define BMA220_RANGE_MASK			GENMASK(1, 0)
 #define BMA220_SUSPEND_SLEEP			0xFF
 #define BMA220_SUSPEND_WAKE			0x00
+#define BMA220_RESET_MODE			0xFF
+#define BMA220_NONRESET_MODE			0x00
 
 #define BMA220_DEVICE_NAME			"bma220"
 
@@ -203,31 +206,28 @@ static const struct iio_info bma220_info = {
 	.read_avail		= bma220_read_avail,
 };
 
-static int bma220_init(struct spi_device *spi)
+static int bma220_reset(struct spi_device *spi, bool up)
 {
-	int ret;
-	static const char * const regulator_names[] = { "vddd", "vddio", "vdda" };
+	int i, ret;
 
-	ret = devm_regulator_bulk_get_enable(&spi->dev,
-					     ARRAY_SIZE(regulator_names),
-					     regulator_names);
-	if (ret)
-		return dev_err_probe(&spi->dev, ret, "Failed to get regulators\n");
+	/**
+	 * The chip can be reset by a simple register read.
+	 * We need up to 2 register reads of the softreset register
+	 * to make sure that the device is in the desired state.
+	 */
+	for (i = 0; i < 2; i++) {
+		ret = bma220_read_reg(spi, BMA220_REG_SOFTRESET);
+		if (ret < 0)
+			return ret;
 
-	ret = bma220_read_reg(spi, BMA220_REG_ID);
-	if (ret != BMA220_CHIP_ID)
-		return -ENODEV;
+		if (up && (ret == BMA220_RESET_MODE))
+			return 0;
 
-	/* Make sure the chip is powered on */
-	ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
-	if (ret == BMA220_SUSPEND_WAKE)
-		ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
-	if (ret < 0)
-		return ret;
-	if (ret == BMA220_SUSPEND_WAKE)
-		return -EBUSY;
+		if (!up && (ret == BMA220_NONRESET_MODE))
+			return 0;
+	}
 
-	return 0;
+	return -EBUSY;
 }
 
 static int bma220_power(struct spi_device *spi, bool up)
@@ -244,16 +244,43 @@ static int bma220_power(struct spi_device *spi, bool up)
 		if (ret < 0)
 			return ret;
 
-		if (up && ret == BMA220_SUSPEND_SLEEP)
+		if (up && (ret == BMA220_SUSPEND_SLEEP))
 			return 0;
 
-		if (!up && ret == BMA220_SUSPEND_WAKE)
+		if (!up && (ret == BMA220_SUSPEND_WAKE))
 			return 0;
 	}
 
 	return -EBUSY;
 }
 
+static int bma220_init(struct spi_device *spi)
+{
+	int ret;
+	static const char * const regulator_names[] = { "vddd", "vddio", "vdda" };
+
+	ret = devm_regulator_bulk_get_enable(&spi->dev,
+					     ARRAY_SIZE(regulator_names),
+					     regulator_names);
+	if (ret)
+		return dev_err_probe(&spi->dev, ret, "Failed to get regulators\n");
+
+	ret = bma220_read_reg(spi, BMA220_REG_ID);
+	if (ret != BMA220_CHIP_ID)
+		return -ENODEV;
+
+	/* Make sure the chip is powered on and config registers are reset */
+	ret = bma220_power(spi, true);
+	if (ret)
+		return dev_err_probe(&spi->dev, ret, "Failed to power-on chip\n");
+
+	ret = bma220_reset(spi, true);
+	if (ret)
+		return dev_err_probe(&spi->dev, ret, "Failed to soft reset chip\n");
+
+	return 0;
+}
+
 static void bma220_deinit(void *spi)
 {
 	bma220_power(spi, false);

-- 
2.49.1


