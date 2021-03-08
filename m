Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBECB33058F
	for <lists+linux-iio@lfdr.de>; Mon,  8 Mar 2021 02:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbhCHBKG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Mar 2021 20:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbhCHBJb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Mar 2021 20:09:31 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BF8C06174A
        for <linux-iio@vger.kernel.org>; Sun,  7 Mar 2021 17:09:31 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id n9so4414503pgi.7
        for <linux-iio@vger.kernel.org>; Sun, 07 Mar 2021 17:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TbODWFLdJifOkejS9hgbe8ELRNbypeCDIpatD3uQ97I=;
        b=JRuUJqhITmAvzohFE2Bg8KCHbDYdm8P6Yn4eRMy/HFySxEm8z0uUVDvaZTERtcqtz+
         LtKiF6zb6y2Lwye1dBSiW4A4B0TMRVSpxD2uDa/4T7B1khtzHh9OsDN2DqgJJtfCVf7Y
         WJL57VbWQwgpxi102gaXgkxvAityQbS1/iEUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TbODWFLdJifOkejS9hgbe8ELRNbypeCDIpatD3uQ97I=;
        b=GtJGleQ2ZUkRVdJNGKOmhAA5X+PBikp09L+klAwb4uDY9w2sKjpu5hZ1mU20rFh8me
         GxAFeqOoMAQC4Y7EtqDg08GKX06MTlYGHhXT9wYWi/jsN2O52T2UXAudoz7xgqnbAiUR
         qC0wWdmCESfm6yyH1o6pI6LKLdov2/k5DZDHgHYGxTzvCcbursEJuBlnSrfzEoK9lfEQ
         G9RtFkpd7BYh1E7Lw8uOVSrQxZIiDUis65k/xahqyqZdDT/xiJETs4OnPvLufSHrH3lW
         eiufa/d9W/+qzK1LA0afiICpFYeeefaR83Plw/4OH/WtI3Ew3XADBgf8uOz0/GpqL1bT
         UCzw==
X-Gm-Message-State: AOAM531rkhp7kHOqCCjkX6YRREcYusaJjCxLvwq8DUrBm4eh/yc7F/5x
        +NJm5o1UKskpX9Q6Pw5AFrNavQ==
X-Google-Smtp-Source: ABdhPJw++2w30Z7M4l8mEKWYUZs7TLzENA27BTxbGkDYEnmhx75OOPubb4BxqoRIGXNuFmOht0Zy9Q==
X-Received: by 2002:aa7:8bd2:0:b029:1ee:1838:685f with SMTP id s18-20020aa78bd20000b02901ee1838685fmr18990233pfd.64.1615165771153;
        Sun, 07 Mar 2021 17:09:31 -0800 (PST)
Received: from localhost ([2620:15c:202:201:6dac:4399:3fff:9ad9])
        by smtp.gmail.com with UTF8SMTPSA id v185sm8526809pfb.125.2021.03.07.17.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Mar 2021 17:09:30 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     Jonathan.Cameron@huawei.com, alexandru.ardelean@analog.com,
        groeck@chromium.org
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] iio: cros: unify hw fifo attributes without API changes
Date:   Sun,  7 Mar 2021 17:09:22 -0800
Message-Id: <20210308010922.765394-1-gwendal@chromium.org>
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

2. devm_iio_triggered_buffer_setup_ext() does not need to be called.
Only when the EC support FIFO we set the buffer attributes directly to set
timeout and watermark.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/accel/cros_ec_accel_legacy.c      |  2 +-
 .../cros_ec_sensors/cros_ec_lid_angle.c       |  3 +--
 .../common/cros_ec_sensors/cros_ec_sensors.c  |  3 +--
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 19 +++++++------------
 drivers/iio/light/cros_ec_light_prox.c        |  3 +--
 drivers/iio/pressure/cros_ec_baro.c           |  3 +--
 .../linux/iio/common/cros_ec_sensors_core.h   |  3 +--
 7 files changed, 13 insertions(+), 23 deletions(-)

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
index c833ec0ef2147..1926f5719b2d4 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -8,6 +8,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/buffer_impl.h>
 #include <linux/iio/common/cros_ec_sensors_core.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
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
@@ -358,21 +357,17 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
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
 
+			/* Set attributes to control EC FIFO directly. */
+			indio_dev->buffer->attrs = cros_ec_sensor_fifo_attributes;
+		} else {
 			/*
 			 * The only way to get samples in buffer is to set a
 			 * software trigger (systrig, hrtimer).
 			 */
-			ret = devm_iio_triggered_buffer_setup_ext(
+			ret = devm_iio_triggered_buffer_setup(
 					dev, indio_dev, NULL, trigger_capture,
-					NULL, fifo_attrs);
+					NULL);
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

