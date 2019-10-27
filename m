Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8BC9E6A2C
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2019 00:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfJ0XLE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Oct 2019 19:11:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34503 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbfJ0XJz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Oct 2019 19:09:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id e4so1083054pgs.1
        for <linux-iio@vger.kernel.org>; Sun, 27 Oct 2019 16:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=88HzHaI/b1vr8BW0SqilRvf1zIa7FAM3FTP808LFAI4=;
        b=ROUIju85Z6Q3Q2Sh12GxbQaHgE26pu+JzHeKBLTkAVyRDuOtNqVxyfC3wKM5f+x3PG
         0lY728t0X+B8rvNv6XTBWeUI/VBbxXlIm399tRnsD3Hpwwv5qjyXRhvZ6YJB48DHOvra
         ifMfdbwJTVNCAhPEXyWF8rNwp0JgpksyqKb/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=88HzHaI/b1vr8BW0SqilRvf1zIa7FAM3FTP808LFAI4=;
        b=IZDo/RT+7ngB/BcYqu2B2IUyFwNKnG70UYlj93XokYAQcf8TodEcnYP6AECB5CY2iX
         OMrKpRMyuqqLqrwxtk9H/cRAxDaYSKIoahVt27okDdil4UK/FcX91LTFP4guBprGR6tj
         qUSopamK3wVV5H/f0BgfWFsde7KGcnEksNsPSzg4vmR39LbsI5rCMjIxG4wSY8pQJsjC
         BcAITuJtgnjU09N48K3ha4UUAlUZawgop63rwbEZk8OGYcIqaqNXsUrkHZmoeg9c5Qcc
         LxVbj8bHAYGCr9a9ymfNUwMAvYvieJRZ6Pi4yTzvDKOPxdZGXnXQdJKXGA/5sdYrbXvM
         c7xw==
X-Gm-Message-State: APjAAAU0OF754FNELFN5z5yPyoJi71mLnTHyQCQljaWwklPf5U8WSHZs
        ZqXzxLt8xEaeJft/P0j7fAC1qA==
X-Google-Smtp-Source: APXvYqw82IihQSdHb83I0PV5LF/0UFqzZF8JLLwLM0Jc6eOM1kEmldVLzp6+BkB1JZhmxZsdcaIddA==
X-Received: by 2002:a17:90a:c505:: with SMTP id k5mr18000573pjt.84.1572217793527;
        Sun, 27 Oct 2019 16:09:53 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id r19sm8906290pgj.43.2019.10.27.16.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2019 16:09:53 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 03/18] platform: cros_ec: Add cros_ec_sensor_hub driver
Date:   Sun, 27 Oct 2019 16:09:06 -0700
Message-Id: <20191027230921.205251-4-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
In-Reply-To: <20191027230921.205251-1-gwendal@chromium.org>
References: <20191027230921.205251-1-gwendal@chromium.org>
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
 drivers/platform/chrome/cros_ec_sensorhub.c   | 208 ++++++++++++++++++
 .../linux/platform_data/cros_ec_sensorhub.h   |  21 ++
 5 files changed, 243 insertions(+), 1 deletion(-)
 create mode 100644 drivers/platform/chrome/cros_ec_sensorhub.c
 create mode 100644 include/linux/platform_data/cros_ec_sensorhub.h

