Return-Path: <linux-iio+bounces-19624-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A03ABAFD0
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 13:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4DA1899B78
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 11:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43F821D3F1;
	Sun, 18 May 2025 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMARcSn2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE7F21CC49;
	Sun, 18 May 2025 11:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747566828; cv=none; b=Rl+7UpHy3fIZNAkC9JPUzhe13jSa3BlBh3JvWXHn5QuLejhzrqJW53whl3UwVDtAKab2xretKl23KRuTHG67H5FCkaBVl/DkUPtC/rO9E81wdWtc9ga9zTALYj9uoOQ1NQ4YVxPMAMXPoHWzZTxdr4WGZXRBGV8brHJc7+31Yqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747566828; c=relaxed/simple;
	bh=FAkeI3iLXBoKfNQQG5a9Eb2lE65BJrdkrbdP26nSRkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AxUHi/R4p3EUFHS5pcL4bZFsxZHVdUTxQb+XKeffKHwYMpAvx+3uENs/7prRtKLYP6bmFV38eEDHzr5rSh8oU+4JULncVvK3eRPRjp2YzmvZpcXL7u9KQdsVgkypaX7lfUi9NH6BL9yGA3q0hEPX4cxlAwfpYM8pwYl20zVxQbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMARcSn2; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a35ae46214so270653f8f.2;
        Sun, 18 May 2025 04:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747566825; x=1748171625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pV3a4M1kUDF9zkuT1tBZbV9E8xvUYJCDi11TETr8fdc=;
        b=gMARcSn29F9q5JXOCLfYyIo4/Iaq3F0UIwmA+uLwpOk0Kqcn98qrkizGD00lJLoKkT
         E7lm5SZfKUr6DciKqPoxzCvXsW1RKu0VRWRhwyuaKEgGL+yIYf5IqtG0D4B2RDlDu4dE
         aukowIasOKfdhNSYhHhufBv989Bzgi5vDzPpMq6bR6DnQFl+BqsXA7yFnoSqxsyXxDpw
         zpH41p9izm3g4B1bVS4xZhOsjNgWxHjFOwIo6xkTfDh0n7E0r8vcMJWroNEdpkhPIElB
         YCTrOV8suBPRM26KEydGvt1wcUtBL4XtK6BsHPT9XslYfzrvsqgg1ns1aVa7mS+k5v1o
         J72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747566825; x=1748171625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pV3a4M1kUDF9zkuT1tBZbV9E8xvUYJCDi11TETr8fdc=;
        b=Qgylu0Ug+86UV7gqX4ymxneQxKaZyLBiEIgZsxRrLedgIQ/BN4Pmc0ezg/R++QV0JH
         8+ikFyWwHwvyJYef6ysmWPegFRblfjcjL3qCUDRDSKDVywLI2yB4uLPq2b4RAqEPlyKJ
         43UisT2TXeTWafZQGQsfH7EcCyGiKjnffVf9TG/J5tzxSsK1SQBhgfA1RDd7RfFnNp57
         cE8d1zGWjrqk6zKCfs6Da6PnzCSO5C9+IrRidJDGBDEsYaenSwQbyMQbFwrRZfPZKAhB
         z/nxI3VDwsip2/iNTrO71IGwj3iJ4QZtaxP/aORgJJ8NhhNUPfNL75KXEx1FmqssIjge
         K1Mg==
X-Forwarded-Encrypted: i=1; AJvYcCXKqxJpy3jn3DV80Qy0nOJYbgOexWT+62QOfUnVYk6W2Kju1XBFOuD0LbMave+Q2fKj4a4TNf4pvm0Q4lol@vger.kernel.org, AJvYcCXhIJ+i1/a4gNSzYX4jhmCukt10AAslrLCVGe3bv7d9nYP/J6aFKjgTenRTTnkP0KSum0p7LtlQ6gc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz05sxw3OGm9LngIuVy90joab7LQKJUolEdRnaFUUjV4IsSxiG3
	zjK4cMF9zvdtqXK09LWSFVjwE27COgLhqbq5EraBCV7XRTuy9ZehG2lu
