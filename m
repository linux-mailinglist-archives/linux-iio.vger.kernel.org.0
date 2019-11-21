Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A129B105B87
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2019 22:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfKUVB0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Nov 2019 16:01:26 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37313 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfKUVB0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Nov 2019 16:01:26 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iXtZV-0006Og-12; Thu, 21 Nov 2019 22:01:01 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iXtZS-0006zv-UO; Thu, 21 Nov 2019 22:00:58 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v3 3/3] iio: adc: new driver to support Linear technology's ltc2496
Date:   Thu, 21 Nov 2019 22:00:07 +0100
Message-Id: <20191121210007.25646-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191121210007.25646-1-u.kleine-koenig@pengutronix.de>
References: <20191121210007.25646-1-u.kleine-koenig@pengutronix.de>
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
and so has a slightly different protocol. Only the actual hardware
access is different. The spi protocol is different enough to not be able
to map the differences via a regmap.

Also generalize the entry in MAINTAINER to cover the newly introduced
file.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 MAINTAINERS               |   2 +-
 drivers/iio/adc/Kconfig   |  10 ++++
 drivers/iio/adc/Makefile  |   1 +
 drivers/iio/adc/ltc2496.c | 108 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 120 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/adc/ltc2496.c

diff --git a/MAINTAINERS b/MAINTAINERS
index eb19fad370d7..8b1211038617 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1029,7 +1029,7 @@ S:	Supported
 F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
 F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
 F:	drivers/iio/*/ad*
-F:	drivers/iio/adc/ltc2497*
+F:	drivers/iio/adc/ltc249*
 X:	drivers/iio/*/adjd*
 F:	drivers/staging/iio/*/ad*
 
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
index ee0c8dcfb501..c3dc2a12766a 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
 obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
 obj-$(CONFIG_LTC2471) += ltc2471.o
 obj-$(CONFIG_LTC2485) += ltc2485.o
+obj-$(CONFIG_LTC2496) += ltc2496.o ltc2497-core.o
 obj-$(CONFIG_LTC2497) += ltc2497.o ltc2497-core.o
 obj-$(CONFIG_MAX1027) += max1027.o
 obj-$(CONFIG_MAX11100) += max11100.o
diff --git a/drivers/iio/adc/ltc2496.c b/drivers/iio/adc/ltc2496.c
new file mode 100644
index 000000000000..a7659c8f9cc9
--- /dev/null
+++ b/drivers/iio/adc/ltc2496.c
@@ -0,0 +1,108 @@
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
+#include <linux/spi/spi.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/driver.h>
+#include <linux/module.h>
+#include <linux/of.h>
+
+#include "ltc2497.h"
+
+struct ltc2496_driverdata {
+	/* this must be the first member */
+	struct ltc2497core_driverdata common_ddata;
+	struct spi_device *spi;
+
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	unsigned char rxbuf[3] ____cacheline_aligned;
+	unsigned char txbuf[3] ____cacheline_aligned;
+};
+
+static int ltc2496_result_and_measure(struct ltc2497core_driverdata *ddata,
+				      u8 address, int *val)
+{
+	struct ltc2496_driverdata *st =
+		container_of(ddata, struct ltc2496_driverdata, common_ddata);
+	struct spi_transfer t = {
+		.tx_buf = st->txbuf,
+		.rx_buf = st->rxbuf,
+		.len = sizeof(st->txbuf),
+	};
+	int ret;
+
+	st->txbuf[0] = LTC2497_ENABLE | address;
+
+	ret = spi_sync_transfer(st->spi, &t, 1);
+	if (ret < 0)  {
+		dev_err(&st->spi->dev, "spi_sync_transfer failed: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
+	if (val)
+		*val = ((st->rxbuf[0] & 0x3f) << 12 |
+			st->rxbuf[1] << 4 | st->rxbuf[2] >> 4) -
+			(1 << 17);
+
+	return 0;
+}
+
+static int ltc2496_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct ltc2496_driverdata *st;
+	struct device *dev = &spi->dev;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	spi_set_drvdata(spi, indio_dev);
+	st->spi = spi;
+	st->common_ddata.result_and_measure = ltc2496_result_and_measure;
+
+	return ltc2497core_probe(dev, indio_dev);
+}
+
+static int ltc2496_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+
+	ltc2497core_remove(indio_dev);
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
2.24.0

