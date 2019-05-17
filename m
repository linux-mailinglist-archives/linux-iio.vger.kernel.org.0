Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B408220C2
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 01:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfEQXjK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 May 2019 19:39:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33303 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbfEQXjG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 May 2019 19:39:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id h17so4006113pgv.0
        for <linux-iio@vger.kernel.org>; Fri, 17 May 2019 16:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ReIwvSW1gibG6rcIrbJ7tf7TexCbxQLkXs9Ll/bUMDk=;
        b=RXGKfYyMqznbpXVjZFO1s3f5Ix9s1Ik5s/F8um5Jfk5PjnbtjpLO4nHpc/TiRA3Tum
         VIrKOTi7MI8lw+S7L/3SXsqnfZAaUhsQBwQ+OutOdgtr85JOYtFFfQQXN53vRGugtKwj
         /UKNsJYBKuUmCjUJMchw+i2oByhblwEFwB5B0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ReIwvSW1gibG6rcIrbJ7tf7TexCbxQLkXs9Ll/bUMDk=;
        b=U6p4XtzYGnWNOKvyT/IVYS5OnNwA9IP0DD91yUO1FSXysYfLMK2gsgsECcb8fVavtv
         52qkRseQ60unU83Iwj7kLxScfDY5mxdW5vhww/WmUYCNREhtkNwogSG2tszFb53xaZlT
         f4YdBj5ruMwismquArGD4yhwtERg6kMe3EJocXc4/rL1FqGlIsW3cV3gNCWnLjr7Ho09
         40uP1REbeDUlZ0MHw4yt/Sv1XZKdoDzIPRkC7meb7epfJ1ulZUnaPbdXbrZ2yso2z0AJ
         4d/cqlc2bQcrWMYhZPQN+ZhKjaSzwboocpkH7TtqEnZiXVye95eCqxszfj8EMaf40PSl
         rQhQ==
X-Gm-Message-State: APjAAAXwaQ+LMCjgQfusKGAU/9U5ufLNjumpsi5ybtUwVjEMHXOR/WPD
        dKIkq4OtMf9c5YqYgwWwiURRmQ==
X-Google-Smtp-Source: APXvYqwQidO1KC+MffDhwmDts1dUo4VpS7aBYBQQLeZn50P0J+UCsmklXBy9BckqXbjRrNBSwoCW9A==
X-Received: by 2002:a65:624f:: with SMTP id q15mr59923633pgv.436.1558136345462;
        Fri, 17 May 2019 16:39:05 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id r74sm11960716pfa.71.2019.05.17.16.39.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 16:39:04 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v7 2/2] iio: cros_ec: Add lid angle driver
Date:   Fri, 17 May 2019 16:38:56 -0700
Message-Id: <20190517233856.155793-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190517233856.155793-1-gwendal@chromium.org>
References: <20190517233856.155793-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a IIO driver that reports the angle between the lid and the base for
ChromeOS convertible device.

Tested on eve with ToT EC firmware.
Check driver is loaded and lid angle is correct.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v7:
- Split patch in two: This is the IIO section.

Changes in v6:
- Fix lock held in an error path error.

Changes in v5:
- Remove unnecessary define.
- v4 was the wrong patch file

Changes in v3:
- Use static channel array, simplify code because index is always 0.

Changes in v2:
- Fix license, remove driver_module field.

 drivers/iio/common/cros_ec_sensors/Kconfig    |   9 ++
 drivers/iio/common/cros_ec_sensors/Makefile   |   1 +
 .../cros_ec_sensors/cros_ec_lid_angle.c       | 139 ++++++++++++++++++
 3 files changed, 149 insertions(+)
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c

diff --git a/drivers/iio/common/cros_ec_sensors/Kconfig b/drivers/iio/common/cros_ec_sensors/Kconfig
index 135f6825903f..aacc2ab9c34f 100644
--- a/drivers/iio/common/cros_ec_sensors/Kconfig
+++ b/drivers/iio/common/cros_ec_sensors/Kconfig
@@ -20,3 +20,12 @@ config IIO_CROS_EC_SENSORS
 	  Accelerometers, Gyroscope and Magnetometer that are
 	  presented by the ChromeOS EC Sensor hub.
 	  Creates an IIO device for each functions.
