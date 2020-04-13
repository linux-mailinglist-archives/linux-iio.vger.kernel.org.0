Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86E21A6CDC
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 21:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388140AbgDMTzT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 15:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388135AbgDMTzS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2020 15:55:18 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85951C0A3BE2
        for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2020 12:55:18 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id c138so5014654pfc.0
        for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2020 12:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RcHSfD/zpnb9B30gzcWUBYhaXXfJkVgBPummCh5qh0o=;
        b=Pq7eLGHUHlDGlpF3jsIn7ZqdewX0L40/1CRveffZxHemxip5phP+m8nwGYeTJ3MWt8
         MIdUdAZ7EzGEEu61EmqD7JwpBtCnJR3v0xy2z13L/mCBPh3t2CjcTosAyZUYMIKKWu++
         kzfAyxNpPjw/dEbAWIlRSH2VU3fHQ9cYCK0Iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RcHSfD/zpnb9B30gzcWUBYhaXXfJkVgBPummCh5qh0o=;
        b=VREFAwxZLHeWFsAJzNlp3ZVtfdJgFUEQoyT+5AJAqrCYYfWw0HUZ4Au3wvImfe4Za7
         CUBzAImZnFDC1iA9zQd3LxIG2qEfmVAIIQmmBanQldW/L+YYAGBp0Xnpq4RAGVY+ah/Q
         Xkvwj1VK1Z9rUTFoypqAajF8aKky+qwax6+l2qDE6EVW/EmDUuGMT+DiQwuyr7WGisng
         8JEWVMP7s+5iaQd5nzgFFA37mPw07UPQyBnz4Xy384AkXOiXhps6h0qvHuUYlq1G3Phl
         30FwaCNo6ydBvLuvNkLbvI1GPT5llTxEqLDhGHLXGTRkiVgfd1XywxJ58+XtBZ9Q0M+D
         GOdw==
X-Gm-Message-State: AGi0PuY1IFi9BUvTbZRNvUweolYfhIQI3GhSvGKpJhgD5j3podqZmpK6
        9N6b9VyaUrF79StYFxa58thUJA==
X-Google-Smtp-Source: APiQypJTgEkBbYmbJARiW9ERdvGxPpA0941NvdkR+lPLV4QwM4Nv2C9+3HpfH9nFNDM2t0O4O+sefQ==
X-Received: by 2002:aa7:8429:: with SMTP id q9mr6923651pfn.205.1586807717713;
        Mon, 13 Apr 2020 12:55:17 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id u13sm10290403pjb.45.2020.04.13.12.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 12:55:16 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     vilhelm.gray@gmail.com, enric.balletbo@collabora.com,
        jic23@kernel.org
Cc:     bleung@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2] drivers: counter: Add Cros EC Sync counter
Date:   Mon, 13 Apr 2020 12:55:14 -0700
Message-Id: <20200413195514.192868-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When the camera vsync pin is connected to the embedded controller (EC) of
a chromebook, the EC reports a sensor with a counter that increases
at each GPIO rising edge.

The sensor is presented using the counter subsystem.
In addition, it is also presented via the IIO subsystem with a timestamp,
allowing synchronisation with sensors connected to the same EC, for
image stabilisation or augmented reality applications.

To enable the counter:
via counter ABI:
echo "rising edge" > counterX/count0/signal_action
via iio ABI
echo 1 > iio:deviceY/en

To disable the counter:
via counter ABI:
echo "none" > counterX/count0/signal_action
via iio ABI
echo 0 > iio:deviceY/en

To read the current counter value:
via counter ABI:
cat counterX/count0/count
via iio ABI
cat iio:deviceY/in_count_raw
We can also read the value through the IIO buffer:
echo 1 > iio:deviceY/scan_elements/in_timestamp_en
echo 1 > iio:deviceY/scan_elements/in_count_en
echo 1 > iio:deviceY/buffer/enable

and each time to counter increase, the following binary blob
will be appended to dev/iio:deviceY:
000f 0000 0000 0000 dc66 816c 0071 0000
 \   <-- padding -> <-- timestamp ---->
  count

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v2:
- fix license.
- remove extra unlock.

 drivers/counter/Kconfig                       |  11 +
 drivers/counter/Makefile                      |   1 +
 drivers/counter/cros_ec_sync.c                | 332 ++++++++++++++++++
 .../cros_ec_sensors/cros_ec_sensors_core.c    |  15 +
 drivers/platform/chrome/cros_ec_sensorhub.c   |   3 +
 .../linux/iio/common/cros_ec_sensors_core.h   |   4 +-
 6 files changed, 365 insertions(+), 1 deletion(-)
 create mode 100644 drivers/counter/cros_ec_sync.c

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index c80fa76bb5311..18fde918ff40b 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -29,6 +29,17 @@ config 104_QUAD_8
 	  The base port addresses for the devices may be configured via the base
 	  array module parameter.
 
