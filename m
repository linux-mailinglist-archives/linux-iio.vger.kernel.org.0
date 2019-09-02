Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFE90A4CFB
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2019 03:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfIBBAa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Sep 2019 21:00:30 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33733 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbfIBBAa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Sep 2019 21:00:30 -0400
Received: by mail-qt1-f196.google.com with SMTP id r5so8789591qtd.0;
        Sun, 01 Sep 2019 18:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S5omctu3Ga2ES69Ck/wWzKYXRtaxzVx8DXZXXjNL1gg=;
        b=MAINTJU/N+e6WrUdjUqYYDBWuQUHkxX6HOUdzVL3S4yII1vmQYYfxB8MIYRSexvlGQ
         HURSihycIvvKv0/cKP37tydIhbiDhEkwNVzVmtuP/AlIKIuOMUX3FZncUB5u1gPn5TGo
         L9q3k57HyryBwtG9TVH7wR7toEaN6DhU4pyG9D3lslmaXR+8nMyuxjs5LQKahsG4LH1+
         X5gjluUmmFH9oRevYD7CizobxeRQgMtrkoMrWaVgLF53SpKlb+CutvDjezWegKh8R+g6
         WI/tOESPTiOg21JGkp9zxqexNCltu7Zw1nRl0HaKPUkueTuE9noTijVxmvBxxgsTaOPD
         gQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S5omctu3Ga2ES69Ck/wWzKYXRtaxzVx8DXZXXjNL1gg=;
        b=Sg3gEUnKnU02nwH8w2AZBOR7pZ8F6duEsTO70QJ0enEMCrzOovuQhpNAkCmrWj8s0E
         AVdt4kinimtIMZY2yjkIC0JUnp/4axXJqxsssYZ2a6EX2PSKG0cGM67Pjw6IxgQ1E6vU
         uNTZXxABBaAgsGHE27jNfxH44GiCY2E9R71A5EUyC6vWpq/09WQ+23cqSN+eyYpWCL7B
         xQuFkB5VR5ETDEC5JPyZSsay9u+8jM7Xx+UjfjOPNckVqUCE6qR/aZE2GlPMJgj51dxx
         vcm8/ogVnaF/Q26iteDY2OLI1hunNIBuwcVf/WxWH+PRSKbHXYSH3NexdIRhZoZDWqjE
         Ahng==
X-Gm-Message-State: APjAAAXLjqXKIekJIupzKTuj/gDMYEtKrV3NCgNWq7yFJJ7UdzOv5KXb
        +QxdoGua+w3+WhPg5f/B3bo=
X-Google-Smtp-Source: APXvYqx1TPKKNtQd/gcT5WOGWDABrv8caHizazIX4amvpcUzP4e8xni3eC1jf+HfJdCj43R/xqBhZg==
X-Received: by 2002:a0c:eb11:: with SMTP id j17mr3032379qvp.162.1567386028357;
        Sun, 01 Sep 2019 18:00:28 -0700 (PDT)
Received: from localhost.localdomain (201-93-54-168.dial-up.telesp.net.br. [201.93.54.168])
        by smtp.gmail.com with ESMTPSA id f22sm5596588qkk.45.2019.09.01.18.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2019 18:00:28 -0700 (PDT)
From:   Rodrigo Carvalho <rodrigorsdc@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        alexandru.ardelean@analog.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Rodrigo Carvalho <rodrigorsdc@gmail.com>
Subject: [PATCH 2/2] staging: iio: accel: adis16240: move out of staging
Date:   Sun,  1 Sep 2019 21:59:38 -0300
Message-Id: <20190902005938.7734-2-rodrigorsdc@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190902005938.7734-1-rodrigorsdc@gmail.com>
References: <20190902005938.7734-1-rodrigorsdc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Move ADIS16240 driver from staging to mainline.

The ADIS16240 is a fully integrated digital shock detection
and recorder system.

Signed-off-by: Rodrigo Ribeiro Carvalho <rodrigorsdc@gmail.com>
---
 drivers/iio/accel/Kconfig             |  12 +
 drivers/iio/accel/Makefile            |   1 +
 drivers/iio/accel/adis16240.c         | 454 ++++++++++++++++++++++++++
 drivers/staging/iio/accel/Kconfig     |  12 -
 drivers/staging/iio/accel/Makefile    |   1 -
 drivers/staging/iio/accel/adis16240.c | 454 --------------------------
 6 files changed, 467 insertions(+), 467 deletions(-)
 create mode 100644 drivers/iio/accel/adis16240.c
 delete mode 100644 drivers/staging/iio/accel/adis16240.c

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index d4ef35aeb579..91fd8741c95f 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -30,6 +30,18 @@ config ADIS16209
 	  To compile this driver as a module, say M here: the module will be
 	  called adis16209.
 
