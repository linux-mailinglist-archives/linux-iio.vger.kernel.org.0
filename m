Return-Path: <linux-iio+bounces-8606-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C62799570C6
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 18:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF16281991
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 16:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6EA183CC6;
	Mon, 19 Aug 2024 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PN02+Vkp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C481717BB25;
	Mon, 19 Aug 2024 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086128; cv=none; b=lrGVOidv0SbxUp0ptGvsHOBTPy5EPnJOjHqkRrsStUQ/IbxBkBbul5LXE7urnS0nG42pc7XX9UFjzg9T9KtwF3lekQJbw3YxTns+//0Lq6/vfRMnqKGl06iDRNGHB5STpJnPfGYrVjQjD+SXXags4yb8muAiquTzTlTdQMx+ZEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086128; c=relaxed/simple;
	bh=PXcsBzwFl2GwJIvfGM2Lg71OZ1PddeIewm5S+RRkQ44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gp7txll2V8IK0QGMTyHh4ucsl2o5fmd1AAD2yUiRBqCOY+HRULhCJtkY/WKNkBV1vOue89eGck4JzEbmXbIAh8DE1ze50Gp7gpVi9VnGEKX9jP8Fu3lNSmVBGqm6zn/8E+r4Ex8ltJ5gkmUybPh3/OCEp3IgSF2zaeWhCXG9Gv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PN02+Vkp; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-709428a9469so2938100a34.3;
        Mon, 19 Aug 2024 09:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724086126; x=1724690926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0UhxZ2XxQFgvUjgiU5dDgFB2D6T8k8pYUXnFuEDKNs=;
        b=PN02+Vkpg6LciPGX8b6UTLLe7RRGx+Nl3A46GHKoZ4QIoqi6t8YAU3YyruP3lD3NbQ
         NzhyZNLA5WaGRjjMxPUVzRDBi8bYex/Bk0fnAAGuR1xO67UFitpqIWR0PSco8vCCmwRJ
         kIak6AtIm6IX4BGEXjLNvjZBGkLPmafxCXVgIqrzC9FZBgFHM1a+zOoCnEAXRTRsOS7j
         j0/3wM3BIyYBqAqaCtwn4xK8Nhm2UjF+ZLy8sgCbqeKqqCyFTfZo+qex1KXferBSpVqX
         chVIjY6Bug/I8M+KEgC2hKYPZowJCa8Zk88Iy4Hsu47zEyCK0kXAHaKyunlpvucPETgy
         8ceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086126; x=1724690926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0UhxZ2XxQFgvUjgiU5dDgFB2D6T8k8pYUXnFuEDKNs=;
        b=edzkndXHiC+rWyh1+eSGO2pCX3CyFpAl8t2CA9I4QggiTt6HdxMNTwm91KpPNAF7In
         uU7tL/jSPyUvB+twlUgBqbjcgHnB22rDYSKYRrPQTIqdC5oChadjgi/nH9EsZwtxGjWN
         XlhDaQyYKlkFWFjUjuZA3mBeE5p8mQ52M2Hd/ZjAfaV1y3n9bxypGIyx9uU9gKwb60CA
         eT+2SHR+8TgYAhDOMz705qJnlCjU9VDOZh5lYH3inyWJsZGfH3zcQKHO4Zas/O7U8zw1
         YdNl4DQvxs7jjb58a+af0nKhGCg+1aIt7V5ZvateI+Wvi8yhTahof427JWvomA3c7TTz
         Xn/w==
X-Forwarded-Encrypted: i=1; AJvYcCWDDLkwMJh+iI1YKQogPkLjbb257HNIQzrs3qaxersggBk9Hgw3+Gn5R21JpFwbRoYp3cKrcq32fAA5F+4qTAEE5RycfTxXgwyYWgNHfIT2dQ+8BwITv0G/0LRa1rXyIh8zZK+8gg==
X-Gm-Message-State: AOJu0YxoYxZDcSHzekGaWFztH/eWKFfjZHBOsdWB0sMwD5rzsUUm32hR
	9iFaDR0iLwdLz9wNFH9oWTE24DtdhOfiGO/r3HDia+RKCJtptuHw+ktRhA==
X-Google-Smtp-Source: AGHT+IFKVHyXBq2kvibehw/FWwU6sMR+9rBonmmxLiBPSvlRFOSxmGmsGuw+ct2LJQdqTm9QFHZWEA==
X-Received: by 2002:a05:6830:7107:b0:709:4060:1093 with SMTP id 46e09a7af769-70cac897e6amr15970781a34.22.1724086125773;
        Mon, 19 Aug 2024 09:48:45 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70ca649c61csm2332428a34.26.2024.08.19.09.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:48:45 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-sunxi@lists.linux.dev
