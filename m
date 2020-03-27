Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2006619613E
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 23:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgC0WfC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 18:35:02 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54879 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbgC0We7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 18:34:59 -0400
Received: by mail-pj1-f68.google.com with SMTP id np9so4450945pjb.4
        for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2020 15:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Sobb4nq0/308DQITGpXeJKD71I3+OINs+Tv0aV6PWA=;
        b=dUdb40/OKnkABAIfWqE9elc5tiBQtcuQfZ1RIC5P3XPMwED4CPt7dF8P6JJ3eH+yMy
         iUeXYhwpQ9Yes8512vOhBpon+Osretjvk2z2VRSIwQuOKjJaBuYB4XOS6ad5T2p3FyQn
         hwTsLl2LuYWSG+t73mcq8EdihcZYTuDTXP0SA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Sobb4nq0/308DQITGpXeJKD71I3+OINs+Tv0aV6PWA=;
        b=JfDnzzqajWeGNcx9h/Y1/cWk4p5Kb61X/D7MQsTD9IPYBp5+lfWML6Zsy1U71E6AVO
         XQdWOjIN+IB1fL12YvIVj7/2hFQVyo7TmajKESehYbZgd1YVIBBacW1810/6GhHPmHUs
         o20/LwV4ovm0AQqvcoDJW2+BAwWT/g3ebQEsRZ0C7crCsX3Pe0NAbnVN0LipdBIhtAUq
         76CjVr7P+ziTqqB1P7uPkm2UYH4ondjTpk91E4hUVB7HIOy3kuNbVaweBFft1NhTyDvC
         OOU5HxfWLtjQPbBfAIGXcjsgdck1kduz3+TJhca/lynlyLnYhIok1lw8PdFk8PHawFJh
         alvg==
X-Gm-Message-State: ANhLgQ14en//CCBjbLEVKWIA2aZ4XdpLhETiY8s8zpKZMQpoBxIiDwOR
        HGSKTlIW8CDOIbtlOh4VYUd1/A==
X-Google-Smtp-Source: ADFU+vuylLIli9K5YCcUdoNdG4IlakEGKRC0s305VS6q0vqVZNLaiSKar4NzpvNRQXSClNqDDvzAoQ==
X-Received: by 2002:a17:902:788b:: with SMTP id q11mr1275519pll.20.1585348496407;
        Fri, 27 Mar 2020 15:34:56 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id iq14sm1917408pjb.43.2020.03.27.15.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 15:34:56 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        Jonathan.Cameron@huawei.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v7 08/12] iio: cros_ec: Remove pm function
Date:   Fri, 27 Mar 2020 15:34:39 -0700
Message-Id: <20200327223443.6006-9-gwendal@chromium.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <20200327223443.6006-1-gwendal@chromium.org>
References: <20200327223443.6006-1-gwendal@chromium.org>
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

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
No changes in v6 and v7.
Changes in v5:
  Added ack.
No changes in v4, v3.
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
index 711134d67ddee..fad21a90bc7e8 100644
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
index 01513cb933653..a1ecbd55ea767 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -738,52 +738,5 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
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
index 03c951ff4a3c3..e10b35de4c2fa 100644
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
index b8f573ca9dcc9..96ea4551945e2 100644
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
@@ -117,8 +114,6 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
 			       struct iio_chan_spec const *chan,
 			       int val, int val2, long mask);
 
-extern const struct dev_pm_ops cros_ec_sensors_pm_ops;
-
 /* List of extended channel specification for all sensors */
 extern const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[];
 
-- 
2.26.0.rc2.310.g2932bb562d-goog

