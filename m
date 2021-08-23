Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9071A3F499F
	for <lists+linux-iio@lfdr.de>; Mon, 23 Aug 2021 13:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbhHWLXV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Aug 2021 07:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236235AbhHWLXU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Aug 2021 07:23:20 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A912BC061757
        for <linux-iio@vger.kernel.org>; Mon, 23 Aug 2021 04:22:37 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u14so11431483ejf.13
        for <linux-iio@vger.kernel.org>; Mon, 23 Aug 2021 04:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CFnjzcAbZ1Fd/XLqR8h8NXilZLyCPtQhYrh56Atnm9o=;
        b=ZC69gpbQcNfx5hej4qegAOT97Q9haDxvDHrogtL6ILfE1ZSXXgJi2Cx8U7NwZ+rIT8
         GPCgLhRAY228g9QRmcn1wwtj3xnGoxs+LueT/ZIoeWE+0MrxsDVwWwnThjC28v7lfL78
         lEWqV2RBrmbwGr+3dyUwC+DU5Qn8QpgEr/kaLNdVjs8ggGI14850kdMp2jhK4rioad72
         cscGAIth38XewhL7VOZtcJkUoFnOXDYCHqpv39socxxhk/avJ7Q0TUQN9clk/XUeib2G
         yQ6gTJ6PSe7qTM3zsmvNeQFv+2gVYIFHQLKgfDNM1RH7zE1E0QDFQG5C7F26KBKwzK/T
         oEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CFnjzcAbZ1Fd/XLqR8h8NXilZLyCPtQhYrh56Atnm9o=;
        b=PMmlRLWc2Iz2lKvp+pFxSspecXrljtgl3woaJ2anwiYNnzfjcrow+6izlBfka2uAFw
         exg/wGxSWL7AIZMcNuP1i2fGr8CpAaiozpR+jVhyLoCMmubBfCcOXMGz1yULzoHnboS9
         i+qawmfiMpbBCUx9vOBo0PZVTJyNNRS/x19rGVX5iMvEVCtPbWTxdajF8hfEgoizJ6RG
         6IRNLnfgIH950KTky+oUbw+3DoGdiYW1G5D/aa+RJPHd3eJkc7wdhhIwAtC0DAng0PX7
         FTJSe/lo3d6/9x4v2N0PrEifMmCJJXLT0JX8/j9UkuuWcqVdklzHIVTPJfr8Jjdn5JWC
         7Uvw==
X-Gm-Message-State: AOAM532STEr7F/rxcPmAwsZDkorE9qYTFIIV8xqoQDi28jWdFhrByg0B
        uZ/3vESD0aq5K5+uLxaMB23vUQakhuFrZM7J
X-Google-Smtp-Source: ABdhPJwuz4a91YL3YHScxPSL+n5RaCUMuCncCzP9xcOhw8JnDBuXum87oJ5hr7jONyWYs91SWfswmQ==
X-Received: by 2002:a17:906:c342:: with SMTP id ci2mr35729489ejb.122.1629717756036;
        Mon, 23 Aug 2021 04:22:36 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id d22sm7382212ejj.47.2021.08.23.04.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 04:22:35 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     denis.ciocca@st.com, jic23@kernel.org, linus.walleij@linaro.org,
        lee.jones@linaro.org, andy.shevchenko@gmail.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v3 2/5] iio: st_sensors: remove st_sensors_deallocate_trigger() function
Date:   Mon, 23 Aug 2021 14:22:01 +0300
Message-Id: <20210823112204.243255-3-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210823112204.243255-1-aardelean@deviqon.com>
References: <20210823112204.243255-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change converts the st_sensors_allocate_trigger() to use
device-managed functions.

The parent device of the IIO device object is used. This is based on the
assumption that all other devm_ calls in the ST sensors use this reference.

That makes the st_sensors_deallocate_trigger() function un-needed, so it
can be removed.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/accel/st_accel_core.c             | 18 +-------
 .../common/st_sensors/st_sensors_trigger.c    | 45 +++++++------------
 drivers/iio/gyro/st_gyro_core.c               | 18 +-------
 drivers/iio/magnetometer/st_magn_core.c       | 18 +-------
 drivers/iio/pressure/st_pressure_core.c       | 18 +-------
 include/linux/iio/common/st_sensors.h         |  5 ---
 6 files changed, 19 insertions(+), 103 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index f1e6ec380667..a7be1633bff1 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -1380,29 +1380,13 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 			return err;
 	}
 
