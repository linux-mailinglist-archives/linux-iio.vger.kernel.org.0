Return-Path: <linux-iio+bounces-23634-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6C7B40051
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 14:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024BC188127A
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 12:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3412C2C029F;
	Tue,  2 Sep 2025 12:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoAJtlmd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC3D81ACA;
	Tue,  2 Sep 2025 12:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815881; cv=none; b=tUQlZnBj2518fwsexBGel/N9A4bKGYL2Vg+buUIqsyMKRrLAmFYWw2/YpaPiT4dBLkgcROzrlSOJAEtOxoCvX9jD3lHBRMYSYmUYFtjX1sudy/PbHjfGgRq7oLU959Ywbdx1ZgJBUfBmwfK7/YjLy+iwK5neUzFFWOQUEpCaQXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815881; c=relaxed/simple;
	bh=BAp2CfNdzO/Ou6WVVW7HLB17CzeHLTNAgB5ZKArIYWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukSoej7ipSEz/iu8vCJXnSP2FQwCSsSE9EeHru08CzD52bl2gXoixAMAVUUmK9akninvikdYuL2NM2XVHFCl3ScMSKMem4E1VwBBfCnYM3/NaZj38w8jdO2nCMpCf7W301MFi5AK0AU6QZ47jfIg6O9s2NyJsAl/1GrPhWD0SpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoAJtlmd; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-337e5daf5f5so11956391fa.0;
        Tue, 02 Sep 2025 05:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756815877; x=1757420677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OOca+d6LeFk+Lj8SDu3fWDtPSfIkxA8RckC/sL10xRU=;
        b=IoAJtlmdk3iWT/rPI5x+zhV1HVS2VHa91XKxJ1TJLPq3VSqsm1o3GHWVcau5XIiEsu
         lJ+JAipW9+rKYNfz6Cm6JwzOVsnsBZDQKiVa/smcUoG9E3U73GNSQDPt3APqGXlm29Co
         VmKqDZuK34YxiiFXI0IIqNsYdvs+sIDyEn9MRwK11iI1FqKgRuEb2wosOHsgd7pkztFp
         VrEimW6EPvsHIwq267rC5aD/o62NT7lEVukyPkuM9mB+b/CQ6hUuT45uSlWs5qKn7RdV
         BJvXL4BIsQabHzPCixen1+T4+4aKEwSj+0ulPDR0/3twG0Ajc3ggCpG17SlhoEopELAI
         axbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756815877; x=1757420677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOca+d6LeFk+Lj8SDu3fWDtPSfIkxA8RckC/sL10xRU=;
        b=NTR2x6aLCNLxqR3+cMQ02DIvPoQLp3zJrMv6+4eCAkBrix4ZD10Eo4HchBKLGbu2fI
         S7wBHQj8cU1ywaDQ3ds7h7PbtJFErlU30jKpl00NUaMQ/jO2vDTH/q0xEkj8e1pSUVBG
         uQqgEMBz+cYSZoQFpa46E0Zw3xcIf/SusD/lQcIA6J1b88XBB+Dh8PEJc7zgvc2p/Wbr
         U4fSsxsJi7hxn2G+q4l8R1KilD9253ng68XtOkprDmevqfFOJgaGNdmhJFXGSiqQrMIZ
         CUQyULxtaiEDR40jU6SJvyZDjmsiMmRUYcC5CGyMzjukB+keyoAUbdIq+U2ow8EPCeq4
         i/Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUrdKac8JkycY6YpLyYi1Ke7xscwdOEx2/5AcVVTy1Iy6+pKQlGc7ExSNbGCVRHwhZwKx7C10jjpOiI@vger.kernel.org, AJvYcCUxDEliKCzpHr1cGv3v77SOcFGwe4l4g0uVsVphibUucRkyceqAlUCB5fTwyvw/MLsXHyQdb9mQN/CurPE1@vger.kernel.org, AJvYcCVdyJeQwP91EzQJgfohgPejFxKxj0CNPg+tL89BLSfNwoXFnHPb9F1fLR/HB38Dk0c0Mlf8ihp8nNykwA==@vger.kernel.org, AJvYcCWWAlhE4EqLgLpZguPzGlwXu/aDiq1qtMHXOwFxEH96Cb9fMxU2U3VmF40+BZhaN6Adx2s1m9Zsv7mT@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh4MVv9HBNHzHqcorSeJEgmV/lLRzB8eL8DsfOBwL42/L+Kq44
	w4WVqluZGWGHETrGeNMcV+9HWDapzofHJ7MiRwwtIKSrALVqGiNEA2h7
