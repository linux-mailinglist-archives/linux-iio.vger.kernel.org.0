Return-Path: <linux-iio+bounces-12728-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337A79DA482
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 10:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7C5128588C
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 09:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A3B1917E4;
	Wed, 27 Nov 2024 09:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="stI6/Kn4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D498188A0D
	for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2024 09:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732698657; cv=none; b=TcZFdhNA1f+EE7UrWDKTFEPyG+QHIERb3RuApFRWTBg0db/l3MLhJGJE4tNXLHpD0vQ3BuqJv64LbOZIekdNxov6bfUmSLB1KGdeupI+7WsVsLfrsYvQzEwTRCscu/5HrpPF5knhs0A/1B5bqkvUCi/UYwCWFe88P69GycDiF1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732698657; c=relaxed/simple;
	bh=mGChwpwq5YT7BF+pvadT8OA4CAgJuJsktPYP5RjTzOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GstT9kOGUhLYverFdAF6J1GewcEa7ZJ9tVqttniPHB4n7nGi464EqC2BkZh5ngvxUmkeF9FCBSAVxeQ/rigImdCNS6VGqwecenbuHdB0UzIQWpnXAKLo/WSFlNavgunkOa4BIsgQhDGvLPp/4nJU8DsHLjOC3mK+8dyW9eQuBro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=stI6/Kn4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434ab938e37so1423345e9.0
        for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2024 01:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732698653; x=1733303453; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8PZCJ1UvScuEOpB5rRFdFq+kujaPZNgC8slKMTXTueo=;
        b=stI6/Kn40BeZXOOa3tqx3KZ88msdTna1OZwU/G5cSOEVZ3WXfGEB4vD98zfIkEVwe+
         Tpyi+ANCeBUxGkpdnk6AicsbvBy+RfkjikQaX8mbF82eV/lH5rHLx54j3QpPTzr65UGV
         q2yLQnCbkpW8zPA9b3mFxWf57NM23Os5VpYv+ZG4RD4rXf8NAtLZwBl5oTSkhhwpkz//
         CTi6OPVsps97wonHI4VQIGNa695BxkPNDrrPIVOKcHVlgsSaTb4GcrH2LS9b5vLkE8+W
         9UtqIhgXciEAMUmVDnNggzX3fyAyeJ+ubqXOWvsapnuQIvDlPtUyR4DkE0nHiq6yO3HD
         IEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732698653; x=1733303453;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PZCJ1UvScuEOpB5rRFdFq+kujaPZNgC8slKMTXTueo=;
        b=Aq+xgYjtNlfV0G303qXrsgVtuaKVA+06QadEug6VX7ffDY8b5NiQKOk6EYCzzUF3rv
         vk/WZbozRnlmoCBFJVpVyFwPlrqlQWomAA/rU8OujWEZ4f4lMw6exnpeDZ6jCzbVYCNT
         9khHUYPv/1zaDWbpvnDD0h3oQzijOl1DCVRgTcsFQ1e4e3ZhkEfhx9fRFcqMmHK6RFkK
         7/ZV//NZxvgepUhwOdTe1J4tgzzLisyjNvf+T72WmJrI+nMi02kksp1wy6tEbsEnWpvq
         uqInEso2PKGCd64hOUyqp/BDe4lfvrQhqzLZulxRuN9oo4EXcmANZ8Fnydb/SitLTQJp
         Wwkw==
X-Gm-Message-State: AOJu0Yxq2JizjuNhusTGpH+PttXj7dCIk0A5zhSTyh7Cc17Unez5IWNw
	UiLpElUYPWc8064neXHlFcEODq60zVbrsXyEykmS7draAz5H5Iy60Rq+fyphiIo=
X-Gm-Gg: ASbGncukEju3SZx9rXBFErzbBAAxxTWe6EXjzEoWTGpwQi0ZU7N/drUdu2J1Y0cQ/LF
	wLf+OrrgplcHUCEA1BQupotLm6DdBJE/6K00gItmB+P5JhTrvlL1SU+AoyII8p+pZq3DoYGZCRC
	dDDb0jyW2/hCei3NnFHxjSuddbfyDo3KVAgh57BtyY/5vf0lqvSxWWYd8izzKk2j2IAPoB/7BKL
	aH7a9u8hHib1olRvZVfm4Dl7olOqQllXRvJ8HqTeX2/QY5AOynKkOJ5sSCPAMZhk45lE5AiozM3
	b0f/fUXir642vHJDhsPT
X-Google-Smtp-Source: AGHT+IHASFmt/+tSp+MB23odNNjU/BnjXn6PxrJ0jWKW916Rej4TxNyf5heOhcFoJD0mQihGOTYsmA==
X-Received: by 2002:a05:600c:3b1a:b0:434:a968:89b5 with SMTP id 5b1f17b1804b1-434a9dc35f7mr19819365e9.9.1732698652838;
        Wed, 27 Nov 2024 01:10:52 -0800 (PST)
