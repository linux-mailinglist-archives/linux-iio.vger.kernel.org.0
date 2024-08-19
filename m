Return-Path: <linux-iio+bounces-8616-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC489570E4
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 18:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16856281538
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 16:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FAD188CCD;
	Mon, 19 Aug 2024 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2YY3JLl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED3C176252;
	Mon, 19 Aug 2024 16:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086137; cv=none; b=i1cepZgGAtA2No1bb9ss20e8bIyMO3SuccSwelz87AI84/RCALEiej1GKIzq0dEVwVgWgvxJkYxD8ZfC1z0CYXj996idXocGNpFgdZrwbu6TkKctOq6DlJ2C9hw+KFQLoBBnpEHF4vqY1yxq1ehAYzqzrhVV3MtZwCrkjqrN+XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086137; c=relaxed/simple;
	bh=HTiUsBGkMLjrflXMqghPQnhTqgk/FX7buQqc7mufc64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D/xbU/pMzyAQGavz38r2vektjBiK4At698RU0kEoFvpIFVMgzkjeqQkdsDvcB1g8Bi8fI01DAZR11JP4SDXeZ6+WshKgbIKqHSWxzjqj+ocHmI/5Pk2uCDzmuGDDFQhw1tUypAYni29f8ZZ+bMoe7EVFyKxeRZUYzW7oNOJmNmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2YY3JLl; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-704466b19c4so2627049a34.0;
        Mon, 19 Aug 2024 09:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724086134; x=1724690934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAOSNNqGHZk5eqNGgC5r2eAFOqJPQ2gWfhzwSVd1uSc=;
        b=i2YY3JLl6hGrAfW47If9XOqlrqEopxk9OcjA+WtTvXSqnfzBNfigNDGmr5pMQZv3Ze
         bAruyhaL1VxvDnW5r1eiALUhE2OuuX6mJR8OTezzN6V9/v6atzuZTukP7u+pVcyP0MZl
         ld0tePSALGr26KPP35JrQ8p/7LAPknXMcQKHUGib9WnRfpiS1vuONG6OibzLpEke1jkI
         1OfGVKk3bZSf1pFVeDQELMCxdeLVpPbr8ufkAuYQSoOrwTDqsxOgm7ir21YW7DV7DASu
         gLthA6FQQzyfXusGK3aospsiDT0mWg44NLPpoR4uNbhASHYR0Qtm3JkzRpVzNj/yzBMA
         Rwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086134; x=1724690934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAOSNNqGHZk5eqNGgC5r2eAFOqJPQ2gWfhzwSVd1uSc=;
        b=n14JywMn0g2yeFU4pQCa8oki0LGPKCN2/DdbAxaJ2tVyvsZlmL2EboXaZEi6RIDf1E
         y6lLCxsxA077K1/nl5rklZdxAhi+ByZgIVaNsrN1GERco8symq/5Yd3+zs9+IMuApDcJ
         xBwiElzYagonzO6L+Mfjvw+7+E76toe87EXO46bIASdgnV1gKnAIq1R287y2dJrO45Vl
         WKUB9pB6XVBJZs70uwgx6lh1DLWUGPDc6GTAdzY3TCWouQYkHdbeHQqHBhlbs47d0BpA
         jPejPCqRIYrz7bXN2qefW7b/mwf3FIp61cZwF70xjEoP2NvZkxcOlWGN6Enyz4H5I/Wh
         583Q==
X-Forwarded-Encrypted: i=1; AJvYcCWz3KgzR4eFYk6QejIZFfGL6DqVrplMLRyk1XKPv54gVJJjGnk99/sFDRtwbVexGtmXAPOrs3RWiClC79QQVsaVB1SslvXDWpei8JuLnFU2zI7zhLc/APCG6xgLvp4tZWNLS+u5jw==
X-Gm-Message-State: AOJu0YwAeTs9AMqRCMqt9IqCr0pM/1uNe28bFmOoZQ7bo/O751j4TJdv
	Mhp4VWRgXI+z6xOZVpBjIp8EnZOKUvKFxcgzO6GllOqXyiutfBOg
