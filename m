Return-Path: <linux-iio+bounces-10287-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A5A993108
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 17:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C461C22D83
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 15:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3941D959A;
	Mon,  7 Oct 2024 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5PZvXh+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5508B1D935A;
	Mon,  7 Oct 2024 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314567; cv=none; b=VSlYTJLQi84Q9D79a5vlAhqSEKx3E5nlUlv1KTVFWY6juz+oBZNAFRm1KaI6Z2MSmgWNcVrECMooyQtnj5aXGumUFO4zS/YGLDA6hqpGdJtIBCndStGoNHYJtg3/BDaY+K6FOQbaHY0DDVXQ1ejwk8tQVBUKNHXBsfT70IWtvo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314567; c=relaxed/simple;
	bh=kahuhEbWhljSN1XdX+Glr547jKdvkKJ3VPKL2ysqdQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmeQgZBPgjMFCLqqvg0MHcgBOF6RVl6Y7dIbb/sB78JGCjcsaH2kvhdREic0zo0zkqRN2TqtLL+9Q3vEb9AxZw5iM5hEitbaQaOCS/al+dHiCIY9OzKAaAvd+Y3BRZawq+mqPGfBBV9pQnURuzv6tYwJhCKaBfOJZJAhCp7HBQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5PZvXh+; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ea03ecf191so1247701a12.0;
        Mon, 07 Oct 2024 08:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728314564; x=1728919364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGXYLWa9PfVlmMvYF4HK1fhAmnNokMXHI7JdaUOAE80=;
        b=m5PZvXh+2ksgnzjTt2OIzG+fCLmFuSXT+H9VhKBm6xJsrabwDuMBIMhkmMCF97zzTT
         irpgmnnCp2/OzESudFAsg7Bt+M4eSdbERHfkwrdX8Kie8mjwwXFbK/sjUCs1cQC7hRl6
         KHHqC4oX53x3EXE9nBF/f4NnfShga/VId3FFCB/f4Cpa3/pXAUxqakB5i1BU8rMjuqBr
         +x+DIf2L69YfC/qZIBdWX0OjQy4vwjws3Lyy4sgaxKdgjtNWDrIWQcRiK6aPFl63LUZr
         ySy/cJQ5bHr6YWGzwdf9jWwDU7jp1GbAX+ciNKezfbIEQzLHULad0P7CvTr8aBF2fvXy
         Ug9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728314564; x=1728919364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGXYLWa9PfVlmMvYF4HK1fhAmnNokMXHI7JdaUOAE80=;
        b=ku71deYx63MPnvgCMjgwlylT1TvXS0WVsD5o2iyLBDAE+vEAlLu63ajGYVZeafyAZY
         iJphpA7MyYwQx9wleG3ruU+IXf9wIMaZIegWAbAayegzOEXsCzA7+2YuVr9uDXgvBGhX
         qVetwJYjCBxiBoQzOeapITN/BurKx8mnmL9EYWffD1z9DxJVU12sM1tjj2Su041VWBva
         7XO6vm5YLAGa/gtd7vCiFGnGn6WGs4MSW+7Gj2F3t4WkGvHUp1Pooj/I4BAtYot/ojZK
         In6G2SA1doxFaduqXcUiy+CsdD8G/+pZZvMfarU8UPXfEWHkEoRtBFl8eUY60X4calyM
         zGOw==
X-Forwarded-Encrypted: i=1; AJvYcCWILr6LiltpAI2clAKY+ZSr4qLEHfRGDGF7XRrA0v/AT93E2wlrkPysKtP9W7ubPml4A9rDl9OmkSfuKJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSHkXYnWmeKJ9gX/9h/pYEVfrYvs0FjelyHSI4RdUlQMbk7Klt
	Io9NmciWTAx2AqGLu87kM/PdwYffEYbT9r0Y2cAwxqi47po2XGhFOz+Azw1BrYE=
