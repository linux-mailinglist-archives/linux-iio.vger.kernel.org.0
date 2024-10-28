Return-Path: <linux-iio+bounces-11506-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 371B69B3772
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 18:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ABFF1C216B2
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 17:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DFB1DF961;
	Mon, 28 Oct 2024 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBppxe3x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB34F1DF72F;
	Mon, 28 Oct 2024 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730135654; cv=none; b=bxNG3e77Rzg8o1OwpWN5otXPFVqTJvwZmgJoLqC9mFM7LOXaMN2Wem7lxWKBQDQW9lzAgdt6AyzM8RIX2tpENuCxpPTEoZ0XmyzsEhEeY9tAbN4FiTeMt3FMumqtAssurq23uJCY5qcfbk+NdVHKOMRdiMNuMSvzsv7BQFbTsvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730135654; c=relaxed/simple;
	bh=BgkVBJFGhC6T+R0R4bVBLsPBPikg/EtLE3pTsjYoq+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WgNyXG4XnZjEdj6Ry9BNI+HN9hf+naMXCksmU+vxMhSCB+4IOJCExkG2Yurt4X9Ibkf+GJAE/lN605BVk0D5sXC2eLbmWEDoZqluTgr9+/hlWuQpnyu8/pwsFfmCkR/lJTMejuPbQJR8cT617MrBuZdmaOo/Nm/zSebHHlfLU+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBppxe3x; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e59dadebso5399211e87.0;
        Mon, 28 Oct 2024 10:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730135650; x=1730740450; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f61g60FJPeMj3hhBI0sGCedrxgK9skggmaEbo+OjaBQ=;
        b=fBppxe3x5K92ygc7OHSP5PFQxx5cV/rbL+YzlNEDCQY5+zlyzwqyZLrsOChAvzWDNx
         Oogmhm2FY24W3dJNoy6J1EWGxdzryZIX6ezybDQX110B55fo2q8YhtCkJAA/EzqG7L5U
         QwJrMJUYQFSiNW14kxABa5EqyWdjV8H+wywQyGHlWSpfrruyxi9fAlNvk+tYPj60MKuK
         /YSTh+/2NcreG1pV4zKC6EOGAjp9lwGYorUZ6UyaNQn13TVrAKISToa+Jzg7Pj3vl/YD
         rrqznk7V3mFMqGktZkTyCdmSqRdWqtuLEGy9xKtQTUkTR5Z6+U6oBDBcqcoVjTDDB7p/
         I7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730135650; x=1730740450;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f61g60FJPeMj3hhBI0sGCedrxgK9skggmaEbo+OjaBQ=;
        b=FqWcgn/bvnz3WNgS1mUCFhcAnidtdld+XFgnjgsO8vbNPx7DUzGuRC4C0LY8+GScb4
         B1bn0Azk+6vR06CwOaxRXjoxwazquq2McKD7zt0F/kofgSABRhHeN+XZcp8TyZ3p94cG
         6Op4l3DdmGZYersI8d36TYVSK2wIy3eT/s0Bq/QJtiuqjg1xS6YK+ksq5MnWbFUAiGJR
         Rt30JyvLz3rU+F/B0wSxc7SRWXgljJV4dQOuMoQoNEnZqsPGEKyZKW10/SzGiDmkZfjW
         mkLEgHxg6HS1MwKCDDJZlEO1XLYHSp0D7/mFpEBOK+0oE/pra/C3+8Q0e3849iiZOw2G
         kCQA==
X-Forwarded-Encrypted: i=1; AJvYcCW/GWC8fusuDkNhzLmZph/FlfzIplWuSHFb0ezbPUxuxq3eqleoUxtpEbW7kjunqrYd8XhDUpXCo1YIBF3v@vger.kernel.org, AJvYcCWNSRabPhBzePwKNFv30Nx7BqUIaHhGJttOY8rmCs/znexPR1iOmiZvt+QhUZs1skWQ6MKL1nPXyW8i@vger.kernel.org
X-Gm-Message-State: AOJu0Yyasb/aJfncSSPxQiFd5fXAC1q5n13zG6T8kB4hF31WC448vm7B
	jLQ4voVcle330CguiE1mBXJV63t+HDqBre6vzPJaCYbpckYGiH9h
