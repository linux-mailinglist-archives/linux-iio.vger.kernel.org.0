Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DAB5FA083
	for <lists+linux-iio@lfdr.de>; Mon, 10 Oct 2022 16:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiJJOwo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Oct 2022 10:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJJOwn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Oct 2022 10:52:43 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57166474FC;
        Mon, 10 Oct 2022 07:52:41 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.95,173,1661785200"; 
   d="scan'208";a="136028498"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Oct 2022 23:52:41 +0900
Received: from localhost.localdomain (unknown [10.226.92.95])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id EB63442F5164;
        Mon, 10 Oct 2022 23:52:37 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, Lee Jones <lee@kernel.org>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 3/4] mfd: Add RZ/G2L MTU3 counter driver
Date:   Mon, 10 Oct 2022 15:52:21 +0100
Message-Id: <20221010145222.1047748-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221010145222.1047748-1-biju.das.jz@bp.renesas.com>
References: <20221010145222.1047748-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add RZ/G2L MTU3 counter driver. This IP supports the following
phase counting modes on MTU1 and MTU2 channels

1) 16-bit phase counting modes on MTU1 and MTU2 channels.
2) 32-bit phase counting mode by cascading MTU1 and MTU2.

This patch adds 3 counters by creating 3 logical channels
	counter0: 16-bit phase counter on MTU1 channel
	counter1: 16-bit phase counter on MTU2 channel
	counter2: 32-bit phase counter by cascading MTU1 and MTU2
		  channels.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * There is no resource associated with "rz-mtu3-counter" compatible
   and moved the code to mfd subsystem as it binds against "rz-mtu".
 * Removed struct platform_driver rz_mtu3_cnt_driver.
 * Updated commit description
 * Updated Kconfig description
 * Added macros RZ_MTU3_16_BIT_MTU{1,2}_CH for MTU1 and MTU2 channels
 * Added RZ_MTU3_GET_HW_CH macro for getting channel ID.
 * replaced priv->ch[id]->priv->ch[0] in rz_mtu3_count_read()
 * Cached counter max values
 * replaced cnt->tsr in rz_mtu3_count_direction_read()
 * Added comments for RZ_MTU3_TCR_CCLR_NONE
 * Replaced if with switch in rz_mtu3_initialize_counter() and
   rz_mtu3_count_ceiling_write()
 * Added locks in initialize, terminate and enable_read to prevent races.
 * Updated rz_mtu3_action_read to take care of MTU2 signals.
 * Added separate distinct array for each group of Synapse.
 * Moved pm handling to parent.

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
 drivers/mfd/Kconfig       |   8 +
 drivers/mfd/Makefile      |   1 +
 drivers/mfd/rz-mtu3-cnt.c | 554 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 563 insertions(+)
 create mode 100644 drivers/mfd/rz-mtu3-cnt.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 7329971a3bdf..fa88056224c9 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1986,6 +1986,14 @@ config MFD_RZ_MTU3
 	  To compile this driver as a module, choose M here: the
 	  module will be called rz-mtu3.
 
+config MFD_RZ_MTU3_CNT
+	tristate "RZ/G2L MTU3 counter driver"
+	depends on MFD_RZ_MTU3 || COMPILE_TEST
+	help
+	  Enable support for MTU3 counter driver found on Renesas RZ/G2L alike
+	  SoCs. This IP supports both 16-bit and 32-bit phase counting mode
+	  support.
+
 config MFD_STM32_LPTIMER
 	tristate "Support for STM32 Low-Power Timer"
 	depends on (ARCH_STM32 && OF) || COMPILE_TEST
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index cd492903411c..9d0d1fd22f99 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -252,6 +252,7 @@ obj-$(CONFIG_MFD_STPMIC1)	+= stpmic1.o
 obj-$(CONFIG_MFD_SUN4I_GPADC)	+= sun4i-gpadc.o
 
 rz-mtu3-objs			:= rz-mtu3-core.o
+rz-mtu3-$(CONFIG_MFD_RZ_MTU3_CNT)	+= rz-mtu3-cnt.o
 obj-$(CONFIG_MFD_RZ_MTU3) 	+= rz-mtu3.o
 obj-$(CONFIG_MFD_STM32_LPTIMER)	+= stm32-lptimer.o
 obj-$(CONFIG_MFD_STM32_TIMERS) 	+= stm32-timers.o
