Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77421B372D
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 11:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbfIPJeg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 05:34:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:7925 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbfIPJeg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Sep 2019 05:34:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 02:34:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,512,1559545200"; 
   d="scan'208";a="201565193"
Received: from pipin.fi.intel.com ([10.237.72.175])
  by fmsmga001.fm.intel.com with ESMTP; 16 Sep 2019 02:34:33 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [RFC/PATCH] counter: introduce support for Intel QEP Encoder
Date:   Mon, 16 Sep 2019 12:34:31 +0300
Message-Id: <20190916093431.264504-1-felipe.balbi@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for Intel PSE Quadrature Encoder

Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
---

Hi William,

Here's a first cut of the ported driver. Note that this is really an RFC as
there's still quite a bit I don't fully understand. I've left some of my old
sysfs files in there just to keep track of which features I'm still missing.

If understood this correctly, I should add noise filtering as a signal
extension, right? Same for Input Swap.

How should we handle the reset mode of the device? And mode of operation?

If you have any ideas, let me know.

cheers

 drivers/counter/Kconfig     |   6 +
 drivers/counter/Makefile    |   1 +
 drivers/counter/intel-qep.c | 874 ++++++++++++++++++++++++++++++++++++
 3 files changed, 881 insertions(+)
 create mode 100644 drivers/counter/intel-qep.c

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index 2967d0a9ff91..f280cd721350 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -59,4 +59,10 @@ config FTM_QUADDEC
 	  To compile this driver as a module, choose M here: the
 	  module will be called ftm-quaddec.
 
+config INTEL_QEP
+	tristate "Intel Quadrature Encoder"
+	depends on PCI
+	help
+	  Support for Intel Quadrature Encoder Devices
+
 endif # COUNTER
diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
index 40d35522937d..cf291cfd8cf0 100644
--- a/drivers/counter/Makefile
+++ b/drivers/counter/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
 obj-$(CONFIG_STM32_TIMER_CNT)	+= stm32-timer-cnt.o
 obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
 obj-$(CONFIG_FTM_QUADDEC)	+= ftm-quaddec.o
