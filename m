Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA9518A3B8
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 21:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgCRUYY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 16:24:24 -0400
Received: from mx-out1.startmail.com ([145.131.90.139]:59475 "EHLO
        mx-out1.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgCRUYY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 16:24:24 -0400
From:   Alexandru Lazar <alazar@startmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2017-11; t=1584563061;
        bh=W+gkq7eMiOKvwtUxH77DqsRku85IMdXKev6QzXMi+C0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pJ2Qfu7vMsHosqYqnwHEJ5ANydR7P45IXDlQhOen9Ar5psT2q2fpF/cCFn70QK31H
         Afhl1Nb4Ot6DANERm3xHVutwxrdkC8CesyeJtyVBMFg2aoeB+Y5/1thXUkD7ct34+1
         OgrXXyoDqgmxDbAn/z8dOOqtiqLe57CiETTIJEYktVxTXR586eLZNt9zPHtOzW646q
         iGU8uzhCGvWnXIlX2cwuh4m+iDTnp5fukUpOFpOt7AR1ZahcT6badgCMHokny7akNd
         /czmwqPkbcqcMuxb5URIbZl3QbJEmMjPEH5wEkCrRL+bMw+S2Y2+/o+VBwqaD+ta2E
         0lFP/x/yE3Tpg==
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        Alexandru Lazar <alazar@startmail.com>
Subject: [PATCH 1/2] iio: adc: Add MAX1241 driver
Date:   Wed, 18 Mar 2020 22:28:36 +0200
Message-Id: <20200318202837.512428-2-alazar@startmail.com>
In-Reply-To: <20200318202837.512428-1-alazar@startmail.com>
References: <20200318202837.512428-1-alazar@startmail.com>
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
 drivers/iio/adc/Kconfig   |  10 ++
 drivers/iio/adc/Makefile  |   1 +
 drivers/iio/adc/max1241.c | 206 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 217 insertions(+)
 create mode 100644 drivers/iio/adc/max1241.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 5d8540b7b427..4254633147af 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -566,6 +566,16 @@ config MAX1118
 	  To compile this driver as a module, choose M here: the module will be
 	  called max1118.
 
+config MAX1241
+	tristate "Maxim max1241 ADC driver"
+	depends on SPI_MASTER
+	help
+	  Say yes here to build support for Maxim max1241 12-bit, single-channel
+	  ADC.
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
index 000000000000..0278510ec346
--- /dev/null
+++ b/drivers/iio/adc/max1241.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MAX1241 low-power, 12-bit serial ADC
+ *
+ * Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX1240-MAX1241.pdf
+ */
+
+#include <linux/regulator/consumer.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
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
+	struct spi_transfer xfers[] = {
+		/*
+		 * Begin conversion by bringing /CS low for at least
+		 * tconv us.
+		 */
+		{
+			.len = 0,
+			.delay.value = 8,
+			.delay.unit = SPI_DELAY_UNIT_USECS,
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
+	return spi_sync_transfer(adc->spi, xfers, ARRAY_SIZE(xfers));
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
+static void max1241_disable_reg_action(void *data)
+{
+	struct max1241 *adc = data;
+	int err;
+
+	err = regulator_disable(adc->reg);
+	if (err)
+		dev_err(&adc->spi->dev, "could not disable reference regulator.\n");
+}
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
+	ret = devm_add_action_or_reset(&spi->dev, max1241_disable_reg_action,
+					adc);
+	if (ret) {
+		dev_err(&spi->dev, "could not set up regulator cleanup action!\n");
+		return ret;
+	}
+
+	adc->shdn = devm_gpiod_get_optional(&spi->dev, "shdn", GPIOD_OUT_HIGH);
+
+	if (IS_ERR(adc->shdn))
+		return PTR_ERR(adc->shdn);
+
+	if (!adc->shdn)
+		dev_dbg(&spi->dev, "no shdn pin passed, low-power mode disabled");
+	else
+		dev_dbg(&spi->dev, "shdn pin passed, low-power mode enabled");
+
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->info = &max1241_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = max1241_channels;
+	indio_dev->num_channels = ARRAY_SIZE(max1241_channels);
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct spi_device_id max1241_id[] = {
+	{ "max1241", max1241 },
+	{},
+};
+
+static const struct of_device_id max1241_dt_ids[] = {
+	{ .compatible = "maxim,max1241" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, max1241_dt_ids);
+
+static struct spi_driver max1241_spi_driver = {
+	.driver = {
+		.name = "max1241",
+		.of_match_table = max1241_dt_ids,
+	},
+	.probe = max1241_probe,
+	.id_table = max1241_id,
+};
+module_spi_driver(max1241_spi_driver);
+
+MODULE_AUTHOR("Alexandru Lazar <alazar@startmail.com>");
+MODULE_DESCRIPTION("MAX1241 ADC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

