Return-Path: <linux-iio+bounces-6438-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3169C90BD50
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 00:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37AC41C210ED
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 22:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861AA19A290;
	Mon, 17 Jun 2024 22:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEgZz8no"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B093199EA7;
	Mon, 17 Jun 2024 22:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718661968; cv=none; b=AChkhySl5Nt33GRdDqKrOIcTQNZAhZTN0FDeOVT/we5drAyKf8m0u/ZmJmfUVRXMYlwH5i/OsB2KrkI/dR/2vevblMnBnT7XLoF47Qr3lZdI9pliMSJM9TOn0D6/dxXuAS57UfWZ+T4urNAk8iZccifxRzwHw6eMAtBdy8CQdtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718661968; c=relaxed/simple;
	bh=TvT0z3C54FYFc5vYp0f3D6asRMN9eBfjhrrA1A+4lRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dSRl3ANMluWfWxdFJmazV1Q6XhYlzKpJ8g9/kpgyNExTvDclYFwOssHsAxqHEK9wRlZBM/xHzsMA2f3gdk9PkeytCSglWJJWChobGRxwldhENAT28Z965LrGm6B3U6BysnD5sQYn9GWdsvwOWvCCuUXJTYKNFeELqmnLlXaPNY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEgZz8no; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f9b213ebf9so2044782a34.1;
        Mon, 17 Jun 2024 15:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718661965; x=1719266765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaG42Wz3C+u5uZVgkIeRT5xMMFnVPmxzVdABnPuJWXE=;
        b=FEgZz8nokUsmJb5GYy2iAhh841miV36ebyGwkl8qggZV9xyVNfxnLQ3SC3MsXG4Gch
         941/A8JLsdyrjod7m+64kDltE1amlYqv++sW9v4/PlaYxXVJXu0ki5Cr0xTeUO6wfRgr
         tIxtgd1dm3S4jP27I3cpMd8BGYgmG0g70bNGXP8RGdtoYJDFjqHhMFAsodoC+KNu00Ce
         Qc/eqFwabPQKLy0H8UhaRTcriGw6ni8VGb9ZLCRTu/DIOLFr8L+ma2g8PRrK2+I/nVPh
         Y41XBFkSQoRLMRyWI0xFwpXT31s34Ij+NFbA7J6m1DSpgtL1rN8Whcl1nHPJ4ciA8W9q
         61fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718661965; x=1719266765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CaG42Wz3C+u5uZVgkIeRT5xMMFnVPmxzVdABnPuJWXE=;
        b=AkvMeaLjbZj0jhl+rzNJ9zYJwDNRTRCydL2J5h+YIXwSxjZeoJCoGRpUE+SkAkQWDO
         qy4vshAcE9glg/BF5PgwsgmftZ2QDZXOveOnxHrXc1DijQsRXube84zoLs0JMaDTJjhy
         F8jirJaX+EgNONw++8rOJIjSnqajgRxVqfcTLwLR1R/6ebhVQqIImV4/dFKPjRISw4Nj
         jJxb0hy31NzDgBFpcGCa86NlDOLC0gk6Utr39YjPxZCE+VIsjrrlI3v8i39saNZ2itAn
         TUQ9l7YP3JG4XGrB2JWHovXhFNMvhybtr4xphInYI25nGXxylU1LOlN378XsyGoLxGTB
         cycw==
X-Forwarded-Encrypted: i=1; AJvYcCXxjykulkjMxv7dnKYrmzQTAls3GhOUe35dpKbBU50ZO9I2W4pLur8pm2HZQI3CBq6AlvPQCih+l2tt/+G/KpbJqsBbyIyQYh4QH9YYmaQtzo0IL31QhOkzS7XxC1QO0YsxtL29cg==
X-Gm-Message-State: AOJu0YwtVs6WGIhFa2rnIN0Lcf6AEUH6Btp3qn0gmkeJUdoUSI/+BI5z
	sxYqk50jhMwesm2gwtamrUTPGlJxlOu3sXhE6d70HOxxioTLtqCJB0RTxA==
