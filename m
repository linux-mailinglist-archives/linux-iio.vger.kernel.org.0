Return-Path: <linux-iio+bounces-19845-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A1AAC2BDB
	for <lists+linux-iio@lfdr.de>; Sat, 24 May 2025 00:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0AA188D8B5
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 22:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D34221549;
	Fri, 23 May 2025 22:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEswDjlg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B225220699;
	Fri, 23 May 2025 22:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748039765; cv=none; b=NnJjLNtDX7W6hlw1he9yCqNEhp57PaBj6Nb7g6vMbNgn9tf59r+Kel5pH3SfGfQTzhSGA7qhtB8pfE2V+uAmD+BgeYcuUpT5qlYUuoN6sGt0v0YGfF7R6GurCkrACjOQ5w2SEW63H/Y3lBpkTKhAHv+QUGa/1Uv8x/X+L1sIGjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748039765; c=relaxed/simple;
	bh=iJSf6Xxk6KeT6wlI5gW700ZO+GsAq/Lk9zSEi6JYGU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MgqhBysco6s6rqSfHySWoYsiWCRp2dbK0o6K/rlgbYrcAVyKP3tPzjFH6kUdQHf4EiuFPYuzajI9eO5wY56uTjdC8ZQfX9FcIi1G2oRvgdBGVKXfA/GgFFhTuL4HDc9HA4wFuxVJ6ghqgauP290nHqC3qSdUDWKIu69V6SAIeT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEswDjlg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43d72b749dcso345745e9.1;
        Fri, 23 May 2025 15:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748039762; x=1748644562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6s57TFtd1As3uzIgt1BYG6+jylYZ5jj1HV+ep70fK38=;
        b=SEswDjlgovVFPdpSB7IE5PmC+hBUXec0YejZCaVwLv2NhzoPcG27znngXdQxCmifTm
         gYwoJE7fMR6ozGaA0GS4D5wgBCxZsBMHhbtQ4vVUvnhn0pz5x1BdSHZ+Vbs6zCRw3oju
         WS3SSue+fvn9ZwcJGdXNVxfDZZlgScMxX2B5QYyr1UGHPKeQPJQSgg39JG1QM5fZDops
         O6dYWcS5Uhdkxx0TCbbwk+ixcgB1i6pSIgykpG13NzDO7yuVoeKf0M/41KjYpj3f62jn
         FJjD/8fvYjxUDV+8CMfkb95py6M/UEMOrTDLJOXpjOueXFBH8kYJOFBVhautWXMj26tN
         nnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748039762; x=1748644562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6s57TFtd1As3uzIgt1BYG6+jylYZ5jj1HV+ep70fK38=;
        b=cI05jFKyYPJRKYlDqNfIEtrwenNx8ZxOttjZ4gpEOxxOl2K0tcYUyP9cqgut6glUvs
         ABMWuOXrOJGQzhGvvKBDwsi6foi2GzzoOzZCEi57SD65JI700uYj2bzsOvmK+ZwWl5/o
         W2lJPlnMIDW3aPPvKEwYrODHljzzyqK21iHWUfF7AiPwvQXNdkFgmi0+Phs5XqScIpnQ
         8Z+wMHTPfDb5zsqsLbpO0n23cOGOjwZJsPgYT75IRVx2bzHWz1Gh4jxu3acG6F/vM9iQ
         G3PUod4rQMYxmAuUQyAhFh+ts5/t+q86AgzJHq2GFslsez3lnXc5iTCEYdQmLeOMmJAU
         Eofw==
X-Forwarded-Encrypted: i=1; AJvYcCUmAylK1WcMiVXp+B509+X6ZGg0D3ky1tS9Pz09Ts4hK5qT5n9CA+LCNvhHfq7EglhI3Uz4vSgfs1c=@vger.kernel.org, AJvYcCWkaROnZEXxbteOQOn/vJISN0Bh2RBu5pApffdxZqY/ybFz+hL05SIaWEW/pdRVkFtjrytIr1C4ubv4g8KX@vger.kernel.org, AJvYcCXRuM9glvRK53aA9Pk1b5XPlIS+7Ei475gtHuNm1o7LlEpbMzvzKYjPNKtnwca7V2CECdYUQexZek83@vger.kernel.org
X-Gm-Message-State: AOJu0YxkIvD0+ed2LvSsVqchU9p3fMEjCs2jnDuJkaCo2Hqe9W3GRIOE
	zkNos/ak3egl9eBI5XqyEFDlHEeQenNW+VE4glHaKC+yE1YpFialsTxd
