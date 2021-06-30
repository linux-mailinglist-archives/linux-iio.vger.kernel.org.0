Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C65A3B8229
	for <lists+linux-iio@lfdr.de>; Wed, 30 Jun 2021 14:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbhF3MdU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Jun 2021 08:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbhF3MdU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Jun 2021 08:33:20 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B248C061766
        for <linux-iio@vger.kernel.org>; Wed, 30 Jun 2021 05:30:50 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id i24so3001814edx.4
        for <linux-iio@vger.kernel.org>; Wed, 30 Jun 2021 05:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y/NiruVedtLXXcwtmHdL7yKXuqcEb3kTC2VwZHt24F0=;
        b=lyRAmwLNmZQr8elDlzNE/ZwhMZVeTVx3L4Y+rrM5hwdWMI7XJ8U8rbAbEVOGx3vFPx
         JHECnhq7sz6axmuGyvPo35D3LfXqsI7qSbRAHmon/VMT03wtt/fsZacWoCqY14gexFvG
         CBNzTQP0I5UG+FcgeIxCiF0KA19VA1vNlinRsEujWMMqK4jqiPidB+ofkBwngwUkMUlk
         GXD8nqUrbY8tGi5QAt2szudgY9psIto5gbubGqQotaFqndHFtth7k5HCYi/4/6abpF3R
         aNnq0WSpaaFK3OqZwYfYD3aIl3FHbbY8ZTjyT+udPOAsS4eIvtfSetKZ11KX/HUXiQf9
         0ytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y/NiruVedtLXXcwtmHdL7yKXuqcEb3kTC2VwZHt24F0=;
        b=hNgOkidOyTquAYYU3ZdxTrB8YrwHkYp5ZMnY5B8ySt+rk9Y3A/3d86k3c4/8/2ymBS
         muctHuZctBdX1y5W4/l04s0K2oodjGR4SFkfXIg2ZMcz2Ll/WjNakQqujGJ/DeOrVcMM
         qCQdLZvNi3y+8vXOlbW5JaM1cT2ik7iDF5ylX9iSgTyyHfwx7iVLYM9pUoIED8IVVWsS
         r9VC4hSxbt5MTueK19c9AZfvRxtgf+Fnn9RhIILY8BipXVaRWFLLGCP69Dif1gFRcS4G
         XYzxAbpV6Xul3vAZe79TfXyp+Y+gfBb/ZHp3zMUu7vnbwQdA0/Vr8/sY8bGu6sXz6lTg
         e+Qg==
X-Gm-Message-State: AOAM532br4lmxVVJwyFcLJEF/0e5qRPRBHa3IE2w+hO8yZ+ZOz/Gb8oL
        uofoq81bJADcURu60tm38CcGPhTk22RDlbv2
X-Google-Smtp-Source: ABdhPJxueKb4to0PneFmftPCn0BqxSotcbL/q0VxIKaL1Q5nKdNH4gFy7Hwx7rPfI71HMU1G86vpFA==
X-Received: by 2002:a05:6402:40c3:: with SMTP id z3mr45126000edb.375.1625056248847;
        Wed, 30 Jun 2021 05:30:48 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id u21sm11079046edv.20.2021.06.30.05.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 05:30:48 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, srinivas.pandruvada@linux.intel.com,
        jikos@kernel.org, Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] iio: hid-sensors: bind IIO channels alloc to device object
Date:   Wed, 30 Jun 2021 15:30:29 +0300
Message-Id: <20210630123029.759609-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some HID drivers use devm_kmemdup() already to clone the template IIO
channels information and update it.
However, there are still some drivers that kmemdup() and kfree() the
channels.

This change converts them to use devm_kmemdup() and bind the life-time of
this allocated object to the parent device object (in these drivers).

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c      | 10 ++++------
 drivers/iio/gyro/hid-sensor-gyro-3d.c        | 11 ++++-------
 drivers/iio/light/hid-sensor-als.c           | 11 ++++-------
 drivers/iio/light/hid-sensor-prox.c          | 11 ++++-------
 drivers/iio/orientation/hid-sensor-incl-3d.c | 11 ++++-------
 drivers/iio/pressure/hid-sensor-press.c      | 11 ++++-------
 6 files changed, 24 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 55cdca818b3b..a2def6f9380a 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -367,7 +367,8 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to setup common attributes\n");
 		return ret;
 	}
-	indio_dev->channels = kmemdup(channel_spec, channel_size, GFP_KERNEL);
+	indio_dev->channels = devm_kmemdup(&pdev->dev, channel_spec,
+					   channel_size, GFP_KERNEL);
 
 	if (!indio_dev->channels) {
 		dev_err(&pdev->dev, "failed to duplicate channels\n");
@@ -378,7 +379,7 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 				hsdev->usage, accel_state);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup attributes\n");
-		goto error_free_dev_mem;
+		return ret;
 	}
 
 	indio_dev->info = &accel_3d_info;