Received: from [127.0.0.1] (alille-653-1-300-114.w90-1.abo.wanadoo.fr. [90.1.180.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e5285sm14529415e9.40.2024.11.27.01.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 01:10:52 -0800 (PST)
From: Guillaume Ranquet <granquet@baylibre.com>
Date: Wed, 27 Nov 2024 10:06:13 +0100
Subject: [PATCH v2 1/2] iio: adc: ad7173: add calibration support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-ad411x_calibration-v2-1-66412dac35aa@baylibre.com>
References: <20241127-ad411x_calibration-v2-0-66412dac35aa@baylibre.com>
In-Reply-To: <20241127-ad411x_calibration-v2-0-66412dac35aa@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guillaume Ranquet <granquet@baylibre.com>
X-Mailer: b4 0.15-dev

The ad7173 family of chips has up to four calibration modes.

Internal zero scale: removes ADC core offset errors.
Internal full scale: removes ADC core gain errors.
System zero scale: reduces offset error to the order of channel noise.
System full scale: reduces gain error to the order of channel noise.

All voltage channels will undergo an internal zero/full scale
calibration at bootup.

System zero/full scale can be done after bootup using the newly created
iio interface 'sys_calibration' and 'sys_calibration_mode'

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 drivers/iio/adc/ad7173.c | 123 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index a0fca16c3be07534547a5b914d525d05f7425340..11ff148cb5a315d32485acf04b8d6f7d0fb6e5fa 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -150,6 +150,11 @@
 #define AD7173_FILTER_ODR0_MASK		GENMASK(5, 0)
 #define AD7173_MAX_CONFIGS		8
 
+#define AD7173_MODE_CAL_INT_ZERO		0x4 /* Internal Zero-Scale Calibration */
+#define AD7173_MODE_CAL_INT_FULL		0x5 /* Internal Full-Scale Calibration */
+#define AD7173_MODE_CAL_SYS_ZERO		0x6 /* System Zero-Scale Calibration */
+#define AD7173_MODE_CAL_SYS_FULL		0x7 /* System Full-Scale Calibration */
+
 struct ad7173_device_info {
 	const unsigned int *sinc5_data_rates;
 	unsigned int num_sinc5_data_rates;
@@ -175,6 +180,7 @@ struct ad7173_device_info {
 	bool has_input_buf;
 	bool has_int_ref;
 	bool has_ref2;
+	bool has_internal_fs_calibration;
 	bool higher_gpio_bits;
 	u8 num_gpios;
 };
@@ -215,6 +221,7 @@ struct ad7173_state {
 	struct regmap *reg_gpiocon_regmap;
 	struct gpio_regmap *gpio_regmap;
 #endif
+	u8 *syscalib_mode;
 };
 
 static unsigned int ad4115_sinc5_data_rates[] = {
@@ -272,6 +279,7 @@ static const struct ad7173_device_info ad4111_device_info = {
 	.has_input_buf = true,
 	.has_current_inputs = true,
 	.has_int_ref = true,
+	.has_internal_fs_calibration = true,
 	.clock = 2 * HZ_PER_MHZ,
 	.sinc5_data_rates = ad7173_sinc5_data_rates,
 	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
@@ -291,6 +299,7 @@ static const struct ad7173_device_info ad4112_device_info = {
 	.has_input_buf = true,
 	.has_current_inputs = true,
 	.has_int_ref = true,
+	.has_internal_fs_calibration = true,
 	.clock = 2 * HZ_PER_MHZ,
 	.sinc5_data_rates = ad7173_sinc5_data_rates,
 	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
@@ -326,6 +335,7 @@ static const struct ad7173_device_info ad4114_device_info = {
 	.has_temp = true,
 	.has_input_buf = true,
 	.has_int_ref = true,
+	.has_internal_fs_calibration = true,
 	.clock = 2 * HZ_PER_MHZ,
 	.sinc5_data_rates = ad7173_sinc5_data_rates,
 	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
@@ -343,6 +353,7 @@ static const struct ad7173_device_info ad4115_device_info = {
 	.has_temp = true,
 	.has_input_buf = true,
 	.has_int_ref = true,
+	.has_internal_fs_calibration = true,
 	.clock = 8 * HZ_PER_MHZ,
 	.sinc5_data_rates = ad4115_sinc5_data_rates,
 	.num_sinc5_data_rates = ARRAY_SIZE(ad4115_sinc5_data_rates),
@@ -360,6 +371,7 @@ static const struct ad7173_device_info ad4116_device_info = {
 	.has_temp = true,
 	.has_input_buf = true,
 	.has_int_ref = true,
+	.has_internal_fs_calibration = true,
 	.clock = 4 * HZ_PER_MHZ,
 	.sinc5_data_rates = ad4116_sinc5_data_rates,
 	.num_sinc5_data_rates = ARRAY_SIZE(ad4116_sinc5_data_rates),
@@ -505,6 +517,105 @@ static const struct regmap_config ad7173_regmap_config = {
 	.read_flag_mask = BIT(6),
 };
 
+enum {
+	AD7173_SYSCALIB_ZERO_SCALE,
+	AD7173_SYSCALIB_FULL_SCALE,
+};
+
+static const char * const ad7173_syscalib_modes[] = {
+	[AD7173_SYSCALIB_ZERO_SCALE] = "zero_scale",
+	[AD7173_SYSCALIB_FULL_SCALE] = "full_scale",
+};
+
+static int ad7173_set_syscalib_mode(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    unsigned int mode)
+{
+	struct ad7173_state *st = iio_priv(indio_dev);
+
+	st->syscalib_mode[chan->channel] = mode;
+
+	return 0;
+}
+
+static int ad7173_get_syscalib_mode(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan)
+{
+	struct ad7173_state *st = iio_priv(indio_dev);
+
+	return st->syscalib_mode[chan->channel];
+}
+
+static ssize_t ad7173_write_syscalib(struct iio_dev *indio_dev,
+				     uintptr_t private,
+				     const struct iio_chan_spec *chan,
+				     const char *buf, size_t len)
+{
+	struct ad7173_state *st = iio_priv(indio_dev);
+	bool sys_calib;
+	int ret, mode;
+
+	ret = kstrtobool(buf, &sys_calib);
+	if (ret)
+		return ret;
+
+	mode = st->syscalib_mode[chan->channel];
+	if (sys_calib) {
+		if (mode == AD7173_SYSCALIB_ZERO_SCALE)
+			ret = ad_sd_calibrate(&st->sd, AD7173_MODE_CAL_SYS_ZERO,
+					      chan->address);
+		else
+			ret = ad_sd_calibrate(&st->sd, AD7173_MODE_CAL_SYS_FULL,
+					      chan->address);
+	}
+
+	return ret ? : len;
+}
+
+static const struct iio_enum ad7173_syscalib_mode_enum = {
+	.items = ad7173_syscalib_modes,
+	.num_items = ARRAY_SIZE(ad7173_syscalib_modes),
+	.set = ad7173_set_syscalib_mode,
+	.get = ad7173_get_syscalib_mode
+};
+
+static const struct iio_chan_spec_ext_info ad7173_calibsys_ext_info[] = {
+	{
+		.name = "sys_calibration",
+		.write = ad7173_write_syscalib,
+		.shared = IIO_SEPARATE,
+	},
+	IIO_ENUM("sys_calibration_mode", IIO_SEPARATE,
+		 &ad7173_syscalib_mode_enum),
+	IIO_ENUM_AVAILABLE("sys_calibration_mode", IIO_SHARED_BY_TYPE,
+			   &ad7173_syscalib_mode_enum),
+	{ }
+};
+
+static int ad7173_calibrate_all(struct ad7173_state *st, struct iio_dev *indio_dev)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < st->num_channels; i++) {
+		if (indio_dev->channels[i].type != IIO_VOLTAGE)
+			continue;
+
+		ret = ad_sd_calibrate(&st->sd, AD7173_MODE_CAL_INT_ZERO, st->channels[i].ain);
+		if (ret < 0)
+			return ret;
+
+		if (st->info->has_internal_fs_calibration) {
+			ret = ad_sd_calibrate(&st->sd, AD7173_MODE_CAL_INT_FULL,
+					      st->channels[i].ain);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int ad7173_mask_xlate(struct gpio_regmap *gpio, unsigned int base,
 			     unsigned int offset, unsigned int *reg,
 			     unsigned int *mask)
@@ -801,6 +912,10 @@ static int ad7173_setup(struct iio_dev *indio_dev)
 	if (!st->config_cnts)
 		return -ENOMEM;
 
+	ret = ad7173_calibrate_all(st, indio_dev);
+	if (ret)
+		return ret;
+
 	/* All channels are enabled by default after a reset */
 	return ad7173_disable_all(&st->sd);
 }
@@ -1023,6 +1138,7 @@ static const struct iio_chan_spec ad7173_channel_template = {
 		.storagebits = 32,
 		.endianness = IIO_BE,
 	},
+	.ext_info = ad7173_calibsys_ext_info,
 };
 
 static const struct iio_chan_spec ad7173_temp_iio_channel_template = {
@@ -1213,6 +1329,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 	struct iio_chan_spec *chan_arr, *chan;
 	unsigned int ain[AD7173_NO_AINS_PER_CHANNEL], chan_index = 0;
 	int ref_sel, ret, num_channels;
+	u8 *calib_mode;
 
 	num_channels = device_get_child_node_count(dev);
 
@@ -1240,8 +1357,14 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 	if (!chans_st_arr)
 		return -ENOMEM;
 
+	calib_mode = devm_kcalloc(dev, st->num_channels, sizeof(*st->syscalib_mode),
+				  GFP_KERNEL);
+	if (!calib_mode)
+		return -ENOMEM;
+
 	indio_dev->channels = chan_arr;
 	st->channels = chans_st_arr;
+	st->syscalib_mode = calib_mode;
 
 	if (st->info->has_temp) {
 		chan_arr[chan_index] = ad7173_temp_iio_channel_template;

-- 
2.47.0


