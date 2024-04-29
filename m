Return-Path: <linux-iio+bounces-4658-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D43798B667E
	for <lists+linux-iio@lfdr.de>; Tue, 30 Apr 2024 01:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E7741F232F8
	for <lists+linux-iio@lfdr.de>; Mon, 29 Apr 2024 23:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E8F199EB2;
	Mon, 29 Apr 2024 23:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QHghTFco"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1843F194C73
	for <linux-iio@vger.kernel.org>; Mon, 29 Apr 2024 23:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714434040; cv=none; b=CpUhbKUoGddReXAb3o4rQf5u4VrJOTs21U9Xklmu3I2duVIiQWA7K4ief1Flbw01X45h9O+h5986QNg9R5RRNXCcxrwB5Q5EMnZm0tqWv8IoOXvuTaMtpl9rBwctMTYx1AKPYVCtgOnKCJoQwGJbiVNf+pSbfdBk3/5mn/58ZFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714434040; c=relaxed/simple;
	bh=FxpiwVEGKQscfaIrKjDK4V3875jn6xFnM8mM/zDKOGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OqEaMsO/bv1Mr67fiwWA2Q3tz+78x2JvmmU1izYCzouujomlortR3OOrOofdzhBR8jVqfyOAIn07Zltps+oC0FOFa2jPntqfosWIvdaarzMfGAt15IkAdHJgKM5Ce1jFT5CPHhF/2E6dCO1gDTNz/0tbXd4alTra7FxiOmFRmns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QHghTFco; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-23a6a8e9978so2239417fac.3
        for <linux-iio@vger.kernel.org>; Mon, 29 Apr 2024 16:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714434036; x=1715038836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCu+RSrpWOgpCZSyomahXHu6xaI4OOMemllTcAyzYVE=;
        b=QHghTFco/zn/C7GqSoc3lNXuq0jTvpQ/JqEjfbqDbonhTVUtLd3/fJLiZsp8U6rYOB
         5a/YiM7+GorUDXJvIJULOD7ah1COUSyfeikBmReiLOrTspre3k2kMG5MiRESOwmesINN
         wDnxn4VlCPBMHyxpv0dMJK1/6omEHRW0Fz85mFNfNpKkVb/7qFjbANf5QKwj9byr1JRB
         FLsL/H5ng6I4BGADhWywr8ai9lNbMuvay6F4msrhs3IhwnsNK606l6tA3WZxDIvSLlkp
         dRY3ypyHTch7KjBrxHf8InljEOn/OV3hshj0u6/om1HUbFoj2KF+0/m1EVoNCnbXtFPq
         H6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714434036; x=1715038836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCu+RSrpWOgpCZSyomahXHu6xaI4OOMemllTcAyzYVE=;
        b=rDdpcr7MR1DPk4oKfdkGO/D3rpPzOD+U8EefnEs+zj070iZXmkzwTbBYBDaOzuUxnh
         Bl2GMxwLauTwDYN5bu9hae9uMDVbdi84cjEhELIAgMaAZ0L4dhMx2aksg9Uk3/4HDyJy
         JmiSyNbGpv6S9Gd3CXRo5Vcu3KxV1Kri9QjG54jc6ajcWnE2JWUpEhNGSIhMnr9F7Cpg
         yk+5IjcDCntJ04jflGwCypTD7IngbVtSIAtT7txzlIo6F7ZI19OqlCFGdZOmo8mq/2Vh
         pZj8sm7jfv4rK7XRIh2IjPDWp6dH8I7LdUsQgzmYEy12cCVNv3yrnonWsCpNq9qxJ1yJ
         3CMw==
X-Forwarded-Encrypted: i=1; AJvYcCXtah0tL6uMcamng74DdNddCoVCR4Vcqaw53B9HqDsIsGhjUS8dmH0AAOs2XJoVcmz0xs6dExWbFKFYJ0+s/3+dgz/M7NIME29Q
X-Gm-Message-State: AOJu0Yx1sb5mb14HtoASKpBvxdp8duYEqO3//AQF7pXttDlIJTvhc7Oc
	QxTPqTRxOKSjFF746dzNaU2EPX77QDPpt2NOm3XuAp9NnPErKk3dQkS9fxKddfc=
X-Google-Smtp-Source: AGHT+IHvFRkfpRvjsc3KUb2Jg1DqGyd2+WOnB4xcy/LRQ+hoCXNoFpQKjrtG95po28kNgaZ1HyBPmQ==
X-Received: by 2002:a05:6870:d911:b0:232:fb5e:c23b with SMTP id gq17-20020a056870d91100b00232fb5ec23bmr16803310oab.26.1714434036129;
        Mon, 29 Apr 2024 16:40:36 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id hp22-20020a0568709a9600b0023b58aa20afsm2144508oab.25.2024.04.29.16.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 16:40:35 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Support Opensource <support.opensource@diasemi.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-input@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 2/7] hwmon: (adc128d818) Use devm_regulator_get_enable_read_voltage()
Date: Mon, 29 Apr 2024 18:40:10 -0500
Message-ID: <20240429-regulator-get-enable-get-votlage-v2-2-b1f11ab766c1@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240429-regulator-get-enable-get-votlage-v2-0-b1f11ab766c1@baylibre.com>
References: <20240429-regulator-get-enable-get-votlage-v2-0-b1f11ab766c1@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

