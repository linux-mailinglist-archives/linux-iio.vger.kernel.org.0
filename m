Return-Path: <linux-iio+bounces-10670-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B5D9A14F7
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 23:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83F781C2245D
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 21:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076AB1D4152;
	Wed, 16 Oct 2024 21:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+Tgjq7s"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04011D3195;
	Wed, 16 Oct 2024 21:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729114791; cv=none; b=i0gbYHg61dD3+zWbA0f7WNn/iojJvp5NKJYuHZc/E2l3cgO3UsEfkLFjQQ48SioMxuR4QAciPcQqLyp9qptDiTfbymIJPnnPKVt602QdwG+PIfgEuxvI3REZPf0prGFumtrCeDapqrczcLW1kofjMEAF5s5Rws5TUFB9RGMtsvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729114791; c=relaxed/simple;
	bh=XzHX7mpiZNGRxKCO2NaVfoSzdHDVdgWI+Um95X+xHGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pweeJh9bEA/CrUp1tOZ1Vk5egW/u7WHqmZ+6KFHL8FhDPYSMs3eGDM0Y9zYm/km7OS1WGvsTEaUhjS11eWRCAgBlbIfnYBREnx+YisZP2ZSFcVrBVPYb+zIa9/m6VknfoHuMA4tzjjrszRDRcpXuVHqfJ+iuPOo4nZuER3FM5q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+Tgjq7s; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43124843b04so2597995e9.2;
        Wed, 16 Oct 2024 14:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729114788; x=1729719588; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bqV4JP661x6Urd5uW2zeeB7UqCel1QGeugZu19kMdpU=;
        b=C+Tgjq7sHcUklqNb7s6c9ez4BIw8r0oeq7blvcRr+SLVu976SaYDMDWTdBGpWra7Mt
         e5yZ/hpHKeyHSg5tFiwh5QUqpwy+2yZq8bpDKPxt/b73jOek+U0F78SdozQgupzV7g+7
         D5G26Q9Mh/ye8f80ZKJCDcKiZoPY9OajubooQfr/N6nhLuIk7pcz1zfZz5NW+pXt4W0u
         F33nq+hEOPtNhcX5ji6fK1Kk2glleHmd8QZ31RRSq5TgHnKgKnE7Vr6gGUC3DeWtKOgu
         c/mQdtU35o1eE+/aEAVc147zVtcY9uZD1rtgbbSYQM8NqvAMm8lhae0VHExzusRKwcji
         Gglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729114788; x=1729719588;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqV4JP661x6Urd5uW2zeeB7UqCel1QGeugZu19kMdpU=;
        b=fMPWHuvq6pmfJ3uuPo1sB35MeF3s5aluyHLxX9I/YEVeQaeiDMxiFmFh3US4mP2OOE
         YVVWrUvjyAzx5bDJ3pIv/9E9a/avabk0LCMz+9KxHSKe9L2LOKRkQ8+8D0FLxcHOKgy0
         yTUWr6116MoXAtjTIOsd9Y/CLykf1mmzc+u81vwRNfGUvOVqdROX0cZtuzlwXHOz5zAl
         sOKz9l351pUFfbMszmMW7mg4zFnUSQRsM3rWCkfRvXdZHX4uWhlz04b4c5KLKtb4FLoz
         cro1Z5MGM0fVFQPV55sati1UX6OH/7RyNZzWWQ8yY9OxtRaJhVcK2fL/N86lvPrlZMOr
         lAjA==
X-Forwarded-Encrypted: i=1; AJvYcCV+Etmypq+9se24ddEDDeNEdN96amL+LylJPa1+vco0ua0u7WPSkO/hUgyF4mV3RlirFycgUVVc2W4EaZIU@vger.kernel.org, AJvYcCXCA2aqtYpUlXt58zzkcvvT1QL+QdAA54ondPinxfkySQacVGZ3PSzq/tuemmvfMAg58gKi2AJjS8YT@vger.kernel.org
X-Gm-Message-State: AOJu0YwB36THIgJSUG5XgXx1DSBUkPZvp8+D4MnFiLYKJkn/8+g9NVlb
	D3nsDtofLT70DTNvEu7bwiwC0W8IVRaIA4vzbTAte5XRjrsOd3kGIeBYMw==
