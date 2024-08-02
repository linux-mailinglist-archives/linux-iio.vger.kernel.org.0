Return-Path: <linux-iio+bounces-8163-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D779463DD
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 21:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4CB51C214E2
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 19:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0D11ABEB0;
	Fri,  2 Aug 2024 19:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0BZ9UiV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918AA1547F9;
	Fri,  2 Aug 2024 19:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722626584; cv=none; b=fQFBQbIGaD0602r017FIRr4EX2n1ntOGi0hRx4o9jpkptz47T4gFfAadenCP6G+rmjXn74hSXu5zYjZBGRSE3N4jMi1Ypm0schO9JReJt5Tila0V/qhvvWkNDsfn4iCBHmMLyuoE4l//u+vjMvyRjWPR9nqVbMTXV6CUIOOcWZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722626584; c=relaxed/simple;
	bh=WWha/+/aE9B9fCIjHL40ioPWhVOHMNBL2wTAmILnqLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yytb5aWBMJa3WFV31LS+9rP7ygfl+H7Kw4afR4Kj68/Yl2v5ajGvI6ZHKqDyRokdG9hzMs2yBTWl9sF45joIujIkOOkWvfcsc7Iy0sViqZ73r831qiJKkk3naRaak7yGn/P8ZozVfZ8Ks69lI2+dVrLMYZVKP4vIeRa0VskhT1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0BZ9UiV; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3db14930a1aso5583387b6e.3;
        Fri, 02 Aug 2024 12:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722626580; x=1723231380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzwbUBXpQ31q7HNv2dH+jmh+P3HKqC3um14cKU6HarE=;
        b=L0BZ9UiVK1NDx055cOXkNe1Czp7mRI1E7wztIwbyzLmTGUTRAv65qgDvKwMji5y0fc
         r9Vg8hpPS6vwKGgWUUfZGVv4xfuTqgT7n0t+dVPV+37AKxl6HNAB3Jzl6J6Q1ZJRcpph
         vKCLtCHztsPrgI89SPx+ud37Aa6v+pX3vu+sFyDR/Tmt/ifizMoc2+YpKMr+CPj+UrOT
         2mDgnT0/BN7rhjK9FAatdxv3n8ziz/kRvz3ruLNLeZYtv+wW9pLVU58ZBRWn6jtEAA6W
         aCI67XNib/lJ0ArcpfUQPs1Qztk6ZjWdTwqzc/Xl57YdS4xpcc8VC1xpiKB/Caro8LE9
         FOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722626580; x=1723231380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzwbUBXpQ31q7HNv2dH+jmh+P3HKqC3um14cKU6HarE=;
        b=DZWGAliyaEct1E1pXmcl5092cK73gm8zoDxtG3VyNSYR5mL+Jdah2awKp6SByeg3nV
         Dt3Z6FdVSSZox8KcsjD0+9E85uHTU7W8xjJEPmcUtwkQCVS1xTJTt6DRYUd+Bxd8YSRz
         TDsxX/y8BpepXMbXhn7bpGDKuwSUUzyr251oh5p8rmIE8sCugQC4Xz9oss7YLjOycM4S
         K/bVARrXVramwz7UAVelox+2CU33DUsvOOjKnygOcfkRB7lUEb24MoJ+wnkZWui6LJu6
         zPrQ8B4l+owMERi+ZF5J2Wx2GgEez5L3oBQ59rQ6ytezXuVOdTETBiCdzQY871+pBDC2
         lmvg==
X-Forwarded-Encrypted: i=1; AJvYcCULs+ljvMgfYnlvOrqM47ArCbL/EbCrDsq78L/7ZZxJq4ZihA4yfyzvDzNW0W9fnPqLpVx4nxnL0qu4iE2xqMGvEivf0SuO/mTRKfxzY9py+MwhCU43km/y8yOCDZ9Ma77JtKkjEA==
X-Gm-Message-State: AOJu0YzDYUmKwXZw9RDCuE9vhHyu5pITqjMT7q37JL+2tH9Y4DOO/OWZ
	TalCOjuqzS/QRFCKNeRfBJ2MghW69L2YVkkpIsrznpI3cppBiyRJ
X-Google-Smtp-Source: AGHT+IG8QL3OfDlej9oSYtslP47HePYHZVzG9VRvY48Gi3z6TsLgLdUXMLKm1me39Bvya9Azl5EjMw==
X-Received: by 2002:a05:6808:178b:b0:3d9:385d:8754 with SMTP id 5614622812f47-3db5583cae4mr5529852b6e.47.1722626580554;
        Fri, 02 Aug 2024 12:23:00 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db563b7065sm584592b6e.46.2024.08.02.12.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 12:23:00 -0700 (PDT)
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
	Chris Morgan <macromorgan@hotmail.com>,
	Philippe Simons <simons.philippe@gmail.com>
