Return-Path: <linux-iio+bounces-8605-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 956709570C2
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 18:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94D51C22C00
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 16:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E1617C98C;
	Mon, 19 Aug 2024 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IU5jMqqI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02BC178CE8;
	Mon, 19 Aug 2024 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086127; cv=none; b=WMwUeKOEwItpz7qgj6jReZkuEK9AlXwALInM0XT04dwdEnO/X2VhMi7B08+wr80WN0xbW15XExTClKj4w0Ff5QHAqwl7WrDUyMqxUNK6+ttiMI1YKkr6LaX5iuFLeezkCSBLf+IEn7u6oIvqvCbp1uC65aqCeUI/XLJSzShDBKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086127; c=relaxed/simple;
	bh=7oiVFaUcI0C5oMqqUaovkqLRY8Weg4Zg7WG/UFywWlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ipNaT+6PeZe5MkZL2md929+/9+mSqQ+TJbXydLVODv6xxggXrHl2fOgjWrmOgZ8IIeSXx2XTvbOHSA8iOqMO3DlatTch8GKD8ne0mF0eQDKHpvfRzqnLRVYemTf6QHTNQY4QaA5Y10Ncl/09npjLvxf12ZnYihwfv49CdX6A2Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IU5jMqqI; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7091558067eso1870221a34.3;
        Mon, 19 Aug 2024 09:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724086125; x=1724690925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6uKad2/4G0gY3Nm8pi2ZP0lDyan1DAsdC6ygDIyfJY=;
        b=IU5jMqqIYu6y2ON9y28flyhQPDo73M7mFoJnTZ9k8gb9TRBEE0B8Oh93de2D+aDQVh
         P88AdJkvSC6OB1NSjVIgORb1Ep7Jcdv3WhwWCBMUv1N6uLgzmE4Eex+zg1atHKkDJfB3
         r1Zr/h26p+o2h3BlkIM+CHTVegRObZGuUUwDkqMRasW2llu3RN2VdnpoU+fiH5S+/yIy
         1YfurGPxNrHKbIII/9TwMU8MDBVyiB3vS94Sx3SS9O/1w8e2sx0GdUx5w4NprHHLG6l1
         Y/1qiB4JW5p8AbBquc96kBMdT/ZAnuGzmozVO3o2vNua9ybw4jsydKZORLWY5npjmMYo
         4OnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086125; x=1724690925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6uKad2/4G0gY3Nm8pi2ZP0lDyan1DAsdC6ygDIyfJY=;
        b=ao7AO8tejV/CMAhpD7ia59Swx5Nl8dHannrihwFTkL85TMrAl++RDNAkopOsFUU5Jo
         szqICSto0uaFN3r8mESIDxuxy4pId3g++i2iY2shsqOqN/TfyXm8XN3mlxCLDrqFc3t7
         Mkz1UZF1l7pAkoFjMzMNFNM0cGqdZ4en4d0QgfWD7lwYqb4ifx6JzBNJoEkrSe1GZ8Ha
         TWJvrcgEYC53+A1mXzTEgpvFMq+dYwu9vu7neYyF6N7DAmMupN76LTjMo0n9LRbjgn5d
         gZiAMEif9m14i/klAP53hDdeqD/1RXk/1dndQcQKdbSFj4rBkz4H/Z8U0k+JeO8ouQCp
         iDmg==
X-Forwarded-Encrypted: i=1; AJvYcCVM8AT/+rCupHRYwM9ZzGu7AHsm6U/DMwqEQUazzp7EiVjyZjhuBTOkp2bhVMjfR49n+8O7efjBnBgg1W6iHyYm/KHmbTelAxtrfX083wrR5vmT50nA7V0kh24Oma3TegngvyCKDQ==
X-Gm-Message-State: AOJu0YyLVKAk4gAD1nN/SJuwKwnehuW/Hec8I4P8egMNu1c6AQWC0p7l
	Bxpz2d/aZi0m2CoWopsWs5KCINm/GqY6B7o1YLO4UFK1Vi0mc91J
X-Google-Smtp-Source: AGHT+IEwdTajK32hPcu8uNm7Coe7QuoNGEKT0SOfI0VRHK0bdQK2q5Psfs0K6YXmcF7x1EbHUUprPA==
X-Received: by 2002:a05:6830:3c8c:b0:709:419f:2ae7 with SMTP id 46e09a7af769-70cac8b1dbamr16175460a34.29.1724086124741;
        Mon, 19 Aug 2024 09:48:44 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70ca649c61csm2332428a34.26.2024.08.19.09.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:48:44 -0700 (PDT)
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
Subject: [PATCH V3 03/15] power: supply: axp20x_battery: Make iio and battery config per device
Date: Mon, 19 Aug 2024 11:46:07 -0500
Message-Id: <20240819164619.556309-4-macroalpha82@gmail.com>
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


