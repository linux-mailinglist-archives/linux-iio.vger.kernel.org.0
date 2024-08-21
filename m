Return-Path: <linux-iio+bounces-8667-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1000995A740
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 23:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34FEC1C22B20
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 21:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D59917C215;
	Wed, 21 Aug 2024 21:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8aD3Mqd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E4717BB16;
	Wed, 21 Aug 2024 21:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724277454; cv=none; b=mczs0wR1kRG7eyTTlWtQ9UOjhPROh6tCy9BPbC0WQ7FpKQypISTl5obe/nBofa877q5KiGTEU44mf1WU7xlENhAf/SlSXoy8Yp3akV5u111xMzPWj/jYQ+sIuTVnjDm2bgvrd+YXLSnvnjcssECilydaHOU48ffXP2IJHkrLfDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724277454; c=relaxed/simple;
	bh=7oiVFaUcI0C5oMqqUaovkqLRY8Weg4Zg7WG/UFywWlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W3x7Sy1fFweNp+YYKSft/UdHZhTnR0/M5KzHTm4npOMmIGOll06I4GDL+TSvfX+sESfqaNgi7hESbzgH27r9z/4A+lyU4eYKLlRx6SAwxHQwCm8oR71LRHLgQs5l1YCfKdsn2MsMH3zYy3RLuQjK7i+ZnUke5ZI1XiUcZG/4ryc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8aD3Mqd; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3db157cb959so90953b6e.0;
        Wed, 21 Aug 2024 14:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724277451; x=1724882251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6uKad2/4G0gY3Nm8pi2ZP0lDyan1DAsdC6ygDIyfJY=;
        b=G8aD3MqdpOhhpwEnqw5g4ukMXdVjCJvg7HWsPJnkQOymInhw9DZjcvWfKTv8J8nMMt
         8GTKLLDgmrxQabLC50WLtM0izBm5rakWJdJTtd+QIQgmiwKkYo20ro1JaRvkJilYHFmi
         cYvg9w3QhI4PotEu+SC/H2IdxryclpiZTHLVEpuG3PBckedGgLUAFjinwzNdbY565alR
         5B8g2wsQkHgygSRr+Uxl0x0G4aC/h/g7QGJBxAJvj6OTj5+IDajAZNcDfxyedIWc1CJH
         rupb8EPTZGGZ19dvtLBU5/ffTbnGxxN6LWOxUh0bKRkNGA2tyEwJuqnFpnWLR43Sa/Yx
         JspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724277451; x=1724882251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6uKad2/4G0gY3Nm8pi2ZP0lDyan1DAsdC6ygDIyfJY=;
        b=QD7WEHmG+GZMs59eQKZrWII1LkraF2jGzyl8aQx2VxzT+2uWw9JatyDgs2Ny0TrZ2H
         MXEmna9coIWUgl5TORoJJ0JMD753IeIYoxJaD8Oaf0I/naqTCjeQFmr3UBhaIZRHERpH
         hmgIR1Ow0rC+MxeZyWN5m2P+6xOMl7ayA58xODXrwdkRCszqxNf9fW7vd2LS5csa2dSp
         1uqvvubYopwt25pBBnVI/qyWyzw//1N8LofciVKg6R6rjqph3PPeV7Ho2erpzVo+OW98
         nLUDmogpqo5K3sJY34ZAO/x9I4z+O/Y7JnHI/nk41+D2rydn5kVgli/4Qtwxxeln645T
         gVvw==
X-Forwarded-Encrypted: i=1; AJvYcCWlIM4sPQkf9BEgWv87UF+Wo/3TRjGW1tQp5Z4S+jb5F7HJVyIRXIis+M242qooY5e4laG+6vKhzvz4@vger.kernel.org, AJvYcCWwbAUwLqWqeCNpNzmoTLcQVh/wg0/0KyZFAlqvO5BPM5qAPy1ppauwnIVTlT6SE6EwpDGyCPZ30Klg@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9/qRaRPn0td2jrYTX+OXuhdVFvyzko5x+L2WuDMd+LzAhx1Yl
	56gsAp3uqoeqaCU50eTYv6E/Pbpbjvo9GKl18KLbbgnUc3CUc0dB
