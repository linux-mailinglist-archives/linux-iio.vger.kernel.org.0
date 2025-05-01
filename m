Return-Path: <linux-iio+bounces-18927-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C4EAA5CEB
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 12:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED7B189E5BB
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 10:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B902B21931B;
	Thu,  1 May 2025 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndzVYNdZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A173421422B;
	Thu,  1 May 2025 10:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746093700; cv=none; b=K5yhoSfWEAaCy1+3ULoCEicBEigpmpxImWSrP7uKvQopdvvZieS/BxnQKUsWOROynTrnwtbskBrgGvMzxe2xZE4LfZrA2MDettVuh4XITF+oaePG/AkZcLpjnZ//s27ppSUHHnhRpEyn8CeGZB73ppY87R9L5dNkHkvLwhZOvFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746093700; c=relaxed/simple;
	bh=j3UiZr5I0BZ0R0iZxPPxb6ntqJ2vhywnYgSy7Jt1j9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p90AVryGaDGdDR05QM+xgDKGxqqXRyZWLd2JWW/UMCK5Om693hL0nvBHe01MFhZnw3dQnROxXMWVctZfBGrlGUIvrk7+roOEIWxr1tWQ7XJfVsTk0pOJb+O+IGrY7IhTDSn9tB4GGJaD+m8hrg7mmCbhRVlFmidHANHKkXu1NA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndzVYNdZ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-30155bbbed9so711259a91.1;
        Thu, 01 May 2025 03:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746093698; x=1746698498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mc8onLY2LGr4PGgeqQsnCbETY9vwRghe23s2uHPKPqY=;
        b=ndzVYNdZH2CzexCwj2keHER27t0tmkdz2zJnJCYe7KtveReSw+khI0WgpoakeAGiBI
         MuVebHuceqmegEY/8obqgala40ONPGOHkLcMqN631Cen4M6ZHtyEt98RvYPPNu+6DOag
         G9SmG2NohuXTvvBoW2Kfqu697+j8Ihunp28CJCEqpxPR2TVGh66dbscVQLpYT5OapWZE
         tIeZinmgasQL6ctLgL0wK+734H8g4NpVXfATE9Hn1ewjQVQOsXT+7EXqnzLe9d35jgk3
         xlxJv6CNIsdPnMaLeUAgALocPyZbCEkCm1k8iY9BNigJCVbDXxQEgE34Q6t8HF9+zsGJ
         k4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746093698; x=1746698498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mc8onLY2LGr4PGgeqQsnCbETY9vwRghe23s2uHPKPqY=;
        b=sohKVRWH43Yt1/T+cV18ge+70Frvb6LKFlFUmlQb289CmTKSHAtckqpVvsxQwH0apU
         +UW30swxGRS+zVuE945LiBD21Eia9wM+JvWpnQnHw63cpEM32I3BUjEXGtEbXI5+xpS6
         A0cvjxsSfZ5N6fO4IiMCNxxX9q/4mFTKMd+5Flkmk/feLJnp+hex8J3FJV/UwCJZFI3a
         j2NLMSW23rFNMQwC0u9i2eVlwe3bJFfuF0opJLHPGeWCDKgqCeO/ri0tcXR7oSEG9nJY
         kRgKpov2nqc3xu14pZPKI/JFSU70FLuPUVeO+EQHX9bke0gdV2dJNmP4TC5762KchhCL
         cfOw==
X-Forwarded-Encrypted: i=1; AJvYcCUUBKJyWuq1HKQfgGw724oOZbeGzMO9c76Yc5YgIRHE0JvZ8B9jOPrSTMvS6LJhWihv9/FCCPTwxooj@vger.kernel.org, AJvYcCUviYPdRT8UwX0PE+kvwqBuyF8BCy8iw5dUlH6dXV5sfu3z/INNlnusoh9T4b5L09iLWPG+ePwdOGL5gVt4@vger.kernel.org
X-Gm-Message-State: AOJu0YwSG2ThT9k7RVeq3j2YTSnuVkdDm2fj+j2MIThlqzhmfEmaIME4
	j5MWsaIyJD0YegtdQ8snVbDhdgd7X+RoGIcEjjl9dW+4feGDRqFPs3+2Ta5GIg4=
