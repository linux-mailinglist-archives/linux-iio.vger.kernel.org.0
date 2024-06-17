Return-Path: <linux-iio+bounces-6440-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B16090BD57
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 00:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA101C2112C
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 22:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3509219AA40;
	Mon, 17 Jun 2024 22:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqnVGBvZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8036B198823;
	Mon, 17 Jun 2024 22:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718661971; cv=none; b=AFVHDicoGuTTA7x8pLyNwKenuT2O0gta70eOfWcL2vPHPvTT+2G4qgPpru2VYN30IsXG50u1zVMLfzIsZrH31dz4uIy39yp0ylaAs/MdB7+tp7NS3cli4IdXXmtiHEQ4hHx4OX1SYNm9ynXtxXaSWHAzR6ZNfhaotYhtI7iiXxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718661971; c=relaxed/simple;
	bh=8ZqJRmyIrwYtuXKousLg/7Cev2gbM5qzO+k/FGNWkvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=buLcuzsPtkxX0+RajSpasqB2Ab8VLFgPkpKYThHo2hfEbEsTnos0y6h5yDXydEOwFNRHuCoW9XFzUyjn6WbDKlwn8reWpMsxF+J1IY1/xfmMy0qNcavncPrrSGu9/Wgx4tx/vg0ZMILwQcziTlw99d3G7liOjRiVjboaGma0DSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqnVGBvZ; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f9923df5dbso2779363a34.2;
        Mon, 17 Jun 2024 15:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718661966; x=1719266766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRFIW1GkxIs4n3biJH6DqY0SIeFvn+wMgrHFKTc6gFw=;
        b=CqnVGBvZNgXzwA2X28UtA9DhL0Fo2bF21MXeS5lwT5PVgTNVGRNc2MMDRDFmq3It2K
         FkgIDB5ivSWlr3ysi9Qlm8c5UxTsKboEe4UP8XC+uwALAO6Rp+zCtLuj068kiuKh46nI
         nYDdB03SNrm1uSBXyFL3/Iyds5dcsTuknBB6CFWq05nHlgdS6oz6S4j2bRBnUgMc8s15
         8zYeDF+VyM4LIMYH8eu/RUoWy8HEKZv2mB+DSwaRh9GCB0ugYXu5DK6725V8kJ/Z6srK
         RGvFQCdPQ/HszKKZ3ab4AFkEdCw8Y7qahcGfL4nmtJt6clQ4A6CDxQM9xAgPXWMqU4bI
         jeig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718661966; x=1719266766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRFIW1GkxIs4n3biJH6DqY0SIeFvn+wMgrHFKTc6gFw=;
        b=KDHXPIG7aH/1aOk2nfeqprzKkHCe4dqcnAbVZDyNoZZxQXi6oFbzVES73ppQnZdk6f
         TQefG8lGdLcAMGaEkHEWTcNjL42sp5Z44cfSuGjw7kHAGkpoNe87nXaEjVmh9IACLt9k
         4nqnMN6oJVEj3D7FXMjLlDAgIHqKUJN6LUiyPGc0S/91rSOrOi3GU5wWAiJBbHCOMNsp
         VzdtTo3XNXfI5nI4rO3tZWZSAkwVk3enle3awseInlA/YqAocGrvDc1LOV4IVwHFygjK
         2w/WhZNWlT+QNYCf+0C7/93P6b7jmJZfkStUKoWDykS0v3etrzX/eMivU9eFxpJVqNyr
         eJNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLvdqul+CqREh91xbAYRRM+ypmMHGt7DuDU/0hIuWPoutqqJFmpV6Ebgnmi93DVLOXnRpCco1n3x6oXzJFJDfRla+shvEQypEly+ro9fgFG5tTLgFNXJehlPznbGJkJBdBjo1Jlg==
X-Gm-Message-State: AOJu0YzvLga/Nsq8ANQhcHylLrxSl9ebYE7lal+2iuGLRz1s5UsS78Vl
	XY5aIg3GDzzBm3T64dD7pYVR09qhGGQ//mRwUuLZ6Lk73XXYuXTU
X-Google-Smtp-Source: AGHT+IFm8jMqa5GdLtSGixhiw8iMcBVf1gx5F42lZlgwWq45gI50ksklV30dAc7aOo/CC8jgls/WEw==
X-Received: by 2002:a05:6830:928:b0:6f9:916c:e936 with SMTP id 46e09a7af769-6fb93651b45mr17797148a34.8.1718661966342;
        Mon, 17 Jun 2024 15:06:06 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6fb5b1b0fa8sm1664232a34.28.2024.06.17.15.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 15:06:05 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-sunxi@lists.linux.dev
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	broonie@kernel.org,
	lee@kernel.org,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	sre@kernel.org,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 7/8] power: supply: axp20x_battery: add support for AXP717
