Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECA22D6921
	for <lists+linux-iio@lfdr.de>; Thu, 10 Dec 2020 21:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404519AbgLJUue (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Dec 2020 15:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404489AbgLJUue (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Dec 2020 15:50:34 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C218C0613D6
        for <linux-iio@vger.kernel.org>; Thu, 10 Dec 2020 12:49:54 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id f9so5252001pfc.11
        for <linux-iio@vger.kernel.org>; Thu, 10 Dec 2020 12:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sxroUl2DinnRDTBKjS3M0R5MauOXGen7PUJ9zRmp5OU=;
        b=YbJibJqGX+aBDVDm00VmoRnHSBWsTjAhdRi/VtJxZQPUPeIdB7o2pvE2nHWXPWFU50
         QyCWG1iKVX23fRa1C3ocmbzYq94N3jYO70KnfbRrgk9i7iGUX2sBNjNNH1qPxb61PJjt
         uUHJZNLMntmJ809mWXpCrvzVbB/AWcHeklIqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sxroUl2DinnRDTBKjS3M0R5MauOXGen7PUJ9zRmp5OU=;
        b=T9qtZiKDJsLwqiQPMgyCVqkKC0+aJ6akrZ1ZZx768HpN9zB51UJuzbidZPx8Z7QUJg
         f51EXHqrPe6fF/YRXo9XeW8TslsfKs0HTCv3RKVDyg219+bnr7sakoyVNXRelnk498xc
         6fAPmipXmSJVQmaxI72wCBeJ8NUR1FRB6agp2Fut0uAEO0A5xBqystzSGOQmz6oVZv9e
         YsaGU67sPvcAIAOKHHaHYkT/mQd/Wxo87kzXzPztYPSLCAi/xqa9ej57cxtmbAWqSR/J
         Nd2EKxWL7rrWexxPO8ge68lxnuD2p4VR7C8n/2bWNzPfYxmn5mcIr62eNaWyOoSkrDOy
         ruyw==
X-Gm-Message-State: AOAM532ggcMM4G2iYWZdZ9k1Il1am3Ow9GATmplW9/5FuIlWFa2emIAJ
        7d4i7i83dHWPYEweUe1wiYr6mQ==
X-Google-Smtp-Source: ABdhPJw9MRlU9ZXLk95EXMn+GpVzubjqpw0IPk7TH9nvJbpbbIFuL1u6kxFq47f3Wt2c/44Lo84BUA==
X-Received: by 2002:a17:90a:a502:: with SMTP id a2mr5335561pjq.155.1607633393979;
        Thu, 10 Dec 2020 12:49:53 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id u11sm7290223pjy.17.2020.12.10.12.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 12:49:53 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     gabriele.mzt@gmail.com, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 2/2] iio: acpi_als: Add trigger support
Date:   Thu, 10 Dec 2020 12:49:43 -0800
Message-Id: <20201210204944.968290-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201210204944.968290-1-gwendal@chromium.org>
References: <20201210204944.968290-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

As some firmware does not notify on illuminance changes, add a
trigger to be able to query light via software (sysfs-trigger or
hrtrigger).

BUG=b:172408337
TEST=Check iio_info reports the sensor as buffer capable:
iio:device0: acpi-als (buffer capable)
Check we can get data on demand on volteer:
echo 1 > iio_sysfs_trigger/add_trigger
cat trigger2/name > iio\:device0/trigger/current_trigger
for i in iio\:device0/scan_elements/*_en iio\:device0/buffer/enable ; do
  echo 1 > $i
done
od -x /dev/iio\:device0&
echo 1 > trigger2/trigger_now

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/light/acpi-als.c | 92 ++++++++++++++++++++++++++----------
 1 file changed, 67 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index ff0ecec65fae4..86af5077ec8d2 100644
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
@@ -60,6 +64,7 @@ static const struct iio_chan_spec acpi_als_channels[] = {
 struct acpi_als {
 	struct acpi_device	*device;
 	struct mutex		lock;
+	struct iio_trigger	*trig;
 
 	s32 evt_buffer[ACPI_ALS_EVT_BUFFER_SIZE / sizeof(s32)]  __aligned(8);
 };
@@ -103,33 +108,20 @@ static void acpi_als_notify(struct acpi_device *device, u32 event)
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
@@ -160,13 +152,46 @@ static const struct iio_info acpi_als_info = {
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
+	ret = acpi_als_read_value(als, ACPI_ALS_ILLUMINANCE, &val);
+	if (ret < 0)
+		goto out;
+	*buffer++ = val;
+
+	/*
+	 * when coming from own trigger via polls, set timestamp here.
+	 * Given ACPI notifier is already in a thread and call function directly,
+	 * there is no need to set the timestamp in the notify function.
+	 */
+	if (!pf->timestamp)
+		pf->timestamp = iio_get_time_ns(indio_dev);
+
+	iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf->timestamp);
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
+	struct device *dev = &device->dev;
+	int ret;
 
-	indio_dev = devm_iio_device_alloc(&device->dev, sizeof(*als));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*als));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -177,19 +202,36 @@ static int acpi_als_add(struct acpi_device *device)
 	mutex_init(&als->lock);
 
 	indio_dev->name = ACPI_ALS_DEVICE_NAME;
-	indio_dev->dev.parent = &device->dev;
+	indio_dev->dev.parent = dev;
 	indio_dev->info = &acpi_als_info;
-	indio_dev->modes = INDIO_BUFFER_SOFTWARE;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = acpi_als_channels;
 	indio_dev->num_channels = ARRAY_SIZE(acpi_als_channels);
 
-	buffer = devm_iio_kfifo_allocate(&device->dev);
-	if (!buffer)
+	als->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
+					   indio_dev->name,
+					   indio_dev->id);
+	if (!als->trig)
 		return -ENOMEM;
 
-	iio_device_attach_buffer(indio_dev, buffer);
+	iio_trigger_set_drvdata(als->trig, indio_dev);
+	ret = devm_iio_trigger_register(dev, als->trig);
+	if (ret)
+		return ret;
+	/*
+	 * Set hardware trigger by default to let events flow when
+	 * BIOS support notification.
+	 */
+	indio_dev->trig = iio_trigger_get(als->trig);
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      acpi_als_trigger_handler,
+					      NULL);
+	if (ret)
+		return ret;
 
-	return devm_iio_device_register(&device->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct acpi_device_id acpi_als_device_ids[] = {
-- 
2.29.2.576.ga3fc446d84-goog

