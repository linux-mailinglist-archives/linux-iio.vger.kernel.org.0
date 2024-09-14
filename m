Return-Path: <linux-iio+bounces-9592-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B0C9792E5
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 20:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EED7C1C213A7
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 18:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8021D2F5B;
	Sat, 14 Sep 2024 18:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLDyxYcP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B411D278F;
	Sat, 14 Sep 2024 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726337625; cv=none; b=Pu7C6QLTrjwdjx15TLFm96MqrhnIFO6YYGVDZhOdM3QtNRWbg2xzdBpe5KWchZKoB2MbnkrIx+EjG98x2jljKhaRnBLfb+QJWJhTdxp5ujTIMoIyhYai6csZlYCHQjkIEmb7fvyk9UVeSA+hEPMPuBVmD1amD8z9N/H8cuV3YPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726337625; c=relaxed/simple;
	bh=/zrDPSUSW+KCgQasuMdEtHhQ2cHGxxYjaaXishYNjVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEe5K7Yi3F5uwHcFfaLBGntWxG5gd1EqGqylN5Gp+Pq8GQLGKI0veGIxJZz0/tKfwbwMadQWaGtWLNudM7Wmw0XVqyOX2g2GQFPZCLn9RomeQddhL234Aomugyg3zr9vAruIOwIlRddtV88AWauCFCz1zYoJnrQPDhzqO+KrjDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLDyxYcP; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-206bd1c6ccdso17819795ad.3;
        Sat, 14 Sep 2024 11:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726337622; x=1726942422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgOgFn1PixKBms2a98A4BTpMQlTcE2wOvdP5Mou9Jro=;
        b=mLDyxYcP9shg1uu6VApUUn9dB/N8JuXIsTgq9un3K82GEm+tjLxDV78CWl/7hHpUcL
         yvgdoF98LQ0kFt3tYZT0R8VUNGV156yrqs9cPml+g4eRyLcYNwZJxmbvzU6DlOXczl2z
         ydnXvHZUa0/f2jLG3gkSOZ0T/S7FZm4PH454jk95liQG4NwH2lHHcuGwl3TOh55Eh6Qg
         ukQEa+2vSVxXdozmA1ZoQSascDyjgcQPrvSEaGc0AU5leLUi0vZG9Ev3SrqAH73uG3ki
         p/4Lo89xgaRhIezJdCrmoRkdzS6qdcCD6LU8B00K5PwLONY0LPPZF1b5DWstBL03XEsY
         FlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726337623; x=1726942423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JgOgFn1PixKBms2a98A4BTpMQlTcE2wOvdP5Mou9Jro=;
        b=s28tbPnziTOhmKFcOVMQ6HE4+vD6VCWqKdwf9MiCu8m/txuKsXw5UG8xOCxkeMcOMD
         u5SjMw2U8UisdoS/BIGN+fs5BamqIcFnXJQLw2KL0Axpu7v++OWRYvwu26Q0Wm8Hzgla
         kWs0i+bHM6ik6sMhOCqYOm9LlYu3HxtkiBFtyoZpLPk4K4WW7TYi8Eo5ActWcIxXWBgr
         pAAVCb/gXwtQ3TLl+3mrWxWoNqi3K3QFM7s1mOCosSHEpnPefk20eJ2ypdVq9yzFvzwl
         OHympxs1NW1lLsyBgndxiJZ59qC+SjVf3gbvChz+xxvAKaL/Kar64BkxfX2A/H6XOfuH
         tD8g==
X-Forwarded-Encrypted: i=1; AJvYcCXTrWjoWj7p/65pP0vhVa9hCeYRuOyrij2iL65pDT/EPkoWyFYKGiPI3wlsxALPch7lSWTM8LTCTqtbric=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNcTxz557FiDyMqA/xtg+5ZBSygh+Bs9MVcUv6daXFY58yd3yS
	FIdELJ+AgigtdI+smS9Q58WRte+qmeMhYu1LQQhQbBPCK59F5V33sWZTAHzmetU=
