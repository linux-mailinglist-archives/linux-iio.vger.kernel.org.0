Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3039263652
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2019 15:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfGINAC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Jul 2019 09:00:02 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42518 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfGINAB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Jul 2019 09:00:01 -0400
Received: from laptop.home (unknown [IPv6:2a01:cb19:8ad6:900:42dd:dd1c:19ee:7c60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: aragua)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 56FCC28AC6F;
        Tue,  9 Jul 2019 13:59:57 +0100 (BST)
From:   Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     kernel@collabora.com, Gwendal Grignou <gwendal@chromium.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>,
        Nick Vaccaro <nvaccaro@chromium.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 1/1] counter: cros_ec: Add synchronization sensor
Date:   Tue,  9 Jul 2019 14:59:42 +0200
Message-Id: <2f7d1c7582ad4005b16e5c8273bcd0100431ff1d.1562676020.git.fabien.lahoudere@collabora.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1562676020.git.fabien.lahoudere@collabora.com>
References: <cover.1562676020.git.fabien.lahoudere@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Gwendal Grignou <gwendal@chromium.org>

EC returns a counter when there is an event on camera vsync.
This patch comes from chromeos kernel 4.4

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>

CROS EC sync sensor was originally designed as an IIO device.
Now that the counter subsystem will replace IIO_COUNTER, we
have to implement a new way to get sync count.

Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
---
 drivers/counter/Kconfig                       |   9 +
 drivers/counter/Makefile                      |   1 +
 drivers/counter/cros_ec_sensors_sync.c        | 200 ++++++++++++++++++
 .../cros_ec_sensors/cros_ec_sensors_core.c    |   1 +
 drivers/mfd/cros_ec_dev.c                     |   3 +
 5 files changed, 214 insertions(+)
 create mode 100644 drivers/counter/cros_ec_sensors_sync.c

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index 2967d0a9ff91..22287f5715e5 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -59,4 +59,13 @@ config FTM_QUADDEC
 	  To compile this driver as a module, choose M here: the
 	  module will be called ftm-quaddec.
 
+config IIO_CROS_EC_SENSORS_SYNC
+	tristate "ChromeOS EC Counter Sensors"
+	depends on IIO_CROS_EC_SENSORS_CORE && IIO
+	help
+	  Module to handle synchronisation sensors presented by the ChromeOS EC
+	  Sensor hub.
+	  Synchronisation sensors are counter sensors triggered when events
+	  occurs from other subsystems.
+
 endif # COUNTER
diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
index 40d35522937d..6fe4c98a446f 100644
--- a/drivers/counter/Makefile
+++ b/drivers/counter/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
 obj-$(CONFIG_STM32_TIMER_CNT)	+= stm32-timer-cnt.o
 obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
 obj-$(CONFIG_FTM_QUADDEC)	+= ftm-quaddec.o
