Return-Path: <linux-iio+bounces-21274-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3513CAF65FD
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 01:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A974E015D
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 23:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6301D24468B;
	Wed,  2 Jul 2025 23:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baLz+QVy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0541A2E03FD;
	Wed,  2 Jul 2025 23:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497712; cv=none; b=YRRO4a2kQVY+/8mDppNbJZd17jTaSO7TQiEM1nzedBmUWOpJWUXe26PvAWleW3IzlVKK6+HU3WZCfxcVPwcWmCgAWMauYqqnFUa0T73G0/FDOzAKBs2QJpFl3YEkcdGJ+M6Yg0/9MlFmxzPIl6Th44CVRdEAgZz5nHv48kmgMXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497712; c=relaxed/simple;
	bh=h3/a0Q9+9MW7F2bL0/4opJlubTRkyT3fuD/vtomhh/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qw5+uDDXl4SQacN8OD7v0nB05KB4c6nb3Pv3/59HzcEVBww08zuwLWXaUEPs1nmnMW6X+7mZGsEQBCknB7AgO6co07PgrlApxJA8IkfiJHLkf3+qy02E0i11EDwoggbKOMogJUdPrsl6JOGvJK/rsZoahmOxrt0sHnvwMq/iF4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baLz+QVy; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae3521a129aso92911966b.3;
        Wed, 02 Jul 2025 16:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497708; x=1752102508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbhLFYMz46xEB1YUu1Q4x0HgQDDSkCjbH4WEeWQ31Jo=;
        b=baLz+QVy2mdEydBYc4WFfILmQAgI9F9D+TPev1g7ifnDzddvQZ0i6Bm2eJEwi0PHin
         rh/Tl3eIFzChblr4KIKhsXY2ylLSaSoRsqAWtz/cWwF3Xsa3EPgJm92XsIHpnM2rZ49Q
         19ZKQxst4JgvWs5PEKg4juvS922TiS5YYGlGK4/QZeFxC9jUvAGDhgTdDLk9yh3a0M9Q
         LqxjpY+Bu6iimmNrPV0ZTiIAruLxp7wQZfl1HexuYW8SrhvcezWsEtjVkmUTUjcqGupT
         7hWZzgex0Xl1ZuVPMav0o/na39D1OWVS4bMtO8P+JuJFeAkFi932ED2ychFWJwaZ2i/4
         c/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497708; x=1752102508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbhLFYMz46xEB1YUu1Q4x0HgQDDSkCjbH4WEeWQ31Jo=;
        b=vWS0FKuISaP/NESUFaKybtUXpDpqU+cC/pr1zlG82MadEYNc3WPGXmkhMRw+iysT4H
         UsRy+sCix2UPsRlVAFr5VjpHXuBIt782IxpO6CXUKvEnTsDn2GH6uH1zRDGF5BbYCDkX
         +0csZ0U7juSHhm28AR5I0WOppNjKUPGcyKSwZL1worHv1kERD4lBT9cwStUOSSLZMYDp
         8+1IIQ/r2xkPstSiirweQPcSZr+4N4peLFVHKiuaPUkesakmBaHDdNuQFUP5MmuTjSOF
         8fvtWtjawEBHkSNL04kshan4T+3aVCF+mdbDswwIMOzHZ/oGhRc1xjg9twewBmkdq2Rn
         iuZA==
X-Forwarded-Encrypted: i=1; AJvYcCV0JymU0I64OjckeZ6URV2LWJh/rxXoLOqhVqtCmpzNml24WJkwCvqQMrtABQ1dbOPcuNh6RE5wj1d8oGQu@vger.kernel.org, AJvYcCVOAGPs7XC2x4N7uITB8VL+Q17R9qhGbwj1H/oHQg9+2+oh3ByEgGbXy/fhCueeOlIHGfg3EWBr2Ms=@vger.kernel.org, AJvYcCWNWYTWoPdb5gES4svwzDjnV8EGTrPEPl0B2j58NQOc6iSXLTXYW+ntgYm1jse5RHfGPny8PRH4+kXm@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdl3DisKqedojnLrPn4ut0Sm05Am8PcE7OhwC3E3Cue+nWjJwJ
	6KO7I6iSrzMRd8m17iyMf2ozJr5Ncv2RguAqr6VvesSJq6tB2HGlGmTj
