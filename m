Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F2854BAC6
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jun 2022 21:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344143AbiFNTmi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jun 2022 15:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343925AbiFNTmi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jun 2022 15:42:38 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2581EC76;
        Tue, 14 Jun 2022 12:42:36 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bg6so19277863ejb.0;
        Tue, 14 Jun 2022 12:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iHBrk/R6rOQSUwzKFPbJ8q27LHisn+BQKnnz2b2fGcs=;
        b=H35454TY3tR6vSzQkhYmJu9fksU5jHiSzl8VMbQvIuHJk8ZutH7z51kTeodM7RSKiM
         QfN/1iorvITM7Zavlr+Lro3sKnwKo2AgKr4v02lqwBO34HxkFR4fflgJ14CMJHuHwima
         PbBEmadtFxXN1ozVqhCg4FEoxDH6bbA+oS5bKI7RpXMcAnrUPNaDKK09VpDXnSA2vPUN
         vugrz4jNcmN8pHeL0BJxhYMzG6zDCKSf9iLb95kzrHwpcHYKSFTRSTaaenqfmXv1EKLh
         hV1FkeGw54Q5/b5Dh+dtFnjrj9UAWZLjGa7HqZYJD9zReEAFBmrj2qbuk2xsX2IevdRo
         qLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iHBrk/R6rOQSUwzKFPbJ8q27LHisn+BQKnnz2b2fGcs=;
        b=nt6iDgIxJ/pwnoP2eKoUz0n1qFcyazJJPCjznOrYCzVlU2DWeBsdkjp1mm2M8UTkgL
         6fKTOKQy2BzT3qqL/In0KVTc/nwtJaRr51QSpyqhmjHurGLxfXBWCBx0WlGXux071MQ4
         KjMphBQkbVLZhusACDTZvWbw8Atr1Nd4h1VB+zbg96HSp6tWT0uyVln5m1rWkTnkF+Jb
         5vipTwIlYly0I7TmBE+Hdc/YOG6Ep+m0C8Ov990j97Y6kN5irrVujLoUOLaVobH6IbPI
         Ci+hV3nDQPfasIlr9UUMeuHjXnhdyPVjGBSU18JViN93qRfpg+amPutzMiS7hwW7XFmo
         fSQw==
X-Gm-Message-State: AOAM5329HcHeO0GRhngepRKfIyM3fpnVVi2xueKzGFTbIdQSxpa1//nY
        z+bbgUi+aFL73I1wZ9Qq8Zk=
X-Google-Smtp-Source: ABdhPJzMSFIfMhIpaGGdIJmGyaXGao5nSGLm0+g1w6dlE+B1pA4SvyiRCWyOEoJ6sWU11eKV2pUu6g==
X-Received: by 2002:a17:906:c01:b0:711:917c:4c58 with SMTP id s1-20020a1709060c0100b00711917c4c58mr5869170ejf.291.1655235756336;
        Tue, 14 Jun 2022 12:42:36 -0700 (PDT)
Received: from localhost.localdomain (p5b3f7f9c.dip0.t-ipconnect.de. [91.63.127.156])
        by smtp.gmail.com with ESMTPSA id vw5-20020a170907058500b00712057b037fsm5306699ejb.167.2022.06.14.12.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 12:42:35 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v2 5/6] power: supply: Add support for mp2733 battery charger
Date:   Tue, 14 Jun 2022 21:42:24 +0200
Message-Id: <20220614194225.2226447-5-sravanhome@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220614194225.2226447-1-sravanhome@gmail.com>
References: <20220614194225.2226447-1-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

mp2733 is updated version of mp2629 battery charge management
which supports USB fast-charge and higher range of input voltage.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 drivers/power/supply/mp2629_charger.c | 208 ++++++++++++++++++++++----
 1 file changed, 179 insertions(+), 29 deletions(-)

diff --git a/drivers/power/supply/mp2629_charger.c b/drivers/power/supply/mp2629_charger.c
index bf9c27b463a8..8d4175d0504f 100644
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
+	int (*mpxx_get_usb_type)(unsigned int rval);
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
+		val->intval = charger->chip_info->mpxx_get_usb_type(rval);
 		break;
 
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
@@ -556,6 +628,60 @@ static struct attribute *mp2629_charger_sysfs_attrs[] = {
 };
 ATTRIBUTE_GROUPS(mp2629_charger_sysfs);
 
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
+static struct attribute *mp2733_charger_sysfs_attrs[] = {
+	&dev_attr_usb_fast_charge.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(mp2733_charger_sysfs);
+
 static void mp2629_charger_disable(void *data)
 {
 	struct mp2629_charger *charger = data;
@@ -564,6 +690,23 @@ static void mp2629_charger_disable(void *data)
 					MP2629_MASK_CHARGE_CTRL, 0);
 }
 
+static const struct mp2xx_chip_info mp2xx_chip_info_tbl[] = {
+	[CHIP_ID_MP2629] = {
+		.rfields = mp2629_reg_fields,
+		.chip_props = mp2629_chip_props,
+		.has_impedance = 1,
+
+		.mpxx_get_usb_type = mp2629_get_usb_type,
+	},
+	[CHIP_ID_MP2733] = {
+		.rfields = mp2733_reg_fields,
+		.chip_props = mp2733_chip_props,
+		.has_fast_charge = 1,
+
+		.mpxx_get_usb_type = mp2733_get_usb_type,
+	},
+};
+
 static int mp2629_charger_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -578,6 +721,7 @@ static int mp2629_charger_probe(struct platform_device *pdev)
 
 	charger->regmap = ddata->regmap;
 	charger->dev = dev;
+	charger->chip_info = &mp2xx_chip_info_tbl[ddata->chip_id];
 	platform_set_drvdata(pdev, charger);
 
 	irq = platform_get_irq(to_platform_device(dev->parent), 0);
@@ -586,7 +730,8 @@ static int mp2629_charger_probe(struct platform_device *pdev)
 
 	for (i = 0; i < MP2629_MAX_FIELD; i++) {
 		charger->regmap_fields[i] = devm_regmap_field_alloc(dev,
-					charger->regmap, mp2629_reg_fields[i]);
+					charger->regmap,
+					charger->chip_info->rfields[i]);
 		if (IS_ERR(charger->regmap_fields[i])) {
 			dev_err(dev, "regmap field alloc fail %d\n", i);
 			return PTR_ERR(charger->regmap_fields[i]);
@@ -613,7 +758,12 @@ static int mp2629_charger_probe(struct platform_device *pdev)
 	}
 
 	psy_cfg.drv_data = charger;
-	psy_cfg.attr_grp = mp2629_charger_sysfs_groups;
+	if (charger->chip_info->has_impedance)
+		psy_cfg.attr_grp = mp2629_charger_sysfs_groups;
+
+	if (charger->chip_info->has_fast_charge)
+		psy_cfg.attr_grp = mp2733_charger_sysfs_groups;
+
 	charger->battery = devm_power_supply_register(dev,
 					 &mp2629_battery_desc, &psy_cfg);
 	if (IS_ERR(charger->battery)) {
-- 
2.25.1

