Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EEB3E8B13
	for <lists+linux-iio@lfdr.de>; Wed, 11 Aug 2021 09:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235641AbhHKHbL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Aug 2021 03:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235632AbhHKHbJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Aug 2021 03:31:09 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E95C06179B;
        Wed, 11 Aug 2021 00:30:44 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id b7so1519756plh.7;
        Wed, 11 Aug 2021 00:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f9qMyZC5HHn/J5i72i6L2XxDQXQYk9fA5n+EXJvF2O4=;
        b=IFPoY6qh+lHgelDJHMz/dgT96wBAA4ZV0SKaH6kdIimeuS+iiG9myO4JDxifF4gUlR
         Hgxt7y8Mm9SSW2ceVEm6l+AiG78UbCAeGCb5PpqhGgXe6hbSXzm7CvGRaRf2HtAaJDHM
         lb5IlOhKP7Or5tX0bo4q1nP0644JC2Cj6Qoz2XTFnK0OOZM3KM6jTd37bNX9KJYF4map
         legyrMHB+Vcyzx6BlpsxifQLhTJ4OIAdt8Ogr3x0cmY/Bu3vTOKiiidWRsJG7nZ8f9ey
         NWfY+cTVACBY4MZjL4GfxEzIrWXekES1E4Ur/2nXYU94cYngiKH8fIbzyH4xdOx73Z4I
         9/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f9qMyZC5HHn/J5i72i6L2XxDQXQYk9fA5n+EXJvF2O4=;
        b=LmbE6hGA4VRqan6KxkuUXzFo6PaamyODHCsPo553U+nCSFgzEQN1jcQFL7d1bKwOV3
         XPBdm3pAGgqUrRIrVf6LkK6GmwWXBV1vS30Pl22Qp9oGfMPFFwlUVA9iG00ZmLWQ5ADD
         tBV472au1n2ePj3YgGdAgx+Ks2VaTIz2kgg3udw0ES3RyIJ5cRKjGDXMl63IMvbCdIRD
         2cR3nrxXRg0+nUgZ0lZ9oS1xe7y0NXSvZGLdy/hYGx4XrsCHIaTNQrUSqtjGtyWvjuWC
         adVfMsEQuZuVnXl4KDaDeoZubCvjKU9FRauhBe7yncvVV7hsDGuOgnDY2yjbptpxSZN8
         bIFQ==
X-Gm-Message-State: AOAM531FG4PXz7YJeL4Gxvnj4HQHTrQQ0sQSrpmQCWucy2pE/dqEsadc
        m01/RO2v5idU22Rf6SxoZIQg1RcdDnoek3Ah
X-Google-Smtp-Source: ABdhPJyR1nrmQartakpBTaaXq6UwPdgsSDxOXyNCqnPjEtCE9Har+Acyvuv9KrNH0+cTUiLBPdX9tQ==
X-Received: by 2002:a65:468c:: with SMTP id h12mr375601pgr.423.1628667044159;
        Wed, 11 Aug 2021 00:30:44 -0700 (PDT)
Received: from localhost.localdomain ([124.253.244.73])
        by smtp.googlemail.com with ESMTPSA id c21sm26042284pfo.193.2021.08.11.00.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 00:30:43 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Michael.Hennerich@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        Dragos.Bogdan@analog.com, Darius.Berghe@analog.com,
        andy.shevchenko@gmail.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: [PATCH v12 2/2] iio: accel: Add driver support for ADXL355
Date:   Wed, 11 Aug 2021 13:00:27 +0530
Message-Id: <20210811073027.124619-3-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210811073027.124619-1-puranjay12@gmail.com>
References: <20210811073027.124619-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

ADXL355 is a 3-axis MEMS Accelerometer. It offers low noise density,
low 0g offset drift, low power with selectable measurement ranges.
It also features programmable high-pass and low-pass filters.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adxl354_adxl355.pdf
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 MAINTAINERS                      |  10 +
 drivers/iio/accel/Kconfig        |  29 ++
 drivers/iio/accel/Makefile       |   3 +
 drivers/iio/accel/adxl355.h      |  21 ++
 drivers/iio/accel/adxl355_core.c | 584 +++++++++++++++++++++++++++++++
 drivers/iio/accel/adxl355_i2c.c  |  62 ++++
 drivers/iio/accel/adxl355_spi.c  |  65 ++++
 7 files changed, 774 insertions(+)
 create mode 100644 drivers/iio/accel/adxl355.h
 create mode 100644 drivers/iio/accel/adxl355_core.c
 create mode 100644 drivers/iio/accel/adxl355_i2c.c
 create mode 100644 drivers/iio/accel/adxl355_spi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bd7aff0c1..104d22c83 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -586,6 +586,16 @@ W:	http://ez.analog.com/community/linux-device-drivers
 F:	Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
 F:	drivers/input/misc/adxl34x.c
 
