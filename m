Return-Path: <linux-iio+bounces-17125-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E53A69A74
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 22:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE33483960
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 21:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E88219E8C;
	Wed, 19 Mar 2025 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFIaRP/m"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9EA2153FC;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742417986; cv=none; b=g1oONO5oByQ048j+UMXpy4h6Q9DuuteCjC/nluF7gm244X4WVhCiBtDpF5O28h+pc+VHvcbI2PHpGDkinN4FhkFZCKs5VoiMcb9H/ear+8mRiYv2+C+dNz/rHHqgkBVvjgNQ6g/zMgk2JK7NuemMzqGUXLcIji+cP7lyMp42qJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742417986; c=relaxed/simple;
	bh=IGkg4ybk/fFAAJaDocAv5wPTYmjsGrL/ufyf1jfMDio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ledt3jyi6gbLe/3FM7FViuksE2RQLbxQs27KUlLV0TAMyhrI7Tli+xkvdhsmfRj6ExBxtFNVDMFGBrTka+vOpWZxAb4cxHrwRaVV/7DGKAcrHezCpxBa5N7ngEzK0X2gXsgQqR36OdannSAQfe4ZulN9IdBwiijl14p7A7Izcrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFIaRP/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB0D9C4CEFE;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742417985;
	bh=IGkg4ybk/fFAAJaDocAv5wPTYmjsGrL/ufyf1jfMDio=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bFIaRP/maoKhPB4AzcxGkefv3fKrgz7hDKK0vB2W91+O8j6wwO0Fx19FPGsClfhVk
	 59fV/BHZZa584Gt6kdOZfBFUWxzaUt8jX4kmN2D0sb3yfVlIxzAwTbSob9O2IiYW75
	 TB8QhyWFHLjjDB4Vm35O1NgdWCH+UWa8sn7huO+tLqt1XvppEoaJuYxyVSsj3Mx4vo
	 PKE3vSRSo1U4LnOpzh2yvx4RMFS8PHF2Rdr7OVz4TyxXGgbiohy7F0KkQavwR/vRyv
	 g5Q0u12lMHZhOEKVJHj42JFiSn5B0mp6WUCs41EPQqkAIyW13hvTsDNeGBIQZy+Jh/
	 HpCZUdhxINEHg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DB1C36000;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 19 Mar 2025 21:59:51 +0100
Subject: [PATCH v2 12/13] iio: light: al3010: Implement regmap support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-al3010-iio-regmap-v2-12-1310729d0543@ixit.cz>
References: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
In-Reply-To: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Robert Eckelmann <longnoserob@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4984; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=si5i/P1Y4ZQEes9Htrsr4D8xcLlkLp6GlW5byhVEUIE=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn2zA+qJJaVc2brmiCAtLHdeOmMKYWWqoS1BKoN
 K5dgXgAVU6JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ9swPgAKCRBgAj/E00kg
 cnubD/9t4zOwfIXNrdNxXqi/xfxbkZh2H2KzL7Lmcz0pfAelXcPo1Fx8LG1rFpkw8+oCa/JVkLy
 lNUBQH5mntARqP52dFutobvYv5fNYA5LgP9uu0l8l86ostuKUyQpY5Np/bhFP55w3vWxfpI1Fn4
 f/fBhY1Wk8u9kRDeXirh5y1Cdt8JWC37w4xZ1eLPhb+h8ZLNbB6fMesACDW/yOkQ3OYLC+QAKY/
 RDqsXW7/nOaWnHImK6fMNl/6NYSSc4vxykhfgF0e0SCv+e/eFUOE78P+JWzSuJ8QBpgpBMn4tvR
 sUh/pPfeEwxPr+GHQNF79Njym4QeorNWZhZlbgo7co9C2okenoC5uOg4KTgVujilmslKGYc+z1i
 /aargYf7Vx0bBkBNh/owhQ3v12ksrU4nexcxl3nQElgODEspetNmyQiZG12Dpl6/8ekmitEd4wW
 iir1miFaW/NMObiEEJn8Eyb5+hmPDEp+wEoD3II5BvgYGFRz0a10aZG7tHPd1v6UOc3fMmLHc0x
 wkdm5vXK73/S/i0oQtRncqrOJ/WRG/2BvIOA2lB5pwQS8nNx7IouFeVebAqW7fIliLbSaUrR2/0
 NFxdKxbudoNRJj7pGAnuPumJ17KAGLglIRntXI5yHlf2nSpKSIW2GuU6F731kkYnp+gjObNUcF2
 obIZjyUH9GReFgg==
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
 drivers/iio/light/al3010.c | 70 ++++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
index af7ed028259837f2232f30072b87cc0da7c77f37..04d9d49ef20930f47b642ef118514be6e016368a 100644
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
@@ -67,35 +74,32 @@ static const struct attribute_group al3010_attribute_group = {
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
@@ -103,7 +107,7 @@ static int al3010_read_raw(struct iio_dev *indio_dev,
 			   int *val2, long mask)
 {
 	struct al3010_data *data = iio_priv(indio_dev);
-	int ret;
+	int ret, gain, raw;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -112,21 +116,21 @@ static int al3010_read_raw(struct iio_dev *indio_dev,
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
@@ -147,9 +151,8 @@ static int al3010_write_raw(struct iio_dev *indio_dev,
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
@@ -175,7 +178,10 @@ static int al3010_probe(struct i2c_client *client)
 
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
-	data->client = client;
+	data->regmap = devm_regmap_init_i2c(client, &al3010_regmap_config);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(dev, PTR_ERR(data->regmap),
+				     "cannot allocate regmap\n");
 
 	indio_dev->info = &al3010_info;
 	indio_dev->name = "al3010";
@@ -204,7 +210,9 @@ static int al3010_suspend(struct device *dev)
 
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