@@ -391,7 +392,7 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 					&accel_state->common_attributes);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "trigger setup failed\n");
-		goto error_free_dev_mem;
+		return ret;
 	}
 
 	ret = iio_device_register(indio_dev);
@@ -416,8 +417,6 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
 	hid_sensor_remove_trigger(indio_dev, &accel_state->common_attributes);
-error_free_dev_mem:
-	kfree(indio_dev->channels);
 	return ret;
 }
 
@@ -431,7 +430,6 @@ static int hid_accel_3d_remove(struct platform_device *pdev)
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	iio_device_unregister(indio_dev);
 	hid_sensor_remove_trigger(indio_dev, &accel_state->common_attributes);
-	kfree(indio_dev->channels);
 
 	return 0;
 }
diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index bc63c2a34c5e..8f0ad022c7f1 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -303,8 +303,8 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	indio_dev->channels = kmemdup(gyro_3d_channels,
-				      sizeof(gyro_3d_channels), GFP_KERNEL);
+	indio_dev->channels = devm_kmemdup(&pdev->dev, gyro_3d_channels,
+					   sizeof(gyro_3d_channels), GFP_KERNEL);
 	if (!indio_dev->channels) {
 		dev_err(&pdev->dev, "failed to duplicate channels\n");
 		return -ENOMEM;
@@ -315,7 +315,7 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 				   HID_USAGE_SENSOR_GYRO_3D, gyro_state);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup attributes\n");
-		goto error_free_dev_mem;
+		return ret;
 	}
 
 	indio_dev->num_channels = ARRAY_SIZE(gyro_3d_channels);
@@ -329,7 +329,7 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 					&gyro_state->common_attributes);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "trigger setup failed\n");
-		goto error_free_dev_mem;
+		return ret;
 	}
 
 	ret = iio_device_register(indio_dev);
@@ -354,8 +354,6 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
 	hid_sensor_remove_trigger(indio_dev, &gyro_state->common_attributes);
-error_free_dev_mem:
-	kfree(indio_dev->channels);
 	return ret;
 }
 
@@ -369,7 +367,6 @@ static int hid_gyro_3d_remove(struct platform_device *pdev)
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
 	iio_device_unregister(indio_dev);
 	hid_sensor_remove_trigger(indio_dev, &gyro_state->common_attributes);
-	kfree(indio_dev->channels);
 
 	return 0;
 }
diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 2ff252c75c03..5a1a625d8d16 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -294,8 +294,8 @@ static int hid_als_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	indio_dev->channels = kmemdup(als_channels,
-				      sizeof(als_channels), GFP_KERNEL);
+	indio_dev->channels = devm_kmemdup(&pdev->dev, als_channels,
+					   sizeof(als_channels), GFP_KERNEL);
 	if (!indio_dev->channels) {
 		dev_err(&pdev->dev, "failed to duplicate channels\n");
 		return -ENOMEM;
@@ -306,7 +306,7 @@ static int hid_als_probe(struct platform_device *pdev)
 			       HID_USAGE_SENSOR_ALS, als_state);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup attributes\n");
-		goto error_free_dev_mem;
+		return ret;
 	}
 
 	indio_dev->num_channels =
@@ -321,7 +321,7 @@ static int hid_als_probe(struct platform_device *pdev)
 				&als_state->common_attributes);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "trigger setup failed\n");
-		goto error_free_dev_mem;
+		return ret;
 	}
 
 	ret = iio_device_register(indio_dev);
@@ -346,8 +346,6 @@ static int hid_als_probe(struct platform_device *pdev)
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
 	hid_sensor_remove_trigger(indio_dev, &als_state->common_attributes);
-error_free_dev_mem:
-	kfree(indio_dev->channels);
 	return ret;
 }
 
@@ -361,7 +359,6 @@ static int hid_als_remove(struct platform_device *pdev)
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_ALS);
 	iio_device_unregister(indio_dev);
 	hid_sensor_remove_trigger(indio_dev, &als_state->common_attributes);
-	kfree(indio_dev->channels);
 
 	return 0;
 }
diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 1621530f5f61..f10fa2abfe72 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -253,8 +253,8 @@ static int hid_prox_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	indio_dev->channels = kmemdup(prox_channels, sizeof(prox_channels),
-				      GFP_KERNEL);
+	indio_dev->channels = devm_kmemdup(&pdev->dev, prox_channels,
+					   sizeof(prox_channels), GFP_KERNEL);
 	if (!indio_dev->channels) {
 		dev_err(&pdev->dev, "failed to duplicate channels\n");
 		return -ENOMEM;
@@ -265,7 +265,7 @@ static int hid_prox_probe(struct platform_device *pdev)
 				HID_USAGE_SENSOR_PROX, prox_state);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup attributes\n");
