Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1B06367C7
	for <lists+linux-iio@lfdr.de>; Wed, 23 Nov 2022 18:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239279AbiKWRzP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Nov 2022 12:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239298AbiKWRzJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Nov 2022 12:55:09 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFB76A6AE;
        Wed, 23 Nov 2022 09:55:07 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id f9so13180040pgf.7;
        Wed, 23 Nov 2022 09:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orj5zmzIKR7QW+91Ap7/jvHRciPjHKTw/L4LGYwZM1o=;
        b=PC7675NGGmpHBZx19VsvHHuOIFN6FjIKPh3S5/f3G7cWSfOlFtVp3m8Od/6kGfd9EC
         ZRxH+9JmyDa5YV6+UOzb+NITucMv0s94JNf/cPA14JFeXDZDM9a21bE/19HQXsxmGXIb
         pDu+ngVGr+FIwnMxmaUuwVoj/wNR4d3xmk/5CUyGLWe5l62uLtWLBTvBto+54DjoAHzR
         jE32eunuJKYjQcPG0+w8Xm4h7P5/+fy03cj9s2EXAyZ2OXZSO5gV1ibcIpnTZDXnBLCW
         xwvyG20XHH0ljuWCjeMycO38wIc+TbReGlo3Far37Ih2g024oq/IgHuB4p6FZKizNsKA
         QRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orj5zmzIKR7QW+91Ap7/jvHRciPjHKTw/L4LGYwZM1o=;
        b=IpDt65ztnSbwtE8ZofAUR+d0WQYH68DzA+8SuVara1Csm9/JhMsHbmsdD2qIYwo500
         rYYRXu92ifr5DpG47ywYfTgaKz/o60e0y48CFUaZgfmhYLMz5wkEixlpZh4qeYLyU+W3
         e5K5GKxh4oounO7Jaq5efyeDOZMruGBKHuqpkK7mTl+RhVsnPhnCWdkxGjT/VDw9KGVN
         Y/wyOcnrcKfkAt1Sb9nsh8WiLFYrZoTdzD2SwNnmuQXu6PKQfjLCw7wha+1hyVPepTho
         /84xaBLLOcPdiIQZyv8u49u3U5bzD4E0RmeHJYOeEGAFmuHhTKPZoTAapTgMM5GLw++F
         vTjg==
X-Gm-Message-State: ANoB5pkZ2k+j9EYI5nzj4MLU5RVhpDItR8yQM9E9ZE3THDN1862Hyxvw
        haGjEPeDZvVaEOI2B1GOc0pSpBBJYkE=
X-Google-Smtp-Source: AA0mqf7+utv1EwXC+8WhgpzCtOzmO5tUdQsZLuqGnmT9WaC6cjxZ7J1yEnd0bETZufkOzi2BNEXxog==
X-Received: by 2002:aa7:9245:0:b0:571:3fb3:9b5f with SMTP id 5-20020aa79245000000b005713fb39b5fmr31072791pfp.86.1669226107396;
        Wed, 23 Nov 2022 09:55:07 -0800 (PST)
Received: from discovery.. ([2401:4900:483b:e422:60e:77bf:baa2:9d8b])
        by smtp.gmail.com with ESMTPSA id y76-20020a62644f000000b0057470a06694sm837503pfb.40.2022.11.23.09.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 09:55:06 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee@kernel.org, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v6 6/7] power: supply: Add support for mp2733 battery charger
Date:   Wed, 23 Nov 2022 18:54:24 +0100
Message-Id: <20221123175425.564042-7-sravanhome@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221123175425.564042-1-sravanhome@gmail.com>
References: <20221123175425.564042-1-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

mp2733 is updated version of mp2629 battery charge management
which supports USB fast-charge and higher range of input voltage.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/mp2629_charger.c | 223 ++++++++++++++++++++++----
 1 file changed, 192 insertions(+), 31 deletions(-)

diff --git a/drivers/power/supply/mp2629_charger.c b/drivers/power/supply/mp2629_charger.c
index 46d620bd23b9..2ff3729afc48 100644
--- a/drivers/power/supply/mp2629_charger.c
+++ b/drivers/power/supply/mp2629_charger.c
@@ -30,12 +30,15 @@
 #define MP2629_REG_INTERRUPT		0x0b
 #define MP2629_REG_STATUS		0x0c
 #define MP2629_REG_FAULT		0x0d
