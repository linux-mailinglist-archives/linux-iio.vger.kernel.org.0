Return-Path: <linux-iio+bounces-22632-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CA8B22EA1
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 19:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117F11A26255
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 17:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF652FDC51;
	Tue, 12 Aug 2025 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LO12tsEX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083DA2FD1D5;
	Tue, 12 Aug 2025 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018598; cv=none; b=drvW4j49UwxHADhJYuBTSAd8W5z7R4K8xZyGiVNRcdmpzdaH/d0lBNL+gGyFioS7tOEkf1LnH62C/2x7xbly1HyvIPuL4gV7xl8MY0rWse3fjlO1L59l2udCnvvtM9gKklFds7LXTxAabMAYxaip7FSWwD81lvMpobEV8J08Igc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018598; c=relaxed/simple;
	bh=iyO00up7pExqdt6wTiA/2z0XMeAgUS+X5mkIQF9F00g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r78krNMtIRH10Ar890DzTu9q9EXcqWAQgtbv2Lse9NntUQSnqPMfFzsvpujbopK2Erb+2tJ+nn/cNaNJLEwcMcw24TuxkhczC9B/spkvk80E8yi3nnTSLKp4usZau7ckKT6cX4JtqtFlUyNmerZKKB6NkCLK10fPzPO58BJ6OZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LO12tsEX; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6185a9bb91eso1213391a12.1;
        Tue, 12 Aug 2025 10:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755018594; x=1755623394; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WfV/TLm5sOcAbXXCv8uHmzLQQnkBSUp1pBLo2Jf6xJA=;
        b=LO12tsEXByq+RnB7uF/J5PXT5zPAx8LSmXRZ9pspJ9zBcnKIPfbU+IEe6gbWNHvYaq
         rCPi1Pv4WJBKfxyHFuA0zfXK4+LAdPgVP0xdsASNC4Ra+36k/IoOMy0MLitXdEKqtzci
         hJskWDuF1+v98dsiMv6PmDT/6S0aJ0X1xwqn/LCFnCLoM2g3AkFREXIboVsi1BmiTGff
         c0lALN9u+gAf15DvGZStlfPVO5IS1Pz6K3OwF6rN9jAPSktOez8yp+/IkWomSghA5kAS
         lhbJh8GkpOK+yq+zT7c9sEXY91AYbjKrBxwED9UUWlouR0vOvMMyRcQsYHEwMOWK3/Jo
         fnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755018594; x=1755623394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfV/TLm5sOcAbXXCv8uHmzLQQnkBSUp1pBLo2Jf6xJA=;
        b=IlGzFnB+WZS3C143DiQRgqV/1G7tg5+ylff9d2eJHMXaDWlbSilRpX5CD7gsODu9rO
         VxuB3ogGcpQe+jJ9L/lNpyxRwwUyLUqzojYNS1JclYuF3PSTm0r6AfAk3qY+S1gi5DPs
         bTl1KKUHSh3qAlaVYUKjnJTgX6AHrSnz/gqpKJI3IW6IuOlsrIm/GJQsADwEq9EI/+Ka
         /HWhSLpmRK0N2d0Fm1OPxk5Gqa0Q75bbqmeqWV2wwQsQHZxZ51phPsH+AMwU5iQZ0sWc
         1DPxYITBZg006W9cz+T0UT0JxC+d6/+gDm2zP5b7TVTt5MBUgkud2hTEm28cd7f9WCgC
         sxCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHxxT7EE4g9n9LBKztS/8drKwaGxeOTufoF78TF980q6ikQ9x5J12X9EdvHCJlOEcltqUUeW09lz1f@vger.kernel.org, AJvYcCVPYgPmlo4KHoflVBX3jeuJq0KVICyxRSCQDtyofvLph/50fYfq457E7ZY38IagX0d8y818lrKJcrZo@vger.kernel.org, AJvYcCXeE21MXiaxZUdVr8OafaZpWVS/NvCau9Swz5IIYw47jVNibMeJUFfS3CcBs5BlWNOjPrebY9dAu3odJcot@vger.kernel.org