diff --git a/drivers/iio/common/cros_ec_sensors/Kconfig b/drivers/iio/common/cros_ec_sensors/Kconfig
index cdbb29cfb9076..fefad95727907 100644
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
index ee5f08ea57b6c..56a25317a6bee 100644
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
index 477ec3d1d1c98..a164c40dc0996 100644
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
index 0000000000000..7cb316135f4c0
--- /dev/null
+++ b/drivers/platform/chrome/cros_ec_sensorhub.c
@@ -0,0 +1,208 @@
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
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/mfd/cros_ec.h>
+#include <linux/platform_data/cros_ec_commands.h>
+#include <linux/platform_data/cros_ec_proto.h>
+#include <linux/platform_data/cros_ec_sensorhub.h>
+#include <linux/platform_device.h>
+#include <linux/poll.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+
+#define DRV_NAME		"cros-ec-sensorhub"
+
+static struct device_type cros_ec_sensorhub_dev_type = {
+	.name	= "cros_ec_iio_sensor",
+};
+
+static int cros_ec_sensorhub_allocate_single_sensor(
+		struct device *parent,
+		char *sensor_name,
+		int sensor_num)
+{
+	struct platform_device *pdev;
+	struct cros_ec_sensor_platform sensor_platforms = {
+		.sensor_num = sensor_num,
+	};
+	int ret;
+
+	pdev = platform_device_alloc(sensor_name, PLATFORM_DEVID_AUTO);
+	if (!pdev)
+		return -ENOMEM;
+
+	pdev->dev.parent = parent;
+	pdev->dev.type = &cros_ec_sensorhub_dev_type;
+
+	ret = platform_device_add_data(pdev, &sensor_platforms,
+			sizeof(sensor_platforms));
+	if (ret)
+		goto fail_device;
+
+	ret = platform_device_add(pdev);
+	if (ret)
+		goto fail_device;
+
+	return 0;
+
+fail_device:
+	platform_device_put(pdev);
+	return ret;
+}
+
+static int cros_ec_sensorhub_register(struct device *dev,
+		struct cros_ec_dev *ec)
+{
+	int ret, i, id, sensor_num;
+	int sensor_type[MOTIONSENSE_TYPE_MAX] = { 0 };
+	struct ec_params_motion_sense *params;
+	struct ec_response_motion_sense *resp;
+	struct cros_ec_command *msg;
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
+	msg = kzalloc(sizeof(struct cros_ec_command) +
+		      max(sizeof(*params), sizeof(*resp)), GFP_KERNEL);
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
+		ret = cros_ec_sensorhub_allocate_single_sensor(dev, name, i);
+		if (ret)
+			goto error;
+
+		sensor_type[resp->info.type]++;
+	}
+
+	if (sensor_type[MOTIONSENSE_TYPE_ACCEL] >= 2)
+		ec->has_kb_wake_angle = true;
+
+	if (cros_ec_check_features(ec,
+				EC_FEATURE_REFINED_TABLET_MODE_HYSTERESIS)) {
+		ret = cros_ec_sensorhub_allocate_single_sensor(
+				dev, "cros-ec-lid-angle", 0);
+	}
+
+error:
+	kfree(msg);
+	return ret;
+}
+
+static int cros_ec_sensorhub_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cros_ec_dev *ec = dev_get_drvdata(dev->parent);
+	int ret, i;
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
+		ret = cros_ec_sensorhub_register(dev, ec);
+		if (ret) {
+			dev_err(dev, "Register failed %d\n", ret);
+			return ret;
+		}
+	} else {
+		/*
+		 * If the device has sensors but does not claim to
+		 * be a sensor hub, we are in legacy mode.
+		 */
+		for (i = 0; i < 2; i++) {
+			ret = cros_ec_sensorhub_allocate_single_sensor(
+					dev, "cros-ec-accel-legacy", i);
+			if (ret) {
+				dev_err(dev, "Legacy %d failed %d\n", i, ret);
+				return ret;
+			}
+		}
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
index 0000000000000..7737685591ad3
--- /dev/null
+++ b/include/linux/platform_data/cros_ec_sensorhub.h
@@ -0,0 +1,21 @@
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
+/*
+ * struct cros_ec_sensorhub - Sensor Hub device data.
+ */
+struct cros_ec_sensorhub {
+	/* Embedded Controller where the hub is located. */
+	struct cros_ec_dev *ec;
+};
+
+#endif   /* __LINUX_PLATFORM_DATA_CROS_EC_SENSORHUB_H */
-- 
2.23.0.866.gb869b98d4c-goog

