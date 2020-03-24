Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA56191AF9
	for <lists+linux-iio@lfdr.de>; Tue, 24 Mar 2020 21:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgCXU14 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Mar 2020 16:27:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41846 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbgCXU1z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Mar 2020 16:27:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id z65so9894721pfz.8
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2020 13:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wk1E5NST0hP0snf8CIvKzpAWiRfamSLnbLwOE0ZpuJ8=;
        b=n0ss82B2aZDbDi9wyAzWCCxa9fYKUh6ivd2p9DsSxRalwBVJaH0hQ2aZUUoNbiWGo0
         kXp0DAIl8E0gqAQbJy+Z63MYkwq9cKsRkIbEIFWtmSO9IcCxsDs4Hstr7huV4J6EQetO
         aU72aYisy/+RIVJ+nVGzpgqxXfQqNTOfH+cqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wk1E5NST0hP0snf8CIvKzpAWiRfamSLnbLwOE0ZpuJ8=;
        b=j1+fyr+xQvaIl8p6r7QZMYhCPPZBpsdmmMKZWEulXKnpD4El1JTyRhZeLxqJY9dGxo
         JpkfKlkv1QWFo2/ZwN86HSnj7dKOME2Ok+Bgnu4738JcxOooG0vha37picU8XXop7dK7
         mnw4TRaDfzAPQUpWLxsdPSYQtfZ5vqsSrWupFKSfo4+1DYu0c6WuV8oUyd5JdxlcUk99
         8GBOjEBOk0zaItE3uQYB4FZvajpAkyxwFG81Y2phwbwCJDqHHmoPWYCtSCtCgHebOg5A
         /pubBvkgHdQ3G0GBCfmMuU5cFGEgAGmF8mdvPaxfaUqM51QwcYcymmGBlPibhII4kdMN
         r2/w==
X-Gm-Message-State: ANhLgQ2AmUxn82OBjKMOm3zJsZDQAfhKKNFQGnkkKIr/V6ZZEReFW8JK
        iM4LgkkUTkhBekwqnSI2dNgrSA==
X-Google-Smtp-Source: ADFU+vtCGSBfZrxRiioO/CYimNmrIYMrHFVgxk72ONRL+x9Leh9KHD5rND+CszLYomDNjzpV3fcCHQ==
X-Received: by 2002:a62:834c:: with SMTP id h73mr2259096pfe.59.1585081673799;
        Tue, 24 Mar 2020 13:27:53 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id i4sm15412462pgo.23.2020.03.24.13.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 13:27:53 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        Jonathan.Cameron@huawei.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v6 06/11] iio: cros_ec: Register to cros_ec_sensorhub when EC supports FIFO
Date:   Tue, 24 Mar 2020 13:27:31 -0700
Message-Id: <20200324202736.243314-7-gwendal@chromium.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200324202736.243314-1-gwendal@chromium.org>
References: <20200324202736.243314-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When EC supports FIFO, each IIO device registers a callback, to put
samples in the buffer when they arrives from the FIFO.

When no FIFO, the user space app needs to call trigger_new, or better
register a high precision timer.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v6:
- Revert code from v2 that allow trigger in FIFO mode. It was causing
  a crash when events would flow from hardware FIFO in but no triggers
  were setup.
  Creating a triggered buffers and a hardware interrupt trigger from
  the sensorhub and having to connect the trigger to sensor before use
  was not practical.
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

 drivers/iio/accel/cros_ec_accel_legacy.c      |   8 +-
 .../cros_ec_sensors/cros_ec_lid_angle.c       |   2 +-
 .../common/cros_ec_sensors/cros_ec_sensors.c  |   9 +-
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 101 +++++++++++++++++-
 drivers/iio/light/cros_ec_light_prox.c        |   9 +-
 drivers/iio/pressure/cros_ec_baro.c           |   9 +-
 .../linux/iio/common/cros_ec_sensors_core.h   |  10 +-
 7 files changed, 119 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
index 68e847c6255e3..2532b9ad33842 100644
--- a/drivers/iio/accel/cros_ec_accel_legacy.c
+++ b/drivers/iio/accel/cros_ec_accel_legacy.c
@@ -170,7 +170,8 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
 	if (!indio_dev)
 		return -ENOMEM;
 
