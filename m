Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E31E391B1F
	for <lists+linux-iio@lfdr.de>; Wed, 26 May 2021 17:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbhEZPHp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 May 2021 11:07:45 -0400
Received: from mga06.intel.com ([134.134.136.31]:51126 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233554AbhEZPHo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 May 2021 11:07:44 -0400
IronPort-SDR: uiHff4kifQrbEusm4wdaCOau2Ww//TY3V6m1aTCyDg6/vbkjKN7XfeqgHl4/oEEtky/TRbOB60
 Iaxz30jpHfqA==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="263692117"
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="263692117"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 08:06:09 -0700
IronPort-SDR: p/Rub1dkEKsPAYfzP59hKHRY5GTWQE5XTd0jmw44xLzy6TL/LzPgRiwsBYOfORRWAgJG6tADBL
 /ZFjkLyOuL+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="397346182"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.166])
  by orsmga003.jf.intel.com with ESMTP; 26 May 2021 08:06:07 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-iio@vger.kernel.org
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH v2 2/2] counter: Add support for Intel Quadrature Encoder Peripheral
Date:   Wed, 26 May 2021 18:06:01 +0300
Message-Id: <20210526150601.3605866-2-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210526150601.3605866-1-jarkko.nikula@linux.intel.com>
References: <20210526150601.3605866-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for Intel Quadrature Encoder Peripheral found on Intel
Elkhart Lake platform.

Initial implementation was done by Felipe Balbi while he was working at
Intel with later changes from Raymond Tan and me.

Co-developed-by: Felipe Balbi (Intel) <balbi@kernel.org>
Signed-off-by: Felipe Balbi (Intel) <balbi@kernel.org>
Co-developed-by: Raymond Tan <raymond.tan@intel.com>
Signed-off-by: Raymond Tan <raymond.tan@intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
v2:
- counter_to_qep() macro -> counter->priv
- Use sysfs_emit for user space returned values
- Use kstrbool for boolean values from userspace
- enable_write() reworked to be more readable
- Reworked synapse action control and new sysfs attribute "invert"
  * Action control before was wrong - what HW does is signal inversion.
    Implemented "invert" sysfs attribute for it and read-only action
    mode sysfs returning constant "both edges"
- Renamed sysfs attribe "noise" as "spike_filter_ns" and define
  programmable spike filter in terms of nanoseconds instead of raw
  register value
- Above and "ceiling" sysfs attribe changed as count extensions instead
  of device extensions
- Signal IDs rearranged to be zero based in order to prepare for counter
  character device interface patches in order to ensure same userspace
  sysfs paths
- Initializer macros for counter_signal and counter_synapse
  initialization
- Grouping intel_qep_counter_ops, intel_qep_signal_ext and enums near to
  their callback functions and use
- "invert" and "spike_filter_ns" sysfs attributes documented
- Other minor changes like local variable and empty line removal, etc

v1: https://www.spinics.net/lists/linux-iio/msg59652.html
---
 Documentation/ABI/testing/sysfs-bus-counter |  19 +
 drivers/counter/Kconfig                     |  10 +
 drivers/counter/Makefile                    |   1 +
 drivers/counter/intel-qep.c                 | 651 ++++++++++++++++++++
 4 files changed, 681 insertions(+)
 create mode 100644 drivers/counter/intel-qep.c

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index 8f1e3de88c77..19bdb32d450a 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -197,6 +197,15 @@ Description:
 		both edges:
 			Any state transition.
 
+What:		/sys/bus/counter/devices/counterX/countY/spike_filter_ns
+KernelVersion:	5.14
+Contact:	linux-iio@vger.kernel.org
+Description:
+		If the counter device supports programmable spike filter this
+		attribute indicates the value in nanoseconds where noise pulses
+		shorter or equal to configured value are ignored. Value 0 means
+		filter is disabled.
+
 What:		/sys/bus/counter/devices/counterX/name
 KernelVersion:	5.2
 Contact:	linux-iio@vger.kernel.org
@@ -232,3 +241,13 @@ Description:
 		Read-only attribute that indicates the device-specific name of
 		Signal Y. If possible, this should match the name of the
 		respective signal as it appears in the device datasheet.
