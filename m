Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C9F699DF3
	for <lists+linux-iio@lfdr.de>; Thu, 16 Feb 2023 21:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjBPUjC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Feb 2023 15:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjBPUjB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Feb 2023 15:39:01 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46C111ADE6;
        Thu, 16 Feb 2023 12:38:57 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.97,302,1669042800"; 
   d="scan'208";a="153127622"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 17 Feb 2023 05:38:56 +0900
Received: from localhost.localdomain (unknown [10.226.93.2])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 159DE40121D0;
        Fri, 17 Feb 2023 05:38:52 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-iio@vger.kernel.org,
        Lee Jones <lee@kernel.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v13 4/6] counter: Add Renesas RZ/G2L MTU3a counter driver
Date:   Thu, 16 Feb 2023 20:38:28 +0000
Message-Id: <20230216203830.196632-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230216203830.196632-1-biju.das.jz@bp.renesas.com>
References: <20230216203830.196632-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add RZ/G2L MTU3a counter driver. This IP supports the following
phase counting modes on MTU1 and MTU2 channels

1) 16-bit phase counting modes on MTU1 and MTU2 channels.
2) 32-bit phase counting mode by cascading MTU1 and MTU2 channels.

This patch adds 3 counter value channels.
	count0: 16-bit phase counter value channel on MTU1
	count1: 16-bit phase counter value channel on MTU2
	count2: 32-bit phase counter value channel by cascading
                MTU1 and MTU2 channels.

The external input phase clock pin for the counter value channels
are as follows:
	count0: "MTCLKA-MTCLKB"
	count1: "MTCLKA-MTCLKB" or "MTCLKC-MTCLKD"
	count2: "MTCLKA-MTCLKB" or "MTCLKC-MTCLKD"

Use the sysfs variable "external_input_phase_clock_select" to select the
external input phase clock pin and "cascade_counts_enable" to enable/
disable cascading of channels.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: William Breathitt Gray <william.gray@linaro.org>
---
v12->v13:
 * No change.
v11->v12:
 * Updated header file to <linux/mfd/rz-mtu3.h> as core driver is moved to MFD.
v10->v11:
 * Added Rb tag from William Breathitt Gray
 * Replaced count2 channel name from "combined"->"cascaded", as channels
   are cascaded
 * Simplified the locking by adding the helper functions
   rz_mtu3_lock_if_counter_is_valid, rz_mtu3_lock_if_count_is_enabled,
   and rz_mtu3_lock_if_ch0_is_enabled.
v9->v10:
 * Added helper function for rz_mtu3_count_{action,function}_read
 * Added priv->lock in rz_mtu3_count_function_read and rz_mtu3_count_
   direction_read.
 * Added ch->is_busy check for rz_mtu3_action_read()
 * Added rz_mtu3_is_ch0_enabled() for device specific sysfs variables.
 * Added ch->is_busy check for device specific sysfs variables.
v8->v9:
 * Added count_is_enabled variable to struct rz_mtu3_cnt
 * Added check for ch->is_busy and count_is_enabled before every Counter
   callback to ensure we do not try to access a busy channel used by other
   subsystem(eg: pwm).
 * Removed id parameter from rz_mtu3_32bit_cnt_setting()
 * Made definition of rz_mtu3_get_ch() in single line.
 * Replaced break->return in rz_mtu3_32bit_cnt_setting(),
   rz_mtu3_count_function_read() and rz_mtu3_initialize_counter()
   and removed redundant return 0.
 * Simplified synapse signal check for rz_mtu3_action_read().
v7->v8:
 * Simplified rz_mtu3_initialize_counter by calling rz_mtu3_request_
   channel() and release the acquired sibling channel in case of error.
 * Simplified rz_mtu3_terminate_counter by calling rz_mtu3_release_
   channel().
 * Removed unused ceiling and ch_id from rz_mtu3_count_write()
 * Replaced the error -EINVAL->-EBUSY for rz_mtu3_is_counter_invalid()
 * Avoided race between rz_mtu3_count_{read, write} with rz_mtu3_
   cascade_counts_enable_set() by adding locks and moved the lock
   before rz_mtu3_is_counter_invalid()
 * Protected the rz_mtu3_count_ceiling_read() function with a lock
   to make sure the cascade operation mode doesn't not change and
   that the priv data structure accesses don't race when they are
   changed in the ceiling_write() callback.
 * Added lock in rz_mtu3_cascade_enable_set() to make sure the other
   callbacks don't try to read the LWA state while updating LWA.
 * Added lock in rz_mtu3_ext_input_phase_clock_select_set() to ensure
   the other callbacks don't try to read the PHCKSEL state while updating
   PHCKSEL.
 * Added lock to avoid race between rz_mtu3_count_function_write() and
   rz_mtu3_action_read()
 * Updated rz_mtu3_action_read to return 0, if Synapse is in COUNTER_SYNAPSE
   _ACTION_NONE state.
 * Replaced sysfs variable cascade_enable->cascade_counts_enable
 * Renamed rz_mtu3_cascade_enable_get->rz_mtu3_cascade_counts_enable_get
 * Renamed rz_mtu3_cascade_enable_set->rz_mtu3_cascade_counts_enable_set
 * Removed redundent ceiling assignment from rz_mtu3_count_ceiling_read()
 * Removed unused ceiling and ch_id from rz_mtu3_count_write().
