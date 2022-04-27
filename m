Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2290512238
	for <lists+linux-iio@lfdr.de>; Wed, 27 Apr 2022 21:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiD0TQM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Apr 2022 15:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiD0TPy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 Apr 2022 15:15:54 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3745362BCE
        for <linux-iio@vger.kernel.org>; Wed, 27 Apr 2022 12:08:17 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id p6so2381780plf.9
        for <linux-iio@vger.kernel.org>; Wed, 27 Apr 2022 12:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dorLNsz2KUwbmplm1YZpFcqeoPUdXbipAhMjrnQYSeE=;
        b=WsJX9UAmpK7EnTC/b9yw+JHPIAE1xOgzCid3URRWdMBfLGTbSvZoA2qMJWkB9TMiT9
         OPx3YbOV6+C//Pl1FynXEihesPG9YP5B922lwxs4Gewzw3oPG5gWGDxG1UjElfXfGJUd
         pbCcYFpekLiwUEvJPHnDq/iZjbn6ARZRRT3cA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dorLNsz2KUwbmplm1YZpFcqeoPUdXbipAhMjrnQYSeE=;
        b=QVeapgUFtXFaJNTjWhq82occZRCbp9dPomJKieunzYfDCoik6FIwbfQak30yRFMbOT
         sLDegoFIgmsvDdnJ6aOQKhvnjKb/0GxVgxxWdswNPi9Wz7pnXjiWVELvJLuAFLoe4tAH
         mvjF12TzDdtLkoWO1jYcn0jRnJeXMpHKvMrZDXPT2M2x3GLA0vK9qElLIqsNnWiyhAjd
         UQ9eH6+qWAwqX/o930LuZWq9S2IW8tCqu/xkOVfVbvpsEw7PjLxJIAGdudGluC/rUo7S
         0fQCOzwl43joGy8pgWJDfRV0VR+pF6Q2TxeSTyI+b6c3ar6rTIla68r+H6Z6R1lGpQw/
         9AoQ==
X-Gm-Message-State: AOAM531sYz515PBt2Gl07p/TiS8Urr/BOgvxuOfYCkP7Cx0EZvZeLfov
        dlt5YzY2Bm9U0JzQs7XA3cSYbA==
X-Google-Smtp-Source: ABdhPJx2Ld/wbAbRbILbWiAee5Y+6gCKSNgdbzGtF3dKE9E6Smt0w4wWQkdSeL78VbfHcPJIjijyOQ==
X-Received: by 2002:a17:903:2002:b0:15c:686f:da1a with SMTP id s2-20020a170903200200b0015c686fda1amr27675060pla.30.1651086497424;
        Wed, 27 Apr 2022 12:08:17 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:e71:6689:b6a2:6150])
        by smtp.gmail.com with UTF8SMTPSA id g5-20020a17090a640500b001cd4989ff53sm3718026pjj.26.2022.04.27.12.08.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 12:08:17 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org
Cc:     bleung@chromium.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 2/2] iio: common: cros_ec_sensors: Add label attribute
Date:   Wed, 27 Apr 2022 12:08:04 -0700
Message-Id: <20220427190804.961697-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
In-Reply-To: <20220427190804.961697-1-gwendal@chromium.org>
References: <20220427190804.961697-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When sensor location is known, populate iio sysfs "label" attribute:

* "accel-base" : the sensor is in the base of the convertible (2-1)
  device.
* "accel-display" : the sensor is in the lid/display plane of the
  device.
* "accel-camera" : the sensor is in the swivel camera subassembly.

The non-standard |location| attribute is removed, the field |loc| in
cros_ec_sensors_core_state is removed.

It apply to standalone accelerometer as well as IMU (accelerometer +
gyroscope) and sensors where the location is known (light).

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 changes in v2:
 * Use "accel-camera" define.
 * remove |location| attribute completely.
 * remove ->loc field, and duplication of setting ->type field.

 drivers/iio/accel/cros_ec_accel_legacy.c      |  2 +-
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 30 ++++++-------------
 drivers/iio/light/cros_ec_light_prox.c        |  2 --
 drivers/iio/pressure/cros_ec_baro.c           |  2 --
 .../linux/iio/common/cros_ec_sensors_core.h   |  2 --
 5 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
index b6f3471b62dcf..1c0171f26e99e 100644
--- a/drivers/iio/accel/cros_ec_accel_legacy.c
+++ b/drivers/iio/accel/cros_ec_accel_legacy.c
@@ -230,7 +230,7 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
 	indio_dev->channels = cros_ec_accel_legacy_channels;
 	indio_dev->num_channels = ARRAY_SIZE(cros_ec_accel_legacy_channels);
 	/* The lid sensor needs to be presented inverted. */
