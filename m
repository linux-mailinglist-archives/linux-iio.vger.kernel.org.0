Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C99E340D83
	for <lists+linux-iio@lfdr.de>; Thu, 18 Mar 2021 19:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhCRStk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Mar 2021 14:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhCRStJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Mar 2021 14:49:09 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEF7C06174A
        for <linux-iio@vger.kernel.org>; Thu, 18 Mar 2021 11:49:09 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id ay2so1757682plb.3
        for <linux-iio@vger.kernel.org>; Thu, 18 Mar 2021 11:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ez0VKEgE4V4By1Phkg2jrUXPztD5wSWDoFrIs88DLQw=;
        b=RdLkHjQCkx9z5j7555rLwIm0M0kedhdVT8WQOxAXugVDRAu7PnN9Cvi+Zx5/X/ALRR
         BUPLxlwK7DXHrdUi6y5anxV1C397p/vIPTQF8bJ5jVxmG5m9pRwUUdXj5KEt4iwdKdVY
         ec9cUWFqd6T776yz6VJYaiZpfq3nlGqlomqLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ez0VKEgE4V4By1Phkg2jrUXPztD5wSWDoFrIs88DLQw=;
        b=CLLWQrKIRTWjTSPt/La1O1K9OgwWtMRfwDtLAR6VcG1+2Ab9X+DD3NPXL5ZPGMlbRB
         WuN9eOUl62njm4MTnYKZ+JZ2S1CnQs+BCW4kVQJiLt2H9l3ullOiPdMVZ3YeSbHZQGXP
         XWYciUSrDkjoX85icHPaw7QwQdzXdRaG0VmMMNkol6WQDdfOVHML2iD4YoA+w2IRSW5n
         SIurwN9erowLCxOiAnOd8EQsWFL26Ktsw0rwATMS8UCdzY/VczUwDHs4goCLofKLguWU
         F0DEYaQfKpEtkNqF7ByEXdZO20XDgt5p3NlY7wiJmXe/pNL4i4rT/fDwZGyedXMgRaRC
         s5yg==
X-Gm-Message-State: AOAM533Fu2DWEyAHmg16dyfyk36tI3PWjxf0/tW9kdvXBLgjY67rWyAJ
        JKTOI7EyJx7Ry2+SNgeyQb0Xfu6IN65tng==
X-Google-Smtp-Source: ABdhPJwEsyBXf7wwx28TC7N/wAsfIIznmuTTdUccJY0fNDSzs/PQ2ENtx2Br7VOUA5uPvPX4NAcrRw==
X-Received: by 2002:a17:90a:af8a:: with SMTP id w10mr5594736pjq.114.1616093349299;
        Thu, 18 Mar 2021 11:49:09 -0700 (PDT)
Received: from localhost ([100.99.132.241])
        by smtp.gmail.com with UTF8SMTPSA id 64sm3093139pfd.174.2021.03.18.11.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 11:49:04 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     Jonathan.Cameron@huawei.com, ardeleanalex@gmail.com,
        andy.shevchenko@gmail.com, groeck@chromium.org
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v7] iio: cros: unify hw fifo attributes without API changes
Date:   Thu, 18 Mar 2021 11:48:57 -0700
Message-Id: <20210318184857.2679181-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Commit 2e2366c2d141 ("iio: cros_ec: unify hw fifo attributes into the core file")
should be reverted as it set buffer extended attributes at
the wrong place. However, to revert it will requires to revert more
commits:
commit 165aea80e2e2 ("iio: cros_ec: use devm_iio_triggered_buffer_setup_ext()")
commit 21232b4456ba ("iio: buffer: remove iio_buffer_set_attrs() helper")).
and we would still have conflict with more recent development.
commit ee708e6baacd ("iio: buffer: introduce support for attaching more IIO buffers")

Instead, this commit reverts the first 2 commits without re-adding
iio_buffer_set_attrs() and set the buffer extended attributes at the
right place:

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

Fixes: 2e2366c2d141 ("iio: cros_ec: unify hw fifo attributes into the core file")
Fixes: 165aea80e2e2 ("iio: cros_ec: use devm_iio_triggered_buffer_setup_ext()")
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changes since v6:
Added review tags.

Changes since v5:
Explain why a single patch solution was preferred to multiple commit
reverts.

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
2.31.0.291.g576ba9dcdaf-goog