X-Gm-Message-State: AOJu0YyJNMc89daU28Bz4agTtrtJjA4l1GG/atY92LtS+7Emn4t8iq5i
	8vIV9+tVoL1cxUnJA5lAc1fxa3F/LKj7lKTcFoaHVBfoRGcoUkzm2fSS7V0QZTDzFiQ=
X-Gm-Gg: ASbGnctcE1HzWPsOcRNyrN8tamk2mf/qZXNW4+bWVIAmIkdd/BHOF9mpe7Al216unWf
	kryoisRkBd2uWHRlzMGEFj2YehMj36+2JjRkQ4cVHGFCgTcUlx8XaUF+xs3tk/RxMKWE/to075Y
	P/OLYM5J/vUFD93liSCbRrYZ7M8fHk44b6zSBpGRWzd1Bbj+qqXYaMgEZPOx9IepfxFpfxMhjZt
	kL9ngme8+sru3/y4QikUN3gdM9mcSlNLubbYEPPJm6nde0wEsAcMdOMoA31Cta4YKkZpTE6Yltm
	eISXye8wmv7XWvl1Ht48KzCC0qWZTqTb2QALhuzXB14riqdvVjBJRkhCFvks0nrwCVz/CpvZ3M+
	JVS2W5pcsFuPIHMNpVjLUwqsJYxLp
X-Google-Smtp-Source: AGHT+IFhWlFfAetMWnvKBwxPMCxdHL9/KjyowI9GWIogi0BZL66HqQyQNHNkazu6MlI6QY4EpYD/Qg==
X-Received: by 2002:a05:6402:440b:b0:615:8bee:56b6 with SMTP id 4fb4d7f45d1cf-6186735e9edmr479221a12.34.1755018594201;
        Tue, 12 Aug 2025 10:09:54 -0700 (PDT)
Received: from [127.0.1.1] ([185.177.137.147])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a911451csm20060302a12.60.2025.08.12.10.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:09:52 -0700 (PDT)
From: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
Date: Tue, 12 Aug 2025 19:04:12 +0200
Subject: [PATCH 3/3] iio: adc: ltc2497: add temperature sensor support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-ltc2495-v1-3-7bf4c6feec2e@gmail.com>
References: <20250812-ltc2495-v1-0-7bf4c6feec2e@gmail.com>
In-Reply-To: <20250812-ltc2495-v1-0-7bf4c6feec2e@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755018589; l=7778;
 i=y.alperbilgin@gmail.com; s=20250811; h=from:subject:message-id;
 bh=iyO00up7pExqdt6wTiA/2z0XMeAgUS+X5mkIQF9F00g=;
 b=CEJMp9UmnXizijTG5R6lE4pMOZZDU4w86PgVlCb97SQyPX+nqq5AczOzcXw5uSMRRR6P7IP/u
 fX7SCHPpgBsARYLgJgdCXiDGCCiRHhjlu/8s4cZ8gSbtzpaAhEID2J/
X-Developer-Key: i=y.alperbilgin@gmail.com; a=ed25519;
 pk=FtW2oyQ0+xlYU0XmhYiJYC3lNPtPrgeE6i4WXPwaFnY=

The LTC2495 and LTC2499 include an internal temperature sensor. This
patch adds support for reading it via a standard IIO temperature
channel.

Signed-off-by: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
---
 drivers/iio/adc/ltc2496.c      |  1 +
 drivers/iio/adc/ltc2497-core.c | 80 ++++++++++++++++++++++++++++++++++++++----
 drivers/iio/adc/ltc2497.c      | 33 ++++++++++++++---
 drivers/iio/adc/ltc2497.h      |  7 +++-
 4 files changed, 109 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ltc2496.c b/drivers/iio/adc/ltc2496.c