-	if (state->loc == MOTIONSENSE_LOC_LID) {
+	if (!strcmp(indio_dev->label, "accel-display")) {
 		state->sign[CROS_EC_SENSOR_X] = -1;
 		state->sign[CROS_EC_SENSOR_Z] = -1;
 	}
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 5976aca48e3bd..e5ccedef13a80 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -29,12 +29,6 @@
  */
 #define CROS_EC_FIFO_SIZE (2048 * 2 / 3)
 
-static char *cros_ec_loc[] = {
-	[MOTIONSENSE_LOC_BASE] = "base",
-	[MOTIONSENSE_LOC_LID] = "lid",
-	[MOTIONSENSE_LOC_MAX] = "unknown",
-};
-
 static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
 					     u16 cmd_offset, u16 cmd, u32 *mask)
 {
@@ -287,6 +281,8 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 	indio_dev->name = pdev->name;
 
 	if (physical_device) {
+		enum motionsensor_location loc;
+
 		state->param.cmd = MOTIONSENSE_CMD_INFO;
 		state->param.info.sensor_num = sensor_platform->sensor_num;
 		ret = cros_ec_motion_send_host_cmd(state, 0);
@@ -295,7 +291,13 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 			return ret;
 		}
 		state->type = state->resp->info.type;
-		state->loc = state->resp->info.location;
+		loc = state->resp->info.location;
+		if (loc == MOTIONSENSE_LOC_BASE)
+			indio_dev->label = "accel-base";
+		else if (loc == MOTIONSENSE_LOC_LID)
+			indio_dev->label = "accel-display";
+		else if (loc == MOTIONSENSE_LOC_CAMERA)
+			indio_dev->label = "accel-camera";
 
 		/* Set sign vector, only used for backward compatibility. */
 		memset(state->sign, 1, CROS_EC_SENSOR_MAX_AXIS);
@@ -442,15 +444,6 @@ static ssize_t cros_ec_sensors_id(struct iio_dev *indio_dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", st->param.info.sensor_num);
 }
 
-static ssize_t cros_ec_sensors_loc(struct iio_dev *indio_dev,
-		uintptr_t private, const struct iio_chan_spec *chan,
-		char *buf)
-{
-	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
-
-	return snprintf(buf, PAGE_SIZE, "%s\n", cros_ec_loc[st->loc]);
-}
-
 const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[] = {
 	{
 		.name = "calibrate",
@@ -462,11 +455,6 @@ const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[] = {
 		.shared = IIO_SHARED_BY_ALL,
 		.read = cros_ec_sensors_id
 	},
-	{
-		.name = "location",
-		.shared = IIO_SHARED_BY_ALL,
-		.read = cros_ec_sensors_loc
-	},
 	{ },
 };
 EXPORT_SYMBOL_GPL(cros_ec_sensors_ext_info);
diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
index de472f23d1cba..a00a8b3b86cfa 100644
--- a/drivers/iio/light/cros_ec_light_prox.c
+++ b/drivers/iio/light/cros_ec_light_prox.c
@@ -188,8 +188,6 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
 
 	indio_dev->info = &cros_ec_light_prox_info;
 	state = iio_priv(indio_dev);
-	state->core.type = state->core.resp->info.type;
-	state->core.loc = state->core.resp->info.location;
 	channel = state->channels;
 
 	/* Common part */
diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
index 2f882e1094232..1d9d34ae3c0a8 100644
--- a/drivers/iio/pressure/cros_ec_baro.c
+++ b/drivers/iio/pressure/cros_ec_baro.c
@@ -145,8 +145,6 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
 
 	indio_dev->info = &cros_ec_baro_info;
 	state = iio_priv(indio_dev);
-	state->core.type = state->core.resp->info.type;
-	state->core.loc = state->core.resp->info.location;
 	channel = state->channels;
 	/* Common part */
 	channel->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index c582e1a142320..a8259c8822f56 100644
--- a/include/linux/iio/common/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -41,7 +41,6 @@ typedef irqreturn_t (*cros_ec_sensors_capture_t)(int irq, void *p);
  * @param:			motion sensor parameters structure
  * @resp:			motion sensor response structure
  * @type:			type of motion sensor
- * @loc:			location where the motion sensor is placed
  * @range_updated:		True if the range of the sensor has been
  *				updated.
  * @curr_range:			If updated, the current range value.
@@ -67,7 +66,6 @@ struct cros_ec_sensors_core_state {
 	struct ec_response_motion_sense *resp;
 
 	enum motionsensor_type type;
-	enum motionsensor_location loc;
 
 	bool range_updated;
 	int curr_range;
-- 
2.36.0.464.gb9c8b46e94-goog