diff --git a/drivers/mfd/rz-mtu3-cnt.c b/drivers/mfd/rz-mtu3-cnt.c
new file mode 100644
index 000000000000..e4aef25be462
--- /dev/null
+++ b/drivers/mfd/rz-mtu3-cnt.c
@@ -0,0 +1,554 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G2L MTU3a Counter driver
+ *
+ * Copyright (C) 2022 Renesas Electronics Corporation
+ */
+#include <linux/counter.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/types.h>
+
+#include "rz-mtu3.h"
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
+#define RZ_MTU3_16_BIT_MTU1_CH	(0)
+#define RZ_MTU3_16_BIT_MTU2_CH	(1)
+#define RZ_MTU3_32_BIT_CH		(2)
+
+#define RZ_MTU3_TIOR_IC_BOTH	(10)
+
+#define RZ_MTU3_GET_HW_CH(id) (((id) == RZ_MTU3_32_BIT_CH) ? 0 : (id))
+
+/**
+ * struct rz_mtu3_cnt - MTU3 counter private data
+ *
+ * @lock: Lock to prevent concurrent access for ceiling and count
+ * @mtu_16bit_max: Cache for 16-bit counters
+ * @mtu_32bit_max: Cache for 32-bit counters
+ * @rz_mtu3_channel: HW channels for the counters
+ */
+struct rz_mtu3_cnt {
+	struct mutex lock;
+	u16 mtu_16bit_max[RZ_MTU3_MAX_HW_CNTR_CHANNELS];
+	u32 mtu_32bit_max;
+	struct rz_mtu3_channel *ch[RZ_MTU3_MAX_HW_CNTR_CHANNELS];
+};
+
+static const enum counter_function rz_mtu3_count_functions[] = {
+	COUNTER_FUNCTION_QUADRATURE_X4,
+	COUNTER_FUNCTION_PULSE_DIRECTION,
+	COUNTER_FUNCTION_QUADRATURE_X2_B,
+};
+
+static int rz_mtu3_count_read(struct counter_device *counter,
+			      struct counter_count *count, u64 *val)
+{
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+
+	if (count->id == RZ_MTU3_32_BIT_CH)
+		*val = rz_mtu3_32bit_ch_read(priv->ch[0], RZ_MTU3_TCNTLW);
+	else
+		*val = rz_mtu3_16bit_ch_read(priv->ch[count->id], RZ_MTU3_TCNT);
+
+	return 0;
+}
+
+static int rz_mtu3_count_write(struct counter_device *counter,
+			       struct counter_count *count, const u64 val)
+{
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+	const size_t ch_id = RZ_MTU3_GET_HW_CH(count->id);
+	u32 ceiling;
+
+	mutex_lock(&priv->lock);
+	if (count->id == RZ_MTU3_32_BIT_CH)
+		ceiling = priv->mtu_32bit_max;
+	else
+		ceiling = priv->mtu_16bit_max[ch_id];
+
+	if (val > ceiling) {
+		mutex_unlock(&priv->lock);
+		return -ERANGE;
+	}
+
+	if (count->id == RZ_MTU3_32_BIT_CH)
+		rz_mtu3_32bit_ch_write(priv->ch[0], RZ_MTU3_TCNTLW, val);
+	else
+		rz_mtu3_16bit_ch_write(priv->ch[ch_id], RZ_MTU3_TCNT, val);
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
+	const size_t ch_id = RZ_MTU3_GET_HW_CH(count->id);
+	u8 val;
+
+	val = rz_mtu3_8bit_ch_read(priv->ch[ch_id], RZ_MTU3_TMDR1);
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
+	const size_t ch_id = RZ_MTU3_GET_HW_CH(count->id);
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
+	rz_mtu3_8bit_ch_write(priv->ch[ch_id], RZ_MTU3_TMDR1, mode);
+
+	return 0;
+}
+
+static int rz_mtu3_count_direction_read(struct counter_device *counter,
+					struct counter_count *count,
+					enum counter_count_direction *direction)
+{
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+	const size_t ch_id = RZ_MTU3_GET_HW_CH(count->id);
+	u8 tsr;
+
+	tsr = rz_mtu3_8bit_ch_read(priv->ch[ch_id], RZ_MTU3_TSR);
+
+	if (tsr & RZ_MTU3_TSR_TCFD)
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
+	const size_t ch_id = RZ_MTU3_GET_HW_CH(count->id);
+
+	if (count->id == RZ_MTU3_32_BIT_CH)
+		*ceiling = priv->mtu_32bit_max;
+	else
+		*ceiling = priv->mtu_16bit_max[ch_id];
+
+	return 0;
+}
+
+static int rz_mtu3_count_ceiling_write(struct counter_device *counter,
+				       struct counter_count *count,
+				       u64 ceiling)
+{
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+	const size_t ch_id = RZ_MTU3_GET_HW_CH(count->id);
+
+	switch (count->id) {
+	case RZ_MTU3_16_BIT_MTU1_CH:
+	case RZ_MTU3_16_BIT_MTU2_CH:
+		if (ceiling > U16_MAX)
+			return -ERANGE;
+		priv->mtu_16bit_max[ch_id] = ceiling;
+		break;
+	case RZ_MTU3_32_BIT_CH:
+		if (ceiling > U32_MAX)
+			return -ERANGE;
+		priv->mtu_32bit_max = ceiling;
+		break;
+	}
+
+	mutex_lock(&priv->lock);
+	if (ceiling == 0) {
+		/* Disable counter clear source */
+		rz_mtu3_8bit_ch_write(priv->ch[ch_id], RZ_MTU3_TCR,
+				      RZ_MTU3_TCR_CCLR_NONE);
+	} else {
+		if (count->id == RZ_MTU3_32_BIT_CH)
+			rz_mtu3_32bit_ch_write(priv->ch[ch_id], RZ_MTU3_TGRALW,
+					       ceiling);
+		else
+			rz_mtu3_16bit_ch_write(priv->ch[ch_id], RZ_MTU3_TGRA,
+					       ceiling);
+
+		rz_mtu3_8bit_ch_write(priv->ch[ch_id], RZ_MTU3_TCR,
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
+	rz_mtu3_shared_reg_write(priv->ch[0], RZ_MTU3_TMDR3, 0);
+	/* Phase counting mode 1 is used as default in initialization. */
+	rz_mtu3_8bit_ch_write(priv->ch[id], RZ_MTU3_TMDR1,
+			      RZ_MTU3_TMDR1_PH_CNT_MODE_1);
+
+	rz_mtu3_8bit_ch_write(priv->ch[id], RZ_MTU3_TCR, RZ_MTU3_TCR_CCLR_TGRA);
+	rz_mtu3_enable(priv->ch[id]);
+}
+
+static int rz_mtu3_initialize_counter(struct counter_device *counter, int id)
+{
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+
+	mutex_lock(&priv->lock);
+	switch (id) {
+	case RZ_MTU3_16_BIT_MTU1_CH:
+	case RZ_MTU3_16_BIT_MTU2_CH:
+		if (priv->ch[id]->function != RZ_MTU3_NORMAL) {
+			mutex_unlock(&priv->lock);
+			return -EBUSY;
+		}
+
+		rz_mtu3_16bit_cnt_setting(counter, id);
+		break;
+	case RZ_MTU3_32_BIT_CH:
+		if (priv->ch[0]->function != RZ_MTU3_NORMAL ||
+		    priv->ch[1]->function != RZ_MTU3_NORMAL) {
+			mutex_unlock(&priv->lock);
+			return -EBUSY;
+		}
+		rz_mtu3_32bit_cnt_setting(counter, id);
+		break;
+	}
+	mutex_unlock(&priv->lock);
+
+	return 0;
+}
+
+static void rz_mtu3_terminate_counter(struct counter_device *counter, int id)
+{
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+
+	mutex_lock(&priv->lock);
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
+	mutex_unlock(&priv->lock);
+}
+
+static int rz_mtu3_count_enable_read(struct counter_device *counter,
+				     struct counter_count *count, u8 *enable)
+{
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+
+	if (count->id == RZ_MTU3_32_BIT_CH) {
+		mutex_lock(&priv->lock);
+		*enable = rz_mtu3_is_enabled(priv->ch[0]) &&
+			rz_mtu3_is_enabled(priv->ch[1]);
+		mutex_unlock(&priv->lock);
+	} else {
+		*enable = rz_mtu3_is_enabled(priv->ch[count->id]);
+	}
+
+	return 0;
+}
+
+static int rz_mtu3_count_enable_write(struct counter_device *counter,
+				      struct counter_count *count, u8 enable)
+{
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+	const size_t ch_id = RZ_MTU3_GET_HW_CH(count->id);
+	struct rz_mtu3_channel *ch = priv->ch[ch_id];
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
+	size_t signal_c_id;
+	size_t signal_d_id;
+	enum counter_function function;
+	int err;
+
+	if (count->id != RZ_MTU3_16_BIT_MTU1_CH) {
+		signal_c_id = count->synapses[2].signal->id;
+		signal_d_id = count->synapses[3].signal->id;
+	}
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
+		if (synapse->signal->id == signal_a_id ||
+		    synapse->signal->id == signal_c_id)
+			*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
+		break;
+	case COUNTER_FUNCTION_QUADRATURE_X2_B:
+		/*
+		 * Any state transition on quadrature pair signal B updates
+		 * the respective count.
+		 */
+		if (synapse->signal->id == signal_b_id ||
+		    synapse->signal->id == signal_d_id)
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
+static struct counter_synapse rz_mtu3_mtu1_count_synapses[] = {
+	{
+		.actions_list = rz_mtu3_synapse_actions,
+		.num_actions = ARRAY_SIZE(rz_mtu3_synapse_actions),
+		.signal = rz_mtu3_signals,
+	},
+	{
+		.actions_list = rz_mtu3_synapse_actions,
+		.num_actions = ARRAY_SIZE(rz_mtu3_synapse_actions),
+		.signal = rz_mtu3_signals + 1,
+	}
+};
+
+static struct counter_synapse rz_mtu3_mtu2_count_synapses[] = {
+	{
+		.actions_list = rz_mtu3_synapse_actions,
+		.num_actions = ARRAY_SIZE(rz_mtu3_synapse_actions),
+		.signal = rz_mtu3_signals,
+	},
+	{
+		.actions_list = rz_mtu3_synapse_actions,
+		.num_actions = ARRAY_SIZE(rz_mtu3_synapse_actions),
+		.signal = rz_mtu3_signals + 1,
+	},
+	{
+		.actions_list = rz_mtu3_synapse_actions,
+		.num_actions = ARRAY_SIZE(rz_mtu3_synapse_actions),
+		.signal = rz_mtu3_signals + 2,
+	},
+	{
+		.actions_list = rz_mtu3_synapse_actions,
+		.num_actions = ARRAY_SIZE(rz_mtu3_synapse_actions),
+		.signal = rz_mtu3_signals + 3,
+	}
+};
+
+static struct counter_count rz_mtu3_counts[] = {
+	{
+		.id = RZ_MTU3_16_BIT_MTU1_CH,
+		.name = "Channel 1 phase counter",
+		.functions_list = rz_mtu3_count_functions,
+		.num_functions = ARRAY_SIZE(rz_mtu3_count_functions),
+		.synapses = rz_mtu3_mtu1_count_synapses,
+		.num_synapses = ARRAY_SIZE(rz_mtu3_mtu1_count_synapses),
+		.ext = rz_mtu3_count_ext,
+		.num_ext = ARRAY_SIZE(rz_mtu3_count_ext),
+	},
+	{
+		.id = RZ_MTU3_16_BIT_MTU2_CH,
+		.name = "Channel 2 phase counter",
+		.functions_list = rz_mtu3_count_functions,
+		.num_functions = ARRAY_SIZE(rz_mtu3_count_functions),
+		.synapses = rz_mtu3_mtu2_count_synapses,
+		.num_synapses = ARRAY_SIZE(rz_mtu3_mtu2_count_synapses),
+		.ext = rz_mtu3_count_ext,
+		.num_ext = ARRAY_SIZE(rz_mtu3_count_ext),
+	},
+	{
+		.id = RZ_MTU3_32_BIT_CH,
+		.name = "Channel 3 Cascaded phase counter",
+		.functions_list = rz_mtu3_count_functions,
+		.num_functions = ARRAY_SIZE(rz_mtu3_count_functions),
+		.synapses = rz_mtu3_mtu2_count_synapses,
+		.num_synapses = ARRAY_SIZE(rz_mtu3_mtu2_count_synapses),
+		.ext = rz_mtu3_count_ext,
+		.num_ext = ARRAY_SIZE(rz_mtu3_count_ext),
+	}
+};
+
+int rz_mtu3_cnt_probe(struct platform_device *pdev)
+{
+	struct rz_mtu3 *ddata = dev_get_drvdata(&pdev->dev);
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
+	ddata->cnt_priv = priv;
+
+	for (i = 0; i < RZ_MTU3_MAX_HW_CNTR_CHANNELS; i++) {
+		priv->ch[i] = &ddata->channels[RZ_MTU1 + i];
+		priv->ch[i]->dev = dev;
+		priv->mtu_16bit_max[i] = U16_MAX;
+	}
+
+	priv->mtu_32bit_max = U32_MAX;
+
+	mutex_init(&priv->lock);
+
+	counter->name = dev_name(dev);
+	counter->parent = dev;
+	counter->ops = &rz_mtu3_cnt_ops;
+	counter->counts = rz_mtu3_counts;
+	counter->num_counts = ARRAY_SIZE(rz_mtu3_counts);
+	counter->signals = rz_mtu3_signals;
+	counter->num_signals = ARRAY_SIZE(rz_mtu3_signals);
+
+	/* Register Counter device */
+	ret = devm_counter_add(dev, counter);
+	if (ret < 0)
+		dev_err_probe(dev, ret, "Failed to add counter\n");
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rz_mtu3_cnt_probe);
+
+MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
+MODULE_DESCRIPTION("Renesas RZ/G2L MTU3a counter driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(COUNTER);
-- 
2.25.1