Subject: [PATCH V2 13/15] power: supply: axp20x_usb_power: Add support for AXP717
Date: Fri,  2 Aug 2024 14:20:24 -0500
Message-Id: <20240802192026.446344-14-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802192026.446344-1-macroalpha82@gmail.com>
References: <20240802192026.446344-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add support for the AXP717 PMIC. The AXP717 PMIC allows for detection
of USB type like the AXP813, but has little in common otherwise with
the other AXP PMICs. The USB charger is able to provide between
100000uA and 3250000uA of power, and can measure the VBUS input in mV
with up to 14 bits of precision.

Tested-by: Philippe Simons <simons.philippe@gmail.com>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/power/supply/axp20x_usb_power.c | 244 ++++++++++++++++++++++++
 1 file changed, 244 insertions(+)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 69fbb5861934..41426fca8cfc 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -30,8 +30,13 @@
 #define AXP20X_PWR_STATUS_VBUS_PRESENT	BIT(5)
 #define AXP20X_PWR_STATUS_VBUS_USED	BIT(4)
 
+#define AXP717_PWR_STATUS_VBUS_GOOD	BIT(5)
+
 #define AXP20X_USB_STATUS_VBUS_VALID	BIT(2)
 
+#define AXP717_PMU_FAULT_VBUS		BIT(5)
+#define AXP717_PMU_FAULT_VSYS		BIT(3)
+
 #define AXP20X_VBUS_VHOLD_uV(b)		(4000000 + (((b) >> 3) & 7) * 100000)
 #define AXP20X_VBUS_VHOLD_MASK		GENMASK(5, 3)
 #define AXP20X_VBUS_VHOLD_OFFSET	3
@@ -39,6 +44,12 @@
 #define AXP20X_ADC_EN1_VBUS_CURR	BIT(2)
 #define AXP20X_ADC_EN1_VBUS_VOLT	BIT(3)
 
