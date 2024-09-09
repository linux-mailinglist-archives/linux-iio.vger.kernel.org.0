Return-Path: <linux-iio+bounces-9380-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2148A971572
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 12:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD0C1C22299
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 10:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1D31B580D;
	Mon,  9 Sep 2024 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OD204rO8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7210C1B580A;
	Mon,  9 Sep 2024 10:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725878251; cv=none; b=Jf9DaN4WrcFa0HcqQFsInvygDK4QWSPrxv5m6Z2XsV90UZXuwzndH+IMi1lasmO4jF69oZID6iu9CqNne2p0s5ld91HeH7tChhwoMd2f1Hbx3WWl8CvUA2q6dRD2T5sbiCWg/O3OvA3XVDcoFIaNDqIwwWBNzZLQ2Zr0uf6MUz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725878251; c=relaxed/simple;
	bh=VNG7rvvZia/wCUOSgxtTR2Ji8uix+Z+Sqo/HnwqlhRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GIgw+1UNvVH+KGEAK9GnitCNnE09Q0/0Oz2nAgmJHcACF2H3KvfmD5fL4eHgNYnzgx4tBt24fwAMSYNKuoXuE+HeoY6XNaJXogtfQOzMHAhY9H7nn5XVPOfMRxXT6bkZNgQN+t0lytNoCp1VcNc4iTiqWWiZIqL1dnlK4ZVGfOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OD204rO8; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-718a3b8a2dcso2265697b3a.2;
        Mon, 09 Sep 2024 03:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725878248; x=1726483048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cINpB1QE7f8M6u2vyABHpUJsKL9FmJXbrSnf5SAefL4=;
        b=OD204rO86j67p/XZuXkj8GV2jR7hcNVvG8OkcTb8SDuIy+6VEaKmMAsVsXII04XZs9
         aWhbAbDpdZ8H6IWA46libOzv5ZTDdgqARIezpL3HDDqgdq1BglQiljuRBpoIoN9vqlba
         5BA0EP6Yks8zivolawY77ML+Pk+ow0tiTLVYOxRt2fCP1XhHhnI1DhWQ5GwtkiUmKJLZ
         S3nmo4qor7oS1h+8RQj5BoR6eRsE20bVMos6r8zuwoVcg9Y3NyfytRQgC3i2E7El0uec
         7GYXhazvnFB6hqGCRW0Cba9J24wujM0V/jUoz3jtGd13GS+4DzDM3+C9uYRVGLxpG989
         Nw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725878248; x=1726483048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cINpB1QE7f8M6u2vyABHpUJsKL9FmJXbrSnf5SAefL4=;
        b=neIRoixMJ083WJ7BPtGVsYAtMUj+NYwjW0+ryR+yyao3cr9CaJhQOpey6I8axJxTUO
         P+jJD/eAczTjRqfz8fMEb6wkrTj1EHa7BXnE02F/1X+73zpQzBPjzWNriDiKzttzQL4F
         TV6Z1nulElBfA5WY7/lYN2IF+Rs+92/YE/fLpnImpz2U7xUACPhSWLHTD/WhbMdj8jj0
         h4gyTez2vXqVdL0Y/sErts5RPlpEaQZzRZKXC5jFYrvoBpbsLYaqnXg+6fYZvm4Om9HJ
         W4VFxz83GPtJk31W1dWRrzr12HBHChntOFTztTvbG4izE/1O2o5wCktx3ckcDBYl4mcx
         4ZCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf/Fff8wEh5SvkPJnSPE1VUv3wlCmXlbDAvb/TFg9sOd0SfEqECQY2wAEEH1mScGND2L2JrFndHS5HM6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyecpKg8fvADmep4TIIEhXbCWGim3J2nlCa/sBPM98EY3a1fuBB
	o8egU3DSBZYEBLn0ODdspbYJHKq1dtUOlcfS2Eox8vJf9n6RLBHWy37joZIRTV0=