+obj-$(CONFIG_INTEL_QEP)		+= intel-qep.o
diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
new file mode 100644
index 000000000000..5b208362ab73
--- /dev/null
+++ b/drivers/counter/intel-qep.c
@@ -0,0 +1,874 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * intel-qep.c - Intel Quadrature Encoder Driver
+ *
+ * Copyright (C) 2019 Intel Corporation - https://www.intel.com
+ *
+ * Author: Felipe Balbi <felipe.balbi@linux.intel.com>
+ */
+#include <linux/bitops.h>
+#include <linux/counter.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/pm_runtime.h>
+#include <linux/sysfs.h>
+
+#define INTEL_QEPCON		0x00
+#define INTEL_QEPFLT		0x04
+#define INTEL_QEPCOUNT		0x08
+#define INTEL_QEPMAX		0x0c
+#define INTEL_QEPWDT		0x10
+#define INTEL_QEPCAPDIV		0x14
+#define INTEL_QEPCNTR		0x18
+#define INTEL_QEPCAPBUF		0x1c
+#define INTEL_QEPINT_STAT	0x20
+#define INTEL_QEPINT_MASK	0x24
+
+/* QEPCON */
+#define INTEL_QEPCON_EN		BIT(0)
+#define INTEL_QEPCON_FLT_EN	BIT(1)
+#define INTEL_QEPCON_EDGE_A	BIT(2)
+#define INTEL_QEPCON_EDGE_B	BIT(3)
+#define INTEL_QEPCON_EDGE_INDX	BIT(4)
+#define INTEL_QEPCON_SWPAB	BIT(5)
+#define INTEL_QEPCON_OP_MODE	BIT(6)
+#define INTEL_QEPCON_PH_ERR	BIT(7)
+#define INTEL_QEPCON_COUNT_RST_MODE BIT(8)
+#define INTEL_QEPCON_INDX_GATING_MASK GENMASK(10, 9)
+#define INTEL_QEPCON_INDX_GATING(n) (((n) & 3) << 9)
+#define INTEL_QEPCON_INDX_PAL_PBL INTEL_QEPCON_INDX_GATING(0)
+#define INTEL_QEPCON_INDX_PAL_PBH INTEL_QEPCON_INDX_GATING(1)
+#define INTEL_QEPCON_INDX_PAH_PBL INTEL_QEPCON_INDX_GATING(2)
+#define INTEL_QEPCON_INDX_PAH_PBH INTEL_QEPCON_INDX_GATING(3)
+#define INTEL_QEPCON_CAP_MODE	BIT(11)
+#define INTEL_QEPCON_FIFO_THRE_MASK GENMASK(14, 12)
+#define INTEL_QEPCON_FIFO_THRE(n) ((((n) - 1) & 7) << 12)
+#define INTEL_QEPCON_FIFO_EMPTY	BIT(15)
+
+/* QEPFLT */
+#define INTEL_QEPFLT_MAX_COUNT(n) ((n) & 0x1fffff)
+
+/* QEPINT */
+#define INTEL_QEPINT_FIFOCRIT	BIT(5)
+#define INTEL_QEPINT_FIFOENTRY	BIT(4)
+#define INTEL_QEPINT_QEPDIR	BIT(3)
+#define INTEL_QEPINT_QEPRST_UP	BIT(2)
+#define INTEL_QEPINT_QEPRST_DOWN BIT(1)
+#define INTEL_QEPINT_WDT	BIT(0)
+
+#define INTEL_QEP_DIRECTION_UP 0
+#define INTEL_QEP_DIRECTION_DOWN 1
+
+struct intel_qep {
+	struct counter_device counter;
+	struct mutex lock;
+	struct pci_dev *pci;
+	struct device *dev;
+	void __iomem *regs;
+	u32 interrupt;
+	int direction;
+	bool enabled;
+};
+
+#define counter_to_qep(c)	(container_of((c), struct intel_qep, counter))
+
+static inline u32 intel_qep_readl(void __iomem *base, u32 offset)
+{
+	return readl(base + offset);
+}
+
+static inline void intel_qep_writel(void __iomem *base, u32 offset, u32 value)
+{
+	writel(value, base + offset);
+}
+
+static ssize_t reset_mode_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct intel_qep *qep = dev_get_drvdata(dev);
+	u32 reg;
+
+	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+			reg & INTEL_QEPCON_COUNT_RST_MODE ?
+			"maximum" : "index");
+}
+
+static ssize_t reset_mode_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct intel_qep *qep = dev_get_drvdata(dev);
+	u32 reg;
+
+	if (qep->enabled)
+		return -EINVAL;
+
+	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
+
+	if (sysfs_streq(buf, "maximum"))
+		reg |= INTEL_QEPCON_COUNT_RST_MODE;
+	else if (sysfs_streq(buf, "index"))
+		reg &= ~INTEL_QEPCON_COUNT_RST_MODE;
+
+	intel_qep_writel(qep->regs, INTEL_QEPCON, reg);
+
+	return count;
+}
+static DEVICE_ATTR_RW(reset_mode);
+
+static ssize_t state_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct intel_qep *qep = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+			qep->enabled ? "enabled" : "disabled");
+}
+
+static ssize_t state_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct intel_qep *qep = dev_get_drvdata(dev);
+	u32 reg;
+
+	pm_runtime_get_sync(dev);
+
+	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
+
+	if (sysfs_streq(buf, "enable")) {
+		reg |= INTEL_QEPCON_EN;
+		qep->enabled = true;
+
+	} else if (sysfs_streq(buf, "disable")) {
+		reg &= ~INTEL_QEPCON_EN;
+		qep->enabled = false;
+
+		pm_runtime_put(dev);
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+	}
+
+	intel_qep_writel(qep->regs, INTEL_QEPCON, reg);
+
+	return count;
+}
+static DEVICE_ATTR_RW(state);
+
+static ssize_t current_position_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct intel_qep *qep = dev_get_drvdata(dev);
+	u32 reg;
+
+	reg = intel_qep_readl(qep->regs, INTEL_QEPCOUNT);
+
+	return snprintf(buf, PAGE_SIZE, "%08x\n", reg);
+}
+static DEVICE_ATTR_RO(current_position);
+
+static ssize_t max_position_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct intel_qep *qep = dev_get_drvdata(dev);
+	u32 reg;
+
+	reg = intel_qep_readl(qep->regs, INTEL_QEPMAX);
+
+	return snprintf(buf, PAGE_SIZE, "%08x\n", reg);
+}
+
+static ssize_t max_position_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct intel_qep *qep = dev_get_drvdata(dev);
+	u32 max;
+	int ret;
+
+	if (qep->enabled)
+		return -EINVAL;
+
+	ret = kstrtou32(buf, 0, &max);
+	if (ret < 0)
+		return ret;
+
+	intel_qep_writel(qep->regs, INTEL_QEPMAX, max);
+
+	return count;
+}
+static DEVICE_ATTR_RW(max_position);
+
+static ssize_t filter_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct intel_qep *qep = dev_get_drvdata(dev);
+	u32 reg;
+
+	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+			reg & INTEL_QEPCON_FLT_EN ? "enabled" : "disabled");
+}
+
+static ssize_t filter_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct intel_qep *qep = dev_get_drvdata(dev);
+	u32 reg;
+
+	if (qep->enabled)
+		return -EINVAL;
+
+	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
+
+	if (sysfs_streq(buf, "enable"))
+		reg |= INTEL_QEPCON_FLT_EN;
+	else if (sysfs_streq(buf, "disable"))
+		reg &= ~INTEL_QEPCON_FLT_EN;
+
+	intel_qep_writel(qep->regs, INTEL_QEPCON, reg);
+
+	return count;
+}
+static DEVICE_ATTR_RW(filter);
+
+static ssize_t filter_count_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct intel_qep *qep = dev_get_drvdata(dev);
+	u32 reg;
+
+	reg = intel_qep_readl(qep->regs, INTEL_QEPFLT);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", INTEL_QEPFLT_MAX_COUNT(reg));
+}
+
+static ssize_t filter_count_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct intel_qep *qep = dev_get_drvdata(dev);
+	u32 max;
+	int ret;
+
+	if (qep->enabled)
+		return -EINVAL;
+
+	ret = kstrtou32(buf, 0, &max);
+	if (ret < 0)
+		return ret;
+
+	if (max > 0x1fffff)
+		max = 0x1ffff;
+
+	intel_qep_writel(qep->regs, INTEL_QEPFLT, max);
+
+	return count;
+}
+static DEVICE_ATTR_RW(filter_count);
+
+static ssize_t swap_inputs_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct intel_qep *qep = dev_get_drvdata(dev);
+	u32 reg;
+
+	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+			reg & INTEL_QEPCON_SWPAB ? "swapped" : "normal");
+}
+
+static ssize_t swap_inputs_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct intel_qep *qep = dev_get_drvdata(dev);
+	u32 reg;
+
+	if (qep->enabled)
+		return -EINVAL;
+
+	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
+
+	if (sysfs_streq(buf, "swap"))
+		reg |= INTEL_QEPCON_SWPAB;
+	else if (sysfs_streq(buf, "normal"))
+		reg &= ~INTEL_QEPCON_SWPAB;
+
+	intel_qep_writel(qep->regs, INTEL_QEPCON, reg);
+
+	return count;
+}
+static DEVICE_ATTR_RW(swap_inputs);
+
+static ssize_t phase_error_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct intel_qep *qep = dev_get_drvdata(dev);
+	u32 reg;
+
+	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+			reg & INTEL_QEPCON_PH_ERR ? "error" : "okay");
+}
+static DEVICE_ATTR_RO(phase_error);
+
+static ssize_t direction_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct intel_qep *qep = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", qep->direction ? "down" : "up");
+}
+static DEVICE_ATTR_RO(direction);
+
+static ssize_t fifo_empty_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct intel_qep *qep = dev_get_drvdata(dev);
+	u32 reg;
+
+	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+			reg & INTEL_QEPCON_FIFO_EMPTY ? "empty" : "not empty");
+}
+static DEVICE_ATTR_RO(fifo_empty);
+
+static ssize_t operating_mode_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct intel_qep *qep = dev_get_drvdata(dev);
+	u32 reg;
+
+	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+			reg & INTEL_QEPCON_OP_MODE ? "capture" : "quadrature");
+}
+
+static ssize_t operating_mode_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct intel_qep *qep = dev_get_drvdata(dev);
+	u32 reg;
+
+	if (qep->enabled)
+		return -EINVAL;
+
+	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
+
+	if (sysfs_streq(buf, "capture"))
+		reg |= INTEL_QEPCON_OP_MODE;
+	else if (sysfs_streq(buf, "quadrature"))
+		reg &= ~INTEL_QEPCON_OP_MODE;
+
+	intel_qep_writel(qep->regs, INTEL_QEPCON, reg);
+
+	return count;
+}
+static DEVICE_ATTR_RW(operating_mode);
+
+static ssize_t capture_mode_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct intel_qep *qep = dev_get_drvdata(dev);
+	u32 reg;
+
+	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+			reg & INTEL_QEPCON_CAP_MODE ? "both" : "single");
+}
+
+static ssize_t capture_mode_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct intel_qep *qep = dev_get_drvdata(dev);
+	u32 reg;
+
+	if (qep->enabled)
+		return -EINVAL;
+
+	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
+
+	if (sysfs_streq(buf, "both"))
+		reg |= INTEL_QEPCON_CAP_MODE;
+	else if (sysfs_streq(buf, "single"))
+		reg &= ~INTEL_QEPCON_CAP_MODE;
+
+	intel_qep_writel(qep->regs, INTEL_QEPCON, reg);
+
+	return count;
+}
+static DEVICE_ATTR_RW(capture_mode);
+
+static const struct attribute *intel_qep_attrs[] = {
+	&dev_attr_capture_mode.attr,
+	&dev_attr_current_position.attr,
+	&dev_attr_direction.attr,
+	&dev_attr_fifo_empty.attr,
+	&dev_attr_filter.attr,
+	&dev_attr_filter_count.attr,
+	&dev_attr_max_position.attr,
+	&dev_attr_operating_mode.attr,
+	&dev_attr_phase_error.attr,
+	&dev_attr_reset_mode.attr,
+	&dev_attr_state.attr,
+	&dev_attr_swap_inputs.attr,
+	NULL	/* Terminating Entry */
+};
+
+static ssize_t capture_data_read(struct file *filp, struct kobject *kobj,
+		struct bin_attribute *attr, char *buf,
+		loff_t offset, size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct intel_qep *qep = dev_get_drvdata(dev);
+	u32 reg;
+	int i;
+
+	mutex_lock(&qep->lock);
+	for (i = 0; i < count; i += 4) {
+		reg = intel_qep_readl(qep->regs, INTEL_QEPCAPBUF);
+
+		buf[i + 0] = reg & 0xff;
+		buf[i + 1] = (reg >> 8) & 0xff;
+		buf[i + 2] = (reg >> 16) & 0xff;
+		buf[i + 3] = (reg >> 24) & 0xff;
+	}
+	mutex_unlock(&qep->lock);
+
+	return count;
+}
+
+static BIN_ATTR_RO(capture_data, 4);
+
+static struct bin_attribute *intel_qep_bin_attrs[] = {
+	&bin_attr_capture_data,
+	NULL	/* Terminating Entry */
+};
+
+static const struct attribute_group intel_qep_device_attr_group = {
+	.name = "qep",
+	.attrs = (struct attribute **) intel_qep_attrs,
+	.bin_attrs = intel_qep_bin_attrs,
+};
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
+static void intel_qep_init(struct intel_qep *qep, bool reset)
+{
+	u32 reg;
+
+	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
+	reg &= ~INTEL_QEPCON_EN;
+	intel_qep_writel(qep->regs, INTEL_QEPCON, reg);
+
+	/* make sure periperal is disabled by reading one more time */
+	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
+
+	if (reset) {
+		reg &= ~(INTEL_QEPCON_OP_MODE | INTEL_QEPCON_FLT_EN);
+		reg |= INTEL_QEPCON_EDGE_A | INTEL_QEPCON_EDGE_B |
+			INTEL_QEPCON_EDGE_INDX | INTEL_QEPCON_COUNT_RST_MODE;
+	}
+
+	intel_qep_writel(qep->regs, INTEL_QEPCON, reg);
+
+	intel_qep_writel(qep->regs, INTEL_QEPWDT, 0x1000);
+	intel_qep_writel(qep->regs, INTEL_QEPINT_MASK, 0x0);
+
+	qep->direction = INTEL_QEP_DIRECTION_UP;
+}
+
+static irqreturn_t intel_qep_irq_thread(int irq, void *_qep)
+{
+	struct intel_qep	*qep = _qep;
+	u32			stat;
+
+	mutex_lock(&qep->lock);
+
+	stat = qep->interrupt;
+	if (stat & INTEL_QEPINT_FIFOCRIT)
+		sysfs_notify(&qep->dev->kobj, "qep", "capture_buffer");
+
+	if (stat & INTEL_QEPINT_FIFOENTRY)
+		sysfs_notify(&qep->dev->kobj, "qep", "capture_buffer");
+
+	if (stat & INTEL_QEPINT_QEPDIR) {
+		qep->direction = !(qep->direction);
+		sysfs_notify(&qep->dev->kobj, "qep", "direction");
+	}
+
+	if (stat & INTEL_QEPINT_QEPRST_UP) {
+		qep->direction = INTEL_QEP_DIRECTION_UP;
+		sysfs_notify(&qep->dev->kobj, "qep", "direction");
+	}
+
+	if (stat & INTEL_QEPINT_QEPRST_DOWN) {
+		qep->direction = INTEL_QEP_DIRECTION_DOWN;
+		sysfs_notify(&qep->dev->kobj, "qep", "direction");
+	}
+
+	if (stat & INTEL_QEPINT_WDT)
+		dev_dbg(qep->dev, "Watchdog\n");
+
+	intel_qep_writel(qep->regs, INTEL_QEPINT_MASK, 0x00);
+	mutex_unlock(&qep->lock);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t intel_qep_irq(int irq, void *_qep)
+{
+	struct intel_qep	*qep = _qep;
+	u32			stat;
+
+	stat = intel_qep_readl(qep->regs, INTEL_QEPINT_STAT);
+	if (stat) {
+		qep->interrupt = stat;
+		intel_qep_writel(qep->regs, INTEL_QEPINT_MASK, 0xffffffff);
+		intel_qep_writel(qep->regs, INTEL_QEPINT_STAT, stat);
+		return IRQ_WAKE_THREAD;
+	}
+
+	return IRQ_HANDLED;
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
+	INTEL_QEP_ENCODER_MODE_1,
+};
+
+static const enum counter_count_function intel_qep_count_functions[] = {
+	[INTEL_QEP_ENCODER_MODE_1] =
+	COUNTER_COUNT_FUNCTION_QUADRATURE_X4
+};
+
+static int intel_qep_count_read(struct counter_device *counter,
+		struct counter_count *count,
+		struct counter_count_read_value *val)
+{
+	struct intel_qep *const qep = counter->priv;
+	uint32_t cntval;
+
+	cntval = intel_qep_readl(qep, INTEL_QEPCOUNT);
+	counter_count_read_value_set(val, COUNTER_COUNT_POSITION, &cntval);
+
+	return 0;
+}
+
+static int intel_qep_count_write(struct counter_device *counter,
+		struct counter_count *count,
+		struct counter_count_write_value *val)
+{
+	struct intel_qep *const qep = counter->priv;
+	u32 cnt;
+	int err;
+
+	err = counter_count_write_value_get(&cnt, COUNTER_COUNT_POSITION, val);
+	if (err)
+		return err;
+
+	intel_qep_writel(qep->regs, INTEL_QEPMAX, cnt);
+
+	return 0;
+}
+
+static int intel_qep_function_get(struct counter_device *counter,
+		struct counter_count *count, size_t *function)
+{
+	*function = INTEL_QEP_ENCODER_MODE_1;
+
+	return 0;
+}
+
+static int intel_qep_action_get(struct counter_device *counter,
+		struct counter_count *count, struct counter_synapse *synapse,
+		size_t *action)
+{
+	struct intel_qep *qep = counter_to_qep(counter);
+	u32 reg;
+
+	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
+
+	*action = reg & synapse->signal->id ?
+		INTEL_QEP_SYNAPSE_ACTION_RISING_EDGE :
+		INTEL_QEP_SYNAPSE_ACTION_FALLING_EDGE;
+
+	return 0;
+}
+
+static int intel_qep_action_set(struct counter_device *counter,
+		struct counter_count *count,
+		struct counter_synapse *synapse, size_t action)
+{
+	struct intel_qep *qep = counter_to_qep(counter);
+	u32 reg;
+
+	reg = intel_qep_readl(qep->regs, INTEL_QEPCON);
+
+	if (action == INTEL_QEP_SYNAPSE_ACTION_RISING_EDGE)
+		reg |= synapse->signal->id;
+	else
+		reg &= ~synapse->signal->id;
+
+	intel_qep_writel(qep->regs, INTEL_QEPCON, reg);
+
+	return 0;
+}
+
+static const struct counter_ops intel_qep_counter_ops = {
+	.count_read = intel_qep_count_read,
+	.count_write = intel_qep_count_write,
+	.function_get = intel_qep_function_get,
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
+static const char * const intel_qep_clock_dividers[] = {
+	"1", "2", "4", "8", "16", "32", "64", "128"
+};
+
+static int intel_qep_clock_divider_get(struct counter_device *counter,
+		struct counter_count *count, size_t *mode)
+{
+	struct intel_qep *qep = counter_to_qep(counter);
+	
+	*mode = intel_qep_readl(qep->regs, INTEL_QEPCAPDIV);
+
+	return 0;
+}
+
+static int intel_qep_clock_divider_set(struct counter_device *counter,
+		struct counter_count *count, size_t mode)
+{
+	struct intel_qep *qep = counter_to_qep(counter);
+
+	intel_qep_writel(qep->regs, INTEL_QEPCAPDIV, ffs(mode) - 1);
+
+	return 0;
+}
+
+static struct counter_count_enum_ext intel_qep_clock_divider_enum = {
+	.items = intel_qep_clock_dividers,
+	.num_items = ARRAY_SIZE(intel_qep_clock_dividers),
+	.get = intel_qep_clock_divider_get,
+	.set = intel_qep_clock_divider_set,
+};
+
+static const struct counter_count_ext intel_qep_count_ext[] = {
+	COUNTER_COUNT_ENUM("clock_divider", &intel_qep_clock_divider_enum),
+	COUNTER_COUNT_ENUM_AVAILABLE("clock_divider",
+			&intel_qep_clock_divider_enum),
+};
+
+static struct counter_count intel_qep_counter_count = {
+	.id = 0,
+	.name = "Channel 1 Count",
+	.functions_list = intel_qep_count_functions,
+	.num_functions = ARRAY_SIZE(intel_qep_count_functions),
+	.synapses = intel_qep_count_synapses,
+	.num_synapses = ARRAY_SIZE(intel_qep_count_synapses),
+};
+
+static int intel_qep_probe(struct pci_dev *pci, const struct pci_device_id *id)
+{
+	struct intel_qep	*qep;
+	struct device		*dev = &pci->dev;
+	void __iomem		*regs;
+	int			ret;
+	int			irq;
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
+	qep->pci = pci;
+	qep->dev = dev;
+	qep->regs = regs;
+	mutex_init(&qep->lock);
+
+	intel_qep_init(qep, true);
+	pci_set_drvdata(pci, qep);
+
+	qep->counter.name = pci_name(pci);
+	qep->counter.parent = dev;
+	qep->counter.ops = &intel_qep_counter_ops;
+	qep->counter.counts = &intel_qep_counter_count;
+	qep->counter.num_counts = 1;
+	qep->counter.signals = intel_qep_signals;
+	qep->counter.num_signals = ARRAY_SIZE(intel_qep_signals);
+	qep->counter.priv = qep;
+
+	ret = counter_register(&qep->counter);
+	if (ret)
+		return ret;
+
+	ret = pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_ALL_TYPES);
+	if (ret < 0)
+		goto err_irq_vectors;
+
+	irq = pci_irq_vector(pci, 0);
+	ret = devm_request_threaded_irq(&pci->dev, irq, intel_qep_irq,
+			intel_qep_irq_thread, IRQF_SHARED | IRQF_TRIGGER_RISING,
+			"intel-qep", qep);
+	if (ret)
+		goto err_irq;
+
+	pm_runtime_set_autosuspend_delay(dev, 1000);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_put_noidle(dev);
+	pm_runtime_allow(dev);
+
+	return 0;
+
+err_irq:
+	pci_free_irq_vectors(pci);
+
+err_irq_vectors:
+	counter_unregister(&qep->counter);
+
+	return ret;
+}
+
+static void intel_qep_remove(struct pci_dev *pci)
+{
+	struct intel_qep	*qep = pci_get_drvdata(pci);
+	struct device		*dev = &pci->dev;
+
+	pm_runtime_forbid(dev);
+	pm_runtime_get_noresume(dev);
+
+	pci_free_irq_vectors(pci);
+	counter_unregister(&qep->counter);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int intel_qep_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int intel_qep_resume(struct device *dev)
+{
+	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
+	struct intel_qep *qep = pci_get_drvdata(pdev);
+
+	intel_qep_init(qep, false);
+
+	return 0;
+}
+
+static int intel_qep_runtime_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int intel_qep_runtime_resume(struct device *dev)
+{
+	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
+	struct intel_qep *qep = pci_get_drvdata(pdev);
+
+	intel_qep_init(qep, false);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops intel_qep_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(intel_qep_suspend,
+				intel_qep_resume)
+	SET_RUNTIME_PM_OPS(intel_qep_runtime_suspend, intel_qep_runtime_resume,
+				NULL)
+};
+
+static struct pci_driver intel_qep_driver = {
+	.name		= "intel-qep",
+	.id_table	= intel_qep_id_table,
+	.probe		= intel_qep_probe,
+	.remove		= intel_qep_remove,
+	.driver = {
+		.pm = &intel_qep_pm_ops,
+	}
+};
+
+module_pci_driver(intel_qep_driver);
+
+MODULE_AUTHOR("Felipe Balbi <felipe.balbi@linux.intel.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Intel Quadrature Encoder Driver");
-- 
2.23.0