X-Gm-Gg: ASbGncuF7HnPGHYSt55s8JE0FckpPR9UddAXjEe3JvN2t2vBve8Tfa+pBpU/VR5b6Iu
	7vlciJ0Q1p7yEPssYnm9ydyY0xjbF9h5Z2jOHzfjcApcxUEem2kCgcqTmL1GOrjFhKw2Sgk2Ux0
	BcdduEpye1OgiCUDpY8L9ZJu+e6qy3OhYEMBFTbnh2eh1AYG/MB1SDrH4JI957IXkl0KAzVRzs+
	JcLWEioHyJYhTwXVrYONRbf5twHv/O8zQxMKv0+luqyhGxNsiGBwwhOZnxp+mlcP8uXRrbIpfl6
	zyYaSpSq2yQCjw7Al6fYuCumtDwlN+hYB7fWN8ogVLDsEeq+yxQZBW4BuLGFLAzdwFStC11g/d8
	UVH/PhdME3I1JJD8Ciw5yTwTgd7kKJUbGgZxV
X-Google-Smtp-Source: AGHT+IEL/QpIytWW5R0PHB2S22PdKzfO1hptHO354QV+O8uD2lS9oBx3cX5UEw8kdAw+TislSVb7xA==
X-Received: by 2002:a2e:a684:0:b0:336:74ed:699a with SMTP id 38308e7fff4ca-336c8108b66mr25585221fa.15.1756815876268;
        Tue, 02 Sep 2025 05:24:36 -0700 (PDT)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f5069b12sm4381651fa.48.2025.09.02.05.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:24:35 -0700 (PDT)
Date: Tue, 2 Sep 2025 15:24:31 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Hans de Goede <hansg@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
Message-ID: <08929460fe11dd0b749c50a72a634423f13f4104.1756813980.git.mazziesaccount@gmail.com>
References: <cover.1756813980.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Zll8XmoJ+NDqc7os"
Content-Disposition: inline
In-Reply-To: <cover.1756813980.git.mazziesaccount@gmail.com>


--Zll8XmoJ+NDqc7os
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
 drivers/iio/adc/Kconfig        |  10 +
 drivers/iio/adc/Makefile       |   1 +
 drivers/iio/adc/rohm-bd79112.c | 542 +++++++++++++++++++++++++++++++++
 3 files changed, 553 insertions(+)
 create mode 100644 drivers/iio/adc/rohm-bd79112.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index e3d3826c3357..4b78929bb257 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1309,6 +1309,16 @@ config RN5T618_ADC
 	  This driver can also be built as a module. If so, the module
 	  will be called rn5t618-adc.
