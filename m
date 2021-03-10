Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659B533362F
	for <lists+linux-iio@lfdr.de>; Wed, 10 Mar 2021 08:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhCJHNw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Mar 2021 02:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCJHNj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Mar 2021 02:13:39 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5897AC06174A
        for <linux-iio@vger.kernel.org>; Tue,  9 Mar 2021 23:13:39 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id ha17so320105pjb.2
        for <linux-iio@vger.kernel.org>; Tue, 09 Mar 2021 23:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JeY9SqMJmfo2nqy3327r+Mg7OR7K3HWpQGJsPSzD31w=;
        b=iZgxbrvzF3nu27pVFRqs1vo9yOHraVtKX4q3wnnoyOgc/GwEZuTgXbNnKObI+OSGTv
         haFGwt01P3XRURuOI7diUXM/gOXgLd/pj/cxffCYmwXD6mt7RouY0m9OgolhHPWyjYtB
         pw98phaee5yvzISbSguwfgV5/GaOccLyrvMBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JeY9SqMJmfo2nqy3327r+Mg7OR7K3HWpQGJsPSzD31w=;
        b=l2CF/S06oBIScCWRPh9THFFiv09HKWbmClRHEVPBZOcIFMiLhRfR6AtkYQ2poMXZOR
         fEyVRQ9QbAr9qypEML/lcXMfccOI8vE0AVIFUpm3lkG2Cuz+277p70pyhYcq0JoVlRa/
         67EDO8KUyX2ZSCsmV+al7r/qtXHjXQTePAsyngdP8ZQsVt/COZRrosDIIrqjm6B7uGb1
         arlAYMi+A9DZI2Qthnun2LlmBegEjyziI3rl8TGNW6jkyH8KgHCtP0XrNMyl+I8Sl8dJ
         0ZSp+YNFeN2x2dQsZAMS51jAAC2QWECR/r7WeEmP2jSrUVrsQ/OqCQ22VT7ca1VVkpQV
         oYbw==
X-Gm-Message-State: AOAM532jqZr7CuvghHkl3JgEt+LhF86bzuUUtrtrgohHYGDMXNuIrtSH
        5SD+uIry1gRB66dkWbX0nA8cqg==
X-Google-Smtp-Source: ABdhPJy/LORE6//igpsuppG0FkLmKAQw0ykKIfF7bLLTl/h+2S9QdaNRuxoiW6TWnI4SHR8p1WNc0g==
X-Received: by 2002:a17:90a:6343:: with SMTP id v3mr2093613pjs.153.1615360418680;
        Tue, 09 Mar 2021 23:13:38 -0800 (PST)
Received: from localhost ([2620:15c:202:201:98f9:3cff:c504:d44b])
        by smtp.gmail.com with UTF8SMTPSA id d7sm14859123pfh.73.2021.03.09.23.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 23:13:38 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     Jonathan.Cameron@huawei.com, alexandru.ardelean@analog.com,
        groeck@chromium.org
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2] iio: cros: unify hw fifo attributes without API changes
Date:   Tue,  9 Mar 2021 23:13:34 -0800
Message-Id: <20210310071334.3204344-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

fixes commit 2e2366c2d141 ("iio: cros_ec: unify hw fifo attributes into the core file")
fixes commit 165aea80e2e2 ("iio: cros_ec: use devm_iio_triggered_buffer_setup_ext()")

1. Instead of adding has_fw_fifo, deduct it from the configuration:
- EC must support FIFO (EC_FEATURE_MOTION_SENSE_FIFO) set.
- sensors send data a regular interval (accelerometer, gyro,
  magnetomer, barometer, light sensor).
- "Legacy accelerometer" is only present on EC without FIFO, so we don't
need to set buffer attributes.

2. devm_iio_triggered_buffer_setup_ext() does not need to be called when
EC does not support FIFO, as there is no FIFO to manage.

3. Create a triggered buffer with devm_iio_triggered_buffer_setup_ext() when
the EC support FIFO as it is the only clean way to set the
buffer extended attributes.
Add a slim trigger to be sure the samples can flow via callback from the
EC FIFO to the IIO buffer.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/accel/cros_ec_accel_legacy.c      |  2 +-
 .../cros_ec_sensors/cros_ec_lid_angle.c       |  3 +-
 .../common/cros_ec_sensors/cros_ec_sensors.c  |  3 +-
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 58 +++++++++++--------
 drivers/iio/light/cros_ec_light_prox.c        |  3 +-
 drivers/iio/pressure/cros_ec_baro.c           |  3 +-
 .../linux/iio/common/cros_ec_sensors_core.h   |  3 +-
 7 files changed, 41 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
index 8f1232c38e0d7..b6f3471b62dcf 100644
--- a/drivers/iio/accel/cros_ec_accel_legacy.c
+++ b/drivers/iio/accel/cros_ec_accel_legacy.c
@@ -215,7 +215,7 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
-					cros_ec_sensors_capture, NULL, false);
+					cros_ec_sensors_capture, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
index 752f59037715b..af801e203623e 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
@@ -97,8 +97,7 @@ static int cros_ec_lid_angle_probe(struct platform_device *pdev)
 	if (!indio_dev)
 		return -ENOMEM;
 