We can reduce boilerplate code and eliminate the driver remove()
function by using devm_regulator_get_enable_read_voltage().

A new external_vref flag is added since we no longer have the handle
to the regulator to check if it is present.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:
* rename to devm_regulator_get_enable_read_voltage()
* use vref instead of err for return value
* simplify last error check to return PTR_ERR directly
---
 drivers/hwmon/adc128d818.c | 57 ++++++++++++++--------------------------------
 1 file changed, 17 insertions(+), 40 deletions(-)

diff --git a/drivers/hwmon/adc128d818.c b/drivers/hwmon/adc128d818.c
index 46e3c8c50765..2a35acb011eb 100644
--- a/drivers/hwmon/adc128d818.c
+++ b/drivers/hwmon/adc128d818.c
@@ -58,7 +58,6 @@ static const u8 num_inputs[] = { 7, 8, 4, 6 };
 
 struct adc128_data {
 	struct i2c_client *client;
-	struct regulator *regulator;
 	int vref;		/* Reference voltage in mV */
 	struct mutex update_lock;
 	u8 mode;		/* Operation mode */
@@ -389,7 +388,7 @@ static int adc128_detect(struct i2c_client *client, struct i2c_board_info *info)
 	return 0;
 }
 
-static int adc128_init_client(struct adc128_data *data)
+static int adc128_init_client(struct adc128_data *data, bool external_vref)
 {
 	struct i2c_client *client = data->client;
 	int err;
@@ -408,7 +407,7 @@ static int adc128_init_client(struct adc128_data *data)
 		regval |= data->mode << 1;
 
 	/* If external vref is selected, configure the chip to use it */
-	if (data->regulator)
+	if (external_vref)
 		regval |= 0x01;
 
 	/* Write advanced configuration register */
@@ -430,9 +429,9 @@ static int adc128_init_client(struct adc128_data *data)
 static int adc128_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
-	struct regulator *regulator;
 	struct device *hwmon_dev;
 	struct adc128_data *data;
+	bool external_vref;
 	int err, vref;
 
 	data = devm_kzalloc(dev, sizeof(struct adc128_data), GFP_KERNEL);
@@ -440,20 +439,15 @@ static int adc128_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	/* vref is optional. If specified, is used as chip reference voltage */
-	regulator = devm_regulator_get_optional(dev, "vref");
-	if (!IS_ERR(regulator)) {
-		data->regulator = regulator;
-		err = regulator_enable(regulator);
-		if (err < 0)
-			return err;
-		vref = regulator_get_voltage(regulator);
-		if (vref < 0) {
-			err = vref;
-			goto error;
-		}
-		data->vref = DIV_ROUND_CLOSEST(vref, 1000);
-	} else {
+	vref = devm_regulator_get_enable_read_voltage(dev, "vref");
+	if (vref == -ENODEV) {
+		external_vref = false;
 		data->vref = 2560;	/* 2.56V, in mV */
+	} else if (vref < 0) {
+		return vref;
+	} else {
+		external_vref = true;
+		data->vref = DIV_ROUND_CLOSEST(vref, 1000);
 	}
 
 	/* Operation mode is optional. If unspecified, keep current mode */
@@ -461,13 +455,12 @@ static int adc128_probe(struct i2c_client *client)
 		if (data->mode > 3) {
 			dev_err(dev, "invalid operation mode %d\n",
 				data->mode);
-			err = -EINVAL;
-			goto error;
+			return -EINVAL;
 		}
 	} else {
 		err = i2c_smbus_read_byte_data(client, ADC128_REG_CONFIG_ADV);
 		if (err < 0)
-			goto error;
+			return err;
 		data->mode = (err >> 1) & ADC128_REG_MASK;
 	}
 
@@ -476,31 +469,16 @@ static int adc128_probe(struct i2c_client *client)
 	mutex_init(&data->update_lock);
 
 	/* Initialize the chip */
-	err = adc128_init_client(data);
+	err = adc128_init_client(data, external_vref);
 	if (err < 0)
-		goto error;
+		return err;
 
 	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
 							   data, adc128_groups);
-	if (IS_ERR(hwmon_dev)) {
-		err = PTR_ERR(hwmon_dev);
-		goto error;
-	}
+	if (IS_ERR(hwmon_dev))
+		return PTR_ERR(hwmon_dev);
 
 	return 0;
-
-error:
-	if (data->regulator)
-		regulator_disable(data->regulator);
-	return err;
-}
-
-static void adc128_remove(struct i2c_client *client)
-{
-	struct adc128_data *data = i2c_get_clientdata(client);
-
-	if (data->regulator)
-		regulator_disable(data->regulator);
 }
 
 static const struct i2c_device_id adc128_id[] = {
@@ -522,7 +500,6 @@ static struct i2c_driver adc128_driver = {
 		.of_match_table = of_match_ptr(adc128_of_match),
 	},
 	.probe		= adc128_probe,
-	.remove		= adc128_remove,
 	.id_table	= adc128_id,
 	.detect		= adc128_detect,
 	.address_list	= normal_i2c,

-- 
2.43.2


