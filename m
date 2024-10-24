Return-Path: <linux-iio+bounces-11239-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABE19AF3FA
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 22:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB21285A7A
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 20:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228D3218304;
	Thu, 24 Oct 2024 20:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWL54DWT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBBF217328;
	Thu, 24 Oct 2024 20:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729802701; cv=none; b=uzq1dJ5+05/hGoR2u7bPmEck/BPaESGGR/dGTPR60B0T4Y0ChFSCZzbfMSrJ0gKVb1Nk79OTL8gMkLk+mxLjz8QkfJn63/38T13xH5HVrot974Dv3f/HvP2LuGE6NFT4Ffs5fs6PK6bD2MbA7I6vH1IbRut/u7kQEsFgVDHmH78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729802701; c=relaxed/simple;
	bh=oZPAr3Y77yWNy4K+Aw0DjhYwJTcFqi612sUO6EctSpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DwZHnordqN+kL5kV7nobycpsmASO92yobF6ofuUBQnpA1495Eoq+dKotZikz0AjdaB855jvttC3NuaztDFh9WmV86Clas4fuqRwhK2B2TdVAhuklJKZygf70zw99dw1YSiIxZg7KmjyyTaRt39zR1hl7ZzYPqMV+0hU0XfYUfrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWL54DWT; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315baa51d8so13961395e9.0;
        Thu, 24 Oct 2024 13:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729802697; x=1730407497; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gk6vB3S5OtF3deyvVo5NWizKGTdTO11ShjSSXMNyYtg=;
        b=CWL54DWTD9XAPCBnLEekOX6nZPOB/eN91VlR/ClT4E4q5ReCrhoXG9yR8fAzrL9Fta
         3ZrTtpiS7b7crbFL/frvxPWOKA1OTogqWX9Xyke6QhqhQVfh8odFOEJC04rhgAtMcxWB
         QCj7ZtepdJWwR2VUeIriuL8pbIQqRnyXn/gxBTSQQHwUkBSozWc3VTC3krjf8KJXSyh/
         1dFdQ2a5MPDFqbQi2B653wz12QfD9PKZLRtBa7ZKzZpNXBoXQCDmhOggElZ13UZzYqGM
         b/mgGgAzZxlZnmFFiyehllpAk6VIxHja3s+lGolk74hxL7C82tIMMB7c0z+aTussJron
         QI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729802697; x=1730407497;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gk6vB3S5OtF3deyvVo5NWizKGTdTO11ShjSSXMNyYtg=;
        b=wap6QlnJbdsMHz94JEK9KUlAI760iPENaWzJ/VShMmpecqy9zUgiU6pPAa2HgAFpUO
         GZfpcSBxfLO+XCm/kJF9gRQjGZq5w48KWA3V0sUy1Rh2uAyfkUFJRDGXC9p8Pr+4qiBS
         D4CpaaC51EPxsf84mksLyXy4KWXJRuRx77FXvOGGE7T1e4I72RILKiMT3V2o7K0IXJ1F
         uepKHDBnCaZnJ8MZaUWqs96ZCTmEoqPmyHy8/lXwcoigiPQX1iubbdv1Bb1c6NS4oKF1
         VR3Nh4NQ0/1SGElgQhg4zHKFJs/6s4SJ3NzJehV3v2RUQMULKqa+TIJBrMQQxgndq6Hl
         KkqA==
X-Forwarded-Encrypted: i=1; AJvYcCW38IRwYyPXcqMRRuO36PtJJlbMAi3tWb320sYxpqIvwMkJDCPlXLF0RwdcB3vJPo23y7zyX5kFa7Ow@vger.kernel.org, AJvYcCXFd/MkSuWZJzm0/H2T3q7EQZk0mbZlXm+/yI8ne/qlCDItn1BOJDDkg16azGov0apOUw3mlqUaqcnRwDM0@vger.kernel.org
X-Gm-Message-State: AOJu0YxpQRjmvBBNB/gohSe+rh6jCGTIoZrhwH1f3L7lWWm7aDFYeKDJ
	W1BvT3RJiCeIrsV6PPNfN5fy5R6mmAP0DoFm3VQK8YplykYtgfG3dVBovA==
