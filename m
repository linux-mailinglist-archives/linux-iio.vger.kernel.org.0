Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D686B18C8D0
	for <lists+linux-iio@lfdr.de>; Fri, 20 Mar 2020 09:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgCTIMI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Mar 2020 04:12:08 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:51326 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbgCTILb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 20 Mar 2020 04:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=V7ao2BxZREvse3XwoWf/L44QfzmREzjIcPwYKWepRPE=; b=YzsIlOb0QNyiwbeGx9tQAb1TBr
        Wc6NNJ7LNAMHfASNsbsSsHHf88CCmqLE47HdufFMjjQBM60lDRs+kwTjCRu86z8W2iWPYJ2qofHo0
        Zi932bL/DlSHYGdfp5n/1rj7KeDS866+1yQE71wwCfy0NRiKG/Ayt5xhbTPG2CpYzCTs=;
Received: from p200300ccff093a00e2cec3fffe93fc31.dip0.t-ipconnect.de ([2003:cc:ff09:3a00:e2ce:c3ff:fe93:fc31] helo=eeepc)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1jFCkP-00058W-5O; Fri, 20 Mar 2020 09:11:18 +0100
Received: from andi by eeepc with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1jFCkH-00039K-9N; Fri, 20 Mar 2020 09:11:09 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, stefan@agner.ch, b.galvani@gmail.com,
        phh@phh.me, letux-kernel@openphoenux.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        jic23@kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v7 2/7] mfd: rn5t618: add IRQ support
Date:   Fri, 20 Mar 2020 09:11:00 +0100
Message-Id: <20200320081105.12026-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200320081105.12026-1-andreas@kemnade.info>
References: <20200320081105.12026-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds support for IRQ handling in the RC5T619 which is required
for properly implementing subdevices like RTC.
For now only definitions for the variant RC5T619 are included.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in v7:
more cleanups in IRQ init

Changes in v5:
rn5t618_irq_init static

Changes in v4:
merge rn5t618-irq.c into rn5t618.c
use macros for IRQ table

Changes in v3:
alignment cleanup

Changes in v2:
- no dead code, did some more testing and thinking for that
- remove extra empty lines
 drivers/mfd/Kconfig         |  1 +
 drivers/mfd/rn5t618.c       | 78 ++++++++++++++++++++++++++++++++++++-
 include/linux/mfd/rn5t618.h | 15 +++++++
 3 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 2b203290e7b9..a7067888a41e 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1058,6 +1058,7 @@ config MFD_RN5T618
 	depends on OF
 	select MFD_CORE
 	select REGMAP_I2C
+	select REGMAP_IRQ
 	help
 	  Say yes here to add support for the Ricoh RN5T567,
 	  RN5T618, RC5T619 PMIC.
diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
index ead2e79036a9..b66dc4605d56 100644
--- a/drivers/mfd/rn5t618.c
+++ b/drivers/mfd/rn5t618.c
@@ -8,6 +8,8 @@
 
 #include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/rn5t618.h>
 #include <linux/module.h>
@@ -46,9 +48,56 @@ static const struct regmap_config rn5t618_regmap_config = {
 	.cache_type	= REGCACHE_RBTREE,
 };
 
+static const struct regmap_irq rc5t619_irqs[] = {
+	REGMAP_IRQ_REG(RN5T618_IRQ_SYS, 0, BIT(0)),
+	REGMAP_IRQ_REG(RN5T618_IRQ_DCDC, 0, BIT(1)),
+	REGMAP_IRQ_REG(RN5T618_IRQ_RTC, 0, BIT(2)),
+	REGMAP_IRQ_REG(RN5T618_IRQ_ADC, 0, BIT(3)),
+	REGMAP_IRQ_REG(RN5T618_IRQ_GPIO, 0, BIT(4)),
+	REGMAP_IRQ_REG(RN5T618_IRQ_CHG, 0, BIT(6)),
+};
+
+static const struct regmap_irq_chip rc5t619_irq_chip = {
+	.name = "rc5t619",
+	.irqs = rc5t619_irqs,
+	.num_irqs = ARRAY_SIZE(rc5t619_irqs),
+	.num_regs = 1,
+	.status_base = RN5T618_INTMON,
+	.mask_base = RN5T618_INTEN,
+	.mask_invert = true,
+};
+
 static struct rn5t618 *rn5t618_pm_power_off;
 static struct notifier_block rn5t618_restart_handler;
 
