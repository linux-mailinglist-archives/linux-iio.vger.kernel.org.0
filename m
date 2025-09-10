Return-Path: <linux-iio+bounces-23931-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E728FB51572
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 13:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D96F563AF4
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 11:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4EE2D63F8;
	Wed, 10 Sep 2025 11:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFfDWmAr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C995E27B340;
	Wed, 10 Sep 2025 11:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503486; cv=none; b=ZPGFIjJefQMyYEk7WjFhSgqLyhjwkOPJ8++7rAfO/KNI30VVnZvXmpXcnucjw+b0EZJs7X9mqbIZoWINV+AWwmpKpebFI+CvHFgWI6Hwg+V3X/V5TeG5UNRTg8hJPQsovSzZJc4pajCGFrjPqxr5QIvPHV6EjSbi/Z2sSeNen9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503486; c=relaxed/simple;
	bh=feYgKie0Geq+D3TFX8O6b1mOf6JZ8VJ8j3OqdlrP2ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDT+FE+hCIJMVvBiuXWzPIgITJN5umYZtYEFrtF27f0vt6MEjm3Yw89AgHFVIz0CwVG+fzoNhaO7BINZwFNhXdiUymY0SpicpVMCSYwPp4SdWyCL8xnUmLx/kAvo+vZHqIKVNTw/6cYQi5RW9mc5MPr03xzzPC9WWWEJjFisVHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFfDWmAr; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55f720ffe34so815437e87.1;
        Wed, 10 Sep 2025 04:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757503482; x=1758108282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zvG85F9SrebkqQ77GTNYM6l1uW+8sVXqi3P6q1bxbHY=;
        b=AFfDWmArAgwHdydf6b5M1Koc11DDwcfjqUnPCmUpXz9da3WHi9XmuMDXlsQaqCxuUO
         yVJa9Y4IWNMT2T21+TBQPI+R1LRG2xKGFxokNjA3RUVkHXsw+hHscU4MZ4qhw9BNQ4/m
         bQKTEuXSe/kxfAmxR21FU9ovxQM8lPCcKhtKo4znX+Dgk+Lx0s5pTvqHGrXdlm2B7JDp
         6E/+Ii7tROQWBpgQyAI854Xw8itI4kWErXl/xs6kRdxDKjg+tr3XELQ+ZU7nB6EgBXkb
         wThRvUjmHxoL2OHNWfPGLngmMRAJfqg5OU0DECxkL3qIurcVJLnbFwA1FftR8U7ItxgT
         kU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757503482; x=1758108282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvG85F9SrebkqQ77GTNYM6l1uW+8sVXqi3P6q1bxbHY=;
        b=Zo1ZXZQKNtBQec8cMcSbCd+lH29PtSypSp94xbWcWX6AhwtxTuVbfxlTF/AkHZv+z0
         tkzXXfsPYeKvvh8ze+KIMHgJRvApNE+C7pv4MHhEMm+App5Un9Rpj46ahSoQei/ZVIUz
         2zy0fCzg4cwX1e34MZOa2EzTS22YdCAT9YkPnNoENIE2pw1K31rTG3i8NnN04J2pQhRt
         H5d36joHPtKq11kUzex8ENChUrWeQBAO+uaIpP6uE23o7F7/GuucX+9pUaH0xg5iGrRv
         S6jaZO6Jmj4zTmSskJxaJFrwkBiTgu3NiOAvzo7Tgzq+0lPopIcwqLTC1UGUt089ZEOw
         aA+w==
X-Forwarded-Encrypted: i=1; AJvYcCWGGMokcMNOdj4dXWzE573fSObukm35lN9g5aCNTOWyZrUhZeJfyTdmSlxyOA5WfzQPUFG1HRSsWyc7Op9Y@vger.kernel.org, AJvYcCWOyWG766EuSbghco/Hq84er6yRKBVPQOddzhkYRmhqvNms07WlQzn0oc+M7ZpCahUMmiWoi8zrfax3@vger.kernel.org, AJvYcCWsI5bXIKYQPUcD6hqvpy3xnQtB/aT8oiKBahbMHDeoz4aHeTYNvFiA0MVi21pYurKrXHTEZDWj748v+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPNVsziAPeuniXZBbysqIYMZcBsUAAZKxAkPprXKP/GUaPiQa9
	VPxdnS5TC2bHlDmfz/eRRgKPShseJrQKBwn9EmX0sK4SSf/RjLSmMZUi
