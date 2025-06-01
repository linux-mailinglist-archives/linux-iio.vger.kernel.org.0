Return-Path: <linux-iio+bounces-20104-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6F1AC9F97
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 19:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468C0189530C
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 17:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E40C20B80E;
	Sun,  1 Jun 2025 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPsQ+GGw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C2C2045B5;
	Sun,  1 Jun 2025 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748798522; cv=none; b=d5UEImEqERPfAJs4d9ImZgK5g3K2AhfFJ4JqcCvnm7CPN7HGzP0OAbE6cntkksVo4acdprXFp5FFkVO2KuNIyx5qyjeTB/hN2Jm163X2JLHTVxiI2s/cYdUow0Fju2pWjXlP/Ltr01PA/WDfe7g5NTjBOXOo/3qJjCVmbFusdnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748798522; c=relaxed/simple;
	bh=m1BHSldAKTqhZJptWjKeNYnu/UTDyDC/BrQFWOSoVeA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R8jM5T5vmceIhOhHgH/QAwo/GqoM1a891L2YPGeUPKapFyxi9B45KNf9zHof0f70zL/AvtbRlsEfKXLqWB3/Ly38ZzyjLZEgP2UuJ3cKWq9j68ZlYs3o5JRUbnqbG4KdJqfzbrsqgaCr7iPtth6teWVOG3miY7nseWwZtAwkadc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPsQ+GGw; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450d61cc409so700175e9.3;
        Sun, 01 Jun 2025 10:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748798519; x=1749403319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JeCK9Gn5gUH10CfxoaZ02nPV2QTvNKzqD5cWKUlNDuY=;
        b=YPsQ+GGwa7dT0JLvcsFlI7ClwDGfrzxpGGSf0t5vDb0v0c2HkcZ0y3lsrvLYszBaPp
         hx/tr0/SHjn4gjidIa72yqVDL/LLnoK8vXSKNIJbIUazNgrl2/+WJx4Yx4odCyOalb8I
         R+iiuudxtq9aZ3WeYDGm2Cix/AT4IHv0Pd0cFwOPE/p8eBUF0THKCVhk/xU44i6ub5Jo
         OH78qxVi0Emw8HgulczC/29jnAQTvqcUkFVr/+dY6niinatAEFaEObYJdmV2sGlf2Wo9
         T2m6spLpEHzB06oMWEnoQ0Dp+CRcKlnxmQYy6KIMLlZ7ki3desflqZdPfLRyqXU26L0c
         nTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748798519; x=1749403319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JeCK9Gn5gUH10CfxoaZ02nPV2QTvNKzqD5cWKUlNDuY=;
        b=WqwBB+Bdb4kw1/tPeoeJy31d59M7Ph+yBJAHyFnRnAqZjX1oQJKbceW8v2LB04BpOD
         QB8ho5AaX2/QSvYIOrj1v37WlXAft4uNSZHvzsfH19AWxiXdmm4KKC0K2McBAUVPZ0Dk
         CDobqEWbpBwDGQ1AHYXTdOv6Jz/N/XfmMrnD6N+UAInUyEoBwYURbAjtUsjPvOVESYz0
         VIsEV87WIfa0Vk92R3Cnb7ePKZw+xpa70eoAj7Y+nq88NVP7g2YwVOnprIvAO06m7IEY
         IwEGhGlms0uGL197JEixuk0yX9e6rn6Ws8nbjJBkvWwJqEQ/ZOjzgtukq/DR8CghLGWV
         lkNA==
