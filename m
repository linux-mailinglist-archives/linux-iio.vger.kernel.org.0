Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06760FD9D6
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2019 10:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfKOJvD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Nov 2019 04:51:03 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33902 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbfKOJun (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Nov 2019 04:50:43 -0500
Received: by mail-pg1-f193.google.com with SMTP id z188so5744278pgb.1
        for <linux-iio@vger.kernel.org>; Fri, 15 Nov 2019 01:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yJ3LspI9bF0hEvtS0gNH7CaeJvv/WTYfNb2xDCT4Co4=;
        b=LYE++QQcdVKyDuMJ0PD+qXUIM1TkL/v6Kq7zlSALHvb86aeCHvp5/UFe2opGhKc31i
         IPYTfseCb/Z6qnz6agX8d2oCZSN18jZ8tJUhFkXtncJMfN2+xJE8fWxXGnP4tTZl4pmw
         NLFEoY1sDQqcs9cwLjOodb8WACJMs/v0HVLw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yJ3LspI9bF0hEvtS0gNH7CaeJvv/WTYfNb2xDCT4Co4=;
        b=aaootKjjSO4qQwBXN+SybVgMpC7/iyThVnfdEC1gRr8PWjQZNNTIjq/dh7UM4+KGvd
         d6/c1CX8dTYDepy+qpgeiChONBy5o5aloFQmtZO+eZkwLWeGMTak6lgk2bxM9UtLVQYN
         RnxkO2lHzySvopZAo8XcamoGdFkKd0v8c19ADU/7XdGAWBLlZ3Nr/LvOMKSlFfK8YmsB
         AXsEL06EEY3NAugIfWEvHh/ZSF2xt6fPbWO2/1xA+rFfR4TO/qzN0OoJORDgHGzZUzM/
         7Y1NI1cTmf7+F/cSojL6lY9C9WdWdqBtCZe4HrUDibLEqrta9ydT7AkZ4kB8OZwEdzRz
         3JWg==
X-Gm-Message-State: APjAAAXYt1wTkV9kmNV6ityV9qeln/CnCpZMsm5M+iL9ri97UCv4k7L0
        yrZoY3dkpd2z+9DdDO/uHCd5cQ==
X-Google-Smtp-Source: APXvYqwwHqFIUmVq3LNxNOrcbHXviXbaYlqOee3tLM7yy6f75WoEHydhU9ewVsG5fhW7BveWqXZCQQ==
X-Received: by 2002:a62:180a:: with SMTP id 10mr16648263pfy.40.1573811441110;
        Fri, 15 Nov 2019 01:50:41 -0800 (PST)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id x13sm9989335pfc.46.2019.11.15.01.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2019 01:50:40 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     dmitry.torokhov@gmail.com, groeck@chromium.org,
        briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v5 14/18] iio: cros_ec: Register to cros_ec_sensorhub when EC supports FIFO
Date:   Fri, 15 Nov 2019 01:34:08 -0800
Message-Id: <20191115093412.144922-15-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191115093412.144922-1-gwendal@chromium.org>
References: <20191115093412.144922-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When EC supports FIFO, each IIO device registers a callback, to put
samples in the buffer when they arrives from the FIFO.
We can still use a trigger to collect samples, but there may be some
duplications in the buffer: EC has a single FIFO, so once one sensor is
using it, all sensors event will be in the FIFO.

When no FIFO, the user space app needs to call trigger_new, or better
register a high precision timer.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v5:
- Revert modes setting that were removed by mistake
- Remove unnecessary check when receving events from callback
- Set clock_id to boottime by default, as it is what sensorhub_ring is
  using.
- Update commit messages reference to time domain: trigger and hub
  generated events are always in the same time domain.
Changes in v4:
- Fix a logic error when the sensor is not "physical", for instance lig
  angle: core_init() would return !0 even if there was no error.
- Check patch with --strict option
    Use sizeof(*obj) instead of sizeof(struct ...obj)
    Alignement
Change in v3:
- Remove double line
- Fix indentation
- Add code to support iio clock_id setting. Optimized for
  CLOCK_BOOTTIME.
Change in v2 from "Use triggered buffer only when EC does not support
FIFO":
- Keep trigger all the time.
- Add  devm_add_action to cleanup callback registration.
- EC that "reports" legacy sensors do not have FIFO.
- Use iiio_is_buffer_enabled instead of checking the scan_mask
  before sending samples to buffer.