X-Google-Smtp-Source: AGHT+IFXGM9zmI0GTZC1CmI3sJ8G7Sk5Ttti+QQTSHUccgp/ruhC3cqoeoYu7KNY8KcR0y14eTBM1w==
X-Received: by 2002:a05:6000:1802:b0:37d:4e59:549a with SMTP id ffacd0b85a97d-37efcf0c85bmr4850729f8f.16.1729802697331;
        Thu, 24 Oct 2024 13:44:57 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-937a-2f15-cf5f-c6fb.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:937a:2f15:cf5f:c6fb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a4ad48sm12105728f8f.42.2024.10.24.13.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 13:44:55 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 24 Oct 2024 22:44:49 +0200
Subject: [PATCH v2 2/2] iio: light: veml6070: add support for integration
 time
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-veml6070-integration-time-v2-2-d53272ec0feb@gmail.com>
References: <20241024-veml6070-integration-time-v2-0-d53272ec0feb@gmail.com>
In-Reply-To: <20241024-veml6070-integration-time-v2-0-d53272ec0feb@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729802691; l=6773;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=oZPAr3Y77yWNy4K+Aw0DjhYwJTcFqi612sUO6EctSpo=;
 b=h09zjFTJ8/vtNeSChQJpZEfxxR1o13vMRNQvP9HWqzp5nj1mUo0WZaagwn6b6J5EI/G/1+wIM
 E7hPzUqNudbAfeA9n80ZPwP0ehGu7K+4eIFgHcHQ8HcD9e6hr85U6YK
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The integration time of the veml6070 depends on an external resistor
(called Rset in the datasheet) and the value configured in the IT
field of the command register, whose supported values are 1/2x, 1x,
2x and 4x.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6070.c | 137 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 129 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
index d11ae00f61f8..d4d024e1b171 100644
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
@@ -29,18 +29,88 @@
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
+	u32 it[4][2];
 };
 
+static void veml6070_calc_it(struct device *dev, struct veml6070_data *data)
+{
+	u32 tmp_it;
+	int i, ret;
+
+	ret = device_property_read_u32(dev, "rset-ohms", &data->rset);
+	if (ret) {
+		dev_warn(dev, "no Rset specified, using default 270 kohms\n");
+		data->rset = 270000;
+	}
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
+	/**
+	 * convert to kohm to avoid overflows and work with the same units as
+	 * in the datasheet and simplify UVI operations.
+	 */
+	data->rset /= 1000;
+
+	tmp_it = VEML6070_MIN_IT_US * data->rset / VEML6070_MIN_RSET_KOHM;
+	for (i = 0; i < ARRAY_SIZE(data->it); i++) {
+		data->it[i][0] = (tmp_it << i) / 1000000;
+		data->it[i][1] = (tmp_it << i) % 1000000;
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
@@ -51,7 +121,9 @@ static int veml6070_read(struct veml6070_data *data)
 	if (ret < 0)
 		return ret;
 
-	msleep(125 + 10); /* measurement takes up to 125 ms for IT 1x */
+	veml6070_get_it(data, &val, &val2);
+	it_ms = val * 1000 + val2 / 1000;
+	msleep(it_ms + 10);
 
 	ret = i2c_smbus_read_byte(data->client2); /* read MSB, address 0x39 */
 	if (ret < 0)
@@ -81,26 +153,37 @@ static const struct iio_chan_spec veml6070_channels[] = {
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
+	 * the RSET pin (default: 270 KOhm, IT = 1x)
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
@@ -123,10 +206,44 @@ static int veml6070_read_raw(struct iio_dev *indio_dev,
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
@@ -134,6 +251,8 @@ static int veml6070_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info veml6070_info = {
 	.read_raw = veml6070_read_raw,
+	.read_avail  = veml6070_read_avail,
+	.write_raw = veml6070_write_raw,
 };
 
 static void veml6070_i2c_unreg(void *p)
@@ -164,6 +283,8 @@ static int veml6070_probe(struct i2c_client *client)
 	indio_dev->name = VEML6070_DRV_NAME;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
+	veml6070_calc_it(&client->dev, data);
+
 	ret = devm_regulator_get_enable(&client->dev, "vdd");
 	if (ret < 0)
 		return ret;

-- 
2.43.0


