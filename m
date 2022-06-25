Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB3355ACE8
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jun 2022 00:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbiFYWYs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Jun 2022 18:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiFYWYr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Jun 2022 18:24:47 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73D113D51
        for <linux-iio@vger.kernel.org>; Sat, 25 Jun 2022 15:24:46 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id jb13so5063023plb.9
        for <linux-iio@vger.kernel.org>; Sat, 25 Jun 2022 15:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UXlF06FaD8KDiG+JfqFrHNDFhGUpqj2/rjt064pHY0s=;
        b=M7AYRhXN0wVSqf223DciiKtcsRmKTFAFQKsvIuVStHGVpIMcmPvde6KXmHMnnxs7Me
         DtG62LdTtGFpk578pwzYOqDmMdIQyqXThs2thkfnkHSHBDekH2MCH1WjrjWNU37NC/Nd
         8m0UDnVfljhXWKQVuEKoRfpAXzsYnk0QKqFaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UXlF06FaD8KDiG+JfqFrHNDFhGUpqj2/rjt064pHY0s=;
        b=yeGEygOi/XtEJSvoIrxh1ACycfQjaYNs4iy5vvqiWaCFhzyDh4TDVDSWIpJkXgO7gM
         JJNVuBY7U0qIu5cD1COKWjh1pTD1mmACsRNVz7YEam6KTd7So5gh5uMQMTd1NmESaxkH
         Y2aK9VeO/LwwIVxDNdcxIoRyCDPnhUzAdZjPdeweRPX0X6yoaupAkVRrcAcDYIAwnnbb
         YoGXPKnJb37ys0OFBi7b+HlT4MY5WzUfwcFdEeZNKoE7dAmRxIjzH92Pr0/ZZN/0TyAi
         jqI7F+xBnx42c255Z4sOpfvayyrVXBVO/30lPOVYpGtmK3mXFs4vuUBURHpsqeXp4MuH
         WSJg==
X-Gm-Message-State: AJIora8V/qevdYsOZ3xvpX8BEBGVqn2F97YzW6pzJlExjq2+Z9ugX84B
        CQjspzDOe0irqlWzzzig+cv8Bg==
X-Google-Smtp-Source: AGRyM1tpB3iXd58F6qQfROJy408oxyltHtEHcTLYHtqVszma50w+AUo26EIMNf47aWCQaYs9FfFQVQ==
X-Received: by 2002:a17:90a:64cc:b0:1ec:c7bc:d998 with SMTP id i12-20020a17090a64cc00b001ecc7bcd998mr6588430pjm.21.1656195886167;
        Sat, 25 Jun 2022 15:24:46 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:1f1b:ac36:ee4f:cd78])
        by smtp.gmail.com with UTF8SMTPSA id f11-20020a62380b000000b0051829b1595dsm4080742pfa.130.2022.06.25.15.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 15:24:45 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, dianders@chromium.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2] iio: cros: Register FIFO callback after sensor is registered
Date:   Sat, 25 Jun 2022 15:24:43 -0700
Message-Id: <20220625222443.2906866-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <CAPUE2usKnbvXw5wBLq-w4ZkftAqZdiwQHu51rWi_-Dw8PoC9_Q@mail.gmail.com>
References: <CAPUE2usKnbvXw5wBLq-w4ZkftAqZdiwQHu51rWi_-Dw8PoC9_Q@mail.gmail.com>
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
index e5ccedef13a80..b5317e6339598 100644
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
+	int ret = 0;
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ret;
+
+	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO) &&
+	    push_data != NULL) {
+		ret = cros_ec_sensorhub_register_push_data(
+				sensor_hub, sensor_platform->sensor_num,
+				indio_dev, push_data);
+		if (ret)
+			return ret;
+
+		ret = devm_add_action_or_reset(
+				dev, cros_ec_sensors_core_clean, pdev);
+	}
+	return ret;
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

