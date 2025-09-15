Return-Path: <linux-iio+bounces-24103-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0AAB570EE
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 09:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07DE4189CB17
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 07:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4E02D24B7;
	Mon, 15 Sep 2025 07:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsATyPyU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C602D24A1
	for <linux-iio@vger.kernel.org>; Mon, 15 Sep 2025 07:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757920374; cv=none; b=mfAyqnU4i1FhSKubydWo6s4ZbcnD+XfiO/Z0BFEy91U+9uVLDIh9La7UIIimK3rxS8XfcluP4Ub+G3WgXKYnncD1B4R2Bx8TGZnNe37uc19KpcSgwmoNL2SsE5R5p7POX4WN5KLMfpLNEdGyKz8CEkw3Gl0RnNsuPHufS6CBH+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757920374; c=relaxed/simple;
	bh=d4DOAmhQ/zWM7N5d8zhXOncd6up2q432TwTde42kAME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6n+ArPmjpcUmm0XvTuCpwbZz1+gBPiN2gPjHf0nFWtR/YyuCv+ooiVQ+J6GF6f+HBCQy3hu+QLfQ9J6GHOQkC3NOkqcXfzdgwLaOMXeQx9bjenb/4vfP+A9JBri+dQ3obUfisx2pbmh7DddNhRsaTfUXqr9nZytSpcP+x2rDfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsATyPyU; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-560888dc903so4622901e87.2
        for <linux-iio@vger.kernel.org>; Mon, 15 Sep 2025 00:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757920370; x=1758525170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cGqDZmAFJZ2MeJadIvWxYXKHkuiaKbqgyPd2MUCUbVA=;
        b=UsATyPyU4Sk9CkGh2Bl3IskYG3Jmi04IB1gVnYqHZX0ABcJLENodUQ8XzegeFlWSDS
         qFeLD/9UdEOxz9klCTuTmdH2aHI/qYpFw/NUZMJYCV0Xhhffrx2m+1rJs9dJKMhCneZM
         mz/PIp3w8SMUrkWC9+iTDDWA/v35kinV8+lQyhfuONmvUohQfXiRmp8zuTqIWG/IkwFX
         ujRDNfBS2zN0IAqiGcMZQ9kg4qOE/cnfWUtA2QMzGwgkqDof9h7I07MrAGuMONKNpsZ9
         V0Vp6iIrfuSEZBrXtsQK+35iq0zUqVtRBE+dGsrADdVpao+2wd7rV1xYVaUrkTnxC4yu
         U7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757920370; x=1758525170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGqDZmAFJZ2MeJadIvWxYXKHkuiaKbqgyPd2MUCUbVA=;
        b=cwexwpV12+InWD1dnkHxPoTB4YBwsW9QyEnyYkqyMDblqEHqQE9lpPYHOn1R+Hktl1
         2v0d3NgBYlhuXemnKLtVnkFe0/SGkQsOjEID/Vf34TVSHWFIWC9RR3K1UkOQvLMDkZFn
         ym55V658jV/0qJGN1I3bA5ny/i5F4c8D6ATyIVMkqWJlZFtatfsthq0R+osWlkk1wfw7
         nNg45yLMK/fAb88dEGMeIY5o9/888AoM8POoUD3dnKVQB0XhS+5c+gh/g78JB9heeXci
         nx0TsHKMH0L3DZ9TaaO0mgyqleqk6FPvLmDEFA5IK6RvGBBmMph5GOvkzs6i/yu0w82U
         Rf6g==
X-Gm-Message-State: AOJu0Yy7TLqhyutd5In3IayxPe4FFamRaIIRRbAsKHePswFCDZWN7h2m
	tNgQ8Mwo0GkqdmF03+Uo+Q6lqpsMRPlO0Rc2dU07V65+cRCAK+c1SexK
X-Gm-Gg: ASbGncs45KNDMTXSJ8chYaETK/aQX6MUMepeTm9ZzuFbS+m+XCWtk9GtcCfGkbHNrKJ
	VG1tVI/k9aTOpsGXpoh/vs4IKHvPHVyWNWlDNtPGOXnwuG//a/Py/rC70T+W2mWUhVcILmke4jt
	rsAA1FrT20NlUuf2LEMNsAHmF+m2YNmUUdG02L9QuxhvBUPpI4BSwGgx2JHCmQb8o4IRLtqmnTL
	SLhbuYuKjiK9otWuSI2u+z3a/osWM2VECcTbxAtyEk5/cARKyCm1N1GJLwLmI5unMl+ztaXytB5
	h4gW3SL2ikEWC4Hc7uaR1xkaIJ+EQsiOQ5zp0CfTGuh17q2APJjzvT3J/aH/TbBXvpP7gaMeGwY
	QvxrHyPFGqPaZgM0m8dnhWN9N2T4rHcxS03o0ljpnoe3dPP4=
X-Google-Smtp-Source: AGHT+IHGOSBv+aqKsqFORjzcdqTmRl/KvlE4X2ujT2GOdURXKu2LjWGzbp8qK9/6k45/511Ma9i+1g==
X-Received: by 2002:a05:6512:3043:b0:560:956e:4392 with SMTP id 2adb3069b0e04-570489fca64mr3398591e87.9.1757920369338;
        Mon, 15 Sep 2025 00:12:49 -0700 (PDT)
