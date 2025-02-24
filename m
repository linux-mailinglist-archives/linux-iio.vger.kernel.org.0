Return-Path: <linux-iio+bounces-15998-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AA9A41E64
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 13:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E13F63AFCEC
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 11:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84BC25B683;
	Mon, 24 Feb 2025 11:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4rP3sb0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F6B25A359;
	Mon, 24 Feb 2025 11:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740397725; cv=none; b=HCP1MWcH2Wtrfz1TiJhG7Z5yiAJWwOPEM6P2OUIgQyxWBuHGWIaCOf1o0u4vhb9SDlHk64Qqp8J8gpOVQDNFAtzBXW507KPMXgwxql5W0EjLsypNjL9y4UlqicYH1sfzjcXCYLNioKKSxR6elP4ZqlhSWrlRgNAcNT6RDpKxW8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740397725; c=relaxed/simple;
	bh=LiixZ6nLZXqDCL1axeLvoXoP++p+tvfMUNtdAl/Ty8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UuuvrxZ53frdvFrQtp56xWpU7Mp1QYF6WEhAb2rXUm7v99qZ0q8xkVO4+GlT6O2pl4Ss4OvTQ6KYeorOLHwKV0pGWrsRHU9YVaQwpMFZJKfQ0uY3YtQAbsWeiL01Qjv3yU9GO+tLYh7cQviC/leXf97+9fnrDkAK3Yp/kbLJL+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4rP3sb0; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5484fa1401cso150930e87.1;
        Mon, 24 Feb 2025 03:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740397718; x=1741002518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7YGxgcYsH2Z6UeAPNFU8eFx1X3tNVUIDdtvMVz8EVg=;
        b=C4rP3sb06vLx7oybn7x19EH+s7nSYydtuQMZhugZnvbC1uSPAxX6TpsI0mGsRgX91e
         tYoMXxiTu/DPgT0ie+rdW7DBOHJ5oh47eXFAO0IEmDk9TPtYn+gJyVO6RJkkrKCjS9jC
         kPw2ITARffLUYJ5G/paKv98TbU9UqclEGHNHzPVl6dCbJhrpZ3WlUoS23ZiixbhuWlq7
         3oDDZQIFWsBKKG1DX5CXi0a//LDk4FwNcMB2FcGVV9EEn5Hp4Pj1VYL4jzTJUsAnEntJ
         x3y/JrR4ao7MCkSMPs7NoJ8o9DBl69v+uuctwh1IeR8DhDl5SYW2GqP+4qcgM0tqx5e3
         9tdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740397718; x=1741002518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7YGxgcYsH2Z6UeAPNFU8eFx1X3tNVUIDdtvMVz8EVg=;
        b=tPqQ6KzjK1qeLdjynAgHyZjK90oKLyTLkGw5Mp9o97oW7xBTrBpuw7lG/Ku2ei2CWL
         jwOzXxpbNzyevkrz3k80wC91DihGwUohMxiEBFwtnQgUpNTDghGmwzUk35MwyCG0T4zq
         F74aEJhZLPavHzDx4e16nbhMJsPPKT+iIl0p8Te5nR7L4Ky+bK47bWccjo2p+ut1mmoV
         ZnI1ikjuWExkmTJaNvYB1IoNh5/4nWcZOJ74WF3WBRlPcpuGhLz7E+IhYGlka1LwHsbm
         si1Rur4/NpI9Nfj0fz4mW3xmbA73Ldo/b+zDd1/qXJP6TUXI1NuHGD+ewp1aRFaYtppm
         E1YQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5A+3OaTpMtKnc8Ky8UErmxNBTVeb+z8tiHARhiimZ0sOLmHPtkgw6vesbsz4WEH+8L9ODsPC8AvKnNjZK@vger.kernel.org, AJvYcCVS7CyNhHayJbo9bLINPU2dWOtsSoDUFzkC7YvPGNN5L1LTRe70Fnvw58Uoc04YMOBSA+nZOu1yd7so/A==@vger.kernel.org, AJvYcCWLlLOe46sTYvsOnd+qFNkeRvSU+YGj+R3whHBaOgM3kiOV5rpcHJaxKR36gO7WjcC8jqmVc3c5zU2Uww==@vger.kernel.org, AJvYcCXUeZwUBBkt9DeCdNFYWKqTbSonzf+hotjITHzsFKt1BsRUqtRymUUqOSmKY965KFXPzGcEZabAxGEn@vger.kernel.org
