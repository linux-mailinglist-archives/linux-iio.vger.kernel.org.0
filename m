Return-Path: <linux-iio+bounces-9002-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D331968849
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 15:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FE86B20F2D
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 13:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0F41D6180;
	Mon,  2 Sep 2024 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+Rgq99c"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AD36FD5;
	Mon,  2 Sep 2024 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282127; cv=none; b=XjVQPjp6R347vhh6bNSWOex99P66m8MTyAHIsanSQsmItT/dV12sgyky15YPvvRcOgc9zBGboQ8QAOfcgimwVdGGsNvCGCE+1MIIobn1eSdQ8TpQUaIxIZI/OZUSid1cZHxtKEyDEnlJ/ZpH04/GjIkg9BV4VDHHGU280snG16U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282127; c=relaxed/simple;
	bh=kdFlFXieU6YHUocmcFd61SowmuIowi5fKHLyyDAYGSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UnN+Es7dh00NknrIcOHqkrGPtqbELZd0WHSqUpYFHFFm3b0JmLlu1Ltg0Ifm0GnncC3vrbhhcujUaYuUV7wZu8yvfUyvLn0oZGK6NCx/TdZzzxBQzPK+Jc4q5hHz0LRFQLwRhLUz9KUkvIAuXKYzLdK8m/LlOsYyG7/kmOXf2oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+Rgq99c; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5353cd18c20so4990156e87.0;
        Mon, 02 Sep 2024 06:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725282123; x=1725886923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7niqeUp9DUGRdneFCk61y2m68xGYdegLPejgXDoJQ9k=;
        b=F+Rgq99cOXC5XDP1e7zn0aZQ4ADpE9JDpVl9EjTxeyy7tSlYJhHk38sL798/R9Mae7
         NnLedhBB9/Tfcw2rpq+Z+ALX3wSh18psML4hSW7eNF1cLUxzpst0zP83F4YJQdDQJmr7
         /tOeL5u7GRMXtJqsu/q6qqQVqQqX0KXXw2yWPXXQGmNBKJGj4SOCHjJs1cTAWhd6g3TR
         cmkuC1cDqoEpbjZgBjROBet36gef8tQcXhBKi5iV+laUBhJO2w0McBXYukmUGo+MdKRe
         0AIzpkcm/YY0Ko6ZV1aSnURMAU+OXCFvVEOEcu6jWsYOCSSR51ri+9zLOKRv/+C4xDIV
         15Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725282123; x=1725886923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7niqeUp9DUGRdneFCk61y2m68xGYdegLPejgXDoJQ9k=;
        b=tQE5gCNT/4zsZiVl4FLdmsRn3+cVbqW7ZgCZz4Mkg2AkLDxe63AgOdvNB50dm0LH/y
         Y02kV7WAjCGkd2fGGng/XVvxaP4U6CWLRU1mWfQW0ynOi/HQhmloRfoorqeRoBTqQlAh
         cjFV+dKHmhAIAImnUHc7hiojJ95FhAHJ0KBW9D+YWylf8GuYxfvYqEatDyH7nO936mkn
         dynUbqLfkujOyUEFNDzOWivWT8hoFzm15FyDsHjuoye/CXOcOUkufF2uwRrympqHB+Lc
         Ud8OKNvVUQwy3atSUUuM+8+LnWR2WrqYblIZ5NPaLk9pwVHQ5z5lfSVsEshHUEzSmvWm
         NOtg==
X-Forwarded-Encrypted: i=1; AJvYcCUhIhiZgaG/f4gC+fedJdSEG1eCLvNCWpKnCDS8CxWJvJ3nDYwS24r511eNnl5k8LKEXUoNz6ZkfWTE@vger.kernel.org, AJvYcCVL61IeSqliaMXH8c1eR8nIqP1+A2IHDCUMiF6H+bDm9KmZmjq8RFIb7rCPvY9hXvEpbcIK2SIPCkd2wAZ3@vger.kernel.org, AJvYcCVQv4h8obL0MpCA5dz7jSAN6nJYGqgwOCE4R268vnTEAeCSFWH6XJ1HQ2CX0zEKnTmw95W/Cx5jyCiN@vger.kernel.org
X-Gm-Message-State: AOJu0YwWnrF6jjEALXvxzWi6yVmZdJch0w9fyUlpw1n9DYLYgxAr7j6A
	jUrjBlwmtqXy7oqx2nh8BvjeGGeCOym1eWNBmclqPJkSX/vh5RWy
