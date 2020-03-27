Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33FDF19614B
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 23:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgC0Wew (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 18:34:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42864 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgC0Wev (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 18:34:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id h8so5259581pgs.9
        for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2020 15:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sBGsO3d5pcmc3tbgdRu/3pO3ADaPX50+zmTCsUK5EN0=;
        b=jQh5B3cEZrh9N4Xzs4V+ZAd+TkyNyofblENthZTgGImKB4Cm3swrN2zV25ZU8XOM+r
         7LPf7JcD396FSqLK2w5JCmZXY6iShrk4dY/mueVSZW40Rc6EdW9LhaNDfdvf0OdeZPJh
         79b4vEdDjBxB8KfQH9TQxhQTkIAu+cxU1I9r0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sBGsO3d5pcmc3tbgdRu/3pO3ADaPX50+zmTCsUK5EN0=;
        b=Sx+o7SbZKu8WmRTMItGlPRZqoCZLZZPWcek4W6/mIw9WHGkmdChHsdxCqJokS8qhX+
         hzCRB+bZaQXu6xG7VG+0KthQbeZstpQanKN5BZSpzjTNJozc80RhfSrJWq+pbnsJMyYy
         R2irxak3My+VPXyT88X18chRKfWOyihIH/aCjVYMZKOnWdE9h3KAMC3P0M4qwsJM0FuT
         /n9v9qbvkX/lSgBsiV+sylwolFYf1zhiDOL+WTjYZg17H1r+aiUAlLevK75vIhEdYY7b
         ojKLjNx3G3hTVgOQSmTdgDy7For/fupYVhojUAJMmbMIu9zSIJmoZU4G0uYNUBFlyYwc
         4pVw==
X-Gm-Message-State: ANhLgQ104qWd+mx/vJcb8UNIa1DlH8t2G7B7Wr9Dezixn3Ps+bz2Fgj/
        x/DUIfEsAqKgd5z793+o8ck4Yw==
X-Google-Smtp-Source: ADFU+vtJ9gwM2R/DubPCRuksCgDNfhszbHOpDr1sOBqq6d01oay16jwWLOB9d0Q1VxYytQhfc0Rf5Q==
X-Received: by 2002:a63:5124:: with SMTP id f36mr1471265pgb.288.1585348488995;
        Fri, 27 Mar 2020 15:34:48 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id 184sm4588332pgb.52.2020.03.27.15.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 15:34:48 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        Jonathan.Cameron@huawei.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v7 02/12] platform: chrome: sensorhub: Add FIFO support
Date:   Fri, 27 Mar 2020 15:34:33 -0700
Message-Id: <20200327223443.6006-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <20200327223443.6006-1-gwendal@chromium.org>
References: <20200327223443.6006-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

cros_ec_sensorhub registers a listener and query motion sense FIFO,
spread to iio sensors registers.

To test, we can use libiio:
iiod&
iio_readdev -u ip:localhost -T 10000 -s 25 -b 16 cros-ec-gyro | od -x

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v7:
- Use the number of sensors present to create the right number of
  callback slots and to collect the right amount of FIFO information
  when sensor events are lost.
- Report the number of lost events for sensors that lost all their
  events.
Changes in v6:
- Unify function naming in cros_ec_sensorhub: cros_ec_sensorhub_ring_...
- Kernel module name is now cros-ec-sensorhub
- Remove unneceassary warning messages.

Changes in v5:
- Use a goto in cros_ec_sensorhub_ring_handler to centralize error
  handling
- Use devm_add_action_or_reset to not need a .remove entry point for
  cros_sensor_hub.
- Fix logic error in cros_ec_sensorhub_register_push_data.
- Update kernel_doc documentation.
- Remve the need for comments in variable declaration section.
Changes in v4:
- Keep defining cros_ec_sensorhub in kernel-doc format
- Fix logic error when checking if sensor index outside array.
- Check patch with --strict option
    Use sizeof(*obj) instead of sizeof(struct ...obj)
    Alignement
    Use uX instead of uintX_t
    Use !ptr instead of ptr != NULL
Changes in v3:
- Do not use ret !=
- Simplfy errpr handling by removing a goto
- Fix doxygen comments
- Replace suspend/resume entry points with regular driver entry point;
  There was an issue in the past where the sensor stack was preventing
  device to suspend, but the proper fix has been implemented in cros_ec
  code (6ad16b78a039b "platform/chrome: don't report
EC_MKBP_EVENT_SENSOR_FIFO as wakeup")
- Reduce mutex scope by checking return code outside of it.
Changes in v2:
- Do not register a .remove routinge in plaform_driver. A
  devm_action_add is added later patch IIO driver register their
callback.
- Remove double lines, add lines before return calls.
- Handle FLUSH flag from EC.

- Use ktime_t for most timestamp measurements.
- Add doxygen comments
- Cleanup timestamp collection when processing FIFO.
- Rename fifo_toggle to fifo_enable


 drivers/platform/chrome/Makefile              |   4 +-
 drivers/platform/chrome/cros_ec_sensorhub.c   | 107 +++--
 .../platform/chrome/cros_ec_sensorhub_ring.c  | 439 ++++++++++++++++++
 .../linux/platform_data/cros_ec_sensorhub.h   |  76 +++
 4 files changed, 598 insertions(+), 28 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_ec_sensorhub_ring.c

diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index 198c155c7c4d4..1223b028cefa0 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -20,7 +20,9 @@ obj-$(CONFIG_CROS_EC_CHARDEV)		+= cros_ec_chardev.o
 obj-$(CONFIG_CROS_EC_LIGHTBAR)		+= cros_ec_lightbar.o
 obj-$(CONFIG_CROS_EC_VBC)		+= cros_ec_vbc.o
 obj-$(CONFIG_CROS_EC_DEBUGFS)		+= cros_ec_debugfs.o
-obj-$(CONFIG_CROS_EC_SENSORHUB)		+= cros_ec_sensorhub.o
+obj-$(CONFIG_CROS_EC_SENSORHUB)                += cros-ec-sensorhub.o
+cros-ec-sensorhub-objs                 := cros_ec_sensorhub.o
+cros-ec-sensorhub-objs                 += cros_ec_sensorhub_ring.o
 obj-$(CONFIG_CROS_EC_SYSFS)		+= cros_ec_sysfs.o
 obj-$(CONFIG_CROS_USBPD_LOGGER)		+= cros_usbpd_logger.o
 obj-$(CONFIG_CROS_USBPD_NOTIFY)		+= cros_usbpd_notify.o
diff --git a/drivers/platform/chrome/cros_ec_sensorhub.c b/drivers/platform/chrome/cros_ec_sensorhub.c
index 134ee5e460472..b7f2c00db5e1e 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub.c
@@ -50,10 +50,8 @@ static int cros_ec_sensorhub_register(struct device *dev,
 				      struct cros_ec_sensorhub *sensorhub)
 {
 	int sensor_type[MOTIONSENSE_TYPE_MAX] = { 0 };
+	struct cros_ec_command *msg = sensorhub->msg;
 	struct cros_ec_dev *ec = sensorhub->ec;
-	struct ec_params_motion_sense *params;
-	struct ec_response_motion_sense *resp;
-	struct cros_ec_command *msg;
 	int ret, i, sensor_num;
 	char *name;
 
@@ -71,22 +69,13 @@ static int cros_ec_sensorhub_register(struct device *dev,
 		return -EINVAL;
 	}
 
-	/* Prepare a message to send INFO command to each sensor. */
-	msg = kzalloc(sizeof(*msg) + max(sizeof(*params), sizeof(*resp)),
-		      GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
 	msg->version = 1;
-	msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
-	msg->outsize = sizeof(*params);
-	msg->insize = sizeof(*resp);
-	params = (struct ec_params_motion_sense *)msg->data;
-	resp = (struct ec_response_motion_sense *)msg->data;
+	msg->insize = sizeof(struct ec_response_motion_sense);
+	msg->outsize = sizeof(struct ec_params_motion_sense);
 
 	for (i = 0; i < sensor_num; i++) {
-		params->cmd = MOTIONSENSE_CMD_INFO;
-		params->info.sensor_num = i;
+		sensorhub->params->cmd = MOTIONSENSE_CMD_INFO;
+		sensorhub->params->info.sensor_num = i;
 
 		ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
 		if (ret < 0) {
@@ -95,7 +84,7 @@ static int cros_ec_sensorhub_register(struct device *dev,
 			continue;
 		}
 
-		switch (resp->info.type) {
+		switch (sensorhub->resp->info.type) {
 		case MOTIONSENSE_TYPE_ACCEL:
 			name = "cros-ec-accel";
 			break;
@@ -118,15 +107,16 @@ static int cros_ec_sensorhub_register(struct device *dev,
 			name = "cros-ec-activity";
 			break;
 		default:
-			dev_warn(dev, "unknown type %d\n", resp->info.type);
+			dev_warn(dev, "unknown type %d\n",
+				 sensorhub->resp->info.type);
 			continue;
 		}
 
 		ret = cros_ec_sensorhub_allocate_sensor(dev, name, i);
 		if (ret)
-			goto error;
+			return ret;
 
-		sensor_type[resp->info.type]++;
+		sensor_type[sensorhub->resp->info.type]++;
 	}
 
 	if (sensor_type[MOTIONSENSE_TYPE_ACCEL] >= 2)
@@ -138,29 +128,41 @@ static int cros_ec_sensorhub_register(struct device *dev,
 							"cros-ec-lid-angle",
 							0);
 		if (ret)
-			goto error;
+			return ret;
 	}
 
-	kfree(msg);
 	return 0;
-
-error:
-	kfree(msg);
-	return ret;
 }
 
 static int cros_ec_sensorhub_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct cros_ec_dev *ec = dev_get_drvdata(dev->parent);
 	struct cros_ec_sensorhub *data;
+	struct cros_ec_command *msg;
 	int ret;
 	int i;
 
+	msg = devm_kzalloc(dev, sizeof(struct cros_ec_command) +
+			   max((u16)sizeof(struct ec_params_motion_sense),
+			       ec->ec_dev->max_response), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
+
 	data = devm_kzalloc(dev, sizeof(struct cros_ec_sensorhub), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	data->ec = dev_get_drvdata(dev->parent);
+	mutex_init(&data->cmd_lock);
+
+	data->dev = dev;
+	data->ec = ec;
+	data->msg = msg;
+	data->params = (struct ec_params_motion_sense *)msg->data;
+	data->resp = (struct ec_response_motion_sense *)msg->data;
+
 	dev_set_drvdata(dev, data);
 
 	/* Check whether this EC is a sensor hub. */
@@ -182,12 +184,63 @@ static int cros_ec_sensorhub_probe(struct platform_device *pdev)
 		}
 	}
 
+	/*
+	 * If the EC does not have a FIFO, the sensors will query their data
+	 * themselves via sysfs or a software trigger.
+	 */
+	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
+		ret = cros_ec_sensorhub_ring_add(data);
+		if (ret)
+			return ret;
+		/*
+		 * The msg and its data is not under the control of the ring
+		 * handler.
+		 */
+		return devm_add_action_or_reset(dev,
+						cros_ec_sensorhub_ring_remove,
+						data);
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+/*
+ * When the EC is suspending, we must stop sending interrupt,
+ * we may use the same interrupt line for waking up the device.
+ * Tell the EC to stop sending non-interrupt event on the iio ring.
+ */
+static int cros_ec_sensorhub_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct cros_ec_sensorhub *sensorhub = platform_get_drvdata(pdev);
+	struct cros_ec_dev *ec = sensorhub->ec;
+
+	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO))
+		return cros_ec_sensorhub_ring_fifo_enable(sensorhub, false);
 	return 0;
 }
 
+static int cros_ec_sensorhub_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct cros_ec_sensorhub *sensorhub = platform_get_drvdata(pdev);
+	struct cros_ec_dev *ec = sensorhub->ec;
+
+	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO))
+		return cros_ec_sensorhub_ring_fifo_enable(sensorhub, true);
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(cros_ec_sensorhub_pm_ops,
+		cros_ec_sensorhub_suspend,
+		cros_ec_sensorhub_resume);
+
 static struct platform_driver cros_ec_sensorhub_driver = {
 	.driver = {
 		.name = DRV_NAME,
+		.pm = &cros_ec_sensorhub_pm_ops,
 	},
 	.probe = cros_ec_sensorhub_probe,
 };
diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
new file mode 100644
index 0000000000000..da73757529ca5
--- /dev/null
+++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
@@ -0,0 +1,439 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for Chrome OS EC Sensor hub FIFO.
+ *
+ * Copyright 2020 Google LLC
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/iio/iio.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_data/cros_ec_commands.h>
+#include <linux/platform_data/cros_ec_proto.h>
+#include <linux/platform_data/cros_ec_sensorhub.h>
+#include <linux/platform_device.h>
+#include <linux/sort.h>
+#include <linux/slab.h>
+
+static inline int
+cros_sensorhub_send_sample(struct cros_ec_sensorhub *sensorhub,
+			   struct cros_ec_sensors_ring_sample *sample)
+{
+	cros_ec_sensorhub_push_data_cb_t cb;
+	int id = sample->sensor_id;
+	struct iio_dev *indio_dev;
+
+	if (id > sensorhub->sensor_num)
+		return -EINVAL;
+
+	cb = sensorhub->push_data[id].push_data_cb;
+	if (!cb)
+		return 0;
+
+	indio_dev = sensorhub->push_data[id].indio_dev;
+
+	if (sample->flag & MOTIONSENSE_SENSOR_FLAG_FLUSH)
+		return 0;
+
+	return cb(indio_dev, sample->vector, sample->timestamp);
+}
+
+/**
+ * cros_ec_sensorhub_register_push_data() - register the callback to the hub.
+ *
+ * @sensorhub : Sensor Hub object
+ * @sensor_num : The sensor the caller is interested in.
+ * @indio_dev : The iio device to use when a sample arrives.
+ * @cb : The callback to call when a sample arrives.
+ *
+ * The callback cb will be used by cros_ec_sensorhub_ring to distribute events
+ * from the EC.
+ *
+ * Return: 0 when callback is registered.
+ *         EINVAL is the sensor number is invalid or the slot already used.
+ */
+int cros_ec_sensorhub_register_push_data(struct cros_ec_sensorhub *sensorhub,
+					 u8 sensor_num,
+					 struct iio_dev *indio_dev,
+					 cros_ec_sensorhub_push_data_cb_t cb)
+{
+	if (sensor_num >= sensorhub->sensor_num)
+		return -EINVAL;
+	if (sensorhub->push_data[sensor_num].indio_dev)
+		return -EINVAL;
+
+	sensorhub->push_data[sensor_num].indio_dev = indio_dev;
+	sensorhub->push_data[sensor_num].push_data_cb = cb;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cros_ec_sensorhub_register_push_data);
+
+void cros_ec_sensorhub_unregister_push_data(struct cros_ec_sensorhub *sensorhub,
+					    u8 sensor_num)
+{
+	sensorhub->push_data[sensor_num].indio_dev = NULL;
+	sensorhub->push_data[sensor_num].push_data_cb = NULL;
+}
+EXPORT_SYMBOL_GPL(cros_ec_sensorhub_unregister_push_data);
+
+/**
+ * cros_ec_sensorhub_ring_fifo_enable() - Enable or disable interrupt generation
+ *					  for FIFO events.
+ * @sensorhub: Sensor Hub object
+ * @on: true when events are requested.
+ *
+ * To be called before sleeping or when noone is listening.
+ * Return: 0 on success, or an error when we can not communicate with the EC.
+ *
+ */
+int cros_ec_sensorhub_ring_fifo_enable(struct cros_ec_sensorhub *sensorhub,
+				       bool on)
+{
+	int ret;
+
+	mutex_lock(&sensorhub->cmd_lock);
+	sensorhub->params->cmd = MOTIONSENSE_CMD_FIFO_INT_ENABLE;
+	sensorhub->params->fifo_int_enable.enable = on;
+
+	sensorhub->msg->outsize = sizeof(struct ec_params_motion_sense);
+	sensorhub->msg->insize = sizeof(struct ec_response_motion_sense);
+
+	ret = cros_ec_cmd_xfer_status(sensorhub->ec->ec_dev, sensorhub->msg);
+	mutex_unlock(&sensorhub->cmd_lock);
+
+	/* We expect to receive a payload of 4 bytes, ignore. */
+	if (ret > 0)
+		ret = 0;
+
+	return ret;
+}
+
+/**
+ * cros_ec_sensor_ring_process_event() - process one EC FIFO event
+ *
+ * @sensorhub: Sensor Hub object.
+ * @fifo_info: FIFO information from the EC (includes b point, EC timebase).
+ * @fifo_timestamp: EC IRQ, kernel timebase (aka c).
+ * @current_timestamp: calculated event timestamp, kernel timebase (aka a').
+ * @in: incoming FIFO event from EC (includes a point, EC timebase).
+ * @out: outgoing event to user space (includes a').
+ *
+ * Process one EC event, add it in the ring if necessary.
+ *
+ * Return: true if out event has been populated.
+ */
+static bool
+cros_ec_sensor_ring_process_event(struct cros_ec_sensorhub *sensorhub,
+				const struct ec_response_motion_sense_fifo_info
+				*fifo_info,
+				const ktime_t fifo_timestamp,
+				ktime_t *current_timestamp,
+				struct ec_response_motion_sensor_data *in,
+				struct cros_ec_sensors_ring_sample *out)
+{
+	const s64 now = cros_ec_get_time_ns();
+	int axis, async_flags;
+
+	/* Do not populate the filter based on asynchronous events. */
+	async_flags = in->flags &
+		(MOTIONSENSE_SENSOR_FLAG_ODR | MOTIONSENSE_SENSOR_FLAG_FLUSH);
+
+	if (in->flags & MOTIONSENSE_SENSOR_FLAG_TIMESTAMP && !async_flags) {
+		s64 new_timestamp;
+
+		/*
+		 * Disable filtering since we might add more jitter
+		 * if b is in a random point in time.
+		 */
+		new_timestamp = fifo_timestamp -
+				fifo_info->timestamp  * 1000 +
+				in->timestamp * 1000;
+
+		/*
+		 * The timestamp can be stale if we had to use the fifo
+		 * info timestamp.
+		 */
+		if (new_timestamp - *current_timestamp > 0)
+			*current_timestamp = new_timestamp;
+	}
+
+	if (in->flags & MOTIONSENSE_SENSOR_FLAG_FLUSH) {
+		out->sensor_id = in->sensor_num;
+		out->timestamp = *current_timestamp;
+		out->flag = in->flags;
+		/*
+		 * No other payload information provided with
+		 * flush ack.
+		 */
+		return true;
+	}
+
+	if (in->flags & MOTIONSENSE_SENSOR_FLAG_TIMESTAMP)
+		/* If we just have a timestamp, skip this entry. */
+		return false;
+
+	/* Regular sample */
+	out->sensor_id = in->sensor_num;
+	if (*current_timestamp - now > 0)
+		/* If the timestamp is in the future. */
+		out->timestamp = now;
+	else
+		out->timestamp = *current_timestamp;
+
+	out->flag = in->flags;
+	for (axis = 0; axis < 3; axis++)
+		out->vector[axis] = in->data[axis];
+
+	return true;
+}
+
+/**
+ * cros_ec_sensorhub_ring_handler() - The trigger handler function
+ *
+ * @sensorhub: Sensor Hub object.
+ *
+ * Called by the notifier, process the EC sensor FIFO queue.
+ */
+static void cros_ec_sensorhub_ring_handler(struct cros_ec_sensorhub *sensorhub)
+{
+	struct ec_response_motion_sense_fifo_info *fifo_info =
+		sensorhub->fifo_info;
+	struct cros_ec_dev *ec = sensorhub->ec;
+	ktime_t fifo_timestamp, current_timestamp;
+	int i, j, number_data, ret;
+	struct ec_response_motion_sensor_data *in;
+	struct cros_ec_sensors_ring_sample *out, *last_out;
+
+	mutex_lock(&sensorhub->cmd_lock);
+
+	/* Get FIFO information if there are lost vectors. */
+	if (fifo_info->total_lost) {
+		int fifo_info_length =
+			sizeof(struct ec_response_motion_sense_fifo_info) +
+			sizeof(u16) * sensorhub->sensor_num;
+
+		/* Need to retrieve the number of lost vectors per sensor */
+		sensorhub->params->cmd = MOTIONSENSE_CMD_FIFO_INFO;
+		sensorhub->msg->outsize = 1;
+		sensorhub->msg->insize = fifo_info_length;
+
+		if (cros_ec_cmd_xfer_status(ec->ec_dev, sensorhub->msg) < 0)
+			goto error;
+
+		memcpy(fifo_info, &sensorhub->resp->fifo_info,
+		       fifo_info_length);
+
+		/*
+		 * Update collection time, will not be as precise as the
+		 * non-error case.
+		 */
+		fifo_timestamp = cros_ec_get_time_ns();
+	} else {
+		fifo_timestamp = sensorhub->fifo_timestamp[
+			CROS_EC_SENSOR_NEW_TS];
+	}
+
+	if (fifo_info->count > sensorhub->fifo_size ||
+	    fifo_info->size != sensorhub->fifo_size) {
+		dev_warn(sensorhub->dev,
+			 "Mismatch EC data: count %d, size %d - expected %d",
+			 fifo_info->count, fifo_info->size,
+			 sensorhub->fifo_size);
+		goto error;
+	}
+
+	/* Copy elements in the main fifo */
+	current_timestamp = sensorhub->fifo_timestamp[CROS_EC_SENSOR_LAST_TS];
+	out = sensorhub->ring;
+	for (i = 0; i < fifo_info->count; i += number_data) {
+		sensorhub->params->cmd = MOTIONSENSE_CMD_FIFO_READ;
+		sensorhub->params->fifo_read.max_data_vector =
+			fifo_info->count - i;
+		sensorhub->msg->outsize =
+			sizeof(struct ec_params_motion_sense);
+		sensorhub->msg->insize =
+			sizeof(sensorhub->resp->fifo_read) +
+			sensorhub->params->fifo_read.max_data_vector *
+			  sizeof(struct ec_response_motion_sensor_data);
+		ret = cros_ec_cmd_xfer_status(ec->ec_dev, sensorhub->msg);
+		if (ret < 0) {
+			dev_warn(sensorhub->dev, "Fifo error: %d\n", ret);
+			break;
+		}
+		number_data = sensorhub->resp->fifo_read.number_data;
+		if (number_data == 0) {
+			dev_dbg(sensorhub->dev, "Unexpected empty FIFO\n");
+			break;
+		}
+		if (number_data > fifo_info->count - i) {
+			dev_warn(sensorhub->dev,
+				 "Invalid EC data: too many entry received: %d, expected %d",
+				 number_data, fifo_info->count - i);
+			break;
+		}
+		if (out + number_data >
+		    sensorhub->ring + fifo_info->count) {
+			dev_warn(sensorhub->dev,
+				 "Too many samples: %d (%zd data) to %d entries for expected %d entries",
+				 i, out - sensorhub->ring, i + number_data,
+				 fifo_info->count);
+			break;
+		}
+
+		for (in = sensorhub->resp->fifo_read.data, j = 0;
+		     j < number_data; j++, in++) {
+			if (cros_ec_sensor_ring_process_event(
+						sensorhub, fifo_info,
+						fifo_timestamp,
+						&current_timestamp,
+						in, out))
+				out++;
+		}
+	}
+	mutex_unlock(&sensorhub->cmd_lock);
+	last_out = out;
+
+	if (out == sensorhub->ring)
+		/* Unexpected empty FIFO. */
+		goto ring_handler_end;
+
+	/*
+	 * Check if current_timestamp is ahead of the last sample.
+	 * Normally, the EC appends a timestamp after the last sample, but if
+	 * the AP is slow to respond to the IRQ, the EC may have added new
+	 * samples. Use the FIFO info timestamp as last timestamp then.
+	 */
+	if ((last_out - 1)->timestamp == current_timestamp)
+		current_timestamp = fifo_timestamp;
+
+	/* Warn on lost samples. */
+	if (fifo_info->total_lost)
+		for (i = 0; i < sensorhub->sensor_num; i++) {
+			if (fifo_info->lost[i])
+				dev_warn_ratelimited(sensorhub->dev,
+						     "Sensor %d: lost: %d out of %d\n",
+						     i, fifo_info->lost[i],
+						     fifo_info->total_lost);
+		}
+
+	/* Push the event into the FIFO. */
+	for (out = sensorhub->ring; out < last_out; out++)
+		cros_sensorhub_send_sample(sensorhub, out);
+
+ring_handler_end:
+	sensorhub->fifo_timestamp[CROS_EC_SENSOR_LAST_TS] = current_timestamp;
+	return;
+
+error:
+	mutex_unlock(&sensorhub->cmd_lock);
+}
+
+static int cros_ec_sensorhub_event(struct notifier_block *nb,
+				   unsigned long queued_during_suspend,
+				   void *_notify)
+{
+	struct cros_ec_sensorhub *sensorhub;
+	struct cros_ec_device *ec_dev;
+
+	sensorhub = container_of(nb, struct cros_ec_sensorhub, notifier);
+	ec_dev = sensorhub->ec->ec_dev;
+
+	if (ec_dev->event_data.event_type != EC_MKBP_EVENT_SENSOR_FIFO)
+		return NOTIFY_DONE;
+
+	if (ec_dev->event_size != sizeof(ec_dev->event_data.data.sensor_fifo)) {
+		dev_warn(ec_dev->dev, "Invalid fifo info size\n");
+		return NOTIFY_DONE;
+	}
+
+	if (queued_during_suspend)
+		return NOTIFY_OK;
+
+	memcpy(sensorhub->fifo_info, &ec_dev->event_data.data.sensor_fifo.info,
+	       sizeof(*sensorhub->fifo_info));
+	sensorhub->fifo_timestamp[CROS_EC_SENSOR_NEW_TS] =
+		ec_dev->last_event_time;
+	cros_ec_sensorhub_ring_handler(sensorhub);
+
+	return NOTIFY_OK;
+}
+
+/**
+ * cros_ec_sensorhub_ring_add() - Add the FIFO functionality if the EC
+ *				  supports it.
+ *
+ * @sensorhub : Sensor Hub object.
+ *
+ * Return: 0 on success.
+ */
+int cros_ec_sensorhub_ring_add(struct cros_ec_sensorhub *sensorhub)
+{
+	struct cros_ec_dev *ec = sensorhub->ec;
+	int ret;
+	int fifo_info_length =
+		sizeof(struct ec_response_motion_sense_fifo_info) +
+		sizeof(u16) * sensorhub->sensor_num;
+
+	/* Allocate the array for lost events. */
+	sensorhub->fifo_info = devm_kzalloc(sensorhub->dev, fifo_info_length,
+					    GFP_KERNEL);
+	if (!sensorhub->fifo_info)
+		return -ENOMEM;
+
+	/* Retrieve FIFO information */
+	sensorhub->msg->version = 2;
+	sensorhub->params->cmd = MOTIONSENSE_CMD_FIFO_INFO;
+	sensorhub->msg->outsize = 1;
+	sensorhub->msg->insize = fifo_info_length;
+
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, sensorhub->msg);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Allocate the full fifo. We need to copy the whole FIFO to set
+	 * timestamps properly.
+	 */
+	sensorhub->fifo_size = sensorhub->resp->fifo_info.size;
+	sensorhub->ring = devm_kcalloc(sensorhub->dev, sensorhub->fifo_size,
+				       sizeof(*sensorhub->ring), GFP_KERNEL);
+	if (!sensorhub->ring)
+		return -ENOMEM;
+
+	/*
+	 * Allocate the callback area based on the number of sensors.
+	 */
+	sensorhub->push_data = devm_kcalloc(
+			sensorhub->dev, sensorhub->sensor_num,
+			sizeof(*sensorhub->push_data),
+			GFP_KERNEL);
+	if (!sensorhub->push_data)
+		return -ENOMEM;
+
+	sensorhub->fifo_timestamp[CROS_EC_SENSOR_LAST_TS] =
+		cros_ec_get_time_ns();
+
+	/* Register the notifier that will act as a top half interrupt. */
+	sensorhub->notifier.notifier_call = cros_ec_sensorhub_event;
+	ret = blocking_notifier_chain_register(&ec->ec_dev->event_notifier,
+					       &sensorhub->notifier);
+	if (ret < 0)
+		return ret;
+
+	/* Start collection samples. */
+	return cros_ec_sensorhub_ring_fifo_enable(sensorhub, true);
+}
+
+void cros_ec_sensorhub_ring_remove(void *arg)
+{
+	struct cros_ec_sensorhub *sensorhub = arg;
+	struct cros_ec_device *ec_dev = sensorhub->ec->ec_dev;
+
+	/* Disable the ring, prevent EC interrupt to the AP for nothing. */
+	cros_ec_sensorhub_ring_fifo_enable(sensorhub, false);
+	blocking_notifier_chain_unregister(&ec_dev->event_notifier,
+					   &sensorhub->notifier);
+}
diff --git a/include/linux/platform_data/cros_ec_sensorhub.h b/include/linux/platform_data/cros_ec_sensorhub.h
index 7e46a47fd642b..b0950814f820e 100644
--- a/include/linux/platform_data/cros_ec_sensorhub.h
+++ b/include/linux/platform_data/cros_ec_sensorhub.h
@@ -8,8 +8,13 @@
 #ifndef __LINUX_PLATFORM_DATA_CROS_EC_SENSORHUB_H
 #define __LINUX_PLATFORM_DATA_CROS_EC_SENSORHUB_H
 