+obj-$(CONFIG_IIO_CROS_EC_SENSORS_SYNC) += cros_ec_sensors_sync.o
diff --git a/drivers/counter/cros_ec_sensors_sync.c b/drivers/counter/cros_ec_sensors_sync.c
new file mode 100644
index 000000000000..715a4860cade
--- /dev/null
+++ b/drivers/counter/cros_ec_sensors_sync.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver of counter increaseded after events on interrupt line in EC.
+ *
+ * Copyright 2018 Google, Inc
+ */
+
+#include <linux/device.h>
+#include <linux/counter.h>
+#include <linux/iio/common/cros_ec_sensors_core.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/kernel.h>
+#include <linux/mfd/cros_ec.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#define DRV_NAME "cros-ec-sync"
+
+/*
+ * One channel for counter, the other for timestamp.
+ */
+#define MAX_CHANNELS (1 + 1)
+
+/* State data for ec_sensors iio driver. */
+struct cros_ec_sensors_sync_state {
+	/* Shared by all sensors */
+	struct cros_ec_sensors_core_state core;
+	struct counter_device counter;
+	struct iio_chan_spec channels[MAX_CHANNELS];
+};
+
+static int cros_ec_sensors_sync_read(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan,
+				     int *val, int *val2, long mask)
+{
+	struct cros_ec_sensors_sync_state *st = iio_priv(indio_dev);
+	u16 data;
+	int ret;
+	int idx = chan->scan_index;
+
+	mutex_lock(&st->core.cmd_lock);
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = cros_ec_sensors_read_cmd(indio_dev, BIT(idx), &data);
+		if (ret < 0)
+			break;
+		ret = IIO_VAL_INT;
+		*val = data;
+		break;
+	default:
+		ret = cros_ec_sensors_core_read(&st->core, chan, val, val2,
+						mask);
+		break;
+	}
+	mutex_unlock(&st->core.cmd_lock);
+	return ret;
+}
+
+static int cros_ec_sensors_write(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan,
+				 int val, int val2, long mask)
+{
+	struct cros_ec_sensors_sync_state *st = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&st->core.cmd_lock);
+
+	ret = cros_ec_sensors_core_write(&st->core, chan, val, val2, mask);
+
+	mutex_unlock(&st->core.cmd_lock);
+	return ret;
+}
+
+static struct iio_info cros_ec_sensors_sync_info = {
+	.read_raw = &cros_ec_sensors_sync_read,
+	.write_raw = &cros_ec_sensors_write,
+	.read_avail = &cros_ec_sensors_core_read_avail,
+};
+
+static struct counter_count cros_ec_sync_counts = {
+	.id = 0,
+	.name = "Cros EC sync counter",
+};
+
+static int cros_ec_sync_cnt_read(struct counter_device *counter,
+				struct counter_count *count,
+				struct counter_count_read_value *val)
+{
+	s16 cnt;
+	int ret;
+	struct iio_dev * indio_dev = counter->priv;
+	struct cros_ec_sensors_sync_state *const st = iio_priv(indio_dev);
+	unsigned long data;
+
+	mutex_lock(&st->core.cmd_lock);
+	ret = cros_ec_sensors_read_cmd(indio_dev, BIT(0), &cnt);
+	mutex_unlock(&st->core.cmd_lock);
+	if (ret != 0) {
+		dev_warn(&indio_dev->dev, "Unable to read sensor data\n");
+		return ret;
+	}
+
+	data = (unsigned long) cnt;
+	counter_count_read_value_set(val, COUNTER_COUNT_POSITION, &data);
+
+	return 0;
+}
+
+static const struct counter_ops cros_ec_sync_cnt_ops = {
+	.count_read = cros_ec_sync_cnt_read,
+};
+
+static int cros_ec_sensors_sync_probe(struct platform_device *pdev)
+{
+	struct cros_ec_sensors_sync_state *state;
+	struct device *dev = &pdev->dev;
+	struct iio_chan_spec *channel;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	ret = cros_ec_sensors_core_init(pdev, indio_dev, true);
+	if (ret)
+		return ret;
+
+	indio_dev->info = &cros_ec_sensors_sync_info;
+	state = iio_priv(indio_dev);
+
+	if (state->core.type != MOTIONSENSE_TYPE_SYNC)
+		return -EINVAL;
+
+	/* Initialize IIO device */
+	channel = state->channels;
+	channel->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+	channel->info_mask_shared_by_all = BIT(IIO_CHAN_INFO_FREQUENCY);
+	channel->scan_type.realbits = CROS_EC_SENSOR_BITS;
+	channel->scan_type.storagebits = CROS_EC_SENSOR_BITS;
+	channel->scan_type.shift = 0;
+	channel->scan_index = 0;
+	channel->ext_info = cros_ec_sensors_ext_info;
+	channel->scan_type.sign = 'u';
+	channel->type = IIO_COUNT;
+	state->core.calib[0] = 0;
+
+	/* Timestamp */
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
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+					      cros_ec_sensors_capture, NULL);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ret;
+
+	/* Initialize counter device */
+	state->counter.name = dev_name(&pdev->dev);
+	state->counter.parent = &pdev->dev;
+	state->counter.counts = &cros_ec_sync_counts;
+	state->counter.num_counts = 1;
+	state->counter.priv = indio_dev;
+	state->counter.ops = &cros_ec_sync_cnt_ops;
+
+	return devm_counter_register(&pdev->dev, &state->counter);
+}
+
+static const struct platform_device_id cros_ec_sensors_sync_ids[] = {
+	{ .name = DRV_NAME, },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, cros_ec_sensors_sync_ids);
+
+static struct platform_driver cros_ec_sensors_sync_platform_driver = {
+	.driver = {
+		.name	= DRV_NAME,
+		.pm	= &cros_ec_sensors_pm_ops,
+	},
+	.probe		= cros_ec_sensors_sync_probe,
+	.id_table	= cros_ec_sensors_sync_ids,
+};
+module_platform_driver(cros_ec_sensors_sync_platform_driver);
+
+MODULE_DESCRIPTION("ChromeOS EC synchronisation sensor driver");
+MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 805652250960..2bf183425eaf 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -22,6 +22,7 @@
 static char *cros_ec_loc[] = {
 	[MOTIONSENSE_LOC_BASE] = "base",
 	[MOTIONSENSE_LOC_LID] = "lid",
+	[MOTIONSENSE_LOC_CAMERA] = "camera",
 	[MOTIONSENSE_LOC_MAX] = "unknown",
 };
 
diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 41dccced5026..1c5c2c38af88 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -332,6 +332,9 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 		case MOTIONSENSE_TYPE_ACTIVITY:
 			sensor_cells[id].name = "cros-ec-activity";
 			break;
+		case MOTIONSENSE_TYPE_SYNC:
+			sensor_cells[id].name = "cros-ec-sync";
+			break;
 		default:
 			dev_warn(ec->dev, "unknown type %d\n", resp->info.type);
 			continue;
-- 
2.19.2

