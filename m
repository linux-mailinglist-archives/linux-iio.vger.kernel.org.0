Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0BEF82A3
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2019 22:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKKV6m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Nov 2019 16:58:42 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48179 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKV6m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Nov 2019 16:58:42 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iUHQN-0005Bn-40; Mon, 11 Nov 2019 22:40:39 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iUHQL-0004mQ-4h; Mon, 11 Nov 2019 22:40:37 +0100
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
Subject: [PATCH 2/3] iio: adc: ltc2497: split channel definition in a separate module
Date:   Mon, 11 Nov 2019 22:40:24 +0100
Message-Id: <20191111214025.18310-2-u.kleine-koenig@pengutronix.de>
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

This allows to share the data for the ltc2496 driver added in
the next commit that is an SPI variant of the ltc2497.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/adc/Makefile  |  2 +-
 drivers/iio/adc/ltc2497.c | 81 +++++----------------------------------
 drivers/iio/adc/ltc249x.c | 72 ++++++++++++++++++++++++++++++++++
 drivers/iio/adc/ltc249x.h | 10 +++++
 4 files changed, 93 insertions(+), 72 deletions(-)
 create mode 100644 drivers/iio/adc/ltc249x.c
 create mode 100644 drivers/iio/adc/ltc249x.h

diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index ef9cc485fb67..660242c2cca7 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -47,7 +47,7 @@ obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
 obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
 obj-$(CONFIG_LTC2471) += ltc2471.o
 obj-$(CONFIG_LTC2485) += ltc2485.o
-obj-$(CONFIG_LTC2497) += ltc2497.o
+obj-$(CONFIG_LTC2497) += ltc2497.o ltc249x.o
 obj-$(CONFIG_MAX1027) += max1027.o
 obj-$(CONFIG_MAX11100) += max11100.o
 obj-$(CONFIG_MAX1118) += max1118.o
diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
index 470406032720..e86fe42f1598 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -16,12 +16,7 @@
 #include <linux/of.h>
 #include <linux/regulator/consumer.h>
 
-#define LTC2497_ENABLE			0xA0
-#define LTC2497_SGL			BIT(4)
-#define LTC2497_DIFF			0
-#define LTC2497_SIGN			BIT(3)
-#define LTC2497_CONFIG_DEFAULT		LTC2497_ENABLE
-#define LTC2497_CONVERSION_TIME_MS	150ULL
+#include "ltc249x.h"
 
 struct ltc2497_st {
 	struct i2c_client *client;
@@ -41,18 +36,18 @@ static int ltc2497_wait_conv(struct ltc2497_st *st)
 
 	time_elapsed = ktime_ms_delta(ktime_get(), st->time_prev);
 
-	if (time_elapsed < LTC2497_CONVERSION_TIME_MS) {
+	if (time_elapsed < LTC249X_CONVERSION_TIME_MS) {
 		/* delay if conversion time not passed
 		 * since last read or write
 		 */
 		if (msleep_interruptible(
-		    LTC2497_CONVERSION_TIME_MS - time_elapsed))
+		    LTC249X_CONVERSION_TIME_MS - time_elapsed))
 			return -ERESTARTSYS;
 
 		return 0;
 	}
 
