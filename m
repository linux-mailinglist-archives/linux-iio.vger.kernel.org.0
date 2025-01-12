Return-Path: <linux-iio+bounces-14182-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60083A0A8F3
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 13:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2BC77A2104
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647221B21B5;
	Sun, 12 Jan 2025 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="As8FQZIt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FBD1AF0C0;
	Sun, 12 Jan 2025 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736683565; cv=none; b=ba3RUbwmbsjtZZnmxRtI8GvhMliWlcx4q7hjwazmjDZ4Y7Mb3gbXSLDDMKL1od9SysleWj2RR6OeFXOnbqcT8jgx0hJMOLmrW4swATePKHTkNcDb5KKB9hTo23vSQjFem9Wk8y/SJxTWFWPeYTh4ZRqFaWlP8N2l0wiv5dDNj+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736683565; c=relaxed/simple;
	bh=Se0XQboJyjtbGzscr24wmSD4SF40fS4151iliKnRSms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LphP8HZn1EX1yPQ+JI+yarFv5FTfWXaZObofGck8pXsNxrdfNWAulNWDmuV+7npgGUlEYjVPHiCaa3xUlaXZUO2Rb1TxvV7uz3YkNtg3OZYiYglMw5QGmt17EYryBfdMUjI33S/O4dOrpyyYTsYATGhboSTUgIIPqK1oM+HzLvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=As8FQZIt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA576C4CEE9;
	Sun, 12 Jan 2025 12:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736683564;
	bh=Se0XQboJyjtbGzscr24wmSD4SF40fS4151iliKnRSms=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=As8FQZItL/BnzHw/7uKn65d+3WdxoCwiWrV2guMIUOjVcXb4pZnrgVwS8Hn/b9uU0
	 tWUl/w7vjNca5op4fTlVmZTC7DD6ozPNv3HXNQB1nbKZpkM44ilNgw3TSgYRePMZsG
	 Uo6yxWmZsfUjUv+FXHeTZvhWyR3+JlSWBnMHerLpE9bT1ZoId8KrwOG38konfBiED2
	 kZT/PtM8qjZsCSXFtHl20FC8rsHvZwPQOm7GuSqOhgQ8KsbE2JXMZOiBDYFVfpc84S
	 wvUMKD4ryh6C3ZbTgMPml3fvyw99n92SzCVzfIw6/7Af7GUoWd9qBRJ6+6pItrNlm6
	 cTNrzL7pQGNEA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB74E7719C;
	Sun, 12 Jan 2025 12:06:04 +0000 (UTC)
From: Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org>
Date: Sun, 12 Jan 2025 15:06:05 +0300
Subject: [PATCH v2 4/5] iio: accel: mc3230: add multiple devices support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250112-mainlining-mc3510c-v2-4-322804a545cf@gmail.com>
References: <20250112-mainlining-mc3510c-v2-0-322804a545cf@gmail.com>
In-Reply-To: <20250112-mainlining-mc3510c-v2-0-322804a545cf@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vasiliy Doylov <nekodevelopper@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3868;
 i=nekodevelopper@gmail.com; h=from:subject:message-id;
 bh=3IVy/NyWvdKKaQp0EMfhTlEK8Ob/tkCbzYjX6DAoo5c=;
 b=owGbwMvMwCW2fZ/SFZeSpU2Mp9WSGNKbN2gprFV2Tfh9/sXuWz3P71hy9Kiztt2K/LFm1Z9zS
 VZfplcVdJSyMIhxMciKKbLYbPSYLZYfLjlp2lMFmDmsTCBDGLg4BeAm5zL8d06w8JPeyzcv/9/r
 JtVe8zNrlgY6zxdMuV6VwXT4U9r2Ewz/jB8kvPgoe2XWq+9zDy/ZfPTk2mUnNnHM8k08ZLzXZMW
 OlTwA
X-Developer-Key: i=nekodevelopper@gmail.com; a=openpgp;
 fpr=3CB1489B166F57199296E520B7BE22D44474A582
X-Endpoint-Received: by B4 Relay for nekodevelopper@gmail.com/default with
 auth_id=314
X-Original-From: Vasiliy Doylov <nekodevelopper@gmail.com>
Reply-To: nekodevelopper@gmail.com

From: Vasiliy Doylov <nekodevelopper@gmail.com>

This patch allows to add new devices to this driver.

Signed-off-by: Vasiliy Doylov <nekodevelopper@gmail.com>
---
 drivers/iio/accel/mc3230.c | 50 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
index ba30c904d3f67002deeb3ca5a7e12bfae312e05f..ef9c4bcabb0b77518fe2a124e31ec5e7ca66816f 100644
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
+	const u8 chip_id;
+	const char *name;
+	const u8 product_code;
+	const int scale;
+};
+
+static struct mc3230_chip_info mc3230_chip_info = {
+	.chip_id = 0x01,
+	.name = "mc3230",
+	.product_code = 0x19,
+	/* (1.5 + 1.5) * 9.81 / (2^8 - 1) = 0.115411765 */
+	.scale = 115411765,
+};
 
 #define MC3230_CHANNEL(reg, axis) {	\
 	.type = IIO_ACCEL,	\
@@ -48,6 +57,7 @@ static const int mc3230_nscale = 115411765;
 }
 
 struct mc3230_data {
+	const struct mc3xxx_chip_info *chip_info;
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
+	const struct mc3xxx_chip_info *chip_info;
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
+	{ "mc3230", (kernel_ulong_t)&mc3230_chip_info },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, mc3230_i2c_id);
 
 static const struct of_device_id mc3230_of_match[] = {
-	{ .compatible = "mcube,mc3230" },
+	{ .compatible = "mcube,mc3230", &c3230_chip_info },
 	{}
 };
 MODULE_DEVICE_TABLE(of, mc3230_of_match);

-- 
2.47.1



