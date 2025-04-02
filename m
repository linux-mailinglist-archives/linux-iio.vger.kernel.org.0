Return-Path: <linux-iio+bounces-17556-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FA7A795E5
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 21:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9964C1892AFC
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 19:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138141EDA04;
	Wed,  2 Apr 2025 19:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THbQJsqw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7AC13635E;
	Wed,  2 Apr 2025 19:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743622412; cv=none; b=B9PHSihQ/lWWj8N3/wCYgfj9xFF+4f0ODwBFRDpaWofwDEDriNoTk2meeh6/7Tag8Zcvx61snsohFfdIJwGL/sZkB2vbiE+XT1pAJr+pkG36EXtU4zEKFGStDuigFydLmitDpoBt2B+wUTj3jVhq+TrDJpK7lBphRv595o+rGew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743622412; c=relaxed/simple;
	bh=GD1mfBzXCt0cgDgeoYjhc5hkgaAZktPHxYCmSLS1h0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mn704I0eHLs7BoqLrI93h1xDktWqv2ZXF+w+lQNIR4fVBkk61RWpWfNQMBI1H9L/3Z8vurUpcs/6CmYR1J/qVYI42jdOfQllsB9W9Q4CWVUj9OfISDI3bqfKyiPeXcVWPCkKTlOzLOHa6COvizZQv0DaQtTw/uN3YObPpts4wWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THbQJsqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62E40C4CEEF;
	Wed,  2 Apr 2025 19:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743622412;
	bh=GD1mfBzXCt0cgDgeoYjhc5hkgaAZktPHxYCmSLS1h0I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=THbQJsqwfZ9Kv42AwxphMriqBl1tdE0lAu2kQqbDmGqBtSC9Usj/MEg+UH1sEXAH1
	 UJo0ddBEDui3qqo7pZk9FVeKhWP2zcUth1dXaHXLOw3ZWUd4yC/Tv07fdOT38zsszg
	 gpHoTpSNOPbbi5KoYo6qexxjlXC7x6oog0EsZ2tHHEAi+YvEn7EC+cVnMQiwCzCYLC
	 QPgZowp8On3YROj6opJu6oKxrz3zSalVf6soII7x2pGWFklTlFfmzjH2WRkUjA7PhF
	 Xa/8jWFBftKEYTEzg7uIRBq15Cu8dAmM08v9+31PfEoOGxILdtCyaVIaKMFl5H96dQ
	 BfAjAfjaR7QfA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5859AC3601B;
	Wed,  2 Apr 2025 19:33:32 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 02 Apr 2025 21:33:27 +0200
Subject: [PATCH v4 4/5] iio: light: al3010: Implement regmap support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-al3010-iio-regmap-v4-4-d189bea87261@ixit.cz>
References: <20250402-al3010-iio-regmap-v4-0-d189bea87261@ixit.cz>
In-Reply-To: <20250402-al3010-iio-regmap-v4-0-d189bea87261@ixit.cz>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Robert Eckelmann <longnoserob@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5389; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=xLXsAL6IdnDjFhJIlqoCoKr7hx9rtDUHioMAjUgCuVg=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn7ZEK1PisZ3DA8tTFzQ7YNrhqQdK4MjHjULRwe
 Nd4nNUg4LOJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ+2RCgAKCRBgAj/E00kg
 cqUqEACzIR7MO8Hq9NtE5+/vnPb8Yq4bEg53p26e09ClAISxRv/O/TekJYo8Xa+8SUvW3uhQPWC
 ARkPCjQStdSdZ0EoygNSwLEt8kKIkV0c21IDdArIlnLkEzuAvMSV7CbeE0y3K8sHbu1FqSA+Co2
 WS3yPWmAz34UMiupn8Srp+KuGvo8gS6mirsrV5tg3lspAlC+Ov1qDBIpNOb6aHpERo7z7a1Wd2r
 tZYLk1hwzn1p1dg6GruRePXnK7NJi8RDaUrhlpIUozmDeWR9hR4IlHoFU1ESB/pU5jfGcMf5puN
 bRahgTn3Ohr4jUvaVzadL4P1FW9vEZ+UCA2C2r9Hgkn8juRh5c0nk02PCyEuPlpJvtQr6DaGBf8
 YZej64VCxA8NxMmjkTPB+W8ExYL7RRzIE8oqjCZ3oXQpfvvHH5iE2ObGv+lrDYc69q3l5J05Mq7
 QvrxjOraNSUyDEwl8lMeHrPFzwduBi6AEdMiG9wpczCCtpyMyb9Y5Qoqf6KgZnqCIfV72CMs4Hd
 qFHe7dNBWI6G5FRio3Yqt2lVlmxwuDZY1bhz4IQa8C/bRJrpr+z4UkexnAeGrN6c2kBhg569KO+
 2dp8hbIkrZJEZH0u/AyJNopc/gbYyrc1/pU0hCcDeBljB6WciEdbA2PCAAvnipEFEpmT2pRQt/O
 OBqJI5wwhZW5PHw==
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
 drivers/iio/light/al3010.c | 77 +++++++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
