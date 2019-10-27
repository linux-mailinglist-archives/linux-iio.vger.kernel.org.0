Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43A75E6A14
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2019 00:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbfJ0XKG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Oct 2019 19:10:06 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44312 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728544AbfJ0XKF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Oct 2019 19:10:05 -0400
Received: by mail-pl1-f196.google.com with SMTP id q16so4265071pll.11
        for <linux-iio@vger.kernel.org>; Sun, 27 Oct 2019 16:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g84IXVkVwvEi7cMxPPZlgHv7M2+Vj9/fFyzME8K9oaY=;
        b=dJ7X//TPUjVdvJ6Ma0Wesm5GON3ox0mRLYBK0x3R1DUySlRVBUXsuAAI+01bDygm48
         rwm/CQE9S8mSLG0SgbJ3nqPcsBHwdaQNunqGd1EMrMkk1LBd0sBxAOKVwjfhHkYmqJpg
         W1ycQ6wwbgYM9BjF5hi8/EYelhlE5Me5ujic8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g84IXVkVwvEi7cMxPPZlgHv7M2+Vj9/fFyzME8K9oaY=;
        b=ieDeDPBIldxKEyNNkrQZ+0z5qHF9NSnoh27uHrFxwe90t9X9C/FO4nerwKIzrcTOvz
         rowk9DNKU2gBLet9OxmohSGhugTNnbFDySpkZb1EOi+YWJd8jvTKYsek0H9K+Stca8id
         P2AE653xobGPxIU+IFAgtn6l7ebMxZOwcxlWq+R5/OiBfxUEAWwwtXfYTXQAjwnzBGMZ
         1qwzPsUbE17B998ThTka/G12gMn82XSdvAcUOtQrbaUxjAHhjfmhj73Fv4mCyppg5rAV
         y9oOGZXK7dqa2ced3N74c4xGPbAPOKom1N2sX0+OD3LHCp3BHgeMevWVxPn9MEyqu7XA
         uqlg==
X-Gm-Message-State: APjAAAUfOb10JFh9fj/cEkLHEBwPf0LlgoGLKBQNMXUEn+szLSQN2fTZ
        2QNApF0xuZvdGgzB6c9yUYLGzw==
X-Google-Smtp-Source: APXvYqza4hLcq5gbW0ua1T4TJS/3/y7r5Zi3K0MdIorXsudr72vdb63AsCORBWWL85OvgMHUbP9Q2Q==
X-Received: by 2002:a17:902:740b:: with SMTP id g11mr16572624pll.10.1572217803838;
        Sun, 27 Oct 2019 16:10:03 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id c8sm7746544pjo.1.2019.10.27.16.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2019 16:10:03 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 10/18] platform: chrome: sensorhub: Add FIFO support
Date:   Sun, 27 Oct 2019 16:09:13 -0700
Message-Id: <20191027230921.205251-11-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
In-Reply-To: <20191027230921.205251-1-gwendal@chromium.org>
References: <20191027230921.205251-1-gwendal@chromium.org>
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

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v3:
- Do not use ret !=
- Simplfy errpr handling by removing a goto
- Fix doxygen comments
- Replace suspend/resume entry points with regular driver entry point;
  There was an issue in the past where the sensor stack was preventing
  device to suspend, but the proper fix has been implemented in cros_ec
  code (6ad16b78a039b "platform/chrome: don't report EC_MKBP_EVENT_SENSOR_FIFO as wakeup") 
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

 drivers/platform/chrome/Makefile              |   3 +-
 drivers/platform/chrome/cros_ec_sensorhub.c   | 115 +++--
 .../platform/chrome/cros_ec_sensorhub_ring.c  | 423 ++++++++++++++++++
 .../linux/platform_data/cros_ec_sensorhub.h   |  80 ++++
 4 files changed, 594 insertions(+), 27 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_ec_sensorhub_ring.c

diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index a164c40dc0996..cb709048c003e 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -17,7 +17,8 @@ obj-$(CONFIG_CROS_EC_PROTO)		+= cros_ec_proto.o cros_ec_trace.o
 obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)	+= cros_kbd_led_backlight.o
 obj-$(CONFIG_CROS_EC_CHARDEV)		+= cros_ec_chardev.o
 obj-$(CONFIG_CROS_EC_LIGHTBAR)		+= cros_ec_lightbar.o
-obj-$(CONFIG_CROS_EC_SENSORHUB)		+= cros_ec_sensorhub.o
+cros_ec_sensorsupport-objs			:= cros_ec_sensorhub_ring.o cros_ec_sensorhub.o
+obj-$(CONFIG_CROS_EC_SENSORHUB)		+= cros_ec_sensorsupport.o
 obj-$(CONFIG_CROS_EC_VBC)		+= cros_ec_vbc.o
 obj-$(CONFIG_CROS_EC_DEBUGFS)		+= cros_ec_debugfs.o
 obj-$(CONFIG_CROS_EC_SYSFS)		+= cros_ec_sysfs.o
diff --git a/drivers/platform/chrome/cros_ec_sensorhub.c b/drivers/platform/chrome/cros_ec_sensorhub.c
index 7cb316135f4c0..d5290a41a01f7 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub.c
@@ -62,14 +62,13 @@ static int cros_ec_sensorhub_allocate_single_sensor(
 }
 
 static int cros_ec_sensorhub_register(struct device *dev,
-		struct cros_ec_dev *ec)
+		struct cros_ec_sensorhub *sensorhub)
 {
 	int ret, i, id, sensor_num;
 	int sensor_type[MOTIONSENSE_TYPE_MAX] = { 0 };
-	struct ec_params_motion_sense *params;
-	struct ec_response_motion_sense *resp;
-	struct cros_ec_command *msg;
 	char *name;
+	struct cros_ec_command *msg = sensorhub->msg;
+	struct cros_ec_dev *ec = sensorhub->ec;
 
 	sensor_num = cros_ec_get_sensor_count(ec);
 	if (sensor_num < 0) {
@@ -84,30 +83,21 @@ static int cros_ec_sensorhub_register(struct device *dev,
 		return -EINVAL;
 	}
 
-	/* Prepare a message to send INFO command to each sensor. */
-	msg = kzalloc(sizeof(struct cros_ec_command) +
-		      max(sizeof(*params), sizeof(*resp)), GFP_KERNEL);
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
 
 	id = 0;
 	for (i = 0; i < sensor_num; i++) {
-		params->cmd = MOTIONSENSE_CMD_INFO;
-		params->info.sensor_num = i;
+		sensorhub->params->cmd = MOTIONSENSE_CMD_INFO;
+		sensorhub->params->info.sensor_num = i;
 		ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
 		if (ret < 0) {
 			dev_warn(dev, "no info for EC sensor %d : %d/%d\n",
 				 i, ret, msg->result);
 			continue;
 		}
-		switch (resp->info.type) {
+		switch (sensorhub->resp->info.type) {
 		case MOTIONSENSE_TYPE_ACCEL:
 			name = "cros-ec-accel";
 			break;
@@ -130,14 +120,15 @@ static int cros_ec_sensorhub_register(struct device *dev,
 			name = "cros-ec-activity";
 			break;
 		default:
-			dev_warn(dev, "unknown type %d\n", resp->info.type);
+			dev_warn(dev, "unknown type %d\n",
+				 sensorhub->resp->info.type);
 			continue;
 		}
 		ret = cros_ec_sensorhub_allocate_single_sensor(dev, name, i);
 		if (ret)
-			goto error;
+			return ret;
 
-		sensor_type[resp->info.type]++;
+		sensor_type[sensorhub->resp->info.type]++;
 	}
 
 	if (sensor_type[MOTIONSENSE_TYPE_ACCEL] >= 2)
@@ -149,8 +140,6 @@ static int cros_ec_sensorhub_register(struct device *dev,
 				dev, "cros-ec-lid-angle", 0);
 	}
 
-error:
-	kfree(msg);
 	return ret;
 }
 
@@ -159,18 +148,34 @@ static int cros_ec_sensorhub_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct cros_ec_dev *ec = dev_get_drvdata(dev->parent);
 	int ret, i;
-	struct cros_ec_sensorhub *data =
-		kzalloc(sizeof(struct cros_ec_sensorhub), GFP_KERNEL);
+	struct cros_ec_sensorhub *data;
+	struct cros_ec_command *msg;
+
+	msg = devm_kzalloc(dev, sizeof(struct cros_ec_command) +
+			max((u16)sizeof(struct ec_params_motion_sense),
+			    ec->ec_dev->max_response), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
 
+	msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
+
+	data = devm_kzalloc(dev, sizeof(struct cros_ec_sensorhub), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
+	data->dev = dev;
 	data->ec = ec;
+
+	mutex_init(&data->cmd_lock);
+	data->msg = msg;
+	data->params = (struct ec_params_motion_sense *)msg->data;
+	data->resp = (struct ec_response_motion_sense *)msg->data;
+
 	dev_set_drvdata(dev, data);
 
 	/* Check whether this EC is a sensor hub. */
 	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE)) {
-		ret = cros_ec_sensorhub_register(dev, ec);
+		ret = cros_ec_sensorhub_register(dev, data);
 		if (ret) {
 			dev_err(dev, "Register failed %d\n", ret);
 			return ret;
@@ -190,14 +195,72 @@ static int cros_ec_sensorhub_probe(struct platform_device *pdev)
 		}
 	}
 
+	/*
+	 * If the EC does not have a FIFO, the sensors will query their data
+	 * themselves via sysfs or a software trigger.
+	 */
+	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
+		return cros_ec_sensorhub_ring_add(data);
+		/*
+		 * The msg and its data is not under the control of the ring
+		 * handler.
+		 */
+	}
+
 	return 0;
 }
 