+#define MP2629_REG_FAST_CHARGE		0x17
 
 #define MP2629_MASK_INPUT_TYPE		GENMASK(7, 5)
 #define MP2629_MASK_CHARGE_TYPE		GENMASK(4, 3)
 #define MP2629_MASK_CHARGE_CTRL		GENMASK(5, 4)
 #define MP2629_MASK_WDOG_CTRL		GENMASK(5, 4)
 #define MP2629_MASK_IMPEDANCE		GENMASK(7, 4)
+#define MP2733_MASK_FAST_CHARGE		GENMASK(2, 1)
+#define MP2733_MASK_FAST_CHARGE_RESET	BIT(0)
 
 #define MP2629_INPUTSOURCE_CHANGE	GENMASK(7, 5)
 #define MP2629_CHARGING_CHANGE		GENMASK(4, 3)
@@ -62,6 +65,17 @@ enum mp2629_source_type {
 	MP2629_SOURCE_TYPE_OTG = 7,
 };
 
+enum mp2733_source_type {
+	MP2733_SOURCE_TYPE_NO_INPUT,
+	MP2733_SOURCE_TYPE_NON_STD,
+	MP2733_SOURCE_TYPE_APPLE_1p0,
+	MP2733_SOURCE_TYPE_APPLE_2p1,
+	MP2733_SOURCE_TYPE_APPLE_2p4,
+	MP2733_SOURCE_TYPE_SDP,
+	MP2733_SOURCE_TYPE_CDP,
+	MP2733_SOURCE_TYPE_DCP,
+};
+
 enum mp2629_field {
 	INPUT_ILIM,
 	INPUT_VLIM,
@@ -72,11 +86,30 @@ enum mp2629_field {
 	MP2629_MAX_FIELD
 };
 
+struct mp2629_prop {
+	int reg;
+	int mask;
+	int min;
+	int max;
+	int step;
+	int shift;
+};
+
+struct mp2xx_chip_info {
+	const struct reg_field *rfields;
+	struct mp2629_prop *chip_props;
+	bool has_impedance;
+	bool has_fast_charge;
+
+	int (*mp2xx_get_usb_type)(unsigned int rval);
+};
+
 struct mp2629_charger {
 	struct device *dev;
 	int status;
 	int fault;
 
+	const struct mp2xx_chip_info *chip_info;
 	struct regmap *regmap;
 	struct regmap_field *regmap_fields[MP2629_MAX_FIELD];
 	struct mutex lock;
@@ -85,15 +118,6 @@ struct mp2629_charger {
 	struct iio_channel *iiochan[MP2629_ADC_CHAN_END];
 };
 
-struct mp2629_prop {
-	int reg;
-	int mask;
-	int min;
-	int max;
-	int step;
-	int shift;
-};
-
 static enum power_supply_usb_type mp2629_usb_types[] = {
 	POWER_SUPPLY_USB_TYPE_SDP,
 	POWER_SUPPLY_USB_TYPE_DCP,
@@ -126,7 +150,25 @@ static enum power_supply_property mp2629_charger_bat_props[] = {
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
 };
 
-static struct mp2629_prop props[] = {
+static struct mp2629_prop mp2733_chip_props[] = {
+	MP2629_PROPS(INPUT_ILIM, 100000, 3250000, 50000),
+	MP2629_PROPS(INPUT_VLIM, 3800000, 15200000, 100000),
+	MP2629_PROPS(CHARGE_ILIM, 320000, 4520000, 40000),
+	MP2629_PROPS(CHARGE_VLIM, 3400000, 4670000, 10000),
+	MP2629_PROPS(PRECHARGE, 120000, 720000, 40000),
+	MP2629_PROPS(TERM_CURRENT, 80000, 680000, 40000),
+};
+
+static const struct reg_field mp2733_reg_fields[] = {
+	[INPUT_ILIM]	= REG_FIELD(MP2629_REG_INPUT_ILIM, 0, 5),
+	[INPUT_VLIM]	= REG_FIELD(MP2629_REG_INPUT_VLIM, 0, 6),
+	[CHARGE_ILIM]	= REG_FIELD(MP2629_REG_CHARGE_ILIM, 0, 6),
+	[CHARGE_VLIM]	= REG_FIELD(MP2629_REG_CHARGE_VLIM, 1, 7),
+	[PRECHARGE]	= REG_FIELD(MP2629_REG_PRECHARGE, 4, 7),
+	[TERM_CURRENT]	= REG_FIELD(MP2629_REG_TERM_CURRENT, 0, 3),
+};
+
+static struct mp2629_prop mp2629_chip_props[] = {
 	MP2629_PROPS(INPUT_ILIM, 100000, 3250000, 50000),
 	MP2629_PROPS(INPUT_VLIM, 3800000, 5300000, 100000),
 	MP2629_PROPS(CHARGE_ILIM, 320000, 4520000, 40000),
@@ -174,6 +216,7 @@ static int mp2629_get_prop(struct mp2629_charger *charger,
 {
 	int ret;
 	unsigned int rval;
+	struct mp2629_prop *props = charger->chip_info->chip_props;
 
 	ret = regmap_field_read(charger->regmap_fields[fld], &rval);
 	if (ret)
@@ -189,6 +232,7 @@ static int mp2629_set_prop(struct mp2629_charger *charger,
 			   const union power_supply_propval *val)
 {
 	unsigned int rval;
+	struct mp2629_prop *props = charger->chip_info->chip_props;
 
 	if (val->intval < props[fld].min || val->intval > props[fld].max)
 		return -EINVAL;
@@ -311,6 +355,16 @@ static int mp2629_charger_battery_get_prop(struct power_supply *psy,
 		default:
 			val->intval = POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
 		}
+
+		if (charger->chip_info->has_fast_charge) {
+			ret = regmap_read(charger->regmap,
+					  MP2629_REG_FAST_CHARGE, &rval);
+			if (ret)
+				break;
+
+			if (rval & BIT(6))
+				val->intval = POWER_SUPPLY_CHARGE_TYPE_FAST;
+		}
 		break;
 
 	default:
@@ -344,6 +398,40 @@ static int mp2629_charger_battery_set_prop(struct power_supply *psy,
 	}
 }
 
+static int mp2733_get_usb_type(unsigned int rval)
+{
+	switch (rval) {
+	case MP2733_SOURCE_TYPE_APPLE_1p0:
+	case MP2733_SOURCE_TYPE_APPLE_2p1:
+	case MP2733_SOURCE_TYPE_APPLE_2p4:
+		return POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID;
+	case MP2733_SOURCE_TYPE_SDP:
+		return POWER_SUPPLY_USB_TYPE_SDP;
+	case MP2733_SOURCE_TYPE_CDP:
+		return POWER_SUPPLY_USB_TYPE_CDP;
+	case MP2733_SOURCE_TYPE_DCP:
+		return POWER_SUPPLY_USB_TYPE_DCP;
+	default:
+		return POWER_SUPPLY_USB_TYPE_UNKNOWN;
+	}
+}
+
+static int mp2629_get_usb_type(unsigned int rval)
+{
+	switch (rval) {
+	case MP2629_SOURCE_TYPE_SDP:
+		return POWER_SUPPLY_USB_TYPE_SDP;
+	case MP2629_SOURCE_TYPE_CDP:
+		return POWER_SUPPLY_USB_TYPE_CDP;
+	case MP2629_SOURCE_TYPE_DCP:
+		return POWER_SUPPLY_USB_TYPE_DCP;
+	case MP2629_SOURCE_TYPE_OTG:
+		return POWER_SUPPLY_USB_TYPE_PD_DRP;
+	default:
+		return POWER_SUPPLY_USB_TYPE_UNKNOWN;
+	}
+}
+
 static int mp2629_charger_usb_get_prop(struct power_supply *psy,
 				enum power_supply_property psp,
 				union power_supply_propval *val)
@@ -367,23 +455,7 @@ static int mp2629_charger_usb_get_prop(struct power_supply *psy,
 			break;
 
 		rval = (rval & MP2629_MASK_INPUT_TYPE) >> 5;
-		switch (rval) {
-		case MP2629_SOURCE_TYPE_SDP:
-			val->intval = POWER_SUPPLY_USB_TYPE_SDP;
-			break;
-		case MP2629_SOURCE_TYPE_CDP:
-			val->intval = POWER_SUPPLY_USB_TYPE_CDP;
-			break;
-		case MP2629_SOURCE_TYPE_DCP:
-			val->intval = POWER_SUPPLY_USB_TYPE_DCP;
-			break;
-		case MP2629_SOURCE_TYPE_OTG:
-			val->intval = POWER_SUPPLY_USB_TYPE_PD_DRP;
-			break;
-		default:
-			val->intval = POWER_SUPPLY_USB_TYPE_UNKNOWN;
-			break;
-		}
+		val->intval = charger->chip_info->mp2xx_get_usb_type(rval);
 		break;
 
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
@@ -550,11 +622,72 @@ static ssize_t batt_impedance_compensation_store(struct device *dev,
 
 static DEVICE_ATTR_RW(batt_impedance_compensation);
 
-static struct attribute *mp2629_charger_sysfs_attrs[] = {
+static struct attribute *mp2xx_batt_imp_sysfs_attrs[] = {
+	&dev_attr_batt_impedance_compensation.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(mp2xx_batt_imp_sysfs);
+
+static ssize_t usb_fast_charge_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct mp2629_charger *charger = dev_get_drvdata(dev->parent);
+	unsigned int rval;
+	int ret;
+
+	ret = regmap_read(charger->regmap, MP2629_REG_INTERRUPT, &rval);
+	if (ret)
+		return ret;
+
+	return  sysfs_emit(buf, "USB DP %u:DM %u\n", !!(rval & BIT(2)),
+			 !!(rval & BIT(1)));
+}
+
+static ssize_t usb_fast_charge_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf,
+				     size_t count)
+{
+	struct mp2629_charger *charger = dev_get_drvdata(dev->parent);
+	unsigned int val;
+	int ret;
+
+	ret = kstrtouint(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val > 3)
+		return -ERANGE;
+
+	ret = regmap_update_bits(charger->regmap, MP2629_REG_INTERRUPT,
+				 MP2733_MASK_FAST_CHARGE, val << 1);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(charger->regmap, MP2629_REG_INTERRUPT,
+				 MP2733_MASK_FAST_CHARGE_RESET,
+				 MP2733_MASK_FAST_CHARGE_RESET);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(usb_fast_charge);
+
+static struct attribute *mp2xx_fast_charge_sysfs_attrs[] = {
+	&dev_attr_usb_fast_charge.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(mp2xx_fast_charge_sysfs);
+
+static struct attribute *mp2xx_all_sysfs_attrs[] = {
+	&dev_attr_usb_fast_charge.attr,
 	&dev_attr_batt_impedance_compensation.attr,
 	NULL
 };
-ATTRIBUTE_GROUPS(mp2629_charger_sysfs);
+ATTRIBUTE_GROUPS(mp2xx_all_sysfs);
 
 static void mp2629_charger_disable(void *data)
 {
@@ -564,6 +697,23 @@ static void mp2629_charger_disable(void *data)
 					MP2629_MASK_CHARGE_CTRL, 0);
 }
 
+static const struct mp2xx_chip_info mp2xx_chip_info_tbl[] = {
+	[CHIP_ID_MP2629] = {
+		.rfields = mp2629_reg_fields,
+		.chip_props = mp2629_chip_props,
+		.has_impedance = 1,
+
+		.mp2xx_get_usb_type = mp2629_get_usb_type,
+	},
+	[CHIP_ID_MP2733] = {
+		.rfields = mp2733_reg_fields,
+		.chip_props = mp2733_chip_props,
+		.has_fast_charge = 1,
+
+		.mp2xx_get_usb_type = mp2733_get_usb_type,
+	},
+};
+
 static int mp2629_charger_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -578,6 +728,7 @@ static int mp2629_charger_probe(struct platform_device *pdev)
 
 	charger->regmap = ddata->regmap;
 	charger->dev = dev;
+	charger->chip_info = &mp2xx_chip_info_tbl[ddata->chip_id];
 	platform_set_drvdata(pdev, charger);
 
 	irq = platform_get_irq(to_platform_device(dev->parent), 0);
@@ -586,7 +737,8 @@ static int mp2629_charger_probe(struct platform_device *pdev)
 
 	for (i = 0; i < MP2629_MAX_FIELD; i++) {
 		charger->regmap_fields[i] = devm_regmap_field_alloc(dev,
-					charger->regmap, mp2629_reg_fields[i]);
+					charger->regmap,
+					charger->chip_info->rfields[i]);
 		if (IS_ERR(charger->regmap_fields[i])) {
 			dev_err(dev, "regmap field alloc fail %d\n", i);
 			return PTR_ERR(charger->regmap_fields[i]);
@@ -613,7 +765,16 @@ static int mp2629_charger_probe(struct platform_device *pdev)
 	}
 
 	psy_cfg.drv_data = charger;
-	psy_cfg.attr_grp = mp2629_charger_sysfs_groups;
+
+	if (charger->chip_info->has_impedance &&
+	    charger->chip_info->has_fast_charge) {
+		psy_cfg.attr_grp = mp2xx_all_sysfs_groups;
+	} else if (charger->chip_info->has_impedance) {
+		psy_cfg.attr_grp = mp2xx_batt_imp_sysfs_groups;
+	} else if (charger->chip_info->has_fast_charge) {
+		psy_cfg.attr_grp = mp2xx_fast_charge_sysfs_groups;
+	}
+
 	charger->battery = devm_power_supply_register(dev,
 					 &mp2629_battery_desc, &psy_cfg);
 	if (IS_ERR(charger->battery)) {
-- 
2.34.1