X-Google-Smtp-Source: AGHT+IH9YykG8pnqUX4o3BAMRqd/uyJprygkS5OQChYS4nwcZyPHBAeSN2j1fFDY2m76/Yyc58jMsw==
X-Received: by 2002:a05:600c:444d:b0:431:51a9:e956 with SMTP id 5b1f17b1804b1-43151a9eb2cmr32542945e9.1.1729114787633;
        Wed, 16 Oct 2024 14:39:47 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-33e3-844f-063e-de99.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:33e3:844f:63e:de99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c37f36sm5632715e9.7.2024.10.16.14.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 14:39:46 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 16 Oct 2024 23:39:32 +0200
Subject: [PATCH 2/2] iio: light: add support for veml3235
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-veml3235-v1-2-b904f802daef@gmail.com>
References: <20241016-veml3235-v1-0-b904f802daef@gmail.com>
In-Reply-To: <20241016-veml3235-v1-0-b904f802daef@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729114783; l=15522;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=XzHX7mpiZNGRxKCO2NaVfoSzdHDVdgWI+Um95X+xHGs=;
 b=G6V9P1VncvKas6XZVJQJRqYvwPEAHDnw8N72aIXrXrK6BaKot2/x/ECL8NfqHO9WbyDrr1VfL
 JTLnlX4mA38DAmpqY4BRtd3HK9T8IyhZDpbQpWq1/zeans6mDbReByf
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The Vishay veml3235 is a low-power ambient light sensor with I2C
interface. It provides a minimum detectable intensity of
0.0021 lx/cnt, configurable integration time and gain, and an additional
white channel to distinguish between different light sources.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 MAINTAINERS                  |   6 +
 drivers/iio/light/Kconfig    |  11 +
 drivers/iio/light/Makefile   |   1 +
 drivers/iio/light/veml3235.c | 534 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 552 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5ed860685cd1..ae7cb38fb64e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24798,6 +24798,12 @@ S:	Maintained
 F:	drivers/input/serio/userio.c
 F:	include/uapi/linux/userio.h
 
+VISHAY VEML3235 AMBIENT LIGHT SENSOR DRIVER
+M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
+F:	drivers/iio/light/veml3235.c
+
 VISHAY VEML6030 AMBIENT LIGHT SENSOR DRIVER
 M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
 S:	Maintained
diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index c38b3c603ab4..c6b7ed0c61a1 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -670,6 +670,17 @@ config VCNL4035
 	  To compile this driver as a module, choose M here: the
 	  module will be called vcnl4035.
 
+config VEML3235
+	tristate "VEML3235 ambient light sensor"
+	select REGMAP_I2C
+	depends on I2C
+	help
+	  Say Y here if you want to build a driver for the Vishay VEML3235
+	  ambient light sensor.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called veml3235.
+
 config VEML6030
 	tristate "VEML6030 and VEML6035 ambient light sensors"
 	select REGMAP_I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index 321010fc0b93..f14a37442712 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_TSL4531)		+= tsl4531.o
 obj-$(CONFIG_US5182D)		+= us5182d.o
 obj-$(CONFIG_VCNL4000)		+= vcnl4000.o
 obj-$(CONFIG_VCNL4035)		+= vcnl4035.o
+obj-$(CONFIG_VEML3235)		+= veml3235.o
 obj-$(CONFIG_VEML6030)		+= veml6030.o
 obj-$(CONFIG_VEML6040)		+= veml6040.o
 obj-$(CONFIG_VEML6070)		+= veml6070.o
