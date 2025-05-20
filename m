Return-Path: <linux-iio+bounces-19757-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46CAABE799
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 00:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71D647B2D9F
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 22:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C24265611;
	Tue, 20 May 2025 22:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyvZvGcE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28982641F8;
	Tue, 20 May 2025 22:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747781450; cv=none; b=E5N93qLBHpGQUum6AtmQdRrV2JEzlVAX/b5N95urZu9sw5pmG5MuKgs6wapBzBUWPupJ96Va9ZapBGpu0+9/AL8vj7naqqFKohZ1AxYeRDHqcDS3s6itIpiK6bswiy1LzKyohWY+jLelGIHLK7W1i9A399tj2Cr9sGYv1U/uX9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747781450; c=relaxed/simple;
	bh=cGFbi5C3yvvVc2j088BWbK1R9NCI10pI8FhrnRnpm3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UCCN3txZJHf24UaalrtyKZiMVEBPBoqY7hjN8HjYWCau7wiKai2Wqw7+/rFzr8As2mNq36i5CkKJgyMjebA+XTWbamKlYoG+JN73h2V4E72kYfW1UTle7kZDWQxJ9RIT697OiluSWsOqnZ/zggQVo4Iboe3NXcRxrG6gjlRDIqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KyvZvGcE; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-441c0d42233so6497955e9.0;
        Tue, 20 May 2025 15:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747781447; x=1748386247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iC2hxGqQGFL4ebjRUVvTAYj7NaaoF4Tthin7d6OvSlQ=;
        b=KyvZvGcEe67kaM7ORod1CVWw4O73PGxOJKyaFBO9Z293BVjHdooO63HuXzuxm08bdt
         vLRaAvLyfXyTmiFhnqZ1T24xTCSZwUF8StUTPQVoMoGxpgUkUVrmomIB4KLLczeYWUZe
         N/wwOCD8njBs3TMo/fgF4i4tEXcT6c8Rg3wyHmNScjjufc4HUkqhTov122p1H5kfTXGa
         ihmCX8L/astsrlty5jPAtWQvNQgyeiJ5hBMP4oXmPGb7wfVSEMMTo+HIOaCQTS3OQVnc
         gNtxqKaC/mzsnDmUCf4T2IsJKsKTB0crd0793Ll7ILkJliqIp7RHSz9CS/OdGIApVeIP
         7AQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747781447; x=1748386247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iC2hxGqQGFL4ebjRUVvTAYj7NaaoF4Tthin7d6OvSlQ=;
        b=iAX+OmUD8tnVaIdXl5Jiy4NrS6apx9kZT0xET8EzJmC1fghWoEB/zrYzr1YHZJf4B3
         yaJgr1lO/dCIOgUP9M+r8WGlwtcQtXmiwI0nQbIueg2nOA31pkHdLV/Vb7a5OeK88LCN
         H7JyDF3R5m0pKCO2K29C3OEAknzeKCeXoUEhyoe6rYPzGEduzVS7SO5tX6QAhUAf4WDU
         F8SmtTF9kOayzFnNBV8HniisI5Ij8u0XAqt4TJ3ivf9htRSrl6qCnWKvFnsPaHsCCS8B
         omXPkKLQD9JkR/O+znbsDdTljMHKEiWKxOHKxBBdeNcQLZINZ0TPcWx74W2dj+OKp15S
         2llg==
X-Forwarded-Encrypted: i=1; AJvYcCX0WkHh5s5RQghohVO1HCFNO4EUx5GoNtEDC8xlDLchy5F+XsKvOhseCuJemWargSXlqWwmK+ai4+b4KjoP@vger.kernel.org, AJvYcCXoEpX3yUdM2CJ0sckki4hvvQ09NNijz1TrPhanjraxRiDU2UMLQOIfv8hlRIMxEdolpURNt9I3G1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvGp65bV3E3F/chZqh25b2B3vzxw3ieAXoQZY1PKC5wGBloqjN
	dEZybeC2/wLzzaruaiAwho7Bk5JYGqao4Bu3QDUMEvc5Z9pO+hrG6oWj
X-Gm-Gg: ASbGncvrXIYfJ1gJ2/l99Kdn+lfR1pdqRgtZzQzcNcLPKVlhsnB3JJopw9s6uOcm5vv
	kt/HRptCrvdHQ7u++6ja/X1aXaWgG/akNPdOqR5jzA6nHumjfO2sydiwHoJu83FLFY9G5/lNjf4
	5eFsjGUlskFXZDZe8iR+272i9rLOxqi6SGkOVy+eaZSjKScMwmq0Axp5air96AEj29ssfNE0/zL
	Kn4fNKhTubdCBFIXZt/6qpBh6WZJh+51g5iU3OkWYB6qKniTTI/C4MGhc7zaTI2BHU3VUDRaY2u
	1o7shBZoW+OhR/DZIpg5JVEPDE1Q9PDVDv47YcuerOkiqTBCaRey5jGDHFsn8YvTtxVt3htHOu9
	PM1FwHgdHaR7u9jx/AKxlxw==
X-Google-Smtp-Source: AGHT+IGN8P/Q72OtlXii6iV/7bS8eGzUg5GN3V2j5cslejFXwVb+y0i/MJnKoH28Te1lP8JpnW8vRw==
X-Received: by 2002:a05:6000:2284:b0:3a3:6e0e:a09d with SMTP id ffacd0b85a97d-3a36e0ea15dmr3675147f8f.6.1747781446855;
        Tue, 20 May 2025 15:50:46 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d105sm18101588f8f.11.2025.05.20.15.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 15:50:46 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	l.rubusch@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/12] iio: accel: adxl313: add activity sensing
Date: Tue, 20 May 2025 22:50:04 +0000
Message-Id: <20250520225007.10990-10-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250520225007.10990-1-l.rubusch@gmail.com>
References: <20250520225007.10990-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl313_core.c | 230 +++++++++++++++++++++++++++++++
 1 file changed, 230 insertions(+)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index da89e13a100d..2ad87e98525c 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/units.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
@@ -27,6 +28,21 @@
 
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
@@ -231,6 +247,16 @@ static const int adxl313_odr_freqs[][2] = {
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
@@ -239,6 +265,14 @@ static const struct iio_chan_spec adxl313_channels[] = {
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
@@ -301,6 +335,66 @@ static int adxl313_read_freq_avail(struct iio_dev *indio_dev,
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
+	if (type == ADXL313_ACTIVITY)
+		axis_en = FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl);
+	else
+		return 0;
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
+	if (type == ADXL313_ACTIVITY)
+		en = cmd_en && threshold;
+	else
+		en = false;
+
+	return regmap_update_bits(data->regmap, ADXL313_REG_INT_ENABLE,
+				  adxl313_act_int_reg[type],
+				  en ? adxl313_act_int_reg[type] : 0);
+}
+
 static int adxl313_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
@@ -374,6 +468,113 @@ static int adxl313_write_raw(struct iio_dev *indio_dev,
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
@@ -505,10 +706,22 @@ static int adxl313_fifo_push(struct iio_dev *indio_dev, int samples)
 
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
@@ -555,6 +768,10 @@ static int adxl313_reg_access(struct iio_dev *indio_dev, unsigned int reg,
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
@@ -665,6 +882,19 @@ int adxl313_core_probe(struct device *dev,
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
 		ret  = devm_iio_kfifo_buffer_setup(dev, indio_dev,
 						   &adxl313_buffer_ops);
 		if (ret)
-- 
2.39.5


