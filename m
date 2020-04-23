Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE421B5114
	for <lists+linux-iio@lfdr.de>; Thu, 23 Apr 2020 02:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgDWACh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Apr 2020 20:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgDWACg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Apr 2020 20:02:36 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01849C03C1AA
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2020 17:02:36 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 145so1967351pfw.13
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2020 17:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sTWLgOtshATpNFxTq+DHSs8KLIuF8Dd31xNiPcAAu1U=;
        b=hKL3r/VwQHN2ryET6mZlqZljqTwA0CnHIlVqsMn/GYc2AQx2EMQ7vWu/EtMKyXUr4N
         UxtLxq6KYh2kjhZJYi/3s1tudss/9Ps0OUEQse5XpS/yY/+JG/oh6sj1vMl/l0EHDNZF
         XwKzXKW9V6TsPNDjHKtSE0WwmE96H7NUMSnwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sTWLgOtshATpNFxTq+DHSs8KLIuF8Dd31xNiPcAAu1U=;
        b=LmY0XBF41Od/Y/hwSyTdJuPHH72iV5QOMEIHFogGuMwKlkqgLPRyP6S8wT9gns3Naa
         1uxax4y8Dl1CEzIJIwUAqb+FxgNmXjKe76v+Yb+jIUYRjLPhYj4voMTSxmEWnc3idjWf
         tc1eHxp8cLZQmuG1RosPb7ztYx3a3D3Zc7CRgpzV1kZ5DamOgsCFWMMtRiyqRKon+ffd
         To0eaiqLh9GqpzqWgAR4/0+9kJrqeOzREcVYHONQsU5uT1BpjDhe1jj0UKSq13W/3B8c
         RtkxDKCYhmiXRjf3taLRq4St3rI4tszVjG2aI/Ds+tvZL2K1HCgX4gA/ayoL54D6W3eU
         uu7Q==
X-Gm-Message-State: AGi0PuYYiPA9X1ccxgcoj4umY4lfgR8fzcHeqLp8bQSSqZa4O7NymX+t
        QfbSXLfyDPuYKv3/QVZdjHbqvQ==
X-Google-Smtp-Source: APiQypLfxlY6RoefRcmznE1AEdolDHeBNzAT1DehanG/lKhK8/uT5B6mhtWP+RRhZFikxAwIEF1jhA==
X-Received: by 2002:a05:6a00:2b4:: with SMTP id q20mr1109600pfs.104.1587600155479;
        Wed, 22 Apr 2020 17:02:35 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id b73sm662301pfb.52.2020.04.22.17.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 17:02:34 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, jic23@kernel.org
Cc:     bleung@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 1/2] iio: cros_ec: Allow enabling/disabling calibration mode
Date:   Wed, 22 Apr 2020 17:02:29 -0700
Message-Id: <20200423000230.82750-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200423000230.82750-1-gwendal@chromium.org>
References: <20200423000230.82750-1-gwendal@chromium.org>
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
index 69210881ebac8..3286ac00b0436 100644
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
2.26.1.301.g55bc3eb7cb9-goog

