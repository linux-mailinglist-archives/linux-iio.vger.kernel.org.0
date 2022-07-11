Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDDE570616
	for <lists+linux-iio@lfdr.de>; Mon, 11 Jul 2022 16:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiGKOrd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Jul 2022 10:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbiGKOr1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jul 2022 10:47:27 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8456D9F2
        for <linux-iio@vger.kernel.org>; Mon, 11 Jul 2022 07:47:26 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso5198971pjo.0
        for <linux-iio@vger.kernel.org>; Mon, 11 Jul 2022 07:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wqENu/60B82824PXLnXSadIOITmkFm3XM5ALm/fLyyw=;
        b=a1gClb3hX424TQ3NcQ7jdx1ouFdKl47baF+kRVTTDoWMJxnWnBzVxAfoDuqToztA4w
         d4g3pxZIU/vA6WbrXuIzFN2nyzfyHhZXkO9wpPDFl5dgBun7LJQacbtUxV6nO+j/H+0K
         J03EDgfi1Mn3dtllBSwQWXD+pWmYVjkouewdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wqENu/60B82824PXLnXSadIOITmkFm3XM5ALm/fLyyw=;
        b=mnqm/q5ftXhby1dBRX9v0hFNOTHgVEtvpx1FCZyL0tSnYoNiIXtdG5/xXNz9kSknPJ
         dKClhkhv2lIJL8ltijJESPYXXIlIiRJPNN8K2WucbHrgDpLEQDGD/hJEsmUf7dhejGvj
         5CK2oG1q1r97/R1KzVZx74WdQG3iINEfwAxs6sTErsB6Xdor//yKPirLVWLmSn56r60w
         uVSnLIz5vKirfPK2lWYte3w6TptnfTds1K2XMFkQne6MgFsBQtcfnUHOJ7/ZyUOm3GnL
         73N2SsbziatCI2/S8mhthh23F9WFdyUi5T1UBRxw0KNAH3gcOU85Emk7JRXJxcdcOa5G
         0uDg==
X-Gm-Message-State: AJIora+0d0Y1U+wHvv5MLHHXJFvpX9lhqmyeBtyNszywAjglw90NrTg8
        Qxn4A2wbEE4066HAyHN2tTDCZg==
X-Google-Smtp-Source: AGRyM1uLfvgVhiU/SllAtzzYwe9MJqytvU7p38QVJ3+UELDfP59osvsCdokWCTfx94VUI4ZVmIN/MA==
X-Received: by 2002:a17:902:cad5:b0:16b:e3f1:fd8e with SMTP id y21-20020a170902cad500b0016be3f1fd8emr19329391pld.106.1657550845501;
        Mon, 11 Jul 2022 07:47:25 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:a6a:eff7:697d:ea1a])
        by smtp.gmail.com with UTF8SMTPSA id s137-20020a63778f000000b0040d1eb90d67sm4280291pgc.93.2022.07.11.07.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 07:47:25 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, dianders@chromium.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3] iio: cros: Register FIFO callback after sensor is registered
Date:   Mon, 11 Jul 2022 07:47:16 -0700
Message-Id: <20220711144716.642617-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Instead of registering callback to process sensor events right at
initialization time, wait for the sensor to be register in the iio
subsystem.

Events can come at probe time (in case the kernel rebooted abruptly
without switching the sensor off for  instance), and be sent to IIO core
before the sensor is fully registered.

Reported-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes since v2:
- Do not compare pointer with NULL,
- Invert logic to reduce indentation.
- Do not set local variable just before use.

Changes since v1:
- renamed from "iio: cros: Add cros_ec_sensors_core_register"
- Call devm_iio_device_register() inside cros_ec_sensors_core_register.

 drivers/iio/accel/cros_ec_accel_legacy.c      |  4 +-
 .../cros_ec_sensors/cros_ec_lid_angle.c       |  4 +-
 .../common/cros_ec_sensors/cros_ec_sensors.c  |  6 +-
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 58 ++++++++++++++-----
 drivers/iio/light/cros_ec_light_prox.c        |  6 +-
 drivers/iio/pressure/cros_ec_baro.c           |  6 +-
 .../linux/iio/common/cros_ec_sensors_core.h   |  7 ++-
 7 files changed, 60 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
