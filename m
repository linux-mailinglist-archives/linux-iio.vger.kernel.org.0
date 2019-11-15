Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A06E8FD9BE
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2019 10:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfKOJu0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Nov 2019 04:50:26 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33720 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfKOJuZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Nov 2019 04:50:25 -0500
Received: by mail-pl1-f195.google.com with SMTP id ay6so4314941plb.0
        for <linux-iio@vger.kernel.org>; Fri, 15 Nov 2019 01:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=217eC9hKKPhFR1dt5ut+bKE9PoJLm9Luk5L1E4O08SY=;
        b=bV5Cgu3vp7/I5f4JwZ8BVuzarL/xFpG1avEzPFu5Q5faSfZP9PupsphWvmEmhYtGhN
         HY1kN2JlDy2J2n03BkYZF+ImkBQcM7a/Z8afCNmGXMRxHE1PHOIyLVjLOWf11Bg8OBwr
         3XTkJ51McBscgxwFPNDou0HxpDj/d5aGYdSMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=217eC9hKKPhFR1dt5ut+bKE9PoJLm9Luk5L1E4O08SY=;
        b=A1UUg38BPUYlL/hhtGqv4bSN9m6yyRGsTWRi/kXlj6hOrdZ4Y8lTkWgOwkzHaKIkwV
         Vulvt2a7f+pdwFuEHAbPmbllk+AbS/4U0eYmWIKhl9VXcgzIEul6NnLBkDTOOdrcPODs
         jNNqKpTl7BSHCChJrHfb7/YXUA1k/7nqAg52PTWcGSewAhEJSBe0VZ4AFVtCuvuOGC4O
         L+2WpJWnaY+bghuF/gT6sXCPx1n3J8bT5GWcqhmzwokuKiogXUIV2Vm9XNST9kv09iHD
         vXhz64ysfbj6sEluRKVmavZlYMXS14yo3R+/Q2NTt87GK71627/8O8E9K94DTOuxNjKG
         iYIA==
X-Gm-Message-State: APjAAAWSO98EkJQL4Og/At3SU/gDfgquTsLE7Kk2ize3OsnmfOll+yeA
        dx5lsOkMPREVSRTQ3l2T6ReumQ==
X-Google-Smtp-Source: APXvYqzIMSU8vq9BjvPriBULbuqe6wv7lEuICA3AcXhgNzKQm/2tNyxkqjBDqx6XYftyqKXWMAQzvA==
X-Received: by 2002:a17:90a:f013:: with SMTP id bt19mr18446883pjb.16.1573811422687;
        Fri, 15 Nov 2019 01:50:22 -0800 (PST)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id p18sm9935506pff.9.2019.11.15.01.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2019 01:50:22 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     dmitry.torokhov@gmail.com, groeck@chromium.org,
        briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v5 02/18] platform: cros_ec: Add cros_ec_sensor_hub driver
Date:   Fri, 15 Nov 2019 01:33:56 -0800
Message-Id: <20191115093412.144922-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191115093412.144922-1-gwendal@chromium.org>
References: <20191115093412.144922-1-gwendal@chromium.org>
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
Changes in v5:
- Use devm_add_action_or_reset() to free children devices.
  In consequence, remove array and define not use for house keeping in
  .h file, remove .remove entry point.
- Use PTR_ERR() when needed.
- Use demv_kzalloc for device memory allocation.
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
 drivers/platform/chrome/Kconfig               |  12 ++
 drivers/platform/chrome/Makefile              |   1 +
 drivers/platform/chrome/cros_ec_sensorhub.c   | 197 ++++++++++++++++++
 .../linux/platform_data/cros_ec_sensorhub.h   |  22 ++
 5 files changed, 233 insertions(+), 1 deletion(-)
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
index ee5f08ea57b6..884ac9a287f2 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -190,6 +190,18 @@ config CROS_EC_DEBUGFS
 	  To compile this driver as a module, choose M here: the
 	  module will be called cros_ec_debugfs.
 
+config CROS_EC_SENSORHUB
+	tristate "ChromeOS EC MEMS Sensor Hub"
+	depends on CROS_EC
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
index 000000000000..85e3d3f25786
--- /dev/null
+++ b/drivers/platform/chrome/cros_ec_sensorhub.c
@@ -0,0 +1,197 @@
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
+static void cros_ec_sensorhub_free_single_sensor(void *arg)
+{
+	struct platform_device *pdev = arg;
+
+	platform_device_unregister(pdev);
+}
+
+static int cros_ec_sensorhub_allocate_single_sensor(struct device *parent,
+						    char *sensor_name,
+						    int sensor_num)
+{
+	struct platform_device *pdev;
+	struct cros_ec_sensor_platform sensor_platforms = {
+		.sensor_num = sensor_num,
+	};
+
+	pdev = platform_device_register_data(parent, sensor_name,
+					     PLATFORM_DEVID_AUTO,
+					     &sensor_platforms,
+					     sizeof(sensor_platforms));
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	return devm_add_action_or_reset(parent,
+			cros_ec_sensorhub_free_single_sensor, pdev);
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
+				   EC_FEATURE_REFINED_TABLET_MODE_HYSTERESIS)) {
+		ret = cros_ec_sensorhub_allocate_single_sensor(dev,
+							"cros-ec-lid-angle", 0);
+		if (ret)
+			goto error;
+	}
+	kfree(msg);
+	return 0;
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
+	struct cros_ec_sensorhub *data =
+		devm_kzalloc(dev, sizeof(struct cros_ec_sensorhub), GFP_KERNEL);
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
+			return ret;
+		}
+	} else {
+		/*
+		 * If the device has sensors but does not claim to
+		 * be a sensor hub, we are in legacy mode.
+		 */
+		for (i = 0; i < 2; i++) {
+			ret = cros_ec_sensorhub_allocate_single_sensor(dev,
+						"cros-ec-accel-legacy", i);
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
index 000000000000..63c8dafb87e8
--- /dev/null
+++ b/include/linux/platform_data/cros_ec_sensorhub.h
@@ -0,0 +1,22 @@
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
+/**
+ * struct cros_ec_sensorhub - Sensor Hub device data.
+ *
+ * @ec:           Embedded Controller where the hub is located.
+ */
+struct cros_ec_sensorhub {
+	struct cros_ec_dev *ec;
+};
+
+#endif   /* __LINUX_PLATFORM_DATA_CROS_EC_SENSORHUB_H */
-- 
2.24.0.432.g9d3f5f5b63-goog

