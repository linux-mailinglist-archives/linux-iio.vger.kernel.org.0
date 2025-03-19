Return-Path: <linux-iio+bounces-17126-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08898A69A6B
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 22:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136188A588B
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 20:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F45219E93;
	Wed, 19 Mar 2025 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAg8szp0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F5B215792;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742417986; cv=none; b=IYrJvFG8wdSn9OmMa3GHi6QeRPu1sthMcHmM0DVx5MNsIDrYF/GXhV96BYUPsBsegKjFjpjdlQ87Eohqqxb7R+IsgFYEn+67pRCUHNN7sFRreePOHHS9J+whHIFt0Rw+Mp25Dym0aO/YUEEml2WlNTbwkMVvwArVm6cTfgjHTZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742417986; c=relaxed/simple;
	bh=HlqGSpQH8OKsmLbqZc6BB4OlujKzK+8Vy2q3EvYfcic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cV12weSEHfJNNTTd4GT9uQMrYhot+CwSdMkREP5mUz86wuT90I35D0SHqPvz5mpfxtIKKxNwYYlVU+AQmJ16INSNTlz/W4kvPrB3O+DscRYKtuBAbz8NEr7noPbGa81tqf5k2vDTdwJt3TSwMAuvANlsYGCGBPgljOAIqZYCPj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAg8szp0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9ECDC4CEFF;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742417985;
	bh=HlqGSpQH8OKsmLbqZc6BB4OlujKzK+8Vy2q3EvYfcic=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UAg8szp0Yj6j0B1RM1vDs3/LykoppwNLG21/hY9j0wBMJtgoFu7kcGxw0ZWnh+Hr/
	 HYVB57AVa5dw+7E6qBZfVqJDVIK1b2hTqutp5z3GbtUUSd6JTidtztWza+Z1CWCd8v
	 eouaNFQVrAcbcJXcBhzrn2YiRCvrbtxPa4MxLbPgZg/OAGgMYCIHtrs9fnYkI22ynU
	 19GqcogaZHgOMmxhkDA2WHkXgawVTNJVYzYLJpIJpYlHjsll6u38H6xrPpsyvC3bE6
	 F27Ccfezksy7t89CRpet6a377A6FQXBqeQo9Epq8SBuJTsxL7BhQe/YNg7Q75lrBXs
	 b5b/VOI+G8JBA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FB7C35FFA;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 19 Mar 2025 21:59:52 +0100
Subject: [PATCH v2 13/13] iio: light: al3320a: Implement regmap support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-al3010-iio-regmap-v2-13-1310729d0543@ixit.cz>
References: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
In-Reply-To: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Robert Eckelmann <longnoserob@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5559; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=bnMzXmnoT68yZfBO8ZVJqfaFZx4Hg8RoMkkxAEWajno=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn2zA+aaQy4IJXR6bGl8obK0Hj1/nZ+/reD0Ilu
 01/9BrmahOJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ9swPgAKCRBgAj/E00kg
 cjI7EACs3xekAQOLmIXXZwlMeXBMghSmyBpQx/e1qzrkgVc+xbJ5JOVgamKIkD8WGJG+0CDhN7A
 Qyr3ur6KBOvEkLkoJWW0oyv54k6CIWGhcYNLPQBh1TBEiByIavO30hdM1cFbE68pDCFSzdoOFco
 6jeczP3Zenopo8HL//LyZJ+wWcqpyHj42MWe1czChocgBY+oY4oLuPP7Tkm7wY+AtLuxnir3K4l
 qZ1hpMLfQFVAmcXipxwx2RQqajGvL+l5Z8p+jiqDnKhfkfi/8TLm6M7z8mzB2IBB/wvCIH9QSWD
 afuvvjSXpC4+A2tI1CbOv56WB/xK9IPsLGvmqmhyqqI7JIQfoDmTlJmk3v8VcWSMEwnstr5EWxj
 qiXro/a+qedPecj8XsVzAY6QLkBt00/Gh+gDzElgCUaS74pLkiBPIwaYjuNxQtEzU/YgY4PoATx
 sSsQ6Gce7w3xb3OIsoyTkUZOrp57tzc4SK+yjreZyLhnZALLXMt3ER1Z18XAGEHY2uz0gDzS87z
 LtEVBRL77YDiMlkieqY/3Az4YaX9wCFkhIvyVvhpTP/A47DA18pCmWNt8AWnFUz6EgbI0SUHaui
 SiCRVqt4qQFGNezxYQ2nkxDStuSpyu0MDdtGKxJD6JiU1/d86p1+e5vibH/zuDeaVdqXZBawGg9
 5LulEQf5/vR3s2g==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

Modernize and make driver a bit cleaner.

After the regmap implementation, the compiler is able to produce
much smaller module.

Size before: 72 kB
Size after:  58 kB

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/iio/light/al3320a.c | 82 +++++++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
index 1943e6f34a70b00b5d732dbf4ae6ccb4376303b7..dc9534195e1db9366a5307b84eeab96b99f16b96 100644
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
@@ -80,44 +87,42 @@ static const struct attribute_group al3320a_attribute_group = {
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
-		return ret;
-
-	ret = i2c_smbus_write_byte_data(data->client, AL3320A_REG_CONFIG_RANGE,
-					FIELD_PREP(AL3320A_GAIN_MASK,
-						   AL3320A_RANGE_3));
-	if (ret < 0)
+	ret = al3320a_set_pwr_on(data);
+	if (ret)
 		return ret;
 
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
@@ -125,7 +130,7 @@ static int al3320a_read_raw(struct iio_dev *indio_dev,
 			    int *val2, long mask)
 {
 	struct al3320a_data *data = iio_priv(indio_dev);
-	int ret;
+	int ret, gain, raw;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -134,21 +139,21 @@ static int al3320a_read_raw(struct iio_dev *indio_dev,
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
@@ -169,9 +174,8 @@ static int al3320a_write_raw(struct iio_dev *indio_dev,
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
@@ -197,7 +201,11 @@ static int al3320a_probe(struct i2c_client *client)
 
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
@@ -226,7 +234,9 @@ static int al3320a_suspend(struct device *dev)
 
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



