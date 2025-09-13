Return-Path: <linux-iio+bounces-24071-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EB0B561EF
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 17:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D8FA0240C
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 15:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A94D2F5337;
	Sat, 13 Sep 2025 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="ybnVcbgs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EC52F39C9;
	Sat, 13 Sep 2025 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757778017; cv=none; b=LLPq/7Z2b8crT94ghPvRZ9kfTtgy6OM9T24LrDUjufEsS7CC71xSpDwO6fuRl+INbzX48p3T2fWhOOiEPdx0dgRQxgt6Rbjzk9YMp3u1l7mUoG1dUye1XJnoeTat2K83ujfiZQIfsUJlckeLTYxnTf/2gpH+u+wI8tYFSxtr7fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757778017; c=relaxed/simple;
	bh=kiTvKanWFJbaHUYayT5VU9Zl+pbyJ0hhXXQhg3n2Pv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g/0N1ybnyrO82sH5K/NHaBpXzHo+dDhH006oqYLPhwmdAbhhU0RhNWEdf7DXgJLsHgKx9JvkTlRiIPhLlptAJDK0I2oMlwSFKst/dePLylcAZ0byz6ZVTjA0rOCjBSLDhqD2luyRXma8T5qNFzuGszTMY/yLKJqo+nPdw6e3IwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=ybnVcbgs; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id A63DD173BF0;
	Sat, 13 Sep 2025 18:40:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757778008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QUa0LRP/R6N3g4QAuYnqLIgZlxNhVNC+0kJgbARJu4c=;
	b=ybnVcbgs+tMM4fSxJgGHBt1U4Jm2pH8jj9k539v3NGxLS3fvmjavKfAEU64lQTpEtA3Gvg
	hJ0tcKXVPNB8Pfgfkfoo0nx4wo6a73QS2F5LV/9qiCN0PjYzg6BMHL2gn6fEy8P8oUq3OD
	hT9cq+B9hlpe6qOhqjh7x6uaFHFC4o4FT6uODwLAc9uE2rn1NCM/YZcn+8sQmqUPs0oQRQ
	4+s5hh7nj8Vc8rNnnNlKseGCoxW8hgO5icseWbkhqJW9E+7Gm80sS+sxBObWTp9omYGk5/
	fb66kf1koHptfq2xp5BGLECV8Y0rD5V7RKArGqEdORN9LrX4+yE0efcAeJ2gbg==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sat, 13 Sep 2025 18:39:29 +0300
Subject: [PATCH v3 08/18] iio: accel: bma220: reset registers during init
 stage
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-b4-bma220_improvements-v3-8-0b97279b4e45@subdimension.ro>
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
In-Reply-To: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2641;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=kiTvKanWFJbaHUYayT5VU9Zl+pbyJ0hhXXQhg3n2Pv4=;
 b=owEBbQKS/ZANAwAIAc8mmZmETn8wAcsmYgBoxZBS1+RQLCWq3qQwQ8Nj5HYZvFcl6z3aK5jH4
 91VNudsd5KJAjMEAAEIAB0WIQTYCn/BdhUZNew+X6nPJpmZhE5/MAUCaMWQUgAKCRDPJpmZhE5/
 MHdvD/9dTO7c7Fcq19J7TyMq0iDYwkqlHHahbc/51djWHB6Y9F3jQMtitRdQQuTTbL5awHun8lQ
 TF2F52TCfZ4w8ONQgXOisuHJrz/ToQ0XoPc20cUJEwuEhZG8HfKbAYgIna3F3Dps/zwV/ldOpWp
 o88dYhT5EnfM/lOZpXphv79xza88tZ2h4l3u02BrXpbjwGJmY2cw5a75HCo7j7QvQi87yrtPlS5
 kTMfq9IWI0BHFx0YNcltR31vcy2WGYoFEjvkrajVNDErlID1hZYjPdudhqIpO4yOJN5RGgyHCYU
 z/guwHghtWlLrYtor3h4w44JiGYHedLyBCsTvdaFSfbG8U+1kSiyhTXXtSvwF81X64Uuarx/QXr
 clMudLzn4lPuGwrj3kOnSYBKL/WaVhKEWK5/OClmvKU8ERBCkrdeNJAbzNhUph4/ASUBlihLsGA
 GeCrn+hK8GkbSLNASh+MSMq+ADtGTX+fqRxBA2mL7C8Lx5AZLWl4aclKgcT8F8EKMzyTk/ve9tG
 JQXxnpIpRYyhiOhJZ1j1nTTPzQltoTKCtSL4lMpMEpegCEuTCRAKcybraHKEQXdIHjWbNLvSOzP
 O68G5Owc+OBjeNLnk+EIkJe14pYNg6dLj2q/12Tim8fpTPf2h2IjvG0ih20GN8MASaITDy/t+Vi
 1HSKu8VVgprczlw==
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Bring all configuration registers to default values during device probe().
Remove trivial code duplication regarding bma220_power() in _init()

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v2->v3
- split from larger patch
- remove 20% innocent parentheses in conditional (David)
---
 drivers/iio/accel/bma220_core.c | 43 +++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index dc156fcc1435ace9bda5fabc87864f38ae7bee05..fad73bf6b8f29c0a33519c64c8888a01008f7579 100644
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
 
@@ -203,6 +206,30 @@ static const struct iio_info bma220_info = {
 	.read_avail		= bma220_read_avail,
 };
 
+static int bma220_reset(struct spi_device *spi, bool up)
+{
+	int i, ret;
+
+	/**
+	 * The chip can be reset by a simple register read.
+	 * We need up to 2 register reads of the softreset register
+	 * to make sure that the device is in the desired state.
+	 */
+	for (i = 0; i < 2; i++) {
+		ret = bma220_read_reg(spi, BMA220_REG_SOFTRESET);
+		if (ret < 0)
+			return ret;
+
+		if (up && ret == BMA220_RESET_MODE)
+			return 0;
+
+		if (!up && ret == BMA220_NONRESET_MODE)
+			return 0;
+	}
+
+	return -EBUSY;
+}
+
 static int bma220_power(struct spi_device *spi, bool up)
 {
 	int i, ret;
@@ -242,14 +269,14 @@ static int bma220_init(struct spi_device *spi)
 	if (ret != BMA220_CHIP_ID)
 		return -ENODEV;
 
-	/* Make sure the chip is powered on */
-	ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
-	if (ret == BMA220_SUSPEND_WAKE)
-		ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
-	if (ret < 0)
-		return ret;
-	if (ret == BMA220_SUSPEND_WAKE)
-		return -EBUSY;
+	/* Make sure the chip is powered on and config registers are reset */
+	ret = bma220_power(spi, true);
+	if (ret)
+		return dev_err_probe(&spi->dev, ret, "Failed to power-on chip\n");
+
+	ret = bma220_reset(spi, true);
+	if (ret)
+		return dev_err_probe(&spi->dev, ret, "Failed to soft reset chip\n");
 
 	return 0;
 }

-- 
2.49.1


