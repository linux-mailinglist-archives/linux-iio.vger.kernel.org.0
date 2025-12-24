Return-Path: <linux-iio+bounces-27349-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD05CDB6C1
	for <lists+linux-iio@lfdr.de>; Wed, 24 Dec 2025 06:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A0653086C8F
	for <lists+linux-iio@lfdr.de>; Wed, 24 Dec 2025 05:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645352517AC;
	Wed, 24 Dec 2025 05:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RydVFW1K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616122E1722
	for <linux-iio@vger.kernel.org>; Wed, 24 Dec 2025 05:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766554651; cv=none; b=M+/MESXT3ClGvACZkAz9ZBFziOK7JUqAkfkanBvXWm7mKvL3slGKrEHmL9es6j3DbdSfa2sdhI/ysaagpOUnP1yPaqOKP7gGGZCmJ/49vAGN7i5tcI2uAp4lt2VPY5KPAear86Tr/td7Hc4AT7i2RrOZksww3H8M1KSoD4NqqRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766554651; c=relaxed/simple;
	bh=cjUg0AYH48wLnJQtKo5oNwmm0Gt8Cb1FVV1mMjM1uoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ozMuYTB2RzgKnAqST3pTv+5oMsbZQ5Wn0DoJtyl8MKju9fB2hDiquiunjfmpqXQlIr9f8H9K/kzhLw7Nta7mCrdAr6ARu1JmSg6xjaJN2ypzcihuAomuNQnJ1ijmZ7lF1Ln1l7c5mo+q5e8fHIkpPicDWIB14GwOQVreyb7jAsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RydVFW1K; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7b6dd81e2d4so5898524b3a.0
        for <linux-iio@vger.kernel.org>; Tue, 23 Dec 2025 21:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766554649; x=1767159449; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gPsYHGDCdSqdXlYFEwPAX1QjkmAlAOGnYX3XMfo9iss=;
        b=RydVFW1KIjwz1WB5mY8EE5jBFMbcc3arCadco1hX+cBFjbkDKsQim2JfIDqRTmhKw7
         WF3asWQZ7pISzG4qEzeBj8k+h+T8XrxfzFfKCG2E8Xdhdbw6ZVZvZQVFqVD6swzyeIUj
         FFg7JQy1Qlrtb7y9mAhkgT9XAOqaCFyKtcjaat8NeFPMVOqLq19+uJ5zKRLxGF3qQ1C8
         g1rDkay8I/2OrWRAHVLBVxR08/wjsaflejAMOFC12kVQ74dlY+EBtFfCuDsDF538Dz7s
         vggoqskjLB/AmJbVduvwyVFeAujW3QKHG0Yg86WhPYOXQdiciUz70B+890W6eq+ttBcx
         DSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766554649; x=1767159449;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gPsYHGDCdSqdXlYFEwPAX1QjkmAlAOGnYX3XMfo9iss=;
        b=mLonFqnWi5DQtlFeKr6de26XOaov0hjqNU7D1xh5oLf36xFOcNOmA0/ghHtsqwdn6Q
         945tiwYKjXB5uUdBCnRluYZjIuI9lf/qOCx+7jJfLFyAtBhx0Iwf8BM4c0E2aBvnzlI8
         RWzcun+xh1JDyHSmE4BvONzMxHlFJapcyge0KzaiDriq8lKbMvxrGAOCt5vqFq4zpYeh
         g0j684bL62ZBmitORpiU+36sIcpflQXfsVQGuy5Hi4v66PXxbDYWkcZK+Di+iPIwJYNz
         wHb/lc6U4Z9Jj7UqW6iwV2jH8KD/HNVOGzohpvfsfEFvcqw6CwzvrraC+loWBkqrkm2i
         P4vg==
X-Forwarded-Encrypted: i=1; AJvYcCXnR60HRMiE6OHExIcHBDLAmE/nLSpwqGXSU6uxNcvb+/F/idTjoi3OuxCjO6bnAdRagKojxU0WExY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVRFYEYHrppQGEIOu40YSlnNZkUHo8IjsjaRKmMGskl3B+7w/6
	bEz36tw+Y1rQnWEEWSHo2iM0JiqfCk/uZcaaZpDkYWLxIo/OzTL2NZLwViLs8Q==
