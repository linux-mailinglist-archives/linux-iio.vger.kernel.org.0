Return-Path: <linux-iio+bounces-26764-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFD1CA4DE1
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 19:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4BD03061EA6
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 18:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1224A357A52;
	Thu,  4 Dec 2025 17:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWQB+uSt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AB1357711
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764870986; cv=none; b=VoSJErhNrHXFtIGbTnAewPy1J45w1Mjt1wVPzNFvTVQ/DvAPqNQ740Qhu00JEOrdj4eqDY2QoILMFSrMZXtc/nY9tAPCntsKzgYwArdJaMQFl2FMqBFKNveUvmSfxL27jUUYTOhHC8RNDfz68s6j67oVOQZRpo+Dp6z7wd735dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764870986; c=relaxed/simple;
	bh=jF54Nbfiey3JRWMYm78ZyQSX9TqcX1MX5At9Bd69ACU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V5dwOecHxJN3HqO1UdU1r7a00gD5UA+kZm/KvT9CNys7sgduRoHAtM8Oj/jRXkFb16b/4JNP14W4DK4nnCYxS2pTk6v2x5wha/uLQm4LUFdnhlhFQ4heE2YzDS0w31ymxiE5OYT4VD51F5aLpNITeK0ShyIRMu92cFpJ8sTszu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWQB+uSt; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-55b2f2ae1cbso866443e0c.1
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 09:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764870982; x=1765475782; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/zWzpIKpuDO3iPAxggYRiDk8vFcf3HrY+KlmEjcyBw=;
        b=eWQB+uStp0xbYmiRHlpuhfVo0eQfNVi99TN+tPZvt/QqVagEp9c2wssrU7+sfFtJ6b
         mlNKZL8HMprMTckCHlis5BjFUwJsiGwOpspmrIAxbpUVPWlzORmpsFaLPAqRLO7UyUPQ
         Q7PADAeXSEAiamVWTZdYy9V1vZ2Xon/sS+osNl949EjnGuP+OVety9xD9wDa+Rb+JYaA
         pbS38tnl8XvY7ZL1p205GbchP/80Ieon7+eUnhomoJIcvJt+Pbp1/9igGMRAUR2xJEUw
         bej1gfj8B3b5NlAbT4Jsj3mgDlV/fMkUeplSrj7bKCm25vhXCNiXd8YDzZPyM+Od9kGj
         YwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764870982; x=1765475782;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h/zWzpIKpuDO3iPAxggYRiDk8vFcf3HrY+KlmEjcyBw=;
        b=rgA/cGZmJkCkE8k+T2sAzKiwk019nxco/nVpeVE5qnnyXu2XbRXSgsoTSNrvpyh4f+
         3wP9fbsYiqHzdFZP3ppt3GHHzuClPvKPVxdr4s1ayieK5tK65zY4e1sfIHYrmZ6jsKvw
         jq6EFAp/GBtgiSj1dQmvt0N1S76q9RH/OIv1mWMVwoa1fUHLA792R0Ni7mP7BZ+fV/TR
         mmp7Ffn1Rgk+yudPvKVfMwdG2sg1XC5HW+6tdpmFujlgVqjfL/Oba5BfAtrDhMKbA9LV
         2Y2MISkE4kcrf1jitTdSTixa/X85QXQDeyIeMWkQjqaSwRp7GXwMvWl4Mecrl+uQrNyk
         I7lw==
X-Forwarded-Encrypted: i=1; AJvYcCVmILc6rsJ5yyxo1nq/1aO9FQbMn4ryKlOwyL1ZVwuZ9ZeH59HvDfUfQH9+6YbKyg7aoskP40iRky8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjgLvyTp6cHZyNSxX5n1B6vRrFPbNNSPf1K9AIhabQBQ0pF+fM
	tXC5hBxPRwEbIk2x2Etb2t9qCyMO5cX8DK4GkeUcn3kWzW8jUFL0n8vj
