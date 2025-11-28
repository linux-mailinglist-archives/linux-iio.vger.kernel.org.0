Return-Path: <linux-iio+bounces-26531-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1E5C90C99
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 04:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B603A87BC
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 03:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FB02D9EF0;
	Fri, 28 Nov 2025 03:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IycEQook"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2E22D63E2
	for <linux-iio@vger.kernel.org>; Fri, 28 Nov 2025 03:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764301055; cv=none; b=qpvRztMZme2TXzxeYCmUJZzCFom3Mxgaxn96QbyzZSer+L8d7Wf5h+jMb36ZCpt7q3P6KO6vMqupVpUjPsiqg+pCUW+o1GlHIM8Ar7ShXaNLUOY5oGEAtY3rBXqJLs7uGjn5z4IPbEpoGSsB6WFvqlSwGoiXbrlkcnzDZRKO7aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764301055; c=relaxed/simple;
	bh=kV1OALCUnGKVOlxwRw/qBr1IuNZxZdZwM6EY+WCt1WQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R+Qadi5m2b8FmdxdqNc1A51a3oiSaY0/PC4hWjPyCN/mW2A2becXGlaL+AXiae6dWFiZtTCrOTMlZVtPrhP3M7zxj7APxHTtpS8WWCbYk+Yi4uPafGnsdGasOGAi+vyzKZsPJrBtKRYMoKEijldg0fDKa45FghiW0kOsS/ofsIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IycEQook; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5e18598b9b1so1010156137.0
        for <linux-iio@vger.kernel.org>; Thu, 27 Nov 2025 19:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764301052; x=1764905852; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pD/zLHdmoPpI8ayLItX7Z6XnekUdFadeWRXh3YqTLPA=;
        b=IycEQookOMxNCf3BwkUWlIn5K9WuG3aujwjN4w3AsfU2eECtH+uHQrwDgNI5uh0abH
         Rn9qurExBbCNmLNY6cINqqi+6V/l8Sm4wDjw/OVn5ue9u+Uod2NQvXAManxSuKln1bzS
         CLHczBpEhHnCv7kq1DviLtvF5E2zj6LbbmZAjcibGbPgKT8WscaoZhRAxfPEFXqghwOo
         TGx114mrrsNN7IAoEFFVNPXKiF7bNDQeaBHyxT2U7xI93zN1jJulUG4hPdKQwKapYcRv
         7N5N7FJ0klnMtGn48jc60T6QVsyacCBXWIgC2c4/paOskHKQP4GtjIPw2zkBRSJW/ny8
         fg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764301052; x=1764905852;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pD/zLHdmoPpI8ayLItX7Z6XnekUdFadeWRXh3YqTLPA=;
        b=aTH0bNKGtylYl3MM7E0e4rvWBZApf9icLQXlJY2oEi/ek7jrVky9wplyQiEjZOx6iy
         ZyA9JvuRWTC9RAaBx+PAzOiqhE3wLVqIbxn96mypanu7/sjzM3DRdVMpudYYz0T2vKhS
         30ivb/MVpUIFDsQqBgD7Cx0giB4OwPaellRuCMsK3Ws8gUu3eX92q2WJDV7AJtjG2yX+
         BmTEkhjCP7LGZhJ6GDWHh/K5539XZg+R5E0bvQ4WVY+FvTvkMLn3wV0gp5opdxELw2Dy
         DYkSjDTFJdtHxX0cWAWNsmO4z3/tf3UWjf5KI1KDp8M2eiZUQj4ozZU+mSts0HNDRWm8
         yIdg==
X-Forwarded-Encrypted: i=1; AJvYcCVXI+9WAl4jXFcGmgYZSgSM9JcxH/K96XkINBkYSz1KwUeKKFhIyW/Ie5dwe074W8pGnD7T9b4HsWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTq0bxjVu6wqi8OPf98UW8DsbCeTVxqP6CwPImy7BKLqJBMPey
	iJsO6Q47g5zDBBRAqHWfE0DAsfmrssSUxwRpB64XKdVgd5/LhxSnCHXulu+Y9g==