X-Gm-Gg: ASbGncv7A4cReRMllDbQc+IKJLyadO0JMyGcPtUWx8el1ZpeB7tO3hL/EwF8PRLqtug
	njTVPv4vf/Gx9kwzTHQGQoa080/6oVRcWaprSnNsLQ59i9r3gPOgA5xPkYM9Mlp647F7fC5B+Qn
	6DyetVcV6V9k+8tSjSHwowvLUokBExzPt/sVCshEzpZLlrJmnprd1FMo98p8tTCIKC0Dj+CJHq8
	3nGsweTOQSE7x/2WEu29Bhwy4+OrqFDqP+gZIydPrQ9g9ty5PF4cu3kX8uXtWToNpFbGFybamGX
	3zadbTz55HbkgBTRjLYBPunlRkDiShlYZkI3h9UQcY0kkB8oMn2odlN3bROutm5EeQ7CadJL/I8
	z9inCWbQ4Kk5alUighPom156Ld/5J4Q==
X-Google-Smtp-Source: AGHT+IEFeId5jUZhYvRG0VD8OfPOjgmdxeuKTEB7XlGo36ON5xIkUpVVirhILyYgpEK+mGzv7I/Pfw==
X-Received: by 2002:a05:6512:3989:b0:56a:4480:4f3f with SMTP id 2adb3069b0e04-56a4480505fmr1426616e87.17.1757503481422;
        Wed, 10 Sep 2025 04:24:41 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56cab79b895sm83998e87.66.2025.09.10.04.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 04:24:39 -0700 (PDT)
Date: Wed, 10 Sep 2025 14:24:35 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH v4 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
Message-ID: <20250910-bd79112-v4-2-f82f43746a8c@gmail.com>
References: <20250910-bd79112-v4-0-f82f43746a8c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b8QSQeXVGVbYMa3l"
Content-Disposition: inline
In-Reply-To: <20250910-bd79112-v4-0-f82f43746a8c@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=19864;
 i=mazziesaccount@gmail.com; h=from:subject:message-id;
 bh=GBolxVEDqbYdxsEMKaB5ELxGhTfTmz/NzMkOBUrBOl8=;
 b=owEBbQGS/pANAwAKAXhQN/9N2qHFAcsmYgBowV8JfLina8+SReze1jD1tD6IbcmXgF9Pdn4XV
 A83krJ0/7yJATMEAAEKAB0WIQQjH5/zBlvbx8soSFN4UDf/TdqhxQUCaMFfCQAKCRB4UDf/Tdqh
 xXWWB/9RpO4HLaUPvja4dWZwcu9IHuPpqn/lwbPqe2b3DhDOPuFll9Ff6O9l74I5oC9PTg+EGQW
 /xAwjW6CoBfrVYKJdsQyhy2ZmLhi/CK2rF5l6IRskDNOpirr2YiGXWVBJfYOO1LMUb2Ze1cpUCa
 Gt4Gb/jL19iZTvTkqkVYIqMR34odOLFsa3L8XCIAK62g/r896xiTfdcqW5AtNvQKft1z7+FbnaS
 ZbH4XiXkiCPJdO+asHgF75aTAClIQ7JtS0tx+UqpuL6LHjupaGqTtTqwLvp9qKPhnHt8OpOL/lu
 IGZTF9aKjyqVHNKhPkW0o+BiD12CQYpiptvrYRVXOvYXhjJ2
X-Developer-Key: i=mazziesaccount@gmail.com; a=openpgp;
 fpr=83351EE69759B11AF0A3107B40497F0C4693EF47


--b8QSQeXVGVbYMa3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD79112 is an ADC/GPIO with 32 channels. The channel inputs can
be used as ADC or GPIO. Using the GPIOs as IRQ sources isn't supported.

The ADC is 12-bit, supporting input voltages up to 5.7V, and separate I/O
voltage supply. Maximum SPI clock rate is 20 MHz (10 MHz with
daisy-chain configuration) and maximum sampling rate is 1MSPS.

The IC does also support CRC but it is not implemented in the driver.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v3 =3D> v4:
 - Fix Kconfig dependency (I2C =3D> SPI)
 - Styling as suggested by Andy and Jonathan
 - Moved I/O documentation comment and read/write functions next to each
   other and tried clarifying the comment