X-Google-Smtp-Source: AGHT+IFIsWoz8wLgQwjvcJRsd3rkTLG9sHik7nmh8yKB4pr/6rnIAE2IfdyuY/AeueJsvaP9BwW+nw==
X-Received: by 2002:a05:6830:4b4:b0:6f9:d2ce:7627 with SMTP id 46e09a7af769-6ff15cd2e42mr444600a34.3.1718661965350;
        Mon, 17 Jun 2024 15:06:05 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6fb5b1b0fa8sm1664232a34.28.2024.06.17.15.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 15:06:04 -0700 (PDT)
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
Subject: [PATCH 6/8] power: supply: axp20x_usb_power: Add support for AXP717
Date: Mon, 17 Jun 2024 17:05:33 -0500
Message-Id: <20240617220535.359021-7-macroalpha82@gmail.com>
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

Add support for the AXP717 PMIC. The AXP717 PMIC allows for detection
of USB type like the AXP813, but has little in common otherwise with
the other AXP PMICs. The USB charger is able to provide between
100000uA and 3250000uA of power, and can measure the VBUS input in mV
with up to 14 bits of precision.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/power/supply/axp20x_usb_power.c | 350 +++++++++++++++++++++---
 1 file changed, 314 insertions(+), 36 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index dae7e5cfc54e..c442dd005831 100644
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
@@ -39,12 +44,20 @@
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
  */
 #define DEBOUNCE_TIME			msecs_to_jiffies(50)
 
