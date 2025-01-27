Return-Path: <linux-iio+bounces-14611-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B1AA1D7B3
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 15:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84191662D2
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 14:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE6B200112;
	Mon, 27 Jan 2025 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iv7wyLvG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C89A6FC5
	for <linux-iio@vger.kernel.org>; Mon, 27 Jan 2025 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737986697; cv=none; b=EIbivDyMs31XT87lPEUziLIBC6K+zKM7S9Oi2AQbtu2RSL6mHxNr1cpcxWiq+nlVbMGzCt6qJYSwYy8N1Z2NlsmZIiJZrpMks2d8kyqfHDz5zsbEDsZ2rLLL71uXEjjYSSlDPRi0p0RJUEvfqy3U5jgEkcNcIKdQ9MLnp4IJfnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737986697; c=relaxed/simple;
	bh=tv8ufJNX2FveIIM0Ullgh4WcbgMO2rH4hcs0LieA+jQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XFKQnaRx0DSQxssoOufzbDTepOAOyeVvltNQ+K53LJh6y36CLHoFIOA135ODgbPaW3f5pd+MPnB41tJFaXWz3vjnUwTopCCFTixsbAbyeScKWeSYgYWLztnVLtQkeVJJHBW/u+Z7IJch3VaE0D/9II6cL9GiwjWxUrgAsmbjwso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iv7wyLvG; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385d7f19f20so2287657f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Jan 2025 06:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737986693; x=1738591493; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qY0uFd4cFOzopA1OWUs9gFHikn9daeVfoWLrhNqrq8o=;
        b=iv7wyLvGyEzX4P8aXy9usbIXueAUhsXbtiNEnWVhIL83/FuGYucz0hnatAjcKJhvue
         3d5aGnqz+6OSOYbiM42fhnJ8Y/hUov8PnBwcCTFujjnq2Y49uxtTJunhHxZ62fPgnzPz
         6A9yn3v5WT6j5OI9OiJXySlYo2BA3bcX/o3IQOiAWFUrnbzZxLtcPR+gwt5FX3xZilnI
         IG+nAS0onO4h56e1HIl0z1XrYv+HiufPSPn2Dzg4vaIHqSQtqrsPtRgNSZCEwsUPTB2T
         gZSF6y6ZvPBYnCbQj9JeOQbFs3aTQdHLtYpAxi8VE6rPKn49CR+a0sA482ic/MO55NOu
         b9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737986693; x=1738591493;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qY0uFd4cFOzopA1OWUs9gFHikn9daeVfoWLrhNqrq8o=;
        b=iD5ywkgVQJE8BnG/+/QSLmAm+q3VCYmcY3/bOhkZnbsBwyFlNY4FGePVgA08RxJyui
         dS0JrDWPNIxYkq2bj2DnCZ+KvzrTl77pxAAji/RUC4Rj6dYexHCPpw8oJqrqu8kiSAf9
         cYUV88Boj4Oqeh3ZcAm/fw9wE6/38/tSfoOnsAYKws8J04hJNEjv/jq89SfUmxiUFcft
         IlqlMcpbPudHunwJ+3gxS5fy0Bgy7j+b9ptHU4bBr37m6GzqFb6pEzywGVmzgLvFmvkT
         BOebBDbkP4hRUtdsv2bsOaLnsYP/vk43D9iyqhxGaJQSSohWbRBAafeXwszi6goz4lXz
         UUCQ==
X-Gm-Message-State: AOJu0YwcgEGPzFaymiiWqDa9Vpg613ktg3icrWWi0y9ED62sgkxjMoGM
	UOCv+58ALf8BhwiA1dFYQNtYbGfFH+PKpcJaGuNZnVrYjQHi1Ft7BtKTRYKWfkU=
X-Gm-Gg: ASbGncuoWSqUHZYNse055lWq8vMdfIVcQVfg+yuyf8RfaRemYE4KhB03NRXZXmO/gBs
	cfNn578gOck91/mZdeXqcoKBOmDmfwfmq0VB2g0ZLXg+WCBovvCVYQZ/C6uVJAsBTaVc7ir03Sn
	pvNOrv4h7mMVyqHcgAy543hFBUy9OnGZPsszm6hd/9Je7uHfvOQpqv2D5ED1P+wNoiKrTlmWvkj
	32+HQVP/gC99pC5Ga01tg0R9+gWadbAd0C9tncZNIvirWkYPOR83kGe94iHVvdikttPBuvU8ap6
	YGSDvPnRxVKNLG9zvUbxWmVzeMFteVvcOkf+uKwHvJ1kXDozb/4=
X-Google-Smtp-Source: AGHT+IGLm1hJ1mW9caGceHze6AjMdQ/MxMJ2NJ1GV9e265lvP/Q/g7qOxf8xZbW2WZh7iYDigEbsHg==
X-Received: by 2002:a05:6000:1b82:b0:385:e3b8:f331 with SMTP id ffacd0b85a97d-38bf5663bd7mr29768565f8f.14.1737986692513;
        Mon, 27 Jan 2025 06:04:52 -0800 (PST)