Received: from mva-rohm ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e6460d741sm3415054e87.101.2025.09.15.00.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 00:12:48 -0700 (PDT)
Date: Mon, 15 Sep 2025 10:12:43 +0300
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
Subject: [PATCH v5 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
Message-ID: <20250915-bd79112-v5-2-a74e011a0560@gmail.com>
References: <20250915-bd79112-v5-0-a74e011a0560@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Iw1KzgU7X+s1ipVg"
Content-Disposition: inline
In-Reply-To: <20250915-bd79112-v5-0-a74e011a0560@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=20067;
 i=mazziesaccount@gmail.com; h=from:subject:message-id;
 bh=+e4+ukZoY7b61V7Hvl7SwI9xaxAbyoLENd1sZI8UYLA=;
 b=owEBbQGS/pANAwAKAXhQN/9N2qHFAcsmYgBox7tkYQjv98fPddjPhmDc0Z0wvGvT6Us8yBl8f
 kqxrA1QSq+JATMEAAEKAB0WIQQjH5/zBlvbx8soSFN4UDf/TdqhxQUCaMe7ZAAKCRB4UDf/Tdqh
 xTy3CADIRl2xVzcSdAqcIjnUfu+QiwD/DNRLKuvexy5i+EamGjMfEyoSfKKc4yG/vPkZGh+Bg7q
 rf2ENaMJjNHqQIdCc6JAvua0W1HY3rKq3imMj4guzjOiBOYxTNDRs7F5hl23r0m0s7/ggCxhXw4
 r4q71/c/fwRHk/N/DPRuPauSZLfYtpJr4QY9owBUitbSbFOwAKhfyxQvaIe64XehZuwa8VPXNAn
 HlKxNThjufUUSJGTIfmpm0dvRD9oZ864XiVBBF19QFnsF3bj+llk1GKwZOgj/MxkoBJo17La76d
 EeVrimTvRpzxKgCjLrQyvNfBEh2aQXyzppggXq8S6VQO4BYo
X-Developer-Key: i=mazziesaccount@gmail.com; a=openpgp;
 fpr=83351EE69759B11AF0A3107B40497F0C4693EF47


--Iw1KzgU7X+s1ipVg
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
v4 =3D> v5:
 - improve ADC read doc
 - drop debug check from the read function
 - styling
 - optimize SPI messages

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
 drivers/iio/adc/rohm-bd79112.c | 550 +++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 561 insertions(+)

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
index 0000000000000000000000000000000000000000..b406d4ee54119429e891a594749=
9c2c9155a0aae
--- /dev/null
+++ b/drivers/iio/adc/rohm-bd79112.c
@@ -0,0 +1,550 @@
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
+ *   - SCK: | 1 |      2      | 3  4 |   4 .. 16   |
+ *   - MISO:| 0 | STATUS_FLAG | 2'b0 | 12-bit data |
+ *     The 'STATUS_FLAG' is set if the read input pin was configured as a =
GPIO.
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
+static unsigned int bd79112_get_gpio_pins(const struct iio_chan_spec *cs, =
int num_channels)
+{
+	unsigned int i, gpio_channels;
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
+	data->map =3D devm_regmap_init(dev, NULL, data, &bd79112_regmap);
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
+	devm_spi_optimize_message(dev, spi, &data->read_msg);
+
+	data->write_xfer.tx_buf =3D &data->reg_write_tx[0];
+	data->write_xfer.len =3D sizeof(data->reg_write_tx);
+	spi_message_init_with_transfers(&data->write_msg, &data->write_xfer, 1);
+	devm_spi_optimize_message(dev, spi, &data->write_msg);
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
+	for (i =3D 0; i < iio_dev->num_channels; i++)
+		cs[i].datasheet_name =3D bd79112_chan_names[cs[i].channel];
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


--Iw1KzgU7X+s1ipVg
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmjHvGsACgkQeFA3/03a
ocVLdQf9Hw0jCPYRGbx9c7oewUXy7QCvrLXjo20uOp04Hg2ubjmfQx5Ov3DEOqVx
4vFXooVxD/BLDwS7ZGuF+Vk9lMIi1xximmA4QjsAsIsLKKKtpoxpJ99GL1nZqKIh
K74/mUZFuPifQz3f9Gv8ebvz0XTYkJ5UC4btXwjLCj+jVCrJldwnTEBpZNVtNMWC
+tA2I6YUMBxO70UjZJsJzSNs/Su9nQWp3MXFJB8r4yPC/exaSTfGVW6Mqoeu/X0l
u6cxwgt/6aO8ntagtg6Zbi3tNBXJ3wyLWt0uOJJv7IF3auyhnFYHAOHfZ1xN/1sB
RxDxdu9NWq3rQARYy/eXf9QICW2IHA==
=IKHA
-----END PGP SIGNATURE-----

--Iw1KzgU7X+s1ipVg--

