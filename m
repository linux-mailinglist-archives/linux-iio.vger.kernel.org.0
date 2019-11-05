Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46CDDF094F
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2019 23:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbfKEW1E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Nov 2019 17:27:04 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35625 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387453AbfKEW1D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Nov 2019 17:27:03 -0500
Received: by mail-pg1-f196.google.com with SMTP id q22so7964629pgk.2
        for <linux-iio@vger.kernel.org>; Tue, 05 Nov 2019 14:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ciXtoXWNpHZ542H8FN2q32b9gqkzRvSlBLKtMJ5nImI=;
        b=MWO0iaL5zJrwfWES+eDDiOHRyYa3iUImldx4CqCod6kh1bMMxpFV0HbMuI4Rtl89Ot
         A+qWcqUE397ITMJv3LP48CmoGTFlW1xm0xqbgwi6Ku+14Dj3GhHSWH2VJVXGH3vSZYGL
         M+3RkZ0QsgJsWnuXwU8m60L9pgih9czEMVXtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ciXtoXWNpHZ542H8FN2q32b9gqkzRvSlBLKtMJ5nImI=;
        b=F3xFLculyBCebM2pCBUIGFKdcVaOtSAzApngBBzpWPX97aFMdgy+V9uObsLR6VKmZ+
         L2amXa0+3kOI3plRUMkVsNUGty+cBjNxXQpCwuxElPLAUOpdliEVeXTvwgzwpU0EOAtQ
         ne9cvSBvcGhYUX4l72l38vE6D6UZ4Vu3k3occG1lEVBTnbgRJ/rNb3zeF37pLUOzzy5d
         ZV7c4qXmdZWgs5LnE/+K9pCcJhvQ9TJxiPMmNRAlbzpR8HTZUd0el/TpxEWEGJPKCGfG
         WgG5Cjw3s3s79hxFijFGzMRzk/85jDufwQMpBEZauXP9af7iCcVSlRKkv9hBZGGjV1VX
         kd2w==
X-Gm-Message-State: APjAAAWG+xT0IDHwV0tXRtmTbr6xkPYn/kLLElVye8BTrymAwjV+2Ut6
        PTvH3xUyURGQT9MDdD99mRNvaA==
X-Google-Smtp-Source: APXvYqypJ6XwKo8OcKyN6bhz1q9ifDOhy8VYX60UNo5HCNbkr2dpimNq9JiaTcmTOBExRkTqo0Qm0A==
X-Received: by 2002:aa7:96ef:: with SMTP id i15mr39619299pfq.242.1572992822022;
        Tue, 05 Nov 2019 14:27:02 -0800 (PST)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id l24sm20045924pff.151.2019.11.05.14.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 14:27:01 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 02/17] platform: cros_ec: Add cros_ec_sensor_hub driver
Date:   Tue,  5 Nov 2019 14:26:37 -0800
Message-Id: <20191105222652.70226-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191105222652.70226-1-gwendal@chromium.org>
References: <20191105222652.70226-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Similar to HID sensor stack, the new driver sits between cros_ec_dev
and the iio device drivers:

EC based iio device topology would be:
iio:device1 ->
...0/0000:00:1f.0/PNP0C09:00/GOOG0004:00/cros-ec-dev.6.auto/
                                         cros-ec-sensorhub.7.auto/
                                         cros-ec-accel.15.auto/
                                         iio:device1

It will be expanded to control EC sensor FIFO.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v4:
- Use platform_device_register_data in children registration.
- Free registered pdev children at remove time.
- Remove useless includes
- Check patch with --strict option
    Use sizeof(*obj) instead of sizeof(struct ...obj)
    Alignement