X-Forwarded-Encrypted: i=1; AJvYcCV52EZy/J59QObORpf3QmXg/PlieGAhvphoXbGWkTVE8LTiYXLj2lzcMirKL8MXXoRwDdk5QbH2q+On4Tv0@vger.kernel.org, AJvYcCX2QPZBYOePhRYR3S5FjGAAcFrRDeykc0YatBDx9R2PBeORslBXleasYm0kSjjaV592asgB8r3YerU=@vger.kernel.org, AJvYcCXbdywi7s0c4kXzDyFqxiw68yN+vODXBjmBMGAHYrUy2qzjgpYGnO83Say6XVY7JGS8wl+tkOEWAry7@vger.kernel.org
X-Gm-Message-State: AOJu0YwM6p2qh5TzN+9yQtrxmbGelc1Nt0N1G81NnAAfEfG7y5bSUSBx
	nlEgOGWTljMyxE6XyX1Ch51b9aO9WHLHTeOq4VTv8MgIbr7oPwFYMIWy
X-Gm-Gg: ASbGncuBp+dJgalNxt3yctTwFIiYRP8zVxkGPeSUW3LVjxMwtJc63Mlxnw5pPea7Gl4
	Wjzv56IL8kK58nJ0hHhMjfeBEMGiQsacpLUXQCQl61f76o+0QP+UfzDCECoqC6wwUHpCUD2I30D
	g0E612J82jQ4Aj+vG5bPWYqkfc+wHrwxwPbypVaO4seQnVbLQ06zLwF4GuWp0kQcpYmqRY21kuS
	qwx9nRNxqbzYtzV3HFODMsPWDqV0QmsTlc/dVAjoGvWYaXhiKwyGFutbFrIKLIhyDbfQ2+AqdH+
	ovkF1WhImND1q8DsfV/XGxfOMHItkR3u9jq8ik0t40HFzVnzX4p5rzjCMsIlZA9gjaTY1yf6Nz5
	lodVpR3MrqMcfjjDf7zpa4Q==
X-Google-Smtp-Source: AGHT+IFwJsWa12fhq9dormBrLU7PF5s3HWdnBAIgd9HfIfTft6VKTL2K3wqsrF2m0k6Yj5yj/UcV8Q==
X-Received: by 2002:a05:600c:3595:b0:439:8294:2115 with SMTP id 5b1f17b1804b1-450d7bd5e14mr29797985e9.8.1748798518813;
        Sun, 01 Jun 2025 10:21:58 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f009f9d6sm11890444f8f.84.2025.06.01.10.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 10:21:58 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	bagasdotme@gmail.com
Cc: l.rubusch@gmail.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/11] iio: accel: adxl313: add activity sensing
Date: Sun,  1 Jun 2025 17:21:35 +0000
Message-Id: <20250601172139.59156-8-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601172139.59156-1-l.rubusch@gmail.com>
References: <20250601172139.59156-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add possibilities to set a threshold for activity sensing. Extend the
interrupt handler to process activity interrupts. Provide functions to set
the activity threshold and to enable/disable activity sensing. Further add
a fake channel for having x, y and z axis anded on the iio channel.

This is a preparatory patch. Some of the definitions and functions are
supposed to be extended for inactivity later on.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313_core.c | 237 ++++++++++++++++++++++++++++++-
 1 file changed, 235 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 8a0b5542fb40..e647c40575ab 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -13,8 +13,10 @@
 #include <linux/overflow.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/units.h>
 
 #include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
 #include <linux/iio/kfifo_buf.h>
 
 #include "adxl313.h"
@@ -25,6 +27,21 @@
 
 #define ADXL313_REG_XYZ_BASE			ADXL313_REG_DATA_AXIS(0)
 
+#define ADXL313_ACT_XYZ_EN			GENMASK(6, 4)
+
+/* activity/inactivity */
+enum adxl313_activity_type {
+	ADXL313_ACTIVITY,
+};
+
+static const unsigned int adxl313_act_int_reg[] = {
+	[ADXL313_ACTIVITY] = ADXL313_INT_ACTIVITY,
+};
+
+static const unsigned int adxl313_act_thresh_reg[] = {
+	[ADXL313_ACTIVITY] = ADXL313_REG_THRESH_ACT,
+};
+
 static const struct regmap_range adxl312_readable_reg_range[] = {
 	regmap_reg_range(ADXL313_REG_DEVID0, ADXL313_REG_DEVID0),
 	regmap_reg_range(ADXL313_REG_OFS_AXIS(0), ADXL313_REG_OFS_AXIS(2)),
@@ -227,6 +244,15 @@ static const int adxl313_odr_freqs[][2] = {
 	},								\
 }
 