X-Gm-Message-State: AOJu0Ywaue5Ip2OplJwtt3RxPRBxwtJqLxyS5xG13Uhn8XDRccaeCr5q
	ymlKw9Fji37oxD0pOVaN9a+w2EgHUVZxs+Iw3mIt7zTZ9NEiFkc8
X-Gm-Gg: ASbGncsUVAjsa4NGU7jmG5RU3YptfdwaStrJ76AoDU1I2AVQT67nPQ0nu02YAKoQ5bf
	QX3siOxbOJAfU/M2oyBFsF3X1x0PVVjKxIhSBwPbNjdwJIHYMhu9++eXjdl3/490BQFyigwNAhw
	8q1ylVPSsjmV5e4LwDQizog/QANdcGNgoMpZBp/owoeIRq3y9LeXL+L/EMvWp3TcI8v3rtGg9dT
	3GpUz0W7vS/BBTeZHAP1z++F3CvWf7NK27ynbRdJdsaQKVzcHL5JXd3B3IUbSUEGb+xgszejzz5
	ZNL0P4k6dxSZj14H
X-Google-Smtp-Source: AGHT+IGkL3jPbvjdhubhnPrx7plRciIWdKWwe/aVSvkhwLSqdnGfEPza49vkT/ZGzqXc7B6I0kxqLQ==
X-Received: by 2002:a05:6512:3186:b0:545:f9c:a80f with SMTP id 2adb3069b0e04-54838edd978mr4285102e87.1.1740397717800;
        Mon, 24 Feb 2025 03:48:37 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54526338bf9sm3167862e87.85.2025.02.24.03.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 03:48:37 -0800 (PST)
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
Subject: [PATCH v3 2/2] mfd: lm3533: convert to use OF
Date: Mon, 24 Feb 2025 13:48:14 +0200
Message-ID: <20250224114815.146053-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224114815.146053-1-clamor95@gmail.com>
References: <20250224114815.146053-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove platform data and fully relay on OF and device tree
parsing and binding devices.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/iio/light/lm3533-als.c      |  40 ++++---
 drivers/leds/leds-lm3533.c          |  46 +++++---
 drivers/mfd/lm3533-core.c           | 159 ++++++++--------------------
 drivers/video/backlight/lm3533_bl.c |  71 ++++++++++---
 include/linux/mfd/lm3533.h          |  35 +-----
 5 files changed, 164 insertions(+), 187 deletions(-)

diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index 99f0b903018c..cb52965e93c6 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -16,9 +16,12 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/mfd/core.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/units.h>
 
 #include <linux/mfd/lm3533.h>
 
@@ -56,6 +59,9 @@ struct lm3533_als {
 
 	atomic_t zone;
 	struct mutex thresh_mutex;
+
+	unsigned pwm_mode:1;		/* PWM input mode (default analog) */
+	u8 r_select;			/* 1 - 127 (ignored in PWM-mode) */
 };
 
 
@@ -753,18 +759,17 @@ static int lm3533_als_set_resistor(struct lm3533_als *als, u8 val)
 	return 0;
 }
 
