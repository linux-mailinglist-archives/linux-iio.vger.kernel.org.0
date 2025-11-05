Return-Path: <linux-iio+bounces-25906-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4AEC34FC4
	for <lists+linux-iio@lfdr.de>; Wed, 05 Nov 2025 10:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DFD453441C3
	for <lists+linux-iio@lfdr.de>; Wed,  5 Nov 2025 09:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B8130BB8E;
	Wed,  5 Nov 2025 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXxp89eM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B837330C350
	for <linux-iio@vger.kernel.org>; Wed,  5 Nov 2025 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336610; cv=none; b=NfdrA7v5Ae9dJ+EPJCe6Ic7Va/sZZdT1HUyuWd8YNAtHuXq9FtlfpUHi81yrBIAvpHOyLP0VAI7kW24a79uiJYqrv/wyuUZOvR+w8HshPcoAZwKnQnItPgpnyysYd8hqc/ZE6OJI1Q5pmpikoaClpu+gYw2zti1UbvBgrx5z1tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336610; c=relaxed/simple;
	bh=KKznF8+PApZcEWd9iTzewV5G7EssaoQjqQ6hmanjAHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iMGw0wm5Z9Ym7G/5t/t0QQuwWerkx/+uVMWe44vsukaVNWHfO5vaX46HxwULBDV+NBwbI317FSerl+fNh62QinhUBC67mGHecq0Io3nUMwAAjDcok6znNJz6hwvKKUmE+3argtkCiyzmpUVqtzSih1INv4hV47gRH9yL2A8t9Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXxp89eM; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640f4b6836bso2317285a12.3
        for <linux-iio@vger.kernel.org>; Wed, 05 Nov 2025 01:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762336607; x=1762941407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zS3atC4aNLHHxOcqnZGtrBGqDXMbtPyhX2iAFhjNqj4=;
        b=dXxp89eMYmWFlt0xWn27KVDFukqDOJtnqeat+Y6kN79tI50XkyYVeCTAIdwfYnl84Y
         7YTVThgj70crTyiY/ZqejvjCBqNQxoZaOLQe96Zuas8lKk8/ai/nOuBQgKFQ6WqX2y4F
         INkW/UlK9UesK7beP6rE4wUxO+/X351mx4NQKf43CntN8Snq6jveQhNn4wZwYlEhlyub
         lYZ2A/NrgPgCOgpIA5pIKfqPEKYcx9MoGncuV1+LNMjsSIY4rCb6J2TuUc+uLabVK4oS
         GdBW5ZHhIYTZquWO6LubvWcVeT9awItKKICQj8X5HmggNj9rrh7nOtomQkmCvXFDQkSw
         kwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762336607; x=1762941407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zS3atC4aNLHHxOcqnZGtrBGqDXMbtPyhX2iAFhjNqj4=;
        b=rtFkpAXyCuYVKFMDZrsW0QHlNkgLXOYYo+pMbF/Gcpry8OWHBc5clareEQPKeHl3rO
         D+d/KrbgEIY6M9icX1uufXaecoqibk2wIou+c7cFfXpZgxkFAIBJh12YG1fEACZHv9Nr
         E8nt5P251CC+/wB0Q0u2V3jD0cq6qCHIJ3cVxy5hrsrTF1xq+/s7bQl9EuMsc+Wke0zl
         /Lq3qHoF7blmic9ZAO9OBCxy9ADtPWqk4YDHZC85kA83fch+xLBQlCt/sgQskNxp7+1E
         k0a2C1ymLz/Z2Myzz+0BDAH/nzmudChrKZsczSLNQU2zfmdtmgdhjQdXyLp67nvGEyrs
         EYew==
X-Gm-Message-State: AOJu0Yx+xTe1EQBwMq9pZMLUQdbnpZE8+JuOYzZzVCWPKU+Kn1wWMcm+
	cc4+oib1jX3nCr5QmZxAi/eFsKwZqNK/3E7issWj72ffQ88tbwUSJ6mr
