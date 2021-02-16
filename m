Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC85031C735
	for <lists+linux-iio@lfdr.de>; Tue, 16 Feb 2021 09:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhBPIQ1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Feb 2021 03:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhBPIQR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Feb 2021 03:16:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DA4C061793
        for <linux-iio@vger.kernel.org>; Tue, 16 Feb 2021 00:14:25 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lBvUw-0000SL-MI; Tue, 16 Feb 2021 09:14:18 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lBvUv-0000xN-Gi; Tue, 16 Feb 2021 09:14:17 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v6 2/2] counter: add IRQ or GPIO based event counter
Date:   Tue, 16 Feb 2021 09:13:56 +0100
Message-Id: <20210216081356.3577-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210216081356.3577-1-o.rempel@pengutronix.de>
References: <20210216081356.3577-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add simple IRQ or GPIO base event counter. This device is used to measure
rotation speed of some agricultural devices, so no high frequency on the
counter pin is expected.

The maximal measurement frequency depends on the CPU and system load. On
the idle iMX6S I was able to measure up to 20kHz without count drops.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 MAINTAINERS                     |   7 +
 drivers/counter/Kconfig         |  10 ++
 drivers/counter/Makefile        |   1 +
 drivers/counter/interrupt-cnt.c | 249 ++++++++++++++++++++++++++++++++
 4 files changed, 267 insertions(+)
 create mode 100644 drivers/counter/interrupt-cnt.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 00836f6452f0..9cf87af41d7d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9246,6 +9246,13 @@ F:	include/dt-bindings/interconnect/
 F:	include/linux/interconnect-provider.h
 F:	include/linux/interconnect.h
 
+INTERRUPT COUNTER DRIVER
+M:	Oleksij Rempel <o.rempel@pengutronix.de>
+R:	Pengutronix Kernel Team <kernel@pengutronix.de>
+L:	linux-iio@vger.kernel.org
+F:	Documentation/devicetree/bindings/counter/interrupt-counter.yaml
+F:	drivers/counter/interrupt-cnt.c
+
 INVENSENSE ICM-426xx IMU DRIVER
 M:	Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
 L:	linux-iio@vger.kernel.org
diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index 2de53ab0dd25..dcad13229134 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -29,6 +29,16 @@ config 104_QUAD_8
 	  The base port addresses for the devices may be configured via the base
 	  array module parameter.
 
+config INTERRUPT_CNT
+	tristate "Interrupt counter driver"
+	depends on GPIOLIB
+	help
+	  Select this option to enable interrupt counter driver. Any interrupt
+	  source can be used by this driver as the event source.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called interrupt-cnt.
+
 config STM32_TIMER_CNT
 	tristate "STM32 Timer encoder counter driver"
 	depends on MFD_STM32_TIMERS || COMPILE_TEST
diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
index 0a393f71e481..cb646ed2f039 100644
--- a/drivers/counter/Makefile
+++ b/drivers/counter/Makefile
@@ -6,6 +6,7 @@
 obj-$(CONFIG_COUNTER) += counter.o
 
 obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
+obj-$(CONFIG_INTERRUPT_CNT)		+= interrupt-cnt.o
 obj-$(CONFIG_STM32_TIMER_CNT)	+= stm32-timer-cnt.o
 obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
 obj-$(CONFIG_TI_EQEP)		+= ti-eqep.o
diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
new file mode 100644
index 000000000000..16669924cdfa
--- /dev/null
+++ b/drivers/counter/interrupt-cnt.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
+ */
+
+#include <linux/counter.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#define INTERRUPT_CNT_NAME "interrupt-cnt"
+
+struct interrupt_cnt_priv {
+	atomic_t count;
+	struct counter_device counter;
+	struct gpio_desc *gpio;
+	int irq;
+	bool enabled;
+};
+
+static irqreturn_t interrupt_cnt_isr(int irq, void *dev_id)
+{
+	struct interrupt_cnt_priv *priv = dev_id;
+
+	atomic_inc(&priv->count);
+
+	return IRQ_HANDLED;
+}
+
+static ssize_t interrupt_cnt_enable_read(struct counter_device *counter,
+					 struct counter_count *count,
+					 void *private, char *buf)
+{
+	struct interrupt_cnt_priv *priv = counter->priv;
+
+	return sysfs_emit(buf, "%d\n", priv->enabled);
+}
+
+static ssize_t interrupt_cnt_enable_write(struct counter_device *counter,
+					  struct counter_count *count,
+					  void *private, const char *buf,
+					  size_t len)
+{
+	struct interrupt_cnt_priv *priv = counter->priv;
+	bool enable;
+	ssize_t ret;
+
+	ret = kstrtobool(buf, &enable);
+	if (ret)
+		return ret;
+
+	if (priv->enabled == enable)
+		return len;
+
+	if (enable) {
+		priv->enabled = true;
+		enable_irq(priv->irq);
+	} else {
+		disable_irq(priv->irq);
+		priv->enabled = false;
+	}
+
+	return len;
+}
+
+static const struct counter_count_ext interrupt_cnt_ext[] = {
+	{
+		.name = "enable",
+		.read = interrupt_cnt_enable_read,
+		.write = interrupt_cnt_enable_write,
+	},
+};
+
+static enum counter_synapse_action interrupt_cnt_synapse_actionss[] = {
+	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
+};
+
+static int interrupt_cnt_action_get(struct counter_device *counter,
+				    struct counter_count *count,
+				    struct counter_synapse *synapse,
+				    size_t *action)
+{
+	*action = interrupt_cnt_synapse_actionss[0];
+
+	return 0;
+}
+
+static int interrupt_cnt_read(struct counter_device *counter,
+			      struct counter_count *count, unsigned long *val)
+{
+	struct interrupt_cnt_priv *priv = counter->priv;
+
+	*val = atomic_read(&priv->count);
+
+	return 0;
+}
+
+static int interrupt_cnt_write(struct counter_device *counter,
+			       struct counter_count *count,
+			       const unsigned long val)
+{
+	struct interrupt_cnt_priv *priv = counter->priv;
+
+	atomic_set(&priv->count, val);
+
+	return 0;
+}
+
+static enum counter_count_function interrupt_cnt_functions[] = {
+	COUNTER_COUNT_FUNCTION_INCREASE,
+};
+
+static int interrupt_cnt_function_get(struct counter_device *counter,
+				      struct counter_count *count,
+				      size_t *function)
+{
+	*function = interrupt_cnt_functions[0];
+
+	return 0;
+}
+
+static int interrupt_cnt_signal_read(struct counter_device *counter,
+				     struct counter_signal *signal,
+				     enum counter_signal_value *val)
+{
+	struct interrupt_cnt_priv *priv = counter->priv;
+	int ret;
+
+	ret = gpiod_get_value(priv->gpio);
+	if (ret < 0)
+		return ret;
+
+	*val = ret ? COUNTER_SIGNAL_HIGH : COUNTER_SIGNAL_LOW;
+
+	return 0;
+}
+
+static struct counter_signal interrupt_cnt_signals[] = {
+	{
+		.id = 0,
+		.name = "Channel 0, GPIO line state",
+	},
+};
+
+static struct counter_synapse interrupt_cnt_synapses[] = {
+	{
+		.actions_list = interrupt_cnt_synapse_actionss,
+		.num_actions = ARRAY_SIZE(interrupt_cnt_synapse_actionss),
+		.signal = &interrupt_cnt_signals[0]
+	},
+};
+
+static struct counter_count interrupt_cnts[] = {
+	{
+		.id = 0,
+		.name = "Channel 0 Count",
+		.functions_list = interrupt_cnt_functions,
+		.num_functions = ARRAY_SIZE(interrupt_cnt_functions),
+		.synapses = interrupt_cnt_synapses,
+		.num_synapses = ARRAY_SIZE(interrupt_cnt_synapses),
+		.ext = interrupt_cnt_ext,
+		.num_ext = ARRAY_SIZE(interrupt_cnt_ext),
+	},
+};
+
+static const struct counter_ops interrupt_cnt_ops = {
+	.action_get = interrupt_cnt_action_get,
+	.count_read = interrupt_cnt_read,
+	.count_write = interrupt_cnt_write,
+	.function_get = interrupt_cnt_function_get,
+	.signal_read  = interrupt_cnt_signal_read,
+};
+
+static int interrupt_cnt_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct interrupt_cnt_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->irq = platform_get_irq_optional(pdev,  0);
+	if (priv->irq == -ENXIO)
+		priv->irq = 0;
+	else if (priv->irq < 0)
+		return dev_err_probe(dev, priv->irq, "failed to get IRQ\n");
+
+	priv->gpio = devm_gpiod_get_optional(dev, NULL, GPIOD_IN);
+	if (IS_ERR(priv->gpio))
+		return dev_err_probe(dev, PTR_ERR(priv->gpio), "failed to get GPIO\n");
+
+	if (!priv->irq && !priv->gpio) {
+		dev_err(dev, "IRQ and GPIO are not found. At least one source should be provided\n");
+		return -ENODEV;
+	}
+
+	if (!priv->irq) {
+		int irq = gpiod_to_irq(priv->gpio);
+
+		if (irq < 0)
+			return dev_err_probe(dev, irq, "failed to get IRQ from GPIO\n");
+
+		priv->irq = irq;
+	}
+
+	priv->counter.priv = priv;
+	priv->counter.name = dev_name(dev);
+	priv->counter.parent = dev;
+	priv->counter.ops = &interrupt_cnt_ops;
+	priv->counter.counts = interrupt_cnts;
+	priv->counter.num_counts = ARRAY_SIZE(interrupt_cnts);
+	priv->counter.signals = interrupt_cnt_signals;
+	priv->counter.num_signals = priv->gpio ?
+				    ARRAY_SIZE(interrupt_cnt_signals) : 0;
+
+	irq_set_status_flags(priv->irq, IRQ_NOAUTOEN);
+	ret = devm_request_irq(dev, priv->irq, interrupt_cnt_isr,
+			       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
+			       INTERRUPT_CNT_NAME, priv);
+	if (ret)
+		return ret;
+
+	return devm_counter_register(dev, &priv->counter);
+}
+
+static const struct of_device_id interrupt_cnt_of_match[] = {
+	{ .compatible = "interrupt-counter", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, interrupt_cnt_of_match);
+
+static struct platform_driver interrupt_cnt_driver = {
+	.probe = interrupt_cnt_probe,
+	.driver = {
+		.name = INTERRUPT_CNT_NAME,
+		.of_match_table = interrupt_cnt_of_match,
+	},
+};
+module_platform_driver(interrupt_cnt_driver);
+
+MODULE_ALIAS("platform:interrupt-counter");
+MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
+MODULE_DESCRIPTION("Interrupt counter driver");
+MODULE_LICENSE("GPL v2");
-- 
2.29.2

