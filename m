Return-Path: <linux-iio+bounces-14286-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92782A0B8F7
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 15:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2292A3A158C
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 14:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52DB23DE8E;
	Mon, 13 Jan 2025 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbuCBEOx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EFC237A38;
	Mon, 13 Jan 2025 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736776923; cv=none; b=oOKzAAf+7RdtRHsKUrXJU16EUid2Au54K+ChSjyHsjh8hbe5RO0sm3bDnsPEqUcd3v2tX1DlOAaDn2qR5WowN9pS99x2IGXGVHB8y+hJG1S+SV00xzr4wrR2zy6tz/ojyTSWu2zmtuiNhYEi3y16qe3pS1xRV4ySFil4KWpHwSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736776923; c=relaxed/simple;
	bh=GHBGvpnYHAvgR5QdMdS42bx3vhlkuBWS2kC6em2zrsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ddO6CoyTHUR3abQndmI+MCOtdpi4t90PjOOFuB9YwLrawKCS+zr3M1FcQM4/m7Jei3FfEf6p14H0TqGI7W5KxzZ8fewTy9pl/dxvcZetRTTPvVbkJM+kSZjHdDBEPDZHCYZCxgnAdhpsXHBhMauArvFLicrNDmFY665ve1ESpZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbuCBEOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01AD3C4CEEB;
	Mon, 13 Jan 2025 14:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736776923;
	bh=GHBGvpnYHAvgR5QdMdS42bx3vhlkuBWS2kC6em2zrsk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FbuCBEOxvMzQBXzdzGCYKwiRvZBSllGU06Dji9ZnoZIdZ5qoY6kvT53g7lNy2Fh3+
	 kWcgCBCyTxsl7IDJpp2AwxbhK/5PNPxZn1+sNorW/qjtxQgoQNWAa6UF/krsmSLs7Q
	 stcN9xoHD42P4e1Wz69sEN88faCdfBfEbh6JsjHxApUBSlNPRDX7Px8QGUX9UBuCQu
	 us2LtcvgJSCf8Obp/yP9XiFlwzAuSbxYdznadhtbJifHN0hTHtmvE4f9DdzbgC568t
	 Cxl+73mR7LcbCBJESP45iSSWjExFJaiCGU7d9jFJc7d3+I3kf1hwGByEASP5E7FMXE
	 Z4aHAG70MkUPQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E982BC02183;
	Mon, 13 Jan 2025 14:02:02 +0000 (UTC)
From: Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org>
Date: Mon, 13 Jan 2025 17:02:03 +0300
Subject: [PATCH v4 4/5] iio: accel: mc3230: add multiple devices support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-mainlining-mc3510c-v4-4-4118411ef569@gmail.com>
References: <20250113-mainlining-mc3510c-v4-0-4118411ef569@gmail.com>
In-Reply-To: <20250113-mainlining-mc3510c-v4-0-4118411ef569@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vasiliy Doylov <nekodevelopper@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3965;
 i=nekodevelopper@gmail.com; h=from:subject:message-id;
 bh=u0GLxDIqXOpHS5sTxKMtGQzMSlmbBkvPdn0nmTqe/ag=;
 b=owGbwMvMwCW2fZ/SFZeSpU2Mp9WSGNJbZW5eE1gTGZaharxW9XNpgtOzaUuneNdzPL9hwaigy
 pogdKCho5SFQYyLQVZMkcVmo8dssfxwyUnTnirAzGFlAhnCwMUpABMJ2s/w311brVV61Z2DRpMz
 mV6syVx3YedPq2WOBybN8fh7zDZRi42R4bOa7l8b4wyxjw1PWA8u3tfxMVb736vYHa8e76i77sT
 hzw4A
X-Developer-Key: i=nekodevelopper@gmail.com; a=openpgp;
 fpr=3CB1489B166F57199296E520B7BE22D44474A582
X-Endpoint-Received: by B4 Relay for nekodevelopper@gmail.com/default with
 auth_id=314
X-Original-From: Vasiliy Doylov <nekodevelopper@gmail.com>
Reply-To: nekodevelopper@gmail.com

From: Vasiliy Doylov <nekodevelopper@gmail.com>

Refactor code to support multiple generations of MCUBE devices by
defining name, chip id and product code in mc3230_chip_info struct.

Signed-off-by: Vasiliy Doylov <nekodevelopper@gmail.com>
---
 drivers/iio/accel/mc3230.c | 52 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