-		goto error_free_dev_mem;
+		return ret;
 	}
 
 	indio_dev->num_channels = ARRAY_SIZE(prox_channels);
@@ -279,7 +279,7 @@ static int hid_prox_probe(struct platform_device *pdev)
 				&prox_state->common_attributes);
 	if (ret) {
 		dev_err(&pdev->dev, "trigger setup failed\n");
-		goto error_free_dev_mem;
+		return ret;
 	}
 
 	ret = iio_device_register(indio_dev);
@@ -304,8 +304,6 @@ static int hid_prox_probe(struct platform_device *pdev)
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
 	hid_sensor_remove_trigger(indio_dev, &prox_state->common_attributes);
-error_free_dev_mem:
-	kfree(indio_dev->channels);
 	return ret;
 }
 
@@ -319,7 +317,6 @@ static int hid_prox_remove(struct platform_device *pdev)
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PROX);
 	iio_device_unregister(indio_dev);
 	hid_sensor_remove_trigger(indio_dev, &prox_state->common_attributes);
-	kfree(indio_dev->channels);
 
 	return 0;
 }
diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index c0079e2c8807..ba5b581d5b25 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -326,8 +326,8 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	indio_dev->channels = kmemdup(incl_3d_channels,
-				      sizeof(incl_3d_channels), GFP_KERNEL);
+	indio_dev->channels = devm_kmemdup(&pdev->dev, incl_3d_channels,
+					   sizeof(incl_3d_channels), GFP_KERNEL);
 	if (!indio_dev->channels) {
 		dev_err(&pdev->dev, "failed to duplicate channels\n");
 		return -ENOMEM;
@@ -339,7 +339,7 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 				   incl_state);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup attributes\n");
-		goto error_free_dev_mem;
+		return ret;
 	}
 
 	indio_dev->num_channels = ARRAY_SIZE(incl_3d_channels);
@@ -353,7 +353,7 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 					&incl_state->common_attributes);
 	if (ret) {
 		dev_err(&pdev->dev, "trigger setup failed\n");
-		goto error_free_dev_mem;
+		return ret;
 	}
 
 	ret = iio_device_register(indio_dev);
@@ -379,8 +379,6 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
 	hid_sensor_remove_trigger(indio_dev, &incl_state->common_attributes);
-error_free_dev_mem:
-	kfree(indio_dev->channels);
 	return ret;
 }
 
@@ -394,7 +392,6 @@ static int hid_incl_3d_remove(struct platform_device *pdev)
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_INCLINOMETER_3D);
 	iio_device_unregister(indio_dev);
 	hid_sensor_remove_trigger(indio_dev, &incl_state->common_attributes);
-	kfree(indio_dev->channels);
 
 	return 0;
 }
diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 10c52b8df2ba..dcd593c426b4 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -259,8 +259,8 @@ static int hid_press_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	indio_dev->channels = kmemdup(press_channels, sizeof(press_channels),
-				      GFP_KERNEL);
+	indio_dev->channels = devm_kmemdup(&pdev->dev, press_channels,
+					   sizeof(press_channels), GFP_KERNEL);
 	if (!indio_dev->channels) {
 		dev_err(&pdev->dev, "failed to duplicate channels\n");
 		return -ENOMEM;
@@ -271,7 +271,7 @@ static int hid_press_probe(struct platform_device *pdev)
 				 HID_USAGE_SENSOR_PRESSURE, press_state);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup attributes\n");
-		goto error_free_dev_mem;
+		return ret;
 	}
 
 	indio_dev->num_channels =
@@ -286,7 +286,7 @@ static int hid_press_probe(struct platform_device *pdev)
 				&press_state->common_attributes);
 	if (ret) {
 		dev_err(&pdev->dev, "trigger setup failed\n");
-		goto error_free_dev_mem;
+		return ret;
 	}
 
 	ret = iio_device_register(indio_dev);
@@ -311,8 +311,6 @@ static int hid_press_probe(struct platform_device *pdev)
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
 	hid_sensor_remove_trigger(indio_dev, &press_state->common_attributes);
-error_free_dev_mem:
-	kfree(indio_dev->channels);
 	return ret;
 }
 
@@ -326,7 +324,6 @@ static int hid_press_remove(struct platform_device *pdev)
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PRESSURE);
 	iio_device_unregister(indio_dev);
 	hid_sensor_remove_trigger(indio_dev, &press_state->common_attributes);
-	kfree(indio_dev->channels);
 
 	return 0;
 }
-- 
2.31.1