index 1c0171f26e99e..0f403342b1fc0 100644
--- a/drivers/iio/accel/cros_ec_accel_legacy.c
+++ b/drivers/iio/accel/cros_ec_accel_legacy.c
@@ -215,7 +215,7 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
-					cros_ec_sensors_capture, NULL);
+					cros_ec_sensors_capture);
 	if (ret)
 		return ret;
 
@@ -235,7 +235,7 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
 		state->sign[CROS_EC_SENSOR_Z] = -1;
 	}
 
-	return devm_iio_device_register(dev, indio_dev);
+	return cros_ec_sensors_core_register(dev, indio_dev, NULL);
 }
 
 static struct platform_driver cros_ec_accel_platform_driver = {
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
index 9f780fafaed9f..119acb078af3b 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
@@ -98,7 +98,7 @@ static int cros_ec_lid_angle_probe(struct platform_device *pdev)
 	if (!indio_dev)
 		return -ENOMEM;
 
-	ret = cros_ec_sensors_core_init(pdev, indio_dev, false, NULL, NULL);
+	ret = cros_ec_sensors_core_init(pdev, indio_dev, false, NULL);
 	if (ret)
 		return ret;
 
@@ -114,7 +114,7 @@ static int cros_ec_lid_angle_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(dev, indio_dev);
+	return cros_ec_sensors_core_register(dev, indio_dev, NULL);
 }
 
 static const struct platform_device_id cros_ec_lid_angle_ids[] = {
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index 61e07a7bb1995..66153b1850f10 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -236,8 +236,7 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
-					cros_ec_sensors_capture,
-					cros_ec_sensors_push_data);
+					cros_ec_sensors_capture);
 	if (ret)
 		return ret;
 
@@ -298,7 +297,8 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
 	else
 		state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
 
