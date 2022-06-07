Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05908539035
	for <lists+linux-iio@lfdr.de>; Tue, 31 May 2022 14:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344047AbiEaMAx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 May 2022 08:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243208AbiEaMAv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 May 2022 08:00:51 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D6862A08;
        Tue, 31 May 2022 05:00:50 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id cv1so11796617qvb.5;
        Tue, 31 May 2022 05:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sePt3x7ON3JH7CeHoCRuD6Euif4kN7Rj2nuq+sT7jGM=;
        b=a1C7geg44/vyN6CH6BtasgsefGUrIoeeQas19yYLFdsSwBCrHd99IIVPXwoqloAhmM
         /+Hd0Nu8GvWazokVuyhb5fDwtnr43eeEG6h3SDsjkfAD6lURX/LWSEltrsbNvwVNIWmC
         xc1rDPk3beFIetJ/zO5fDs4fIZ6loCrprKswhzjHZi2AKvOVWjLHcs5hh59Rt/GlORjz
         NDWalXQHaM4ki7NYyJbv8hmuD3nxk/q9xIUknNFKykTk3mx0eWSNEJMM58kD9in1CjB9
         Y5qrmP2ganqIkhlAwNot4KrUXSGl/k5YlWNK0Kr5oMGHsBZo7WkBqCrlI/hueU6O3CP2
         D7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sePt3x7ON3JH7CeHoCRuD6Euif4kN7Rj2nuq+sT7jGM=;
        b=Lbw6zqYEp7PD4wRB66cQzKw0DZIV3YdsQvlZW37asRQp1+Qbm8TsC/Crlsu4yPZJbr
         RQsvYJf2IFz1nhOP1HNClHEK5SAaPqihtVU87b1eSyC+wQRksNRX9i7GWfu5ApnxN9jg
         c5GR3BIgtO5vr7U0cN3wZZ2t4GZT2pXFCEd714gO8f0r+WWg4Jn+EVw+xvxPzOITbZaP
         4oTFY3JcYVarz9LsG1FWXGf9ItU1+A/Fl5SKQgbOa3TIHBcRTz5okGrOXHdBzaZF1g1Z
         3G5IFeFQhMwIuZV4W5Rp26gLpIe2WbGNbgB4YdYh8io4mk/bwX7yvYpZi20ynBkQir5P
         bw1g==
X-Gm-Message-State: AOAM533uxdNKaBd3m5tcj0o4VcozCE+gEIhPnZTxzFKkHfCE11vN2jqc
        pL8ixgbK3Ltu8QvqNtpT7OOm6YJmBSw=
X-Google-Smtp-Source: ABdhPJznECG9ysRHKdOsoxJuaAI0R0aP7H6dI0m1RwwQYampL4SnNF7DFpIy3MUp9wHblt7yBtTbrQ==
X-Received: by 2002:aa7:8141:0:b0:518:425b:760e with SMTP id d1-20020aa78141000000b00518425b760emr58507803pfn.27.1653992980058;
        Tue, 31 May 2022 03:29:40 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-72-220-172.emome-ip.hinet.net. [42.72.220.172])
        by smtp.gmail.com with ESMTPSA id c1-20020a63d501000000b003c14af50631sm10216519pgg.73.2022.05.31.03.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:29:39 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de
Cc:     cy_huang@richtek.com, alice_chen@richtek.com,
        chiaen_wu@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 03/14] regulator: mt6370: Add mt6370 DisplayBias and VibLDO support
Date:   Tue, 31 May 2022 18:27:58 +0800
Message-Id: <20220531102809.11976-4-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220531102809.11976-1-peterwu.pub@gmail.com>
References: <20220531102809.11976-1-peterwu.pub@gmail.com>
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

From: ChiYuan Huang <cy_huang@richtek.com>

Add mt6370 DisplayBias and VibLDO support.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/regulator/Kconfig            |   8 +
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/mt6370-regulator.c | 389 +++++++++++++++++++++++++++
 3 files changed, 398 insertions(+)
 create mode 100644 drivers/regulator/mt6370-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index cbe0f96ca342..dcb6866dab53 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -804,6 +804,14 @@ config REGULATOR_MT6360
 	  2-channel buck with Thermal Shutdown and Overload Protection
 	  6-channel High PSRR and Low Dropout LDO.
 