X-Google-Smtp-Source: AGHT+IEnLkAJsjTv0l47L3ZjtI9JOsOcTsIHgj7Jh+DqTUbi1W+WlBSYc9FTRITVuJc+8eGypj+1BQ==
X-Received: by 2002:a05:6512:e84:b0:534:53ea:17e1 with SMTP id 2adb3069b0e04-53546aef86amr6938079e87.11.1725282122192;
        Mon, 02 Sep 2024 06:02:02 -0700 (PDT)
Received: from localhost.localdomain ([37.162.182.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989196968sm554979066b.139.2024.09.02.06.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 06:02:01 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org
Cc: pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH 1/2] iio: temperature: tmp006: add triggered buffer support
Date: Mon,  2 Sep 2024 14:59:47 +0200
Message-Id: <20240902125946.350635-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902125946.350635-1-apokusinski01@gmail.com>
References: <20240902125946.350635-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for continuous data capture using triggered buffers for the
tmp006 sensor. The device features a "data ready" interrupt line which
is pulled down once a new measurement is ready to be read.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
Note:
For some reason, the checkpatch.pl returns a warning for this patch:

  WARNING: Missing a blank line after declarations
  #156: FILE: drivers/iio/temperature/tmp006.c:253:
  +               s16 channels[2];
  +               s64 ts __aligned(8);

It also suggests that the following code with a blank line is correct:

	struct {
		s16 channels[2];

		s64 ts __aligned(8);
	} scan;

I left the code as it was (with the WARNING) since it feels obviously
more natural.
---
 drivers/iio/temperature/Kconfig  |   2 +
 drivers/iio/temperature/tmp006.c | 116 +++++++++++++++++++++++++++++--
 2 files changed, 111 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
index ed0e4963362f..1244d8e17d50 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -91,6 +91,8 @@ config MLX90635
 config TMP006
 	tristate "TMP006 infrared thermopile sensor"
 	depends on I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  If you say yes here you get support for the Texas Instruments
 	  TMP006 infrared thermopile sensor.
diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index 6d8d661f0c82..183b30a41573 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -7,8 +7,6 @@
  * Driver for the Texas Instruments I2C 16-bit IR thermopile sensor
  *
  * (7-bit I2C slave address 0x40, changeable via ADR pins)
- *
- * TODO: data ready irq
  */
 
 #include <linux/err.h>
@@ -21,6 +19,9 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 
 #define TMP006_VOBJECT 0x00
 #define TMP006_TAMBIENT 0x01
@@ -45,6 +46,7 @@
 struct tmp006_data {
 	struct i2c_client *client;
 	u16 config;
+	struct iio_trigger *drdy_trig;
 };
 
 static int tmp006_read_measurement(struct tmp006_data *data, u8 reg)
@@ -81,15 +83,21 @@ static int tmp006_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
 		if (channel->type == IIO_VOLTAGE) {
 			/* LSB is 156.25 nV */
 			ret = tmp006_read_measurement(data, TMP006_VOBJECT);
+			iio_device_release_direct_mode(indio_dev);
 			if (ret < 0)
 				return ret;
 			*val = sign_extend32(ret, 15);
 		} else if (channel->type == IIO_TEMP) {
 			/* LSB is 0.03125 degrees Celsius */
 			ret = tmp006_read_measurement(data, TMP006_TAMBIENT);
+			iio_device_release_direct_mode(indio_dev);
 			if (ret < 0)
 				return ret;
 			*val = sign_extend32(ret, 15) >> TMP006_TAMBIENT_SHIFT;
@@ -128,7 +136,7 @@ static int tmp006_write_raw(struct iio_dev *indio_dev,
 			    long mask)
 {
 	struct tmp006_data *data = iio_priv(indio_dev);
-	int i;
+	int ret, i;
 
 	if (mask != IIO_CHAN_INFO_SAMP_FREQ)
 		return -EINVAL;
@@ -136,13 +144,19 @@ static int tmp006_write_raw(struct iio_dev *indio_dev,
 	for (i = 0; i < ARRAY_SIZE(tmp006_freqs); i++)
 		if ((val == tmp006_freqs[i][0]) &&
 		    (val2 == tmp006_freqs[i][1])) {
+			ret = iio_device_claim_direct_mode(indio_dev);
+			if (ret)
+				return ret;
+
 			data->config &= ~TMP006_CONFIG_CR_MASK;
 			data->config |= i << TMP006_CONFIG_CR_SHIFT;
 
-			return i2c_smbus_write_word_swapped(data->client,
-							    TMP006_CONFIG,
-							    data->config);
+			ret = i2c_smbus_write_word_swapped(data->client,
+							   TMP006_CONFIG,
+							   data->config);
 
+			iio_device_release_direct_mode(indio_dev);
+			return ret;
 		}
 	return -EINVAL;
 }
@@ -164,13 +178,29 @@ static const struct iio_chan_spec tmp006_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_BE
+		}
 	},
 	{
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
-	}
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 14,
+			.storagebits = 16,
+			.shift = TMP006_TAMBIENT_SHIFT,
+			.endianness = IIO_BE
+		}
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(2)
 };
 
 static const struct iio_info tmp006_info = {
@@ -213,6 +243,49 @@ static void tmp006_powerdown_cleanup(void *dev)
 	tmp006_power(dev, false);
 }
 
