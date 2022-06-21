Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEBA553983
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 20:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiFUS3M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 14:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiFUS3M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 14:29:12 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DA73B3
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 11:29:10 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id i15so13271934plr.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 11:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S7ZzwyfAWhVH5eDfksXCoq7Nf+vZ6RRrRQUl8NcEmCo=;
        b=Va8ZSu46cH4vxhoTH2BpMT69/giDhMWkt2c0lFAI1ASHEUOyd0A0Frrhl5T/TvSeVt
         A4C1PJ1LAhokE28DDamuDztnhCKsmPuOzYY1015+23tGtw050VrEec7CRKFMDr8BopFd
         h2OSM5sDF6U5ajYtZQ8MfZkHNLXqEMBUytezU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S7ZzwyfAWhVH5eDfksXCoq7Nf+vZ6RRrRQUl8NcEmCo=;
        b=aahDTRGV/iLqLOxZ3wS9NbrMYzbiGlnii3kV05e8z3vF5VSucrXVPxSAm80C9WeaIt
         dSN0YJELTOvjoyOOPnnUOwJ5R2kivWbHAohtJjn7mpRKjOMjzMAldEhREHHg1vj1UZK5
         KA78TFcyj15SSDb7Q3fAqoM5NpCqSF1nrw1X6zOFz+1tjPERVZK2zFrIj99GCHdFqr1V
         f/wkwesE4VUtbc0o9egXBBzgSW4/KNvPxdqRkhHe2G7OnPvNQ34+hap23CzjelE5VcXx
         wMQeDopNPOgupUT7eLyMoHmRimbXgi0hxfPJ9XIt9aF9i4AvGfqX65w2FfW5i+lKZ0HD
         LwOg==
X-Gm-Message-State: AJIora/1Mx7GBD9X/sqNmq2nGk721mzcpXL44QfO1N7N9oZjgdAXNwIw
        d1WqVVs1h5NbX2L+G0UA6L4jTw==
X-Google-Smtp-Source: AGRyM1sv4I6eUjK6dItx94FfRFlBgO55Z5UxuIuV0VXmfpz6dppcPZgsYP3HLd7setxICFgrBW84DA==
X-Received: by 2002:a17:902:9b83:b0:164:59e:b189 with SMTP id y3-20020a1709029b8300b00164059eb189mr29420745plp.91.1655836150417;
        Tue, 21 Jun 2022 11:29:10 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:4bc3:6b2:6061:1923])
        by smtp.gmail.com with UTF8SMTPSA id o22-20020a17090a421600b001ec9b7efec2sm5142151pjg.5.2022.06.21.11.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 11:29:09 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, dianders@chromium.org, swboyd@chromium.org
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] iio: cros: Add cros_ec_sensors_core_register
Date:   Tue, 21 Jun 2022 11:28:59 -0700
Message-Id: <20220621182859.459045-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
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
without switching the sensor off for instance).

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 .../cros_ec_sensors/cros_ec_lid_angle.c       |  2 +-
 .../common/cros_ec_sensors/cros_ec_sensors.c  | 11 +++--
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 49 +++++++++++++------
 drivers/iio/light/cros_ec_light_prox.c        | 10 ++--
 drivers/iio/pressure/cros_ec_baro.c           | 11 +++--
 .../linux/iio/common/cros_ec_sensors_core.h   |  7 ++-
 6 files changed, 63 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
index 9f780fafaed9f..4e569f76bb8cd 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
@@ -98,7 +98,7 @@ static int cros_ec_lid_angle_probe(struct platform_device *pdev)
 	if (!indio_dev)
 		return -ENOMEM;
 
-	ret = cros_ec_sensors_core_init(pdev, indio_dev, false, NULL, NULL);
+	ret = cros_ec_sensors_core_init(pdev, indio_dev, false, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index 61e07a7bb1995..d3c456e8c313d 100644
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
 
@@ -298,7 +297,13 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
 	else
 		state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
 
-	return devm_iio_device_register(dev, indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ret;
+
+	/* Ready to receive samples from the EC. */
+	return cros_ec_sensors_core_register(dev, indio_dev,
+			cros_ec_sensors_push_data);
 }
 
 static const struct platform_device_id cros_ec_sensors_ids[] = {
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index e5ccedef13a80..5bf5cfb0e746b 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -233,16 +233,13 @@ static void cros_ec_sensors_core_clean(void *arg)
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
@@ -372,6 +358,39 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(cros_ec_sensors_core_init);
 
+/**
+ * cros_ec_sensors_core_register() - Register callback to FIFO when sensor is
+ * ready.
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
+	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
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
index e345e0f71b740..ec176b1ac84db 100644
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
 
@@ -239,7 +238,12 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
 
 	state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
 
-	return devm_iio_device_register(dev, indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ret;
+
+	return cros_ec_sensors_core_register(dev, indio_dev,
+					     cros_ec_sensors_push_data);
 }
 
 static const struct platform_device_id cros_ec_light_prox_ids[] = {
diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
index 25217279f3507..82f20c738a165 100644
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
 
@@ -185,7 +184,13 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
 
 	state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
 
-	return devm_iio_device_register(dev, indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ret;
+
+	/* Ready to receive samples from the EC. */
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
2.37.0.rc0.104.g0611611a94-goog

