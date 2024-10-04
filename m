Return-Path: <linux-iio+bounces-10136-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFD8990709
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 17:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239F52882B3
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 15:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F3C1C7600;
	Fri,  4 Oct 2024 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNu6gwlT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3251C75F6;
	Fri,  4 Oct 2024 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728054164; cv=none; b=fOyt29EezeSsw3oRNAly3wxq/0Rlpo4RZbakOj9I0i8adOWy42CEqGCUxFr+eRXEG4YkOVl/lHUUoUi6fGspMgAts3Iipw6NemmZaddRXWbetmMJEvzYjNha29128d+UOCk+P5oAoZVCAYCiEfYn1Lhyc9hTpqteK7tqvmQwg1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728054164; c=relaxed/simple;
	bh=Fjx/l2xdHysAK/CJdTUGFN8OKKZLV0AyFZ/ZqSxNnI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hjov4sauLxQjY5CknWVGg9Rh2hHGonztNjDvZ2YagOVLw4u5CEEwI+870oDpUkV0qoQdu3B0GIm3QD2dzgi40+YiRkm+7EM2nJKmwb2CPiC0nTAb5iQ4mxkb6rHye2U5mZnELG21S5llr/nBoo57GPbQrZxr370BrajsnHWfEp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNu6gwlT; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-718e2855479so1855507b3a.1;
        Fri, 04 Oct 2024 08:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728054160; x=1728658960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ySn74GfdRjrISJyyXSwTVcF7lv1Nr6YC2yCmv/pj+A=;
        b=VNu6gwlTVy+y5TGia/kyRmgmTrVR09l8IWGkvRkW4/2kGvOzMn+2dqnYY2aKuWM+3P
         k3w/8UT7P6bGX0Yn0KepOlv88cXDL3vDCb1VAAeUjJYhCNP2IBNwICzWe8yGnzrg1UDT
         rpPKX9wN0hYaCh4WJKQoiKl4HsxMZ8iWaRgjT1Mxei0/Hp+RCDwOYFpuOOpT8hGvRIwQ
         0JCrIeJPbzru/LTadBhirnSUT2UwkHgO5DBcxhbhPSn9XzFSOEWdhivA9Gcd+UepViHE
         cj37Y1A2hexp9kqwa9uPBYoa1HXhodUzXPy5WXoy6CKyuQ6XJDdo2exzNjwldwa7klKl
         owug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728054160; x=1728658960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ySn74GfdRjrISJyyXSwTVcF7lv1Nr6YC2yCmv/pj+A=;
        b=OZqIE2Ny9o3KPA034eHZu9ZBNGqy6USC/p+Kf7pgJEon4Dlyt3iM8vJeNfXmLLrNyW
         MrMUVzbdUkN8RS7bCmbyDhbxFefFDYyFBIM3YyPxpvqFgPsCQ02zDAKSv6s5iIsx2OdA
         jEO9BSJ3j7tffr8+LZO/zExmwCwxkmJ3b3++KsFwGDVCAbhZf1Ro+EYvUNkPOF6rLHuW
         zqb0lxby4MMRxNt5I5YB5Sjdo7qfK4/3xuHC7NQ7/ls6K+KjpSlw3+kOBLQgiVk7iu7Q
         Vrri+OGMBX/KBmhtKb2pPRM+qmrem9W5U2/nLwgHCFBUnUg6Z544QlDo178WvMtqqRA2
         DSqw==
X-Forwarded-Encrypted: i=1; AJvYcCWlmA2SutohMd1+BFl1D30bCE3j5+C9adK6Uii9QydCZmdYSJhQfvDe9EFbLetqMQyUcirj5750XcHrMtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgG25Ce7Fu9E/2kP2huFNexLu+s8PVR0RacDDWQJV4EFJ1G8Sm
	4/kAL/uq7tA7uuzIy+pS71Ke+N1DjPEy2o1nwjesryEyP8Nh3uHcd7rw7W9Cc/E=
X-Google-Smtp-Source: AGHT+IFHC8xL8+nWqUauFWJMNcz4vp8AIZyiJMaiZHrJZGOQlLhVWB/zbpUeaTjU3fZx701yF0/i+A==
X-Received: by 2002:aa7:88c9:0:b0:710:50c8:ddcb with SMTP id d2e1a72fcca58-71de23a57efmr4622308b3a.5.1728054160108;
        Fri, 04 Oct 2024 08:02:40 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7e9f6c34127sm19979a12.67.2024.10.04.08.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 08:02:39 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH 3/3] iio: light: vl6180: Add support for Continuous Mode
