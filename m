Return-Path: <linux-iio+bounces-5548-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D408D67C0
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 19:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987E52838A4
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 17:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF84617C9FB;
	Fri, 31 May 2024 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LZ74HylB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF1917C223;
	Fri, 31 May 2024 17:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717175336; cv=none; b=kLJX8RfJYGTuBBBEp7UL+Gggd/wMPxazz6wiN/STBu8IKH7sDfL8SIvSu2IBEao/GIdi192oXRJIhy2tbbGEXq1ZsKF80itMMwCcj45Jf9u3ote6xIisTdL3xXmNLw53qJeMJ9+v55ttDWfiFtERsLoT6a+tuLyLSPCdppA+Jkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717175336; c=relaxed/simple;
	bh=2q9QlVI/f03rYQOTivHmu7hY6K+c4OWLLJUjCRQkbws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMxG+aJSXO8QFItAxcSwryfjpd4CwPp8ky4s0BnQLp9pg3VBFM1UTW/UpUr1J99lMnK2/q7Sqp9nGunhJ4D91W+ns36FF0xNl0Zm8tPMoc9mzTxlnW9Qxjx7/F9wQ6EDVU7rwZdynaB9QS4/ewNiJVQV1iNJ2nZ8ZiQjhBviNS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LZ74HylB; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717175335; x=1748711335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2q9QlVI/f03rYQOTivHmu7hY6K+c4OWLLJUjCRQkbws=;
  b=LZ74HylB4aWiVZbWRnqGC3rVXPmWaPcNcLyUWgzi86cpiOs42aLH8rTz
   RUw/6aYhNp9E6/S6ZJR9KGBhMQ+8t0SuXkasdnzKIX7wlWt/oqxd7xmLg
   qBa48a0o+r5mhR5t1nzXqkBsH4S/BMh6Kn43B7/y1OdRaMcuWHlGjb2pt
   jCG8ioCqPnJOfQdk0SuoISbqLBn0dSZp4kTEm9gMm9kmh+1Rs5VG8xZg1
   1BjLQilVDrlVVKNVrQ5Hs6iIZORDv9eLUICl+zLDpvJyxOvW335hO3PCF
   Qz6sN5TIF/3pfywrCWnqQtTP0W2DelC6b62ESnh3DskT+oo2EaO3NdIs8
   w==;
X-CSE-ConnectionGUID: zfvxVgeuTNysgABYGrYzJA==
X-CSE-MsgGUID: 1wkPPR7PQwyf9wa3wH3Gxg==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="31224218"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="31224218"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 10:08:52 -0700
X-CSE-ConnectionGUID: 6bL+POsfQ1erow9TF+gXiQ==
X-CSE-MsgGUID: EY23vCM3TpKv+kpk32iFsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="36163155"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 31 May 2024 10:08:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7EAE0136; Fri, 31 May 2024 20:08:46 +0300 (EEST)
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
Subject: [PATCH v1 1/4] backlight: lm3533_bl: Remove the driver
Date: Fri, 31 May 2024 19:56:13 +0300
Message-ID: <20240531170844.1595468-2-andriy.shevchenko@linux.intel.com>
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
 drivers/video/backlight/Kconfig     |  11 -
 drivers/video/backlight/Makefile    |   1 -
 drivers/video/backlight/lm3533_bl.c | 399 ----------------------------
 3 files changed, 411 deletions(-)
 delete mode 100644 drivers/video/backlight/lm3533_bl.c

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 230bca07b09d..91d6618d69a0 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -198,17 +198,6 @@ config BACKLIGHT_KTZ8866
 		Say Y to enable the backlight driver for the Kinetic KTZ8866
 		found in Xiaomi Mi Pad 5 series.
 
-config BACKLIGHT_LM3533
-	tristate "Backlight Driver for LM3533"
-	depends on MFD_LM3533
-	help
-	  Say Y to enable the backlight driver for National Semiconductor / TI
-	  LM3533 Lighting Power chips.
-
-	  The backlights can be controlled directly, through PWM input, or by
-	  the ambient-light-sensor interface. The chip supports 256 brightness
-	  levels.
-
 config BACKLIGHT_LOCOMO
 	tristate "Sharp LOCOMO LCD/Backlight Driver"
 	depends on SHARP_LOCOMO
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index 8d2cb252042d..fc75b9f059f9 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -36,7 +36,6 @@ obj-$(CONFIG_BACKLIGHT_IPAQ_MICRO)	+= ipaq_micro_bl.o
 obj-$(CONFIG_BACKLIGHT_KTD253)		+= ktd253-backlight.o
 obj-$(CONFIG_BACKLIGHT_KTD2801)		+= ktd2801-backlight.o
 obj-$(CONFIG_BACKLIGHT_KTZ8866)		+= ktz8866.o