X-Gm-Gg: ASbGncuv0OdvLj4XSbANOALlidpqb0DqFkwzdmr2n/axm+7opj1+40k4wFnow+eBmfK
	T0nHLeTdwT4Wun8HwBttGoqJZz8h/Bb+Hy21um+7+ExRoG2fv4VuKPZdtuRSy0245vNvOZhcIXN
	774KrDo3H/kp3Zb/BwMA3XCUO0Wswau7K/3OyBfC+5MRqYL9H2U1kU/BdQTcqvPUj1/Z26Brtel
	mZd3fG8VsqSsY1AFW1JDPBqgXoDpQHmtPQ6Hpk5RGxu5CojikJwys4pNgX5f0/gpWtwzUSM1Nbr
	rLX940gtO1oIwRs4Muxvrf0vXnykER5lk3qmBoiLdOrW7/ffA2swvpLJiIpkICtkpsP2nI6I+3m
	+soRXhT1r6/1oSaYc1qAqXnYIfXr+CyoiQ5hOMUuI8qkK6XJR0q+8VuqKEgOs3REG4n/fF4BQmS
	G1tmUojmH04KU3inA=
X-Google-Smtp-Source: AGHT+IG5lFDXIWrwgaZNzHEoYvpLhM0nu/Oy9cVAHHbB1oUiSkAKTHWU5dUV1OoyXWmu2+ExVyBZgg==
X-Received: by 2002:a05:6122:7c6:b0:559:623a:3aa9 with SMTP id 71dfb90a1353d-55e69d99c13mr1413241e0c.1.1764870981610;
        Thu, 04 Dec 2025 09:56:21 -0800 (PST)
