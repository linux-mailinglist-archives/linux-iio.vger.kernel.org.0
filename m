Return-Path: <linux-iio+bounces-160-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4267F0461
	for <lists+linux-iio@lfdr.de>; Sun, 19 Nov 2023 05:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA851C20878
	for <lists+linux-iio@lfdr.de>; Sun, 19 Nov 2023 04:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB315385;
	Sun, 19 Nov 2023 04:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cD3LsyYc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6883F9;
	Sat, 18 Nov 2023 20:58:14 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9c603e2354fso629394466b.1;
        Sat, 18 Nov 2023 20:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700369893; x=1700974693; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h9TNoB/LcNldBSp7dYbn5PyixrV70vpLsZv70MWrCE4=;
        b=cD3LsyYcrm93w1l6f3yXxGDiE6fsWeVKbYvpkCHKT2846thToDSvCmLWkvzs7V2TXq
         7ihVdgUCGW2hFFal7VaAoJ0h+/txkcjOhxvQ8RvFA22a5aIFewzwxmDjycOKUGvDJb0f
         raOfu66eDYFfKsf6G3CuRB48ez8JV0+4ZIj4A7a1YofqsDpB396qTRHjyaUtOZICrBkX
         HMsKHNyXLt3IZtfoGtu+zUGgmWMAqJrS+/D62jeUm4YgJAYUrae+kIXX5Qd1MiRKAEui
         rYvaiysM73EdqlABKqNLij/xOlug6rADKTMWKsTqYGJq1KW0Ja398+j6tZR+PQ7lsg1Q
         SEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700369893; x=1700974693;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9TNoB/LcNldBSp7dYbn5PyixrV70vpLsZv70MWrCE4=;
        b=bZKhE6cLHPFCG7CfBaSkQhtV+BY5dvyt3NuVfjaS1tOzcOCkq6rJ8CwG3ovAZwCPXC
         omYp1dTS8TAapNlkR1IRykZZ65LRtW0s+L+75I7EzZyeY86M9I3Kh8rWasZpJqikpRcr
         nlpUcHx0L2SY9uC2S+dYxbccd5hb0+af6fMFbiKTHEdYLbn95/5q+KefuK4DnNpti+Xt
         jLPpoX0FsacCN1TUtikSXHTck5g6UKv2OG6b7u988oZlm1u/ZPy+62M4Bw2LkEvWPS8X
         w1s4W+yrDNLcwXt6h+ojjJNvD3RtI+RoSNAUNzdw7+pRtwZhuR3SLt1O1pEYT39vyoSY
         NwWQ==
X-Gm-Message-State: AOJu0Ywo/dE6L5CtFFExeMnLNujbRM9FQEwCN+DkKMrcej+fRcl0+D+x
	oVTKmsdVrc+8Aeq+FNX5vF5hKZ6MqOS5mQ==
X-Google-Smtp-Source: AGHT+IFxMr4zYqV23S8eWGKbJKDHxejo5bJN5q5dEtel9ipuSv9t9dGTp2SC+wUNt9q+hUBjv3Es5Q==
X-Received: by 2002:a17:906:24d0:b0:9f1:a725:54a6 with SMTP id f16-20020a17090624d000b009f1a72554a6mr9337833ejb.1.1700369892952;
        Sat, 18 Nov 2023 20:58:12 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-9fcd-7897-f205-6e36.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:9fcd:7897:f205:6e36])
        by smtp.gmail.com with ESMTPSA id q18-20020a1709060e5200b009f5b7b6f3c8sm2504220eji.56.2023.11.18.20.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 20:58:12 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 19 Nov 2023 05:58:03 +0100
Subject: [PATCH 1/2] iio: light: add VEML6075 UVA and UVB light sensor
 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231110-veml6075-v1-1-354b3245e14a@gmail.com>
References: <20231110-veml6075-v1-0-354b3245e14a@gmail.com>
In-Reply-To: <20231110-veml6075-v1-0-354b3245e14a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700369889; l=16150;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=ejRxTC+xVXkLLDkMkvoljKj07tFGZsAIX8yh/GYWAa4=;
 b=fJ6i8zn7Sn/jxZQEfDXrDkMlK8Hm6evb6XJSaHBV4AoI/bHVd8a53eBhX3aZ7euqHMj1gUzum
 tk0eVz3SiXJD9ciIdKvjhAmN3sl+U9pVBIyPXL8UyXh91fFdnVVqP95
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The Vishay VEMl6075 is a low power, 16-bit resolution UVA and UVB
light sensor with I2C interface and noise compensation (visible and
infrarred).

