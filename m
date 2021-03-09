Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA8B331C39
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 02:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhCIBSt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Mar 2021 20:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhCIBS1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Mar 2021 20:18:27 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43214C06174A
        for <linux-iio@vger.kernel.org>; Mon,  8 Mar 2021 17:18:27 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 18so8360454pfo.6
        for <linux-iio@vger.kernel.org>; Mon, 08 Mar 2021 17:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ryixBaZ24up9iNWsKHTuKTkS0yrVXcBIFF88uerV3uM=;
        b=jxickTY6uW9cl3yW6DawrXpmjaA3H8HBlSBgf5L+G7wzXQCawAnWHwoijzAryjd9BU
         A+9H3rN5XS4SLSMdAA7UXx/EhWIgs4bSIcOKzrl5LqCjm2vyplUGOZyAZIJpkBpNi4d/
         jwbHjJuHifzBuphX7wjrSd1dVulEYTG16M+1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ryixBaZ24up9iNWsKHTuKTkS0yrVXcBIFF88uerV3uM=;
        b=j4GdzVa+Meg3Zam3cBA7IuyoLA9y9x0UC8uZVvrl0ul9hcH1qkspynvWQm8K8C6JCo
         9HfOE3pYc/jT5Nohc8o5AmUrHj0FhRSoVqugVkBSe7y+nxPXfv1/gFAqAwiEQZvPaWW/
         vw3zsUpRa7ugDKg2RSOB6vvrhqHK31sACPMMm4oTC5tPGagG/s6PoqJVetCyiJu6TQSO
         6pZQw++pnsUL4fwLr458QN+L9WBYbg1bn2l0jtUIYHpru7dot6M4DGO91dg4MdU2IzUF
         CZnL0xIbTMgjDUAfJtN2bJXivBOS9xRTyT4oQ4ornkew0TYPJCIERXG6ZvFbDPzO5QFx
         yKnA==
X-Gm-Message-State: AOAM532JuGRg3XIozgLnlgjAxBNqjmx6Z9GlYt85mIUSHLtyTxgMmMD9
        aCq70j8F/PlfsPyFr/5RBMw0GA==
X-Google-Smtp-Source: ABdhPJySbJ3yfehwacklH77OM7vMhzvATtUTavH9WznQCwwkv8vHBSvC/NA1JLLDMDGJUzIPZ/6jtw==
X-Received: by 2002:a05:6a00:1a46:b029:1d5:9acd:798c with SMTP id h6-20020a056a001a46b02901d59acd798cmr1361134pfv.25.1615252706705;
        Mon, 08 Mar 2021 17:18:26 -0800 (PST)
Received: from localhost ([2620:15c:202:201:3cb0:414a:7f1c:ca43])
        by smtp.gmail.com with UTF8SMTPSA id o123sm4015847pfb.16.2021.03.08.17.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 17:18:25 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 1/8] iio: set default trig->dev.parent
Date:   Mon,  8 Mar 2021 17:18:09 -0800
Message-Id: <20210309011816.2024099-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210309011816.2024099-1-gwendal@chromium.org>
References: <20210309011816.2024099-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When allocated with [devm_]iio_trigger_alloc(), set trig device parent to
the device the trigger is allocated for by default.

It can always be reassigned in the probe routine.