v2 =3D> v3: (mainly based on review by Andy, thanks!)
 - fix broken indentiation
 - re-order includes
 - drop useless < 0 check for an unsigned offset
 - use gc->ngpios instead of hard coded pincount in
   for_each_set_clump8()
 - drop useless check for zero mask inside for_each_set_clump8() body
 - reorder return value checks for the
   devm_iio_adc_device_alloc_chaninfo_se() as suggested by Andy. (Well,
   I am not 100% happy with it as it results an extra check in the
   hopefully most common 'success' -case. But yeah, probe is not exactly
   a fast path).

v1 =3D> v2 (mainly based on reviews by Andy and David, thanks!)
 - Fix Kconfig dependency to REGMAP_SPI instead of REGMAP_I2C
 - Add a few header includes
 - Drop unnecessary alignments
 - plenty of styling
 - use for_each_set_clump8 instead of open-coding it
 - change order of direction setting writes to avoid receiving 'event'
   when direction is changed from input to output.
 - fix data-sheet names and assigning of them to iio_dev
---
 drivers/iio/adc/Kconfig        |  10 +
 drivers/iio/adc/Makefile       |   1 +
 drivers/iio/adc/rohm-bd79112.c | 553 +++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 564 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index e3d3826c335714652726f012018aa5ecb9124a6d..984246b6f57f34e8c097fb92b59=
df158dd2a14a4 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1309,6 +1309,16 @@ config RN5T618_ADC
 	  This driver can also be built as a module. If so, the module
 	  will be called rn5t618-adc.
=20
+config ROHM_BD79112
+	tristate "Rohm BD79112 ADC driver"
+	depends on SPI && GPIOLIB
+	select REGMAP_SPI
+	select IIO_ADC_HELPER
+	help
+	  Say yes here to build support for the ROHM BD79112 ADC. The
+	  ROHM BD79112 is a 12-bit, 32-channel, SAR ADC. Analog inputs
+	  can also be used for GPIO.
+
 config ROHM_BD79124
 	tristate "Rohm BD79124 ADC driver"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 89d72bf9ce70ac1e225fbef83a83dd1a13aef27c..34b40c34cf7191c3367c6c57dca=
d6d1dbe374824 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -117,6 +117,7 @@ obj-$(CONFIG_QCOM_VADC_COMMON) +=3D qcom-vadc-common.o
 obj-$(CONFIG_RCAR_GYRO_ADC) +=3D rcar-gyroadc.o
 obj-$(CONFIG_RICHTEK_RTQ6056) +=3D rtq6056.o
 obj-$(CONFIG_RN5T618_ADC) +=3D rn5t618-adc.o
+obj-$(CONFIG_ROHM_BD79112) +=3D rohm-bd79112.o
 obj-$(CONFIG_ROHM_BD79124) +=3D rohm-bd79124.o
 obj-$(CONFIG_ROCKCHIP_SARADC) +=3D rockchip_saradc.o
 obj-$(CONFIG_RZG2L_ADC) +=3D rzg2l_adc.o