+#define AXP717_INPUT_VOL_LIMIT_MASK	GENMASK(3, 0)
+#define AXP717_INPUT_CUR_LIMIT_MASK	GENMASK(5, 0)
+#define AXP717_ADC_DATA_MASK		GENMASK(14, 0)
+
+#define AXP717_ADC_EN_VBUS_VOLT		BIT(2)
+
 /*
  * Note do not raise the debounce time, we must report Vusb high within
  * 100ms otherwise we get Vbus errors in musb.
@@ -143,6 +154,24 @@ static void axp20x_usb_power_poll_vbus(struct work_struct *work)
 		mod_delayed_work(system_power_efficient_wq, &power->vbus_detect, DEBOUNCE_TIME);
 }
 
+static void axp717_usb_power_poll_vbus(struct work_struct *work)
+{
+	struct axp20x_usb_power *power =
+		container_of(work, struct axp20x_usb_power, vbus_detect.work);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(power->regmap, AXP717_ON_INDICATE, &val);
+	if (ret)
+		return;
+
+	val &= AXP717_PWR_STATUS_VBUS_GOOD;
+	if (val != power->old_status)
+		power_supply_changed(power->supply);
+
+	power->old_status = val;
+}
+
 static int axp20x_get_usb_type(struct axp20x_usb_power *power,
 			       union power_supply_propval *val)
 {
@@ -288,6 +317,91 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 	return 0;
 }
 
+static int axp717_usb_power_get_property(struct power_supply *psy,
+	enum power_supply_property psp, union power_supply_propval *val)
+{
+	struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
+	unsigned int v;
+	int ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_HEALTH:
+		val->intval = POWER_SUPPLY_HEALTH_GOOD;
+		ret = regmap_read(power->regmap, AXP717_ON_INDICATE, &v);
+		if (ret)
+			return ret;
+
+		if (!(v & AXP717_PWR_STATUS_VBUS_GOOD))
+			val->intval = POWER_SUPPLY_HEALTH_UNKNOWN;
+
+		ret = regmap_read(power->regmap, AXP717_PMU_FAULT_VBUS, &v);
+		if (ret)
+			return ret;
+
+		v &= (AXP717_PMU_FAULT_VBUS | AXP717_PMU_FAULT_VSYS);
+		if (v) {
+			val->intval = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
+			regmap_write(power->regmap, AXP717_PMU_FAULT_VBUS, v);
+		}
+
+		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		ret = regmap_read(power->regmap, AXP717_INPUT_CUR_LIMIT_CTRL, &v);
+		if (ret)
+			return ret;
+
+		/* 50ma step size with 100ma offset. */
+		v &= AXP717_INPUT_CUR_LIMIT_MASK;
+		val->intval = (v * 50000) + 100000;
+		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+	case POWER_SUPPLY_PROP_PRESENT:
+		ret = regmap_read(power->regmap, AXP717_ON_INDICATE, &v);
+		if (ret)
+			return ret;
+		val->intval = !!(v & AXP717_PWR_STATUS_VBUS_GOOD);
+		break;
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		return axp20x_get_usb_type(power, val);
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		ret = regmap_read(power->regmap, AXP717_INPUT_VOL_LIMIT_CTRL, &v);
+		if (ret)
+			return ret;
+
+		/* 80mv step size with 3.88v offset. */
+		v &= AXP717_INPUT_VOL_LIMIT_MASK;
+		val->intval = (v * 80000) + 3880000;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		if (IS_ENABLED(CONFIG_AXP20X_ADC)) {
+			ret = iio_read_channel_processed(power->vbus_v,
+							 &val->intval);
+			if (ret)
+				return ret;
+
+			/*
+			 * IIO framework gives mV but Power Supply framework
+			 * gives uV.
+			 */
+			val->intval *= 1000;
+			return 0;
+		}
+
+		ret = axp20x_read_variable_width(power->regmap,
+						 AXP717_VBUS_V_H, 16);
+		if (ret < 0)
+			return ret;
+
+		val->intval = (ret % AXP717_ADC_DATA_MASK) * 1000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+
+}
+
 static int axp20x_usb_power_set_voltage_min(struct axp20x_usb_power *power,
 					    int intval)
 {
@@ -314,6 +428,22 @@ static int axp20x_usb_power_set_voltage_min(struct axp20x_usb_power *power,
 	return -EINVAL;
 }
 
+static int axp717_usb_power_set_voltage_min(struct axp20x_usb_power *power,
+					    int intval)
+{
+	int val;
+
+	/* Minimum value of 3.88v and maximum of 5.08v. */
+	if (intval < 3880000 || intval > 5080000)
+		return -EINVAL;
+
+	/* step size of 80ma with 3.88v offset. */
+	val = (intval - 3880000) / 80000;
+	return regmap_update_bits(power->regmap,
+				  AXP717_INPUT_VOL_LIMIT_CTRL,
+				  AXP717_INPUT_VOL_LIMIT_MASK, val);
+}
+
 static int axp20x_usb_power_set_input_current_limit(struct axp20x_usb_power *power,
 						    int intval)
 {
@@ -354,6 +484,29 @@ static int axp20x_usb_power_set_input_current_limit(struct axp20x_usb_power *pow
 	return regmap_field_write(power->curr_lim_fld, reg);
 }
 
+static int axp717_usb_power_set_input_current_limit(struct axp20x_usb_power *power,
+						    int intval)
+{
+	int tmp;
+
+	/* Minimum value of 100mA and maximum value of 3.25A*/
+	if (intval < 100000 || intval > 3250000)
+		return -EINVAL;
+
+	if (power->max_input_cur && (intval > power->max_input_cur)) {
+		dev_warn(power->dev,
+			 "reqested current %d clamped to max current %d\n",
+			 intval, power->max_input_cur);
+		intval = power->max_input_cur;
+	}
+
+	/* Minimum value of 100mA with step size of 50mA. */
+	tmp = (intval - 100000) / 50000;
+	return regmap_update_bits(power->regmap,
+				  AXP717_INPUT_CUR_LIMIT_CTRL,
+				  AXP717_INPUT_CUR_LIMIT_MASK, tmp);
+}
+
 static int axp20x_usb_power_set_property(struct power_supply *psy,
 					 enum power_supply_property psp,
 					 const union power_supply_propval *val)
@@ -376,6 +529,24 @@ static int axp20x_usb_power_set_property(struct power_supply *psy,
 	default:
 		return -EINVAL;
 	}
+}
+
+static int axp717_usb_power_set_property(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 const union power_supply_propval *val)
+{
+	struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		return axp717_usb_power_set_input_current_limit(power, val->intval);
+
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		return axp717_usb_power_set_voltage_min(power, val->intval);
+
+	default:
+		return -EINVAL;
+	}
 
 	return -EINVAL;
 }
@@ -399,6 +570,13 @@ static int axp20x_usb_power_prop_writeable(struct power_supply *psy,
 	       psp == POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT;
 }
 
