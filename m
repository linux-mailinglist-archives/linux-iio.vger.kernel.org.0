Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38F246D742
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2019 01:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfGRX2c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Jul 2019 19:28:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38944 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfGRX2c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jul 2019 19:28:32 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so13573398pgi.6
        for <linux-iio@vger.kernel.org>; Thu, 18 Jul 2019 16:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kdfXrLZuHiUNaZJIFbxlwZux0+Ow1AdLjKNlsGSWaIE=;
        b=TFhQdgrurZlY9B5Zuxb4KHD6ASykKMA5jaGQ1IZ9VSNA6Isw+8ikwdnVTEQLKo17J+
         Q1VVpRXbNGfZhp2eIBh8HWqWFa6eenTQKwzO9htDfqLynBO+zC7zJGxwDzMqIAjZz5Dc
         goh/WpDsoUE5ZatoUppaXJ6YvUZPINqN38JBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kdfXrLZuHiUNaZJIFbxlwZux0+Ow1AdLjKNlsGSWaIE=;
        b=h8L/RLbOt8hpdBVlIWT2WuuAEcBw3bE1eDJwX3tR2BMRwqOmBoVbDlB1oVUpKm6jeb
         JCyGZXJGBO5ZN538iN1eDzMUS7RxbJxPOAUx82iwGZWD7/c1wAwpVRHFD483Je9eahb0
         qQdnWTWVx5P40gexje/IdXF3rGApQHNqLquVnIMvAVf9AsdoQxK3kS3apOIks3/GeTo5
         w2Xf03yW9CZpqUSqDeNePew0V3136L4a19oNMHtDXiPIG5UFdocLoMQBXU3VNbQToPz6
         9TEG8V6Gi4fmzOVSWm5lfJAilSuxDZyeY/84rQkuFs4BQuIF44zgqAPp+jiGLYRuRsVn
         R80Q==
X-Gm-Message-State: APjAAAXt+zWDUy8OINl/pA95tWVWWZs/vqRbkDon63OVUr846j/uMTwN
        yAL2nkuykPzyYq4sFuM5el9m+Q==
X-Google-Smtp-Source: APXvYqxK51FAWY/z3GYUB8ve8wCz2TK1Zq++l5HerEYbsnJ/hvJs5j7AU4+QqEblT6BI3jVKuR3MIw==
X-Received: by 2002:a17:90a:cb8e:: with SMTP id a14mr5584341pju.124.1563492511490;
        Thu, 18 Jul 2019 16:28:31 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id q1sm33298659pfg.84.2019.07.18.16.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 16:28:30 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-iio@vger.kernel.org, Allison Randal <allison@lohutok.net>,
        Guenter Roeck <groeck@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Benson Leung <bleung@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: cros_ec: Add calibscale for 3d MEMS
Date:   Thu, 18 Jul 2019 16:28:24 -0700
Message-Id: <20190718232825.183662-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add calibration scale support to accel, gyro and magnetometer.

Check on eve with current firmware, check reading calibscale returns 1.0,
check with newer firmware values are applied.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---

 .../common/cros_ec_sensors/cros_ec_sensors.c  | 51 +++++++++++++++++--
 .../cros_ec_sensors/cros_ec_sensors_core.c    |  2 +-
 drivers/iio/light/cros_ec_light_prox.c        | 12 ++---
 drivers/iio/pressure/cros_ec_baro.c           |  2 -
 .../linux/iio/common/cros_ec_sensors_core.h   |  5 +-
 5 files changed, 57 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index 17af4e0fd5f8..2af09606c438 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -63,10 +63,35 @@ static int cros_ec_sensors_read(struct iio_dev *indio_dev,
 
 		/* Save values */
 		for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++)
-			st->core.calib[i] =
+			st->core.calib[i].offset =
 				st->core.resp->sensor_offset.offset[i];
 		ret = IIO_VAL_INT;
-		*val = st->core.calib[idx];
+		*val = st->core.calib[idx].offset;
+		break;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_SCALE;
+		st->core.param.sensor_offset.flags = 0;
+
+		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
+		if (ret == -EPROTO) {
+			/* Reading calibscale is not supported on older EC. */
+			*val = 1;
+			*val2 = 0;
+			ret = IIO_VAL_INT_PLUS_MICRO;
+			break;
+		} else if (ret) {
+			break;
+		}
+
+		/* Save values */
+		for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++)
+			st->core.calib[i].scale =
+				st->core.resp->sensor_scale.scale[i];
+
+		*val = st->core.calib[idx].scale >> 15;
+		*val2 = ((st->core.calib[idx].scale & 0x7FFF) * 1000000LL) /
+			MOTION_SENSE_DEFAULT_SCALE;
+		ret = IIO_VAL_INT_PLUS_MICRO;
 		break;
 	case IIO_CHAN_INFO_SCALE:
 		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_RANGE;