+config CROS_EC_SYNC
+	tristate "ChromeOS EC Counter driver"
+	depends on IIO_CROS_EC_SENSORS_CORE
+	help
+	  Module to handle synchronisation sensor presented by the ChromeOS EC
+	  Sensor hub.
+	  Synchronisation sensor sends event to the host when the camera
+	  take a picture. It allows synchronisation with other MEMS sensor,
+	  like gyroscope for image statbilization or augmented reality
+	  application (AR).
+
 config STM32_TIMER_CNT
 	tristate "STM32 Timer encoder counter driver"
 	depends on MFD_STM32_TIMERS || COMPILE_TEST
diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
index 55142d1f4c436..98378fca50ad6 100644
--- a/drivers/counter/Makefile
+++ b/drivers/counter/Makefile
@@ -6,6 +6,7 @@
 obj-$(CONFIG_COUNTER) += counter.o
 
 obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
+obj-$(CONFIG_CROS_EC_SYNC)	+= cros_ec_sync.o
 obj-$(CONFIG_STM32_TIMER_CNT)	+= stm32-timer-cnt.o
 obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
 obj-$(CONFIG_TI_EQEP)		+= ti-eqep.o
diff --git a/drivers/counter/cros_ec_sync.c b/drivers/counter/cros_ec_sync.c
new file mode 100644
index 0000000000000..4e644d651fde6
--- /dev/null
+++ b/drivers/counter/cros_ec_sync.c
@@ -0,0 +1,332 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for synchronisation sensor behind CrOS EC.
+ *
+ * Copyright 2020 Google LLC.
+ *
+ * This driver uses the cros-ec interface to communicate with the Chrome OS
+ * EC about counter sensors. Counters are presented through
+ * iio sysfs.
+ */
+
+#include <linux/counter.h>
+#include <linux/device.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/common/cros_ec_sensors_core.h>
+#include <linux/iio/iio.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_data/cros_ec_commands.h>
+#include <linux/platform_data/cros_ec_proto.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+/*
+ * One channel for counter, the other for timestamp.
+ */
+#define MAX_CHANNELS (1 + 1)
+
+/**
+ * struct cros_ec_sync_state - device structure
+ *
+ * @core: common structure for all cros_ec sensor.
+ *        Must be at the beggining.
+ * @channels: presented iio channels(2).
+ * @counter: counter data structure.
+ */
+struct cros_ec_sync_state {
+	struct cros_ec_sensors_core_state core;
+	struct iio_chan_spec channels[MAX_CHANNELS];
+	struct counter_device counter;
+};
+
+/**
+ * cros_ec_sync_get_enable() - Check if the counter is enabled.
+ *
+ * @st:     core cros_ec sensor
+ * @val:    status: 0: disabled, 1 enabled.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+static int cros_ec_sync_get_enable(struct cros_ec_sensors_core_state *st,
+				   int *val)
+{
+	int ret;
+
+	mutex_lock(&st->cmd_lock);
+	st->param.cmd = MOTIONSENSE_CMD_SENSOR_ODR;
+	st->param.sensor_odr.data = EC_MOTION_SENSE_NO_VALUE;
+
+	ret = cros_ec_motion_send_host_cmd(st, 0);
+	mutex_unlock(&st->cmd_lock);
+	if (ret)
+		return ret;
+
+	*val = !!st->resp->sensor_odr.ret;
+	return 0;
+}
+
+/**
+ * cros_ec_sync_set_enable() - Allow the counter to count.
+ *
+ * When enable, the counter will increase for each VSYNC rising edge
+ * and will produce an event in the iio buffer, if enabled.
+ *
+ * @st:     core cros_ec sensor
+ * @val:    0: disable, 1 enable.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+static int cros_ec_sync_set_enable(struct cros_ec_sensors_core_state *st,
+				   int val)
+{
+	int ret;
+
+	mutex_lock(&st->cmd_lock);
+	st->param.cmd = MOTIONSENSE_CMD_SENSOR_ODR;
+	st->param.sensor_odr.data = val;
+	st->param.sensor_odr.roundup = 1;
+
+	ret = cros_ec_motion_send_host_cmd(st, 0);
+	mutex_unlock(&st->cmd_lock);
+	return ret;
+}
+
+static int cros_ec_sync_iio_read(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan,
+				 int *val, int *val2, long mask)
+{
+	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
+	u16 data;
+	int ret;
+	int idx = chan->scan_index;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&st->cmd_lock);
+		ret = cros_ec_sensors_read_cmd(indio_dev, 1 << idx, &data);
+		mutex_unlock(&st->cmd_lock);
+		if (ret < 0)
+			break;
+		ret = IIO_VAL_INT;
+		*val = data;
+		break;
+	case IIO_CHAN_INFO_ENABLE:
+		ret = cros_ec_sync_get_enable(st, val);
+		if (ret < 0)
+			break;
+		ret = IIO_VAL_INT;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static int cros_ec_sync_iio_write(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan,
+				  int val, int val2, long mask)
+{
+	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_ENABLE:
+		if (val < 0 || val > 1)
+			return -EINVAL;
+
+		return cros_ec_sync_set_enable(st, val);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info cros_ec_sync_info = {
+	.read_raw = &cros_ec_sync_iio_read,
+	.write_raw = &cros_ec_sync_iio_write,
+};
+
+/* The counter can only increase, so only one function present. */
+static enum counter_count_function cros_ec_sync_functions[] = {
+	COUNTER_COUNT_FUNCTION_INCREASE,
+};
+
+/* 2 synapse actions allowed: count for each rising edge, or not. */
+static enum counter_synapse_action cros_ec_sync_synapse_actions[] = {
+	COUNTER_SYNAPSE_ACTION_NONE,
+	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
+};
+
+static int cros_ec_sync_read_count(struct counter_device *counter,
+				   struct counter_count *count,
+				   unsigned long *val)
+{
+	struct cros_ec_sensors_core_state *st = counter->priv;
+	u16 raw;
+	int ret;
+
+	mutex_lock(&st->cmd_lock);
+	ret = cros_ec_sensors_read_cmd(iio_priv_to_dev(st), 1, &raw);
+	mutex_unlock(&st->cmd_lock);
+	if (ret)
+		return ret;
+
+	*val = raw;
+	return 0;
+}
+
+static int cros_ec_sync_function_get(struct counter_device *counter,
+				     struct counter_count *count,
+				     size_t *function)
+{
+	*function = 0;
+	return 0;
+}
+
+static int cros_ec_sync_action_get(struct counter_device *counter,
+				   struct counter_count *count,
+				   struct counter_synapse *synapse,
+				   size_t *action)
+{
+	struct cros_ec_sensors_core_state *st = counter->priv;
+	int ret;
+	int raw;
+
+	ret = cros_ec_sync_get_enable(st, &raw);
+	if (ret)
+		return ret;
+
+	*action = !!raw;
+	return 0;
+}
+
+static int cros_ec_sync_action_set(struct counter_device *counter,
+				   struct counter_count *count,
+				   struct counter_synapse *synapse,
+				   size_t action)
+{
+	struct cros_ec_sensors_core_state *st = counter->priv;
+
+	return cros_ec_sync_set_enable(st, action);
+}
+
+static const struct counter_ops cros_ec_sync_ops = {
+	.count_read = cros_ec_sync_read_count,
+	.function_get = cros_ec_sync_function_get,
+	.action_get = cros_ec_sync_action_get,
+	.action_set = cros_ec_sync_action_set,
+};
+
+static struct counter_signal cros_ec_sync_signals[] = {
+	{
+		.id = 0,
+		.name = "vsync"
+	}
+};
+
+static struct counter_synapse cros_ec_sync_synapses[] = {
+	{
+		.actions_list = cros_ec_sync_synapse_actions,
+		.num_actions = ARRAY_SIZE(cros_ec_sync_synapse_actions),
+		.signal = cros_ec_sync_signals
+	}
+};
+
+static struct counter_count cros_ec_sync_counts[] = {
+	{
+		.id = 0,
+		.name = "vsync",
+		.functions_list = cros_ec_sync_functions,
+		.num_functions = ARRAY_SIZE(cros_ec_sync_functions),
+		.synapses = cros_ec_sync_synapses,
+		.num_synapses = ARRAY_SIZE(cros_ec_sync_synapses),
+	}
+};
+
+static int cros_ec_sync_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct iio_dev *indio_dev;
+	struct cros_ec_sync_state *state;
+	struct iio_chan_spec *channel;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
+					cros_ec_sensors_capture,
+					cros_ec_sensors_push_data);
+	if (ret)
+		return ret;
+
+	indio_dev->info = &cros_ec_sync_info;
+	state = iio_priv(indio_dev);
+
+	/* Initialize IIO device */
+	channel = state->channels;
+
+	/* Counter channel */
+	channel->type = IIO_COUNT;
+	channel->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+	channel->info_mask_shared_by_all = BIT(IIO_CHAN_INFO_ENABLE);
+	channel->scan_type.realbits = CROS_EC_SENSOR_BITS;
+	channel->scan_type.storagebits = CROS_EC_SENSOR_BITS;
+	channel->scan_type.shift = 0;
+	channel->scan_index = 0;
+	channel->ext_info = cros_ec_sensors_limited_info;
+	channel->scan_type.sign = 'u';
+
+	/* Timestamp channel */
+	channel++;
+	channel->type = IIO_TIMESTAMP;
+	channel->channel = -1;
+	channel->scan_index = 1;
+	channel->scan_type.sign = 's';
+	channel->scan_type.realbits = 64;
+	channel->scan_type.storagebits = 64;
+
+	indio_dev->channels = state->channels;
+	indio_dev->num_channels = MAX_CHANNELS;
+
+	state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
+
+	/* Initialize Counter device */
+	state->counter.name = dev_name(&pdev->dev);
+	state->counter.parent = &pdev->dev;
+	state->counter.ops = &cros_ec_sync_ops;
+	state->counter.counts = cros_ec_sync_counts;
+	state->counter.num_counts = ARRAY_SIZE(cros_ec_sync_counts);
+	state->counter.signals = cros_ec_sync_signals;
+	state->counter.num_signals = ARRAY_SIZE(cros_ec_sync_signals);
+	state->counter.priv = state;
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ret;
+
+	return devm_counter_register(dev, &state->counter);
+}
+
+static const struct platform_device_id cros_ec_sync_ids[] = {
+	{
+		.name = "cros-ec-sync",
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, cros_ec_sync_ids);
+
+static struct platform_driver cros_ec_sync_platform_driver = {
+	.driver = {
+		.name	= "cros-ec-sync",
+	},
+	.probe		= cros_ec_sync_probe,
+	.id_table	= cros_ec_sync_ids,
+};
+module_platform_driver(cros_ec_sync_platform_driver);
+
+MODULE_AUTHOR("Gwendal Grignou <gwendal@chromium.org>");
+MODULE_DESCRIPTION("ChromeOS EC synchronisation sensor driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index c831915ca7e56..3a15094616710 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -31,6 +31,7 @@
 static char *cros_ec_loc[] = {
 	[MOTIONSENSE_LOC_BASE] = "base",
 	[MOTIONSENSE_LOC_LID] = "lid",
+	[MOTIONSENSE_LOC_CAMERA] = "camera",
 	[MOTIONSENSE_LOC_MAX] = "unknown",
 };
 
@@ -467,6 +468,20 @@ const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[] = {
 };
 EXPORT_SYMBOL_GPL(cros_ec_sensors_ext_info);
 
+const struct iio_chan_spec_ext_info cros_ec_sensors_limited_info[] = {
+	{
+		.name = "id",
+		.shared = IIO_SHARED_BY_ALL,
+		.read = cros_ec_sensors_id
+	},
+	{
+		.name = "location",
+		.shared = IIO_SHARED_BY_ALL,
+		.read = cros_ec_sensors_loc
+	},
+	{ },
+};
+EXPORT_SYMBOL_GPL(cros_ec_sensors_limited_info);
 /**
  * cros_ec_sensors_idx_to_reg - convert index into offset in shared memory
  * @st:		pointer to state information for device
diff --git a/drivers/platform/chrome/cros_ec_sensorhub.c b/drivers/platform/chrome/cros_ec_sensorhub.c
index b7f2c00db5e1e..e4ae0868d1e06 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub.c
@@ -106,6 +106,9 @@ static int cros_ec_sensorhub_register(struct device *dev,
 		case MOTIONSENSE_TYPE_ACTIVITY:
 			name = "cros-ec-activity";
 			break;
+		case MOTIONSENSE_TYPE_SYNC:
+			name = "cros-ec-sync";
+			break;
 		default:
 			dev_warn(dev, "unknown type %d\n",
 				 sensorhub->resp->info.type);
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index 7bc961defa87e..e416b28cf24c7 100644
--- a/include/linux/iio/common/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -114,7 +114,9 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
 			       struct iio_chan_spec const *chan,
 			       int val, int val2, long mask);
 
-/* List of extended channel specification for all sensors */
+/* List of extended channel specification for all sensors. */
+extern const struct iio_chan_spec_ext_info cros_ec_sensors_limited_info[];
+/* Add calibration to set above. */
 extern const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[];
 extern const struct attribute *cros_ec_sensor_fifo_attributes[];
 
-- 
2.26.0.110.g2183baf09c-goog

