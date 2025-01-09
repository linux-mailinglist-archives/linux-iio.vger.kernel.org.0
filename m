Return-Path: <linux-iio+bounces-14058-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7399DA0785F
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2025 15:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 602787A29DB
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2025 14:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D78218AC3;
	Thu,  9 Jan 2025 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JUYhGoi5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F4021A443
	for <linux-iio@vger.kernel.org>; Thu,  9 Jan 2025 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736431227; cv=none; b=k9MGkbRLRyxyusDqo+0KHeR2ulX9Y0u0BX8usIrxvs6BRMvWrB2wU59zNBd1MQnAnMGz+Zuz/zwZt8m/BkfCqNzcx8lgIhjA1SejDdcruiAA0y/VsNmBJA/+fHn9mbw07XRbZiLPCOMGzqvT9mi5UkSERTbbumRiPGQfWf3HdkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736431227; c=relaxed/simple;
	bh=jwTFQXQabCqYHpttFWrIC+mVkgc5ukvNNAgINPJHF9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s+eTW5zGOubW0Ki1XyUqShUAB1dDg6lZBGdN+Jk2R3NAyWXjJNobIOjsi+7OkSaZT9zDlWCgMSXp23276D0up5iR5SuuwCsnf/w2e2uo8SQeb3Iv/QexuL34ix9zivLPPIh8X8qVp3c3C9wuJEjaEh7yMY0hbv5U3rKz5eDukJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JUYhGoi5; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38789e5b6a7so525275f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 09 Jan 2025 06:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736431223; x=1737036023; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zIh5E1JEl/cQObfFwfvjq9ag94VKLf/1HcFgYeQO0Rg=;
        b=JUYhGoi5QYwvH12oMPcp3x4FgNAzFnl6kZt4jdezat2x6t4/d6XnGVrvRZe0yi+ZsR
         gPXpXrcg291ovWa6RbUIomF3neR+RB9JfXRO0gmeQIuEJIYTy46/TVtD2u1Pe83DtFrL
         6jGla3Hb87tVGEX8Ok1g4zjkyDod3zinRLDW43jz1sb3qx0ySeQel6FNMK4JTWuC3F5p
         qDemj24V3zUfyC3gIzO0gf+kzmjOEIBbH/MiJ9doJIM/KfUjG+Fpsu1WvFAlg08yNspU
         4GPscX5UkrKslVb5X//sCVEPxv0fawHQSo24euOJjOAL4vB9zvN9ZhpLJ+yj60F867P5
         Kn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736431223; x=1737036023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zIh5E1JEl/cQObfFwfvjq9ag94VKLf/1HcFgYeQO0Rg=;
        b=YrjvWAyvgmKviglfhW2CHpxWAp7o8HdQPg7Y6n/mmQcrrmvIivLZeF4RhDfNkmtgap
         YkUdc7zVgubfcuePE9OP8lEpVG5oZQZFdv2f+RRlRnyVV3+Lq169pPWlHpBe0UFVEMAG
         yP6jV+jpLJhwzmZFXy03TajYqXwA4E6ZkUFHA1wIU2UCjnPOmEv/g5XoqpFJYOV4L3lR
         UDt37NDsI/XIJgX9rEz0vYZt5OYlLlgIiKdMOPaumFjP/5oSCmeG1PuvMeLTzydMmb4P
         XP4KuraJKqkU2BklUK3Wdu97DCF7TfHfkRxzob9XqFSFOC8myoH0jA+IaQNlMZ0Fahdw
         szmQ==
X-Gm-Message-State: AOJu0Yx+TRuyVEeK79YSYHOMRRkasW8y02l+34BwDUS5cPCnBDKnS4nn
	7Wl9cSma1SiPTjrY3v8ul+gxfS+j/+q03ela7rosJCYYIdlMd514wxuGLi7O2Uk=
X-Gm-Gg: ASbGncvdhthkZ9P5UGRtqAxNKV45juk6zF680G/QdoizBVELwGdGGQFlrJvO3FN/6v1
	o+Nwqg2qE3IT6g7Km1pVlP3JX+bIHmFEEALASMhxVR5aDFBxyFrKzujrShnxJLQTnl9DxjSZlm0
	ruXK5mNhmyIJjLUp81Wq1/Cvr/QT4n0us6p0u6qt/v+PeENqM2r1jz3W2ruJqsTY6VLYoEqoHKQ
	OAi/VGjhpwjmNUV0NekIi52FG4jZ13mWr/uI6RAxG19eGsrPFdqbBSkgQ==