index f06dd0b9a85819935abea6496abe2a808ac549c6..909dbd5f9aee877aafe423b47581ff4f36a76c52 100644
--- a/drivers/iio/adc/ltc2496.c
+++ b/drivers/iio/adc/ltc2496.c
@@ -90,6 +90,7 @@ static void ltc2496_remove(struct spi_device *spi)
 static const struct ltc2497_chip_info ltc2496_info = {
 	.resolution = 16,
 	.name = NULL,
+	.has_temp_channel = false,
 };
 
 static const struct of_device_id ltc2496_of_match[] = {
diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
index 400f4fe5af30e8e16b75506726235f10f2a4237f..938259df4d27e9e26dea2be4112bef355adaaafb 100644
--- a/drivers/iio/adc/ltc2497-core.c
+++ b/drivers/iio/adc/ltc2497-core.c
@@ -72,8 +72,8 @@ static int ltc2497core_read(struct ltc2497core_driverdata *ddata, u8 address, in
 }
 
 static int ltc2497core_read_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *chan,
-			    int *val, int *val2, long mask)
+				struct iio_chan_spec const *chan,
+				int *val, int *val2, long mask)
 {
 	struct ltc2497core_driverdata *ddata = iio_priv(indio_dev);
 	int ret;
@@ -93,10 +93,52 @@ static int ltc2497core_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
-		*val = ret / 1000;
-		*val2 = ddata->chip_info->resolution + 1;
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			*val = ret / 1000;
+			*val2 = ddata->chip_info->resolution + 1;
+
+			return IIO_VAL_FRACTIONAL_LOG2;
+
+		case IIO_TEMP:
+			if (!ddata->chip_info->has_temp_channel)
+				return -EINVAL;
+
+			/*
+			 * The datasheet formula to get Temperature in Celsius is:
+			 * Temp_C = (Conversion * Vref / temp_scale) - 273
+			 *
+			 * To match the IIO framework's model of (raw + offset) * scale,
+			 * and to get the final result in millidegrees Celsius:
+			 *
+			 * = ((Conversion * Vref / temp_scale) - 273) * 1000
+			 * = (Conversion - (273 * temp_scale / Vref)) * 1000 * Vref / temp_scale
+			 *
+			 * This gives us if the Vref is in mV:
+			 * scale  = Vref * 1000 / temp_scale
+			 * offset = -273 * temp_scale / Vref
+			 */
+			*val = ret;
+			*val2 = ddata->chip_info->temp_scale;
+
+			return IIO_VAL_FRACTIONAL;
+
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_OFFSET:
+		if (chan->type != IIO_TEMP)
+			return -EINVAL;
+
+		/* see the calculation above. Offset with (-273 * temp_scale / Vref) */
+		ret = regulator_get_voltage(ddata->ref);
+		if (ret < 0)
+			return ret;
 
-		return IIO_VAL_FRACTIONAL_LOG2;
+		*val = -273 * ddata->chip_info->temp_scale;
+		*val2 = ret / 1000;
+
+		return IIO_VAL_FRACTIONAL;
 
 	default:
 		return -EINVAL;
@@ -124,6 +166,14 @@ static int ltc2497core_read_raw(struct iio_dev *indio_dev,
 	.differential = 1, \
 }
 
+#define LTC2497_T_CHAN() {									\
+	.type = IIO_TEMP,									\
+	.channel = 0,										\
+	.address = (LTC2497_TEMP_CMD_ADDR),							\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),						\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET),	\
+}
+
 static const struct iio_chan_spec ltc2497core_channel[] = {
 	LTC2497_CHAN(0, LTC2497_SGL, "CH0"),
 	LTC2497_CHAN(1, LTC2497_SGL, "CH1"),
@@ -159,6 +209,8 @@ static const struct iio_chan_spec ltc2497core_channel[] = {
 	LTC2497_CHAN_DIFF(7, LTC2497_DIFF | LTC2497_SIGN),
 };
 
+static const struct iio_chan_spec ltc2497_temp_channel = LTC2497_T_CHAN();
+
 static const struct iio_info ltc2497core_info = {
 	.read_raw = ltc2497core_read_raw,
 };
@@ -180,8 +232,22 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
 
 	indio_dev->info = &ltc2497core_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = ltc2497core_channel;
-	indio_dev->num_channels = ARRAY_SIZE(ltc2497core_channel);
+
+	/* Dynamically create the channel list */
+	if (ddata->chip_info->has_temp_channel) {
+		/* Allocate space for common channels + 1 temp channel */
+		indio_dev->num_channels = ARRAY_SIZE(ltc2497core_channel) + 1;
+		indio_dev->channels = devm_kmemdup(dev, ltc2497core_channel,
+						   sizeof(ltc2497core_channel), GFP_KERNEL);
+		if (!indio_dev->channels)
+			return -ENOMEM;
+
+		memcpy((void *)&indio_dev->channels[ARRAY_SIZE(ltc2497core_channel)],
+		       &ltc2497_temp_channel, sizeof(ltc2497_temp_channel));
+	} else {
+		indio_dev->channels = ltc2497core_channel;
+		indio_dev->num_channels = ARRAY_SIZE(ltc2497core_channel);
+	}
 
 	ret = ddata->result_and_measure(ddata, LTC2497_CONFIG_DEFAULT, NULL);
 	if (ret < 0)
diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
index 8f4665547b5b0d32084599f8557c40102c37a4ce..3f8515ef465d3fda7572d63ef3a265dec89079ea 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -86,11 +86,31 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
 			return 0;
 	}
 
