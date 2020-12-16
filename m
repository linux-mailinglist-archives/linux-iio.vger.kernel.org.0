Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB5F2DC870
	for <lists+linux-iio@lfdr.de>; Wed, 16 Dec 2020 22:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgLPVmF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Dec 2020 16:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgLPVmE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Dec 2020 16:42:04 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FD6C0617B0
        for <linux-iio@vger.kernel.org>; Wed, 16 Dec 2020 13:41:24 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id q4so7983506plr.7
        for <linux-iio@vger.kernel.org>; Wed, 16 Dec 2020 13:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9EjDNwU05bgJKT6WsaqEUOCspqDMMYWE67z/jFF2GQE=;
        b=Qsjqw46y05FO0LmUuJ+u4Od90NjL0Z4azAQtM1qhOmGIz25wbh4acgTBTugi6Y/QM/
         FAYAAtg0/J6qfIuwlaiZJApkhiT14roxtDza/QW0SmG8c8UQnCVVA66EZijeq3jWNASq
         fNozCjdMhQFpCISLzvuR87AXg767nchB57ATU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9EjDNwU05bgJKT6WsaqEUOCspqDMMYWE67z/jFF2GQE=;
        b=TyreHf+fASg0UXLPbyvApoxVxSGhrKvGnTL3Y5G+RDfymYTjTPC1/qqw1njyc2JRnD
         ctacBOdywHIj3yedhs7aTL1r7NBlEIbMMssUQRULA4TC48cQrkCgkhtff9K0Bvi9eC9h
         X+WEochf7zChuApqLipM1hENT8sBgXf+4LfHtkIPb8W3EK2UkIFU8oCOB5i+3eFZVzTK
         EmtNcqZO73yljuR58EhqWtnT0I7AbrfmOWK8rIjGXQQ8exq57VyN87ByuPwmE8KLrY8K
         DGYjX99IqGLPU1dxsAGWuC2g6RFVT5em5ipWN9D57QmyDnB4lb9aj0NCMpqCy8DYqPJV
         5ZFQ==
X-Gm-Message-State: AOAM531sjOlyb/HYNqZ13YlAwonmsrC8K0R36rDWC3Pm0XYwUwRLb8eK
        V2m4HBddWuGNK7pmOdCl2BP5HA==
X-Google-Smtp-Source: ABdhPJwLZM1N5mG/U2OpZRZTv9zPpr2F/wRZ3151naSM6gNyatphqM96wguN+sedz1mYI716h2Q92A==
X-Received: by 2002:a17:90a:d145:: with SMTP id t5mr4840480pjw.104.1608154884120;
        Wed, 16 Dec 2020 13:41:24 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id u24sm2880742pjx.56.2020.12.16.13.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 13:41:23 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     gabriele.mzt@gmail.com, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v5 3/3] iio: acpi_als: Add trigger support
Date:   Wed, 16 Dec 2020 13:41:07 -0800
Message-Id: <20201216214107.774969-4-gwendal@chromium.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20201216214107.774969-1-gwendal@chromium.org>
References: <20201216214107.774969-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

As some firmware does not notify on illuminance changes, add a
trigger to be able to query light via software (sysfs-trigger or
hrtrigger).
Add a hardware trigger set as the default trigger to maintain backward
compatibility.

Check iio_info reports the sensor as buffer capable:
  iio:device0: acpi-als (buffer capable)

To test, check we can get data on demand on an Intel based chromebook:

  IIO_DEV="iio:device0"
  echo 1 > iio_sysfs_trigger/add_trigger
  cat trigger2/name > ${IIO_DEV}/trigger/current_trigger
  for i in ${IIO_DEV}/scan_elements/*_en ${IIO_DEV}/buffer/enable ; do
    echo 1 > $i
  done
  od -x /dev/${IIO_DEV} &
  echo 1 > trigger2/trigger_now

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 Changes in v4:
 Added comments when pf->timestamp is 0 and valid. Fix spelling.
 Changes in v5:
 Improve commit message readability, add note about backward
 compatibility.
 Remove unneeded include file.

 drivers/iio/light/acpi-als.c | 89 ++++++++++++++++++++++++++----------
 1 file changed, 66 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index fd20808d4a119..80fe0da51fad3 100644
--- a/drivers/iio/light/acpi-als.c
+++ b/drivers/iio/light/acpi-als.c
@@ -16,11 +16,14 @@
 #include <linux/module.h>
 #include <linux/acpi.h>
 #include <linux/err.h>
+#include <linux/irq.h>
 #include <linux/mutex.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
-#include <linux/iio/kfifo_buf.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 
 #define ACPI_ALS_CLASS			"als"
 #define ACPI_ALS_DEVICE_NAME		"acpi-als"
@@ -59,6 +62,7 @@ static const struct iio_chan_spec acpi_als_channels[] = {
 struct acpi_als {
 	struct acpi_device	*device;
 	struct mutex		lock;
+	struct iio_trigger	*trig;
 
 	s32 evt_buffer[ACPI_ALS_EVT_BUFFER_SIZE / sizeof(s32)]  __aligned(8);
 };
@@ -102,33 +106,20 @@ static void acpi_als_notify(struct acpi_device *device, u32 event)
 {
 	struct iio_dev *indio_dev = acpi_driver_data(device);
 	struct acpi_als *als = iio_priv(indio_dev);
-	s32 *buffer = als->evt_buffer;
-	s64 time_ns = iio_get_time_ns(indio_dev);
-	s32 val;
-	int ret;
 
-	mutex_lock(&als->lock);
-
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
@@ -159,12 +150,47 @@ static const struct iio_info acpi_als_info = {
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
+	*buffer = val;
+
+	/*
+	 * When coming from own trigger via polls, set polling function timestamp
+	 * here.
+	 * Given ACPI notifier is already in a thread and call function directly,
+	 * there is no need to set the timestamp in the notify function.
+	 *
+	 * If the timestamp was actually 0, the timestamp is set one more time.
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
 	struct device *dev = &device->dev;
 	struct iio_dev *indio_dev;
-	struct iio_buffer *buffer;
 	struct acpi_als *als;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*als));
 	if (!indio_dev)
@@ -178,15 +204,32 @@ static int acpi_als_add(struct acpi_device *device)
 
 	indio_dev->name = ACPI_ALS_DEVICE_NAME;
 	indio_dev->info = &acpi_als_info;
-	indio_dev->modes = INDIO_BUFFER_SOFTWARE;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = acpi_als_channels;
 	indio_dev->num_channels = ARRAY_SIZE(acpi_als_channels);
 
-	buffer = devm_iio_kfifo_allocate(dev);
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
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-- 
2.29.2.729.g45daf8777d-goog