Received: from [192.168.100.61] ([2800:bf0:4580:3149:7d4:54b1:c444:6f2f])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55e6c97cea1sm921105e0c.17.2025.12.04.09.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 09:56:21 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Thu, 04 Dec 2025 12:55:42 -0500
Subject: [PATCH v5 2/2] iio: adc: Add ti-ads1018 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-ads1x18-v5-2-b6243de766d1@gmail.com>
References: <20251204-ads1x18-v5-0-b6243de766d1@gmail.com>
In-Reply-To: <20251204-ads1x18-v5-0-b6243de766d1@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=27010; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=jF54Nbfiey3JRWMYm78ZyQSX9TqcX1MX5At9Bd69ACU=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJmGpx10an7r9O4tezojubTtoO9341ly73wF47adNzxxq
 2/fkpuzO0pZGMS4GGTFFFnaExZ9exSV99bvQOh9mDmsTCBDGLg4BWAiH9cy/K8KO6Y+5ZNCmWhc
 0Yu4idvfP5PW2vU0VN7/+7dtAh8PGu5gZFiXEvRBPe3ti9q4/s0z/sytEvobZ3D7b8zOCXm6Tg1
 Z+zgA
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
 drivers/iio/adc/ti-ads1018.c | 826 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 840 insertions(+)

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
index 000000000000..8ee1ea9d9463
--- /dev/null
+++ b/drivers/iio/adc/ti-ads1018.c
@@ -0,0 +1,826 @@
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
+#include <linux/dev_printk.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/math.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <asm/byteorder.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
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
+#define ADS1018_CFG_MODE_MASK		BIT(8)
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
+	const unsigned int *data_rate_mode_to_hz;
+	unsigned long num_data_rate_mode_to_hz;
+
+	/* IIO_VAL_INT_PLUS_NANO */
+	const unsigned int (*pga_mode_to_gain)[2];
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
+#define ADS1018_VOLT_DIFF_CHAN(_index, _chan, _chan2, _realbits) {		\
+	.type = IIO_VOLTAGE,							\
+	.channel = _chan,							\
+	.channel2 = _chan2,							\
+	.scan_index = _index,							\
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
+#define ADS1018_VOLT_CHAN(_index, _chan, _realbits) {				\
+	.type = IIO_VOLTAGE,							\
+	.channel = _chan,							\
+	.scan_index = _index,							\
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
+#define ADS1018_TEMP_CHAN(_index, _realbits) {					\
+	.type = IIO_TEMP,							\
+	.scan_index = _index,							\
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
+/**
+ * ads1018_get_data_rate_mode - Get current data-rate mode for a channel.
+ * @ads1018: Device data
+ * @address: Channel address
+ *
+ * Context: Expects iio_device_claim_direct() is held.
+ *
+ * Return: Current data-rate mode for the channel at @address.
+ */
+static u8 ads1018_get_data_rate_mode(struct ads1018 *ads1018, unsigned int address)
+{
+	return ads1018->chan_data[address].data_rate_mode;
+}
+
+/**
+ * ads1018_get_pga_mode - Get current PGA mode for a channel.
+ * @ads1018: Device data
+ * @address: Channel address
+ *
+ * Context: Expects iio_device_claim_direct() is held.
+ *
+ * Return: Current PGA mode for the channel at @address.
+ */
+static u8 ads1018_get_pga_mode(struct ads1018 *ads1018, unsigned int address)
+{
+	return ads1018->chan_data[address].pga_mode;
+}
+
+/**
+ * ads1018_set_data_rate_mode - Set a data-rate mode for a channel.
+ * @ads1018: Device data
+ * @address: Channel address
+ * @val: New data-rate mode for channel at @address.
+ *
+ * Context: Expects iio_device_claim_direct() is held.
+ *
+ * Lazily set a new data-rate mode for a channel.
+ */
+static void ads1018_set_data_rate_mode(struct ads1018 *ads1018,
+				       unsigned int address, u8 val)
+{
+	ads1018->chan_data[address].data_rate_mode = val;
+}
+
+/**
+ * ads1018_set_pga_mode - Set a PGA mode for a channel.
+ * @ads1018: Device data
+ * @address: Channel address
+ * @val: New PGA mode for channel at @address.
+ *
+ * Context: Expects iio_device_claim_direct() is held.
+ *
+ * Lazily set a new PGA mode for a channel.
+ */
+static void ads1018_set_pga_mode(struct ads1018 *ads1018,
+				 unsigned int address, u8 val)
+{
+	ads1018->chan_data[address].pga_mode = val;
+}
+
+/**
+ * ads1018_calc_delay - Calculates a suitable delay for a single-shot reading
+ * @ads1018: Device data
+ *
+ * Calculates an appropriate delay for a single shot reading, assuming the
+ * device's maximum data-rate is used.
+ *
+ * Context: Expects iio_device_claim_direct() is held.
+ *
+ * Return: Delay in microseconds (Always greater than 0).
+ */
+static u32 ads1018_calc_delay(struct ads1018 *ads1018)
+{
+	const struct ads1018_chip_info *chip_info = ads1018->chip_info;
+	unsigned long max_drate_mode = chip_info->num_data_rate_mode_to_hz - 1;
+	unsigned int hz = chip_info->data_rate_mode_to_hz[max_drate_mode];
+
+	/*
+	 * Calculate the worst-case sampling rate on the maximum data-rate
+	 * mode by subtracting 10% error specified in the datasheet.
+	 */
+	hz -= DIV_ROUND_UP(hz, 10);
+
+	/*
+	 * Then calculate time per sample in microseconds.
+	 */
+	return DIV_ROUND_UP(MICROHZ_PER_HZ, hz);
+}
+
+/**
+ * ads1018_spi_read_exclusive - Reads a conversion value from the device
+ * @ads1018: Device data
+ * @cnv: ADC Conversion value (optional)
+ * @hold_cs: Keep CS line asserted after the SPI transfer
+ *
+ * Reads the most recent ADC conversion value, without updating the
+ * device's configuration.
+ *
+ * Context: Expects iio_device_claim_buffer_mode() is held and SPI bus
+ *	    *exclusive* use.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+static int ads1018_spi_read_exclusive(struct ads1018 *ads1018, __be16 *cnv,
+				      bool hold_cs)
+{
+	int ret;
+
+	ads1018->xfer.cs_change = hold_cs;
+
+	ret = spi_sync_locked(ads1018->spi, &ads1018->msg_read);
+	if (ret)
+		return ret;
+
+	if (cnv)
+		*cnv = ads1018->rx_buf[0];
+
+	return 0;
+}
+
+/**
+ * ads1018_single_shot - Performs a one-shot reading sequence
+ * @ads1018: Device data
+ * @cfg: New configuration for the device
+ * @cnv: Conversion value
+ *
+ * Writes a new configuration, waits an appropriate delay (assuming the new
+ * configuration uses the maximum data-rate) and then reads the most recent
+ * conversion.
+ *
+ * Context: Expects iio_device_claim_direct() is held.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+static int ads1018_single_shot(struct ads1018 *ads1018, u16 cfg, u16 *cnv)
+{
+	struct spi_transfer xfer[2] = {
+		{
+			.tx_buf = ads1018->tx_buf,
+			.len = sizeof(ads1018->tx_buf[0]),
+			.delay = {
+				.value = ads1018_calc_delay(ads1018),
+				.unit = SPI_DELAY_UNIT_USECS,
+			},
+			.cs_change = 1, /* 16-bit mode requires CS de-assert */
+		},
+		{
+			.rx_buf = ads1018->rx_buf,
+			.len = sizeof(ads1018->rx_buf[0]),
+		},
+	};
+	int ret;
+
+	ads1018->tx_buf[0] = cpu_to_be16(cfg);
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
+ads1018_read_raw_unlocked(struct iio_dev *indio_dev,
+			  struct iio_chan_spec const *chan, int *val, int *val2,
+			  long mask)
+{
+	struct ads1018 *ads1018 = iio_priv(indio_dev);
+	const struct ads1018_chip_info *chip_info = ads1018->chip_info;
+	u8 drate_mode = ads1018_get_data_rate_mode(ads1018, chan->scan_index);
+	u8 pga_mode = ads1018_get_pga_mode(ads1018, chan->scan_index);
+	u8 max_drate_mode = chip_info->num_data_rate_mode_to_hz - 1;
+	u16 cnv, cfg;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		cfg = ADS1018_CFG_VALID | ADS1018_CFG_OS_TRIG;
+		cfg |= FIELD_PREP(ADS1018_CFG_MUX_MASK, chan->scan_index);
+		cfg |= FIELD_PREP(ADS1018_CFG_PGA_MASK, pga_mode);
+		cfg |= FIELD_PREP(ADS1018_CFG_MODE_MASK, ADS1018_MODE_ONESHOT);
+		cfg |= FIELD_PREP(ADS1018_CFG_DRATE_MASK, max_drate_mode);
+
+		if (chan->type == IIO_TEMP)
+			cfg |= ADS1018_CFG_TS_MODE_EN;
+
+		ret = ads1018_single_shot(ads1018, cfg, &cnv);
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
+	ret = ads1018_read_raw_unlocked(indio_dev, chan, val, val2, mask);
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
+ads1018_write_raw_unlocked(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan, int val, int val2,
+			   long mask)
+{
+	struct ads1018 *ads1018 = iio_priv(indio_dev);
+	const struct ads1018_chip_info *info = ads1018->chip_info;
+	unsigned int i;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		for (i = 0; i < info->num_pga_mode_to_gain; i++) {
+			if (val == info->pga_mode_to_gain[i][0] &&
+			    val2 == info->pga_mode_to_gain[i][1])
+				break;
+		}
+		if (i == info->num_pga_mode_to_gain)
+			return -EINVAL;
+
+		ads1018_set_pga_mode(ads1018, chan->scan_index, i);
+		return 0;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		for (i = 0; i < info->num_data_rate_mode_to_hz; i++) {
+			if (val == info->data_rate_mode_to_hz[i])
+				break;
+		}
+		if (i == info->num_data_rate_mode_to_hz)
+			return -EINVAL;
+
+		ads1018_set_data_rate_mode(ads1018, chan->scan_index, i);
+		return 0;
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
+	ret = ads1018_write_raw_unlocked(indio_dev, chan, val, val2, mask);
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
+static void ads1018_set_trigger_enable(struct ads1018 *ads1018)
+{
+	spi_bus_lock(ads1018->spi->controller);
+	ads1018_spi_read_exclusive(ads1018, NULL, true);
+	enable_irq(ads1018->drdy_irq);
+}
+
+static void ads1018_set_trigger_disable(struct ads1018 *ads1018)
+{
+	disable_irq(ads1018->drdy_irq);
+	ads1018_spi_read_exclusive(ads1018, NULL, false);
+	spi_bus_unlock(ads1018->spi->controller);
+}
+
+static int ads1018_set_trigger_state(struct iio_trigger *trig, bool state)
+{
+	struct ads1018 *ads1018 = iio_trigger_get_drvdata(trig);
+
+	/*
+	 * We need to lock the SPI bus and tie CS low (hold_cs) to catch
+	 * data-ready interrupts, otherwise the MISO line enters a Hi-Z state.
+	 */
+
+	if (state)
+		ads1018_set_trigger_enable(ads1018);
+	else
+		ads1018_set_trigger_disable(ads1018);
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
+	u16 cfg;
+
+	addr = find_first_bit(indio_dev->active_scan_mask, iio_get_masklength(indio_dev));
+	pga = ads1018_get_pga_mode(ads1018, addr);
+	drate = ads1018_get_data_rate_mode(ads1018, addr);
+
+	cfg = ADS1018_CFG_VALID;
+	cfg |= FIELD_PREP(ADS1018_CFG_MUX_MASK, addr);
+	cfg |= FIELD_PREP(ADS1018_CFG_PGA_MASK, pga);
+	cfg |= FIELD_PREP(ADS1018_CFG_MODE_MASK, ADS1018_MODE_CONTINUOUS);
+	cfg |= FIELD_PREP(ADS1018_CFG_DRATE_MASK, drate);
+
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
+	u16 cfg;
+
+	cfg = ADS1018_CFG_VALID;
+	cfg |= FIELD_PREP(ADS1018_CFG_MODE_MASK, ADS1018_MODE_ONESHOT);
+
+	ads1018->tx_buf[0] = cpu_to_be16(cfg);
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
+	if (!gpiod_get_value(ads1018->drdy_gpiod))
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
+		ret = ads1018_spi_read_exclusive(ads1018, &scan.conv, true);
+		enable_irq(ads1018->drdy_irq);
+	} else {
+		ret = spi_read(ads1018->spi, ads1018->rx_buf, sizeof(ads1018->rx_buf));
+		scan.conv = ads1018->rx_buf[0];
+	}
+	if (ret)
+		goto out_release_buffer;
+
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), pf->timestamp);
+
+out_release_buffer:
+	iio_device_release_buffer_mode(indio_dev);
+out_notify_done:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int ads1018_trigger_setup(struct iio_dev *indio_dev)
+{
+	struct ads1018 *ads1018 = iio_priv(indio_dev);
+	struct spi_device *spi = ads1018->spi;
+	struct device *dev = &spi->dev;
+	const char *con_id = "drdy";
+	int ret;
+
+	ads1018->drdy_gpiod = devm_gpiod_get_optional(dev, con_id, GPIOD_IN);
+	if (IS_ERR(ads1018->drdy_gpiod))
+		return dev_err_probe(dev, PTR_ERR(ads1018->drdy_gpiod),
+				     "Failed to get %s GPIO.\n", con_id);
+
+	/* First try to get IRQ from SPI core, then from GPIO */
+	if (spi->irq > 0)
+		ads1018->drdy_irq = spi->irq;
+	else if (ads1018->drdy_gpiod)
+		ads1018->drdy_irq = gpiod_to_irq(ads1018->drdy_gpiod);
+	if (ads1018->drdy_irq < 0)
+		return dev_err_probe(dev, ads1018->drdy_irq,
+				     "Failed to get IRQ from %s GPIO.\n", con_id);
+
+	/* An IRQ line is only an optional requirement for the IIO trigger */
+	if (ads1018->drdy_irq == 0)
+		return 0;
+
+	ads1018->indio_trig = devm_iio_trigger_alloc(dev, "%s-dev%d-%s",
+						     indio_dev->name,
+						     iio_device_id(indio_dev),
+						     con_id);
+	if (!ads1018->indio_trig)
+		return -ENOMEM;
+
+	iio_trigger_set_drvdata(ads1018->indio_trig, ads1018);
+	ads1018->indio_trig->ops = &ads1018_trigger_ops;
+
+	ret = devm_iio_trigger_register(dev, ads1018->indio_trig);
+	if (ret)
+		return ret;
+
+	/*
+	 * The "data-ready" IRQ line is shared with the MOSI pin, thus we need
+	 * to keep it disabled until we actually request data.
+	 */
+	return devm_request_irq(dev, ads1018->drdy_irq, ads1018_irq_handler,
+				IRQF_NO_AUTOEN, ads1018->chip_info->name, ads1018);
+}
+
+static int ads1018_spi_probe(struct spi_device *spi)
+{
+	const struct ads1018_chip_info *info = spi_get_device_match_data(spi);
+	struct device *dev = &spi->dev;
+	struct iio_dev *indio_dev;
+	struct ads1018 *ads1018;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*ads1018));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	ads1018 = iio_priv(indio_dev);
+	ads1018->spi = spi;
+	ads1018->chip_info = info;
+
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = info->name;
+	indio_dev->info = &ads1018_iio_info;
+	indio_dev->channels = info->channels;
+	indio_dev->num_channels = info->num_channels;
+
+	for (unsigned int i = 0; i < ADS1018_CHANNELS_MAX; i++) {
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
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      ads1018_trigger_handler,
+					      &ads1018_buffer_ops);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+/**
+ * ADS1018_FSR_TO_SCALE - Converts FSR into scale
+ * @_fsr: Full-scale range in millivolts
+ * @_res: ADC resolution
+ *
+ * The macro is crafted to avoid potential overflows on 32-bit machines. This
+ * imposes restrictions on the possible values for @_fsr (less than 274878),
+ * and @_res (greater than or equal to 6 bits).
+ *
+ * Return: Scale in IIO_VAL_INT_PLUS_NANO format
+ */
+#define ADS1018_FSR_TO_SCALE(_fsr, _res) \
+	{ 0, ((_fsr) * (MICRO >> 6)) / (BIT((_res) - 1) >> 6) }
+
+static const unsigned int ads1018_gain_table[][2] = {
+	ADS1018_FSR_TO_SCALE(6144, 12),
+	ADS1018_FSR_TO_SCALE(4096, 12),
+	ADS1018_FSR_TO_SCALE(2048, 12),
+	ADS1018_FSR_TO_SCALE(1024, 12),
+	ADS1018_FSR_TO_SCALE(512, 12),
+	ADS1018_FSR_TO_SCALE(256, 12),
+};
+
+static const unsigned int ads1118_gain_table[][2] = {
+	ADS1018_FSR_TO_SCALE(6144, 16),
+	ADS1018_FSR_TO_SCALE(4096, 16),
+	ADS1018_FSR_TO_SCALE(2048, 16),
+	ADS1018_FSR_TO_SCALE(1024, 16),
+	ADS1018_FSR_TO_SCALE(512, 16),
+	ADS1018_FSR_TO_SCALE(256, 16),
+};
+
+static const unsigned int ads1018_data_rate_table[] = {
+	128, 250, 490, 920, 1600, 2400, 3300,
+};
+
+static const unsigned int ads1118_data_rate_table[] = {
+	8, 16, 32, 64, 128, 250, 475, 860,
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