X-Google-Smtp-Source: AGHT+IFiyKeG0570sWHXTmCTdWFufaQEF0acYJIej/OrAxyzxDdgjcCl9B6TD7+A1BwENDgfGek30w==
X-Received: by 2002:a05:6000:1fa1:b0:385:ed20:3be2 with SMTP id ffacd0b85a97d-38a87355790mr6097527f8f.48.1736431223105;
        Thu, 09 Jan 2025 06:00:23 -0800 (PST)
Received: from [127.0.0.1] ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38325esm1901507f8f.27.2025.01.09.06.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 06:00:22 -0800 (PST)
From: Guillaume Ranquet <granquet@baylibre.com>
Date: Thu, 09 Jan 2025 14:55:18 +0100
Subject: [PATCH RFC v2 2/2] iio: adc: ad7173: add openwire detection
 support for single conversions
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-ad4111_openwire-v2-2-0372c2dde0ce@baylibre.com>
References: <20250109-ad4111_openwire-v2-0-0372c2dde0ce@baylibre.com>
In-Reply-To: <20250109-ad4111_openwire-v2-0-0372c2dde0ce@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guillaume Ranquet <granquet@baylibre.com>
X-Mailer: b4 0.15-dev

Some chips of the ad7173 family supports open wire detection.

Generate a threshold event whenever an external source is disconnected
from the system input on single conversions.

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 drivers/iio/adc/ad7173.c | 164 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 11ff148cb5a315d32485acf04b8d6f7d0fb6e5fa..2f1b506c439249462b9740ff69e7553a37c45943 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -35,6 +35,7 @@
 #include <linux/units.h>
 
 #include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
@@ -102,6 +103,7 @@
 
 #define AD7173_GPIO_PDSW	BIT(14)
 #define AD7173_GPIO_OP_EN2_3	BIT(13)
+#define AD4111_GPIO_GP_OW_EN	BIT(12)
 #define AD7173_GPIO_MUX_IO	BIT(12)
 #define AD7173_GPIO_SYNC_EN	BIT(11)
 #define AD7173_GPIO_ERR_EN	BIT(10)
@@ -149,6 +151,7 @@
 
 #define AD7173_FILTER_ODR0_MASK		GENMASK(5, 0)
 #define AD7173_MAX_CONFIGS		8
+#define AD4111_OW_DET_THRSH_MV		300
 
 #define AD7173_MODE_CAL_INT_ZERO		0x4 /* Internal Zero-Scale Calibration */
 #define AD7173_MODE_CAL_INT_FULL		0x5 /* Internal Full-Scale Calibration */