X-Gm-Gg: ASbGncvg+Hedix0eu0SshOeVsy+wYDU9eymv/4Be33EOw/gQJzuYF9AoPpdYchMlRHh
	319R6n/0yIDMUpllBI8rcWu3pm0rV9uLmPwkYM5mGRqRLjfqJgDeic5ZQu8cemD5xvKBLbg8Wgt
	9l9dhh1q2XmLzfT04mCGM5A8q7/eBtxoJEG+XQkWXY6JGJg2TN+L4lTeLNqT+IT2w/NZ3UNujjf
	4FRVG0+q6Ap/OlKMEBWuj+Q5AGEo+nQADXGMIpS15zdfpBYlJFxAmdrvwVlUoHPxZJFV1eGzZEo
	YqozvqnJXptPHTzAMjVdG3pZM+4vZ0Pt+0gJfPtnx4rFJHuEV5J/HGaIJ0Rfmh/JmsKl/0xIO1C
	YacMawjD41za945IY+E/usi3WQ/iL8ZYP3z6+WXdVZVBglGyt8sNXAMi/ZAe5aMX1mccdeOV9Hk
	mBHuCA66ntYS0+
X-Google-Smtp-Source: AGHT+IFyg04p4vmAWYYqYopDiA9K0c+5VO3S1p5ojQc9nDKgbYghvFqLnysYQ8mR4kxsaglbDHmmCA==
X-Received: by 2002:a05:6102:448a:b0:5db:cec7:810b with SMTP id ada2fe7eead31-5e1de2cfa1dmr10324686137.29.1764301051479;
        Thu, 27 Nov 2025 19:37:31 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e24d94f2d2sm1170483137.8.2025.11.27.19.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 19:37:31 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Thu, 27 Nov 2025 22:37:11 -0500
Subject: [PATCH v2 2/2] iio: adc: Add ti-ads1018 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251127-ads1x18-v2-2-2ebfd780b633@gmail.com>
References: <20251127-ads1x18-v2-0-2ebfd780b633@gmail.com>
In-Reply-To: <20251127-ads1x18-v2-0-2ebfd780b633@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Tobias Sperling <tobias.sperling@softing.com>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=23363; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=kV1OALCUnGKVOlxwRw/qBr1IuNZxZdZwM6EY+WCt1WQ=;
 b=kA0DAAoWFmBDOPSf1GYByyZiAGkpGPWhmKo9I0g2abTB9QC9aFj0Xn5p9f/VA+i56XtKYTYu1
 Ih1BAAWCgAdFiEEh2Ci9uJabu1OwFXfFmBDOPSf1GYFAmkpGPUACgkQFmBDOPSf1GaKqwEApbZ+
 CusRbPorOqQDRxI1vVGnJjdQ1BYULNRql36Q08MA/0nJBISPlNPRuV/8FguGrSo7/x3Z48GqMhL
 Zk6gl+5QA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add ti-ads1018 driver for Texas Instruments ADS1018 and ADS1118 SPI
analog-to-digital converters.

These chips' MOSI pin is shared with a data-ready interrupt. Defining
this interrupt in devicetree is optional, therefore we only create an
IIO trigger if one is found.

Handling this interrupt requires some considerations. When enabling the
trigger the CS line is tied low (active), thus we need to hold
spi_bus_lock() too, to avoid state corruption. This is done inside the
set_trigger_state() callback, to let users use other triggers without
wasting a bus lock.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 MAINTAINERS                  |   1 +
 drivers/iio/adc/Kconfig      |  12 +
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/ti-ads1018.c | 716 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 730 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3d5295b5d6eb..b3822cbff2c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25651,6 +25651,7 @@ M:	Kurt Borja <kuurtb@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
+F:	drivers/iio/adc/ti-ads1018.c
 
 TI ADS7924 ADC DRIVER
 M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 58da8255525e..aa3f7023c64b 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1664,6 +1664,18 @@ config TI_ADS1015
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-ads1015.
 
+config TI_ADS1018
+       tristate "Texas Instruments ADS1018 ADC"
+       depends on SPI
+       select IIO_BUFFER
+       select IIO_TRIGGERED_BUFFER
+       help
+         If you say yes here you get support for Texas Instruments ADS1018 and
+         ADS1118 ADC chips.
+
+         This driver can also be built as a module. If so, the module will be
+         called ti-ads1018.
+
 config TI_ADS1100
 	tristate "Texas Instruments ADS1100 and ADS1000 ADC"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 7cc8f9a12f76..72ef79becdec 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -145,6 +145,7 @@ obj-$(CONFIG_TI_ADC12138) += ti-adc12138.o
 obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
 obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
 obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