Date: Mon, 17 Jun 2024 17:05:34 -0500
Message-Id: <20240617220535.359021-8-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617220535.359021-1-macroalpha82@gmail.com>
References: <20240617220535.359021-1-macroalpha82@gmail.com>
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

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/power/supply/axp20x_battery.c | 580 +++++++++++++++++++++++---
 1 file changed, 531 insertions(+), 49 deletions(-)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index 6ac5c80cfda2..f09a56948642 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -32,9 +32,19 @@
 #include <linux/mfd/axp20x.h>
 
 #define AXP20X_PWR_STATUS_BAT_CHARGING	BIT(2)
+#define AXP717_PWR_STATUS_MASK		GENMASK(6, 5)
+#define AXP717_PWR_STATUS_BAT_STANDBY	(0 << 5)
+#define AXP717_PWR_STATUS_BAT_CHRG	(1 << 5)
+#define AXP717_PWR_STATUS_BAT_DISCHRG	(2 << 5)
 
 #define AXP20X_PWR_OP_BATT_PRESENT	BIT(5)
 #define AXP20X_PWR_OP_BATT_ACTIVATED	BIT(3)
+#define AXP717_PWR_OP_BATT_PRESENT	BIT(3)
+
+#define AXP717_BATT_PMU_FAULT_MASK	GENMASK(2, 0)
+#define AXP717_BATT_UVLO_2_5V		(1 << 2)
+#define AXP717_BATT_OVER_TEMP		(1 << 1)
+#define AXP717_BATT_UNDER_TEMP		(1 << 0)
 
 #define AXP209_FG_PERCENT		GENMASK(6, 0)
 #define AXP22X_FG_VALID			BIT(7)