+struct axp20x_usb_power;
+
 struct axp_data {
 	const struct power_supply_desc	*power_desc;
 	const char * const		*irq_names;
@@ -58,6 +71,10 @@ struct axp_data {
 	struct reg_field		usb_bc_det_fld;
 	struct reg_field		vbus_disable_bit;
 	bool				vbus_needs_polling: 1;
+	void (*axp20x_read_vbus)(struct work_struct *work);
+	int (*axp20x_cfg_iio_chan)(struct platform_device *pdev,
+				   struct axp20x_usb_power *power);
+	int (*axp20x_cfg_adc_reg)(struct axp20x_usb_power *power);
 };
 
 struct axp20x_usb_power {
@@ -74,6 +91,7 @@ struct axp20x_usb_power {
 	struct iio_channel *vbus_v;
 	struct iio_channel *vbus_i;
 	struct delayed_work vbus_detect;
+	int max_input_cur;
 	unsigned int old_status;
 	unsigned int online;
 	unsigned int num_irqs;
@@ -136,6 +154,24 @@ static void axp20x_usb_power_poll_vbus(struct work_struct *work)
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
@@ -281,6 +317,84 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
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
@@ -307,16 +421,40 @@ static int axp20x_usb_power_set_voltage_min(struct axp20x_usb_power *power,
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
-	int ret;
+	int ret, val;
 	unsigned int reg;
 	const unsigned int max = power->axp_data->curr_lim_table_size;
 
 	if (intval == -1)
 		return -EINVAL;
 
+	if (power->max_input_cur && (intval > power->max_input_cur)) {
+		val = power->max_input_cur;
+		dev_warn(power->dev,
+			 "reqested current %d clamped to max current %d\n",
+			 intval, power->max_input_cur);
+	} else
+		val = intval;
+
 	/*
 	 * BC1.2 detection can cause a race condition if we try to set a current
 	 * limit while it's in progress. When it finishes it will overwrite the
@@ -331,15 +469,39 @@ static int axp20x_usb_power_set_input_current_limit(struct axp20x_usb_power *pow
 	}
 
 	for (reg = max - 1; reg > 0; reg--)
-		if (power->axp_data->curr_lim_table[reg] <= intval)
+		if (power->axp_data->curr_lim_table[reg] <= val)
 			break;
 
 	dev_dbg(power->dev, "setting input current limit reg to %d (%d uA), requested %d uA",
-		reg, power->axp_data->curr_lim_table[reg], intval);
+		reg, power->axp_data->curr_lim_table[reg], val);
 
 	return regmap_field_write(power->curr_lim_fld, reg);
 }
 
+static int axp717_usb_power_set_input_current_limit(struct axp20x_usb_power *power,
+						    int intval)
+{
+	int val, tmp;
+
+	/* Minimum value of 100mA and maximum value of 3.25A*/
+	if (intval < 100000 || intval > 3250000)
+		return -EINVAL;
+
+	if (power->max_input_cur && (intval > power->max_input_cur)) {
+		val = power->max_input_cur;
+		dev_warn(power->dev,
+			 "reqested current %d clamped to max current %d\n",
+			 intval, power->max_input_cur);
+	} else
+		val = intval;
+
+	/* Minimum value of 100mA with step size of 50mA. */
+	tmp = (val - 100000) / 50000;
+	return regmap_update_bits(power->regmap,
+				  AXP717_INPUT_CUR_LIMIT_CTRL,
+				  AXP717_INPUT_CUR_LIMIT_MASK, tmp);
+}
+
 static int axp20x_usb_power_set_property(struct power_supply *psy,
 					 enum power_supply_property psp,
 					 const union power_supply_propval *val)
@@ -366,6 +528,26 @@ static int axp20x_usb_power_set_property(struct power_supply *psy,
 	return -EINVAL;
 }
 
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
+
+	return -EINVAL;
+}
+
 static int axp20x_usb_power_prop_writeable(struct power_supply *psy,
 					   enum power_supply_property psp)
 {
@@ -385,6 +567,64 @@ static int axp20x_usb_power_prop_writeable(struct power_supply *psy,
 	       psp == POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT;
 }
 
+static int axp717_usb_power_prop_writeable(struct power_supply *psy,
+					   enum power_supply_property psp)
+{
+	return psp == POWER_SUPPLY_PROP_VOLTAGE_MIN ||
+	       psp == POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT;
+}
+
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
@@ -403,6 +643,16 @@ static enum power_supply_property axp22x_usb_power_properties[] = {
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
@@ -439,6 +689,18 @@ static const struct power_supply_desc axp22x_usb_power_desc = {
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
@@ -505,6 +767,9 @@ static const struct axp_data axp192_data = {
 	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
 	.vbus_valid_bit = REG_FIELD(AXP192_USB_OTG_STATUS, 2, 2),
 	.vbus_mon_bit   = REG_FIELD(AXP20X_VBUS_MON, 3, 3),
+	.axp20x_read_vbus = &axp20x_usb_power_poll_vbus,
+	.axp20x_cfg_iio_chan = axp20x_configure_iio_channels,
+	.axp20x_cfg_adc_reg = axp20x_configure_adc_registers,
 };
 
 static const struct axp_data axp202_data = {
@@ -516,6 +781,9 @@ static const struct axp_data axp202_data = {
 	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
 	.vbus_valid_bit = REG_FIELD(AXP20X_USB_OTG_STATUS, 2, 2),
 	.vbus_mon_bit   = REG_FIELD(AXP20X_VBUS_MON, 3, 3),
+	.axp20x_read_vbus = &axp20x_usb_power_poll_vbus,
+	.axp20x_cfg_iio_chan = axp20x_configure_iio_channels,
+	.axp20x_cfg_adc_reg = axp20x_configure_adc_registers,
 };
 
 static const struct axp_data axp221_data = {
@@ -526,6 +794,9 @@ static const struct axp_data axp221_data = {
 	.curr_lim_table_size = ARRAY_SIZE(axp221_usb_curr_lim_table),
 	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
 	.vbus_needs_polling = true,
+	.axp20x_read_vbus = &axp20x_usb_power_poll_vbus,
+	.axp20x_cfg_iio_chan = axp20x_configure_iio_channels,
+	.axp20x_cfg_adc_reg = axp20x_configure_adc_registers,
 };
 
 static const struct axp_data axp223_data = {
@@ -536,6 +807,23 @@ static const struct axp_data axp223_data = {
 	.curr_lim_table_size = ARRAY_SIZE(axp20x_usb_curr_lim_table),
 	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
 	.vbus_needs_polling = true,
+	.axp20x_read_vbus = &axp20x_usb_power_poll_vbus,
+	.axp20x_cfg_iio_chan = axp20x_configure_iio_channels,
+	.axp20x_cfg_adc_reg = axp20x_configure_adc_registers,
+};
+
+static const struct axp_data axp717_data = {
+	.power_desc     = &axp717_usb_power_desc,
+	.irq_names      = axp22x_irq_names,
+	.num_irq_names  = ARRAY_SIZE(axp22x_irq_names),
+	.curr_lim_fld   = REG_FIELD(AXP717_INPUT_CUR_LIMIT_CTRL, 0, 5),
+	.usb_bc_en_bit  = REG_FIELD(AXP717_MODULE_EN_CONTROL_1, 4, 4),
+	.usb_bc_det_fld = REG_FIELD(AXP717_BC_DETECT, 5, 7),
+	.vbus_mon_bit   = REG_FIELD(AXP717_ADC_CH_EN_CONTROL, 2, 2),
+	.vbus_needs_polling = false,
+	.axp20x_read_vbus = &axp717_usb_power_poll_vbus,
+	.axp20x_cfg_iio_chan = axp717_configure_iio_channels,
+	.axp20x_cfg_adc_reg = axp717_configure_adc_registers,
 };
 
 static const struct axp_data axp813_data = {
@@ -549,6 +837,9 @@ static const struct axp_data axp813_data = {
 	.usb_bc_det_fld = REG_FIELD(AXP288_BC_DET_STAT, 5, 7),
 	.vbus_disable_bit = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 7, 7),
 	.vbus_needs_polling = true,
+	.axp20x_read_vbus = &axp20x_usb_power_poll_vbus,
+	.axp20x_cfg_iio_chan = axp20x_configure_iio_channels,
+	.axp20x_cfg_adc_reg = axp20x_configure_adc_registers,
 };
 
 #ifdef CONFIG_PM_SLEEP
@@ -590,36 +881,6 @@ static int axp20x_usb_power_resume(struct device *dev)
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
@@ -640,6 +901,18 @@ static int axp20x_regmap_field_alloc_optional(struct device *dev,
 	return 0;
 }
 
+/* Optionally allow users to specify a maximum charging current. */
+static void axp20x_charger_parse_dt_property(struct device *dev,
+					     struct axp20x_usb_power *power)
+{
+	int ret;
+
+	ret = device_property_read_u32(dev, "input-current-limit-microamp",
+				       &power->max_input_cur);
+	if (ret)
+		dev_dbg(dev, "%s() no input-current-limit specified\n", __func__);
+}
+
 static int axp20x_usb_power_probe(struct platform_device *pdev)
 {
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
@@ -676,6 +949,8 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 	if (IS_ERR(power->curr_lim_fld))
 		return PTR_ERR(power->curr_lim_fld);
 
+	axp20x_charger_parse_dt_property(&pdev->dev, power);
+
 	ret = axp20x_regmap_field_alloc_optional(&pdev->dev, power->regmap,
 						 axp_data->vbus_valid_bit,
 						 &power->vbus_valid_bit);
@@ -707,7 +982,7 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 		return ret;
 
 	ret = devm_delayed_work_autocancel(&pdev->dev, &power->vbus_detect,
-					   axp20x_usb_power_poll_vbus);
+					   axp_data->axp20x_read_vbus);
 	if (ret)
 		return ret;
 
@@ -718,9 +993,9 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 			return ret;
 
 		if (IS_ENABLED(CONFIG_AXP20X_ADC))
-			ret = configure_iio_channels(pdev, power);
+			ret = axp_data->axp20x_cfg_iio_chan(pdev, power);
 		else
-			ret = configure_adc_registers(power);
+			ret = axp_data->axp20x_cfg_adc_reg(power);
 
 		if (ret)
 			return ret;
@@ -778,6 +1053,9 @@ static const struct of_device_id axp20x_usb_power_match[] = {
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