X-Gm-Gg: ASbGnctVdGciFmhhTCCXhTocJwW+wlRya2LhnwVOUgaZgklBreWpKwLPb02Rhdhb3/T
	L0+e5wwGK6udvvaI1zKhhVhoTKJTZOnIafNfKxLy1Bfh+oAkHpdd4R+9p9EAQ0rb9qn0CFZc8B0
	YMs+lHpx297AdR+UMn90QDhxTtX+MxC7x43z7GrEzpYse4Hg0+35W3Ae3P/umYm2PscInOkLg3C
	k1pZrFkDno8btuMSNIBCOtWl8pi5oIIay4lkxOT1pnVqy7ZSGXlALrHVjtrRaPCOHqV+9HvVvwx
	9ZYaXM2yRecF89KPVMXtmlBZRnkdpO3Ij9gU5LfYUmuEsMq635xZVY3Djw==
X-Google-Smtp-Source: AGHT+IEc6/ZLCTHaQJM/Rf7ILcdaECorVl4Hil2NyKSwXu5ZnaHkUirlV97JK1Xc5FUNMHL+bW8vXA==
X-Received: by 2002:a17:90b:53c7:b0:2fc:3264:3666 with SMTP id 98e67ed59e1d1-30a4337bcedmr2879302a91.30.1746093697661;
        Thu, 01 May 2025 03:01:37 -0700 (PDT)
