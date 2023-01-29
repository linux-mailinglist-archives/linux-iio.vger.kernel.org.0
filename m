Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F13680002
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jan 2023 16:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjA2Pmi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Jan 2023 10:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbjA2Pmi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jan 2023 10:42:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F58F1F93A;
        Sun, 29 Jan 2023 07:42:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9EC6B80D1B;
        Sun, 29 Jan 2023 15:42:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDC0C4339C;
        Sun, 29 Jan 2023 15:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675006951;
        bh=AiYsY1Pjt06nmkXX9GlrsDATjOE8584u9ZkcrVI9COs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k44MUswAPKW20yXSG+7osdxrDN6A7QZSBrIkhZLiGXLO9kKS1G8/D+md6mu1ltvBS
         x/i9ElyO28wSGh3/ZJ71zCYC8wgcjTXmnnsmYlbLaHZNSDLA0uuqh7QCk42xUdbbxJ
         Dc48JN8x1R+mf3MPwRhcdbarSGR3SvHUuSrPx7lTgh9g+x+UBocGfi7Tvpwpe5enLH
         MnJJY5GKlwMhjZo4ZwYyKWYhzL/kDqWi4LuFyJDTElRGtwJY1v4wvHTvIoCWPUcmxV
         fyY95+twHZ+FmEchyepRHGeuU9pxL0kHzlg7rDSJxpenYs6g9Q5P81GcM8v90vg+qo
         5TSX+rRRIRHgA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 11/12] staging: iio: accel: adis16203: Move out of staging
Date:   Sun, 29 Jan 2023 15:56:01 +0000
Message-Id: <20230129155602.740743-12-jic23@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230129155602.740743-1-jic23@kernel.org>
References: <20230129155602.740743-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The main blocker of this driver moving previously was non standard
ABI for the 180 degree offset channel. Now support for that channel
has been dropped, this simple driver can move out of staging.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/Kconfig             |  12 ++
 drivers/iio/accel/Makefile            |   1 +
 drivers/iio/accel/adis16203.c         | 231 ++++++++++++++++++++++++++
 drivers/staging/iio/accel/Kconfig     |  12 --
 drivers/staging/iio/accel/Makefile    |   1 -
 drivers/staging/iio/accel/adis16203.c | 231 --------------------------
 6 files changed, 244 insertions(+), 244 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index b6b45d359f28..88d4b18bd5e8 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -18,6 +18,18 @@ config ADIS16201
 	  To compile this driver as a module, say M here: the module will
 	  be called adis16201.
 
+config ADIS16203
+	tristate "Analog Devices ADIS16203 Programmable 360 Degrees Inclinometer"
+	depends on SPI
+	select IIO_ADIS_LIB
+	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
+	help
+	  Say Y here to build support for Analog Devices adis16203 Programmable
+	  360 Degrees Inclinometer.
+
+	  To compile this driver as a module, say M here: the module will be
+	  called adis16203.
+
 config ADIS16209
 	tristate "Analog Devices ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer"
 	depends on SPI
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 311ead9c3ef1..b6f0cee52659 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -5,6 +5,7 @@
 
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_ADIS16201) += adis16201.o
+obj-$(CONFIG_ADIS16203) += adis16203.o
 obj-$(CONFIG_ADIS16209) += adis16209.o
 obj-$(CONFIG_ADXL313) += adxl313_core.o
 obj-$(CONFIG_ADXL313_I2C) += adxl313_i2c.o
