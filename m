Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058FF5EA92C
	for <lists+linux-iio@lfdr.de>; Mon, 26 Sep 2022 16:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbiIZOyx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Sep 2022 10:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbiIZOyc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Sep 2022 10:54:32 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E8B9925BC;
        Mon, 26 Sep 2022 06:21:38 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,346,1654527600"; 
   d="scan'208";a="136203504"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 26 Sep 2022 22:21:38 +0900
Received: from localhost.localdomain (unknown [10.226.92.133])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5E3F9400544F;
        Mon, 26 Sep 2022 22:21:36 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH RFC 5/8] counter: Add RZ/G2L MTU3 counter driver
Date:   Mon, 26 Sep 2022 14:21:11 +0100
Message-Id: <20220926132114.60396-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220926132114.60396-1-biju.das.jz@bp.renesas.com>
References: <20220926132114.60396-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add RZ/G2L MTU3 counter driver. Currently it supports 16-bit phase
counting mode on MTU{1,2} channels.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/counter/Kconfig          |   9 +
 drivers/counter/Makefile         |   1 +
 drivers/counter/rzg2l-mtu3-cnt.c | 367 +++++++++++++++++++++++++++++++
 3 files changed, 377 insertions(+)
 create mode 100644 drivers/counter/rzg2l-mtu3-cnt.c

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index 5edd155f1911..6bdc0756f9c4 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -39,6 +39,15 @@ config INTERRUPT_CNT
 	  To compile this driver as a module, choose M here: the
 	  module will be called interrupt-cnt.
 
+config RZG2L_MTU3_CNT
+	tristate "RZ/G2L MTU3 counter driver"
+	depends on MFD_RZG2L_MTU3 || COMPILE_TEST
+	help
+	  Select this option to enable RZ/G2L MTU3 counter driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called rzg2l-mtu3-cnt.
+
 config STM32_TIMER_CNT
 	tristate "STM32 Timer encoder counter driver"
 	depends on MFD_STM32_TIMERS || COMPILE_TEST
diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
index 8fde6c100ebc..f9138f3e14f7 100644
--- a/drivers/counter/Makefile
+++ b/drivers/counter/Makefile
@@ -8,6 +8,7 @@ counter-y := counter-core.o counter-sysfs.o counter-chrdev.o
 
 obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
 obj-$(CONFIG_INTERRUPT_CNT)		+= interrupt-cnt.o
+obj-$(CONFIG_RZG2L_MTU3_CNT)	+= rzg2l-mtu3-cnt.o
 obj-$(CONFIG_STM32_TIMER_CNT)	+= stm32-timer-cnt.o
 obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
 obj-$(CONFIG_TI_EQEP)		+= ti-eqep.o