+static int axp717_usb_power_prop_writeable(struct power_supply *psy,
+					   enum power_supply_property psp)
+{
+	return psp == POWER_SUPPLY_PROP_VOLTAGE_MIN ||
+	       psp == POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT;
+}
+
 static int axp20x_configure_iio_channels(struct platform_device *pdev,
 					 struct axp20x_usb_power *power)
 {
@@ -419,6 +597,19 @@ static int axp20x_configure_iio_channels(struct platform_device *pdev,
 	return 0;
 }
 
+static int axp717_configure_iio_channels(struct platform_device *pdev,
+					 struct axp20x_usb_power *power)
+{
+	power->vbus_v = devm_iio_channel_get(&pdev->dev, "vbus_v");
+	if (IS_ERR(power->vbus_v)) {
+		if (PTR_ERR(power->vbus_v) == -ENODEV)
+			return -EPROBE_DEFER;
+		return PTR_ERR(power->vbus_v);
+	}
+
+	return 0;
+}
+
 static int axp20x_configure_adc_registers(struct axp20x_usb_power *power)
 {
 	/* Enable vbus voltage and current measurement */
@@ -429,6 +620,14 @@ static int axp20x_configure_adc_registers(struct axp20x_usb_power *power)
 				  AXP20X_ADC_EN1_VBUS_VOLT);
 }
 
+static int axp717_configure_adc_registers(struct axp20x_usb_power *power)
+{
+	/* Enable vbus voltage measurement  */
+	return regmap_update_bits(power->regmap, AXP717_ADC_CH_EN_CONTROL,
+				  AXP717_ADC_EN_VBUS_VOLT,
+				  AXP717_ADC_EN_VBUS_VOLT);
+}
+
 static enum power_supply_property axp20x_usb_power_properties[] = {
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_PRESENT,
@@ -447,6 +646,16 @@ static enum power_supply_property axp22x_usb_power_properties[] = {
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 };
 
+static enum power_supply_property axp717_usb_power_properties[] = {
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_USB_TYPE,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+};
+
 static enum power_supply_property axp813_usb_power_properties[] = {
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_PRESENT,
@@ -483,6 +692,18 @@ static const struct power_supply_desc axp22x_usb_power_desc = {
 	.set_property = axp20x_usb_power_set_property,
 };
 
+static const struct power_supply_desc axp717_usb_power_desc = {
+	.name = "axp20x-usb",
+	.type = POWER_SUPPLY_TYPE_USB,
+	.properties = axp717_usb_power_properties,
+	.num_properties = ARRAY_SIZE(axp717_usb_power_properties),
+	.property_is_writeable = axp717_usb_power_prop_writeable,
+	.get_property = axp717_usb_power_get_property,
+	.set_property = axp717_usb_power_set_property,
+	.usb_types = axp813_usb_types,
+	.num_usb_types = ARRAY_SIZE(axp813_usb_types),
+};
+
 static const struct power_supply_desc axp813_usb_power_desc = {
 	.name = "axp20x-usb",
 	.type = POWER_SUPPLY_TYPE_USB,
@@ -507,6 +728,12 @@ static const char * const axp22x_irq_names[] = {
 	"VBUS_REMOVAL",
 };
 
+static const char * const axp717_irq_names[] = {
+	"VBUS_PLUGIN",
+	"VBUS_REMOVAL",
+	"VBUS_OVER_V",
+};
+
 static int axp192_usb_curr_lim_table[] = {
 	-1,
 	-1,
@@ -594,6 +821,20 @@ static const struct axp_data axp223_data = {
 	.axp20x_cfg_adc_reg = axp20x_configure_adc_registers,
 };
 
+static const struct axp_data axp717_data = {
+	.power_desc     = &axp717_usb_power_desc,
+	.irq_names      = axp717_irq_names,
+	.num_irq_names  = ARRAY_SIZE(axp717_irq_names),
+	.curr_lim_fld   = REG_FIELD(AXP717_INPUT_CUR_LIMIT_CTRL, 0, 5),
+	.usb_bc_en_bit  = REG_FIELD(AXP717_MODULE_EN_CONTROL_1, 4, 4),
+	.usb_bc_det_fld = REG_FIELD(AXP717_BC_DETECT, 5, 7),
+	.vbus_mon_bit   = REG_FIELD(AXP717_ADC_CH_EN_CONTROL, 2, 2),
+	.vbus_needs_polling = false,
+	.axp20x_read_vbus = &axp717_usb_power_poll_vbus,
+	.axp20x_cfg_iio_chan = axp717_configure_iio_channels,
+	.axp20x_cfg_adc_reg = axp717_configure_adc_registers,
+};
+
 static const struct axp_data axp813_data = {
 	.power_desc	= &axp813_usb_power_desc,
 	.irq_names	= axp22x_irq_names,
@@ -821,6 +1062,9 @@ static const struct of_device_id axp20x_usb_power_match[] = {
 	}, {
 		.compatible = "x-powers,axp223-usb-power-supply",
 		.data = &axp223_data,
+	}, {
+		.compatible = "x-powers,axp717-usb-power-supply",
+		.data = &axp717_data,
 	}, {
 		.compatible = "x-powers,axp813-usb-power-supply",
 		.data = &axp813_data,
-- 
2.34.1