+static const struct iio_event_spec adxl313_activity_events[] = {
+	{
+		.type = IIO_EV_TYPE_MAG,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
+	},
+};
+
 enum adxl313_chans {
 	chan_x, chan_y, chan_z,
 };
@@ -235,6 +261,14 @@ static const struct iio_chan_spec adxl313_channels[] = {
 	ADXL313_ACCEL_CHANNEL(0, chan_x, X),
 	ADXL313_ACCEL_CHANNEL(1, chan_y, Y),
 	ADXL313_ACCEL_CHANNEL(2, chan_z, Z),
+	{
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_X_OR_Y_OR_Z,
+		.scan_index = -1, /* Fake channel for axis OR'ing */
+		.event_spec = adxl313_activity_events,
+		.num_event_specs = ARRAY_SIZE(adxl313_activity_events),
+	},
 };
 
 static const unsigned long adxl313_scan_masks[] = {
@@ -297,6 +331,68 @@ static int adxl313_read_freq_avail(struct iio_dev *indio_dev,
 	}
 }
 
+static int adxl313_is_act_inact_en(struct adxl313_data *data,
+				   enum adxl313_activity_type type)
+{
+	unsigned int axis_ctrl;
+	unsigned int regval;
+	int axis_en, int_en, ret;
+
+	ret = regmap_read(data->regmap, ADXL313_REG_ACT_INACT_CTL, &axis_ctrl);
+	if (ret)
+		return ret;
+
+	/* Check if axis for activity are enabled */
+	if (type != ADXL313_ACTIVITY)
+		return 0;
+
+	axis_en = FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl);
+
+	/* The axis are enabled, now check if specific interrupt is enabled */
+	ret = regmap_read(data->regmap, ADXL313_REG_INT_ENABLE, &regval);
+	if (ret)
+		return ret;
+
+	int_en = adxl313_act_int_reg[type] & regval;
+
+	return axis_en && int_en;
+}
+
+static int adxl313_set_act_inact_en(struct adxl313_data *data,
+				    enum adxl313_activity_type type,
+				    bool cmd_en)
+{
+	unsigned int axis_ctrl;
+	unsigned int threshold;
+	int ret;
+
+	if (type != ADXL313_ACTIVITY)
+		return 0;
+
+	axis_ctrl = ADXL313_ACT_XYZ_EN;
+
+	ret = adxl313_set_measure_en(data, false);
+	if (ret)
+		return ret;
+
+	ret = regmap_assign_bits(data->regmap, ADXL313_REG_ACT_INACT_CTL,
+				 axis_ctrl, cmd_en);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap, adxl313_act_thresh_reg[type], &threshold);
+	if (ret)
+		return ret;
+
+	ret = regmap_assign_bits(data->regmap, ADXL313_REG_INT_ENABLE,
+				 adxl313_act_int_reg[type],
+				 cmd_en && threshold);
+	if (ret)
+		return ret;
+
+	return adxl313_set_measure_en(data, true);
+}
+
 static int adxl313_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
