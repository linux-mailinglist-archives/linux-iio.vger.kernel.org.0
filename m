Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D52303EDC
	for <lists+linux-iio@lfdr.de>; Tue, 26 Jan 2021 14:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404424AbhAZNfx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Jan 2021 08:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404756AbhAZNf2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jan 2021 08:35:28 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CFDC061A31
        for <linux-iio@vger.kernel.org>; Tue, 26 Jan 2021 05:34:31 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1l4O9C-0001l3-9Y; Tue, 26 Jan 2021 14:12:42 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1l4O9A-0002CY-VU; Tue, 26 Jan 2021 14:12:40 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org
Subject: [PATCH v4 2/2] counter: add IRQ or GPIO based pulse counter
Date:   Tue, 26 Jan 2021 14:12:39 +0100
Message-Id: <20210126131239.8335-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126131239.8335-1-o.rempel@pengutronix.de>
References: <20210126131239.8335-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add simple IRQ or GPIO base pulse counter. This device is used to measure
rotation speed of some agricultural devices, so no high frequency on the
counter pin is expected.

The maximal measurement frequency depends on the CPU and system load. On
the idle iMX6S I was able to measure up to 20kHz without count drops.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 drivers/counter/Kconfig     |  10 ++
 drivers/counter/Makefile    |   1 +
 drivers/counter/pulse-cnt.c | 235 ++++++++++++++++++++++++++++++++++++
 3 files changed, 246 insertions(+)
 create mode 100644 drivers/counter/pulse-cnt.c

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index 2de53ab0dd25..73107a861648 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -29,6 +29,16 @@ config 104_QUAD_8
 	  The base port addresses for the devices may be configured via the base
 	  array module parameter.
 
+config PULSE_CNT
+	tristate "Pulse counter driver"
+	depends on GPIOLIB
+	help
+	  Select this option to enable pulse counter driver. Any interrupt source
+	  can be used by this driver as the pulse source.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called gpio-pulse-cnt.
+
 config STM32_TIMER_CNT
 	tristate "STM32 Timer encoder counter driver"
 	depends on MFD_STM32_TIMERS || COMPILE_TEST
diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
index 0a393f71e481..73999e39e984 100644
--- a/drivers/counter/Makefile
+++ b/drivers/counter/Makefile
@@ -6,6 +6,7 @@
 obj-$(CONFIG_COUNTER) += counter.o
 
 obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
+obj-$(CONFIG_PULSE_CNT)		+= pulse-cnt.o
 obj-$(CONFIG_STM32_TIMER_CNT)	+= stm32-timer-cnt.o
 obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
 obj-$(CONFIG_TI_EQEP)		+= ti-eqep.o
