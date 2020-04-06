Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03B2B19F972
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 17:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgDFP63 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 11:58:29 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:39715 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbgDFP62 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Apr 2020 11:58:28 -0400
X-Originating-IP: 78.193.40.249
Received: from localhost (unknown [78.193.40.249])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id C8941240004;
        Mon,  6 Apr 2020 15:58:24 +0000 (UTC)
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH 1/3] counter: add an inkernel API
Date:   Mon,  6 Apr 2020 17:58:04 +0200
Message-Id: <20200406155806.1295169-2-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200406155806.1295169-1-kamel.bouhara@bootlin.com>
References: <20200406155806.1295169-1-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Currently, counter devices are exposed directly to user-space through a
sysfs interface. However, there are situations where it might makes
sense for another kernel driver to use a counter handled by the counter
subsystem.

An example is the implementation of an input driver for a rotary
encoder that is connected to hardware counters handled by the counter
subsystem.

This is very much like what happens with IIO subsystem, where ADC
channels are directly accessible by user-space through sysfs, or can be
used through the IIO in-kernel API by other kernel drivers, such as the
adc-keys input keyboard driver.

The proposed API is fairly simple:

 - devm_counter_get() allows a driver to get a reference to a counter
   device. From a Device Tree point of view, a counter-phandle property
   allows to indicate which counter device should be used.
   devm_counter_get() returns a reference to the counter_device
   structure.

 - counter_count_get() and counter_count_set() allow respectively to
   read and set a count value.

 - counter_function_get() and counter_function_set() allow to read and
   set the current count function.

 - counter_action_get() and counter_action_set allow to read and set the
   current count action/synapse.

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
---
 drivers/counter/counter.c | 213 ++++++++++++++++++++++++++++++++++++++
 include/linux/counter.h   |  27 +++++
 2 files changed, 240 insertions(+)

diff --git a/drivers/counter/counter.c b/drivers/counter/counter.c
index 6a683d086008..f81d2d1dbca7 100644
--- a/drivers/counter/counter.c
+++ b/drivers/counter/counter.c
@@ -19,6 +19,7 @@
 #include <linux/string.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
+#include <linux/of.h>
 
 const char *const counter_count_direction_str[2] = {
 	[COUNTER_COUNT_DIRECTION_FORWARD] = "forward",
@@ -1460,6 +1461,218 @@ static int devm_counter_match(struct device *dev, void *res, void *data)
 	return *r == data;
 }
 