X-Google-Smtp-Source: AGHT+IGu7XhEZxjvswryF9hPdHwsYydoIQuFBIN7kghC+9x3wK/wj9jECVR6gZW4Ujum4HwsNMc5HA==
X-Received: by 2002:a05:6830:d07:b0:709:50b3:78c0 with SMTP id 46e09a7af769-70cac89bf42mr14963431a34.21.1724086134230;
        Mon, 19 Aug 2024 09:48:54 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70ca649c61csm2332428a34.26.2024.08.19.09.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:48:53 -0700 (PDT)
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
	Chris Morgan <macromorgan@hotmail.com>,
	Philippe Simons <simons.philippe@gmail.com>
Subject: [PATCH V3 14/15] power: supply: axp20x_battery: add support for AXP717
Date: Mon, 19 Aug 2024 11:46:18 -0500
Message-Id: <20240819164619.556309-15-macroalpha82@gmail.com>
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

Add support for the AXP717 PMIC battery charger. The AXP717 differs
greatly from existing AXP battery chargers in that it cannot measure
the discharge current. The datasheet does not document the current
value's offset or scale, so the POWER_SUPPLY_PROP_CURRENT_NOW is left
unscaled.

Tested-by: Philippe Simons <simons.philippe@gmail.com>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/power/supply/axp20x_battery.c | 437 ++++++++++++++++++++++++++
 1 file changed, 437 insertions(+)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index c903c588b361..d43c11f27de6 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -32,9 +32,19 @@
 #include <linux/mfd/axp20x.h>
 
 #define AXP20X_PWR_STATUS_BAT_CHARGING	BIT(2)
+#define AXP717_PWR_STATUS_MASK		GENMASK(6, 5)
+#define AXP717_PWR_STATUS_BAT_STANDBY	0
+#define AXP717_PWR_STATUS_BAT_CHRG	1
+#define AXP717_PWR_STATUS_BAT_DISCHRG	2
 
 #define AXP20X_PWR_OP_BATT_PRESENT	BIT(5)
 #define AXP20X_PWR_OP_BATT_ACTIVATED	BIT(3)
+#define AXP717_PWR_OP_BATT_PRESENT	BIT(3)
+
+#define AXP717_BATT_PMU_FAULT_MASK	GENMASK(2, 0)
+#define AXP717_BATT_UVLO_2_5V		BIT(2)
+#define AXP717_BATT_OVER_TEMP		BIT(1)
+#define AXP717_BATT_UNDER_TEMP		BIT(0)
 
 #define AXP209_FG_PERCENT		GENMASK(6, 0)
 #define AXP22X_FG_VALID			BIT(7)
@@ -49,11 +59,34 @@
 #define AXP22X_CHRG_CTRL1_TGT_4_22V	(1 << 5)
 #define AXP22X_CHRG_CTRL1_TGT_4_24V	(3 << 5)
 
+#define AXP717_CHRG_ENABLE		BIT(1)
+#define AXP717_CHRG_CV_VOLT_MASK	GENMASK(2, 0)
+#define AXP717_CHRG_CV_4_0V		0
+#define AXP717_CHRG_CV_4_1V		1
+#define AXP717_CHRG_CV_4_2V		2
+#define AXP717_CHRG_CV_4_35V		3
+#define AXP717_CHRG_CV_4_4V		4
+/* Values 5 and 6 reserved. */
+#define AXP717_CHRG_CV_5_0V		7
+
 #define AXP813_CHRG_CTRL1_TGT_4_35V	(3 << 5)
 
 #define AXP20X_CHRG_CTRL1_TGT_CURR	GENMASK(3, 0)
+#define AXP717_ICC_CHARGER_LIM_MASK	GENMASK(5, 0)
+
+#define AXP717_ITERM_CHG_LIM_MASK	GENMASK(3, 0)
+#define AXP717_ITERM_CC_STEP		64000
 
 #define AXP20X_V_OFF_MASK		GENMASK(2, 0)
+#define AXP717_V_OFF_MASK		GENMASK(6, 4)
+
+#define AXP717_BAT_VMIN_MIN_UV		2600000
+#define AXP717_BAT_VMIN_MAX_UV		3300000
+#define AXP717_BAT_VMIN_STEP		100000
+#define AXP717_BAT_CV_MIN_UV		4000000
+#define AXP717_BAT_CV_MAX_UV		5000000
+#define AXP717_BAT_CC_MIN_UA		0
+#define AXP717_BAT_CC_MAX_UA		3008000
 
 struct axp20x_batt_ps;
 
