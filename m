Return-Path: <linux-iio+bounces-25605-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FA5C17118
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 22:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFC024F8BBC
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 21:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453DF2E1747;
	Tue, 28 Oct 2025 21:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXTA66fX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAD62E093A
	for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 21:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761687273; cv=none; b=nKVetQ+VOVezTaxZ7DPj7gr2JcAAX/lEHsMHXRVZrSqpqkOLGLsKa7GMzWubDx5S+r2571p39JWvFZfeZ2dU1VW9n+EIa4rXAP/IpYsUFIY4AMC+GhX2JFXKnuXdP+TQmR/LG1bWlorqW19yNPH1n/8hg3nr2gv9ZHIK1g2l4ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761687273; c=relaxed/simple;
	bh=QSmEAQZZBiFeRR5lNiNBsQe1Cx+DZuN0XZKdgN7ymow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jDcandoB0d43Km1fYUEma0zWexRX6TPtyfbuIQ/dXFF1wNiCvYVxF+jMvEtTOTJsP0DaaWvVYoY6SUT8qaaWMvMJRYeQ21Fbay/zeIRBjxywCblB51Wolk47V8uvcpcrQZ0OZp3Z7d4hIPZOmoHI5zk/D1f125NUsdvjU7bxXE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXTA66fX; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b6d83bf1077so337201666b.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 14:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761687269; x=1762292069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+9LqB/TvV6+QJ2tdqf0cjeFLNzbW3UfQsov2CRssck=;
        b=OXTA66fX4G/D/SsbomuVLez2y1H27l9qBzJj8CiBmCo47/jKOJKD3PhqkstTFJ95VL
         lGgut00C8YWe7HBjLv3xERuS1fK+V0fRfWBInkwVCPwIMHLpuR/RmymI/uzX3UKmJbHf
         ypKsXffkJ8iT2ICmMAol+6BlsCPatBQdG68q3vqB7SBgMvklX3Glx+6HwgCDwsRcl27S
         DxyHscSDHPsFokuBLQGyG2JhsyYJDNs4ytaljzaR0G3UB9iakl6F/PK4xOj5PUPCM1F7
         xnUrH5AGriNnPQCJbg+hYJ5skpH1nWhf4KwswBN8Ovpgz/mQIEpYb7eWQpVCZlc+MF/x
         rFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761687269; x=1762292069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+9LqB/TvV6+QJ2tdqf0cjeFLNzbW3UfQsov2CRssck=;
        b=MKeLtv0hSrQERaf2QVZ089qXAAlg0hzJw+ZSgYOj41wFiZan0mS5x2sH4hVGNT2rNh
         DIqUhVD2eVoyZP58OGOuh9UU0x/7Doqdvj39OpN0ZmXcpRVKCr00GLm+k2NdVo9o6eRu
         Jrzl1NfNh7l/hQ+skMfh7ZZ+ipE1aOMB4tN492cogkDxcMo8T6oeodU92MO9k6/z1rJI
         rSDITYL4l2foX+KfgA+tTrSn3s+3wGcj1nvc3vOAqAsRwFVRhYssIz8OzoQMo/pqoCGi
         MmjNtbzq+SKscUbZJ2oZgpPK7FK5f4dEyZfEdF7mPA8IJjc1t91W9y7U0EsDenCXU3xq
         QWRA==
X-Gm-Message-State: AOJu0YyHzPb7NbRyhqklE2o/EdAqg7KrVubVTD4FiASIdOHJ8YkIiZmI
	WZvH31OjD6PA6QLpFHvM5IgGPEmdenkQOvAkr/jFYIKmmX1xGQ82RN4M
