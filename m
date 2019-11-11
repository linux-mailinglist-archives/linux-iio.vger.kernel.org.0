Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF7FF82AA
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2019 22:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfKKV6s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Nov 2019 16:58:48 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47437 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfKKV6r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Nov 2019 16:58:47 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iUHQN-0005Bo-40; Mon, 11 Nov 2019 22:40:39 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iUHQL-0004md-5c; Mon, 11 Nov 2019 22:40:37 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>
Cc:     kernel@pengutronix.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 3/3] iio: adc: new driver to support Linear technology's ltc2496
Date:   Mon, 11 Nov 2019 22:40:25 +0100
Message-Id: <20191111214025.18310-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191111214025.18310-1-u.kleine-koenig@pengutronix.de>
References: <20191111214025.18310-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This chip is similar to the LTC2497 ADC, it just uses SPI instead of I2C
and so has a slightly different protocol. The channel definitions are
shared between the two drivers.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/adc/Kconfig   |  10 ++
 drivers/iio/adc/Makefile  |   1 +
 drivers/iio/adc/ltc2496.c | 208 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 219 insertions(+)
 create mode 100644 drivers/iio/adc/ltc2496.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index f0af3a42f53c..deb86f6039b3 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -492,6 +492,16 @@ config LTC2485
 	  To compile this driver as a module, choose M here: the module will be
 	  called ltc2485.
 
+config LTC2496
+	tristate "Linear Technology LTC2496 ADC driver"
+	depends on SPI
+	help
+	  Say yes here to build support for Linear Technology LTC2496
+	  16-Bit 8-/16-Channel Delta Sigma ADC.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ltc2496.
+
 config LTC2497
 	tristate "Linear Technology LTC2497 ADC driver"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 660242c2cca7..afe2b6db4a5e 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
 obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
 obj-$(CONFIG_LTC2471) += ltc2471.o
 obj-$(CONFIG_LTC2485) += ltc2485.o
+obj-$(CONFIG_LTC2496) += ltc2496.o ltc249x.o
 obj-$(CONFIG_LTC2497) += ltc2497.o ltc249x.o
 obj-$(CONFIG_MAX1027) += max1027.o
 obj-$(CONFIG_MAX11100) += max11100.o
diff --git a/drivers/iio/adc/ltc2496.c b/drivers/iio/adc/ltc2496.c
new file mode 100644
index 000000000000..0b0a7aa8987f
--- /dev/null
+++ b/drivers/iio/adc/ltc2496.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ltc2496.c - Driver for Analog Devices/Linear Technology LTC2496 ADC
+ *
+ * Based on ltc2497.c which has
+ * Copyright (C) 2017 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ *
+ * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/2496fc.pdf
+ */
+
+#include <linux/delay.h>
+#include <linux/spi/spi.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/driver.h>
+#include <linux/iio/sysfs.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+
+#include "ltc249x.h"
+
+struct ltc2496_st {
+	struct spi_device *spi;
+	struct regulator *ref;
+	ktime_t	time_prev;
+	u8 addr_prev;
+};
+
+static int ltc2496_wait_conv(struct ltc2496_st *st)
+{
+	s64 time_elapsed;
+
+	time_elapsed = ktime_ms_delta(ktime_get(), st->time_prev);
+
+	if (time_elapsed < LTC249X_CONVERSION_TIME_MS) {
+		/* delay if conversion time not passed
+		 * since last read or write
+		 */
+		if (msleep_interruptible(
+		    LTC249X_CONVERSION_TIME_MS - time_elapsed))
+			return -ERESTARTSYS;
+
+		return 0;
+	}
+
+	if (time_elapsed - LTC249X_CONVERSION_TIME_MS <= 0) {
+		/* We're in automatic mode -
+		 * so the last reading is still not outdated
+		 */
+		return 0;
+	}
+
+	return 1;
+}
+
+static int ltc2496_read(struct ltc2496_st *st, u8 address, int *val)
+{
+	struct spi_device *spi = st->spi;
+	int ret;
+	unsigned char txbuf[3] = { LTC249X_ENABLE | address, };
+	unsigned char rxbuf[3];
+	struct spi_transfer t = {
+		.tx_buf = txbuf,
+		.rx_buf = rxbuf,
+		.len = sizeof(txbuf),
+	};
+
+	ret = ltc2496_wait_conv(st);
+	if (ret < 0)
+		return ret;
+
+	if (ret || st->addr_prev != address) {
+		ret = spi_sync_transfer(spi, &t, 1);
+		if (ret < 0)
+			return ret;
+		st->addr_prev = address;
+		if (msleep_interruptible(LTC249X_CONVERSION_TIME_MS))
+			return -ERESTARTSYS;
+	}
+
+	ret = spi_sync_transfer(spi, &t, 1);
+	if (ret < 0)  {
+		dev_err(&spi->dev, "spi_sync_transfer failed\n");
+		return ret;
+	}
+	st->time_prev = ktime_get();
+
+	/* convert and shift the result,
+	 * and finally convert from offset binary to signed integer
+	 */
+	*val = ((rxbuf[0] & 0x3f) << 12 | rxbuf[1] << 4 | rxbuf[2] >> 4)
+		- (1 << 17);
+
+	return ret;
+}
+
+static int ltc2496_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct ltc2496_st *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&indio_dev->mlock);
+		ret = ltc2496_read(st, chan->address, val);
+		mutex_unlock(&indio_dev->mlock);
+		if (ret < 0)
+			return ret;
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		ret = regulator_get_voltage(st->ref);
+		if (ret < 0)
+			return ret;
+
+		*val = ret / 1000;
+		*val2 = 17;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ltc2496_info = {
+	.read_raw = ltc2496_read_raw,
+};
+
+static int ltc2496_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct ltc2496_st *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	spi_set_drvdata(spi, indio_dev);
+	st->spi = spi;
+
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = "ltc2496";
+	indio_dev->info = &ltc2496_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ltc249x_channel;
+	indio_dev->num_channels = ltc249x_num_channels;
+
+	st->ref = devm_regulator_get(&spi->dev, "vref");
+	if (IS_ERR(st->ref))
+		return PTR_ERR(st->ref);
+
+	ret = regulator_enable(st->ref);
+	if (ret < 0)
+		return ret;
+
+	st->addr_prev = 0;
+	st->time_prev = ktime_get();
+
+	ret = iio_device_register(indio_dev);
+	if (ret < 0)
+		goto err_regulator_disable;
+
+	return 0;
+
+err_regulator_disable:
+	regulator_disable(st->ref);
+
+	return ret;
+}
+
+static int ltc2496_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct ltc2496_st *st = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	regulator_disable(st->ref);
+
+	return 0;
+}
+
+static const struct of_device_id ltc2496_of_match[] = {
+	{ .compatible = "lltc,ltc2496", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ltc2496_of_match);
+
+static struct spi_driver ltc2496_driver = {
+	.driver = {
+		.name = "ltc2496",
+		.of_match_table = of_match_ptr(ltc2496_of_match),
+	},
+	.probe = ltc2496_probe,
+	.remove = ltc2496_remove,
+};
+module_spi_driver(ltc2496_driver);
+
+MODULE_AUTHOR("Uwe Kleine-König <u.kleine-könig@pengutronix.de>");
+MODULE_DESCRIPTION("Linear Technology LTC2496 ADC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.24.0.rc1