Received: from debian.domain.name ([2401:4900:1c45:13dc:af05:2012:1f6c:ed34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a47476120sm472477a91.13.2025.05.01.03.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 03:01:37 -0700 (PDT)
From: Sayyad Abid <sayyad.abid16@gmail.com>
To: linux-iio@vger.kernel.org
Cc: sayyad.abid16@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	javier.carrasco.cruz@gmail.com,
	olivier.moysan@foss.st.com,
	gstols@baylibre.com,
	tgamblin@baylibre.com,
	alisadariana@gmail.com,
	eblanc@baylibre.com,
	antoniu.miclaus@analog.com,
	andriy.shevchenko@linux.intel.com,
	stefan.popa@analog.com,
	ramona.gradinariu@analog.com,
	herve.codina@bootlin.com,
	tobias.sperling@softing.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/5] iio: adc: ti-ads1262.c: add initial driver for TI ADS1262 ADC
Date: Thu,  1 May 2025 15:30:39 +0530
Message-Id: <20250501100043.325423-2-sayyad.abid16@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250501100043.325423-1-sayyad.abid16@gmail.com>
References: <20250501100043.325423-1-sayyad.abid16@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the core driver file `ti-ads1262.c` for the TI ADS1262 ADC.
This initial version implements basic IIO functionality for device
probe via SPI and reading raw voltage samples from input channels.

Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>
---
 drivers/iio/adc/ti-ads1262.c | 438 +++++++++++++++++++++++++++++++++++
 1 file changed, 438 insertions(+)
 create mode 100644 drivers/iio/adc/ti-ads1262.c

diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
new file mode 100644
index 000000000000..ef34c528ffeb
--- /dev/null
+++ b/drivers/iio/adc/ti-ads1262.c
@@ -0,0 +1,438 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IIO driver for Texas Instruments ADS1662 32-bit ADC
+ *
+ * Datasheet: https://www.ti.com/product/ADS1262
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/delay.h>
+#include <linux/spi/spi.h>
+#include <linux/unaligned.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/triggered_buffer.h>
+
+/* Commands */
+#define ADS1262_CMD_RESET		0x06
+#define ADS1262_CMD_START1		0x08
+#define ADS1262_CMD_STOP1		0x0A
+#define ADS1262_CMD_RDATA1		0x12
+#define ADS1262_CMD_RREG		0x20
+#define ADS1262_CMD_WREG		0x40
+
+/* Registers */
+#define ADS1262_REG_ID			0x00
+#define ADS1262_REG_POWER		0x01
+#define ADS1262_REG_INTERFACE		0x02
+#define ADS1262_REG_MODE0		0x03
+#define ADS1262_REG_MODE1		0x04
+#define ADS1262_REG_MODE2		0x05
+#define ADS1262_REG_INPMUX		0x06
+
+/* Configurations */
+#define ADS1262_INTREF_ENABLE		0x01
+#define ADS1262_MODE0_ONE_SHOT		0x40
+#define ADS1262_MODE2_PGA_EN		0x00
+#define ADS1262_MODE2_PGA_BYPASS	BIT(7)
+
+/* Masks */
+#define ADS1262_MASK_MODE2_DR		GENMASK(4, 0)
+
+/* ADS1262_SPECS */
+#define ADS1262_MAX_CHANNELS		11
+#define ADS1262_BITS_PER_SAMPLE		32
+#define ADS1262_CLK_RATE_HZ		7372800
+#define ADS1262_CLOCKS_TO_USECS(x)	\
+	(DIV_ROUND_UP((x) * MICROHZ_PER_HZ, ADS1262_CLK_RATE_HZ))
+#define ADS1262_VOLTAGE_INT_REF_uV	2500000
+#define ADS1262_TEMP_SENSITIVITY_uV_per_C 420
+
+#define ADS1262_SETTLE_TIME_USECS	10000
+
+/* The Read/Write commands require 4 tCLK to encode and decode, for speeds
+ * 2x the clock rate, these commands would require extra time between the
+ * command byte and the data. A simple way to tacke this issue is by
+ * limiting the SPI bus transfer speed while accessing registers.
+ */
+#define ADS1262_SPI_BUS_SPEED_SLOW	ADS1262_CLK_RATE_HZ
+
+/* For reading and writing we need a buffer of size 3bytes*/
+#define ADS1262_SPI_CMD_BUFFER_SIZE	3
+
+/* Read data buffer size for
+ * 1 status byte - 4 byte data (32 bit) - 1 byte checksum / CRC
+ */
+#define ADS1262_SPI_RDATA_BUFFER_SIZE	6
+
+#define MILLI				1000
+
+/**
+ * struct ads1262_private - ADS1262 ADC private data structure
+ * @spi: SPI device structure
+ * @reset_gpio: GPIO descriptor for reset pin
+ * @prev_channel: Previously selected channel for MUX configuration
+ * @cmd_buffer: Buffer for SPI command transfers
+ * @rx_buffer: Buffer for SPI data reception
+ */
+struct ads1262_private {
+	struct spi_device *spi;
+	struct gpio_desc *reset_gpio;
+	u8 prev_channel;
+	u8 cmd_buffer[ADS1262_SPI_CMD_BUFFER_SIZE];
+	u8 rx_buffer[ADS1262_SPI_RDATA_BUFFER_SIZE] __aligned(IIO_DMA_MINALIGN);
+};
+
+#define ADS1262_CHAN(index)						\
+{									\
+	.type = IIO_VOLTAGE,						\
+	.indexed = 1,							\
+	.channel = index,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.scan_index = index,						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = ADS1262_BITS_PER_SAMPLE,			\
+		.storagebits = 32,					\
+		.endianness = IIO_CPU					\
+	},								\
+}
+
+#define ADS1262_DIFF_CHAN(index, pos_channel, neg_channel)		\
+{									\
+	.type = IIO_VOLTAGE,						\
+	.indexed = 1,							\
+	.channel = pos_channel,						\
+	.channel2 = neg_channel,					\
+	.differential = 1,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.scan_index = index,						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = ADS1262_BITS_PER_SAMPLE,			\
+		.storagebits = 32,					\
+		.endianness = IIO_CPU					\
+	},								\
+}
+
+#define ADS1262_TEMP_CHAN(index)					\
+{									\
+	.type = IIO_TEMP,						\
+	.indexed = 1,							\
+	.channel = index,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
+			     BIT(IIO_CHAN_INFO_SCALE) |			\
+			     BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
+	.scan_index = index,						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = ADS1262_BITS_PER_SAMPLE,			\
+		.storagebits = 32,					\
+		.endianness = IIO_BE,					\
+	},								\
+}
+
+static const struct iio_chan_spec ads1262_channels[] = {
+	/* Single ended channels*/
+	ADS1262_CHAN(0),
+	ADS1262_CHAN(1),
+	ADS1262_CHAN(2),
+	ADS1262_CHAN(3),
+	ADS1262_CHAN(4),
+	ADS1262_CHAN(5),
+	ADS1262_CHAN(6),
+	ADS1262_CHAN(7),
+	ADS1262_CHAN(8),
+	ADS1262_CHAN(9),
+	/* The channel at index 10 is AINCOM, which is the common ground
+	 * of the ADC. It is not a valid channel for the user.
+	 */
+
+	/* Temperature and Monitor channels */
+	ADS1262_TEMP_CHAN(11),	/* TEMP SENSOR */
+	ADS1262_CHAN(12),	/* AVDD MON */
+	ADS1262_CHAN(13),	/* DVDD MON */
+	ADS1262_CHAN(14),	/* TDAC TEST */
+	/* Differential channels */
+	ADS1262_DIFF_CHAN(15, 0, 1),	/* AIN0 - AIN1 */
+	ADS1262_DIFF_CHAN(16, 2, 3),	/* AIN2 - AIN3 */
+	ADS1262_DIFF_CHAN(17, 4, 5),	/* AIN4 - AIN5 */
+	ADS1262_DIFF_CHAN(18, 6, 7),	/* AIN6 - AIN7 */
+	ADS1262_DIFF_CHAN(19, 8, 9),	/* AIN8 - AIN9 */
+};
+
+static int ads1262_write_cmd(struct ads1262_private *priv, u8 command)
+{
+	struct spi_transfer xfer = {
+		.tx_buf = priv->cmd_buffer,
+		.rx_buf = priv->rx_buffer,
+		.len = ADS1262_SPI_RDATA_BUFFER_SIZE,
+		.speed_hz = ADS1262_CLK_RATE_HZ,
+	};
+
+	priv->cmd_buffer[0] = command;
+
+	return spi_sync_transfer(priv->spi, &xfer, 1);
+}
+
+static int ads1262_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct ads1262_private *priv = context;
+
+	priv->cmd_buffer[0] = ADS1262_CMD_WREG | reg;
+	priv->cmd_buffer[1] = 0;
+	priv->cmd_buffer[2] = val;
+
+	return spi_write(priv->spi, &priv->cmd_buffer[0], 3);
+}
+
+static int ads1262_reg_read(void *context, unsigned int reg)
+{
+	struct ads1262_private *priv = context;
+	struct spi_transfer reg_read_xfer = {
+		.tx_buf = priv->cmd_buffer,
+		.rx_buf = priv->cmd_buffer,
+		.len = 3,
+		.speed_hz = ADS1262_CLK_RATE_HZ,
+	};
+	int ret;
+
+	priv->cmd_buffer[0] = ADS1262_CMD_RREG | reg;
+	priv->cmd_buffer[1] = 0;
+	priv->cmd_buffer[2] = 0;
+
+	ret = spi_sync_transfer(priv->spi, &reg_read_xfer, 1);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int ads1262_reset(struct iio_dev *indio_dev)
+{
+	struct ads1262_private *priv = iio_priv(indio_dev);
+
+	if (priv->reset_gpio) {
+		gpiod_set_value(priv->reset_gpio, 0);
+		usleep_range(200, 300);
+		gpiod_set_value(priv->reset_gpio, 1);
+	} else {
+		return ads1262_write_cmd(priv, ADS1262_CMD_RESET);
+	}
+	return 0;
+}
+
+static int ads1262_init(struct iio_dev *indio_dev)
+{
+	struct ads1262_private *priv = iio_priv(indio_dev);
+	int ret = 0;
+
+	ret = ads1262_reset(indio_dev);
+	if (ret)
+		return ret;
+
+	/* 10 milliseconds settling time for the ADC to stabilize */
+	fsleep(ADS1262_SETTLE_TIME_USECS);
+
+	/* Clearing the RESET bit in the power register to detect ADC reset */
+	ret = ads1262_reg_write(priv, ADS1262_REG_POWER, ADS1262_INTREF_ENABLE);
+	if (ret)
+		return ret;
+
+	/* Setting the ADC to one-shot conversion mode */
+	ret = ads1262_reg_write(priv, ADS1262_REG_MODE0, ADS1262_MODE0_ONE_SHOT);
+	if (ret)
+		return ret;
+
+	ret = ads1262_reg_read(priv, ADS1262_REG_INPMUX);
+	if (ret)
+		return ret;
+
+	priv->prev_channel = priv->cmd_buffer[2];
+
+	return ret;
+}
+
+static int ads1262_get_samp_freq(struct ads1262_private *priv, int *val)
+{
+	unsigned long samp_freq;
+	int ret;
+
+	ret = ads1262_reg_read(priv, ADS1262_REG_MODE2);
+	if (ret)
+		return ret;
+
+	samp_freq = priv->cmd_buffer[2];
+
+	*val = (samp_freq & ADS1262_MASK_MODE2_DR);
+
+	return IIO_VAL_INT;
+}
+
+/**
+ * ads1262_read - Read a single sample from the ADC
+ * @priv: Pointer to the ADS1262 private data structure
+ * @chan: Pointer to the IIO channel specification
+ * @val: Pointer to store the read value
+ *
+ * Reads a single sample from the specified ADC channel. For differential
+ * channels, it sets up the MUX with both channels. For single-ended channels,
+ * it uses the channel number and AINCOM (0x0A).
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int ads1262_read(struct ads1262_private *priv,
+			struct iio_chan_spec const *chan, int *val)
+{
+	u8 mux_value;
+	int ret;
+
+	if (chan->differential) {
+		mux_value = (chan->channel << 4) | chan->channel2;
+	} else {
+		/* For single-ended channels, use the channel number on one end
+		 * and AINCOM (0x0A) on the other end
+		 */
+		mux_value = (chan->channel << 4) | 0x0A;
+	}
+
+	if (mux_value != priv->prev_channel) {
+		ret = ads1262_write_cmd(priv, ADS1262_CMD_STOP1);
+		if (ret)
+			return ret;
+
+		ret = ads1262_reg_write(priv, ADS1262_REG_INPMUX, mux_value);
+		if (ret)
+			return ret;
+
+		priv->prev_channel = mux_value;
+	}
+
+	ret = ads1262_write_cmd(priv, ADS1262_CMD_START1);
+	if (ret)
+		return ret;
+
+	usleep_range(1000, 2000);
+
+	*val = sign_extend64(get_unaligned_be32(priv->rx_buffer + 1),
+			     ADS1262_BITS_PER_SAMPLE - 1);
+
+	return 0;
+}
+
+static int ads1262_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct ads1262_private *spi = iio_priv(indio_dev);
+	s64 temp;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ads1262_read(spi, chan, val);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			*val = ADS1262_VOLTAGE_INT_REF_uV;
+			*val2 = chan->scan_type.realbits;
+			return IIO_VAL_FRACTIONAL_LOG2;
+		case IIO_TEMP:
+			temp = (s64)ADS1262_VOLTAGE_INT_REF_uV * MILLI;
+			temp /= ADS1262_TEMP_SENSITIVITY_uV_per_C;
+			*val = temp;
+			*val2 = chan->scan_type.realbits;
+			return IIO_VAL_FRACTIONAL_LOG2;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ads1262_get_samp_freq(spi, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ads1262_info = {
+	.read_raw = ads1262_read_raw,
+};
+
+static void ads1262_stop(void *ptr)
+{
+	struct ads1262_private *adc = ptr;
+
+	ads1262_write_cmd(adc, ADS1262_CMD_STOP1);
+}
+
+static int ads1262_probe(struct spi_device *spi)
+{
+	struct ads1262_private *adc;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	adc = iio_priv(indio_dev);
+	adc->spi = spi;
+
+	spi->mode = SPI_MODE_1;
+	spi->max_speed_hz = ADS1262_SPI_BUS_SPEED_SLOW;
+	spi_set_drvdata(spi, indio_dev);
+
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ads1262_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ads1262_channels);
+	indio_dev->info = &ads1262_info;
+
+	ret = ads1262_reg_read(adc, ADS1262_REG_ID);
+	if (ret)
+		return ret;
+
+	if (adc->rx_buffer[2] != ADS1262_REG_ID)
+		dev_err_probe(&spi->dev, -EINVAL, "Wrong device ID 0x%x\n",
+			      adc->rx_buffer[2]);
+
+	ret = devm_add_action_or_reset(&spi->dev, ads1262_stop, adc);
+	if (ret)
+		return ret;
+
+	ret = ads1262_init(indio_dev);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static struct spi_device_id ads1262_id_table[] = {
+	{ "ads1262" },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ads1262_id_table);
+
+static const struct of_device_id ads1262_of_match[] = {
+	{ .compatible = "ti,ads1262" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ads1262_of_match);
+
+static struct spi_driver ads1262_driver = {
+	.driver = {
+		.name = "ads1262",
+		.of_match_table = ads1262_of_match,
+	},
+	.probe = ads1262_probe,
+	.id_table = ads1262_id_table,
+};
+module_spi_driver(ads1262_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Sayyad Abid <sayyad.abid16@gmail.com>");
+MODULE_DESCRIPTION("TI ADS1262 ADC");
-- 
2.39.5


