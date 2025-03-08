Return-Path: <linux-iio+bounces-16583-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB16FA57DEA
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 21:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4915A1892B30
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 20:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D99D20D4FE;
	Sat,  8 Mar 2025 20:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dq2prbBS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82BD2080FD;
	Sat,  8 Mar 2025 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741464150; cv=none; b=su5To1QS5/gwJ2KaHQZebhL7hBK3iy9bKUqN37q5qNFAdF8v/pDrf0309jT3HBFc/HZmpaVbs4eOb6K3fV0J4Js+VBnEkjSdD8HbaZkOYga48bnMogeePipW0jQ/D29sMNSc7xFiV1mqCrMQ/uiYO8EfW8BIJhl33nPsYn2rs/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741464150; c=relaxed/simple;
	bh=FbwfoFA9TUfwf9Q1WJyzp7VxofeoHXHrNGqGmADWW5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fnEsmW1E2ZDisU1ankORNTK9G/Zu2CYmQ8W/W6A78tmDYBTU4TpqvJUe5ahiiBiGL/2hLQyFTa1d3JurUuGNeuBKOczys1DGfiJALVeDhunDDciPtMt7YLdbOJLc1+5OmRLwHGCbwKU1+DUNwHgqTm/OJC3A6u6HcMd7ATRWBOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dq2prbBS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 480DEC4CEED;
	Sat,  8 Mar 2025 20:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741464150;
	bh=FbwfoFA9TUfwf9Q1WJyzp7VxofeoHXHrNGqGmADWW5g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dq2prbBSx6MnMHCQZdrPD3ML6cGNQbalkeDqncDsB23q3/YMhjeP4qK/FP4WRlV2R
	 ELB4QZXMYBhKvO8NN47A+9/T2eDKwhD0y5XoVoPRcuGwlzY0WSW9C0VikU/egE3riY
	 PzEa3yuEQOYXUsFSPaBLa0SZEQcaDRyVYBhSJfH6UVglm5IKNSKUDN3TsJNLX3y4pm
	 mvfQNxAmTVYNwajd6Q4Gs6ABC1bkz9kxVv+Q51jHVHAzuCO2H/+oEHK9kFuIiAJNF6
	 cdB4iEe/Ok8o35n1Sxt1J0QqkvPlM7zOciRJkoyqh72UX1X5fRKPMw1IVlrT1W3WF/
	 3X0XaNwD4uFCQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A832C28B31;
	Sat,  8 Mar 2025 20:02:30 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sat, 08 Mar 2025 21:01:01 +0100
Subject: [PATCH 4/4] iio: light: al3320a: Implement regmap support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-al3010-iio-regmap-v1-4-b672535e8213@ixit.cz>
References: <20250308-al3010-iio-regmap-v1-0-b672535e8213@ixit.cz>
In-Reply-To: <20250308-al3010-iio-regmap-v1-0-b672535e8213@ixit.cz>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Robert Eckelmann <longnoserob@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6797; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=5I6aLiVBvHlW9GqP9cewvJ+GzQ5KKG9d4c1w8WEv3k4=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBnzKJUKSj+aSO7mnAWNa2/OCRt+uzxahs6/j9FY
 vOe9ckR53mJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ8yiVAAKCRBgAj/E00kg
 cu6ZEACNLmmqM1HzvFOBITah4KysNN7aImTh9WaoMLNrxeIbt/FD8lUmWA1dhB1qJC+rFCMojmB
 J/yJ+EbFtG6WrbkvAmWqheN5Yfyx16gbp4y1g7poVc46Gnimdnh/6pya8SolmXJM6csw3ZaxqAg
 6VaICjlDub6b/O7qXxy5qLrEDfYmaBdj2oD2AGAwYBUNm4H31cOEAAZ0J7LmKLvY5d42rmOZf5y
 S4mKqT809e92ZzadxfpuSut6u7ubsylvuq/d5tYv75gu/B76eW6xCCvGLWN77lbryRO9ZJMJAPu
 t2enaOq7fgAZ0WjE/inMxVoIxBFLisk4alEBFGV80kyRZzX4IkNfdJuF+7bX2oNYUg2llw5L8NA
 ehuPu7SeO2u51WnbBf1WeQlVg3ckEjaSJT87DJ6zuvjw9l1AUKaaqzufrT5wtN5xe113mDGHA9J
 ZVkfB2oC75mGLtM/PtoboetdWrme7n8u/Ibg1hQ7Tc4g0BrcjZOcXsvKgrpVxWAeuPlbB+hcFVW
 zDn4drWY7enPaYxuhLp+SuJQPEOW6fsPwng+tM11GW/9keO5qudO8J8W/fMu0Y0GS5xzQHO3qDt
 y9UCwbhf6MRw/aWgAofh+UkIZxzhCCn1yLY28/9WyIj6ph+CuMAea0J/wF6kmMPK/FR+QMlzTfL
 7bEj9bGkM24oeuA==
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
 drivers/iio/light/al3320a.c | 101 ++++++++++++++++++++++++--------------------
 1 file changed, 56 insertions(+), 45 deletions(-)

diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
index d34a91fdafa0affad4665d995e1f66d2aaa0373b..208b4f212f3543557e99342630c92f5e6bdaf05d 100644
--- a/drivers/iio/light/al3320a.c
+++ b/drivers/iio/light/al3320a.c
@@ -15,6 +15,7 @@
 #include <linux/bitfield.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 #include <linux/mod_devicetable.h>
 
 #include <linux/iio/iio.h>
@@ -59,8 +60,14 @@ static const int al3320a_scales[][2] = {
 	{0, 512000}, {0, 128000}, {0, 32000}, {0, 10000}
 };
 
+static const struct regmap_config al3320a_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = AL3320A_REG_HIGH_THRESH_HIGH,
+};
+
 struct al3320a_data {
-	struct i2c_client *client;
+	struct regmap *regmap;
 };
 
 static const struct iio_chan_spec al3320a_channels[] = {
@@ -82,45 +89,42 @@ static const struct attribute_group al3320a_attribute_group = {
 	.attrs = al3320a_attributes,
 };
 
-static int al3320a_set_pwr(struct i2c_client *client, bool pwr)
+static int al3320a_set_pwr_on(struct al3320a_data *data)
 {
-	u8 val = pwr ? AL3320A_CONFIG_ENABLE : AL3320A_CONFIG_DISABLE;
-	return i2c_smbus_write_byte_data(client, AL3320A_REG_CONFIG, val);
+	return regmap_write(data->regmap, AL3320A_REG_CONFIG, AL3320A_CONFIG_ENABLE);
 }
 
 static void al3320a_set_pwr_off(void *_data)
 {
 	struct al3320a_data *data = _data;
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
 
-	al3320a_set_pwr(data->client, false);
+	ret = regmap_write(data->regmap, AL3320A_REG_CONFIG, AL3320A_CONFIG_DISABLE);
+	if (ret)
+		dev_err(dev, "failed to write system register\n");
 }
 
 static int al3320a_init(struct al3320a_data *data)
 {
 	int ret;
 
-	ret = al3320a_set_pwr(data->client, true);
-
-	if (ret < 0)
+	ret = al3320a_set_pwr_on(data);
+	if (ret)
 		return ret;
 
-	ret = i2c_smbus_write_byte_data(data->client, AL3320A_REG_CONFIG_RANGE,
-					FIELD_PREP(AL3320A_GAIN_MASK,
-						   AL3320A_RANGE_3));
-	if (ret < 0)
-		return ret;
-
-	ret = i2c_smbus_write_byte_data(data->client, AL3320A_REG_MEAN_TIME,
-					AL3320A_DEFAULT_MEAN_TIME);
-	if (ret < 0)
+	ret = regmap_write(data->regmap, AL3320A_REG_CONFIG_RANGE,
+			   FIELD_PREP(AL3320A_GAIN_MASK, AL3320A_RANGE_3));
+	if (ret)
 		return ret;
 
-	ret = i2c_smbus_write_byte_data(data->client, AL3320A_REG_WAIT,
-					AL3320A_DEFAULT_WAIT_TIME);
-	if (ret < 0)
+	ret = regmap_write(data->regmap, AL3320A_REG_MEAN_TIME,
+			   AL3320A_DEFAULT_MEAN_TIME);
+	if (ret)
 		return ret;
 
-	return 0;
+	return regmap_write(data->regmap, AL3320A_REG_WAIT,
+			    AL3320A_DEFAULT_WAIT_TIME);
 }
 
 static int al3320a_read_raw(struct iio_dev *indio_dev,
@@ -128,7 +132,7 @@ static int al3320a_read_raw(struct iio_dev *indio_dev,
 			    int *val2, long mask)
 {
 	struct al3320a_data *data = iio_priv(indio_dev);
-	int ret;
+	int ret, value;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -137,21 +141,21 @@ static int al3320a_read_raw(struct iio_dev *indio_dev,
 		 * - low byte of output is stored at AL3320A_REG_DATA_LOW
 		 * - high byte of output is stored at AL3320A_REG_DATA_LOW + 1
 		 */
-		ret = i2c_smbus_read_word_data(data->client,
-					       AL3320A_REG_DATA_LOW);
-		if (ret < 0)
+		ret = regmap_read(data->regmap, AL3320A_REG_DATA_LOW, &value);
+		if (ret)
 			return ret;
-		*val = ret;
+
+		*val = value;
+
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		ret = i2c_smbus_read_byte_data(data->client,
-					       AL3320A_REG_CONFIG_RANGE);
-		if (ret < 0)
+		ret = regmap_read(data->regmap, AL3320A_REG_CONFIG_RANGE, &value);
+		if (ret)
 			return ret;
 
-		ret = FIELD_GET(AL3320A_GAIN_MASK, ret);
-		*val = al3320a_scales[ret][0];
-		*val2 = al3320a_scales[ret][1];
+		value = FIELD_GET(AL3320A_GAIN_MASK, value);
+		*val = al3320a_scales[value][0];
+		*val2 = al3320a_scales[value][1];
 
 		return IIO_VAL_INT_PLUS_MICRO;
 	}
@@ -163,7 +167,7 @@ static int al3320a_write_raw(struct iio_dev *indio_dev,
 			     int val2, long mask)
 {
 	struct al3320a_data *data = iio_priv(indio_dev);
-	int i;
+	unsigned int i;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
@@ -172,9 +176,8 @@ static int al3320a_write_raw(struct iio_dev *indio_dev,
 			    val2 != al3320a_scales[i][1])
 				continue;
 
-			return i2c_smbus_write_byte_data(data->client,
-					AL3320A_REG_CONFIG_RANGE,
-					FIELD_PREP(AL3320A_GAIN_MASK, i));
+			return regmap_write(data->regmap, AL3320A_REG_CONFIG_RANGE,
+					    FIELD_PREP(AL3320A_GAIN_MASK, i));
 		}
 		break;
 	}
@@ -190,16 +193,21 @@ static const struct iio_info al3320a_info = {
 static int al3320a_probe(struct i2c_client *client)
 {
 	struct al3320a_data *data;
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
+
+	data->regmap = devm_regmap_init_i2c(client, &al3320a_regmap_config);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(dev, PTR_ERR(data->regmap),
+				     "cannot allocate regmap\n");
 
 	indio_dev->info = &al3320a_info;
 	indio_dev->name = AL3320A_DRV_NAME;
@@ -209,27 +217,30 @@ static int al3320a_probe(struct i2c_client *client)
 
 	ret = al3320a_init(data);
 	if (ret < 0) {
-		dev_err(&client->dev, "al3320a chip init failed\n");
+		dev_err(dev, "failed to init ALS\n");
 		return ret;
 	}
 
-	ret = devm_add_action_or_reset(&client->dev,
-					al3320a_set_pwr_off,
-					data);
+	ret = devm_add_action_or_reset(dev, al3320a_set_pwr_off, data);
 	if (ret < 0)
 		return ret;
 
-	return devm_iio_device_register(&client->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static int al3320a_suspend(struct device *dev)
 {
-	return al3320a_set_pwr(to_i2c_client(dev), false);
+	struct al3320a_data *data = iio_priv(dev_get_drvdata(dev));
+
+	al3320a_set_pwr_off(data);
+	return 0;
 }
 
 static int al3320a_resume(struct device *dev)
 {
-	return al3320a_set_pwr(to_i2c_client(dev), true);
+	struct al3320a_data *data = iio_priv(dev_get_drvdata(dev));
+
+	return al3320a_set_pwr_on(data);
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(al3320a_pm_ops, al3320a_suspend,

-- 
2.47.2



