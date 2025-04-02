Return-Path: <linux-iio+bounces-17552-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCEDA795B4
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 21:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B92AD1710C0
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 19:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F064C1EB18F;
	Wed,  2 Apr 2025 19:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzhYOeS4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A5C1E9907;
	Wed,  2 Apr 2025 19:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743621305; cv=none; b=eWAko5hzwwQ9+kgt1vfmwel47Qkj6qi5BngQg5Ks4zPGZmGMpLHktK7T2ys0N8wnULDtNHYk12+OCqrqcJjnH1Q/T/PcG/6BZRBjPJeYXnpMbw1Rjc1WDFPnCLZG2kXAwCWYvb/xPpOmHC5ozfd08SRuuhSaa0xyVorlcOUCkn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743621305; c=relaxed/simple;
	bh=/6ORwPGEylk2ensJ45ZIl+JuJVNYG1Rvk/NerUkupug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V5UohpC9Ci6YuYPzuKjcRVlAXioRVfmAt1yEhta5ewxEPK3Dmi9EeLIF7GiJSc7pL+78asKGPGhX9oJjpJ15aZ4X+dtENMtflO10vUfmERK1hx1L83sK+f/2l0ORFzx3AJgfV/YHrLe6Z+tp0kitYUGQ5rGrn+p5wByaOBKkR+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzhYOeS4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B141C4CEEA;
	Wed,  2 Apr 2025 19:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743621305;
	bh=/6ORwPGEylk2ensJ45ZIl+JuJVNYG1Rvk/NerUkupug=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PzhYOeS4NRLsh4sJf+eypzdtQPJJxbI3KdhTBTmR0KJgQqMhHXj4PoMYSR7I4c0vk
	 rhcXGW5M9WQMt4hTgHjDM0zB+poLLZno9n1tY9qrdHZsU7LF9N/KpLLL9iC40V7Pmv
	 oQjcbov0CjyaZodOAGwSmXbZDUlmboTPKShiCU4/7LT0C0skkoFXLlPENABvDgEfN9
	 zkJFGn/Z7NUwq5Mj/f+QuEkXayIX2Kn5frzgI65KI0CPM95JsqmKQ/aaLQ1G/iwjTE
	 +kVRE0Rg6FYgWOOowDzU+c7QyStLSTBbuTzHrWh+zvPMpnjiUSO8lR2EodG9r4TaKp
	 FbskvvKeG0ZWQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CB4C3601B;
	Wed,  2 Apr 2025 19:15:05 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 02 Apr 2025 21:14:17 +0200
Subject: [PATCH v3 5/5] iio: light: al3320a: Implement regmap support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-al3010-iio-regmap-v3-5-cc3da273b5b2@ixit.cz>
References: <20250402-al3010-iio-regmap-v3-0-cc3da273b5b2@ixit.cz>
In-Reply-To: <20250402-al3010-iio-regmap-v3-0-cc3da273b5b2@ixit.cz>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Robert Eckelmann <longnoserob@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5785; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=VF2IB659WVA5EWuUppV3rVlQHRbT5K4V8Zm1qxQVpcY=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn7Yy3UYYbdVwzWjvefWbwlC9fPFuWVa7X+c7J7
 glWpj6MxlSJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ+2MtwAKCRBgAj/E00kg
 cnieEADOUjVWO+EZ7SnPPLT/MviCrwZLrkrhnBolAMv/Mc9PWIh5Frxn77DKupA0yQlvNw4wSx0
 rqV3rk3g70E0v/hr3Xchouc9htwHFLMqwLY4POatTRIH83HvX8BvTACMT2xxHhCGcdxEdz57Uby
 uJ5GJxfOPn59l6wfgsG/gc7JXH0HUYUoWFAq61IGyD5/XZ16J3XW1eeJ7vad5b8fvWta644tSlz
 TKB4n+cF6yQA5mV9lfoSZqs/3mfjon7M5Opt/HKvkzuH8QLg7s7RGHCCufwU2C348OZGTgg5Oa8
 RyA4WuygFPrBYWY+38Pk64b+Q932ZOgKG5GNkjmxOtKfGcHtf5/U3S3331xlf/0DqFg1SS95voE
 f7BGR3I5R81U0U2l00q5rI+CPmaC7EnpwwWGQEOaq4na+ZYK5GfuFYErwkkzrm4+OOR6Fo590vw
 dipW06/DWvZqKN+uSeBbjvRkbsAS8aFz231pplz7KpEutM1ocyzX7Wnd+izdHtzS6Jy5J0no3zq
 5MiYZKLyo23Jd4UwIzcOJUmBkZgOGomYkZLk1A/9AJqiX3pYV00OhVgtWkSJHJV4HyEVuT/BhQI
 Mrfgocgel+YmxN+iM0Inss30L4K/Ewifwdd3B/kp9e50mhvOszCY3ztpuLSP9i1qjx043OzmfFr
 ZiINJ5K29vUxqSA==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