index 443b5b30c83144478c27a86dbdc12e4e944a34df..c8d394c3ecf08fad60f0f2ae7be6fd992327d843 100644
--- a/drivers/iio/accel/mc3230.c
+++ b/drivers/iio/accel/mc3230.c
@@ -22,20 +22,29 @@
 #define MC3230_MODE_OPCON_STANDBY	0x03
 
 #define MC3230_REG_CHIP_ID		0x18
-#define MC3230_CHIP_ID			0x01
-
 #define MC3230_REG_PRODUCT_CODE		0x3b
-#define MC3230_PRODUCT_CODE		0x19
 
 /*
  * The accelerometer has one measurement range:
  *
  * -1.5g - +1.5g (8-bit, signed)
  *
- * scale = (1.5 + 1.5) * 9.81 / (2^8 - 1)	= 0.115411765
  */
 
-static const int mc3230_nscale = 115411765;
+struct mc3230_chip_info {
+	const char *name;
+	const u8 chip_id;
+	const u8 product_code;
+	const int scale;
+};
+
+static const struct mc3230_chip_info mc3230_chip_info = {
+	.name = "mc3230",
+	.chip_id = 0x01,
+	.product_code = 0x19,
+	/* (1.5 + 1.5) * 9.81 / (2^8 - 1) = 0.115411765 */
+	.scale = 115411765,
+};
 
 #define MC3230_CHANNEL(reg, axis) {	\
 	.type = IIO_ACCEL,	\
@@ -48,6 +57,7 @@ static const int mc3230_nscale = 115411765;
 }
 
 struct mc3230_data {
+	const struct mc3230_chip_info *chip_info;
 	struct i2c_client *client;
 	struct iio_mount_matrix orientation;
 };
@@ -111,7 +121,7 @@ static int mc3230_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
-		*val2 = mc3230_nscale;
+		*val2 = data->chip_info->scale;
 		return IIO_VAL_INT_PLUS_NANO;
 	default:
 		return -EINVAL;
@@ -127,15 +137,28 @@ static int mc3230_probe(struct i2c_client *client)
 	int ret;
 	struct iio_dev *indio_dev;
 	struct mc3230_data *data;
+	const struct mc3230_chip_info *chip_info;
+
+	chip_info = i2c_get_match_data(client);
+	if (chip_info == NULL) {
+		dev_err(&client->dev, "failed to get match data");
+		return -ENODATA;
+	}
 
 	/* First check chip-id and product-id */
 	ret = i2c_smbus_read_byte_data(client, MC3230_REG_CHIP_ID);
-	if (ret != MC3230_CHIP_ID)
-		return (ret < 0) ? ret : -ENODEV;
+	if (ret != chip_info->chip_id) {
+		dev_info(&client->dev,
+			"chip id check fail: 0x%x != 0x%x !\n",
+			ret, chip_info->chip_id);
+	}
 
 	ret = i2c_smbus_read_byte_data(client, MC3230_REG_PRODUCT_CODE);
-	if (ret != MC3230_PRODUCT_CODE)
-		return (ret < 0) ? ret : -ENODEV;
+	if (ret != chip_info->product_code) {
+		dev_info(&client->dev,
+			"product code check fail: 0x%x != 0x%x !\n",
+			ret, chip_info->product_code);
+	}
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev) {
@@ -144,11 +167,12 @@ static int mc3230_probe(struct i2c_client *client)
 	}
 
 	data = iio_priv(indio_dev);
+	data->chip_info = chip_info;
 	data->client = client;
 	i2c_set_clientdata(client, indio_dev);
 
 	indio_dev->info = &mc3230_info;
-	indio_dev->name = "mc3230";
+	indio_dev->name = chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = mc3230_channels;
 	indio_dev->num_channels = ARRAY_SIZE(mc3230_channels);
@@ -200,13 +224,13 @@ static int mc3230_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(mc3230_pm_ops, mc3230_suspend, mc3230_resume);
 
 static const struct i2c_device_id mc3230_i2c_id[] = {
-	{ "mc3230" },
-	{}
+	{ "mc3230", (kernel_ulong_t)&mc3230_chip_info },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mc3230_i2c_id);
 
 static const struct of_device_id mc3230_of_match[] = {
-	{ .compatible = "mcube,mc3230" },
+	{ .compatible = "mcube,mc3230", &mc3230_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mc3230_of_match);

-- 
2.47.1