X-Google-Smtp-Source: AGHT+IFPO4w7m2Z2BarivpeU4GdfUU+wB2NzdzppQzrTv6AH443WYXXZuWXSeRgyV96rXsewRbQTFw==
X-Received: by 2002:a05:6a00:190d:b0:718:d94b:4b with SMTP id d2e1a72fcca58-718d94b0149mr9276003b3a.6.1725878247635;
        Mon, 09 Sep 2024 03:37:27 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-718e5897b3fsm3258032b3a.25.2024.09.09.03.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 03:37:26 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH 3/4] iio: light: ltr390: Interrupts and threshold event support
Date: Mon,  9 Sep 2024 16:06:22 +0530
Message-ID: <20240909103623.264113-4-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909103623.264113-1-abhashkumarjha123@gmail.com>
References: <20240909103623.264113-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added support for threshold events for both the ALS and UVI channels.
The events are reported when the threshold interrupt is triggered. Both
rising and falling threshold types are supported.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/light/ltr390.c | 220 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 218 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index c4ff26d68..c707a4871 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -26,6 +26,7 @@
 #include <linux/bitfield.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/events.h>
 
 #include <asm/unaligned.h>
 
@@ -33,9 +34,12 @@
 #define LTR390_ALS_UVS_MEAS_RATE	0x04
 #define LTR390_ALS_UVS_GAIN		0x05
 #define LTR390_PART_ID			0x06
+#define LTR390_MAIN_STATUS		0x07
 #define LTR390_ALS_DATA			0x0D
 #define LTR390_UVS_DATA			0x10
 #define LTR390_INT_CFG			0x19
+#define LTR390_THRESH_UP		0x21
+#define LTR390_THRESH_LOW		0x24
 
 #define LTR390_PART_NUMBER_ID		0xb
 #define LTR390_ALS_UVS_GAIN_MASK	0x07
@@ -46,6 +50,8 @@
 #define LTR390_SW_RESET	      BIT(4)
 #define LTR390_UVS_MODE	      BIT(3)
 #define LTR390_SENSOR_ENABLE  BIT(1)
+#define LTR390_LS_INT_EN      BIT(2)
+#define LTR390_LS_INT_SEL_UVS BIT(5)
 
 #define LTR390_FRACTIONAL_PRECISION 100
 
@@ -230,6 +236,22 @@ static const int ltr390_int_time_map_us[] = { 400000, 200000, 100000, 50000, 250
 static const int ltr390_gain_map[] = { 1, 3, 6, 9, 18 };
 static const int ltr390_freq_map[] = { 40000, 20000, 10000, 5000, 2000, 1000, 500, 500 };
 
+static const struct iio_event_spec ltr390_event_spec[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	}
+};
+
 static const struct iio_chan_spec ltr390_channels[] = {
 	/* UV sensor */
 	{
@@ -238,7 +260,9 @@ static const struct iio_chan_spec ltr390_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SCALE)
-						| BIT(IIO_CHAN_INFO_SAMP_FREQ)
+						| BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.event_spec = ltr390_event_spec,
+		.num_event_specs = ARRAY_SIZE(ltr390_event_spec),
 	},
 	/* ALS sensor */
 	{
@@ -247,7 +271,9 @@ static const struct iio_chan_spec ltr390_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SCALE)
-						| BIT(IIO_CHAN_INFO_SAMP_FREQ)
+						| BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.event_spec = ltr390_event_spec,
+		.num_event_specs = ARRAY_SIZE(ltr390_event_spec),
 	},
 };
 
@@ -370,12 +396,186 @@ static int ltr390_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec cons
 	}
 }
 
