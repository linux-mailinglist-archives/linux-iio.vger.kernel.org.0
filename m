Return-Path: <linux-iio+bounces-12937-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E34E9DFE8C
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 11:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02FC8163A86
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 10:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738EA1FCCF4;
	Mon,  2 Dec 2024 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zYuWdesn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4071FC10E
	for <linux-iio@vger.kernel.org>; Mon,  2 Dec 2024 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733134472; cv=none; b=PY70xZ7Yo/Io7eGtWVAjkDFHBWHD5NeiNnnCdgt+9VEIOnAJwmbhCCPwhllDyUgmlkF2uo70YX6P0613xdCoKGVCtgR1ZOmMKAUxflwMxPb7KtaAYKdldcOz0BEtk33vWMxs44r0f9W0+JF45ka1CMtH77TFGkX3EwR0ehcPku8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733134472; c=relaxed/simple;
	bh=lxtQNPG7ecK6Iv4xprjHSTDP5kz4+CAaG6h4MbYJZwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tJqjSUBSHcQMA0IYNn0JX5l094HvFoDeGXXsz8z+OCRSqQfgB0RW5ozAsW3x6v8Xq2O3BnHhq2hwNnHTw3pfQ9ugfzxY+8zMkJwy+035XZ/uye5b6xRbqyukY8KrlgvDlOFA+u2abYVja3nFOzkkhqRfo68sIIgrqc7piBnbcLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zYuWdesn; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434a14d6bf4so36402115e9.1
        for <linux-iio@vger.kernel.org>; Mon, 02 Dec 2024 02:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733134468; x=1733739268; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C3sHijHsObcmuC5+B0nCO3Vf+v46fobTZzfGbKsmzqY=;
        b=zYuWdesn9Lcc9QTDd3FwO3o5mYT9tzQpJUMk3xEsvQFZIyQ4Go0OU1lTzeqQsj+GfJ
         rnoaYgJRVC9Vfe48ZtypMVps3K5T0Hvba1s9Fsnr3YjDzdql6og1HhY6iUHAR9vXyMoj
         zlr1PnxDaQODaUu7vHEWpjRFOdI8spP621aV+fn4NV8piqEB2ysJPAES65OrjgxM2DiP
         ta6cD7fhg9B+6iRh5ncz4Xa12/iz4qlJ9IvnZY+ZBTOa3/bK8B/xWrXmohwZlEJVdCgI
         ShvP4vhJgHkIZa1EzN9c/3LfSVooqO55Cn8Xn2dyZVCnxkuv8A2r2eaCtKiej4BxpLOh
         RiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733134468; x=1733739268;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3sHijHsObcmuC5+B0nCO3Vf+v46fobTZzfGbKsmzqY=;
        b=JG6a5hueSheMbGojAemMCDB6vPqJzBbN2xwVwJ+CAnEAlDTpnrQNXCsazWY8iLMfEw
         7rXaMvWPpScmWuFlX8CcutBLZmMOWEzfO5puzvDbxiiBPD/IEQs9LIfCHC+ziuC5xkJf
         RwDfg4uugte/mQNg9dY2ku/oNMeDn6deuCP8O5YoqxBzxZktL5gVaSE62SUFA0kfWvJk
         Y5NOWBLzVfbppV9ewD/WOSCICqFaBl/Sgh0oJD4kL8el4t+qL2qWGY13qL8HvvYhGoKz
         9B6za4yxAUl22/J/jCMD4gypS1MmTDK9Iy240BGABPgx+F2PTZx9v4vVmIDxTyX83aSN
         Cpaw==
X-Gm-Message-State: AOJu0YwK9v/TrapR+KRAJZ9NrcP7/0PCCdZiC3sQmgnU49wYV58Abcef
	cOs2cRvN8IrNsk2ao/0tLFBr490ZvW/qE4NxFzWoIOEH19JVE9ixcFwMFQy0NuA=
X-Gm-Gg: ASbGncssRf5MaGxhru/7kVMBy+K1WCXgsvKl8Udfkp1umz5EaAjR5EPY3Nge8xS1fzJ
	kgNSXmgftWK01+d2XrwDyU/HX6l+gatR7ppdVYFvEJC1KA66tRmxndO1LLkGqdCVWpYtbqpP2jf
	xxF2TKCE/fKI7sOQ41gD/hWz6I2bhq4TRTOvbiyzAyy/SEo3ltt1EuXJd64tDkKlbcyOoRYyNm6
	Oqw8aXjdVZwdaTcdjBmrltbwwhKKEk65pzft7pgfgCQKA6Opy3O2aZ3jiq5eGPDVWvgrnzi1Cgm
	NmxD0s5hjG40Ih1EKfoa
X-Google-Smtp-Source: AGHT+IFjx/yJJybfJqzTJyGbOn2E5AZSxv5el1mA0qTMGPGYHc4xLYJUUBB5kp/oNkqyJxkeV2587w==
X-Received: by 2002:a05:600c:4e8b:b0:431:93d8:e1a1 with SMTP id 5b1f17b1804b1-434a9df1f34mr189694025e9.27.1733134467826;
        Mon, 02 Dec 2024 02:14:27 -0800 (PST)
Received: from [127.0.0.1] (alille-653-1-300-114.w90-1.abo.wanadoo.fr. [90.1.180.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e5e59sm181138325e9.44.2024.12.02.02.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 02:14:27 -0800 (PST)
From: Guillaume Ranquet <granquet@baylibre.com>
Date: Mon, 02 Dec 2024 11:09:52 +0100
Subject: [PATCH v3 1/2] iio: adc: ad7173: add calibration support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-ad411x_calibration-v3-1-beb6aeec39e2@baylibre.com>
References: <20241202-ad411x_calibration-v3-0-beb6aeec39e2@baylibre.com>
In-Reply-To: <20241202-ad411x_calibration-v3-0-beb6aeec39e2@baylibre.com>
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
 drivers/iio/adc/ad7173.c | 116 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index a0fca16c3be07534547a5b914d525d05f7425340..5e711b9c80840547bcfa2ad8f5fc8e15c1acc5d2 100644
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
@@ -196,6 +202,7 @@ struct ad7173_channel {
 	unsigned int chan_reg;
 	unsigned int ain;
 	struct ad7173_channel_config cfg;
+	u8 syscalib_mode;
 };
 
 struct ad7173_state {
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
+	st->channels[chan->channel].syscalib_mode = mode;
+
+	return 0;
+}
+
+static int ad7173_get_syscalib_mode(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan)
+{
+	struct ad7173_state *st = iio_priv(indio_dev);
+
+	return st->channels[chan->channel].syscalib_mode;
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
+	mode = st->channels[chan->channel].syscalib_mode;
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

-- 
2.47.0