+static int cros_ec_sensorhub_remove(struct platform_device *pdev)
+{
+	struct cros_ec_sensorhub *sensorhub = platform_get_drvdata(pdev);
+	struct cros_ec_dev *ec = sensorhub->ec;
+
+	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO))
+		cros_ec_sensorhub_ring_remove(sensorhub);
+	return 0;
+}
+
+#if CONFIG_PM_SLEEP
+/*
+ * When the EC is suspending, we must stop sending interrupt,
+ * we may use the same interrupt line for waking up the device.
+ * Tell the EC to stop sending non-interrupt event on the iio ring.
+ */
+static int cros_ec_ring_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct cros_ec_sensorhub *sensorhub = platform_get_drvdata(pdev);
+	struct cros_ec_dev *ec = sensorhub->ec;
+
+	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO))
+		return cros_ec_sensorhub_ring_fifo_enable(sensorhub, false);
+	return 0;
+}
+
+static int cros_ec_ring_resume(struct device *dev)
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
+static SIMPLE_DEV_PM_OPS(cros_ec_sensorhub_ring_pm_ops,
+		cros_ec_ring_suspend,
+		cros_ec_ring_resume);
+
+
 static struct platform_driver cros_ec_sensorhub_driver = {
 	.driver = {
 		.name = DRV_NAME,
+		.pm = &cros_ec_sensorhub_ring_pm_ops,
 	},
 	.probe = cros_ec_sensorhub_probe,
+	.remove = cros_ec_sensorhub_remove,
 };
 
 module_platform_driver(cros_ec_sensorhub_driver);
diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
new file mode 100644
index 0000000000000..d77e71303d80e
--- /dev/null
+++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
@@ -0,0 +1,423 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * cros_ec_sensorhub_ring - Driver for Chrome OS EC Sensor hub FIFO.
+ *
+ * Copyright 2019 Google LLC
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/iio/iio.h>
+#include <linux/kernel.h>
+#include <linux/mfd/cros_ec.h>
+#include <linux/module.h>
+#include <linux/platform_data/cros_ec_commands.h>
+#include <linux/platform_data/cros_ec_proto.h>
+#include <linux/platform_data/cros_ec_sensorhub.h>
+#include <linux/platform_device.h>
+#include <linux/sort.h>
+#include <linux/slab.h>
+
+static inline int cros_sensorhub_send_sample(
+		struct cros_ec_sensorhub *sensorhub,
+		struct cros_ec_sensors_ring_sample *sample)
+{
+	int id = sample->sensor_id;
+	cros_ec_sensorhub_push_data_cb_t cb;
+	struct iio_dev *indio_dev;
+
+	if (id > CROS_EC_SENSOR_MAX)
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
+ * cros_ec_sensorhub_register_push_data - register the callback to the hub.
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
+ */
+int cros_ec_sensorhub_register_push_data(
+		struct cros_ec_sensorhub *sensorhub,
+		u8 sensor_num,
+		struct iio_dev *indio_dev,
+		cros_ec_sensorhub_push_data_cb_t cb)
+{
+	if (sensor_num > CROS_EC_SENSOR_MAX)
+		return -EINVAL;
+	if (sensorhub->push_data[sensor_num].indio_dev != NULL)
+		return -EINVAL;
+
+	sensorhub->push_data[sensor_num].indio_dev = indio_dev;
+	sensorhub->push_data[sensor_num].push_data_cb = cb;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cros_ec_sensorhub_register_push_data);
+
+void cros_ec_sensorhub_unregister_push_data(
+		struct cros_ec_sensorhub *sensorhub,
+		u8 sensor_num)
+{
+	sensorhub->push_data[sensor_num].indio_dev = NULL;
+	sensorhub->push_data[sensor_num].push_data_cb = NULL;
+}
+EXPORT_SYMBOL_GPL(cros_ec_sensorhub_unregister_push_data);
+
+/**
+ * cros_ec_sensorhub_ring_fifo_enable - Enable or disable interrupt generation
+ *  for FIFO events.
+ * @sensorhub : Sensor Hub object
+ * @on : true when events are requested.
+ *
+ * To be called before sleeping or when noone is listening.
+ * Return: 0 on success.
+ */
+int cros_ec_sensorhub_ring_fifo_enable(
+		struct cros_ec_sensorhub *sensorhub,
+		bool on)
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
+ * cros_ec_ring_process_event - process one EC FIFO event
+ *
+ * @sensorhub: Sensorhub object.
+ * @fifo_info: fifo information from the EC (includes b point, EC timebase).
+ * @fifo_timestamp: EC IRQ, kernel timebase (aka c)
+ * @current_timestamp: calculated event timestamp, kernel timebase (aka a')
+ * @in: incoming FIFO event from EC (includes a point, EC timebase)
+ * @out: outgoing event to user space (includes a')
+ *
+ * Process one EC event, add it in the ring if necessary.
+ *
+ * Return: true if out event has been populated.
+ */
+static bool cros_ec_ring_process_event(
+				struct cros_ec_sensorhub *sensorhub,
+				const struct cros_ec_fifo_info *fifo_info,
+				const ktime_t fifo_timestamp,
+				ktime_t *current_timestamp,
+				struct ec_response_motion_sensor_data *in,
+				struct cros_ec_sensors_ring_sample *out)
+{
+	int axis;
+	/* Do not populate the filter based on asynchronous events. */
+	const int async_flags = in->flags &
+		(MOTIONSENSE_SENSOR_FLAG_ODR | MOTIONSENSE_SENSOR_FLAG_FLUSH);
+	const s64 now = cros_ec_get_time_ns();
+
+	if (in->flags & MOTIONSENSE_SENSOR_FLAG_TIMESTAMP && !async_flags) {
+		s64 a = in->timestamp;
+		s64 b = fifo_info->info.timestamp;
+		s64 c = fifo_timestamp;
+		s64 new_timestamp;
+
+		/*
+		 * disable filtering since we might add more jitter
+		 * if b is in a random point in time
+		 */
+		new_timestamp = c - b * 1000 + a * 1000;
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
+	if (in->flags & MOTIONSENSE_SENSOR_FLAG_TIMESTAMP)
+		/* If we just have a timestamp, skip this entry. */
+		return false;
+
+	/* Regular sample */
+	out->sensor_id = in->sensor_num;
+	if (*current_timestamp - now > 0) {
+		/* If the timestamp is in the future. */
+		out->timestamp = now;
+	} else {
+		out->timestamp = *current_timestamp;
+	}
+
+	out->flag = in->flags;
+	for (axis = 0; axis < 3; axis++)
+		out->vector[axis] = in->data[axis];
+
+	return true;
+}
+
+/*
+ * cros_ec_sensorhub_ring_handler - the trigger handler function
+ *
+ * @sensorhub: device information.
+ *
+ * Called by the notifier, process the EC sensor FIFO queue.
+ */
+static void cros_ec_sensorhub_ring_handler(struct cros_ec_sensorhub *sensorhub)
+{
+	struct cros_ec_fifo_info *fifo_info = &sensorhub->fifo_info;
+	struct cros_ec_dev *ec = sensorhub->ec;
+	ktime_t fifo_timestamp, current_timestamp;
+	int i, j, number_data, ret;
+	unsigned long sensor_mask = 0;
+	struct ec_response_motion_sensor_data *in;
+	struct cros_ec_sensors_ring_sample *out, *last_out;
+
+	mutex_lock(&sensorhub->cmd_lock);
+
+	/* Get FIFO information if there are lost vectors. */
+	if (fifo_info->info.total_lost) {
+		/* Need to retrieve the number of lost vectors per sensor */
+		sensorhub->params->cmd = MOTIONSENSE_CMD_FIFO_INFO;
+		sensorhub->msg->outsize = 1;
+		sensorhub->msg->insize =
+			sizeof(struct ec_response_motion_sense_fifo_info) +
+			sizeof(u16) * CROS_EC_SENSOR_MAX;
+
+		if (cros_ec_cmd_xfer_status(ec->ec_dev, sensorhub->msg) < 0) {
+			mutex_unlock(&sensorhub->cmd_lock);
+			return;
+		}
+		memcpy(fifo_info, &sensorhub->resp->fifo_info,
+		       sizeof(*fifo_info));
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
+	if (fifo_info->info.count > sensorhub->fifo_size ||
+	    fifo_info->info.size != sensorhub->fifo_size) {
+		dev_warn(sensorhub->dev,
+			 "Mismatch EC data: count %d, size %d - expected %d",
+			 fifo_info->info.count, fifo_info->info.size,
+			 sensorhub->fifo_size);
+		mutex_unlock(&sensorhub->cmd_lock);
+		return;
+	}
+
+
+	/* Copy elements in the main fifo */
+	current_timestamp = sensorhub->fifo_timestamp[CROS_EC_SENSOR_LAST_TS];
+	out = sensorhub->ring;
+	for (i = 0; i < fifo_info->info.count; i += number_data) {
+		sensorhub->params->cmd = MOTIONSENSE_CMD_FIFO_READ;
+		sensorhub->params->fifo_read.max_data_vector =
+			fifo_info->info.count - i;
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
+		if (number_data > fifo_info->info.count - i) {
+			dev_warn(sensorhub->dev,
+				 "Invalid EC data: too many entry received: %d, expected %d",
+				 number_data, fifo_info->info.count - i);
+			break;
+		}
+		if (out + number_data >
+		    sensorhub->ring + fifo_info->info.count) {
+			dev_warn(sensorhub->dev,
+				 "Too many samples: %d (%zd data) to %d entries for expected %d entries",
+				 i, out - sensorhub->ring, i + number_data,
+				 fifo_info->info.count);
+			break;
+		}
+
+		for (in = sensorhub->resp->fifo_read.data, j = 0;
+		     j < number_data; j++, in++) {
+			if (cros_ec_ring_process_event(
+					sensorhub, fifo_info, fifo_timestamp,
+					&current_timestamp, in, out)) {
+				sensor_mask |= (1 << in->sensor_num);
+				out++;
+			}
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
+	if ((last_out-1)->timestamp == current_timestamp)
+		current_timestamp = fifo_timestamp;
+
+	/* Warn on lost samples. */
+	for_each_set_bit(i, &sensor_mask, BITS_PER_LONG) {
+		if (fifo_info->info.total_lost) {
+			int lost = fifo_info->lost[i];
+
+			if (lost) {
+				dev_warn_ratelimited(sensorhub->dev,
+					"Sensor %d: lost: %d out of %d\n", i,
+					lost, fifo_info->info.total_lost);
+			}
+		}
+	}
+
+	/* push the event into the kfifo */
+	for (out = sensorhub->ring; out < last_out; out++)
+		cros_sensorhub_send_sample(sensorhub, out);
+
+ring_handler_end:
+	sensorhub->fifo_timestamp[CROS_EC_SENSOR_LAST_TS] = current_timestamp;
+}
+
+static int cros_ec_sensorhub_event(struct notifier_block *nb,
+	unsigned long queued_during_suspend, void *_notify)
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
+	sensorhub->fifo_info.info = ec_dev->event_data.data.sensor_fifo.info;
+	sensorhub->fifo_timestamp[CROS_EC_SENSOR_NEW_TS] =
+		ec_dev->last_event_time;
+	cros_ec_sensorhub_ring_handler(sensorhub);
+
+	return NOTIFY_OK;
+}
+
+/**
+ * cros_ec_sensorhub_ring_add - Add/Remove the fifo functionality if the EC
+ *  supports it.
+ *
+ * @sensorhub : Sensor Hub object
+ *
+ * Return: 0 on success.
+ */
+int cros_ec_sensorhub_ring_add(struct cros_ec_sensorhub *sensorhub)
+{
+	struct cros_ec_dev *ec = sensorhub->ec;
+	int ret;
+
+	/* Retrieve FIFO information */
+	sensorhub->msg->version = 2;
+	sensorhub->params->cmd = MOTIONSENSE_CMD_FIFO_INFO;
+	sensorhub->msg->outsize = 1;
+	sensorhub->msg->insize =
+		sizeof(struct ec_response_motion_sense_fifo_info) +
+		sizeof(u16) * CROS_EC_SENSOR_MAX;
+
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, sensorhub->msg);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Allocate the full fifo.
+	 * We need to copy the whole FIFO to set timestamps properly *
+	 */
+	sensorhub->fifo_size = sensorhub->resp->fifo_info.size;
+	sensorhub->ring = devm_kcalloc(sensorhub->dev, sensorhub->fifo_size,
+			sizeof(*sensorhub->ring), GFP_KERNEL);
+	if (!sensorhub->ring)
+		return -ENOMEM;
+
+	sensorhub->fifo_timestamp[CROS_EC_SENSOR_LAST_TS] =
+		cros_ec_get_time_ns();
+
+	/* register the notifier that will act as a top half interrupt. */
+	sensorhub->notifier.notifier_call = cros_ec_sensorhub_event;
+	ret = blocking_notifier_chain_register(&ec->ec_dev->event_notifier,
+					       &sensorhub->notifier);
+	if (ret < 0) {
+		dev_warn(sensorhub->dev, "failed to register notifier\n");
+		return ret;
+	}
+
+	/* Start collection samples. */
+	return cros_ec_sensorhub_ring_fifo_enable(sensorhub, true);
+}
+
+int cros_ec_sensorhub_ring_remove(struct cros_ec_sensorhub *sensorhub)
+{
+	struct cros_ec_device *ec_dev = sensorhub->ec->ec_dev;
+
+	/* Disable the ring, prevent EC interrupt to the AP for nothing. */
+	cros_ec_sensorhub_ring_fifo_enable(sensorhub, false);
+	blocking_notifier_chain_unregister(&ec_dev->event_notifier,
+					   &sensorhub->notifier);
+
+	return 0;
+}
diff --git a/include/linux/platform_data/cros_ec_sensorhub.h b/include/linux/platform_data/cros_ec_sensorhub.h
index c18fba660bb62..35b4414756788 100644
--- a/include/linux/platform_data/cros_ec_sensorhub.h
+++ b/include/linux/platform_data/cros_ec_sensorhub.h
@@ -18,12 +18,92 @@ struct cros_ec_sensor_platform {
 	u8 sensor_num;
 };
 
+struct iio_dev;
+
+/**
+ * typedef cros_ec_sensorhub_push_data_cb_t - Callback function to send datum
+ *     to specific sensors
+ *
+ * @indio_dev: The IIO device that will process the sample.
+ * @data: vector array of the ring sample.
+ * @timestamp: Timestamp in host timespace when the sample was acquired by
+ *             the EC.
+ */
+typedef int (*cros_ec_sensorhub_push_data_cb_t)(
+		struct iio_dev *indio_dev,
+		s16 *data,
+		s64 timestamp);
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
+#define CROS_EC_SENSOR_MAX 16
+
+struct __ec_todo_packed cros_ec_fifo_info {
+	struct ec_response_motion_sense_fifo_info info;
+	uint16_t lost[CROS_EC_SENSOR_MAX];
+};
+
+struct cros_ec_sensors_ring_sample {
+	uint8_t sensor_id;
+	uint8_t flag;
+	int16_t  vector[3];
+	s64      timestamp;
+} __packed;
+
 /*
  * struct cros_ec_sensorhub - Sensor Hub device data.
  */
 struct cros_ec_sensorhub {
+	/* Device object, mostly used for logging. */
+	struct device *dev;
+
 	/* Embedded Controller where the hub is located. */
 	struct cros_ec_dev *ec;
+
+	/* Structure to send FIFO requests. */
+	struct cros_ec_command *msg;
+	struct ec_params_motion_sense *params;
+	struct ec_response_motion_sense *resp;
+	struct mutex cmd_lock;
+
+	/* Notifier to kick the FIFO interrupt */
+	struct notifier_block notifier;
+
+	/* Preprocessed ring to send to kfifos */
+	struct cros_ec_sensors_ring_sample *ring;
+
+	ktime_t fifo_timestamp[CROS_EC_SENSOR_ALL_TS];
+	struct cros_ec_fifo_info fifo_info;
+	int    fifo_size;
+
+	/*
+	 * Dynamic array to be able to spread datum to iio sensor objects.
+	 */
+	struct cros_ec_sensorhub_sensor_push_data push_data[CROS_EC_SENSOR_MAX];
 };
 
+int cros_ec_sensorhub_register_push_data(
+		struct cros_ec_sensorhub *sensor_hub,
+		u8 sensor_num,
+		struct iio_dev *indio_dev,
+		cros_ec_sensorhub_push_data_cb_t cb);
+void cros_ec_sensorhub_unregister_push_data(
+		struct cros_ec_sensorhub *sensor_hub,
+		u8 sensor_num);
+
+int cros_ec_sensorhub_ring_add(struct cros_ec_sensorhub *sensor_hub);
+int cros_ec_sensorhub_ring_remove(struct cros_ec_sensorhub *sensor_hub);
+int cros_ec_sensorhub_ring_fifo_enable(
+		struct cros_ec_sensorhub *sensorhub,
+		bool on);
+
 #endif   /* __LINUX_PLATFORM_DATA_CROS_EC_SENSORHUB_H */
-- 
2.23.0.866.gb869b98d4c-goog

