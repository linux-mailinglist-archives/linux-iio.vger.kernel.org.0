Return-Path: <linux-iio+bounces-14140-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0148EA0A5D5
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 21:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B50433A75F2
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 20:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5F61B87F2;
	Sat, 11 Jan 2025 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeGOLksy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149931B85CC;
	Sat, 11 Jan 2025 20:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736626270; cv=none; b=iV9nE9LWUsank2UXISvj7+gjjpEWTKOvBXmOKNeYuik+xXl1l1JyD5jl8TqeFYsvU1avnEgAj1fOmHwcnb2jc36FGqtWTzR74Jsfu3eAroko6jSsYD/LVEROq1pZt4gLryngX0NjSU5Y7oUwb0aBnObORLXio6KCeatkGY3DhZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736626270; c=relaxed/simple;
	bh=zHENJgA45YYkFLL0ldE4wCLz8XeAFTgRqKHUY79HGiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=emxPSUvEnMI7TX3zFIfFl0pZLLpShr1MtpPuehPYTd4nMO9dwm55ZxKdlA3MslnvioKh5lflaGuINETZy9vH5R6+05jdNXbzIGqql2JkFCFK4xQHSgX99k6yX7Dobc671UEm0x/4UjXhurO5o5TgezXwgWj6KTKGqUdXxIQfzCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeGOLksy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF269C4CEE3;
	Sat, 11 Jan 2025 20:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736626269;
	bh=zHENJgA45YYkFLL0ldE4wCLz8XeAFTgRqKHUY79HGiw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DeGOLksy0TY24bt+xBPEz/Lk5QF2zS4NnDvTlxmjANlRShk/tbQs9FOhpKlycG9ev
	 1FpECt5Act7q2nve7S8bj9tHKZNGgnlRuV+nRl8I2XzWjXZpXmu281foF9Iup2eCIp
	 NbuXL8h36ic1pZT7j+80ZBcsr4JqKO8rPpR28OdxkpjonioaEI3dgm1wcEkGVPgUcI
	 nG2cyNBatTTTfaN4aZzMP21tfFvjukyWhc8DxWwNg5RVozA/k+7VhZmMuIrvXnzXSl
	 84wiAENNYHd3RCfCbJSVr53ylV4GoCcIIMfembbyALFgBRMMbKQkeDSxKv3GyxandZ
	 mG6blifU/eQEQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D84E7719C;
	Sat, 11 Jan 2025 20:11:09 +0000 (UTC)
From: Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org>
Date: Sat, 11 Jan 2025 23:11:08 +0300
Subject: [PATCH 3/4] iio: accel: mc3230: add mc3510c support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250111-mainlining-mc3510c-v1-3-57be503addf8@gmail.com>
References: <20250111-mainlining-mc3510c-v1-0-57be503addf8@gmail.com>
In-Reply-To: <20250111-mainlining-mc3510c-v1-0-57be503addf8@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vasiliy Doylov <nekodevelopper@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4230;
 i=nekodevelopper@gmail.com; h=from:subject:message-id;
 bh=ydt9wEg9ZXDn59JTji5alQyxsHpWkyrwV3RCLRJDzSw=;
 b=owGbwMvMwCW2fZ/SFZeSpU2Mp9WSGNKbLkSv8WDsmtnCctluzwWfmPsNlj43JBmLuS68dWgNO
 ZHL9pm3o5SFQYyLQVZMkcVmo8dssfxwyUnTnirAzGFlAhnCwMUpABNRcmJkmNe8NarpU7i1z5lT
 yUaMH55EirO+1jQ8aHPHItstXUZRh5FhZxyzWfO602aPr0zsko3V5Z13pGD5c6/dMxnfsi18yzO
 JAwA=
X-Developer-Key: i=nekodevelopper@gmail.com; a=openpgp;
 fpr=3CB1489B166F57199296E520B7BE22D44474A582
X-Endpoint-Received: by B4 Relay for nekodevelopper@gmail.com/default with
 auth_id=314
X-Original-From: Vasiliy Doylov <nekodevelopper@gmail.com>
Reply-To: nekodevelopper@gmail.com

From: Vasiliy Doylov <nekodevelopper@gmail.com>

This commit integrates support for the mc3510c into the mc3230 driver.

Tested on Huawei MediaPad T3 10 (huawei-agassi)