+
+What:		/sys/bus/counter/devices/counterX/signalY/invert
+KernelVersion:	5.14
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Whether signal Y inversion is enabled. Valid attribute values
+		are boolean.
+
+		For counter devices that have feature to control inversion of
+		signal Y.
diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index 5328705aa09c..d5d2540b30c2 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -91,4 +91,14 @@ config MICROCHIP_TCB_CAPTURE
 	  To compile this driver as a module, choose M here: the
 	  module will be called microchip-tcb-capture.
 
+config INTEL_QEP
+	tristate "Intel Quadrature Encoder Peripheral driver"
+	depends on PCI
+	help
+	  Select this option to enable the Intel Quadrature Encoder Peripheral
+	  driver.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called intel-qep.
+
 endif # COUNTER
diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
index cb646ed2f039..19742e6f5e3e 100644
--- a/drivers/counter/Makefile
+++ b/drivers/counter/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
 obj-$(CONFIG_TI_EQEP)		+= ti-eqep.o
 obj-$(CONFIG_FTM_QUADDEC)	+= ftm-quaddec.o
 obj-$(CONFIG_MICROCHIP_TCB_CAPTURE)	+= microchip-tcb-capture.o
+obj-$(CONFIG_INTEL_QEP)		+= intel-qep.o
diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
new file mode 100644
index 000000000000..d3a5e4e93794
--- /dev/null
+++ b/drivers/counter/intel-qep.c
@@ -0,0 +1,651 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel Quadrature Encoder Peripheral driver
+ *
+ * Copyright (C) 2019-2021 Intel Corporation
+ *
+ * Author: Felipe Balbi (Intel)
+ * Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
+ * Author: Raymond Tan <raymond.tan@intel.com>
+ */
+#include <linux/bitops.h>
+#include <linux/counter.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/pm_runtime.h>
+
+#define INTEL_QEPCON			0x00
+#define INTEL_QEPFLT			0x04
+#define INTEL_QEPCOUNT			0x08
+#define INTEL_QEPMAX			0x0c
+#define INTEL_QEPWDT			0x10
+#define INTEL_QEPCAPDIV			0x14
+#define INTEL_QEPCNTR			0x18
+#define INTEL_QEPCAPBUF			0x1c
+#define INTEL_QEPINT_STAT		0x20
+#define INTEL_QEPINT_MASK		0x24
+
+/* QEPCON */
+#define INTEL_QEPCON_EN			BIT(0)
+#define INTEL_QEPCON_FLT_EN		BIT(1)
+#define INTEL_QEPCON_EDGE_A		BIT(2)
+#define INTEL_QEPCON_EDGE_B		BIT(3)
+#define INTEL_QEPCON_EDGE_INDX		BIT(4)
+#define INTEL_QEPCON_SWPAB		BIT(5)
+#define INTEL_QEPCON_OP_MODE		BIT(6)
+#define INTEL_QEPCON_PH_ERR		BIT(7)
+#define INTEL_QEPCON_COUNT_RST_MODE	BIT(8)
+#define INTEL_QEPCON_INDX_GATING_MASK	GENMASK(10, 9)
+#define INTEL_QEPCON_INDX_GATING(n)	(((n) & 3) << 9)
+#define INTEL_QEPCON_INDX_PAL_PBL	INTEL_QEPCON_INDX_GATING(0)
+#define INTEL_QEPCON_INDX_PAL_PBH	INTEL_QEPCON_INDX_GATING(1)
+#define INTEL_QEPCON_INDX_PAH_PBL	INTEL_QEPCON_INDX_GATING(2)
+#define INTEL_QEPCON_INDX_PAH_PBH	INTEL_QEPCON_INDX_GATING(3)
+#define INTEL_QEPCON_CAP_MODE		BIT(11)
+#define INTEL_QEPCON_FIFO_THRE_MASK	GENMASK(14, 12)
+#define INTEL_QEPCON_FIFO_THRE(n)	((((n) - 1) & 7) << 12)
+#define INTEL_QEPCON_FIFO_EMPTY		BIT(15)
+
+/* QEPFLT */
+#define INTEL_QEPFLT_MAX_COUNT(n)	((n) & 0x1fffff)
+
+/* QEPINT */
+#define INTEL_QEPINT_FIFOCRIT		BIT(5)
+#define INTEL_QEPINT_FIFOENTRY		BIT(4)
+#define INTEL_QEPINT_QEPDIR		BIT(3)
+#define INTEL_QEPINT_QEPRST_UP		BIT(2)
+#define INTEL_QEPINT_QEPRST_DOWN	BIT(1)
+#define INTEL_QEPINT_WDT		BIT(0)
+
+#define INTEL_QEPINT_MASK_ALL		GENMASK(5, 0)
+
+#define INTEL_QEP_CLK_PERIOD_NS		10
+
+#define INTEL_QEP_COUNTER_EXT_RW(_name) \
+{ \
+	.name = #_name, \
+	.read = _name##_read, \
+	.write = _name##_write, \
+}
+
+struct intel_qep {
+	struct counter_device counter;
+	struct mutex lock;
+	struct device *dev;
+	void __iomem *regs;
+	bool enabled;
+	/* Context save registers */
+	u32 qepcon;
+	u32 qepflt;
+	u32 qepmax;
+};
+
+static inline u32 intel_qep_readl(struct intel_qep *qep, u32 offset)
+{
+	return readl(qep->regs + offset);
+}
+
+static inline void intel_qep_writel(struct intel_qep *qep,
+				    u32 offset, u32 value)
+{
+	writel(value, qep->regs + offset);
+}
+
+static void intel_qep_init(struct intel_qep *qep)
+{
+	u32 reg;
+
+	reg = intel_qep_readl(qep, INTEL_QEPCON);
+	reg &= ~INTEL_QEPCON_EN;
+	intel_qep_writel(qep, INTEL_QEPCON, reg);
+	qep->enabled = false;
+	/*
+	 * Make sure peripheral is disabled by flushing the write with
+	 * a dummy read
+	 */
+	reg = intel_qep_readl(qep, INTEL_QEPCON);
+
+	reg &= ~(INTEL_QEPCON_OP_MODE | INTEL_QEPCON_FLT_EN);
+	reg |= INTEL_QEPCON_EDGE_A | INTEL_QEPCON_EDGE_B |
+	       INTEL_QEPCON_EDGE_INDX | INTEL_QEPCON_COUNT_RST_MODE;
+	intel_qep_writel(qep, INTEL_QEPCON, reg);
+	intel_qep_writel(qep, INTEL_QEPINT_MASK, INTEL_QEPINT_MASK_ALL);
+}
+
+static int intel_qep_count_read(struct counter_device *counter,
+				struct counter_count *count,
+				unsigned long *val)
+{
+	struct intel_qep *const qep = counter->priv;
+
+	pm_runtime_get_sync(qep->dev);
+	*val = intel_qep_readl(qep, INTEL_QEPCOUNT);
+	pm_runtime_put(qep->dev);
+
+	return 0;
+}
+
+enum intel_qep_count_function {
+	INTEL_QEP_ENCODER_MODE_NORMAL,
+	INTEL_QEP_ENCODER_MODE_SWAPPED,
+};
+
+static const enum counter_count_function intel_qep_count_functions[] = {
+	[INTEL_QEP_ENCODER_MODE_NORMAL] =
+	COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
+
+	[INTEL_QEP_ENCODER_MODE_SWAPPED] =
+	COUNTER_COUNT_FUNCTION_QUADRATURE_X4_SWAPPED,
+};
+
+static int intel_qep_function_get(struct counter_device *counter,
+				  struct counter_count *count,
+				  size_t *function)
+{
+	struct intel_qep *qep = counter->priv;
+	u32 reg;
+
+	pm_runtime_get_sync(qep->dev);
+	reg = intel_qep_readl(qep, INTEL_QEPCON);
+	pm_runtime_put(qep->dev);
+	if (reg & INTEL_QEPCON_SWPAB)
+		*function = INTEL_QEP_ENCODER_MODE_SWAPPED;
+	else
+		*function = INTEL_QEP_ENCODER_MODE_NORMAL;
+
+	return 0;
+}
+
+static int intel_qep_function_set(struct counter_device *counter,
+				  struct counter_count *count,
+				  size_t function)
+{
+	struct intel_qep *qep = counter->priv;
+	int ret = 0;
+	u32 reg;
+
+	mutex_lock(&qep->lock);
+	if (qep->enabled) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	pm_runtime_get_sync(qep->dev);
+	reg = intel_qep_readl(qep, INTEL_QEPCON);
+	if (function == INTEL_QEP_ENCODER_MODE_SWAPPED)
+		reg |= INTEL_QEPCON_SWPAB;
+	else
+		reg &= ~INTEL_QEPCON_SWPAB;
+	intel_qep_writel(qep, INTEL_QEPCON, reg);
+	pm_runtime_put(qep->dev);
+
+out:
+	mutex_unlock(&qep->lock);
+	return ret;
+}
+
+static const enum counter_synapse_action intel_qep_synapse_actions[] = {
+	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
+};
+
+static int intel_qep_action_get(struct counter_device *counter,
+				struct counter_count *count,
+				struct counter_synapse *synapse,
+				size_t *action)
+{
+	*action = 0;
+	return 0;
+}
+
+static const struct counter_ops intel_qep_counter_ops = {
+	.count_read = intel_qep_count_read,
+	.function_get = intel_qep_function_get,
+	.function_set = intel_qep_function_set,
+	.action_get = intel_qep_action_get,
+};
+
+static ssize_t intel_qep_signal_invert_read(struct counter_device *counter,
+					    struct counter_signal *signal,
+					    void *priv, char *buf)
+{
+	struct intel_qep *qep = counter->priv;
+	u32 reg;
+
+	pm_runtime_get_sync(qep->dev);
+	reg = intel_qep_readl(qep, INTEL_QEPCON);
+	pm_runtime_put(qep->dev);
+
+	return sysfs_emit(buf, "%u\n", !(reg & (uintptr_t)signal->priv));
+}
+
+static ssize_t intel_qep_signal_invert_write(struct counter_device *counter,
+					     struct counter_signal *signal,
+					     void *priv, const char *buf,
+					     size_t len)
+{
+	struct intel_qep *qep = counter->priv;
+	bool invert;
+	int ret;
+	u32 reg;
+
+	ret = kstrtobool(buf, &invert);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&qep->lock);
+	if (qep->enabled) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	pm_runtime_get_sync(qep->dev);
+	reg = intel_qep_readl(qep, INTEL_QEPCON);
+	if (invert == true)
+		reg &= ~(uintptr_t)signal->priv;
+	else
+		reg |= (uintptr_t)signal->priv;
+	intel_qep_writel(qep, INTEL_QEPCON, reg);
+	pm_runtime_put(qep->dev);
+	ret = len;
+
+out:
+	mutex_unlock(&qep->lock);
+	return ret;
+}
+
+static const struct counter_signal_ext intel_qep_signal_ext[] = {
+	{
+		.name = "invert",
+		.read = intel_qep_signal_invert_read,
+		.write = intel_qep_signal_invert_write,
+	},
+};
+
+#define INTEL_QEP_SIGNAL(_id, _name, _priv) {		\
+	.id = (_id),					\
+	.name = (_name),				\
+	.ext = intel_qep_signal_ext,			\
+	.num_ext = ARRAY_SIZE(intel_qep_signal_ext),	\
+	.priv = (void *)_priv,				\
+}
+
+static struct counter_signal intel_qep_signals[] = {
+	INTEL_QEP_SIGNAL(0, "Phase A", INTEL_QEPCON_EDGE_A),
+	INTEL_QEP_SIGNAL(1, "Phase B", INTEL_QEPCON_EDGE_A),
+	INTEL_QEP_SIGNAL(2, "Index", INTEL_QEPCON_EDGE_A),
+};
+
+#define INTEL_QEP_SYNAPSE(_signal_id) {				\
+	.actions_list = intel_qep_synapse_actions,		\
+	.num_actions = ARRAY_SIZE(intel_qep_synapse_actions),	\
+	.signal = &intel_qep_signals[(_signal_id)],		\
+}
+
+static struct counter_synapse intel_qep_count_synapses[] = {
+	INTEL_QEP_SYNAPSE(0),
+	INTEL_QEP_SYNAPSE(1),
+	INTEL_QEP_SYNAPSE(2),
+};
+
+static ssize_t ceiling_read(struct counter_device *counter,
+			    struct counter_count *count,
+			    void *priv, char *buf)
+{
+	struct intel_qep *qep = counter->priv;
+	u32 reg;
+
+	pm_runtime_get_sync(qep->dev);
+	reg = intel_qep_readl(qep, INTEL_QEPMAX);
+	pm_runtime_put(qep->dev);
+
+	return sysfs_emit(buf, "%u\n", reg);
+}
+
+static ssize_t ceiling_write(struct counter_device *counter,
+			     struct counter_count *count,
+			     void *priv, const char *buf, size_t len)
+{
+	struct intel_qep *qep = counter->priv;
+	u32 max;
+	int ret;
+
+	ret = kstrtou32(buf, 0, &max);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&qep->lock);
+	if (qep->enabled) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	pm_runtime_get_sync(qep->dev);
+	intel_qep_writel(qep, INTEL_QEPMAX, max);
+	pm_runtime_put(qep->dev);
+	ret = len;
+
+out:
+	mutex_unlock(&qep->lock);
+	return ret;
+}
+
+static ssize_t enable_read(struct counter_device *counter,
+			   struct counter_count *count,
+			   void *priv, char *buf)
+{
+	struct intel_qep *qep = counter->priv;
+
+	return sysfs_emit(buf, "%u\n", qep->enabled);
+}
+
+static ssize_t enable_write(struct counter_device *counter,
+			    struct counter_count *count,
+			    void *priv, const char *buf, size_t len)
+{
+	struct intel_qep *qep = counter->priv;
+	u32 reg;
+	bool val, changed;
+	int ret;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	mutex_lock(&qep->lock);
+	changed = val ^ qep->enabled;
+	if (!changed)
+		goto out;
+
+	pm_runtime_get_sync(qep->dev);
+	reg = intel_qep_readl(qep, INTEL_QEPCON);
+	if (val) {
+		/* Enable peripheral and keep runtime PM always on */
+		reg |= INTEL_QEPCON_EN;
+		pm_runtime_get_noresume(qep->dev);
+	} else {
+		/* Let runtime PM be idle and disable peripheral */
+		pm_runtime_put_noidle(qep->dev);
+		reg &= ~INTEL_QEPCON_EN;
+	}
+	intel_qep_writel(qep, INTEL_QEPCON, reg);
+	pm_runtime_put(qep->dev);
+	qep->enabled = val;
+
+out:
+	mutex_unlock(&qep->lock);
+	return len;
+}
+
+static ssize_t spike_filter_ns_read(struct counter_device *counter,
+				    struct counter_count *count,
+				    void *priv, char *buf)
+{
+	struct intel_qep *qep = counter->priv;
+	u32 reg;
+
+	pm_runtime_get_sync(qep->dev);
+	reg = intel_qep_readl(qep, INTEL_QEPCON);
+	if (!(reg & INTEL_QEPCON_FLT_EN)) {
+		pm_runtime_put(qep->dev);
+		return sysfs_emit(buf, "0\n");
+	}
+	reg = INTEL_QEPFLT_MAX_COUNT(intel_qep_readl(qep, INTEL_QEPFLT));
+	pm_runtime_put(qep->dev);
+
+	return sysfs_emit(buf, "%u\n", (reg + 2) * INTEL_QEP_CLK_PERIOD_NS);
+}
+
+static ssize_t spike_filter_ns_write(struct counter_device *counter,
+				     struct counter_count *count,
+				     void *priv, const char *buf, size_t len)
+{
+	struct intel_qep *qep = counter->priv;
+	u32 reg, length;
+	bool enable;
+	int ret;
+
+	ret = kstrtou32(buf, 0, &length);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Spike filter length is (MAX_COUNT + 2) clock periods. Disable
+	 * filter when user space supplies shorter than 2 clock periods and
+	 * otherwise enable and set MAX_COUNT = clock periods - 2.
+	 */
+	length /= INTEL_QEP_CLK_PERIOD_NS;
+	if (length < 2) {
+		enable = false;
+		length = 0;
+	} else {
+		enable = true;
+		length -= 2;
+	}
+
+	if (length > INTEL_QEPFLT_MAX_COUNT(length))
+		return -EINVAL;
+
+	mutex_lock(&qep->lock);
+	if (qep->enabled) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	pm_runtime_get_sync(qep->dev);
+	reg = intel_qep_readl(qep, INTEL_QEPCON);
+	if (enable)
+		reg |= INTEL_QEPCON_FLT_EN;
+	else
+		reg &= ~INTEL_QEPCON_FLT_EN;
+	intel_qep_writel(qep, INTEL_QEPFLT, length);
+	intel_qep_writel(qep, INTEL_QEPCON, reg);
+	pm_runtime_put(qep->dev);
+	ret = len;
+
+out:
+	mutex_unlock(&qep->lock);
+	return ret;
+}
+
+static ssize_t preset_enable_read(struct counter_device *counter,
+				  struct counter_count *count,
+				  void *priv, char *buf)
+{
+	struct intel_qep *qep = counter->priv;
+	u32 reg;
+
+	pm_runtime_get_sync(qep->dev);
+	reg = intel_qep_readl(qep, INTEL_QEPCON);
+	pm_runtime_put(qep->dev);
+	return sysfs_emit(buf, "%u\n", !(reg & INTEL_QEPCON_COUNT_RST_MODE));
+}
+
+static ssize_t preset_enable_write(struct counter_device *counter,
+				   struct counter_count *count,
+				   void *priv, const char *buf, size_t len)
+{
+	struct intel_qep *qep = counter->priv;
+	u32 reg;
+	bool val;
+	int ret;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	mutex_lock(&qep->lock);
+	if (qep->enabled) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	pm_runtime_get_sync(qep->dev);
+	reg = intel_qep_readl(qep, INTEL_QEPCON);
+	if (val)
+		reg &= ~INTEL_QEPCON_COUNT_RST_MODE;
+	else
+		reg |= INTEL_QEPCON_COUNT_RST_MODE;
+
+	intel_qep_writel(qep, INTEL_QEPCON, reg);
+	pm_runtime_put(qep->dev);
+	ret = len;
+
+out:
+	mutex_unlock(&qep->lock);
+
+	return ret;
+}
+
+static const struct counter_count_ext intel_qep_count_ext[] = {
+	INTEL_QEP_COUNTER_EXT_RW(ceiling),
+	INTEL_QEP_COUNTER_EXT_RW(enable),
+	INTEL_QEP_COUNTER_EXT_RW(spike_filter_ns),
+	INTEL_QEP_COUNTER_EXT_RW(preset_enable)
+};
+
+static struct counter_count intel_qep_counter_count[] = {
+	{
+		.id = 0,
+		.name = "Channel 1 Count",
+		.functions_list = intel_qep_count_functions,
+		.num_functions = ARRAY_SIZE(intel_qep_count_functions),
+		.synapses = intel_qep_count_synapses,
+		.num_synapses = ARRAY_SIZE(intel_qep_count_synapses),
+		.ext = intel_qep_count_ext,
+		.num_ext = ARRAY_SIZE(intel_qep_count_ext),
+	},
+};
+
+static int intel_qep_probe(struct pci_dev *pci, const struct pci_device_id *id)
+{
+	struct intel_qep *qep;
+	struct device *dev = &pci->dev;
+	void __iomem *regs;
+	int ret;
+
+	qep = devm_kzalloc(dev, sizeof(*qep), GFP_KERNEL);
+	if (!qep)
+		return -ENOMEM;
+
+	ret = pcim_enable_device(pci);
+	if (ret)
+		return ret;
+
+	pci_set_master(pci);
+
+	ret = pcim_iomap_regions(pci, BIT(0), pci_name(pci));
+	if (ret)
+		return ret;
+
+	regs = pcim_iomap_table(pci)[0];
+	if (!regs)
+		return -ENOMEM;
+
+	qep->dev = dev;
+	qep->regs = regs;
+	mutex_init(&qep->lock);
+
+	intel_qep_init(qep);
+	pci_set_drvdata(pci, qep);
+
+	qep->counter.name = pci_name(pci);
+	qep->counter.parent = dev;
+	qep->counter.ops = &intel_qep_counter_ops;
+	qep->counter.counts = intel_qep_counter_count;
+	qep->counter.num_counts = ARRAY_SIZE(intel_qep_counter_count);
+	qep->counter.signals = intel_qep_signals;
+	qep->counter.num_signals = ARRAY_SIZE(intel_qep_signals);
+	qep->counter.priv = qep;
+	qep->enabled = false;
+
+	pm_runtime_put(dev);
+	pm_runtime_allow(dev);
+
+	return devm_counter_register(&pci->dev, &qep->counter);
+}
+
+static void intel_qep_remove(struct pci_dev *pci)
+{
+	struct intel_qep *qep = pci_get_drvdata(pci);
+	struct device *dev = &pci->dev;
+
+	pm_runtime_forbid(dev);
+	if (!qep->enabled)
+		pm_runtime_get(dev);
+
+	intel_qep_writel(qep, INTEL_QEPCON, 0);
+}
+
+#ifdef CONFIG_PM
+static int intel_qep_suspend(struct device *dev)
+{
+	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
+	struct intel_qep *qep = pci_get_drvdata(pdev);
+
+	qep->qepcon = intel_qep_readl(qep, INTEL_QEPCON);
+	qep->qepflt = intel_qep_readl(qep, INTEL_QEPFLT);
+	qep->qepmax = intel_qep_readl(qep, INTEL_QEPMAX);
+
+	return 0;
+}
+
+static int intel_qep_resume(struct device *dev)
+{
+	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
+	struct intel_qep *qep = pci_get_drvdata(pdev);
+
+	/*
+	 * Make sure peripheral is disabled when restoring registers and
+	 * control register bits that are writable only when the peripheral
+	 * is disabled
+	 */
+	intel_qep_writel(qep, INTEL_QEPCON, 0);
+	intel_qep_readl(qep, INTEL_QEPCON);
+
+	intel_qep_writel(qep, INTEL_QEPFLT, qep->qepflt);
+	intel_qep_writel(qep, INTEL_QEPMAX, qep->qepmax);
+	intel_qep_writel(qep, INTEL_QEPINT_MASK, INTEL_QEPINT_MASK_ALL);
+
+	/* Restore all other control register bits except enable status */
+	intel_qep_writel(qep, INTEL_QEPCON, qep->qepcon & ~INTEL_QEPCON_EN);
+	intel_qep_readl(qep, INTEL_QEPCON);
+
+	/* Restore enable status */
+	intel_qep_writel(qep, INTEL_QEPCON, qep->qepcon);
+
+	return 0;
+}
+#endif
+
+static UNIVERSAL_DEV_PM_OPS(intel_qep_pm_ops,
+			    intel_qep_suspend, intel_qep_resume, NULL);
+
+static const struct pci_device_id intel_qep_id_table[] = {
+	/* EHL */
+	{ PCI_VDEVICE(INTEL, 0x4bc3), },
+	{ PCI_VDEVICE(INTEL, 0x4b81), },
+	{ PCI_VDEVICE(INTEL, 0x4b82), },
+	{ PCI_VDEVICE(INTEL, 0x4b83), },
+	{  } /* Terminating Entry */
+};
+MODULE_DEVICE_TABLE(pci, intel_qep_id_table);
+
+static struct pci_driver intel_qep_driver = {
+	.name = "intel-qep",
+	.id_table = intel_qep_id_table,
+	.probe = intel_qep_probe,
+	.remove = intel_qep_remove,
+	.driver = {
+		.pm = &intel_qep_pm_ops,
+	}
+};
+
+module_pci_driver(intel_qep_driver);
+
+MODULE_AUTHOR("Felipe Balbi (Intel)");
+MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@linux.intel.com>");
+MODULE_AUTHOR("Raymond Tan <raymond.tan@intel.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Intel Quadrature Encoder Peripheral driver");
-- 
2.30.2