Every UV channel generates an output measured in counts per integration
period. Available integration times are 50 ms, 100 ms, 200 ms, 400 ms
and 800 ms,

This driver adds support for both UV channels and the ultraviolet
index (UVI) inferred from them according to the device application note
with open-air (no teflon) coefficients.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 MAINTAINERS                  |   6 +
 drivers/iio/light/Kconfig    |  11 +
 drivers/iio/light/Makefile   |   1 +
 drivers/iio/light/veml6075.c | 503 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 521 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97f51d5ec1cf..2f13a5088d41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23184,6 +23184,12 @@ S:	Maintained
 F:	drivers/input/serio/userio.c
 F:	include/uapi/linux/userio.h
 
+VISHAY VEML6075 UVA AND UVB LIGHT SENSOR DRIVER
+M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/light/veml6075.yaml
+F:	drivers/iio/light/veml6075.c
+
 VISL VIRTUAL STATELESS DECODER DRIVER
 M:	Daniel Almeida <daniel.almeida@collabora.com>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 45edba797e4c..f68e62196bc2 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -637,6 +637,17 @@ config VEML6070
 	  To compile this driver as a module, choose M here: the
 	  module will be called veml6070.
 
+config VEML6075
+	tristate "VEML6075 UVA and UVB light sensor"
+	select REGMAP_I2C
+	depends on I2C
+	help
+	  Say Y here if you want to build a driver for the Vishay VEML6075 UVA
+	  and UVB light sensor.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called veml6075.
+
 config VL6180
 	tristate "VL6180 ALS, range and proximity sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index c0db4c4c36ec..c8289e24e3f6 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -60,5 +60,6 @@ obj-$(CONFIG_VCNL4000)		+= vcnl4000.o
 obj-$(CONFIG_VCNL4035)		+= vcnl4035.o
 obj-$(CONFIG_VEML6030)		+= veml6030.o
 obj-$(CONFIG_VEML6070)		+= veml6070.o
+obj-$(CONFIG_VEML6075)		+= veml6075.o
 obj-$(CONFIG_VL6180)		+= vl6180.o
 obj-$(CONFIG_ZOPT2201)		+= zopt2201.o
