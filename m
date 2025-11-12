Return-Path: <linux-iio+bounces-26191-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C09C54C3C
	for <lists+linux-iio@lfdr.de>; Wed, 12 Nov 2025 23:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 330F14E2E98
	for <lists+linux-iio@lfdr.de>; Wed, 12 Nov 2025 22:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B612DEA71;
	Wed, 12 Nov 2025 22:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TajvwjRO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDEA2E7196
	for <linux-iio@vger.kernel.org>; Wed, 12 Nov 2025 22:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762988251; cv=none; b=LOd2JmrJ8tgTorFE9YoK2znGf3c132lssFPi6N/gV288iA+DvsbMNSRxrOfh3MJTayycYUW49jaCmV0DeOjJBKqD1pElwB9WdhKf9673xZJ/Iw9Yh1mHTN66cnpjfwXK/bcRh/VB8K8j1P9c0a7nvlNoOCe2zRyLJZrHdCrDhrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762988251; c=relaxed/simple;
	bh=4zZLBfpumbdh7ltXIJs2K7CAoYZvWqRXe44ZO+6Tuls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r82qN30UjgCE9dAKgt5huJFyPGJSw22nGlr6gz4uCm6re1bxdkFD2Xv+olSuFR9LBkJ66t1gPYwIsMQYesOKxv1I/0U7hVuMn1eYiKdBZd+WJxTVHie0OQsT+lRXAFns7OtSBuz+JrYu6JfXCb/bzpzqtIf9fPzuCTth1/e3SgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TajvwjRO; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-429c4c65485so162501f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 12 Nov 2025 14:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762988248; x=1763593048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/58+r0lPSGSY5PhfjE6noQfz+8v9ff7u2Qtdsu2R0Q=;
        b=TajvwjROe7ozABXoET9MLDQYtRNz8HD7y2kUgHNRjbDwtRMIPLy26eCqXsmUWru6OH
         ToFaae2XT6RW+oLXoY7/H4EJp0VXKX4wu2ezG2ZbOT1DJNBcqXDeqHfWNpzhw6MFbPbH
         5uYx1hFpqF6EKgpO4zmhHYeS5URmrnxJsJDscv4bZch6rE2qUogUZJRlD9OZvjk9D5Tg
         gVARKKgDqA+hq/OMkJ0Wng0zfMDpYkh/ncLIl3qCAbIkWQ5LY6gsxoTsk0uposamMlYc
         H9MqK+3nX9oGROSWf5fPh7HQoJR9S/6qcbGOI2qSoHvpB3F6wK4oMVen4NtMhvksQHii
         gTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762988248; x=1763593048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S/58+r0lPSGSY5PhfjE6noQfz+8v9ff7u2Qtdsu2R0Q=;
        b=CjFHex/Ddii3DUyXhmKrxMsm0Wjxo2B9J09g0e8vPhBcF3DpPCM4evA1IgARomlRXU
         Hkdw0OgQUciJw6dlbQrc88bjfQSiDZEf/IJCTarXhdLhNbBZvT4J6pII9JIYbe0EcYJw
         zrI8HDH2v1iL8w8HAUW2yyGfahniP5HcHl3hKYkWyysTDjXjCQn4uSSV0W3bTkIbj9Hg
         swYetMHBWJJUR/wAP0UQ1QH9OPC6oMQZ1z5ERknd9KvEU7V2yLN7MqQrcp8yC1rjMyLr
         ln0ru9ZTSZzQ+gBgMK8QPwwm4s+Kxd1e4rrWM9ZDtEq+PseZEYGwC6oR/eAXF8H+s2oM
         9sOg==
X-Gm-Message-State: AOJu0YzbI77v06TpKO1WPglACioy+hwwXxqkBHIlYW1FdNoiRxg24NKd
	F4oUCl/NW7M8tiGOO3PwQ2jiYMVEJ9wMYrQ1oqZH0rITrsKSd6I+0yL6
