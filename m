Return-Path: <linux-iio+bounces-8078-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FA39426FF
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 08:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83701B20DD3
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 06:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8481916D9C7;
	Wed, 31 Jul 2024 06:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+YG3p8P"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC61816D9C6;
	Wed, 31 Jul 2024 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722407853; cv=none; b=BgcG/Uy4dQwAPYIMRcseEJLhJ9//L4q/x3SMvbs3WuDg2kG838QAu3rB2rZY4TAQteVcJMOd2cuv/gzCLHpM2ILCKYT0fD3PUQnd40WNapVX+nGTzNdvKr8JydAUGIlXE+3cLucRAUA9fAC48OuJj9GSGlADoWgnsWN4rClRqGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722407853; c=relaxed/simple;
	bh=FMzfDsfFJrtv1m5ZevHIk5L79iSt+EYyRIKcHmjU/cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjYYUaDvU4vDLXQIwCP8Gie/uKVUnSCSGcarQJMslPJ2C5E5kmTxmAdpeGB9KFABhS6K8fHVg7HG8UK8nhR+fnoweSEAXvKo8zoLsHCqY0IFQvt4Et10QO+hd0YelujPhvftbtC80PF4uf+vXmC2i/otX4GMZO8KMH4ocZdXbx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+YG3p8P; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fed72d23a7so38323445ad.1;
        Tue, 30 Jul 2024 23:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722407849; x=1723012649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wsg7L2MYAs8C+0E2H+puh2yeJCYoePlZ3OwjgmIaDT8=;
        b=S+YG3p8PdUsRhHFgiP2v0uJaahHzP5Q5sRXfGVFW8T21pDKO3MpUhl8ekRIaIknl8g
         23l6k0StPL60U7kefXLz/39F1I4yiiPJ6qTbPQb9F2dXCIK5bz4RXhMNPLinB8cVzYCS
         exyJbQWaZRK6vl8pkFTTkQCeYxUX29QRKFnyQRIr/Tx3RusqJM9f507XJYzWbiEBc+Eo
         QRPS4qTFn1ZTRK22O7cIPH9lTq0Qo457saGbaWXzLZ70tkmqNu6kE12GiEANUdwQXkE8
         KkRO5HHOqASe68JERtoEIPw0SDq09/4abper39wKL7rxoF+KA7XJnhT2YlXDOahrL0r3
         r92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722407849; x=1723012649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wsg7L2MYAs8C+0E2H+puh2yeJCYoePlZ3OwjgmIaDT8=;
        b=myfrEqh4aGqFFc1fnGcp/GV40MSXvbqDoqrROF3r0uJ7D37bONcTD1jggCoTpG5uX4
         eh9CUJ5nEAd/wMhceMw5JW4A7G3E+u3iAvvLd7MFq23oZwYxihIrxjdlS8qdnLjzk8s/
         1zKoY99QCpbR0wAitj+d1MCQ6wJDEMyec5kLTOs5GnNUT6X/4EZq1GY5iEmNyR5poCJq
         b0VTiIhGyoqqpfyIhZfRr/k3687idG0SBW+Doqi1SPNKyNmz2CyT8Q25Bk2eqUNKaGvU
         tRU6tZIjw7Zb6KPaWuzY/hWWcSY8yWRIX3g4hTJlJAcrv0n7aGUh9xlEAWi9CpUbfTCE
         IoZw==
X-Forwarded-Encrypted: i=1; AJvYcCVd5YfvcgYLL+PcDu0I17Te/0anmsTd3L8kxl06gLGmFAlB9rlcTJ2qsuPXYWtg1+9kquBRZX+34eZQpJWJxyCyosVebIZBCH6JdVXx
X-Gm-Message-State: AOJu0YxTHtFeRM+rD+/fgaomCEXqz5zcmXAQIIo9cYLmDm9/E1Boy9Gj
	29DEF60xifhr/56WtlREKxuPmlOyNrH21uV1tZ/eWnGmcG3FSvVwxN6E5iQVx5Cxsg==
X-Google-Smtp-Source: AGHT+IGIMo16uh8PRmtq0AsfNBVzBa9NjUY76cIJLsaioTbk6ZGOxcvKWqyW0Tu55gsw3+h636C/Hw==
X-Received: by 2002:a17:902:e749:b0:1fd:9cb1:5dc6 with SMTP id d9443c01a7336-1ff048dc11cmr127174685ad.57.1722407849319;
        Tue, 30 Jul 2024 23:37:29 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fed7ee4ce6sm113164905ad.157.2024.07.30.23.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 23:37:28 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v5 2/3] iio: light: ltr390: Add ALS channel and support for gain and resolution
Date: Wed, 31 Jul 2024 12:07:04 +0530
Message-ID: <20240731063706.25412-3-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731063706.25412-1-abhashkumarjha123@gmail.com>
References: <20240731063706.25412-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new ALS channel and allow reading lux and scale values.
Also provide gain and resolution configuration for ALS channel.
Add automatic mode switching between the UVS and ALS channel
based on which channel is being accessed.
The default mode in which the sensor start is ALS mode.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/light/ltr390.c | 100 ++++++++++++++++++++++++++++++++-----
 1 file changed, 88 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index ee3d30075..d3ce43f20 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -63,11 +63,17 @@
  */
 #define LTR390_WINDOW_FACTOR 1
 