diff --git a/drivers/iio/light/veml3235.c b/drivers/iio/light/veml3235.c
new file mode 100644
index 000000000000..9bda42379456
--- /dev/null
+++ b/drivers/iio/light/veml3235.c
@@ -0,0 +1,534 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * VEML3235 Ambient Light Sensor
+ *
+ * Copyright (c) 2024, Javier Carrasco <javier.carrasco.cruz@gmail.com>
+ *
+ * Datasheet: https://www.vishay.com/docs/80131/veml3235.pdf
+ * Appnote-80222: https://www.vishay.com/docs/80222/designingveml3235.pdf
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+#define VEML3235_REG_CONF       0x00
+#define VEML3235_REG_WH_DATA    0x04
+#define VEML3235_REG_ALS_DATA   0x05
+#define VEML3235_REG_ID         0x09
+
+#define VEML3235_SD             BIT(0)
+#define VEML3235_SD0            BIT(8)
+
+struct veml3235_rf {
+	struct regmap_field *it;
+	struct regmap_field *gain;
+	struct regmap_field *id;
+};
+
+struct veml3235_data {
+	struct i2c_client *client;
+	struct device *dev;
+	struct regmap *regmap;
+	struct veml3235_rf rf;
+	int gain;
+	int it;
+	int resolution;
+};
+
+static const int veml3235_it_times[][2] = {
+	{ 0, 50000 },
+	{ 0, 100000 },
+	{ 0, 200000 },
+	{ 0, 400000 },
+	{ 0, 800000 },
+};
+
+static const int veml3235_scale_vals[] = { 1, 2, 4, 8 };
+
+static int veml3235_power_on(struct veml3235_data *data)
+{
+	int ret;
+
+	ret = regmap_clear_bits(data->regmap, VEML3235_REG_CONF, VEML3235_SD |
+				VEML3235_SD0);
+	if (ret)
+		return ret;
+
+	/* Wait 4 ms to let processor & oscillator start correctly */
+	fsleep(4000);
+
+	return 0;
+}
+
+static int veml3235_shut_down(struct veml3235_data *data)
+{
+	return regmap_set_bits(data->regmap, VEML3235_REG_CONF, VEML3235_SD |
+			       VEML3235_SD0);
+}
+
+static void veml3235_shut_down_action(void *data)
+{
+	veml3235_shut_down(data);
+}
+
+enum veml3235_chan {
+	CH_ALS,
+	CH_WHITE,
+};
+
+static const struct iio_chan_spec veml3235_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.channel = CH_ALS,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_PROCESSED),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
+					   BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+						     BIT(IIO_CHAN_INFO_SCALE),
+	},
+	{
+		.type = IIO_INTENSITY,
+		.channel = CH_WHITE,
+		.modified = 1,
+		.channel2 = IIO_MOD_LIGHT_BOTH,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
+					   BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+						     BIT(IIO_CHAN_INFO_SCALE),
+	},
+};
+
+static const struct regmap_config veml3235_regmap_config = {
+	.name = "veml3235_regmap",
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = VEML3235_REG_ID,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+};
+
+static int veml3235_get_it(struct veml3235_data *data, int *val, int *val2)
+{
+	int ret, reg;
+
+	ret = regmap_field_read(data->rf.it, &reg);
+	if (ret)
+		return ret;
+
+	switch (reg) {
+	case 0:
+		*val2 = 50000;
+		break;
+	case 1:
+		*val2 = 100000;
+		break;
+	case 2:
+		*val2 = 200000;
+		break;
+	case 3:
+		*val2 = 400000;
+		break;
+	case 4:
+		*val2 = 800000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	*val = 0;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int veml3235_set_it(struct iio_dev *indio_dev, int val, int val2)
+{
+	struct veml3235_data *data = iio_priv(indio_dev);
+	int ret, new_it, it_idx;
+
+	if (val)
+		return -EINVAL;
+
+	switch (val2) {
+	case 50000:
+		new_it = 0x00;
+		it_idx = 4;
+		break;
+	case 100000:
+		new_it = 0x01;
+		it_idx = 3;
+		break;
+	case 200000:
+		new_it = 0x02;
+		it_idx = 2;
+		break;
+	case 400000:
+		new_it = 0x03;
+		it_idx = 1;
+		break;
+	case 800000:
+		new_it = 0x04;
+		it_idx = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_field_write(data->rf.it, new_it);
+	if (ret) {
+		dev_err(data->dev,
+			"failed to update integration time: %d\n", ret);
+		return ret;
+	}
+
+	if (data->it < it_idx)
+		data->resolution <<= it_idx - data->it;
+	else if (data->it > it_idx)
+		data->resolution >>= data->it - it_idx;
+
+	data->it = it_idx;
+
+	return 0;
+}
+
+static int veml3235_set_gain(struct iio_dev *indio_dev, int val, int val2)
+{
+	struct veml3235_data *data = iio_priv(indio_dev);
+	int ret, new_gain, gain_idx;
+
+	if (val == 1 && val2 == 0) {
+		new_gain = 0x00;
+		gain_idx = 3;
+	} else if (val == 2 && val2 == 0) {
+		new_gain = 0x01;
+		gain_idx = 2;
+	} else if (val == 4 && val2 == 0) {
+		new_gain = 0x03;
+		gain_idx = 1;
+	} else if (val == 8 && val2 == 0) {
+		new_gain = 0x07;
+		gain_idx = 0;
+	} else {
+		return -EINVAL;
+	}
+
+	ret = regmap_field_write(data->rf.gain, new_gain);
+	if (ret) {
+		dev_err(data->dev, "failed to set gain: %d\n", ret);
+		return ret;
+	}
+
+	if (data->gain < gain_idx)
+		data->resolution <<= gain_idx - data->gain;
+	else if (data->gain > gain_idx)
+		data->resolution >>= data->gain - gain_idx;
+
+	data->gain = gain_idx;
+
+	return 0;
+}
+
+static int veml3235_get_gain(struct veml3235_data *data, int *val)
+{
+	int ret, reg;
+
+	ret = regmap_field_read(data->rf.gain, &reg);
+	if (ret) {
+		dev_err(data->dev, "failed to read gain %d\n", ret);
+		return ret;
+	}
+
+	switch (reg & 0x03) {
+	case 0:
+		*val = 1;
+		break;
+	case 1:
+		*val = 2;
+		break;
+	case 3:
+		*val = 4;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Double gain */
+	if (reg & 0x04)
+		*val *= 2;
+
+	return IIO_VAL_INT;
+}
+
+static int veml3235_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int *val,
+			     int *val2, long mask)
+{
+	struct veml3235_data *data = iio_priv(indio_dev);
+	struct regmap *regmap = data->regmap;
+	int ret, reg;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_PROCESSED:
+		switch (chan->type) {
+		case IIO_LIGHT:
+			ret = regmap_read(regmap, VEML3235_REG_ALS_DATA, &reg);
+			if (ret < 0)
+				return ret;
+
+			if (mask == IIO_CHAN_INFO_PROCESSED) {
+				*val = (reg * data->resolution) / 100000;
+				*val2 = (reg * data->resolution) % 100000 * 10;
+				return IIO_VAL_INT_PLUS_MICRO;
+			}
+			*val = reg;
+			return IIO_VAL_INT;
+		case IIO_INTENSITY:
+			ret = regmap_read(regmap, VEML3235_REG_WH_DATA, &reg);
+			if (ret < 0)
+				return ret;
+
+			*val = reg;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_INT_TIME:
+		return veml3235_get_it(data, val, val2);
+	case IIO_CHAN_INFO_SCALE:
+		return veml3235_get_gain(data, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int veml3235_read_avail(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       const int **vals, int *type, int *length,
+			       long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		*vals = (int *)&veml3235_it_times;
+		*length = 2 * ARRAY_SIZE(veml3235_it_times);
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (int *)&veml3235_scale_vals;
+		*length = ARRAY_SIZE(veml3235_scale_vals);
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_LIST;
+	}
+
+	return -EINVAL;
+}
+
+static int veml3235_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		return veml3235_set_it(indio_dev, val, val2);
+	case IIO_CHAN_INFO_SCALE:
+		return veml3235_set_gain(indio_dev, val, val2);
+	}
+
+	return -EINVAL;
+}
+
+static int veml3235_read_id(struct veml3235_data *data)
+{
+	int ret, reg;
+
+	ret = regmap_field_read(data->rf.id,  &reg);
+	if (ret)
+		return dev_err_probe(data->dev, ret, "failed to read ID\n");
+
+	if (reg != 0x35)
+		return dev_err_probe(data->dev, -ENODEV, "Unknown ID %d\n", reg);
+
+	return 0;
+}
+
+static const struct reg_field veml3235_rf_it =
+	REG_FIELD(VEML3235_REG_CONF, 4, 6);
+
+static const struct reg_field veml3235_rf_gain =
+	REG_FIELD(VEML3235_REG_CONF, 11, 13);
+
+static const struct reg_field veml3235_rf_id =
+	REG_FIELD(VEML3235_REG_ID, 0, 7);
+
+static int veml3235_regfield_init(struct veml3235_data *data)
+{
+	struct regmap *regmap = data->regmap;
+	struct device *dev = data->dev;
+	struct regmap_field *rm_field;
+	struct veml3235_rf *rf = &data->rf;
+
+	rm_field = devm_regmap_field_alloc(dev, regmap, veml3235_rf_it);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->it = rm_field;
+
+	rm_field = devm_regmap_field_alloc(dev, regmap, veml3235_rf_gain);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->gain = rm_field;
+
+	rm_field = devm_regmap_field_alloc(dev, regmap, veml3235_rf_id);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->id = rm_field;
+
+	return 0;
+}
+
+static int veml3235_hw_init(struct iio_dev *indio_dev)
+{
+	struct veml3235_data *data = iio_priv(indio_dev);
+	struct device *dev = data->dev;
+	int ret;
+
+	ret = regmap_write(data->regmap, VEML3235_REG_CONF, 0x1001);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to set configuration\n");
+
+	/*
+	 * Set gain to 1, integration time to 100 ms, and the resulting
+	 * resolution in (lux/cnt * 100000) according to the typical value
+	 * from the datasheet.
+	 */
+	ret = regmap_field_write(data->rf.gain, 0x00);
+	if (ret)
+		return dev_err_probe(data->dev, ret, "failed to set gain\n");
+
+	ret = regmap_field_write(data->rf.it, 0x01);
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "failed to set integration time\n");
+
+	data->gain = 3;
+	data->it = 3;
+	data->resolution = 13632;
+
+	ret = veml3235_power_on(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to power on\n");
+
+	return devm_add_action_or_reset(dev, veml3235_shut_down_action, data);
+}
+
+static const struct iio_info veml3235_info = {
+	.read_raw  = veml3235_read_raw,
+	.read_avail  = veml3235_read_avail,
+	.write_raw = veml3235_write_raw,
+};
+
+static int veml3235_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct veml3235_data *data;
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	int ret;
+
+	regmap = devm_regmap_init_i2c(client, &veml3235_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "failed to setup regmap\n");
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+	data->dev = dev;
+	data->regmap = regmap;
+
+	ret = veml3235_regfield_init(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to init regfield\n");
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable regulator\n");
+
+	indio_dev->name = "veml3235";
+	indio_dev->channels = veml3235_channels;
+	indio_dev->num_channels = ARRAY_SIZE(veml3235_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &veml3235_info;
+
+	ret = veml3235_read_id(data);
+	if (ret < 0)
+		return ret;
+
+	ret = veml3235_hw_init(indio_dev);
+	if (ret < 0)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static int veml3235_runtime_suspend(struct device *dev)
+{
+	struct veml3235_data *data = iio_priv(dev_get_drvdata(dev));
+	int ret;
+
+	ret = veml3235_shut_down(data);
+	if (ret < 0)
+		dev_err(data->dev, "failed to suspend: %d\n", ret);
+
+	return ret;
+}
+
+static int veml3235_runtime_resume(struct device *dev)
+{
+	struct veml3235_data *data = iio_priv(dev_get_drvdata(dev));
+	int ret;
+
+	ret = veml3235_power_on(data);
+	if (ret < 0)
+		dev_err(data->dev, "failed to resume: %d\n", ret);
+
+	return ret;
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(veml3235_pm_ops, veml3235_runtime_suspend,
+				 veml3235_runtime_resume, NULL);
+
+static const struct of_device_id veml3235_of_match[] = {
+	{ .compatible = "vishay,veml3235" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, veml3235_of_match);
+
+static const struct i2c_device_id veml3235_id[] = {
+	{ "veml3235" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, veml3235_id);
+
+static struct i2c_driver veml3235_driver = {
+	.driver = {
+		.name = "veml3235",
+		.of_match_table = veml3235_of_match,
+		.pm = pm_ptr(&veml3235_pm_ops),
+	},
+	.probe = veml3235_probe,
+	.id_table = veml3235_id,
+};
+module_i2c_driver(veml3235_driver);
+
+MODULE_AUTHOR("Javier Carrasco <javier.carrasco.cruz@gmail.com>");
+MODULE_DESCRIPTION("VEML3235 Ambient Light Sensor");
+MODULE_LICENSE("GPL");

-- 
2.43.0