X-Gm-Gg: ASbGncuFrbmZDITj+ucL33st0JVNQiLKKp+mAWCXHX3LWxSQzj5t5e4IhHVZtwFIsHI
	J53MeRHUhkpEpbp5mn1ZlUtnfTWQIRSI8QBqrM7RygSW6WJGCi0pgWXFjuAJwOuY2JNz948itQW
	VSzc7XGGzFgiNfwKg1L3P+CdKGNIBzt0/qpbce6/A74+9JraeyJAr6efnsAmcUHvKcE5bwNtksA
	59XIww2IBnabzRFoy4tZUkhfLelSGy7vEI7f+vfiAEcg5y1q3n47qapGARam04M0Zct63zJ4kA+
	c1m+25HifirbzXSGaPqMs9Q8kXSTuV7FkkhWxQGIbSHHRxBWzrkv/oZ5Kss/nOw38LsW/KsQ3s7
	nLOEseiLVmxs7hEsGditqv88z5gHLLdQ+eRLqJHZNWPt1ih6OmDB0Wns6bnV/OiiAVk8viFpo
X-Google-Smtp-Source: AGHT+IE66AaMLPDlrLXqAT+Djqtrr+0CcNyoHxJfYKP8kdxhu3Z+xZlQeGLQSfiijknml32Mni2xmw==
X-Received: by 2002:a5d:588a:0:b0:42b:4177:7135 with SMTP id ffacd0b85a97d-42b4bdaa6e4mr4296673f8f.41.1762988247372;
        Wed, 12 Nov 2025 14:57:27 -0800 (PST)
