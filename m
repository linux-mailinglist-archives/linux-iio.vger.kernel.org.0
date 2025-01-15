Return-Path: <linux-iio+bounces-14384-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDEAA12C67
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2025 21:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24003162258
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2025 20:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5263C1DA614;
	Wed, 15 Jan 2025 20:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIUs3+cF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36391DA116;
	Wed, 15 Jan 2025 20:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736972230; cv=none; b=FkGkV48tDopzZ2XDbV5hgBK6ehje0Fykwoh5WRqZ79zpk0xoI2NOl3fLrBGVEHBndQ6ud9YlHAiKBz+Y+gSCGx5M0IOW/Jf8hVj9tggoNpuvT1MQygdgBzrHqxqEq3jsVHRUDedTvEK2JtceeCYOsIb1SdFEod/OI8iVIoT8cp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736972230; c=relaxed/simple;
	bh=wN+gtZUONlhoiPNS4+bL9+mCb+pTYBtRuma8UI9njxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HL+aM5T5pv+pZp9dG9yXhKrdj2PS24zLpEMvo6CobYbuJlk/lvVPRL9vV1ezOF3/bv4HPiPJrsAVPq8PCVrYiUDpnYFoVjNKTDOLS2b2Srzexx6/DzgKGwI7cR+EZig55Bizk+DaJz1lPb0/56JtsOoJH/VxCGEMUddYvEpIkeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIUs3+cF; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaf6b1a5f2bso257690266b.1;
        Wed, 15 Jan 2025 12:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736972226; x=1737577026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZvLua7IXouUPNYkH/lSclePR+yLBlK7Bj9GLgrrOmU=;
        b=CIUs3+cFEN/TWn5ZVDjNYoY5ozgUlexosqpjoHG1xd6HncMZ4tZnDOASKoFfInx3cG
         l01VQGAXB2q6N47Nv+NEssI69UGapN5UFGRDHL/Z3mM3EfxOAHwUCmQr3+iaY3SPHerS
         0hC9Uc4pZsDgOZYXv0/x/0QE/7K+eJu1oO4NgGE9vzRwm1E1HK4RYvY9b7ay03LMhJHo
         hscbA90gRNgIgIy3jbmqJu+U8UUm1rVXvD5MprWrR9pWxAmc/Su3PhS+mZ3ozeWNgpN2
         vzExjM7NCsqxV6+yv5aaIYubgSs0CIBt2sg6JLmBvS9z8JlAEFlIBx5nTvzyPgCs83E+
         NXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736972226; x=1737577026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ZvLua7IXouUPNYkH/lSclePR+yLBlK7Bj9GLgrrOmU=;
        b=mDg471CFY0tcc4FFGkbAKsfeuypluEt6P9xuqxh9eT7a/V1MuWZTLk6Pe/lqAzhgCL
         0PDlH1keABA43oTDWulsh7YiA+hhkRPLEW+shLjkJo5FMPUe4PBlqyG93bKlMoeJiqqo
         6m8VhVhSGMFT3MdMqrYlXEIkg7QiaJw2/RAhGSVqfNz6Hmgf0A7pcyekfld1RJ99LwdV
         KKkuoWcQByslShX2NuU7BWD1wDZFnwznGqB4DZpchaW8Fs33TL+ufkIY4Xxltm9/wAYz
         vs1Z/RHQhI80lz4NTTrp7GqvdKpidxn167vmnfbUeIumKxBZlnjTBzFM+bpY//e8//1f
         7GGg==
X-Forwarded-Encrypted: i=1; AJvYcCWMnjHixyFUXh6BuuTn4JoQsrHUExE1tav2UI9abPyvjqpGeFjD9p9l82HgKEhQEtphAb329muPwuc5kui1@vger.kernel.org, AJvYcCX+KRELmk0HLWwl3AQ9fmtGFruQ31e5Nx8dIEVBFy+RSyLCKrS5VLLRxpuRD8+zWq49V4czxjp8mcaU@vger.kernel.org, AJvYcCXuY3xBi05ynLOymQH10LzZdYO7dIW9xSLZ6/E+kY/Fsav5yXEEOIOGjBSC5Dkk2JruQHUhwWnO8NmN@vger.kernel.org
X-Gm-Message-State: AOJu0YwBC/U0UeVLP8QZtzklz4rsphjuYrqo+LhV+qYC+64YUWGWu+4N
	8yoDp5zp3O+5w6bpzqNjqRnwTGM5MDUqatEwvNRLHHXAfio+2kRZ