X-Gm-Gg: ASbGncs2w31mQcnlik9QTFeUpRrS2tZMTA4GfZ5r2m1cbZ0catGbo+fAdXr+UFMoY5e
	+cvqYC6hqAlq9spJM4bgO8nOBjSP5kEFq8W78IdaAG+RE2ehX8oRb/X9y/CKxBT0evOTNe/f9hh
	Xw2PE0Exbq2JVGn3cwFUvmNZtHuQ1JLTurNDgYIv5jnp/L+44450rwTljdyf9Jia/FN7nPuiAHw
	FVp0U9HSzTvze4E4fc1uEDkVxnrYbAIBXYEwk97k+Fk2uEwgBPsi26VEcXl+Zn5rkUkWqRvMQS5
	qQNwEplONpcyCxX2CXRLgCH4Mk2XNM4W0aBUCcyOe4l7lyN4tahOE0KvualulxOjdnJGlOG/dFC
	Tz6+dtDHLkgtcJflSDoUdjimIsMnH6HzCLgKHUAQ4PTvTelivRRFy0M+DgK5Uz1v3KO+ghaC2Vu
	P9QvaozwKQqFQtaeNq
X-Google-Smtp-Source: AGHT+IF/ksgOnk3dCwpQUTb2Cd6c8bERS3mEHT2FJx4K+KRxYQJp7dERhUxUPzkHzeAHHH96+oez8w==
X-Received: by 2002:a17:907:970a:b0:b6d:7231:3276 with SMTP id a640c23a62f3a-b72652a2368mr216155466b.19.1762336606779;
        Wed, 05 Nov 2025 01:56:46 -0800 (PST)
Received: from localhost.localdomain ([78.211.196.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fe37b7asm440266866b.60.2025.11.05.01.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 01:56:46 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v3 2/3] iio: mpl3115: add threshold events support
Date: Wed,  5 Nov 2025 10:56:14 +0100
Message-Id: <20251105095615.4310-3-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251105095615.4310-1-apokusinski01@gmail.com>
References: <20251105095615.4310-1-apokusinski01@gmail.com>
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
 drivers/iio/pressure/mpl3115.c | 218 +++++++++++++++++++++++++++++++--
 1 file changed, 208 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index 3f1fa9fe3c76..d56f5fcd5900 100644
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
@@ -307,6 +316,15 @@ static irqreturn_t mpl3115_trigger_handler(int irq, void *p)
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
@@ -322,7 +340,9 @@ static const struct iio_chan_spec mpl3115_channels[] = {
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
@@ -338,7 +358,9 @@ static const struct iio_chan_spec mpl3115_channels[] = {
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
@@ -348,15 +370,45 @@ static irqreturn_t mpl3115_interrupt_handler(int irq, void *private)
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
+					      2, (u8 *)&val_temp);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -377,6 +429,7 @@ static int mpl3115_config_interrupt(struct mpl3115_data *data,
 		goto reg1_cleanup;
 
 	data->ctrl_reg1 = ctrl_reg1;
+	data->ctrl_reg4 = ctrl_reg4;
 
 	return 0;
 
@@ -390,15 +443,22 @@ static int mpl3115_set_trigger_state(struct iio_trigger *trig, bool state)
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
@@ -407,10 +467,148 @@ static const struct iio_trigger_ops mpl3115_trigger_ops = {
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
+	__be16 tmp;
+
+	if (info != IIO_EV_INFO_VALUE)
+		return -EINVAL;
+
+	switch (chan->type) {
+	case IIO_PRESSURE:
+		ret = i2c_smbus_read_i2c_block_data(data->client,
+						    MPL3115_PRESS_TGT,
+						    sizeof(tmp), (u8 *)&tmp);
+		if (ret < 0)
+			return ret;
+
+		/*
+		 * Target value for the pressure is 16-bit unsigned value,
+		 * expressed in 2 Pa units
+		 */
+		*val = be16_to_cpu(tmp) << 1;
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
+	__be16 tmp;
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
+		tmp = cpu_to_be16(val);
+
+		return i2c_smbus_write_i2c_block_data(data->client,
+						      MPL3115_PRESS_TGT,
+						      sizeof(tmp), (u8 *)&tmp);
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


