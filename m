Return-Path: <linux-iio+bounces-15955-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42874A40977
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 16:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF1A4422861
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 15:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D201448E3;
	Sat, 22 Feb 2025 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNDoyvK6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F2178F46
	for <linux-iio@vger.kernel.org>; Sat, 22 Feb 2025 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740237630; cv=none; b=FOx8Tx5qWR3/BWsN4X8uJtHH6tblMYGtIFPXZcKDgpTBCB4OZK48C5J0I4EIJEr3VJ/JUbwB8x35d33nNo9d5ljD9JmnKXz0J+LVUGD5Gm2LpEe6OwX0X5RKgbuMZjfMxcNQGDfSE4OVGnsrlSncpQUn7l8GitYdRWYSAbREMAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740237630; c=relaxed/simple;
	bh=NSb8p50N40BJ9NEyBpzNZwVHqGuzgYs9AO9ALy0BpCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aan5WzA+6ZXebDSFNSUSOhD5zGy5+JlGVjUQeFil3rolzrK2PvoteHSFFminOpLZuDrIl/akHdtunN6Q5o4NYhRjJKajaD3qf9U4LEEpfjU2GddWKq2rnpaPw/YII//fOO7jdNUQeyi8Cwm+uzG1rPrcjSzCC3VaDe/ysV86Jlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNDoyvK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C834DC4CED1;
	Sat, 22 Feb 2025 15:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740237629;
	bh=NSb8p50N40BJ9NEyBpzNZwVHqGuzgYs9AO9ALy0BpCM=;
	h=From:To:Cc:Subject:Date:From;
	b=pNDoyvK6+qwteXXVZ0sa6wmxqjJNKqpbPdxEPijynBHQ3yWPlIf5jqztAs1+bQRjA
	 54WOolDRGm4V4PRAI4NXA36tiXMJP266fW5f6BLO1mrIAOqL8AU+NzNj6jQl8UwgWi
	 GCqoffN9eQbgqFPtSfWLKyb0vMzejDuaUWEqCYx1esVZ+Krxb94hTOEESKjvJnlKAg
	 u0VM686+SGT/icnRGRz6IbAFFBVJE+8faELEQfPb/sbHio0OrONd4n4G/OOF0fsU+W
	 vELjAyawg7U4YtcG3zrstxSPbI2oLy/f0aOrdeceeD14YgaLMOS9fnvpeRV1tRAd/b
	 xI7UQktHVc4WQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Nuno Sa <nuno.sa@analog.com>,
	Rodrigo Carvalho <rodrigorsdc@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] staging: iio: accel: adis16240: Drop driver for this impact sensor
Date: Sat, 22 Feb 2025 15:20:21 +0000
Message-ID: <20250222152021.1039675-1-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Whilst an interesting part, no one has done significant work on this
driver since 2019.  The recent changes are all as a result of adis library
improvements having to incorporate this device.

https://www.analog.com/en/products/adis16240.html now lists this part
as obsolete so the chances of anyone working on it are likely to be greatly
reduced.

So drop it.  We can always bring it back if anyone does have interest in
this device and is willing to invest the time to make it suitable for a
staging graduation.  How to handle the hardware triggered short bursts
of capture has never been resolved and is a somewhat challenging ABI design
problem.

Cc: Nuno Sa <nuno.sa@analog.com>
Cc: Rodrigo Carvalho <rodrigorsdc@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/accel/Kconfig     |  12 -
 drivers/staging/iio/accel/Makefile    |   1 -
 drivers/staging/iio/accel/adis16240.c | 443 --------------------------
 3 files changed, 456 deletions(-)

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
index 3be3eaf5d9d4..000000000000
--- a/drivers/staging/iio/accel/adis16240.c
+++ /dev/null
@@ -1,443 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * ADIS16240 Programmable Impact Sensor and Recorder driver
- *
- * Copyright 2010 Analog Devices Inc.
- */
-
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/spi/spi.h>
-#include <linux/sysfs.h>
-#include <linux/module.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
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
-static const struct adis_timeout adis16240_timeouts = {
-	.reset_ms = ADIS16240_STARTUP_DELAY,
-	.sw_reset_ms = ADIS16240_STARTUP_DELAY,
-	.self_test_ms = ADIS16240_STARTUP_DELAY,
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
-	.self_test_reg = ADIS16240_MSC_CTRL,
-	.self_test_no_autoclear = true,
-	.timeouts = &adis16240_timeouts,
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
-	indio_dev->info = &adis16240_info;
-	indio_dev->channels = adis16240_channels;
-	indio_dev->num_channels = ARRAY_SIZE(adis16240_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
-
-	spi->mode = SPI_MODE_3;
-	ret = spi_setup(spi);
-	if (ret) {
-		dev_err(&spi->dev, "spi_setup failed!\n");
-		return ret;
-	}
-
-	ret = adis_init(st, indio_dev, spi, &adis16240_data);
-	if (ret)
-		return ret;
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
-};
-module_spi_driver(adis16240_driver);
-
-MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
-MODULE_DESCRIPTION("Analog Devices Programmable Impact Sensor and Recorder");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("spi:adis16240");
-MODULE_IMPORT_NS("IIO_ADISLIB");
-- 
2.48.1