+static int rn5t618_irq_init(struct rn5t618 *rn5t618)
+{
+	const struct regmap_irq_chip *irq_chip = NULL;
+	int ret;
+
+	if (!rn5t618->irq)
+		return 0;
+
+	switch (rn5t618->variant) {
+	case RC5T619:
+		irq_chip = &rc5t619_irq_chip;
+		break;
+	default:
+		dev_err(rn5t618->dev, "Currently no IRQ support for variant %d\n",
+			(int)rn5t618->variant);
+		return -ENOENT;
+	}
+
+	ret = devm_regmap_add_irq_chip(rn5t618->dev, rn5t618->regmap,
+				       rn5t618->irq,
+				       IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+				       0, irq_chip, &rn5t618->irq_data);
+	if (ret)
+		dev_err(rn5t618->dev, "Failed to register IRQ chip\n");
+
+	return ret;
+}
+
 static void rn5t618_trigger_poweroff_sequence(bool repower)
 {
 	/* disable automatic repower-on */
@@ -106,6 +155,8 @@ static int rn5t618_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, priv);
 	priv->variant = (long)of_id->data;
+	priv->irq = i2c->irq;
+	priv->dev = &i2c->dev;
 
 	priv->regmap = devm_regmap_init_i2c(i2c, &rn5t618_regmap_config);
 	if (IS_ERR(priv->regmap)) {
@@ -138,7 +189,7 @@ static int rn5t618_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	return 0;
+	return rn5t618_irq_init(priv);
 }
 
 static int rn5t618_i2c_remove(struct i2c_client *i2c)
@@ -155,15 +206,40 @@ static int rn5t618_i2c_remove(struct i2c_client *i2c)
 	return 0;
 }
 
+static int __maybe_unused rn5t618_i2c_suspend(struct device *dev)
+{
+	struct rn5t618 *priv = dev_get_drvdata(dev);
+
+	if (priv->irq)
+		disable_irq(priv->irq);
+
+	return 0;
+}
+
+static int __maybe_unused rn5t618_i2c_resume(struct device *dev)
+{
+	struct rn5t618 *priv = dev_get_drvdata(dev);
+
+	if (priv->irq)
+		enable_irq(priv->irq);
+
+	return 0;
+}
+
 static const struct i2c_device_id rn5t618_i2c_id[] = {
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rn5t618_i2c_id);
 
+static SIMPLE_DEV_PM_OPS(rn5t618_i2c_dev_pm_ops,
+			rn5t618_i2c_suspend,
+			rn5t618_i2c_resume);
+
 static struct i2c_driver rn5t618_i2c_driver = {
 	.driver = {
 		.name = "rn5t618",
 		.of_match_table = of_match_ptr(rn5t618_of_match),
+		.pm = &rn5t618_i2c_dev_pm_ops,
 	},
 	.probe = rn5t618_i2c_probe,
 	.remove = rn5t618_i2c_remove,
diff --git a/include/linux/mfd/rn5t618.h b/include/linux/mfd/rn5t618.h
index d62ef48060b5..739571656f2b 100644
--- a/include/linux/mfd/rn5t618.h
+++ b/include/linux/mfd/rn5t618.h
@@ -242,9 +242,24 @@ enum {
 	RC5T619,
 };
 
+/* RN5T618 IRQ definitions */
+enum {
+	RN5T618_IRQ_SYS = 0,
+	RN5T618_IRQ_DCDC,
+	RN5T618_IRQ_RTC,
+	RN5T618_IRQ_ADC,
+	RN5T618_IRQ_GPIO,
+	RN5T618_IRQ_CHG,
+	RN5T618_NR_IRQS,
+};
+
 struct rn5t618 {
 	struct regmap *regmap;
+	struct device *dev;
 	long variant;
+
+	int irq;
+	struct regmap_irq_chip_data *irq_data;
 };
 
 #endif /* __LINUX_MFD_RN5T618_H */
-- 
2.20.1