Received: from [127.0.0.1] (alille-653-1-300-114.w90-1.abo.wanadoo.fr. [90.1.180.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a313383sm11480639f8f.36.2025.01.27.06.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 06:04:51 -0800 (PST)
From: Guillaume Ranquet <granquet@baylibre.com>
Date: Mon, 27 Jan 2025 14:59:33 +0100
Subject: [PATCH v5 2/2] iio: adc: ad7173: add openwire detection support
 for single conversions
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250127-ad4111_openwire-v5-2-ef2db05c384f@baylibre.com>
References: <20250127-ad4111_openwire-v5-0-ef2db05c384f@baylibre.com>
In-Reply-To: <20250127-ad4111_openwire-v5-0-ef2db05c384f@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guillaume Ranquet <granquet@baylibre.com>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.15-dev

Some chips of the ad7173 family supports open wire detection.

Generate a level fault event whenever an external source is disconnected
from the system input on single conversions.

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 drivers/iio/adc/ad7173.c | 179 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 179 insertions(+)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 8b438c689594..1855929b23d0 100644
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
@@ -182,11 +185,15 @@ struct ad7173_device_info {
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
 
@@ -203,6 +210,7 @@ struct ad7173_channel {
 	unsigned int ain;
 	struct ad7173_channel_config cfg;
 	u8 syscalib_mode;
+	bool openwire_det_en;
 };
 
 struct ad7173_state {
@@ -394,6 +402,76 @@ static int ad7173_calibrate_all(struct ad7173_state *st, struct iio_dev *indio_d
 	return 0;
 }
 
+/*
+ * Associative array of channel pairs for open wire detection
+ * The array is indexed by ain and gives the associated channel pair
+ * to perform the open wire detection with
+ * the channel pair [0] is for non differential and pair [1]
+ * is for differential inputs
+ */
+static int openwire_ain_to_channel_pair[][2][2] = {
+/*	AIN     Single    Differential */
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
+/*
+ * Openwire detection on ad4111 works by running the same input measurement
+ * on two different channels and compare if the difference between the two
+ * measurements exceeds a certain value (typical 300mV)
+ */
+static int ad4111_openwire_event(struct iio_dev *indio_dev,
+				 const struct iio_chan_spec *chan)
+{
+	struct ad7173_state *st = iio_priv(indio_dev);
+	struct ad7173_channel *adchan = &st->channels[chan->address];
+	struct ad7173_channel_config *cfg = &adchan->cfg;
+	int ret, val1, val2;
+
+	ret = regmap_set_bits(st->reg_gpiocon_regmap, AD7173_REG_GPIO,
+			      AD4111_GPIO_GP_OW_EN);
+	if (ret)
+		return ret;
+
+	adchan->cfg.openwire_comp_chan =
+		openwire_ain_to_channel_pair[chan->channel][chan->differential][0];
+
+	ret = ad_sigma_delta_single_conversion(indio_dev, chan, &val1);
+	if (ret < 0) {
+		dev_err(&indio_dev->dev,
+			"Error running ad_sigma_delta single conversion: %d", ret);
+		goto out;
+	}
+
+	adchan->cfg.openwire_comp_chan =
+		openwire_ain_to_channel_pair[chan->channel][chan->differential][1];
+
+	ret = ad_sigma_delta_single_conversion(indio_dev, chan, &val2);
+	if (ret < 0) {
+		dev_err(&indio_dev->dev,
+			"Error running ad_sigma_delta single conversion: %d", ret);
+		goto out;
+	}
+
+	if (abs(val1 - val2) > cfg->openwire_thrsh_raw)
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, chan->address,
+						    IIO_EV_TYPE_FAULT, IIO_EV_DIR_FAULT_OPENWIRE),
+			       iio_get_time_ns(indio_dev));
+
+out:
+	adchan->cfg.openwire_comp_chan = -1;
+	regmap_clear_bits(st->reg_gpiocon_regmap, AD7173_REG_GPIO,
+			  AD4111_GPIO_GP_OW_EN);
+	return ret;
+}
+
 static int ad7173_mask_xlate(struct gpio_regmap *gpio, unsigned int base,
 			     unsigned int offset, unsigned int *reg,
 			     unsigned int *mask)
@@ -591,6 +669,9 @@ static int ad7173_set_channel(struct ad_sigma_delta *sd, unsigned int channel)
 	      FIELD_PREP(AD7173_CH_SETUP_SEL_MASK, st->channels[channel].cfg.cfg_slot) |
 	      st->channels[channel].ain;
 
+	if (st->channels[channel].cfg.openwire_comp_chan >= 0)
+		channel = st->channels[channel].cfg.openwire_comp_chan;
+
 	return ad_sd_write_reg(&st->sd, AD7173_REG_CH(channel), 2, val);
 }
 
@@ -639,6 +720,11 @@ static int ad7173_disable_all(struct ad_sigma_delta *sd)
 
 static int ad7173_disable_one(struct ad_sigma_delta *sd, unsigned int chan)
 {
+	struct ad7173_state *st = ad_sigma_delta_to_ad7173(sd);
+
+	if (st->channels[chan].cfg.openwire_comp_chan >= 0)
+		chan = st->channels[chan].cfg.openwire_comp_chan;
+
 	return ad_sd_write_reg(sd, AD7173_REG_CH(chan), 2, 0);
 }
 
@@ -690,6 +776,7 @@ static const struct ad7173_device_info ad4111_device_info = {
 	.has_current_inputs = true,
 	.has_int_ref = true,
 	.has_internal_fs_calibration = true,
+	.has_openwire_det = true,
 	.clock = 2 * HZ_PER_MHZ,
 	.sinc5_data_rates = ad7173_sinc5_data_rates,
 	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
@@ -1000,6 +1087,12 @@ static int ad7173_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
+		if (ch->openwire_det_en) {
+			ret = ad4111_openwire_event(indio_dev, chan);
+			if (ret < 0)
+				return ret;
+		}
+
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 
@@ -1144,12 +1237,57 @@ static int ad7173_debug_reg_access(struct iio_dev *indio_dev, unsigned int reg,
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
+	switch (type) {
+	case IIO_EV_TYPE_FAULT:
+		adchan->openwire_det_en = state;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad7173_read_event_config(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir)
+{
+	struct ad7173_state *st = iio_priv(indio_dev);
+	struct ad7173_channel *adchan = &st->channels[chan->address];
+
+	switch (type) {
+	case IIO_EV_TYPE_FAULT:
+		return adchan->openwire_det_en;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_event_spec ad4111_events[] = {
+	{
+		.type = IIO_EV_TYPE_FAULT,
+		.dir = IIO_EV_DIR_FAULT_OPENWIRE,
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
+	.read_event_config = ad7173_read_event_config,
 };
 
 static const struct iio_scan_type ad4113_scan_type = {
@@ -1353,6 +1491,37 @@ static int ad7173_validate_reference(struct ad7173_state *st, int ref_sel)
 	return 0;
 }
 
+static int ad7173_validate_openwire_ain_inputs(struct ad7173_state *st,
+					       bool differential,
+					       unsigned int ain0,
+					       unsigned int ain1)
+{
+	/*
+	 * If the channel is configured as differential,
+	 * the ad4111 requires specific ains to be used together
+	 */
+	if (differential)
+		return (ain0 % 2) ? (ain0 - 1) == ain1 : (ain0 + 1) == ain1;
+
+	return ain1 == AD4111_VINCOM_INPUT;
+}
+
+static unsigned int ad7173_calc_openwire_thrsh_raw(struct ad7173_state *st,
+						   struct iio_chan_spec *chan,
+						   struct ad7173_channel *chan_st_priv,
+						   unsigned int thrsh_mv) {
+	unsigned int thrsh_raw;
+
+	thrsh_raw =
+		BIT(chan->scan_type.realbits - !!(chan_st_priv->cfg.bipolar))
+		* thrsh_mv
+		/ ad7173_get_ref_voltage_milli(st, chan_st_priv->cfg.ref_sel);
+	if (chan->channel < st->info->num_voltage_in_div)
+		thrsh_raw /= AD4111_DIVIDER_RATIO;
+
+	return thrsh_raw;
+}
+
 static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 {
 	struct ad7173_channel *chans_st_arr, *chan_st_priv;
@@ -1400,6 +1569,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		chan_st_priv->cfg.bipolar = false;
 		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
 		chan_st_priv->cfg.ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
+		chan_st_priv->cfg.openwire_comp_chan = -1;
 		st->adc_mode |= AD7173_ADC_MODE_REF_EN;
 		if (st->info->data_reg_only_16bit)
 			chan_arr[chan_index].scan_type = ad4113_scan_type;
@@ -1466,6 +1636,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		chan->channel = ain[0];
 		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
 		chan_st_priv->cfg.odr = 0;
+		chan_st_priv->cfg.openwire_comp_chan = -1;
 
 		chan_st_priv->cfg.bipolar = fwnode_property_read_bool(child, "bipolar");
 		if (chan_st_priv->cfg.bipolar)
@@ -1480,6 +1651,14 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 			chan_st_priv->cfg.input_buf = st->info->has_input_buf;
 			chan->channel2 = ain[1];
 			chan_st_priv->ain = AD7173_CH_ADDRESS(ain[0], ain[1]);
+			if (st->info->has_openwire_det &&
+			    ad7173_validate_openwire_ain_inputs(st, chan->differential, ain[0], ain[1])) {
+				chan->event_spec = ad4111_events;
+				chan->num_event_specs = ARRAY_SIZE(ad4111_events);
+				chan_st_priv->cfg.openwire_thrsh_raw =
+					ad7173_calc_openwire_thrsh_raw(st, chan, chan_st_priv,
+								       AD4111_OW_DET_THRSH_MV);
+			}
 		}
 
 		if (st->info->data_reg_only_16bit)

-- 
2.47.1


