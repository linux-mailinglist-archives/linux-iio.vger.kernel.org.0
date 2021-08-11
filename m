Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D1E3E9A53
	for <lists+linux-iio@lfdr.de>; Wed, 11 Aug 2021 23:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhHKVSb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Aug 2021 17:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbhHKVSb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Aug 2021 17:18:31 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB88C061765;
        Wed, 11 Aug 2021 14:18:07 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id a20so4474449plm.0;
        Wed, 11 Aug 2021 14:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NOUs57yGPX0nGrD1a36LeHpfV5+tZdGz9CUcUbqaX8s=;
        b=Fy4EUDw3aQHUBz8oGw/EVywbOEZVxRWiRkz66v53PnVyaLnPOfObd6u8LIMzj3szyl
         savFtp+eQl7i5VB5uP6Z1msqQS0GlAeFk7bpnxIYqO8FlpDCnmJ5ZlbbzLl5NUHSWTPr
         pNEeBXaFe+0c02iiZWcwTuVIJiMd+PhxR3+gUWXv4nJDfj1yfuvgCKYTvdA2ygvZy/eU
         VCANTsgRrsen2QO1PS9y/6GGzrKpK4+8aJom2r8pp8rAPa1FYyIhkvX5mmqDGBvEg/zt
         Y2P8JTJaKDiJSvcEC6dB1J8DkFTWEOIfk8+Aw+/q6cd2X4u/lf7dvSPMmnwoub4Rqhj3
         pViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NOUs57yGPX0nGrD1a36LeHpfV5+tZdGz9CUcUbqaX8s=;
        b=aKy81fK6kBsEYFdyKnUAZtHdBj1DhTO56U1/a1AWK7PkkbyKRAaeFc+586+mr8/+IB
         8d0TH2LrocapecmrwMc5mOAjj4Q79HIZWzP7qOi/Klc1AOwRlsI4fdOkeZa++JARCexS
         deh0IA9PH/whj9DZurDzuUp6bzvObr6Fj4E7PXAirC98kGSnKZiiNb6LLqDQo8xSqXf4
         mvtKnneEtseF7N6gCQf6hoRFw1vuozAd+UlSH2OD566bIyJvNWQ5a7BOn3uCqrZNz6UV
         mG8TPQRUUcUvnZH4ANxs/pW5oD1GPXdVsinrm/a0k1JUk4r5QCLI7cdahDQtkB6tXLcB
         ztnw==
X-Gm-Message-State: AOAM532UWIFRT2gwXhCw6CAqd1AUteathI2AXQNdD1O3/DtBd3UyX0lP
        slBEWQ/G8jg02dSkHxGk8eI=
X-Google-Smtp-Source: ABdhPJxlKcucPyZHW0i/TBTI7l2yn0IwcWf+q9ZBdnism7CsqwxMTiqtQ2DEgyYb8AxK9gBw+KDK2A==
X-Received: by 2002:a65:5a8a:: with SMTP id c10mr701421pgt.290.1628716686746;
        Wed, 11 Aug 2021 14:18:06 -0700 (PDT)
Received: from smtp.gmail.com ([2804:14c:73:9a01::1001])
        by smtp.gmail.com with ESMTPSA id f4sm439178pgi.68.2021.08.11.14.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 14:18:06 -0700 (PDT)
Date:   Wed, 11 Aug 2021 18:18:02 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        robh+dt@kernel.org, Dragos.Bogdan@analog.com,
        Darius.Berghe@analog.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] iio: accel: Add driver support for ADXL313
Message-ID: <69f3b83eaf31d657cdb522839dc0102384d50681.1628713039.git.lucas.p.stankus@gmail.com>
References: <cover.1628713039.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1628713039.git.lucas.p.stankus@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