X-Google-Smtp-Source: AGHT+IEFFJbziMrJiWeCFL1hwf2ttRLRClqnubICMWhVvCR17fO+nze7N86057SdvUBo7gsUsXy5LA==
X-Received: by 2002:a05:6808:1910:b0:3d9:2b5a:4ac6 with SMTP id 5614622812f47-3de194eb972mr5016464b6e.6.1724277451289;
        Wed, 21 Aug 2024 14:57:31 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:81a9:2325:e0f7:7376])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de225555b6sm47070b6e.17.2024.08.21.14.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:57:30 -0700 (PDT)
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
Subject: [PATCH V4 03/15] power: supply: axp20x_battery: Make iio and battery config per device
Date: Wed, 21 Aug 2024 16:54:44 -0500
Message-Id: <20240821215456.962564-4-macroalpha82@gmail.com>
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

Move the configuration of battery specific information and available
iio channels from the probe function to a device specific routine,
allowing us to use this driver for devices with slightly different
configurations (such as the AXP717).

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/power/supply/axp20x_battery.c | 137 +++++++++++++++++---------
 1 file changed, 88 insertions(+), 49 deletions(-)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index 7520b599eb3d..c903c588b361 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -58,11 +58,19 @@
 struct axp20x_batt_ps;
 
 struct axp_data {
-	int	ccc_scale;
-	int	ccc_offset;
-	bool	has_fg_valid;
+	int		ccc_scale;
+	int		ccc_offset;
+	unsigned int	ccc_reg;
+	unsigned int	ccc_mask;
+	bool		has_fg_valid;
+	const struct	power_supply_desc *bat_ps_desc;
 	int	(*get_max_voltage)(struct axp20x_batt_ps *batt, int *val);
 	int	(*set_max_voltage)(struct axp20x_batt_ps *batt, int val);
+	int	(*cfg_iio_chan)(struct platform_device *pdev,
+				struct axp20x_batt_ps *axp_batt);
+	void	(*set_bat_info)(struct platform_device *pdev,
+				struct axp20x_batt_ps *axp_batt,
+				struct power_supply_battery_info *info);
 };
 
 struct axp20x_batt_ps {
@@ -508,7 +516,7 @@ static int axp20x_battery_prop_writeable(struct power_supply *psy,
 	       psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX;
 }
 
-static const struct power_supply_desc axp20x_batt_ps_desc = {
+static const struct power_supply_desc axp209_batt_ps_desc = {
 	.name = "axp20x-battery",
 	.type = POWER_SUPPLY_TYPE_BATTERY,
 	.properties = axp20x_battery_props,
@@ -518,27 +526,94 @@ static const struct power_supply_desc axp20x_batt_ps_desc = {
 	.set_property = axp20x_battery_set_prop,
 };
 
+static int axp209_bat_cfg_iio_channels(struct platform_device *pdev,
+				       struct axp20x_batt_ps *axp_batt)
+{
+	axp_batt->batt_v = devm_iio_channel_get(&pdev->dev, "batt_v");
+	if (IS_ERR(axp_batt->batt_v)) {
+		if (PTR_ERR(axp_batt->batt_v) == -ENODEV)
+			return -EPROBE_DEFER;
+		return PTR_ERR(axp_batt->batt_v);
+	}
+
+	axp_batt->batt_chrg_i = devm_iio_channel_get(&pdev->dev,
+							"batt_chrg_i");
+	if (IS_ERR(axp_batt->batt_chrg_i)) {
+		if (PTR_ERR(axp_batt->batt_chrg_i) == -ENODEV)
+			return -EPROBE_DEFER;
+		return PTR_ERR(axp_batt->batt_chrg_i);
+	}
+
+	axp_batt->batt_dischrg_i = devm_iio_channel_get(&pdev->dev,
+							   "batt_dischrg_i");
+	if (IS_ERR(axp_batt->batt_dischrg_i)) {
+		if (PTR_ERR(axp_batt->batt_dischrg_i) == -ENODEV)
+			return -EPROBE_DEFER;
+		return PTR_ERR(axp_batt->batt_dischrg_i);
+	}
+
+	return 0;
+}
+
+static void axp209_set_battery_info(struct platform_device *pdev,
+				    struct axp20x_batt_ps *axp_batt,
+				    struct power_supply_battery_info *info)
+{
+	int vmin = info->voltage_min_design_uv;
+	int ccc = info->constant_charge_current_max_ua;
+
+	if (vmin > 0 && axp20x_set_voltage_min_design(axp_batt, vmin))
+		dev_err(&pdev->dev,
+			"couldn't set voltage_min_design\n");
+
+	/* Set max to unverified value to be able to set CCC */
+	axp_batt->max_ccc = ccc;
+
+	if (ccc <= 0 || axp20x_set_constant_charge_current(axp_batt, ccc)) {
+		dev_err(&pdev->dev,
+			"couldn't set ccc from DT: fallback to min value\n");
+		ccc = 300000;
+		axp_batt->max_ccc = ccc;
+		axp20x_set_constant_charge_current(axp_batt, ccc);
+	}
+}
+
 static const struct axp_data axp209_data = {
 	.ccc_scale = 100000,
 	.ccc_offset = 300000,
+	.ccc_reg = AXP20X_CHRG_CTRL1,
+	.ccc_mask = AXP20X_CHRG_CTRL1_TGT_CURR,
+	.bat_ps_desc = &axp209_batt_ps_desc,
 	.get_max_voltage = axp20x_battery_get_max_voltage,
 	.set_max_voltage = axp20x_battery_set_max_voltage,
+	.cfg_iio_chan = axp209_bat_cfg_iio_channels,
+	.set_bat_info = axp209_set_battery_info,
 };
 
 static const struct axp_data axp221_data = {
 	.ccc_scale = 150000,
 	.ccc_offset = 300000,
+	.ccc_reg = AXP20X_CHRG_CTRL1,
+	.ccc_mask = AXP20X_CHRG_CTRL1_TGT_CURR,
 	.has_fg_valid = true,
+	.bat_ps_desc = &axp209_batt_ps_desc,
 	.get_max_voltage = axp22x_battery_get_max_voltage,
 	.set_max_voltage = axp22x_battery_set_max_voltage,
+	.cfg_iio_chan = axp209_bat_cfg_iio_channels,
+	.set_bat_info = axp209_set_battery_info,
 };
 
 static const struct axp_data axp813_data = {
 	.ccc_scale = 200000,
 	.ccc_offset = 200000,
+	.ccc_reg = AXP20X_CHRG_CTRL1,
+	.ccc_mask = AXP20X_CHRG_CTRL1_TGT_CURR,
 	.has_fg_valid = true,
+	.bat_ps_desc = &axp209_batt_ps_desc,
 	.get_max_voltage = axp813_battery_get_max_voltage,
 	.set_max_voltage = axp20x_battery_set_max_voltage,
+	.cfg_iio_chan = axp209_bat_cfg_iio_channels,
+	.set_bat_info = axp209_set_battery_info,
 };
 
 static const struct of_device_id axp20x_battery_ps_id[] = {
@@ -561,6 +636,7 @@ static int axp20x_power_probe(struct platform_device *pdev)
 	struct power_supply_config psy_cfg = {};
 	struct power_supply_battery_info *info;
 	struct device *dev = &pdev->dev;
+	int ret;
 
 	if (!of_device_is_available(pdev->dev.of_node))
 		return -ENODEV;
@@ -572,29 +648,6 @@ static int axp20x_power_probe(struct platform_device *pdev)
 
 	axp20x_batt->dev = &pdev->dev;
 
-	axp20x_batt->batt_v = devm_iio_channel_get(&pdev->dev, "batt_v");
-	if (IS_ERR(axp20x_batt->batt_v)) {
-		if (PTR_ERR(axp20x_batt->batt_v) == -ENODEV)
-			return -EPROBE_DEFER;
-		return PTR_ERR(axp20x_batt->batt_v);
-	}
-
-	axp20x_batt->batt_chrg_i = devm_iio_channel_get(&pdev->dev,
-							"batt_chrg_i");
-	if (IS_ERR(axp20x_batt->batt_chrg_i)) {
-		if (PTR_ERR(axp20x_batt->batt_chrg_i) == -ENODEV)
-			return -EPROBE_DEFER;
-		return PTR_ERR(axp20x_batt->batt_chrg_i);
-	}
-
-	axp20x_batt->batt_dischrg_i = devm_iio_channel_get(&pdev->dev,
-							   "batt_dischrg_i");
-	if (IS_ERR(axp20x_batt->batt_dischrg_i)) {
-		if (PTR_ERR(axp20x_batt->batt_dischrg_i) == -ENODEV)
-			return -EPROBE_DEFER;
-		return PTR_ERR(axp20x_batt->batt_dischrg_i);
-	}
-
 	axp20x_batt->regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	platform_set_drvdata(pdev, axp20x_batt);
 
@@ -603,8 +656,12 @@ static int axp20x_power_probe(struct platform_device *pdev)
 
 	axp20x_batt->data = (struct axp_data *)of_device_get_match_data(dev);
 
+	ret = axp20x_batt->data->cfg_iio_chan(pdev, axp20x_batt);
+	if (ret)
+		return ret;
+
 	axp20x_batt->batt = devm_power_supply_register(&pdev->dev,
-						       &axp20x_batt_ps_desc,
+						       axp20x_batt->data->bat_ps_desc,
 						       &psy_cfg);
 	if (IS_ERR(axp20x_batt->batt)) {
 		dev_err(&pdev->dev, "failed to register power supply: %ld\n",
@@ -613,33 +670,15 @@ static int axp20x_power_probe(struct platform_device *pdev)
 	}
 
 	if (!power_supply_get_battery_info(axp20x_batt->batt, &info)) {
-		int vmin = info->voltage_min_design_uv;
-		int ccc = info->constant_charge_current_max_ua;
-
-		if (vmin > 0 && axp20x_set_voltage_min_design(axp20x_batt,
-							      vmin))
-			dev_err(&pdev->dev,
-				"couldn't set voltage_min_design\n");
-
-		/* Set max to unverified value to be able to set CCC */
-		axp20x_batt->max_ccc = ccc;
-
-		if (ccc <= 0 || axp20x_set_constant_charge_current(axp20x_batt,
-								   ccc)) {
-			dev_err(&pdev->dev,
-				"couldn't set constant charge current from DT: fallback to minimum value\n");
-			ccc = 300000;
-			axp20x_batt->max_ccc = ccc;
-			axp20x_set_constant_charge_current(axp20x_batt, ccc);
-		}
+		axp20x_batt->data->set_bat_info(pdev, axp20x_batt, info);
+		power_supply_put_battery_info(axp20x_batt->batt, info);
 	}
 
 	/*
 	 * Update max CCC to a valid value if battery info is present or set it
 	 * to current register value by default.
 	 */
-	axp20x_get_constant_charge_current(axp20x_batt,
-					   &axp20x_batt->max_ccc);
+	axp20x_get_constant_charge_current(axp20x_batt, &axp20x_batt->max_ccc);
 
 	return 0;
 }
-- 
2.34.1