+config REGULATOR_MT6370
+	tristate "MT6370 SubPMIC Regulator"
+	depends on MFD_MT6370
+	help
+	  Say Y here to enable MT6370 regulator support.
+	  This driver support the control for DisplayBias voltages and one
+	  general purpose LDO which commonly used to drive the vibrator.
+
 config REGULATOR_MT6380
 	tristate "MediaTek MT6380 PMIC"
 	depends on MTK_PMIC_WRAP
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 8d3ee8b6d41d..f1cbff21843e 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -97,6 +97,7 @@ obj-$(CONFIG_REGULATOR_MT6323)	+= mt6323-regulator.o
 obj-$(CONFIG_REGULATOR_MT6358)	+= mt6358-regulator.o
 obj-$(CONFIG_REGULATOR_MT6359)	+= mt6359-regulator.o
 obj-$(CONFIG_REGULATOR_MT6360) += mt6360-regulator.o
+obj-$(CONFIG_REGULATOR_MT6370) += mt6370-regulator.o
 obj-$(CONFIG_REGULATOR_MT6380)	+= mt6380-regulator.o
 obj-$(CONFIG_REGULATOR_MT6397)	+= mt6397-regulator.o
 obj-$(CONFIG_REGULATOR_MTK_DVFSRC) += mtk-dvfsrc-regulator.o