@@ -370,6 +466,113 @@ static int adxl313_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int adxl313_read_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+
+	if (type != IIO_EV_TYPE_MAG)
+		return -EINVAL;
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		return adxl313_is_act_inact_en(data, ADXL313_ACTIVITY);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl313_write_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir,
+				      bool state)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+
+	if (type != IIO_EV_TYPE_MAG)
+		return -EINVAL;
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		return adxl313_set_act_inact_en(data, ADXL313_ACTIVITY, state);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl313_read_event_value(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info,
+				    int *val, int *val2)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+	unsigned int act_threshold;
+	int ret;
+
+	/* Measurement stays enabled, reading from regmap cache */
+
+	if (type != IIO_EV_TYPE_MAG)
+		return -EINVAL;
+
+	if (info != IIO_EV_INFO_VALUE)
+		return -EINVAL;
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		ret = regmap_read(data->regmap,
+				  adxl313_act_thresh_reg[ADXL313_ACTIVITY],
+				  &act_threshold);
+		if (ret)
+			return ret;
+		*val = act_threshold * 15625;
+		*val2 = MICRO;
+		return IIO_VAL_FRACTIONAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl313_write_event_value(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     enum iio_event_info info,
+				     int val, int val2)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+	unsigned int regval;
+	int ret;
+
+	ret = adxl313_set_measure_en(data, false);
+	if (ret)
+		return ret;
+
+	if (type != IIO_EV_TYPE_MAG)
+		return -EINVAL;
+
+	if (info != IIO_EV_INFO_VALUE)
+		return -EINVAL;
+
+	/* Scale factor 15.625 mg/LSB */
+	regval = DIV_ROUND_CLOSEST(MICRO * val + val2, 15625);
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		ret = regmap_write(data->regmap,
+				   adxl313_act_thresh_reg[ADXL313_ACTIVITY],
+				   regval);
+		if (ret)
+			return ret;
+		return adxl313_set_measure_en(data, true);
+	default:
+		return -EINVAL;
+	}
+}
+
 static int adxl313_set_watermark(struct iio_dev *indio_dev, unsigned int value)
 {
 	struct adxl313_data *data = iio_priv(indio_dev);
@@ -502,19 +705,32 @@ static int adxl313_fifo_push(struct iio_dev *indio_dev, int samples)
 
 static int adxl313_push_event(struct iio_dev *indio_dev, int int_stat)
 {
+	s64 ts = iio_get_time_ns(indio_dev);
 	struct adxl313_data *data = iio_priv(indio_dev);
 	int samples;
+	int ret = -ENOENT;
+
+	if (FIELD_GET(ADXL313_INT_ACTIVITY, int_stat)) {
+		ret = iio_push_event(indio_dev,
+				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							IIO_MOD_X_OR_Y_OR_Z,
+							IIO_EV_TYPE_MAG,
+							IIO_EV_DIR_RISING),
+				     ts);
+		if (ret)
+			return ret;
+	}
 
 	if (FIELD_GET(ADXL313_INT_WATERMARK, int_stat)) {
 		samples = adxl313_get_samples(data);
 		if (samples < 0)
 			return samples;
 
-		return adxl313_fifo_push(indio_dev, samples);
+		ret = adxl313_fifo_push(indio_dev, samples);
 	}
 
 	/* Return error if no event data was pushed to the IIO channel. */
-	return -ENOENT;
+	return ret;
 }
 
 static irqreturn_t adxl313_irq_handler(int irq, void *p)
@@ -553,6 +769,10 @@ static int adxl313_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 static const struct iio_info adxl313_info = {
 	.read_raw	= adxl313_read_raw,
 	.write_raw	= adxl313_write_raw,
+	.read_event_config = adxl313_read_event_config,
+	.write_event_config = adxl313_write_event_config,
+	.read_event_value = adxl313_read_event_value,
+	.write_event_value = adxl313_write_event_value,
 	.read_avail	= adxl313_read_freq_avail,
 	.hwfifo_set_watermark = adxl313_set_watermark,
 	.debugfs_reg_access = &adxl313_reg_access,
@@ -666,6 +886,19 @@ int adxl313_core_probe(struct device *dev,
 		if (ret)
 			return ret;
 
+		/*
+		 * Reset or configure the registers with reasonable default
+		 * values. As having 0 in most cases may result in undesirable
+		 * behavior if the interrupts are enabled.
+		 */
+		ret = regmap_write(data->regmap, ADXL313_REG_ACT_INACT_CTL, 0x00);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(data->regmap, ADXL313_REG_THRESH_ACT, 0x52);
+		if (ret)
+			return ret;
+
 		ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
 						  &adxl313_buffer_ops);
 		if (ret)
-- 
2.39.5


