Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BEE33FA1C
	for <lists+linux-iio@lfdr.de>; Wed, 17 Mar 2021 21:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbhCQUrc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Mar 2021 16:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbhCQUrD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Mar 2021 16:47:03 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78969C06174A
        for <linux-iio@vger.kernel.org>; Wed, 17 Mar 2021 13:47:03 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id l1so13784pgb.5
        for <linux-iio@vger.kernel.org>; Wed, 17 Mar 2021 13:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RRXMRpaj9UoUDd9t3UUMGZB8dNG8d6lVlRy0AL39eOE=;
        b=W3WHg0qlQmOX0B5Zl3E71KRmARKjI9n8jtDY/42dEOOpTRc672dCcY+rpv8isArrDj
         mvjRlUTncTZy7ai3zX47omafAScGM9fF2KMgB7bxnuhaqcKarc+w+/ED1LL6+JcSgFoZ
         vjPMoJoSKxJyKeu0ubM0LrjGWlMxNt6o1KSGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RRXMRpaj9UoUDd9t3UUMGZB8dNG8d6lVlRy0AL39eOE=;
        b=Sm2KL1a1dkJdFBJkBz608eERXVy9mkJWTbxEPG6Sk+Wy7fQjpRwyQ8GBmcGOiS8N/q
         ZvTBEV6jXFuJUNQSPk8Ze3QEWatL+w+8LsNGp9hBRhHBXNrIIGkANHLJ65hH/TCGEDIi
         yzWr1jbyeRrsz+bQwmmB+HLEtyGLjt9WPAcKyew0vmbHFWA4o8F5+aI2kBDV0qyyy6sd
         QhSk9T2Vua+r7YtWMMdp7snZkBeocjtCsnEMhTZMTaoEUvtImwNvfUcaq070Fvzf/zoG
         LmAbnJmG0jt21MuvxvmeA1EjgIyiOiG7sXAJWKLWU+y94M3MELPi3CHsZ2OyJ7KETui2
         6EhA==
X-Gm-Message-State: AOAM530dczWnII2CfMKer9FbXoBOh5ynTXeJVQWETyqssYj+vOeV+k/v
        ek72BFdX0t6ufhn9kWxo+Du0HA==
X-Google-Smtp-Source: ABdhPJwiatet+WBmyBAS0e5lwRtscjeksOMGJUt3qmsnPQk2jVmATgfjOBSld9Q86BS+rb/PLAfmpg==
X-Received: by 2002:aa7:9493:0:b029:1f8:a493:b747 with SMTP id z19-20020aa794930000b02901f8a493b747mr784161pfk.41.1616014022803;
        Wed, 17 Mar 2021 13:47:02 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:f97b:2fbd:4700:fb85])
        by smtp.gmail.com with UTF8SMTPSA id a204sm6227pfd.106.2021.03.17.13.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 13:46:58 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     Jonathan.Cameron@huawei.com, ardeleanalex@gmail.com,
        andy.shevchenko@gmail.com, groeck@chromium.org
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v6] iio: cros: unify hw fifo attributes without API changes
Date:   Wed, 17 Mar 2021 13:46:52 -0700
Message-Id: <20210317204652.2469171-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
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
---
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
2.31.0.rc2.261.g7f71774620-goog

