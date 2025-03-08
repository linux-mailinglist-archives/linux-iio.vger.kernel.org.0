Return-Path: <linux-iio+bounces-16582-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D661A57DE9
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 21:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4916616DE81
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 20:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4A020D4FC;
	Sat,  8 Mar 2025 20:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjAD7tLa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D6D207DEB;
	Sat,  8 Mar 2025 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741464150; cv=none; b=JdO+4AwOuwT5TtJc98/6p3eMxfjCCbeE4CBprlRXSHrykekEBvbBwQqKe5DuaOSxaXVrGRMlEPA44plh/XfdtWfpDAu4/zs8XBlk7D8jHsJyvXqe11gbhdzVvft/n1CeW928Y0DALktCJM303ZIU0ZTryDkmCgRZ2Q0Vcu8XNkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741464150; c=relaxed/simple;
	bh=6otCFNXi8rJDPgtqrJjfodfpkQOsK64XOFGkE+Uqfgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BBQBEjmf7br1hfWBwaZlPEyiloC8SBC/h2gUPMe0kISlUFGTLoeNFwZGYeWIDG9amo0myapnF5RRtxwyNTdPymzYaIwJU4ZWNf5CRd4wo6HdUiqIDrVaxUiYyIfAVcRD96Gh9hE+Epkkr+8MlCEqtxBUHTb0BhpnypUMgCXa1mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjAD7tLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A1B2C4CEEA;
	Sat,  8 Mar 2025 20:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741464150;
	bh=6otCFNXi8rJDPgtqrJjfodfpkQOsK64XOFGkE+Uqfgk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GjAD7tLarSLJnPbzbVGDVjS7QQuGzGP4wqsHwsZAvoCmxj58g8voxsa0gE1OTOuko
	 KKvkMad2SYC+Bq5PmuhTsHhdDl7Ahlcld1dh9UV17RZxdGYwbO7FQp2lYNS8+LbaGz
	 2JIdxiNxcZPzRFhvHge3zMHuiSfQdmbDvWVzcemH/NuHlYOalR6dIn2aI+QipIngFu
	 BEsdODy7CM0TFQAAOnL8hOhZ94ErPqd5hb7JAAqwUrU4ClmM2D2aHr7EnRXnk0lMjk
	 0zVnykA0Agognaz84nwqtMb0cm2e8MXcxlIOtaEto5dPrCHTMOYkbn6n1J3PiUrDZ5
	 zP2D76UieNbdw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23781C28B2F;
	Sat,  8 Mar 2025 20:02:30 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sat, 08 Mar 2025 21:01:00 +0100
Subject: [PATCH 3/4] iio: light: al3010: Implement regmap support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250308-al3010-iio-regmap-v1-3-b672535e8213@ixit.cz>
References: <20250308-al3010-iio-regmap-v1-0-b672535e8213@ixit.cz>
In-Reply-To: <20250308-al3010-iio-regmap-v1-0-b672535e8213@ixit.cz>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Robert Eckelmann <longnoserob@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6586; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=0ARMKIzxYYDa8ckpNzQObR3a0fTEgZFZCzYqD+3QDso=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBnzKJUhbmOjYMI5g7UGr6V86HcY6q1ucYtsjPA5
 eOjXNP1UfaJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ8yiVAAKCRBgAj/E00kg
 ciOcD/9Bgc6DYRtx+1luJ/BNm1QccnBXxKhTRPXthTkXXzodaEbrB1poTZ55hF4E653AeL0Gssp
 aO3nY2MShcnYd/KKTJj/wwYP9HThsB1ove7koTCeR47kQhzPHDyIUQi13iaPCqrG0coKA9XYklH
 vpT0J4AFeoIiEgYHkvygK/FTsBCQjUERCdQ7YNAktoNxPdH1qZXKQxwvQ4ARYdv1M+uyZ7xA1st
 VgyjL5d26ivJkqhIj2nZ0+r/zqKGY9IR5xQ6WNSrdCgndWYQlmjMVFK5vgF7Je0OGfU8Qg51EG4
 WOEKCYwsJUWr1c8UQt8jBi6iK0lbse2bvYsnOR0AEhlgTZf9zsQ0WeUmgDDeKJDRN3Sy8bS1Ef/
 LvDcLgn+7oqs5RvvbtSEnmouPRXpvKjLHcOBda45+hJs7t9VfKpPi0R9ftVBp6qTr/EmZIYU9tJ
 U5i/YGFzIpaQG95IiQOCrqE1ZwyNOhUJHU4Db7mJF0c2ZqZGABpECszHoPPeHDdDBywArJOAtui
 buidRpVxJ5Mb2g6m8ceZgIzESIHK3Pgzcbm1x4bzLyP8pNpFHNFTOH7mwXTGMBP2vqAaQL/0XB0
 VFbwGesLpG5N4ZryAipw1DmgW6B7HSS9AhE2dMmEPfymByhdutbXlnjBA+jZENdyMb/baoZohfs
 Nk5tHI9K2KMmv7Q==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