- Add empty lines for visibility.

 drivers/iio/accel/cros_ec_accel_legacy.c      |  8 +-
 .../cros_ec_sensors/cros_ec_lid_angle.c       |  2 +-
 .../common/cros_ec_sensors/cros_ec_sensors.c  |  9 +--
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 81 ++++++++++++++++++-
 drivers/iio/light/cros_ec_light_prox.c        |  9 +--
 drivers/iio/pressure/cros_ec_baro.c           |  9 +--
 .../linux/iio/common/cros_ec_sensors_core.h   | 10 ++-
 7 files changed, 101 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
index 65f85faf6f31..b9f651e4ce99 100644
--- a/drivers/iio/accel/cros_ec_accel_legacy.c
+++ b/drivers/iio/accel/cros_ec_accel_legacy.c
@@ -171,7 +171,8 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
 	if (!indio_dev)
 		return -ENOMEM;
 
-	ret = cros_ec_sensors_core_init(pdev, indio_dev, true);
+	ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
+					cros_ec_sensors_capture, NULL);
 	if (ret)
 		return ret;
 
@@ -191,11 +192,6 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
 		state->sign[CROS_EC_SENSOR_Z] = -1;
 	}
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
-			cros_ec_sensors_capture, NULL);
-	if (ret)
-		return ret;
-
 	return devm_iio_device_register(dev, indio_dev);
 }
 
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
index 1dcc2a16ab2d..e30a59fcf0f9 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
@@ -97,7 +97,7 @@ static int cros_ec_lid_angle_probe(struct platform_device *pdev)
 	if (!indio_dev)
 		return -ENOMEM;
 
-	ret = cros_ec_sensors_core_init(pdev, indio_dev, false);
+	ret = cros_ec_sensors_core_init(pdev, indio_dev, false, NULL, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index 7dce04473467..62a0dd970988 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -231,7 +231,9 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
 	if (!indio_dev)
 		return -ENOMEM;
 
-	ret = cros_ec_sensors_core_init(pdev, indio_dev, true);
+	ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
+					cros_ec_sensors_capture,
+					cros_ec_sensors_push_data);
 	if (ret)
 		return ret;
 
@@ -293,11 +295,6 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
 	else
 		state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
-			cros_ec_sensors_capture, NULL);
-	if (ret)
-		return ret;
-
 	return devm_iio_device_register(dev, indio_dev);
 }
 
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index b47da497a3c3..cffc712c32a7 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -12,6 +12,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 #include <linux/kernel.h>
 #include <linux/mfd/cros_ec.h>
 #include <linux/module.h>
@@ -83,17 +84,71 @@ static void get_default_min_max_freq(enum motionsensor_type type,
 	}
 }
 
+int cros_ec_sensors_push_data(struct iio_dev *indio_dev,
+			      s16 *data,
+			      s64 timestamp)
+{
+	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
+	s16 *out;
+	s64 delta;
+	unsigned int i;
+
+	/*
+	 * Ignore samples if the buffer is not set: it is needed if the ODR is
+	 * set but the buffer is not enabled yet.
+	 */
+	if (!iio_buffer_enabled(indio_dev))
+		return 0;
+
+	out = (s16 *)st->samples;
+	for_each_set_bit(i,
+			 indio_dev->active_scan_mask,
+			 indio_dev->masklength) {
+		*out = data[i];
+		out++;
+	}
+
+	if (iio_device_get_clock(indio_dev) != CLOCK_BOOTTIME)
+		delta = iio_get_time_ns(indio_dev) - cros_ec_get_time_ns();
+	else
+		delta = 0;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, st->samples,
+					   timestamp + delta);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cros_ec_sensors_push_data);
+
+static void cros_ec_sensors_core_clean(void *arg)
+{
+	struct platform_device *pdev = (struct platform_device *)arg;
+	struct cros_ec_sensorhub *sensor_hub =
+		dev_get_drvdata(pdev->dev.parent);
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
+	u8 sensor_num = st->param.info.sensor_num;
+
+	cros_ec_sensorhub_unregister_push_data(sensor_hub, sensor_num);
+}
+
 /**
  * cros_ec_sensors_core_init() - basic initialization of the core structure
  * @pdev:		platform device created for the sensors
  * @indio_dev:		iio device structure of the device
  * @physical_device:	true if the device refers to a physical device
+ * @trigger_capture:    function pointer to call buffer is triggered,
+ *    for backward compatibility.
+ * @push_data:          function to call when cros_ec_sensorhub receives
+ *    a sample for that sensor.
  *
  * Return: 0 on success, -errno on failure.
  */
 int cros_ec_sensors_core_init(struct platform_device *pdev,
 			      struct iio_dev *indio_dev,
-			      bool physical_device)
+			      bool physical_device,
+			      cros_ec_sensors_capture_t trigger_capture,
+			      cros_ec_sensorhub_push_data_cb_t push_data)
 {
 	struct device *dev = &pdev->dev;
 	struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
@@ -162,6 +217,30 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 			state->frequencies[2] =
 			    state->resp->info_3.max_frequency;
 		}