+enum ltr390_mode {
+	LTR390_SET_ALS_MODE,
+	LTR390_SET_UVS_MODE,
+};
+
 struct ltr390_data {
 	struct regmap *regmap;
 	struct i2c_client *client;
 	/* Protects device from simulataneous reads */
 	struct mutex lock;
+	enum ltr390_mode mode;
 	int gain;
 	int int_time_us;
 };
@@ -95,6 +101,25 @@ static int ltr390_register_read(struct ltr390_data *data, u8 register_address)
 	return get_unaligned_le24(recieve_buffer);
 }
 
+static int ltr390_set_mode(struct ltr390_data *data, enum ltr390_mode mode)
+{
+	if (data->mode == mode)
+		return 0;
+
+	switch (mode) {
+	case LTR390_SET_ALS_MODE:
+		regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_UVS_MODE);
+		break;
+
+	case LTR390_SET_UVS_MODE:
+		regmap_set_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_UVS_MODE);
+		break;
+	}
+
+	data->mode = mode;
+	return 0;
+}
+
 static int ltr390_read_raw(struct iio_dev *iio_device,
 			   struct iio_chan_spec const *chan, int *val,
 			   int *val2, long mask)
@@ -105,16 +130,54 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
 	guard(mutex)(&data->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		ret = ltr390_set_mode(data, LTR390_SET_UVS_MODE);
+		if (ret < 0)
+			return ret;
+
 		ret = ltr390_register_read(data, LTR390_UVS_DATA);
 		if (ret < 0)
 			return ret;
 		*val = ret;
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE:
-		*val = LTR390_WINDOW_FACTOR;
-		*val2 = LTR390_COUNTS_PER_UVI;
+
+	case IIO_CHAN_INFO_PROCESSED:
+		ret = ltr390_set_mode(data, LTR390_SET_ALS_MODE);
+		if (ret < 0)
+			return ret;
+		ret = ltr390_register_read(data, LTR390_ALS_DATA);
+		if (ret < 0)
+			return ret;
+
+		/* Converting microseconds to miliseconds */
+		*val = 1000 * ret;
+		*val2 = data->gain * data->int_time_us;
 		return IIO_VAL_FRACTIONAL;
 
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_UVINDEX:
+			ret = ltr390_set_mode(data, LTR390_SET_UVS_MODE);
+			if (ret < 0)
+				return ret;
+
+			*val = LTR390_WINDOW_FACTOR;
+			*val2 = LTR390_COUNTS_PER_UVI;
+			return IIO_VAL_FRACTIONAL;
+
+		case IIO_LIGHT:
+			ret = ltr390_set_mode(data, LTR390_SET_ALS_MODE);
+			if (ret < 0)
+				return ret;
+
+			/* scale is 0.6 * WINDOW_FACTOR */
+			*val = LTR390_WINDOW_FACTOR * 6;
+			*val2 = 10;
+			return IIO_VAL_FRACTIONAL;
+
+		default:
+			return -EINVAL;
+		}
+
 	case IIO_CHAN_INFO_INT_TIME:
 		*val = data->int_time_us;
 		return IIO_VAL_INT;
@@ -128,11 +191,23 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
 static const int ltr390_int_time_map_us[] = { 400000, 200000, 100000, 50000, 25000, 12500 };
 static const int ltr390_gain_map[] = { 1, 3, 6, 9, 18 };
 
-static const struct iio_chan_spec ltr390_channel = {
-	.type = IIO_UVINDEX,
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
-	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
-	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SCALE)
+static const struct iio_chan_spec ltr390_channels[] = {
+	/* UV sensor */
+	{
+		.type = IIO_UVINDEX,
+		.scan_index = 0,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SCALE)
+	},
+	/* ALS sensor */
+	{
+		.type = IIO_LIGHT,
+		.scan_index = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) | BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SCALE)
+	},
 };
 
 static int ltr390_set_gain(struct ltr390_data *data, int val)
@@ -252,12 +327,14 @@ static int ltr390_probe(struct i2c_client *client)
 	data->int_time_us = 100000;
 	/* default value of gain from pg: 16 of the datasheet */
 	data->gain = 3;
+	/* default mode for ltr390 is ALS mode */
+	data->mode = LTR390_SET_ALS_MODE;
 
 	mutex_init(&data->lock);
 
 	indio_dev->info = &ltr390_info;
-	indio_dev->channels = &ltr390_channel;
-	indio_dev->num_channels = 1;
+	indio_dev->channels = ltr390_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ltr390_channels);
 	indio_dev->name = "ltr390";
 
 	ret = regmap_read(data->regmap, LTR390_PART_ID, &part_number);
@@ -275,8 +352,7 @@ static int ltr390_probe(struct i2c_client *client)
 	/* Wait for the registers to reset before proceeding */
 	usleep_range(1000, 2000);
 
-	ret = regmap_set_bits(data->regmap, LTR390_MAIN_CTRL,
-			      LTR390_SENSOR_ENABLE | LTR390_UVS_MODE);
+	ret = regmap_set_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_SENSOR_ENABLE);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to enable the sensor\n");
 
-- 
2.43.0