-	err = iio_device_register(indio_dev);
-	if (err)
-		goto st_accel_device_register_error;
-
-	dev_info(&indio_dev->dev, "registered accelerometer %s\n",
-		 indio_dev->name);
-
-	return 0;
-
-st_accel_device_register_error:
-	if (adata->irq > 0)
-		st_sensors_deallocate_trigger(indio_dev);
-	return err;
+	return iio_device_register(indio_dev);
 }
 EXPORT_SYMBOL(st_accel_common_probe);
 
 void st_accel_common_remove(struct iio_dev *indio_dev)
 {
-	struct st_sensor_data *adata = iio_priv(indio_dev);
-
 	iio_device_unregister(indio_dev);
-	if (adata->irq > 0)
-		st_sensors_deallocate_trigger(indio_dev);
 }
 EXPORT_SYMBOL(st_accel_common_remove);
 
diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
index 64e0a748a855..d022157b66a2 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -119,11 +119,12 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 				const struct iio_trigger_ops *trigger_ops)
 {
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
+	struct device *parent = indio_dev->dev.parent;
 	unsigned long irq_trig;
 	int err;
 
-	sdata->trig = iio_trigger_alloc(sdata->dev, "%s-trigger",
-					indio_dev->name);
+	sdata->trig = devm_iio_trigger_alloc(parent, "%s-trigger",
+					     indio_dev->name);
 	if (sdata->trig == NULL) {
 		dev_err(&indio_dev->dev, "failed to allocate iio trigger.\n");
 		return -ENOMEM;
@@ -153,7 +154,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 				sdata->sensor_settings->drdy_irq.addr_ihl,
 				sdata->sensor_settings->drdy_irq.mask_ihl, 1);
 			if (err < 0)
-				goto iio_trigger_free;
+				return err;
 			dev_info(&indio_dev->dev,
 				 "interrupts on the falling edge or active low level\n");
 		}
@@ -179,8 +180,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 		if (!sdata->sensor_settings->drdy_irq.stat_drdy.addr) {
 			dev_err(&indio_dev->dev,
 				"edge IRQ not supported w/o stat register.\n");
-			err = -EOPNOTSUPP;
-			goto iio_trigger_free;
+			return -EOPNOTSUPP;
 		}
 		sdata->edge_irq = true;
 	} else {
@@ -205,44 +205,29 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 	    sdata->sensor_settings->drdy_irq.stat_drdy.addr)
 		irq_trig |= IRQF_SHARED;
 
-	err = request_threaded_irq(sdata->irq,
-				   st_sensors_irq_handler,
-				   st_sensors_irq_thread,
-				   irq_trig,
-				   sdata->trig->name,
-				   sdata->trig);
+	err = devm_request_threaded_irq(parent,
+					sdata->irq,
+					st_sensors_irq_handler,
+					st_sensors_irq_thread,
+					irq_trig,
+					sdata->trig->name,
+					sdata->trig);
 	if (err) {
 		dev_err(&indio_dev->dev, "failed to request trigger IRQ.\n");
-		goto iio_trigger_free;
+		return err;
 	}
 
-	err = iio_trigger_register(sdata->trig);
+	err = devm_iio_trigger_register(parent, sdata->trig);
 	if (err < 0) {
 		dev_err(&indio_dev->dev, "failed to register iio trigger.\n");
-		goto iio_trigger_register_error;
+		return err;
 	}
 	indio_dev->trig = iio_trigger_get(sdata->trig);
 
 	return 0;
-
-iio_trigger_register_error:
-	free_irq(sdata->irq, sdata->trig);
-iio_trigger_free:
-	iio_trigger_free(sdata->trig);
-	return err;
 }
 EXPORT_SYMBOL(st_sensors_allocate_trigger);
 