diff --git a/drivers/counter/pulse-cnt.c b/drivers/counter/pulse-cnt.c
new file mode 100644
index 000000000000..4128b4b3661e
--- /dev/null
+++ b/drivers/counter/pulse-cnt.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
+ */
+
+#include <linux/counter.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#define PULSE_CNT_NAME		"pulse-cnt"
+
+struct pulse_cnt_priv {
+	struct counter_device counter;
+	struct counter_ops ops;
+	struct gpio_desc *gpio;
+	int irq;
+	bool enabled;
+	atomic_t count;
+};
+
+static irqreturn_t pulse_cnt_isr(int irq, void *dev_id)
+{
+	struct pulse_cnt_priv *priv = dev_id;
+
+	atomic_inc(&priv->count);
+
+	return IRQ_HANDLED;
+}
+
+static ssize_t pulse_cnt_enable_read(struct counter_device *counter,
+				     struct counter_count *count, void *private,
+				     char *buf)
+{
+	struct pulse_cnt_priv *priv = counter->priv;
+
+	return sysfs_emit(buf, "%d\n", priv->enabled);
+}
+
+static ssize_t pulse_cnt_enable_write(struct counter_device *counter,
+				      struct counter_count *count,
+				      void *private, const char *buf,
+				      size_t len)
+{
+	struct pulse_cnt_priv *priv = counter->priv;
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
+		priv->enabled = enable;
+		enable_irq(priv->irq);
+	} else {
+		disable_irq(priv->irq);
+		priv->enabled = enable;
+	}
+
+	return len;
+}
+
+static const struct counter_count_ext pulse_cnt_ext[] = {
+	{
+		.name = "enable",
+		.read = pulse_cnt_enable_read,
+		.write = pulse_cnt_enable_write,
+	},
+};
+
+static enum counter_synapse_action pulse_cnt_synapse_actionss[] = {
+	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
+};
+
+static int pulse_cnt_action_get(struct counter_device *counter,
+			    struct counter_count *count,
+			    struct counter_synapse *synapse,
+			    size_t *action)
+{
+	*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
+
+	return 0;
+}
+
+static int pulse_cnt_read(struct counter_device *counter,
+				 struct counter_count *count,
+				 unsigned long *val)
+{
+	struct pulse_cnt_priv *priv = counter->priv;
+
+	*val = atomic_read(&priv->count);
+
+	return 0;
+}
+
+static int pulse_cnt_write(struct counter_device *counter,
+				  struct counter_count *count,
+				  const unsigned long val)
+{
+	struct pulse_cnt_priv *priv = counter->priv;
+
+	atomic_set(&priv->count, val);
+
+	return 0;
+}
+
+static int pulse_cnt_function_get(struct counter_device *counter,
+				  struct counter_count *count, size_t *function)
+{
+	*function = COUNTER_COUNT_FUNCTION_INCREASE;
+
+	return 0;
+}
+
+static int pulse_cnt_signal_read(struct counter_device *counter,
+				 struct counter_signal *signal,
+				 enum counter_signal_value *val)
+{
+	struct pulse_cnt_priv *priv = counter->priv;
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
+static struct counter_signal pulse_cnt_signals[] = {
+	{
+		.id = 0,
+		.name = "Channel 0 signal",
+	},
+};
+
+static struct counter_synapse pulse_cnt_synapses[] = {
+	{
+		.actions_list = pulse_cnt_synapse_actionss,
+		.num_actions = ARRAY_SIZE(pulse_cnt_synapse_actionss),
+		.signal = &pulse_cnt_signals[0]
+	},
+};
+
+static enum counter_count_function pulse_cnt_functions[] = {
+	COUNTER_COUNT_FUNCTION_INCREASE,
+};
+
+static struct counter_count pulse_cnts[] = {
+	{
+		.id = 0,
+		.name = "Channel 1 Count",
+		.functions_list = pulse_cnt_functions,
+		.num_functions = ARRAY_SIZE(pulse_cnt_functions),
+		.synapses = pulse_cnt_synapses,
+		.num_synapses = ARRAY_SIZE(pulse_cnt_synapses),
+		.ext = pulse_cnt_ext,
+		.num_ext = ARRAY_SIZE(pulse_cnt_ext),
+	},
+};
+
+static int pulse_cnt_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pulse_cnt_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->irq = platform_get_irq(pdev,  0);
+	if (priv->irq < 0) {
+		dev_err(dev, "failed to map GPIO to IRQ: %d\n", priv->irq);
+		return priv->irq;
+	}
+
+	priv->gpio = devm_gpiod_get_optional(dev, NULL, GPIOD_IN);
+	if (IS_ERR(priv->gpio))
+		return dev_err_probe(dev, PTR_ERR(priv->gpio), "failed to get gpio\n");
+
+	priv->ops.action_get = pulse_cnt_action_get;
+	priv->ops.count_read = pulse_cnt_read;
+	priv->ops.count_write = pulse_cnt_write;
+	priv->ops.function_get = pulse_cnt_function_get;
+	if (priv->gpio)
+		priv->ops.signal_read  = pulse_cnt_signal_read;
+
+	priv->counter.name = dev_name(dev);
+	priv->counter.parent = dev;
+	priv->counter.ops = &priv->ops;
+	priv->counter.counts = pulse_cnts;
+	priv->counter.num_counts = ARRAY_SIZE(pulse_cnts);
+	priv->counter.signals = pulse_cnt_signals;
+	priv->counter.num_signals = ARRAY_SIZE(pulse_cnt_signals);
+	priv->counter.priv = priv;
+
+	irq_set_status_flags(priv->irq, IRQ_NOAUTOEN);
+	ret = devm_request_irq(dev, priv->irq, pulse_cnt_isr,
+			       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
+			       PULSE_CNT_NAME, priv);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, priv);
+
+	return devm_counter_register(dev, &priv->counter);
+}
+
+static const struct of_device_id pulse_cnt_of_match[] = {
+	{ .compatible = "virtual,pulse-counter", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pulse_cnt_of_match);
+
+static struct platform_driver pulse_cnt_driver = {
+	.probe = pulse_cnt_probe,
+	.driver = {
+		.name = PULSE_CNT_NAME,
+		.of_match_table = pulse_cnt_of_match,
+	},
+};
+module_platform_driver(pulse_cnt_driver);
+
+MODULE_ALIAS("platform:pulse-counter");
+MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
+MODULE_DESCRIPTION("Pulse counter driver");
+MODULE_LICENSE("GPL v2");
-- 
2.30.0

