Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA4111009F
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2019 15:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfLCOub (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Dec 2019 09:50:31 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59926 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfLCOub (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Dec 2019 09:50:31 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 604DD28A0B4
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, gwendal@chromium.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-iio@vger.kernel.org, Nick Vaccaro <nvaccaro@chromium.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Sebastian Reichel <sre@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH] cros_ec: treewide: Remove 'include/linux/mfd/cros_ec.h'
Date:   Tue,  3 Dec 2019 15:50:18 +0100
Message-Id: <20191203145018.14015-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This header file now only includes the cros_ec_dev struct, however, is the
'include/linux/platform_data/cros_ec_proto.h' who contains the definition of
all the Chrome OS EC related structs. There is no reason to have a
separate include for this struct so move to the place where other
structs are defined. That way, we can remove the include itself, but also
simplify the common pattern

    #include <linux/mfd/cros_ec.h>
    #include <linux/platform_data/cros_ec_proto.h>

for a single include

    #include <linux/platform_data/cros_ec_proto.h>

The changes to remove the cros_ec.h include were generated with the
following shell script:

    git grep -l "<linux/mfd/cros_ec.h>" | xargs sed -i '/<linux\/mfd\/cros_ec.h>/d'

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/iio/accel/cros_ec_accel_legacy.c      |  1 -
 .../common/cros_ec_sensors/cros_ec_sensors.c  |  1 -
 .../cros_ec_sensors/cros_ec_sensors_core.c    |  1 -
 drivers/iio/light/cros_ec_light_prox.c        |  1 -
 drivers/iio/pressure/cros_ec_baro.c           |  1 -
 .../media/platform/cros-ec-cec/cros-ec-cec.c  |  1 -
 drivers/mfd/cros_ec_dev.c                     |  1 -
 drivers/platform/chrome/cros_ec_chardev.c     |  1 -
 drivers/platform/chrome/cros_ec_debugfs.c     |  1 -
 drivers/platform/chrome/cros_ec_lightbar.c    |  1 -
 drivers/platform/chrome/cros_ec_sensorhub.c   |  1 -
 drivers/platform/chrome/cros_ec_sysfs.c       |  1 -
 drivers/platform/chrome/cros_ec_vbc.c         |  1 -
 drivers/platform/chrome/cros_usbpd_logger.c   |  1 -
 drivers/power/supply/cros_usbpd-charger.c     |  1 -
 drivers/rtc/rtc-cros-ec.c                     |  1 -
 include/linux/mfd/cros_ec.h                   | 35 -------------------
 include/linux/platform_data/cros_ec_proto.h   | 23 +++++++++++-
 18 files changed, 22 insertions(+), 52 deletions(-)
 delete mode 100644 include/linux/mfd/cros_ec.h

diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
index 65f85faf6f31..68e847c6255e 100644
--- a/drivers/iio/accel/cros_ec_accel_legacy.c
+++ b/drivers/iio/accel/cros_ec_accel_legacy.c
@@ -18,7 +18,6 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/kernel.h>
-#include <linux/mfd/cros_ec.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/platform_data/cros_ec_commands.h>
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index 7dce04473467..576e45faafaf 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -16,7 +16,6 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/kernel.h>
-#include <linux/mfd/cros_ec.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 81a7f692de2f..d3a3626c7cd8 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -13,7 +13,6 @@
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/kernel.h>
-#include <linux/mfd/cros_ec.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/platform_data/cros_ec_commands.h>
diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
index d85a391e50c5..7a838e2956f4 100644
--- a/drivers/iio/light/cros_ec_light_prox.c
+++ b/drivers/iio/light/cros_ec_light_prox.c
@@ -14,7 +14,6 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/kernel.h>
-#include <linux/mfd/cros_ec.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
index 2354302375de..d2a67dceb996 100644
--- a/drivers/iio/pressure/cros_ec_baro.c
+++ b/drivers/iio/pressure/cros_ec_baro.c
@@ -14,7 +14,6 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/kernel.h>
-#include <linux/mfd/cros_ec.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/platform_data/cros_ec_commands.h>
diff --git a/drivers/media/platform/cros-ec-cec/cros-ec-cec.c b/drivers/media/platform/cros-ec-cec/cros-ec-cec.c
index 4a3b3810fd89..72c70f123650 100644
--- a/drivers/media/platform/cros-ec-cec/cros-ec-cec.c
+++ b/drivers/media/platform/cros-ec-cec/cros-ec-cec.c
@@ -14,7 +14,6 @@
 #include <linux/cec.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
-#include <linux/mfd/cros_ec.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <media/cec.h>
diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index c4b977a5dd96..8da4e4cef26f 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -6,7 +6,6 @@
  */
 
 #include <linux/mfd/core.h>
-#include <linux/mfd/cros_ec.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/of_platform.h>
diff --git a/drivers/platform/chrome/cros_ec_chardev.c b/drivers/platform/chrome/cros_ec_chardev.c
index 74ded441bb50..c65e70bc168d 100644
--- a/drivers/platform/chrome/cros_ec_chardev.c
+++ b/drivers/platform/chrome/cros_ec_chardev.c
@@ -13,7 +13,6 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/fs.h>
-#include <linux/mfd/cros_ec.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 6ae484989d1f..ecfada00e6c5 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -7,7 +7,6 @@
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
-#include <linux/mfd/cros_ec.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/platform_data/cros_ec_commands.h>
diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
index c0f2eec35a48..b4c110c5fee0 100644
--- a/drivers/platform/chrome/cros_ec_lightbar.c
+++ b/drivers/platform/chrome/cros_ec_lightbar.c
@@ -8,7 +8,6 @@
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/kobject.h>
-#include <linux/mfd/cros_ec.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
diff --git a/drivers/platform/chrome/cros_ec_sensorhub.c b/drivers/platform/chrome/cros_ec_sensorhub.c
index 04d8879689e9..79fefd3bb0fa 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub.c
@@ -9,7 +9,6 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/module.h>
-#include <linux/mfd/cros_ec.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_data/cros_ec_sensorhub.h>
diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index 74d36b8d4f46..07dac97ad57c 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -8,7 +8,6 @@
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/kobject.h>
-#include <linux/mfd/cros_ec.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chrome/cros_ec_vbc.c
index f11a1283e5c8..8edae465105c 100644
--- a/drivers/platform/chrome/cros_ec_vbc.c
+++ b/drivers/platform/chrome/cros_ec_vbc.c
@@ -6,7 +6,6 @@
 
 #include <linux/of.h>
 #include <linux/platform_device.h>
-#include <linux/mfd/cros_ec.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
diff --git a/drivers/platform/chrome/cros_usbpd_logger.c b/drivers/platform/chrome/cros_usbpd_logger.c
index 374cdd1e868a..7de3ea75ef46 100644
--- a/drivers/platform/chrome/cros_usbpd_logger.c
+++ b/drivers/platform/chrome/cros_usbpd_logger.c
@@ -6,7 +6,6 @@
  */
 
 #include <linux/ktime.h>
-#include <linux/mfd/cros_ec.h>
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
index 6cc7c3910e09..0aca0da41cb7 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2014 - 2018 Google, Inc
  */
 
-#include <linux/mfd/cros_ec.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
diff --git a/drivers/rtc/rtc-cros-ec.c b/drivers/rtc/rtc-cros-ec.c
index d043d30f05bc..f7343c289cab 100644
--- a/drivers/rtc/rtc-cros-ec.c
+++ b/drivers/rtc/rtc-cros-ec.c
@@ -5,7 +5,6 @@
 // Author: Stephen Barber <smbarber@chromium.org>
 
 #include <linux/kernel.h>
-#include <linux/mfd/cros_ec.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
deleted file mode 100644
index 61c2875c2a40..000000000000
--- a/include/linux/mfd/cros_ec.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * ChromeOS EC multi-function device
- *
- * Copyright (C) 2012 Google, Inc
- */
-
-#ifndef __LINUX_MFD_CROS_EC_H
-#define __LINUX_MFD_CROS_EC_H
-
-#include <linux/device.h>
-
-/**
- * struct cros_ec_dev - ChromeOS EC device entry point.
- * @class_dev: Device structure used in sysfs.
- * @ec_dev: cros_ec_device structure to talk to the physical device.
- * @dev: Pointer to the platform device.
- * @debug_info: cros_ec_debugfs structure for debugging information.
- * @has_kb_wake_angle: True if at least 2 accelerometer are connected to the EC.
- * @cmd_offset: Offset to apply for each command.
- * @features: Features supported by the EC.
- */
-struct cros_ec_dev {
-	struct device class_dev;
-	struct cros_ec_device *ec_dev;
-	struct device *dev;
-	struct cros_ec_debugfs *debug_info;
-	bool has_kb_wake_angle;
-	u16 cmd_offset;
-	u32 features[2];
-};
-
-#define to_cros_ec_dev(dev)  container_of(dev, struct cros_ec_dev, class_dev)
-
-#endif /* __LINUX_MFD_CROS_EC_H */
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 30098a551523..119b9951c055 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -12,7 +12,6 @@
 #include <linux/mutex.h>
 #include <linux/notifier.h>
 
-#include <linux/mfd/cros_ec.h>
 #include <linux/platform_data/cros_ec_commands.h>
 
 #define CROS_EC_DEV_NAME	"cros_ec"
@@ -185,6 +184,28 @@ struct cros_ec_platform {
 	u16 cmd_offset;
 };
 
+/**
+ * struct cros_ec_dev - ChromeOS EC device entry point.
+ * @class_dev: Device structure used in sysfs.
+ * @ec_dev: cros_ec_device structure to talk to the physical device.
+ * @dev: Pointer to the platform device.
+ * @debug_info: cros_ec_debugfs structure for debugging information.
+ * @has_kb_wake_angle: True if at least 2 accelerometer are connected to the EC.
+ * @cmd_offset: Offset to apply for each command.
+ * @features: Features supported by the EC.
+ */
+struct cros_ec_dev {
+	struct device class_dev;
+	struct cros_ec_device *ec_dev;
+	struct device *dev;
+	struct cros_ec_debugfs *debug_info;
+	bool has_kb_wake_angle;
+	u16 cmd_offset;
+	u32 features[2];
+};
+
+#define to_cros_ec_dev(dev)  container_of(dev, struct cros_ec_dev, class_dev)
+
 int cros_ec_suspend(struct cros_ec_device *ec_dev);
 
 int cros_ec_resume(struct cros_ec_device *ec_dev);
-- 
2.20.1