+
+config IIO_CROS_EC_SENSORS_LID_ANGLE
+	tristate "ChromeOS EC Sensor for lid angle"
+	depends on IIO_CROS_EC_SENSORS_CORE
+	help
+	  Module to report the angle between lid and base for some
+	  convertible devices.
+	  This module is loaded when the EC can calculate the angle between the base
+	  and the lid.
diff --git a/drivers/iio/common/cros_ec_sensors/Makefile b/drivers/iio/common/cros_ec_sensors/Makefile
index ec716ff2a775..a35ee232ac07 100644
--- a/drivers/iio/common/cros_ec_sensors/Makefile
+++ b/drivers/iio/common/cros_ec_sensors/Makefile
@@ -4,3 +4,4 @@
 
 obj-$(CONFIG_IIO_CROS_EC_SENSORS_CORE) += cros_ec_sensors_core.o
 obj-$(CONFIG_IIO_CROS_EC_SENSORS) += cros_ec_sensors.o
+obj-$(CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE) += cros_ec_lid_angle.o
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
new file mode 100644
index 000000000000..876dfd176b0e
--- /dev/null
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * cros_ec_lid_angle - Driver for CrOS EC lid angle sensor.
+ *
+ * Copyright 2018 Google, Inc
+ *
+ * This driver uses the cros-ec interface to communicate with the Chrome OS
+ * EC about counter sensors. Counters are presented through
+ * iio sysfs.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/common/cros_ec_sensors_core.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/kernel.h>
+#include <linux/mfd/cros_ec.h>
+#include <linux/mfd/cros_ec_commands.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define DRV_NAME "cros-ec-lid-angle"
+
+/*
+ * One channel for the lid angle, the other for timestamp.
+ */
+static const struct iio_chan_spec cros_ec_lid_angle_channels[] = {
+	{
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.scan_type.realbits = CROS_EC_SENSOR_BITS,
+		.scan_type.storagebits = CROS_EC_SENSOR_BITS,
+		.scan_type.sign = 'u',
+		.type = IIO_ANGL
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(1)
+};
+
+/* State data for ec_sensors iio driver. */
+struct cros_ec_lid_angle_state {
+	/* Shared by all sensors */
+	struct cros_ec_sensors_core_state core;
+};
+
+static int cros_ec_sensors_read_lid_angle(struct iio_dev *indio_dev,
+					  unsigned long scan_mask, s16 *data)
+{
+	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
+	int ret;
+
+	st->param.cmd = MOTIONSENSE_CMD_LID_ANGLE;
+	ret = cros_ec_motion_send_host_cmd(st, sizeof(st->resp->lid_angle));
+	if (ret) {
+		dev_warn(&indio_dev->dev, "Unable to read lid angle\n");
+		return ret;
+	}
+
+	*data = st->resp->lid_angle.value;
+	return 0;
+}
+
+static int cros_ec_lid_angle_read(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan,
+				    int *val, int *val2, long mask)
+{
+	struct cros_ec_lid_angle_state *st = iio_priv(indio_dev);
+	s16 data;
+	int ret;
+
+	mutex_lock(&st->core.cmd_lock);
+	ret = cros_ec_sensors_read_lid_angle(indio_dev, 1, &data);
+	if (ret == 0) {
+		*val = data;
+		ret = IIO_VAL_INT;
+	}
+	mutex_unlock(&st->core.cmd_lock);
+	return ret;
+}
+
+static const struct iio_info cros_ec_lid_angle_info = {
+	.read_raw = &cros_ec_lid_angle_read,
+};
+
+static int cros_ec_lid_angle_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct iio_dev *indio_dev;
+	struct cros_ec_lid_angle_state *state;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	ret = cros_ec_sensors_core_init(pdev, indio_dev, false);
+	if (ret)
+		return ret;
+
+	indio_dev->info = &cros_ec_lid_angle_info;
+	state = iio_priv(indio_dev);
+	indio_dev->channels = cros_ec_lid_angle_channels;
+	indio_dev->num_channels = ARRAY_SIZE(cros_ec_lid_angle_channels);
+
+	state->core.read_ec_sensors_data = cros_ec_sensors_read_lid_angle;
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+			cros_ec_sensors_capture, NULL);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct platform_device_id cros_ec_lid_angle_ids[] = {
+	{
+		.name = DRV_NAME,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, cros_ec_lid_angle_ids);
+
+static struct platform_driver cros_ec_lid_angle_platform_driver = {
+	.driver = {
+		.name	= DRV_NAME,
+		.pm	= &cros_ec_sensors_pm_ops,
+	},
+	.probe		= cros_ec_lid_angle_probe,
+	.id_table	= cros_ec_lid_angle_ids,
+};
+module_platform_driver(cros_ec_lid_angle_platform_driver);
+
+MODULE_DESCRIPTION("ChromeOS EC driver for reporting convertible lid angle.");
+MODULE_LICENSE("GPL v2");
-- 
2.21.0.1020.gf2820cf01a-goog