diff --git a/drivers/iio/adc/rohm-bd79112.c b/drivers/iio/adc/rohm-bd79112.c
new file mode 100644
index 0000000000000000000000000000000000000000..a2a3affe2c6dc86a237a164139c=
27ec66dc9d131
--- /dev/null
+++ b/drivers/iio/adc/rohm-bd79112.c
@@ -0,0 +1,553 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ROHM ADC driver for BD79112 signal monitoring hub.
+ * Copyright (C) 2025, ROHM Semiconductor.
+ *
+ * SPI communication derived from ad7923.c and ti-ads7950.c
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/bits.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/gpio/driver.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+#include <asm/byteorder.h>
+
+#include <linux/iio/adc-helpers.h>
+#include <linux/iio/iio.h>
+
+#define BD79112_MAX_NUM_CHANNELS 32
+
+struct bd79112_data {
+	struct spi_device *spi;
+	struct regmap *map;
+	struct device *dev;
+	struct gpio_chip gc;
+	unsigned long gpio_valid_mask;
+	unsigned int vref_mv;
+	struct spi_transfer read_xfer[2];
+	struct spi_transfer write_xfer;
+	struct spi_message read_msg;
+	struct spi_message write_msg;
+	/* 16-bit TX, valid data in high byte */
+	u8 read_tx[2] __aligned(IIO_DMA_MINALIGN);
+	/* 8-bit address followed by 8-bit data */
+	u8 reg_write_tx[2];
+	/* 12-bit of ADC data or 8 bit of reg data */
+	__be16 read_rx;
+};
+
+/*
+ * The ADC data is read issuing SPI-command matching the channel number.
+ * We treat this as a register address.
+ */
+#define BD79112_REG_AGIO0A		0x00
+#define BD79112_REG_AGIO15B		0x1f
+
+/*
+ * ADC STATUS_FLAG appended to ADC data will be set, if the ADC result is =
being
+ * read for a channel, which input pin is muxed to be a GPIO.
+ */
+#define BD79112_ADC_STATUS_FLAG BIT(14)
+
+/*
+ * The BD79112 requires "R/W bit" to be set for SPI register (not ADC data)
+ * reads and an "IOSET bit" to be set for read/write operations (which are=
n't
+ * reading the ADC data).
+ */
+#define BD79112_BIT_RW			BIT(4)
+#define BD79112_BIT_IO			BIT(5)
+
+#define BD79112_REG_GPI_VALUE_B8_15	(BD79112_BIT_IO | 0x0)
+#define BD79112_REG_GPI_VALUE_B0_B7	(BD79112_BIT_IO | 0x1)
+#define BD79112_REG_GPI_VALUE_A8_15	(BD79112_BIT_IO | 0x2)
+#define BD79112_REG_GPI_VALUE_A0_A7	(BD79112_BIT_IO | 0x3)
+
+#define BD79112_REG_GPI_EN_B7_B15	(BD79112_BIT_IO | 0x4)
+#define BD79112_REG_GPI_EN_B0_B7	(BD79112_BIT_IO | 0x5)
+#define BD79112_REG_GPI_EN_A8_A15	(BD79112_BIT_IO | 0x6)
+#define BD79112_REG_GPI_EN_A0_A7	(BD79112_BIT_IO | 0x7)
+
+#define BD79112_REG_GPO_EN_B7_B15	(BD79112_BIT_IO | 0x8)
+#define BD79112_REG_GPO_EN_B0_B7	(BD79112_BIT_IO | 0x9)
+#define BD79112_REG_GPO_EN_A8_A15	(BD79112_BIT_IO | 0xa)
+#define BD79112_REG_GPO_EN_A0_A7	(BD79112_BIT_IO | 0xb)
+
+#define BD79112_NUM_GPIO_EN_REGS	8
+#define BD79112_FIRST_GPIO_EN_REG	BD79112_REG_GPI_EN_B7_B15
+
+#define BD79112_REG_GPO_VALUE_B8_15	(BD79112_BIT_IO | 0xc)
+#define BD79112_REG_GPO_VALUE_B0_B7	(BD79112_BIT_IO | 0xd)
+#define BD79112_REG_GPO_VALUE_A8_15	(BD79112_BIT_IO | 0xe)
+#define BD79112_REG_GPO_VALUE_A0_A7	(BD79112_BIT_IO | 0xf)
+
+#define BD79112_REG_MAX BD79112_REG_GPO_VALUE_A0_A7
+
+/*
+ * Read transaction consists of two 16-bit sequences separated by CSB.
+ * For register read, 'IOSET' bit must be set. For ADC read, IOSET is clea=
red
+ * and ADDR equals the channel number (0 ... 31).
+ *
+ * First 16-bit sequence, MOSI as below, MISO data ignored:
+ * - SCK: | 1 | 2 |   3   |    4   | 5 .. 8 | 9 .. 16 |
+ * - MOSI:| 0 | 0 | IOSET | RW (1) |  ADDR  |  8'b0   |
+ *
+ * CSB released and re-acquired between these sequences
+ *
+ * Second 16-bit sequence, MISO as below, MOSI data ignored:
+ *   For Register read data is 8 bits:
+ *   - SCK: | 1 .. 8 |   9 .. 16   |
+ *   - MISO:|  8'b0  | 8-bit data  |
+ *
+ *   For ADC read data is 12 bits:
+ *   - SCK: | 1 .. 4 |   4 .. 16   |
+ *   - MISO:|  4'b0  | 12-bit data |
+ */
+static int bd79112_reg_read(void *context, unsigned int reg, unsigned int =
*val)
+{
+	struct bd79112_data *data =3D context;
+	int ret;
+
+	if (reg & BD79112_BIT_IO)
+		reg |=3D BD79112_BIT_RW;
+
+	data->read_tx[0] =3D reg;
+
+	ret =3D spi_sync(data->spi, &data->read_msg);
+	if (!ret)
+		*val =3D be16_to_cpu(data->read_rx);
+
+	if (reg & BD79112_BIT_IO && *val & BD79112_ADC_STATUS_FLAG)
+		dev_err(data->dev, "ADC pin configured as GPIO\n");
+
+	return ret;
+}
+
+/*
+ * Write, single 16-bit sequence (broken down below):
+ *
+ * First 8-bit, MOSI as below, MISO data ignored:
+ * - SCK: | 1 | 2 | 3   | 4     | 5 .. 8 |
+ * - MOSI:| 0 | 0 |IOSET| RW(0) | ADDR   |
+ *
+ * Last 8 SCK cycles (b8 ... b15), MISO contains register data, MOSI ignor=
ed.
+ * - SCK: | 9 .. 16 |
+ * - MISO:|  data   |
+ */
+static int bd79112_reg_write(void *context, unsigned int reg, unsigned int=
 val)
