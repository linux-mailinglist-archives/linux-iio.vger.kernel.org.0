Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84092E6D1F
	for <lists+linux-iio@lfdr.de>; Tue, 29 Dec 2020 02:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgL2Bxx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Dec 2020 20:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgL2Bxx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Dec 2020 20:53:53 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1888C061798
        for <linux-iio@vger.kernel.org>; Mon, 28 Dec 2020 17:53:12 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id 4so6501764plk.5
        for <linux-iio@vger.kernel.org>; Mon, 28 Dec 2020 17:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6a/4PXNW4RoHDdxMI3IizbFDKROwq7pJJM4nIFWHSMU=;
        b=N+75h+iBPh++VQYNSfVw6cIlpW14acdbXpOJUDSbdCUlH5U7ShR/hjB9zV/llYCCy7
         oeBy8EMbQUVA3AsuRItie5b61zodPtnBhVVfP23r5n1Ikbje8ux9StdjtfchzE9P1fJT
         Xik0kukG47RoiKsPClICt+oKzpPa2/MvLXGVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6a/4PXNW4RoHDdxMI3IizbFDKROwq7pJJM4nIFWHSMU=;
        b=cjUqDtNrWll+NYxAsoro0hQm/Yi1D+ryZpVVEki70+ptZkrSc9uyn3Y6KTu3VXYq/H
         XFMhParJbUPsvUQb6guzGtp0SNEj3/TAe9KyRRiiBtxuYPr6XLcifsFA6lms8d54fIYO
         m6DsgO8a2zv0SMrrYh8l0qiG0P5/vXHZLSlHk19PP1IO7xG5+qjiqXL9bEzckUCckGtC
         QJd6jIxVi6wWfcEu2G1TeeXKPhES9Szpc74cm+RU3MOInJDYAPHMWWk9qpbgKcGh1Jfh
         9AJ4+znz2Nr59vi6qN38FypV8Y/KGefVQTlWoaHoYmzx6kQz5VZX67truqnrGJPg6Jn4
         QwVQ==
X-Gm-Message-State: AOAM531R5LBh+oir1tIRe3WgLJk+3+wlMIXcAdygfVAZGS241yFdivPD
        m/EzA53edmdAVAk1L1MRkFC9OA==
X-Google-Smtp-Source: ABdhPJw4fahdFvbzubnwOw7tSnQ+0cbwKXhcfhY3UiUFaRD2GiE5mBgsW//ixlE1h5pmB5QZBpV/9g==
X-Received: by 2002:a17:90a:e38c:: with SMTP id b12mr1663536pjz.177.1609206792445;
        Mon, 28 Dec 2020 17:53:12 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id i6sm30149273pgc.58.2020.12.28.17.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Dec 2020 17:53:11 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     gabriele.mzt@gmail.com, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v6 3/3] iio: acpi_als: Add trigger support
Date:   Mon, 28 Dec 2020 17:53:00 -0800
Message-Id: <20201229015300.3037816-4-gwendal@chromium.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20201229015300.3037816-1-gwendal@chromium.org>
References: <20201229015300.3037816-1-gwendal@chromium.org>
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
 Changes in v6:
 Inverted logic in acpi_als_notify()
 Put timestamp comments in the same paragraph.
 Changes in v5:
 Improve commit message readability, add note about backward
 compatibility.
 Remove unneeded include file.
 Changes in v4:
 Added comments when pf->timestamp is 0 and valid. Fix spelling.

 drivers/iio/light/acpi-als.c | 104 ++++++++++++++++++++++++-----------
 1 file changed, 73 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index fd20808d4a119..183e8604b82bf 100644
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
@@ -102,33 +106,19 @@ static void acpi_als_notify(struct acpi_device *device, u32 event)
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
-
-	switch (event) {
-	case ACPI_ALS_NOTIFY_ILLUMINANCE:
-		ret = acpi_als_read_value(als, ACPI_ALS_ILLUMINANCE, &val);
-		if (ret < 0)
-			goto out;
-		*buffer++ = val;
-		break;
-	default:
-		/* Unhandled event */
-		dev_dbg(&device->dev, "Unhandled ACPI ALS event (%08x)!\n",
-			event);
-		goto out;
+	if (iio_buffer_enabled(indio_dev) && iio_trigger_using_own(indio_dev)) {
+		switch (event) {
+		case ACPI_ALS_NOTIFY_ILLUMINANCE:
+			iio_trigger_poll_chained(als->trig);
+			break;
+		default:
+			/* Unhandled event */
+			dev_dbg(&device->dev,
+				"Unhandled ACPI ALS event (%08x)!\n",
+				event);
+		}
 	}
-
-	iio_push_to_buffers_with_timestamp(indio_dev, als->evt_buffer, time_ns);
-
-out:
-	mutex_unlock(&als->lock);
 }
 
 static int acpi_als_read_raw(struct iio_dev *indio_dev,
@@ -159,12 +149,47 @@ static const struct iio_info acpi_als_info = {
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
+	 * When coming from own trigger via polls, set polling function
+	 * timestamp here. Given ACPI notifier is already in a thread and call
+	 * function directly, there is no need to set the timestamp in the
+	 * notify function.
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
@@ -178,15 +203,32 @@ static int acpi_als_add(struct acpi_device *device)
 
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

