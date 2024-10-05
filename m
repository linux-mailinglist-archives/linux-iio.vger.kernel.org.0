Return-Path: <linux-iio+bounces-10175-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC469917FC
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 17:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C38A1F22EEA
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 15:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8369A1586F2;
	Sat,  5 Oct 2024 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NB+LmiuG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76D615854F;
	Sat,  5 Oct 2024 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728143590; cv=none; b=UZWz0VUj+CRfa97lDTJv7s5ktco3d/aYy6CpIG9WRuLunsQlrubwKrNIMBteyKgDDXjVa/KsUBwIX+eb4Wcwr+EOaUDMwXeFFFkeltoVKITIVdWYIHs/1vodqBZbb5ezi6bBLkZnhkO4mvGL+HwfY5E/U40VF7g6bNTxVFIJlVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728143590; c=relaxed/simple;
	bh=Fit/7+70VUBcPnUV9WaI7RcQB219ex1h4vG8en2Yru0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJPa5aP6fN1mZcv87MkoQDWixcyaqeHe8W5j0Cp5Q4gJSxwuIkXfhgo+IYZYdzdEEvnKVx+T0o0U+xt+7b+MeX3B24mtkOjqL0kC5e7Q2QClJMomP0gu7R7cMN/Sch/nPXEcqa+n80s5y6RcGHUBQew8gThm4AXEexsr6mfh4F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NB+LmiuG; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e078d28fe9so2201971a91.2;
        Sat, 05 Oct 2024 08:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728143587; x=1728748387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TE9IGHKdaTgYIuAo7IgiEznxfsxfMWkmrqG2JFBMfBo=;
        b=NB+LmiuG3F82GZnb8Tzc04O/ZP5J1kmAztaX3HLqpeb0h0BGHLQZAU0rOno8r3I9cK
         TNzJVbIFnhNvhF3+A4fl1ZuQQpbtpBUoPbubtFL81AIQSzwonmOzL7yw+dhdpeJlNfHj
         15obzZ5TGdHHx+TE+EXGAn1/KWiDQ6zq7jlkgtYFMhaT4kO3NNTc6z5qV6a07xKtONxb
         X9KUGfovIHQ1h6XOD8OzHqALvcTZzNPyhlBWX5zB4VdTUKC3TtN4E0zbIEkmgFmXe36S
         zxg65DcN9Mj37zEnSXMKNFcfN+Ue4hLDDuOhuWSn6ljIv6uzxc6mvhwBglxgTvuD9xYf
         EU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728143587; x=1728748387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TE9IGHKdaTgYIuAo7IgiEznxfsxfMWkmrqG2JFBMfBo=;
        b=pYG6sjeYW+UaGaMUaDokSHgzyqSdVJHmHezz4cwfppiGvsx2ZQ68bYnujBxudlKT0v
         1SgYT2X0/GFstpp7vqTgcodGCq2GOI89c1LpQk2Z9ATf93QjR0BaFBCdedXLyjLIVEAN
         1tUPdmrjUUePf/ZEkK5yz6c1cfxozCxQoh1I1hNwoW6t6X2NEM7vIh4DGKaEKL4iF0N7
         ew3booNNhg1xCZcFFKBfxLwHW6JX1t9pwklhXQLmIZ1H0ZWTfWm9mUVMpe2iwUMGH+1Z
         PJj3JX67CiAWlbzAWpoSheQcAGKPchRHVNYVOw/6llizk61M0G0btxOgARfSjyS/I9tL
         7Z5A==
X-Forwarded-Encrypted: i=1; AJvYcCX/h9Skn2Rmp0orHQ307OzZxtWWIpSMqwieI7MkMin/aen2rpJFhtYcjXbKDT1VZJPlOJO4EQ7s0UiRh2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfnObF45TGMX10Hgd4or6bfDv7kP0+lDNvCcjWbSJkB/E6T2B+
	Tb2K8bS/az315ij67eijbVtdyFzHw82osZ5/mrW3jLoCLsXJbR7iuzrK3337qUk=
X-Google-Smtp-Source: AGHT+IGAKi0OtMMtNkrRd7Q7988lPCmzLMrqb3e2UAyznKK5l57XDJ83GpLhVet/SipoVFuZq7iOmg==
X-Received: by 2002:a17:90b:151:b0:2d3:c892:9607 with SMTP id 98e67ed59e1d1-2e1e621e995mr7497453a91.12.1728143586944;
        Sat, 05 Oct 2024 08:53:06 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e20aebc40csm2008370a91.23.2024.10.05.08.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 08:53:06 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v2 3/3] iio: light: vl6180: Add support for Continuous Mode
Date: Sat,  5 Oct 2024 21:22:25 +0530
Message-ID: <20241005155225.9239-4-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005155225.9239-1-abhashkumarjha123@gmail.com>
References: <20241005155225.9239-1-abhashkumarjha123@gmail.com>
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
index 7630a7503..74be3e6dc 100644
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
@@ -496,17 +525,99 @@ static irqreturn_t vl6180_threaded_irq(int irq, void *priv)
 	struct iio_dev *indio_dev = priv;
 	struct vl6180_data *data = iio_priv(indio_dev);
 
-	complete(&data->completion);
+	if (iio_buffer_enabled(indio_dev))
+		iio_trigger_poll_nested(indio_dev->trig);
+	else
+		complete(&data->completion);
+
 	return IRQ_HANDLED;
 }
 
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
+	return IRQ_HANDLED;
+}
+
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
@@ -546,6 +657,12 @@ static int vl6180_init(struct vl6180_data *data)
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
@@ -602,7 +719,7 @@ static int vl6180_probe(struct i2c_client *client)
 	indio_dev->name = VL6180_DRV_NAME;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = vl6180_init(data);
+	ret = vl6180_init(data, indio_dev);
 	if (ret < 0)
 		return ret;
 
@@ -617,6 +734,19 @@ static int vl6180_probe(struct i2c_client *client)
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