X-Gm-Gg: ASbGncvU7Sa+sFQN/3QkRqCX/+M5s+q7qS9EOv8BMUFMOeQjI1vp/GHPm5XzcDZArVN
	8kHka/pTNc2mOqpprXpl9VOzsnSrz7hrAFQTso2fF3dejkMslHxJtqgboLyR6yzXale49VWwY3w
	3VeM/Pcpgn78DrNoVAjLXXIbySWZQdxH094JdNZuSCUngI4yy3eBTavE3v+bmGutoC9fGokgaQ2
	RKfx8JGbVaXgcLO0wlOsxNN9yPg/LyH0HMPpqiHZ41Svr5B/mYYWmZMN6NoCwR96zEZX1CPfY39
	p2hc2Z2GTSZ+JM4P5A98qfb2KMPVpygnUqb0cpaOz1K2X2fFdHStWo7uz75FwgULCWr2rMjmEPB
	PUAKKJMkTR3bjxs5rYuVmwPySJTZMTzJBHCvykQdGT5OCHVDzZgAGtYoiBJYYBI89b+qplbuijn
	/A02ai1B6esBr/jF4=
X-Google-Smtp-Source: AGHT+IFaHW7pIbjxqsxyh/vcoj8mo3fUVONexJBx1AJVyVDn36Wl92RVEg4w7HA/x5qkbM4dMfylfw==
X-Received: by 2002:a17:907:3d46:b0:b3b:5fe6:577a with SMTP id a640c23a62f3a-b703d2cd753mr49833866b.8.1761687269210;
        Tue, 28 Oct 2025 14:34:29 -0700 (PDT)
Received: from localhost.localdomain ([37.161.59.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6db9b86c80sm451303666b.43.2025.10.28.14.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 14:34:28 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH 2/2] iio: mpl3115: add threshold events support
Date: Tue, 28 Oct 2025 22:33:52 +0100
Message-Id: <20251028213351.77368-3-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251028213351.77368-1-apokusinski01@gmail.com>
References: <20251028213351.77368-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for pressure and temperature rising threshold events.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/iio/pressure/mpl3115.c | 219 +++++++++++++++++++++++++++++++--
 1 file changed, 210 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index 4cc103e20a39..bb252ff05ff5 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -16,8 +16,10 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/property.h>
+#include <linux/units.h>
 
 #include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/triggered_buffer.h>
@@ -30,6 +32,8 @@
 #define MPL3115_WHO_AM_I 0x0c
 #define MPL3115_INT_SOURCE 0x12
 #define MPL3115_PT_DATA_CFG 0x13
+#define MPL3115_PRESS_TGT 0x16 /* MSB first, 16 bit */
+#define MPL3115_TEMP_TGT 0x18
 #define MPL3115_CTRL_REG1 0x26
 #define MPL3115_CTRL_REG2 0x27
 #define MPL3115_CTRL_REG3 0x28
@@ -42,6 +46,8 @@
 #define MPL3115_STATUS_TEMP_RDY BIT(1)
 
 #define MPL3115_INT_SRC_DRDY BIT(7)
+#define MPL3115_INT_SRC_PTH BIT(3)
+#define MPL3115_INT_SRC_TTH BIT(2)
 
 #define MPL3115_PT_DATA_EVENT_ALL GENMASK(2, 0)
 
@@ -56,6 +62,8 @@
 #define MPL3115_CTRL3_IPOL2 BIT(1)
 
 #define MPL3115_CTRL4_INT_EN_DRDY BIT(7)
+#define MPL3115_CTRL4_INT_EN_PTH BIT(3)
+#define MPL3115_CTRL4_INT_EN_TTH BIT(2)
 
 #define MPL3115_CTRL5_INT_CFG_DRDY BIT(7)
 
@@ -307,6 +315,15 @@ static irqreturn_t mpl3115_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static const struct iio_event_spec mpl3115_temp_press_event[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
+				 BIT(IIO_EV_INFO_VALUE),
+	},
+};
+
 static const struct iio_chan_spec mpl3115_channels[] = {
 	{
 		.type = IIO_PRESSURE,
@@ -322,7 +339,9 @@ static const struct iio_chan_spec mpl3115_channels[] = {
 			.storagebits = 32,
 			.shift = 12,
 			.endianness = IIO_BE,
-		}
+		},
+		.event_spec = mpl3115_temp_press_event,
+		.num_event_specs = ARRAY_SIZE(mpl3115_temp_press_event),
 	},
 	{
 		.type = IIO_TEMP,
@@ -338,7 +357,9 @@ static const struct iio_chan_spec mpl3115_channels[] = {
 			.storagebits = 16,
 			.shift = 4,
 			.endianness = IIO_BE,
-		}
+		},
+		.event_spec = mpl3115_temp_press_event,
+		.num_event_specs = ARRAY_SIZE(mpl3115_temp_press_event),
 	},
 	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