X-Google-Smtp-Source: AGHT+IF3U8U/LJ2VKd5L5jrTLQ46PhzA07EsPkRkDrVcunn6gJjEreyOD0BJIfZ6mKxxzImwWsLNRg==
X-Received: by 2002:a05:6512:b84:b0:539:f886:31d6 with SMTP id 2adb3069b0e04-53b348ec0bbmr3153745e87.2.1730135649661;
        Mon, 28 Oct 2024 10:14:09 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b273-88b2-f83b-5936.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b273:88b2:f83b:5936])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43193595470sm114693795e9.15.2024.10.28.10.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 10:14:09 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 28 Oct 2024 18:14:02 +0100
Subject: [PATCH v3 2/2] iio: light: veml6070: add support for integration
 time
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-veml6070-integration-time-v3-2-dd7ace62f480@gmail.com>
References: <20241028-veml6070-integration-time-v3-0-dd7ace62f480@gmail.com>
In-Reply-To: <20241028-veml6070-integration-time-v3-0-dd7ace62f480@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730135643; l=6835;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=BgkVBJFGhC6T+R0R4bVBLsPBPikg/EtLE3pTsjYoq+o=;
 b=iJGuCz29PRluhqKvg91ktjlRDbEAP5E/ZDkrYt+qZKuz/glxwIt4MMoTnqohOf0nnLptX6LXJ
 JTUxiWgCAr/C5csigD6S9D5ujUGbzF42JwJPN5V9MvWBqch2EGbQG8H
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The integration time of the veml6070 depends on an external resistor
(called Rset in the datasheet) and the value configured in the IT
field of the command register, whose supported values are 1/2x, 1x,
2x and 4x.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6070.c | 134 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 126 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
index d11ae00f61f8..89b3ccb51515 100644
--- a/drivers/iio/light/veml6070.c
+++ b/drivers/iio/light/veml6070.c
@@ -6,7 +6,7 @@
  *
  * IIO driver for VEML6070 (7-bit I2C slave addresses 0x38 and 0x39)
  *
- * TODO: integration time, ACK signal
+ * TODO: ACK signal
  */
 
 #include <linux/bitfield.h>
@@ -15,6 +15,7 @@
 #include <linux/mutex.h>
 #include <linux/err.h>
 #include <linux/delay.h>
+#include <linux/units.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -29,18 +30,84 @@
 #define VEML6070_COMMAND_RSRVD	BIT(1) /* reserved, set to 1 */
 #define VEML6070_COMMAND_SD	BIT(0) /* shutdown mode when set */
 
-#define VEML6070_IT_10	0x01 /* integration time 1x */
+#define VEML6070_IT_05		0x00
+#define VEML6070_IT_10		0x01
+#define VEML6070_IT_20		0x02
+#define VEML6070_IT_40		0x03
+
+#define VEML6070_MIN_RSET_KOHM	75
+#define VEML6070_MIN_IT_US	15625 /* Rset = 75 kohm, IT = 1/2 */
 
 struct veml6070_data {
 	struct i2c_client *client1;
 	struct i2c_client *client2;
 	u8 config;
 	struct mutex lock;
+	u32 rset;
+	int it[4][2];
 };
 
