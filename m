Return-Path: <linux-iio+bounces-8678-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC7795A760
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 23:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640C4285388
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 21:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A43017DFFD;
	Wed, 21 Aug 2024 21:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYzsPWsj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F265717B513;
	Wed, 21 Aug 2024 21:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724277463; cv=none; b=R6xrN8Tv7GFFi64G76UAUS+PocxMbo3/fwBmue6HnKMB61R6ptmS6AcaqvEG0lXqGFezH5XtkPnWX0w1e1wz4k74ttYF+wCJSiwsXJzD2wHy4oPMzWZ6HWV+7IcXQSE97OWDGhkaE9QYIKhhD6Oi7Qnh4qhgsAvh1R2jcrcsjv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724277463; c=relaxed/simple;
	bh=QeqRGuaNZn35sh/2JJqQqrdIhJxD8p3YXfp97ZlwaBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pFjaazOmsaPF7bO3t7+TZffeBuZMbLvkrTdmF1B16Uku42BAXnhZF+gI1jHyo1NDCJSxLaXeUpd51pNrqZhYnzLSDPIK70uaBsBkSSXgR51SdHpCNl6lzMXD/R3DXACOCMO/zwg2/crvWH632IvlVP7PFYQqhzYyOfbne+34+CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYzsPWsj; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3db18c4927bso100197b6e.1;
        Wed, 21 Aug 2024 14:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724277460; x=1724882260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWYI1+rqxoAuP5ujwY5Es0pGFkBazrnSW9iCz4mY1l8=;
        b=OYzsPWsjhrBuVZes+BTJ+qUolvqDsilS3ZuYXNFbloLOmulGjbDZSBnsUJet1qD8YC
         KCeY+rNmKs2ZzZqBxvl6N8A0abyo+yLNJ1qFEKkjHVlJeAwF+xObQ3n8DkQG9LafMzo4
         omyG/mocc0eTg7eLp+Nqvw8TCbMn+MG1FyAtFiv+4EISn8fcja/0hTtBU3sN5BiUrBXk
         6JTIKhx1Nn7S1bTJMELJ/kk+z9O7XVXl9FuwphPOK922my5dQL2it3+d/8IBJSDjnepB
         dGpM7Z333cxbxGXnhqnOCHHCnHvN3DqTSiepuUwIFQalFk5ML4kgcYCY2QJdn8m4mAz0
         B+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724277460; x=1724882260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RWYI1+rqxoAuP5ujwY5Es0pGFkBazrnSW9iCz4mY1l8=;
        b=JEfNvEsVLnhG3/4NfLMG4aAsEuRgz6OfVsI1+yRVit2LGx5CX3CK7H/EQP6c/1IzX8
         85sUFcj3HaTRsdGcBBoB3InItXGwz48joKx66MSLm/4lzyxQHYGewNsy3rPPgFoE5LTI
         6E6EtRXoTr6ZLtLv3WLN59UCo9sSiq12D1Tj2U+eDCNlYmEPyd/lBfzJIhBzwADbI6eq
         VnkeWFAdAd9bBBcAwmNj5kChZYqGFo4But8RBk0oLfJuk3j2SEcoDEQ9CwpoDiJLYX59
         3HrGCzmLO9ugmRRegs+lub2CaQE1rxwyjpUu9ELeZEnQSfaHgkFWPMDaHnxlnHOVgD2K
         FbPw==
X-Forwarded-Encrypted: i=1; AJvYcCWVKqcbAiFMcpBtvhpchGt0n9KTmawyg4ZKWNfAUMqG42SoSJZxvTDmkilaLD8GA5blAfTS80d2MuXm@vger.kernel.org, AJvYcCWyXxXxAtjrjoxtdv9LrUSLRCfqwVvYQcx+PsRejKj2Xz7NALfPqGwbIdWwtdbHs3KQBxOnIeIf+64/@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp8QK36ElMo1j+iiGIgSltq4xh107BOP9EvXExoWoDhyxwGkh9
	LrbT/x3Om4oQChynJQknUvyxSNVACPjRJ6tzfzD3EazGfFqoGqVa75XLpQ==
X-Google-Smtp-Source: AGHT+IEIJpkRZf3GerIDPrOK8qoWsbSJycVnWqKTAe676M+6Bx6GAz1aznK/Nt9mNbp/L4mJdvEtpw==
X-Received: by 2002:a05:6808:1589:b0:3d5:61d9:fac1 with SMTP id 5614622812f47-3de1958ae6amr4046776b6e.46.1724277459987;
        Wed, 21 Aug 2024 14:57:39 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:81a9:2325:e0f7:7376])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de225555b6sm47070b6e.17.2024.08.21.14.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:57:39 -0700 (PDT)
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
Subject: [PATCH V4 14/15] power: supply: axp20x_battery: add support for AXP717
Date: Wed, 21 Aug 2024 16:54:55 -0500
Message-Id: <20240821215456.962564-15-macroalpha82@gmail.com>
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

Add support for the AXP717 PMIC battery charger. The AXP717 differs
greatly from existing AXP battery chargers in that it cannot measure
the discharge current. The datasheet does not document the current
value's offset or scale, so the POWER_SUPPLY_PROP_CURRENT_NOW is left
unscaled.

Tested-by: Philippe Simons <simons.philippe@gmail.com>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/power/supply/axp20x_battery.c | 438 ++++++++++++++++++++++++++
 1 file changed, 438 insertions(+)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index c903c588b361..f71cc90fea12 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -17,6 +17,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/bitfield.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -32,9 +33,19 @@
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
@@ -49,11 +60,34 @@
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
 
@@ -143,6 +177,39 @@ static int axp22x_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
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
@@ -188,6 +255,21 @@ static int axp20x_get_constant_charge_current(struct axp20x_batt_ps *axp,
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
@@ -340,6 +422,171 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
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
@@ -396,6 +643,35 @@ static int axp20x_battery_set_max_voltage(struct axp20x_batt_ps *axp20x_batt,
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
@@ -412,6 +688,24 @@ static int axp20x_set_constant_charge_current(struct axp20x_batt_ps *axp_batt,
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
@@ -456,6 +750,19 @@ static int axp20x_set_voltage_min_design(struct axp20x_batt_ps *axp_batt,
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
@@ -492,6 +799,42 @@ static int axp20x_battery_set_prop(struct power_supply *psy,
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
@@ -506,6 +849,20 @@ static enum power_supply_property axp20x_battery_props[] = {
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
@@ -516,6 +873,15 @@ static int axp20x_battery_prop_writeable(struct power_supply *psy,
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
@@ -526,6 +892,16 @@ static const struct power_supply_desc axp209_batt_ps_desc = {
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
@@ -555,6 +931,27 @@ static int axp209_bat_cfg_iio_channels(struct platform_device *pdev,
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
@@ -578,6 +975,32 @@ static void axp209_set_battery_info(struct platform_device *pdev,
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
@@ -603,6 +1026,18 @@ static const struct axp_data axp221_data = {
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
@@ -623,6 +1058,9 @@ static const struct of_device_id axp20x_battery_ps_id[] = {
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


