Return-Path: <linux-iio+bounces-3841-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF07C88F2D4
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 00:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17ABD1C2B52B
	for <lists+linux-iio@lfdr.de>; Wed, 27 Mar 2024 23:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090AA1553A2;
	Wed, 27 Mar 2024 23:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2s3jI1+/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAA31552E5
	for <linux-iio@vger.kernel.org>; Wed, 27 Mar 2024 23:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711581548; cv=none; b=AobHeXadba4fuzG+7hXcm9ayCNa/bPxsw80+PAuRyXKFYBKZ977a6dDRaZXJ5Us0tg2o/+eSo4p/regSZaYEjew67rj4Tl8iKP/2lwpB08Nvn5kdNv4e6ulaaxdlaFWoicxWuIryMl5P7byQvbJaOmecTkgduCq45PqAkb3VXsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711581548; c=relaxed/simple;
	bh=neFzT6HqcboqV4+7wZk9fLD3RdDZfPvFuSLluIe7M0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZ7uxG86rYvE9uy2pPqGI59DqWWmon+2HQAYPhcsLnHU6B85TGJas/hffGUQvLgRWL0wah63lJwYrPE651JiHDAibGGSjFc5raPlBh3iTtbKBk3TS3aEqH9ZHV8Zk0UK+PmhI26/6iTquhet9c4rHi+YzxUz8wb1t5FzictjGDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2s3jI1+/; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c3e081a2f0so302073b6e.0
        for <linux-iio@vger.kernel.org>; Wed, 27 Mar 2024 16:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711581545; x=1712186345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDy4pTWnkpzbrflLHcGNvhZoR/MRYIqFIu3bxWkx5Ws=;
        b=2s3jI1+/GCM9mQFPftY+sTaEasxKfga3EUkxNyQvN9MMdfwPS/IngP/TfwuOCXPybF
         DDEJ8iKgLcWsmM4cSrdHss9GS0rcRdazB3VAUzBy2OH2o3U8aHL+0LLBk+Qp9zPw3Rs0
         uEtsxhOsRr1EgKFVa5BKQCxkJKyckZXiwZ4WSvLOFwECuRPoOiOnG8K5hMsoSePxE2Wn
         c+Ilaf9yTdI5Icf1VdFkKU6ex+pENSR6HVEl3TDp2Ram2tFIN0gas3q/5kGPsKQrG8o3
         vb80700kjoRYS98SLOaeCMfKRUiDqC7D+Ijq3JAeB0KVfeyZ1MVEiz8q1XJ7d8u1YFkN
         MtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711581545; x=1712186345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDy4pTWnkpzbrflLHcGNvhZoR/MRYIqFIu3bxWkx5Ws=;
        b=Zm8eAdcow2T21cUyupgYiEYi1Kmc3HsdCHChQ3mbL27PJcrP8+/1MDxv4SvwVQKkp5
         y+joqcmXz1QbmJHYPdilAbQuKY1c9upa/qLsOQwAp1xd91dR7vl1Ud/MKTmbwQAMCgxx
         L+nBRDkEaADZgP4b1ZIwhhTWf7ORy7pIwTEX8/TGECX5UulsUEV115BDigaNDABITIzU
         tCk1cGVyOI+RInet1mqZsziA43XXkhFOTJLbCksz3l+aLgna3zTD2C9zOmSq43U4ZaWM
         jdZKTabSIo4aAfKJofR0XytRhBSWnmNiSfprXfKQhT91R55erI6KFP3iYa+pxcfhtS65
         557g==
X-Forwarded-Encrypted: i=1; AJvYcCVIxYirFpuSG58mG6MJRZKMAa/tO6KVdOMqqMP4QoQzGWyXFg7ZKpQRyw7HEIsssjk2dCxnpoLdoLYs6Pzhwe8e71b0I8PjBPq7
X-Gm-Message-State: AOJu0YwR/0g8zUJa9uQQhN7keuegLif089It7DzVL32KXmKm5MBv8VNU
	CpRDuKLs1zdjQ1X8VPWfDMh65Uu25cHLWVMydZVzcBYBk7XrspWhDkHwSsTVqZg=
X-Google-Smtp-Source: AGHT+IGRFIewUZzJjdav0VooP65bH9hr9ECiT789M34rqrspoxpzTHpgVb/U1H59dfHvPYlK2YUMpA==
X-Received: by 2002:a05:6871:29a:b0:221:b27a:2bab with SMTP id i26-20020a056871029a00b00221b27a2babmr1185697oae.55.1711581544880;
        Wed, 27 Mar 2024 16:19:04 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id js3-20020a056870bac300b0022a0519183csm81381oab.2.2024.03.27.16.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 16:19:04 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Support Opensource <support.opensource@diasemi.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-input@vger.kernel.org
Subject: [PATCH RFC 2/7] hwmon: (adc128d818) Use devm_regulator_get_optional_enable_get_voltage()
Date: Wed, 27 Mar 2024 18:18:51 -0500
Message-ID: <20240327-regulator-get-enable-get-votlage-v1-2-5f4517faa059@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240327-regulator-get-enable-get-votlage-v1-0-5f4517faa059@baylibre.com>
References: <20240327-regulator-get-enable-get-votlage-v1-0-5f4517faa059@baylibre.com>
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
function by using devm_regulator_get_optional_enable_get_voltage().

A new external_vref flag is added since we no longer have the handle
to the regulator to check if it is present.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/hwmon/adc128d818.c | 55 ++++++++++++++--------------------------------
 1 file changed, 17 insertions(+), 38 deletions(-)

diff --git a/drivers/hwmon/adc128d818.c b/drivers/hwmon/adc128d818.c
index 46e3c8c50765..119e2841720f 100644
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
@@ -430,30 +429,25 @@ static int adc128_init_client(struct adc128_data *data)
 static int adc128_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
-	struct regulator *regulator;
 	struct device *hwmon_dev;
 	struct adc128_data *data;
-	int err, vref;
+	bool external_vref;
+	int err;
 
 	data = devm_kzalloc(dev, sizeof(struct adc128_data), GFP_KERNEL);
 	if (!data)
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
+	err = devm_regulator_get_optional_enable_get_voltage(dev, "vref");
+	if (err == -ENODEV) {
+		external_vref = false;
 		data->vref = 2560;	/* 2.56V, in mV */
+	} else if (err < 0) {
+		return err;
+	} else {
+		external_vref = true;
+		data->vref = DIV_ROUND_CLOSEST(err, 1000);
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
 
@@ -476,31 +469,18 @@ static int adc128_probe(struct i2c_client *client)
 	mutex_init(&data->update_lock);
 
 	/* Initialize the chip */
-	err = adc128_init_client(data);
+	err = adc128_init_client(data, external_vref);
 	if (err < 0)
-		goto error;
+		return err;
 
 	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
 							   data, adc128_groups);
 	if (IS_ERR(hwmon_dev)) {
 		err = PTR_ERR(hwmon_dev);
-		goto error;
+		return err;
 	}
 
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
@@ -522,7 +502,6 @@ static struct i2c_driver adc128_driver = {
 		.of_match_table = of_match_ptr(adc128_of_match),
 	},
 	.probe		= adc128_probe,
-	.remove		= adc128_remove,
 	.id_table	= adc128_id,
 	.detect		= adc128_detect,
 	.address_list	= normal_i2c,

-- 
2.43.2