v6->v7:
 * Updated commit description
 * Added Register descriptions
 * Opimized size of cache variable by using union
 * Used test_bit() in rz_mtu3_is_counter_invalid()
 * Replaced val->timer_mode in rz_mtu3_count_function_{read,write}
 * Added TODO comment phase3 and phase5 modes.
 * replaced if-else with ternary expression in rz_mtu3_count_direction_read()
 * Used switch statement in rz_mtu3_count_ceiling_read to consistent with write
 * Provided default case for all switch statement.
 * Add mutex lock for avoiding races with other devices
 * Updated comments in rz_mtu3_action_read
 * Replaced COUNTER_COMP_DEVICE_BOOL->COUNTER_COMP_DEVICE_BOOL for 
   cascade_enable
 * Replaced RZ_MTU3_GET_HW_CH->rz_mtu3_get_hw_ch
 * Added rz_mtu3_get_ch() to get channels
 * used rz_mtu3_shared_reg_update_bit for cascade_enable and
   selecting phase input clock.
 * Added rz_mtu3_is_counter_invalid() check in rz_mtu3_count_ceiling_read()
v5->v6:
 * Updated KConfig and commit description
 * Sorted header
 * Fixed RZ_MTU3_GET_HW_CH Macro for argument reuse 'id' - 
   possible side-effects?
 * Replaced SET_RUNTIME_PM_OPS->DEFINE_RUNTIME_DEV_PM_OPS and removed
   __maybe_unused from suspend/resume()
v4->v5:
 * Updated the Kconfig with SoC vendor name
 * Introduced rz_mtu3_is_counter_invalid()
 * replaced pointer to an array of struct rz_mtu3_channel with
   a simple pointer to struct rz_mtu3_channel.
 * Added long_word_access_ctrl_mode sysfs entry for 16-bit and
   32-bit access
 * Added external_input_phase_clock_select sysfs entry for
   selecting input clocks.
 * used preprocessor defines represent SIGNAL_{A,B,C,D}_ID instead of
   signal ids.
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
 drivers/counter/Kconfig       |  11 +
 drivers/counter/Makefile      |   1 +
 drivers/counter/rz-mtu3-cnt.c | 902 ++++++++++++++++++++++++++++++++++
 3 files changed, 914 insertions(+)
 create mode 100644 drivers/counter/rz-mtu3-cnt.c

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index b5ba8fb02cf7..4228be917038 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -73,6 +73,17 @@ config MICROCHIP_TCB_CAPTURE
 	  To compile this driver as a module, choose M here: the
 	  module will be called microchip-tcb-capture.
 
