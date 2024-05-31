Return-Path: <linux-iio+bounces-5549-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B27908D67C4
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 19:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14C22B23E5D
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 17:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B062C17CA1E;
	Fri, 31 May 2024 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cJ/1KjSp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B97117B4F2;
	Fri, 31 May 2024 17:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717175337; cv=none; b=rCu2KP+iiDFT+QcF7k5qd5p3pwALtKv5hckB/qHmTocVaxin26VtCr+MXP6UfI5xyVaDlW3VlVDdWAFsEBMPuDNUA8d3Op7dCHMBsPya2d+SyQH2PolH0H467OlTJiShvDCoiutERDnCiaLDbuSu3usdpbtkMZGvtAdY6q4e55o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717175337; c=relaxed/simple;
	bh=FS60TBEE/wruQULKObXrlgrM94WKm93IKkchS2QxQho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IkBz1+lC1DS+Av5rdk9SZ+Y2O7/ws4XupAGXc3X16MQ4P6dvIUxE80iEccGMsvKijncWQbtkCEO43nyNLHFtWaIH+J4FF1py8Q40xlof3yuZyQebQYDGzG5Ohu5K/Sr7tO6UJtnDSFeIFYl359BmrYLda02+sH0EVXuhbFqZ3IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cJ/1KjSp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717175335; x=1748711335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FS60TBEE/wruQULKObXrlgrM94WKm93IKkchS2QxQho=;
  b=cJ/1KjSpd3vTpvQ3WNBfgbYioADTwIUgH7/4Ad2H6WcmQTjq6GlSehvb
   ZWNHUJfAIimBEfXXsw4Wd8scekQ8aZqRZXr+n31c76SJCtb0ApNNSFOSy
   mlRmZviCM9eEu3iXIaeF7sVG+5Lny6DpfpkDthP4InIIPbEi/n/d0SxnW
   1F4tQ2qEmkdKXwKRE5AxesAd8/1hm+/eB68SsP/wj19Lin3K71YHBXwci
   CHbKawzMSR+r6QbJ1bTZTSwAhHXRb/WBs7LQvaQbVThTX+JpHSNVP+EFp
   cSNsJKpS6/k3OiSYQKre2K9cwqgnvtZSs/mfYH0h9FAviod6aph26ccQR
   w==;
X-CSE-ConnectionGUID: QGs//N1/SgSrIRNKpCIvIw==
X-CSE-MsgGUID: rpKBukffS3q0JJpwk5/Uww==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="25131916"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="25131916"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 10:08:52 -0700
X-CSE-ConnectionGUID: cvEFmdX4So6HAMsOyfD9HA==
X-CSE-MsgGUID: 0Ps6g+LnRyuqFBdTbcOLLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="36147844"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 31 May 2024 10:08:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8FB0641D; Fri, 31 May 2024 20:08:46 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Pavel Machek <pavel@ucw.cz>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Johan Hovold <jhovold@gmail.com>
Subject: [PATCH v1 2/4] iio: light: lm3533-als: Remove the driver
Date: Fri, 31 May 2024 19:56:14 +0300
Message-ID: <20240531170844.1595468-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240531170844.1595468-1-andriy.shevchenko@linux.intel.com>
References: <20240531170844.1595468-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver has no in kernel users and requires a board file
to be instantiated. Remove basically a dead code.

If ever needed, it can be reinstantiated and converted to one
that uses firmware node interfaces.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/light/Kconfig      |  17 -
 drivers/iio/light/Makefile     |   1 -
 drivers/iio/light/lm3533-als.c | 922 ---------------------------------
 3 files changed, 940 deletions(-)
 delete mode 100644 drivers/iio/light/lm3533-als.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 9a587d403118..827eee527a62 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -358,23 +358,6 @@ config RPR0521
 	  To compile this driver as a module, choose M here:
 	  the module will be called rpr0521.
 
-config SENSORS_LM3533
-	tristate "LM3533 ambient light sensor"
-	depends on MFD_LM3533
-	help
-	  If you say yes here you get support for the ambient light sensor
-	  interface on National Semiconductor / TI LM3533 Lighting Power
-	  chips.
-
-	  The sensor interface can be used to control the LEDs and backlights
-	  of the chip through defining five light zones and three sets of
-	  corresponding output-current values.
-
-	  The driver provides raw and mean adc readings along with the current
-	  light zone through sysfs. A threshold event can be generated on zone
-	  changes. The ALS-control output values can be set per zone for the
-	  three current output channels.
-
 config LTR390
 	tristate "LTR-390UV-01 ambient light and UV sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index a30f906e91ba..6fd7b6f95d1d 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -31,7 +31,6 @@ obj-$(CONFIG_SENSORS_ISL29028)	+= isl29028.o
 obj-$(CONFIG_ISL29125)		+= isl29125.o
 obj-$(CONFIG_ISL76682)		+= isl76682.o
 obj-$(CONFIG_JSA1212)		+= jsa1212.o
-obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
 obj-$(CONFIG_LTR390)		+= ltr390.o
 obj-$(CONFIG_LTR501)		+= ltr501.o
 obj-$(CONFIG_LTRF216A)		+= ltrf216a.o
diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
deleted file mode 100644
index 7800f7fa51b7..000000000000
--- a/drivers/iio/light/lm3533-als.c
+++ /dev/null
@@ -1,922 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * lm3533-als.c -- LM3533 Ambient Light Sensor driver
- *
- * Copyright (C) 2011-2012 Texas Instruments
- *
- * Author: Johan Hovold <jhovold@gmail.com>
- */
-
-#include <linux/atomic.h>
-#include <linux/fs.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/iio/events.h>
-#include <linux/iio/iio.h>
-#include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/mfd/core.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/uaccess.h>
-
-#include <linux/mfd/lm3533.h>
-
-
-#define LM3533_ALS_RESISTOR_MIN			1
-#define LM3533_ALS_RESISTOR_MAX			127
-#define LM3533_ALS_CHANNEL_CURRENT_MAX		2
-#define LM3533_ALS_THRESH_MAX			3
-#define LM3533_ALS_ZONE_MAX			4
-
-#define LM3533_REG_ALS_RESISTOR_SELECT		0x30
-#define LM3533_REG_ALS_CONF			0x31
-#define LM3533_REG_ALS_ZONE_INFO		0x34
-#define LM3533_REG_ALS_READ_ADC_RAW		0x37
-#define LM3533_REG_ALS_READ_ADC_AVERAGE		0x38
-#define LM3533_REG_ALS_BOUNDARY_BASE		0x50
-#define LM3533_REG_ALS_TARGET_BASE		0x60
-
-#define LM3533_ALS_ENABLE_MASK			0x01
-#define LM3533_ALS_INPUT_MODE_MASK		0x02
-#define LM3533_ALS_INT_ENABLE_MASK		0x01
-
-#define LM3533_ALS_ZONE_SHIFT			2
-#define LM3533_ALS_ZONE_MASK			0x1c
-
-#define LM3533_ALS_FLAG_INT_ENABLED		1
-
-
-struct lm3533_als {
-	struct lm3533 *lm3533;
-	struct platform_device *pdev;
-
-	unsigned long flags;
-	int irq;
-
-	atomic_t zone;
-	struct mutex thresh_mutex;
-};
-
-
-static int lm3533_als_get_adc(struct iio_dev *indio_dev, bool average,
-								int *adc)
-{
-	struct lm3533_als *als = iio_priv(indio_dev);
-	u8 reg;
-	u8 val;
-	int ret;
-
-	if (average)
-		reg = LM3533_REG_ALS_READ_ADC_AVERAGE;
-	else
-		reg = LM3533_REG_ALS_READ_ADC_RAW;
-
-	ret = lm3533_read(als->lm3533, reg, &val);
-	if (ret) {
-		dev_err(&indio_dev->dev, "failed to read adc\n");
-		return ret;
-	}
-
-	*adc = val;
-
-	return 0;
-}
-
-static int _lm3533_als_get_zone(struct iio_dev *indio_dev, u8 *zone)
-{
-	struct lm3533_als *als = iio_priv(indio_dev);
-	u8 val;
-	int ret;
-
-	ret = lm3533_read(als->lm3533, LM3533_REG_ALS_ZONE_INFO, &val);
-	if (ret) {
-		dev_err(&indio_dev->dev, "failed to read zone\n");
-		return ret;
-	}
-
-	val = (val & LM3533_ALS_ZONE_MASK) >> LM3533_ALS_ZONE_SHIFT;
-	*zone = min_t(u8, val, LM3533_ALS_ZONE_MAX);
-
-	return 0;
-}
-
-static int lm3533_als_get_zone(struct iio_dev *indio_dev, u8 *zone)
-{
-	struct lm3533_als *als = iio_priv(indio_dev);
-	int ret;
-
-	if (test_bit(LM3533_ALS_FLAG_INT_ENABLED, &als->flags)) {
-		*zone = atomic_read(&als->zone);
-	} else {
-		ret = _lm3533_als_get_zone(indio_dev, zone);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-/*
- * channel	output channel 0..2
- * zone		zone 0..4
- */
-static inline u8 lm3533_als_get_target_reg(unsigned channel, unsigned zone)
-{
-	return LM3533_REG_ALS_TARGET_BASE + 5 * channel + zone;
-}
-
-static int lm3533_als_get_target(struct iio_dev *indio_dev, unsigned channel,
-							unsigned zone, u8 *val)
-{
-	struct lm3533_als *als = iio_priv(indio_dev);
-	u8 reg;
-	int ret;
-
-	if (channel > LM3533_ALS_CHANNEL_CURRENT_MAX)
-		return -EINVAL;
-
-	if (zone > LM3533_ALS_ZONE_MAX)
-		return -EINVAL;
-
-	reg = lm3533_als_get_target_reg(channel, zone);
-	ret = lm3533_read(als->lm3533, reg, val);
-	if (ret)
-		dev_err(&indio_dev->dev, "failed to get target current\n");
-
-	return ret;
-}
-
-static int lm3533_als_set_target(struct iio_dev *indio_dev, unsigned channel,
-							unsigned zone, u8 val)
-{
-	struct lm3533_als *als = iio_priv(indio_dev);
-	u8 reg;
-	int ret;
-
-	if (channel > LM3533_ALS_CHANNEL_CURRENT_MAX)
-		return -EINVAL;
-
-	if (zone > LM3533_ALS_ZONE_MAX)
-		return -EINVAL;
-
-	reg = lm3533_als_get_target_reg(channel, zone);
-	ret = lm3533_write(als->lm3533, reg, val);
-	if (ret)
-		dev_err(&indio_dev->dev, "failed to set target current\n");
-
-	return ret;
-}
-
-static int lm3533_als_get_current(struct iio_dev *indio_dev, unsigned channel,
-								int *val)
-{
-	u8 zone;
-	u8 target;
-	int ret;
-
-	ret = lm3533_als_get_zone(indio_dev, &zone);
-	if (ret)
-		return ret;
-
-	ret = lm3533_als_get_target(indio_dev, channel, zone, &target);
-	if (ret)
-		return ret;
-
-	*val = target;
-
-	return 0;
-}
-
-static int lm3533_als_read_raw(struct iio_dev *indio_dev,
-				struct iio_chan_spec const *chan,
-				int *val, int *val2, long mask)
-{
-	int ret;
-
-	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
-		switch (chan->type) {
-		case IIO_LIGHT:
-			ret = lm3533_als_get_adc(indio_dev, false, val);
-			break;
-		case IIO_CURRENT:
-			ret = lm3533_als_get_current(indio_dev, chan->channel,
-									val);
-			break;
-		default:
-			return -EINVAL;
-		}
-		break;
-	case IIO_CHAN_INFO_AVERAGE_RAW:
-		ret = lm3533_als_get_adc(indio_dev, true, val);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	if (ret)
-		return ret;
-
-	return IIO_VAL_INT;
-}
-
-#define CHANNEL_CURRENT(_channel)					\
-	{								\
-		.type		= IIO_CURRENT,				\
-		.channel	= _channel,				\
-		.indexed	= true,					\
-		.output		= true,					\
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
-	}
-
-static const struct iio_chan_spec lm3533_als_channels[] = {
-	{
-		.type		= IIO_LIGHT,
-		.channel	= 0,
-		.indexed	= true,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_AVERAGE_RAW) |
-				   BIT(IIO_CHAN_INFO_RAW),
-	},
-	CHANNEL_CURRENT(0),
-	CHANNEL_CURRENT(1),
-	CHANNEL_CURRENT(2),
-};
-
-static irqreturn_t lm3533_als_isr(int irq, void *dev_id)
-{
-
-	struct iio_dev *indio_dev = dev_id;
-	struct lm3533_als *als = iio_priv(indio_dev);
-	u8 zone;
-	int ret;
-
-	/* Clear interrupt by reading the ALS zone register. */
-	ret = _lm3533_als_get_zone(indio_dev, &zone);
-	if (ret)
-		goto out;
-
-	atomic_set(&als->zone, zone);
-
-	iio_push_event(indio_dev,
-		       IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
-					    0,
-					    IIO_EV_TYPE_THRESH,
-					    IIO_EV_DIR_EITHER),
-		       iio_get_time_ns(indio_dev));
-out:
-	return IRQ_HANDLED;
-}
-
-static int lm3533_als_set_int_mode(struct iio_dev *indio_dev, int enable)
-{
-	struct lm3533_als *als = iio_priv(indio_dev);
-	u8 mask = LM3533_ALS_INT_ENABLE_MASK;
-	u8 val;
-	int ret;
-
-	if (enable)
-		val = mask;
-	else
-		val = 0;
-
-	ret = lm3533_update(als->lm3533, LM3533_REG_ALS_ZONE_INFO, val, mask);
-	if (ret) {
-		dev_err(&indio_dev->dev, "failed to set int mode %d\n",
-								enable);
-		return ret;
-	}
-
-	return 0;
-}
-
-static int lm3533_als_get_int_mode(struct iio_dev *indio_dev, int *enable)
-{
-	struct lm3533_als *als = iio_priv(indio_dev);
-	u8 mask = LM3533_ALS_INT_ENABLE_MASK;
-	u8 val;
-	int ret;
-
-	ret = lm3533_read(als->lm3533, LM3533_REG_ALS_ZONE_INFO, &val);
-	if (ret) {
-		dev_err(&indio_dev->dev, "failed to get int mode\n");
-		return ret;
-	}
-
-	*enable = !!(val & mask);
-
-	return 0;
-}
-
-static inline u8 lm3533_als_get_threshold_reg(unsigned nr, bool raising)
-{
-	u8 offset = !raising;
-
-	return LM3533_REG_ALS_BOUNDARY_BASE + 2 * nr + offset;
-}
-
-static int lm3533_als_get_threshold(struct iio_dev *indio_dev, unsigned nr,
-							bool raising, u8 *val)
-{
-	struct lm3533_als *als = iio_priv(indio_dev);
-	u8 reg;
-	int ret;
-
-	if (nr > LM3533_ALS_THRESH_MAX)
-		return -EINVAL;
-
-	reg = lm3533_als_get_threshold_reg(nr, raising);
-	ret = lm3533_read(als->lm3533, reg, val);
-	if (ret)
-		dev_err(&indio_dev->dev, "failed to get threshold\n");
-
-	return ret;
-}
-
-static int lm3533_als_set_threshold(struct iio_dev *indio_dev, unsigned nr,
-							bool raising, u8 val)
-{
-	struct lm3533_als *als = iio_priv(indio_dev);
-	u8 val2;
-	u8 reg, reg2;
-	int ret;
-
-	if (nr > LM3533_ALS_THRESH_MAX)
-		return -EINVAL;
-
-	reg = lm3533_als_get_threshold_reg(nr, raising);
-	reg2 = lm3533_als_get_threshold_reg(nr, !raising);
-
-	mutex_lock(&als->thresh_mutex);
-	ret = lm3533_read(als->lm3533, reg2, &val2);
-	if (ret) {
-		dev_err(&indio_dev->dev, "failed to get threshold\n");
-		goto out;
-	}
-	/*
-	 * This device does not allow negative hysteresis (in fact, it uses
-	 * whichever value is smaller as the lower bound) so we need to make
-	 * sure that thresh_falling <= thresh_raising.
-	 */
-	if ((raising && (val < val2)) || (!raising && (val > val2))) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	ret = lm3533_write(als->lm3533, reg, val);
-	if (ret) {
-		dev_err(&indio_dev->dev, "failed to set threshold\n");
-		goto out;
-	}
-out:
-	mutex_unlock(&als->thresh_mutex);
-
-	return ret;
-}
-
-static int lm3533_als_get_hysteresis(struct iio_dev *indio_dev, unsigned nr,
-								u8 *val)
-{
-	struct lm3533_als *als = iio_priv(indio_dev);
-	u8 falling;
-	u8 raising;
-	int ret;
-
-	if (nr > LM3533_ALS_THRESH_MAX)
-		return -EINVAL;
-
-	mutex_lock(&als->thresh_mutex);
-	ret = lm3533_als_get_threshold(indio_dev, nr, false, &falling);
-	if (ret)
-		goto out;
-	ret = lm3533_als_get_threshold(indio_dev, nr, true, &raising);
-	if (ret)
-		goto out;
-
-	*val = raising - falling;
-out:
-	mutex_unlock(&als->thresh_mutex);
-
-	return ret;
-}
-
-static ssize_t show_thresh_either_en(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct lm3533_als *als = iio_priv(indio_dev);
-	int enable;
-	int ret;
-
-	if (als->irq) {
-		ret = lm3533_als_get_int_mode(indio_dev, &enable);
-		if (ret)
-			return ret;
-	} else {
-		enable = 0;
-	}
-
-	return sysfs_emit(buf, "%u\n", enable);
-}
-
-static ssize_t store_thresh_either_en(struct device *dev,
-					struct device_attribute *attr,
-					const char *buf, size_t len)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct lm3533_als *als = iio_priv(indio_dev);
-	unsigned long enable;
-	bool int_enabled;
-	u8 zone;
-	int ret;
-
-	if (!als->irq)
-		return -EBUSY;
-
-	if (kstrtoul(buf, 0, &enable))
-		return -EINVAL;
-
-	int_enabled = test_bit(LM3533_ALS_FLAG_INT_ENABLED, &als->flags);
-
-	if (enable && !int_enabled) {
-		ret = lm3533_als_get_zone(indio_dev, &zone);
-		if (ret)
-			return ret;
-
-		atomic_set(&als->zone, zone);
-
-		set_bit(LM3533_ALS_FLAG_INT_ENABLED, &als->flags);
-	}
-
-	ret = lm3533_als_set_int_mode(indio_dev, enable);
-	if (ret) {
-		if (!int_enabled)
-			clear_bit(LM3533_ALS_FLAG_INT_ENABLED, &als->flags);
-
-		return ret;
-	}
-
-	if (!enable)
-		clear_bit(LM3533_ALS_FLAG_INT_ENABLED, &als->flags);
-
-	return len;
-}
-
-static ssize_t show_zone(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	u8 zone;
-	int ret;
-
-	ret = lm3533_als_get_zone(indio_dev, &zone);
-	if (ret)
-		return ret;
-
-	return sysfs_emit(buf, "%u\n", zone);
-}
-
-enum lm3533_als_attribute_type {
-	LM3533_ATTR_TYPE_HYSTERESIS,
-	LM3533_ATTR_TYPE_TARGET,
-	LM3533_ATTR_TYPE_THRESH_FALLING,
-	LM3533_ATTR_TYPE_THRESH_RAISING,
-};
-
-struct lm3533_als_attribute {
-	struct device_attribute dev_attr;
-	enum lm3533_als_attribute_type type;
-	u8 val1;
-	u8 val2;
-};
-
-static inline struct lm3533_als_attribute *
-to_lm3533_als_attr(struct device_attribute *attr)
-{
-	return container_of(attr, struct lm3533_als_attribute, dev_attr);
-}
-
-static ssize_t show_als_attr(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct lm3533_als_attribute *als_attr = to_lm3533_als_attr(attr);
-	u8 val;
-	int ret;
-
-	switch (als_attr->type) {
-	case LM3533_ATTR_TYPE_HYSTERESIS:
-		ret = lm3533_als_get_hysteresis(indio_dev, als_attr->val1,
-									&val);
-		break;
-	case LM3533_ATTR_TYPE_TARGET:
-		ret = lm3533_als_get_target(indio_dev, als_attr->val1,
-							als_attr->val2, &val);
-		break;
-	case LM3533_ATTR_TYPE_THRESH_FALLING:
-		ret = lm3533_als_get_threshold(indio_dev, als_attr->val1,
-								false, &val);
-		break;
-	case LM3533_ATTR_TYPE_THRESH_RAISING:
-		ret = lm3533_als_get_threshold(indio_dev, als_attr->val1,
-								true, &val);
-		break;
-	default:
-		ret = -ENXIO;
-	}
-
-	if (ret)
-		return ret;
-
-	return sysfs_emit(buf, "%u\n", val);
-}
-
-static ssize_t store_als_attr(struct device *dev,
-					struct device_attribute *attr,
-					const char *buf, size_t len)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct lm3533_als_attribute *als_attr = to_lm3533_als_attr(attr);
-	u8 val;
-	int ret;
-
-	if (kstrtou8(buf, 0, &val))
-		return -EINVAL;
-
-	switch (als_attr->type) {
-	case LM3533_ATTR_TYPE_TARGET:
-		ret = lm3533_als_set_target(indio_dev, als_attr->val1,
-							als_attr->val2, val);
-		break;
-	case LM3533_ATTR_TYPE_THRESH_FALLING:
-		ret = lm3533_als_set_threshold(indio_dev, als_attr->val1,
-								false, val);
-		break;
-	case LM3533_ATTR_TYPE_THRESH_RAISING:
-		ret = lm3533_als_set_threshold(indio_dev, als_attr->val1,
-								true, val);
-		break;
-	default:
-		ret = -ENXIO;
-	}
-
-	if (ret)
-		return ret;
-
-	return len;
-}
-
-#define ALS_ATTR(_name, _mode, _show, _store, _type, _val1, _val2)	\
-	{ .dev_attr	= __ATTR(_name, _mode, _show, _store),		\
-	  .type		= _type,					\
-	  .val1		= _val1,					\
-	  .val2		= _val2 }
-
-#define LM3533_ALS_ATTR(_name, _mode, _show, _store, _type, _val1, _val2) \
-	struct lm3533_als_attribute lm3533_als_attr_##_name =		  \
-		ALS_ATTR(_name, _mode, _show, _store, _type, _val1, _val2)
-
-#define ALS_TARGET_ATTR_RW(_channel, _zone)				\
-	LM3533_ALS_ATTR(out_current##_channel##_current##_zone##_raw,	\
-				S_IRUGO | S_IWUSR,			\
-				show_als_attr, store_als_attr,		\
-				LM3533_ATTR_TYPE_TARGET, _channel, _zone)
-/*
- * ALS output current values (ALS mapper targets)
- *
- * out_current[0-2]_current[0-4]_raw		0-255
- */
-static ALS_TARGET_ATTR_RW(0, 0);
-static ALS_TARGET_ATTR_RW(0, 1);
-static ALS_TARGET_ATTR_RW(0, 2);
-static ALS_TARGET_ATTR_RW(0, 3);
-static ALS_TARGET_ATTR_RW(0, 4);
-
-static ALS_TARGET_ATTR_RW(1, 0);
-static ALS_TARGET_ATTR_RW(1, 1);
-static ALS_TARGET_ATTR_RW(1, 2);
-static ALS_TARGET_ATTR_RW(1, 3);
-static ALS_TARGET_ATTR_RW(1, 4);
-
-static ALS_TARGET_ATTR_RW(2, 0);
-static ALS_TARGET_ATTR_RW(2, 1);
-static ALS_TARGET_ATTR_RW(2, 2);
-static ALS_TARGET_ATTR_RW(2, 3);
-static ALS_TARGET_ATTR_RW(2, 4);
-
-#define ALS_THRESH_FALLING_ATTR_RW(_nr)					\
-	LM3533_ALS_ATTR(in_illuminance0_thresh##_nr##_falling_value,	\
-			S_IRUGO | S_IWUSR,				\
-			show_als_attr, store_als_attr,		\
-			LM3533_ATTR_TYPE_THRESH_FALLING, _nr, 0)
-
-#define ALS_THRESH_RAISING_ATTR_RW(_nr)					\
-	LM3533_ALS_ATTR(in_illuminance0_thresh##_nr##_raising_value,	\
-			S_IRUGO | S_IWUSR,				\
-			show_als_attr, store_als_attr,			\
-			LM3533_ATTR_TYPE_THRESH_RAISING, _nr, 0)
-/*
- * ALS Zone thresholds (boundaries)
- *
- * in_illuminance0_thresh[0-3]_falling_value	0-255
- * in_illuminance0_thresh[0-3]_raising_value	0-255
- */
-static ALS_THRESH_FALLING_ATTR_RW(0);
-static ALS_THRESH_FALLING_ATTR_RW(1);
-static ALS_THRESH_FALLING_ATTR_RW(2);
-static ALS_THRESH_FALLING_ATTR_RW(3);
-
-static ALS_THRESH_RAISING_ATTR_RW(0);
-static ALS_THRESH_RAISING_ATTR_RW(1);
-static ALS_THRESH_RAISING_ATTR_RW(2);
-static ALS_THRESH_RAISING_ATTR_RW(3);
-
-#define ALS_HYSTERESIS_ATTR_RO(_nr)					\
-	LM3533_ALS_ATTR(in_illuminance0_thresh##_nr##_hysteresis,	\
-			S_IRUGO, show_als_attr, NULL,			\
-			LM3533_ATTR_TYPE_HYSTERESIS, _nr, 0)
-/*
- * ALS Zone threshold hysteresis
- *
- * threshY_hysteresis = threshY_raising - threshY_falling
- *
- * in_illuminance0_thresh[0-3]_hysteresis	0-255
- * in_illuminance0_thresh[0-3]_hysteresis	0-255
- */
-static ALS_HYSTERESIS_ATTR_RO(0);
-static ALS_HYSTERESIS_ATTR_RO(1);
-static ALS_HYSTERESIS_ATTR_RO(2);
-static ALS_HYSTERESIS_ATTR_RO(3);
-
-#define ILLUMINANCE_ATTR_RO(_name) \
-	DEVICE_ATTR(in_illuminance0_##_name, S_IRUGO, show_##_name, NULL)
-#define ILLUMINANCE_ATTR_RW(_name) \
-	DEVICE_ATTR(in_illuminance0_##_name, S_IRUGO | S_IWUSR, \
-						show_##_name, store_##_name)
-/*
- * ALS Zone threshold-event enable
- *
- * in_illuminance0_thresh_either_en		0,1
- */
-static ILLUMINANCE_ATTR_RW(thresh_either_en);
-
-/*
- * ALS Current Zone
- *
- * in_illuminance0_zone		0-4
- */
-static ILLUMINANCE_ATTR_RO(zone);
-
-static struct attribute *lm3533_als_event_attributes[] = {
-	&dev_attr_in_illuminance0_thresh_either_en.attr,
-	&lm3533_als_attr_in_illuminance0_thresh0_falling_value.dev_attr.attr,
-	&lm3533_als_attr_in_illuminance0_thresh0_hysteresis.dev_attr.attr,
-	&lm3533_als_attr_in_illuminance0_thresh0_raising_value.dev_attr.attr,
-	&lm3533_als_attr_in_illuminance0_thresh1_falling_value.dev_attr.attr,
-	&lm3533_als_attr_in_illuminance0_thresh1_hysteresis.dev_attr.attr,
-	&lm3533_als_attr_in_illuminance0_thresh1_raising_value.dev_attr.attr,
-	&lm3533_als_attr_in_illuminance0_thresh2_falling_value.dev_attr.attr,
-	&lm3533_als_attr_in_illuminance0_thresh2_hysteresis.dev_attr.attr,
-	&lm3533_als_attr_in_illuminance0_thresh2_raising_value.dev_attr.attr,
-	&lm3533_als_attr_in_illuminance0_thresh3_falling_value.dev_attr.attr,
-	&lm3533_als_attr_in_illuminance0_thresh3_hysteresis.dev_attr.attr,
-	&lm3533_als_attr_in_illuminance0_thresh3_raising_value.dev_attr.attr,
-	NULL
-};
-
-static const struct attribute_group lm3533_als_event_attribute_group = {
-	.attrs = lm3533_als_event_attributes
-};
-
-static struct attribute *lm3533_als_attributes[] = {
-	&dev_attr_in_illuminance0_zone.attr,
-	&lm3533_als_attr_out_current0_current0_raw.dev_attr.attr,
-	&lm3533_als_attr_out_current0_current1_raw.dev_attr.attr,
-	&lm3533_als_attr_out_current0_current2_raw.dev_attr.attr,
-	&lm3533_als_attr_out_current0_current3_raw.dev_attr.attr,
-	&lm3533_als_attr_out_current0_current4_raw.dev_attr.attr,
-	&lm3533_als_attr_out_current1_current0_raw.dev_attr.attr,
-	&lm3533_als_attr_out_current1_current1_raw.dev_attr.attr,
-	&lm3533_als_attr_out_current1_current2_raw.dev_attr.attr,
-	&lm3533_als_attr_out_current1_current3_raw.dev_attr.attr,
-	&lm3533_als_attr_out_current1_current4_raw.dev_attr.attr,
-	&lm3533_als_attr_out_current2_current0_raw.dev_attr.attr,
-	&lm3533_als_attr_out_current2_current1_raw.dev_attr.attr,
-	&lm3533_als_attr_out_current2_current2_raw.dev_attr.attr,
-	&lm3533_als_attr_out_current2_current3_raw.dev_attr.attr,
-	&lm3533_als_attr_out_current2_current4_raw.dev_attr.attr,
-	NULL
-};
-
-static const struct attribute_group lm3533_als_attribute_group = {
-	.attrs = lm3533_als_attributes
-};
-
-static int lm3533_als_set_input_mode(struct lm3533_als *als, bool pwm_mode)
-{
-	u8 mask = LM3533_ALS_INPUT_MODE_MASK;
-	u8 val;
-	int ret;
-
-	if (pwm_mode)
-		val = mask;	/* pwm input */
-	else
-		val = 0;	/* analog input */
-
-	ret = lm3533_update(als->lm3533, LM3533_REG_ALS_CONF, val, mask);
-	if (ret) {
-		dev_err(&als->pdev->dev, "failed to set input mode %d\n",
-								pwm_mode);
-		return ret;
-	}
-
-	return 0;
-}
-
-static int lm3533_als_set_resistor(struct lm3533_als *als, u8 val)
-{
-	int ret;
-
-	if (val < LM3533_ALS_RESISTOR_MIN || val > LM3533_ALS_RESISTOR_MAX) {
-		dev_err(&als->pdev->dev, "invalid resistor value\n");
-		return -EINVAL;
-	}
-
-	ret = lm3533_write(als->lm3533, LM3533_REG_ALS_RESISTOR_SELECT, val);
-	if (ret) {
-		dev_err(&als->pdev->dev, "failed to set resistor\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static int lm3533_als_setup(struct lm3533_als *als,
-			    struct lm3533_als_platform_data *pdata)
-{
-	int ret;
-
-	ret = lm3533_als_set_input_mode(als, pdata->pwm_mode);
-	if (ret)
-		return ret;
-
-	/* ALS input is always high impedance in PWM-mode. */
-	if (!pdata->pwm_mode) {
-		ret = lm3533_als_set_resistor(als, pdata->r_select);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-static int lm3533_als_setup_irq(struct lm3533_als *als, void *dev)
-{
-	u8 mask = LM3533_ALS_INT_ENABLE_MASK;
-	int ret;
-
-	/* Make sure interrupts are disabled. */
-	ret = lm3533_update(als->lm3533, LM3533_REG_ALS_ZONE_INFO, 0, mask);
-	if (ret) {
-		dev_err(&als->pdev->dev, "failed to disable interrupts\n");
-		return ret;
-	}
-
-	ret = request_threaded_irq(als->irq, NULL, lm3533_als_isr,
-					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-					dev_name(&als->pdev->dev), dev);
-	if (ret) {
-		dev_err(&als->pdev->dev, "failed to request irq %d\n",
-								als->irq);
-		return ret;
-	}
-
-	return 0;
-}
-
-static int lm3533_als_enable(struct lm3533_als *als)
-{
-	u8 mask = LM3533_ALS_ENABLE_MASK;
-	int ret;
-
-	ret = lm3533_update(als->lm3533, LM3533_REG_ALS_CONF, mask, mask);
-	if (ret)
-		dev_err(&als->pdev->dev, "failed to enable ALS\n");
-
-	return ret;
-}
-
-static int lm3533_als_disable(struct lm3533_als *als)
-{
-	u8 mask = LM3533_ALS_ENABLE_MASK;
-	int ret;
-
-	ret = lm3533_update(als->lm3533, LM3533_REG_ALS_CONF, 0, mask);
-	if (ret)
-		dev_err(&als->pdev->dev, "failed to disable ALS\n");
-
-	return ret;
-}
-
-static const struct iio_info lm3533_als_info = {
-	.attrs		= &lm3533_als_attribute_group,
-	.event_attrs	= &lm3533_als_event_attribute_group,
-	.read_raw	= &lm3533_als_read_raw,
-};
-
-static int lm3533_als_probe(struct platform_device *pdev)
-{
-	struct lm3533 *lm3533;
-	struct lm3533_als_platform_data *pdata;
-	struct lm3533_als *als;
-	struct iio_dev *indio_dev;
-	int ret;
-
-	lm3533 = dev_get_drvdata(pdev->dev.parent);
-	if (!lm3533)
-		return -EINVAL;
-
-	pdata = pdev->dev.platform_data;
-	if (!pdata) {
-		dev_err(&pdev->dev, "no platform data\n");
-		return -EINVAL;
-	}
-
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*als));
-	if (!indio_dev)
-		return -ENOMEM;
-
-	indio_dev->info = &lm3533_als_info;
-	indio_dev->channels = lm3533_als_channels;
-	indio_dev->num_channels = ARRAY_SIZE(lm3533_als_channels);
-	indio_dev->name = dev_name(&pdev->dev);
-	iio_device_set_parent(indio_dev, pdev->dev.parent);
-	indio_dev->modes = INDIO_DIRECT_MODE;
-
-	als = iio_priv(indio_dev);
-	als->lm3533 = lm3533;
-	als->pdev = pdev;
-	als->irq = lm3533->irq;
-	atomic_set(&als->zone, 0);
-	mutex_init(&als->thresh_mutex);
-
-	platform_set_drvdata(pdev, indio_dev);
-
-	if (als->irq) {
-		ret = lm3533_als_setup_irq(als, indio_dev);
-		if (ret)
-			return ret;
-	}
-
-	ret = lm3533_als_setup(als, pdata);
-	if (ret)
-		goto err_free_irq;
-
-	ret = lm3533_als_enable(als);
-	if (ret)
-		goto err_free_irq;
-
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register ALS\n");
-		goto err_disable;
-	}
-
-	return 0;
-
-err_disable:
-	lm3533_als_disable(als);
-err_free_irq:
-	if (als->irq)
-		free_irq(als->irq, indio_dev);
-
-	return ret;
-}
-
-static void lm3533_als_remove(struct platform_device *pdev)
-{
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct lm3533_als *als = iio_priv(indio_dev);
-
-	lm3533_als_set_int_mode(indio_dev, false);
-	iio_device_unregister(indio_dev);
-	lm3533_als_disable(als);
-	if (als->irq)
-		free_irq(als->irq, indio_dev);
-}
-
-static struct platform_driver lm3533_als_driver = {
-	.driver	= {
-		.name	= "lm3533-als",
-	},
-	.probe		= lm3533_als_probe,
-	.remove_new	= lm3533_als_remove,
-};
-module_platform_driver(lm3533_als_driver);
-
-MODULE_AUTHOR("Johan Hovold <jhovold@gmail.com>");
-MODULE_DESCRIPTION("LM3533 Ambient Light Sensor driver");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:lm3533-als");
-- 
2.43.0.rc1.1336.g36b5255a03ac