diff --git a/drivers/counter/rzg2l-mtu3-cnt.c b/drivers/counter/rzg2l-mtu3-cnt.c
new file mode 100644
index 000000000000..c324cd831f1d
--- /dev/null
+++ b/drivers/counter/rzg2l-mtu3-cnt.c
@@ -0,0 +1,367 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G2L MTU3a Counter driver
+ *
+ * Copyright (C) 2022 Renesas Electronics Corporation
+ */
+#include <linux/counter.h>
+#include <linux/mfd/rzg2l-mtu3.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+
+#define RZG2L_MTU3_TSR_TCFD	BIT(7)
+
+#define RZG2L_MTU3_TMDR1_PH_CNT_MODE_1	(4)
+#define RZG2L_MTU3_TMDR1_PH_CNT_MODE_2	(5)
+#define RZG2L_MTU3_TMDR1_PH_CNT_MODE_3	(6)
+#define RZG2L_MTU3_TMDR1_PH_CNT_MODE_4	(7)
+#define RZG2L_MTU3_TMDR1_PH_CNT_MODE_5	(9)
+#define RZG2L_MTU3_TMDR1_PH_CNT_MODE_MASK	(0xf)
+
+struct rzg2l_mtu3_cnt {
+	struct clk *clk;
+	void __iomem *mmio;
+	struct rzg2l_mtu3_channel *ch;
+};
+
+static const enum counter_function rzg2l_mtu3_count_functions[] = {
+	COUNTER_FUNCTION_QUADRATURE_X4,
+	COUNTER_FUNCTION_PULSE_DIRECTION,
+	COUNTER_FUNCTION_QUADRATURE_X2_B,
+};
+
+static int rzg2l_mtu3_count_read(struct counter_device *counter,
+				 struct counter_count *count, u64 *val)
+{
+	struct rzg2l_mtu3_cnt *const priv = counter_priv(counter);
+	u32 cnt;
+
+	cnt = rzg2l_mtu3_16bit_ch_read(priv->ch, RZG2L_MTU3_TCNT);
+	*val = cnt;
+
+	return 0;
+}
+
+static int rzg2l_mtu3_count_write(struct counter_device *counter,
+				  struct counter_count *count, const u64 val)
+{
+	struct rzg2l_mtu3_cnt *const priv = counter_priv(counter);
+	u16 ceiling;
+
+	ceiling = rzg2l_mtu3_16bit_ch_read(priv->ch, RZG2L_MTU3_TGRA);
+
+	if (val > ceiling)
+		return -EINVAL;
+
+	rzg2l_mtu3_16bit_ch_write(priv->ch, RZG2L_MTU3_TCNT, (u16)val);
+
+	return 0;
+}
+
+static int rzg2l_mtu3_count_function_read(struct counter_device *counter,
+					  struct counter_count *count,
+					  enum counter_function *function)
+{
+	struct rzg2l_mtu3_cnt *const priv = counter_priv(counter);
+	u8 val;
+
+	val = rzg2l_mtu3_8bit_ch_read(priv->ch, RZG2L_MTU3_TMDR1);
+
+	switch (val & RZG2L_MTU3_TMDR1_PH_CNT_MODE_MASK) {
+	case RZG2L_MTU3_TMDR1_PH_CNT_MODE_1:
+		*function = COUNTER_FUNCTION_QUADRATURE_X4;
+		break;
+	case RZG2L_MTU3_TMDR1_PH_CNT_MODE_2:
+		*function = COUNTER_FUNCTION_PULSE_DIRECTION;
+		break;
+	case RZG2L_MTU3_TMDR1_PH_CNT_MODE_4:
+		*function = COUNTER_FUNCTION_QUADRATURE_X2_B;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rzg2l_mtu3_count_function_write(struct counter_device *counter,
+					   struct counter_count *count,
+					   enum counter_function function)
+{
+	struct rzg2l_mtu3_cnt *const priv = counter_priv(counter);
+	u8 mode;
+
+	switch (function) {
+	case COUNTER_FUNCTION_QUADRATURE_X4:
+		mode = RZG2L_MTU3_TMDR1_PH_CNT_MODE_1;
+		break;
+	case COUNTER_FUNCTION_PULSE_DIRECTION:
+		mode = RZG2L_MTU3_TMDR1_PH_CNT_MODE_2;
+		break;
+	case COUNTER_FUNCTION_QUADRATURE_X2_B:
+		mode = RZG2L_MTU3_TMDR1_PH_CNT_MODE_4;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	rzg2l_mtu3_8bit_ch_write(priv->ch, RZG2L_MTU3_TMDR1, mode);
+
+	return 0;
+}
+
+static int rzg2l_mtu3_count_direction_read(struct counter_device *counter,
+					   struct counter_count *count,
+					   enum counter_count_direction *direction)
+{
+	struct rzg2l_mtu3_cnt *const priv = counter_priv(counter);
+	u8 cnt;
+
+	cnt = rzg2l_mtu3_8bit_ch_read(priv->ch, RZG2L_MTU3_TSR);
+
+	if (cnt & RZG2L_MTU3_TSR_TCFD)
+		*direction = COUNTER_COUNT_DIRECTION_FORWARD;
+	else
+		*direction = COUNTER_COUNT_DIRECTION_BACKWARD;
+
+	return 0;
+}
+
+static int rzg2l_mtu3_count_ceiling_read(struct counter_device *counter,
+					 struct counter_count *count,
+					 u64 *ceiling)
+{
+	struct rzg2l_mtu3_cnt *const priv = counter_priv(counter);
+	u32 val;
+
+	val = rzg2l_mtu3_16bit_ch_read(priv->ch, RZG2L_MTU3_TGRA);
+	*ceiling = val;
+
+	return 0;
+}
+
+static int rzg2l_mtu3_count_ceiling_write(struct counter_device *counter,
+					  struct counter_count *count,
+					  u64 ceiling)
+{
+	struct rzg2l_mtu3_cnt *const priv = counter_priv(counter);
+
+	if (ceiling > U16_MAX)
+		return -ERANGE;
+
+	rzg2l_mtu3_16bit_ch_write(priv->ch, RZG2L_MTU3_TGRA, (u16)ceiling);
+	rzg2l_mtu3_8bit_ch_write(priv->ch, RZG2L_MTU3_TCR,
+				 RZG2L_MTU3_TCR_CCLR_TGRA);
+
+	return 0;
+}
+
+static int rzg2l_mtu3_count_enable_read(struct counter_device *counter,
+					struct counter_count *count, u8 *enable)
+{
+	struct rzg2l_mtu3_cnt *const priv = counter_priv(counter);
+	int ch = priv->ch->index;
+
+	*enable = (rzg2l_mtu3_shared_reg_read(priv->ch, RZG2L_MTU3_TSTRA) &
+		(0x1 << ch)) >> ch;
+
+	return 0;
+}
+
+static int rzg2l_mtu3_count_enable_write(struct counter_device *counter,
+					 struct counter_count *count, u8 enable)
+{
+	struct rzg2l_mtu3_cnt *const priv = counter_priv(counter);
+
+	if (enable)
+		rzg2l_mtu3_enable(priv->ch);
+	else
+		rzg2l_mtu3_disable(priv->ch);
+
+	return 0;
+}
+
+static struct counter_comp rzg2l_mtu3_count_ext[] = {
+	COUNTER_COMP_DIRECTION(rzg2l_mtu3_count_direction_read),
+	COUNTER_COMP_ENABLE(rzg2l_mtu3_count_enable_read,
+			    rzg2l_mtu3_count_enable_write),
+	COUNTER_COMP_CEILING(rzg2l_mtu3_count_ceiling_read,
+			     rzg2l_mtu3_count_ceiling_write),
+};
+
+static const enum counter_synapse_action rzg2l_mtu3_synapse_actions[] = {
+	COUNTER_SYNAPSE_ACTION_NONE,
+	COUNTER_SYNAPSE_ACTION_BOTH_EDGES
+};
+
+static int rzg2l_mtu3_action_read(struct counter_device *counter,
+				  struct counter_count *count,
+				  struct counter_synapse *synapse,
+				  enum counter_synapse_action *action)
+{
+	enum counter_function function;
+	int err;
+
+	err = rzg2l_mtu3_count_function_read(counter, count, &function);
+	if (err)
+		return err;
+
+	switch (function) {
+	case COUNTER_FUNCTION_PULSE_DIRECTION:
+		/*
+		 * Rising edges on signal A updates the respective count.
+		 * The input level of signal B determines direction.
+		 */
+		*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
+		break;
+	case COUNTER_FUNCTION_QUADRATURE_X2_B:
+		/*
+		 * Any state transition on quadrature pair signal B updates
+		 * the respective count.
+		 */
+		*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
+		break;
+	case COUNTER_FUNCTION_QUADRATURE_X4:
+		/* counts up/down on both edges of A and B signal*/
+		*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct counter_ops rzg2l_mtu3_cnt_ops = {
+	.count_read = rzg2l_mtu3_count_read,
+	.count_write = rzg2l_mtu3_count_write,
+	.function_read = rzg2l_mtu3_count_function_read,
+	.function_write = rzg2l_mtu3_count_function_write,
+	.action_read = rzg2l_mtu3_action_read,
+};
+
+static struct counter_signal rzg2l_mtu3_signals[] = {
+	{
+		.id = 0,
+		.name = "Channel 1 Quadrature A"
+	},
+	{
+		.id = 1,
+		.name = "Channel 1 Quadrature B"
+	}
+};
+
+static struct counter_synapse rzg2l_mtu3_count_synapses[] = {
+	{
+		.actions_list = rzg2l_mtu3_synapse_actions,
+		.num_actions = ARRAY_SIZE(rzg2l_mtu3_synapse_actions),
+		.signal = &rzg2l_mtu3_signals[0]
+	},
+	{
+		.actions_list = rzg2l_mtu3_synapse_actions,
+		.num_actions = ARRAY_SIZE(rzg2l_mtu3_synapse_actions),
+		.signal = &rzg2l_mtu3_signals[1]
+	}
+};
+
+static struct counter_count rzg2l_mtu3_counts = {
+	.id = 0,
+	.name = "Channel 1 Count",
+	.functions_list = rzg2l_mtu3_count_functions,
+	.num_functions = ARRAY_SIZE(rzg2l_mtu3_count_functions),
+	.synapses = rzg2l_mtu3_count_synapses,
+	.num_synapses = ARRAY_SIZE(rzg2l_mtu3_count_synapses),
+	.ext = rzg2l_mtu3_count_ext,
+	.num_ext = ARRAY_SIZE(rzg2l_mtu3_count_ext)
+};
+
+static int rzg2l_mtu3_cnt_probe(struct platform_device *pdev)
+{
+	struct rzg2l_mtu3 *ddata = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct counter_device *counter;
+	struct rzg2l_mtu3_cnt *priv;
+	int ret;
+	u32 ch;
+
+	if (IS_ERR_OR_NULL(ddata))
+		return -EINVAL;
+
+	counter = devm_counter_alloc(dev, sizeof(*priv));
+	if (!counter)
+		return -ENOMEM;
+
+	priv = counter_priv(counter);
+
+	ret = of_property_read_u32(dev->of_node, "reg", &ch);
+	if (ret) {
+		dev_err(dev, "%pOF: No reg property found\n", dev->of_node);
+		return -EINVAL;
+	}
+
+	if (ch != RZG2L_MTU1 && ch != RZG2L_MTU2) {
+		dev_err(dev, "%pOF: Invalid channel '%u'\n", dev->of_node, ch);
+		return -EINVAL;
+	}
+
+	priv->clk = ddata->clk;
+	priv->ch = &ddata->channels[ch];
+	priv->ch->dev = dev;
+
+	counter->name = dev_name(dev);
+	counter->parent = dev;
+	counter->ops = &rzg2l_mtu3_cnt_ops;
+	counter->counts = &rzg2l_mtu3_counts;
+	counter->num_counts = 1;
+	counter->signals = rzg2l_mtu3_signals;
+	counter->num_signals = ARRAY_SIZE(rzg2l_mtu3_signals);
+	platform_set_drvdata(pdev, priv);
+
+	/* Register Counter device */
+	ret = devm_counter_add(dev, counter);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to add counter\n");
+
+	priv->ch->function = RZG2L_MTU3_16BIT_PHASE_COUNTING;
+	ret = clk_prepare_enable(ddata->clk);
+	if (ret)
+		return ret;
+
+	/*
+	 * Phase counting mode 1 will be used as default
+	 * when initializing counters.
+	 */
+	rzg2l_mtu3_8bit_ch_write(priv->ch, RZG2L_MTU3_TMDR1,
+				 RZG2L_MTU3_TMDR1_PH_CNT_MODE_1);
+
+	/* Initialize 16-bit counter max value */
+	rzg2l_mtu3_8bit_ch_write(priv->ch, RZG2L_MTU3_TCR,
+				 RZG2L_MTU3_TCR_CCLR_TGRA);
+	rzg2l_mtu3_16bit_ch_write(priv->ch, RZG2L_MTU3_TGRA, U16_MAX);
+
+	clk_disable(ddata->clk);
+
+	return 0;
+}
+
+static const struct of_device_id rzg2l_mtu3_cnt_of_match[] = {
+	{ .compatible = "renesas,rzg2l-mtu3-counter", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rzg2l_mtu3_cnt_of_match);
+
+static struct platform_driver rzg2l_mtu3_cnt_driver = {
+	.probe = rzg2l_mtu3_cnt_probe,
+	.driver = {
+		.name = "rzg2l-mtu3-counter",
+		.of_match_table = rzg2l_mtu3_cnt_of_match,
+	},
+};
+module_platform_driver(rzg2l_mtu3_cnt_driver);
+
+MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
+MODULE_ALIAS("platform:rzg2l-mtu3-counter");
+MODULE_DESCRIPTION("Renesas RZ/G2L MTU3a counter driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