@@ -143,6 +176,39 @@ static int axp22x_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
 	return 0;
 }
 
+static int axp717_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
+					  int *val)
+{
+	int ret, reg;
+
+	ret = regmap_read(axp20x_batt->regmap, AXP717_CV_CHG_SET, &reg);
+	if (ret)
+		return ret;
+
+	switch (reg & AXP717_CHRG_CV_VOLT_MASK) {
+	case AXP717_CHRG_CV_4_0V:
+		*val = 4000000;
+		return 0;
+	case AXP717_CHRG_CV_4_1V:
+		*val = 4100000;
+		return 0;
+	case AXP717_CHRG_CV_4_2V:
+		*val = 4200000;
+		return 0;
+	case AXP717_CHRG_CV_4_35V:
+		*val = 4350000;
+		return 0;
+	case AXP717_CHRG_CV_4_4V:
+		*val = 4400000;
+		return 0;
+	case AXP717_CHRG_CV_5_0V:
+		*val = 5000000;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int axp813_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
 					  int *val)
 {
@@ -188,6 +254,21 @@ static int axp20x_get_constant_charge_current(struct axp20x_batt_ps *axp,
 	return 0;
 }
 
+static int axp717_get_constant_charge_current(struct axp20x_batt_ps *axp,
+					      int *val)
+{
+	int ret;
+
+	ret = regmap_read(axp->regmap, AXP717_ICC_CHG_SET, val);
+	if (ret)
+		return ret;
+
+	*val = FIELD_GET(AXP717_ICC_CHARGER_LIM_MASK, *val) *
+		axp->data->ccc_scale;
+
+	return 0;
+}
+
 static int axp20x_battery_get_prop(struct power_supply *psy,
 				   enum power_supply_property psp,
 				   union power_supply_propval *val)
@@ -340,6 +421,171 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
 	return 0;
 }
 
+static int axp717_battery_get_prop(struct power_supply *psy,
+				   enum power_supply_property psp,
+				   union power_supply_propval *val)
+{
+	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
+	int ret = 0, reg;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_PRESENT:
+	case POWER_SUPPLY_PROP_ONLINE:
+		ret = regmap_read(axp20x_batt->regmap, AXP717_ON_INDICATE,
+				  &reg);
+		if (ret)
+			return ret;
+
+		val->intval = FIELD_GET(AXP717_PWR_OP_BATT_PRESENT, reg);
+		return 0;
+
+	case POWER_SUPPLY_PROP_STATUS:
+		ret = regmap_read(axp20x_batt->regmap, AXP717_PMU_STATUS_2,
+				  &reg);
+		if (ret)
+			return ret;
+
+		switch (FIELD_GET(AXP717_PWR_STATUS_MASK, reg)) {
+		case AXP717_PWR_STATUS_BAT_STANDBY:
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			return 0;
+
+		case AXP717_PWR_STATUS_BAT_CHRG:
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+			return 0;
+
+		case AXP717_PWR_STATUS_BAT_DISCHRG:
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+			return 0;
+
+		default:
+			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+			return 0;
+		}
+
+	/*
+	 * If a fault is detected it must also be cleared; if the
+	 * condition persists it should reappear (This is an
+	 * assumption, it's actually not documented). A restart was
+	 * not sufficient to clear the bit in testing despite the
+	 * register listed as POR.
+	 */
+	case POWER_SUPPLY_PROP_HEALTH:
+		ret = regmap_read(axp20x_batt->regmap, AXP717_PMU_FAULT,
+				  &reg);
+		if (ret)
+			return ret;
+
+		switch (reg & AXP717_BATT_PMU_FAULT_MASK) {
+		case AXP717_BATT_UVLO_2_5V:
+			val->intval = POWER_SUPPLY_HEALTH_DEAD;
+			regmap_update_bits(axp20x_batt->regmap,
+					   AXP717_PMU_FAULT,
+					   AXP717_BATT_UVLO_2_5V,
+					   AXP717_BATT_UVLO_2_5V);
+			return 0;
+
+		case AXP717_BATT_OVER_TEMP:
+			val->intval = POWER_SUPPLY_HEALTH_HOT;
+			regmap_update_bits(axp20x_batt->regmap,
+					   AXP717_PMU_FAULT,
+					   AXP717_BATT_OVER_TEMP,
+					   AXP717_BATT_OVER_TEMP);
+			return 0;
+
+		case AXP717_BATT_UNDER_TEMP:
+			val->intval = POWER_SUPPLY_HEALTH_COLD;
+			regmap_update_bits(axp20x_batt->regmap,
+					   AXP717_PMU_FAULT,
+					   AXP717_BATT_UNDER_TEMP,
+					   AXP717_BATT_UNDER_TEMP);
+			return 0;
+
+		default:
+			val->intval = POWER_SUPPLY_HEALTH_GOOD;
+			return 0;
+		}
+
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+		ret = axp717_get_constant_charge_current(axp20x_batt,
+							 &val->intval);
+		if (ret)
+			return ret;
+		return 0;
+
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		/*
+		 * The offset of this value is currently unknown and is
+		 * not documented in the datasheet. Based on
+		 * observation it's assumed to be somewhere around
+		 * 450ma. I will leave the value raw for now.
+		 */
+		ret = iio_read_channel_processed(axp20x_batt->batt_chrg_i, &val->intval);
+		if (ret)
+			return ret;
+		/* IIO framework gives mA but Power Supply framework gives uA */
+		val->intval *= 1000;
+		return 0;
+
+	case POWER_SUPPLY_PROP_CAPACITY:
+		ret = regmap_read(axp20x_batt->regmap, AXP717_ON_INDICATE,
+				  &reg);
+		if (ret)
+			return ret;
+
+		if (!FIELD_GET(AXP717_PWR_OP_BATT_PRESENT, reg))
+			return -ENODEV;
+
+		ret = regmap_read(axp20x_batt->regmap,
+				  AXP717_BATT_PERCENT_DATA, &reg);
+		if (ret)
+			return ret;
+
+		/*
+		 * Fuel Gauge data takes 7 bits but the stored value seems to be
+		 * directly the raw percentage without any scaling to 7 bits.
+		 */
+		val->intval = reg & AXP209_FG_PERCENT;
+		return 0;
+
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+		return axp20x_batt->data->get_max_voltage(axp20x_batt,
+							  &val->intval);
+
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		ret = regmap_read(axp20x_batt->regmap,
+				  AXP717_VSYS_V_POWEROFF, &reg);
+		if (ret)
+			return ret;
+
+		val->intval = AXP717_BAT_VMIN_MIN_UV + AXP717_BAT_VMIN_STEP *
+			(reg & AXP717_V_OFF_MASK);
+		return 0;
+
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		ret = iio_read_channel_processed(axp20x_batt->batt_v,
+						 &val->intval);
+		if (ret)
+			return ret;
+
+		/* IIO framework gives mV but Power Supply framework gives uV */
+		val->intval *= 1000;
+		return 0;
+
+	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+		ret = regmap_read(axp20x_batt->regmap,
+				  AXP717_ITERM_CHG_SET, &reg);
+		if (ret)
+			return ret;
+
+		val->intval = (reg & AXP717_ITERM_CHG_LIM_MASK) * AXP717_ITERM_CC_STEP;
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static int axp22x_battery_set_max_voltage(struct axp20x_batt_ps *axp20x_batt,
 					  int val)
 {
@@ -396,6 +642,35 @@ static int axp20x_battery_set_max_voltage(struct axp20x_batt_ps *axp20x_batt,
 				  AXP20X_CHRG_CTRL1_TGT_VOLT, val);
 }
 
+static int axp717_battery_set_max_voltage(struct axp20x_batt_ps *axp20x_batt,
+					  int val)
+{
+	switch (val) {
+	case 4000000:
+		val = AXP717_CHRG_CV_4_0V;
+		break;
+
+	case 4100000:
+		val = AXP717_CHRG_CV_4_1V;
+		break;
+
+	case 4200000:
+		val = AXP717_CHRG_CV_4_2V;
+		break;
+
+	default:
+		/*
+		 * AXP717 can go up to 4.35, 4.4, and 5.0 volts which
+		 * seem too high for lithium batteries, so do not allow.
+		 */
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(axp20x_batt->regmap,
+				  AXP717_CV_CHG_SET,
+				  AXP717_CHRG_CV_VOLT_MASK, val);
+}
+
 static int axp20x_set_constant_charge_current(struct axp20x_batt_ps *axp_batt,
 					      int charge_current)
 {
@@ -412,6 +687,24 @@ static int axp20x_set_constant_charge_current(struct axp20x_batt_ps *axp_batt,
 				  AXP20X_CHRG_CTRL1_TGT_CURR, charge_current);
 }
 
+static int axp717_set_constant_charge_current(struct axp20x_batt_ps *axp,
+					      int charge_current)
+{
+	int val;
+
+	if (charge_current > axp->max_ccc)
+		return -EINVAL;
+
+	if (charge_current > AXP717_BAT_CC_MAX_UA || charge_current < 0)
+		return -EINVAL;
+
+	val = (charge_current - axp->data->ccc_offset) /
+		axp->data->ccc_scale;
+
+	return regmap_update_bits(axp->regmap, AXP717_ICC_CHG_SET,
+				  AXP717_ICC_CHARGER_LIM_MASK, val);
+}
+
 static int axp20x_set_max_constant_charge_current(struct axp20x_batt_ps *axp,
 						  int charge_current)
 {
@@ -456,6 +749,19 @@ static int axp20x_set_voltage_min_design(struct axp20x_batt_ps *axp_batt,
 				  AXP20X_V_OFF_MASK, val1);
 }
 
+static int axp717_set_voltage_min_design(struct axp20x_batt_ps *axp_batt,
+					 int min_voltage)
+{
+	int val1 = (min_voltage - AXP717_BAT_VMIN_MIN_UV) / AXP717_BAT_VMIN_STEP;
+
+	if (val1 < 0 || val1 > AXP717_V_OFF_MASK)
+		return -EINVAL;
+
+	return regmap_update_bits(axp_batt->regmap,
+				  AXP717_VSYS_V_POWEROFF,
+				  AXP717_V_OFF_MASK, val1);
+}
+
 static int axp20x_battery_set_prop(struct power_supply *psy,
 				   enum power_supply_property psp,
 				   const union power_supply_propval *val)
@@ -492,6 +798,42 @@ static int axp20x_battery_set_prop(struct power_supply *psy,
 	}
 }
 
+static int axp717_battery_set_prop(struct power_supply *psy,
+				   enum power_supply_property psp,
+				   const union power_supply_propval *val)
+{
+	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		return axp717_set_voltage_min_design(axp20x_batt, val->intval);
+
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+		return axp20x_batt->data->set_max_voltage(axp20x_batt, val->intval);
+
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+		return axp717_set_constant_charge_current(axp20x_batt,
+							  val->intval);
+	case POWER_SUPPLY_PROP_STATUS:
+		switch (val->intval) {
+		case POWER_SUPPLY_STATUS_CHARGING:
+			return regmap_update_bits(axp20x_batt->regmap,
+						  AXP717_MODULE_EN_CONTROL_2,
+						  AXP717_CHRG_ENABLE,
+						  AXP717_CHRG_ENABLE);
+
+		case POWER_SUPPLY_STATUS_DISCHARGING:
+		case POWER_SUPPLY_STATUS_NOT_CHARGING:
+			return regmap_update_bits(axp20x_batt->regmap,
+						  AXP717_MODULE_EN_CONTROL_2,
+						  AXP717_CHRG_ENABLE, 0);
+		}
+		return -EINVAL;
+	default:
+		return -EINVAL;
+	}
+}
+
 static enum power_supply_property axp20x_battery_props[] = {
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_ONLINE,
@@ -506,6 +848,20 @@ static enum power_supply_property axp20x_battery_props[] = {
 	POWER_SUPPLY_PROP_CAPACITY,
 };
 
+static enum power_supply_property axp717_battery_props[] = {
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
+};
+
 static int axp20x_battery_prop_writeable(struct power_supply *psy,
 					 enum power_supply_property psp)
 {
@@ -516,6 +872,15 @@ static int axp20x_battery_prop_writeable(struct power_supply *psy,
 	       psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX;
 }
 
+static int axp717_battery_prop_writeable(struct power_supply *psy,
+					 enum power_supply_property psp)
+{
+	return psp == POWER_SUPPLY_PROP_STATUS ||
+	       psp == POWER_SUPPLY_PROP_VOLTAGE_MIN ||
+	       psp == POWER_SUPPLY_PROP_VOLTAGE_MAX ||
+	       psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX;
+}
+
 static const struct power_supply_desc axp209_batt_ps_desc = {
 	.name = "axp20x-battery",
 	.type = POWER_SUPPLY_TYPE_BATTERY,
@@ -526,6 +891,16 @@ static const struct power_supply_desc axp209_batt_ps_desc = {
 	.set_property = axp20x_battery_set_prop,
 };
 
+static const struct power_supply_desc axp717_batt_ps_desc = {
+	.name = "axp20x-battery",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = axp717_battery_props,
+	.num_properties = ARRAY_SIZE(axp717_battery_props),
+	.property_is_writeable = axp717_battery_prop_writeable,
+	.get_property = axp717_battery_get_prop,
+	.set_property = axp717_battery_set_prop,
+};
+
 static int axp209_bat_cfg_iio_channels(struct platform_device *pdev,
 				       struct axp20x_batt_ps *axp_batt)
 {
@@ -555,6 +930,27 @@ static int axp209_bat_cfg_iio_channels(struct platform_device *pdev,
 	return 0;
 }
 
+static int axp717_bat_cfg_iio_channels(struct platform_device *pdev,
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
+	return 0;
+}
+
 static void axp209_set_battery_info(struct platform_device *pdev,
 				    struct axp20x_batt_ps *axp_batt,
 				    struct power_supply_battery_info *info)
@@ -578,6 +974,32 @@ static void axp209_set_battery_info(struct platform_device *pdev,
 	}
 }
 
+static void axp717_set_battery_info(struct platform_device *pdev,
+				    struct axp20x_batt_ps *axp_batt,
+				    struct power_supply_battery_info *info)
+{
+	int vmin = info->voltage_min_design_uv;
+	int vmax = info->voltage_max_design_uv;
+	int ccc = info->constant_charge_current_max_ua;
+	int val;
+
+	if (vmin > 0 && axp717_set_voltage_min_design(axp_batt, vmin))
+		dev_err(&pdev->dev,
+			"couldn't set voltage_min_design\n");
+
+	if (vmax > 0 && axp717_battery_set_max_voltage(axp_batt, vmax))
+		dev_err(&pdev->dev,
+			"couldn't set voltage_max_design\n");
+
+	axp717_get_constant_charge_current(axp_batt, &val);
+	axp_batt->max_ccc = ccc;
+	if (ccc <= 0 || axp717_set_constant_charge_current(axp_batt, ccc)) {
+		dev_err(&pdev->dev,
+			"couldn't set ccc from DT: current ccc is %d\n",
+			val);
+	}
+}
+
 static const struct axp_data axp209_data = {
 	.ccc_scale = 100000,
 	.ccc_offset = 300000,
@@ -603,6 +1025,18 @@ static const struct axp_data axp221_data = {
 	.set_bat_info = axp209_set_battery_info,
 };
 
+static const struct axp_data axp717_data = {
+	.ccc_scale = 64000,
+	.ccc_offset = 0,
+	.ccc_reg = AXP717_ICC_CHG_SET,
+	.ccc_mask = AXP717_ICC_CHARGER_LIM_MASK,
+	.bat_ps_desc = &axp717_batt_ps_desc,
+	.get_max_voltage = axp717_battery_get_max_voltage,
+	.set_max_voltage = axp717_battery_set_max_voltage,
+	.cfg_iio_chan = axp717_bat_cfg_iio_channels,
+	.set_bat_info = axp717_set_battery_info,
+};
+
 static const struct axp_data axp813_data = {
 	.ccc_scale = 200000,
 	.ccc_offset = 200000,
@@ -623,6 +1057,9 @@ static const struct of_device_id axp20x_battery_ps_id[] = {
 	}, {
 		.compatible = "x-powers,axp221-battery-power-supply",
 		.data = (void *)&axp221_data,
+	}, {
+		.compatible = "x-powers,axp717-battery-power-supply",
+		.data = (void *)&axp717_data,
 	}, {
 		.compatible = "x-powers,axp813-battery-power-supply",
 		.data = (void *)&axp813_data,
-- 
2.34.1


