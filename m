Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2A45F68AB
	for <lists+linux-iio@lfdr.de>; Thu,  6 Oct 2022 15:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbiJFN5p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Oct 2022 09:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbiJFN5l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Oct 2022 09:57:41 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4871F9082D;
        Thu,  6 Oct 2022 06:57:39 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.95,163,1661785200"; 
   d="scan'208";a="135616457"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Oct 2022 22:57:39 +0900
Received: from localhost.localdomain (unknown [10.226.92.84])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 78CC053EEFC8;
        Thu,  6 Oct 2022 22:57:36 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 4/4] counter: Add RZ/G2L MTU3 counter driver
Date:   Thu,  6 Oct 2022 14:57:17 +0100
Message-Id: <20221006135717.1748560-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006135717.1748560-1-biju.das.jz@bp.renesas.com>
References: <20221006135717.1748560-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add RZ/G2L MTU3 counter driver.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v3:
 * Modelled as a counter device supporting 3 counters(2 16-bit and 
   32-bit)
 * Add kernel-doc comments to document struct rz_mtu3_cnt
 * Removed mmio variable from struct rz_mtu3_cnt
 * Removed cnt local variable from rz_mtu3_count_read()
 * Replaced -EINVAL->-ERANGE for out of range error conditions.
 * Removed explicit cast from write functions.
 * Removed local variable val from rz_mtu3_count_ceiling_read()
 * Added lock for RMW for counter/ceiling updates.
 * Added different synapses for counter0 and counter{1,2}
 * Used ARRAY for assigning num_counts.
 * Added PM runtime for managing clocks.
 * Add MODULE_IMPORT_NS(COUNTER) to import the COUNTER namespace.
---
 drivers/counter/Kconfig       |   9 +
 drivers/counter/Makefile      |   1 +
 drivers/counter/rz-mtu3-cnt.c | 568 ++++++++++++++++++++++++++++++++++
 3 files changed, 578 insertions(+)
 create mode 100644 drivers/counter/rz-mtu3-cnt.c

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index d388bf26f4dc..531b187e4630 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -39,6 +39,15 @@ config INTERRUPT_CNT
 	  To compile this driver as a module, choose M here: the
 	  module will be called interrupt-cnt.
 
+config RZ_MTU3_CNT
+	tristate "RZ/G2L MTU3 counter driver"
+	depends on MFD_RZ_MTU3 || COMPILE_TEST
+	help
+	  Select this option to enable RZ/G2L MTU3 counter driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called rz-mtu3-cnt.
+
 config STM32_TIMER_CNT
 	tristate "STM32 Timer encoder counter driver"
 	depends on MFD_STM32_TIMERS || COMPILE_TEST
diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
index b9a369e0d4fc..933fdd50b3e4 100644
--- a/drivers/counter/Makefile
+++ b/drivers/counter/Makefile
@@ -8,6 +8,7 @@ counter-y := counter-core.o counter-sysfs.o counter-chrdev.o
 
 obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
 obj-$(CONFIG_INTERRUPT_CNT)		+= interrupt-cnt.o
+obj-$(CONFIG_RZ_MTU3_CNT)	+= rz-mtu3-cnt.o
 obj-$(CONFIG_STM32_TIMER_CNT)	+= stm32-timer-cnt.o
 obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
 obj-$(CONFIG_TI_EQEP)		+= ti-eqep.o
diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
new file mode 100644
index 000000000000..26b5ea3852f8
--- /dev/null
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -0,0 +1,568 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G2L MTU3a Counter driver
+ *
+ * Copyright (C) 2022 Renesas Electronics Corporation
+ */
+#include <linux/counter.h>
+#include <linux/mfd/rz-mtu3.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/types.h>
+
+#define RZ_MTU3_TSR_TCFD	BIT(7)
+#define RZ_MTU3_MAX_HW_CNTR_CHANNELS	(2)
+
+#define RZ_MTU3_TMDR1_PH_CNT_MODE_1	(4)
+#define RZ_MTU3_TMDR1_PH_CNT_MODE_2	(5)
+#define RZ_MTU3_TMDR1_PH_CNT_MODE_3	(6)
+#define RZ_MTU3_TMDR1_PH_CNT_MODE_4	(7)
+#define RZ_MTU3_TMDR1_PH_CNT_MODE_5	(9)
+#define RZ_MTU3_TMDR1_PH_CNT_MODE_MASK	(0xf)
+
+#define RZ_MTU3_TCR_CCLR	GENMASK(7, 5)
+#define RZ_MTU3_TCR_CCLR_NONE	FIELD_PREP(RZ_MTU3_TCR_CCLR, 0)
+
+#define RZ_MTU3_TMDR3_LWA	BIT(0)
+#define RZ_MTU3_32_BIT_CH	(2)
+
+#define RZ_MTU3_TIOR_IC_BOTH	(10)
+
+/**
+ * struct rz_mtu3_cnt - MTU3 counter private data
+ *
+ * @clk: MTU3 module clock
+ * @lock: Lock to prevent concurrent access for ceiling and count
+ * @rz_mtu3_channel: HW channels for the counters
+ */
+struct rz_mtu3_cnt {
+	struct clk *clk;
+	struct mutex lock;
+	struct rz_mtu3_channel *ch[RZ_MTU3_MAX_HW_CNTR_CHANNELS];
+};
+
+static const enum counter_function rz_mtu3_count_functions[] = {
+	COUNTER_FUNCTION_QUADRATURE_X4,
+	COUNTER_FUNCTION_PULSE_DIRECTION,
+	COUNTER_FUNCTION_QUADRATURE_X2_B,
+};
+
+static bool rz_mtu3_is_16_bit_cnt_mode(struct rz_mtu3_cnt *const priv)
+{
+	return (priv->ch[0]->function == RZ_MTU3_16BIT_PHASE_COUNTING ||
+		priv->ch[1]->function == RZ_MTU3_16BIT_PHASE_COUNTING);
+}
+
+static bool rz_mtu3_is_32_bit_cnt_mode(struct rz_mtu3_cnt *const priv)
+{
+	return (priv->ch[0]->function == RZ_MTU3_32BIT_PHASE_COUNTING &&
+		priv->ch[1]->function == RZ_MTU3_32BIT_PHASE_COUNTING);
+}
+
+static int rz_mtu3_count_read(struct counter_device *counter,
+			      struct counter_count *count, u64 *val)
+{
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+	u32 id = count->id & 1;
+
+	if (count->id == RZ_MTU3_32_BIT_CH)
+		*val = rz_mtu3_32bit_ch_read(priv->ch[id], RZ_MTU3_TCNTLW);
+	else
+		*val = rz_mtu3_16bit_ch_read(priv->ch[id], RZ_MTU3_TCNT);
+
+	return 0;
+}
+
+static int rz_mtu3_count_write(struct counter_device *counter,
+			       struct counter_count *count, const u64 val)
+{
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+	u32 id = count->id & 1;
+	u32 ceiling;
+
+	mutex_lock(&priv->lock);
+	if (count->id == RZ_MTU3_32_BIT_CH)
+		ceiling = rz_mtu3_32bit_ch_read(priv->ch[id], RZ_MTU3_TGRALW);
+	else
+		ceiling = rz_mtu3_16bit_ch_read(priv->ch[id], RZ_MTU3_TGRA);
+
+	if (val > ceiling) {
+		mutex_unlock(&priv->lock);
+		return -ERANGE;
+	}
+
+	if (count->id == RZ_MTU3_32_BIT_CH)
+		rz_mtu3_32bit_ch_write(priv->ch[id], RZ_MTU3_TCNTLW, val);
+	else
+		rz_mtu3_16bit_ch_write(priv->ch[id], RZ_MTU3_TCNT, val);
+
+	mutex_unlock(&priv->lock);
+
+	return 0;
+}
+
+static int rz_mtu3_count_function_read(struct counter_device *counter,
+				       struct counter_count *count,
+				       enum counter_function *function)
+{
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+	u32 id = count->id & 1;
+	u8 val;
+
+	val = rz_mtu3_8bit_ch_read(priv->ch[id], RZ_MTU3_TMDR1);
+
+	switch (val & RZ_MTU3_TMDR1_PH_CNT_MODE_MASK) {
+	case RZ_MTU3_TMDR1_PH_CNT_MODE_1:
+		*function = COUNTER_FUNCTION_QUADRATURE_X4;
+		break;
+	case RZ_MTU3_TMDR1_PH_CNT_MODE_2:
+		*function = COUNTER_FUNCTION_PULSE_DIRECTION;
+		break;
+	case RZ_MTU3_TMDR1_PH_CNT_MODE_4:
+		*function = COUNTER_FUNCTION_QUADRATURE_X2_B;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rz_mtu3_count_function_write(struct counter_device *counter,
+					struct counter_count *count,
+					enum counter_function function)
+{
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+	u32 id = count->id & 1;
+	u8 mode;
+
+	switch (function) {
+	case COUNTER_FUNCTION_QUADRATURE_X4:
+		mode = RZ_MTU3_TMDR1_PH_CNT_MODE_1;
+		break;
+	case COUNTER_FUNCTION_PULSE_DIRECTION:
+		mode = RZ_MTU3_TMDR1_PH_CNT_MODE_2;
+		break;
+	case COUNTER_FUNCTION_QUADRATURE_X2_B:
+		mode = RZ_MTU3_TMDR1_PH_CNT_MODE_4;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	rz_mtu3_8bit_ch_write(priv->ch[id], RZ_MTU3_TMDR1, mode);
+
+	return 0;
+}
+
+static int rz_mtu3_count_direction_read(struct counter_device *counter,
+					struct counter_count *count,
+					enum counter_count_direction *direction)
+{
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+	u32 id = count->id & 1;
+	u8 cnt;
+
+	cnt = rz_mtu3_8bit_ch_read(priv->ch[id], RZ_MTU3_TSR);
+
+	if (cnt & RZ_MTU3_TSR_TCFD)
+		*direction = COUNTER_COUNT_DIRECTION_FORWARD;
+	else
+		*direction = COUNTER_COUNT_DIRECTION_BACKWARD;
+
+	return 0;
+}
+
+static int rz_mtu3_count_ceiling_read(struct counter_device *counter,
+				      struct counter_count *count,
+				      u64 *ceiling)
+{
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+	u32 id = count->id & 1;
+
+	if (count->id == RZ_MTU3_32_BIT_CH)
+		*ceiling = rz_mtu3_32bit_ch_read(priv->ch[id], RZ_MTU3_TGRALW);
+	else
+		*ceiling = rz_mtu3_16bit_ch_read(priv->ch[id], RZ_MTU3_TGRA);
+
+	return 0;
+}
+
+static int rz_mtu3_count_ceiling_write(struct counter_device *counter,
+				       struct counter_count *count,
+				       u64 ceiling)
+{
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+	u32 id = count->id & 1;
+
+	if (ceiling > U16_MAX && rz_mtu3_is_16_bit_cnt_mode(priv))
+		return -ERANGE;
+
+	if (ceiling > U32_MAX && rz_mtu3_is_32_bit_cnt_mode(priv))
+		return -ERANGE;
+
+	mutex_lock(&priv->lock);
+	if (ceiling == 0) {
+		rz_mtu3_8bit_ch_write(priv->ch[id], RZ_MTU3_TCR,
+				      RZ_MTU3_TCR_CCLR_NONE);
+
+	} else {
+		if (count->id == RZ_MTU3_32_BIT_CH)
+			rz_mtu3_32bit_ch_write(priv->ch[id], RZ_MTU3_TGRALW, ceiling);
+		else
+			rz_mtu3_16bit_ch_write(priv->ch[id], RZ_MTU3_TGRA, ceiling);
+
+		rz_mtu3_8bit_ch_write(priv->ch[id], RZ_MTU3_TCR,
+				      RZ_MTU3_TCR_CCLR_TGRA);
+	}
+	mutex_unlock(&priv->lock);
+
+	return 0;
+}
+
+static void rz_mtu3_32bit_cnt_setting(struct counter_device *counter, int id)
+{
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+
+	/*
+	 * 32-bit phase counting need MTU1 and MTU2 to create 32-bit cascade
+	 * counter.
+	 */
+	priv->ch[0]->function = RZ_MTU3_32BIT_PHASE_COUNTING;
+	priv->ch[1]->function = RZ_MTU3_32BIT_PHASE_COUNTING;
+
+	rz_mtu3_shared_reg_write(priv->ch[0], RZ_MTU3_TMDR3, RZ_MTU3_TMDR3_LWA);
+
+	/* Phase counting mode 1 is used as default in initialization. */
+	rz_mtu3_8bit_ch_write(priv->ch[0], RZ_MTU3_TMDR1,
+			      RZ_MTU3_TMDR1_PH_CNT_MODE_1);
+
+	rz_mtu3_8bit_ch_write(priv->ch[0], RZ_MTU3_TCR, RZ_MTU3_TCR_CCLR_TGRA);
+	rz_mtu3_8bit_ch_write(priv->ch[0], RZ_MTU3_TIOR, RZ_MTU3_TIOR_IC_BOTH);
+
+	rz_mtu3_enable(priv->ch[0]);
+	rz_mtu3_enable(priv->ch[1]);
+}
+
+static void rz_mtu3_16bit_cnt_setting(struct counter_device *counter, int id)
+{
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+
+	priv->ch[id]->function = RZ_MTU3_16BIT_PHASE_COUNTING;
+
+	/* Phase counting mode 1 is used as default in initialization. */
+	rz_mtu3_8bit_ch_write(priv->ch[id], RZ_MTU3_TMDR1,
+			      RZ_MTU3_TMDR1_PH_CNT_MODE_1);
+
+	rz_mtu3_8bit_ch_write(priv->ch[id], RZ_MTU3_TCR, RZ_MTU3_TCR_CCLR_TGRA);
+	rz_mtu3_16bit_ch_write(priv->ch[id], RZ_MTU3_TGRA, U16_MAX);
+
+	rz_mtu3_enable(priv->ch[id]);
+}
+
+static int rz_mtu3_initialize_counter(struct counter_device *counter, int id)
+{
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+
+	if (id == RZ_MTU3_32_BIT_CH && rz_mtu3_is_16_bit_cnt_mode(priv))
+		return -EBUSY;
+
+	if (id != RZ_MTU3_32_BIT_CH && rz_mtu3_is_32_bit_cnt_mode(priv))
+		return -EBUSY;
+
+	if (id == RZ_MTU3_32_BIT_CH)
+		rz_mtu3_32bit_cnt_setting(counter, id);
+	else
+		rz_mtu3_16bit_cnt_setting(counter, id);
+
+	return 0;
+}
+
+static void rz_mtu3_terminate_counter(struct counter_device *counter, int id)
+{
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+
+	if (id == RZ_MTU3_32_BIT_CH) {
+		priv->ch[0]->function = RZ_MTU3_NORMAL;
+		priv->ch[1]->function = RZ_MTU3_NORMAL;
+		rz_mtu3_shared_reg_write(priv->ch[0], RZ_MTU3_TMDR3, 0);
+		rz_mtu3_disable(priv->ch[1]);
+		rz_mtu3_disable(priv->ch[0]);
+	} else {
+		priv->ch[id]->function = RZ_MTU3_NORMAL;
+		rz_mtu3_disable(priv->ch[id]);
+	}
+}
+
+static int rz_mtu3_count_enable_read(struct counter_device *counter,
+				     struct counter_count *count, u8 *enable)
+{
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+
+	if (count->id == RZ_MTU3_32_BIT_CH)
+		*enable = rz_mtu3_is_enabled(priv->ch[0]) &&
+			rz_mtu3_is_enabled(priv->ch[1]);
+	else
+		*enable = rz_mtu3_is_enabled(priv->ch[count->id]);
+
+	return 0;
+}
+
+static int rz_mtu3_count_enable_write(struct counter_device *counter,
+				      struct counter_count *count, u8 enable)
+{
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+	struct rz_mtu3_channel *ch = priv->ch[count->id & 0x1];
+	int ret = 0;
+
+	if (enable) {
+		pm_runtime_get_sync(ch->dev);
+		ret = rz_mtu3_initialize_counter(counter, count->id);
+	} else {
+		rz_mtu3_terminate_counter(counter, count->id);
+		pm_runtime_put(ch->dev);
+	}
+
+	return ret;
+}
+
+static struct counter_comp rz_mtu3_count_ext[] = {
+	COUNTER_COMP_DIRECTION(rz_mtu3_count_direction_read),
+	COUNTER_COMP_ENABLE(rz_mtu3_count_enable_read,
+			    rz_mtu3_count_enable_write),
+	COUNTER_COMP_CEILING(rz_mtu3_count_ceiling_read,
+			     rz_mtu3_count_ceiling_write),
+};
+
+static const enum counter_synapse_action rz_mtu3_synapse_actions[] = {
+	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
+	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
+	COUNTER_SYNAPSE_ACTION_NONE,
+};
+
+static int rz_mtu3_action_read(struct counter_device *counter,
+			       struct counter_count *count,
+			       struct counter_synapse *synapse,
+			       enum counter_synapse_action *action)
+{
+	const size_t signal_a_id = count->synapses[0].signal->id;
+	const size_t signal_b_id = count->synapses[1].signal->id;
+	enum counter_function function;
+	int err;
+
+	err = rz_mtu3_count_function_read(counter, count, &function);
+	if (err)
+		return err;
+
+	/* Default action mode */
+	*action = COUNTER_SYNAPSE_ACTION_NONE;
+
+	switch (function) {
+	case COUNTER_FUNCTION_PULSE_DIRECTION:
+		/*
+		 * Rising edges on signal A updates the respective count.
+		 * The input level of signal B determines direction.
+		 */
+		if (synapse->signal->id == signal_a_id)
+			*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
+		break;
+	case COUNTER_FUNCTION_QUADRATURE_X2_B:
+		/*
+		 * Any state transition on quadrature pair signal B updates
+		 * the respective count.
+		 */
+		if (synapse->signal->id == signal_b_id)
+			*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
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
+static const struct counter_ops rz_mtu3_cnt_ops = {
+	.count_read = rz_mtu3_count_read,
+	.count_write = rz_mtu3_count_write,
+	.function_read = rz_mtu3_count_function_read,
+	.function_write = rz_mtu3_count_function_write,
+	.action_read = rz_mtu3_action_read,
+};
+
+#define RZ_MTU3_PHASE_SIGNAL(_id, _name) {		\
+	.id = (_id),				\
+	.name = (_name),			\
+}
+
+static struct counter_signal rz_mtu3_signals[] = {
+	RZ_MTU3_PHASE_SIGNAL(0, "MTU1 MTCLKA"),
+	RZ_MTU3_PHASE_SIGNAL(1, "MTU1 MTCLKB"),
+	RZ_MTU3_PHASE_SIGNAL(2, "MTU2 MTCLKC"),
+	RZ_MTU3_PHASE_SIGNAL(3, "MTU2 MTCLKD"),
+};
+
+#define RZ_MTU3_COUNT_SYNAPSES(_id) {					\
+	{								\
+		.actions_list = rz_mtu3_synapse_actions,		\
+		.num_actions = ARRAY_SIZE(rz_mtu3_synapse_actions),	\
+		.signal = rz_mtu3_signals + 2 * (_id)			\
+	},								\
+	{								\
+		.actions_list = rz_mtu3_synapse_actions,		\
+		.num_actions = ARRAY_SIZE(rz_mtu3_synapse_actions),	\
+		.signal = rz_mtu3_signals + 2 * (_id) + 1		\
+	}								\
+}
+
+static struct counter_synapse rz_mtu3_count_synapses[][2] = {
+	RZ_MTU3_COUNT_SYNAPSES(0), RZ_MTU3_COUNT_SYNAPSES(1)
+};
+
+static struct counter_count rz_mtu3_counts[] = {
+	{
+		.id = 0,
+		.name = "Channel 1 Count(16-bit)",
+		.functions_list = rz_mtu3_count_functions,
+		.num_functions = ARRAY_SIZE(rz_mtu3_count_functions),
+		.synapses = rz_mtu3_count_synapses[0],
+		.num_synapses = 2,
+		.ext = rz_mtu3_count_ext,
+		.num_ext = ARRAY_SIZE(rz_mtu3_count_ext),
+	},
+	{
+		.id = 1,
+		.name = "Channel 2 Count(16-bit)",
+		.functions_list = rz_mtu3_count_functions,
+		.num_functions = ARRAY_SIZE(rz_mtu3_count_functions),
+		.synapses = rz_mtu3_count_synapses[0],
+		.num_synapses = 4,
+		.ext = rz_mtu3_count_ext,
+		.num_ext = ARRAY_SIZE(rz_mtu3_count_ext),
+	},
+	{
+		.id = 2,
+		.name = "Channel3 Count(32-bit)",
+		.functions_list = rz_mtu3_count_functions,
+		.num_functions = ARRAY_SIZE(rz_mtu3_count_functions),
+		.synapses = rz_mtu3_count_synapses[0],
+		.num_synapses = 4,
+		.ext = rz_mtu3_count_ext,
+		.num_ext = ARRAY_SIZE(rz_mtu3_count_ext),
+	}
+};
+
+static int __maybe_unused rz_mtu3_cnt_pm_runtime_suspend(struct device *dev)
+{
+	struct rz_mtu3_cnt *const priv = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static int __maybe_unused rz_mtu3_cnt_pm_runtime_resume(struct device *dev)
+{
+	struct rz_mtu3_cnt *const priv = dev_get_drvdata(dev);
+
+	clk_prepare_enable(priv->clk);
+
+	return 0;
+}
+
+static const struct dev_pm_ops rz_mtu3_cnt_pm_ops = {
+	SET_RUNTIME_PM_OPS(rz_mtu3_cnt_pm_runtime_suspend, rz_mtu3_cnt_pm_runtime_resume, NULL)
+};
+
+static void rz_mtu3_cnt_pm_disable(void *data)
+{
+	struct device *dev = data;
+
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+}
+
+static int rz_mtu3_cnt_probe(struct platform_device *pdev)
+{
+	struct rz_mtu3 *ddata = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct counter_device *counter;
+	struct rz_mtu3_cnt *priv;
+	unsigned int i;
+	int ret;
+
+	counter = devm_counter_alloc(dev, sizeof(*priv));
+	if (!counter)
+		return -ENOMEM;
+
+	priv = counter_priv(counter);
+	priv->clk = ddata->clk;
+
+	for (i = 0; i < RZ_MTU3_MAX_HW_CNTR_CHANNELS; i++) {
+		priv->ch[i] = &ddata->channels[RZ_MTU1 + i];
+		priv->ch[i]->dev = dev;
+		if (priv->ch[i]->function != RZ_MTU3_NORMAL)
+			return dev_err_probe(dev, -EINVAL,
+					     "channel '%u' is already claimed\n", i);
+	}
+
+	mutex_init(&priv->lock);
+	clk_prepare_enable(priv->clk);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       rz_mtu3_cnt_pm_disable,
+				       dev);
+	if (ret < 0)
+		goto disable_clock;
+
+	counter->name = dev_name(dev);
+	counter->parent = dev;
+	counter->ops = &rz_mtu3_cnt_ops;
+	counter->counts = rz_mtu3_counts;
+	counter->num_counts = ARRAY_SIZE(rz_mtu3_counts);
+	counter->signals = rz_mtu3_signals;
+	counter->num_signals = ARRAY_SIZE(rz_mtu3_signals);
+	platform_set_drvdata(pdev, priv);
+
+	/* Register Counter device */
+	ret = devm_counter_add(dev, counter);
+	if (ret < 0) {
+		dev_err_probe(dev, ret, "Failed to add counter\n");
+		goto disable_clock;
+	}
+
+	return 0;
+
+disable_clock:
+	clk_disable_unprepare(priv->clk);
+
+	return ret;
+}
+
+static const struct of_device_id rz_mtu3_cnt_of_match[] = {
+	{ .compatible = "renesas,rz-mtu3-counter", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rz_mtu3_cnt_of_match);
+
+static struct platform_driver rz_mtu3_cnt_driver = {
+	.probe = rz_mtu3_cnt_probe,
+	.driver = {
+		.name = "rz-mtu3-counter",
+		.pm = &rz_mtu3_cnt_pm_ops,
+		.of_match_table = rz_mtu3_cnt_of_match,
+	},
+};
+module_platform_driver(rz_mtu3_cnt_driver);
+
+MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
+MODULE_ALIAS("platform:rz-mtu3-counter");
+MODULE_DESCRIPTION("Renesas RZ/G2L MTU3a counter driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(COUNTER);
-- 
2.25.1