X-Gm-Gg: ASbGnctdzCsUVTPC0gJt0GnbVlXCO7t8nXFiCSa3sHjjqTR0d3vN0uQJe8JdccUdSke
	6RcUY234hSKWY2ahSHbndhqeAQd9C7uPSUCgHFw9RTGGa+kd006GUTwl8SUWlMyYlf4AVI86sy5
	uT0xNnulrAAS2mFIhZqlP4Uegr1JUKQNxN3hthOaFemKKJUkYSxBt1gf8OI4suSCZLpT10hla2v
	fblx87KMAh0eXY4WnfPSDukdJ/dSKE4psj3eSq/m7r5SPVBfGgzlIjAWxbOT97zmZoDb+O+EEbu
	tMezyxLMmK/j8E8LB5pDlHLwj6FN9/ojIH30u1ryidpIX3yAuhYavNfZKb4OEzYs8eubKsZnYee
	gyC7UZ7tmRQ1ge7zKC8NYJukR8J5cEKsS
X-Google-Smtp-Source: AGHT+IGGNSVJiF5W6NpTeTSVzdLQhULs/WwAN07w/e1eIli5cu1dA+UGA8jMdtzcRg8pKYDUXrlXWA==
X-Received: by 2002:a17:907:7ea0:b0:ad8:882e:38a with SMTP id a640c23a62f3a-ae3e28514b4mr5943566b.14.1751497708281;
        Wed, 02 Jul 2025 16:08:28 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353ca18bbsm1158355566b.151.2025.07.02.16.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:08:27 -0700 (PDT)
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
Subject: [PATCH v7 4/8] iio: accel: adxl313: add activity sensing
Date: Wed,  2 Jul 2025 23:08:15 +0000
Message-Id: <20250702230819.19353-5-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702230819.19353-1-l.rubusch@gmail.com>
References: <20250702230819.19353-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for configuring an activity detection threshold. Extend the
interrupt handler to process activity-related interrupts, and provide
functions to set the threshold as well as to enable or disable activity
sensing. Additionally, introduce a virtual channel that represents the
logical AND of the x, y, and z axes in the IIO channel.

This patch serves as a preparatory step; some definitions and functions
introduced here are intended to be extended later to support inactivity
detection.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313_core.c | 306 +++++++++++++++++++++++++++++++
 1 file changed, 306 insertions(+)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 04ca8491bb5c..828b46b2254d 100644
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
@@ -297,6 +331,81 @@ static int adxl313_read_freq_avail(struct iio_dev *indio_dev,
 	}
 }
 
+static int adxl313_is_act_inact_en(struct adxl313_data *data,
+				   enum adxl313_activity_type type)
+{
+	unsigned int axis_ctrl;
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(data->regmap, ADXL313_REG_ACT_INACT_CTL, &axis_ctrl);
+	if (ret)
+		return ret;
+
+	/* Check if axis for activity are enabled */
+	switch (type) {
+	case ADXL313_ACTIVITY:
+		if (!FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl))
+			return false;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Check if specific interrupt is enabled */
+	ret = regmap_read(data->regmap, ADXL313_REG_INT_ENABLE, &regval);
+	if (ret)
+		return ret;
+
+	return adxl313_act_int_reg[type] & regval;
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
+	if (cmd_en) {
+		/* When turning on, check if threshold is valid */
+		ret = regmap_read(data->regmap, adxl313_act_thresh_reg[type],
+				  &threshold);
+		if (ret)
+			return ret;
+
+		if (!threshold) /* Just ignore the command if threshold is 0 */
+			return 0;
+	}
+
+	/* Start modifying configuration registers */
+	ret = adxl313_set_measure_en(data, false);
+	if (ret)
+		return ret;
+
+	/* Enable axis according to the command */
+	switch (type) {
+	case ADXL313_ACTIVITY:
+		axis_ctrl = ADXL313_ACT_XYZ_EN;
+		break;
+	default:
+		return -EINVAL;
+	}
+	ret = regmap_assign_bits(data->regmap, ADXL313_REG_ACT_INACT_CTL,
+				 axis_ctrl, cmd_en);
+	if (ret)
+		return ret;
+
+	/* Enable the interrupt line, according to the command */
+	ret = regmap_assign_bits(data->regmap, ADXL313_REG_INT_ENABLE,
+				 adxl313_act_int_reg[type], cmd_en);
+	if (ret)
+		return ret;
+
+	return adxl313_set_measure_en(data, true);
+}
+
 static int adxl313_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
