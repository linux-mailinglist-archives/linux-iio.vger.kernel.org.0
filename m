Return-Path: <linux-iio+bounces-27330-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B92AECD8898
	for <lists+linux-iio@lfdr.de>; Tue, 23 Dec 2025 10:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F13A305B7E8
	for <lists+linux-iio@lfdr.de>; Tue, 23 Dec 2025 09:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A4A324B09;
	Tue, 23 Dec 2025 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWVk0U8r"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFC1303A30
	for <linux-iio@vger.kernel.org>; Tue, 23 Dec 2025 09:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766481166; cv=none; b=Fy/WGg6HsLJfpsdbTU3iJT4SzJ70B8Fd5rLv6Ak3B/B0x6Pz3hWCKhtFZezoArjVP5xG5DL/hdOhRCUaZXqQl13I8BlXkT5TmZr91a2y1C1rjKGv3aTjKtPksDjHg/eZUGxXpZgrsyMU10tbTANN4hpIPRsxXjCbkXMcguUCvw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766481166; c=relaxed/simple;
	bh=aYGthVOr7xKF0XzkPUzrKtO6r7O3Qp3wRgl5PgSqd7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lht2hv9bN0ZZGQsORU+y+QZuACtLnMjUWh3hcWUsKdJaKGCxvzsGiei9Cil/3aeCBjGN/ymVKFvcLjcx47AhWahoS8eW7gnRZPKn2eMURRZ9zMwO7xU9H42l/2nl7Ac9PLMYuRGzBLDdbdnU5y2c0NwzNfgYFIbtWmJ77PDxRDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWVk0U8r; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34c84dc332cso4092698a91.0
        for <linux-iio@vger.kernel.org>; Tue, 23 Dec 2025 01:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766481164; x=1767085964; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+0+ceAv6TxBKZMC+y+UrpAJS40TNi33h8i+zox/uTo=;
        b=PWVk0U8rae0k5Gzb182f1vXrBSB/X8mKd59g8G2Qegb3/2HcF/2pxPWO+APC9fO8wD
         bN41snKY01hRR2GXMRo0uFHknBKRevJEgLpJ1CVlf28ZIZyDMo6G7Q5BADs+wRzW7R7q
         EasWt62cIdHlvFJPdBR7RQI2vpBS6fNwo1Vf9LWOCOAn1kReo+sNaC1ilznLXUgEY6j8
         ZW5NaHoiZ43839MbbV0jrn6QgON2vz+1XPOloOpdA3F9tIgTgtXiu4tnsf95zyoA+Nmf
         6JPQQ5u5TL6sFjFfrHp9umLx5xPsFFSTB3wKqizes9DT4pr6BeW87KdBFqM6lzkyuWvo
         HzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766481164; x=1767085964;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j+0+ceAv6TxBKZMC+y+UrpAJS40TNi33h8i+zox/uTo=;
        b=qnxbpfFzK0BDJ9ZaI65ghkbCNlFgVcJWSnI3XxeTaflAHkxYF93ni/7pNQfaZSvsCt
         djRlp7qZCsVBt/g232KmEd3zXzM6Mjls8AFcu2f1d6XSqg2ePatIvP7wSui+WW/EVGFf
         1B8R0DIzQrYxi3ArONMOZRXey61RkD9x8ph3+Vg8lKGDbA6cHGI2Mf7z1zpoFqUkA+9L
         jr/h8iFzuyjeLY1M1s2DwGno54b2AGk+0saDgXq8WV0b2czZvNrLJNgRHCET9KVVPzab
         76LCWe0NkvvDH8ijvoECqKK+CpqXnhdkhwuuCOsKpYwR76Uzth82fgzDP0rjz9Fjt5k9
         nHdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0M4WF6xSFV0b6jzfQgep0T/kZTLFuw0JdMv19ufjxTdyC8TrZzDRD3YNQC+3EeK6o8bXwKSptY10=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzOx0FPESfmX0KiEBusBSPAjbF4mzCLFF9FmA0gg0nVDLa8wku
	P4OY4eQ5NV/uyrkzFHpRxZltx1YPeRzyvKUs8ksP8F2015146OiJtIuQ