-	return devm_iio_device_register(dev, indio_dev);
+	return cros_ec_sensors_core_register(dev, indio_dev,
+			cros_ec_sensors_push_data);
 }
 
 static const struct platform_device_id cros_ec_sensors_ids[] = {
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index e5ccedef13a80..05a28d353e343 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -228,21 +228,18 @@ static void cros_ec_sensors_core_clean(void *arg)
 
 /**
  * cros_ec_sensors_core_init() - basic initialization of the core structure
- * @pdev:		platform device created for the sensors
+ * @pdev:		platform device created for the sensor
  * @indio_dev:		iio device structure of the device
  * @physical_device:	true if the device refers to a physical device
  * @trigger_capture:    function pointer to call buffer is triggered,
  *    for backward compatibility.
- * @push_data:          function to call when cros_ec_sensorhub receives
- *    a sample for that sensor.
  *
  * Return: 0 on success, -errno on failure.
  */
 int cros_ec_sensors_core_init(struct platform_device *pdev,
 			      struct iio_dev *indio_dev,
 			      bool physical_device,
-			      cros_ec_sensors_capture_t trigger_capture,
-			      cros_ec_sensorhub_push_data_cb_t push_data)
+			      cros_ec_sensors_capture_t trigger_capture)
 {
 	struct device *dev = &pdev->dev;
 	struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
@@ -340,17 +337,6 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 			if (ret)
 				return ret;
 
-			ret = cros_ec_sensorhub_register_push_data(
-					sensor_hub, sensor_platform->sensor_num,
-					indio_dev, push_data);
-			if (ret)
-				return ret;
-
-			ret = devm_add_action_or_reset(
-					dev, cros_ec_sensors_core_clean, pdev);
-			if (ret)
-				return ret;
-
 			/* Timestamp coming from FIFO are in ns since boot. */
 			ret = iio_device_set_clock(indio_dev, CLOCK_BOOTTIME);
 			if (ret)
@@ -372,6 +358,46 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(cros_ec_sensors_core_init);
 
+/**
+ * cros_ec_sensors_core_register() - Register callback to FIFO and IIO when
+ * sensor is ready.
+ * It must be called at the end of the sensor probe routine.
+ * @dev:		device created for the sensor
+ * @indio_dev:		iio device structure of the device
+ * @push_data:          function to call when cros_ec_sensorhub receives
+ *    a sample for that sensor.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int cros_ec_sensors_core_register(struct device *dev,
+				  struct iio_dev *indio_dev,
+				  cros_ec_sensorhub_push_data_cb_t push_data)
+{
+	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
+	struct cros_ec_sensorhub *sensor_hub = dev_get_drvdata(dev->parent);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct cros_ec_dev *ec = sensor_hub->ec;
+	int ret;
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ret;
+
+	if (!push_data ||
+	    !cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO))
+		return 0;
+
+	ret = cros_ec_sensorhub_register_push_data(
+			sensor_hub, sensor_platform->sensor_num,
+			indio_dev, push_data);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(
+			dev, cros_ec_sensors_core_clean, pdev);
+}
+EXPORT_SYMBOL_GPL(cros_ec_sensors_core_register);
+
 /**
  * cros_ec_motion_send_host_cmd() - send motion sense host command
  * @state:		pointer to state information for device
diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
index e345e0f71b740..19e529c84e957 100644
--- a/drivers/iio/light/cros_ec_light_prox.c
+++ b/drivers/iio/light/cros_ec_light_prox.c
@@ -182,8 +182,7 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
-					cros_ec_sensors_capture,
-					cros_ec_sensors_push_data);
+					cros_ec_sensors_capture);
 	if (ret)
 		return ret;
 
@@ -239,7 +238,8 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
 
 	state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
 
-	return devm_iio_device_register(dev, indio_dev);
+	return cros_ec_sensors_core_register(dev, indio_dev,
+					     cros_ec_sensors_push_data);
 }
 
 static const struct platform_device_id cros_ec_light_prox_ids[] = {
diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
index 25217279f3507..2649c2f89e898 100644
--- a/drivers/iio/pressure/cros_ec_baro.c
+++ b/drivers/iio/pressure/cros_ec_baro.c
@@ -139,8 +139,7 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
-					cros_ec_sensors_capture,
-					cros_ec_sensors_push_data);
+					cros_ec_sensors_capture);
 	if (ret)
 		return ret;
 
@@ -185,7 +184,8 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
 
 	state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
 
-	return devm_iio_device_register(dev, indio_dev);
+	return cros_ec_sensors_core_register(dev, indio_dev,
+					     cros_ec_sensors_push_data);
 }
 
 static const struct platform_device_id cros_ec_baro_ids[] = {
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index a8259c8822f56..e72167b96d27e 100644
--- a/include/linux/iio/common/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -93,8 +93,11 @@ int cros_ec_sensors_read_cmd(struct iio_dev *indio_dev, unsigned long scan_mask,
 struct platform_device;
 int cros_ec_sensors_core_init(struct platform_device *pdev,
 			      struct iio_dev *indio_dev, bool physical_device,
-			      cros_ec_sensors_capture_t trigger_capture,
-			      cros_ec_sensorhub_push_data_cb_t push_data);
+			      cros_ec_sensors_capture_t trigger_capture);
+
+int cros_ec_sensors_core_register(struct device *dev,
+				  struct iio_dev *indio_dev,
+				  cros_ec_sensorhub_push_data_cb_t push_data);
 
 irqreturn_t cros_ec_sensors_capture(int irq, void *p);
 int cros_ec_sensors_push_data(struct iio_dev *indio_dev,
-- 
2.37.0.rc0.161.g10f37bed90-goog