Signed-off-by: Vasiliy Doylov <nekodevelopper@gmail.com>
---
 drivers/iio/accel/mc3230.c | 55 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
index 3cad6f2d7a2a79df38f90e5656763f6ed019a920..ebbb96c658d87a83007c7c3c7212ce9ebf039963 100644
--- a/drivers/iio/accel/mc3230.c
+++ b/drivers/iio/accel/mc3230.c
@@ -22,20 +22,41 @@
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
+enum mc3xxx_chips {
+	MC3230,
+	MC3510C,
+};
+
+struct mc3xxx_chip_info {
+	const char *name;
+	const u8 chip_id;
+	const u8 product_code;
+	const int scale;
+};
+
+static struct mc3xxx_chip_info mc3xxx_chip_info_tbl[] = {
+	[MC3230] = {
+		.name = "mc3230",
+		.chip_id = 0x01,
+		.product_code = 0x19,
+		.scale = 115411765, // (1.5 + 1.5) * 9.81 / (2^8 - 1) = 0.115411765
+	},
+	[MC3510C] = {
+		.name = "mc3510c",
+		.chip_id = 0x23,
+		.product_code = 0x10,
+		.scale = 625000000, // Was obtained empirically
+	},
+};
 
 #define MC3230_CHANNEL(reg, axis) {	\
 	.type = IIO_ACCEL,	\
@@ -50,6 +71,7 @@ static const int mc3230_nscale = 115411765;
 struct mc3230_data {
 	struct i2c_client *client;
 	struct iio_mount_matrix orientation;
+	const struct mc3xxx_chip_info *chip_info;
 };
 
 static const struct iio_mount_matrix *
@@ -111,7 +133,7 @@ static int mc3230_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
-		*val2 = mc3230_nscale;
+		*val2 = data->chip_info->scale;
 		return IIO_VAL_INT_PLUS_NANO;
 	default:
 		return -EINVAL;
@@ -127,15 +149,23 @@ static int mc3230_probe(struct i2c_client *client)
 	int ret;
 	struct iio_dev *indio_dev;
 	struct mc3230_data *data;
+	const struct mc3xxx_chip_info *chip_info;
 
+	chip_info = i2c_get_match_data(client);
 	/* First check chip-id and product-id */
 	ret = i2c_smbus_read_byte_data(client, MC3230_REG_CHIP_ID);
-	if (ret != MC3230_CHIP_ID)
+	if (ret != chip_info->chip_id) {
+		dev_err(&client->dev,
+		"chip id check fail: 0x%x != 0x%x !\n", ret, chip_info->chip_id);
 		return (ret < 0) ? ret : -ENODEV;
+	}
 
 	ret = i2c_smbus_read_byte_data(client, MC3230_REG_PRODUCT_CODE);
-	if (ret != MC3230_PRODUCT_CODE)
+	if (ret != chip_info->product_code) {
+		dev_err(&client->dev,
+		"product code check fail: 0x%x != 0x%x !\n", ret, chip_info->product_code);
 		return (ret < 0) ? ret : -ENODEV;
+	}
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev) {
@@ -145,10 +175,11 @@ static int mc3230_probe(struct i2c_client *client)
 
 	data = iio_priv(indio_dev);
 	data->client = client;
+	data->chip_info = chip_info;
 	i2c_set_clientdata(client, indio_dev);
 
 	indio_dev->info = &mc3230_info;
-	indio_dev->name = "mc3230";
+	indio_dev->name = chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = mc3230_channels;
 	indio_dev->num_channels = ARRAY_SIZE(mc3230_channels);
@@ -200,13 +231,15 @@ static int mc3230_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(mc3230_pm_ops, mc3230_suspend, mc3230_resume);
 
 static const struct i2c_device_id mc3230_i2c_id[] = {
-	{ "mc3230" },
+	{ "mc3230", (kernel_ulong_t)&mc3xxx_chip_info_tbl[MC3230] },
+	{ "mc3510c", (kernel_ulong_t)&mc3xxx_chip_info_tbl[MC3510C] },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, mc3230_i2c_id);
 
 static const struct of_device_id mc3230_of_match[] = {
-	{ .compatible = "mcube,mc3230" },
+	{ .compatible = "mcube,mc3230", &mc3xxx_chip_info_tbl[MC3230] },
+	{ .compatible = "mcube,mc3510c", &mc3xxx_chip_info_tbl[MC3510C] },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, mc3230_of_match);

-- 
2.47.1