-	ret = i2c_smbus_write_byte(st->client,
-				   LTC2497_ENABLE | address);
+	/*
+	 * Chips with temperature sensor support (e.g., LTC2495/LTC2499)
+	 * require a two-byte command format to select any channel.
+	 *
+	 * To read the internal temperature, LTC2497_TEMP_CMD_ADDR is sent as
+	 * the second byte. To read a voltage channel, LTC2497_EN2 is sent,
+	 * which sets the default configuration: simultaneous 50/60Hz
+	 * rejection, 1x speed, and gain=1.
+	 *
+	 * Chips without this feature use a standard single-byte command.
+	 */
+	if (ddata->chip_info->has_temp_channel) {
+		if (address == LTC2497_TEMP_CMD_ADDR)
+			ret = i2c_smbus_write_byte_data(st->client, LTC2497_ENABLE,
+							LTC2497_TEMP_CMD_ADDR);
+		else
+			ret = i2c_smbus_write_byte_data(st->client, LTC2497_ENABLE | address,
+							LTC2497_EN2);
+
+	} else {
+		ret = i2c_smbus_write_byte(st->client, LTC2497_ENABLE | address);
+	}
+
 	if (ret)
-		dev_err(&st->client->dev, "i2c transfer failed: %pe\n",
-			ERR_PTR(ret));
+		dev_err(&st->client->dev, "i2c transfer failed: %pe\n", ERR_PTR(ret));
 	return ret;
 }
 
@@ -135,14 +155,19 @@ static const struct ltc2497_chip_info ltc2497_info[] = {
 	[TYPE_LTC2495] = {
 		.resolution = 16,
 		.name = "ltc2495",
+		.has_temp_channel = true,
+		.temp_scale = 12250, /* 12.250 V per degree C -> 12250 mV */
 	},
 	[TYPE_LTC2497] = {
 		.resolution = 16,
 		.name = NULL,
+		.has_temp_channel = false,
 	},
 	[TYPE_LTC2499] = {
 		.resolution = 24,
 		.name = "ltc2499",
+		.has_temp_channel = true,
+		.temp_scale = 1570000, /* 1570 V per degree C -> 1570000 mV */
 	},
 };
 
diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
index f2139f260c3fe4e8772c6db9c46331de775dcd5c..c133a4fb8092b1c6a66a7336016dd361783f531c 100644
--- a/drivers/iio/adc/ltc2497.h
+++ b/drivers/iio/adc/ltc2497.h
@@ -1,10 +1,15 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 
-#define LTC2497_ENABLE	0xA0
+#define LTC2497_ENABLE		0xA0
+#define LTC2497_EN2		0x80
+#define LTC2497_IM		0x40
+#define LTC2497_TEMP_CMD_ADDR	(LTC2497_EN2 | LTC2497_IM)
 
 struct ltc2497_chip_info {
 	u32 resolution;
 	const char *name;
+	bool has_temp_channel;
+	u32 temp_scale; /* in mV, for temp conversion */
 };
 
 struct ltc2497core_driverdata {

-- 
2.43.0