@@ -181,11 +184,15 @@ struct ad7173_device_info {
 	bool has_int_ref;
 	bool has_ref2;
 	bool has_internal_fs_calibration;
+	bool has_openwire_det;
 	bool higher_gpio_bits;
 	u8 num_gpios;
 };
 
 struct ad7173_channel_config {
+	/* Openwire detection threshold */
+	unsigned int openwire_thrsh_raw;
+	int openwire_comp_chan;
 	u8 cfg_slot;
 	bool live;
 
@@ -202,6 +209,7 @@ struct ad7173_channel {
 	unsigned int chan_reg;
 	unsigned int ain;
 	struct ad7173_channel_config cfg;
+	bool openwire_det_en;
 };
 
 struct ad7173_state {
@@ -280,6 +288,7 @@ static const struct ad7173_device_info ad4111_device_info = {
 	.has_current_inputs = true,
 	.has_int_ref = true,
 	.has_internal_fs_calibration = true,
+	.has_openwire_det = true,
 	.clock = 2 * HZ_PER_MHZ,
 	.sinc5_data_rates = ad7173_sinc5_data_rates,
 	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
@@ -616,6 +625,69 @@ static int ad7173_calibrate_all(struct ad7173_state *st, struct iio_dev *indio_d
 	return 0;
 }
 
+/* Associative array of channel pairs for openwire detection
+ * The array is indexed by ain and gives the associated channel pair
+ * to perform the openwire detection with
+ * the channel pair [0] is for non differential and pair [1]
+ * is for differential inputs
+ */
+static int openwire_ain_to_channel_pair[][2][2] = {
+	[0] = { {0, 15},  {1, 2}   },
+	[1] = { {1, 2},   {2, 1}   },
+	[2] = { {3, 4},   {5, 6}   },
+	[3] = { {5, 6},   {6, 5}   },
+	[4] = { {7, 8},   {9, 10}  },
+	[5] = { {9, 10},  {10, 9}  },
+	[6] = { {11, 12}, {13, 14} },
+	[7] = { {13, 14}, {14, 13} },
+};
+
+/* Openwire detection on ad4111 works by running the same input measurement
+ * on two different channels and compare if the difference between the two
+ * measurements exceeds a certain value (typical 300mV)
+ */
+static void ad4111_openwire_event(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan)
+{
+	struct ad7173_state *st = iio_priv(indio_dev);
+	struct ad7173_channel *adchan = &st->channels[chan->address];
+	struct ad7173_channel_config *cfg = &adchan->cfg;
+	int ret, val1, val2;
+
+	ret = regmap_set_bits(st->reg_gpiocon_regmap, AD7173_REG_GPIO, AD4111_GPIO_GP_OW_EN);
+	if (ret)
+		return;
+
+	adchan->cfg.openwire_comp_chan =
+		openwire_ain_to_channel_pair[chan->channel][chan->differential][0];
+
+	ret = ad_sigma_delta_single_conversion(indio_dev, chan, &val1);
+	if (ret < 0)
+		goto out;
+
+	adchan->cfg.openwire_comp_chan =
+		openwire_ain_to_channel_pair[chan->channel][chan->differential][1];
+
+	ret = ad_sigma_delta_single_conversion(indio_dev, chan, &val2);
+	if (ret < 0)
+		goto out;
+
+	if (abs(val1 - val2) > cfg->openwire_thrsh_raw)
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, chan->address,
+						    IIO_EV_TYPE_OPENWIRE, IIO_EV_DIR_RISING),
+			       iio_get_time_ns(indio_dev));
+	else
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, chan->address,
+						    IIO_EV_TYPE_OPENWIRE, IIO_EV_DIR_FALLING),
+			       iio_get_time_ns(indio_dev));
+
+out:
+	adchan->cfg.openwire_comp_chan = -1;
+	regmap_clear_bits(st->reg_gpiocon_regmap, AD7173_REG_GPIO, AD4111_GPIO_GP_OW_EN);
+}
+
 static int ad7173_mask_xlate(struct gpio_regmap *gpio, unsigned int base,
 			     unsigned int offset, unsigned int *reg,
 			     unsigned int *mask)
@@ -813,6 +885,9 @@ static int ad7173_set_channel(struct ad_sigma_delta *sd, unsigned int channel)
 	      FIELD_PREP(AD7173_CH_SETUP_SEL_MASK, st->channels[channel].cfg.cfg_slot) |
 	      st->channels[channel].ain;
 
+	if (st->channels[channel].cfg.openwire_comp_chan >= 0)
+		channel = st->channels[channel].cfg.openwire_comp_chan;
+
 	return ad_sd_write_reg(&st->sd, AD7173_REG_CH(channel), 2, val);
 }
 
@@ -861,6 +936,11 @@ static int ad7173_disable_all(struct ad_sigma_delta *sd)
 
 static int ad7173_disable_one(struct ad_sigma_delta *sd, unsigned int chan)
 {
+	struct ad7173_state *st = ad_sigma_delta_to_ad7173(sd);
+
+	if (st->channels[chan].cfg.openwire_comp_chan >= 0)
+		chan = st->channels[chan].cfg.openwire_comp_chan;
+
 	return ad_sd_write_reg(sd, AD7173_REG_CH(chan), 2, 0);
 }
 
@@ -968,6 +1048,9 @@ static int ad7173_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
+		if (ch->openwire_det_en)
+			ad4111_openwire_event(indio_dev, chan);
+
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 
@@ -1112,12 +1195,71 @@ static int ad7173_debug_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 	return ad_sd_write_reg(&st->sd, reg, reg_size, writeval);
 }
 