+{
+	struct bd79112_data *data =3D context;
+
+	data->reg_write_tx[0] =3D reg;
+	data->reg_write_tx[1] =3D val;
+
+	return spi_sync(data->spi, &data->write_msg);
+}
+
+static int _get_gpio_reg(unsigned int offset, unsigned int base)
+{
+	int regoffset =3D offset / 8;
+
+	if (offset > 31)
+		return -EINVAL;
+
+	return base - regoffset;
+}
+
+#define GET_GPIO_BIT(offset) BIT((offset) % 8)
+#define GET_GPO_EN_REG(offset)  _get_gpio_reg((offset), BD79112_REG_GPO_EN=
_A0_A7)
+#define GET_GPI_EN_REG(offset)  _get_gpio_reg((offset), BD79112_REG_GPI_EN=
_A0_A7)
+#define GET_GPO_VAL_REG(offset)  _get_gpio_reg((offset), BD79112_REG_GPO_V=
ALUE_A0_A7)
+#define GET_GPI_VAL_REG(offset)  _get_gpio_reg((offset), BD79112_REG_GPI_V=
ALUE_A0_A7)
+
+static const struct regmap_range bd71815_volatile_ro_ranges[] =3D {
+	{
+		/* Read ADC data */
+		.range_min =3D BD79112_REG_AGIO0A,
+		.range_max =3D BD79112_REG_AGIO15B,
+	}, {
+		/* GPI state */
+		.range_min =3D BD79112_REG_GPI_VALUE_B8_15,
+		.range_max =3D BD79112_REG_GPI_VALUE_A0_A7,
+	},
+};
+
+static const struct regmap_access_table bd79112_volatile_regs =3D {
+	.yes_ranges =3D &bd71815_volatile_ro_ranges[0],
+	.n_yes_ranges =3D ARRAY_SIZE(bd71815_volatile_ro_ranges),
+};
+
+static const struct regmap_access_table bd79112_ro_regs =3D {
+	.no_ranges =3D &bd71815_volatile_ro_ranges[0],
+	.n_no_ranges =3D ARRAY_SIZE(bd71815_volatile_ro_ranges),
+};
+
+static const struct regmap_config bd79112_regmap =3D {
+	.reg_read =3D bd79112_reg_read,
+	.reg_write =3D bd79112_reg_write,
+	.volatile_table =3D &bd79112_volatile_regs,
+	.wr_table =3D &bd79112_ro_regs,
+	.cache_type =3D REGCACHE_MAPLE,
+	.max_register =3D BD79112_REG_MAX,
+};
+
+static int bd79112_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long m)
+{
+	struct bd79112_data *data =3D iio_priv(indio_dev);
+	int ret;
+
+	switch (m) {
+	case IIO_CHAN_INFO_RAW:
+		ret =3D regmap_read(data->map, chan->channel, val);
+		if (ret < 0)
+			return ret;
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val =3D data->vref_mv;
+		*val2 =3D 12;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info bd79112_info =3D {
+	.read_raw =3D bd79112_read_raw,
+};
+
+static const struct iio_chan_spec bd79112_chan_template =3D {
+	.type =3D IIO_VOLTAGE,
+	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
+	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),
+	.indexed =3D 1,
+};
+
+static int bd79112_gpio_init_valid_mask(struct gpio_chip *gc,
+					unsigned long *valid_mask,
+					unsigned int ngpios)
+{
+	struct bd79112_data *data =3D gpiochip_get_data(gc);
+
+	*valid_mask =3D data->gpio_valid_mask;
+
+	return 0;
+}
+
+static int bd79112_gpio_dir_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct bd79112_data *data =3D gpiochip_get_data(gc);
+	unsigned int reg, bit, val;
+	int ret;
+
+	bit =3D GET_GPIO_BIT(offset);
+	reg =3D GET_GPO_EN_REG(offset);
+
+	ret =3D regmap_read(data->map, reg, &val);
+	if (ret)
+		return ret;
+
+	if (bit & val)
+		return GPIO_LINE_DIRECTION_OUT;
+
+	reg =3D GET_GPI_EN_REG(offset);
+	ret =3D regmap_read(data->map, reg, &val);
+	if (ret)
+		return ret;
+
+	if (bit & val)
+		return GPIO_LINE_DIRECTION_IN;
+
+	/*
+	 * Ouch. Seems the pin is ADC input - shouldn't happen as changing mux
+	 * at runtime is not supported and non GPIO pins should be invalidated
+	 * by the valid_mask at probe. Maybe someone wrote a register bypassing
+	 * the driver?
+	 */
+	dev_err(data->dev, "Pin not a GPIO\n");
+
+	return -EINVAL;
+}
+
+static int bd79112_gpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct bd79112_data *data =3D gpiochip_get_data(gc);
+	unsigned int reg, bit, val;
+	int ret;
+
+	bit =3D GET_GPIO_BIT(offset);
+	reg =3D GET_GPI_VAL_REG(offset);
+
+	ret =3D regmap_read(data->map, reg, &val);
+	if (ret)
+		return ret;
+
+	return !!(val & bit);
+}
+
+static int bd79112_gpio_set(struct gpio_chip *gc, unsigned int offset,
+			    int value)
+{
+	struct bd79112_data *data =3D gpiochip_get_data(gc);
+	unsigned int reg, bit;
+
+	bit =3D GET_GPIO_BIT(offset);
+	reg =3D GET_GPO_VAL_REG(offset);
+
+	return regmap_assign_bits(data->map, reg, bit, value);
+}
+
+static int bd79112_gpio_set_multiple(struct gpio_chip *gc, unsigned long *=
mask,
+				     unsigned long *bits)
+{
+	struct bd79112_data *data =3D gpiochip_get_data(gc);
+	unsigned long i, bank_mask;
+
+	for_each_set_clump8(i, bank_mask, mask, gc->ngpio) {
+		unsigned long bank_bits;
+		unsigned int reg;
+		int ret;
+
+		bank_bits =3D bitmap_get_value8(bits, i);
+		reg =3D BD79112_REG_GPO_VALUE_A0_A7 - i / 8;
+		ret =3D regmap_update_bits(data->map, reg, bank_mask, bank_bits);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int bd79112_gpio_dir_set(struct bd79112_data *data, unsigned int of=
fset,
+				int dir)
+{
+	unsigned int gpi_reg, gpo_reg, bit;
+	int ret;
+
+	bit =3D GET_GPIO_BIT(offset);
+	gpi_reg =3D GET_GPI_EN_REG(offset);
+	gpo_reg =3D  GET_GPO_EN_REG(offset);
+
+	if (dir =3D=3D GPIO_LINE_DIRECTION_OUT) {
+		ret =3D regmap_clear_bits(data->map, gpi_reg, bit);
+		if (ret)
+			return ret;
+
+		return regmap_set_bits(data->map, gpo_reg, bit);
+	}
+
+	ret =3D regmap_set_bits(data->map, gpi_reg, bit);
+	if (ret)
+		return ret;
+
+	return regmap_clear_bits(data->map, gpo_reg, bit);
+}
+
+static int bd79112_gpio_input(struct gpio_chip *gc, unsigned int offset)
+{
+	struct bd79112_data *data =3D gpiochip_get_data(gc);
+
+	return bd79112_gpio_dir_set(data, offset, GPIO_LINE_DIRECTION_IN);
+}
+
+static int bd79112_gpio_output(struct gpio_chip *gc, unsigned int offset,
+			       int value)
+{
+	struct bd79112_data *data =3D gpiochip_get_data(gc);
+	int ret;
+
+	ret =3D bd79112_gpio_set(gc, offset, value);
+	if (ret)
+		return ret;
+
+	return bd79112_gpio_dir_set(data, offset, GPIO_LINE_DIRECTION_OUT);
+}
+
+static const struct gpio_chip bd79112_gpio_chip =3D {
+	.label			=3D "bd79112-gpio",
+	.get_direction		=3D bd79112_gpio_dir_get,
+	.direction_input	=3D bd79112_gpio_input,
+	.direction_output	=3D bd79112_gpio_output,
+	.get			=3D bd79112_gpio_get,
+	.set			=3D bd79112_gpio_set,
+	.set_multiple		=3D bd79112_gpio_set_multiple,
+	.init_valid_mask	=3D bd79112_gpio_init_valid_mask,
+	.can_sleep		=3D true,
+	.ngpio			=3D 32,
+	.base			=3D -1,
+};
+
+static int bd79112_get_gpio_pins(const struct iio_chan_spec *cs, int num_c=
hannels)
+{
+	int i, gpio_channels;
+
+	/*
+	 * Let's initialize the mux config to say that all 32 channels are
+	 * GPIOs. Then we can just loop through the iio_chan_spec and clear the
+	 * bits for found ADC channels.
+	 */
+	gpio_channels =3D GENMASK(31, 0);
+	for (i =3D 0; i < num_channels; i++)
+		gpio_channels &=3D ~BIT(cs[i].channel);
+
+	return gpio_channels;
+}
+
+/* ADC channels as named in the data-sheet */
+static const char * const bd79112_chan_names[] =3D {
+	"AGIO0A", "AGIO1A", "AGIO2A", "AGIO3A",		/* 0 - 3 */
+	"AGIO4A", "AGIO5A", "AGIO6A", "AGIO7A",		/* 4 - 7 */
+	"AGIO8A", "AGIO9A", "AGIO10A", "AGIO11A",	/* 8 - 11 */
+	"AGIO12A", "AGIO13A", "AGIO14A", "AGIO15A",	/* 12 - 15 */
+	"AGIO0B", "AGIO1B", "AGIO2B", "AGIO3B",		/* 16 - 19 */
+	"AGIO4B", "AGIO5B", "AGIO6B", "AGIO7B",		/* 20 - 23 */
+	"AGIO8B", "AGIO9B", "AGIO10B", "AGIO11B",	/* 24 - 27 */
+	"AGIO12B", "AGIO13B", "AGIO14B", "AGIO15B",	/* 28 - 31 */
+};
+
+static int bd79112_probe(struct spi_device *spi)
+{
+	struct bd79112_data *data;
+	struct iio_dev *iio_dev;
+	struct iio_chan_spec *cs;
+	struct device *dev =3D &spi->dev;
+	unsigned long gpio_pins, pin;
+	unsigned int i;
+	int ret;
+
+	iio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	data =3D iio_priv(iio_dev);
+	data->spi =3D spi;
+	data->dev =3D dev;
+	data->map =3D devm_regmap_init(&spi->dev, NULL, data, &bd79112_regmap);
+	if (IS_ERR(data->map))
+		return dev_err_probe(dev, PTR_ERR(data->map),
+				     "Failed to initialize Regmap\n");
+
+	ret =3D devm_regulator_get_enable_read_voltage(dev, "vdd");
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to get the Vdd\n");
+
+	data->vref_mv =3D ret / 1000;
+
+	ret =3D devm_regulator_get_enable(dev, "iovdd");
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to enable I/O voltage\n");
+
+	data->read_xfer[0].tx_buf =3D &data->read_tx[0];
+	data->read_xfer[0].len =3D sizeof(data->read_tx);
+	data->read_xfer[0].cs_change =3D 1;
+	data->read_xfer[1].rx_buf =3D &data->read_rx;
+	data->read_xfer[1].len =3D sizeof(data->read_rx);
+	spi_message_init_with_transfers(&data->read_msg, data->read_xfer, 2);
+
+	data->write_xfer.tx_buf =3D &data->reg_write_tx[0];
+	data->write_xfer.len =3D sizeof(data->reg_write_tx);
+	spi_message_init_with_transfers(&data->write_msg, &data->write_xfer, 1);
+
+	ret =3D devm_iio_adc_device_alloc_chaninfo_se(dev, &bd79112_chan_template,
+						    BD79112_MAX_NUM_CHANNELS - 1,
+						    &cs);
+
+	/* Register all pins as GPIOs if there are no ADC channels */
+	if (ret =3D=3D -ENOENT)
+		goto register_gpios;
+
+	if (ret < 0)
+		return ret;
+
+	iio_dev->num_channels =3D ret;
+	iio_dev->channels =3D cs;
+
+	for (i =3D 0; i < iio_dev->num_channels; i++) {
+		unsigned int ch =3D cs[i].channel;
+
+		cs[i].datasheet_name =3D bd79112_chan_names[ch];
+	}
+
+	iio_dev->info =3D &bd79112_info;
+	iio_dev->name =3D "bd79112";
+	iio_dev->modes =3D INDIO_DIRECT_MODE;
+
+	/*
+	 * Ensure all channels are ADCs. This allows us to register the IIO
+	 * device early (before checking which pins are to be used for GPIO)
+	 * without having to worry about some pins being initially used for
+	 * GPIO.
+	 */
+	for (i =3D 0; i < BD79112_NUM_GPIO_EN_REGS; i++) {
+		ret =3D regmap_write(data->map, BD79112_FIRST_GPIO_EN_REG + i, 0);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to initialize channels\n");
+	}
+
+	ret =3D devm_iio_device_register(data->dev, iio_dev);
+	if (ret)
+		return dev_err_probe(data->dev, ret, "Failed to register ADC\n");
+
+register_gpios:
+	gpio_pins =3D bd79112_get_gpio_pins(iio_dev->channels,
+					  iio_dev->num_channels);
+
+	/* If all channels are reserved for ADC, then we're done. */
+	if (!gpio_pins)
+		return 0;
+
+	/* Default all the GPIO pins to GPI */
+	for_each_set_bit(pin, &gpio_pins, BD79112_MAX_NUM_CHANNELS) {
+		ret =3D bd79112_gpio_dir_set(data, pin, GPIO_LINE_DIRECTION_IN);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to mark pin as GPI\n");
+	}
+
+	data->gpio_valid_mask =3D gpio_pins;
+	data->gc =3D bd79112_gpio_chip;
+	data->gc.parent =3D dev;
+
+	return devm_gpiochip_add_data(dev, &data->gc, data);
+}
+
+static const struct of_device_id bd79112_of_match[] =3D {
+	{ .compatible =3D "rohm,bd79112" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bd79112_of_match);
+
+static const struct spi_device_id bd79112_id[] =3D {
+	{ "bd79112" },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, bd79112_id);
+
+static struct spi_driver bd79112_driver =3D {
+	.driver =3D {
+		.name =3D "bd79112",
+		.of_match_table =3D bd79112_of_match,
+	},
+	.probe =3D bd79112_probe,
+	.id_table =3D bd79112_id,
+};
+module_spi_driver(bd79112_driver);
+
+MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
+MODULE_DESCRIPTION("Driver for ROHM BD79112 ADC/GPIO");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_DRIVER");

--=20
2.51.0


--b8QSQeXVGVbYMa3l
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmjBX/MACgkQeFA3/03a
ocV2cAgAqko+RsA6qVEko/arL5LrsPGEQ8a0wxzVt1rOmeAj9tDhmFInHdH0S5Pw
jGgqeb+D9/vtfFtzrpca5HiPoDHtWxtBDVyV4diw5w0xGP1xvVDp4rJodj2dq+kp
chEUFRbWeVncCcppa1Z50CARNYmbB9okt1iPbWsveHh1APJQOQWmDhpdJiadnbvl
SFxBk/kM5jmF6CDXqpDo/LICuNEoBGn1BCL/Ncl68qf0WMcxG9YSq5ORUrKEHkFx
cJ4wo+SxbB0iJ9abeqZTYde2yXFnVCAAX6KYvqscNaf8oqL1j7jTyun1gUJDPpbH
MW6fxlIU2BO4X6j1YifFBZ/fUGzqDQ==
=UHBH
-----END PGP SIGNATURE-----

--b8QSQeXVGVbYMa3l--