-static int lm3533_als_setup(struct lm3533_als *als,
-			    const struct lm3533_als_platform_data *pdata)
+static int lm3533_als_setup(struct lm3533_als *als)
 {
 	int ret;
 
-	ret = lm3533_als_set_input_mode(als, pdata->pwm_mode);
+	ret = lm3533_als_set_input_mode(als, als->pwm_mode);
 	if (ret)
 		return ret;
 
 	/* ALS input is always high impedance in PWM-mode. */
-	if (!pdata->pwm_mode) {
-		ret = lm3533_als_set_resistor(als, pdata->r_select);
+	if (!als->pwm_mode) {
+		ret = lm3533_als_set_resistor(als, als->r_select);
 		if (ret)
 			return ret;
 	}
@@ -828,22 +833,16 @@ static const struct iio_info lm3533_als_info = {
 
 static int lm3533_als_probe(struct platform_device *pdev)
 {
-	const struct lm3533_als_platform_data *pdata;
 	struct lm3533 *lm3533;
 	struct lm3533_als *als;
 	struct iio_dev *indio_dev;
+	u32 val;
 	int ret;
 
 	lm3533 = dev_get_drvdata(pdev->dev.parent);
 	if (!lm3533)
 		return -EINVAL;
 
-	pdata = dev_get_platdata(&pdev->dev);
-	if (!pdata) {
-		dev_err(&pdev->dev, "no platform data\n");
-		return -EINVAL;
-	}
-
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*als));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -864,13 +863,21 @@ static int lm3533_als_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, indio_dev);
 
+	val = 200 * KILO; /* 200kOhm */
+	device_property_read_u32(&pdev->dev, "ti,resistor-value-ohm", &val);
+
+	/* Convert resitance into R_ALS value with 2v / 10uA * R */
+	als->r_select = DIV_ROUND_UP(2 * MICRO, 10 * val);
+
+	als->pwm_mode = device_property_read_bool(&pdev->dev, "ti,pwm-mode");
+
 	if (als->irq) {
 		ret = lm3533_als_setup_irq(als, indio_dev);
 		if (ret)
 			return ret;
 	}
 
-	ret = lm3533_als_setup(als, pdata);
+	ret = lm3533_als_setup(als);
 	if (ret)
 		goto err_free_irq;
 
@@ -907,9 +914,16 @@ static void lm3533_als_remove(struct platform_device *pdev)
 		free_irq(als->irq, indio_dev);
 }
 