X-Gm-Gg: ASbGncuQwiMP2Api6vlLlIPZySYSTVHcBiH02O824TxDRhdFpQ8t7mBY0oCXwgpUpp4
	mo5qg36CKPG/xc1WVaqm/BsbaKg+VN+yaqYXUgxPzZ39sGKIVVP0lcUyAWwgZqIOG/wvs/NVyWZ
	0UAez4c09f351RX5AYehFaPnjjebmw6s/nZamg9/Tk+pwbg+3Ww04cq5WlvnUYimBpM+YG4vswC
	INRkgr2PfxNMM6PTjeTALZpZaFn1w5PmgSWg0xHz4cCQk+w+0GLsxRkwBFSBEaQ9C4rT/61fyOg
	YHYByhG2VpOktkxO1dvtulL5AIUgbHyo3jFYxBIBZGNvP8S++FHY87GECTJ+A/NFTO+o1rX/bsE
	hQMBMofSSGpc0D+B0yLpvzA==
X-Google-Smtp-Source: AGHT+IFoPl1oI2i/STs2tXUTPsaokM/zK5NSc7nilel36Z5XA/xBKtTHjlDM5LpSSJ+I+0ngQ2NrVA==
X-Received: by 2002:a5d:5f43:0:b0:3a3:62c6:d2b9 with SMTP id ffacd0b85a97d-3a362c6d3fbmr2186482f8f.8.1747566824563;
        Sun, 18 May 2025 04:13:44 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d1dfsm9287446f8f.18.2025.05.18.04.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 04:13:44 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH v1 09/12] iio: accel: adxl313: add activity sensing
Date: Sun, 18 May 2025 11:13:18 +0000
Message-Id: <20250518111321.75226-10-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250518111321.75226-1-l.rubusch@gmail.com>
References: <20250518111321.75226-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl313_core.c | 252 +++++++++++++++++++++++++++++++
 1 file changed, 252 insertions(+)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 0a93af89ba19..49914ccc92cf 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -27,6 +27,21 @@
 
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
@@ -231,6 +246,16 @@ static const int adxl313_odr_freqs[][2] = {
 	},								\
 }
 
+static const struct iio_event_spec adxl313_fake_chan_events[] = {
+	{
+		/* activity */
+		.type = IIO_EV_TYPE_MAG,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
+	},
+};
+
 enum adxl313_chans {
 	chan_x, chan_y, chan_z
 };
@@ -239,6 +264,14 @@ static const struct iio_chan_spec adxl313_channels[] = {
 	ADXL313_ACCEL_CHANNEL(0, chan_x, X),
 	ADXL313_ACCEL_CHANNEL(1, chan_y, Y),
 	ADXL313_ACCEL_CHANNEL(2, chan_z, Z),
+	{
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_X_AND_Y_AND_Z,
+		.scan_index = -1, /* Fake channel for axis AND'ing */
+		.event_spec = adxl313_fake_chan_events,
+		.num_event_specs = ARRAY_SIZE(adxl313_fake_chan_events),
+	},
 };
 
 static const unsigned long adxl313_scan_masks[] = {
@@ -301,6 +334,67 @@ static int adxl313_read_freq_avail(struct iio_dev *indio_dev,
 	}
 }
 
+static int adxl313_is_act_inact_en(struct adxl313_data *data,
+				   enum adxl313_activity_type type,
+				   bool *en)
+{
+	unsigned int axis_ctrl;
+	unsigned int regval;
+	int ret;
+
+	*en = false;
+
+	ret = regmap_read(data->regmap, ADXL313_REG_ACT_INACT_CTL, &axis_ctrl);
+	if (ret)
+		return ret;
+
+	if (type == ADXL313_ACTIVITY)
+		*en = FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl);
+
+	if (*en) {
+		ret = regmap_read(data->regmap, ADXL313_REG_INT_ENABLE, &regval);
+		if (ret)
+			return ret;
+
+		*en = adxl313_act_int_reg[type] & regval;
+	}
+
+	return 0;
+}
+
+static int adxl313_set_act_inact_en(struct adxl313_data *data,
+				    enum adxl313_activity_type type,
+				    bool cmd_en)
+{
+	unsigned int axis_ctrl = 0;
+	unsigned int threshold;
+	bool en;
+	int ret;
+
+	if (type == ADXL313_ACTIVITY)
+		axis_ctrl = ADXL313_ACT_XYZ_EN;
+
+	ret = regmap_update_bits(data->regmap,
+				 ADXL313_REG_ACT_INACT_CTL,
+				 axis_ctrl,
+				 cmd_en ? 0xff : 0x00);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap, adxl313_act_thresh_reg[type], &threshold);
+	if (ret)
+		return ret;
+
+	en = false;
+
+	if (type == ADXL313_ACTIVITY)
+		en = cmd_en && threshold;
+
+	return regmap_update_bits(data->regmap, ADXL313_REG_INT_ENABLE,
+				  adxl313_act_int_reg[type],
+				  en ? adxl313_act_int_reg[type] : 0);
+}
+
 static int adxl313_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