+#include <linux/ktime.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
 #include <linux/platform_data/cros_ec_commands.h>
 
+struct iio_dev;
+
 /**
  * struct cros_ec_sensor_platform - ChromeOS EC sensor platform information.
  * @sensor_num: Id of the sensor, as reported by the EC.
@@ -18,15 +23,86 @@ struct cros_ec_sensor_platform {
 	u8 sensor_num;
 };
 
+/**
+ * typedef cros_ec_sensorhub_push_data_cb_t - Callback function to send datum
+ *					      to specific sensors.
+ *
+ * @indio_dev: The IIO device that will process the sample.
+ * @data: Vector array of the ring sample.
+ * @timestamp: Timestamp in host timespace when the sample was acquired by
+ *             the EC.
+ */
+typedef int (*cros_ec_sensorhub_push_data_cb_t)(struct iio_dev *indio_dev,
+						s16 *data,
+						s64 timestamp);
+
+struct cros_ec_sensorhub_sensor_push_data {
+	struct iio_dev *indio_dev;
+	cros_ec_sensorhub_push_data_cb_t push_data_cb;
+};
+
+enum {
+	CROS_EC_SENSOR_LAST_TS,
+	CROS_EC_SENSOR_NEW_TS,
+	CROS_EC_SENSOR_ALL_TS
+};
+
+struct cros_ec_sensors_ring_sample {
+	u8  sensor_id;
+	u8  flag;
+	s16 vector[3];
+	s64 timestamp;
+} __packed;
+
 /**
  * struct cros_ec_sensorhub - Sensor Hub device data.
  *
+ * @dev: Device object, mostly used for logging.
  * @ec: Embedded Controller where the hub is located.
  * @sensor_num: Number of MEMS sensors present in the EC.
+ * @msg: Structure to send FIFO requests.
+ * @params: Pointer to parameters in msg.
+ * @resp: Pointer to responses in msg.
+ * @cmd_lock : Lock for sending msg.
+ * @notifier: Notifier to kick the FIFO interrupt.
+ * @ring: Preprocessed ring to store events.
+ * @fifo_timestamp: array for event timestamp and spreading.
+ * @fifo_info: copy of FIFO information coming from the EC.
+ * @fifo_size: size of the ring.
+ * @push_data: array of callback to send datums to iio sensor object.
  */
 struct cros_ec_sensorhub {
+	struct device *dev;
 	struct cros_ec_dev *ec;
 	int sensor_num;
+
+	struct cros_ec_command *msg;
+	struct ec_params_motion_sense *params;
+	struct ec_response_motion_sense *resp;
+	struct mutex cmd_lock;  /* Lock for protecting msg structure. */
+
+	struct notifier_block notifier;
+
+	struct cros_ec_sensors_ring_sample *ring;
+
+	ktime_t fifo_timestamp[CROS_EC_SENSOR_ALL_TS];
+	struct ec_response_motion_sense_fifo_info *fifo_info;
+	int fifo_size;
+
+	struct cros_ec_sensorhub_sensor_push_data *push_data;
 };
 
+int cros_ec_sensorhub_register_push_data(struct cros_ec_sensorhub *sensorhub,
+					 u8 sensor_num,
+					 struct iio_dev *indio_dev,
+					 cros_ec_sensorhub_push_data_cb_t cb);
+
+void cros_ec_sensorhub_unregister_push_data(struct cros_ec_sensorhub *sensorhub,
+					    u8 sensor_num);
+
+int cros_ec_sensorhub_ring_add(struct cros_ec_sensorhub *sensorhub);
+void cros_ec_sensorhub_ring_remove(void *arg);
+int cros_ec_sensorhub_ring_fifo_enable(struct cros_ec_sensorhub *sensorhub,
+				       bool on);
+
 #endif   /* __LINUX_PLATFORM_DATA_CROS_EC_SENSORHUB_H */
-- 
2.26.0.rc2.310.g2932bb562d-goog