diff --git a/drivers/regulator/mt6370-regulator.c b/drivers/regulator/mt6370-regulator.c
new file mode 100644
index 000000000000..949b2c7b5556
--- /dev/null
+++ b/drivers/regulator/mt6370-regulator.c
@@ -0,0 +1,389 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/bits.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+
+enum {
+	MT6370_IDX_DSVBOOST = 0,
+	MT6370_IDX_DSVPOS,
+	MT6370_IDX_DSVNEG,
+	MT6370_IDX_VIBLDO,
+	MT6370_MAX_IDX
+};
+
+#define MT6370_REG_LDO_CFG	0x180
+#define MT6370_REG_LDO_VOUT	0x181
+#define MT6370_REG_DB_CTRL1	0x1B0
+#define MT6370_REG_DB_CTRL2	0x1B1
+#define MT6370_REG_DB_VBST	0x1B2
+#define MT6370_REG_DB_VPOS	0x1B3
+#define MT6370_REG_DB_VNEG	0x1B4
+#define MT6370_REG_LDO_STAT	0x1DC
+#define MT6370_REG_DB_STAT	0x1DF
+
+#define MT6370_LDOOMS_MASK	BIT(7)
+#define MT6370_LDOEN_MASK	BIT(7)
+#define MT6370_LDOVOUT_MASK	GENMASK(3, 0)
+#define MT6370_DBPERD_MASK	(BIT(7) | BIT(4))
+#define MT6370_DBEXTEN_MASK	BIT(0)
+#define MT6370_DBVPOSEN_MASK	BIT(6)
+#define MT6370_DBVPOSDISG_MASK	BIT(5)
+#define MT6370_DBVNEGEN_MASK	BIT(3)
+#define MT6370_DBVNEGDISG_MASK	BIT(2)
+#define MT6370_DBALLON_MASK	(MT6370_DBVPOSEN_MASK | MT6370_DBVNEGEN_MASK)
+#define MT6370_DBSLEW_MASK	GENMASK(7, 6)
+#define MT6370_DBVOUT_MASK	GENMASK(5, 0)
+#define MT6370_LDOOC_EVT_MASK	BIT(7)
+#define MT6370_POSSCP_EVT_MASK	BIT(7)
+#define MT6370_NEGSCP_EVT_MASK	BIT(6)
+#define MT6370_BSTOCP_EVT_MASK	BIT(5)
+#define MT6370_POSOCP_EVT_MASK	BIT(4)
+#define MT6370_NEGOCP_EVT_MASK	BIT(3)
+
+#define MT6370_LDO_MINUV	1600000
+#define MT6370_LDO_STPUV	200000
+#define MT6370_LDO_N_VOLT	13
+#define MT6370_DBVBOOST_MINUV	4000000
+#define MT6370_DBVBOOST_STPUV	50000
+#define MT6370_DBVBOOST_N_VOLT	45
+#define MT6370_DBVOUT_MINUV	4000000
+#define MT6370_DBVOUT_STPUV	50000
+#define MT6370_DBVOUT_N_VOLT	41
+
+struct mt6370_priv {
+	struct device *dev;
+	struct regmap *regmap;
+	struct regulator_dev *rdev[MT6370_MAX_IDX];
+	bool use_external_ctrl;
+};
+
+static const unsigned int mt6370_vpos_ramp_tbl[] = { 8540, 5840, 4830, 3000 };
+static const unsigned int mt6370_vneg_ramp_tbl[] = { 10090, 6310, 5050, 3150 };
+
+static int mt6370_get_error_flags(struct regulator_dev *rdev,
+				  unsigned int *flags)
+{
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	unsigned int stat_reg, stat, rpt_flags = 0;
+	int rid = rdev_get_id(rdev), ret;
+
+	if (rid == MT6370_IDX_VIBLDO)
+		stat_reg = MT6370_REG_LDO_STAT;
+	else
+		stat_reg = MT6370_REG_DB_STAT;
+
+	ret = regmap_read(regmap, stat_reg, &stat);
+	if (ret)
+		return ret;
+
+	switch (rid) {
+	case MT6370_IDX_DSVBOOST:
+		if (stat & MT6370_BSTOCP_EVT_MASK)
+			rpt_flags |= REGULATOR_ERROR_OVER_CURRENT;
+		break;
+	case MT6370_IDX_DSVPOS:
+		if (stat & MT6370_POSSCP_EVT_MASK)
+			rpt_flags |= REGULATOR_ERROR_UNDER_VOLTAGE;
+
+		if (stat & MT6370_POSOCP_EVT_MASK)
+			rpt_flags |= REGULATOR_ERROR_OVER_CURRENT;
+		break;
+	case MT6370_IDX_DSVNEG:
+		if (stat & MT6370_NEGSCP_EVT_MASK)
+			rpt_flags |= REGULATOR_ERROR_UNDER_VOLTAGE;
+
+		if (stat & MT6370_NEGOCP_EVT_MASK)
+			rpt_flags |= REGULATOR_ERROR_OVER_CURRENT;
+		break;
+	default:
+		if (stat & MT6370_LDOOC_EVT_MASK)
+			rpt_flags |= REGULATOR_ERROR_OVER_CURRENT;
+		break;
+	}
+
+	*flags = rpt_flags;
+	return 0;
+}
+
+static const struct regulator_ops mt6370_dbvboost_ops = {
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.list_voltage = regulator_list_voltage_linear,
+	.get_bypass = regulator_get_bypass_regmap,
+	.set_bypass = regulator_set_bypass_regmap,
+	.get_error_flags = mt6370_get_error_flags,
+};
+
+static const struct regulator_ops mt6370_dbvout_ops = {
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.list_voltage = regulator_list_voltage_linear,
+	.is_enabled = regulator_is_enabled_regmap,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.set_active_discharge = regulator_set_active_discharge_regmap,
+	.set_ramp_delay = regulator_set_ramp_delay_regmap,
+	.get_error_flags = mt6370_get_error_flags,
+};
+
+static const struct regulator_ops mt6370_ldo_ops = {
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.list_voltage = regulator_list_voltage_linear,
+	.is_enabled = regulator_is_enabled_regmap,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.set_active_discharge = regulator_set_active_discharge_regmap,
+	.get_error_flags = mt6370_get_error_flags,
+};
+
+static int mt6370_of_parse_cb(struct device_node *np,
+			      const struct regulator_desc *desc,
+			      struct regulator_config *config)
+{
+	struct mt6370_priv *priv = config->driver_data;
+	struct gpio_desc *enable_gpio;
+	int ret;
+
+	enable_gpio = fwnode_gpiod_get_index(of_fwnode_handle(np), "enable", 0,
+					     GPIOD_OUT_HIGH |
+					     GPIOD_FLAGS_BIT_NONEXCLUSIVE,
+					     desc->name);
+	if (IS_ERR(enable_gpio)) {
+		config->ena_gpiod = NULL;
+		return 0;
+	}
+
+	/*
+	 * RG control by default
+	 * Only if all are using external pin, change all by external control
+	 */
+	if (priv->use_external_ctrl) {
+		ret = regmap_update_bits(priv->regmap, MT6370_REG_DB_CTRL1,
+					 MT6370_DBEXTEN_MASK,
+					 MT6370_DBEXTEN_MASK);
+		if (ret)
+			return ret;
+	}
+
+	config->ena_gpiod = enable_gpio;
+	priv->use_external_ctrl = true;
+	return 0;
+}
+
+static const struct regulator_desc mt6370_regulator_descs[] = {
+	{
+		.name = "mt6370-dsv-vbst",
+		.of_match = of_match_ptr("dsvbst"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = MT6370_IDX_DSVBOOST,
+		.type = REGULATOR_VOLTAGE,
+		.owner = THIS_MODULE,
+		.ops = &mt6370_dbvboost_ops,
+		.min_uV = MT6370_DBVBOOST_MINUV,
+		.uV_step = MT6370_DBVBOOST_STPUV,
+		.n_voltages = MT6370_DBVBOOST_N_VOLT,
+		.vsel_reg = MT6370_REG_DB_VBST,
+		.vsel_mask = MT6370_DBVOUT_MASK,
+		.bypass_reg = MT6370_REG_DB_CTRL1,
+		.bypass_mask = MT6370_DBPERD_MASK,
+		.bypass_val_on = MT6370_DBPERD_MASK,
+	},
+	{
+		.name = "mt6370-dsv-vpos",
+		.of_match = of_match_ptr("dsvpos"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = MT6370_IDX_DSVPOS,
+		.type = REGULATOR_VOLTAGE,
+		.owner = THIS_MODULE,
+		.of_parse_cb = mt6370_of_parse_cb,
+		.ops = &mt6370_dbvout_ops,
+		.min_uV = MT6370_DBVOUT_MINUV,
+		.uV_step = MT6370_DBVOUT_STPUV,
+		.n_voltages = MT6370_DBVOUT_N_VOLT,
+		.vsel_reg = MT6370_REG_DB_VPOS,
+		.vsel_mask = MT6370_DBVOUT_MASK,
+		.enable_reg = MT6370_REG_DB_CTRL2,
+		.enable_mask = MT6370_DBVPOSEN_MASK,
+		.ramp_reg = MT6370_REG_DB_VPOS,
+		.ramp_mask = MT6370_DBSLEW_MASK,
+		.ramp_delay_table = mt6370_vpos_ramp_tbl,
+		.n_ramp_values = ARRAY_SIZE(mt6370_vpos_ramp_tbl),
+		.active_discharge_reg = MT6370_REG_DB_CTRL2,
+		.active_discharge_mask = MT6370_DBVPOSDISG_MASK,
+		.active_discharge_on = MT6370_DBVPOSDISG_MASK,
+	},
+	{
+		.name = "mt6370-dsv-vneg",
+		.of_match = of_match_ptr("dsvneg"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = MT6370_IDX_DSVNEG,
+		.type = REGULATOR_VOLTAGE,
+		.owner = THIS_MODULE,
+		.of_parse_cb = mt6370_of_parse_cb,
+		.ops = &mt6370_dbvout_ops,
+		.min_uV = MT6370_DBVOUT_MINUV,
+		.uV_step = MT6370_DBVOUT_STPUV,
+		.n_voltages = MT6370_DBVOUT_N_VOLT,
+		.vsel_reg = MT6370_REG_DB_VNEG,
+		.vsel_mask = MT6370_DBVOUT_MASK,
+		.enable_reg = MT6370_REG_DB_CTRL2,
+		.enable_mask = MT6370_DBVNEGEN_MASK,
+		.ramp_reg = MT6370_REG_DB_VNEG,
+		.ramp_mask = MT6370_DBSLEW_MASK,
+		.ramp_delay_table = mt6370_vneg_ramp_tbl,
+		.n_ramp_values = ARRAY_SIZE(mt6370_vneg_ramp_tbl),
+		.active_discharge_reg = MT6370_REG_DB_CTRL2,
+		.active_discharge_mask = MT6370_DBVNEGDISG_MASK,
+		.active_discharge_on = MT6370_DBVNEGDISG_MASK,
+	},
+	{
+		.name = "mt6370-vib-ldo",
+		.of_match = of_match_ptr("vibldo"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = MT6370_IDX_VIBLDO,
+		.type = REGULATOR_VOLTAGE,
+		.owner = THIS_MODULE,
+		.ops = &mt6370_ldo_ops,
+		.min_uV = MT6370_LDO_MINUV,
+		.uV_step = MT6370_LDO_STPUV,
+		.n_voltages = MT6370_LDO_N_VOLT,
+		.vsel_reg = MT6370_REG_LDO_VOUT,
+		.vsel_mask = MT6370_LDOVOUT_MASK,
+		.enable_reg = MT6370_REG_LDO_VOUT,
+		.enable_mask = MT6370_LDOEN_MASK,
+		.active_discharge_reg = MT6370_REG_LDO_CFG,
+		.active_discharge_mask = MT6370_LDOOMS_MASK,
+		.active_discharge_on = MT6370_LDOOMS_MASK,
+	}
+};
+
+static irqreturn_t mt6370_scp_handler(int irq, void *data)
+{
+	struct regulator_dev *rdev = data;
+
+	regulator_notifier_call_chain(rdev, REGULATOR_EVENT_UNDER_VOLTAGE,
+				      NULL);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t mt6370_ocp_handler(int irq, void *data)
+{
+	struct regulator_dev *rdev = data;
+
+	regulator_notifier_call_chain(rdev, REGULATOR_EVENT_OVER_CURRENT, NULL);
+	return IRQ_HANDLED;
+}
+
+static int mt6370_regulator_irq_register(struct mt6370_priv *priv)
+{
+	struct platform_device *pdev = to_platform_device(priv->dev);
+	static const struct {
+		const char *name;
+		int rid;
+		irq_handler_t handler;
+	} mt6370_irqs[] = {
+		{ "db_vpos_scp", MT6370_IDX_DSVPOS, mt6370_scp_handler },
+		{ "db_vneg_scp", MT6370_IDX_DSVNEG, mt6370_scp_handler },
+		{ "db_vbst_ocp", MT6370_IDX_DSVBOOST, mt6370_ocp_handler },
+		{ "db_vpos_ocp", MT6370_IDX_DSVPOS,  mt6370_ocp_handler },
+		{ "db_vneg_ocp", MT6370_IDX_DSVNEG, mt6370_ocp_handler },
+		{ "ldo_oc", MT6370_IDX_VIBLDO, mt6370_ocp_handler }
+	};
+	struct regulator_dev *rdev;
+	int i, irq, ret;
+
+	for (i = 0; i < ARRAY_SIZE(mt6370_irqs); i++) {
+		irq = platform_get_irq_byname(pdev, mt6370_irqs[i].name);
+
+		rdev = priv->rdev[mt6370_irqs[i].rid];
+
+		ret = devm_request_threaded_irq(priv->dev, irq, NULL,
+						mt6370_irqs[i].handler, 0,
+						mt6370_irqs[i].name, rdev);
+		if (ret) {
+			dev_err(priv->dev,
+				"Failed to register (%d) interrupt\n", i);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int mt6370_regualtor_register(struct mt6370_priv *priv)
+{
+	struct regulator_dev *rdev;
+	struct regulator_config cfg = {};
+	struct device *parent = priv->dev->parent;
+	int i;
+
+	cfg.dev = parent;
+	cfg.driver_data = priv;
+
+	for (i = 0; i < MT6370_MAX_IDX; i++) {
+		rdev = devm_regulator_register(priv->dev,
+					       mt6370_regulator_descs + i,
+					       &cfg);
+		if (IS_ERR(rdev)) {
+			dev_err(priv->dev,
+				"Failed to register (%d) regulator\n", i);
+			return PTR_ERR(rdev);
+		}
+
+		priv->rdev[i] = rdev;
+	}
+
+	return 0;
+}
+
+static int mt6370_regulator_probe(struct platform_device *pdev)
+{
+	struct mt6370_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+
+	priv->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!priv->regmap) {
+		dev_err(&pdev->dev, "Failed to init regmap\n");
+		return -ENODEV;
+	}
+
+	ret = mt6370_regualtor_register(priv);
+	if (ret)
+		return ret;
+
+	return mt6370_regulator_irq_register(priv);
+}
+
+static const struct platform_device_id mt6370_devid_table[] = {
+	{ "mt6370-regulator", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(platform, mt6370_devid_table);
+
+static struct platform_driver mt6370_regulator_driver = {
+	.driver = {
+		.name = "mt6370-regulator",
+	},
+	.id_table = mt6370_devid_table,
+	.probe = mt6370_regulator_probe,
+};
+module_platform_driver(mt6370_regulator_driver);
+
+MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
+MODULE_DESCRIPTION("Mediatek MT6370 Regulator Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

