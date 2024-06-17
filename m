Return-Path: <linux-iio+bounces-6436-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9509890BD4B
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 00:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD662840FC
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 22:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C52199393;
	Mon, 17 Jun 2024 22:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcskVGzr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6369E19146C;
	Mon, 17 Jun 2024 22:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718661966; cv=none; b=C7wRU9vGvna9HabrhL/Q6XPNgA2EgxfVPII3GQevUB5jYYcJCeKTkk+efEyTvjc/pRAK7bwKXisDfIJsjRgjUMe6l4sWXMe1beYDk2fjHbhlvxCqrjdE658mgsCVZKaSHsH28PGghU4gPgEiGxM7KRJMcDhAurU1umrMRSRppoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718661966; c=relaxed/simple;
	bh=7W+zEzC3vXAhnwwYg1m5125PlBcZ0yMCdMRtGNi+7bQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EKfLz234BqayVqOoNptffY9lzDYb4MDGcLwULKLkIIkZG6Aa4/hi9Tx4bdonB6/vq3A9jm47pC2vQVIuwp22HOwGhOdDcKNQJWFNPxcpJY2Qwzi2GZx+bvtTzW8n1E0Pc+YTCm623BdBwPyGTe9ot35Dh6C1VTmxBfNssqrwBiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcskVGzr; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6f97b836c42so2821483a34.1;
        Mon, 17 Jun 2024 15:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718661963; x=1719266763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwIGCzrn9e+OTRycHSADYLuR/RgspG+7oK+u1Nm/RTs=;
        b=ZcskVGzrSgH2XppPE3kfiuA4xM9urU+eNWjpk59ERXkz02WlVEJ02JitwWMdJOz0Bu
         e55yl/gRs4pOJYlWWKeBU6He6XiD+yxE8W/wJec/vUl45u+vay1VdbsnbeVM27RSZust
         omqhAHt5IovGEa+dBZVFTU0R9VC7pgqnwGTfnnH8edeJiR5POVL4+G6CWLboicGVs4+3
         C8TWqvU9QDV1Uo5dGnTkSjfskQo4jLv+i4AxGhCtrQcSf5xvUmncj8s5L7wPYcB0eJJY
         OgbgRRpQi8Uz//Mww/8rhwVVucJrxvjMlzXqZoIQcAPs0zjUAQsV0E5Y+L4LrQ3EulbE
         yr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718661963; x=1719266763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gwIGCzrn9e+OTRycHSADYLuR/RgspG+7oK+u1Nm/RTs=;
        b=cOVkccddtCEBfwUZnPskTLtCaGmoLXVvCH0VO4q3GD/X71vsvOuJylnXqEcafF5A3g
         zqdDYVSI9xtrrBT9qKUxvsdsoGAuICUCM3LUsW0rFTtmKxM+rSRhg2rne8WXbfbkGhdm
         +UzbXthxmeX1PxRVMbna6wMdBEnhYkYx5H76U50NlrgkrmVjFgxyKozpCF7KbkQN5ysd
         4QT5OLQf8BBhYrnX55qJM+qFcSIiAdTRdMDanv3GH3Br4YTTZMbdjdGDjilHBSovXA8B
         zesPQoVP9afuZYd7b7TWSWQr0mI1VQPGAtc6gGfjbBHwntZ9+2oFmIZpVvGOzcHQnQew
         /2Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUgSCDDAHx2iVq/wxlyJ2zF6Goj/LzFMqleQOWNXOIzku+OZGQAYbzJg+dW2O4wns6L1JOmx5QiYcnV/9QcdP21IYoi82PdXFBZctDMB7PIs4LKunHif2RwJ/YJeyFxqGzvzpE3gA==
X-Gm-Message-State: AOJu0Yxs70qRdmV5n9uqidiUUczWAEkh89lrlIw2LjWf/ILh3SoJ/X+8
	Pwnei1RYnu3R8vuV+ojwgh3oLFmUMuzzVXMWlTlm+KZjmZ25kraw