@@ -49,20 +59,50 @@
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
+#define AXP717_ICC_CHARGER_LIM		GENMASK(5, 0)
+
+#define AXP717_ITERM_CHG_LIM		GENMASK(3, 0)
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
 
 struct axp_data {
-	int	ccc_scale;
-	int	ccc_offset;
-	bool	has_fg_valid;
+	int		ccc_scale;
+	int		ccc_offset;
+	bool		has_fg_valid;
+	const struct	power_supply_desc *bat_ps_desc;
 	int	(*get_max_voltage)(struct axp20x_batt_ps *batt, int *val);
 	int	(*set_max_voltage)(struct axp20x_batt_ps *batt, int val);
+	int	(*cfg_iio_chan)(struct platform_device *pdev,
+				struct axp20x_batt_ps *axp_batt);
+	void	(*set_bat_info)(struct platform_device *pdev,
+				struct axp20x_batt_ps *axp_batt,
+				struct power_supply_battery_info *info);
+	int	(*get_constant_chg_cur)(struct axp20x_batt_ps *axp, int *val);
 };
 
 struct axp20x_batt_ps {
@@ -135,6 +175,41 @@ static int axp22x_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
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
+		break;
+	case AXP717_CHRG_CV_4_1V:
+		*val = 4100000;
+		break;
+	case AXP717_CHRG_CV_4_2V:
+		*val = 4200000;
+		break;
+	case AXP717_CHRG_CV_4_35V:
+		*val = 4350000;
+		break;
+	case AXP717_CHRG_CV_4_4V:
+		*val = 4400000;
+		break;
+	case AXP717_CHRG_CV_5_0V:
+		*val = 5000000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int axp813_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
 					  int *val)
 {
@@ -180,6 +255,22 @@ static int axp20x_get_constant_charge_current(struct axp20x_batt_ps *axp,
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
+	*val &= AXP717_ICC_CHARGER_LIM;
+
+	*val = *val * axp->data->ccc_scale;
+
+	return 0;
+}
+
 static int axp20x_battery_get_prop(struct power_supply *psy,
 				   enum power_supply_property psp,
 				   union power_supply_propval *val)
@@ -332,6 +423,178 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
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
+		val->intval = !!(reg & AXP717_PWR_OP_BATT_PRESENT);
+		break;
+
+	case POWER_SUPPLY_PROP_STATUS:
+		ret = regmap_read(axp20x_batt->regmap, AXP717_PMU_STATUS_2,
+				  &reg);
+		if (ret)
+			return ret;
+
+		switch (reg & AXP717_PWR_STATUS_MASK) {
+		case AXP717_PWR_STATUS_BAT_STANDBY:
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			break;
+
+		case AXP717_PWR_STATUS_BAT_CHRG:
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+			break;
+
+		case AXP717_PWR_STATUS_BAT_DISCHRG:
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+			break;
+
+		default:
+			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+		}
+
+		break;
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
+			break;
+
+		case AXP717_BATT_OVER_TEMP:
+			val->intval = POWER_SUPPLY_HEALTH_HOT;
+			regmap_update_bits(axp20x_batt->regmap,
+					   AXP717_PMU_FAULT,
+					   AXP717_BATT_OVER_TEMP,
+					   AXP717_BATT_OVER_TEMP);
+			break;
+
+		case AXP717_BATT_UNDER_TEMP:
+			val->intval = POWER_SUPPLY_HEALTH_COLD;
+			regmap_update_bits(axp20x_batt->regmap,
+					   AXP717_PMU_FAULT,
+					   AXP717_BATT_UNDER_TEMP,
+					   AXP717_BATT_UNDER_TEMP);
+			break;
+
+		default:
+			val->intval = POWER_SUPPLY_HEALTH_GOOD;
+		}
+
+		break;
+
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+		ret = axp717_get_constant_charge_current(axp20x_batt,
+							 &val->intval);
+		if (ret)
+			return ret;
+		break;
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
+		break;
+
+	case POWER_SUPPLY_PROP_CAPACITY:
+		/* When no battery is present, return capacity is 100% */
+		ret = regmap_read(axp20x_batt->regmap, AXP717_ON_INDICATE,
+				  &reg);
+		if (ret)
+			return ret;
+
+		if (!(reg & AXP717_PWR_OP_BATT_PRESENT)) {
+			val->intval = 100;
+			return 0;
+		}
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
+		break;
+
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
+		return axp20x_batt->data->get_max_voltage(axp20x_batt,
+							  &val->intval);
+
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
+		ret = regmap_read(axp20x_batt->regmap,
+				  AXP717_VSYS_V_POWEROFF, &reg);
+		if (ret)
+			return ret;
+
+		val->intval = AXP717_BAT_VMIN_MIN_UV + AXP717_BAT_VMIN_STEP *
+			(reg & AXP717_V_OFF_MASK);
+		break;
+
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		ret = iio_read_channel_processed(axp20x_batt->batt_v,
+						 &val->intval);
+		if (ret)
+			return ret;
+
+		/* IIO framework gives mV but Power Supply framework gives uV */
+		val->intval *= 1000;
+		break;
+
+	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+		ret = regmap_read(axp20x_batt->regmap,
+				  AXP717_ITERM_CHG_SET, &reg);
+		if (ret)
+			return ret;
+
+		val->intval = (reg & AXP717_ITERM_CHG_LIM) * AXP717_ITERM_CC_STEP;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int axp22x_battery_set_max_voltage(struct axp20x_batt_ps *axp20x_batt,
 					  int val)
 {
@@ -388,6 +651,35 @@ static int axp20x_battery_set_max_voltage(struct axp20x_batt_ps *axp20x_batt,
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
@@ -404,6 +696,24 @@ static int axp20x_set_constant_charge_current(struct axp20x_batt_ps *axp_batt,
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
+				  AXP717_ICC_CHARGER_LIM, val);
+}
+
 static int axp20x_set_max_constant_charge_current(struct axp20x_batt_ps *axp,
 						  int charge_current)
 {
@@ -448,6 +758,19 @@ static int axp20x_set_voltage_min_design(struct axp20x_batt_ps *axp_batt,
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
@@ -484,6 +807,42 @@ static int axp20x_battery_set_prop(struct power_supply *psy,
 	}
 }
 
+static int axp717_battery_set_prop(struct power_supply *psy,
+				   enum power_supply_property psp,
+				   const union power_supply_propval *val)
+{
+	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
+		return axp717_set_voltage_min_design(axp20x_batt, val->intval);
+
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
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
+		fallthrough;
+	default:
+		return -EINVAL;
+	}
+}
+
 static enum power_supply_property axp20x_battery_props[] = {
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_ONLINE,
@@ -498,6 +857,20 @@ static enum power_supply_property axp20x_battery_props[] = {
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
+	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
+};
+
 static int axp20x_battery_prop_writeable(struct power_supply *psy,
 					 enum power_supply_property psp)
 {
@@ -508,7 +881,16 @@ static int axp20x_battery_prop_writeable(struct power_supply *psy,
 	       psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX;
 }
 
-static const struct power_supply_desc axp20x_batt_ps_desc = {
+static int axp717_battery_prop_writeable(struct power_supply *psy,
+					 enum power_supply_property psp)
+{
+	return psp == POWER_SUPPLY_PROP_STATUS ||
+	       psp == POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN ||
+	       psp == POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN ||
+	       psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX;
+}
+
+static const struct power_supply_desc axp209_batt_ps_desc = {
 	.name = "axp20x-battery",
 	.type = POWER_SUPPLY_TYPE_BATTERY,
 	.properties = axp20x_battery_props,
@@ -518,27 +900,159 @@ static const struct power_supply_desc axp20x_batt_ps_desc = {
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
+	.bat_ps_desc = &axp209_batt_ps_desc,
 	.get_max_voltage = axp20x_battery_get_max_voltage,
 	.set_max_voltage = axp20x_battery_set_max_voltage,
+	.cfg_iio_chan = axp209_bat_cfg_iio_channels,
+	.set_bat_info = axp209_set_battery_info,
+	.get_constant_chg_cur = axp20x_get_constant_charge_current,
 };
 
 static const struct axp_data axp221_data = {
 	.ccc_scale = 150000,
 	.ccc_offset = 300000,
 	.has_fg_valid = true,
+	.bat_ps_desc = &axp209_batt_ps_desc,
 	.get_max_voltage = axp22x_battery_get_max_voltage,
 	.set_max_voltage = axp22x_battery_set_max_voltage,
+	.cfg_iio_chan = axp209_bat_cfg_iio_channels,
+	.set_bat_info = axp209_set_battery_info,
+	.get_constant_chg_cur = axp20x_get_constant_charge_current,
+};
+
+static const struct axp_data axp717_data = {
+	.ccc_scale = 64000,
+	.ccc_offset = 0,
+	.bat_ps_desc = &axp717_batt_ps_desc,
+	.get_max_voltage = axp717_battery_get_max_voltage,
+	.set_max_voltage = axp717_battery_set_max_voltage,
+	.cfg_iio_chan = axp717_bat_cfg_iio_channels,
+	.set_bat_info = axp717_set_battery_info,
+	.get_constant_chg_cur = axp717_get_constant_charge_current,
 };
 
 static const struct axp_data axp813_data = {
 	.ccc_scale = 200000,
 	.ccc_offset = 200000,
 	.has_fg_valid = true,
+	.bat_ps_desc = &axp209_batt_ps_desc,
 	.get_max_voltage = axp813_battery_get_max_voltage,
 	.set_max_voltage = axp20x_battery_set_max_voltage,
+	.cfg_iio_chan = axp209_bat_cfg_iio_channels,
+	.set_bat_info = axp209_set_battery_info,
+	.get_constant_chg_cur = axp20x_get_constant_charge_current,
 };
 
 static const struct of_device_id axp20x_battery_ps_id[] = {
@@ -548,6 +1062,9 @@ static const struct of_device_id axp20x_battery_ps_id[] = {
 	}, {
 		.compatible = "x-powers,axp221-battery-power-supply",
 		.data = (void *)&axp221_data,
+	}, {
+		.compatible = "x-powers,axp717-battery-power-supply",
+		.data = (void *)&axp717_data,
 	}, {
 		.compatible = "x-powers,axp813-battery-power-supply",
 		.data = (void *)&axp813_data,
@@ -561,6 +1078,7 @@ static int axp20x_power_probe(struct platform_device *pdev)
 	struct power_supply_config psy_cfg = {};
 	struct power_supply_battery_info *info;
 	struct device *dev = &pdev->dev;
+	int ret;
 
 	if (!of_device_is_available(pdev->dev.of_node))
 		return -ENODEV;
@@ -572,29 +1090,6 @@ static int axp20x_power_probe(struct platform_device *pdev)
 
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
 
@@ -603,8 +1098,12 @@ static int axp20x_power_probe(struct platform_device *pdev)
 
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
@@ -613,33 +1112,16 @@ static int axp20x_power_probe(struct platform_device *pdev)
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
+	axp20x_batt->data->get_constant_chg_cur(axp20x_batt,
+						&axp20x_batt->max_ccc);
 
 	return 0;
 }
-- 
2.34.1