+static irqreturn_t tmp006_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct tmp006_data *data = iio_priv(indio_dev);
+	struct {
+		s16 channels[2];
+		s64 ts __aligned(8);
+	} scan;
+
+	scan.channels[0] = i2c_smbus_read_word_data(data->client, TMP006_VOBJECT);
+	if (scan.channels[0] < 0)
+		goto err;
+
+	scan.channels[1] = i2c_smbus_read_word_data(data->client, TMP006_TAMBIENT);
+	if (scan.channels[1] < 0)
+		goto err;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
+					   iio_get_time_ns(indio_dev));
+err:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
+static int tmp006_set_trigger_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct tmp006_data *data = iio_priv(indio_dev);
+
+	if (state)
+		data->config |= TMP006_CONFIG_DRDY_EN;
+	else
+		data->config &= ~TMP006_CONFIG_DRDY_EN;
+
+	return i2c_smbus_write_word_swapped(data->client, TMP006_CONFIG,
+		data->config);
+}
+
+static const struct iio_trigger_ops tmp006_trigger_ops = {
+	.set_trigger_state = tmp006_set_trigger_state,
+};
+
 static int tmp006_probe(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev;
@@ -258,6 +331,35 @@ static int tmp006_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
+	if (client->irq > 0) {
+		data->drdy_trig = devm_iio_trigger_alloc(&client->dev,
+							 "%s-dev%d",
+							 indio_dev->name,
+							 iio_device_id(indio_dev));
+		if (!data->drdy_trig)
+			return -ENOMEM;
+
+		data->drdy_trig->ops = &tmp006_trigger_ops;
+		iio_trigger_set_drvdata(data->drdy_trig, indio_dev);
+		ret = iio_trigger_register(data->drdy_trig);
+		if (ret)
+			return ret;
+
+		indio_dev->trig = iio_trigger_get(data->drdy_trig);
+
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						iio_trigger_generic_data_rdy_poll,
+						NULL,
+						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+						"tmp006_irq",
+						data->drdy_trig);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
+					      tmp006_trigger_handler, NULL);
+
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-- 
2.25.1