+static int ltr390_read_threshold(const struct iio_dev *indio_dev,
+				enum iio_event_direction dir,
+				int *val, int *val2)
+{
+	struct ltr390_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		ret = ltr390_register_read(data, LTR390_THRESH_UP);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		return IIO_VAL_INT;
+
+	case IIO_EV_DIR_FALLING:
+		ret = ltr390_register_read(data, LTR390_THRESH_LOW);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ltr390_write_threshold(struct iio_dev *indio_dev,
+				enum iio_event_direction dir,
+				int val, int val2)
+{
+	struct ltr390_data *data = iio_priv(indio_dev);
+	int ret;
+
+	guard(mutex)(&data->lock);
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		ret = regmap_bulk_write(data->regmap,
+					LTR390_THRESH_UP,
+					&val, 3);
+		return ret;
+	case IIO_EV_DIR_FALLING:
+		ret = regmap_bulk_write(data->regmap,
+					LTR390_THRESH_LOW,
+					&val, 3);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ltr390_read_event_value(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				enum iio_event_info info,
+				int *val, int *val2)
+{
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		return ltr390_read_threshold(indio_dev, dir, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ltr390_write_event_value(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				enum iio_event_info info,
+				int val, int val2)
+{
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		if (val2 != 0)
+			return -EINVAL;
+
+		return ltr390_write_threshold(indio_dev, dir, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ltr390_read_event_config(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir)
+{
+	struct ltr390_data *data = iio_priv(indio_dev);
+	int ret, status;
+
+	ret = regmap_read(data->regmap, LTR390_INT_CFG, &status);
+	if (ret < 0)
+		return ret;
+
+	return status & LTR390_LS_INT_EN;
+}
+
+static int ltr390_write_event_config(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				int state)
+{
+	struct ltr390_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (state != 1  && state != 0)
+		return -EINVAL;
+
+	if (state == 0)
+		return regmap_clear_bits(data->regmap, LTR390_INT_CFG, LTR390_LS_INT_EN);
+
+	guard(mutex)(&data->lock);
+	ret = regmap_set_bits(data->regmap, LTR390_INT_CFG, LTR390_LS_INT_EN);
+	if (ret < 0)
+		return ret;
+
+	switch (chan->type) {
+	case IIO_LIGHT:
+		ret = ltr390_set_mode(data, LTR390_SET_ALS_MODE);
+		if (ret < 0)
+			return ret;
+
+		return regmap_clear_bits(data->regmap, LTR390_INT_CFG, LTR390_LS_INT_SEL_UVS);
+
+	case IIO_UVINDEX:
+		ret = ltr390_set_mode(data, LTR390_SET_UVS_MODE);
+		if (ret < 0)
+			return ret;
+
+		return regmap_set_bits(data->regmap, LTR390_INT_CFG, LTR390_LS_INT_SEL_UVS);
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct iio_info ltr390_info = {
 	.read_raw = ltr390_read_raw,
 	.write_raw = ltr390_write_raw,
 	.read_avail = ltr390_read_avail,
+	.read_event_value = ltr390_read_event_value,
+	.read_event_config = ltr390_read_event_config,
+	.write_event_value = ltr390_write_event_value,
+	.write_event_config = ltr390_write_event_config,
 };
 
+static irqreturn_t ltr390_interrupt_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct ltr390_data *data = iio_priv(indio_dev);
+	int ret, status;
+
+	/* Reading the status register to clear the interrupt flag, Datasheet pg: 17*/
+	ret = regmap_read(data->regmap, LTR390_MAIN_STATUS, &status);
+	if (ret < 0)
+		return ret;
+
+	switch (data->mode) {
+	case LTR390_SET_ALS_MODE:
+		iio_push_event(indio_dev,
+			IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
+			IIO_EV_TYPE_THRESH,
+			IIO_EV_DIR_EITHER),
+			iio_get_time_ns(indio_dev));
+		break;
+
+	case LTR390_SET_UVS_MODE:
+		iio_push_event(indio_dev,
+			IIO_UNMOD_EVENT_CODE(IIO_UVINDEX, 0,
+			IIO_EV_TYPE_THRESH,
+			IIO_EV_DIR_EITHER),
+			iio_get_time_ns(indio_dev));
+		break;
+	}
+
+	return IRQ_HANDLED;
+}
+
 static int ltr390_probe(struct i2c_client *client)
 {
 	struct ltr390_data *data;
@@ -429,6 +629,22 @@ static int ltr390_probe(struct i2c_client *client)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to enable the sensor\n");
 
+	if (client->irq) {
+		int irq_flags = irq_get_trigger_type(client->irq);
+
+		if (!irq_flags)
+			irq_flags = IRQF_TRIGGER_FALLING;
+
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL, ltr390_interrupt_handler,
+						irq_flags | IRQF_ONESHOT,
+						"ltr390_thresh_event", indio_dev);
+		if (ret) {
+			dev_err(&client->dev, "request irq (%d) failed\n", client->irq);
+			return ret;
+		}
+	}
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 
-- 
2.43.0