X-Gm-Gg: AY/fxX4KzNGEvciWO9eTdotL2CNA1LjWmJr6SynzTqZA+5w5oLm92GXAhZS3pbFX/Hp
	mH2Tn1KfjNgqq9FmSkwsBovM1f7hMiFIse4ywPNHn/n24yXA78j86my1mov9AfPmlYTGLU7r4XX
	i8jkTSBSYdLeWaV8rJvuAesorha3dlTpHl/rqFLiOPyLGt+QmrUDqHFIPOztHoACh/b1hPJSuwF
	lkqeD5wi11NdRk8QLUIQXz37g+mgDPNKoaiX3NDI1CFWMSopFHLqzIZDGaBoFv+4vZxT6C62C0M
	xR7W18BaxGc8faCjv/nVutr2t3aPMIIXRHXUAIlVZcrPqeBbXzngBf01unygrh+RhORptuO90id
	EwP6eWTSImq+ppToFHhxQMlj+IST4ts6apIERca32vYJVA8/acWM/7v/hDZLlRAged1RNdqIgo5
	5ZqrbqENPLz01h7TT9nJA3xo3whQla28mzcAwJe/IzmZ1uq78pucs=
X-Google-Smtp-Source: AGHT+IEc3Oz8jvN7Pk9BkuP7OHjMSdV6mtgCRxxfx2CAgsyqy7ICmNWKMAzAlRq3A2p/HRbyJ0F3Ig==
X-Received: by 2002:a05:6a00:e11:b0:7f7:a2f:aef4 with SMTP id d2e1a72fcca58-7ff64ece91fmr13273719b3a.29.1766554648597;
        Tue, 23 Dec 2025 21:37:28 -0800 (PST)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e588a30sm15540214b3a.55.2025.12.23.21.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 21:37:28 -0800 (PST)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Wed, 24 Dec 2025 13:37:15 +0800
Subject: [PATCH v2 2/2] iio: adc: ltc2309: add support for ltc2305
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251224-add_ltc2305_driver-v2-2-061f78cf45a3@gmail.com>
References: <20251224-add_ltc2305_driver-v2-0-061f78cf45a3@gmail.com>
In-Reply-To: <20251224-add_ltc2305_driver-v2-0-061f78cf45a3@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hsieh <kylehsieh1995@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4154;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=cjUg0AYH48wLnJQtKo5oNwmm0Gt8Cb1FVV1mMjM1uoU=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBpS3wQL1uQIAdKzmLPmGJrJ1gBoyTk82zWUqsHc
 NOqlRAYV0WJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCaUt8EAAKCRClg0K3CVbE
 gT9cB/wO/BFC5YmQ/emm1OyASrSnGXvCbv29Hc7gtDDctpHJUzqPgni6pmBvmIMowvTxktJLfeq
 PmGGQamcC2X4D4FcqYoeshBEbHmhy9waFZ70SBin+7+X5wrSC8k7zRAbho5UQM1wJCkNcOlvrsU
 CR3S7ZtMGtChrVWp8YuDu2/izMSQnR2J44cs3V0jofP0MPW7EuyvUQ68yL0PI9xMhPrGdm9hZRD
 tI7RiGJlRzfadFzCxn6hWdeNr0KuL5aFix9N4Rky9jL+6eF6jw1I2+faO9SjEtTCJHB3sVm+AXT
 OpBYZW8GyeUmdzcdFO03AHFNGZWXNeP4zpjNNbzrmsjxUM5n
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Add support for the 2-channel LTC2305 ADC in the existing LTC2309 driver.
The LTC2305 and LTC2309 share similar features: both are 12-bit,
low-noise, low-power SAR ADCs with an I2C interface.
The main difference is the number of channels: LTC2305 has 2 channels,
while LTC2309 has 8 channels.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
 drivers/iio/adc/ltc2309.c | 51 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ltc2309.c b/drivers/iio/adc/ltc2309.c
index 5f0d947d0615..0cf9bcae36c8 100644
--- a/drivers/iio/adc/ltc2309.c
+++ b/drivers/iio/adc/ltc2309.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * The LTC2305 is a  2-Channel, 12-Bit SAR ADC with an I2C Interface.
  * The LTC2309 is an 8-Channel, 12-Bit SAR ADC with an I2C Interface.
  *
  * Datasheet:
+ * https://www.analog.com/media/en/technical-documentation/data-sheets/23015fb.pdf
  * https://www.analog.com/media/en/technical-documentation/data-sheets/2309fd.pdf
  *
  * Copyright (c) 2023, Liam Beguin <liambeguin@gmail.com>
@@ -41,6 +43,13 @@ struct ltc2309 {
 };
 
 /* Order matches expected channel address, See datasheet Table 1. */
+enum ltc2305_channels {
+	LTC2305_CH0_CH1 = 0,
+	LTC2305_CH1_CH0,
+	LTC2305_CH0,
+	LTC2305_CH1,
+};
+
 enum ltc2309_channels {
 	LTC2309_CH0_CH1 = 0,
 	LTC2309_CH2_CH3,
@@ -80,6 +89,13 @@ enum ltc2309_channels {
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
 }
 
+static const struct iio_chan_spec ltc2305_channels[] = {
+	LTC2309_CHAN(0, LTC2305_CH0),
+	LTC2309_CHAN(1, LTC2305_CH1),
+	LTC2309_DIFF_CHAN(0, 1, LTC2305_CH0_CH1),
+	LTC2309_DIFF_CHAN(1, 0, LTC2305_CH1_CH0),
+};
+
 static const struct iio_chan_spec ltc2309_channels[] = {
 	LTC2309_CHAN(0, LTC2309_CH0),
 	LTC2309_CHAN(1, LTC2309_CH1),
@@ -99,6 +115,24 @@ static const struct iio_chan_spec ltc2309_channels[] = {
 	LTC2309_DIFF_CHAN(7, 6, LTC2309_CH7_CH6),
 };
 
+struct ltc2309_chip_info {
+	const char *name;
+	const struct iio_chan_spec *channels;
+	int num_channels;
+};
+
+static const struct ltc2309_chip_info ltc2305_chip_info = {
+	.name = "ltc2305",
+	.channels = ltc2305_channels,
+	.num_channels = ARRAY_SIZE(ltc2305_channels),
+};
+
+static const struct ltc2309_chip_info ltc2309_chip_info = {
+	.name = "ltc2309",
+	.channels = ltc2309_channels,
+	.num_channels = ARRAY_SIZE(ltc2309_channels),
+};
+
 static int ltc2309_read_raw_channel(struct ltc2309 *ltc2309,
 				    unsigned long address, int *val)
 {
@@ -158,6 +192,7 @@ static const struct iio_info ltc2309_info = {
 
 static int ltc2309_probe(struct i2c_client *client)
 {
+	const struct ltc2309_chip_info *chip_info;
 	struct iio_dev *indio_dev;
 	struct ltc2309 *ltc2309;
 	int ret;
@@ -167,13 +202,17 @@ static int ltc2309_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	ltc2309 = iio_priv(indio_dev);
+	chip_info = i2c_get_match_data(client);
+	if (!chip_info)
+		return -EINVAL;
+
 	ltc2309->dev = &indio_dev->dev;
 	ltc2309->client = client;
 
-	indio_dev->name = "ltc2309";
+	indio_dev->name = chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = ltc2309_channels;
-	indio_dev->num_channels = ARRAY_SIZE(ltc2309_channels);
+	indio_dev->channels = chip_info->channels;
+	indio_dev->num_channels = chip_info->num_channels;
 	indio_dev->info = &ltc2309_info;
 
 	ret = devm_regulator_get_enable_read_voltage(&client->dev, "vref");
@@ -189,13 +228,15 @@ static int ltc2309_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id ltc2309_of_match[] = {
-	{ .compatible = "lltc,ltc2309" },
+	{ .compatible = "lltc,ltc2305", .data = &ltc2305_chip_info },
+	{ .compatible = "lltc,ltc2309", .data = &ltc2309_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ltc2309_of_match);
 
 static const struct i2c_device_id ltc2309_id[] = {
-	{ "ltc2309" },
+	{ "ltc2305", (kernel_ulong_t)&ltc2305_chip_info },
+	{ "ltc2309", (kernel_ulong_t)&ltc2309_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltc2309_id);

-- 
2.34.1