+static void veml6070_calc_it(struct device *dev, struct veml6070_data *data)
+{
+	int i, tmp_it;
+
+	data->rset = 270000;
+	device_property_read_u32(dev, "rset-ohms", &data->rset);
+
+	if (data->rset < 75000) {
+		dev_warn(dev, "Rset too low, using minimum = 75 kohms\n");
+		data->rset = 75000;
+	}
+
+	if (data->rset > 1200000) {
+		dev_warn(dev, "Rset too high, using maximum = 1200 kohms\n");
+		data->rset = 1200000;
+	}
+
+	/*
+	 * convert to kohm to avoid overflows and work with the same units as
+	 * in the datasheet and simplify UVI operations.
+	 */
+	data->rset /= KILO;
+
+	tmp_it = VEML6070_MIN_IT_US * data->rset / VEML6070_MIN_RSET_KOHM;
+	for (i = 0; i < ARRAY_SIZE(data->it); i++) {
+		data->it[i][0] = (tmp_it << i) / MICRO;
+		data->it[i][1] = (tmp_it << i) % MICRO;
+	}
+}
+
+static int veml6070_get_it(struct veml6070_data *data, int *val, int *val2)
+{
+	int it_idx = FIELD_GET(VEML6070_COMMAND_IT, data->config);
+
+	*val = data->it[it_idx][0];
+	*val2 = data->it[it_idx][1];
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int veml6070_set_it(struct veml6070_data *data, int val, int val2)
+{
+	int it_idx;
+
+	for (it_idx = 0; it_idx < ARRAY_SIZE(data->it); it_idx++) {
+		if (data->it[it_idx][0] == val && data->it[it_idx][1] == val2)
+			break;
+	}
+
+	if (it_idx >= ARRAY_SIZE(data->it))
+		return -EINVAL;
+
+	data->config = (data->config & ~VEML6070_COMMAND_IT) |
+		FIELD_PREP(VEML6070_COMMAND_IT, it_idx);
+
+	return i2c_smbus_write_byte(data->client1, data->config);
+}
+
 static int veml6070_read(struct veml6070_data *data)
 {
-	int ret;
+	int ret, it_ms, val, val2;
 	u8 msb, lsb;
 
 	guard(mutex)(&data->lock);
@@ -51,7 +118,9 @@ static int veml6070_read(struct veml6070_data *data)
 	if (ret < 0)
 		return ret;
 
-	msleep(125 + 10); /* measurement takes up to 125 ms for IT 1x */
+	veml6070_get_it(data, &val, &val2);
+	it_ms = val * MILLI + val2 / (MICRO / MILLI);
+	msleep(it_ms + 10);
 
 	ret = i2c_smbus_read_byte(data->client2); /* read MSB, address 0x39 */
 	if (ret < 0)
@@ -81,26 +150,37 @@ static const struct iio_chan_spec veml6070_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_LIGHT_UV,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
 	},
 	{
 		.type = IIO_UVINDEX,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
 	}
 };
 
-static int veml6070_to_uv_index(unsigned int val)
+static int veml6070_to_uv_index(struct veml6070_data *data, unsigned int val)
 {
 	/*
 	 * conversion of raw UV intensity values to UV index depends on
 	 * integration time (IT) and value of the resistor connected to
-	 * the RSET pin (default: 270 KOhm)
+	 * the RSET pin.
 	 */
 	unsigned int uvi[11] = {
 		187, 373, 560, /* low */
 		746, 933, 1120, /* moderate */
 		1308, 1494, /* high */
 		1681, 1868, 2054}; /* very high */
-	int i;
+	int i, it_idx;
+
+	it_idx = FIELD_GET(VEML6070_COMMAND_IT, data->config);
+
+	if (!it_idx)
+		val = (val * 270  / data->rset) << 1;
+	else
+		val = (val * 270 / data->rset) >> (it_idx - 1);
 
 	for (i = 0; i < ARRAY_SIZE(uvi); i++)
 		if (val <= uvi[i])
@@ -123,10 +203,44 @@ static int veml6070_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 		if (mask == IIO_CHAN_INFO_PROCESSED)
-			*val = veml6070_to_uv_index(ret);
+			*val = veml6070_to_uv_index(data, ret);
 		else
 			*val = ret;
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_INT_TIME:
+		return veml6070_get_it(data, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int veml6070_read_avail(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       const int **vals, int *type, int *length,
+			       long mask)
+{
+	struct veml6070_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		*vals = (int *)data->it;
+		*length = 2 * ARRAY_SIZE(data->it);
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int veml6070_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
+{
+	struct veml6070_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		return veml6070_set_it(data, val, val2);
 	default:
 		return -EINVAL;
 	}
@@ -134,6 +248,8 @@ static int veml6070_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info veml6070_info = {
 	.read_raw = veml6070_read_raw,
+	.read_avail  = veml6070_read_avail,
+	.write_raw = veml6070_write_raw,
 };
 
 static void veml6070_i2c_unreg(void *p)
@@ -164,6 +280,8 @@ static int veml6070_probe(struct i2c_client *client)
 	indio_dev->name = VEML6070_DRV_NAME;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
+	veml6070_calc_it(&client->dev, data);
+
 	ret = devm_regulator_get_enable(&client->dev, "vdd");
 	if (ret < 0)
 		return ret;

-- 
2.43.0