index 34a29a51c5f9e8aa143d3ba195b79a19793e4f88..d4c9a6e5c415269332dda67622b17b46fb157218 100644
--- a/drivers/iio/light/al3010.c
+++ b/drivers/iio/light/al3010.c
@@ -17,6 +17,7 @@
 #include <linux/bitfield.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 #include <linux/mod_devicetable.h>
 
 #include <linux/iio/iio.h>
@@ -44,8 +45,14 @@ static const int al3010_scales[][2] = {
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
@@ -67,41 +74,37 @@ static const struct attribute_group al3010_attribute_group = {
 	.attrs = al3010_attributes,
 };
 
-static int al3010_set_pwr_on(struct i2c_client *client)
+static int al3010_set_pwr_on(struct al3010_data *data)
 {
-	return i2c_smbus_write_byte_data(client, AL3010_REG_SYSTEM,
-					 AL3010_CONFIG_ENABLE);
+	return regmap_write(data->regmap, AL3010_REG_SYSTEM, AL3010_CONFIG_ENABLE);
 }
 
 static void al3010_set_pwr_off(void *_data)
 {
 	struct al3010_data *data = _data;
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
 
-	i2c_smbus_write_byte_data(data->client, AL3010_REG_SYSTEM,
-				  AL3010_CONFIG_DISABLE);
+	ret = regmap_write(data->regmap, AL3010_REG_SYSTEM, AL3010_CONFIG_DISABLE);
+	if (ret)
+		dev_err(dev, "failed to write system register\n");
 }
 
 static int al3010_init(struct al3010_data *data)
 {
+	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 
-	ret = al3010_set_pwr_on(data->client);
-	if (ret < 0)
+	ret = al3010_set_pwr_on(data);
+	if (ret)
 		return ret;
 
-	ret = devm_add_action_or_reset(&data->client->dev,
-				       al3010_set_pwr_off,
-				       data);
+	ret = devm_add_action_or_reset(dev, al3010_set_pwr_off, data);
 	if (ret)
-		return dev_err_probe(&data->client->dev, ret, "failed to add action\n");
-
-	ret = i2c_smbus_write_byte_data(data->client, AL3010_REG_CONFIG,
-					FIELD_PREP(AL3010_GAIN_MASK,
-						   AL3XXX_RANGE_3));
-	if (ret < 0)
-		return ret;
+		return dev_err_probe(dev, ret, "failed to add action\n");
 
-	return 0;
+	return regmap_write(data->regmap, AL3010_REG_CONFIG,
+			    FIELD_PREP(AL3010_GAIN_MASK, AL3XXX_RANGE_3));
 }
 
 static int al3010_read_raw(struct iio_dev *indio_dev,
@@ -109,7 +112,7 @@ static int al3010_read_raw(struct iio_dev *indio_dev,
 			   int *val2, long mask)
 {
 	struct al3010_data *data = iio_priv(indio_dev);
-	int ret;
+	int ret, gain, raw;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -118,21 +121,21 @@ static int al3010_read_raw(struct iio_dev *indio_dev,
 		 * - low byte of output is stored at AL3010_REG_DATA_LOW
 		 * - high byte of output is stored at AL3010_REG_DATA_LOW + 1
 		 */
-		ret = i2c_smbus_read_word_data(data->client,
-					       AL3010_REG_DATA_LOW);
-		if (ret < 0)
+		ret = regmap_read(data->regmap, AL3010_REG_DATA_LOW, &raw);
+		if (ret)
 			return ret;
-		*val = ret;
+
+		*val = raw;
+
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		ret = i2c_smbus_read_byte_data(data->client,
-					       AL3010_REG_CONFIG);
-		if (ret < 0)
+		ret = regmap_read(data->regmap, AL3010_REG_CONFIG, &gain);
+		if (ret)
 			return ret;
 
-		ret = FIELD_GET(AL3010_GAIN_MASK, ret);
-		*val = al3010_scales[ret][0];
-		*val2 = al3010_scales[ret][1];
+		gain = FIELD_GET(AL3010_GAIN_MASK, gain);
+		*val = al3010_scales[gain][0];
+		*val2 = al3010_scales[gain][1];
 
 		return IIO_VAL_INT_PLUS_MICRO;
 	}
@@ -153,9 +156,8 @@ static int al3010_write_raw(struct iio_dev *indio_dev,
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
@@ -181,7 +183,10 @@ static int al3010_probe(struct i2c_client *client)
 
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
-	data->client = client;
+	data->regmap = devm_regmap_init_i2c(client, &al3010_regmap_config);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(dev, PTR_ERR(data->regmap),
+				     "cannot allocate regmap\n");
 
 	indio_dev->info = &al3010_info;
 	indio_dev->name = "al3010";
@@ -206,7 +211,9 @@ static int al3010_suspend(struct device *dev)
 
 static int al3010_resume(struct device *dev)
 {
-	return al3010_set_pwr_on(to_i2c_client(dev));
+	struct al3010_data *data = iio_priv(dev_get_drvdata(dev));
+
+	return al3010_set_pwr_on(data);
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(al3010_pm_ops, al3010_suspend, al3010_resume);

-- 
2.49.0