+static int ad7173_write_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     bool state)
+{
+	struct ad7173_state *st = iio_priv(indio_dev);
+	struct ad7173_channel *adchan = &st->channels[chan->address];
+
+	adchan->openwire_det_en = state;
+
+	return 0;
+}
+
+static int ad7173_write_event_value(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
+				    enum iio_event_type type, enum iio_event_direction dir,
+				    enum iio_event_info info, int val, int val2)
+{
+	struct ad7173_state *st = iio_priv(indio_dev);
+	struct ad7173_channel *adchan = &st->channels[chan->address];
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		adchan->cfg.openwire_thrsh_raw = val;
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad7173_read_event_value(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
+				   enum iio_event_type type, enum iio_event_direction dir,
+				   enum iio_event_info info, int *val, int *val2)
+{
+	struct ad7173_state *st = iio_priv(indio_dev);
+	struct ad7173_channel *adchan = &st->channels[chan->address];
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		*val = adchan->cfg.openwire_thrsh_raw;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_event_spec ad4111_events[] = {
+	{
+		.type = IIO_EV_TYPE_OPENWIRE,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+		.mask_shared_by_all = BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
 static const struct iio_info ad7173_info = {
 	.read_raw = &ad7173_read_raw,
 	.write_raw = &ad7173_write_raw,
 	.debugfs_reg_access = &ad7173_debug_reg_access,
 	.validate_trigger = ad_sd_validate_trigger,
 	.update_scan_mode = ad7173_update_scan_mode,
+	.write_event_config = ad7173_write_event_config,
+	.write_event_value = ad7173_write_event_value,
+	.read_event_value = ad7173_read_event_value,
 };
 
 static const struct iio_scan_type ad4113_scan_type = {
@@ -1321,6 +1463,15 @@ static int ad7173_validate_reference(struct ad7173_state *st, int ref_sel)
 	return 0;
 }
 
+static int ad7173_validate_openwire_ain_inputs(struct ad7173_state *st, bool differential,
+					       unsigned int ain0, unsigned int ain1)
+{
+	if (differential)
+		return (ain0 % 2) ? (ain0 - 1) == ain1 : (ain0 + 1) == ain1;
+
+	return ain1 == AD4111_VINCOM_INPUT;
+}
+
 static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 {
 	struct ad7173_channel *chans_st_arr, *chan_st_priv;
@@ -1375,6 +1526,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		chan_st_priv->cfg.bipolar = false;
 		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
 		chan_st_priv->cfg.ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
+		chan_st_priv->cfg.openwire_comp_chan = -1;
 		st->adc_mode |= AD7173_ADC_MODE_REF_EN;
 		if (st->info->data_reg_only_16bit)
 			chan_arr[chan_index].scan_type = ad4113_scan_type;
@@ -1442,6 +1594,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		chan_st_priv->chan_reg = chan_index;
 		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
 		chan_st_priv->cfg.odr = 0;
+		chan_st_priv->cfg.openwire_comp_chan = -1;
 
 		chan_st_priv->cfg.bipolar = fwnode_property_read_bool(child, "bipolar");
 		if (chan_st_priv->cfg.bipolar)
@@ -1456,6 +1609,17 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 			chan_st_priv->cfg.input_buf = st->info->has_input_buf;
 			chan->channel2 = ain[1];
 			chan_st_priv->ain = AD7173_CH_ADDRESS(ain[0], ain[1]);
+			if (st->info->has_openwire_det &&
+			    ad7173_validate_openwire_ain_inputs(st, chan->differential, ain[0], ain[1])) {
+				chan->event_spec = ad4111_events;
+				chan->num_event_specs = ARRAY_SIZE(ad4111_events);
+				chan_st_priv->cfg.openwire_thrsh_raw =
+					BIT(chan->scan_type.realbits - !!(chan_st_priv->cfg.bipolar))
+					* AD4111_OW_DET_THRSH_MV
+					/ ad7173_get_ref_voltage_milli(st, chan_st_priv->cfg.ref_sel);
+				if (chan->channel < st->info->num_voltage_in_div)
+					chan_st_priv->cfg.openwire_thrsh_raw /= AD4111_DIVIDER_RATIO;
+			}
 		}
 
 		if (st->info->data_reg_only_16bit)

-- 
2.47.1


