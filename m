Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61662CF5BA
	for <lists+linux-iio@lfdr.de>; Fri,  4 Dec 2020 21:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgLDUij (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Dec 2020 15:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgLDUij (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Dec 2020 15:38:39 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CCFC0613D1
        for <linux-iio@vger.kernel.org>; Fri,  4 Dec 2020 12:37:59 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id b23so3779680pls.11
        for <linux-iio@vger.kernel.org>; Fri, 04 Dec 2020 12:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=STUIfJSOggxSw+6qJfYdEmopEg25cEyRg4dVW6fPcPI=;
        b=mhtOJ/N+q45zF/inV2N9TsMZBo+9uH3hs8TwG4ErMl3hjVC5wZEIuqWReHFSr3rhL2
         QFDzFPKDyHi0FJfzT5o8kJ3ARqNBHt4RsH93WanHeXziDW/nauGwfpmRkbBrJBv1nf75
         n1azDjbiHujKsGw/ntblpS3141Nipa7O7AtJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=STUIfJSOggxSw+6qJfYdEmopEg25cEyRg4dVW6fPcPI=;
        b=e1DuOCYyIaQ8d6mn0iYCs+d/hyTnYF1p7RODKMa9OAa2XPNxVILLqcjHeiEG3ZHcVb
         /zV/92Kv6EVVhFtqX4CT242aPwuOHrA/ak07/+IXDkuvZbQOv7LEIPTRAQXt8484Jn6k
         vfsk098QOgRk95H+HFqTYpAQEc6IIXPww10/vTXcf+EhlnIZXLfF7yiv1UiMrRMUWcPE
         OXeqyBtaCzAr5OrjdyDLrl8XVFAu3/awfSjXVpSXWlncBy/Qe4vpoZW4fGNb32qffJua
         iDLfAmQApbW69rIdxTrbrgJjRX0bOBXjmoLE5ZdpFiOtywmUbnch0DJbC0hsDlGZDg5B
         Paxw==
X-Gm-Message-State: AOAM533R8ZAEQm/M7ECRFwQlV0aGBOU36ZYUwVJo+5i0+XAvqgEYWv+x
        0L+8rCmE2eWwXuFsjnHx9H1GVg==
X-Google-Smtp-Source: ABdhPJyYtPzwDRmIdtkkGIIeva+IkE9LDom8RmXJOWtcZMkMbGtYVeEYe9XLdpRihfpnAmY9Z0C2UQ==
X-Received: by 2002:a17:90a:db48:: with SMTP id u8mr5674233pjx.81.1607114279101;
        Fri, 04 Dec 2020 12:37:59 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id w12sm5695832pfn.136.2020.12.04.12.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 12:37:58 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     gabriele.mzt@gmail.com, jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] iio: acpi_als: Add trigger support
Date:   Fri,  4 Dec 2020 12:37:55 -0800
Message-Id: <20201204203755.818932-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add timestamp channel: use standard procedure to collect timestamp.
As some firmware do not notify on illuminance changes, add a
trigger to periodically query light.
We can either use the device trigger, or a software trigger like sysfs
or hrtimer.

This change is not backward compatible. To get samples from bios that
supports notification, we need to register the hardware trigger first:

echo acpi-als-dev${X} > iio\:device${X}/trigger/current_trigger

Check iio_info reports the sensor as buffer capable:
iio:device0: acpi-als (buffer capable)
Check we can get data on demand:
echo 1 > iio_sysfs_trigger/add_trigger
cat trigger2/name > iio\:device0/trigger/current_trigger
for i in iio\:device0/scan_elements/*_en iio\:device0/buffer/enable ; do
  echo 1 > $i
done
od -x /dev/iio\:device0&
echo 1 > trigger2/trigger_now

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/light/acpi-als.c | 86 +++++++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index 1eafd0b24e182..2619e4b073a59 100644
--- a/drivers/iio/light/acpi-als.c
+++ b/drivers/iio/light/acpi-als.c
@@ -16,11 +16,15 @@
 #include <linux/module.h>
 #include <linux/acpi.h>
 #include <linux/err.h>
+#include <linux/irq.h>
 #include <linux/mutex.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/kfifo_buf.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 
 #define ACPI_ALS_CLASS			"als"
 #define ACPI_ALS_DEVICE_NAME		"acpi-als"
@@ -45,22 +49,22 @@ static const struct iio_chan_spec acpi_als_channels[] = {
 		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) |
 					  BIT(IIO_CHAN_INFO_PROCESSED),
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(1),
 };
 
 /*
  * The event buffer contains timestamp and all the data from
  * the ACPI0008 block. There are multiple, but so far we only
- * support _ALI (illuminance). Once someone adds new channels
- * to acpi_als_channels[], the evt_buffer below will grow
- * automatically.
+ * support _ALI (illuminance):
+ * One channel, paddind and timestamp.
  */
-#define ACPI_ALS_EVT_NR_SOURCES		ARRAY_SIZE(acpi_als_channels)
 #define ACPI_ALS_EVT_BUFFER_SIZE		\
-	(sizeof(s64) + (ACPI_ALS_EVT_NR_SOURCES * sizeof(s32)))
+	(sizeof(s32) + sizeof(s32) + sizeof(s64))
 
 struct acpi_als {
 	struct acpi_device	*device;
 	struct mutex		lock;
+	struct iio_trigger	*trig;
 
 	s32			evt_buffer[ACPI_ALS_EVT_BUFFER_SIZE];
 };
@@ -104,33 +108,20 @@ static void acpi_als_notify(struct acpi_device *device, u32 event)
 {
 	struct iio_dev *indio_dev = acpi_driver_data(device);
 	struct acpi_als *als = iio_priv(indio_dev);
-	s32 *buffer = als->evt_buffer;
-	s64 time_ns = iio_get_time_ns(indio_dev);
-	s32 val;
-	int ret;
-
-	mutex_lock(&als->lock);
 
-	memset(buffer, 0, ACPI_ALS_EVT_BUFFER_SIZE);
+	if (!iio_buffer_enabled(indio_dev) ||
+	    !iio_trigger_using_own(indio_dev))
+		return;
 
 	switch (event) {
 	case ACPI_ALS_NOTIFY_ILLUMINANCE:
-		ret = acpi_als_read_value(als, ACPI_ALS_ILLUMINANCE, &val);
-		if (ret < 0)
-			goto out;
-		*buffer++ = val;
+		iio_trigger_poll_chained(als->trig);
 		break;
 	default:
 		/* Unhandled event */
 		dev_dbg(&device->dev, "Unhandled ACPI ALS event (%08x)!\n",
 			event);
-		goto out;
 	}
-
-	iio_push_to_buffers_with_timestamp(indio_dev, als->evt_buffer, time_ns);
-
-out:
-	mutex_unlock(&als->lock);
 }
 
 static int acpi_als_read_raw(struct iio_dev *indio_dev,
@@ -161,11 +152,37 @@ static const struct iio_info acpi_als_info = {
 	.read_raw		= acpi_als_read_raw,
 };
 
+static irqreturn_t acpi_als_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct acpi_als *als = iio_priv(indio_dev);
+	s32 *buffer = als->evt_buffer;
+	s32 val;
+	int ret;
+
+	mutex_lock(&als->lock);
+
+	memset(buffer, 0, ACPI_ALS_EVT_BUFFER_SIZE);
+	ret = acpi_als_read_value(als, ACPI_ALS_ILLUMINANCE, &val);
+	if (ret < 0)
+		goto out;
+	*buffer++ = val;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, als->evt_buffer,
+					   pf->timestamp);
+out:
+	mutex_unlock(&als->lock);
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static int acpi_als_add(struct acpi_device *device)
 {
 	struct acpi_als *als;
 	struct iio_dev *indio_dev;
-	struct iio_buffer *buffer;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(&device->dev, sizeof(*als));
 	if (!indio_dev)
@@ -180,15 +197,30 @@ static int acpi_als_add(struct acpi_device *device)
 	indio_dev->name = ACPI_ALS_DEVICE_NAME;
 	indio_dev->dev.parent = &device->dev;
 	indio_dev->info = &acpi_als_info;
-	indio_dev->modes = INDIO_BUFFER_SOFTWARE;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = acpi_als_channels;
 	indio_dev->num_channels = ARRAY_SIZE(acpi_als_channels);
 
-	buffer = devm_iio_kfifo_allocate(&device->dev);
-	if (!buffer)
+	als->trig = devm_iio_trigger_alloc(&device->dev,
+					   "%s-dev%d",
+					   indio_dev->name,
+					   indio_dev->id);
+	if (!als->trig)
 		return -ENOMEM;
 
-	iio_device_attach_buffer(indio_dev, buffer);
+	als->trig->dev.parent = &device->dev;
+	iio_trigger_set_drvdata(als->trig, indio_dev);
+	ret = iio_trigger_register(als->trig);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_triggered_buffer_setup(&device->dev,
+					      indio_dev,
+					      iio_pollfunc_store_time,
+					      acpi_als_trigger_handler,
+					      NULL);
+	if (ret)
+		return ret;
 
 	return devm_iio_device_register(&device->dev, indio_dev);
 }
-- 
2.29.2.576.ga3fc446d84-goog