-	ret = cros_ec_sensors_core_init(pdev, indio_dev, true);
+	ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
+					cros_ec_sensors_capture, NULL);
 	if (ret)
 		return ret;
 
@@ -190,11 +191,6 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
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
index 1dcc2a16ab2dd..e30a59fcf0f95 100644
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
index 576e45faafaff..711134d67ddee 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -230,7 +230,9 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
 	if (!indio_dev)
 		return -ENOMEM;
 
-	ret = cros_ec_sensors_core_init(pdev, indio_dev, true);
+	ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
+					cros_ec_sensors_capture,
+					cros_ec_sensors_push_data);
 	if (ret)
 		return ret;
 
@@ -292,11 +294,6 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
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
index f3c000448b90e..01513cb933653 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -12,6 +12,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -82,17 +83,71 @@ static void get_default_min_max_freq(enum motionsensor_type type,
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
@@ -131,8 +186,6 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 	indio_dev->name = pdev->name;
 
 	if (physical_device) {
-		indio_dev->modes = INDIO_DIRECT_MODE;
-
 		state->param.cmd = MOTIONSENSE_CMD_INFO;
 		state->param.info.sensor_num = sensor_platform->sensor_num;
 		ret = cros_ec_motion_send_host_cmd(state, 0);
@@ -161,6 +214,48 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 			state->frequencies[2] =
 			    state->resp->info_3.max_frequency;
 		}
+
+		if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
+			/*
+			 * Create a software buffer, feed by the EC FIFO.
+			 * We can not use trigger here, as events are generated
+			 * as soon as sample_frequency is set.
+			 */
+			struct iio_buffer *buffer;
+
+			buffer = devm_iio_kfifo_allocate(dev);
+			if (!buffer)
+				return -ENOMEM;
+
+			iio_device_attach_buffer(indio_dev, buffer);
+			indio_dev->modes = INDIO_BUFFER_SOFTWARE;
+
+			ret = cros_ec_sensorhub_register_push_data(
+					sensor_hub, sensor_platform->sensor_num,
+					indio_dev, push_data);
+			if (ret)
+				return ret;
+
+			ret = devm_add_action_or_reset(
+					dev, cros_ec_sensors_core_clean, pdev);
+			if (ret)
+				return ret;
+
+			/* Timestamp coming from FIFO are in ns since boot. */
+			ret = iio_device_set_clock(indio_dev, CLOCK_BOOTTIME);
+			if (ret)
+				return ret;
+		} else {
+			/*
+			 * The only way to get samples in buffer is to set a
+			 * software tigger (systrig, hrtimer).
+			 */
+			ret = devm_iio_triggered_buffer_setup(
+					dev, indio_dev, NULL, trigger_capture,
+					NULL);
+			if (ret)
+				return ret;
+		}
 	}
 
 	return 0;
diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
index 7a838e2956f40..03c951ff4a3c3 100644
--- a/drivers/iio/light/cros_ec_light_prox.c
+++ b/drivers/iio/light/cros_ec_light_prox.c
@@ -177,7 +177,9 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
 	if (!indio_dev)
 		return -ENOMEM;
 
-	ret = cros_ec_sensors_core_init(pdev, indio_dev, true);
+	ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
+					cros_ec_sensors_capture,
+					cros_ec_sensors_push_data);
 	if (ret)
 		return ret;
 
@@ -236,11 +238,6 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
 
 	state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
-					      cros_ec_sensors_capture, NULL);
-	if (ret)
-		return ret;
-
 	return devm_iio_device_register(dev, indio_dev);
 }
 
diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
index b521bebd551c7..6add499f11aa6 100644
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
 
@@ -182,11 +184,6 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
 
 	state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
-					      cros_ec_sensors_capture, NULL);
-	if (ret)
-		return ret;
-
 	return devm_iio_device_register(dev, indio_dev);
 }
 
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index 0af918978f975..b8f573ca9dcc9 100644
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
2.25.1.696.g5e7596f4ac-goog