Date: Fri,  4 Oct 2024 20:31:48 +0530
Message-ID: <20241004150148.14033-4-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004150148.14033-1-abhashkumarjha123@gmail.com>
References: <20241004150148.14033-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added support for getting continuous readings from vl6180 using
triggered buffer approach. The continuous mode can be enabled by
enabling the buffer.
Also added a trigger and appropriate checks to see that it is used
with this device.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/light/vl6180.c | 138 +++++++++++++++++++++++++++++++++++--
 1 file changed, 134 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
index 4c2b486e2..e724e752e 100644
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
 
@@ -91,10 +95,16 @@ struct vl6180_data {
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
+		u16 chan;
+		aligned_u64 timestamp;
+	} scan;
 };
 
 enum { VL6180_ALS, VL6180_RANGE, VL6180_PROX };
@@ -275,6 +285,12 @@ static const struct iio_chan_spec vl6180_channels[] = {
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
@@ -283,14 +299,27 @@ static const struct iio_chan_spec vl6180_channels[] = {
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
@@ -497,17 +526,99 @@ static irqreturn_t vl6180_threaded_irq(int irq, void *priv)
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
+	int ret;
+
+	for (int i = 0; i < indio_dev->masklength; i++) {
+		if (test_bit(i, indio_dev->active_scan_mask)) {
+
+		ret = vl6180_chan_regs_table[i].word ?
+			vl6180_read_word(data->client, vl6180_chan_regs_table[i].value_reg) :
+			vl6180_read_byte(data->client, vl6180_chan_regs_table[i].value_reg);
+		if (ret < 0)
+			dev_err(&data->client->dev, "failed to read from value regs: %d\n", ret);
+
+		data->scan.chan = ret;
+		iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
+						iio_get_time_ns(indio_dev));
+		}
+	}
+
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
 
+static int vl6180_validate_trigger(struct iio_dev *indio_dev, struct iio_trigger *trig)
+{
+	struct vl6180_data *data = iio_priv(indio_dev);
+
+	return data->trig == trig ? 0 : -EINVAL;
+}
+
 static const struct iio_info vl6180_info = {
 	.read_raw = vl6180_read_raw,
 	.write_raw = vl6180_write_raw,
 	.attrs = &vl6180_attribute_group,
+	.validate_trigger = vl6180_validate_trigger,
 };
 
-static int vl6180_init(struct vl6180_data *data)
+static int vl6180_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct vl6180_data *data = iio_priv(indio_dev);
+
+	for (int i = 0; i < indio_dev->masklength; i++) {
+		if (test_bit(i, indio_dev->active_scan_mask))
+			return vl6180_write_byte(data->client,
+				vl6180_chan_regs_table[i].start_reg,
+				VL6180_MODE_CONT | VL6180_STARTSTOP);
+	}
+
+	return -EINVAL;
+}
+
+static int vl6180_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct vl6180_data *data = iio_priv(indio_dev);
+
+	for (int i = 0; i < indio_dev->masklength; i++) {
+		if (test_bit(i, indio_dev->active_scan_mask))
+			return vl6180_write_byte(data->client,
+				vl6180_chan_regs_table[i].start_reg,
+				VL6180_STARTSTOP);
+	}
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
@@ -547,6 +658,12 @@ static int vl6180_init(struct vl6180_data *data)
 	if (ret < 0)
 		return ret;
 
+	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
+						&vl6180_trigger_handler,
+						&iio_triggered_buffer_setup_ops);
+	if (ret)
+		return ret;
+
 	/* Default Range inter-measurement time: 50ms
 	 * reg_val = (50 / 10 - 1) = 4
 	 */
@@ -603,7 +720,7 @@ static int vl6180_probe(struct i2c_client *client)
 	indio_dev->name = VL6180_DRV_NAME;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = vl6180_init(data);
+	ret = vl6180_init(data, indio_dev);
 	if (ret < 0)
 		return ret;
 
@@ -618,6 +735,19 @@ static int vl6180_probe(struct i2c_client *client)
 		}
 
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


