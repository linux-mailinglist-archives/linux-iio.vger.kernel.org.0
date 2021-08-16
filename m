Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9AA3ED045
	for <lists+linux-iio@lfdr.de>; Mon, 16 Aug 2021 10:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhHPIap (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Aug 2021 04:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbhHPIao (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Aug 2021 04:30:44 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6775FC0613C1
        for <linux-iio@vger.kernel.org>; Mon, 16 Aug 2021 01:30:13 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id i22so6411723edq.11
        for <linux-iio@vger.kernel.org>; Mon, 16 Aug 2021 01:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XxCBnIZ5dXssQzzN6VCgXFv518uWR4Tb6f83q4mewwQ=;
        b=WoErGq4ga63J08ObXGiPAf2u+RAOrP3QVMwIeQs4+guK+CEZQ5OyBEKudJGo4KOw+u
         3HVkZr63lCFXnK32WrLOoKXPghO4WiVQ5v5BdMGnqjnQqiviRwONAj73Z3zC4JQ2t1i1
         ScSinjeWMcggwqG4moRj+LLopp/LZyJmC6L3mvQJlFi2i59psIExvzidLaEzNhWrfgab
         NlRFNdnQ3ob3Ygd+B0iMlN3+476DjDiVFd1QTeUbXZ5/3ssJ2xXDid9IhYZvb8VunKY2
         ZQiZspeqqfs2zLjULEZ1y9zoT9TaaRSCqPvhhEes8AeaaPF401nHI1/RxNDvVnf1LTxy
         6lcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XxCBnIZ5dXssQzzN6VCgXFv518uWR4Tb6f83q4mewwQ=;
        b=EgXMxSD7Sbx8pbdx8zEN91Um0b19p9btGR/1KVju77iQLgxy2VdTF5wtCKwQNRFdbw
         J4nyWHerl/9tNH7lbdQ3T8eEVZT9t2h32wpXGF2Uy70JaZxBQ72C/33CcEdfo5GPOM0t
         ScCqqe0ENPiMIjxkIKjkoNXTZv1MBz8rnieH6f4ozPG2VN0hnSHdHKyDGmqcfvGkYDzz
         KpKeS5K1EGxwZobbso+km2zGoB5nERjCL9FvqJq8LC7yzam4cu1WIKQ5SPxuXSZirnzw
         8iQJkrnvewfqEvTwx7dQXwsi5MyJ6n6WfirfEGHlfpB9AEueE+6EugAYfSS6M1b43Tym
         2KVA==
X-Gm-Message-State: AOAM532uictOpxyz8JAiuDGoA39DY95WH6KsRVS+DEfnFhqGBs+jxzvl
        14wV5HH4MUyr3aro8KQ84LEFjcCy+W+V/Zd6
X-Google-Smtp-Source: ABdhPJyBHwWJlt6hQrDX7UKsacE7tlB5sHPe5ddMRCX7mBGnPPqCEKJtqgAB3Cl/n+/fb8cgtXFXxg==
X-Received: by 2002:a50:9fa3:: with SMTP id c32mr19117491edf.354.1629102611735;
        Mon, 16 Aug 2021 01:30:11 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id q30sm4516878edi.84.2021.08.16.01.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 01:30:11 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     denis.ciocca@st.com, jic23@kernel.org,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v2 2/5] iio: st_sensors: remove st_sensors_deallocate_trigger() function
Date:   Mon, 16 Aug 2021 11:28:33 +0300
Message-Id: <20210816082836.67511-3-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210816082836.67511-1-aardelean@deviqon.com>
References: <20210816082836.67511-1-aardelean@deviqon.com>
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