@@ -374,6 +468,135 @@ static int adxl313_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int adxl313_read_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+	bool int_en;
+	int ret;
+
+	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			ret = adxl313_is_act_inact_en(data,
+						      ADXL313_ACTIVITY,
+						      &int_en);
+			if (ret)
+				return ret;
+			return int_en;
+		default:
+			return -EINVAL;
+		}
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
+	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return adxl313_set_act_inact_en(data,
+							ADXL313_ACTIVITY,
+							state);
+		default:
+			return -EINVAL;
+		}
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
+	/* measurement stays enabled, reading from regmap cache */
+
+	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			switch (dir) {
+			case IIO_EV_DIR_RISING:
+				ret = regmap_read(data->regmap,
+						  adxl313_act_thresh_reg[ADXL313_ACTIVITY],
+						  &act_threshold);
+				if (ret)
+					return ret;
+				*val = act_threshold * 15625;
+				*val2 = 1000000;
+				return IIO_VAL_FRACTIONAL;
+			default:
+				return -EINVAL;
+			}
+		default:
+			return -EINVAL;
+		}
+
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
+	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			/* The scale factor is 15.625 mg/LSB */
+			regval = DIV_ROUND_CLOSEST(1000000 * val + val2, 15625);
+			switch (dir) {
+			case IIO_EV_DIR_RISING:
+				ret = regmap_write(data->regmap,
+						   adxl313_act_thresh_reg[ADXL313_ACTIVITY],
+						   regval);
+				if (ret)
+					return ret;
+				return adxl313_set_measure_en(data, true);
+			default:
+				return -EINVAL;
+			}
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
 static int adxl313_set_watermark(struct iio_dev *indio_dev, unsigned int value)
 {
 	struct adxl313_data *data = iio_priv(indio_dev);
@@ -508,10 +731,22 @@ static int adxl313_fifo_push(struct iio_dev *indio_dev, int samples)
 
 static int adxl313_push_event(struct iio_dev *indio_dev, int int_stat)
 {
+	s64 ts = iio_get_time_ns(indio_dev);
 	struct adxl313_data *data =  iio_priv(indio_dev);
 	int samples;
 	int ret = -ENOENT;
 
+	if (FIELD_GET(ADXL313_INT_ACTIVITY, int_stat)) {
+		ret = iio_push_event(indio_dev,
+				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							IIO_MOD_X_AND_Y_AND_Z,
+							IIO_EV_TYPE_MAG,
+							IIO_EV_DIR_RISING),
+				     ts);
+		if (ret)
+			return ret;
+	}
+
 	if (FIELD_GET(ADXL313_INT_WATERMARK, int_stat)) {
 		samples = adxl313_get_samples(data);
 		if (samples < 0)
@@ -558,6 +793,10 @@ static int adxl313_reg_access(struct iio_dev *indio_dev, unsigned int reg,
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
@@ -668,6 +907,19 @@ int adxl313_core_probe(struct device *dev,
 		if (ret)
 			return ret;
 
+		/*
+		 * Reset or configure the registers with reasonable default
+		 * values. As having 0 in most cases may result in undesirable
+		 * behavior if the interrupts are enabled.
+		 */
+		ret = regmap_write(data->regmap, ADXL313_REG_ACT_INACT_CTL, 0);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(data->regmap, ADXL313_REG_THRESH_ACT, 0x52);
+		if (ret)
+			return ret;
+
 		ret  = devm_iio_kfifo_buffer_setup(dev, indio_dev,
 						   &adxl313_buffer_ops);
 		if (ret)
-- 
2.39.5