X-Gm-Gg: ASbGncvJzY2Ejv7lrl83yuzV+H079Mwd3OYHDFvdTLjmmcRkIcYAaaH+5z9JaOkkuQq
	XAsNYI8jE44Rvzbm39Ez62vdfglwAJWi3BloR3LxPR5MDfP9+gXbR91bdfVa4gDAlsjKOvGxhzi
	5VWlpHYgB8URaEgNXE9/eC9vaePEBft83oSrp+6j5P+nJABXW4Oc/mO3jo3hMTnZ4uP/7IQlR8w
	9dfmi3jZ8fZL/XxvC1amvwFjkzxURvHS8MBBr9Pmd+0Q+NWGOPUvLNNFWY7IjTP5KhD4Z/mf/Vx
	4Yu8DS6UpoE8H3jkeG1n2m+RJWRUF4w+gsJ3Mbr3XBHF0guZIQAWe5BQjRSIzudZ6gp1wF0AA8S
	n98ZR0nkF8wbKf/y/yQDr/w==
X-Google-Smtp-Source: AGHT+IH92z7+suz//80DLf9LLeXZNiEXuA0iuAGn2aCcVB5h8N23TOM7esWj/0ZFSYTaZYj62MFNmA==
X-Received: by 2002:a05:6000:2906:b0:3a3:4b8a:99bd with SMTP id ffacd0b85a97d-3a4cb49fdf7mr281016f8f.14.1748039761569;
        Fri, 23 May 2025 15:36:01 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6b29672sm165202375e9.3.2025.05.23.15.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 15:36:01 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: l.rubusch@gmail.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/12] iio: accel: adxl313: add activity sensing
Date: Fri, 23 May 2025 22:35:20 +0000
Message-Id: <20250523223523.35218-10-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250523223523.35218-1-l.rubusch@gmail.com>
References: <20250523223523.35218-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl313_core.c | 229 ++++++++++++++++++++++++++++++-
 1 file changed, 227 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 80991cd9bd79..74bb7cfe8a55 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -13,6 +13,7 @@
 #include <linux/overflow.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/units.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
@@ -28,6 +29,21 @@
 
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
@@ -230,6 +246,16 @@ static const int adxl313_odr_freqs[][2] = {
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
 	chan_x, chan_y, chan_z,
 };
@@ -238,6 +264,14 @@ static const struct iio_chan_spec adxl313_channels[] = {
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
@@ -300,6 +334,60 @@ static int adxl313_read_freq_avail(struct iio_dev *indio_dev,
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
+	ret = regmap_assign_bits(data->regmap, ADXL313_REG_ACT_INACT_CTL,
+				 axis_ctrl, cmd_en);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap, adxl313_act_thresh_reg[type], &threshold);
+	if (ret)
+		return ret;
+
+	return regmap_assign_bits(data->regmap, ADXL313_REG_INT_ENABLE,
+				  adxl313_act_int_reg[type],
+				  cmd_en && threshold);
+}
+
 static int adxl313_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
@@ -373,6 +461,113 @@ static int adxl313_write_raw(struct iio_dev *indio_dev,
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
@@ -509,19 +704,32 @@ static int adxl313_fifo_push(struct iio_dev *indio_dev, int samples)
 
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
+							IIO_MOD_X_AND_Y_AND_Z,
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
@@ -560,6 +768,10 @@ static int adxl313_reg_access(struct iio_dev *indio_dev, unsigned int reg,
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
@@ -669,6 +881,19 @@ int adxl313_core_probe(struct device *dev,
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