- Describe cros_ec_sensorhub in kernel-doc format.
Changes in v3:
- Fix doxygen comments
- Fix use of ret |=
- Remove unncessary goto.
Changes in v2:
- Remove unerelated changes.
- Fix spelling.
- Use !x instead of x == NULL
- Use platform_ API directly to register IIO sensors from
  cros_ec_sensorhub.

 drivers/iio/common/cros_ec_sensors/Kconfig    |   2 +-
 drivers/platform/chrome/Kconfig               |  12 +
 drivers/platform/chrome/Makefile              |   1 +
 drivers/platform/chrome/cros_ec_sensorhub.c   | 223 ++++++++++++++++++
 .../linux/platform_data/cros_ec_sensorhub.h   |  33 +++
 5 files changed, 270 insertions(+), 1 deletion(-)
 create mode 100644 drivers/platform/chrome/cros_ec_sensorhub.c
 create mode 100644 include/linux/platform_data/cros_ec_sensorhub.h

diff --git a/drivers/iio/common/cros_ec_sensors/Kconfig b/drivers/iio/common/cros_ec_sensors/Kconfig
index cdbb29cfb907..fefad9572790 100644
--- a/drivers/iio/common/cros_ec_sensors/Kconfig
+++ b/drivers/iio/common/cros_ec_sensors/Kconfig
@@ -4,7 +4,7 @@
 #
 config IIO_CROS_EC_SENSORS_CORE
 	tristate "ChromeOS EC Sensors Core"
-	depends on SYSFS && CROS_EC
+	depends on SYSFS && CROS_EC_SENSORHUB
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index ee5f08ea57b6..56a25317a6be 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -190,6 +190,18 @@ config CROS_EC_DEBUGFS
 	  To compile this driver as a module, choose M here: the
 	  module will be called cros_ec_debugfs.
 
+config CROS_EC_SENSORHUB
+	tristate "ChromeOS EC MEMS Sensor Hub"
+	depends on CROS_EC && IIO
+	help
+	  Allow loading IIO sensors. This driver is loaded by MFD and will in
+	  turn query the EC and register the sensors.
+	  It also spreads the sensor data coming from the EC to the IIO sensor
+	  object.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cros_ec_sensorhub.
+
 config CROS_EC_SYSFS
 	tristate "ChromeOS EC control and information through sysfs"
 	depends on MFD_CROS_EC_DEV && SYSFS
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index 477ec3d1d1c9..a164c40dc099 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_CROS_EC_PROTO)		+= cros_ec_proto.o cros_ec_trace.o
 obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)	+= cros_kbd_led_backlight.o
 obj-$(CONFIG_CROS_EC_CHARDEV)		+= cros_ec_chardev.o
 obj-$(CONFIG_CROS_EC_LIGHTBAR)		+= cros_ec_lightbar.o
+obj-$(CONFIG_CROS_EC_SENSORHUB)		+= cros_ec_sensorhub.o
 obj-$(CONFIG_CROS_EC_VBC)		+= cros_ec_vbc.o
 obj-$(CONFIG_CROS_EC_DEBUGFS)		+= cros_ec_debugfs.o
 obj-$(CONFIG_CROS_EC_SYSFS)		+= cros_ec_sysfs.o
