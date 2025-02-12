Return-Path: <linux-iio+bounces-15424-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 241B9A32084
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 08:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E6E161C3E
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 07:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89B0204F8C;
	Wed, 12 Feb 2025 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIcoEaWU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B47204C07;
	Wed, 12 Feb 2025 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739347162; cv=none; b=icFfq1Z25bBxb4fHoN+Qi8MwKTDiCJno+HKYT61dQBrV5tfta7jR9Yri+7xymWGMxye5fOHFkaJbi3pav6rd7NJ8242t8Vl8GUU+sUwyqlT7c09JstSrLm9OOt6gHrCT5878u4GWealkhfdfcObbr3QnfOWWMB+nrRwOHGnTlaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739347162; c=relaxed/simple;
	bh=g147+pNHCblvdLkB3gSmClxMR2wA7snJ1XhYu/42Wnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7lNogt7Cb5F6w7orQLy3of5m3EFOPecpyP7tmQWpjVWE1eq0/cKNdimKs+PPa/mSnLZu8G8mupB5Dz4d+fw2HPwmrDM1uPUlbtbvUduvXKT76Fv/0Jps5ioLWnaCRcZA4XLbIckrxQVr7bbZbbe/Cod//Y0X4NM8rhjdBTQvbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIcoEaWU; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5450408455dso4619526e87.0;
        Tue, 11 Feb 2025 23:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739347158; x=1739951958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nw1AK0MrowiHGVQ4sl0yVhUzbIvFUDWN6wQBGIzcdc=;
        b=DIcoEaWU48hMdS67tE0QkPt1SRuQFNrWHVmolkqfDf4qc43pRLk2KM6qgVqmsHHG3G
         NpOuqPyvLJ0DQsGtETPZPPnEOygzTtnJfTBt5vpnmXvXa7HMjjIZeAJQ4ghFv12x1iXK
         qWV2zsMOBRuR8x8d0W9ky5SM6Hu9XR4Lie76mhhiJ++AWQ+nsCEd6UwyddIw2kZtDfWo
         hcHvGTUiHp43RRPjqMjIWgRg3yCuMscWuNrhiLOywoCddwpenoN4NLGo8FbYX9vZhZp1
         EpeQ6VQIvQ5kd0mgZ3RaKKHgK49v8rIOSGhfxgC8lbmXtSJ8CWhz8lxfzOt3FklyIyFs
         0V4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739347158; x=1739951958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nw1AK0MrowiHGVQ4sl0yVhUzbIvFUDWN6wQBGIzcdc=;
        b=krTizioaKFD/hihZVH8T3xpn2i6T8jcsUCdiN5Z4he5Jcaqd4qOJ5QDoo/Mnp7OedZ
         bGIwTBNs6eV6IsuiEJTz+pXWST3MQHnsC52QJ2txRHqezgz+T0rJcvcKIYFGU2fUXfET
         TwxLEin7VHdzuVqXTrUkteasTZjwKQQ3wg3XnlypxZ0SNZVnVhI1ypudhXzNWwG0vgiy
         yowPaXwgfI5ImPZhxJUMSmFCYOwf49CwXMOCiJLz9GDNWBehJiifa81ilmh64YR7tUx5
         aIBIXaY9yIxRLbHx6ZWUwXh9+dCrUK6H6CvjB6UVmYL6RV4J/cZ0ua/fry2bfOGVJOOG
         KDZw==
X-Forwarded-Encrypted: i=1; AJvYcCULs2xps0Op+Rq/zZqMMo8YjiUZE8NAwpP3CGJNtYZ2+1+itYEgASOP9GM1S6ALvKgJZTbrDy0hx4My@vger.kernel.org, AJvYcCUr6i3FpK2fdCL1UFxBiXBZgX3AJRsM8A9fJakhokWSoOFSDsCrXzor6QudwKcyjBRKU7sDz2IMlV9sMA==@vger.kernel.org, AJvYcCVV7rzDDwPA0mIb1JEmvzwLDLr4ho7WcPhInz6rmBsRsCRfavbojc47pjPcHFoq/sKLx6wj7BthCD6SPg==@vger.kernel.org, AJvYcCWiQTtqtom96uxYJA6/ol1CFiGOMClhkLueTY/rWNafJhu3xuwcyV2McOlByiitmL4k856rD1X74P4nSutQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxM290D5fTwNibs37LvYgoNb6si99xi/tQgMm+4jZm6InCZUG/3
	vscO9nLJ+7ILdWvJATbjPUdQYaFJ1erTLBwivFH5MH2Z1BrFlXdg
