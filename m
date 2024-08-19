Return-Path: <linux-iio+bounces-8615-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B25E9570E1
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 18:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04EE1C22CE7
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 16:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C665188CBE;
	Mon, 19 Aug 2024 16:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIhLUyAG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FCA17557E;
	Mon, 19 Aug 2024 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086136; cv=none; b=ETkzjVrVB02qJUlljP6+ZvL/Q38xs/xL/E+J5j9fW8HEQMwQGKTZ8pTMfW/OvAT78VJPibtYJcTpjBUA0Fr7o02Qzus7NKLmrCg9chDU1dwNAskxOycz0KYOqKSlMyVw1t/2xlYs68pZ8djUCLap7ZLzJQ8OwWQgE1knCUEOFkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086136; c=relaxed/simple;
	bh=WWha/+/aE9B9fCIjHL40ioPWhVOHMNBL2wTAmILnqLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uUuHSPwXjAf0mi6TZwiRPhHBAs71maP5eMYvpHhiPb5Bwim7Ct5Nk12w1y6B+9di3tCyGjMs+BC97ylVEcYZYa5sAEYwjalRjkML2X8PV80tiDFxac6enKMDI6GiPrL05DYKSXqfrHfuW2afUgval7YaRNVEq4rs0A6kmvIaaBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIhLUyAG; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-70936061d0dso2761810a34.2;
        Mon, 19 Aug 2024 09:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724086133; x=1724690933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzwbUBXpQ31q7HNv2dH+jmh+P3HKqC3um14cKU6HarE=;
        b=OIhLUyAGlZFF5Y+cV8JeJ7BlvM8RR9pQkfdG7+tVX/Kv1Z8J/e1yF5m3kx3BZFnQ0P
         o9QCSjz021URiTnVhKxKffOcC4gh2oiXKisUVxhs+TZ5lkriUb5lGhAr8yIo2wcHYMEv
         EQZXpV4LJrwSuWHPWZIm8htqF6sqn0sOJZNTnlK9Gqh4N6W85fYsRTEQRtsz4plVeWsO
         aapkzOUdixwUNEHxLNaXk422Y/avTxkhUH4NWLZT5Xc9jA9DXeEYUhCw5HQ5US7PI/8E
         n+FvUxqFL6+jsA63VqO/OpJZi5avm4MkW883ryBQmB+yvBnGeDniSgC67kuu/UFRe3Dc
         wVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086133; x=1724690933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzwbUBXpQ31q7HNv2dH+jmh+P3HKqC3um14cKU6HarE=;
        b=FMtzoS6H+BoKdr/5O1/EepUSmizeJ9E2jw4ONwPfxKg4I/0QQuR0ZbeeZdcjmw7rTJ
         kMYX08mSgqf8lKKJLfEDt9N0f3MBJ2HvHPTVugASyAPt6KogEcJnKDHaLNocFjQcYpzp
         tHcDxtlcPLtN7708Wd9KBF50XW6m3arMs6ST9/0aOpIRsSjPyLIQLCzEj1Wqbr1n9HV3
         ho9AC5U0YnpEiA0D/ZW+6NxsQfhmmOr5Fcx+G77tei9sxEP1f4eSPmM9AAxuLx5TWolo
         +cIQJmp0gaTo1JZN+6W8w4gckdRqQCKRIfVVgbE+VIaHaEmuI95VWSrvGPeRpjhHO1kc
         WIcw==
X-Forwarded-Encrypted: i=1; AJvYcCWjtbqeQA7noIHdMMUCeUKW7vNT10dyS0olo5tPLOrTFHncHUPV0CwmwoUdEl6hYH8JC93u0VUawLmJEGE4alfJHCDqHZsH6lLV/DDvk6eZX1fBkpDypU+nWq3mNdFf9nAZjKSYEQ==
X-Gm-Message-State: AOJu0Yx9KPSezvpIH1nzTchRgHBIql6y2fuCR4Cn1hvMLq/6UE9WAk51
	JHdIK9MhTedq/BCaK7NiOKlxW6UNC1yZPfdT0KIcPtseqSLS7fgi
X-Google-Smtp-Source: AGHT+IFFYd4ZVwapqGVLHQyRGjAgCainehmvv8TwM5P2Gzk9wn1aPEvlnFBnJSxrHBUMh/MKn/hyAQ==
X-Received: by 2002:a05:6830:6018:b0:707:1794:6f9c with SMTP id 46e09a7af769-70cac8901c7mr12590473a34.22.1724086133445;
        Mon, 19 Aug 2024 09:48:53 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70ca649c61csm2332428a34.26.2024.08.19.09.48.52
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
Subject: [PATCH V3 13/15] power: supply: axp20x_usb_power: Add support for AXP717
Date: Mon, 19 Aug 2024 11:46:17 -0500
Message-Id: <20240819164619.556309-14-macroalpha82@gmail.com>
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