Modernize and make driver a bit cleaner.

Incorporate most of the feedback given on new AL3000A.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/iio/light/al3010.c | 95 ++++++++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
index 7cbb8b203300907a88f4a0ab87da89cabdd087f3..f6ed7246864a777fdb7d3861b74f5834e8af4105 100644
--- a/drivers/iio/light/al3010.c
+++ b/drivers/iio/light/al3010.c
@@ -4,7 +4,7 @@
  *
  * Copyright (c) 2014, Intel Corporation.
  * Copyright (c) 2016, Dyna-Image Corp.
- * Copyright (c) 2020, David Heidelberg, Michał Mirosław, Dmitry Osipenko
+ * Copyright (c) 2020 - 2025, David Heidelberg, Michał Mirosław, Dmitry Osipenko
  *
  * IIO driver for AL3010 (7-bit I2C slave address 0x1C).
  *
@@ -17,6 +17,7 @@
 #include <linux/bitfield.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 #include <linux/mod_devicetable.h>
 
 #include <linux/iio/iio.h>
@@ -46,8 +47,14 @@ static const int al3010_scales[][2] = {
 	{0, 1187200}, {0, 296800}, {0, 74200}, {0, 18600}
 };
 
+static const struct regmap_config al3010_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = AL3010_REG_CONFIG,
+};
+
 struct al3010_data {
-	struct i2c_client *client;
+	struct regmap *regmap;
 };
 
 static const struct iio_chan_spec al3010_channels[] = {
@@ -69,40 +76,32 @@ static const struct attribute_group al3010_attribute_group = {
 	.attrs = al3010_attributes,
 };
 
-static int al3010_set_pwr(struct i2c_client *client, bool pwr)
+static int al3010_set_pwr_on(struct al3010_data *data)
 {
-	u8 val = pwr ? AL3010_CONFIG_ENABLE : AL3010_CONFIG_DISABLE;
-	return i2c_smbus_write_byte_data(client, AL3010_REG_SYSTEM, val);
+	return regmap_write(data->regmap, AL3010_REG_SYSTEM, AL3010_CONFIG_ENABLE);
 }
 
 static void al3010_set_pwr_off(void *_data)
 {
 	struct al3010_data *data = _data;
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
 
-	al3010_set_pwr(data->client, false);
+	ret = regmap_write(data->regmap, AL3010_REG_SYSTEM, AL3010_CONFIG_DISABLE);
+	if (ret)
+		dev_err(dev, "failed to write system register\n");
 }
 
 static int al3010_init(struct al3010_data *data)
 {
 	int ret;
 
-	ret = al3010_set_pwr(data->client, true);
-	if (ret < 0)
-		return ret;
-
-	ret = devm_add_action_or_reset(&data->client->dev,
-				       al3010_set_pwr_off,
-				       data);
-	if (ret < 0)
-		return ret;
-
-	ret = i2c_smbus_write_byte_data(data->client, AL3010_REG_CONFIG,
-					FIELD_PREP(AL3010_GAIN_MASK,
-						   AL3XXX_RANGE_3));
-	if (ret < 0)
+	ret = al3010_set_pwr_on(data);
+	if (ret)
 		return ret;
 
-	return 0;
+	return regmap_write(data->regmap, AL3010_REG_CONFIG,
+			    FIELD_PREP(AL3010_GAIN_MASK, AL3XXX_RANGE_3));
 }
 
 static int al3010_read_raw(struct iio_dev *indio_dev,
@@ -110,7 +109,7 @@ static int al3010_read_raw(struct iio_dev *indio_dev,
 			   int *val2, long mask)
 {
 	struct al3010_data *data = iio_priv(indio_dev);
-	int ret;
+	int ret, value;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -119,21 +118,21 @@ static int al3010_read_raw(struct iio_dev *indio_dev,
 		 * - low byte of output is stored at AL3010_REG_DATA_LOW
 		 * - high byte of output is stored at AL3010_REG_DATA_LOW + 1
 		 */
-		ret = i2c_smbus_read_word_data(data->client,
-					       AL3010_REG_DATA_LOW);
-		if (ret < 0)
+		ret = regmap_read(data->regmap, AL3010_REG_DATA_LOW, &value);
+		if (ret)
 			return ret;
-		*val = ret;
+
+		*val = value;
+
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		ret = i2c_smbus_read_byte_data(data->client,
-					       AL3010_REG_CONFIG);
-		if (ret < 0)
+		ret = regmap_read(data->regmap, AL3010_REG_CONFIG, &value);
+		if (ret)
 			return ret;
 
-		ret = FIELD_GET(AL3010_GAIN_MASK, ret);
-		*val = al3010_scales[ret][0];
-		*val2 = al3010_scales[ret][1];
+		value = FIELD_GET(AL3010_GAIN_MASK, value);
+		*val = al3010_scales[value][0];
+		*val2 = al3010_scales[value][1];
 
 		return IIO_VAL_INT_PLUS_MICRO;
 	}
@@ -145,7 +144,7 @@ static int al3010_write_raw(struct iio_dev *indio_dev,
 			    int val2, long mask)
 {
 	struct al3010_data *data = iio_priv(indio_dev);
-	int i;
+	unsigned int i;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
@@ -154,9 +153,8 @@ static int al3010_write_raw(struct iio_dev *indio_dev,
 			    val2 != al3010_scales[i][1])
 				continue;
 
-			return i2c_smbus_write_byte_data(data->client,
-					AL3010_REG_CONFIG,
-					FIELD_PREP(AL3010_GAIN_MASK, i));
+			return regmap_write(data->regmap, AL3010_REG_CONFIG,
+					    FIELD_PREP(AL3010_GAIN_MASK, i));
 		}
 		break;
 	}
@@ -172,16 +170,20 @@ static const struct iio_info al3010_info = {
 static int al3010_probe(struct i2c_client *client)
 {
 	struct al3010_data *data;
+	struct device *dev = &client->dev;
 	struct iio_dev *indio_dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
-	data->client = client;
+	data->regmap = devm_regmap_init_i2c(client, &al3010_regmap_config);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(dev, PTR_ERR(data->regmap),
+				     "cannot allocate regmap\n");
 
 	indio_dev->info = &al3010_info;
 	indio_dev->name = AL3010_DRV_NAME;
@@ -191,21 +193,30 @@ static int al3010_probe(struct i2c_client *client)
 
 	ret = al3010_init(data);
 	if (ret < 0) {
-		dev_err(&client->dev, "al3010 chip init failed\n");
+		dev_err(dev, "failed to init ALS\n");
 		return ret;
 	}
 
-	return devm_iio_device_register(&client->dev, indio_dev);
+	ret = devm_add_action_or_reset(dev, al3010_set_pwr_off, data);
+	if (ret < 0)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static int al3010_suspend(struct device *dev)
 {
-	return al3010_set_pwr(to_i2c_client(dev), false);
+	struct al3010_data *data = iio_priv(dev_get_drvdata(dev));
+
+	al3010_set_pwr_off(data);
+	return 0;
 }
 
 static int al3010_resume(struct device *dev)
 {
-	return al3010_set_pwr(to_i2c_client(dev), true);
+	struct al3010_data *data = iio_priv(dev_get_drvdata(dev));
+
+	return al3010_set_pwr_on(data);
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(al3010_pm_ops, al3010_suspend, al3010_resume);

-- 
2.47.2