diff --git a/drivers/iio/light/veml6075.c b/drivers/iio/light/veml6075.c
new file mode 100644
index 000000000000..b7d9319c3906
--- /dev/null
+++ b/drivers/iio/light/veml6075.c
@@ -0,0 +1,503 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * veml6075.c - Support for Vishay VEML6075 UVA and UVB light sensor
+ *
+ * Copyright 2023 Javier Carrasco <javier.carrasco.cruz@gmail.com>
+ *
+ * IIO driver for VEML6075 (7-bit I2C slave address 0x10)
+ */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#define VEML6075_DRIVER_NAME "veml6075"
+
+#define VEML6075_CMD_CONF	0x00 /* configuration register */
+#define VEML6075_CMD_UVA	0x07 /* UVA channel */
+#define VEML6075_CMD_UVB	0x09 /* UVB channel */
+#define VEML6075_CMD_COMP1	0x0A /* visible light compensation */
+#define VEML6075_CMD_COMP2	0x0B /* infrarred light compensation */
+#define VEML6075_CMD_ID		0x0C /* device ID */
+
+#define VEML6075_CONF_IT	GENMASK(6, 4) /* intregration time */
+#define VEML6075_CONF_HD	BIT(3) /* dynamic setting */
+#define VEML6075_CONF_TRIG	BIT(2) /* trigger */
+#define VEML6075_CONF_AF	BIT(1) /* active force enable */
+#define VEML6075_CONF_SD	BIT(0) /* shutdown */
+
+#define VEML6075_CONF_IT_50	0x00 /* integration time 50 ms */
+#define VEML6075_CONF_IT_100	0x01 /* integration time 100 ms */
+#define VEML6075_CONF_IT_200	0x02 /* integration time 200 ms */
+#define VEML6075_CONF_IT_400	0x03 /* integration time 400 ms */
+#define VEML6075_CONF_IT_800	0x04 /* integration time 800 ms */
+
+/* Open-air coefficients and responsivity */
+#define VEML6075_A_COEF		2220
+#define VEML6075_B_COEF		1330
+#define VEML6075_C_COEF		2950
+#define VEML6075_D_COEF		1740
+#define VEML6075_UVA_RESP	1461
+#define VEML6075_UVB_RESP	2591
+
+static const int veml6075_it_ms[] = { 50, 100, 200, 400, 800 };
+static const char veml6075_it_ms_avail[] = "50 100 200 400 800";
+
+struct veml6075_data {
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct mutex lock; /* register access lock */
+};
+
+/* channel number */
+enum veml6075_chan {
+	CH_UVA,
+	CH_UVB,
+};
+
+static const struct iio_chan_spec veml6075_channels[] = {
+	{
+		.type = IIO_INTENSITY,
+		.channel = CH_UVA,
+		.modified = 1,
+		.channel2 = IIO_MOD_LIGHT_UV,
+		.extend_name = "UVA",
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+	},
+	{
+		.type = IIO_INTENSITY,
+		.channel = CH_UVB,
+		.modified = 1,
+		.channel2 = IIO_MOD_LIGHT_UV,
+		.extend_name = "UVB",
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+	},
+	{
+		.type = IIO_UVINDEX,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+	},
+};
+
+static IIO_CONST_ATTR_INT_TIME_AVAIL(veml6075_it_ms_avail);
+
+static struct attribute *veml6075_attributes[] = {
+	&iio_const_attr_integration_time_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group veml6075_attribute_group = {
+	.attrs = veml6075_attributes,
+};
+
+static int veml6075_shutdown(struct veml6075_data *data)
+{
+	return regmap_update_bits(data->regmap, VEML6075_CMD_CONF,
+				  VEML6075_CONF_SD, VEML6075_CONF_SD);
+}
+
+static int veml6075_request_measurement(struct veml6075_data *data)
+{
+	int ret, conf, int_time;
+
+	ret = regmap_read(data->regmap, VEML6075_CMD_CONF, &conf);
+	if (ret < 0)
+		return ret;
+
+	/* disable shutdown and trigger measurement */
+	ret = regmap_write(data->regmap, VEML6075_CMD_CONF,
+			   (conf | VEML6075_CONF_TRIG) & ~VEML6075_CONF_SD);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * A measurement requires between 1.30 and 1.40 times the integration
+	 * time for all possible configurations. Using a 1.50 factor simplifies
+	 * operations and ensures reliability under all circumstances.
+	 */
+	int_time = veml6075_it_ms[FIELD_GET(VEML6075_CONF_IT, conf)];
+	msleep(int_time + (int_time / 2));
+
+	/* shutdown again, data registers are still accessible */
+	return veml6075_shutdown(data);
+}
+
+static int veml6075_uva_comp(int raw_uva, int comp1, int comp2)
+{
+	int comp1a_c, comp2a_c, uva_comp;
+
+	comp1a_c = (comp1 * VEML6075_A_COEF) / 1000U;
+	comp2a_c = (comp2 * VEML6075_B_COEF) / 1000U;
+	uva_comp = raw_uva - comp1a_c - comp2a_c;
+	pr_err("JCC: uva=%d, c1=%d, c2=%d, c1ca=%d, c2ca=%d, uvac=%d\n",
+	       raw_uva, comp1, comp2, comp1a_c, comp2a_c, uva_comp);
+
+	return clamp_val(uva_comp, 0, U16_MAX);
+}
+
+static int veml6075_uvb_comp(int raw_uvb, int comp1, int comp2)
+{
+	int comp1b_c, comp2b_c, uvb_comp;
+
+	comp1b_c = (comp1 * VEML6075_C_COEF) / 1000U;
+	comp2b_c = (comp2 * VEML6075_D_COEF) / 1000U;
+	uvb_comp = raw_uvb - comp1b_c - comp2b_c;
+	pr_err("JCC: uvb=%d, c1=%d, c2=%d, c1cb=%d, c2cb=%d, uvbc=%d\n",
+	       raw_uvb, comp1, comp2, comp1b_c, comp2b_c, uvb_comp);
+
+	return clamp_val(uvb_comp, 0, U16_MAX);
+}
+
+static int veml6075_read_comp(struct veml6075_data *data, int *c1, int *c2)
+{
+	int ret;
+
+	ret = regmap_read(data->regmap, VEML6075_CMD_COMP1, c1);
+	if (ret < 0)
+		return ret;
+
+	return regmap_read(data->regmap, VEML6075_CMD_COMP2, c2);
+}
+
+static int veml6075_read_uva_count(struct veml6075_data *data, int *uva)
+{
+	return regmap_read(data->regmap, VEML6075_CMD_UVA, uva);
+}
+
+static int veml6075_read_uvb_count(struct veml6075_data *data, int *uvb)
+{
+	return regmap_read(data->regmap, VEML6075_CMD_UVB, uvb);
+}
+
+static int veml6075_read_uv_direct(struct veml6075_data *data, int chan,
+				   int *val)
+{
+	int c1, c2, ret;
+
+	ret = veml6075_request_measurement(data);
+	if (ret < 0)
+		return ret;
+
+	ret = veml6075_read_comp(data, &c1, &c2);
+	if (ret < 0)
+		return ret;
+
+	switch (chan) {
+	case CH_UVA:
+		ret = veml6075_read_uva_count(data, val);
+		if (ret < 0)
+			return ret;
+
+		*val = veml6075_uva_comp(*val, c1, c2);
+		break;
+	case CH_UVB:
+		ret = veml6075_read_uvb_count(data, val);
+		if (ret < 0)
+			return ret;
+
+		*val = veml6075_uvb_comp(*val, c1, c2);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return IIO_VAL_INT;
+}
+
+static int veml6075_read_int_time_index(struct veml6075_data *data)
+{
+	int ret, conf;
+
+	ret = regmap_read(data->regmap, VEML6075_CMD_CONF, &conf);
+	if (ret < 0)
+		return ret;
+
+	return FIELD_GET(VEML6075_CONF_IT, conf);
+}
+
+static int veml6075_read_int_time_ms(struct veml6075_data *data, int *val)
+{
+	int int_index;
+
+	int_index = veml6075_read_int_time_index(data);
+	if (int_index < 0)
+		return int_index;
+
+	*val = veml6075_it_ms[int_index];
+
+	return IIO_VAL_INT;
+}
+
+static int veml6075_get_uvi_micro(struct veml6075_data *data, int uva_comp,
+				  int uvb_comp)
+{
+	int uvia_micro = uva_comp * VEML6075_UVA_RESP;
+	int uvib_micro = uvb_comp * VEML6075_UVB_RESP;
+	int int_index;
+
+	int_index = veml6075_read_int_time_index(data);
+	if (int_index < 0)
+		return int_index;
+
+	switch (int_index) {
+	case VEML6075_CONF_IT_50:
+		return uvia_micro + uvib_micro;
+	case VEML6075_CONF_IT_100:
+	case VEML6075_CONF_IT_200:
+	case VEML6075_CONF_IT_400:
+	case VEML6075_CONF_IT_800:
+		return (uvia_micro + uvib_micro) / (2 << int_index);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int veml6075_read_uvi(struct veml6075_data *data, int *val, int *val2)
+{
+	int ret, c1, c2, uva, uvb, uvi_micro;
+
+	ret = veml6075_request_measurement(data);
+	if (ret < 0)
+		return ret;
+
+	ret = veml6075_read_comp(data, &c1, &c2);
+	if (ret < 0)
+		return ret;
+
+	ret = veml6075_read_uva_count(data, &uva);
+	if (ret < 0)
+		return ret;
+
+	ret = veml6075_read_uvb_count(data, &uvb);
+	if (ret < 0)
+		return ret;
+
+	uvi_micro = veml6075_get_uvi_micro(data, veml6075_uva_comp(uva, c1, c2),
+					   veml6075_uvb_comp(uvb, c1, c2));
+	if (uvi_micro < 0)
+		return uvi_micro;
+
+	*val = uvi_micro / 1000000LL;
+	*val2 = uvi_micro % 1000000LL;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int veml6075_read_responsivity(int chan, int *val, int *val2)
+{
+	/* scale = 1 / resp */
+	switch (chan) {
+	case CH_UVA:
+		/* resp = 0.93 c/uW/cm2: scale = 1.75268817 */
+		*val = 1;
+		*val2 = 75268817;
+		break;
+	case CH_UVB:
+		/* resp = 2.1 c/uW/cm2: scale = 0.476190476 */
+		*val = 0;
+		*val2 = 476190476;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+static int veml6075_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct veml6075_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&data->lock);
+		ret = veml6075_read_uv_direct(data, chan->channel, val);
+		break;
+	case IIO_CHAN_INFO_PROCESSED:
+		mutex_lock(&data->lock);
+		ret = veml6075_read_uvi(data, val, val2);
+		break;
+	case IIO_CHAN_INFO_INT_TIME:
+		mutex_lock(&data->lock);
+		ret = veml6075_read_int_time_ms(data, val);
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		return veml6075_read_responsivity(chan->channel, val, val2);
+	default:
+		return -EINVAL;
+	}
+
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static int veml6075_write_int_time_ms(struct veml6075_data *data, int val)
+{
+	int conf, i = ARRAY_SIZE(veml6075_it_ms);
+
+	while (i-- > 0) {
+		if (val == veml6075_it_ms[i])
+			break;
+	}
+	if (i < 0)
+		return -EINVAL;
+
+	conf = FIELD_PREP(VEML6075_CONF_IT, i);
+
+	return regmap_update_bits(data->regmap, VEML6075_CMD_CONF,
+				  VEML6075_CONF_IT, conf);
+}
+
+static int veml6075_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
+{
+	struct veml6075_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		mutex_lock(&data->lock);
+		ret = veml6075_write_int_time_ms(data, val);
+		mutex_unlock(&data->lock);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static const struct iio_info veml6075_info = {
+	.read_raw = veml6075_read_raw,
+	.write_raw = veml6075_write_raw,
+	.attrs = &veml6075_attribute_group,
+};
+
+static bool veml6075_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case VEML6075_CMD_CONF:
+	case VEML6075_CMD_UVA:
+	case VEML6075_CMD_UVB:
+	case VEML6075_CMD_COMP1:
+	case VEML6075_CMD_COMP2:
+	case VEML6075_CMD_ID:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool veml6075_writable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case VEML6075_CMD_CONF:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config veml6075_regmap_config = {
+	.name = VEML6075_DRIVER_NAME,
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = VEML6075_CMD_ID,
+	.readable_reg = veml6075_readable_reg,
+	.writeable_reg = veml6075_writable_reg,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+
+};
+
+static int veml6075_probe(struct i2c_client *client)
+{
+	struct veml6075_data *data;
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	int config, ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	regmap = devm_regmap_init_i2c(client, &veml6075_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+	data->regmap = regmap;
+
+	mutex_init(&data->lock);
+
+	indio_dev->name = VEML6075_DRIVER_NAME;
+	indio_dev->info = &veml6075_info;
+	indio_dev->channels = veml6075_channels;
+	indio_dev->num_channels = ARRAY_SIZE(veml6075_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = devm_regulator_get_enable_optional(&client->dev, "vdd");
+	if (ret < 0 && ret != -ENODEV)
+		return ret;
+
+	/* default: 100ms integration time, active force enable, shutdown */
+	config = FIELD_PREP(VEML6075_CONF_IT, VEML6075_CONF_IT_100) |
+		VEML6075_CONF_AF | VEML6075_CONF_SD;
+	ret = regmap_write(data->regmap, VEML6075_CMD_CONF, config);
+	if (ret < 0)
+		return ret;
+
+	return iio_device_register(indio_dev);
+}
+
+static void veml6075_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+
+	iio_device_unregister(indio_dev);
+}
+
+static const struct i2c_device_id veml6075_id[] = {
+	{ "veml6075", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, veml6075_id);
+
+static const struct of_device_id veml6075_of_match[] = {
+	{ .compatible = "vishay,veml6075" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, veml6075_of_match);
+
+static struct i2c_driver veml6075_driver = {
+	.driver = {
+		.name   = VEML6075_DRIVER_NAME,
+		.of_match_table = veml6075_of_match,
+	},
+	.probe = veml6075_probe,
+	.remove  = veml6075_remove,
+	.id_table = veml6075_id,
+};
+
+module_i2c_driver(veml6075_driver);
+
+MODULE_AUTHOR("Javier Carrasco <javier.carrasco.cruz@gmail.com>");
+MODULE_DESCRIPTION("Vishay VEML6075 UVA and UVB light sensor driver");
+MODULE_LICENSE("GPL");

-- 
2.39.2