ADXL313 is a small, thin, low power, 3-axis accelerometer with high
resolution measurement up to +/-4g. It includes an integrated 32-level
FIFO and has activity and inactivity sensing capabilities.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL313.pdf
Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
---
 MAINTAINERS                      |   6 +
 drivers/iio/accel/Kconfig        |  29 +++
 drivers/iio/accel/Makefile       |   3 +
 drivers/iio/accel/adxl313.h      |  57 ++++++
 drivers/iio/accel/adxl313_core.c | 331 +++++++++++++++++++++++++++++++
 drivers/iio/accel/adxl313_i2c.c  |  65 ++++++
 drivers/iio/accel/adxl313_spi.c  |  91 +++++++++
 7 files changed, 582 insertions(+)
 create mode 100644 drivers/iio/accel/adxl313.h
 create mode 100644 drivers/iio/accel/adxl313_core.c
 create mode 100644 drivers/iio/accel/adxl313_i2c.c
 create mode 100644 drivers/iio/accel/adxl313_spi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d0464b83b5b5..b2ada8ca1453 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -585,6 +585,12 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/adv_swbutton.c
 
+ADXL313 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
+M:	Lucas Stankus <lucas.p.stankus@gmail.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
+F:	drivers/iio/accel/adxl313*
+
 ADXL34X THREE-AXIS DIGITAL ACCELEROMETER DRIVER (ADXL345/ADXL346)
 M:	Michael Hennerich <michael.hennerich@analog.com>
 S:	Supported
diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 2f0c0d512ae7..fb8349a88cd3 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -30,6 +30,35 @@ config ADIS16209
 	  To compile this driver as a module, say M here: the module will be
 	  called adis16209.
 
+config ADXL313
+	tristate
+
+config ADXL313_I2C
+	tristate "Analog Devices ADXL313 3-Axis Digital Accelerometer I2C Driver"
+	depends on I2C
+	select ADXL313
+	select REGMAP_I2C
+	help
+	  Say Y here if you want to build i2c support for the Analog Devices
+	  ADXL313 3-axis digital accelerometer.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called adxl313_i2c and you will also get adxl313_core
+	  for the core module.
+
+config ADXL313_SPI
+	tristate "Analog Devices ADXL313 3-Axis Digital Accelerometer SPI Driver"
+	depends on SPI
+	select ADXL313
+	select REGMAP_SPI
+	help
+	  Say Y here if you want to build spi support for the Analog Devices
+	  ADXL313 3-axis digital accelerometer.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called adxl313_spi and you will also get adxl313_core
+	  for the core module.
+
 config ADXL345
 	tristate
 
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 89280e823bcd..fadc92816e24 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -6,6 +6,9 @@
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_ADIS16201) += adis16201.o
 obj-$(CONFIG_ADIS16209) += adis16209.o
+obj-$(CONFIG_ADXL313) += adxl313_core.o
+obj-$(CONFIG_ADXL313_I2C) += adxl313_i2c.o
+obj-$(CONFIG_ADXL313_SPI) += adxl313_spi.o
 obj-$(CONFIG_ADXL345) += adxl345_core.o
 obj-$(CONFIG_ADXL345_I2C) += adxl345_i2c.o
 obj-$(CONFIG_ADXL345_SPI) += adxl345_spi.o
diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
new file mode 100644
index 000000000000..c170b5236988
--- /dev/null
+++ b/drivers/iio/accel/adxl313.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * ADXL313 3-Axis Digital Accelerometer
+ *
+ * Copyright (c) 2021 Lucas Stankus <lucas.p.stankus@gmail.com>
+ */
+
+#ifndef _ADXL313_H_
+#define _ADXL313_H_
+
+/* ADXL313 register definitions */
+#define ADXL313_REG_DEVID0		0x00
+#define ADXL313_REG_DEVID1		0x01
+#define ADXL313_REG_PARTID		0x02
+#define ADXL313_REG_XID			0x04
+#define ADXL313_REG_SOFT_RESET		0x18
+#define ADXL313_REG_OFS_AXIS(index)	(0x1E + (index))
+#define ADXL313_REG_THRESH_ACT		0x24
+#define ADXL313_REG_ACT_INACT_CTL	0x27
+#define ADXL313_REG_BW_RATE		0x2C
+#define ADXL313_REG_POWER_CTL		0x2D
+#define ADXL313_REG_INT_MAP		0x2F
+#define ADXL313_REG_DATA_FORMAT		0x31
+#define ADXL313_REG_DATAX		0x32
+#define ADXL313_REG_DATAY		0x34
+#define ADXL313_REG_DATAZ		0x36
+#define ADXL313_REG_FIFO_CTL		0x38
+#define ADXL313_REG_FIFO_STATUS		0x39
+
+#define ADXL313_DEVID0			0xAD
+#define ADXL313_DEVID1			0x1D
+#define ADXL313_PARTID			0xCB
+#define ADXL313_SOFT_RESET		0x52
+
+#define ADXL313_RATE_MSK		GENMASK(3, 0)
+#define ADXL313_RATE_BASE		6
+
+#define ADXL313_POWER_CTL_MSK		GENMASK(3, 2)
+#define ADXL313_MEASUREMENT_MODE	BIT(3)
+
+#define ADXL313_RANGE_MSK		GENMASK(1, 0)
+#define ADXL313_RANGE_4G		3
+
+#define ADXL313_FULL_RES		BIT(3)
+#define ADXL313_SPI_3WIRE		BIT(6)
+#define ADXL313_I2C_DISABLE		BIT(6)
+
+extern const struct regmap_access_table adxl313_readable_regs_table;
+
+extern const struct regmap_access_table adxl313_writable_regs_table;
+
+int adxl313_core_probe(struct device *dev,
+		       struct regmap *regmap,
+		       const char *name,
+		       int (*interface_specific_setup)(struct device *,
+						       struct regmap *));
+#endif /* _ADXL313_H_ */
diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
new file mode 100644
index 000000000000..8f3d4f5281c4
--- /dev/null
+++ b/drivers/iio/accel/adxl313_core.c
@@ -0,0 +1,331 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ADXL313 3-Axis Digital Accelerometer
+ *
+ * Copyright (c) 2021 Lucas Stankus <lucas.p.stankus@gmail.com>
+ *
+ * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL313.pdf
+ */
+
+#include <linux/bitfield.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "adxl313.h"
+
+const struct regmap_range adxl313_readable_reg_range[] = {
+	regmap_reg_range(ADXL313_REG_DEVID0, ADXL313_REG_XID),
+	regmap_reg_range(ADXL313_REG_SOFT_RESET, ADXL313_REG_SOFT_RESET),
+	regmap_reg_range(ADXL313_REG_OFS_AXIS(0), ADXL313_REG_OFS_AXIS(2)),
+	regmap_reg_range(ADXL313_REG_THRESH_ACT, ADXL313_REG_ACT_INACT_CTL),
+	regmap_reg_range(ADXL313_REG_BW_RATE, ADXL313_REG_FIFO_STATUS)
+};
+
+const struct regmap_access_table adxl313_readable_regs_table = {
+	.yes_ranges = adxl313_readable_reg_range,
+	.n_yes_ranges = ARRAY_SIZE(adxl313_readable_reg_range)
+};
+EXPORT_SYMBOL_GPL(adxl313_readable_regs_table);
+
+const struct regmap_range adxl313_writable_reg_range[] = {
+	regmap_reg_range(ADXL313_REG_SOFT_RESET, ADXL313_REG_SOFT_RESET),
+	regmap_reg_range(ADXL313_REG_OFS_AXIS(0), ADXL313_REG_OFS_AXIS(2)),
+	regmap_reg_range(ADXL313_REG_THRESH_ACT, ADXL313_REG_ACT_INACT_CTL),
+	regmap_reg_range(ADXL313_REG_BW_RATE, ADXL313_REG_INT_MAP),
+	regmap_reg_range(ADXL313_REG_DATA_FORMAT, ADXL313_REG_DATA_FORMAT),
+	regmap_reg_range(ADXL313_REG_FIFO_CTL, ADXL313_REG_FIFO_CTL)
+};
+
+const struct regmap_access_table adxl313_writable_regs_table = {
+	.yes_ranges = adxl313_writable_reg_range,
+	.n_yes_ranges = ARRAY_SIZE(adxl313_writable_reg_range)
+};
+EXPORT_SYMBOL_GPL(adxl313_writable_regs_table);
+
+struct adxl313_data {
+	struct regmap	*regmap;
+	struct mutex	lock; /* lock to protect transf_buf */
+	__le16		transf_buf ____cacheline_aligned;
+};
+
+static const int adxl313_odr_freqs[][2] = {
+	[0] = { 6, 250000 },
+	[1] = { 12, 500000 },
+	[2] = { 25, 0 },
+	[3] = { 50, 0 },
+	[4] = { 100, 0 },
+	[5] = { 200, 0 },
+	[6] = { 400, 0 },
+	[7] = { 800, 0 },
+	[8] = { 1600, 0 },
+	[9] = { 3200, 0 },
+};
+
+#define ADXL313_ACCEL_CHANNEL(index, addr, axis) {			\
+	.type = IIO_ACCEL,						\
+	.address = addr,						\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
+			      BIT(IIO_CHAN_INFO_CALIBBIAS),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
+				    BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+	.info_mask_shared_by_type_available =				\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
+	.scan_index = index,						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 13,						\
+		.storagebits = 16,					\
+		.endianness = IIO_LE,					\
+	},								\
+}
+
+static const struct iio_chan_spec adxl313_channels[] = {
+	ADXL313_ACCEL_CHANNEL(0, ADXL313_REG_DATAX, X),
+	ADXL313_ACCEL_CHANNEL(1, ADXL313_REG_DATAY, Y),
+	ADXL313_ACCEL_CHANNEL(2, ADXL313_REG_DATAZ, Z),
+};
+
+static int adxl313_set_odr(struct adxl313_data *data,
+			   unsigned int freq1, unsigned int freq2)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(adxl313_odr_freqs); i++) {
+		if (adxl313_odr_freqs[i][0] == freq1 &&
+		    adxl313_odr_freqs[i][1] == freq2)
+			break;
+	}
+
+	if (i == ARRAY_SIZE(adxl313_odr_freqs))
+		return -EINVAL;
+
+	return regmap_update_bits(data->regmap, ADXL313_REG_BW_RATE,
+				  ADXL313_RATE_MSK,
+				  FIELD_PREP(ADXL313_RATE_MSK,
+					     ADXL313_RATE_BASE + i));
+}
+
+static int adxl313_read_axis(struct adxl313_data *data,
+			     struct iio_chan_spec const *chan)
+{
+	int ret;
+
+	mutex_lock(&data->lock);
+
+	ret = regmap_bulk_read(data->regmap,
+			       chan->address,
+			       &data->transf_buf, 2);
+	if (ret)
+		goto unlock_ret;
+
+	ret = le16_to_cpu(data->transf_buf);
+
+unlock_ret:
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
+static int adxl313_read_freq_avail(struct iio_dev *indio_dev,
+				   struct iio_chan_spec const *chan,
+				   const int **vals, int *type, int *length,
+				   long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = (const int *)adxl313_odr_freqs;
+		*length = ARRAY_SIZE(adxl313_odr_freqs) * 2;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl313_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+	unsigned int regval;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = adxl313_read_axis(data, chan);
+		if (ret < 0)
+			return ret;
+
+		*val = sign_extend32(ret, chan->scan_type.realbits - 1);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		/*
+		 * Scale for any g range is given in datasheet as
+		 * 1024 LSB/g = 0.0009765625 * 9.80665 = 0.009576806640625 m/s^2
+		 */
+		*val = 0;
+		*val2 = 9576806;
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		ret = regmap_read(data->regmap,
+				  ADXL313_REG_OFS_AXIS(chan->scan_index),
+				  &regval);
+		if (ret)
+			return ret;
+
+		/*
+		 * 8-bit resolution at +/- 0.5g, that is 4x accel data scale
+		 * factor at full resolution
+		 */
+		*val = sign_extend32(regval, 7) * 4;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = regmap_read(data->regmap, ADXL313_REG_BW_RATE, &regval);
+		if (ret)
+			return ret;
+
+		ret = FIELD_GET(ADXL313_RATE_MSK, regval) - ADXL313_RATE_BASE;
+		*val = adxl313_odr_freqs[ret][0];
+		*val2 = adxl313_odr_freqs[ret][1];
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl313_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_CALIBBIAS:
+		/*
+		 * 8-bit resolution at +/- 0.5g, that is 4x accel data scale
+		 * factor at full resolution
+		 */
+		if (clamp_val(val, -128 * 4, 127 * 4) != val)
+			return -EINVAL;
+
+		return regmap_write(data->regmap,
+				    ADXL313_REG_OFS_AXIS(chan->scan_index),
+				    val / 4);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return adxl313_set_odr(data, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info adxl313_info = {
+	.read_raw	= adxl313_read_raw,
+	.write_raw	= adxl313_write_raw,
+	.read_avail	= adxl313_read_freq_avail
+};
+
+static int adxl313_setup(struct device *dev, struct adxl313_data *data,
+			 int (*interface_specific_setup)(struct device *,
+							 struct regmap *))
+{
+	unsigned int regval;
+	int ret;
+
+	/* Ensures the device is in a consistent state after start up */
+	ret = regmap_write(data->regmap, ADXL313_REG_SOFT_RESET,
+			   ADXL313_SOFT_RESET);
+	if (ret)
+		return ret;
+
+	if (interface_specific_setup) {
+		ret = interface_specific_setup(dev, data->regmap);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_read(data->regmap, ADXL313_REG_DEVID0, &regval);
+	if (ret)
+		return ret;
+
+	if (regval != ADXL313_DEVID0) {
+		dev_err(dev, "Invalid manufacturer ID: 0x%02x\n", regval);
+		return -ENODEV;
+	}
+
+	ret = regmap_read(data->regmap, ADXL313_REG_DEVID1, &regval);
+	if (ret)
+		return ret;
+
+	if (regval != ADXL313_DEVID1) {
+		dev_err(dev, "Invalid mems ID: 0x%02x\n", regval);
+		return -ENODEV;
+	}
+
+	ret = regmap_read(data->regmap, ADXL313_REG_PARTID, &regval);
+	if (ret)
+		return ret;
+
+	if (regval != ADXL313_PARTID) {
+		dev_err(dev, "Invalid device ID: 0x%02x\n", regval);
+		return -ENODEV;
+	}
+
+	/* Sets the range to +/- 4g */
+	ret = regmap_update_bits(data->regmap, ADXL313_REG_DATA_FORMAT,
+				 ADXL313_RANGE_MSK,
+				 FIELD_PREP(ADXL313_RANGE_MSK,
+					    ADXL313_RANGE_4G));
+	if (ret)
+		return ret;
+
+	/* Enables full resolution */
+	ret = regmap_update_bits(data->regmap, ADXL313_REG_DATA_FORMAT,
+				 ADXL313_FULL_RES, ADXL313_FULL_RES);
+	if (ret)
+		return ret;
+
+	/* Enables measurement mode */
+	return regmap_update_bits(data->regmap, ADXL313_REG_POWER_CTL,
+				  ADXL313_POWER_CTL_MSK,
+				  ADXL313_MEASUREMENT_MODE);
+}
+
+int adxl313_core_probe(struct device *dev,
+		       struct regmap *regmap,
+		       const char *name,
+		       int (*interface_specific_setup)(struct device *,
+						       struct regmap *))
+{
+	struct adxl313_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->regmap = regmap;
+	mutex_init(&data->lock);
+
+	indio_dev->name = name;
+	indio_dev->info = &adxl313_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = adxl313_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adxl313_channels);
+
+	ret = adxl313_setup(dev, data, interface_specific_setup);
+	if (ret) {
+		dev_err(dev, "ADXL313 setup failed\n");
+		return ret;
+	}
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+EXPORT_SYMBOL_GPL(adxl313_core_probe);
+
+MODULE_AUTHOR("Lucas Stankus <lucas.p.stankus@gmail.com>");
+MODULE_DESCRIPTION("ADXL313 3-Axis Digital Accelerometer core driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/accel/adxl313_i2c.c b/drivers/iio/accel/adxl313_i2c.c
new file mode 100644
index 000000000000..517c6f1c43ad
--- /dev/null
+++ b/drivers/iio/accel/adxl313_i2c.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ADXL313 3-Axis Digital Accelerometer
+ *
+ * Copyright (c) 2021 Lucas Stankus <lucas.p.stankus@gmail.com>
+ *
+ * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL313.pdf
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "adxl313.h"
+
+static const struct regmap_config adxl313_i2c_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.rd_table	= &adxl313_readable_regs_table,
+	.wr_table	= &adxl313_writable_regs_table,
+	.max_register	= 0x39,
+};
+
+static int adxl313_i2c_probe(struct i2c_client *client)
+{
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(client, &adxl313_i2c_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "Error initializing i2c regmap: %ld\n",
+			PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	return adxl313_core_probe(&client->dev, regmap, client->name, NULL);
+}
+
+static const struct i2c_device_id adxl313_i2c_id[] = {
+	{ "adxl313" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, adxl313_i2c_id);
+
+static const struct of_device_id adxl313_of_match[] = {
+	{ .compatible = "adi,adxl313" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, adxl313_of_match);
+
+static struct i2c_driver adxl313_i2c_driver = {
+	.driver = {
+		.name	= "adxl313_i2c",
+		.of_match_table = adxl313_of_match,
+	},
+	.probe_new	= adxl313_i2c_probe,
+	.id_table	= adxl313_i2c_id
+};
+
+module_i2c_driver(adxl313_i2c_driver);
+
+MODULE_AUTHOR("Lucas Stankus <lucas.p.stankus@gmail.com>");
+MODULE_DESCRIPTION("ADXL313 3-Axis Digital Accelerometer I2C driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/accel/adxl313_spi.c b/drivers/iio/accel/adxl313_spi.c
new file mode 100644
index 000000000000..4d625b1753a5
--- /dev/null
+++ b/drivers/iio/accel/adxl313_spi.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ADXL313 3-Axis Digital Accelerometer
+ *
+ * Copyright (c) 2021 Lucas Stankus <lucas.p.stankus@gmail.com>
+ *
+ * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL313.pdf
+ */
+
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+#include "adxl313.h"
+
+static const struct regmap_config adxl313_spi_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.rd_table	= &adxl313_readable_regs_table,
+	.wr_table	= &adxl313_writable_regs_table,
+	.max_register	= 0x39,
+	 /* Setting bits 7 and 6 enables multiple-byte read */
+	.read_flag_mask	= BIT(7) | BIT(6),
+};
+
+static int adxl313_spi_setup(struct device *dev, struct regmap *regmap)
+{
+	struct spi_device *spi = container_of(dev, struct spi_device, dev);
+	int ret;
+
+	if (spi->mode & SPI_3WIRE) {
+		ret = regmap_write(regmap, ADXL313_REG_DATA_FORMAT,
+				   ADXL313_SPI_3WIRE);
+		if (ret)
+			return ret;
+	}
+
+	return regmap_update_bits(regmap, ADXL313_REG_POWER_CTL,
+				  ADXL313_I2C_DISABLE, ADXL313_I2C_DISABLE);
+}
+
+static int adxl313_spi_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id = spi_get_device_id(spi);
+	struct regmap *regmap;
+	int ret;
+
+	spi->mode |= SPI_MODE_3;
+	ret = spi_setup(spi);
+	if (ret)
+		return ret;
+
+	regmap = devm_regmap_init_spi(spi, &adxl313_spi_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&spi->dev, "Error initializing spi regmap: %ld\n",
+			PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	return adxl313_core_probe(&spi->dev, regmap, id->name,
+				  &adxl313_spi_setup);
+}
+
+static const struct spi_device_id adxl313_spi_id[] = {
+	{ "adxl313" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(spi, adxl313_spi_id);
+
+static const struct of_device_id adxl313_of_match[] = {
+	{ .compatible = "adi,adxl313" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, adxl313_of_match);
+
+static struct spi_driver adxl313_spi_driver = {
+	.driver = {
+		.name	= "adxl313_spi",
+		.of_match_table = adxl313_of_match,
+	},
+	.probe		= adxl313_spi_probe,
+	.id_table	= adxl313_spi_id
+};
+
+module_spi_driver(adxl313_spi_driver);
+
+MODULE_AUTHOR("Lucas Stankus <lucas.p.stankus@gmail.com>");
+MODULE_DESCRIPTION("ADXL313 3-Axis Digital Accelerometer SPI driver");
+MODULE_LICENSE("GPL v2");
-- 
2.32.0

