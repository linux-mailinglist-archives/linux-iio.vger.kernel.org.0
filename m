Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EE2642ADE
	for <lists+linux-iio@lfdr.de>; Mon,  5 Dec 2022 16:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbiLEPAU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Dec 2022 10:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbiLEPAT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Dec 2022 10:00:19 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C8F91D30A;
        Mon,  5 Dec 2022 07:00:17 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,219,1665414000"; 
   d="scan'208";a="142271763"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 Dec 2022 00:00:17 +0900
Received: from localhost.localdomain (unknown [10.226.92.127])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id E98224009BD8;
        Tue,  6 Dec 2022 00:00:14 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 5/6] counter: Add Renesas RZ/V2M TIM counter driver
Date:   Mon,  5 Dec 2022 14:59:54 +0000
Message-Id: <20221205145955.391526-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221205145955.391526-1-biju.das.jz@bp.renesas.com>
References: <20221205145955.391526-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add Renesas RZ/V2M TIM(Compare Match Timer) counter driver. This IP
supports 32 bit counter and it generates an interrupt request
signal every cycle set in the TIM counter.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/counter/Kconfig         |  10 +
 drivers/counter/Makefile        |   1 +
 drivers/counter/rzv2m-tim-cnt.c | 312 ++++++++++++++++++++++++++++++++
 3 files changed, 323 insertions(+)
 create mode 100644 drivers/counter/rzv2m-tim-cnt.c

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index d388bf26f4dc..c705b557117f 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -39,6 +39,16 @@ config INTERRUPT_CNT
 	  To compile this driver as a module, choose M here: the
 	  module will be called interrupt-cnt.
 
+config RZV2M_TIM_CNT
+	tristate "Renesas RZ/V2M counter driver"
+	depends on ARCH_R9A09G011 || COMPILE_TEST
+	help
+	  Enable support for RZ/V2M counter driver found on Renesas RZ/V2M alike
+	  SoCs. This IP supports 32 bit counter.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called rzv2m-tim-cnt.
+
 config STM32_TIMER_CNT
 	tristate "STM32 Timer encoder counter driver"
 	depends on MFD_STM32_TIMERS || COMPILE_TEST
diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
index b9a369e0d4fc..1f09ea735ddf 100644
--- a/drivers/counter/Makefile
+++ b/drivers/counter/Makefile
@@ -8,6 +8,7 @@ counter-y := counter-core.o counter-sysfs.o counter-chrdev.o
 
 obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
 obj-$(CONFIG_INTERRUPT_CNT)		+= interrupt-cnt.o
+obj-$(CONFIG_RZV2M_TIM_CNT)	+= rzv2m-tim-cnt.o
 obj-$(CONFIG_STM32_TIMER_CNT)	+= stm32-timer-cnt.o
 obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
 obj-$(CONFIG_TI_EQEP)		+= ti-eqep.o