-obj-$(CONFIG_BACKLIGHT_LM3533)		+= lm3533_bl.o
 obj-$(CONFIG_BACKLIGHT_LM3630A)		+= lm3630a_bl.o
 obj-$(CONFIG_BACKLIGHT_LM3639)		+= lm3639_bl.o
 obj-$(CONFIG_BACKLIGHT_LOCOMO)		+= locomolcd.o
diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
deleted file mode 100644
index 3e10d480cb7f..000000000000
--- a/drivers/video/backlight/lm3533_bl.c
+++ /dev/null
@@ -1,399 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * lm3533-bl.c -- LM3533 Backlight driver
- *
- * Copyright (C) 2011-2012 Texas Instruments
- *
- * Author: Johan Hovold <jhovold@gmail.com>
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/backlight.h>
-#include <linux/fb.h>
-#include <linux/slab.h>
-
-#include <linux/mfd/lm3533.h>
-
-
-#define LM3533_HVCTRLBANK_COUNT		2
-#define LM3533_BL_MAX_BRIGHTNESS	255
-
-#define LM3533_REG_CTRLBANK_AB_BCONF	0x1a
-
-
-struct lm3533_bl {
-	struct lm3533 *lm3533;
-	struct lm3533_ctrlbank cb;
-	struct backlight_device *bd;
-	int id;
-};
-
-
-static inline int lm3533_bl_get_ctrlbank_id(struct lm3533_bl *bl)
-{
-	return bl->id;
-}
-
-static int lm3533_bl_update_status(struct backlight_device *bd)
-{
-	struct lm3533_bl *bl = bl_get_data(bd);
-
-	return lm3533_ctrlbank_set_brightness(&bl->cb, backlight_get_brightness(bd));
-}
-
-static int lm3533_bl_get_brightness(struct backlight_device *bd)
-{
-	struct lm3533_bl *bl = bl_get_data(bd);
-	u8 val;
-	int ret;
-
-	ret = lm3533_ctrlbank_get_brightness(&bl->cb, &val);
-	if (ret)
-		return ret;
-
-	return val;
-}
-
-static const struct backlight_ops lm3533_bl_ops = {
-	.get_brightness	= lm3533_bl_get_brightness,
-	.update_status	= lm3533_bl_update_status,
-};
-
-static ssize_t show_id(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct lm3533_bl *bl = dev_get_drvdata(dev);
-
-	return scnprintf(buf, PAGE_SIZE, "%d\n", bl->id);
-}
-
-static ssize_t show_als_channel(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct lm3533_bl *bl = dev_get_drvdata(dev);
-	unsigned channel = lm3533_bl_get_ctrlbank_id(bl);
-
-	return scnprintf(buf, PAGE_SIZE, "%u\n", channel);
-}
-
-static ssize_t show_als_en(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct lm3533_bl *bl = dev_get_drvdata(dev);
-	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
-	u8 val;
-	u8 mask;
-	bool enable;
-	int ret;
-
-	ret = lm3533_read(bl->lm3533, LM3533_REG_CTRLBANK_AB_BCONF, &val);
-	if (ret)
-		return ret;
-
-	mask = 1 << (2 * ctrlbank);
-	enable = val & mask;
-
-	return scnprintf(buf, PAGE_SIZE, "%d\n", enable);
-}
-
-static ssize_t store_als_en(struct device *dev,
-					struct device_attribute *attr,
-					const char *buf, size_t len)
-{
-	struct lm3533_bl *bl = dev_get_drvdata(dev);
-	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
-	int enable;
-	u8 val;
-	u8 mask;
-	int ret;
-
-	if (kstrtoint(buf, 0, &enable))
-		return -EINVAL;
-
-	mask = 1 << (2 * ctrlbank);
-
-	if (enable)
-		val = mask;
-	else
-		val = 0;
-
-	ret = lm3533_update(bl->lm3533, LM3533_REG_CTRLBANK_AB_BCONF, val,
-									mask);
-	if (ret)
-		return ret;
-
-	return len;
-}
-
-static ssize_t show_linear(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct lm3533_bl *bl = dev_get_drvdata(dev);
-	u8 val;
-	u8 mask;
-	int linear;
-	int ret;
-
-	ret = lm3533_read(bl->lm3533, LM3533_REG_CTRLBANK_AB_BCONF, &val);
-	if (ret)
-		return ret;
-
-	mask = 1 << (2 * lm3533_bl_get_ctrlbank_id(bl) + 1);
-
-	if (val & mask)
-		linear = 1;
-	else
-		linear = 0;
-
-	return scnprintf(buf, PAGE_SIZE, "%x\n", linear);
-}
-
-static ssize_t store_linear(struct device *dev,
-					struct device_attribute *attr,
-					const char *buf, size_t len)
-{
-	struct lm3533_bl *bl = dev_get_drvdata(dev);
-	unsigned long linear;
-	u8 mask;
-	u8 val;
-	int ret;
-
-	if (kstrtoul(buf, 0, &linear))
-		return -EINVAL;
-
-	mask = 1 << (2 * lm3533_bl_get_ctrlbank_id(bl) + 1);
-
-	if (linear)
-		val = mask;
-	else
-		val = 0;
-
-	ret = lm3533_update(bl->lm3533, LM3533_REG_CTRLBANK_AB_BCONF, val,
-									mask);
-	if (ret)
-		return ret;
-
-	return len;
-}
-
-static ssize_t show_pwm(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
-{
-	struct lm3533_bl *bl = dev_get_drvdata(dev);
-	u8 val;
-	int ret;
-
-	ret = lm3533_ctrlbank_get_pwm(&bl->cb, &val);
-	if (ret)
-		return ret;
-
-	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
-}
-
-static ssize_t store_pwm(struct device *dev,
-					struct device_attribute *attr,
-					const char *buf, size_t len)
-{
-	struct lm3533_bl *bl = dev_get_drvdata(dev);
-	u8 val;
-	int ret;
-
-	if (kstrtou8(buf, 0, &val))
-		return -EINVAL;
-
-	ret = lm3533_ctrlbank_set_pwm(&bl->cb, val);
-	if (ret)
-		return ret;
-
-	return len;
-}
-
-static LM3533_ATTR_RO(als_channel);
-static LM3533_ATTR_RW(als_en);
-static LM3533_ATTR_RO(id);
-static LM3533_ATTR_RW(linear);
-static LM3533_ATTR_RW(pwm);
-
-static struct attribute *lm3533_bl_attributes[] = {
-	&dev_attr_als_channel.attr,
-	&dev_attr_als_en.attr,
-	&dev_attr_id.attr,
-	&dev_attr_linear.attr,
-	&dev_attr_pwm.attr,
-	NULL,
-};
-
-static umode_t lm3533_bl_attr_is_visible(struct kobject *kobj,
-					     struct attribute *attr, int n)
-{
-	struct device *dev = kobj_to_dev(kobj);
-	struct lm3533_bl *bl = dev_get_drvdata(dev);
-	umode_t mode = attr->mode;
-
-	if (attr == &dev_attr_als_channel.attr ||
-					attr == &dev_attr_als_en.attr) {
-		if (!bl->lm3533->have_als)
-			mode = 0;
-	}
-
-	return mode;
-};
-
-static struct attribute_group lm3533_bl_attribute_group = {
-	.is_visible	= lm3533_bl_attr_is_visible,
-	.attrs		= lm3533_bl_attributes
-};
-
-static int lm3533_bl_setup(struct lm3533_bl *bl,
-					struct lm3533_bl_platform_data *pdata)
-{
-	int ret;
-
-	ret = lm3533_ctrlbank_set_max_current(&bl->cb, pdata->max_current);
-	if (ret)
-		return ret;
-
-	return lm3533_ctrlbank_set_pwm(&bl->cb, pdata->pwm);
-}
-
-static int lm3533_bl_probe(struct platform_device *pdev)
-{
-	struct lm3533 *lm3533;
-	struct lm3533_bl_platform_data *pdata;
-	struct lm3533_bl *bl;
-	struct backlight_device *bd;
-	struct backlight_properties props;
-	int ret;
-
-	dev_dbg(&pdev->dev, "%s\n", __func__);
-
-	lm3533 = dev_get_drvdata(pdev->dev.parent);
-	if (!lm3533)
-		return -EINVAL;
-
-	pdata = dev_get_platdata(&pdev->dev);
-	if (!pdata) {
-		dev_err(&pdev->dev, "no platform data\n");
-		return -EINVAL;
-	}
-
-	if (pdev->id < 0 || pdev->id >= LM3533_HVCTRLBANK_COUNT) {
-		dev_err(&pdev->dev, "illegal backlight id %d\n", pdev->id);
-		return -EINVAL;
-	}
-
-	bl = devm_kzalloc(&pdev->dev, sizeof(*bl), GFP_KERNEL);
-	if (!bl)
-		return -ENOMEM;
-
-	bl->lm3533 = lm3533;
-	bl->id = pdev->id;
-
-	bl->cb.lm3533 = lm3533;
-	bl->cb.id = lm3533_bl_get_ctrlbank_id(bl);
-	bl->cb.dev = NULL;			/* until registered */
-
-	memset(&props, 0, sizeof(props));
-	props.type = BACKLIGHT_RAW;
-	props.max_brightness = LM3533_BL_MAX_BRIGHTNESS;
-	props.brightness = pdata->default_brightness;
-	bd = devm_backlight_device_register(&pdev->dev, pdata->name,
-					pdev->dev.parent, bl, &lm3533_bl_ops,
-					&props);
-	if (IS_ERR(bd)) {
-		dev_err(&pdev->dev, "failed to register backlight device\n");
-		return PTR_ERR(bd);
-	}
-
-	bl->bd = bd;
-	bl->cb.dev = &bl->bd->dev;
-
-	platform_set_drvdata(pdev, bl);
-
-	ret = sysfs_create_group(&bd->dev.kobj, &lm3533_bl_attribute_group);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to create sysfs attributes\n");
-		return ret;
-	}
-
-	backlight_update_status(bd);
-
-	ret = lm3533_bl_setup(bl, pdata);
-	if (ret)
-		goto err_sysfs_remove;
-
-	ret = lm3533_ctrlbank_enable(&bl->cb);
-	if (ret)
-		goto err_sysfs_remove;
-
-	return 0;
-
-err_sysfs_remove:
-	sysfs_remove_group(&bd->dev.kobj, &lm3533_bl_attribute_group);
-
-	return ret;
-}
-
-static void lm3533_bl_remove(struct platform_device *pdev)
-{
-	struct lm3533_bl *bl = platform_get_drvdata(pdev);
-	struct backlight_device *bd = bl->bd;
-
-	dev_dbg(&bd->dev, "%s\n", __func__);
-
-	bd->props.power = FB_BLANK_POWERDOWN;
-	bd->props.brightness = 0;
-
-	lm3533_ctrlbank_disable(&bl->cb);
-	sysfs_remove_group(&bd->dev.kobj, &lm3533_bl_attribute_group);
-}
-
-#ifdef CONFIG_PM_SLEEP
-static int lm3533_bl_suspend(struct device *dev)
-{
-	struct lm3533_bl *bl = dev_get_drvdata(dev);
-
-	dev_dbg(dev, "%s\n", __func__);
-
-	return lm3533_ctrlbank_disable(&bl->cb);
-}
-
-static int lm3533_bl_resume(struct device *dev)
-{
-	struct lm3533_bl *bl = dev_get_drvdata(dev);
-
-	dev_dbg(dev, "%s\n", __func__);
-
-	return lm3533_ctrlbank_enable(&bl->cb);
-}
-#endif
-
-static SIMPLE_DEV_PM_OPS(lm3533_bl_pm_ops, lm3533_bl_suspend, lm3533_bl_resume);
-
-static void lm3533_bl_shutdown(struct platform_device *pdev)
-{
-	struct lm3533_bl *bl = platform_get_drvdata(pdev);
-
-	dev_dbg(&pdev->dev, "%s\n", __func__);
-
-	lm3533_ctrlbank_disable(&bl->cb);
-}
-
-static struct platform_driver lm3533_bl_driver = {
-	.driver = {
-		.name	= "lm3533-backlight",
-		.pm	= &lm3533_bl_pm_ops,
-	},
-	.probe		= lm3533_bl_probe,
-	.remove_new	= lm3533_bl_remove,
-	.shutdown	= lm3533_bl_shutdown,
-};
-module_platform_driver(lm3533_bl_driver);
-
-MODULE_AUTHOR("Johan Hovold <jhovold@gmail.com>");
-MODULE_DESCRIPTION("LM3533 Backlight driver");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:lm3533-backlight");
-- 
2.43.0.rc1.1336.g36b5255a03ac