@@ -370,6 +479,157 @@ static int adxl313_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int adxl313_read_mag_config(struct adxl313_data *data,
+				   enum iio_event_direction dir,
+				   enum adxl313_activity_type type_act)
+{
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		return !!adxl313_is_act_inact_en(data, type_act);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl313_write_mag_config(struct adxl313_data *data,
+				    enum iio_event_direction dir,
+				    enum adxl313_activity_type type_act,
+				    bool state)
+{
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		return adxl313_set_act_inact_en(data, type_act, state);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl313_read_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+
+	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		return adxl313_read_mag_config(data, dir,
+					       ADXL313_ACTIVITY);
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
+		return adxl313_write_mag_config(data, dir,
+						ADXL313_ACTIVITY,
+						state);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl313_read_mag_value(struct adxl313_data *data,
+				  enum iio_event_direction dir,
+				  enum iio_event_info info,
+				  enum adxl313_activity_type type_act,
+				  int *val, int *val2)
+{
+	unsigned int threshold;
+	int ret;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			ret = regmap_read(data->regmap,
+					  adxl313_act_thresh_reg[type_act],
+					  &threshold);
+			if (ret)
+				return ret;
+			*val = threshold * 15625;
+			*val2 = MICRO;
+			return IIO_VAL_FRACTIONAL;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl313_write_mag_value(struct adxl313_data *data,
+				   enum iio_event_direction dir,
+				   enum iio_event_info info,
+				   enum adxl313_activity_type type_act,
+				   int val, int val2)
+{
+	unsigned int regval;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		/* Scale factor 15.625 mg/LSB */
+		regval = DIV_ROUND_CLOSEST(MICRO * val + val2, 15625);
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return regmap_write(data->regmap,
+					    adxl313_act_thresh_reg[type_act],
+					    regval);
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
+
+	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		return adxl313_read_mag_value(data, dir, info,
+					      ADXL313_ACTIVITY,
+					      val, val2);
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
+
+	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		return adxl313_write_mag_value(data, dir, info,
+					       ADXL313_ACTIVITY,
+					       val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
 static int adxl313_set_watermark(struct iio_dev *indio_dev, unsigned int value)
 {
 	struct adxl313_data *data = iio_priv(indio_dev);
@@ -508,6 +768,25 @@ static int adxl313_fifo_push(struct iio_dev *indio_dev, int samples)
 	return 0;
 }
 
+static int adxl313_push_events(struct iio_dev *indio_dev, int int_stat)
+{
+	s64 ts = iio_get_time_ns(indio_dev);
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
+
+	return ret;
+}
+
 static irqreturn_t adxl313_irq_handler(int irq, void *p)
 {
 	struct iio_dev *indio_dev = p;
@@ -517,6 +796,16 @@ static irqreturn_t adxl313_irq_handler(int irq, void *p)
 	if (regmap_read(data->regmap, ADXL313_REG_INT_SOURCE, &int_stat))
 		return IRQ_NONE;
 
+	/*
+	 * In cases of sensor events not handled (still not implemented) by
+	 * this driver, the FIFO needs to be drained to become operational
+	 * again. In general the sensor configuration only should issue events
+	 * which were configured by this driver. Anyway a miss-configuration
+	 * easily might end up in a hanging sensor FIFO.
+	 */
+	if (adxl313_push_events(indio_dev, int_stat))
+		goto err;
+
 	if (FIELD_GET(ADXL313_INT_WATERMARK, int_stat)) {
 		samples = adxl313_get_samples(data);
 		if (samples < 0)
@@ -550,6 +839,10 @@ static int adxl313_reg_access(struct iio_dev *indio_dev, unsigned int reg,
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
@@ -687,6 +980,19 @@ int adxl313_core_probe(struct device *dev,
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