X-Google-Smtp-Source: AGHT+IFv2pj+4hgeJM5D9yizxIZ3hpbcpCIWgKB3qpXsjyn8RAVikmg0iASj79WXpE+dxzWK/0/J8w==
X-Received: by 2002:a17:90b:3758:b0:2da:88b3:d001 with SMTP id 98e67ed59e1d1-2dbb9e1d271mr8534753a91.18.1726337622410;
        Sat, 14 Sep 2024 11:13:42 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2dbcfd26f2csm1830870a91.31.2024.09.14.11.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 11:13:41 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v3 3/4] iio: light: ltr390: Interrupts and threshold event support
Date: Sat, 14 Sep 2024 23:42:45 +0530
Message-ID: <20240914181246.504450-4-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240914181246.504450-1-abhashkumarjha123@gmail.com>
References: <20240914181246.504450-1-abhashkumarjha123@gmail.com>
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
 drivers/iio/light/ltr390.c | 212 +++++++++++++++++++++++++++++++++++++
 1 file changed, 212 insertions(+)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index e152009b5..57bf48595 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -25,8 +25,11 @@
 #include <linux/regmap.h>
 #include <linux/bitfield.h>
 #include <linux/device.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/events.h>
 
 #include <asm/unaligned.h>
 
@@ -34,9 +37,12 @@
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
@@ -47,6 +53,8 @@
 #define LTR390_SW_RESET	      BIT(4)
 #define LTR390_UVS_MODE	      BIT(3)
 #define LTR390_SENSOR_ENABLE  BIT(1)
+#define LTR390_LS_INT_EN      BIT(2)
+#define LTR390_LS_INT_SEL_UVS BIT(5)
 
 #define LTR390_FRACTIONAL_PRECISION 100
 
@@ -231,6 +239,22 @@ static const int ltr390_int_time_map_us[] = { 400000, 200000, 100000, 50000, 250
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
@@ -241,6 +265,8 @@ static const struct iio_chan_spec ltr390_channels[] = {
 		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
 							BIT(IIO_CHAN_INFO_SCALE) |
 							BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.event_spec = ltr390_event_spec,
+		.num_event_specs = ARRAY_SIZE(ltr390_event_spec),
 	},
 	/* ALS sensor */
 	{
@@ -251,6 +277,8 @@ static const struct iio_chan_spec ltr390_channels[] = {
 		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
 							BIT(IIO_CHAN_INFO_SCALE) |
 							BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.event_spec = ltr390_event_spec,
+		.num_event_specs = ARRAY_SIZE(ltr390_event_spec),
 	},
 };
 
@@ -369,12 +397,183 @@ static int ltr390_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec cons
 	}
 }
 
+static int ltr390_read_threshold(struct iio_dev *indio_dev,
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
+
+	guard(mutex)(&data->lock);
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		return regmap_bulk_write(data->regmap, LTR390_THRESH_UP, &val, 3);
+
+	case IIO_EV_DIR_FALLING:
+		return regmap_bulk_write(data->regmap, LTR390_THRESH_LOW, &val, 3);
+
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
+
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
+
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
+	return FIELD_GET(LTR390_LS_INT_EN, status);
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
+				IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
+				IIO_EV_TYPE_THRESH,
+				IIO_EV_DIR_EITHER),
+				iio_get_time_ns(indio_dev));
+		break;
+
+	case LTR390_SET_UVS_MODE:
+		iio_push_event(indio_dev,
+				IIO_UNMOD_EVENT_CODE(IIO_UVINDEX, 0,
+				IIO_EV_TYPE_THRESH,
+				IIO_EV_DIR_EITHER),
+				iio_get_time_ns(indio_dev));
+		break;
+	}
+
+	return IRQ_HANDLED;
+}
+
 static int ltr390_probe(struct i2c_client *client)
 {
 	struct ltr390_data *data;
@@ -428,6 +627,19 @@ static int ltr390_probe(struct i2c_client *client)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to enable the sensor\n");
 
+	if (client->irq) {
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL, ltr390_interrupt_handler,
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT,
+						"ltr390_thresh_event",
+						indio_dev);
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