Cc: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	quentin.schulz@free-electrons.com,
	mripard@kernel.org,
	tgamblin@baylibre.com,
	aidanmacdonald.0x0@gmail.com,
	u.kleine-koenig@pengutronix.de,
	lee@kernel.org,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	sre@kernel.org,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	jic23@kernel.org,
	jonathan.cameron@huawei.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V3 04/15] power: supply: axp20x_usb_power: Make VBUS and IIO config per device
Date: Mon, 19 Aug 2024 11:46:08 -0500
Message-Id: <20240819164619.556309-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819164619.556309-1-macroalpha82@gmail.com>
References: <20240819164619.556309-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Make reading of the vbus value and configuring of the iio channels
device specific, to allow additional devices (such as the AXP717) to
be supported by this driver.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/power/supply/axp20x_usb_power.c | 87 +++++++++++++++----------
 1 file changed, 54 insertions(+), 33 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index dae7e5cfc54e..cd9e92f2ce71 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -45,6 +45,8 @@
  */
 #define DEBOUNCE_TIME			msecs_to_jiffies(50)
 
+struct axp20x_usb_power;
+
 struct axp_data {
 	const struct power_supply_desc	*power_desc;
 	const char * const		*irq_names;
@@ -58,6 +60,10 @@ struct axp_data {
 	struct reg_field		usb_bc_det_fld;
 	struct reg_field		vbus_disable_bit;
 	bool				vbus_needs_polling: 1;
+	void (*axp20x_read_vbus)(struct work_struct *work);
+	int (*axp20x_cfg_iio_chan)(struct platform_device *pdev,
+				   struct axp20x_usb_power *power);
+	int (*axp20x_cfg_adc_reg)(struct axp20x_usb_power *power);
 };
 
 struct axp20x_usb_power {
@@ -385,6 +391,36 @@ static int axp20x_usb_power_prop_writeable(struct power_supply *psy,
 	       psp == POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT;
 }
 
+static int axp20x_configure_iio_channels(struct platform_device *pdev,
+					 struct axp20x_usb_power *power)
+{
+	power->vbus_v = devm_iio_channel_get(&pdev->dev, "vbus_v");
+	if (IS_ERR(power->vbus_v)) {
+		if (PTR_ERR(power->vbus_v) == -ENODEV)
+			return -EPROBE_DEFER;
+		return PTR_ERR(power->vbus_v);
+	}
+
+	power->vbus_i = devm_iio_channel_get(&pdev->dev, "vbus_i");
+	if (IS_ERR(power->vbus_i)) {
+		if (PTR_ERR(power->vbus_i) == -ENODEV)
+			return -EPROBE_DEFER;
+		return PTR_ERR(power->vbus_i);
+	}
+
+	return 0;
+}
+
+static int axp20x_configure_adc_registers(struct axp20x_usb_power *power)
+{
+	/* Enable vbus voltage and current measurement */
+	return regmap_update_bits(power->regmap, AXP20X_ADC_EN1,
+				  AXP20X_ADC_EN1_VBUS_CURR |
+				  AXP20X_ADC_EN1_VBUS_VOLT,
+				  AXP20X_ADC_EN1_VBUS_CURR |
+				  AXP20X_ADC_EN1_VBUS_VOLT);
+}
+
 static enum power_supply_property axp20x_usb_power_properties[] = {
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_PRESENT,
@@ -505,6 +541,9 @@ static const struct axp_data axp192_data = {
 	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
 	.vbus_valid_bit = REG_FIELD(AXP192_USB_OTG_STATUS, 2, 2),
 	.vbus_mon_bit   = REG_FIELD(AXP20X_VBUS_MON, 3, 3),
+	.axp20x_read_vbus = &axp20x_usb_power_poll_vbus,
+	.axp20x_cfg_iio_chan = axp20x_configure_iio_channels,
+	.axp20x_cfg_adc_reg = axp20x_configure_adc_registers,
 };
 
 static const struct axp_data axp202_data = {
@@ -516,6 +555,9 @@ static const struct axp_data axp202_data = {
 	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
 	.vbus_valid_bit = REG_FIELD(AXP20X_USB_OTG_STATUS, 2, 2),
 	.vbus_mon_bit   = REG_FIELD(AXP20X_VBUS_MON, 3, 3),
+	.axp20x_read_vbus = &axp20x_usb_power_poll_vbus,
+	.axp20x_cfg_iio_chan = axp20x_configure_iio_channels,
+	.axp20x_cfg_adc_reg = axp20x_configure_adc_registers,
 };
 
 static const struct axp_data axp221_data = {
@@ -526,6 +568,9 @@ static const struct axp_data axp221_data = {
 	.curr_lim_table_size = ARRAY_SIZE(axp221_usb_curr_lim_table),
 	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
 	.vbus_needs_polling = true,
+	.axp20x_read_vbus = &axp20x_usb_power_poll_vbus,
+	.axp20x_cfg_iio_chan = axp20x_configure_iio_channels,
+	.axp20x_cfg_adc_reg = axp20x_configure_adc_registers,
 };
 
 static const struct axp_data axp223_data = {
@@ -536,6 +581,9 @@ static const struct axp_data axp223_data = {
 	.curr_lim_table_size = ARRAY_SIZE(axp20x_usb_curr_lim_table),
 	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
 	.vbus_needs_polling = true,
+	.axp20x_read_vbus = &axp20x_usb_power_poll_vbus,
+	.axp20x_cfg_iio_chan = axp20x_configure_iio_channels,
+	.axp20x_cfg_adc_reg = axp20x_configure_adc_registers,
 };
 
 static const struct axp_data axp813_data = {
@@ -549,6 +597,9 @@ static const struct axp_data axp813_data = {
 	.usb_bc_det_fld = REG_FIELD(AXP288_BC_DET_STAT, 5, 7),
 	.vbus_disable_bit = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 7, 7),
 	.vbus_needs_polling = true,
+	.axp20x_read_vbus = &axp20x_usb_power_poll_vbus,
+	.axp20x_cfg_iio_chan = axp20x_configure_iio_channels,
+	.axp20x_cfg_adc_reg = axp20x_configure_adc_registers,
 };
 
 #ifdef CONFIG_PM_SLEEP
@@ -590,36 +641,6 @@ static int axp20x_usb_power_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(axp20x_usb_power_pm_ops, axp20x_usb_power_suspend,
 						  axp20x_usb_power_resume);
 
-static int configure_iio_channels(struct platform_device *pdev,
-				  struct axp20x_usb_power *power)
-{
-	power->vbus_v = devm_iio_channel_get(&pdev->dev, "vbus_v");
-	if (IS_ERR(power->vbus_v)) {
-		if (PTR_ERR(power->vbus_v) == -ENODEV)
-			return -EPROBE_DEFER;
-		return PTR_ERR(power->vbus_v);
-	}
-
-	power->vbus_i = devm_iio_channel_get(&pdev->dev, "vbus_i");
-	if (IS_ERR(power->vbus_i)) {
-		if (PTR_ERR(power->vbus_i) == -ENODEV)
-			return -EPROBE_DEFER;
-		return PTR_ERR(power->vbus_i);
-	}
-
-	return 0;
-}
-
-static int configure_adc_registers(struct axp20x_usb_power *power)
-{
-	/* Enable vbus voltage and current measurement */
-	return regmap_update_bits(power->regmap, AXP20X_ADC_EN1,
-				  AXP20X_ADC_EN1_VBUS_CURR |
-				  AXP20X_ADC_EN1_VBUS_VOLT,
-				  AXP20X_ADC_EN1_VBUS_CURR |
-				  AXP20X_ADC_EN1_VBUS_VOLT);
-}
-
 static int axp20x_regmap_field_alloc_optional(struct device *dev,
 					      struct regmap *regmap,
 					      struct reg_field fdesc,
@@ -707,7 +728,7 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 		return ret;
 
 	ret = devm_delayed_work_autocancel(&pdev->dev, &power->vbus_detect,
-					   axp20x_usb_power_poll_vbus);
+					   axp_data->axp20x_read_vbus);
 	if (ret)
 		return ret;
 
@@ -718,9 +739,9 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 			return ret;
 
 		if (IS_ENABLED(CONFIG_AXP20X_ADC))
-			ret = configure_iio_channels(pdev, power);
+			ret = axp_data->axp20x_cfg_iio_chan(pdev, power);
 		else
-			ret = configure_adc_registers(power);
+			ret = axp_data->axp20x_cfg_adc_reg(power);
 
 		if (ret)
 			return ret;
-- 
2.34.1


