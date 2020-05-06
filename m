Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B481C7DB3
	for <lists+linux-iio@lfdr.de>; Thu,  7 May 2020 01:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgEFXDo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 May 2020 19:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgEFXDf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 May 2020 19:03:35 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CEDC061A10
        for <linux-iio@vger.kernel.org>; Wed,  6 May 2020 16:03:35 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w65so1929223pfc.12
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2020 16:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fykYEAZBREXkb37+0Le9Kbmd8C0bOVDbkDBjBlbVUGs=;
        b=lfgwokHK0Brklpzmvej4JY8UQXjySJzJ+cT+2XjoIkDqqZjSbOTNZ6iPY8vjZi9La1
         akivu/sXiwoKnL4CijDaXD1urZM8fMii/n8Xu0NMSP+goA0/yhjTXDuxVTfoo1Bn0cmK
         azlsh4ZzLuWf0l/Ut5hrPMr6DfpcJbBBQHiLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fykYEAZBREXkb37+0Le9Kbmd8C0bOVDbkDBjBlbVUGs=;
        b=U/SgcXyf47Q9XpvXmSrsiz94TfJCmt2vzZYXXp9nFiDeKUdmdfvaLPdG6JWdCL2/Km
         H6aROXfWuUCsIRn4Rr6XwajrqERr2Z6rHhvKWXlU+63ud2Q9KztUxUkdoLDtSgqQMr0E
         eaFxRNLCuvcHIUz7tS/iUPydtFc40mU4gJJoLY8cS1A6Ehkn00p6cMqaTs2pA8dqQ8CM
         HNClw36o/OOK+58J9upnqyWXUnJbCdIOgkLMPTCmXQlWNiS0H6Ss5u8T6jzxijpIOynr
         ZOnaLXBtCDtmzKHI12IBH3XwJ+rNCWUgh4AnxOD6V0QoWI3Za5XQRNk/huzeSfVCJfo5
         oesw==
X-Gm-Message-State: AGi0PuY/rTiY4Y4nnuqh54k3s8iPZkdErAMEqMEhGp4PLUdRfL9U6qly
        Z78z0HF8WjU8PtBONGq44xu4Qw==
X-Google-Smtp-Source: APiQypJzs+W5WYsIPFMtcylCwrB5U4odFnrNJsA8N4YlUV03urAgiM46sr3oUpC6aJ8qe9h4yvm5KQ==
X-Received: by 2002:a62:fc82:: with SMTP id e124mr10932061pfh.126.1588806215221;
        Wed, 06 May 2020 16:03:35 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id e2sm5555852pjt.2.2020.05.06.16.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 16:03:34 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, jic23@kernel.org
Cc:     bleung@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 2/3] iio: cros_ec: Allow enabling/disabling calibration mode
Date:   Wed,  6 May 2020 16:03:23 -0700
Message-Id: <20200506230324.139241-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
In-Reply-To: <20200506230324.139241-1-gwendal@chromium.org>
References: <20200506230324.139241-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

calibration was a one-shot event sent to the sensor to calibrate itself.
It is used on Bosch sensors (BMI160, BMA254).
For TCS3400 light sensor, we need to stay in calibration mode to run
tests.
Accept boolean true and false (not just true) to enter/exit calibration.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 .../common/cros_ec_sensors/cros_ec_sensors_core.c    |  3 +--
 include/linux/platform_data/cros_ec_commands.h       | 12 +++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index c831915ca7e56..3d8b25ee9d80c 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -411,11 +411,10 @@ static ssize_t cros_ec_sensors_calibrate(struct iio_dev *indio_dev,
 	ret = strtobool(buf, &calibrate);
 	if (ret < 0)
 		return ret;
-	if (!calibrate)
-		return -EINVAL;
 
 	mutex_lock(&st->cmd_lock);
 	st->param.cmd = MOTIONSENSE_CMD_PERFORM_CALIB;
+	st->param.perform_calib.enable = calibrate;
 	ret = cros_ec_motion_send_host_cmd(st, 0);
 	if (ret != 0) {
 		dev_warn(&indio_dev->dev, "Unable to calibrate sensor\n");
diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 451885c697cc3..395c9b2b05c66 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -2517,13 +2517,19 @@ struct ec_params_motion_sense {
 
 		/*
 		 * Used for MOTIONSENSE_CMD_INFO, MOTIONSENSE_CMD_DATA
-		 * and MOTIONSENSE_CMD_PERFORM_CALIB.
 		 */
 		struct __ec_todo_unpacked {
 			uint8_t sensor_num;
-		} info, info_3, data, fifo_flush, perform_calib,
-				list_activities;
+		} info, info_3, data, fifo_flush, list_activities;
 
+		/*
+		 * Used for MOTIONSENSE_CMD_PERFORM_CALIB:
+		 * Allow entering/exiting the calibration mode.
+		 */
+		struct __ec_todo_unpacked {
+			uint8_t sensor_num;
+			uint8_t enable;
+		} perform_calib;
 		/*
 		 * Used for MOTIONSENSE_CMD_EC_RATE, MOTIONSENSE_CMD_SENSOR_ODR
 		 * and MOTIONSENSE_CMD_SENSOR_RANGE.
-- 
2.26.2.526.g744177e7f7-goog