+
+		ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+						      trigger_capture, NULL);
+		if (ret)
+			return ret;
+
+		if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
+			ret = cros_ec_sensorhub_register_push_data(sensor_hub,
+						sensor_platform->sensor_num,
+						indio_dev, push_data);
+			if (ret)
+				return ret;
+
+			ret = devm_add_action_or_reset(dev,
+						cros_ec_sensors_core_clean,
+						pdev);
+			if (ret)
+				return ret;
+
+			/* Timestamp coming from FIFO are in ns since boot. */
+			ret = iio_device_set_clock(indio_dev, CLOCK_BOOTTIME);
+			if (ret)
+				return ret;
+		}
 	}
 
 	return 0;
diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
index d85a391e50c5..698b2ee81ebf 100644
--- a/drivers/iio/light/cros_ec_light_prox.c
+++ b/drivers/iio/light/cros_ec_light_prox.c
@@ -178,7 +178,9 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
 	if (!indio_dev)
 		return -ENOMEM;
 
-	ret = cros_ec_sensors_core_init(pdev, indio_dev, true);
+	ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
+					cros_ec_sensors_capture,
+					cros_ec_sensors_push_data);
 	if (ret)
 		return ret;
 
@@ -237,11 +239,6 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
 
 	state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
-					      cros_ec_sensors_capture, NULL);
-	if (ret)
-		return ret;
-
 	return devm_iio_device_register(dev, indio_dev);
 }
 
diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
index 2354302375de..e1c86b22676c 100644
--- a/drivers/iio/pressure/cros_ec_baro.c
+++ b/drivers/iio/pressure/cros_ec_baro.c
@@ -134,7 +134,9 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
 	if (!indio_dev)
 		return -ENOMEM;
 
-	ret = cros_ec_sensors_core_init(pdev, indio_dev, true);
+	ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
+					cros_ec_sensors_capture,
+					cros_ec_sensors_push_data);
 	if (ret)
 		return ret;
 
@@ -180,11 +182,6 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
 
 	state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
-					      cros_ec_sensors_capture, NULL);
-	if (ret)
-		return ret;
-
 	return devm_iio_device_register(dev, indio_dev);
 }
 
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index 0af918978f97..b8f573ca9dcc 100644
--- a/include/linux/iio/common/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -12,6 +12,7 @@
 #include <linux/irqreturn.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
+#include <linux/platform_data/cros_ec_sensorhub.h>
 
 enum {
 	CROS_EC_SENSOR_X,
@@ -32,6 +33,8 @@ enum {
 /* Minimum sampling period to use when device is suspending */
 #define CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY 1000  /* 1 second */
 
+typedef irqreturn_t (*cros_ec_sensors_capture_t)(int irq, void *p);
+
 /**
  * struct cros_ec_sensors_core_state - state data for EC sensors IIO driver
  * @ec:				cros EC device structure
@@ -87,9 +90,14 @@ int cros_ec_sensors_read_cmd(struct iio_dev *indio_dev, unsigned long scan_mask,
 
 struct platform_device;
 int cros_ec_sensors_core_init(struct platform_device *pdev,
-			      struct iio_dev *indio_dev, bool physical_device);
+			      struct iio_dev *indio_dev, bool physical_device,
+			      cros_ec_sensors_capture_t trigger_capture,
+			      cros_ec_sensorhub_push_data_cb_t push_data);
 
 irqreturn_t cros_ec_sensors_capture(int irq, void *p);
+int cros_ec_sensors_push_data(struct iio_dev *indio_dev,
+			      s16 *data,
+			      s64 timestamp);
 
 int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *st,
 				 u16 opt_length);
-- 
2.24.0.432.g9d3f5f5b63-goog