+static const struct of_device_id lm3533_als_match_table[] = {
+	{ .compatible = "ti,lm3533-als" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, lm3533_als_match_table);
+
 static struct platform_driver lm3533_als_driver = {
 	.driver	= {
 		.name	= "lm3533-als",
+		.of_match_table = lm3533_als_match_table,
 	},
 	.probe		= lm3533_als_probe,
 	.remove		= lm3533_als_remove,
diff --git a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm3533.c
index 45795f2a1042..6e661a2a540f 100644
--- a/drivers/leds/leds-lm3533.c
+++ b/drivers/leds/leds-lm3533.c
@@ -10,8 +10,10 @@
 #include <linux/module.h>
 #include <linux/leds.h>
 #include <linux/mfd/core.h>
+#include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 
 #include <linux/mfd/lm3533.h>
@@ -48,6 +50,9 @@ struct lm3533_led {
 
 	struct mutex mutex;
 	unsigned long flags;
+
+	u16 max_current;		/* 5000 - 29800 uA (800 uA step) */
+	u8 pwm;				/* 0 - 0x3f */
 };
 
 
@@ -632,23 +637,22 @@ static const struct attribute_group *lm3533_led_attribute_groups[] = {
 	NULL
 };
 
-static int lm3533_led_setup(struct lm3533_led *led,
-					struct lm3533_led_platform_data *pdata)
+static int lm3533_led_setup(struct lm3533_led *led)
 {
 	int ret;
 
-	ret = lm3533_ctrlbank_set_max_current(&led->cb, pdata->max_current);
+	ret = lm3533_ctrlbank_set_max_current(&led->cb, led->max_current);
 	if (ret)
 		return ret;
 
-	return lm3533_ctrlbank_set_pwm(&led->cb, pdata->pwm);
+	return lm3533_ctrlbank_set_pwm(&led->cb, led->pwm);
 }
 
 static int lm3533_led_probe(struct platform_device *pdev)
 {
 	struct lm3533 *lm3533;
-	struct lm3533_led_platform_data *pdata;
 	struct lm3533_led *led;
+	u32 val;
 	int ret;
 
 	dev_dbg(&pdev->dev, "%s\n", __func__);
@@ -657,12 +661,6 @@ static int lm3533_led_probe(struct platform_device *pdev)
 	if (!lm3533)
 		return -EINVAL;
 
-	pdata = dev_get_platdata(&pdev->dev);
-	if (!pdata) {
-		dev_err(&pdev->dev, "no platform data\n");
-		return -EINVAL;
-	}
-
 	if (pdev->id < 0 || pdev->id >= LM3533_LVCTRLBANK_COUNT) {
 		dev_err(&pdev->dev, "illegal LED id %d\n", pdev->id);
 		return -EINVAL;
@@ -673,8 +671,11 @@ static int lm3533_led_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	led->lm3533 = lm3533;
-	led->cdev.name = pdata->name;
-	led->cdev.default_trigger = pdata->default_trigger;
+	led->cdev.name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s-%d",
+					pdev->name, pdev->id);
+	led->cdev.default_trigger = "none";
+	device_property_read_string(&pdev->dev, "linux,default-trigger",
+				    &led->cdev.default_trigger);
 	led->cdev.brightness_set_blocking = lm3533_led_set;
 	led->cdev.brightness_get = lm3533_led_get;
 	led->cdev.blink_set = lm3533_led_blink_set;
@@ -702,7 +703,17 @@ static int lm3533_led_probe(struct platform_device *pdev)
 
 	led->cb.dev = led->cdev.dev;
 
-	ret = lm3533_led_setup(led, pdata);
+	/* 5000 - 29800 uA (800 uA step) */
+	val = 5000;
+	device_property_read_u32(&pdev->dev, "ti,max-current-microamp", &val);
+	led->max_current = val;
+
+	/* 0 - 0x3f */
+	val = 0;
+	device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &val);
+	led->pwm = val;
+
+	ret = lm3533_led_setup(led);
 	if (ret)
 		goto err_deregister;
 
@@ -739,9 +750,16 @@ static void lm3533_led_shutdown(struct platform_device *pdev)
 	lm3533_led_set(&led->cdev, LED_OFF);		/* disable blink */
 }
 
+static const struct of_device_id lm3533_led_match_table[] = {
+	{ .compatible = "ti,lm3533-leds" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, lm3533_led_match_table);
+
 static struct platform_driver lm3533_led_driver = {
 	.driver = {
 		.name = "lm3533-leds",
+		.of_match_table = lm3533_led_match_table,
 	},
 	.probe		= lm3533_led_probe,
 	.remove		= lm3533_led_remove,
diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 0a2409d00b2e..e1b8fe136af9 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -14,10 +14,13 @@
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/mfd/core.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/units.h>
 
 #include <linux/mfd/lm3533.h>
 
@@ -42,41 +45,41 @@
 
 #define LM3533_REG_MAX			0xb2
 
-
-static struct mfd_cell lm3533_als_devs[] = {
+static struct mfd_cell lm3533_child_devices[] = {
 	{
 		.name	= "lm3533-als",
 		.id	= -1,
+		.of_compatible = "ti,lm3533-als",
 	},
-};
-
-static struct mfd_cell lm3533_bl_devs[] = {
 	{
 		.name	= "lm3533-backlight",
 		.id	= 0,
+		.of_compatible = "ti,lm3533-backlight",
 	},
 	{
 		.name	= "lm3533-backlight",
 		.id	= 1,
+		.of_compatible = "ti,lm3533-backlight",
 	},
-};
-
-static struct mfd_cell lm3533_led_devs[] = {
 	{
 		.name	= "lm3533-leds",
 		.id	= 0,
+		.of_compatible = "ti,lm3533-leds",
 	},
 	{
 		.name	= "lm3533-leds",
 		.id	= 1,
+		.of_compatible = "ti,lm3533-leds",
 	},
 	{
 		.name	= "lm3533-leds",
 		.id	= 2,
+		.of_compatible = "ti,lm3533-leds",
 	},
 	{
 		.name	= "lm3533-leds",
 		.id	= 3,
+		.of_compatible = "ti,lm3533-leds",
 	},
 };
 
@@ -376,136 +379,60 @@ static struct attribute_group lm3533_attribute_group = {
 	.attrs		= lm3533_attributes
 };
 
-static int lm3533_device_als_init(struct lm3533 *lm3533)
-{
-	struct lm3533_platform_data *pdata = dev_get_platdata(lm3533->dev);
-	int ret;
-
-	if (!pdata->als)
-		return 0;
-
-	lm3533_als_devs[0].platform_data = pdata->als;
-	lm3533_als_devs[0].pdata_size = sizeof(*pdata->als);
-
-	ret = mfd_add_devices(lm3533->dev, 0, lm3533_als_devs, 1, NULL,
-			      0, NULL);
-	if (ret) {
-		dev_err(lm3533->dev, "failed to add ALS device\n");
-		return ret;
-	}
-
-	lm3533->have_als = 1;
-
-	return 0;
-}
-
-static int lm3533_device_bl_init(struct lm3533 *lm3533)
-{
-	struct lm3533_platform_data *pdata = dev_get_platdata(lm3533->dev);
-	int i;
-	int ret;
-
-	if (!pdata->backlights || pdata->num_backlights == 0)
-		return 0;
-
-	if (pdata->num_backlights > ARRAY_SIZE(lm3533_bl_devs))
-		pdata->num_backlights = ARRAY_SIZE(lm3533_bl_devs);
-
-	for (i = 0; i < pdata->num_backlights; ++i) {
-		lm3533_bl_devs[i].platform_data = &pdata->backlights[i];
-		lm3533_bl_devs[i].pdata_size = sizeof(pdata->backlights[i]);
-	}
-
-	ret = mfd_add_devices(lm3533->dev, 0, lm3533_bl_devs,
-			      pdata->num_backlights, NULL, 0, NULL);
-	if (ret) {
-		dev_err(lm3533->dev, "failed to add backlight devices\n");
-		return ret;
-	}
-
-	lm3533->have_backlights = 1;
-
-	return 0;
-}
-
-static int lm3533_device_led_init(struct lm3533 *lm3533)
-{
-	struct lm3533_platform_data *pdata = dev_get_platdata(lm3533->dev);
-	int i;
-	int ret;
-
-	if (!pdata->leds || pdata->num_leds == 0)
-		return 0;
-
-	if (pdata->num_leds > ARRAY_SIZE(lm3533_led_devs))
-		pdata->num_leds = ARRAY_SIZE(lm3533_led_devs);
-
-	for (i = 0; i < pdata->num_leds; ++i) {
-		lm3533_led_devs[i].platform_data = &pdata->leds[i];
-		lm3533_led_devs[i].pdata_size = sizeof(pdata->leds[i]);
-	}
-
-	ret = mfd_add_devices(lm3533->dev, 0, lm3533_led_devs,
-			      pdata->num_leds, NULL, 0, NULL);
-	if (ret) {
-		dev_err(lm3533->dev, "failed to add LED devices\n");
-		return ret;
-	}
-
-	lm3533->have_leds = 1;
-
-	return 0;
-}
-
-static int lm3533_device_setup(struct lm3533 *lm3533,
-					struct lm3533_platform_data *pdata)
+static int lm3533_device_setup(struct lm3533 *lm3533)
 {
 	int ret;
 
-	ret = lm3533_set_boost_freq(lm3533, pdata->boost_freq);
+	ret = lm3533_set_boost_freq(lm3533, lm3533->boost_freq);
 	if (ret)
 		return ret;
 
-	return lm3533_set_boost_ovp(lm3533, pdata->boost_ovp);
+	return lm3533_set_boost_ovp(lm3533, lm3533->boost_ovp);
 }
 
 static int lm3533_device_init(struct lm3533 *lm3533)
 {
-	struct lm3533_platform_data *pdata = dev_get_platdata(lm3533->dev);
+	u32 val;
 	int ret;
 
-	dev_dbg(lm3533->dev, "%s\n", __func__);
+	lm3533->hwen = devm_gpiod_get(lm3533->dev, "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(lm3533->hwen))
+		return dev_err_probe(lm3533->dev, PTR_ERR(lm3533->hwen),
+				     "failed to request HWEN GPIO\n");
 
-	if (!pdata) {
-		dev_err(lm3533->dev, "no platform data\n");
-		return -EINVAL;
-	}
+	val = 16 * MICRO; /* 16V */
+	device_property_read_u32(lm3533->dev, "ti,boost-ovp-microvolt", &val);
 
-	lm3533->hwen = devm_gpiod_get(lm3533->dev, NULL, GPIOD_OUT_LOW);
-	if (IS_ERR(lm3533->hwen))
-		return dev_err_probe(lm3533->dev, PTR_ERR(lm3533->hwen), "failed to request HWEN GPIO\n");
-	gpiod_set_consumer_name(lm3533->hwen, "lm3533-hwen");
+	/* boost_ovp is defined in microvolts, convert to enum value */
+	lm3533->boost_ovp = val / (8 * MICRO) - 2;
+
+	val = 500 * KILO; /* 500kHz */
+	device_property_read_u32(lm3533->dev, "ti,boost-freq-hz", &val);
+
+	/* boost_freq is defined in Hz, convert to enum value */
+	lm3533->boost_freq = val / (500 * KILO) - 1;
 
 	lm3533_enable(lm3533);
 
-	ret = lm3533_device_setup(lm3533, pdata);
+	ret = lm3533_device_setup(lm3533);
 	if (ret)
 		goto err_disable;
 
-	lm3533_device_als_init(lm3533);
-	lm3533_device_bl_init(lm3533);
-	lm3533_device_led_init(lm3533);
+	ret = devm_mfd_add_devices(lm3533->dev, 0, lm3533_child_devices,
+				   ARRAY_SIZE(lm3533_child_devices), NULL, 0, NULL);
+	if (ret) {
+		dev_err(lm3533->dev, "failed to add MFD devices: %d\n", ret);
+		goto err_disable;
+	}
 
 	ret = sysfs_create_group(&lm3533->dev->kobj, &lm3533_attribute_group);
 	if (ret < 0) {
 		dev_err(lm3533->dev, "failed to create sysfs attributes\n");
-		goto err_unregister;
+		goto err_disable;
 	}
 
 	return 0;
 
-err_unregister:
-	mfd_remove_devices(lm3533->dev);
 err_disable:
 	lm3533_disable(lm3533);
 
@@ -517,8 +444,6 @@ static void lm3533_device_exit(struct lm3533 *lm3533)
 	dev_dbg(lm3533->dev, "%s\n", __func__);
 
 	sysfs_remove_group(&lm3533->dev->kobj, &lm3533_attribute_group);
-
-	mfd_remove_devices(lm3533->dev);
 	lm3533_disable(lm3533);
 }
 
@@ -591,6 +516,9 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
 	lm3533->dev = &i2c->dev;
 	lm3533->irq = i2c->irq;
 
+	i2c->dev.coherent_dma_mask = 0;
+	i2c->dev.dma_mask = &i2c->dev.coherent_dma_mask;
+
 	return lm3533_device_init(lm3533);
 }
 
@@ -603,6 +531,12 @@ static void lm3533_i2c_remove(struct i2c_client *i2c)
 	lm3533_device_exit(lm3533);
 }
 
+static const struct of_device_id lm3533_match_table[] = {
+	{ .compatible = "ti,lm3533" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, lm3533_match_table);
+
 static const struct i2c_device_id lm3533_i2c_ids[] = {
 	{ "lm3533" },
 	{ }
@@ -612,6 +546,7 @@ MODULE_DEVICE_TABLE(i2c, lm3533_i2c_ids);
 static struct i2c_driver lm3533_i2c_driver = {
 	.driver = {
 		   .name = "lm3533",
+		   .of_match_table = lm3533_match_table,
 	},
 	.id_table	= lm3533_i2c_ids,
 	.probe		= lm3533_i2c_probe,
diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index babfd3ceec86..0827a5e98dbb 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -9,7 +9,9 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/backlight.h>
 #include <linux/slab.h>
 
@@ -19,6 +21,7 @@
 #define LM3533_HVCTRLBANK_COUNT		2
 #define LM3533_BL_MAX_BRIGHTNESS	255
 
+#define LM3533_REG_OUTPUT_CONF1		0x10
 #define LM3533_REG_CTRLBANK_AB_BCONF	0x1a
 
 
@@ -27,6 +30,11 @@ struct lm3533_bl {
 	struct lm3533_ctrlbank cb;
 	struct backlight_device *bd;
 	int id;
+
+	u16 max_current;		/* 5000 - 29800 uA (800 uA step) */
+	u8 pwm;				/* 0 - 0x3f */
+	bool linear;
+	bool hvled;
 };
 
 
@@ -246,25 +254,40 @@ static struct attribute_group lm3533_bl_attribute_group = {
 	.attrs		= lm3533_bl_attributes
 };
 
-static int lm3533_bl_setup(struct lm3533_bl *bl,
-					struct lm3533_bl_platform_data *pdata)
+static int lm3533_bl_setup(struct lm3533_bl *bl)
 {
+	int id = lm3533_bl_get_ctrlbank_id(bl);
 	int ret;
 
-	ret = lm3533_ctrlbank_set_max_current(&bl->cb, pdata->max_current);
+	if (bl->linear) {
+		ret = lm3533_update(bl->lm3533, LM3533_REG_CTRLBANK_AB_BCONF,
+				    BIT(2 * id + 1), BIT(2 * id + 1));
+		if (ret)
+			return ret;
+	}
+
+	if (bl->hvled) {
+		ret = lm3533_update(bl->lm3533, LM3533_REG_OUTPUT_CONF1,
+				    id | id << 1, BIT(0) | BIT(1));
+		if (ret)
+			return ret;
+	}
+
+	ret = lm3533_ctrlbank_set_max_current(&bl->cb, bl->max_current);
 	if (ret)
 		return ret;
 
-	return lm3533_ctrlbank_set_pwm(&bl->cb, pdata->pwm);
+	return lm3533_ctrlbank_set_pwm(&bl->cb, bl->pwm);
 }
 
 static int lm3533_bl_probe(struct platform_device *pdev)
 {
 	struct lm3533 *lm3533;
-	struct lm3533_bl_platform_data *pdata;
 	struct lm3533_bl *bl;
 	struct backlight_device *bd;
 	struct backlight_properties props;
+	char *name;
+	u32 val;
 	int ret;
 
 	dev_dbg(&pdev->dev, "%s\n", __func__);
@@ -273,12 +296,6 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 	if (!lm3533)
 		return -EINVAL;
 
-	pdata = dev_get_platdata(&pdev->dev);
-	if (!pdata) {
-		dev_err(&pdev->dev, "no platform data\n");
-		return -EINVAL;
-	}
-
 	if (pdev->id < 0 || pdev->id >= LM3533_HVCTRLBANK_COUNT) {
 		dev_err(&pdev->dev, "illegal backlight id %d\n", pdev->id);
 		return -EINVAL;
@@ -295,13 +312,15 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 	bl->cb.id = lm3533_bl_get_ctrlbank_id(bl);
 	bl->cb.dev = NULL;			/* until registered */
 
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s-%d", pdev->name, pdev->id);
+
 	memset(&props, 0, sizeof(props));
 	props.type = BACKLIGHT_RAW;
 	props.max_brightness = LM3533_BL_MAX_BRIGHTNESS;
-	props.brightness = pdata->default_brightness;
-	bd = devm_backlight_device_register(&pdev->dev, pdata->name,
-					pdev->dev.parent, bl, &lm3533_bl_ops,
-					&props);
+	props.brightness = LM3533_BL_MAX_BRIGHTNESS;
+	device_property_read_u32(&pdev->dev, "default-brightness", &props.brightness);
+	bd = devm_backlight_device_register(&pdev->dev, name, pdev->dev.parent,
+					    bl, &lm3533_bl_ops, &props);
 	if (IS_ERR(bd)) {
 		dev_err(&pdev->dev, "failed to register backlight device\n");
 		return PTR_ERR(bd);
@@ -320,7 +339,20 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 
 	backlight_update_status(bd);
 
-	ret = lm3533_bl_setup(bl, pdata);
+	/* 5000 - 29800 uA (800 uA step) */
+	val = 5000;
+	device_property_read_u32(&pdev->dev, "ti,max-current-microamp", &val);
+	bl->max_current = val;
+
+	/* 0 - 0x3f */
+	val = 0;
+	device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &val);
+	bl->pwm = val;
+
+	bl->linear = device_property_read_bool(&pdev->dev, "ti,linear-mapping-mode");
+	bl->hvled = device_property_read_bool(&pdev->dev, "ti,hardware-controlled");
+
+	ret = lm3533_bl_setup(bl);
 	if (ret)
 		goto err_sysfs_remove;
 
@@ -381,10 +413,17 @@ static void lm3533_bl_shutdown(struct platform_device *pdev)
 	lm3533_ctrlbank_disable(&bl->cb);
 }
 
+static const struct of_device_id lm3533_bl_match_table[] = {
+	{ .compatible = "ti,lm3533-backlight" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, lm3533_bl_match_table);
+
 static struct platform_driver lm3533_bl_driver = {
 	.driver = {
 		.name	= "lm3533-backlight",
 		.pm	= &lm3533_bl_pm_ops,
+		.of_match_table = lm3533_bl_match_table,
 	},
 	.probe		= lm3533_bl_probe,
 	.remove		= lm3533_bl_remove,
diff --git a/include/linux/mfd/lm3533.h b/include/linux/mfd/lm3533.h
index 69059a7a2ce5..3b28fc0970f6 100644
--- a/include/linux/mfd/lm3533.h
+++ b/include/linux/mfd/lm3533.h
@@ -27,6 +27,9 @@ struct lm3533 {
 	struct gpio_desc *hwen;
 	int irq;
 
+	u32 boost_ovp;
+	u32 boost_freq;
+
 	unsigned have_als:1;
 	unsigned have_backlights:1;
 	unsigned have_leds:1;
@@ -38,25 +41,6 @@ struct lm3533_ctrlbank {
 	int id;
 };
 
-struct lm3533_als_platform_data {
-	unsigned pwm_mode:1;		/* PWM input mode (default analog) */
-	u8 r_select;			/* 1 - 127 (ignored in PWM-mode) */
-};
-
-struct lm3533_bl_platform_data {
-	char *name;
-	u16 max_current;		/* 5000 - 29800 uA (800 uA step) */
-	u8 default_brightness;		/* 0 - 255 */
-	u8 pwm;				/* 0 - 0x3f */
-};
-
-struct lm3533_led_platform_data {
-	char *name;
-	const char *default_trigger;
-	u16 max_current;		/* 5000 - 29800 uA (800 uA step) */
-	u8 pwm;				/* 0 - 0x3f */
-};
-
 enum lm3533_boost_freq {
 	LM3533_BOOST_FREQ_500KHZ,
 	LM3533_BOOST_FREQ_1000KHZ,
@@ -69,19 +53,6 @@ enum lm3533_boost_ovp {
 	LM3533_BOOST_OVP_40V,
 };
 
-struct lm3533_platform_data {
-	enum lm3533_boost_ovp boost_ovp;
-	enum lm3533_boost_freq boost_freq;
-
-	struct lm3533_als_platform_data *als;
-
-	struct lm3533_bl_platform_data *backlights;
-	int num_backlights;
-
-	struct lm3533_led_platform_data *leds;
-	int num_leds;
-};
-
 extern int lm3533_ctrlbank_enable(struct lm3533_ctrlbank *cb);
 extern int lm3533_ctrlbank_disable(struct lm3533_ctrlbank *cb);
 
-- 
2.43.0