diff --git a/drivers/platform/chrome/cros_ec_sensorhub.c b/drivers/platform/chrome/cros_ec_sensorhub.c
new file mode 100644
index 000000000000..6a0aa84cf092
--- /dev/null
+++ b/drivers/platform/chrome/cros_ec_sensorhub.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SensorHub: driver that discover sensors behind
+ * a ChromeOS Embedded controller.
+ *
+ * Copyright 2019 Google LLC
+ */
+
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/mfd/cros_ec.h>
+#include <linux/platform_data/cros_ec_commands.h>
+#include <linux/platform_data/cros_ec_proto.h>
+#include <linux/platform_data/cros_ec_sensorhub.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define DRV_NAME		"cros-ec-sensorhub"
+
+static struct platform_device *cros_ec_sensorhub_allocate_single_sensor(
+		struct device *parent,
+		char *sensor_name,
+		int sensor_num)
+{
+	struct cros_ec_sensor_platform sensor_platforms = {
+		.sensor_num = sensor_num,
+	};
+
+	return platform_device_register_data(parent, sensor_name,
+				PLATFORM_DEVID_AUTO,
+				&sensor_platforms,
+				sizeof(sensor_platforms));
+}
+
+static int cros_ec_sensorhub_register(struct device *dev,
+				      struct cros_ec_sensorhub *sensorhub)
+{
+	int ret, i, id, sensor_num;
+	struct cros_ec_dev *ec = sensorhub->ec;
+	int sensor_type[MOTIONSENSE_TYPE_MAX] = { 0 };
+	struct ec_params_motion_sense *params;
+	struct ec_response_motion_sense *resp;
+	struct cros_ec_command *msg;
+	struct platform_device *pdev;
+	char *name;
+
+	sensor_num = cros_ec_get_sensor_count(ec);
+	if (sensor_num < 0) {
+		dev_err(dev,
+			"Unable to retrieve sensor information (err:%d)\n",
+			sensor_num);
+		return sensor_num;
+	}
+
+	if (sensor_num == 0) {
+		dev_err(dev, "Zero sensors reported.\n");
+		return -EINVAL;
+	}
+
+	/* Prepare a message to send INFO command to each sensor. */
+	msg = kzalloc(sizeof(*msg) + max(sizeof(*params), sizeof(*resp)),
+		      GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->version = 1;
+	msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
+	msg->outsize = sizeof(*params);
+	msg->insize = sizeof(*resp);
+	params = (struct ec_params_motion_sense *)msg->data;
+	resp = (struct ec_response_motion_sense *)msg->data;
+
+	id = 0;
+	for (i = 0; i < sensor_num; i++) {
+		params->cmd = MOTIONSENSE_CMD_INFO;
+		params->info.sensor_num = i;
+		ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+		if (ret < 0) {
+			dev_warn(dev, "no info for EC sensor %d : %d/%d\n",
+				 i, ret, msg->result);
+			continue;
+		}
+		switch (resp->info.type) {
+		case MOTIONSENSE_TYPE_ACCEL:
+			name = "cros-ec-accel";
+			break;
+		case MOTIONSENSE_TYPE_BARO:
+			name = "cros-ec-baro";
+			break;
+		case MOTIONSENSE_TYPE_GYRO:
+			name = "cros-ec-gyro";
+			break;
+		case MOTIONSENSE_TYPE_MAG:
+			name = "cros-ec-mag";
+			break;
+		case MOTIONSENSE_TYPE_PROX:
+			name = "cros-ec-prox";
+			break;
+		case MOTIONSENSE_TYPE_LIGHT:
+			name = "cros-ec-light";
+			break;
+		case MOTIONSENSE_TYPE_ACTIVITY:
+			name = "cros-ec-activity";
+			break;
+		default:
+			dev_warn(dev, "unknown type %d\n", resp->info.type);
+			continue;
+		}
+		pdev = cros_ec_sensorhub_allocate_single_sensor(dev, name, i);
+		if (IS_ERR(pdev)) {
+			ret = IS_ERR(pdev);
+			goto error;
+		}
+		sensorhub->sensor_pdev[id++] = pdev;
+		sensor_type[resp->info.type]++;
+	}
+
+	if (sensor_type[MOTIONSENSE_TYPE_ACCEL] >= 2)
+		ec->has_kb_wake_angle = true;
+
+	if (cros_ec_check_features(ec,
+				   EC_FEATURE_REFINED_TABLET_MODE_HYSTERESIS)) {
+		pdev = cros_ec_sensorhub_allocate_single_sensor(dev,
+							"cros-ec-lid-angle", 0);
+		if (IS_ERR(pdev)) {
+			ret = IS_ERR(pdev);
+			goto error;
+		}
+		sensorhub->sensor_pdev[id++] = pdev;
+	}
+
+error:
+	kfree(msg);
+	return ret;
+}
+
+static int cros_ec_sensorhub_probe(struct platform_device *sensorhub_pdev)
+{
+	struct device *dev = &sensorhub_pdev->dev;
+	struct cros_ec_dev *ec = dev_get_drvdata(dev->parent);
+	int ret, i;
+	struct platform_device *pdev;
+	struct cros_ec_sensorhub *data =
+		kzalloc(sizeof(struct cros_ec_sensorhub), GFP_KERNEL);
+
+	if (!data)
+		return -ENOMEM;
+
+	data->ec = ec;
+	dev_set_drvdata(dev, data);
+
+	/* Check whether this EC is a sensor hub. */
+	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE)) {
+		ret = cros_ec_sensorhub_register(dev, data);
+		if (ret) {
+			dev_err(dev, "Register failed %d\n", ret);
+			goto unregister_sensors;
+		}
+	} else {
+		/*
+		 * If the device has sensors but does not claim to
+		 * be a sensor hub, we are in legacy mode.
+		 */
+		for (i = 0; i < 2; i++) {
+			pdev = cros_ec_sensorhub_allocate_single_sensor(dev,
+						"cros-ec-accel-legacy", i);
+			if (IS_ERR(pdev)) {
+				ret = IS_ERR(pdev);
+				dev_err(dev, "Legacy %d failed %d\n", i, ret);
+				goto unregister_sensors;
+			} else {
+				data->sensor_pdev[i] = pdev;
+			}
+		}
+	}
+
+	return 0;
+
+unregister_sensors:
+	/*
+	 * Given the probe has failed, we need to unregister all the sensors,
+	 * not jutst the one that did not work: this device will be
+	 * de-allocated.
+	 */
+	for (i = 0; i < CROS_EC_SENSOR_PDEV_MAX; i++) {
+		pdev = data->sensor_pdev[i];
+		if (pdev)
+			platform_device_unregister(pdev);
+	}
+	return ret;
+}
+
+static int cros_ec_sensorhub_remove(struct platform_device *sensorhub_pdev)
+{
+	struct cros_ec_sensorhub *sensorhub =
+		platform_get_drvdata(sensorhub_pdev);
+	struct platform_device *pdev;
+	int i;
+
+	for (i = 0; i < CROS_EC_SENSOR_PDEV_MAX; i++) {
+		pdev = sensorhub->sensor_pdev[i];
+		if (pdev)
+			platform_device_unregister(pdev);
+	}
+
+	return 0;
+}
+
+static struct platform_driver cros_ec_sensorhub_driver = {
+	.driver = {
+		.name = DRV_NAME,
+	},
+	.probe = cros_ec_sensorhub_probe,
+	.remove = cros_ec_sensorhub_remove,
+};
+
+module_platform_driver(cros_ec_sensorhub_driver);
+
+MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_AUTHOR("Gwendal Grignou <gwendal@chromium.org>");
+MODULE_DESCRIPTION("ChromeOS EC MEMS Sensor Hub Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/platform_data/cros_ec_sensorhub.h b/include/linux/platform_data/cros_ec_sensorhub.h
new file mode 100644
index 000000000000..da0ba1d201e4
--- /dev/null
+++ b/include/linux/platform_data/cros_ec_sensorhub.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * cros_ec_sensorhub- Chrome OS EC MEMS Sensor Hub driver.
+ *
+ * Copyright (C) 2019 Google, Inc
+ */
+
+#ifndef __LINUX_PLATFORM_DATA_CROS_EC_SENSORHUB_H
+#define __LINUX_PLATFORM_DATA_CROS_EC_SENSORHUB_H
+
+#include <linux/platform_data/cros_ec_commands.h>
+
+/* Maximal number of sensors supported by the EC. */
+#define CROS_EC_SENSOR_MAX 16
+
+/*
+ * Maximal number of sensors supported by the hub:
+ * We add one for the lid angle inclinometer sensor.
+ */
+#define CROS_EC_SENSOR_PDEV_MAX (CROS_EC_SENSOR_MAX + 1)
+
+/**
+ * struct cros_ec_sensorhub - Sensor Hub device data.
+ *
+ * @ec:           Embedded Controller where the hub is located.
+ * @sensor_pdev:  Array of platform_device, one per sensor.
+ */
+struct cros_ec_sensorhub {
+	struct cros_ec_dev *ec;
+	struct platform_device *sensor_pdev[CROS_EC_SENSOR_PDEV_MAX];
+};
+
+#endif   /* __LINUX_PLATFORM_DATA_CROS_EC_SENSORHUB_H */
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