@@ -134,7 +159,7 @@ static int cros_ec_sensors_write(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBBIAS:
-		st->core.calib[idx] = val;
+		st->core.calib[idx].offset = val;
 
 		/* Send to EC for each axis, even if not complete */
 		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_OFFSET;
@@ -142,10 +167,25 @@ static int cros_ec_sensors_write(struct iio_dev *indio_dev,
 			MOTION_SENSE_SET_OFFSET;
 		for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++)
 			st->core.param.sensor_offset.offset[i] =
-				st->core.calib[i];
+				st->core.calib[i].offset;
 		st->core.param.sensor_offset.temp =
 			EC_MOTION_SENSE_INVALID_CALIB_TEMP;
 
+		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
+		break;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		st->core.calib[idx].scale = val;
+		/* Send to EC for each axis, even if not complete */
+
+		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_SCALE;
+		st->core.param.sensor_offset.flags =
+			MOTION_SENSE_SET_OFFSET;
+		for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++)
+			st->core.param.sensor_scale.scale[i] =
+				st->core.calib[i].scale;
+		st->core.param.sensor_scale.temp =
+			EC_MOTION_SENSE_INVALID_CALIB_TEMP;
+
 		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
 		break;
 	case IIO_CHAN_INFO_SCALE:
@@ -206,7 +246,8 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
 		/* Common part */
 		channel->info_mask_separate =
 			BIT(IIO_CHAN_INFO_RAW) |
-			BIT(IIO_CHAN_INFO_CALIBBIAS);
+			BIT(IIO_CHAN_INFO_CALIBBIAS) |
+			BIT(IIO_CHAN_INFO_CALIBSCALE);
 		channel->info_mask_shared_by_all =
 			BIT(IIO_CHAN_INFO_SCALE) |
 			BIT(IIO_CHAN_INFO_FREQUENCY) |
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 130362ca421b..96d5aa1f4bd5 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -118,7 +118,7 @@ static ssize_t cros_ec_sensors_calibrate(struct iio_dev *indio_dev,
 	} else {
 		/* Save values */
 		for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++)
-			st->calib[i] = st->resp->perform_calib.offset[i];
+			st->calib[i].offset = st->resp->perform_calib.offset[i];
 	}
 	mutex_unlock(&st->cmd_lock);
 
diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
index 308ee6ff2e22..b81746a99f1f 100644
--- a/drivers/iio/light/cros_ec_light_prox.c
+++ b/drivers/iio/light/cros_ec_light_prox.c
@@ -88,9 +88,10 @@ static int cros_ec_light_prox_read(struct iio_dev *indio_dev,
 		}
 
 		/* Save values */
-		st->core.calib[0] = st->core.resp->sensor_offset.offset[0];
+		st->core.calib[0].offset =
+			st->core.resp->sensor_offset.offset[0];
 
-		*val = st->core.calib[idx];
+		*val = st->core.calib[idx].offset;
 		break;
 	case IIO_CHAN_INFO_CALIBSCALE:
 		/*
@@ -134,11 +135,12 @@ static int cros_ec_light_prox_write(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBBIAS:
-		st->core.calib[idx] = val;
+		st->core.calib[idx].offset = val;
 		/* Send to EC for each axis, even if not complete */
 		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_OFFSET;
 		st->core.param.sensor_offset.flags = MOTION_SENSE_SET_OFFSET;
-		st->core.param.sensor_offset.offset[0] = st->core.calib[0];
+		st->core.param.sensor_offset.offset[0] =
+			st->core.calib[0].offset;
 		st->core.param.sensor_offset.temp =
 					EC_MOTION_SENSE_INVALID_CALIB_TEMP;
 		if (cros_ec_motion_send_host_cmd(&st->core, 0))
@@ -205,8 +207,6 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
 	channel->ext_info = cros_ec_sensors_ext_info;
 	channel->scan_type.sign = 'u';
 
-	state->core.calib[0] = 0;
-
 	/* Sensor specific */
 	switch (state->core.type) {
 	case MOTIONSENSE_TYPE_LIGHT:
diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
index 034ce98d6e97..d3acba7ba582 100644
--- a/drivers/iio/pressure/cros_ec_baro.c
+++ b/drivers/iio/pressure/cros_ec_baro.c
@@ -152,8 +152,6 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
 	channel->ext_info = cros_ec_sensors_ext_info;
 	channel->scan_type.sign = 'u';
 
-	state->core.calib[0] = 0;
-
 	/* Sensor specific */
 	switch (state->core.type) {
 	case MOTIONSENSE_TYPE_BARO:
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index 0c636b9fe8d7..bb03a252bd04 100644
--- a/include/linux/iio/common/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -62,7 +62,10 @@ struct cros_ec_sensors_core_state {
 	enum motionsensor_type type;
 	enum motionsensor_location loc;
 
-	s16 calib[CROS_EC_SENSOR_MAX_AXIS];
+	struct calib_data {
+		s16 offset;
+		u16 scale;
+	} calib[CROS_EC_SENSOR_MAX_AXIS];
 
 	u8 samples[CROS_EC_SAMPLE_SIZE];
 
-- 
2.22.0.657.g960e92d24f-goog