X-Gm-Gg: ASbGncucKossA0wOY6lPV0rJTNH04YBxSQ99+fGR0PCQ4MDssUSFbexA4U6ktumuuk5
	zld67KMlf8pWMLDR9H00gbVipMum9GpDii/0iUleH6ZtM4ifmFfAhxYmK/Vun/7W6tmUVz9cNBi
	bltexFoqDx6OCx8waYHaVE3HoLNCMuzbfNvWdshO6InxCb9KG0osMfVcn+V0QxvrB2JJ3DdTqVX
	zkREmKAw5u399vNiZnXka3U6z612Ph26AoOz9PnxuHp39qP1YpVXi0pnj9YdZwfSoi6qfFCC49t
	d7mF86k=
X-Google-Smtp-Source: AGHT+IE+G1N55eGrWmECjyblYtooPWCOLDqnOhvaRLbHU2CRlzATbmbECnCgtrhZAPbtQBO6UNR21g==
X-Received: by 2002:a05:6512:b22:b0:544:f93:6909 with SMTP id 2adb3069b0e04-54518122cd4mr623415e87.30.1739347158114;
        Tue, 11 Feb 2025 23:59:18 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5441053eacfsm1797880e87.38.2025.02.11.23.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 23:59:17 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Pavel Machek <pavel@ucw.cz>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v1 2/2] mfd: lm3533: convert to use OF
Date: Wed, 12 Feb 2025 09:58:42 +0200
Message-ID: <20250212075845.11338-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212075845.11338-1-clamor95@gmail.com>
References: <20250212075845.11338-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ability to fill pdata from device tree. Common stuff is
filled from core driver and then pdata is filled per-device
since all cells are optional.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/iio/light/lm3533-als.c      | 58 ++++++++++++++++++++-
 drivers/leds/leds-lm3533.c          | 69 +++++++++++++++++++++++--
 drivers/mfd/lm3533-core.c           | 79 ++++++++++++++++++++++++-----
 drivers/video/backlight/lm3533_bl.c | 72 ++++++++++++++++++++++++--
 include/linux/mfd/lm3533.h          |  1 +
 5 files changed, 256 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index 99f0b903018c..21fc5f215c80 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -16,7 +16,9 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/mfd/core.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 
@@ -826,6 +828,50 @@ static const struct iio_info lm3533_als_info = {
 	.read_raw	= &lm3533_als_read_raw,
 };
 