+config ADIS16240
+	tristate "Analog Devices ADIS16240 Programmable Impact Sensor and Recorder"
+	depends on SPI
+	select IIO_ADIS_LIB
+	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
+	help
+	  Say Y here to build support for Analog Devices adis16240 programmable
+	  impact Sensor and recorder.
+
+	  To compile this driver as a module, say M here: the module will be
+	  called adis16240.
+	  
 config ADXL345
 	tristate
 
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 56bd0215e0d4..f7e025a86dd9 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -6,6 +6,7 @@
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_ADIS16201) += adis16201.o
 obj-$(CONFIG_ADIS16209) += adis16209.o
+obj-$(CONFIG_ADIS16240) += adis16240.o
 obj-$(CONFIG_ADXL345) += adxl345_core.o
 obj-$(CONFIG_ADXL345_I2C) += adxl345_i2c.o
 obj-$(CONFIG_ADXL345_SPI) += adxl345_spi.o
diff --git a/drivers/iio/accel/adis16240.c b/drivers/iio/accel/adis16240.c
new file mode 100644
index 000000000000..82099db4bf0c
--- /dev/null
+++ b/drivers/iio/accel/adis16240.c
@@ -0,0 +1,454 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ADIS16240 Programmable Impact Sensor and Recorder driver
+ *
+ * Copyright 2010 Analog Devices Inc.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/gpio.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/spi/spi.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/list.h>
+#include <linux/module.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/imu/adis.h>
+
+#define ADIS16240_STARTUP_DELAY	220 /* ms */
+
+/* Flash memory write count */
+#define ADIS16240_FLASH_CNT      0x00
+
+/* Output, power supply */
+#define ADIS16240_SUPPLY_OUT     0x02
+
+/* Output, x-axis accelerometer */
+#define ADIS16240_XACCL_OUT      0x04
+
+/* Output, y-axis accelerometer */
+#define ADIS16240_YACCL_OUT      0x06
+
+/* Output, z-axis accelerometer */
+#define ADIS16240_ZACCL_OUT      0x08
+
+/* Output, auxiliary ADC input */
+#define ADIS16240_AUX_ADC        0x0A
+
+/* Output, temperature */
+#define ADIS16240_TEMP_OUT       0x0C
+
+/* Output, x-axis acceleration peak */
+#define ADIS16240_XPEAK_OUT      0x0E
+
+/* Output, y-axis acceleration peak */
+#define ADIS16240_YPEAK_OUT      0x10
+
+/* Output, z-axis acceleration peak */
+#define ADIS16240_ZPEAK_OUT      0x12
+
+/* Output, sum-of-squares acceleration peak */
+#define ADIS16240_XYZPEAK_OUT    0x14
+
+/* Output, Capture Buffer 1, X and Y acceleration */
+#define ADIS16240_CAPT_BUF1      0x16
+
+/* Output, Capture Buffer 2, Z acceleration */
+#define ADIS16240_CAPT_BUF2      0x18
+
+/* Diagnostic, error flags */
+#define ADIS16240_DIAG_STAT      0x1A
+
+/* Diagnostic, event counter */
+#define ADIS16240_EVNT_CNTR      0x1C
+
+/* Diagnostic, check sum value from firmware test */
+#define ADIS16240_CHK_SUM        0x1E
+
+/* Calibration, x-axis acceleration offset adjustment */
+#define ADIS16240_XACCL_OFF      0x20
+
+/* Calibration, y-axis acceleration offset adjustment */
+#define ADIS16240_YACCL_OFF      0x22
+
+/* Calibration, z-axis acceleration offset adjustment */
+#define ADIS16240_ZACCL_OFF      0x24
+
+/* Clock, hour and minute */
+#define ADIS16240_CLK_TIME       0x2E
+
+/* Clock, month and day */
+#define ADIS16240_CLK_DATE       0x30
+
+/* Clock, year */
+#define ADIS16240_CLK_YEAR       0x32
+
+/* Wake-up setting, hour and minute */
+#define ADIS16240_WAKE_TIME      0x34
+
+/* Wake-up setting, month and day */
+#define ADIS16240_WAKE_DATE      0x36
+
+/* Alarm 1 amplitude threshold */
+#define ADIS16240_ALM_MAG1       0x38
+
+/* Alarm 2 amplitude threshold */
+#define ADIS16240_ALM_MAG2       0x3A
+
+/* Alarm control */
+#define ADIS16240_ALM_CTRL       0x3C
+
+/* Capture, external trigger control */
+#define ADIS16240_XTRIG_CTRL     0x3E
+
+/* Capture, address pointer */
+#define ADIS16240_CAPT_PNTR      0x40
+
+/* Capture, configuration and control */
+#define ADIS16240_CAPT_CTRL      0x42
+
+/* General-purpose digital input/output control */
+#define ADIS16240_GPIO_CTRL      0x44
+
+/* Miscellaneous control */
+#define ADIS16240_MSC_CTRL       0x46
+
+/* Internal sample period (rate) control */
+#define ADIS16240_SMPL_PRD       0x48
+
+/* System command */
+#define ADIS16240_GLOB_CMD       0x4A
+
+/* MSC_CTRL */
+
+/* Enables sum-of-squares output (XYZPEAK_OUT) */
+#define ADIS16240_MSC_CTRL_XYZPEAK_OUT_EN	BIT(15)
+
+/* Enables peak tracking output (XPEAK_OUT, YPEAK_OUT, and ZPEAK_OUT) */
+#define ADIS16240_MSC_CTRL_X_Y_ZPEAK_OUT_EN	BIT(14)
+
+/* Self-test enable: 1 = apply electrostatic force, 0 = disabled */
+#define ADIS16240_MSC_CTRL_SELF_TEST_EN	        BIT(8)
+
+/* Data-ready enable: 1 = enabled, 0 = disabled */
+#define ADIS16240_MSC_CTRL_DATA_RDY_EN	        BIT(2)
+
+/* Data-ready polarity: 1 = active high, 0 = active low */
+#define ADIS16240_MSC_CTRL_ACTIVE_HIGH	        BIT(1)
+
+/* Data-ready line selection: 1 = DIO2, 0 = DIO1 */
+#define ADIS16240_MSC_CTRL_DATA_RDY_DIO2	BIT(0)
+
+/* DIAG_STAT */
+
+/* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
+#define ADIS16240_DIAG_STAT_ALARM2      BIT(9)
+
+/* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
+#define ADIS16240_DIAG_STAT_ALARM1      BIT(8)
+
+/* Capture buffer full: 1 = capture buffer is full */
+#define ADIS16240_DIAG_STAT_CPT_BUF_FUL BIT(7)
+
+/* Flash test, checksum flag: 1 = mismatch, 0 = match */
+#define ADIS16240_DIAG_STAT_CHKSUM      BIT(6)
+
+/* Power-on, self-test flag: 1 = failure, 0 = pass */
+#define ADIS16240_DIAG_STAT_PWRON_FAIL_BIT  5
+
+/* Power-on self-test: 1 = in-progress, 0 = complete */
+#define ADIS16240_DIAG_STAT_PWRON_BUSY  BIT(4)
+
+/* SPI communications failure */
+#define ADIS16240_DIAG_STAT_SPI_FAIL_BIT	3
+
+/* Flash update failure */
+#define ADIS16240_DIAG_STAT_FLASH_UPT_BIT	2
+
+/* Power supply above 3.625 V */
+#define ADIS16240_DIAG_STAT_POWER_HIGH_BIT	1
+
+ /* Power supply below 2.225 V */
+#define ADIS16240_DIAG_STAT_POWER_LOW_BIT	0
+
+/* GLOB_CMD */
+
+#define ADIS16240_GLOB_CMD_RESUME	BIT(8)
+#define ADIS16240_GLOB_CMD_SW_RESET	BIT(7)
+#define ADIS16240_GLOB_CMD_STANDBY	BIT(2)
+
+#define ADIS16240_ERROR_ACTIVE          BIT(14)
+
+/* At the moment triggers are only used for ring buffer
+ * filling. This may change!
+ */
+
+enum adis16240_scan {
+	ADIS16240_SCAN_ACC_X,
+	ADIS16240_SCAN_ACC_Y,
+	ADIS16240_SCAN_ACC_Z,
+	ADIS16240_SCAN_SUPPLY,
+	ADIS16240_SCAN_AUX_ADC,
+	ADIS16240_SCAN_TEMP,
+};
+
+static ssize_t adis16240_spi_read_signed(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf,
+					 unsigned int bits)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adis *st = iio_priv(indio_dev);
+	int ret;
+	s16 val = 0;
+	unsigned int shift = 16 - bits;
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	ret = adis_read_reg_16(st,
+			       this_attr->address, (u16 *)&val);
+	if (ret)
+		return ret;
+
+	if (val & ADIS16240_ERROR_ACTIVE)
+		adis_check_status(st);
+
+	val = (s16)(val << shift) >> shift;
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t adis16240_read_12bit_signed(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	return adis16240_spi_read_signed(dev, attr, buf, 12);
+}
+
+static IIO_DEVICE_ATTR(in_accel_xyz_squared_peak_raw, 0444,
+		       adis16240_read_12bit_signed, NULL,
+		       ADIS16240_XYZPEAK_OUT);
+
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("4096");
+
+static const u8 adis16240_addresses[][2] = {
+	[ADIS16240_SCAN_ACC_X] = { ADIS16240_XACCL_OFF, ADIS16240_XPEAK_OUT },
+	[ADIS16240_SCAN_ACC_Y] = { ADIS16240_YACCL_OFF, ADIS16240_YPEAK_OUT },
+	[ADIS16240_SCAN_ACC_Z] = { ADIS16240_ZACCL_OFF, ADIS16240_ZPEAK_OUT },
+};
+
+static int adis16240_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val, int *val2,
+			      long mask)
+{
+	struct adis *st = iio_priv(indio_dev);
+	int ret;
+	u8 addr;
+	s16 val16;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		return adis_single_conversion(indio_dev, chan,
+				ADIS16240_ERROR_ACTIVE, val);
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			if (chan->channel == 0) {
+				*val = 4;
+				*val2 = 880000; /* 4.88 mV */
+				return IIO_VAL_INT_PLUS_MICRO;
+			}
+			return -EINVAL;
+		case IIO_TEMP:
+			*val = 244; /* 0.244 C */
+			*val2 = 0;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_ACCEL:
+			*val = 0;
+			*val2 = IIO_G_TO_M_S_2(51400); /* 51.4 mg */
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case IIO_CHAN_INFO_PEAK_SCALE:
+		*val = 0;
+		*val2 = IIO_G_TO_M_S_2(51400); /* 51.4 mg */
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = 25000 / 244 - 0x133; /* 25 C = 0x133 */
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		addr = adis16240_addresses[chan->scan_index][0];
+		ret = adis_read_reg_16(st, addr, &val16);
+		if (ret)
+			return ret;
+		*val = sign_extend32(val16, 9);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_PEAK:
+		addr = adis16240_addresses[chan->scan_index][1];
+		ret = adis_read_reg_16(st, addr, &val16);
+		if (ret)
+			return ret;
+		*val = sign_extend32(val16, 9);
+		return IIO_VAL_INT;
+	}
+	return -EINVAL;
+}
+
+static int adis16240_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int val,
+			       int val2,
+			       long mask)
+{
+	struct adis *st = iio_priv(indio_dev);
+	u8 addr;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_CALIBBIAS:
+		addr = adis16240_addresses[chan->scan_index][0];
+		return adis_write_reg_16(st, addr, val & GENMASK(9, 0));
+	}
+	return -EINVAL;
+}
+
+static const struct iio_chan_spec adis16240_channels[] = {
+	ADIS_SUPPLY_CHAN(ADIS16240_SUPPLY_OUT, ADIS16240_SCAN_SUPPLY, 0, 10),
+	ADIS_AUX_ADC_CHAN(ADIS16240_AUX_ADC, ADIS16240_SCAN_AUX_ADC, 0, 10),
+	ADIS_ACCEL_CHAN(X, ADIS16240_XACCL_OUT, ADIS16240_SCAN_ACC_X,
+			BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_PEAK),
+			0, 10),
+	ADIS_ACCEL_CHAN(Y, ADIS16240_YACCL_OUT, ADIS16240_SCAN_ACC_Y,
+			BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_PEAK),
+			0, 10),
+	ADIS_ACCEL_CHAN(Z, ADIS16240_ZACCL_OUT, ADIS16240_SCAN_ACC_Z,
+			BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_PEAK),
+			0, 10),
+	ADIS_TEMP_CHAN(ADIS16240_TEMP_OUT, ADIS16240_SCAN_TEMP, 0, 10),
+	IIO_CHAN_SOFT_TIMESTAMP(6)
+};
+
+static struct attribute *adis16240_attributes[] = {
+	&iio_dev_attr_in_accel_xyz_squared_peak_raw.dev_attr.attr,
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group adis16240_attribute_group = {
+	.attrs = adis16240_attributes,
+};
+
+static const struct iio_info adis16240_info = {
+	.attrs = &adis16240_attribute_group,
+	.read_raw = adis16240_read_raw,
+	.write_raw = adis16240_write_raw,
+	.update_scan_mode = adis_update_scan_mode,
+};
+
+static const char * const adis16240_status_error_msgs[] = {
+	[ADIS16240_DIAG_STAT_PWRON_FAIL_BIT] = "Power on, self-test failed",
+	[ADIS16240_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
+	[ADIS16240_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
+	[ADIS16240_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
+	[ADIS16240_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 2.225V",
+};
+
+static const struct adis_data adis16240_data = {
+	.write_delay = 35,
+	.read_delay = 35,
+	.msc_ctrl_reg = ADIS16240_MSC_CTRL,
+	.glob_cmd_reg = ADIS16240_GLOB_CMD,
+	.diag_stat_reg = ADIS16240_DIAG_STAT,
+
+	.self_test_mask = ADIS16240_MSC_CTRL_SELF_TEST_EN,
+	.self_test_no_autoclear = true,
+	.startup_delay = ADIS16240_STARTUP_DELAY,
+
+	.status_error_msgs = adis16240_status_error_msgs,
+	.status_error_mask = BIT(ADIS16240_DIAG_STAT_PWRON_FAIL_BIT) |
+		BIT(ADIS16240_DIAG_STAT_SPI_FAIL_BIT) |
+		BIT(ADIS16240_DIAG_STAT_FLASH_UPT_BIT) |
+		BIT(ADIS16240_DIAG_STAT_POWER_HIGH_BIT) |
+		BIT(ADIS16240_DIAG_STAT_POWER_LOW_BIT),
+};
+
+static int adis16240_probe(struct spi_device *spi)
+{
+	int ret;
+	struct adis *st;
+	struct iio_dev *indio_dev;
+
+	/* setup the industrialio driver allocated elements */
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+	st = iio_priv(indio_dev);
+	/* this is only used for removal purposes */
+	spi_set_drvdata(spi, indio_dev);
+
+	indio_dev->name = spi->dev.driver->name;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->info = &adis16240_info;
+	indio_dev->channels = adis16240_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adis16240_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = adis_init(st, indio_dev, spi, &adis16240_data);
+	if (ret)
+		return ret;
+	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
+	if (ret)
+		return ret;
+
+	/* Get the device into a sane initial state */
+	ret = adis_initial_startup(st);
+	if (ret)
+		goto error_cleanup_buffer_trigger;
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_cleanup_buffer_trigger;
+	return 0;
+
+error_cleanup_buffer_trigger:
+	adis_cleanup_buffer_and_trigger(st, indio_dev);
+	return ret;
+}
+
+static int adis16240_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct adis *st = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	adis_cleanup_buffer_and_trigger(st, indio_dev);
+
+	return 0;
+}
+
+static const struct of_device_id adis16240_of_match[] = {
+	{ .compatible = "adi,adis16240" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, adis16240_of_match);
+
+static struct spi_driver adis16240_driver = {
+	.driver = {
+		.name = "adis16240",
+		.of_match_table = adis16240_of_match,
+	},
+	.probe = adis16240_probe,
+	.remove = adis16240_remove,
+};
+module_spi_driver(adis16240_driver);
+
+MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
+MODULE_DESCRIPTION("Analog Devices Programmable Impact Sensor and Recorder");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("spi:adis16240");
diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig
index 3318997a7009..cee51f64bc4b 100644
--- a/drivers/staging/iio/accel/Kconfig
+++ b/drivers/staging/iio/accel/Kconfig
@@ -16,16 +16,4 @@ config ADIS16203
 	  To compile this driver as a module, say M here: the module will be
 	  called adis16203.
 
-config ADIS16240
-	tristate "Analog Devices ADIS16240 Programmable Impact Sensor and Recorder"
-	depends on SPI
-	select IIO_ADIS_LIB
-	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
-	help
-	  Say Y here to build support for Analog Devices adis16240 programmable
-	  impact Sensor and recorder.
-
-	  To compile this driver as a module, say M here: the module will be
-	  called adis16240.
-
 endmenu
diff --git a/drivers/staging/iio/accel/Makefile b/drivers/staging/iio/accel/Makefile
index 094cc9be35bd..acac7bc9b9c0 100644
--- a/drivers/staging/iio/accel/Makefile
+++ b/drivers/staging/iio/accel/Makefile
@@ -4,4 +4,3 @@
 #
 
 obj-$(CONFIG_ADIS16203) += adis16203.o
-obj-$(CONFIG_ADIS16240) += adis16240.o
diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
deleted file mode 100644
index 82099db4bf0c..000000000000
--- a/drivers/staging/iio/accel/adis16240.c
+++ /dev/null
@@ -1,454 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * ADIS16240 Programmable Impact Sensor and Recorder driver
- *
- * Copyright 2010 Analog Devices Inc.
- */
-
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/gpio.h>
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/spi/spi.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
-#include <linux/list.h>
-#include <linux/module.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
-#include <linux/iio/buffer.h>
-#include <linux/iio/imu/adis.h>
-
-#define ADIS16240_STARTUP_DELAY	220 /* ms */
-
-/* Flash memory write count */
-#define ADIS16240_FLASH_CNT      0x00
-
-/* Output, power supply */
-#define ADIS16240_SUPPLY_OUT     0x02
-
-/* Output, x-axis accelerometer */
-#define ADIS16240_XACCL_OUT      0x04
-
-/* Output, y-axis accelerometer */
-#define ADIS16240_YACCL_OUT      0x06
-
-/* Output, z-axis accelerometer */
-#define ADIS16240_ZACCL_OUT      0x08
-
-/* Output, auxiliary ADC input */
-#define ADIS16240_AUX_ADC        0x0A
-
-/* Output, temperature */
-#define ADIS16240_TEMP_OUT       0x0C
-
-/* Output, x-axis acceleration peak */
-#define ADIS16240_XPEAK_OUT      0x0E
-
-/* Output, y-axis acceleration peak */
-#define ADIS16240_YPEAK_OUT      0x10
-
-/* Output, z-axis acceleration peak */
-#define ADIS16240_ZPEAK_OUT      0x12
-
-/* Output, sum-of-squares acceleration peak */
-#define ADIS16240_XYZPEAK_OUT    0x14
-
-/* Output, Capture Buffer 1, X and Y acceleration */
-#define ADIS16240_CAPT_BUF1      0x16
-
-/* Output, Capture Buffer 2, Z acceleration */
-#define ADIS16240_CAPT_BUF2      0x18
-
-/* Diagnostic, error flags */
-#define ADIS16240_DIAG_STAT      0x1A
-
-/* Diagnostic, event counter */
-#define ADIS16240_EVNT_CNTR      0x1C
-
-/* Diagnostic, check sum value from firmware test */
-#define ADIS16240_CHK_SUM        0x1E
-
-/* Calibration, x-axis acceleration offset adjustment */
-#define ADIS16240_XACCL_OFF      0x20
-
-/* Calibration, y-axis acceleration offset adjustment */
-#define ADIS16240_YACCL_OFF      0x22
-
-/* Calibration, z-axis acceleration offset adjustment */
-#define ADIS16240_ZACCL_OFF      0x24
-
-/* Clock, hour and minute */
-#define ADIS16240_CLK_TIME       0x2E
-
-/* Clock, month and day */
-#define ADIS16240_CLK_DATE       0x30
-
-/* Clock, year */
-#define ADIS16240_CLK_YEAR       0x32
-
-/* Wake-up setting, hour and minute */
-#define ADIS16240_WAKE_TIME      0x34
-
-/* Wake-up setting, month and day */
-#define ADIS16240_WAKE_DATE      0x36
-
-/* Alarm 1 amplitude threshold */
-#define ADIS16240_ALM_MAG1       0x38
-
-/* Alarm 2 amplitude threshold */
-#define ADIS16240_ALM_MAG2       0x3A
-
-/* Alarm control */
-#define ADIS16240_ALM_CTRL       0x3C
-
-/* Capture, external trigger control */
-#define ADIS16240_XTRIG_CTRL     0x3E
-
-/* Capture, address pointer */
-#define ADIS16240_CAPT_PNTR      0x40
-
-/* Capture, configuration and control */
-#define ADIS16240_CAPT_CTRL      0x42
-
-/* General-purpose digital input/output control */
-#define ADIS16240_GPIO_CTRL      0x44
-
-/* Miscellaneous control */
-#define ADIS16240_MSC_CTRL       0x46
-
-/* Internal sample period (rate) control */
-#define ADIS16240_SMPL_PRD       0x48
-
-/* System command */
-#define ADIS16240_GLOB_CMD       0x4A
-
-/* MSC_CTRL */
-
-/* Enables sum-of-squares output (XYZPEAK_OUT) */
-#define ADIS16240_MSC_CTRL_XYZPEAK_OUT_EN	BIT(15)
-
-/* Enables peak tracking output (XPEAK_OUT, YPEAK_OUT, and ZPEAK_OUT) */
-#define ADIS16240_MSC_CTRL_X_Y_ZPEAK_OUT_EN	BIT(14)
-
-/* Self-test enable: 1 = apply electrostatic force, 0 = disabled */
-#define ADIS16240_MSC_CTRL_SELF_TEST_EN	        BIT(8)
-
-/* Data-ready enable: 1 = enabled, 0 = disabled */
-#define ADIS16240_MSC_CTRL_DATA_RDY_EN	        BIT(2)
-
-/* Data-ready polarity: 1 = active high, 0 = active low */
-#define ADIS16240_MSC_CTRL_ACTIVE_HIGH	        BIT(1)
-
-/* Data-ready line selection: 1 = DIO2, 0 = DIO1 */
-#define ADIS16240_MSC_CTRL_DATA_RDY_DIO2	BIT(0)
-
-/* DIAG_STAT */
-
-/* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
-#define ADIS16240_DIAG_STAT_ALARM2      BIT(9)
-
-/* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
-#define ADIS16240_DIAG_STAT_ALARM1      BIT(8)
-
-/* Capture buffer full: 1 = capture buffer is full */
-#define ADIS16240_DIAG_STAT_CPT_BUF_FUL BIT(7)
-
-/* Flash test, checksum flag: 1 = mismatch, 0 = match */
-#define ADIS16240_DIAG_STAT_CHKSUM      BIT(6)
-
-/* Power-on, self-test flag: 1 = failure, 0 = pass */
-#define ADIS16240_DIAG_STAT_PWRON_FAIL_BIT  5
-
-/* Power-on self-test: 1 = in-progress, 0 = complete */
-#define ADIS16240_DIAG_STAT_PWRON_BUSY  BIT(4)
-
-/* SPI communications failure */
-#define ADIS16240_DIAG_STAT_SPI_FAIL_BIT	3
-
-/* Flash update failure */
-#define ADIS16240_DIAG_STAT_FLASH_UPT_BIT	2
-
-/* Power supply above 3.625 V */
-#define ADIS16240_DIAG_STAT_POWER_HIGH_BIT	1
-
- /* Power supply below 2.225 V */
-#define ADIS16240_DIAG_STAT_POWER_LOW_BIT	0
-
-/* GLOB_CMD */
-
-#define ADIS16240_GLOB_CMD_RESUME	BIT(8)
-#define ADIS16240_GLOB_CMD_SW_RESET	BIT(7)
-#define ADIS16240_GLOB_CMD_STANDBY	BIT(2)
-
-#define ADIS16240_ERROR_ACTIVE          BIT(14)
-
-/* At the moment triggers are only used for ring buffer
- * filling. This may change!
- */
-
-enum adis16240_scan {
-	ADIS16240_SCAN_ACC_X,
-	ADIS16240_SCAN_ACC_Y,
-	ADIS16240_SCAN_ACC_Z,
-	ADIS16240_SCAN_SUPPLY,
-	ADIS16240_SCAN_AUX_ADC,
-	ADIS16240_SCAN_TEMP,
-};
-
-static ssize_t adis16240_spi_read_signed(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf,
-					 unsigned int bits)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct adis *st = iio_priv(indio_dev);
-	int ret;
-	s16 val = 0;
-	unsigned int shift = 16 - bits;
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-
-	ret = adis_read_reg_16(st,
-			       this_attr->address, (u16 *)&val);
-	if (ret)
-		return ret;
-
-	if (val & ADIS16240_ERROR_ACTIVE)
-		adis_check_status(st);
-
-	val = (s16)(val << shift) >> shift;
-	return sprintf(buf, "%d\n", val);
-}
-
-static ssize_t adis16240_read_12bit_signed(struct device *dev,
-					   struct device_attribute *attr,
-					   char *buf)
-{
-	return adis16240_spi_read_signed(dev, attr, buf, 12);
-}
-
-static IIO_DEVICE_ATTR(in_accel_xyz_squared_peak_raw, 0444,
-		       adis16240_read_12bit_signed, NULL,
-		       ADIS16240_XYZPEAK_OUT);
-
-static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("4096");
-
-static const u8 adis16240_addresses[][2] = {
-	[ADIS16240_SCAN_ACC_X] = { ADIS16240_XACCL_OFF, ADIS16240_XPEAK_OUT },
-	[ADIS16240_SCAN_ACC_Y] = { ADIS16240_YACCL_OFF, ADIS16240_YPEAK_OUT },
-	[ADIS16240_SCAN_ACC_Z] = { ADIS16240_ZACCL_OFF, ADIS16240_ZPEAK_OUT },
-};
-
-static int adis16240_read_raw(struct iio_dev *indio_dev,
-			      struct iio_chan_spec const *chan,
-			      int *val, int *val2,
-			      long mask)
-{
-	struct adis *st = iio_priv(indio_dev);
-	int ret;
-	u8 addr;
-	s16 val16;
-
-	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
-		return adis_single_conversion(indio_dev, chan,
-				ADIS16240_ERROR_ACTIVE, val);
-	case IIO_CHAN_INFO_SCALE:
-		switch (chan->type) {
-		case IIO_VOLTAGE:
-			if (chan->channel == 0) {
-				*val = 4;
-				*val2 = 880000; /* 4.88 mV */
-				return IIO_VAL_INT_PLUS_MICRO;
-			}
-			return -EINVAL;
-		case IIO_TEMP:
-			*val = 244; /* 0.244 C */
-			*val2 = 0;
-			return IIO_VAL_INT_PLUS_MICRO;
-		case IIO_ACCEL:
-			*val = 0;
-			*val2 = IIO_G_TO_M_S_2(51400); /* 51.4 mg */
-			return IIO_VAL_INT_PLUS_MICRO;
-		default:
-			return -EINVAL;
-		}
-		break;
-	case IIO_CHAN_INFO_PEAK_SCALE:
-		*val = 0;
-		*val2 = IIO_G_TO_M_S_2(51400); /* 51.4 mg */
-		return IIO_VAL_INT_PLUS_MICRO;
-	case IIO_CHAN_INFO_OFFSET:
-		*val = 25000 / 244 - 0x133; /* 25 C = 0x133 */
-		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_CALIBBIAS:
-		addr = adis16240_addresses[chan->scan_index][0];
-		ret = adis_read_reg_16(st, addr, &val16);
-		if (ret)
-			return ret;
-		*val = sign_extend32(val16, 9);
-		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_PEAK:
-		addr = adis16240_addresses[chan->scan_index][1];
-		ret = adis_read_reg_16(st, addr, &val16);
-		if (ret)
-			return ret;
-		*val = sign_extend32(val16, 9);
-		return IIO_VAL_INT;
-	}
-	return -EINVAL;
-}
-
-static int adis16240_write_raw(struct iio_dev *indio_dev,
-			       struct iio_chan_spec const *chan,
-			       int val,
-			       int val2,
-			       long mask)
-{
-	struct adis *st = iio_priv(indio_dev);
-	u8 addr;
-
-	switch (mask) {
-	case IIO_CHAN_INFO_CALIBBIAS:
-		addr = adis16240_addresses[chan->scan_index][0];
-		return adis_write_reg_16(st, addr, val & GENMASK(9, 0));
-	}
-	return -EINVAL;
-}
-
-static const struct iio_chan_spec adis16240_channels[] = {
-	ADIS_SUPPLY_CHAN(ADIS16240_SUPPLY_OUT, ADIS16240_SCAN_SUPPLY, 0, 10),
-	ADIS_AUX_ADC_CHAN(ADIS16240_AUX_ADC, ADIS16240_SCAN_AUX_ADC, 0, 10),
-	ADIS_ACCEL_CHAN(X, ADIS16240_XACCL_OUT, ADIS16240_SCAN_ACC_X,
-			BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_PEAK),
-			0, 10),
-	ADIS_ACCEL_CHAN(Y, ADIS16240_YACCL_OUT, ADIS16240_SCAN_ACC_Y,
-			BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_PEAK),
-			0, 10),
-	ADIS_ACCEL_CHAN(Z, ADIS16240_ZACCL_OUT, ADIS16240_SCAN_ACC_Z,
-			BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_PEAK),
-			0, 10),
-	ADIS_TEMP_CHAN(ADIS16240_TEMP_OUT, ADIS16240_SCAN_TEMP, 0, 10),
-	IIO_CHAN_SOFT_TIMESTAMP(6)
-};
-
-static struct attribute *adis16240_attributes[] = {
-	&iio_dev_attr_in_accel_xyz_squared_peak_raw.dev_attr.attr,
-	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
-	NULL
-};
-
-static const struct attribute_group adis16240_attribute_group = {
-	.attrs = adis16240_attributes,
-};
-
-static const struct iio_info adis16240_info = {
-	.attrs = &adis16240_attribute_group,
-	.read_raw = adis16240_read_raw,
-	.write_raw = adis16240_write_raw,
-	.update_scan_mode = adis_update_scan_mode,
-};
-
-static const char * const adis16240_status_error_msgs[] = {
-	[ADIS16240_DIAG_STAT_PWRON_FAIL_BIT] = "Power on, self-test failed",
-	[ADIS16240_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
-	[ADIS16240_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
-	[ADIS16240_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
-	[ADIS16240_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 2.225V",
-};
-
-static const struct adis_data adis16240_data = {
-	.write_delay = 35,
-	.read_delay = 35,
-	.msc_ctrl_reg = ADIS16240_MSC_CTRL,
-	.glob_cmd_reg = ADIS16240_GLOB_CMD,
-	.diag_stat_reg = ADIS16240_DIAG_STAT,
-
-	.self_test_mask = ADIS16240_MSC_CTRL_SELF_TEST_EN,
-	.self_test_no_autoclear = true,
-	.startup_delay = ADIS16240_STARTUP_DELAY,
-
-	.status_error_msgs = adis16240_status_error_msgs,
-	.status_error_mask = BIT(ADIS16240_DIAG_STAT_PWRON_FAIL_BIT) |
-		BIT(ADIS16240_DIAG_STAT_SPI_FAIL_BIT) |
-		BIT(ADIS16240_DIAG_STAT_FLASH_UPT_BIT) |
-		BIT(ADIS16240_DIAG_STAT_POWER_HIGH_BIT) |
-		BIT(ADIS16240_DIAG_STAT_POWER_LOW_BIT),
-};
-
-static int adis16240_probe(struct spi_device *spi)
-{
-	int ret;
-	struct adis *st;
-	struct iio_dev *indio_dev;
-
-	/* setup the industrialio driver allocated elements */
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
-	if (!indio_dev)
-		return -ENOMEM;
-	st = iio_priv(indio_dev);
-	/* this is only used for removal purposes */
-	spi_set_drvdata(spi, indio_dev);
-
-	indio_dev->name = spi->dev.driver->name;
-	indio_dev->dev.parent = &spi->dev;
-	indio_dev->info = &adis16240_info;
-	indio_dev->channels = adis16240_channels;
-	indio_dev->num_channels = ARRAY_SIZE(adis16240_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
-
-	ret = adis_init(st, indio_dev, spi, &adis16240_data);
-	if (ret)
-		return ret;
-	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
-	if (ret)
-		return ret;
-
-	/* Get the device into a sane initial state */
-	ret = adis_initial_startup(st);
-	if (ret)
-		goto error_cleanup_buffer_trigger;
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_cleanup_buffer_trigger;
-	return 0;
-
-error_cleanup_buffer_trigger:
-	adis_cleanup_buffer_and_trigger(st, indio_dev);
-	return ret;
-}
-
-static int adis16240_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct adis *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	adis_cleanup_buffer_and_trigger(st, indio_dev);
-
-	return 0;
-}
-
-static const struct of_device_id adis16240_of_match[] = {
-	{ .compatible = "adi,adis16240" },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, adis16240_of_match);
-
-static struct spi_driver adis16240_driver = {
-	.driver = {
-		.name = "adis16240",
-		.of_match_table = adis16240_of_match,
-	},
-	.probe = adis16240_probe,
-	.remove = adis16240_remove,
-};
-module_spi_driver(adis16240_driver);
-
-MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
-MODULE_DESCRIPTION("Analog Devices Programmable Impact Sensor and Recorder");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("spi:adis16240");
-- 
2.23.0.rc1