Modernize and clean up the driver using the regmap framework.

With the regmap implementation, the compiler produces
a significantly smaller module.

Size before: 72 kB
Size after:  58 kB

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/iio/light/al3320a.c | 82 +++++++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
index 005a7664568667b5cf9419baba6764f7b4e8fc39..05b6ec217ee8103e3527948aa2da1af75c2a495e 100644
--- a/drivers/iio/light/al3320a.c
+++ b/drivers/iio/light/al3320a.c
@@ -15,6 +15,7 @@
 #include <linux/bitfield.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 #include <linux/mod_devicetable.h>
 
 #include <linux/iio/iio.h>
@@ -57,8 +58,14 @@ static const int al3320a_scales[][2] = {
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
@@ -80,25 +87,28 @@ static const struct attribute_group al3320a_attribute_group = {
 	.attrs = al3320a_attributes,
 };
 
-static int al3320a_set_pwr_on(struct i2c_client *client)
+static int al3320a_set_pwr_on(struct al3320a_data *data)
 {
-	return i2c_smbus_write_byte_data(client, AL3320A_REG_CONFIG, AL3320A_CONFIG_ENABLE);
+	return regmap_write(data->regmap, AL3320A_REG_CONFIG, AL3320A_CONFIG_ENABLE);
 }
 
 static void al3320a_set_pwr_off(void *_data)
 {
 	struct al3320a_data *data = _data;
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
 
-	i2c_smbus_write_byte_data(data->client, AL3320A_REG_CONFIG, AL3320A_CONFIG_DISABLE);
+	ret = regmap_write(data->regmap, AL3320A_REG_CONFIG, AL3320A_CONFIG_DISABLE);
+	if (ret)
+		dev_err(dev, "failed to write system register\n");
 }
 
 static int al3320a_init(struct al3320a_data *data)
 {
 	int ret;
 
-	ret = al3320a_set_pwr_on(data->client);
-
-	if (ret < 0)
+	ret = al3320a_set_pwr_on(data);
+	if (ret)
 		return ret;
 
 	ret = devm_add_action_or_reset(&data->client->dev,
@@ -107,23 +117,18 @@ static int al3320a_init(struct al3320a_data *data)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to add action\n");
 
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
@@ -131,7 +136,7 @@ static int al3320a_read_raw(struct iio_dev *indio_dev,
 			    int *val2, long mask)
 {
 	struct al3320a_data *data = iio_priv(indio_dev);
-	int ret;
+	int ret, gain, raw;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -140,21 +145,21 @@ static int al3320a_read_raw(struct iio_dev *indio_dev,
 		 * - low byte of output is stored at AL3320A_REG_DATA_LOW
 		 * - high byte of output is stored at AL3320A_REG_DATA_LOW + 1
 		 */
-		ret = i2c_smbus_read_word_data(data->client,
-					       AL3320A_REG_DATA_LOW);
-		if (ret < 0)
+		ret = regmap_read(data->regmap, AL3320A_REG_DATA_LOW, &raw);
+		if (ret)
 			return ret;
-		*val = ret;
+
+		*val = raw;
+
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		ret = i2c_smbus_read_byte_data(data->client,
-					       AL3320A_REG_CONFIG_RANGE);
-		if (ret < 0)
+		ret = regmap_read(data->regmap, AL3320A_REG_CONFIG_RANGE, &gain);
+		if (ret)
 			return ret;
 
-		ret = FIELD_GET(AL3320A_GAIN_MASK, ret);
-		*val = al3320a_scales[ret][0];
-		*val2 = al3320a_scales[ret][1];
+		gain = FIELD_GET(AL3320A_GAIN_MASK, gain);
+		*val = al3320a_scales[gain][0];
+		*val2 = al3320a_scales[gain][1];
 
 		return IIO_VAL_INT_PLUS_MICRO;
 	}
@@ -175,9 +180,8 @@ static int al3320a_write_raw(struct iio_dev *indio_dev,
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
@@ -203,7 +207,11 @@ static int al3320a_probe(struct i2c_client *client)
 
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
-	data->client = client;
+
+	data->regmap = devm_regmap_init_i2c(client, &al3320a_regmap_config);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(dev, PTR_ERR(data->regmap),
+				     "cannot allocate regmap\n");
 
 	indio_dev->info = &al3320a_info;
 	indio_dev->name = "al3320a";
@@ -230,7 +238,9 @@ static int al3320a_suspend(struct device *dev)
 
 static int al3320a_resume(struct device *dev)
 {
-	return al3320a_set_pwr_on(to_i2c_client(dev));
+	struct al3320a_data *data = iio_priv(dev_get_drvdata(dev));
+
+	return al3320a_set_pwr_on(data);
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(al3320a_pm_ops, al3320a_suspend,

-- 
2.49.0



