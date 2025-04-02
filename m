Return-Path: <linux-iio+bounces-17549-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374C2A795B1
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 21:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 961E87A1A58
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 19:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E8D1DE2BB;
	Wed,  2 Apr 2025 19:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGoMlOT3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D30C1E5B82;
	Wed,  2 Apr 2025 19:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743621305; cv=none; b=UTU+PW9hzRwQ8dB/ReOdmC5akeQz5gNstq7j3X/JAEfKHFSfVzTil2WG/H9dmlEq7RtYcLrSBEHQJFYiAFvqx1ZW2XTNxNPqiSE7PVZl76JALbStgsg4JMIxOVaxp4F1MMoeKViW4Yct1HiRypTmAgwsSVKZrwl3w5V/UvizFdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743621305; c=relaxed/simple;
	bh=bLvZgpoRz8jPTh6lztF4LgifJrv5YjqT/zfMYLdKTtQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RubK9Z5zKyB6wHIHaAspCJyLoLkVzla6QfCcGdx5DdUY20foeT4eA7Y0szsrjZD6Wr6J4sXhjH6le4sHEotbgZ9NFlFljEtLxcV3IU7PpDZs9MWang1Mxfg/NOICblCSwBvhkr5DhQcFMmkjFBTjn2LkheDkPAjm5Ra0UaI5TMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGoMlOT3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BEF3C4CEEF;
	Wed,  2 Apr 2025 19:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743621305;
	bh=bLvZgpoRz8jPTh6lztF4LgifJrv5YjqT/zfMYLdKTtQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sGoMlOT3vJS/TpvtfN9gVMLFn+sUX2ShdsJYsVg6Dmfwvk5SeDzxaafguJ86GuOYa
	 PQ6KixY8CWTZZN2M+9L5P4C999M+22/EGQAsdZg3JdltyRm8KVaQQodTmUmpL/kJ5f
	 Z+W3DwMaqS2Zja8YndiJ3yNKjwD22eTdRfK0RtKNbVIATUj5POnG/W4qP+u2Vz5BGk
	 m0oBTW2gJwQCM4JYZaTKbVqkSj25rUodC2t/+aQNQcPJOGzjtuuKeqWEeWzyKnFxvQ
	 s71gash6ghZmQzuWL/TtJPdteH4uxAQuRRYx7hFHiez0lmqpp2vSibgmP0JrA6wzvy
	 acGsZdq703VaQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330AFC36018;
	Wed,  2 Apr 2025 19:15:05 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 02 Apr 2025 21:14:16 +0200
Subject: [PATCH v3 4/5] iio: light: al3010: Implement regmap support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-al3010-iio-regmap-v3-4-cc3da273b5b2@ixit.cz>
References: <20250402-al3010-iio-regmap-v3-0-cc3da273b5b2@ixit.cz>
In-Reply-To: <20250402-al3010-iio-regmap-v3-0-cc3da273b5b2@ixit.cz>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Robert Eckelmann <longnoserob@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5266; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=4vlK8//koSebmXkgSEu7I6tvaU7BCe4QTWz6vNOOPy4=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn7Yy3dSiY3P5FEwr6FbRuqLC2xrgbJeThC+Aj0
 5TxyVY4uTKJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ+2MtwAKCRBgAj/E00kg
 cpcmD/4gg5LEUZZjOsXWowRTOCXw6XaR+zbllg5MjXNsezuh27prCaaUs7I57Ey7ZDkAhgz+SNz
 b1aEFuOzT9GY0InUWymY460jXCw+FpWsZp2YV1Co59V6/9o9Vt1YO9B6S+YYPsaJyEM9Ep352zs
 CBYORfKjdILSG/hYQl2FHjE2a9B7S2Cgnj4EL8coOlxLipMdcOruN59OwdXCnm6N6JDVeE1L69n
 5FGnm4MkWuMWZl1Y1YEXxRCY+ayVhEuzIJKfmtkC5HfkdZNa0EzeDyaV+lJbKskaKhbu9pgajgu
 pq40UWcjWKryw065sXmeLzXlXJs7ZiUG6Iyei38lv5Nc5x3pUaGpaRvSPndgejPlMUUpX9wD0+O
 IGeNYnZv0ESk5VzX5/o0U6tF+PBK4WXs7ui4xl5Gdi/bqEpAm73Pz5Pcdam3RlLHZLcOGjP75S1
 2PimfxbXqIb+pnf4aLFeFs7cySLFKxBwc3rOOrIIDCG32A+bkR+9F3Q+hsyo66pKBTky2bo/Sb2
 o30K6GWfj/Eb13u96Mw28vDW7wRnZhbR+FPUNqjtL4XdPaPCG1ziWrh1GDxHvQ7eSvtoEzvfhOi
 IX04Cfl11QXK/TH7JeMCn3swZt1zFXVKLBivBkX78wm0Z48xqmrYdMMhKJhlfbn66pO4HR6R069
 42VvoDiPnJ5sVew==
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
 drivers/iio/light/al3010.c | 72 +++++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
index 0fcf4253864843142f1a7c61c9a92dcfbdf72a60..03ea3c7c03fbdb4e818a6524a1c6f2209320753b 100644
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
@@ -67,41 +74,38 @@ static const struct attribute_group al3010_attribute_group = {
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
 	int ret;
 
-	ret = al3010_set_pwr_on(data->client);
-	if (ret < 0)
+	ret = al3010_set_pwr_on(data);
+	if (ret)
 		return ret;
 
 	ret = devm_add_action_or_reset(&data->client->dev,
 				       al3010_set_pwr_off,
 				       data);
 	if (ret)
-		return dev_err_probe(dev, ret, "failed to add action\n");
-
-	ret = i2c_smbus_write_byte_data(data->client, AL3010_REG_CONFIG,
-					FIELD_PREP(AL3010_GAIN_MASK,
-						   AL3XXX_RANGE_3));
-	if (ret < 0)
-		return ret;
+		return dev_err_probe(&data->client->dev, ret, "failed to add action\n");
 
-	return 0;
+	return regmap_write(data->regmap, AL3010_REG_CONFIG,
+			    FIELD_PREP(AL3010_GAIN_MASK, AL3XXX_RANGE_3));
 }
 
 static int al3010_read_raw(struct iio_dev *indio_dev,
@@ -109,7 +113,7 @@ static int al3010_read_raw(struct iio_dev *indio_dev,
 			   int *val2, long mask)
 {
 	struct al3010_data *data = iio_priv(indio_dev);
-	int ret;
+	int ret, gain, raw;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -118,21 +122,21 @@ static int al3010_read_raw(struct iio_dev *indio_dev,
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
@@ -153,9 +157,8 @@ static int al3010_write_raw(struct iio_dev *indio_dev,
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
@@ -181,7 +184,10 @@ static int al3010_probe(struct i2c_client *client)
 
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
-	data->client = client;
+	data->regmap = devm_regmap_init_i2c(client, &al3010_regmap_config);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(dev, PTR_ERR(data->regmap),
+				     "cannot allocate regmap\n");
 
 	indio_dev->info = &al3010_info;
 	indio_dev->name = "al3010";
@@ -206,7 +212,9 @@ static int al3010_suspend(struct device *dev)
 
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