+config RZ_MTU3_CNT
+	tristate "Renesas RZ/G2L MTU3a counter driver"
+	depends on RZ_MTU3 || COMPILE_TEST
+	help
+	  Enable support for MTU3a counter driver found on Renesas RZ/G2L alike
+	  SoCs. This IP supports both 16-bit and 32-bit phase counting mode
+	  support.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called rz-mtu3-cnt.
+
 config STM32_LPTIMER_CNT
 	tristate "STM32 LP Timer encoder counter driver"
 	depends on MFD_STM32_LPTIMER || COMPILE_TEST
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
index 000000000000..c4b5440da878
--- /dev/null
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -0,0 +1,902 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G2L MTU3a Counter driver
+ *
+ * Copyright (C) 2022 Renesas Electronics Corporation
+ */
+
+#include <linux/clk.h>
+#include <linux/counter.h>
+#include <linux/mfd/rz-mtu3.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/types.h>
+
+/*
+ * Register descriptions
+ *   TSR: Timer Status Register
+ *   TMDR1: Timer Mode Register 1
+ *   TMDR3: Timer Mode Register 3
+ *   TIOR: Timer I/O Control Register
+ *   TCR: Timer Control Register
+ *   TCNT: Timer Counter
+ *   TGRA: Timer general register A
+ *   TCNTLW: Timer Longword Counter
+ *   TGRALW: Timer longword general register A
+ */
+
+#define RZ_MTU3_TSR_TCFD	BIT(7) /* Count Direction Flag */
+
+#define RZ_MTU3_TMDR1_PH_CNT_MODE_1	(4) /* Phase counting mode 1 */
+#define RZ_MTU3_TMDR1_PH_CNT_MODE_2	(5) /* Phase counting mode 2 */
+#define RZ_MTU3_TMDR1_PH_CNT_MODE_3	(6) /* Phase counting mode 3 */
+#define RZ_MTU3_TMDR1_PH_CNT_MODE_4	(7) /* Phase counting mode 4 */
+#define RZ_MTU3_TMDR1_PH_CNT_MODE_5	(9) /* Phase counting mode 5 */
+#define RZ_MTU3_TMDR1_PH_CNT_MODE_MASK	(0xf)
+
+/*
+ * LWA: MTU1/MTU2 Combination Longword Access Control
+ * 0: 16-bit, 1: 32-bit
+ */
+#define RZ_MTU3_TMDR3_LWA	(0)
+
+/*
+ * PHCKSEL: External Input Phase Clock Select
+ * 0: MTCLKA and MTCLKB, 1: MTCLKC and MTCLKD
+ */
+#define RZ_MTU3_TMDR3_PHCKSEL	(1)
+
+#define RZ_MTU3_16_BIT_MTU1_CH	(0)
+#define RZ_MTU3_16_BIT_MTU2_CH	(1)
+#define RZ_MTU3_32_BIT_CH	(2)
+
+#define RZ_MTU3_TIOR_NO_OUTPUT	(0) /* Output prohibited */
+#define RZ_MTU3_TIOR_IC_BOTH	(10) /* Input capture at both edges */
+
+#define SIGNAL_A_ID	(0)
+#define SIGNAL_B_ID	(1)
+#define SIGNAL_C_ID	(2)
+#define SIGNAL_D_ID	(3)
+
+#define RZ_MTU3_MAX_HW_CNTR_CHANNELS	(2)
+#define RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS	(3)
+
+/**
+ * struct rz_mtu3_cnt - MTU3 counter private data
+ *
+ * @clk: MTU3 module clock
+ * @lock: Lock to prevent concurrent access for ceiling and count
+ * @ch: HW channels for the counters
+ * @count_is_enabled: Enabled state of Counter value channel
+ * @mtu_16bit_max: Cache for 16-bit counters
+ * @mtu_32bit_max: Cache for 32-bit counters
+ */
+struct rz_mtu3_cnt {
+	struct clk *clk;
+	struct mutex lock;
+	struct rz_mtu3_channel *ch;
+	bool count_is_enabled[RZ_MTU3_MAX_LOGICAL_CNTR_CHANNELS];
+	union {
+		u16 mtu_16bit_max[RZ_MTU3_MAX_HW_CNTR_CHANNELS];
+		u32 mtu_32bit_max;
+	};
+};
+
+static const enum counter_function rz_mtu3_count_functions[] = {
+	COUNTER_FUNCTION_QUADRATURE_X4,
+	COUNTER_FUNCTION_PULSE_DIRECTION,
+	COUNTER_FUNCTION_QUADRATURE_X2_B,
+};
+
+static inline size_t rz_mtu3_get_hw_ch(const size_t id)
+{
+	return (id == RZ_MTU3_32_BIT_CH) ? 0 : id;
+}
+
+static inline struct rz_mtu3_channel *rz_mtu3_get_ch(struct counter_device *counter, int id)
+{
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+	const size_t ch_id = rz_mtu3_get_hw_ch(id);
+
+	return &priv->ch[ch_id];
+}
+
+static bool rz_mtu3_is_counter_invalid(struct counter_device *counter, int id)
+{
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+	unsigned long tmdr;
+
+	pm_runtime_get_sync(priv->ch->dev);
+	tmdr = rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
+	pm_runtime_put(priv->ch->dev);
+
+	if (id == RZ_MTU3_32_BIT_CH && test_bit(RZ_MTU3_TMDR3_LWA, &tmdr))
+		return false;
+
+	if (id != RZ_MTU3_32_BIT_CH && !test_bit(RZ_MTU3_TMDR3_LWA, &tmdr))
+		return false;
+
+	return true;
+}
+
+static int rz_mtu3_lock_if_counter_is_valid(struct counter_device *counter,
+					    struct rz_mtu3_channel *const ch,
+					    struct rz_mtu3_cnt *const priv,
+					    int id)
+{
+	mutex_lock(&priv->lock);
+
+	if (ch->is_busy && !priv->count_is_enabled[id]) {
+		mutex_unlock(&priv->lock);
+		return -EINVAL;
+	}
+
+	if (rz_mtu3_is_counter_invalid(counter, id)) {
+		mutex_unlock(&priv->lock);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int rz_mtu3_lock_if_count_is_enabled(struct rz_mtu3_channel *const ch,
+					    struct rz_mtu3_cnt *const priv,
+					    int id)
+{
+	mutex_lock(&priv->lock);
+
+	if (ch->is_busy && !priv->count_is_enabled[id]) {
+		mutex_unlock(&priv->lock);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rz_mtu3_count_read(struct counter_device *counter,
+			      struct counter_count *count, u64 *val)
+{
+	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+	int ret;
+
+	ret = rz_mtu3_lock_if_counter_is_valid(counter, ch, priv, count->id);
+	if (ret)
+		return ret;
+
+	pm_runtime_get_sync(ch->dev);
+	if (count->id == RZ_MTU3_32_BIT_CH)
+		*val = rz_mtu3_32bit_ch_read(ch, RZ_MTU3_TCNTLW);
+	else
+		*val = rz_mtu3_16bit_ch_read(ch, RZ_MTU3_TCNT);
+	pm_runtime_put(ch->dev);
+	mutex_unlock(&priv->lock);
+
+	return 0;
+}
+
+static int rz_mtu3_count_write(struct counter_device *counter,
+			       struct counter_count *count, const u64 val)
+{
+	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+	int ret;
+
+	ret = rz_mtu3_lock_if_counter_is_valid(counter, ch, priv, count->id);
+	if (ret)
+		return ret;
+
+	pm_runtime_get_sync(ch->dev);
+	if (count->id == RZ_MTU3_32_BIT_CH)
+		rz_mtu3_32bit_ch_write(ch, RZ_MTU3_TCNTLW, val);
+	else
+		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TCNT, val);
+	pm_runtime_put(ch->dev);
+	mutex_unlock(&priv->lock);
+
+	return 0;
+}
+
+static int rz_mtu3_count_function_read_helper(struct rz_mtu3_channel *const ch,
+					      struct rz_mtu3_cnt *const priv,
+					      enum counter_function *function)
+{
+	u8 timer_mode;
+
+	pm_runtime_get_sync(ch->dev);
+	timer_mode = rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TMDR1);
+	pm_runtime_put(ch->dev);
+
+	switch (timer_mode & RZ_MTU3_TMDR1_PH_CNT_MODE_MASK) {
+	case RZ_MTU3_TMDR1_PH_CNT_MODE_1:
+		*function = COUNTER_FUNCTION_QUADRATURE_X4;
+		return 0;
+	case RZ_MTU3_TMDR1_PH_CNT_MODE_2:
+		*function = COUNTER_FUNCTION_PULSE_DIRECTION;
+		return 0;
+	case RZ_MTU3_TMDR1_PH_CNT_MODE_4:
+		*function = COUNTER_FUNCTION_QUADRATURE_X2_B;
+		return 0;
+	default:
+		/*
+		 * TODO:
+		 *  - need to add RZ_MTU3_TMDR1_PH_CNT_MODE_3
+		 *  - need to add RZ_MTU3_TMDR1_PH_CNT_MODE_5
+		 */
+		return -EINVAL;
+	}
+}
+
+static int rz_mtu3_count_function_read(struct counter_device *counter,
+				       struct counter_count *count,
+				       enum counter_function *function)
+{
+	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+	int ret;
+
+	ret = rz_mtu3_lock_if_count_is_enabled(ch, priv, count->id);
+	if (ret)
+		return ret;
+
+	ret = rz_mtu3_count_function_read_helper(ch, priv, function);
+	mutex_unlock(&priv->lock);
+
+	return ret;
+}
+
+static int rz_mtu3_count_function_write(struct counter_device *counter,
+					struct counter_count *count,
+					enum counter_function function)
+{
+	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+	u8 timer_mode;
+	int ret;
+
+	ret = rz_mtu3_lock_if_count_is_enabled(ch, priv, count->id);
+	if (ret)
+		return ret;
+
+	switch (function) {
+	case COUNTER_FUNCTION_QUADRATURE_X4:
+		timer_mode = RZ_MTU3_TMDR1_PH_CNT_MODE_1;
+		break;
+	case COUNTER_FUNCTION_PULSE_DIRECTION:
+		timer_mode = RZ_MTU3_TMDR1_PH_CNT_MODE_2;
+		break;
+	case COUNTER_FUNCTION_QUADRATURE_X2_B:
+		timer_mode = RZ_MTU3_TMDR1_PH_CNT_MODE_4;
+		break;
+	default:
+		/*
+		 * TODO:
+		 *  - need to add RZ_MTU3_TMDR1_PH_CNT_MODE_3
+		 *  - need to add RZ_MTU3_TMDR1_PH_CNT_MODE_5
+		 */
+		mutex_unlock(&priv->lock);
+		return -EINVAL;
+	}
+
+	pm_runtime_get_sync(ch->dev);
+	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, timer_mode);
+	pm_runtime_put(ch->dev);
+	mutex_unlock(&priv->lock);
+
+	return 0;
+}
+
+static int rz_mtu3_count_direction_read(struct counter_device *counter,
+					struct counter_count *count,
+					enum counter_count_direction *direction)
+{
+	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+	int ret;
+	u8 tsr;
+
+	ret = rz_mtu3_lock_if_count_is_enabled(ch, priv, count->id);
+	if (ret)
+		return ret;
+
+	pm_runtime_get_sync(ch->dev);
+	tsr = rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TSR);
+	pm_runtime_put(ch->dev);
+
+	*direction = (tsr & RZ_MTU3_TSR_TCFD) ?
+		COUNTER_COUNT_DIRECTION_FORWARD : COUNTER_COUNT_DIRECTION_BACKWARD;
+	mutex_unlock(&priv->lock);
+
+	return 0;
+}
+
+static int rz_mtu3_count_ceiling_read(struct counter_device *counter,
+				      struct counter_count *count,
+				      u64 *ceiling)
+{
+	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+	const size_t ch_id = rz_mtu3_get_hw_ch(count->id);
+	int ret;
+
+	ret = rz_mtu3_lock_if_counter_is_valid(counter, ch, priv, count->id);
+	if (ret)
+		return ret;
+
+	switch (count->id) {
+	case RZ_MTU3_16_BIT_MTU1_CH:
+	case RZ_MTU3_16_BIT_MTU2_CH:
+		*ceiling = priv->mtu_16bit_max[ch_id];
+		break;
+	case RZ_MTU3_32_BIT_CH:
+		*ceiling = priv->mtu_32bit_max;
+		break;
+	default:
+		/* should never reach this path */
+		mutex_unlock(&priv->lock);
+		return -EINVAL;
+	}
+
+	mutex_unlock(&priv->lock);
+	return 0;
+}
+
+static int rz_mtu3_count_ceiling_write(struct counter_device *counter,
+				       struct counter_count *count,
+				       u64 ceiling)
+{
+	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+	const size_t ch_id = rz_mtu3_get_hw_ch(count->id);
+	int ret;
+
+	ret = rz_mtu3_lock_if_counter_is_valid(counter, ch, priv, count->id);
+	if (ret)
+		return ret;
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
+	default:
+		/* should never reach this path */
+		mutex_unlock(&priv->lock);
+		return -EINVAL;
+	}
+
+	pm_runtime_get_sync(ch->dev);
+	if (count->id == RZ_MTU3_32_BIT_CH)
+		rz_mtu3_32bit_ch_write(ch, RZ_MTU3_TGRALW, ceiling);
+	else
+		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRA, ceiling);
+
+	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR, RZ_MTU3_TCR_CCLR_TGRA);
+	pm_runtime_put(ch->dev);
+	mutex_unlock(&priv->lock);
+
+	return 0;
+}
+
+static void rz_mtu3_32bit_cnt_setting(struct counter_device *counter)
+{
+	struct rz_mtu3_channel *const ch1 = rz_mtu3_get_ch(counter, 0);
+	struct rz_mtu3_channel *const ch2 = rz_mtu3_get_ch(counter, 1);
+
+	/* Phase counting mode 1 is used as default in initialization. */
+	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TMDR1, RZ_MTU3_TMDR1_PH_CNT_MODE_1);
+
+	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TCR, RZ_MTU3_TCR_CCLR_TGRA);
+	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TIOR, RZ_MTU3_TIOR_IC_BOTH);
+
+	rz_mtu3_enable(ch1);
+	rz_mtu3_enable(ch2);
+}
+
+static void rz_mtu3_16bit_cnt_setting(struct counter_device *counter, int id)
+{
+	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, id);
+
+	/* Phase counting mode 1 is used as default in initialization. */
+	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, RZ_MTU3_TMDR1_PH_CNT_MODE_1);
+
+	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR, RZ_MTU3_TCR_CCLR_TGRA);
+	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TIOR, RZ_MTU3_TIOR_NO_OUTPUT);
+	rz_mtu3_enable(ch);
+}
+
+static int rz_mtu3_initialize_counter(struct counter_device *counter, int id)
+{
+	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, id);
+	struct rz_mtu3_channel *const ch1 = rz_mtu3_get_ch(counter, 0);
+	struct rz_mtu3_channel *const ch2 = rz_mtu3_get_ch(counter, 1);
+
+	switch (id) {
+	case RZ_MTU3_16_BIT_MTU1_CH:
+	case RZ_MTU3_16_BIT_MTU2_CH:
+		if (!rz_mtu3_request_channel(ch))
+			return -EBUSY;
+
+		rz_mtu3_16bit_cnt_setting(counter, id);
+		return 0;
+	case RZ_MTU3_32_BIT_CH:
+		/*
+		 * 32-bit phase counting need MTU1 and MTU2 to create 32-bit
+		 * cascade counter.
+		 */
+		if (!rz_mtu3_request_channel(ch1))
+			return -EBUSY;
+
+		if (!rz_mtu3_request_channel(ch2)) {
+			rz_mtu3_release_channel(ch1);
+			return -EBUSY;
+		}
+
+		rz_mtu3_32bit_cnt_setting(counter);
+		return 0;
+	default:
+		/* should never reach this path */
+		return -EINVAL;
+	}
+}
+
+static void rz_mtu3_terminate_counter(struct counter_device *counter, int id)
+{
+	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, id);
+	struct rz_mtu3_channel *const ch1 = rz_mtu3_get_ch(counter, 0);
+	struct rz_mtu3_channel *const ch2 = rz_mtu3_get_ch(counter, 1);
+
+	if (id == RZ_MTU3_32_BIT_CH) {
+		rz_mtu3_release_channel(ch2);
+		rz_mtu3_release_channel(ch1);
+		rz_mtu3_disable(ch2);
+		rz_mtu3_disable(ch1);
+	} else {
+		rz_mtu3_release_channel(ch);
+		rz_mtu3_disable(ch);
+	}
+}
+
+static int rz_mtu3_count_enable_read(struct counter_device *counter,
+				     struct counter_count *count, u8 *enable)
+{
+	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
+	struct rz_mtu3_channel *const ch1 = rz_mtu3_get_ch(counter, 0);
+	struct rz_mtu3_channel *const ch2 = rz_mtu3_get_ch(counter, 1);
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+	int ret;
+
+	ret = rz_mtu3_lock_if_count_is_enabled(ch, priv, count->id);
+	if (ret)
+		return ret;
+
+	if (count->id == RZ_MTU3_32_BIT_CH)
+		*enable = rz_mtu3_is_enabled(ch1) && rz_mtu3_is_enabled(ch2);
+	else
+		*enable = rz_mtu3_is_enabled(ch);
+
+	mutex_unlock(&priv->lock);
+
+	return 0;
+}
+
+static int rz_mtu3_count_enable_write(struct counter_device *counter,
+				      struct counter_count *count, u8 enable)
+{
+	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+	int ret = 0;
+
+	if (enable) {
+		pm_runtime_get_sync(ch->dev);
+		mutex_lock(&priv->lock);
+		ret = rz_mtu3_initialize_counter(counter, count->id);
+		if (ret == 0)
+			priv->count_is_enabled[count->id] = true;
+		mutex_unlock(&priv->lock);
+	} else {
+		mutex_lock(&priv->lock);
+		rz_mtu3_terminate_counter(counter, count->id);
+		priv->count_is_enabled[count->id] = false;
+		mutex_unlock(&priv->lock);
+		pm_runtime_put(ch->dev);
+	}
+
+	return ret;
+}
+
+static int rz_mtu3_lock_if_ch0_is_enabled(struct rz_mtu3_cnt *const priv)
+{
+	mutex_lock(&priv->lock);
+	if (priv->ch->is_busy && !(priv->count_is_enabled[RZ_MTU3_16_BIT_MTU1_CH] ||
+				   priv->count_is_enabled[RZ_MTU3_32_BIT_CH])) {
+		mutex_unlock(&priv->lock);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rz_mtu3_cascade_counts_enable_get(struct counter_device *counter,
+					     u8 *cascade_enable)
+{
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+	unsigned long tmdr;
+	int ret;
+
+	ret = rz_mtu3_lock_if_ch0_is_enabled(priv);
+	if (ret)
+		return ret;
+
+	pm_runtime_get_sync(priv->ch->dev);
+	tmdr = rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
+	pm_runtime_put(priv->ch->dev);
+	*cascade_enable = test_bit(RZ_MTU3_TMDR3_LWA, &tmdr);
+	mutex_unlock(&priv->lock);
+
+	return 0;
+}
+
+static int rz_mtu3_cascade_counts_enable_set(struct counter_device *counter,
+					     u8 cascade_enable)
+{
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+	int ret;
+
+	ret = rz_mtu3_lock_if_ch0_is_enabled(priv);
+	if (ret)
+		return ret;
+
+	pm_runtime_get_sync(priv->ch->dev);
+	rz_mtu3_shared_reg_update_bit(priv->ch, RZ_MTU3_TMDR3,
+				      RZ_MTU3_TMDR3_LWA, cascade_enable);
+	pm_runtime_put(priv->ch->dev);
+	mutex_unlock(&priv->lock);
+
+	return 0;
+}
+
+static int rz_mtu3_ext_input_phase_clock_select_get(struct counter_device *counter,
+						    u32 *ext_input_phase_clock_select)
+{
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+	unsigned long tmdr;
+	int ret;
+
+	ret = rz_mtu3_lock_if_ch0_is_enabled(priv);
+	if (ret)
+		return ret;
+
+	pm_runtime_get_sync(priv->ch->dev);
+	tmdr = rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
+	pm_runtime_put(priv->ch->dev);
+	*ext_input_phase_clock_select = test_bit(RZ_MTU3_TMDR3_PHCKSEL, &tmdr);
+	mutex_unlock(&priv->lock);
+
+	return 0;
+}
+
+static int rz_mtu3_ext_input_phase_clock_select_set(struct counter_device *counter,
+						    u32 ext_input_phase_clock_select)
+{
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+	int ret;
+
+	ret = rz_mtu3_lock_if_ch0_is_enabled(priv);
+	if (ret)
+		return ret;
+
+	pm_runtime_get_sync(priv->ch->dev);
+	rz_mtu3_shared_reg_update_bit(priv->ch, RZ_MTU3_TMDR3,
+				      RZ_MTU3_TMDR3_PHCKSEL,
+				      ext_input_phase_clock_select);
+	pm_runtime_put(priv->ch->dev);
+	mutex_unlock(&priv->lock);
+
+	return 0;
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
+	const bool is_signal_ab = (synapse->signal->id == SIGNAL_A_ID) ||
+				  (synapse->signal->id == SIGNAL_B_ID);
+	struct rz_mtu3_channel *const ch = rz_mtu3_get_ch(counter, count->id);
+	struct rz_mtu3_cnt *const priv = counter_priv(counter);
+	enum counter_function function;
+	bool mtclkc_mtclkd;
+	unsigned long tmdr;
+	int ret;
+
+	ret = rz_mtu3_lock_if_count_is_enabled(ch, priv, count->id);
+	if (ret)
+		return ret;
+
+	ret = rz_mtu3_count_function_read_helper(ch, priv, &function);
+	if (ret) {
+		mutex_unlock(&priv->lock);
+		return ret;
+	}
+
+	/* Default action mode */
+	*action = COUNTER_SYNAPSE_ACTION_NONE;
+
+	if (count->id != RZ_MTU3_16_BIT_MTU1_CH) {
+		tmdr = rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
+		mtclkc_mtclkd = test_bit(RZ_MTU3_TMDR3_PHCKSEL, &tmdr);
+		if ((mtclkc_mtclkd && is_signal_ab) ||
+		    (!mtclkc_mtclkd && !is_signal_ab)) {
+			mutex_unlock(&priv->lock);
+			return 0;
+		}
+	}
+
+	switch (function) {
+	case COUNTER_FUNCTION_PULSE_DIRECTION:
+		/*
+		 * Rising edges on signal A (signal C) updates the respective
+		 * count. The input level of signal B (signal D) determines
+		 * direction.
+		 */
+		if (synapse->signal->id == SIGNAL_A_ID ||
+		    synapse->signal->id == SIGNAL_C_ID)
+			*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
+		break;
+	case COUNTER_FUNCTION_QUADRATURE_X2_B:
+		/*
+		 * Any state transition on quadrature pair signal B (signal D)
+		 * updates the respective count.
+		 */
+		if (synapse->signal->id == SIGNAL_B_ID ||
+		    synapse->signal->id == SIGNAL_D_ID)
+			*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
+		break;
+	case COUNTER_FUNCTION_QUADRATURE_X4:
+		/* counts up/down on both edges of A (C)  and B (D) signal */
+		*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
+		break;
+	default:
+		/* should never reach this path */
+		mutex_unlock(&priv->lock);
+		return -EINVAL;
+	}
+
+	mutex_unlock(&priv->lock);
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
+	RZ_MTU3_PHASE_SIGNAL(SIGNAL_A_ID, "MTU1 MTCLKA"),
+	RZ_MTU3_PHASE_SIGNAL(SIGNAL_B_ID, "MTU1 MTCLKB"),
+	RZ_MTU3_PHASE_SIGNAL(SIGNAL_C_ID, "MTU2 MTCLKC"),
+	RZ_MTU3_PHASE_SIGNAL(SIGNAL_D_ID, "MTU2 MTCLKD"),
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
+		.name = "Channel 1 Count",
+		.functions_list = rz_mtu3_count_functions,
+		.num_functions = ARRAY_SIZE(rz_mtu3_count_functions),
+		.synapses = rz_mtu3_mtu1_count_synapses,
+		.num_synapses = ARRAY_SIZE(rz_mtu3_mtu1_count_synapses),
+		.ext = rz_mtu3_count_ext,
+		.num_ext = ARRAY_SIZE(rz_mtu3_count_ext),
+	},
+	{
+		.id = RZ_MTU3_16_BIT_MTU2_CH,
+		.name = "Channel 2 Count",
+		.functions_list = rz_mtu3_count_functions,
+		.num_functions = ARRAY_SIZE(rz_mtu3_count_functions),
+		.synapses = rz_mtu3_mtu2_count_synapses,
+		.num_synapses = ARRAY_SIZE(rz_mtu3_mtu2_count_synapses),
+		.ext = rz_mtu3_count_ext,
+		.num_ext = ARRAY_SIZE(rz_mtu3_count_ext),
+	},
+	{
+		.id = RZ_MTU3_32_BIT_CH,
+		.name = "Channel 1 and 2 (cascaded) Count",
+		.functions_list = rz_mtu3_count_functions,
+		.num_functions = ARRAY_SIZE(rz_mtu3_count_functions),
+		.synapses = rz_mtu3_mtu2_count_synapses,
+		.num_synapses = ARRAY_SIZE(rz_mtu3_mtu2_count_synapses),
+		.ext = rz_mtu3_count_ext,
+		.num_ext = ARRAY_SIZE(rz_mtu3_count_ext),
+	}
+};
+
+static const char *const rz_mtu3_ext_input_phase_clock_select[] = {
+	"MTCLKA-MTCLKB",
+	"MTCLKC-MTCLKD",
+};
+
+static DEFINE_COUNTER_ENUM(rz_mtu3_ext_input_phase_clock_select_enum,
+			   rz_mtu3_ext_input_phase_clock_select);
+
+static struct counter_comp rz_mtu3_device_ext[] = {
+	COUNTER_COMP_DEVICE_BOOL("cascade_counts_enable",
+				 rz_mtu3_cascade_counts_enable_get,
+				 rz_mtu3_cascade_counts_enable_set),
+	COUNTER_COMP_DEVICE_ENUM("external_input_phase_clock_select",
+				 rz_mtu3_ext_input_phase_clock_select_get,
+				 rz_mtu3_ext_input_phase_clock_select_set,
+				 rz_mtu3_ext_input_phase_clock_select_enum),
+};
+
+static int rz_mtu3_cnt_pm_runtime_suspend(struct device *dev)
+{
+	struct clk *const clk = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(clk);
+
+	return 0;
+}
+
+static int rz_mtu3_cnt_pm_runtime_resume(struct device *dev)
+{
+	struct clk *const clk = dev_get_drvdata(dev);
+
+	clk_prepare_enable(clk);
+
+	return 0;
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(rz_mtu3_cnt_pm_ops,
+				 rz_mtu3_cnt_pm_runtime_suspend,
+				 rz_mtu3_cnt_pm_runtime_resume, NULL);
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
+	struct rz_mtu3_channel *ch;
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
+	priv->mtu_32bit_max = U32_MAX;
+	priv->ch = &ddata->channels[RZ_MTU1];
+	ch = &priv->ch[0];
+	for (i = 0; i < RZ_MTU3_MAX_HW_CNTR_CHANNELS; i++) {
+		ch->dev = dev;
+		priv->mtu_16bit_max[i] = U16_MAX;
+		ch++;
+	}
+
+	mutex_init(&priv->lock);
+	platform_set_drvdata(pdev, priv->clk);
+	clk_prepare_enable(priv->clk);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	ret = devm_add_action_or_reset(&pdev->dev, rz_mtu3_cnt_pm_disable, dev);
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
+	counter->ext = rz_mtu3_device_ext;
+	counter->num_ext = ARRAY_SIZE(rz_mtu3_device_ext);
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
+static struct platform_driver rz_mtu3_cnt_driver = {
+	.probe = rz_mtu3_cnt_probe,
+	.driver = {
+		.name = "rz-mtu3-counter",
+		.pm = pm_ptr(&rz_mtu3_cnt_pm_ops),
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