+ADXL355 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
+M:	Puranjay Mohan <puranjay12@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
+F:	drivers/iio/accel/adxl355.h
+F:	drivers/iio/accel/adxl355_core.c
+F:	drivers/iio/accel/adxl355_i2c.c
+F:	drivers/iio/accel/adxl355_spi.c
+
 ADXL372 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
 S:	Supported
diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index cceda3cec..d0c45c809 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -61,6 +61,35 @@ config ADXL345_SPI
 	  will be called adxl345_spi and you will also get adxl345_core
 	  for the core module.
 
+config ADXL355
+	tristate
+
+config ADXL355_I2C
+	tristate "Analog Devices ADXL355 3-Axis Digital Accelerometer I2C Driver"
+	depends on I2C
+	select ADXL355
+	select REGMAP_I2C
+	help
+	  Say Y here if you want to build i2c support for the Analog Devices
+	  ADXL355 3-axis digital accelerometer.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called adxl355_i2c and you will also get adxl355_core
+	  for the core module.
+
+config ADXL355_SPI
+	tristate "Analog Devices ADXL355 3-Axis Digital Accelerometer SPI Driver"
+	depends on SPI
+	select ADXL355
+	select REGMAP_SPI
+	help
+	  Say Y here if you want to build spi support for the Analog Devices
+	  ADXL355 3-axis digital accelerometer.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called adxl355_spi and you will also get adxl355_core
+	  for the core module.
+
 config ADXL372
 	tristate
 	select IIO_BUFFER
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 32cd1342a..0e4721d2d 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -9,6 +9,9 @@ obj-$(CONFIG_ADIS16209) += adis16209.o
 obj-$(CONFIG_ADXL345) += adxl345_core.o
 obj-$(CONFIG_ADXL345_I2C) += adxl345_i2c.o
 obj-$(CONFIG_ADXL345_SPI) += adxl345_spi.o
+obj-$(CONFIG_ADXL355) += adxl355_core.o
+obj-$(CONFIG_ADXL355_I2C) += adxl355_i2c.o
+obj-$(CONFIG_ADXL355_SPI) += adxl355_spi.o
 obj-$(CONFIG_ADXL372) += adxl372.o
 obj-$(CONFIG_ADXL372_I2C) += adxl372_i2c.o
 obj-$(CONFIG_ADXL372_SPI) += adxl372_spi.o
