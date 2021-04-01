Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514A4351A27
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 20:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbhDAR62 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 13:58:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:52080 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234334AbhDARzr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 1 Apr 2021 13:55:47 -0400
IronPort-SDR: 5G9HoziyHQQIG8EZmaljNs/YWUGvc7bvYidZbzDX1Cc1limGDoOiwmEgM6If5ddGz2HqQxXfJa
 1nWD3MgGv/1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="190035783"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="190035783"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 08:32:39 -0700
IronPort-SDR: sj5zDdxTk1YOfQS2obTXlbInhWdbddo7U60UZMMJlftwFlDiNIwvQtc2VIldQ16rD8tSDa+nAX
 0TJaxLkmPGWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="607640516"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.184])
  by fmsmga006.fm.intel.com with ESMTP; 01 Apr 2021 08:32:37 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-iio@vger.kernel.org
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>
Subject: [PATCH 2/2] counter: Add support for Intel Quadrature Encoder Peripheral
Date:   Thu,  1 Apr 2021 18:32:28 +0300
Message-Id: <20210401153228.2773560-2-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210401153228.2773560-1-jarkko.nikula@linux.intel.com>
References: <20210401153228.2773560-1-jarkko.nikula@linux.intel.com>
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
 drivers/counter/Kconfig     |  10 +
 drivers/counter/Makefile    |   1 +
 drivers/counter/intel-qep.c | 636 ++++++++++++++++++++++++++++++++++++
 3 files changed, 647 insertions(+)
 create mode 100644 drivers/counter/intel-qep.c

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
index 000000000000..6a05b97e2163
--- /dev/null
+++ b/drivers/counter/intel-qep.c
@@ -0,0 +1,636 @@
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
+#define counter_to_qep(c)	(container_of((c), struct intel_qep, counter))
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
+enum intel_qep_synapse_action {
+	INTEL_QEP_SYNAPSE_ACTION_RISING_EDGE,
+	INTEL_QEP_SYNAPSE_ACTION_FALLING_EDGE,
+};
+
+static enum counter_synapse_action intel_qep_synapse_actions[] = {
+	[INTEL_QEP_SYNAPSE_ACTION_RISING_EDGE] =
+	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
+
+	[INTEL_QEP_SYNAPSE_ACTION_FALLING_EDGE] =
+	COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
+};
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
+static int intel_qep_count_read(struct counter_device *counter,
+				struct counter_count *count,
+				unsigned long *val)
+{
+	struct intel_qep *const qep = counter->priv;
+	unsigned long cntval;
+
+	pm_runtime_get_sync(qep->dev);
+	cntval = intel_qep_readl(qep, INTEL_QEPCOUNT);
+	*val = cntval;
+	pm_runtime_put(qep->dev);
+
+	return 0;
+}
+
+static int intel_qep_function_get(struct counter_device *counter,
+				  struct counter_count *count,
+				  size_t *function)
+{
+	struct intel_qep *qep = counter_to_qep(counter);
+	u32 reg;
+
+	pm_runtime_get_sync(qep->dev);
+	reg = intel_qep_readl(qep, INTEL_QEPCON);
+	if (reg & INTEL_QEPCON_SWPAB)
+		*function = INTEL_QEP_ENCODER_MODE_SWAPPED;
+	else
+		*function = INTEL_QEP_ENCODER_MODE_NORMAL;
+	pm_runtime_put(qep->dev);
+
+	return 0;
+}
+
+static int intel_qep_function_set(struct counter_device *counter,
+				  struct counter_count *count,
+				  size_t function)
+{
+	struct intel_qep *qep = counter_to_qep(counter);
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
+static int intel_qep_action_get(struct counter_device *counter,
+				struct counter_count *count,
+				struct counter_synapse *synapse,
+				size_t *action)
+{
+	struct intel_qep *qep = counter_to_qep(counter);
+	u32 reg;
+
+	pm_runtime_get_sync(qep->dev);
+	reg = intel_qep_readl(qep, INTEL_QEPCON);
+	pm_runtime_put(qep->dev);
+
+	*action = (reg & synapse->signal->id) ?
+		INTEL_QEP_SYNAPSE_ACTION_RISING_EDGE :
+		INTEL_QEP_SYNAPSE_ACTION_FALLING_EDGE;
+
+	return 0;
+}
+
+static int intel_qep_action_set(struct counter_device *counter,
+				struct counter_count *count,
+				struct counter_synapse *synapse,
+				size_t action)
+{
+	struct intel_qep *qep = counter_to_qep(counter);
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
+	if (action == INTEL_QEP_SYNAPSE_ACTION_RISING_EDGE)
+		reg |= synapse->signal->id;
+	else
+		reg &= ~synapse->signal->id;
+	intel_qep_writel(qep, INTEL_QEPCON, reg);
+	pm_runtime_put(qep->dev);
+
+out:
+	mutex_unlock(&qep->lock);
+	return ret;
+}
+
+static const struct counter_ops intel_qep_counter_ops = {
+	.count_read = intel_qep_count_read,
+
+	.function_get = intel_qep_function_get,
+	.function_set = intel_qep_function_set,
+
+	.action_get = intel_qep_action_get,
+	.action_set = intel_qep_action_set,
+};
+
+static struct counter_signal intel_qep_signals[] = {
+	{
+		.id = INTEL_QEPCON_EDGE_A,
+		.name = "Phase A",
+	},
+	{
+		.id = INTEL_QEPCON_EDGE_B,
+		.name = "Phase B",
+	},
+	{
+		.id = INTEL_QEPCON_EDGE_INDX,
+		.name = "Index",
+	},
+};
+
+static struct counter_synapse intel_qep_count_synapses[] = {
+	{
+		.actions_list = intel_qep_synapse_actions,
+		.num_actions = ARRAY_SIZE(intel_qep_synapse_actions),
+		.signal = &intel_qep_signals[0],
+	},
+	{
+		.actions_list = intel_qep_synapse_actions,
+		.num_actions = ARRAY_SIZE(intel_qep_synapse_actions),
+		.signal = &intel_qep_signals[1],
+	},
+	{
+		.actions_list = intel_qep_synapse_actions,
+		.num_actions = ARRAY_SIZE(intel_qep_synapse_actions),
+		.signal = &intel_qep_signals[2],
+	},
+};
+
+static ssize_t ceiling_read(struct counter_device *counter,
+			    struct counter_count *count,
+			    void *priv, char *buf)
+{
+	struct intel_qep *qep = counter_to_qep(counter);
+	u32 reg;
+
+	pm_runtime_get_sync(qep->dev);
+	reg = intel_qep_readl(qep, INTEL_QEPMAX);
+	pm_runtime_put(qep->dev);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", reg);
+}
+
+static ssize_t ceiling_write(struct counter_device *counter,
+			     struct counter_count *count,
+			     void *priv, const char *buf, size_t len)
+{
+	struct intel_qep *qep = counter_to_qep(counter);
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
+	struct intel_qep *qep = counter_to_qep(counter);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", qep->enabled);
+}
+
+static ssize_t enable_write(struct counter_device *counter,
+			    struct counter_count *count,
+			    void *priv, const char *buf, size_t len)
+{
+	struct intel_qep *qep = counter_to_qep(counter);
+	u32 reg;
+	u32 val;
+	int ret;
+
+	ret = kstrtou32(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&qep->lock);
+	if (val && !qep->enabled) {
+		pm_runtime_get_sync(qep->dev);
+		reg = intel_qep_readl(qep, INTEL_QEPCON);
+		reg |= INTEL_QEPCON_EN;
+		intel_qep_writel(qep, INTEL_QEPCON, reg);
+		qep->enabled = true;
+	} else if (!val && qep->enabled) {
+		reg = intel_qep_readl(qep, INTEL_QEPCON);
+		reg &= ~INTEL_QEPCON_EN;
+		intel_qep_writel(qep, INTEL_QEPCON, reg);
+		qep->enabled = false;
+		pm_runtime_put(qep->dev);
+	}
+	mutex_unlock(&qep->lock);
+
+	return len;
+}
+
+static const struct counter_count_ext intel_qep_count_ext[] = {
+	INTEL_QEP_COUNTER_EXT_RW(ceiling),
+	INTEL_QEP_COUNTER_EXT_RW(enable),
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
+static ssize_t noise_read(struct counter_device *counter,
+			  void *priv, char *buf)
+{
+	struct intel_qep *qep = counter_to_qep(counter);
+	u32 reg;
+
+	pm_runtime_get_sync(qep->dev);
+	reg = intel_qep_readl(qep, INTEL_QEPCON);
+	if (!(reg & INTEL_QEPCON_FLT_EN)) {
+		pm_runtime_put(qep->dev);
+		return snprintf(buf, PAGE_SIZE, "0\n");
+	}
+	reg = intel_qep_readl(qep, INTEL_QEPFLT);
+	pm_runtime_put(qep->dev);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", INTEL_QEPFLT_MAX_COUNT(reg));
+}
+
+static ssize_t noise_write(struct counter_device *counter,
+			   void *priv, const char *buf, size_t len)
+{
+	struct intel_qep *qep = counter_to_qep(counter);
+	u32 reg;
+	u32 max;
+	int ret;
+
+	ret = kstrtou32(buf, 0, &max);
+	if (ret < 0)
+		return ret;
+	if (max > INTEL_QEPFLT_MAX_COUNT(max))
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
+	if (max == 0) {
+		reg &= ~INTEL_QEPCON_FLT_EN;
+	} else {
+		reg |= INTEL_QEPCON_FLT_EN;
+		intel_qep_writel(qep, INTEL_QEPFLT, max);
+	}
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
+				  void *priv, char *buf)
+{
+	struct intel_qep *qep = counter_to_qep(counter);
+	u32 reg;
+
+	pm_runtime_get_sync(qep->dev);
+	reg = intel_qep_readl(qep, INTEL_QEPCON);
+	pm_runtime_put(qep->dev);
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+			!(reg & INTEL_QEPCON_COUNT_RST_MODE));
+}
+
+static ssize_t preset_enable_write(struct counter_device *counter,
+				   void *priv, const char *buf, size_t len)
+{
+	struct intel_qep *qep = counter_to_qep(counter);
+	u32 reg;
+	u32 val;
+	int ret;
+
+	ret = kstrtou32(buf, 0, &val);
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
+static const struct counter_device_ext intel_qep_ext[] = {
+	INTEL_QEP_COUNTER_EXT_RW(noise),
+	INTEL_QEP_COUNTER_EXT_RW(preset_enable)
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
+	qep->counter.ext = intel_qep_ext;
+	qep->counter.num_ext = ARRAY_SIZE(intel_qep_ext);
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

