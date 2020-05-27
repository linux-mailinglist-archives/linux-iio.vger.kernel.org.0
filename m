Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633FA1E3761
	for <lists+linux-iio@lfdr.de>; Wed, 27 May 2020 06:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgE0EfY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 May 2020 00:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgE0EfX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 May 2020 00:35:23 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F010C061A0F
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2020 21:35:22 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 5so969543pjd.0
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2020 21:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5sWjIDfLWlipc7zbX0n8xUofkS2PuKl4EGtkIwR8REA=;
        b=g4QutNdbC7Wfo8XDU8DVQEA+/u+TpGuVnyqMYcjxDZent0umxNB+6CTA3BmPJI/B02
         b8Wen0kzROXGUUdZdwFvJ05pdTUWX/cN07kK+T91mGPftoKCZuV6EbQZgZMyh9oPlklB
         9gQKBTwJay571b2LrIRPE2NQCLJSB+vDY1YE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5sWjIDfLWlipc7zbX0n8xUofkS2PuKl4EGtkIwR8REA=;
        b=CmCQ99uZlxX+nQ56VPjPDdQf0Ow3Sk01QnxaweW68bljQUmdUNZBKqWs94E1rvEHqR
         oFsPy3gDlhcczHzCFDW39lA1DO+72hlNkYa6IFOo0smC74w3EnaclLIOj/o9/pBdaCO6
         IFnm9e2zMip9GACwpA3XaFuXA3Acr7Jyu87QU/VRhNeRSTX7GesPVgj0iZjr+UlXkDWc
         A2bC88wTOWZtSYAf+HQbmuQ69HSgzkbzplWwnOa/HsKVjm4apGu2RAVRcNJLImZLg//g
         3Eah9dUnLsLwdQEqWYTdjG1lyWE65VpeeDovbANPsWcu7W0m7IZXmVNsKu5sCS67j4cv
         B7YQ==
X-Gm-Message-State: AOAM5323/TRnUVCzrfuxB4poD/i18paAmasSl68F2lhj4PgBQoWKS2aq
        Va1i2oXRhrcvmwNlz3hZjWxmmg==
X-Google-Smtp-Source: ABdhPJzKagYKEpG+lUg/oMZQUYd2cYK5FIz2UIM8oU7NMfyUK5DgDKkAmpBdGhC5RMwk6Lf6+JgmYQ==
X-Received: by 2002:a17:90b:4390:: with SMTP id in16mr2873683pjb.78.1590554121841;
        Tue, 26 May 2020 21:35:21 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id m12sm927390pjf.44.2020.05.26.21.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 21:35:21 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     groeck@chromium.org, bleung@chromium.org, jic23@kernel.org,
        enric.balletbo@collabora.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] iio: cros_ec: Reapply range at resume
Date:   Tue, 26 May 2020 21:35:17 -0700
Message-Id: <20200527043517.240123-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

EC does not currently preserve range across sensor reinit.
If sensor is powered down at suspend, it will default to the EC default
range at resume, not the range set by the host.