X-Gm-Gg: AY/fxX40EHnFPEpOREIzk2+tqAYAfecM71AHc0B2FEcBwxdX0PSLj1ie2WdQyVhyiwK
	NSxuv9I88rXKRF92ouLVFetej9rmeF1VySXdsemMbcn4OSMzmczdXBJn35uaKBUdEBzLHfsHOTy
	MwV1e3TyEP6hiBnnHiDMol0HzCPh+/9QgdOhVWZZs16pV4AOIkdusqT28LE7CS1cCYSUuEfzyBq
	dqStkxBHE79cgi9mAwE/IhIElMvUywXBTWt/IdjEaWLwxUXf1Rfsj7hraM1KKRncQEnaM05Ivw9
	/EaoG8EpNSJ3y3wnMyyMZ7Sqpv8JvBZFFKVNfjyZ1DrpAokyRuLZj8LolC9UY7gNc1n3JXcwL7m
	fyLXRB1moki3y/eLrQDToFOtQMLFV4kkC2vSWM/4bClqlkbIY35P2vJ1OVNEayaTUDIBEMgxBhG
	dMvfPmGXhoiXSU9yPnO6qq6TQHX/OuTTaebwtbDtM/ezIdDnc4Vpw=
X-Google-Smtp-Source: AGHT+IGVeO2+LBfxg28+07z9A7um12DF4HPf3YdZgS4hDsDk4T8lb/lj4mtHw46P/SRuJEA1o2V20A==
X-Received: by 2002:a17:90b:2ecc:b0:343:eb40:8dca with SMTP id 98e67ed59e1d1-34e921a3dd3mr11670813a91.19.1766481164124;
        Tue, 23 Dec 2025 01:12:44 -0800 (PST)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e9224d9e5sm12352454a91.17.2025.12.23.01.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 01:12:43 -0800 (PST)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Tue, 23 Dec 2025 17:12:26 +0800
Subject: [PATCH 2/2] iio: adc: ltc2309: add support for ltc2305
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-add_ltc2305_driver-v1-2-dfa0827fd620@gmail.com>
References: <20251223-add_ltc2305_driver-v1-0-dfa0827fd620@gmail.com>
In-Reply-To: <20251223-add_ltc2305_driver-v1-0-dfa0827fd620@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3861;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=aYGthVOr7xKF0XzkPUzrKtO6r7O3Qp3wRgl5PgSqd7c=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBpSl0DbJU7+qtAJ5Jcm/IhA1P/vS3kqmfXjRqYi
 tx+hLKNX3aJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCaUpdAwAKCRClg0K3CVbE
 gQzZB/9TP8hJ6vY4N4Vmf/W9HzruOIUsJiDxk4PyJF8qklbVCU10vCiwb7QgFnuBq+pf2fkJ0Mg
 Uhz8zhnq0rZNGuyxzbDGiDn3dNxxY5cCY2WRbah4PfkWp4r5YltJtlUgHVPsKG/kVx68tCjkdBJ
 /tKkxGXQhYREHkDiq2k6e7832LM/UfXYrz+wIUKkJpEwbMorkFkQT/aM6LMTgm5roPpV9VjmDrf
 d5UGjVDNDqK8okJIeX44GS2w6FEB9P+CccDRKBdRSJac0TyxhQ9xxVNKPSubDhAfhFoGRLQKk/I
 74L1/vE3WWXVlSismDIqfCuVi/iJNEzNvgYceeDhwafdSJV8
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Add support for the 2-channel LTC2305 ADC in the existing LTC2309 driver.
The LTC2305 and LTC2309 share similar features: both are 12-bit,
low-noise, low-power SAR ADCs with an I2C interface.
The main difference is the number of channels: LTC2305 has 2 channels,
while LTC2309 has 8 channels.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
 drivers/iio/adc/ltc2309.c | 50 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ltc2309.c b/drivers/iio/adc/ltc2309.c
