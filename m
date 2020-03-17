Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD06188EE0
	for <lists+linux-iio@lfdr.de>; Tue, 17 Mar 2020 21:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgCQUVt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 16:21:49 -0400
Received: from mx-out1.startmail.com ([145.131.90.139]:60019 "EHLO
        mx-out1.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgCQUVt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Mar 2020 16:21:49 -0400
From:   Alexandru Lazar <alazar@startmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2017-11; t=1584476027;
        bh=2Cw5eJZnSwNI7bHNWiQqBI1m9XEFjllDS3Qf2eTDre4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DCN4cRO7689ZdgDDwqHBtsjjyAUzaY26kxbHrY9hJnNYYF5PmKwN8DbtfMWQkIo9H
         BsTY2/PQA6lGKX4gychv93fwWEm/s1gxaXr/9mKGh8Rls6YzC7HjTV8Dwf+nV3sdBN
         IlN7xhOGgDHebY8Tsbk5gjV+o/hkhpPNiVcE7qV+ZKNDTz3+uF2DAL/qEqcn9bzkdq
         60BuBeiNht8OzMW0r7sHq+thwPmf2h2BMhhSnqnyNJmDZdIkKIXysKvHvOKzV61Cv+
         PMz7EWbCF4EmHFZYu+gZe/73K0CkVMG7FkRA39pJ84Y8Fr4zQh5wCS9Z4IXx1HepTB
         Z5vxS4lTSASCA==
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        Alexandru Lazar <alazar@startmail.com>
Subject: [PATCH 1/2] iio: adc: Add MAX1241 driver
Date:   Tue, 17 Mar 2020 22:17:09 +0200
Message-Id: <20200317201710.23180-2-alazar@startmail.com>
In-Reply-To: <20200317201710.23180-1-alazar@startmail.com>
References: <20200317201710.23180-1-alazar@startmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add driver for the Maxim MAX1241 12-bit, single-channel ADC. The driver
includes support for this device's low-power operation mode.

Signed-off-by: Alexandru Lazar <alazar@startmail.com>
---
 drivers/iio/adc/Kconfig   |  12 +++
 drivers/iio/adc/Makefile  |   1 +
 drivers/iio/adc/max1241.c | 215 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 228 insertions(+)
 create mode 100644 drivers/iio/adc/max1241.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 5d8540b7b427..3a55beec69c9 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -566,6 +566,18 @@ config MAX1118
 	  To compile this driver as a module, choose M here: the module will be
 	  called max1118.
 
+config MAX1241
+	tristate "Maxim max1241 ADC driver"
+	depends on SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say yes here to build support for Maxim max1241 12-bit, single-channel
+          ADC.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called max1118.
+
 config MAX1363
 	tristate "Maxim max1363 ADC driver"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index a1f1fbec0f87..37d6f17559dc 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_LTC2497) += ltc2497.o
 obj-$(CONFIG_MAX1027) += max1027.o
 obj-$(CONFIG_MAX11100) += max11100.o
 obj-$(CONFIG_MAX1118) += max1118.o
+obj-$(CONFIG_MAX1241) += max1241.o
 obj-$(CONFIG_MAX1363) += max1363.o
 obj-$(CONFIG_MAX9611) += max9611.o
 obj-$(CONFIG_MCP320X) += mcp320x.o