Save range if modified, and apply at resume.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 .../common/cros_ec_sensors/cros_ec_sensors.c  |  5 +++++
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 21 +++++++++++++++++++
 drivers/iio/light/cros_ec_light_prox.c        |  6 +++++-
 drivers/iio/pressure/cros_ec_baro.c           |  8 +++++--
 .../linux/iio/common/cros_ec_sensors_core.h   | 11 +++++++++-
 5 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index a66941fdb3855..130ab8ce0269b 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -200,6 +200,10 @@ static int cros_ec_sensors_write(struct iio_dev *indio_dev,
 		st->core.param.sensor_range.roundup = 1;
 
 		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
+		if (ret == 0) {
+			st->core.range_updated = true;
+			st->core.curr_range = val;
+		}
 		break;
 	default:
 		ret = cros_ec_sensors_core_write(
@@ -315,6 +319,7 @@ MODULE_DEVICE_TABLE(platform, cros_ec_sensors_ids);
 static struct platform_driver cros_ec_sensors_platform_driver = {
 	.driver = {
 		.name	= "cros-ec-sensors",
+		.pm	= &cros_ec_sensors_pm_ops,
 	},
 	.probe		= cros_ec_sensors_probe,
 	.id_table	= cros_ec_sensors_ids,
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index c831915ca7e56..cda459b612067 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -824,5 +824,26 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
 }
 EXPORT_SYMBOL_GPL(cros_ec_sensors_core_write);
 
+static int __maybe_unused cros_ec_sensors_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
+	int ret = 0;
+
+	if (st->range_updated) {
+		mutex_lock(&st->cmd_lock);
+		st->param.cmd = MOTIONSENSE_CMD_SENSOR_RANGE;
+		st->param.sensor_range.data = st->curr_range;
+		st->param.sensor_range.roundup = 1;
+		ret = cros_ec_motion_send_host_cmd(st, 0);
+		mutex_unlock(&st->cmd_lock);
+	}
+	return ret;
+}
+
+SIMPLE_DEV_PM_OPS(cros_ec_sensors_pm_ops, NULL, cros_ec_sensors_resume);
+EXPORT_SYMBOL_GPL(cros_ec_sensors_pm_ops);
+
 MODULE_DESCRIPTION("ChromeOS EC sensor hub core functions");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
index 2198b50909ed0..fed79ba27fda5 100644
--- a/drivers/iio/light/cros_ec_light_prox.c
+++ b/drivers/iio/light/cros_ec_light_prox.c
@@ -145,8 +145,11 @@ static int cros_ec_light_prox_write(struct iio_dev *indio_dev,
 		break;
 	case IIO_CHAN_INFO_CALIBSCALE:
 		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_RANGE;
-		st->core.param.sensor_range.data = (val << 16) | (val2 / 100);
+		st->core.curr_range = (val << 16) | (val2 / 100);
+		st->core.param.sensor_range.data = st->core.curr_range;
 		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
+		if (ret == 0)
+			st->core.range_updated = true;
 		break;
 	default:
 		ret = cros_ec_sensors_core_write(&st->core, chan, val, val2,
@@ -256,6 +259,7 @@ MODULE_DEVICE_TABLE(platform, cros_ec_light_prox_ids);
 static struct platform_driver cros_ec_light_prox_platform_driver = {
 	.driver = {
 		.name	= "cros-ec-light-prox",
+		.pm	= &cros_ec_sensors_pm_ops,
 	},
 	.probe		= cros_ec_light_prox_probe,
 	.id_table	= cros_ec_light_prox_ids,
diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
index c079b89600824..f0938b6fbba07 100644
--- a/drivers/iio/pressure/cros_ec_baro.c
+++ b/drivers/iio/pressure/cros_ec_baro.c
@@ -96,8 +96,11 @@ static int cros_ec_baro_write(struct iio_dev *indio_dev,
 		/* Always roundup, so caller gets at least what it asks for. */
 		st->core.param.sensor_range.roundup = 1;
 
-		if (cros_ec_motion_send_host_cmd(&st->core, 0))
-			ret = -EIO;
+		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
+		if (ret == 0) {
+			st->core.range_updated = true;
+			st->core.curr_range = val;
+		}
 		break;
 	default:
 		ret = cros_ec_sensors_core_write(&st->core, chan, val, val2,
@@ -199,6 +202,7 @@ MODULE_DEVICE_TABLE(platform, cros_ec_baro_ids);
 static struct platform_driver cros_ec_baro_platform_driver = {
 	.driver = {
 		.name	= "cros-ec-baro",
+		.pm	= &cros_ec_sensors_pm_ops,
 	},
 	.probe		= cros_ec_baro_probe,
 	.id_table	= cros_ec_baro_ids,
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index 7bc961defa87e..caa8bb279a346 100644
--- a/include/linux/iio/common/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -42,6 +42,10 @@ typedef irqreturn_t (*cros_ec_sensors_capture_t)(int irq, void *p);
  * @resp:			motion sensor response structure
  * @type:			type of motion sensor
  * @loc:			location where the motion sensor is placed
+ * @range_updated:		True if the range of the sensor has been
+ *				updated.
+ * @curr_range:			If updated, the current range value.
+ *				It will be reapplied at every resume.
  * @calib:			calibration parameters. Note that trigger
  *				captured data will always provide the calibrated
  *				data
@@ -65,6 +69,9 @@ struct cros_ec_sensors_core_state {
 	enum motionsensor_type type;
 	enum motionsensor_location loc;
 
+	bool range_updated;
+	int curr_range;
+
 	struct calib_data {
 		s16 offset;
 		u16 scale;
@@ -114,7 +121,9 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
 			       struct iio_chan_spec const *chan,
 			       int val, int val2, long mask);
 
-/* List of extended channel specification for all sensors */
+extern const struct dev_pm_ops cros_ec_sensors_pm_ops;
+
+/* List of extended channel specification for all sensors. */
 extern const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[];
 extern const struct attribute *cros_ec_sensor_fifo_attributes[];
 
-- 
2.27.0.rc0.183.gde8f92d652-goog