Change iio_trigger_alloc() API to add the device pointer to be coherent
with devm_iio_trigger_alloc, using similar interface to
iio_device_alloc().

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes from v2:
- xilinx-xadc-core.c is not using iio_trigger_alloc anymore.
- use parent as argumnet to be consistent with iio_device_alloc().

 drivers/iio/accel/bma180.c                    |  3 +-
 drivers/iio/adc/ad_sigma_delta.c              |  6 ++--
 drivers/iio/adc/at91_adc.c                    |  3 +-
 .../common/hid-sensors/hid-sensor-trigger.c   |  4 +--
 .../common/st_sensors/st_sensors_trigger.c    |  4 +--
 drivers/iio/gyro/itg3200_buffer.c             |  3 +-
 drivers/iio/industrialio-trigger.c            | 36 +++++++++++--------
 drivers/iio/trigger/iio-trig-hrtimer.c        |  2 +-
 drivers/iio/trigger/iio-trig-interrupt.c      |  2 +-
 drivers/iio/trigger/iio-trig-loop.c           |  2 +-
 drivers/iio/trigger/iio-trig-sysfs.c          |  3 +-
 include/linux/iio/iio.h                       |  2 +-
 include/linux/iio/trigger.h                   |  3 +-
 13 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 71f85a3e525b2..b8a7469cdae41 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -1044,7 +1044,7 @@ static int bma180_probe(struct i2c_client *client,
 	indio_dev->info = &bma180_info;
 
 	if (client->irq > 0) {
-		data->trig = iio_trigger_alloc("%s-dev%d", indio_dev->name,
+		data->trig = iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
 			indio_dev->id);
 		if (!data->trig) {
 			ret = -ENOMEM;
@@ -1059,7 +1059,6 @@ static int bma180_probe(struct i2c_client *client,
 			goto err_trigger_free;
 		}
 
-		data->trig->dev.parent = dev;
 		data->trig->ops = &bma180_trigger_ops;
 		iio_trigger_set_drvdata(data->trig, indio_dev);
 		indio_dev->trig = iio_trigger_get(data->trig);
diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 3a6f239d4acca..9289812c0a946 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -475,8 +475,9 @@ static int ad_sd_probe_trigger(struct iio_dev *indio_dev)
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 	int ret;
 
-	sigma_delta->trig = iio_trigger_alloc("%s-dev%d", indio_dev->name,
-						indio_dev->id);
+	sigma_delta->trig = iio_trigger_alloc(&sigma_delta->spi->dev,
+					      "%s-dev%d", indio_dev->name,
+					      indio_dev->id);
 	if (sigma_delta->trig == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
@@ -496,7 +497,6 @@ static int ad_sd_probe_trigger(struct iio_dev *indio_dev)
 		sigma_delta->irq_dis = true;
 		disable_irq_nosync(sigma_delta->spi->irq);
 	}
-	sigma_delta->trig->dev.parent = &sigma_delta->spi->dev;
 	iio_trigger_set_drvdata(sigma_delta->trig, sigma_delta);
 
 	ret = iio_trigger_register(sigma_delta->trig);
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 70750abb5dead..0b5f0c91d0d73 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -625,12 +625,11 @@ static struct iio_trigger *at91_adc_allocate_trigger(struct iio_dev *idev,
 	struct iio_trigger *trig;
 	int ret;
 
-	trig = iio_trigger_alloc("%s-dev%d-%s", idev->name,
+	trig = iio_trigger_alloc(idev->dev.parent, "%s-dev%d-%s", idev->name,
 				 idev->id, trigger->name);
 	if (trig == NULL)
 		return NULL;
 
-	trig->dev.parent = idev->dev.parent;
 	iio_trigger_set_drvdata(trig, idev);
 	trig->ops = &at91_adc_trigger_ops;
 
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 064c32bec9c7b..95ddccb44f1c8 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -255,14 +255,14 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 		return ret;
 	}
 
-	trig = iio_trigger_alloc("%s-dev%d", name, indio_dev->id);
+	trig = iio_trigger_alloc(indio_dev->dev.parent,
+				 "%s-dev%d", name, indio_dev->id);
 	if (trig == NULL) {
 		dev_err(&indio_dev->dev, "Trigger Allocate Failed\n");
 		ret = -ENOMEM;
 		goto error_triggered_buffer_cleanup;
 	}
 
-	trig->dev.parent = indio_dev->dev.parent;
 	iio_trigger_set_drvdata(trig, attrb);
 	trig->ops = &hid_sensor_trigger_ops;
 	ret = iio_trigger_register(trig);
diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
index 2dbd2646e44e9..0b511665dee5f 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -123,7 +123,8 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 	unsigned long irq_trig;
 	int err;
 
-	sdata->trig = iio_trigger_alloc("%s-trigger", indio_dev->name);
+	sdata->trig = iio_trigger_alloc(sdata->dev, "%s-trigger",
+					indio_dev->name);
 	if (sdata->trig == NULL) {
 		dev_err(&indio_dev->dev, "failed to allocate iio trigger.\n");
 		return -ENOMEM;
@@ -131,7 +132,6 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 
 	iio_trigger_set_drvdata(sdata->trig, indio_dev);
 	sdata->trig->ops = trigger_ops;
-	sdata->trig->dev.parent = sdata->dev;
 
 	irq_trig = irqd_get_trigger_type(irq_get_irq_data(sdata->irq));
 	/*
diff --git a/drivers/iio/gyro/itg3200_buffer.c b/drivers/iio/gyro/itg3200_buffer.c
index 1c3c1bd53374a..af0aaa146f0ce 100644
--- a/drivers/iio/gyro/itg3200_buffer.c
+++ b/drivers/iio/gyro/itg3200_buffer.c
@@ -113,7 +113,7 @@ int itg3200_probe_trigger(struct iio_dev *indio_dev)
 	int ret;
 	struct itg3200 *st = iio_priv(indio_dev);
 
-	st->trig = iio_trigger_alloc("%s-dev%d", indio_dev->name,
+	st->trig = iio_trigger_alloc(&st->i2c->dev, "%s-dev%d", indio_dev->name,
 				     indio_dev->id);
 	if (!st->trig)
 		return -ENOMEM;
@@ -127,7 +127,6 @@ int itg3200_probe_trigger(struct iio_dev *indio_dev)
 		goto error_free_trig;
 
 
-	st->trig->dev.parent = &st->i2c->dev;
 	st->trig->ops = &itg3200_trigger_ops;
 	iio_trigger_set_drvdata(st->trig, indio_dev);
 	ret = iio_trigger_register(st->trig);
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index ea3c9859b2589..71e2dd9b946ee 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -514,8 +514,10 @@ static void iio_trig_subirqunmask(struct irq_data *d)
 	trig->subirqs[d->irq - trig->subirq_base].enabled = true;
 }
 
-static __printf(1, 0)
-struct iio_trigger *viio_trigger_alloc(const char *fmt, va_list vargs)
+static __printf(2, 0)
+struct iio_trigger *viio_trigger_alloc(struct device *parent,
+				       const char *fmt,
+				       va_list vargs)
 {
 	struct iio_trigger *trig;
 	int i;
@@ -524,6 +526,7 @@ struct iio_trigger *viio_trigger_alloc(const char *fmt, va_list vargs)
 	if (!trig)
 		return NULL;
 
+	trig->dev.parent = parent;
 	trig->dev.type = &iio_trig_type;
 	trig->dev.bus = &iio_bus_type;
 	device_initialize(&trig->dev);
@@ -559,13 +562,24 @@ struct iio_trigger *viio_trigger_alloc(const char *fmt, va_list vargs)
 	return NULL;
 }
 
-struct iio_trigger *iio_trigger_alloc(const char *fmt, ...)
+/**
+ * iio_trigger_alloc - Allocate a trigger
+ * @parent:		Device to allocate iio_trigger for
+ * @fmt:		trigger name format. If it includes format
+ *			specifiers, the additional arguments following
+ *			format are formatted and inserted in the resulting
+ *			string replacing their respective specifiers.
+ * RETURNS:
+ * Pointer to allocated iio_trigger on success, NULL on failure.
+ */
+struct iio_trigger *iio_trigger_alloc(struct device *parent,
+				      const char *fmt, ...)
 {
 	struct iio_trigger *trig;
 	va_list vargs;
 
 	va_start(vargs, fmt);
-	trig = viio_trigger_alloc(fmt, vargs);
+	trig = viio_trigger_alloc(parent, fmt, vargs);
 	va_end(vargs);
 
 	return trig;
@@ -586,20 +600,14 @@ static void devm_iio_trigger_release(struct device *dev, void *res)
 
 /**
  * devm_iio_trigger_alloc - Resource-managed iio_trigger_alloc()
- * @dev:		Device to allocate iio_trigger for
- * @fmt:		trigger name format. If it includes format
- *			specifiers, the additional arguments following
- *			format are formatted and inserted in the resulting
- *			string replacing their respective specifiers.
- *
  * Managed iio_trigger_alloc.  iio_trigger allocated with this function is
  * automatically freed on driver detach.
  *
  * RETURNS:
  * Pointer to allocated iio_trigger on success, NULL on failure.
  */
-struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,
-						const char *fmt, ...)
+struct iio_trigger *devm_iio_trigger_alloc(struct device *parent,
+					   const char *fmt, ...)
 {
 	struct iio_trigger **ptr, *trig;
 	va_list vargs;
@@ -611,11 +619,11 @@ struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,
 
 	/* use raw alloc_dr for kmalloc caller tracing */
 	va_start(vargs, fmt);
-	trig = viio_trigger_alloc(fmt, vargs);
+	trig = viio_trigger_alloc(parent, fmt, vargs);
 	va_end(vargs);
 	if (trig) {
 		*ptr = trig;
-		devres_add(dev, ptr);
+		devres_add(parent, ptr);
 	} else {
 		devres_free(ptr);
 	}
diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
index 410de837d0417..22940f86003fc 100644
--- a/drivers/iio/trigger/iio-trig-hrtimer.c
+++ b/drivers/iio/trigger/iio-trig-hrtimer.c
@@ -122,7 +122,7 @@ static struct iio_sw_trigger *iio_trig_hrtimer_probe(const char *name)
 	if (!trig_info)
 		return ERR_PTR(-ENOMEM);
 
-	trig_info->swt.trigger = iio_trigger_alloc("%s", name);
+	trig_info->swt.trigger = iio_trigger_alloc(NULL, "%s", name);
 	if (!trig_info->swt.trigger) {
 		ret = -ENOMEM;
 		goto err_free_trig_info;
diff --git a/drivers/iio/trigger/iio-trig-interrupt.c b/drivers/iio/trigger/iio-trig-interrupt.c
index 94a487caf4214..f746c460bf2a5 100644
--- a/drivers/iio/trigger/iio-trig-interrupt.c
+++ b/drivers/iio/trigger/iio-trig-interrupt.c
@@ -45,7 +45,7 @@ static int iio_interrupt_trigger_probe(struct platform_device *pdev)
 
 	irq = irq_res->start;
 
-	trig = iio_trigger_alloc("irqtrig%d", irq);
+	trig = iio_trigger_alloc(NULL, "irqtrig%d", irq);
 	if (!trig) {
 		ret = -ENOMEM;
 		goto error_ret;
diff --git a/drivers/iio/trigger/iio-trig-loop.c b/drivers/iio/trigger/iio-trig-loop.c
index 4a00668e32583..96ec06bbe546a 100644
--- a/drivers/iio/trigger/iio-trig-loop.c
+++ b/drivers/iio/trigger/iio-trig-loop.c
@@ -84,7 +84,7 @@ static struct iio_sw_trigger *iio_trig_loop_probe(const char *name)
 	if (!trig_info)
 		return ERR_PTR(-ENOMEM);
 
-	trig_info->swt.trigger = iio_trigger_alloc("%s", name);
+	trig_info->swt.trigger = iio_trigger_alloc(NULL, "%s", name);
 	if (!trig_info->swt.trigger) {
 		ret = -ENOMEM;
 		goto err_free_trig_info;
diff --git a/drivers/iio/trigger/iio-trig-sysfs.c b/drivers/iio/trigger/iio-trig-sysfs.c
index 0f6b512a5c37b..e9adfff45b39b 100644
--- a/drivers/iio/trigger/iio-trig-sysfs.c
+++ b/drivers/iio/trigger/iio-trig-sysfs.c
@@ -149,7 +149,7 @@ static int iio_sysfs_trigger_probe(int id)
 		goto out1;
 	}
 	t->id = id;
-	t->trig = iio_trigger_alloc("sysfstrig%d", id);
+	t->trig = iio_trigger_alloc(&iio_sysfs_trig_dev, "sysfstrig%d", id);
 	if (!t->trig) {
 		ret = -ENOMEM;
 		goto free_t;
@@ -157,7 +157,6 @@ static int iio_sysfs_trigger_probe(int id)
 
 	t->trig->dev.groups = iio_sysfs_trigger_attr_groups;
 	t->trig->ops = &iio_sysfs_trigger_ops;
-	t->trig->dev.parent = &iio_sysfs_trig_dev;
 	iio_trigger_set_drvdata(t->trig, t);
 
 	t->work = IRQ_WORK_INIT_HARD(iio_sysfs_trigger_work);
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index e4a9822e64950..5ca4b1d33e153 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -698,7 +698,7 @@ static inline void *iio_priv(const struct iio_dev *indio_dev)
 void iio_device_free(struct iio_dev *indio_dev);
 struct iio_dev *devm_iio_device_alloc(struct device *parent, int sizeof_priv);
 __printf(2, 3)
-struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,
+struct iio_trigger *devm_iio_trigger_alloc(struct device *parent,
 					   const char *fmt, ...);
 /**
  * iio_buffer_enabled() - helper function to test if the buffer is enabled
diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index 055890b6ffcf0..87c1a14dc1662 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -161,7 +161,8 @@ void iio_trigger_poll_chained(struct iio_trigger *trig);
 
 irqreturn_t iio_trigger_generic_data_rdy_poll(int irq, void *private);
 
-__printf(1, 2) struct iio_trigger *iio_trigger_alloc(const char *fmt, ...);
+__printf(2, 3) struct iio_trigger *iio_trigger_alloc(struct device *parent,
+						     const char *fmt, ...);
 void iio_trigger_free(struct iio_trigger *trig);
 
 /**
-- 
2.30.1.766.gb4fecdf3b7-goog

