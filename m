Return-Path: <linux-iio+bounces-10283-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B069930FA
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 17:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A71D1F23FB2
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 15:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2970B1D9324;
	Mon,  7 Oct 2024 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sr61Mszv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661031D8E08;
	Mon,  7 Oct 2024 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314424; cv=none; b=pp7AyC78x/QpMXR1HP8s4TmLfZMZMIoDO8iS7QF0WW7D3DwILxPKD7fPTwUU9r43aRzrvthlVVf9avClOoP/Wanr7qVOjwFLe95nSh/j3qiG1qQZL+ArpebDXCc+gxfRmOYWqpgrDWDZ5GTCbA6CIZZMCGgFmk/1+qf5NcA3mVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314424; c=relaxed/simple;
	bh=kahuhEbWhljSN1XdX+Glr547jKdvkKJ3VPKL2ysqdQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pm22zVs4ymUfCx2T4eAijPRGzdh8pMpO850sSrmCLsXk8HZRSSQpJjnYHBx/8kzru0Fkg43sNBj69hcMuoXUu56iEN5Nf5KKiA9sh3tyik0Vq2ok6RPg7aulZIo/dRCj2y7LpFj4s2rtzuX7eqNxQKZttEuMlRD07dVDglYTfHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sr61Mszv; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b6458ee37so52820905ad.1;
        Mon, 07 Oct 2024 08:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728314421; x=1728919221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGXYLWa9PfVlmMvYF4HK1fhAmnNokMXHI7JdaUOAE80=;
        b=Sr61MszvwdQPLIMJL4nSOefe9ffo4+mIPwnXK+/qYC/itWxXk8AW9mT2dhstK5qhHj
         LfHUi9bM0kY/xKs9mR38fSS5/DnhA4fm4PpneXsx9YZ5Y6wWWc8Okmy/GECvQf82qvq2
         N9klVIxq9CLZQnuZP6/KO40QWxVyDi50nLTJUZ8dpQuNjSywAAXSdgNLBME+lin8eoRs
         H41ZNeAyZPLNMctmFf6yGSJsDcSbpCtTi2faPEvPSxRsx9NZq0fDWk0Wvg2txnQhCcXA
         yhTBkc92PTCMdNn4yriuLEtu9tln/1gz9iatjoNxlW7wMxDgxm+o22YTl+WpE1vSu6+0
         r+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728314421; x=1728919221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGXYLWa9PfVlmMvYF4HK1fhAmnNokMXHI7JdaUOAE80=;
        b=SwQiCz9Y2sip65wFlwb2xKPj3FuNSZ5I8794d29IZzq2vSKzCsHq1ttJCPcwll8K2c
         LRbZ+Ku15lJaYxkHLOzsYb0MvTT2wzA0ASlR9C1N1AtYlKcwPUExTUx7IeBnv9RjpHld
         MTwn2EgRPFKnKtabDpGUXTJtkUorMIppfuvikFOMX8+xtp+2NAP+c7m4UyezlClRszQf
         P3DV3v0DpMG8Js6AFbJ4vnRTiHVs6fPltrmzGQxDaHs98zON1YuqGFq63xfWf9vN43cJ
         gykQwfMZJhASx5DOgHRywnnklcVg5Hnvp2WDzXb2BNjNtOOm2j3B8hdPLvU38x1KyA/g
         ql6A==
X-Forwarded-Encrypted: i=1; AJvYcCX9Q6EMTIWn341v8+wWW3mNeND4/IanbRz/H6yNXs6S9KvA9djJoMwqNvElCZz0OMRdQi5LzVQy0t/zSag=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFRmMXw7Qnlv2oX5Vw3vMujLY5nLP5oyi1/in9OebKLdfQ7RX/
	K+kjPz6rAUYnyfCqGbhIOj7N7TBMeIIeM/hdJoJvJnjp7ZwA4wH+cILOj0BWieE=
X-Google-Smtp-Source: AGHT+IF/adgye/9imrxRdWOmsrXvNj+RaMAm6X+oSoTCeiTWPfZ627OqTUq0FI6wwgutoU63E72YIw==
X-Received: by 2002:a17:902:d50c:b0:20b:6145:d0d5 with SMTP id d9443c01a7336-20bfde5fed4mr179128415ad.10.1728314421511;
        Mon, 07 Oct 2024 08:20:21 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20c138b1395sm41000755ad.3.2024.10.07.08.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:20:21 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v3 3/3] iio: light: vl6180: Add support for Continuous Mode
Date: Mon,  7 Oct 2024 20:49:47 +0530
Message-ID: <20241007151947.58828-4-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007151947.58828-1-abhashkumarjha123@gmail.com>
References: <20241007151947.58828-1-abhashkumarjha123@gmail.com>
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