X-Google-Smtp-Source: AGHT+IGg4fDZTfwSodiIxvKKC0awHpg5iBCyYkbp+o+1V4s+lZyTXsCLdYL3Vf8ED/UMff0pP5QO8g==
X-Received: by 2002:a17:90b:3795:b0:2d8:9255:396d with SMTP id 98e67ed59e1d1-2e1e5dc6041mr12735437a91.0.1728314564309;
        Mon, 07 Oct 2024 08:22:44 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e20ae7169esm5573934a91.10.2024.10.07.08.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:22:43 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v3 3/3] iio: light: vl6180: Add support for Continuous Mode
Date: Mon,  7 Oct 2024 20:52:23 +0530
Message-ID: <20241007152223.59008-4-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007152223.59008-1-abhashkumarjha123@gmail.com>
References: <20241007152223.59008-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added support for getting continuous readings from vl6180 using
triggered buffer approach. The continuous mode can be enabled by enabling
the buffer. Also added a trigger and appropriate checks to see that it is
used with this device.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/light/vl6180.c | 133 +++++++++++++++++++++++++++++++++++--
 1 file changed, 129 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
index a747501b0..f0c7a13a0 100644
--- a/drivers/iio/light/vl6180.c
+++ b/drivers/iio/light/vl6180.c
@@ -25,6 +25,10 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #define VL6180_DRV_NAME "vl6180"
 
@@ -87,10 +91,16 @@ struct vl6180_data {
 	struct i2c_client *client;
 	struct mutex lock;
 	struct completion completion;
+	struct iio_trigger *trig;
 	unsigned int als_gain_milli;
 	unsigned int als_it_ms;
 	unsigned int als_meas_rate;
 	unsigned int range_meas_rate;
+
+	struct {
+		u16 chan[2];
+		aligned_s64 timestamp;
+	} scan;
 };
 
 enum { VL6180_ALS, VL6180_RANGE, VL6180_PROX };
@@ -272,6 +282,12 @@ static const struct iio_chan_spec vl6180_channels[] = {
 	{
 		.type = IIO_LIGHT,
 		.address = VL6180_ALS,
+		.scan_index = VL6180_ALS,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+		},
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			BIT(IIO_CHAN_INFO_INT_TIME) |
 			BIT(IIO_CHAN_INFO_SCALE) |
@@ -280,14 +296,27 @@ static const struct iio_chan_spec vl6180_channels[] = {
 	}, {
 		.type = IIO_DISTANCE,
 		.address = VL6180_RANGE,
+		.scan_index = VL6180_RANGE,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 8,
+			.storagebits = 8,
+		},
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			BIT(IIO_CHAN_INFO_SCALE) |
 			BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	}, {
 		.type = IIO_PROXIMITY,
 		.address = VL6180_PROX,
+		.scan_index = VL6180_PROX,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+		},
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-	}
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
 /*
@@ -499,7 +528,48 @@ static irqreturn_t vl6180_threaded_irq(int irq, void *priv)
 	struct iio_dev *indio_dev = priv;
 	struct vl6180_data *data = iio_priv(indio_dev);
 
-	complete(&data->completion);
+	if (iio_buffer_enabled(indio_dev))
+		iio_trigger_poll_nested(indio_dev->trig);
+	else
+		complete(&data->completion);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t vl6180_trigger_handler(int irq, void *priv)
+{
+	struct iio_poll_func *pf = priv;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct vl6180_data *data = iio_priv(indio_dev);
+	s64 time_ns = iio_get_time_ns(indio_dev);
+	int ret, bit, i = 0;
+
+	iio_for_each_active_channel(indio_dev, bit) {
+		if (vl6180_chan_regs_table[bit].word)
+			ret = vl6180_read_word(data->client,
+				vl6180_chan_regs_table[bit].value_reg);
+		else
+			ret = vl6180_read_byte(data->client,
+				vl6180_chan_regs_table[bit].value_reg);
+
+		if (ret < 0) {
+			dev_err(&data->client->dev,
+				"failed to read from value regs: %d\n", ret);
+			return IRQ_HANDLED;
+		}
+
+		data->scan.chan[i++] = ret;
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan, time_ns);
+	iio_trigger_notify_done(indio_dev->trig);
+
+	/* Clear the interrupt flag after data read */
+	ret = vl6180_write_byte(data->client, VL6180_INTR_CLEAR,
+		VL6180_CLEAR_ERROR | VL6180_CLEAR_ALS | VL6180_CLEAR_RANGE);
+	if (ret < 0)
+		dev_err(&data->client->dev, "failed to clear irq: %d\n", ret);
+
 	return IRQ_HANDLED;
 }
 
