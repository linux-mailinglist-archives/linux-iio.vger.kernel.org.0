Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E1C576067
	for <lists+linux-iio@lfdr.de>; Fri, 15 Jul 2022 13:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbiGOL3J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Jul 2022 07:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbiGOL2k (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jul 2022 07:28:40 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E037C89E89;
        Fri, 15 Jul 2022 04:27:43 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id b133so636393pfb.6;
        Fri, 15 Jul 2022 04:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CP+vaJpVQjG+FSy8YpXt902GbJyD5d2vCEqArJODpX8=;
        b=I3orQZU8wezre3N/4NneP6D5O9AhmuA+6TzikynF607lL/3JfeTO5pKrreTG03hg7y
         KHLAqbfKAuIn4MSX6b7BpFqvLGAVwl+d4QrCEVZdwFyPRRfmqzWsgbzMSQ1WN+4xAlPM
         5h9jMXCvt7hvhV8n395qsNDnvOObDNKBoTJ64IYWg5lOzXQ3OxfGKyCnadwlK6IzHkku
         ZNif6hAmiLzHYcV2Nqvo7xrtQRW5rJr1eLAXagwXpI5WEa0/0UYiVcCVnbcKTXaHlb6j
         Yk25+nLumVIMMeK7V09fLTT9dsYI1aWZBSlADkAVW8NsoFWnkjvpQWBCe0lvsFaFOXl6
         +5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CP+vaJpVQjG+FSy8YpXt902GbJyD5d2vCEqArJODpX8=;
        b=EXA4So5QUGlHYDnA0yMej/durgfcvw0jMQSm8+QwYA5kvz6CpnnZirXGgvkADEYeWS
         32JjPIfjlhd0PQK7iZPsBGAraobFT+4ulMCi75q78gKwwhHmGrrwTbYdxBMEzDd/hhg/
         TtWLZ1qQ+SqCioJsqMWwnAXJzb+Mu/jdfO6DPTrxOCi66oYnTUdb0cEzYhr3zljbH838
         BJUXKCsjOliWEhyzzwn7GeSESf54eN5sT9Lz3yV8wfIXQWPsIAplNUlicdfNyZhhaJEx
         mHxY87//zoueZOg5YnzLZa4tEOvkBykT5gASovCXd/8KgH53N6llyQOpFhpWPXrgunpm
         2pZA==
X-Gm-Message-State: AJIora8aHYwGhdIr4Dr9TYAR3JqjLhfXVJvb6lnkTVLcctFsZ2gSTxvH
        fg0qpWOuD1CRKMz6eASMbRw=
X-Google-Smtp-Source: AGRyM1sxTZ1zZxGwFhvOExqgUPUa8bzLV8nDTIvSlsJ3ycJrXGo/wiFZhKvnMO5xoA5Cxy8XSFzdxw==
X-Received: by 2002:a63:1921:0:b0:412:407f:f012 with SMTP id z33-20020a631921000000b00412407ff012mr11446266pgl.125.1657884458423;
        Fri, 15 Jul 2022 04:27:38 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-72-159-86.emome-ip.hinet.net. [42.72.159.86])
        by smtp.gmail.com with ESMTPSA id a5-20020aa78e85000000b00525b61f4792sm3550604pfr.109.2022.07.15.04.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 04:27:38 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com
Subject: [PATCH v5 13/13] video: backlight: mt6370: Add MediaTek MT6370 support
Date:   Fri, 15 Jul 2022 19:26:07 +0800
Message-Id: <20220715112607.591-14-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715112607.591-1-peterwu.pub@gmail.com>
References: <20220715112607.591-1-peterwu.pub@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: ChiaEn Wu <chiaen_wu@richtek.com>

MediaTek MT6370 is a SubPMIC consisting of a single cell battery charger
with ADC monitoring, RGB LEDs, dual channel flashlight, WLED backlight
driver, display bias voltage supply, one general purpose LDO, and the
USB Type-C & PD controller complies with the latest USB Type-C and PD
standards.

