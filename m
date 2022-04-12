Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F714FE9F4
	for <lists+linux-iio@lfdr.de>; Tue, 12 Apr 2022 23:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiDLVcM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Apr 2022 17:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiDLVcL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Apr 2022 17:32:11 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD75AE2F6A
        for <linux-iio@vger.kernel.org>; Tue, 12 Apr 2022 14:10:43 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id y6so152052plg.2
        for <linux-iio@vger.kernel.org>; Tue, 12 Apr 2022 14:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xEUu/MaezyCu7NV0F9OnzDW2+DRu4/dWujqrFfn2gVU=;
        b=NvIhOZgVCSmqcp1cZwMeJfrMdiAXFNNryT7HgEi2zNP8inn+xchq+jkp0Yixy+k2eH
         AoDPcvIJlVkGaMkldBbtC0u23958g0SB4YadZEvAvax9dpRCgxzkxb9eXdeG0qiYB2lw
         jHHohtq6o4jBzP7z0NZFON8cvIECVkPynR9j4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xEUu/MaezyCu7NV0F9OnzDW2+DRu4/dWujqrFfn2gVU=;
        b=69T3UUUnuh9PabWmUNMUPM6b8TGoHLQwSaOG+Rj3NbrYGfjwDhqySTU6Vt9Gduadd0
         ZPxH82AmbjLjWIDtFPISfn/ig1fcil3k4a+Ny/Mr/WlajHD8G5WlpDBnwZGKz/xKGG3T
         T9bJHbbPVoDjl8FQDLMW6YvsqWCw8I0B89ovxqUIPIwxYmipAQ3GC0ucAXsAancXg6px
         H7I/2fgutY3zUCOb98liCEl9suNe2kBImobFyyz5JDORp3wwVXDYzPjk5DOkblWrbkSW
         lBNy3ALxXPNw6XUs8SWxKutz8rcrePNbxXm54o39hzasKkX6muA2X825Jfw0bZ+9uOkJ
         m0tg==
X-Gm-Message-State: AOAM531YCniRgQDInPNosZgogNAbf6thVTlozNJVu4xtTLF2BFo+3ZpZ
        IEU9zNh4RGzrMr0Xvr40o6ePQg==
X-Google-Smtp-Source: ABdhPJx4iEVjTWG2PLhElPIDLbnrrw6d2D8wTEOkN5JU4gaIZYn+B1Y5xRf58JK6Nz6iwTPeMF8HNw==
X-Received: by 2002:a17:90b:4a02:b0:1c6:c1a1:d65c with SMTP id kk2-20020a17090b4a0200b001c6c1a1d65cmr7143394pjb.97.1649797628431;
        Tue, 12 Apr 2022 14:07:08 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:71a2:6c31:3702:8c4f])
        by smtp.gmail.com with UTF8SMTPSA id c139-20020a624e91000000b005060cdff4ffsm479270pfb.129.2022.04.12.14.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 14:07:07 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, enric.balletbo@collabora.com
Cc:     bleung@chromium.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] iio: common: cros_ec_sensors: Add label attribute
Date:   Tue, 12 Apr 2022 14:07:03 -0700
Message-Id: <20220412210703.3842914-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

It apply to standalone accelerometer and IMU (accelerometer +
gyroscope).

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 .../iio/common/cros_ec_sensors/cros_ec_sensors_core.c    | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 989b109a82f47..f86b938b36bf8 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -325,6 +325,8 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 	indio_dev->name = pdev->name;
 
 	if (physical_device) {
+		enum motionsensor_location loc;
+
 		state->param.cmd = MOTIONSENSE_CMD_INFO;
 		state->param.info.sensor_num = sensor_platform->sensor_num;
 		ret = cros_ec_motion_send_host_cmd(state, 0);
@@ -333,7 +335,12 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 			return ret;
 		}
 		state->type = state->resp->info.type;
-		state->loc = state->resp->info.location;
+		loc = state->resp->info.location;
+		if (loc == MOTIONSENSE_LOC_BASE)
+			indio_dev->label = "accel-base";
+		else if (loc == MOTIONSENSE_LOC_LID)
+			indio_dev->label = "accel-display";
+		state->loc = loc;
 
 		/* Set sign vector, only used for backward compatibility. */
 		memset(state->sign, 1, CROS_EC_SENSOR_MAX_AXIS);
-- 
2.35.1.1178.g4f1659d476-goog