-	ret = cros_ec_sensors_core_init(pdev, indio_dev, false, NULL,
-					NULL, false);
+	ret = cros_ec_sensors_core_init(pdev, indio_dev, false, NULL, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index dee1191de7528..376a5b30010ae 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -236,8 +236,7 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
 
 	ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
 					cros_ec_sensors_capture,
-					cros_ec_sensors_push_data,
-					true);
+					cros_ec_sensors_push_data);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index c833ec0ef2147..8ee89c4314a61 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -8,10 +8,12 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/buffer_impl.h>
 #include <linux/iio/common/cros_ec_sensors_core.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/kernel.h>
@@ -240,7 +242,6 @@ static void cros_ec_sensors_core_clean(void *arg)
  *    for backward compatibility.
  * @push_data:          function to call when cros_ec_sensorhub receives
  *    a sample for that sensor.
- * @has_hw_fifo:	Set true if this device has/uses a HW FIFO
  *
  * Return: 0 on success, -errno on failure.
  */
@@ -248,8 +249,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 			      struct iio_dev *indio_dev,
 			      bool physical_device,
 			      cros_ec_sensors_capture_t trigger_capture,
-			      cros_ec_sensorhub_push_data_cb_t push_data,
-			      bool has_hw_fifo)
+			      cros_ec_sensorhub_push_data_cb_t push_data)
 {
 	struct device *dev = &pdev->dev;
 	struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
@@ -329,22 +329,41 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 		}
 
 		if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
+			struct iio_trigger *trig;
+
 			/*
-			 * Create a software buffer, feed by the EC FIFO.
-			 * We can not use trigger here, as events are generated
-			 * as soon as sample_frequency is set.
+			 * Create a triggered buffer to be able to trigger data
+			 * gathering manually, but by default, samples come from
+			 * the EC FIFO.
 			 */
-			struct iio_buffer *buffer;
+			ret = devm_iio_triggered_buffer_setup_ext(dev, indio_dev,
+					NULL, trigger_capture, NULL,
+					cros_ec_sensor_fifo_attributes);
+			if (ret)
+				return ret;
 
-			buffer = devm_iio_kfifo_allocate(dev);
-			if (!buffer)
+			/*
+			 * Register a trigger as plug to allow samples from the
+			 * FIFO to flow.
+			 * When cros-ec-sensor-ring is present, samples produced
+			 * by the EC FIFO are directed to that ring only.
+			 */
+			trig = devm_iio_trigger_alloc(dev, "cros_ec%d-dev%d",
+					sensor_platform->sensor_num, indio_dev->id);
+			if (!trig)
 				return -ENOMEM;
 
-			iio_device_attach_buffer(indio_dev, buffer);
-			indio_dev->modes = INDIO_BUFFER_SOFTWARE;
+			ret = devm_iio_trigger_register(dev, trig);
+			if (ret < 0)
+				return ret;
+			indio_dev->trig = iio_trigger_get(trig);
 
-			ret = cros_ec_sensorhub_register_push_data(
-					sensor_hub, sensor_platform->sensor_num,
+			/*
+			 * Register the callback to use when a sensor sample is
+			 * coming from the EC FIFO.
+			 */
+			ret = cros_ec_sensorhub_register_push_data(sensor_hub,
+					sensor_platform->sensor_num,
 					indio_dev, push_data);
 			if (ret)
 				return ret;
@@ -358,21 +377,14 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 			ret = iio_device_set_clock(indio_dev, CLOCK_BOOTTIME);
 			if (ret)
 				return ret;
-		} else {
-			const struct attribute **fifo_attrs;
-
-			if (has_hw_fifo)
-				fifo_attrs = cros_ec_sensor_fifo_attributes;
-			else
-				fifo_attrs = NULL;
 
+		} else {
 			/*
 			 * The only way to get samples in buffer is to set a
 			 * software trigger (systrig, hrtimer).
 			 */
-			ret = devm_iio_triggered_buffer_setup_ext(
-					dev, indio_dev, NULL, trigger_capture,
-					NULL, fifo_attrs);
+			ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					NULL, trigger_capture, NULL);
 			if (ret)
 				return ret;
 		}
diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
index 75d6b5fcf2cc4..de472f23d1cba 100644
--- a/drivers/iio/light/cros_ec_light_prox.c
+++ b/drivers/iio/light/cros_ec_light_prox.c
@@ -182,8 +182,7 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
 
 	ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
 					cros_ec_sensors_capture,
-					cros_ec_sensors_push_data,
-					true);
+					cros_ec_sensors_push_data);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
index aa043cb9ac426..2f882e1094232 100644
--- a/drivers/iio/pressure/cros_ec_baro.c
+++ b/drivers/iio/pressure/cros_ec_baro.c
@@ -139,8 +139,7 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
 
 	ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
 					cros_ec_sensors_capture,
-					cros_ec_sensors_push_data,
-					true);
+					cros_ec_sensors_push_data);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index c9b80be82440f..7ce8a8adad587 100644
--- a/include/linux/iio/common/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -96,8 +96,7 @@ struct platform_device;
 int cros_ec_sensors_core_init(struct platform_device *pdev,
 			      struct iio_dev *indio_dev, bool physical_device,
 			      cros_ec_sensors_capture_t trigger_capture,
-			      cros_ec_sensorhub_push_data_cb_t push_data,
-			      bool has_hw_fifo);
+			      cros_ec_sensorhub_push_data_cb_t push_data);
 
 irqreturn_t cros_ec_sensors_capture(int irq, void *p);
 int cros_ec_sensors_push_data(struct iio_dev *indio_dev,
-- 
2.30.1.766.gb4fecdf3b7-goog

