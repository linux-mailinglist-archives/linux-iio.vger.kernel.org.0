Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEA2E6A1F
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2019 00:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfJ0XKe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Oct 2019 19:10:34 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37055 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbfJ0XKL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Oct 2019 19:10:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id u9so721276pfn.4
        for <linux-iio@vger.kernel.org>; Sun, 27 Oct 2019 16:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o05xwTXK2ws9h78d6Becw1/PNQhnowHjynvML3hCa20=;
        b=G8VyzJQjdh64J4eybx7BkqGfamSQdtMX/3hr/6hOPJDG3bFJ5eY6WyaTIsCjK/wCax
         l3maj673tnNI5ap35s9+XRFYpui9pUMxhOo5TyOogAT1P1BVbl6R9XpGbVeb1a2cKedE
         6t9x2vU0yaaCRPAz6T9yWjjJyYe9/9VEYpZns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o05xwTXK2ws9h78d6Becw1/PNQhnowHjynvML3hCa20=;
        b=tDMs+HAkgreUqwG0UhVYTNp0O4kDNMuD4eVqHXyoskYXIePDdlpG1WTk56l0D4oVQU
         JRCKdmI/CNJ1uHuICdqXdQYxMw/aDey6T+KdNzwFRq6BTd0KZEWN9dZkAOL8POEIYE01
         V4eRDfwdeYfY1YvDTBLIoXRpBlbM0AnQ0Pg6SlQAeBt+gQFwPtx6PRUJe9tq+wQZh9qN
         PdqyvaVIH50KnKPDibj+VxSAzVuZpbkMjQSLWTsGWXNV8xjC93Z8lo8nxj9JERI8qZDH
         GBk1X/PCTVnumCCi/sLJpZUIMpFNlcfI6Sch9EOC4A1nbVfutpEswuzde7SgYqVPZjH4
         3nNw==
X-Gm-Message-State: APjAAAVbbX/DX/BNbKOlUts2NberM+VFZ8wNWvgjslIpbInLNgZspsGy
        kr8kLENxxMUliQKEvoqGy2L5Ng==
X-Google-Smtp-Source: APXvYqxZE30NFP7gcVWSO/Sug1RdS9+hTcC70Fjzw+30rP3jbSRkZFT6j2tr1ysdjjC+6pZTUC9q7g==
X-Received: by 2002:a62:7dd2:: with SMTP id y201mr8817614pfc.164.1572217811020;
        Sun, 27 Oct 2019 16:10:11 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id 16sm9018605pfn.35.2019.10.27.16.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2019 16:10:10 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     briannorris@chromium.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 15/18] iio: cros_ec: Remove pm function
Date:   Sun, 27 Oct 2019 16:09:18 -0700
Message-Id: <20191027230921.205251-16-gwendal@chromium.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
In-Reply-To: <20191027230921.205251-1-gwendal@chromium.org>
References: <20191027230921.205251-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since cros_ec_sensorhub is shutting down the FIFO when the device
suspends, no need to slow down the EC sampling period rate.
It was necesseary to do that before command CMD_FIFO_INT_ENABLE was
introduced, but now all supported chromebooks have it.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
No changes in v3.
New in v2.

 .../cros_ec_sensors/cros_ec_lid_angle.c       |  1 -
 .../common/cros_ec_sensors/cros_ec_sensors.c  |  1 -
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 47 -------------------
 drivers/iio/light/cros_ec_light_prox.c        |  1 -
 .../linux/iio/common/cros_ec_sensors_core.h   |  5 --
 5 files changed, 55 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