X-Google-Smtp-Source: AGHT+IH+BJi6sHo6LCYmv5GY+d5V0KJOmJZoT5JeyfTGtL7+u2rP6PM8K5xHKrmlkUm+Gxz9BtCinw==
X-Received: by 2002:a9d:5608:0:b0:6f9:88a6:f94f with SMTP id 46e09a7af769-6fb93891669mr11990016a34.31.1718661963480;
        Mon, 17 Jun 2024 15:06:03 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6fb5b1b0fa8sm1664232a34.28.2024.06.17.15.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 15:06:03 -0700 (PDT)
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
Subject: [PATCH 4/8] mfd: axp20x: Add ADC, BAT, and USB cells for AXP717
Date: Mon, 17 Jun 2024 17:05:31 -0500
Message-Id: <20240617220535.359021-5-macroalpha82@gmail.com>
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

Add support for the AXP717 PMIC to utilize the ADC (for reading
voltage, current, and temperature information from the PMIC) as well
as the USB charger and battery.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/mfd/axp20x.c                 | 30 +++++++++++++++++++++++++---
 drivers/regulator/axp20x-regulator.c |  2 +-
 include/linux/mfd/axp20x.h           | 26 +++++++++++++++++++++++-
 3 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 609e7e149681..07db4a11acbc 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -209,15 +209,23 @@ static const struct regmap_access_table axp313a_volatile_table = {
 };
 
 static const struct regmap_range axp717_writeable_ranges[] = {
-	regmap_reg_range(AXP717_MODULE_EN_CONTROL, AXP717_MODULE_EN_CONTROL),
-	regmap_reg_range(AXP717_BOOST_CONTROL, AXP717_BOOST_CONTROL),
+	regmap_reg_range(AXP717_PMU_FAULT, AXP717_MODULE_EN_CONTROL_1),
+	regmap_reg_range(AXP717_MIN_SYS_V_CONTROL, AXP717_BOOST_CONTROL),
+	regmap_reg_range(AXP717_VSYS_V_POWEROFF, AXP717_VSYS_V_POWEROFF),
 	regmap_reg_range(AXP717_IRQ0_EN, AXP717_IRQ4_EN),
 	regmap_reg_range(AXP717_IRQ0_STATE, AXP717_IRQ4_STATE),
+	regmap_reg_range(AXP717_ICC_CHG_SET, AXP717_CV_CHG_SET),
 	regmap_reg_range(AXP717_DCDC_OUTPUT_CONTROL, AXP717_CPUSLDO_CONTROL),
+	regmap_reg_range(AXP717_ADC_CH_EN_CONTROL, AXP717_ADC_CH_EN_CONTROL),
+	regmap_reg_range(AXP717_ADC_DATA_SEL, AXP717_ADC_DATA_SEL),
 };
 
 static const struct regmap_range axp717_volatile_ranges[] = {
+	regmap_reg_range(AXP717_ON_INDICATE, AXP717_PMU_FAULT),
 	regmap_reg_range(AXP717_IRQ0_STATE, AXP717_IRQ4_STATE),
+	regmap_reg_range(AXP717_BATT_PERCENT_DATA, AXP717_BATT_PERCENT_DATA),
+	regmap_reg_range(AXP717_BATT_V_H, AXP717_BATT_CHRG_I_L),
+	regmap_reg_range(AXP717_ADC_DATA_H, AXP717_ADC_DATA_L),
 };
 
 static const struct regmap_access_table axp717_writeable_table = {
@@ -310,6 +318,11 @@ static const struct resource axp22x_usb_power_supply_resources[] = {
 	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
 };
 
+static const struct resource axp717_usb_power_supply_resources[] = {
+	DEFINE_RES_IRQ_NAMED(AXP717_IRQ_VBUS_PLUGIN, "VBUS_PLUGIN"),
+	DEFINE_RES_IRQ_NAMED(AXP717_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
+};
+
 /* AXP803 and AXP813/AXP818 share the same interrupts */
 static const struct resource axp803_usb_power_supply_resources[] = {
 	DEFINE_RES_IRQ_NAMED(AXP803_IRQ_VBUS_PLUGIN, "VBUS_PLUGIN"),
@@ -424,7 +437,7 @@ static const struct regmap_config axp717_regmap_config = {
 	.val_bits = 8,
 	.wr_table = &axp717_writeable_table,
 	.volatile_table = &axp717_volatile_table,
-	.max_register = AXP717_CPUSLDO_CONTROL,
+	.max_register = AXP717_ADC_DATA_L,
 	.cache_type = REGCACHE_MAPLE,
 };
 
@@ -1026,6 +1039,17 @@ static struct mfd_cell axp313a_cells[] = {
 static struct mfd_cell axp717_cells[] = {
 	MFD_CELL_NAME("axp20x-regulator"),
 	MFD_CELL_RES("axp20x-pek", axp717_pek_resources),
+	{
+		.name		= "axp717-adc",
+		.of_compatible	= "x-powers,axp717-adc",
+	},
+	MFD_CELL_OF("axp20x-usb-power-supply",
+		    axp717_usb_power_supply_resources, NULL, 0, 0,
+		    "x-powers,axp717-usb-power-supply"),
+	{
+		.name		= "axp20x-battery-power-supply",
+		.of_compatible	= "x-powers,axp717-battery-power-supply",
+	},
 };
 
 static const struct resource axp288_adc_resources[] = {
diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 20bef3971fec..a8e91d9d028b 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -837,7 +837,7 @@ static const struct regulator_desc axp717_regulators[] = {
 		 AXP717_LDO1_OUTPUT_CONTROL, BIT(4)),
 	AXP_DESC(AXP717, BOOST, "boost", "vin1", 4550, 5510, 64,
 		 AXP717_BOOST_CONTROL, AXP717_BOOST_V_OUT_MASK,
-		 AXP717_MODULE_EN_CONTROL, BIT(4)),
+		 AXP717_MODULE_EN_CONTROL_2, BIT(4)),
 };
 
 /* DCDC ranges shared with AXP813 */
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 5e86b976c4ca..f4dfc1871a95 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -115,8 +115,16 @@ enum axp20x_variants {
 #define AXP313A_IRQ_STATE		0x21
 
 #define AXP717_ON_INDICATE		0x00
-#define AXP717_MODULE_EN_CONTROL	0x19
+#define AXP717_PMU_STATUS_2		0x01
+#define AXP717_BC_DETECT		0x05
+#define AXP717_PMU_FAULT		0x08
+#define AXP717_MODULE_EN_CONTROL_1	0x0b
+#define AXP717_MIN_SYS_V_CONTROL	0x15
+#define AXP717_INPUT_VOL_LIMIT_CTRL	0x16
+#define AXP717_INPUT_CUR_LIMIT_CTRL	0x17
+#define AXP717_MODULE_EN_CONTROL_2	0x19
 #define AXP717_BOOST_CONTROL		0x1e
+#define AXP717_VSYS_V_POWEROFF		0x24
 #define AXP717_IRQ0_EN			0x40
 #define AXP717_IRQ1_EN			0x41
 #define AXP717_IRQ2_EN			0x42
@@ -127,6 +135,9 @@ enum axp20x_variants {
 #define AXP717_IRQ2_STATE		0x4a
 #define AXP717_IRQ3_STATE		0x4b
 #define AXP717_IRQ4_STATE		0x4c
+#define AXP717_ICC_CHG_SET		0x62
+#define AXP717_ITERM_CHG_SET		0x63
+#define AXP717_CV_CHG_SET		0x64
 #define AXP717_DCDC_OUTPUT_CONTROL	0x80
 #define AXP717_DCDC1_CONTROL		0x83
 #define AXP717_DCDC2_CONTROL		0x84
@@ -147,6 +158,19 @@ enum axp20x_variants {
 #define AXP717_CLDO3_CONTROL		0x9d
 #define AXP717_CLDO4_CONTROL		0x9e
 #define AXP717_CPUSLDO_CONTROL		0x9f
+#define AXP717_BATT_PERCENT_DATA	0xa4
+#define AXP717_ADC_CH_EN_CONTROL	0xc0
+#define AXP717_BATT_V_H			0xc4
+#define AXP717_BATT_V_L			0xc5
+#define AXP717_VBUS_V_H			0xc6
+#define AXP717_VBUS_V_L			0xc7
+#define AXP717_VSYS_V_H			0xc8
+#define AXP717_VSYS_V_L			0xc9
+#define AXP717_BATT_CHRG_I_H		0xca
+#define AXP717_BATT_CHRG_I_L		0xcb
+#define AXP717_ADC_DATA_SEL		0xcd
+#define AXP717_ADC_DATA_H		0xce
+#define AXP717_ADC_DATA_L		0xcf
 
 #define AXP806_STARTUP_SRC		0x00
 #define AXP806_CHIP_ID			0x03
-- 
2.34.1