=20
+config ROHM_BD79112
+	tristate "Rohm BD79112 ADC driver"
+	depends on I2C && GPIOLIB
+	select REGMAP_I2C
+	select IIO_ADC_HELPER
+	help
+	  Say yes here to build support for the ROHM BD79112 ADC. The
+	  ROHM BD79112 is a 12-bit, 32-channel, SAR ADC, which analog
+	  inputs can also be used for GPIO.
+
 config ROHM_BD79124
 	tristate "Rohm BD79124 ADC driver"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 89d72bf9ce70..34b40c34cf71 100644
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
index 000000000000..84d9768fb343
--- /dev/null
+++ b/drivers/iio/adc/rohm-bd79112.c
@@ -0,0 +1,542 @@
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
+#include <linux/err.h>
+#include <linux/gpio/driver.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
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
+	u8 reg_write_tx[2] __aligned(IIO_DMA_MINALIGN);
+	/* 12-bit of ADC data or 8 bit of reg data */
+	__be16 read_rx __aligned(IIO_DMA_MINALIGN);
+};
+
+/*
+ * The ADC data is read issuing SPI-command matching the channel number.
+ * We treat this as a register address.
+ */
+#define BD79112_REG_AGIO0A		0x0
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
+ * reads and an "IO bit" to be set for read/write operations (which aren't
+ * reading the ADC data).
+ */
+#define BD79112_BIT_RW			BIT(4)
+#define BD79112_BIT_IO			BIT(5)
+
+/*
+ * The data-sheet explains register I/O communication as follows:
+ *
+ * Read, two 16-bit sequences separated by CSB:
+ * MOSI:
+ * SCK:	| 1 | 2 | 3   | 4      | 5 .. 8 | 9 .. 16 |
+ * data:| 0 | 0 |IOSET| RW (1) | ADDR   | 8'b0    |
+ *
+ * MISO:
+ * SCK:	| 1 .. 8 | 9 .. 16 |
+ * data:| 8'b0   | data    |
+ *
+ * Note, CSB is shown to be released between writing the address (MOSI) and
+ * reading the register data (MISO).
+ *
+ * Write, single 16-bit sequence:
+ * MOSI:
+ * SCK:	| 1 | 2 | 3   | 4     | 5 .. 8 |
+ * data:| 0 | 0 |IOSET| RW(0) | ADDR   |
+ *
+ * MISO:
+ * SCK:	| 1 .. 8 |
+ * data:| data   |
+ *
+ */
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
+static int _get_gpio_reg(int offset, unsigned int base)
+{
+	int regoffset =3D offset / 8;
+
+	if (offset > 31 || offset < 0)
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
+	if (reg & BD79112_BIT_IO)
+		if (*val & BD79112_ADC_STATUS_FLAG)
+			dev_err(data->dev, "ADC pin configured as GPIO\n");
+
+	return ret;
+}
+
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
+		 *val =3D data->vref_mv;
+		 *val2 =3D 12;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+	}
+
+	return -EINVAL;
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
+	 * by the valid_mask at probe. Maybe someone wrote register bypassing
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
+	unsigned int i;
+
+	for (i =3D 0; i < 4; i++) {
+		unsigned int bank_mask, reg, regval, regmask;
+		int ret;
+
+		bank_mask =3D 0xff << 8 * i;
+		regmask =3D (*mask & bank_mask) << 8 * i;
+
+		if (!regmask)
+			continue;
+
+		reg =3D BD79112_REG_GPO_VALUE_A0_A7 - i;
+		regval =3D (*bits & bank_mask) >> 8 * i;
+		ret =3D regmap_update_bits(data->map, reg, regmask, regval);
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
+	unsigned int set_reg, clear_reg, bit;
+	int ret;
+
+	bit =3D GET_GPIO_BIT(offset);
+
+	if (dir =3D=3D GPIO_LINE_DIRECTION_IN) {
+		set_reg =3D GET_GPI_EN_REG(offset);
+		clear_reg =3D GET_GPO_EN_REG(offset);
+	} else {
+		set_reg =3D GET_GPO_EN_REG(offset);
+		clear_reg =3D GET_GPI_EN_REG(offset);
+	}
+
+	ret =3D regmap_set_bits(data->map, set_reg, bit);
+	if (ret)
+		return ret;
+
+	return regmap_clear_bits(data->map, clear_reg, bit);
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
+static int bd79112_probe(struct spi_device *spi)
+{
+	/* ADC channels as named in the data-sheet */
+	static const char * const chan_names[] =3D {
+		"AGIO0A", "AGIO1A", "AGIO2A", "AGIO3A", "AGIO4A", "AGIO5A",
+		"AGIO6A", "AGIO7A", "AGIO8A", "AGIO9A", "AGIO10A", "AGIO11A",
+		"AGIO11A", "AGIO12A", "AGIO13A", "AGIO14A", "AGIO15A",
+		"AGIO0B", "AGIO1B", "AGIO2B", "AGIO3B", "AGIO4B", "AGIO5B",
+		"AGIO6B", "AGIO7B", "AGIO8B", "AGIO9B", "AGIO10B", "AGIO11B",
+		"AGIO11B", "AGIO12B", "AGIO13B", "AGIO14B", "AGIO15B",
+	};
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
+		BD79112_MAX_NUM_CHANNELS - 1, &cs);
+	if (ret < 0) {
+		/* Register all pins as GPIOs if there are no ADC channels */
+		if (ret =3D=3D -ENOENT)
+			goto register_gpios;
+
+		return ret;
+	}
+
+	/* Let's assign data-sheet names to channels */
+	for (i =3D 0; i < iio_dev->num_channels; i++) {
+		unsigned int ch =3D cs[i].channel;
+
+		cs[i].datasheet_name =3D chan_names[ch];
+	}
+
+	iio_dev->channels =3D cs;
+	iio_dev->num_channels =3D ret;
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
+	/* We're done if all channels are reserved for ADC. */
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


--Zll8XmoJ+NDqc7os
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmi24f8ACgkQeFA3/03a
ocWLqwf7BGIsP2QG5W+SCZqnISivWZ1+7RS9oFB/qTw7TTxh18JnoN+EYy1L3iYH
HjWn96d1iwAqQ0wqkRnJEnEjKrWIN8Np0kNoRSeFvI+mzqzvz5MI3cJQsI9MY+YK
QQDh7BWMMjntOL17kyFjmOKTNEqRc/Dj/0ttKYuSICFtBqd7mYgLyY1jPCsGQKqX
D7KJ3J4iSBDDMPa8YKZTrKbK7KM/Zvyy5DMy4rbapdrSQgWhV4WAaA3KaiqRtZL6
hr+jxKDFXxWwmhUR+IAxw9zLFL8/DiWa3+nBli20M0kG6t2XP00r+9iChoUg75dP
5i4YtD2zwN3cqHM/0aBVqQIZlmjRzw==
=Qc1g
-----END PGP SIGNATURE-----

--Zll8XmoJ+NDqc7os--

