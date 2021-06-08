Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C893A05F9
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jun 2021 23:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbhFHV2k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 17:28:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:41600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231775AbhFHV2j (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 8 Jun 2021 17:28:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B49F360FD8;
        Tue,  8 Jun 2021 21:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623187606;
        bh=eBxGRQMQ7QH17b/e4vyj/SrJ1f9pTI9JyfopPK1gMAs=;
        h=From:To:Cc:Subject:Date:From;
        b=ufWlsBj6MStr9Yy8bkkLGJbC7XRe74t5PPcFRXWrM3FSXlE2Zunmqi8/uBKEwy9AU
         xcO4yMm1iXL9JYOl+RG45iH0k/3Yd0svkYZYNU4pSvEZjKd5PnV3mePzzUvkEqFAZp
         EwDAuoB2Hxf0tWNK93k+Bz+gLxaL9db4u8TJmpNASx2Ucdsk/l5X9Ig+sof7McmPt8
         w623JYkDsN/xlkvcVHzNpK4fewK3tlRvKhseSxL49JlXx7f0AFiOFBw1y9OGGhQJZW
         heFEW0pWbc08bAMIXA7LDtf7bkIt/DqtSWfX4w4HRl9J3DtxJkhMi/1k7/7fvwmoyy
         cKEmITNT7fF0A==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH] iio: cros_ec: Update header includes
Date:   Tue,  8 Jun 2021 22:28:34 +0100
Message-Id: <20210608212834.4046618-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

General driver churn doesn't always include updates of header includes.
Manual review of the output of the include-what-you-use checker lead to the
following cleanup. Hopefuly this brings things back to a good state for the
cros_ec sensor drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 drivers/iio/accel/cros_ec_accel_legacy.c                  | 7 +------
 drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c    | 8 ++------
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c      | 7 ++-----
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 6 ++++--
 drivers/iio/light/cros_ec_light_prox.c                    | 8 ++------
 drivers/iio/pressure/cros_ec_baro.c                       | 7 ++-----
 6 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
index b6f3471b62dc..5b24b762b2dd 100644
--- a/drivers/iio/accel/cros_ec_accel_legacy.c
+++ b/drivers/iio/accel/cros_ec_accel_legacy.c
@@ -9,17 +9,12 @@
  * Accelerometer access is presented through iio sysfs.
  */
 
-#include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/iio/buffer.h>
 #include <linux/iio/common/cros_ec_sensors_core.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/kfifo_buf.h>
-#include <linux/iio/trigger_consumer.h>
-#include <linux/iio/triggered_buffer.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/slab.h>
+#include <linux/mutex.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
index af801e203623..497deaf9d96a 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
@@ -10,20 +10,16 @@
  * iio sysfs.
  */
 
-#include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/iio/buffer.h>
 #include <linux/iio/common/cros_ec_sensors_core.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/kfifo_buf.h>
-#include <linux/iio/trigger.h>
 #include <linux/iio/triggered_buffer.h>
-#include <linux/iio/trigger_consumer.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_device.h>
-#include <linux/slab.h>
 
 #define DRV_NAME "cros-ec-lid-angle"
 
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index 376a5b30010a..de8b01501cc5 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -9,18 +9,15 @@
  */
 
 #include <linux/device.h>
-#include <linux/iio/buffer.h>
 #include <linux/iio/common/cros_ec_sensors_core.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/kfifo_buf.h>
-#include <linux/iio/trigger_consumer.h>
-#include <linux/iio/triggered_buffer.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
-#include <linux/slab.h>
 
 #define CROS_EC_SENSORS_MAX_CHANNELS 4
 
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 28bde13003b7..370d1017b533 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -12,12 +12,14 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/sysfs.h>
-#include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
+#include <linux/irqreturn.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/slab.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/time.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_data/cros_ec_sensorhub.h>
diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
index de472f23d1cb..062e02adac65 100644
--- a/drivers/iio/light/cros_ec_light_prox.c
+++ b/drivers/iio/light/cros_ec_light_prox.c
@@ -6,19 +6,15 @@
  */
 
 #include <linux/device.h>
-#include <linux/iio/buffer.h>
 #include <linux/iio/common/cros_ec_sensors_core.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/kfifo_buf.h>
-#include <linux/iio/trigger.h>
-#include <linux/iio/triggered_buffer.h>
-#include <linux/iio/trigger_consumer.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
-#include <linux/slab.h>
 
 /*
  * We only represent one entry for light or proximity. EC is merging different
diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
index 2f882e109423..5a0d9dd1e78a 100644
--- a/drivers/iio/pressure/cros_ec_baro.c
+++ b/drivers/iio/pressure/cros_ec_baro.c
@@ -6,16 +6,13 @@
  */
 
 #include <linux/device.h>
-#include <linux/iio/buffer.h>
 #include <linux/iio/common/cros_ec_sensors_core.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/kfifo_buf.h>
-#include <linux/iio/trigger.h>
-#include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/slab.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
-- 
2.31.1