This adds support for MediaTek MT6370 Backlight driver. It's commonly used
to drive the display WLED. There are 4 channels inside, and each channel
supports up to 30mA of current capability with 2048 current steps in
exponential or linear mapping curves.

Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---

v5
- Add missed <mod_devicetable.h>
- Add struct device *dev in probe() to make code cleaning
- Remove useless including header file <gpio/driver.h>, <of.h>
- Remove useless variable uasage in mt6370_init_backlight_properties()
- Remove redundant checking enable_gpio in mt6370_bl_update_status()
- Remove redundant parentheses in mt6370_bl_get_brightness()
- Revise the description of Kconfig help text
- Revise the calculation of hys_th_steps
---
 drivers/video/backlight/Kconfig            |  12 +
 drivers/video/backlight/Makefile           |   1 +
 drivers/video/backlight/mt6370-backlight.c | 339 +++++++++++++++++++++++++++++
 3 files changed, 352 insertions(+)
 create mode 100644 drivers/video/backlight/mt6370-backlight.c

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index a003e02..846dbe7 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -268,6 +268,18 @@ config BACKLIGHT_MAX8925
 	  If you have a LCD backlight connected to the WLED output of MAX8925
 	  WLED output, say Y here to enable this driver.
 
+config BACKLIGHT_MT6370
+	tristate "MediaTek MT6370 Backlight Driver"
+	depends on MFD_MT6370
+	help
+	  This enables support for Mediatek MT6370 Backlight driver.
+	  It's commonly used to drive the display WLED. There are 4 channels
+	  inside, and each channel supports up to 30mA of current capability
+	  with 2048 current steps in exponential or linear mapping curves.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called "mt6370-backlight".
+
 config BACKLIGHT_APPLE
 	tristate "Apple Backlight Driver"
 	depends on X86 && ACPI
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index cae2c83..e815f3f 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_BACKLIGHT_LP855X)		+= lp855x_bl.o
 obj-$(CONFIG_BACKLIGHT_LP8788)		+= lp8788_bl.o
 obj-$(CONFIG_BACKLIGHT_LV5207LP)	+= lv5207lp.o
 obj-$(CONFIG_BACKLIGHT_MAX8925)		+= max8925_bl.o
+obj-$(CONFIG_BACKLIGHT_MT6370)		+= mt6370-backlight.o
 obj-$(CONFIG_BACKLIGHT_OMAP1)		+= omap1_bl.o
 obj-$(CONFIG_BACKLIGHT_PANDORA)		+= pandora_bl.o
 obj-$(CONFIG_BACKLIGHT_PCF50633)	+= pcf50633-backlight.o