X-Gm-Gg: ASbGncug5U0uqYlTZfmoGfEXHXxQhRW4K/aHGpt+YxliCpYTp+cQIWof1ZOAFxDI2MA
	FME7z+j6TaQ3PshGUJnkwA4kykMnhB5pSwtE6d4ruB4iJbnbew76NRPXaMA0XOfk419VIDVMKjK
	eerR5XnsY1Ds4RKt84vF7Fj2QZrZQ/mxzm/YrM2aWnx9DZVGVkCS0yizUx8/TJv4HLYkLMKSLub
	TN4Rzi5Y10XREKe12MLhOe58d1atu4Sm+2QJ5XPRNvv6J9pBwAGeXHaKlj3f7TnKDnMLMmBpPM=
X-Google-Smtp-Source: AGHT+IGDgDZGsHVxajrdIIy80JKk1MerDCE8eRvmUhq3fcidRzUPtVvYw0uK0Lf9IHm/Fv0LdspXXg==
X-Received: by 2002:a17:906:e242:b0:ab2:f6e5:3f1 with SMTP id a640c23a62f3a-ab36e2b9e8emr917766b.8.1736972225739;
        Wed, 15 Jan 2025 12:17:05 -0800 (PST)
Received: from localhost.localdomain ([78.210.102.185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c90dc101sm813697966b.56.2025.01.15.12.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 12:17:05 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrej.skvortzov@gmail.com,
	neil.armstrong@linaro.org,
	icenowy@aosc.io,
	megi@xff.cz,
	danila@jiaxyga.com,
	javier.carrasco.cruz@gmail.com,
	andy@kernel.org
Cc: apokusinski01@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 2/2] iio: magnetometer: si7210: add driver for Si7210
Date: Wed, 15 Jan 2025 21:16:22 +0100
Message-Id: <20250115201622.270130-3-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250115201622.270130-1-apokusinski01@gmail.com>
References: <20250115201622.270130-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Silicon Labs Si7210 is an I2C Hall effect magnetic position and
temperature sensor. The driver supports the following functionalities:
* reading the temperature measurements
* reading the magnetic field measurements in a single-shot mode
* choosing the magnetic field measurement scale (20 or 200 mT)

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/iio/magnetometer/Kconfig  |  11 +
 drivers/iio/magnetometer/Makefile |   2 +
 drivers/iio/magnetometer/si7210.c | 444 ++++++++++++++++++++++++++++++
 3 files changed, 457 insertions(+)
 create mode 100644 drivers/iio/magnetometer/si7210.c

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 7177cd1d67cb..3debf1320ad1 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -235,6 +235,17 @@ config SENSORS_RM3100_SPI
 	  To compile this driver as a module, choose M here: the module
 	  will be called rm3100-spi.
 
+config SI7210
+	tristate "SI7210 Hall effect sensor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say Y here to add support for the SI7210 Hall effect sensor.
+
+	  This driver can also be compiled as a module.
+	  To compile this driver as a module, choose M here: the module
+	  will be called si7210.
+
 config TI_TMAG5273
 	tristate "TI TMAG5273 Low-Power Linear 3D Hall-Effect Sensor"
 	depends on I2C
diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
index 3e4c2ecd9adf..7455115a052f 100644
--- a/drivers/iio/magnetometer/Makefile
+++ b/drivers/iio/magnetometer/Makefile
@@ -31,6 +31,8 @@ obj-$(CONFIG_SENSORS_RM3100)		+= rm3100-core.o
 obj-$(CONFIG_SENSORS_RM3100_I2C)	+= rm3100-i2c.o
 obj-$(CONFIG_SENSORS_RM3100_SPI)	+= rm3100-spi.o
 
+obj-$(CONFIG_SI7210) 			+= si7210.o
+
 obj-$(CONFIG_TI_TMAG5273)		+= tmag5273.o
 
 obj-$(CONFIG_YAMAHA_YAS530)		+= yamaha-yas530.o
diff --git a/drivers/iio/magnetometer/si7210.c b/drivers/iio/magnetometer/si7210.c
new file mode 100644
index 000000000000..e2cfa0e5ad42
--- /dev/null
+++ b/drivers/iio/magnetometer/si7210.c
@@ -0,0 +1,444 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Silicon Labs Si7210 Hall Effect sensor driver
+ *
+ * Copyright (c) 2024 Antoni Pokusinski <apokusinski01@gmail.com>
+ *
+ * Datasheet:
+ *  https://www.silabs.com/documents/public/data-sheets/si7210-datasheet.pdf
+ */
+
+#include <asm/byteorder.h>
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/math64.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+/* Registers offsets and masks */
+#define SI7210_REG_DSPSIGM	0xC1
+#define SI7210_REG_DSPSIGL	0xC2
+
+#define SI7210_MASK_DSPSIGSEL	GENMASK(2, 0)
+#define SI7210_REG_DSPSIGSEL	0xC3
+
+#define SI7210_MASK_STOP	BIT(1)
+#define SI7210_MASK_ONEBURST	BIT(2)
+#define SI7210_REG_POWER_CTRL	0xC4
+
+#define SI7210_MASK_ARAUTOINC	BIT(0)
+#define SI7210_REG_ARAUTOINC	0xC5
+
+#define SI7210_REG_A0		0xCA
+#define SI7210_REG_A1		0xCB
+#define SI7210_REG_A2		0xCC
+#define SI7210_REG_A3		0xCE
+#define SI7210_REG_A4		0xCF
+#define SI7210_REG_A5		0xD0
+
+#define SI7210_REG_OTP_ADDR	0xE1
+#define SI7210_REG_OTP_DATA	0xE2
+
+#define SI7210_MASK_OTP_READ_EN	BIT(1)
+#define SI7210_REG_OTP_CTRL	0xE3
+
+/* OTP data registers offsets */
+#define SI7210_OTPREG_TMP_OFF	0x1D
+#define SI7210_OTPREG_TMP_GAIN	0x1E
+
+#define SI7210_OTPREG_A0_20	0x21
+#define SI7210_OTPREG_A1_20	0x22
+#define SI7210_OTPREG_A2_20	0x23
+#define SI7210_OTPREG_A3_20	0x24
+#define SI7210_OTPREG_A4_20	0x25
+#define SI7210_OTPREG_A5_20	0x26
+
+#define SI7210_OTPREG_A0_200	0x27
+#define SI7210_OTPREG_A1_200	0x28
+#define SI7210_OTPREG_A2_200	0x29
+#define SI7210_OTPREG_A3_200	0x2A
+#define SI7210_OTPREG_A4_200	0x2B
+#define SI7210_OTPREG_A5_200	0x2C
+
+#define A_REGS_COUNT 6
+
+static const unsigned int a20_otp_regs[A_REGS_COUNT] = {
+	SI7210_OTPREG_A0_20, SI7210_OTPREG_A1_20, SI7210_OTPREG_A2_20,
+	SI7210_OTPREG_A3_20, SI7210_OTPREG_A4_20, SI7210_OTPREG_A5_20,
+};
+
+static const unsigned int a200_otp_regs[A_REGS_COUNT] = {
+	SI7210_OTPREG_A0_200, SI7210_OTPREG_A1_200, SI7210_OTPREG_A2_200,
+	SI7210_OTPREG_A3_200, SI7210_OTPREG_A4_200, SI7210_OTPREG_A5_200,
+};
+
+static const struct regmap_range si7210_read_reg_ranges[] = {
+	regmap_reg_range(SI7210_REG_DSPSIGM, SI7210_REG_ARAUTOINC),
+	regmap_reg_range(SI7210_REG_A0, SI7210_REG_A2),
+	regmap_reg_range(SI7210_REG_A3, SI7210_REG_A5),
+	regmap_reg_range(SI7210_REG_OTP_ADDR, SI7210_REG_OTP_CTRL),
+};
+
+static const struct regmap_access_table si7210_readable_regs = {
+	.yes_ranges = si7210_read_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(si7210_read_reg_ranges),
+};
+
+static const struct regmap_range si7210_write_reg_ranges[] = {
+	regmap_reg_range(SI7210_REG_DSPSIGSEL, SI7210_REG_ARAUTOINC),
+	regmap_reg_range(SI7210_REG_A0, SI7210_REG_A2),
+	regmap_reg_range(SI7210_REG_A3, SI7210_REG_A5),
+	regmap_reg_range(SI7210_REG_OTP_ADDR, SI7210_REG_OTP_CTRL),
+};
+
+static const struct regmap_access_table si7210_writeable_regs = {
+	.yes_ranges = si7210_write_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(si7210_write_reg_ranges),
+};
+
+static const struct regmap_range si7210_volatile_reg_ranges[] = {
+	regmap_reg_range(SI7210_REG_DSPSIGM, SI7210_REG_DSPSIGL),
+	regmap_reg_range(SI7210_REG_POWER_CTRL, SI7210_REG_POWER_CTRL),
+};
+
+static const struct regmap_access_table si7210_volatile_regs = {
+	.yes_ranges = si7210_volatile_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(si7210_volatile_reg_ranges),
+};
+
+static const struct regmap_config si7210_regmap_conf = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = SI7210_REG_OTP_CTRL,
+
+	.rd_table = &si7210_readable_regs,
+	.wr_table = &si7210_writeable_regs,
+	.volatile_table = &si7210_volatile_regs,
+};
+
+struct si7210_data {
+	struct regmap *regmap;
+	struct i2c_client *client;
+	struct regulator *vdd;
+	struct mutex fetch_lock; /* lock for a single measurement fetch */
+	s8 temp_offset;
+	s8 temp_gain;
+	s8 scale_20_a[A_REGS_COUNT];
+	s8 scale_200_a[A_REGS_COUNT];
+	u8 curr_scale;
+};
+
+static const struct iio_chan_spec si7210_channels[] = {
+	{
+		.type = IIO_MAGN,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET),
+	}, {
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+	},
+};
+
+static int si7210_fetch_measurement(struct si7210_data *data,
+				    struct iio_chan_spec const *chan,
+				    u16 *buf)
+{
+	u8 dspsigsel = chan->type == IIO_MAGN ? 0 : 1;
+	int ret;
+	__be16 result;
+
+	guard(mutex)(&data->fetch_lock);
+
+	ret = regmap_update_bits(data->regmap, SI7210_REG_DSPSIGSEL,
+				 SI7210_MASK_DSPSIGSEL, dspsigsel);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(data->regmap, SI7210_REG_POWER_CTRL,
+				 SI7210_MASK_ONEBURST | SI7210_MASK_STOP,
+				 SI7210_MASK_ONEBURST & ~SI7210_MASK_STOP);
+	if (ret)
+		return ret;
+
+	/*
+	 * Read the contents of the
+	 * registers containing the result: DSPSIGM, DSPSIGL
+	 */
+	ret = regmap_bulk_read(data->regmap, SI7210_REG_DSPSIGM,
+			       &result, sizeof(result));
+	if (ret)
+		return ret;
+
+	*buf = be16_to_cpu(result);
+
+	return 0;
+}
+
+static int si7210_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct si7210_data *data = iio_priv(indio_dev);
+	long long temp;
+	u16 dspsig;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = si7210_fetch_measurement(data, chan, &dspsig);
+		if (ret)
+			return ret;
+
+		*val = dspsig & GENMASK(14, 0);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+		if (data->curr_scale == 20)
+			*val2 = 1250;
+		else /* data->curr_scale == 200 */
+			*val2 = 12500;
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = -16384;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_PROCESSED:
+		ret = si7210_fetch_measurement(data, chan, &dspsig);
+		if (ret)
+			return ret;
+
+		temp = FIELD_GET(GENMASK(14, 3), dspsig);
+		temp = div_s64(-383 * temp * temp, 100) + 160940 * temp - 279800000;
+		temp *= (1 + (data->temp_gain / 2048));
+		temp += (int)(MICRO / 16) * data->temp_offset;
+
+		ret = regulator_get_voltage(data->vdd);
+		if (ret < 0)
+			return ret;
+
+		temp -= 222 * div_s64(ret, MILLI);
+
+		*val = div_s64(temp, MILLI);
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int si7210_set_scale(struct si7210_data *data, unsigned int scale)
+{
+	s8 *a_otp_values;
+	int ret;
+
+	if (scale == 20)
+		a_otp_values = data->scale_20_a;
+	else if (scale == 200)
+		a_otp_values = data->scale_200_a;
+	else
+		return -EINVAL;
+
+	guard(mutex)(&data->fetch_lock);
+
+	/* Write the registers 0xCA - 0xCC */
+	ret = regmap_bulk_write(data->regmap, SI7210_REG_A0, a_otp_values, 3);
+	if (ret)
+		return ret;
+
+	/* Write the registers 0xCE - 0xD0 */
+	ret = regmap_bulk_write(data->regmap, SI7210_REG_A3, &a_otp_values[3], 3);
+	if (ret)
+		return ret;
+
+	data->curr_scale = scale;
+
+	return 0;
+}
+
+static int si7210_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	struct si7210_data *data = iio_priv(indio_dev);
+	unsigned int scale;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		if (val == 0 && val2 == 1250)
+			scale = 20;
+		else if (val == 0 && val2 == 12500)
+			scale = 200;
+		else
+			return -EINVAL;
+
+		return si7210_set_scale(data, scale);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int si7210_read_otpreg_val(struct si7210_data *data, unsigned int otpreg, u8 *val)
+{
+	int ret;
+	unsigned int otpdata;
+
+	ret = regmap_write(data->regmap, SI7210_REG_OTP_ADDR, otpreg);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(data->regmap, SI7210_REG_OTP_CTRL,
+				 SI7210_MASK_OTP_READ_EN, SI7210_MASK_OTP_READ_EN);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap, SI7210_REG_OTP_DATA, &otpdata);
+	if (ret)
+		return ret;
+
+	*val = otpdata;
+
+	return 0;
+}
+
+/*
+ * According to the datasheet, the primary method to wake up a
+ * device is to send an empty write. However this is not feasible
+ * using the current API so we use the other method i.e. read a single
+ * byte. The device should respond with 0xFF.
+ */
+static int si7210_device_wake(struct si7210_data *data)
+{
+	int ret;
+
+	ret = i2c_smbus_read_byte(data->client);
+	if (ret < 0)
+		return ret;
+
+	if (ret != 0xFF)
+		return -EIO;
+
+	return 0;
+}
+
+static int si7210_device_init(struct si7210_data *data)
+{
+	int ret;
+	unsigned int i;
+
+	ret = si7210_device_wake(data);
+	if (ret)
+		return ret;
+
+	fsleep(1000);
+
+	ret = si7210_read_otpreg_val(data, SI7210_OTPREG_TMP_GAIN, &data->temp_gain);
+	if (ret)
+		return ret;
+
+	ret = si7210_read_otpreg_val(data, SI7210_OTPREG_TMP_OFF, &data->temp_offset);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < A_REGS_COUNT; i++) {
+		ret = si7210_read_otpreg_val(data, a20_otp_regs[i], &data->scale_20_a[i]);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < A_REGS_COUNT; i++) {
+		ret = si7210_read_otpreg_val(data, a200_otp_regs[i], &data->scale_200_a[i]);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_update_bits(data->regmap, SI7210_REG_ARAUTOINC,
+				 SI7210_MASK_ARAUTOINC, SI7210_MASK_ARAUTOINC);
+	if (ret)
+		return ret;
+
+	return si7210_set_scale(data, 20);
+}
+
+static const struct iio_info si7210_info = {
+	.read_raw = si7210_read_raw,
+	.write_raw = si7210_write_raw,
+};
+
+static int si7210_probe(struct i2c_client *client)
+{
+	struct si7210_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+
+	ret = devm_mutex_init(&client->dev, &data->fetch_lock);
+	if (ret)
+		return ret;
+
+	data->regmap = devm_regmap_init_i2c(client, &si7210_regmap_conf);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(data->regmap),
+				     "failed to register regmap\n");
+
+	data->vdd = devm_regulator_get(&client->dev, "vdd");
+	if (IS_ERR(data->vdd))
+		return dev_err_probe(&client->dev, PTR_ERR(data->vdd),
+				     "failed to get VDD regulator\n");
+
+	ret = regulator_enable(data->vdd);
+	if (ret)
+		return ret;
+
+	indio_dev->name = dev_name(&client->dev);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &si7210_info;
+	indio_dev->channels = si7210_channels;
+	indio_dev->num_channels = ARRAY_SIZE(si7210_channels);
+
+	ret = si7210_device_init(data);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "device initialization failed\n");
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct i2c_device_id si7210_id[] = {
+	{ "si7210" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, si7210_id);
+
+static const struct of_device_id si7210_dt_ids[] = {
+	{ .compatible = "silabs,si7210" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, si7210_dt_ids);
+
+static struct i2c_driver si7210_driver = {
+	.driver = {
+		.name = "si7210",
+		.of_match_table = si7210_dt_ids,
+	},
+	.probe = si7210_probe,
+	.id_table = si7210_id,
+};
+module_i2c_driver(si7210_driver);
+
+MODULE_AUTHOR("Antoni Pokusinski <apokusinski01@gmail.com>");
+MODULE_DESCRIPTION("Silicon Labs Si7210 Hall Effect sensor I2C driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