+obj-$(CONFIG_TI_ADS1018) += ti-ads1018.o
 obj-$(CONFIG_TI_ADS1100) += ti-ads1100.o
 obj-$(CONFIG_TI_ADS1119) += ti-ads1119.o
 obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
diff --git a/drivers/iio/adc/ti-ads1018.c b/drivers/iio/adc/ti-ads1018.c
new file mode 100644
index 000000000000..e351d8bc9cd7
--- /dev/null
+++ b/drivers/iio/adc/ti-ads1018.c
@@ -0,0 +1,716 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Texas Instruments ADS1018 ADC driver
+ *
+ * Copyright (C) 2025 Kurt Borja <kuurtb@gmail.com>
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
+#include <linux/bits.h>
+#include <linux/byteorder/generic.h>
+#include <linux/dev_printk.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/math.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/units.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#define ADS1018_CFG_DEFAULT		0x058b
+
+#define ADS1018_CFG_OS_TRIG		BIT(15)
+#define ADS1018_CFG_TS_MODE_EN		BIT(4)
+#define ADS1018_CFG_PULL_UP		BIT(3)
+#define ADS1018_CFG_NOP			BIT(1)
+#define ADS1018_CFG_VALID		(ADS1018_CFG_PULL_UP | ADS1018_CFG_NOP)
+
+#define ADS1018_CFG_MUX_MASK		GENMASK(14, 12)
+
+#define ADS1018_CFG_PGA_MASK		GENMASK(11, 9)
+#define ADS1018_PGA_DEFAULT		2
+
+#define ADS1018_CFG_MODE_MASK		GENMASK(8, 8)
+#define ADS1018_MODE_CONTINUOUS		0
+#define ADS1018_MODE_ONESHOT		1
+
+#define ADS1018_CFG_DRATE_MASK		GENMASK(7, 5)
+#define ADS1018_DRATE_DEFAULT		4
+
+#define ADS1018_CHANNELS_MAX		10
+
+struct ads1018_chan_data {
+	u8 pga_mode;
+	u8 data_rate_mode;
+};
+
+struct ads1018_chip_info {
+	const char *name;
+
+	const struct iio_chan_spec *channels;
+	unsigned long num_channels;
+
+	/* IIO_VAL_INT */
+	const int *data_rate_mode_to_hz;
+	unsigned long num_data_rate_mode_to_hz;
+
+	/* IIO_VAL_INT_PLUS_NANO */
+	const int (*pga_mode_to_gain)[2];
+	unsigned long num_pga_mode_to_gain;
+
+	/* IIO_VAL_INT_PLUS_MICRO */
+	const int temp_scale[2];
+};
+
+struct ads1018 {
+	struct spi_device *spi;
+	struct iio_trigger *indio_trig;
+
+	struct gpio_desc *drdy_gpiod;
+	int drdy_irq;
+
+	bool restore_mode;
+
+	struct ads1018_chan_data chan_data[ADS1018_CHANNELS_MAX];
+	const struct ads1018_chip_info *chip_info;
+
+	struct spi_message msg_read;
+	struct spi_transfer xfer;
+	__be16 tx_buf[2] __aligned(IIO_DMA_MINALIGN);
+	__be16 rx_buf[2];
+};
+
+#define ADS1018_VOLT_DIFF_CHAN(_addr, _chan, _chan2, _realbits) {		\
+	.type = IIO_VOLTAGE,							\
+	.channel = _chan,							\
+	.channel2 = _chan2,							\
+	.scan_index = _addr,							\
+	.scan_type = {								\
+		.sign = 's',							\
+		.realbits = _realbits,						\
+		.storagebits = 16,						\
+		.shift = 16 - _realbits,					\
+		.endianness = IIO_BE,						\
+	},									\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
+			      BIT(IIO_CHAN_INFO_SCALE) |			\
+			      BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+	.indexed = true,							\
+	.differential = true,							\
+}
+
+#define ADS1018_VOLT_CHAN(_addr, _chan, _realbits) {				\
+	.type = IIO_VOLTAGE,							\
+	.channel = _chan,							\
+	.scan_index = _addr,							\
+	.scan_type = {								\
+		.sign = 's',							\
+		.realbits = _realbits,						\
+		.storagebits = 16,						\
+		.shift = 16 - _realbits,					\
+		.endianness = IIO_BE,						\
+	},									\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
+			      BIT(IIO_CHAN_INFO_SCALE) |			\
+			      BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+	.indexed = true,							\
+}
+
+#define ADS1018_TEMP_CHAN(_addr, _realbits) {					\
+	.type = IIO_TEMP,							\
+	.channel = 0,								\
+	.scan_index = _addr,							\
+	.scan_type = {								\
+		.sign = 's',							\
+		.realbits = _realbits,						\
+		.storagebits = 16,						\
+		.shift = 16 - _realbits,					\
+		.endianness = IIO_BE,						\
+	},									\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
+			      BIT(IIO_CHAN_INFO_SCALE) |			\
+			      BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+}
+
+static const struct iio_chan_spec ads1118_iio_channels[] = {
+	ADS1018_VOLT_DIFF_CHAN(0, 0, 1, 16),
+	ADS1018_VOLT_DIFF_CHAN(1, 0, 3, 16),
+	ADS1018_VOLT_DIFF_CHAN(2, 1, 3, 16),
+	ADS1018_VOLT_DIFF_CHAN(3, 2, 3, 16),
+	ADS1018_VOLT_CHAN(4, 0, 16),
+	ADS1018_VOLT_CHAN(5, 1, 16),
+	ADS1018_VOLT_CHAN(6, 2, 16),
+	ADS1018_VOLT_CHAN(7, 3, 16),
+	ADS1018_TEMP_CHAN(8, 14),
+	IIO_CHAN_SOFT_TIMESTAMP(9),
+};
+
+static const struct iio_chan_spec ads1018_iio_channels[] = {
+	ADS1018_VOLT_DIFF_CHAN(0, 0, 1, 12),
+	ADS1018_VOLT_DIFF_CHAN(1, 0, 3, 12),
+	ADS1018_VOLT_DIFF_CHAN(2, 1, 3, 12),
+	ADS1018_VOLT_DIFF_CHAN(3, 2, 3, 12),
+	ADS1018_VOLT_CHAN(4, 0, 12),
+	ADS1018_VOLT_CHAN(5, 1, 12),
+	ADS1018_VOLT_CHAN(6, 2, 12),
+	ADS1018_VOLT_CHAN(7, 3, 12),
+	ADS1018_TEMP_CHAN(8, 12),
+	IIO_CHAN_SOFT_TIMESTAMP(9),
+};
+
+static u8 ads1018_get_data_rate_mode(struct ads1018 *ads1018, unsigned int address)
+{
+	return ads1018->chan_data[address].data_rate_mode;
+}
+
+static u8 ads1018_get_pga_mode(struct ads1018 *ads1018, unsigned int address)
+{
+	return ads1018->chan_data[address].pga_mode;
+}
+
+static void ads1018_set_data_rate_mode(struct ads1018 *ads1018,
+				       unsigned int address, u8 val)
+{
+	ads1018->chan_data[address].data_rate_mode = val;
+}
+
+static void ads1018_set_pga_mode(struct ads1018 *ads1018,
+				 unsigned int address, u8 val)
+{
+	ads1018->chan_data[address].pga_mode = val;
+}
+
+static unsigned long ads1018_calc_delay(struct ads1018 *ads1018)
+{
+	const struct ads1018_chip_info *chip_info = ads1018->chip_info;
+	unsigned long mode = chip_info->num_data_rate_mode_to_hz - 1;
+	int hz = chip_info->data_rate_mode_to_hz[mode];
+
+	/* We subtract -10% data-rate error */
+	hz -= DIV_ROUND_UP(hz, 10);
+
+	/* Calculate time per sample in usecs */
+	return DIV_ROUND_UP(MICROHZ_PER_HZ, hz);
+}
+
+static int ads1018_read_locked(struct ads1018 *ads1018, __be16 *cnv, bool hold_cs)
+{
+	int ret;
+
+	ads1018->xfer.cs_change = hold_cs;
+
+	ret = spi_sync_locked(ads1018->spi, &ads1018->msg_read);
+	if (ret)
+		return ret;
+
+	*cnv = ads1018->rx_buf[0];
+
+	return 0;
+}
+
+static int ads1018_oneshot(struct ads1018 *ads1018, u16 cfg, u16 *cnv)
+{
+	struct spi_transfer xfer[2] = {
+		{
+			.tx_buf = ads1018->tx_buf,
+			.len = sizeof(ads1018->tx_buf),
+			.delay = {
+				.value = ads1018_calc_delay(ads1018),
+				.unit = SPI_DELAY_UNIT_USECS,
+			},
+		},
+		{
+			.rx_buf = ads1018->rx_buf,
+			.len = sizeof(ads1018->rx_buf),
+		},
+	};
+	int ret;
+
+	ads1018->tx_buf[0] = cpu_to_be16(cfg);
+	ads1018->tx_buf[1] = 0;
+
+	ret = spi_sync_transfer(ads1018->spi, xfer, ARRAY_SIZE(xfer));
+	if (ret)
+		return ret;
+
+	*cnv = be16_to_cpu(ads1018->rx_buf[0]);
+
+	return 0;
+}
+
+static int
+__ads1018_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+		   int *val, int *val2, long mask)
+{
+	struct ads1018 *ads1018 = iio_priv(indio_dev);
+	const struct ads1018_chip_info *chip_info = ads1018->chip_info;
+	u8 drate_mode = ads1018_get_data_rate_mode(ads1018, chan->scan_index);
+	u8 pga_mode = ads1018_get_pga_mode(ads1018, chan->scan_index);
+	u8 max_drate_mode = chip_info->num_data_rate_mode_to_hz - 1;
+	u16 cnv, cfg = 0;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		cfg |= ADS1018_CFG_VALID;
+		cfg |= ADS1018_CFG_OS_TRIG;
+		cfg |= FIELD_PREP(ADS1018_CFG_MUX_MASK, chan->scan_index);
+		cfg |= FIELD_PREP(ADS1018_CFG_PGA_MASK, pga_mode);
+		cfg |= FIELD_PREP(ADS1018_CFG_MODE_MASK, ADS1018_MODE_ONESHOT);
+		cfg |= FIELD_PREP(ADS1018_CFG_DRATE_MASK, max_drate_mode);
+		if (chan->type == IIO_TEMP)
+			cfg |= ADS1018_CFG_TS_MODE_EN;
+
+		ret = ads1018_oneshot(ads1018, cfg, &cnv);
+		if (ret)
+			return ret;
+
+		cnv >>= chan->scan_type.shift;
+		*val = sign_extend32(cnv, chan->scan_type.realbits - 1);
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			*val = chip_info->pga_mode_to_gain[pga_mode][0];
+			*val2 = chip_info->pga_mode_to_gain[pga_mode][1];
+			return IIO_VAL_INT_PLUS_NANO;
+
+		case IIO_TEMP:
+			*val = chip_info->temp_scale[0];
+			*val2 = chip_info->temp_scale[1];
+			return IIO_VAL_INT_PLUS_MICRO;
+
+		default:
+			return -EOPNOTSUPP;
+		}
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = chip_info->data_rate_mode_to_hz[drate_mode];
+		return IIO_VAL_INT;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int
+ads1018_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+		 int *val, int *val2, long mask)
+{
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+	ret = __ads1018_read_raw(indio_dev, chan, val, val2, mask);
+	iio_device_release_direct(indio_dev);
+
+	return ret;
+}
+
+static int
+ads1018_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+		   const int **vals, int *type, int *length, long mask)
+{
+	struct ads1018 *ads1018 = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*type = IIO_VAL_INT_PLUS_NANO;
+		*vals = (const int *)ads1018->chip_info->pga_mode_to_gain;
+		*length = ads1018->chip_info->num_pga_mode_to_gain * 2;
+		return IIO_AVAIL_LIST;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*type = IIO_VAL_INT;
+		*vals = ads1018->chip_info->data_rate_mode_to_hz;
+		*length = ads1018->chip_info->num_data_rate_mode_to_hz;
+		return IIO_AVAIL_LIST;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int
+__ads1018_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+		    int val, int val2, long mask)
+{
+	struct ads1018 *ads1018 = iio_priv(indio_dev);
+	const struct ads1018_chip_info *info = ads1018->chip_info;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		for (int i = 0; i < info->num_pga_mode_to_gain; i++) {
+			if (val != info->pga_mode_to_gain[i][0] ||
+			    val2 != info->pga_mode_to_gain[i][1])
+				continue;
+
+			ads1018_set_pga_mode(ads1018, chan->scan_index, i);
+			return 0;
+		}
+
+		return -EINVAL;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		for (int i = 0; i < info->num_data_rate_mode_to_hz; i++) {
+			if (val != info->data_rate_mode_to_hz[i])
+				continue;
+
+			ads1018_set_data_rate_mode(ads1018, chan->scan_index, i);
+			return 0;
+		}
+
+		return -EINVAL;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int
+ads1018_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+		  int val, int val2, long mask)
+{
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+	ret = __ads1018_write_raw(indio_dev, chan, val, val2, mask);
+	iio_device_release_direct(indio_dev);
+
+	return ret;
+}
+
+static int
+ads1018_write_raw_get_fmt(struct iio_dev *indio_dev,
+			  struct iio_chan_spec const *chan, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+}
+
+static const struct iio_info ads1018_iio_info = {
+	.read_raw = ads1018_read_raw,
+	.read_avail = ads1018_read_avail,
+	.write_raw = ads1018_write_raw,
+	.write_raw_get_fmt = ads1018_write_raw_get_fmt,
+};
+
+static int ads1018_set_trigger_state(struct iio_trigger *trig, bool state)
+{
+	struct ads1018 *ads1018 = iio_trigger_get_drvdata(trig);
+	__be16 cnv;
+
+	/*
+	 * We need to lock the SPI bus and tie CS low (hold_cs) to catch
+	 * data-ready interrupts, otherwise the MISO line enters a Hi-Z state.
+	 */
+
+	if (state) {
+		spi_bus_lock(ads1018->spi->controller);
+		ads1018_read_locked(ads1018, &cnv, true);
+		enable_irq(ads1018->drdy_irq);
+	} else {
+		disable_irq(ads1018->drdy_irq);
+		ads1018_read_locked(ads1018, &cnv, false);
+		spi_bus_unlock(ads1018->spi->controller);
+	}
+
+	return 0;
+}
+
+static const struct iio_trigger_ops ads1018_trigger_ops = {
+	.set_trigger_state = ads1018_set_trigger_state,
+	.validate_device = iio_trigger_validate_own_device,
+};
+
+static int ads1018_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct ads1018 *ads1018 = iio_priv(indio_dev);
+	const struct ads1018_chip_info *chip_info = ads1018->chip_info;
+	unsigned int pga, drate, addr;
+	u16 cfg = 0;
+
+	addr = find_first_bit(indio_dev->active_scan_mask,
+			      iio_get_masklength(indio_dev));
+	pga = ads1018_get_pga_mode(ads1018, addr);
+	drate = ads1018_get_data_rate_mode(ads1018, addr);
+
+	cfg |= ADS1018_CFG_VALID;
+	cfg |= FIELD_PREP(ADS1018_CFG_MUX_MASK, addr);
+	cfg |= FIELD_PREP(ADS1018_CFG_PGA_MASK, pga);
+	cfg |= FIELD_PREP(ADS1018_CFG_MODE_MASK, ADS1018_MODE_CONTINUOUS);
+	cfg |= FIELD_PREP(ADS1018_CFG_DRATE_MASK, drate);
+	if (chip_info->channels[addr].type == IIO_TEMP)
+		cfg |= ADS1018_CFG_TS_MODE_EN;
+
+	ads1018->tx_buf[0] = cpu_to_be16(cfg);
+	ads1018->tx_buf[1] = 0;
+
+	return spi_write(ads1018->spi, ads1018->tx_buf, sizeof(ads1018->tx_buf));
+}
+
+static int ads1018_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct ads1018 *ads1018 = iio_priv(indio_dev);
+
+	ads1018->tx_buf[0] = cpu_to_be16(ADS1018_CFG_DEFAULT);
+	ads1018->tx_buf[1] = 0;
+
+	return spi_write(ads1018->spi, ads1018->tx_buf, sizeof(ads1018->tx_buf));
+}
+
+static const struct iio_buffer_setup_ops ads1018_buffer_ops = {
+	.preenable = ads1018_buffer_preenable,
+	.postdisable = ads1018_buffer_postdisable,
+	.validate_scan_mask = iio_validate_scan_mask_onehot,
+};
+
+static irqreturn_t ads1018_irq_handler(int irq, void *dev_id)
+{
+	struct ads1018 *ads1018 = dev_id;
+
+	/*
+	 * We need to check if the "drdy" pin is actually active or if it's a
+	 * pending interrupt triggered by the SPI transfer.
+	 */
+	if (ads1018->drdy_gpiod && !gpiod_get_value(ads1018->drdy_gpiod))
+		return IRQ_HANDLED;
+
+	iio_trigger_poll(ads1018->indio_trig);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t ads1018_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ads1018 *ads1018 = iio_priv(indio_dev);
+	struct {
+		__be16 conv;
+		aligned_s64 ts;
+	} scan = {};
+	int ret;
+
+	if (iio_device_claim_buffer_mode(indio_dev))
+		goto out_notify_done;
+
+	if (iio_trigger_using_own(indio_dev)) {
+		disable_irq(ads1018->drdy_irq);
+		ret = ads1018_read_locked(ads1018, &scan.conv, true);
+		enable_irq(ads1018->drdy_irq);
+	} else {
+		ret = spi_read(ads1018->spi, ads1018->rx_buf,
+			       sizeof(ads1018->rx_buf));
+		scan.conv = ads1018->rx_buf[0];
+	}
+
+	iio_device_release_buffer_mode(indio_dev);
+
+	if (!ret)
+		iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+					    pf->timestamp);
+
+out_notify_done:
+	iio_trigger_notify_done(ads1018->indio_trig);
+
+	return IRQ_HANDLED;
+}
+
+static int ads1018_trigger_setup(struct iio_dev *indio_dev)
+{
+	struct ads1018 *ads1018 = iio_priv(indio_dev);
+	struct spi_device *spi = ads1018->spi;
+	int ret;
+
+	ads1018->drdy_gpiod = devm_gpiod_get_optional(&spi->dev, "drdy",
+						      GPIOD_IN);
+	if (IS_ERR(ads1018->drdy_gpiod))
+		return dev_err_probe(&spi->dev, PTR_ERR(ads1018->drdy_gpiod),
+				     "Failed to get 'drdy' GPIO.\n");
+
+	if (spi->irq > 0) {
+		ads1018->drdy_irq = spi->irq;
+	} else if (ads1018->drdy_gpiod) {
+		ads1018->drdy_irq = gpiod_to_irq(ads1018->drdy_gpiod);
+		if (ads1018->drdy_irq < 0)
+			return dev_err_probe(&spi->dev, ads1018->drdy_irq,
+					     "Failed to get IRQ from 'drdy' GPIO.\n");
+	} else {
+		return 0;
+	}
+
+	ads1018->indio_trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d-drdy",
+						     indio_dev->name,
+						     iio_device_id(indio_dev));
+	if (!ads1018->indio_trig)
+		return -ENOMEM;
+
+	iio_trigger_set_drvdata(ads1018->indio_trig, ads1018);
+	ads1018->indio_trig->ops = &ads1018_trigger_ops;
+
+	ret = devm_iio_trigger_register(&spi->dev, ads1018->indio_trig);
+	if (ret)
+		return ret;
+
+	/*
+	 * The "data-ready" IRQ line is shared with the MOSI pin, thus we need
+	 * to keep it disabled until we actually request data.
+	 */
+	return devm_request_irq(&spi->dev, ads1018->drdy_irq, ads1018_irq_handler,
+			       IRQF_NO_AUTOEN, ads1018->chip_info->name, ads1018);
+}
+
+static int ads1018_spi_probe(struct spi_device *spi)
+{
+	const struct ads1018_chip_info *info = spi_get_device_match_data(spi);
+	struct iio_dev *indio_dev;
+	struct ads1018 *ads1018;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*ads1018));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	ads1018 = iio_priv(indio_dev);
+	ads1018->spi = spi;
+	ads1018->chip_info = info;
+	spi_set_drvdata(spi, ads1018);
+
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = info->name;
+	indio_dev->info = &ads1018_iio_info;
+	indio_dev->channels = info->channels;
+	indio_dev->num_channels = info->num_channels;
+
+	for (int i = 0; i < ADS1018_CHANNELS_MAX; i++) {
+		ads1018->chan_data[i].data_rate_mode = ADS1018_DRATE_DEFAULT;
+		ads1018->chan_data[i].pga_mode = ADS1018_PGA_DEFAULT;
+	}
+
+	ads1018->xfer.rx_buf = ads1018->rx_buf;
+	ads1018->xfer.len = sizeof(ads1018->rx_buf);
+	spi_message_init_with_transfers(&ads1018->msg_read, &ads1018->xfer, 1);
+
+	ret = ads1018_trigger_setup(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      ads1018_trigger_handler,
+					      &ads1018_buffer_ops);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+#define ADS1018_FSR_TO_SCALE(_fsr, _res) \
+	{ 0, ((_fsr) * MICRO) / BIT(_res) }
+
+static const int ads1018_gain_table[][2] = {
+	ADS1018_FSR_TO_SCALE(6144, 11),
+	ADS1018_FSR_TO_SCALE(4096, 11),
+	ADS1018_FSR_TO_SCALE(2048, 11),
+	ADS1018_FSR_TO_SCALE(1024, 11),
+	ADS1018_FSR_TO_SCALE(512, 11),
+	ADS1018_FSR_TO_SCALE(256, 11),
+};
+
+static const int ads1118_gain_table[][2] = {
+	ADS1018_FSR_TO_SCALE(6144, 15),
+	ADS1018_FSR_TO_SCALE(4096, 15),
+	ADS1018_FSR_TO_SCALE(2048, 15),
+	ADS1018_FSR_TO_SCALE(1024, 15),
+	ADS1018_FSR_TO_SCALE(512, 15),
+	ADS1018_FSR_TO_SCALE(256, 15),
+};
+
+static const unsigned int ads1018_data_rate_table[] = {
+	128, 250, 490, 920, 1600, 2400, 3300
+};
+
+static const unsigned int ads1118_data_rate_table[] = {
+	8, 16, 32, 64, 128, 250, 475, 860
+};
+
+static const struct ads1018_chip_info ads1018_chip_info = {
+	.name = "ads1018",
+
+	.channels = ads1018_iio_channels,
+	.num_channels = ARRAY_SIZE(ads1018_iio_channels),
+
+	.pga_mode_to_gain = ads1018_gain_table,
+	.num_pga_mode_to_gain = ARRAY_SIZE(ads1018_gain_table),
+
+	.data_rate_mode_to_hz = ads1018_data_rate_table,
+	.num_data_rate_mode_to_hz = ARRAY_SIZE(ads1018_data_rate_table),
+
+	.temp_scale = { 0, 125000 },
+};
+
+static const struct ads1018_chip_info ads1118_chip_info = {
+	.name = "ads1118",
+
+	.channels = ads1118_iio_channels,
+	.num_channels = ARRAY_SIZE(ads1118_iio_channels),
+
+	.pga_mode_to_gain = ads1118_gain_table,
+	.num_pga_mode_to_gain = ARRAY_SIZE(ads1118_gain_table),
+
+	.data_rate_mode_to_hz = ads1118_data_rate_table,
+	.num_data_rate_mode_to_hz = ARRAY_SIZE(ads1118_data_rate_table),
+
+	.temp_scale = { 0, 31250 },
+};
+
+static const struct of_device_id ads1018_of_match[] = {
+	{ .compatible = "ti,ads1018", .data = &ads1018_chip_info },
+	{ .compatible = "ti,ads1118", .data = &ads1118_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ads1018_of_match);
+
+static const struct spi_device_id ads1018_spi_match[] = {
+	{ "ads1018", (kernel_ulong_t)&ads1018_chip_info },
+	{ "ads1118", (kernel_ulong_t)&ads1118_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ads1018_spi_match);
+
+static struct spi_driver ads1018_spi_driver = {
+	.driver = {
+		.name = "ads1018",
+		.of_match_table = ads1018_of_match,
+	},
+	.probe = ads1018_spi_probe,
+	.id_table = ads1018_spi_match,
+};
+
+module_spi_driver(ads1018_spi_driver);
+
+MODULE_DESCRIPTION("Texas Instruments ADS1018 ADC Driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Kurt Borja <kuurtb@gmail.com>");

-- 
2.52.0