+static void lm3533_parse_als(struct platform_device *pdev,
+			     struct lm3533_als_platform_data *pdata)
+{
+	struct device *dev = &pdev->dev;
+	int val, ret;
+
+	/* 1 - 127 (ignored in PWM-mode) */
+	ret = device_property_read_u32(dev, "resistor-value", &val);
+	if (ret)
+		val = 1;
+	pdata->r_select = val;
+
+	pdata->pwm_mode = device_property_read_bool(dev, "pwm-mode");
+}
+
+static int lm3533_pass_of_node(struct platform_device *pdev,
+			       struct lm3533_als_platform_data *pdata)
+{
+	struct device *parent_dev = pdev->dev.parent;
+	struct device *dev = &pdev->dev;
+	struct fwnode_handle *node;
+	const char *label;
+	int val, ret;
+
+	device_for_each_child_node(parent_dev, node) {
+		fwnode_property_read_string(node, "compatible", &label);
+
+		if (!strcmp(label, pdev->name)) {
+			ret = fwnode_property_read_u32(node, "reg", &val);
+			if (ret) {
+				dev_err(dev, "reg property is missing: ret %d\n", ret);
+				return ret;
+			}
+
+			if (val == pdev->id) {
+				dev->fwnode = node;
+				dev->of_node = to_of_node(node);
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int lm3533_als_probe(struct platform_device *pdev)
 {
 	const struct lm3533_als_platform_data *pdata;
@@ -840,8 +886,16 @@ static int lm3533_als_probe(struct platform_device *pdev)
 
 	pdata = dev_get_platdata(&pdev->dev);
 	if (!pdata) {
-		dev_err(&pdev->dev, "no platform data\n");
-		return -EINVAL;
+		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+		if (!pdata)
+			return -ENOMEM;
+
+		ret = lm3533_pass_of_node(pdev, pdata);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "failed to get als device node\n");
+
+		lm3533_parse_als(pdev, pdata);
 	}
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*als));
diff --git a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm3533.c
index 45795f2a1042..587bc27b17c3 100644
--- a/drivers/leds/leds-lm3533.c
+++ b/drivers/leds/leds-lm3533.c
@@ -11,7 +11,9 @@
 #include <linux/leds.h>
 #include <linux/mfd/core.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 
 #include <linux/mfd/lm3533.h>
@@ -644,6 +646,59 @@ static int lm3533_led_setup(struct lm3533_led *led,
 	return lm3533_ctrlbank_set_pwm(&led->cb, pdata->pwm);
 }
 
+static void lm3533_parse_led(struct platform_device *pdev,
+			     struct lm3533_led_platform_data *pdata)
+{
+	struct device *dev = &pdev->dev;
+	int val, ret;
+
+	ret = device_property_read_string(dev, "default-trigger",
+					  &pdata->default_trigger);
+	if (ret)
+		pdata->default_trigger = "none";
+
+	/* 5000 - 29800 uA (800 uA step) */
+	ret = device_property_read_u32(dev, "max-current-microamp", &val);
+	if (ret)
+		val = 5000;
+	pdata->max_current = val;
+
+	/* 0 - 0x3f */
+	ret = device_property_read_u32(dev, "pwm", &val);
+	if (ret)
+		val = 0;
+	pdata->pwm = val;
+}
+
+static int lm3533_pass_of_node(struct platform_device *pdev,
+			       struct lm3533_led_platform_data *pdata)
+{
+	struct device *parent_dev = pdev->dev.parent;
+	struct device *dev = &pdev->dev;
+	struct fwnode_handle *node;
+	const char *label;
+	int val, ret;
+
+	device_for_each_child_node(parent_dev, node) {
+		fwnode_property_read_string(node, "compatible", &label);
+
+		if (!strcmp(label, pdev->name)) {
+			ret = fwnode_property_read_u32(node, "reg", &val);
+			if (ret) {
+				dev_info(dev, "reg property is missing: ret %d\n", ret);
+				return ret;
+			}
+
+			if (val == pdev->id) {
+				dev->fwnode = node;
+				dev->of_node = to_of_node(node);
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int lm3533_led_probe(struct platform_device *pdev)
 {
 	struct lm3533 *lm3533;
@@ -659,8 +714,16 @@ static int lm3533_led_probe(struct platform_device *pdev)
 
 	pdata = dev_get_platdata(&pdev->dev);
 	if (!pdata) {
-		dev_err(&pdev->dev, "no platform data\n");
-		return -EINVAL;
+		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+		if (!pdata)
+			return -ENOMEM;
+
+		ret = lm3533_pass_of_node(pdev, pdata);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "failed to get led device node\n");
+
+		lm3533_parse_led(pdev, pdata);
 	}
 
 	if (pdev->id < 0 || pdev->id >= LM3533_LVCTRLBANK_COUNT) {
@@ -673,7 +736,7 @@ static int lm3533_led_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	led->lm3533 = lm3533;
-	led->cdev.name = pdata->name;
+	led->cdev.name = dev_name(&pdev->dev);
 	led->cdev.default_trigger = pdata->default_trigger;
 	led->cdev.brightness_set_blocking = lm3533_led_set;
 	led->cdev.brightness_get = lm3533_led_get;
diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 0a2409d00b2e..cab60c25e3c7 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -381,11 +381,16 @@ static int lm3533_device_als_init(struct lm3533 *lm3533)
 	struct lm3533_platform_data *pdata = dev_get_platdata(lm3533->dev);
 	int ret;
 
-	if (!pdata->als)
+	if (!pdata->num_als)
 		return 0;
 
-	lm3533_als_devs[0].platform_data = pdata->als;
-	lm3533_als_devs[0].pdata_size = sizeof(*pdata->als);
+	if (pdata->num_als > ARRAY_SIZE(lm3533_als_devs))
+		pdata->num_als = ARRAY_SIZE(lm3533_als_devs);
+
+	if (pdata->als) {
+		lm3533_als_devs[0].platform_data = pdata->als;
+		lm3533_als_devs[0].pdata_size = sizeof(*pdata->als);
+	}
 
 	ret = mfd_add_devices(lm3533->dev, 0, lm3533_als_devs, 1, NULL,
 			      0, NULL);
@@ -405,15 +410,17 @@ static int lm3533_device_bl_init(struct lm3533 *lm3533)
 	int i;
 	int ret;
 
-	if (!pdata->backlights || pdata->num_backlights == 0)
+	if (!pdata->num_backlights)
 		return 0;
 
 	if (pdata->num_backlights > ARRAY_SIZE(lm3533_bl_devs))
 		pdata->num_backlights = ARRAY_SIZE(lm3533_bl_devs);
 
-	for (i = 0; i < pdata->num_backlights; ++i) {
-		lm3533_bl_devs[i].platform_data = &pdata->backlights[i];
-		lm3533_bl_devs[i].pdata_size = sizeof(pdata->backlights[i]);
+	if (pdata->backlights) {
+		for (i = 0; i < pdata->num_backlights; ++i) {
+			lm3533_bl_devs[i].platform_data = &pdata->backlights[i];
+			lm3533_bl_devs[i].pdata_size = sizeof(pdata->backlights[i]);
+		}
 	}
 
 	ret = mfd_add_devices(lm3533->dev, 0, lm3533_bl_devs,
@@ -434,15 +441,17 @@ static int lm3533_device_led_init(struct lm3533 *lm3533)
 	int i;
 	int ret;
 
-	if (!pdata->leds || pdata->num_leds == 0)
+	if (!pdata->num_leds)
 		return 0;
 
 	if (pdata->num_leds > ARRAY_SIZE(lm3533_led_devs))
 		pdata->num_leds = ARRAY_SIZE(lm3533_led_devs);
 
-	for (i = 0; i < pdata->num_leds; ++i) {
-		lm3533_led_devs[i].platform_data = &pdata->leds[i];
-		lm3533_led_devs[i].pdata_size = sizeof(pdata->leds[i]);
+	if (pdata->leds) {
+		for (i = 0; i < pdata->num_leds; ++i) {
+			lm3533_led_devs[i].platform_data = &pdata->leds[i];
+			lm3533_led_devs[i].pdata_size = sizeof(pdata->leds[i]);
+		}
 	}
 
 	ret = mfd_add_devices(lm3533->dev, 0, lm3533_led_devs,
@@ -469,6 +478,26 @@ static int lm3533_device_setup(struct lm3533 *lm3533,
 	return lm3533_set_boost_ovp(lm3533, pdata->boost_ovp);
 }
 
+static void lm3533_parse_nodes(struct lm3533 *lm3533,
+			       struct lm3533_platform_data *pdata)
+{
+	struct fwnode_handle *node;
+	const char *label;
+
+	device_for_each_child_node(lm3533->dev, node) {
+		fwnode_property_read_string(node, "compatible", &label);
+
+		if (!strcmp(label, lm3533_bl_devs[pdata->num_backlights].name))
+			pdata->num_backlights++;
+
+		if (!strcmp(label, lm3533_led_devs[pdata->num_leds].name))
+			pdata->num_leds++;
+
+		if (!strcmp(label, lm3533_als_devs[pdata->num_als].name))
+			pdata->num_als++;
+	}
+}
+
 static int lm3533_device_init(struct lm3533 *lm3533)
 {
 	struct lm3533_platform_data *pdata = dev_get_platdata(lm3533->dev);
@@ -477,8 +506,25 @@ static int lm3533_device_init(struct lm3533 *lm3533)
 	dev_dbg(lm3533->dev, "%s\n", __func__);
 
 	if (!pdata) {
-		dev_err(lm3533->dev, "no platform data\n");
-		return -EINVAL;
+		pdata = devm_kzalloc(lm3533->dev, sizeof(*pdata), GFP_KERNEL);
+		if (!pdata)
+			return -ENOMEM;
+
+		ret = device_property_read_u32(lm3533->dev,
+					       "ti,boost-ovp",
+					       &pdata->boost_ovp);
+		if (ret)
+			pdata->boost_ovp = LM3533_BOOST_OVP_16V;
+
+		ret = device_property_read_u32(lm3533->dev,
+					       "ti,boost-freq",
+					       &pdata->boost_freq);
+		if (ret)
+			pdata->boost_freq = LM3533_BOOST_FREQ_500KHZ;
+
+		lm3533_parse_nodes(lm3533, pdata);
+
+		lm3533->dev->platform_data = pdata;
 	}
 
 	lm3533->hwen = devm_gpiod_get(lm3533->dev, NULL, GPIOD_OUT_LOW);
@@ -603,6 +649,12 @@ static void lm3533_i2c_remove(struct i2c_client *i2c)
 	lm3533_device_exit(lm3533);
 }
 
+static const struct of_device_id lm3533_match_table[] = {
+	{ .compatible = "ti,lm3533" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, lm3533_match_table);
+
 static const struct i2c_device_id lm3533_i2c_ids[] = {
 	{ "lm3533" },
 	{ }
@@ -612,6 +664,7 @@ MODULE_DEVICE_TABLE(i2c, lm3533_i2c_ids);
 static struct i2c_driver lm3533_i2c_driver = {
 	.driver = {
 		   .name = "lm3533",
+		   .of_match_table = lm3533_match_table,
 	},
 	.id_table	= lm3533_i2c_ids,
 	.probe		= lm3533_i2c_probe,
diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index babfd3ceec86..bc568916f1b1 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -258,6 +258,60 @@ static int lm3533_bl_setup(struct lm3533_bl *bl,
 	return lm3533_ctrlbank_set_pwm(&bl->cb, pdata->pwm);
 }
 
+static void lm3533_parse_backlight(struct platform_device *pdev,
+				   struct lm3533_bl_platform_data *pdata)
+{
+	struct device *dev = &pdev->dev;
+	int val, ret;
+
+	/* 5000 - 29800 uA (800 uA step) */
+	ret = device_property_read_u32(dev, "max-current-microamp", &val);
+	if (ret)
+		val = 5000;
+	pdata->max_current = val;
+
+	/* 0 - 255 */
+	ret = device_property_read_u32(dev, "default-brightness", &val);
+	if (ret)
+		val = LM3533_BL_MAX_BRIGHTNESS;
+	pdata->default_brightness = val;
+
+	/* 0 - 0x3f */
+	ret = device_property_read_u32(dev, "pwm", &val);
+	if (ret)
+		val = 0;
+	pdata->pwm = val;
+}
+
+static int lm3533_pass_of_node(struct platform_device *pdev,
+			       struct lm3533_bl_platform_data *pdata)
+{
+	struct device *parent_dev = pdev->dev.parent;
+	struct device *dev = &pdev->dev;
+	struct fwnode_handle *node;
+	const char *label;
+	int val, ret;
+
+	device_for_each_child_node(parent_dev, node) {
+		fwnode_property_read_string(node, "compatible", &label);
+
+		if (!strcmp(label, pdev->name)) {
+			ret = fwnode_property_read_u32(node, "reg", &val);
+			if (ret) {
+				dev_info(dev, "reg property is missing: ret %d\n", ret);
+				return ret;
+			}
+
+			if (val == pdev->id) {
+				dev->fwnode = node;
+				dev->of_node = to_of_node(node);
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int lm3533_bl_probe(struct platform_device *pdev)
 {
 	struct lm3533 *lm3533;
@@ -275,8 +329,16 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 
 	pdata = dev_get_platdata(&pdev->dev);
 	if (!pdata) {
-		dev_err(&pdev->dev, "no platform data\n");
-		return -EINVAL;
+		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+		if (!pdata)
+			return -ENOMEM;
+
+		ret = lm3533_pass_of_node(pdev, pdata);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "failed to get backlight device node\n");
+
+		lm3533_parse_backlight(pdev, pdata);
 	}
 
 	if (pdev->id < 0 || pdev->id >= LM3533_HVCTRLBANK_COUNT) {
@@ -299,9 +361,9 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 	props.type = BACKLIGHT_RAW;
 	props.max_brightness = LM3533_BL_MAX_BRIGHTNESS;
 	props.brightness = pdata->default_brightness;
-	bd = devm_backlight_device_register(&pdev->dev, pdata->name,
-					pdev->dev.parent, bl, &lm3533_bl_ops,
-					&props);
+	bd = devm_backlight_device_register(&pdev->dev, dev_name(&pdev->dev),
+					    pdev->dev.parent, bl,
+					    &lm3533_bl_ops, &props);
 	if (IS_ERR(bd)) {
 		dev_err(&pdev->dev, "failed to register backlight device\n");
 		return PTR_ERR(bd);
diff --git a/include/linux/mfd/lm3533.h b/include/linux/mfd/lm3533.h
index 69059a7a2ce5..e22fd2093a95 100644
--- a/include/linux/mfd/lm3533.h
+++ b/include/linux/mfd/lm3533.h
@@ -74,6 +74,7 @@ struct lm3533_platform_data {
 	enum lm3533_boost_freq boost_freq;
 
 	struct lm3533_als_platform_data *als;
+	int num_als;
 
 	struct lm3533_bl_platform_data *backlights;
 	int num_backlights;
-- 
2.43.0


