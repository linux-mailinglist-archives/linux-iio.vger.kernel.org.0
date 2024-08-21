Return-Path: <linux-iio+bounces-8668-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6C495A743
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 23:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33BA0B21713
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 21:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4528717C234;
	Wed, 21 Aug 2024 21:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBPsgmeF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACC817BB24;
	Wed, 21 Aug 2024 21:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724277455; cv=none; b=ktu3a/bXhlKhu/x6aD1IJc4GoeWddHsWvJFok2FWRtD3KLcq3kmxjoeZhxAbEFwwjeEmib5NSMKuJYmnEQN7m8tVNdC5RjxxtMjcNb6mrIBnWWaJt78/Wnr3+LFYEhaEmpT7UCIwGtILB5RVGP/yzBkHrPxp7sQdRnu9vFAZmZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724277455; c=relaxed/simple;
	bh=PXcsBzwFl2GwJIvfGM2Lg71OZ1PddeIewm5S+RRkQ44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aZf5u95iza5Cni7P5/JLix5GIsB4dw5tBqk/AO+ph5inmwyyVH4mFPAUyqq/l4INRxV/Z2Rda2MdsolVe3KJ1GV9K3Z1Bdro2xCqQmFumWMsu30HTnwhO6hiii2xtzLpTe5HbeW3CfJpkwqztJZYTiXACxyUtTfsvArSyulLGCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBPsgmeF; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3db157d3bb9so79385b6e.2;
        Wed, 21 Aug 2024 14:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724277452; x=1724882252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0UhxZ2XxQFgvUjgiU5dDgFB2D6T8k8pYUXnFuEDKNs=;
        b=cBPsgmeFpxJEQJ/KbVuNjMgNRdw4qmhPueEQJ6UpLiPAzSxvCj5q+sRfcZOx38zW2I
         z+Nk/WW+YVstafnQvvQx+1/h220wA8mI4zuDssH1BVdAlMErtvTAcPgMZD8iv3BLbyPe
         CdS99P/sL3tZDJ+KEP9TOZTC5nghpXqNz1kuPmcffKhWMd/QfcgywGJB8umYyYHNi48r
         Uuu5Zx/WTFjw+UZjgHpXRtEWSYHOosq+9i6QA8UNzHppUmnLfJNu1lNbwCzHk6OEZ/Zx
         jMd1NDQYMLPiYemCIBC6b5frCjgVrjxfJ5xFQKpu77TV80zVzJpvyXUeMN1Wl+FDzs9H
         1y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724277452; x=1724882252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0UhxZ2XxQFgvUjgiU5dDgFB2D6T8k8pYUXnFuEDKNs=;
        b=VvEF39rOhTrchfntTxaofzi4RzuWHdD4BdH6CKimLeAdUZHsK01a//h91T/t5s+4W9
         BTN2CL4ATXZ3MsvzYrzMfjqOufs6UGVyH4pS4KNTZdRrFIMrnQxzi76KeE9jDCfFU//H
         YjFQ6miEaMBiF+Gq2PpGLYTX1W0MbazPKwb3+MlgiZ7G9GMJHsWOFSb+oUgzbiicboUL
         TRvBtBluFxehsHL6WxQa3RgmOzx1BD3gibqlHOhSwlvf21daPsoF8/RvFtKz7fRUH2br
         GySW6rVxGIZyInggBFkEhA5KHjdzPZQhl+C+iKmyxptsdifaAAnTr/3SIul8CFV7tpYQ
         EYog==
X-Forwarded-Encrypted: i=1; AJvYcCU1ZHtI0zN7/WxQWzQSDlZHETbiQsVJVA0HT8q0ZC+I5hQy7Llkl2hCXQaB+hcH1jCPtiSf/YM8VVJ+@vger.kernel.org, AJvYcCVE90Rr4vuyRZk11hKLzbP0HxfafLbBfL5ETSu5iiRaj0vO14EYcO5W7M4Gh/JircKUz3WWnwNwBhLW@vger.kernel.org
X-Gm-Message-State: AOJu0YxwMNVl0SLiTcpCbKAWXpnIBbSOdc0v0C8vXdVkH4MXqTKAcX+t
	wZ+NeFHHs7Otzd5Xbcl+HdxQXMYBkERrf/YFWkeaAhlJsvKiznrZ
X-Google-Smtp-Source: AGHT+IG0XI2TE/eI97M843RE/qlc7osFS8BEftni9pYq41Isvj2l2mBUFv5vVdUHIaSBnu9JP0w/Sw==
X-Received: by 2002:a05:6808:1142:b0:3db:1661:4d64 with SMTP id 5614622812f47-3de194f34a2mr4379695b6e.13.1724277452201;
        Wed, 21 Aug 2024 14:57:32 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:81a9:2325:e0f7:7376])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de225555b6sm47070b6e.17.2024.08.21.14.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:57:31 -0700 (PDT)
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
Subject: [PATCH V4 04/15] power: supply: axp20x_usb_power: Make VBUS and IIO config per device
Date: Wed, 21 Aug 2024 16:54:45 -0500
Message-Id: <20240821215456.962564-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821215456.962564-1-macroalpha82@gmail.com>
References: <20240821215456.962564-1-macroalpha82@gmail.com>
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