diff --git a/drivers/iio/accel/adis16203.c b/drivers/iio/accel/adis16203.c
new file mode 100644
index 000000000000..1aaf9815aa66
--- /dev/null
+++ b/drivers/iio/accel/adis16203.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ADIS16203 Programmable 360 Degrees Inclinometer
+ *
+ * Copyright 2010 Analog Devices Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/imu/adis.h>
+
+#define ADIS16203_STARTUP_DELAY_MS		220
+
+#define ADIS16203_FLASH_CNT			0x00
+#define ADIS16203_SUPPLY_OUT			0x02
+#define ADIS16203_AUX_ADC			0x08
+#define ADIS16203_TEMP_OUT			0x0A
+#define ADIS16203_INCL_OUT			0x0C
+#define ADIS16203_INCL_OUT_180			0x0E
+#define ADIS16203_INCL_NULL			0x18
+#define ADIS16203_ALM_MAG1			0x20
+#define ADIS16203_ALM_MAG2			0x22
+#define ADIS16203_ALM_SMPL1			0x24
+#define ADIS16203_ALM_SMPL2			0x26
+#define ADIS16203_ALM_CTRL			0x28
+#define ADIS16203_AUX_DAC			0x30
+#define ADIS16203_GPIO_CTRL			0x32
+#define ADIS16203_MSC_CTRL			0x34
+#define ADIS16203_SMPL_PRD			0x36
+#define ADIS16203_AVG_CNT			0x38
+#define ADIS16203_SLP_CNT			0x3A
+#define ADIS16203_DIAG_STAT			0x3C
+#define ADIS16203_GLOB_CMD			0x3E
+
+#define ADIS16203_MSC_CTRL_PWRUP_SELF_TEST_DIS	BIT(10)
+#define ADIS16203_MSC_CTRL_REVERSE_ROT_EN	BIT(9)
+#define ADIS16203_MSC_CTRL_SELF_TEST_EN		BIT(8)
+#define ADIS16203_MSC_CTRL_DATA_RDY_EN		BIT(2)
+#define ADIS16203_MSC_CTRL_ACTIVE_HIGH		BIT(1)
+#define ADIS16203_MSC_CTRL_DATA_RDY_DIO1	BIT(0)
+
+#define ADIS16203_DIAG_STAT_ALARM2		BIT(9)
+#define ADIS16203_DIAG_STAT_ALARM1		BIT(8)
+#define ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT	5
+#define ADIS16203_DIAG_STAT_SPI_FAIL_BIT	3
+#define ADIS16203_DIAG_STAT_FLASH_UPT_BIT	2
+#define ADIS16203_DIAG_STAT_POWER_HIGH_BIT	1
+#define ADIS16203_DIAG_STAT_POWER_LOW_BIT	0
+
+#define ADIS16203_GLOB_CMD_SW_RESET		BIT(7)
+#define ADIS16203_GLOB_CMD_CLEAR_STAT		BIT(4)
+#define ADIS16203_GLOB_CMD_FACTORY_CAL		BIT(1)
+
+#define ADIS16203_ERROR_ACTIVE			BIT(14)
+
+#define ADIS16203_INCLI_NULL_MSK		GENMASK(13, 0)
+
+enum adis16203_scan {
+	 ADIS16203_SCAN_INCLI_X,
+	 ADIS16203_SCAN_SUPPLY,
+	 ADIS16203_SCAN_AUX_ADC,
+	 ADIS16203_SCAN_TEMP,
+};
+
+static int adis16203_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int val, int val2, long mask)
+{
+	struct adis *st = iio_priv(indio_dev);
+
+	if (mask != IIO_CHAN_INFO_CALIBBIAS)
+		return -EINVAL;
+
+	return adis_write_reg_16(st, ADIS16203_INCL_NULL,
+				 FIELD_PREP(ADIS16203_INCLI_NULL_MSK, val));
+}
+
+static int adis16203_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val, int *val2, long mask)
+{
+	struct adis *st = iio_priv(indio_dev);
+	int ret;
+	s16 val16;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		return adis_single_conversion(indio_dev, chan,
+					      ADIS16203_ERROR_ACTIVE, val);
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			if (chan->channel == 0) {
+				*val = 1;
+				*val2 = 220000; /* 1.22 mV */
+			} else {
+				*val = 0;
+				*val2 = 610000; /* 0.61 mV */
+			}
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_TEMP:
+			*val = -470; /* -0.47 C */
+			*val2 = 0;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_INCLI:
+			*val = 0;
+			*val2 = 25000; /* 0.025 degree */
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_OFFSET:
+		*val = 25000 / -470 - 1278; /* 25 C = 1278 */
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		ret = adis_read_reg_16(st, ADIS16203_INCL_NULL, &val16);
+		if (ret)
+			return ret;
+		*val = sign_extend32(val16, 13);
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_chan_spec adis16203_channels[] = {
+	ADIS_SUPPLY_CHAN(ADIS16203_SUPPLY_OUT, ADIS16203_SCAN_SUPPLY, 0, 12),
+	ADIS_AUX_ADC_CHAN(ADIS16203_AUX_ADC, ADIS16203_SCAN_AUX_ADC, 0, 12),
+	ADIS_INCLI_CHAN(X, ADIS16203_INCL_OUT, ADIS16203_SCAN_INCLI_X,
+			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
+	ADIS_TEMP_CHAN(ADIS16203_TEMP_OUT, ADIS16203_SCAN_TEMP, 0, 12),
+	IIO_CHAN_SOFT_TIMESTAMP(4),
+};
+
+static const struct iio_info adis16203_info = {
+	.read_raw = adis16203_read_raw,
+	.write_raw = adis16203_write_raw,
+	.update_scan_mode = adis_update_scan_mode,
+};
+
+static const char * const adis16203_status_error_msgs[] = {
+	[ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT] = "Self test failure",
+	[ADIS16203_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
+	[ADIS16203_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
+	[ADIS16203_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
+	[ADIS16203_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 2.975V",
+};
+
+static const struct adis_timeout adis16203_timeouts = {
+	.reset_ms = ADIS16203_STARTUP_DELAY_MS,
+	.sw_reset_ms = ADIS16203_STARTUP_DELAY_MS,
+	.self_test_ms = ADIS16203_STARTUP_DELAY_MS
+};
+
+static const struct adis_data adis16203_data = {
+	.read_delay = 20,
+	.msc_ctrl_reg = ADIS16203_MSC_CTRL,
+	.glob_cmd_reg = ADIS16203_GLOB_CMD,
+	.diag_stat_reg = ADIS16203_DIAG_STAT,
+
+	.self_test_mask = ADIS16203_MSC_CTRL_SELF_TEST_EN,
+	.self_test_reg = ADIS16203_MSC_CTRL,
+	.self_test_no_autoclear = true,
+	.timeouts = &adis16203_timeouts,
+
+	.status_error_msgs = adis16203_status_error_msgs,
+	.status_error_mask = BIT(ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT) |
+		BIT(ADIS16203_DIAG_STAT_SPI_FAIL_BIT) |
+		BIT(ADIS16203_DIAG_STAT_FLASH_UPT_BIT) |
+		BIT(ADIS16203_DIAG_STAT_POWER_HIGH_BIT) |
+		BIT(ADIS16203_DIAG_STAT_POWER_LOW_BIT),
+};
+
+static int adis16203_probe(struct spi_device *spi)
+{
+	int ret;
+	struct iio_dev *indio_dev;
+	struct adis *st;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+	st = iio_priv(indio_dev);
+
+	indio_dev->name = "adis16203";
+	indio_dev->channels = adis16203_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adis16203_channels);
+	indio_dev->info = &adis16203_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = adis_init(st, indio_dev, spi, &adis16203_data);
+	if (ret)
+		return ret;
+
+	ret = devm_adis_setup_buffer_and_trigger(st, indio_dev, NULL);
+	if (ret)
+		return ret;
+
+	/* Get the device into a sane initial state */
+	ret = __adis_initial_startup(st);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct of_device_id adis16203_of_match[] = {
+	{ .compatible = "adi,adis16203" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adis16203_of_match);
+
+static struct spi_driver adis16203_driver = {
+	.driver = {
+		.name = "adis16203",
+		.of_match_table = adis16203_of_match,
+	},
+	.probe = adis16203_probe,
+};
+module_spi_driver(adis16203_driver);
+
+MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
+MODULE_DESCRIPTION("Analog Devices ADIS16203 Programmable 360 Degrees Inclinometer");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("spi:adis16203");
+MODULE_IMPORT_NS(IIO_ADISLIB);
diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig
index 3318997a7009..3769af8719f3 100644
--- a/drivers/staging/iio/accel/Kconfig
+++ b/drivers/staging/iio/accel/Kconfig
@@ -4,18 +4,6 @@
 #
 menu "Accelerometers"
 
-config ADIS16203
-	tristate "Analog Devices ADIS16203 Programmable 360 Degrees Inclinometer"
-	depends on SPI
-	select IIO_ADIS_LIB
-	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
-	help
-	  Say Y here to build support for Analog Devices adis16203 Programmable
-	  360 Degrees Inclinometer.
-
-	  To compile this driver as a module, say M here: the module will be
-	  called adis16203.
-
 config ADIS16240
 	tristate "Analog Devices ADIS16240 Programmable Impact Sensor and Recorder"
 	depends on SPI
diff --git a/drivers/staging/iio/accel/Makefile b/drivers/staging/iio/accel/Makefile
index 094cc9be35bd..b0beec471814 100644
--- a/drivers/staging/iio/accel/Makefile
+++ b/drivers/staging/iio/accel/Makefile
@@ -3,5 +3,4 @@
 # Makefile for industrial I/O accelerometer drivers
 #
 
-obj-$(CONFIG_ADIS16203) += adis16203.o
 obj-$(CONFIG_ADIS16240) += adis16240.o
diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
deleted file mode 100644
index 1aaf9815aa66..000000000000
--- a/drivers/staging/iio/accel/adis16203.c
+++ /dev/null
@@ -1,231 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * ADIS16203 Programmable 360 Degrees Inclinometer
- *
- * Copyright 2010 Analog Devices Inc.
- */
-
-#include <linux/bitfield.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/spi/spi.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/imu/adis.h>
-
-#define ADIS16203_STARTUP_DELAY_MS		220
-
-#define ADIS16203_FLASH_CNT			0x00
-#define ADIS16203_SUPPLY_OUT			0x02
-#define ADIS16203_AUX_ADC			0x08
-#define ADIS16203_TEMP_OUT			0x0A
-#define ADIS16203_INCL_OUT			0x0C
-#define ADIS16203_INCL_OUT_180			0x0E
-#define ADIS16203_INCL_NULL			0x18
-#define ADIS16203_ALM_MAG1			0x20
-#define ADIS16203_ALM_MAG2			0x22
-#define ADIS16203_ALM_SMPL1			0x24
-#define ADIS16203_ALM_SMPL2			0x26
-#define ADIS16203_ALM_CTRL			0x28
-#define ADIS16203_AUX_DAC			0x30
-#define ADIS16203_GPIO_CTRL			0x32
-#define ADIS16203_MSC_CTRL			0x34
-#define ADIS16203_SMPL_PRD			0x36
-#define ADIS16203_AVG_CNT			0x38
-#define ADIS16203_SLP_CNT			0x3A
-#define ADIS16203_DIAG_STAT			0x3C
-#define ADIS16203_GLOB_CMD			0x3E
-
-#define ADIS16203_MSC_CTRL_PWRUP_SELF_TEST_DIS	BIT(10)
-#define ADIS16203_MSC_CTRL_REVERSE_ROT_EN	BIT(9)
-#define ADIS16203_MSC_CTRL_SELF_TEST_EN		BIT(8)
-#define ADIS16203_MSC_CTRL_DATA_RDY_EN		BIT(2)
-#define ADIS16203_MSC_CTRL_ACTIVE_HIGH		BIT(1)
-#define ADIS16203_MSC_CTRL_DATA_RDY_DIO1	BIT(0)
-
-#define ADIS16203_DIAG_STAT_ALARM2		BIT(9)
-#define ADIS16203_DIAG_STAT_ALARM1		BIT(8)
-#define ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT	5
-#define ADIS16203_DIAG_STAT_SPI_FAIL_BIT	3
-#define ADIS16203_DIAG_STAT_FLASH_UPT_BIT	2
-#define ADIS16203_DIAG_STAT_POWER_HIGH_BIT	1
-#define ADIS16203_DIAG_STAT_POWER_LOW_BIT	0
-
-#define ADIS16203_GLOB_CMD_SW_RESET		BIT(7)
-#define ADIS16203_GLOB_CMD_CLEAR_STAT		BIT(4)
-#define ADIS16203_GLOB_CMD_FACTORY_CAL		BIT(1)
-
-#define ADIS16203_ERROR_ACTIVE			BIT(14)
-
-#define ADIS16203_INCLI_NULL_MSK		GENMASK(13, 0)
-
-enum adis16203_scan {
-	 ADIS16203_SCAN_INCLI_X,
-	 ADIS16203_SCAN_SUPPLY,
-	 ADIS16203_SCAN_AUX_ADC,
-	 ADIS16203_SCAN_TEMP,
-};
-
-static int adis16203_write_raw(struct iio_dev *indio_dev,
-			       struct iio_chan_spec const *chan,
-			       int val, int val2, long mask)
-{
-	struct adis *st = iio_priv(indio_dev);
-
-	if (mask != IIO_CHAN_INFO_CALIBBIAS)
-		return -EINVAL;
-
-	return adis_write_reg_16(st, ADIS16203_INCL_NULL,
-				 FIELD_PREP(ADIS16203_INCLI_NULL_MSK, val));
-}
-
-static int adis16203_read_raw(struct iio_dev *indio_dev,
-			      struct iio_chan_spec const *chan,
-			      int *val, int *val2, long mask)
-{
-	struct adis *st = iio_priv(indio_dev);
-	int ret;
-	s16 val16;
-
-	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
-		return adis_single_conversion(indio_dev, chan,
-					      ADIS16203_ERROR_ACTIVE, val);
-	case IIO_CHAN_INFO_SCALE:
-		switch (chan->type) {
-		case IIO_VOLTAGE:
-			if (chan->channel == 0) {
-				*val = 1;
-				*val2 = 220000; /* 1.22 mV */
-			} else {
-				*val = 0;
-				*val2 = 610000; /* 0.61 mV */
-			}
-			return IIO_VAL_INT_PLUS_MICRO;
-		case IIO_TEMP:
-			*val = -470; /* -0.47 C */
-			*val2 = 0;
-			return IIO_VAL_INT_PLUS_MICRO;
-		case IIO_INCLI:
-			*val = 0;
-			*val2 = 25000; /* 0.025 degree */
-			return IIO_VAL_INT_PLUS_MICRO;
-		default:
-			return -EINVAL;
-		}
-	case IIO_CHAN_INFO_OFFSET:
-		*val = 25000 / -470 - 1278; /* 25 C = 1278 */
-		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_CALIBBIAS:
-		ret = adis_read_reg_16(st, ADIS16203_INCL_NULL, &val16);
-		if (ret)
-			return ret;
-		*val = sign_extend32(val16, 13);
-		return IIO_VAL_INT;
-	default:
-		return -EINVAL;
-	}
-}
-
-static const struct iio_chan_spec adis16203_channels[] = {
-	ADIS_SUPPLY_CHAN(ADIS16203_SUPPLY_OUT, ADIS16203_SCAN_SUPPLY, 0, 12),
-	ADIS_AUX_ADC_CHAN(ADIS16203_AUX_ADC, ADIS16203_SCAN_AUX_ADC, 0, 12),
-	ADIS_INCLI_CHAN(X, ADIS16203_INCL_OUT, ADIS16203_SCAN_INCLI_X,
-			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
-	ADIS_TEMP_CHAN(ADIS16203_TEMP_OUT, ADIS16203_SCAN_TEMP, 0, 12),
-	IIO_CHAN_SOFT_TIMESTAMP(4),
-};
-
-static const struct iio_info adis16203_info = {
-	.read_raw = adis16203_read_raw,
-	.write_raw = adis16203_write_raw,
-	.update_scan_mode = adis_update_scan_mode,
-};
-
-static const char * const adis16203_status_error_msgs[] = {
-	[ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT] = "Self test failure",
-	[ADIS16203_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
-	[ADIS16203_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
-	[ADIS16203_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
-	[ADIS16203_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 2.975V",
-};
-
-static const struct adis_timeout adis16203_timeouts = {
-	.reset_ms = ADIS16203_STARTUP_DELAY_MS,
-	.sw_reset_ms = ADIS16203_STARTUP_DELAY_MS,
-	.self_test_ms = ADIS16203_STARTUP_DELAY_MS
-};
-
-static const struct adis_data adis16203_data = {
-	.read_delay = 20,
-	.msc_ctrl_reg = ADIS16203_MSC_CTRL,
-	.glob_cmd_reg = ADIS16203_GLOB_CMD,
-	.diag_stat_reg = ADIS16203_DIAG_STAT,
-
-	.self_test_mask = ADIS16203_MSC_CTRL_SELF_TEST_EN,
-	.self_test_reg = ADIS16203_MSC_CTRL,
-	.self_test_no_autoclear = true,
-	.timeouts = &adis16203_timeouts,
-
-	.status_error_msgs = adis16203_status_error_msgs,
-	.status_error_mask = BIT(ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT) |
-		BIT(ADIS16203_DIAG_STAT_SPI_FAIL_BIT) |
-		BIT(ADIS16203_DIAG_STAT_FLASH_UPT_BIT) |
-		BIT(ADIS16203_DIAG_STAT_POWER_HIGH_BIT) |
-		BIT(ADIS16203_DIAG_STAT_POWER_LOW_BIT),
-};
-
-static int adis16203_probe(struct spi_device *spi)
-{
-	int ret;
-	struct iio_dev *indio_dev;
-	struct adis *st;
-
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
-	if (!indio_dev)
-		return -ENOMEM;
-	st = iio_priv(indio_dev);
-
-	indio_dev->name = "adis16203";
-	indio_dev->channels = adis16203_channels;
-	indio_dev->num_channels = ARRAY_SIZE(adis16203_channels);
-	indio_dev->info = &adis16203_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
-
-	ret = adis_init(st, indio_dev, spi, &adis16203_data);
-	if (ret)
-		return ret;
-
-	ret = devm_adis_setup_buffer_and_trigger(st, indio_dev, NULL);
-	if (ret)
-		return ret;
-
-	/* Get the device into a sane initial state */
-	ret = __adis_initial_startup(st);
-	if (ret)
-		return ret;
-
-	return devm_iio_device_register(&spi->dev, indio_dev);
-}
-
-static const struct of_device_id adis16203_of_match[] = {
-	{ .compatible = "adi,adis16203" },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, adis16203_of_match);
-
-static struct spi_driver adis16203_driver = {
-	.driver = {
-		.name = "adis16203",
-		.of_match_table = adis16203_of_match,
-	},
-	.probe = adis16203_probe,
-};
-module_spi_driver(adis16203_driver);
-
-MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
-MODULE_DESCRIPTION("Analog Devices ADIS16203 Programmable 360 Degrees Inclinometer");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("spi:adis16203");
-MODULE_IMPORT_NS(IIO_ADISLIB);
-- 
2.39.1