diff --git a/drivers/counter/rzv2m-tim-cnt.c b/drivers/counter/rzv2m-tim-cnt.c
new file mode 100644
index 000000000000..6c3b738a3e39
--- /dev/null
+++ b/drivers/counter/rzv2m-tim-cnt.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/V2M Compare Match Timer (TIM) driver
+ *
+ * Copyright (C) 2022 Renesas Electronics Corporation
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/counter.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+
+/* TIM REGISTERS */
+#define RZV2M_TIM_TMD			0x0
+#define RZV2M_TIM_CMD			0x4
+#define RZV2M_TIM_TMCD			0x8
+#define RZV2M_TIM_INTCLR		0xc
+
+#define RZV2M_TIM_TMCD_CS		GENMASK(6, 4)
+#define RZV2M_TIM_TMCD_INTMODE		BIT(2)
+#define RZV2M_TIM_TMCD_CE		BIT(1)
+#define RZV2M_TIM_TMCD_CAE		BIT(0)
+
+#define RZV2M_TIM_INTCLR_INTCLR		BIT(0)
+
+#define RZV2M_TIM_TMCD_CH_EN	(RZV2M_TIM_TMCD_CE | RZV2M_TIM_TMCD_CAE)
+#define RZV2M_TIM_TMCD_START	(RZV2M_TIM_TMCD_CH_EN | RZV2M_TIM_TMCD_INTMODE)
+
+#define F2CYCLE_NSEC(f)		(1000000000 / (f))
+
+/**
+ * struct rzv2m_tim_channel - TIM counter private data
+ *
+ * @dev: Channel device
+ * @base: Base address of the chanel
+ * @rstc: Reset handle
+ * @delay: write intervel for register writes
+ * @ceiling: Cache for ceiling value
+ */
+
+struct rzv2m_tim_channel {
+	struct device *dev;
+	void __iomem *base;
+	struct reset_control *rstc;
+	unsigned long delay;
+	u32 ceiling;
+};
+
+static void rzv2m_tim_cnt_wait_delay(struct rzv2m_tim_channel *ch)
+{
+	/* delay required when changing the register settings */
+	ndelay(ch->delay);
+}
+
+static bool rzv2m_tim_cnt_is_counter_enabled(struct counter_device *counter)
+{
+	struct rzv2m_tim_channel *const ch = counter_priv(counter);
+	unsigned long tmcd;
+
+	tmcd = readl(ch->base + RZV2M_TIM_TMCD);
+	return !!FIELD_GET(RZV2M_TIM_TMCD_CH_EN, tmcd);
+}
+
+static void rzv2m_tim_cnt_stop(struct rzv2m_tim_channel *ch)
+{
+	unsigned long tmcd;
+
+	tmcd = readl(ch->base + RZV2M_TIM_TMCD);
+	if (FIELD_GET(RZV2M_TIM_TMCD_CH_EN, tmcd)) {
+		writel(FIELD_GET(RZV2M_TIM_TMCD_CS, tmcd),
+		       ch->base + RZV2M_TIM_TMCD);
+		rzv2m_tim_cnt_wait_delay(ch);
+	}
+}
+
+static void rzv2m_tim_cnt_start(struct rzv2m_tim_channel *ch)
+{
+	unsigned long tmcd;
+
+	tmcd = readl(ch->base + RZV2M_TIM_TMCD);
+	writel(tmcd | RZV2M_TIM_TMCD_START, ch->base + RZV2M_TIM_TMCD);
+	rzv2m_tim_cnt_wait_delay(ch);
+}
+
+static irqreturn_t rzv2m_tim_cnt_interrupt(int irq, void *dev_id)
+{
+	struct rzv2m_tim_channel *const ch = counter_priv(dev_id);
+
+	writel(RZV2M_TIM_INTCLR_INTCLR, ch->base + RZV2M_TIM_INTCLR);
+	counter_push_event(dev_id, COUNTER_EVENT_OVERFLOW, 0);
+
+	return IRQ_HANDLED;
+}
+
+static int rzv2m_tim_cnt_read(struct counter_device *counter,
+			      struct counter_count *count, u64 *val)
+{
+	struct rzv2m_tim_channel *const ch = counter_priv(counter);
+
+	*val = readl(ch->base + RZV2M_TIM_TMD);
+
+	return 0;
+}
+
+static int rzv2m_tim_cnt_ceiling_read(struct counter_device *counter,
+				      struct counter_count *count,
+				      u64 *ceiling)
+{
+	struct rzv2m_tim_channel *const ch = counter_priv(counter);
+
+	*ceiling = ch->ceiling;
+
+	return 0;
+}
+
+static int rzv2m_tim_cnt_ceiling_write(struct counter_device *counter,
+				       struct counter_count *count,
+				       u64 ceiling)
+{
+	struct rzv2m_tim_channel *const ch = counter_priv(counter);
+	bool enable = rzv2m_tim_cnt_is_counter_enabled(counter);
+
+	if (ceiling > U32_MAX)
+		return -ERANGE;
+
+	if (enable)
+		rzv2m_tim_cnt_stop(ch);
+	ch->ceiling = ceiling;
+	writel(ceiling, ch->base + RZV2M_TIM_CMD);
+	if (enable)
+		rzv2m_tim_cnt_start(ch);
+
+	return 0;
+}
+
+static int rzv2m_tim_cnt_enable_read(struct counter_device *counter,
+				     struct counter_count *count, u8 *enable)
+{
+	struct rzv2m_tim_channel *const ch = counter_priv(counter);
+
+	pm_runtime_get_sync(ch->dev);
+	*enable = rzv2m_tim_cnt_is_counter_enabled(counter);
+	pm_runtime_put(ch->dev);
+
+	return 0;
+}
+
+static int rzv2m_tim_cnt_enable_write(struct counter_device *counter,
+				      struct counter_count *count, u8 enable)
+{
+	struct rzv2m_tim_channel *const ch = counter_priv(counter);
+
+	if (enable) {
+		pm_runtime_get_sync(ch->dev);
+		rzv2m_tim_cnt_start(ch);
+	} else {
+		rzv2m_tim_cnt_stop(ch);
+		pm_runtime_put(ch->dev);
+	}
+
+	return 0;
+}
+
+static const struct counter_ops rzv2m_tim_cnt_ops = {
+	.count_read = rzv2m_tim_cnt_read,
+};
+
+static struct counter_comp rzv2m_tim_cnt_ext[] = {
+	COUNTER_COMP_ENABLE(rzv2m_tim_cnt_enable_read,
+			    rzv2m_tim_cnt_enable_write),
+	COUNTER_COMP_CEILING(rzv2m_tim_cnt_ceiling_read,
+			     rzv2m_tim_cnt_ceiling_write),
+};
+
+static struct counter_count rzv2m_tim_counts[] = {
+	{
+		.id = 0,
+		.name = "Channel Count",
+		.ext = rzv2m_tim_cnt_ext,
+		.num_ext = ARRAY_SIZE(rzv2m_tim_cnt_ext),
+	},
+};
+
+static void rzv2m_tim_cnt_reset_assert_pm_disable(void *data)
+{
+	struct rzv2m_tim_channel *ch = data;
+
+	reset_control_assert(ch->rstc);
+	pm_runtime_disable(ch->dev);
+}
+
+static int rzv2m_tim_cnt_probe(struct platform_device *pdev)
+{
+	struct counter_device *counter;
+	struct rzv2m_tim_channel *ch;
+	unsigned long apb_rate, rate;
+	struct clk *clk;
+	int irq;
+	int ret;
+
+	counter = devm_counter_alloc(&pdev->dev, sizeof(*ch));
+	if (!counter)
+		return -ENOMEM;
+
+	ch = counter_priv(counter);
+	ch->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ch->base))
+		return PTR_ERR(ch->base);
+
+	ch->rstc = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
+	if (IS_ERR(ch->rstc))
+		return dev_err_probe(&pdev->dev, PTR_ERR(ch->rstc),
+				     "get reset failed\n");
+
+	ch->dev = &pdev->dev;
+	clk = clk_get(&pdev->dev, "tim");
+	if (IS_ERR(clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
+				     "cannot get tim clock\n");
+	rate = clk_get_rate(clk);
+	clk_put(clk);
+	if (!rate)
+		return dev_err_probe(&pdev->dev, -EINVAL, "tim clk rate is 0");
+
+	clk = clk_get(&pdev->dev, "apb");
+	if (IS_ERR(clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
+				     "cannot get apb clock\n");
+	apb_rate = clk_get_rate(clk);
+	clk_put(clk);
+	if (!apb_rate)
+		return dev_err_probe(&pdev->dev, -EINVAL, "apb clk rate is 0");
+
+	/* delay = 5 * PCLK + 5 * INCLK */
+	ch->delay = F2CYCLE_NSEC(apb_rate) * 5 + F2CYCLE_NSEC(rate) * 5;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	pm_runtime_enable(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret < 0) {
+		dev_err_probe(&pdev->dev, ret,
+			      "pm_runtime_resume_and_get failed");
+		goto err_pm_disable;
+	}
+
+	reset_control_deassert(ch->rstc);
+	writel(U32_MAX, ch->base + RZV2M_TIM_CMD);
+	writel(FIELD_PREP(RZV2M_TIM_TMCD_CS, 0), ch->base  + RZV2M_TIM_TMCD);
+	pm_runtime_put(&pdev->dev);
+	platform_set_drvdata(pdev, ch);
+
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       rzv2m_tim_cnt_reset_assert_pm_disable,
+				       ch);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_request_irq(&pdev->dev, irq,
+			       rzv2m_tim_cnt_interrupt,
+			       0,
+			       dev_name(&pdev->dev), counter);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to request irq%d\n", irq);
+
+	counter->name = dev_name(&pdev->dev);
+	counter->parent = &pdev->dev;
+	counter->ops = &rzv2m_tim_cnt_ops;
+	counter->counts = rzv2m_tim_counts;
+	counter->num_counts = ARRAY_SIZE(rzv2m_tim_counts);
+
+	/* Register Counter device */
+	ret = devm_counter_add(&pdev->dev, counter);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "Failed to add counter\n");
+
+	return 0;
+
+err_pm_disable:
+	pm_runtime_disable(&pdev->dev);
+	return ret;
+}
+
+static const struct of_device_id rzv2m_tim_of_table[] = {
+	{ .compatible = "renesas,rzv2m-tim-cnt", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rzv2m_tim_of_table);
+
+static struct platform_driver rzv2m_tim_cnt_device_driver = {
+	.driver = {
+		.name = "rzv2m_tim_cnt",
+		.of_match_table = of_match_ptr(rzv2m_tim_of_table),
+	},
+	.probe = rzv2m_tim_cnt_probe,
+};
+module_platform_driver(rzv2m_tim_cnt_device_driver);
+
+MODULE_DESCRIPTION("Renesas RZ/V2M Compare Match Timer Driver");
+MODULE_ALIAS("platform:rzv2m-tim-counter");
+MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(COUNTER);
-- 
2.25.1