@@ -348,15 +369,45 @@ static irqreturn_t mpl3115_interrupt_handler(int irq, void *private)
 	struct iio_dev *indio_dev = private;
 	struct mpl3115_data *data = iio_priv(indio_dev);
 	int ret;
+	__be32 val_press;
+	__be16 val_temp;
 
 	ret = i2c_smbus_read_byte_data(data->client, MPL3115_INT_SOURCE);
 	if (ret < 0)
 		return IRQ_HANDLED;
 
-	if (!(ret & MPL3115_INT_SRC_DRDY))
+	if (!(ret & (MPL3115_INT_SRC_DRDY | MPL3115_INT_SRC_PTH |
+		     MPL3115_INT_SRC_TTH)))
 		return IRQ_NONE;
 
-	iio_trigger_poll_nested(data->drdy_trig);
+	if (ret & MPL3115_INT_SRC_DRDY)
+		iio_trigger_poll_nested(data->drdy_trig);
+
+	if (ret & MPL3115_INT_SRC_PTH) {
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_PRESSURE, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
+						    iio_get_time_ns(indio_dev));
+
+		/* Reset the SRC_PTH bit in INT_SOURCE */
+		i2c_smbus_read_i2c_block_data(data->client,
+					      MPL3115_OUT_PRESS,
+					      3, (u8 *) &val_press);
+	}
+
+	if (ret & MPL3115_INT_SRC_TTH) {
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
+						    iio_get_time_ns(indio_dev));
+
+		/* Reset the SRC_TTH bit in INT_SOURCE */
+		i2c_smbus_read_i2c_block_data(data->client,
+					      MPL3115_OUT_TEMP,
+					      2, (u8 *) &val_temp);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -391,18 +442,22 @@ static int mpl3115_set_trigger_state(struct iio_trigger *trig, bool state)
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct mpl3115_data *data = iio_priv(indio_dev);
-	u8 ctrl_reg1 = data->ctrl_reg1;
-	u8 ctrl_reg4 = data->ctrl_reg4;
+	u8 ctrl_reg1, ctrl_reg4;
+
+	guard(mutex)(&data->lock);
+
+	ctrl_reg1 = data->ctrl_reg1;
+	ctrl_reg4 = data->ctrl_reg4;
 
 	if (state) {
 		ctrl_reg1 |= MPL3115_CTRL1_ACTIVE;
 		ctrl_reg4 |= MPL3115_CTRL4_INT_EN_DRDY;
 	} else {
-		ctrl_reg1 &= ~MPL3115_CTRL1_ACTIVE;
 		ctrl_reg4 &= ~MPL3115_CTRL4_INT_EN_DRDY;
-	}
 
-	guard(mutex)(&data->lock);
+		if (!ctrl_reg4)
+			ctrl_reg1 &= ~MPL3115_CTRL1_ACTIVE;
+	}
 
 	return mpl3115_config_interrupt(data, ctrl_reg1, ctrl_reg4);
 }
@@ -411,10 +466,156 @@ static const struct iio_trigger_ops mpl3115_trigger_ops = {
 	.set_trigger_state = mpl3115_set_trigger_state,
 };
 