+static int match(struct device *dev, const void *data)
+{
+	return (dev->of_node == data) &&
+		(dev->type == &counter_device_type);
+}
+
+/* Internal counter request function */
+static struct counter_device *counter_get(struct device *dev)
+{
+	struct device_node *np;
+	struct device *counter_dev;
+	struct counter_device_state *counter_ds;
+	struct counter_device *counter;
+
+	/* Try DT lookup */
+	np = of_parse_phandle(dev->of_node, "counter", 0);
+	if (!np) {
+		dev_dbg(dev,
+			"Looking up from device tree %pOF failed\n", np);
+		return ERR_PTR(-ENODEV);
+	}
+
+	counter_dev = bus_find_device(&counter_bus_type, NULL, np, match);
+	of_node_put(np);
+	if (!counter_dev)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	counter_ds = to_counter_device_state(counter_dev);
+
+	counter = dev_get_drvdata(&counter_ds->dev);
+	if (!counter)
+		return ERR_PTR(-ENODEV);
+
+	/* Check if device is already owned otherwise set the busy bit */
+	if (test_and_set_bit(COUNTER_BUSY_BIT_POS, &counter->flags)) {
+		pr_info("counter is busy\n");
+		return ERR_PTR(-EBUSY);
+	}
+
+	pr_info("counter acquired\n");
+	get_device(&counter_ds->dev);
+
+	return counter;
+}
+
+static void devm_counter_release(struct device *dev, void *res)
+{
+	struct counter_device *counter = *(struct counter_device **)res;
+
+	if (!counter)
+		return;
+	clear_bit(COUNTER_BUSY_BIT_POS, &counter->flags);
+	put_device(&counter->device_state->dev);
+}
+
+/*
+ * devm_counter_get - Obtain an exclusive access to a counter.
+ * @dev: device for counter "consumer"
+ *
+ * Returns a struct counter_device matching the counter producer, or
+ * IS_ERR() condition containing errno.
+ *
+ */
+struct counter_device *devm_counter_get(struct device *dev)
+{
+	struct counter_device **ptr, *counter;
+
+	ptr = devres_alloc(devm_counter_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	counter = counter_get(dev);
+	if (IS_ERR(counter)) {
+		devres_free(ptr);
+		return counter;
+	}
+
+	*ptr = counter;
+	devres_add(dev, ptr);
+
+	return counter;
+}
+EXPORT_SYMBOL_GPL(devm_counter_get);
+
+/*
+ * counter_action_get - get counter synapse mode
+ * @counter: counter device to operate with
+ * @action: pointer to store the current counter synapse mode
+ * returns:
+ *	0 on success, error code on failure.
+ */
+int counter_action_get(struct counter_device *counter, int *mode)
+{
+	struct counter_synapse *synapse = counter->counts->synapses;
+	size_t action_index;
+	int err;
+
+	err = counter->ops->action_get(counter, counter->counts, synapse,
+				       &action_index);
+	if (err)
+		return err;
+
+	*mode = synapse->actions_list[action_index];
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(counter_action_get);
+
+/*
+ * counter_action_set - set counter device synapse
+ * @counter: counter device to operate with
+ * @action: enum of the synapse mode
+ * returns:
+ *	0 on success, error code on failure.
+ */
+int counter_action_set(struct counter_device *counter,
+		       enum counter_synapse_action action)
+{
+	struct counter_synapse *synapse = counter->counts->synapses;
+	const size_t num_actions = synapse->num_actions;
+	size_t action_index;
+
+	/* Find requested action mode */
+	for (action_index = 0; action_index < num_actions; action_index++) {
+		if (action == synapse->actions_list[action_index])
+			break;
+	}
+
+	if (action_index >= num_actions)
+		return -EINVAL;
+
+	return counter->ops->action_set(counter, counter->counts, synapse,
+					action_index);
+}
+EXPORT_SYMBOL_GPL(counter_action_set);
+
+/*
+ * counter_function_get - get the count function
+ * @counter: pointer to counter device to operate with
+ * @mode: pointer to store the current counter function mode
+ * returns:
+ *	0 on success, error code on failure.
+ */
+int counter_function_get(struct counter_device *counter, int *mode)
+{
+	size_t func_index;
+	int err;
+
+	err = counter->ops->function_get(counter, counter->counts,
+					 &func_index);
+	if (err)
+		return err;
+
+	*mode = counter->counts->functions_list[func_index];
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(counter_function_get);
+
+/*
+ * counter_function_set - set a count function
+ * @counter: pointer to a counter device to operate with
+ * @function: enum of the function mode
+ * returns:
+ *	0 on success, error code on failure.
+ */
+int counter_function_set(struct counter_device *counter,
+			  enum counter_count_function function)
+{
+	const size_t num_functions = counter->counts->num_functions;
+	size_t func_index;
+
+	for (func_index = 0; func_index < num_functions; func_index++) {
+		if (function == counter->counts->functions_list[func_index])
+			break;
+	}
+
+	if (func_index >= num_functions)
+		return -EINVAL;
+
+	return counter->ops->function_set(counter, counter->counts, func_index);
+}
+EXPORT_SYMBOL_GPL(counter_function_set);
+
+/*
+ * counter_count_set - set a count value
+ * @counter: pointer to the counter device to operate with
+ * @val: count value to write into the counter
+ * @len: length of the value written to the counter
+ * returns:
+ *	bytes length of the value on success, error code on failure.
+ */
+size_t counter_count_set(struct counter_device *counter,
+			 unsigned long val, size_t len)
+{
+	return counter->ops->count_write(counter, counter->counts, val);
+}
+EXPORT_SYMBOL_GPL(counter_count_set);
+
+/*
+ * counter_count_get - read the count value
+ * @counter: pointer to the counter device to operate with
+ * @val: pointer to store the count value
+ * returns:
+ *  0 on success, error code on failure.
+ */
+int counter_count_get(struct counter_device *counter, unsigned long *val)
+{
+	return counter->ops->count_read(counter, counter->counts, val);
+}
+EXPORT_SYMBOL_GPL(counter_count_get);
+
 /**
  * devm_counter_unregister - Resource-managed counter_unregister
  * @dev:	device this counter_device belongs to
diff --git a/include/linux/counter.h b/include/linux/counter.h
index 9dbd5df4cd34..81f63479be55 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -10,6 +10,8 @@
 #include <linux/device.h>
 #include <linux/types.h>
 
+#define COUNTER_BUSY_BIT_POS 1
+
 enum counter_count_direction {
 	COUNTER_COUNT_DIRECTION_FORWARD = 0,
 	COUNTER_COUNT_DIRECTION_BACKWARD
@@ -290,6 +292,15 @@ struct counter_device_state {
 	const struct attribute_group **groups;
 };
 
+/**
+ * to_counter_device_state - Returns a &struct counter_device_state
+ * from the &struct device embedded in it.
+ *
+ * @d:pointer to &struct device
+ */
+#define to_counter_device_state(d) \
+	container_of(d, struct counter_device_state, dev)
+
 enum counter_signal_value {
 	COUNTER_SIGNAL_LOW = 0,
 	COUNTER_SIGNAL_HIGH
@@ -424,6 +435,7 @@ struct counter_device_enum_ext {
  * @num_counts:		number of Counts specified in @counts
  * @ext:		optional array of Counter device extensions
  * @num_ext:		number of Counter device extensions specified in @ext
+ * @flags:		internal device flags including a busy flag.
  * @priv:		optional private data supplied by driver
  */
 struct counter_device {
@@ -440,6 +452,7 @@ struct counter_device {
 
 	const struct counter_device_ext *ext;
 	size_t num_ext;
+	unsigned long flags;
 
 	void *priv;
 };
@@ -450,5 +463,19 @@ int devm_counter_register(struct device *dev,
 			  struct counter_device *const counter);
 void devm_counter_unregister(struct device *dev,
 			     struct counter_device *const counter);
+/* inkernel interface */
+int __must_check counter_count_get(struct counter_device *counter,
+				   unsigned long *val);
+size_t __must_check counter_count_set(struct counter_device *counter,
+				      unsigned long val, size_t len);
+int __must_check counter_function_get(struct counter_device *counter,
+				      int *mode);
+int __must_check counter_function_set(struct counter_device *counter,
+				      enum counter_count_function function);
+int __must_check counter_action_get(struct counter_device *counter,
+				    int *mode);
+int __must_check counter_action_set(struct counter_device *counter,
+				    enum counter_synapse_action action);
+struct counter_device *__must_check devm_counter_get(struct device *dev);
 
 #endif /* _COUNTER_H_ */
-- 
2.25.0