index 5f0d947d0615..7a611ddd00d2 100644
--- a/drivers/iio/adc/ltc2309.c
+++ b/drivers/iio/adc/ltc2309.c
@@ -1,9 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * The LTC2309 is an 8-Channel, 12-Bit SAR ADC with an I2C Interface.
+ * The LTC2305 is a  2-Channel, 12-Bit SAR ADC with an I2C Interface.
  *
  * Datasheet:
  * https://www.analog.com/media/en/technical-documentation/data-sheets/2309fd.pdf
+ * https://www.analog.com/media/en/technical-documentation/data-sheets/23015fb.pdf
  *
  * Copyright (c) 2023, Liam Beguin <liambeguin@gmail.com>
  */
@@ -60,6 +62,13 @@ enum ltc2309_channels {
 	LTC2309_CH7,
 };
 
+enum ltc2305_channels {
+	LTC2305_CH0_CH1 = 0,
+	LTC2305_CH1_CH0,
+	LTC2305_CH0,
+	LTC2305_CH1,
+};
+
 #define LTC2309_CHAN(_chan, _addr) {				\
 	.type = IIO_VOLTAGE,					\
 	.indexed = 1,						\
@@ -99,6 +108,31 @@ static const struct iio_chan_spec ltc2309_channels[] = {
 	LTC2309_DIFF_CHAN(7, 6, LTC2309_CH7_CH6),
 };
 
+static const struct iio_chan_spec ltc2305_channels[] = {
+	LTC2309_CHAN(0, LTC2305_CH0),
+	LTC2309_CHAN(1, LTC2305_CH1),
+	LTC2309_DIFF_CHAN(0, 1, LTC2305_CH0_CH1),
+	LTC2309_DIFF_CHAN(1, 0, LTC2305_CH1_CH0),
+};
+
+struct ltc230x_chip_info {
+	const char *name;
+	const struct iio_chan_spec *channels;
+	int num_channels;
+};
+
+static const struct ltc230x_chip_info ltc2309_chip_info = {
+	.name = "ltc2309",
+	.channels = ltc2309_channels,
+	.num_channels = ARRAY_SIZE(ltc2309_channels),
+};
+
+static const struct ltc230x_chip_info ltc2305_chip_info = {
+	.name = "ltc2305",
+	.channels = ltc2305_channels,
+	.num_channels = ARRAY_SIZE(ltc2305_channels),
+};
+
 static int ltc2309_read_raw_channel(struct ltc2309 *ltc2309,
 				    unsigned long address, int *val)
 {
@@ -158,6 +192,8 @@ static const struct iio_info ltc2309_info = {
 
 static int ltc2309_probe(struct i2c_client *client)
 {
+	const struct of_device_id *match;
+	const struct ltc230x_chip_info *chip_info;
 	struct iio_dev *indio_dev;
 	struct ltc2309 *ltc2309;
 	int ret;
@@ -167,13 +203,17 @@ static int ltc2309_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	ltc2309 = iio_priv(indio_dev);
+	chip_info = device_get_match_data(&client->dev);
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
@@ -189,13 +229,15 @@ static int ltc2309_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id ltc2309_of_match[] = {
-	{ .compatible = "lltc,ltc2309" },
+	{ .compatible = "lltc,ltc2309", .data = &ltc2309_chip_info },
+	{ .compatible = "lltc,ltc2305", .data = &ltc2305_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ltc2309_of_match);
 
 static const struct i2c_device_id ltc2309_id[] = {
 	{ "ltc2309" },
+	{ "ltc2305" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltc2309_id);

-- 
2.34.1