Received: from localhost.localdomain ([78.209.131.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85cc0sm236979f8f.17.2025.11.12.14.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 14:57:26 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v4 2/3] iio: mpl3115: add threshold events support
Date: Wed, 12 Nov 2025 23:57:00 +0100
Message-Id: <20251112225701.32158-3-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251112225701.32158-1-apokusinski01@gmail.com>
References: <20251112225701.32158-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for pressure and temperature rising threshold events. For
both channels *_en and *_value (in raw units) attributes are exposed.

Since in write_event_config() the ctrl_reg1.active and ctrl_reg4
are modified, accessing the data->ctrl_reg{1,4} in set_trigger_state()
and write_event_config() needs to be now guarded by data->lock.
Otherwise, it would be possible that 2 concurrent threads executing
these functions would access the data->ctrl_reg{1,4} at the same time
and then one would overwrite the other's result.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/iio/pressure/mpl3115.c | 221 +++++++++++++++++++++++++++++++--
 1 file changed, 211 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index 5594256fffbd..aeac1586f12e 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -14,11 +14,13 @@
 #include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/unaligned.h>
 
 #include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/triggered_buffer.h>
@@ -31,6 +33,8 @@
 #define MPL3115_WHO_AM_I 0x0c
 #define MPL3115_INT_SOURCE 0x12
 #define MPL3115_PT_DATA_CFG 0x13
+#define MPL3115_PRESS_TGT 0x16 /* MSB first, 16 bit */
+#define MPL3115_TEMP_TGT 0x18
 #define MPL3115_CTRL_REG1 0x26
 #define MPL3115_CTRL_REG2 0x27
 #define MPL3115_CTRL_REG3 0x28
@@ -43,6 +47,8 @@
 #define MPL3115_STATUS_TEMP_RDY BIT(1)
 
 #define MPL3115_INT_SRC_DRDY BIT(7)
+#define MPL3115_INT_SRC_PTH BIT(3)
+#define MPL3115_INT_SRC_TTH BIT(2)
 
 #define MPL3115_PT_DATA_EVENT_ALL GENMASK(2, 0)
 
@@ -57,6 +63,8 @@
 #define MPL3115_CTRL3_IPOL2 BIT(1)
 
 #define MPL3115_CTRL4_INT_EN_DRDY BIT(7)
+#define MPL3115_CTRL4_INT_EN_PTH BIT(3)
+#define MPL3115_CTRL4_INT_EN_TTH BIT(2)
 
 #define MPL3115_CTRL5_INT_CFG_DRDY BIT(7)
 
@@ -84,6 +92,7 @@ struct mpl3115_data {
 	struct iio_trigger *drdy_trig;
 	struct mutex lock;
 	u8 ctrl_reg1;
+	u8 ctrl_reg4;
 };
 
 enum mpl3115_irq_pin {
@@ -313,6 +322,15 @@ static irqreturn_t mpl3115_trigger_handler(int irq, void *p)
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
@@ -328,7 +346,9 @@ static const struct iio_chan_spec mpl3115_channels[] = {
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
@@ -344,7 +364,9 @@ static const struct iio_chan_spec mpl3115_channels[] = {
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
@@ -354,15 +376,46 @@ static irqreturn_t mpl3115_interrupt_handler(int irq, void *private)
 	struct iio_dev *indio_dev = private;
 	struct mpl3115_data *data = iio_priv(indio_dev);
 	int ret;
+	u8 val_press[3];
+	__be16 val_temp;
 
 	ret = i2c_smbus_read_byte_data(data->client, MPL3115_INT_SOURCE);
 	if (ret < 0)
 		return IRQ_HANDLED;
 
-	if (!(ret & MPL3115_INT_SRC_DRDY))
+	if (!(ret & (MPL3115_INT_SRC_TTH | MPL3115_INT_SRC_PTH |
+		     MPL3115_INT_SRC_DRDY)))
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
+					      sizeof(val_press), val_press);
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
+					      sizeof(val_temp),
+					      (u8 *)&val_temp);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -383,6 +436,7 @@ static int mpl3115_config_interrupt(struct mpl3115_data *data,
 		goto reg1_cleanup;
 
 	data->ctrl_reg1 = ctrl_reg1;
+	data->ctrl_reg4 = ctrl_reg4;
 
 	return 0;
 
@@ -396,15 +450,22 @@ static int mpl3115_set_trigger_state(struct iio_trigger *trig, bool state)
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct mpl3115_data *data = iio_priv(indio_dev);
-	u8 ctrl_reg1 = data->ctrl_reg1;
-	u8 ctrl_reg4 = state ? MPL3115_CTRL4_INT_EN_DRDY : 0;
+	u8 ctrl_reg1, ctrl_reg4;
 
-	if (state)
+	guard(mutex)(&data->lock);
+
+	ctrl_reg1 = data->ctrl_reg1;
+	ctrl_reg4 = data->ctrl_reg4;
+
+	if (state) {
 		ctrl_reg1 |= MPL3115_CTRL1_ACTIVE;
-	else
-		ctrl_reg1 &= ~MPL3115_CTRL1_ACTIVE;
+		ctrl_reg4 |= MPL3115_CTRL4_INT_EN_DRDY;
+	} else {
+		ctrl_reg4 &= ~MPL3115_CTRL4_INT_EN_DRDY;
 
-	guard(mutex)(&data->lock);
+		if (!ctrl_reg4)
+			ctrl_reg1 &= ~MPL3115_CTRL1_ACTIVE;
+	}
 
 	return mpl3115_config_interrupt(data, ctrl_reg1, ctrl_reg4);
 }
@@ -413,10 +474,150 @@ static const struct iio_trigger_ops mpl3115_trigger_ops = {
 	.set_trigger_state = mpl3115_set_trigger_state,
 };
 
+static int mpl3115_read_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
+{
+	struct mpl3115_data *data = iio_priv(indio_dev);
+
+	if (chan->type == IIO_PRESSURE)
+		return !!(data->ctrl_reg4 & MPL3115_CTRL4_INT_EN_PTH);
+
+	if (chan->type == IIO_TEMP)
+		return !!(data->ctrl_reg4 & MPL3115_CTRL4_INT_EN_TTH);
+
+	return -EINVAL;
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
+	int ret;
+	__be16 press_tgt;
+
+	if (info != IIO_EV_INFO_VALUE)
+		return -EINVAL;
+
+	switch (chan->type) {
+	case IIO_PRESSURE:
+		ret = i2c_smbus_read_i2c_block_data(data->client,
+						    MPL3115_PRESS_TGT,
+						    sizeof(press_tgt),
+						    (u8 *)&press_tgt);
+		if (ret < 0)
+			return ret;
+
+		/*
+		 * Target value for the pressure is 16-bit unsigned value,
+		 * expressed in 2 Pa units
+		 */
+		*val = be16_to_cpu(press_tgt) << 1;
+
+		return IIO_VAL_INT;
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
+	__be16 press_tgt;
+
+	if (info != IIO_EV_INFO_VALUE)
+		return -EINVAL;
+
+	switch (chan->type) {
+	case IIO_PRESSURE:
+		val >>= 1;
+
+		if (val < 0 || val > U16_MAX)
+			return -EINVAL;
+
+		press_tgt = cpu_to_be16(val);
+
+		return i2c_smbus_write_i2c_block_data(data->client,
+						      MPL3115_PRESS_TGT,
+						      sizeof(press_tgt),
+						      (u8 *)&press_tgt);
+	case IIO_TEMP:
+		if (val < S8_MIN || val > S8_MAX)
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