-void st_sensors_deallocate_trigger(struct iio_dev *indio_dev)
-{
-	struct st_sensor_data *sdata = iio_priv(indio_dev);
-
-	iio_trigger_unregister(sdata->trig);
-	free_irq(sdata->irq, sdata->trig);
-	iio_trigger_free(sdata->trig);
-}
-EXPORT_SYMBOL(st_sensors_deallocate_trigger);
-
 int st_sensors_validate_device(struct iio_trigger *trig,
 			       struct iio_dev *indio_dev)
 {
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index e8fc8af65143..cb539b47cdf4 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -515,29 +515,13 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
 			return err;
 	}
 
-	err = iio_device_register(indio_dev);
-	if (err)
-		goto st_gyro_device_register_error;
-
-	dev_info(&indio_dev->dev, "registered gyroscope %s\n",
-		 indio_dev->name);
-
-	return 0;
-
-st_gyro_device_register_error:
-	if (gdata->irq > 0)
-		st_sensors_deallocate_trigger(indio_dev);
-	return err;
+	return iio_device_register(indio_dev);
 }
 EXPORT_SYMBOL(st_gyro_common_probe);
 
 void st_gyro_common_remove(struct iio_dev *indio_dev)
 {
-	struct st_sensor_data *gdata = iio_priv(indio_dev);
-
 	iio_device_unregister(indio_dev);
-	if (gdata->irq > 0)
-		st_sensors_deallocate_trigger(indio_dev);
 }
 EXPORT_SYMBOL(st_gyro_common_remove);
 
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 9ffd50d796bf..5be85e2405a5 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -650,29 +650,13 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
 			return err;
 	}
 
-	err = iio_device_register(indio_dev);
-	if (err)
-		goto st_magn_device_register_error;
-
-	dev_info(&indio_dev->dev, "registered magnetometer %s\n",
-		 indio_dev->name);
-
-	return 0;
-
-st_magn_device_register_error:
-	if (mdata->irq > 0)
-		st_sensors_deallocate_trigger(indio_dev);
-	return err;
+	return iio_device_register(indio_dev);
 }
 EXPORT_SYMBOL(st_magn_common_probe);
 
 void st_magn_common_remove(struct iio_dev *indio_dev)
 {
-	struct st_sensor_data *mdata = iio_priv(indio_dev);
-
 	iio_device_unregister(indio_dev);
-	if (mdata->irq > 0)
-		st_sensors_deallocate_trigger(indio_dev);
 }
 EXPORT_SYMBOL(st_magn_common_remove);
 
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index ab1c17fac807..17ebb5171d4c 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -721,29 +721,13 @@ int st_press_common_probe(struct iio_dev *indio_dev)
 			return err;
 	}
 
-	err = iio_device_register(indio_dev);
-	if (err)
-		goto st_press_device_register_error;
-
-	dev_info(&indio_dev->dev, "registered pressure sensor %s\n",
-		 indio_dev->name);
-
-	return err;
-
-st_press_device_register_error:
-	if (press_data->irq > 0)
-		st_sensors_deallocate_trigger(indio_dev);
-	return err;
+	return iio_device_register(indio_dev);
 }
 EXPORT_SYMBOL(st_press_common_probe);
 
 void st_press_common_remove(struct iio_dev *indio_dev)
 {
-	struct st_sensor_data *press_data = iio_priv(indio_dev);
-
 	iio_device_unregister(indio_dev);
-	if (press_data->irq > 0)
-		st_sensors_deallocate_trigger(indio_dev);
 }
 EXPORT_SYMBOL(st_press_common_remove);
 
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 8bdbaf3f3796..e74b55244f35 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -273,7 +273,6 @@ irqreturn_t st_sensors_trigger_handler(int irq, void *p);
 int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 				const struct iio_trigger_ops *trigger_ops);
 
-void st_sensors_deallocate_trigger(struct iio_dev *indio_dev);
 int st_sensors_validate_device(struct iio_trigger *trig,
 			       struct iio_dev *indio_dev);
 #else
@@ -282,10 +281,6 @@ static inline int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 {
 	return 0;
 }
-static inline void st_sensors_deallocate_trigger(struct iio_dev *indio_dev)
-{
-	return;
-}
 #define st_sensors_validate_device NULL
 #endif
 
-- 
2.31.1