diff --git a/drivers/iio/accel/adxl355.h b/drivers/iio/accel/adxl355.h
new file mode 100644
index 000000000..6dd49b13e
--- /dev/null
+++ b/drivers/iio/accel/adxl355.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * ADXL355 3-Axis Digital Accelerometer
+ *
+ * Copyright (c) 2021 Puranjay Mohan <puranjay12@gmail.com>
+ */
+
+#ifndef _ADXL355_H_
+#define _ADXL355_H_
+
+#include <linux/regmap.h>
+
+struct device;
+
+extern const struct regmap_access_table adxl355_readable_regs_tbl;
+extern const struct regmap_access_table adxl355_writeable_regs_tbl;
+
+int adxl355_core_probe(struct device *dev, struct regmap *regmap,
+		       const char *name);
+
+#endif /* _ADXL355_H_ */
diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
new file mode 100644
index 000000000..c91d2254c
--- /dev/null
+++ b/drivers/iio/accel/adxl355_core.c
@@ -0,0 +1,584 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ADXL355 3-Axis Digital Accelerometer IIO core driver
+ *
+ * Copyright (c) 2021 Puranjay Mohan <puranjay12@gmail.com>
+ *
+ * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adxl354_adxl355.pdf
+ */
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/iio/iio.h>
+#include <linux/limits.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/regmap.h>
+#include <asm/unaligned.h>
+
+#include "adxl355.h"
+
+/* ADXL355 Register Definitions */
+#define ADXL355_DEVID_AD_REG		0x00
+#define ADXL355_DEVID_MST_REG		0x01
+#define ADXL355_PARTID_REG		0x02
+#define ADXL355_STATUS_REG		0x04
+#define ADXL355_FIFO_ENTRIES_REG	0x05
+#define ADXL355_TEMP2_REG		0x06
+#define ADXL355_XDATA3_REG		0x08
+#define ADXL355_YDATA3_REG		0x0B
+#define ADXL355_ZDATA3_REG		0x0E
+#define ADXL355_FIFO_DATA_REG		0x11
+#define ADXL355_OFFSET_X_H_REG		0x1E
+#define ADXL355_OFFSET_Y_H_REG		0x20
+#define ADXL355_OFFSET_Z_H_REG		0x22
+#define ADXL355_ACT_EN_REG		0x24
+#define ADXL355_ACT_THRESH_H_REG	0x25
+#define ADXL355_ACT_THRESH_L_REG	0x26
+#define ADXL355_ACT_COUNT_REG		0x27
+#define ADXL355_FILTER_REG		0x28
+#define  ADXL355_FILTER_ODR_MSK GENMASK(3, 0)
+#define  ADXL355_FILTER_HPF_MSK	GENMASK(6, 4)
+#define ADXL355_FIFO_SAMPLES_REG	0x29
+#define ADXL355_INT_MAP_REG		0x2A
+#define ADXL355_SYNC_REG		0x2B
+#define ADXL355_RANGE_REG		0x2C
+#define ADXL355_POWER_CTL_REG		0x2D
+#define  ADXL355_POWER_CTL_MODE_MSK	GENMASK(1, 0)
+#define ADXL355_SELF_TEST_REG		0x2E
+#define ADXL355_RESET_REG		0x2F
+
+#define ADXL355_DEVID_AD_VAL		0xAD
+#define ADXL355_DEVID_MST_VAL		0x1D
+#define ADXL355_PARTID_VAL		0xED
+#define ADXL355_RESET_CODE		0x52
+
+#define MEGA 1000000UL
+#define TERA 1000000000000ULL
+
+static const struct regmap_range adxl355_read_reg_range[] = {
+	regmap_reg_range(ADXL355_DEVID_AD_REG, ADXL355_FIFO_DATA_REG),
+	regmap_reg_range(ADXL355_OFFSET_X_H_REG, ADXL355_SELF_TEST_REG),
+};
+
+const struct regmap_access_table adxl355_readable_regs_tbl = {
+	.yes_ranges = adxl355_read_reg_range,
+	.n_yes_ranges = ARRAY_SIZE(adxl355_read_reg_range),
+};
+EXPORT_SYMBOL_GPL(adxl355_readable_regs_tbl);
+
+static const struct regmap_range adxl355_write_reg_range[] = {
+	regmap_reg_range(ADXL355_OFFSET_X_H_REG, ADXL355_RESET_REG),
+};
+
+const struct regmap_access_table adxl355_writeable_regs_tbl = {
+	.yes_ranges = adxl355_write_reg_range,
+	.n_yes_ranges = ARRAY_SIZE(adxl355_write_reg_range),
+};
+EXPORT_SYMBOL_GPL(adxl355_writeable_regs_tbl);
+
+enum adxl355_op_mode {
+	ADXL355_MEASUREMENT,
+	ADXL355_STANDBY,
+	ADXL355_TEMP_OFF,
+};
+
+enum adxl355_odr {
+	ADXL355_ODR_4000HZ,
+	ADXL355_ODR_2000HZ,
+	ADXL355_ODR_1000HZ,
+	ADXL355_ODR_500HZ,
+	ADXL355_ODR_250HZ,
+	ADXL355_ODR_125HZ,
+	ADXL355_ODR_62_5HZ,
+	ADXL355_ODR_31_25HZ,
+	ADXL355_ODR_15_625HZ,
+	ADXL355_ODR_7_813HZ,
+	ADXL355_ODR_3_906HZ,
+};
+
+enum adxl355_hpf_3db {
+	ADXL355_HPF_OFF,
+	ADXL355_HPF_24_7,
+	ADXL355_HPF_6_2084,
+	ADXL355_HPF_1_5545,
+	ADXL355_HPF_0_3862,
+	ADXL355_HPF_0_0954,
+	ADXL355_HPF_0_0238,
+};
+
+static const int adxl355_odr_table[][2] = {
+	[0] = {4000, 0},
+	[1] = {2000, 0},
+	[2] = {1000, 0},
+	[3] = {500, 0},
+	[4] = {250, 0},
+	[5] = {125, 0},
+	[6] = {62, 500000},
+	[7] = {31, 250000},
+	[8] = {15, 625000},
+	[9] = {7, 813000},
+	[10] = {3, 906000},
+};
+
+static const int adxl355_hpf_3db_multipliers[] = {
+	0,
+	247000,
+	62084,
+	15545,
+	3862,
+	954,
+	238,
+};
+
+enum adxl355_chans {
+	chan_x, chan_y, chan_z,
+};
+
+struct adxl355_chan_info {
+	u8 data_reg;
+	u8 offset_reg;
+};
+
+static const struct adxl355_chan_info adxl355_chans[] = {
+	[chan_x] = {
+		.data_reg = ADXL355_XDATA3_REG,
+		.offset_reg = ADXL355_OFFSET_X_H_REG
+	},
+	[chan_y] = {
+		.data_reg = ADXL355_YDATA3_REG,
+		.offset_reg = ADXL355_OFFSET_Y_H_REG
+	},
+	[chan_z] = {
+		.data_reg = ADXL355_ZDATA3_REG,
+		.offset_reg = ADXL355_OFFSET_Z_H_REG
+	},
+};
+
+struct adxl355_data {
+	struct regmap *regmap;
+	struct device *dev;
+	struct mutex lock; /* lock to protect op_mode */
+	enum adxl355_op_mode op_mode;
+	enum adxl355_odr odr;
+	enum adxl355_hpf_3db hpf_3db;
+	int calibbias[3];
+	int adxl355_hpf_3db_table[7][2];
+	u8 transf_buf[3] ____cacheline_aligned;
+};
+
+static int adxl355_set_op_mode(struct adxl355_data *data,
+			       enum adxl355_op_mode op_mode)
+{
+	int ret;
+
+	if (data->op_mode == op_mode)
+		return 0;
+
+	ret = regmap_update_bits(data->regmap, ADXL355_POWER_CTL_REG,
+				 ADXL355_POWER_CTL_MODE_MSK, op_mode);
+	if (ret)
+		return ret;
+
+	data->op_mode = op_mode;
+
+	return ret;
+}
+
+static void adxl355_fill_3db_frequency_table(struct adxl355_data *data)
+{
+	u32 multiplier;
+	u64 div, rem;
+	u64 odr;
+	int i;
+
+	odr = mul_u64_u32_shr(adxl355_odr_table[data->odr][0], MEGA, 0) +
+			      adxl355_odr_table[data->odr][1];
+
+	for (i = 0; i < ARRAY_SIZE(adxl355_hpf_3db_multipliers); i++) {
+		multiplier = adxl355_hpf_3db_multipliers[i];
+		div = div64_u64_rem(mul_u64_u32_shr(odr, multiplier, 0),
+				    TERA * 100, &rem);
+
+		data->adxl355_hpf_3db_table[i][0] = div;
+		data->adxl355_hpf_3db_table[i][1] = div_u64(rem, MEGA * 100);
+	}
+}
+
+static int adxl355_setup(struct adxl355_data *data)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(data->regmap, ADXL355_DEVID_AD_REG, &regval);
+	if (ret)
+		return ret;
+
+	if (regval != ADXL355_DEVID_AD_VAL) {
+		dev_err(data->dev, "Invalid ADI ID 0x%02x\n", regval);
+		return -ENODEV;
+	}
+
+	ret = regmap_read(data->regmap, ADXL355_DEVID_MST_REG, &regval);
+	if (ret)
+		return ret;
+
+	if (regval != ADXL355_DEVID_MST_VAL) {
+		dev_err(data->dev, "Invalid MEMS ID 0x%02x\n", regval);
+		return -ENODEV;
+	}
+
+	ret = regmap_read(data->regmap, ADXL355_PARTID_REG, &regval);
+	if (ret)
+		return ret;
+
+	if (regval != ADXL355_PARTID_VAL) {
+		dev_err(data->dev, "Invalid DEV ID 0x%02x\n", regval);
+		return -ENODEV;
+	}
+
+	/*
+	 * Perform a software reset to make sure the device is in a consistent
+	 * state after start-up.
+	 */
+	ret = regmap_write(data->regmap, ADXL355_RESET_REG, ADXL355_RESET_CODE);
+	if (ret)
+		return ret;
+
+	adxl355_fill_3db_frequency_table(data);
+
+	return adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
+}
+
+static int adxl355_get_temp_data(struct adxl355_data *data, u8 addr)
+{
+	return regmap_bulk_read(data->regmap, addr, data->transf_buf, 2);
+}
+
+static int adxl355_read_axis(struct adxl355_data *data, u8 addr)
+{
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, addr, data->transf_buf,
+			       ARRAY_SIZE(data->transf_buf));
+	if (ret < 0)
+		return ret;
+
+	return get_unaligned_be24(data->transf_buf);
+}
+
+static int adxl355_find_match(const int (*freq_tbl)[2], const int n,
+			      const int val, const int val2)
+{
+	int i;
+
+	for (i = 0; i < n; i++) {
+		if (freq_tbl[i][0] == val && freq_tbl[i][1] == val2)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int adxl355_set_odr(struct adxl355_data *data,
+			   enum adxl355_odr odr)
+{
+	int ret = 0;
+
+	mutex_lock(&data->lock);
+
+	if (data->odr == odr)
+		goto out_unlock;
+
+	ret = adxl355_set_op_mode(data, ADXL355_STANDBY);
+	if (ret < 0)
+		goto out_unlock;
+
+	ret = regmap_update_bits(data->regmap, ADXL355_FILTER_REG,
+				 ADXL355_FILTER_ODR_MSK,
+				 FIELD_PREP(ADXL355_FILTER_ODR_MSK, odr));
+	if (ret < 0)
+		goto out_unlock;
+
+	data->odr = odr;
+	adxl355_fill_3db_frequency_table(data);
+
+out_unlock:
+	ret = adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
+static int adxl355_set_hpf_3db(struct adxl355_data *data,
+			       enum adxl355_hpf_3db hpf)
+{
+	int ret = 0;
+
+	mutex_lock(&data->lock);
+
+	if (data->hpf_3db == hpf)
+		goto unlock;
+
+	ret = adxl355_set_op_mode(data, ADXL355_STANDBY);
+	if (ret < 0)
+		goto set_opmode_unlock;
+
+	ret = regmap_update_bits(data->regmap, ADXL355_FILTER_REG,
+				 ADXL355_FILTER_HPF_MSK,
+				 FIELD_PREP(ADXL355_FILTER_HPF_MSK, hpf));
+	if (!ret)
+		data->hpf_3db = hpf;
+
+set_opmode_unlock:
+	ret = adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
+unlock:
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
+static int adxl355_set_calibbias(struct adxl355_data *data,
+				 enum adxl355_chans chan, int calibbias)
+{
+	int ret;
+
+	put_unaligned_be16(calibbias, data->transf_buf);
+
+	mutex_lock(&data->lock);
+
+	ret = adxl355_set_op_mode(data, ADXL355_STANDBY);
+	if (ret < 0)
+		goto set_opmode_unlock;
+
+	ret = regmap_bulk_write(data->regmap,
+				adxl355_chans[chan].offset_reg,
+				data->transf_buf, 2);
+	if (ret)
+		goto set_opmode_unlock;
+
+	data->calibbias[chan] = calibbias;
+
+set_opmode_unlock:
+	ret = adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
+static int adxl355_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct adxl355_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_TEMP:
+			ret = adxl355_get_temp_data(data, chan->address);
+			if (ret < 0)
+				return ret;
+			*val = get_unaligned_be16(data->transf_buf);
+
+			return IIO_VAL_INT;
+		case IIO_ACCEL:
+			ret = adxl355_read_axis(data, adxl355_chans[
+						chan->address].data_reg);
+			if (ret < 0)
+				return ret;
+			*val = sign_extend32(ret >> chan->scan_type.shift,
+					     chan->scan_type.realbits - 1);
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		/*
+		 * The datasheet defines an intercept of 1885 LSB at 25 degC
+		 * and a slope of -9.05 LSB/C. The following formula can be used
+		 * to find the temperature:
+		 * Temp = ((RAW - 1885)/(-9.05)) + 25 but this doesn't follow
+		 * the format of the IIO which is Temp = (RAW + OFFSET) * SCALE.
+		 * Hence using some rearranging we get the scale as -110.497238
+		 * and offset as -2111.25.
+		 */
+		case IIO_TEMP:
+			*val = -110;
+			*val2 = 497238;
+			return IIO_VAL_INT_PLUS_MICRO;
+		/*
+		 * At +/- 2g with 20-bit resolution, scale is given in datasheet
+		 * as 3.9ug/LSB = 0.0000039 * 9.80665 = 0.00003824593 m/s^2.
+		 */
+		case IIO_ACCEL:
+			*val = 0;
+			*val2 = 38245;
+			return IIO_VAL_INT_PLUS_NANO;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_OFFSET:
+		*val = -2111;
+		*val2 = 250000;
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		*val = sign_extend32(data->calibbias[chan->address], 15);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = adxl355_odr_table[data->odr][0];
+		*val2 = adxl355_odr_table[data->odr][1];
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
+		*val = data->adxl355_hpf_3db_table[data->hpf_3db][0];
+		*val2 = data->adxl355_hpf_3db_table[data->hpf_3db][1];
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl355_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct adxl355_data *data = iio_priv(indio_dev);
+	int odr_idx, hpf_idx, calibbias;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		odr_idx = adxl355_find_match(adxl355_odr_table,
+					     ARRAY_SIZE(adxl355_odr_table),
+					     val, val2);
+		if (odr_idx < 0)
+			return odr_idx;
+
+		return adxl355_set_odr(data, odr_idx);
+	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
+		hpf_idx = adxl355_find_match(data->adxl355_hpf_3db_table,
+					ARRAY_SIZE(data->adxl355_hpf_3db_table),
+					     val, val2);
+		if (hpf_idx < 0)
+			return hpf_idx;
+
+		return adxl355_set_hpf_3db(data, hpf_idx);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		calibbias = clamp_t(int, val, S16_MIN, S16_MAX);
+
+		return adxl355_set_calibbias(data, chan->address, calibbias);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl355_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	struct adxl355_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = (const int *)adxl355_odr_table;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		/* Values are stored in a 2D matrix */
+		*length = ARRAY_SIZE(adxl355_odr_table) * 2;
+
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
+		*vals = (const int *)data->adxl355_hpf_3db_table;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		/* Values are stored in a 2D matrix */
+		*length = ARRAY_SIZE(data->adxl355_hpf_3db_table) * 2;
+
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info adxl355_info = {
+	.read_raw	= adxl355_read_raw,
+	.write_raw	= adxl355_write_raw,
+	.read_avail	= &adxl355_read_avail,
+};
+
+#define ADXL355_ACCEL_CHANNEL(index, reg, axis) {			\
+	.type = IIO_ACCEL,						\
+	.address = reg,							\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
+			      BIT(IIO_CHAN_INFO_CALIBBIAS),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
+				    BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
+		BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),	\
+	.info_mask_shared_by_type_available =				\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ) |				\
+		BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),	\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 20,						\
+		.storagebits = 32,					\
+		.shift = 4,						\
+		.endianness = IIO_BE,					\
+	}								\
+}
+
+static const struct iio_chan_spec adxl355_channels[] = {
+	ADXL355_ACCEL_CHANNEL(0, chan_x, X),
+	ADXL355_ACCEL_CHANNEL(1, chan_y, Y),
+	ADXL355_ACCEL_CHANNEL(2, chan_z, Z),
+	{
+		.type = IIO_TEMP,
+		.address = ADXL355_TEMP2_REG,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+		.scan_type = {
+			.sign = 's',
+			.realbits = 12,
+			.storagebits = 16,
+			.endianness = IIO_BE,
+		},
+	},
+};
+
+int adxl355_core_probe(struct device *dev, struct regmap *regmap,
+		       const char *name)
+{
+	struct adxl355_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->regmap = regmap;
+	data->dev = dev;
+	data->op_mode = ADXL355_STANDBY;
+	mutex_init(&data->lock);
+
+	indio_dev->name = name;
+	indio_dev->info = &adxl355_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = adxl355_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adxl355_channels);
+
+	ret = adxl355_setup(data);
+	if (ret < 0) {
+		dev_err(dev, "ADXL355 setup failed\n");
+		return ret;
+	}
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+EXPORT_SYMBOL_GPL(adxl355_core_probe);
+
+MODULE_AUTHOR("Puranjay Mohan <puranjay12@gmail.com>");
+MODULE_DESCRIPTION("ADXL355 3-Axis Digital Accelerometer core driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/accel/adxl355_i2c.c b/drivers/iio/accel/adxl355_i2c.c
new file mode 100644
index 000000000..5a987bda9
--- /dev/null
+++ b/drivers/iio/accel/adxl355_i2c.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ADXL355 3-Axis Digital Accelerometer I2C driver
+ *
+ * Copyright (c) 2021 Puranjay Mohan <puranjay12@gmail.com>
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/regmap.h>
+
+#include "adxl355.h"
+
+static const struct regmap_config adxl355_i2c_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x2F,
+	.rd_table = &adxl355_readable_regs_tbl,
+	.wr_table = &adxl355_writeable_regs_tbl,
+};
+
+static int adxl355_i2c_probe(struct i2c_client *client)
+{
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(client, &adxl355_i2c_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "Error initializing i2c regmap: %ld\n",
+			PTR_ERR(regmap));
+
+		return PTR_ERR(regmap);
+	}
+
+	return adxl355_core_probe(&client->dev, regmap, client->name);
+}
+
+static const struct i2c_device_id adxl355_i2c_id[] = {
+	{ "adxl355", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, adxl355_i2c_id);
+
+static const struct of_device_id adxl355_of_match[] = {
+	{ .compatible = "adi,adxl355" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adxl355_of_match);
+
+static struct i2c_driver adxl355_i2c_driver = {
+	.driver = {
+		.name	= "adxl355_i2c",
+		.of_match_table = adxl355_of_match,
+	},
+	.probe_new	= adxl355_i2c_probe,
+	.id_table	= adxl355_i2c_id,
+};
+module_i2c_driver(adxl355_i2c_driver);
+
+MODULE_AUTHOR("Puranjay Mohan <puranjay12@gmail.com>");
+MODULE_DESCRIPTION("ADXL355 3-Axis Digital Accelerometer I2C driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/accel/adxl355_spi.c b/drivers/iio/accel/adxl355_spi.c
new file mode 100644
index 000000000..fb225aeb5
--- /dev/null
+++ b/drivers/iio/accel/adxl355_spi.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ADXL355 3-Axis Digital Accelerometer SPI driver
+ *
+ * Copyright (c) 2021 Puranjay Mohan <puranjay12@gmail.com>
+ */
+
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+#include "adxl355.h"
+
+static const struct regmap_config adxl355_spi_regmap_config = {
+	.reg_bits = 7,
+	.pad_bits = 1,
+	.val_bits = 8,
+	.read_flag_mask = BIT(0),
+	.max_register = 0x2F,
+	.rd_table = &adxl355_readable_regs_tbl,
+	.wr_table = &adxl355_writeable_regs_tbl,
+};
+
+static int adxl355_spi_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id = spi_get_device_id(spi);
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_spi(spi, &adxl355_spi_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&spi->dev, "Error initializing spi regmap: %ld\n",
+			PTR_ERR(regmap));
+
+		return PTR_ERR(regmap);
+	}
+
+	return adxl355_core_probe(&spi->dev, regmap, id->name);
+}
+
+static const struct spi_device_id adxl355_spi_id[] = {
+	{ "adxl355", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, adxl355_spi_id);
+
+static const struct of_device_id adxl355_of_match[] = {
+	{ .compatible = "adi,adxl355" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adxl355_of_match);
+
+static struct spi_driver adxl355_spi_driver = {
+	.driver = {
+		.name	= "adxl355_spi",
+		.of_match_table = adxl355_of_match,
+	},
+	.probe		= adxl355_spi_probe,
+	.id_table	= adxl355_spi_id,
+};
+module_spi_driver(adxl355_spi_driver);
+
+MODULE_AUTHOR("Puranjay Mohan <puranjay12@gmail.com>");
+MODULE_DESCRIPTION("ADXL355 3-Axis Digital Accelerometer SPI driver");
+MODULE_LICENSE("GPL v2");
-- 
2.30.1