diff --git a/drivers/video/backlight/mt6370-backlight.c b/drivers/video/backlight/mt6370-backlight.c
new file mode 100644
index 0000000..ba00a8f
--- /dev/null
+++ b/drivers/video/backlight/mt6370-backlight.c
@@ -0,0 +1,339 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Richtek Technology Corp.
+ *
+ * Author: ChiaEn Wu <chiaen_wu@richtek.com>
+ */
+
+#include <linux/backlight.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/minmax.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define MT6370_REG_DEV_INFO		0x100
+#define MT6370_REG_BL_EN		0x1A0
+#define MT6370_REG_BL_BSTCTRL		0x1A1
+#define MT6370_REG_BL_PWM		0x1A2
+#define MT6370_REG_BL_DIM2		0x1A4
+
+#define MT6370_VENID_MASK		GENMASK(7, 4)
+#define MT6370_BL_EXT_EN_MASK		BIT(7)
+#define MT6370_BL_EN_MASK		BIT(6)
+#define MT6370_BL_CONFIG_MASK		BIT(0)
+#define MT6370_BL_CH_MASK		GENMASK(5, 2)
+#define MT6370_BL_DIM2_MASK		GENMASK(2, 0)
+#define MT6370_BL_DUMMY_6372_MASK	GENMASK(2, 0)
+#define MT6370_BL_DIM2_6372_SHIFT	3
+#define MT6370_BL_PWM_EN_MASK		BIT(7)
+#define MT6370_BL_PWM_HYS_EN_MASK	BIT(2)
+#define MT6370_BL_PWM_HYS_SEL_MASK	GENMASK(1, 0)
+#define MT6370_BL_OVP_EN_MASK		BIT(7)
+#define MT6370_BL_OVP_SEL_MASK		GENMASK(6, 5)
+#define MT6370_BL_OC_EN_MASK		BIT(3)
+#define MT6370_BL_OC_SEL_MASK		GENMASK(2, 1)
+
+#define MT6370_BL_PWM_HYS_TH_MIN_STEP	1
+#define MT6370_BL_PWM_HYS_TH_MAX_STEP	64
+#define MT6370_BL_OVP_MIN_UV		17000000
+#define MT6370_BL_OVP_MAX_UV		29000000
+#define MT6370_BL_OVP_STEP_UV		4000000
+#define MT6370_BL_OCP_MIN_UA		900000
+#define MT6370_BL_OCP_MAX_UA		1800000
+#define MT6370_BL_OCP_STEP_UA		300000
+#define MT6370_BL_MAX_BRIGHTNESS	2048
+#define MT6370_BL_MAX_CH		15
+
+enum {
+	MT6370_VID_COMMON = 0,
+	MT6370_VID_6372,
+};
+
+struct mt6370_priv {
+	int vid_type;
+	struct backlight_device *bl;
+	struct device *dev;
+	struct gpio_desc *enable_gpio;
+	struct regmap *regmap;
+};
+
+static int mt6370_bl_update_status(struct backlight_device *bl_dev)
+{
+	struct mt6370_priv *priv = bl_get_data(bl_dev);
+	int brightness = backlight_get_brightness(bl_dev);
+	unsigned int enable_val;
+	u8 brightness_val[2];
+	int ret;
+
+	if (brightness) {
+		brightness_val[0] = (brightness - 1) & MT6370_BL_DIM2_MASK;
+		brightness_val[1] = (brightness - 1) >> fls(MT6370_BL_DIM2_MASK);
+
+		/*
+		 * To make MT6372 using 14 bits to control the brightness
+		 * backward compatible with 11 bits brightness control
+		 * (like MT6370 and MT6371 do), we left shift the value
+		 * and pad with 1 to remaining bits. Hence, the MT6372's
+		 * backlight brightness will be almost the same as MT6370's
+		 * and MT6371's.
+		 */
+		if (priv->vid_type == MT6370_VID_6372) {
+			brightness_val[0] <<= MT6370_BL_DIM2_6372_SHIFT;
+			brightness_val[0] |= MT6370_BL_DUMMY_6372_MASK;
+		}
+
+		ret = regmap_raw_write(priv->regmap, MT6370_REG_BL_DIM2,
+				       brightness_val, sizeof(brightness_val));
+		if (ret)
+			return ret;
+	}
+
+	gpiod_set_value(priv->enable_gpio, brightness ? 1 : 0);
+
+	enable_val = brightness ? MT6370_BL_EN_MASK : 0;
+	return regmap_update_bits(priv->regmap, MT6370_REG_BL_EN,
+				  MT6370_BL_EN_MASK, enable_val);
+}
+
+static int mt6370_bl_get_brightness(struct backlight_device *bl_dev)
+{
+	struct mt6370_priv *priv = bl_get_data(bl_dev);
+	unsigned int enable;
+	u8 brightness_val[2];
+	int brightness, ret;
+
+	ret = regmap_read(priv->regmap, MT6370_REG_BL_EN, &enable);
+	if (ret)
+		return ret;
+
+	if (!(enable & MT6370_BL_EN_MASK))
+		return 0;
+
+	ret = regmap_raw_read(priv->regmap, MT6370_REG_BL_DIM2,
+			      brightness_val, sizeof(brightness_val));
+	if (ret)
+		return ret;
+
+	if (priv->vid_type == MT6370_VID_6372)
+		brightness_val[0] >>= MT6370_BL_DIM2_6372_SHIFT;
+
+	brightness = brightness_val[1] << fls(MT6370_BL_DIM2_MASK);
+	brightness += brightness_val[0] & MT6370_BL_DIM2_MASK;
+
+	return brightness + 1;
+}
+
+static const struct backlight_ops mt6370_bl_ops = {
+	.options = BL_CORE_SUSPENDRESUME,
+	.update_status = mt6370_bl_update_status,
+	.get_brightness = mt6370_bl_get_brightness,
+};
+
+static int mt6370_init_backlight_properties(struct mt6370_priv *priv,
+					    struct backlight_properties *props)
+{
+	struct device *dev = priv->dev;
+	u8 prop_val;
+	u32 brightness, ovp_uV, ocp_uA;
+	unsigned int mask, val;
+	int ret;
+
+	/* Vendor optional properties */
+	val = 0;
+	if (device_property_read_bool(dev, "mediatek,bled-pwm-enable"))
+		val |= MT6370_BL_PWM_EN_MASK;
+
+	if (device_property_read_bool(dev, "mediatek,bled-pwm-hys-enable"))
+		val |= MT6370_BL_PWM_HYS_EN_MASK;
+
+	ret = device_property_read_u8(dev,
+				      "mediatek,bled-pwm-hys-input-th-steps",
+				      &prop_val);
+	if (!ret) {
+		prop_val = clamp_val(prop_val,
+				     MT6370_BL_PWM_HYS_TH_MIN_STEP,
+				     MT6370_BL_PWM_HYS_TH_MAX_STEP);
+		prop_val = prop_val <= 1 ? 0 :
+			   prop_val <= 4 ? 1 :
+			   prop_val <= 16 ? 2 : 3;
+		val |= prop_val << (ffs(MT6370_BL_PWM_HYS_SEL_MASK) - 1);
+	}
+
+	ret = regmap_update_bits(priv->regmap, MT6370_REG_BL_PWM,
+				 val, val);
+	if (ret)
+		return ret;
+
+	val = 0;
+	if (device_property_read_bool(dev, "mediatek,bled-ovp-shutdown"))
+		val |= MT6370_BL_OVP_EN_MASK;
+
+	ret = device_property_read_u32(dev, "mediatek,bled-ovp-microvolt",
+				       &ovp_uV);
+	if (!ret) {
+		ovp_uV = clamp_val(ovp_uV, MT6370_BL_OVP_MIN_UV,
+				   MT6370_BL_OVP_MAX_UV);
+		ovp_uV = DIV_ROUND_UP(ovp_uV - MT6370_BL_OVP_MIN_UV,
+				      MT6370_BL_OVP_STEP_UV);
+		val |= ovp_uV << (ffs(MT6370_BL_OVP_SEL_MASK) - 1);
+	}
+
+	if (device_property_read_bool(dev, "mediatek,bled-ocp-shutdown"))
+		val |= MT6370_BL_OC_EN_MASK;
+
+	ret = device_property_read_u32(dev, "mediatek,bled-ocp-microamp",
+				       &ocp_uA);
+	if (!ret) {
+		ocp_uA = clamp_val(ocp_uA, MT6370_BL_OCP_MIN_UA,
+				   MT6370_BL_OCP_MAX_UA);
+		ocp_uA = DIV_ROUND_UP(ocp_uA - MT6370_BL_OCP_MIN_UA,
+				      MT6370_BL_OCP_STEP_UA);
+		val |= ocp_uA << (ffs(MT6370_BL_OC_SEL_MASK) - 1);
+	}
+
+	ret = regmap_update_bits(priv->regmap, MT6370_REG_BL_BSTCTRL,
+				 val, val);
+	if (ret)
+		return ret;
+
+	/* Common properties */
+	ret = device_property_read_u32(dev, "max-brightness", &brightness);
+	if (ret)
+		brightness = MT6370_BL_MAX_BRIGHTNESS;
+
+	props->max_brightness = min_t(u32, brightness, MT6370_BL_MAX_BRIGHTNESS);
+
+	ret = device_property_read_u32(dev, "default-brightness", &brightness);
+	if (ret)
+		brightness = props->max_brightness;
+
+	props->brightness = min_t(u32, brightness, props->max_brightness);
+
+	ret = device_property_read_u8(dev, "mediatek,bled-channel-use",
+				      &prop_val);
+	if (ret) {
+		dev_err(dev, "mediatek,bled-channel-use DT property missing\n");
+		return ret;
+	}
+
+	if (!prop_val || prop_val > MT6370_BL_MAX_CH) {
+		dev_err(dev,
+			"No channel specified or over than upper bound (%d)\n",
+			prop_val);
+		return -EINVAL;
+	}
+
+	mask = MT6370_BL_EXT_EN_MASK | MT6370_BL_CH_MASK;
+	val = prop_val << (ffs(MT6370_BL_CH_MASK) - 1);
+
+	if (priv->enable_gpio)
+		val |= MT6370_BL_EXT_EN_MASK;
+
+	return regmap_update_bits(priv->regmap, MT6370_REG_BL_EN, mask, val);
+}
+
+static int mt6370_check_vendor_info(struct mt6370_priv *priv)
+{
+	/*
+	 * MT6372 uses 14 bits to control the brightness but MT6370 and MT6371
+	 * use 11 bits. They are different so we have to use this function to
+	 * check the vendor ID and use different methods to calculate the
+	 * brightness.
+	 */
+	unsigned int dev_info, vid;
+	int ret;
+
+	ret = regmap_read(priv->regmap, MT6370_REG_DEV_INFO, &dev_info);
+	if (ret)
+		return ret;
+
+	vid = FIELD_GET(MT6370_VENID_MASK, dev_info);
+	if (vid == 0x9 || vid == 0xb)
+		priv->vid_type = MT6370_VID_6372;
+	else
+		priv->vid_type = MT6370_VID_COMMON;
+
+	return 0;
+}
+
+static int mt6370_bl_probe(struct platform_device *pdev)
+{
+	struct backlight_properties props = {
+		.type = BACKLIGHT_RAW,
+		.scale = BACKLIGHT_SCALE_LINEAR,
+	};
+	struct device *dev = &pdev->dev;
+	struct mt6370_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+
+	priv->regmap = dev_get_regmap(dev->parent, NULL);
+	if (!priv->regmap)
+		return dev_err_probe(dev, -ENODEV, "Failed to get regmap\n");
+
+	ret = mt6370_check_vendor_info(priv);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to check vendor info\n");
+
+	priv->enable_gpio = devm_gpiod_get_optional(dev, "enable",
+						    GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->enable_gpio))
+		dev_err(dev, "Failed to get 'enable' gpio\n");
+
+	ret = mt6370_init_backlight_properties(priv, &props);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to init backlight properties\n");
+
+	priv->bl = devm_backlight_device_register(dev, pdev->name, dev, priv,
+						  &mt6370_bl_ops, &props);
+	if (IS_ERR(priv->bl))
+		return dev_err_probe(dev, PTR_ERR(priv->bl),
+				     "Failed to register backlight\n");
+
+	backlight_update_status(priv->bl);
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+}
+
+static int mt6370_bl_remove(struct platform_device *pdev)
+{
+	struct mt6370_priv *priv = platform_get_drvdata(pdev);
+	struct backlight_device *bl_dev = priv->bl;
+
+	bl_dev->props.brightness = 0;
+	backlight_update_status(priv->bl);
+
+	return 0;
+}
+
+static const struct of_device_id __maybe_unused mt6370_bl_of_match[] = {
+	{ .compatible = "mediatek,mt6370-backlight", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, mt6370_bl_of_match);
+
+static struct platform_driver mt6370_bl_driver = {
+	.driver = {
+		.name = "mt6370-backlight",
+		.of_match_table = mt6370_bl_of_match,
+	},
+	.probe = mt6370_bl_probe,
+	.remove = mt6370_bl_remove,
+};
+module_platform_driver(mt6370_bl_driver);
+
+MODULE_AUTHOR("ChiaEn Wu <chiaen_wu@richtek.com>");
+MODULE_DESCRIPTION("MediaTek MT6370 Backlight Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