@@ -507,9 +577,45 @@ static const struct iio_info vl6180_info = {
 	.read_raw = vl6180_read_raw,
 	.write_raw = vl6180_write_raw,
 	.attrs = &vl6180_attribute_group,
+	.validate_trigger = iio_validate_own_trigger,
 };
 
-static int vl6180_init(struct vl6180_data *data)
+static int vl6180_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct vl6180_data *data = iio_priv(indio_dev);
+	int bit;
+
+	iio_for_each_active_channel(indio_dev, bit)
+		return vl6180_write_byte(data->client,
+			vl6180_chan_regs_table[bit].start_reg,
+			VL6180_MODE_CONT | VL6180_STARTSTOP);
+
+	return -EINVAL;
+}
+
+static int vl6180_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct vl6180_data *data = iio_priv(indio_dev);
+	int bit;
+
+	iio_for_each_active_channel(indio_dev, bit)
+		return vl6180_write_byte(data->client,
+			vl6180_chan_regs_table[bit].start_reg,
+			VL6180_STARTSTOP);
+
+	return -EINVAL;
+}
+
+static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_ops = {
+	.postenable = &vl6180_buffer_postenable,
+	.postdisable = &vl6180_buffer_postdisable,
+};
+
+static const struct iio_trigger_ops vl6180_trigger_ops = {
+	.validate_device = iio_trigger_validate_own_device,
+};
+
+static int vl6180_init(struct vl6180_data *data, struct iio_dev *indio_dev)
 {
 	struct i2c_client *client = data->client;
 	int ret;
@@ -544,6 +650,12 @@ static int vl6180_init(struct vl6180_data *data)
 	if (ret < 0)
 		return ret;
 
+	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
+						&vl6180_trigger_handler,
+						&iio_triggered_buffer_setup_ops);
+	if (ret)
+		return ret;
+
 	/* Default Range inter-measurement time: 50ms or 20000 mHz */
 	ret = vl6180_write_byte(client, VL6180_RANGE_INTER_MEAS_TIME,
 				vl6180_meas_reg_val_from_mhz(20000));
@@ -598,7 +710,7 @@ static int vl6180_probe(struct i2c_client *client)
 	indio_dev->name = VL6180_DRV_NAME;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = vl6180_init(data);
+	ret = vl6180_init(data, indio_dev);
 	if (ret < 0)
 		return ret;
 
@@ -611,6 +723,19 @@ static int vl6180_probe(struct i2c_client *client)
 			return dev_err_probe(&client->dev, ret, "devm_request_irq error \n");
 
 		init_completion(&data->completion);
+
+		data->trig = devm_iio_trigger_alloc(&client->dev, "%s-dev%d",
+						indio_dev->name, iio_device_id(indio_dev));
+		if (!data->trig)
+			return -ENOMEM;
+
+		data->trig->ops = &vl6180_trigger_ops;
+		iio_trigger_set_drvdata(data->trig, indio_dev);
+		ret = devm_iio_trigger_register(&client->dev, data->trig);
+		if (ret)
+			return ret;
+
+		indio_dev->trig = iio_trigger_get(data->trig);
 	}
 
 	return devm_iio_device_register(&client->dev, indio_dev);
-- 
2.43.0