diff --git a/drivers/iio/adc/max1241.c b/drivers/iio/adc/max1241.c
new file mode 100644
index 000000000000..2bd31f22fb2c
--- /dev/null
+++ b/drivers/iio/adc/max1241.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MAX1241 low-power, 12-bit serial ADC
+ *
+ * Copyright (c) 2020 Ioan-Alexandru Lazar <alazar@startmail.com>
+ *
+ * This file is subject to the terms and conditions of version 2 of
+ * the GNU General Public License.  See the file COPYING in the main
+ * directory of this archive for more details.
+ *
+ * Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX1240-MAX1241.pdf
+ */
+
+#include <linux/regulator/consumer.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio/driver.h>
+#include <linux/gpio.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+
+#define MAX1241_VAL_MASK 0xFFF
+#define MAX1241_SHDN_DELAY_USEC 4
+
+enum max1241_id {
+	max1241,
+};
+
+struct max1241 {
+	struct spi_device *spi;
+	struct mutex lock;
+	struct regulator *reg;
+	struct gpio_desc *shdn;
+
+	__be16 data ____cacheline_aligned;
+};
+
+static const struct iio_chan_spec max1241_channels[] = {
+	{
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = 0,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 12,
+			.storagebits = 16,
+		},
+	},
+};
+
+static int max1241_read(struct max1241 *adc)
+{
+	int ret;
+	struct spi_device *spi = adc->spi;
+	struct spi_transfer xfers[] = {
+		/*
+		 * Begin conversion by bringing /CS low for at least
+		 * tconv us.
+		 */
+		{
+			.len = 0,
+			.delay_usecs = 8,
+		},
+		/*
+		 * Then read two bytes of data in our RX buffer.
+		 */
+		{
+			.rx_buf = &adc->data,
+			.len = 2,
+		},
+	};
+
+	ret = spi_sync_transfer(spi, xfers, 2);
+
+	return ret;
+}
+
+static int max1241_read_raw(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *chan,
+			int *val, int *val2, long mask)
+{
+	int ret, vref_uV;
+	struct max1241 *adc = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&adc->lock);
+
+		if (adc->shdn) {
+			gpiod_set_value(adc->shdn, 0);
+			udelay(MAX1241_SHDN_DELAY_USEC);
+		}
+
+		ret = max1241_read(adc);
+
+		if (adc->shdn)
+			gpiod_set_value(adc->shdn, 1);
+
+		if (ret) {
+			mutex_unlock(&adc->lock);
+			return ret;
+		}
+
+		*val = (be16_to_cpu(adc->data) >> 3) & MAX1241_VAL_MASK;
+
+		mutex_unlock(&adc->lock);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		vref_uV = regulator_get_voltage(adc->reg);
+
+		if (vref_uV < 0)
+			return vref_uV;
+
+		*val = vref_uV / 1000;
+		*val2 = 12;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info max1241_info = {
+	.read_raw = max1241_read_raw,
+};
+
+static int max1241_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct max1241 *adc;
+	int ret = 0;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	adc = iio_priv(indio_dev);
+	adc->spi = spi;
+	mutex_init(&adc->lock);
+
+	spi_set_drvdata(spi, indio_dev);
+
+	adc->reg = devm_regulator_get(&spi->dev, "vref");
+	if (IS_ERR(adc->reg)) {
+		dev_err(&spi->dev, "failed to get vref regulator\n");
+		return PTR_ERR(adc->reg);
+	}
+
+	ret = regulator_enable(adc->reg);
+	if (ret)
+		return ret;
+
+	adc->shdn = devm_gpiod_get_optional(&spi->dev, "shdn", GPIOD_OUT_HIGH);
+	if (!adc->shdn)
+		dev_info(&spi->dev, "no shdn pin passed, low-power mode disabled");
+	else
+		dev_info(&spi->dev, "shdn pin passed, low-power mode enabled");
+
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->info = &max1241_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = max1241_channels;
+	indio_dev->num_channels = ARRAY_SIZE(max1241_channels);
+
+	ret = iio_device_register(indio_dev);
+
+	return ret;
+}
+
+static int max1241_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct max1241 *adc = iio_priv(indio_dev);
+	int ret = 0;
+
+	iio_device_unregister(indio_dev);
+	ret = regulator_disable(adc->reg);
+
+	return ret;
+}
+
+static const struct spi_device_id max1241_id[] = {
+	{ "max1241", max1241 },
+	{},
+};
+
+#ifdef CONFIG_OF
+
+static const struct of_device_id max1241_dt_ids[] = {
+	{ .compatible = "maxim,max1241" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, max1241_dt_ids);
+
+#endif
+
+static struct spi_driver max1241_spi_driver = {
+	.driver = {
+		.name = "max1241",
+		.of_match_table = of_match_ptr(max1241_dt_ids),
+	},
+	.probe = max1241_probe,
+	.remove = max1241_remove,
+	.id_table = max1241_id,
+};
+module_spi_driver(max1241_spi_driver);
+
+MODULE_AUTHOR("Alexandru Lazar <alazar@startmail.com>");
+MODULE_DESCRIPTION("MAX1241 ADC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