+static int mpl3115_read_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
+{
+	struct mpl3115_data *data = iio_priv(indio_dev);
+	u8 int_en_mask;
+
+	switch (chan->type) {
+	case IIO_PRESSURE:
+		int_en_mask = MPL3115_CTRL4_INT_EN_PTH;
+		break;
+	case IIO_TEMP:
+		int_en_mask = MPL3115_CTRL4_INT_EN_TTH;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return !!(data->ctrl_reg4 & int_en_mask);
+}
+
+static int mpl3115_write_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir,
+				      bool state)
+{
+	struct mpl3115_data *data = iio_priv(indio_dev);
+	u8 int_en_mask;
+	u8 ctrl_reg1, ctrl_reg4;
+
+	switch (chan->type) {
+	case IIO_PRESSURE:
+		int_en_mask = MPL3115_CTRL4_INT_EN_PTH;
+		break;
+	case IIO_TEMP:
+		int_en_mask = MPL3115_CTRL4_INT_EN_TTH;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	guard(mutex)(&data->lock);
+
+	ctrl_reg1 = data->ctrl_reg1;
+	ctrl_reg4 = data->ctrl_reg4;
+
+	if (state) {
+		ctrl_reg1 |= MPL3115_CTRL1_ACTIVE;
+		ctrl_reg4 |= int_en_mask;
+	} else {
+		ctrl_reg4 &= ~int_en_mask;
+
+		if (!ctrl_reg4)
+			ctrl_reg1 &= ~MPL3115_CTRL1_ACTIVE;
+	}
+
+	return mpl3115_config_interrupt(data, ctrl_reg1, ctrl_reg4);
+}
+
+static int mpl3115_read_thresh(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan,
+			       enum iio_event_type type,
+			       enum iio_event_direction dir,
+			       enum iio_event_info info,
+			       int *val, int *val2)
+{
+	struct mpl3115_data *data = iio_priv(indio_dev);
+	int ret, press_pa;
+	__be16 tmp;
+
+	if (info != IIO_EV_INFO_VALUE)
+		return -EINVAL;
+
+	switch (chan->type) {
+	case IIO_PRESSURE:
+		ret = i2c_smbus_read_i2c_block_data(data->client,
+						    MPL3115_PRESS_TGT, 2,
+						    (u8 *) &tmp);
+		if (ret < 0)
+			return ret;
+
+		/**
+		 * Target value for the pressure is
+		 * 16-bit unsigned value in 2 Pa units
+		 */
+		press_pa = be16_to_cpu(tmp) << 1;
+		*val = press_pa / KILO;
+		*val2 = (press_pa % KILO) * MILLI;
+
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_TEMP:
+		ret = i2c_smbus_read_byte_data(data->client, MPL3115_TEMP_TGT);
+		if (ret < 0)
+			return ret;
+
+		/* Target value for the temperature is 8-bit 2's complement */
+		*val = sign_extend32(ret, 7);
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mpl3115_write_thresh(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				enum iio_event_info info,
+				int val, int val2)
+{
+	struct mpl3115_data *data = iio_priv(indio_dev);
+	u8 tmp[2];
+
+	if (info != IIO_EV_INFO_VALUE)
+		return -EINVAL;
+
+	switch (chan->type) {
+	case IIO_PRESSURE:
+		val = (val * KILO + val2 / MILLI) >> 1;
+
+		if (val < 0 || val > 0xffff)
+			return -EINVAL;
+
+		tmp[0] = FIELD_GET(GENMASK(15, 8), val);
+		tmp[1] = FIELD_GET(GENMASK(7, 0), val);
+
+		return i2c_smbus_write_i2c_block_data(data->client,
+						      MPL3115_PRESS_TGT, 2, tmp);
+	case IIO_TEMP:
+		if (val < -128 || val > 127)
+			return -EINVAL;
+
+		return i2c_smbus_write_byte_data(data->client,
+						 MPL3115_TEMP_TGT, val);
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct iio_info mpl3115_info = {
 	.read_raw = &mpl3115_read_raw,
 	.read_avail = &mpl3115_read_avail,
 	.write_raw = &mpl3115_write_raw,
+	.read_event_config = mpl3115_read_event_config,
+	.write_event_config = mpl3115_write_event_config,
+	.read_event_value = mpl3115_read_thresh,
+	.write_event_value = mpl3115_write_thresh,
 };
 
 static int mpl3115_trigger_probe(struct mpl3115_data *data,
-- 
2.25.1