-	if (time_elapsed - LTC2497_CONVERSION_TIME_MS <= 0) {
+	if (time_elapsed - LTC249X_CONVERSION_TIME_MS <= 0) {
 		/* We're in automatic mode -
 		 * so the last reading is stil not outdated
 		 */
@@ -73,11 +68,11 @@ static int ltc2497_read(struct ltc2497_st *st, u8 address, int *val)
 
 	if (ret || st->addr_prev != address) {
 		ret = i2c_smbus_write_byte(st->client,
-					   LTC2497_ENABLE | address);
+					   LTC249X_ENABLE | address);
 		if (ret < 0)
 			return ret;
 		st->addr_prev = address;
-		if (msleep_interruptible(LTC2497_CONVERSION_TIME_MS))
+		if (msleep_interruptible(LTC249X_CONVERSION_TIME_MS))
 			return -ERESTARTSYS;
 	}
 	ret = i2c_master_recv(client, (char *)&st->buf, 3);
@@ -127,62 +122,6 @@ static int ltc2497_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
-#define LTC2497_CHAN(_chan, _addr, _ds_name) { \
-	.type = IIO_VOLTAGE, \
-	.indexed = 1, \
-	.channel = (_chan), \
-	.address = (_addr | (_chan / 2) | ((_chan & 1) ? LTC2497_SIGN : 0)), \
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
-	.datasheet_name = (_ds_name), \
-}
-
-#define LTC2497_CHAN_DIFF(_chan, _addr) { \
-	.type = IIO_VOLTAGE, \
-	.indexed = 1, \
-	.channel = (_chan) * 2 + ((_addr) & LTC2497_SIGN ? 1 : 0), \
-	.channel2 = (_chan) * 2 + ((_addr) & LTC2497_SIGN ? 0 : 1),\
-	.address = (_addr | _chan), \
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
-	.differential = 1, \
-}
-
-static const struct iio_chan_spec ltc2497_channel[] = {
-	LTC2497_CHAN(0, LTC2497_SGL, "CH0"),
-	LTC2497_CHAN(1, LTC2497_SGL, "CH1"),
-	LTC2497_CHAN(2, LTC2497_SGL, "CH2"),
-	LTC2497_CHAN(3, LTC2497_SGL, "CH3"),
-	LTC2497_CHAN(4, LTC2497_SGL, "CH4"),
-	LTC2497_CHAN(5, LTC2497_SGL, "CH5"),
-	LTC2497_CHAN(6, LTC2497_SGL, "CH6"),
-	LTC2497_CHAN(7, LTC2497_SGL, "CH7"),
-	LTC2497_CHAN(8, LTC2497_SGL, "CH8"),
-	LTC2497_CHAN(9, LTC2497_SGL, "CH9"),
-	LTC2497_CHAN(10, LTC2497_SGL, "CH10"),
-	LTC2497_CHAN(11, LTC2497_SGL, "CH11"),
-	LTC2497_CHAN(12, LTC2497_SGL, "CH12"),
-	LTC2497_CHAN(13, LTC2497_SGL, "CH13"),
-	LTC2497_CHAN(14, LTC2497_SGL, "CH14"),
-	LTC2497_CHAN(15, LTC2497_SGL, "CH15"),
-	LTC2497_CHAN_DIFF(0, LTC2497_DIFF),
-	LTC2497_CHAN_DIFF(1, LTC2497_DIFF),
-	LTC2497_CHAN_DIFF(2, LTC2497_DIFF),
-	LTC2497_CHAN_DIFF(3, LTC2497_DIFF),
-	LTC2497_CHAN_DIFF(4, LTC2497_DIFF),
-	LTC2497_CHAN_DIFF(5, LTC2497_DIFF),
-	LTC2497_CHAN_DIFF(6, LTC2497_DIFF),
-	LTC2497_CHAN_DIFF(7, LTC2497_DIFF),
-	LTC2497_CHAN_DIFF(0, LTC2497_DIFF | LTC2497_SIGN),
-	LTC2497_CHAN_DIFF(1, LTC2497_DIFF | LTC2497_SIGN),
-	LTC2497_CHAN_DIFF(2, LTC2497_DIFF | LTC2497_SIGN),
-	LTC2497_CHAN_DIFF(3, LTC2497_DIFF | LTC2497_SIGN),
-	LTC2497_CHAN_DIFF(4, LTC2497_DIFF | LTC2497_SIGN),
-	LTC2497_CHAN_DIFF(5, LTC2497_DIFF | LTC2497_SIGN),
-	LTC2497_CHAN_DIFF(6, LTC2497_DIFF | LTC2497_SIGN),
-	LTC2497_CHAN_DIFF(7, LTC2497_DIFF | LTC2497_SIGN),
-};
-
 static const struct iio_info ltc2497_info = {
 	.read_raw = ltc2497_read_raw,
 };
@@ -211,8 +150,8 @@ static int ltc2497_probe(struct i2c_client *client,
 	indio_dev->name = id->name;
 	indio_dev->info = &ltc2497_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = ltc2497_channel;
-	indio_dev->num_channels = ARRAY_SIZE(ltc2497_channel);
+	indio_dev->channels = ltc249x_channel;
+	indio_dev->num_channels = ltc249x_num_channels;
 
 	st->ref = devm_regulator_get(&client->dev, "vref");
 	if (IS_ERR(st->ref))
@@ -231,11 +170,11 @@ static int ltc2497_probe(struct i2c_client *client,
 		}
 	}
 
-	ret = i2c_smbus_write_byte(st->client, LTC2497_CONFIG_DEFAULT);
+	ret = i2c_smbus_write_byte(st->client, LTC249X_CONFIG_DEFAULT);
 	if (ret < 0)
 		goto err_array_unregister;
 
-	st->addr_prev = LTC2497_CONFIG_DEFAULT;
+	st->addr_prev = LTC249X_CONFIG_DEFAULT;
 	st->time_prev = ktime_get();
 
 	ret = iio_device_register(indio_dev);
