Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C1033DEC3
	for <lists+linux-iio@lfdr.de>; Tue, 16 Mar 2021 21:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhCPU3t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Mar 2021 16:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhCPU31 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Mar 2021 16:29:27 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6744C06174A
        for <linux-iio@vger.kernel.org>; Tue, 16 Mar 2021 13:29:26 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t37so12583012pga.11
        for <linux-iio@vger.kernel.org>; Tue, 16 Mar 2021 13:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9FCexO+02dVoKLf6LgP7JwSIf93VFK8yKEpi69INHDY=;
        b=J84guKzlelFM/tR7DaXbOsR9IjKFknMIbF3hZF15ErhQFq78nV5yupp1/1ZyMOuL5N
         RmObdSIXgLCOj8wILayrH8GEMsYOR6m7siz3EncwyJ1A9F0CLUTNCDvOZmbWd1WPbcni
         NxDUUEhMjOAx4Qwv2cVAefxtbPBwmhhMAf5c4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9FCexO+02dVoKLf6LgP7JwSIf93VFK8yKEpi69INHDY=;
        b=q0NEN87By5ynSsFNAyqRa9xiH2t5VZEUe/iqKDvQLqQ72HbyTrJb4TuU1A6QYRcAfM
         ugPi6NK45cj6qa5owYIVWeiO775p1oOlwGaE6N/SeSs3UjielBXYrNCrvEX1rdmbZSa/
         l/aT5ZzHyf9PQqVCXqMtSXmqU7NhpWR8oNpQ0dBQ3bb/GvPkY2dWoi1ld8FCjwQDdou7
         NubtuqKDUytYl3dqIEsPrzEv7OH66L/eelJo/j4iW5dplvqNRCPu8+sSynyD/Vyzbizf
         5D9OXRhvdHXZejuU0B6rKOKRwQ6fuajAc2DNesdLK/OgKTW/T/J+W0GUHtlL4nC19Dc8
         72CQ==
X-Gm-Message-State: AOAM530/p6ekWP0x+ndE6shpVAArZddTKjdORu4wmJnp9Xj2/SWvu9kC
        jzcp5bMS6SNhBUMGvHeOC5OzXA==
X-Google-Smtp-Source: ABdhPJwaeZBcEvb/fBc0sF/ckgyDXY0RXaFyuEEH57qKi/ncR46hjVuBlJxTc6NDcdjjH0EyarC/qg==
X-Received: by 2002:a62:43:0:b029:1cd:2de2:5a24 with SMTP id 64-20020a6200430000b02901cd2de25a24mr1032519pfa.27.1615926566142;
        Tue, 16 Mar 2021 13:29:26 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:bdd3:3391:be74:f7be])
        by smtp.gmail.com with UTF8SMTPSA id o13sm17930272pgv.40.2021.03.16.13.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 13:29:23 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     Jonathan.Cameron@huawei.com, alexandru.ardelean@analog.com,
        groeck@chromium.org
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v5] iio: cros: unify hw fifo attributes without API changes
Date:   Tue, 16 Mar 2021 13:29:19 -0700
Message-Id: <20210316202919.1886616-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
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

3. Use devm_iio_triggered_buffer_setup_ext() when EC has a FIFO to
specify the buffer extended attributes.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes since v4:
Applied on top of commit ("iio: kfifo: add devm_iio_triggered_buffer_setup_ext variant")
https://patchwork.kernel.org/project/linux-iio/patch/20210311091042.22417-1-aardelean@deviqon.com/
Remove the slim trigger and use devm_iio_triggered_buffer_setup_ext() instead.

Changes since v3:
Remove Change-Id.

Changes since v2:
Remove include of buffer_impl.
Rebase on top of kernel/git/jic23/iio.git testing branch.

Changes since v1:
Use a slim trigger when EC supports FIFO, to use
devm_iio_triggered_buffer_setup_ext().

 drivers/iio/accel/cros_ec_accel_legacy.c      |  2 +-
 .../cros_ec_sensors/cros_ec_lid_angle.c       |  3 +--
 .../common/cros_ec_sensors/cros_ec_sensors.c  |  3 +--
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 24 +++++++------------
 drivers/iio/light/cros_ec_light_prox.c        |  3 +--
 drivers/iio/pressure/cros_ec_baro.c           |  3 +--
 .../linux/iio/common/cros_ec_sensors_core.h   |  3 +--
 7 files changed, 14 insertions(+), 27 deletions(-)

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
index f8824afe595e4..094df3ddb2cd0 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -12,6 +12,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/kernel.h>
@@ -240,7 +241,6 @@ static void cros_ec_sensors_core_clean(void *arg)
  *    for backward compatibility.
  * @push_data:          function to call when cros_ec_sensorhub receives
  *    a sample for that sensor.
- * @has_hw_fifo:	Set true if this device has/uses a HW FIFO
  *
  * Return: 0 on success, -errno on failure.
  */
@@ -248,8 +248,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 			      struct iio_dev *indio_dev,
 			      bool physical_device,
 			      cros_ec_sensors_capture_t trigger_capture,
-			      cros_ec_sensorhub_push_data_cb_t push_data,
-			      bool has_hw_fifo)
+			      cros_ec_sensorhub_push_data_cb_t push_data)
 {
 	struct device *dev = &pdev->dev;
 	struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
@@ -334,9 +333,9 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 			 * We can not use trigger here, as events are generated
 			 * as soon as sample_frequency is set.
 			 */
-			ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
-							  INDIO_BUFFER_SOFTWARE,
-							  NULL);
+			ret = devm_iio_kfifo_buffer_setup_ext(dev, indio_dev,
+							      INDIO_BUFFER_SOFTWARE, NULL,
+							      cros_ec_sensor_fifo_attributes);
 			if (ret)
 				return ret;
 
@@ -355,21 +354,14 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
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
2.31.0.rc2.261.g7f71774620-goog