index e30a59fcf0f95..af801e203623e 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
@@ -127,7 +127,6 @@ MODULE_DEVICE_TABLE(platform, cros_ec_lid_angle_ids);
 static struct platform_driver cros_ec_lid_angle_platform_driver = {
 	.driver = {
 		.name	= DRV_NAME,
-		.pm	= &cros_ec_sensors_pm_ops,
 	},
 	.probe		= cros_ec_lid_angle_probe,
 	.id_table	= cros_ec_lid_angle_ids,
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index 9e7903ff99f80..2eb4bb254fbde 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -314,7 +314,6 @@ MODULE_DEVICE_TABLE(platform, cros_ec_sensors_ids);
 static struct platform_driver cros_ec_sensors_platform_driver = {
 	.driver = {
 		.name	= "cros-ec-sensors",
-		.pm	= &cros_ec_sensors_pm_ops,
 	},
 	.probe		= cros_ec_sensors_probe,
 	.id_table	= cros_ec_sensors_ids,
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 869348c599941..353dbbd9b7515 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -722,52 +722,5 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
 }
 EXPORT_SYMBOL_GPL(cros_ec_sensors_core_write);
 
-static int __maybe_unused cros_ec_sensors_prepare(struct device *dev)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
-
-	if (st->curr_sampl_freq == 0)
-		return 0;
-
-	/*
-	 * If the sensors are sampled at high frequency, we will not be able to
-	 * sleep. Set sampling to a long period if necessary.
-	 */
-	if (st->curr_sampl_freq < CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY) {
-		mutex_lock(&st->cmd_lock);
-		st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
-		st->param.ec_rate.data = CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY;
-		cros_ec_motion_send_host_cmd(st, 0);
-		mutex_unlock(&st->cmd_lock);
-	}
-	return 0;
-}
-
-static void __maybe_unused cros_ec_sensors_complete(struct device *dev)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
-
-	if (st->curr_sampl_freq == 0)
-		return;
-
-	if (st->curr_sampl_freq < CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY) {
-		mutex_lock(&st->cmd_lock);
-		st->param.cmd = MOTIONSENSE_CMD_EC_RATE;
-		st->param.ec_rate.data = st->curr_sampl_freq;
-		cros_ec_motion_send_host_cmd(st, 0);
-		mutex_unlock(&st->cmd_lock);
-	}
-}
-
-const struct dev_pm_ops cros_ec_sensors_pm_ops = {
-#ifdef CONFIG_PM_SLEEP
-	.prepare = cros_ec_sensors_prepare,
-	.complete = cros_ec_sensors_complete
-#endif
-};
-EXPORT_SYMBOL_GPL(cros_ec_sensors_pm_ops);
-
 MODULE_DESCRIPTION("ChromeOS EC sensor hub core functions");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
index da40c38370965..6bac02cdd898a 100644
--- a/drivers/iio/light/cros_ec_light_prox.c
+++ b/drivers/iio/light/cros_ec_light_prox.c
@@ -255,7 +255,6 @@ MODULE_DEVICE_TABLE(platform, cros_ec_light_prox_ids);
 static struct platform_driver cros_ec_light_prox_platform_driver = {
 	.driver = {
 		.name	= "cros-ec-light-prox",
-		.pm	= &cros_ec_sensors_pm_ops,
 	},
 	.probe		= cros_ec_light_prox_probe,
 	.id_table	= cros_ec_light_prox_ids,
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index d8535a2a5a49b..f5dc532c9db21 100644
--- a/include/linux/iio/common/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -30,9 +30,6 @@ enum {
  */
 #define CROS_EC_SAMPLE_SIZE  (sizeof(s64) * 2)
 
-/* Minimum sampling period to use when device is suspending */
-#define CROS_EC_MIN_SUSPEND_SAMPLING_FREQUENCY 1000  /* 1 second */
-
 typedef irqreturn_t (*cros_ec_sensors_capture_t)(int irq, void *p);
 
 /**
@@ -118,8 +115,6 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
 			       struct iio_chan_spec const *chan,
 			       int val, int val2, long mask);
 
-extern const struct dev_pm_ops cros_ec_sensors_pm_ops;
-
 /* List of extended channel specification for all sensors */
 extern const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[];
 
-- 
2.23.0.866.gb869b98d4c-goog