diff --git a/drivers/iio/adc/ltc249x.c b/drivers/iio/adc/ltc249x.c
new file mode 100644
index 000000000000..571fce7cc808
--- /dev/null
+++ b/drivers/iio/adc/ltc249x.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/iio/iio.h>
+#include <linux/iio/driver.h>
+#include <linux/module.h>
+
+#define LTC249X_SGL			BIT(4)
+#define LTC249X_DIFF			0
+#define LTC249X_SIGN			BIT(3)
+
+#define LTC249X_CHAN(_chan, _addr, _ds_name) { \
+	.type = IIO_VOLTAGE, \
+	.indexed = 1, \
+	.channel = (_chan), \
+	.address = (_addr | (_chan / 2) | ((_chan & 1) ? LTC249X_SIGN : 0)), \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+	.datasheet_name = (_ds_name), \
+}
+
+#define LTC249X_CHAN_DIFF(_chan, _addr) { \
+	.type = IIO_VOLTAGE, \
+	.indexed = 1, \
+	.channel = (_chan) * 2 + ((_addr) & LTC249X_SIGN ? 1 : 0), \
+	.channel2 = (_chan) * 2 + ((_addr) & LTC249X_SIGN ? 0 : 1),\
+	.address = (_addr | _chan), \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+	.differential = 1, \
+}
+
+const struct iio_chan_spec ltc249x_channel[] = {
+	LTC249X_CHAN(0, LTC249X_SGL, "CH0"),
+	LTC249X_CHAN(1, LTC249X_SGL, "CH1"),
+	LTC249X_CHAN(2, LTC249X_SGL, "CH2"),
+	LTC249X_CHAN(3, LTC249X_SGL, "CH3"),
+	LTC249X_CHAN(4, LTC249X_SGL, "CH4"),
+	LTC249X_CHAN(5, LTC249X_SGL, "CH5"),
+	LTC249X_CHAN(6, LTC249X_SGL, "CH6"),
+	LTC249X_CHAN(7, LTC249X_SGL, "CH7"),
+	LTC249X_CHAN(8, LTC249X_SGL, "CH8"),
+	LTC249X_CHAN(9, LTC249X_SGL, "CH9"),
+	LTC249X_CHAN(10, LTC249X_SGL, "CH10"),
+	LTC249X_CHAN(11, LTC249X_SGL, "CH11"),
+	LTC249X_CHAN(12, LTC249X_SGL, "CH12"),
+	LTC249X_CHAN(13, LTC249X_SGL, "CH13"),
+	LTC249X_CHAN(14, LTC249X_SGL, "CH14"),
+	LTC249X_CHAN(15, LTC249X_SGL, "CH15"),
+	LTC249X_CHAN_DIFF(0, LTC249X_DIFF),
+	LTC249X_CHAN_DIFF(1, LTC249X_DIFF),
+	LTC249X_CHAN_DIFF(2, LTC249X_DIFF),
+	LTC249X_CHAN_DIFF(3, LTC249X_DIFF),
+	LTC249X_CHAN_DIFF(4, LTC249X_DIFF),
+	LTC249X_CHAN_DIFF(5, LTC249X_DIFF),
+	LTC249X_CHAN_DIFF(6, LTC249X_DIFF),
+	LTC249X_CHAN_DIFF(7, LTC249X_DIFF),
+	LTC249X_CHAN_DIFF(0, LTC249X_DIFF | LTC249X_SIGN),
+	LTC249X_CHAN_DIFF(1, LTC249X_DIFF | LTC249X_SIGN),
+	LTC249X_CHAN_DIFF(2, LTC249X_DIFF | LTC249X_SIGN),
+	LTC249X_CHAN_DIFF(3, LTC249X_DIFF | LTC249X_SIGN),
+	LTC249X_CHAN_DIFF(4, LTC249X_DIFF | LTC249X_SIGN),
+	LTC249X_CHAN_DIFF(5, LTC249X_DIFF | LTC249X_SIGN),
+	LTC249X_CHAN_DIFF(6, LTC249X_DIFF | LTC249X_SIGN),
+	LTC249X_CHAN_DIFF(7, LTC249X_DIFF | LTC249X_SIGN),
+};
+EXPORT_SYMBOL_NS_GPL(ltc249x_channel, LTC249X);
+
+const int ltc249x_num_channels = ARRAY_SIZE(ltc249x_channel);
+EXPORT_SYMBOL_NS_GPL(ltc249x_num_channels, LTC249X);
+
+MODULE_DESCRIPTION("common code for LTC2496/LTC2497 drivers");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/adc/ltc249x.h b/drivers/iio/adc/ltc249x.h
new file mode 100644
index 000000000000..dac8b5ed0ecf
--- /dev/null
+++ b/drivers/iio/adc/ltc249x.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#define LTC249X_ENABLE			0xA0
+#define LTC249X_CONFIG_DEFAULT		LTC249X_ENABLE
+#define LTC249X_CONVERSION_TIME_MS	150ULL
+
+extern const struct iio_chan_spec ltc249x_channel[];
+extern const int ltc249x_num_channels;
+
+MODULE_IMPORT_NS(LTC249X);
-- 
2.24.0.rc1

