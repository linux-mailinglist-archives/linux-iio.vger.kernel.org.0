Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C8C33EAA9
	for <lists+linux-iio@lfdr.de>; Wed, 17 Mar 2021 08:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhCQHka (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Mar 2021 03:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbhCQHkX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Mar 2021 03:40:23 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5809C06174A
        for <linux-iio@vger.kernel.org>; Wed, 17 Mar 2021 00:40:23 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 11so526114pfn.9
        for <linux-iio@vger.kernel.org>; Wed, 17 Mar 2021 00:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6DTuOrWEqvYr+bsiUwGD57v7ZjK35N0cW4IiI0jP3JI=;
        b=DZ7RN+cOQM5nK5U7VC2n+ADuIH7uL4B/m1a5e39DqE6tI6V/WtJVFUKtmuHBGtqRuA
         DdchV7qLSWsplHCkzp3MChSyA87Qh6fYGi9JNFE06N/qTQWg8PsM8SiusEsyZPqgz/Hp
         ECZ5vwLnS1z6dGOeykZbOV5+3zxjbPqnwsf3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6DTuOrWEqvYr+bsiUwGD57v7ZjK35N0cW4IiI0jP3JI=;
        b=pCYXUaUbTEjDk+ryifwI/kDKP/6nOa5HBgPBC8xKVmTj+jDJCzRyZik8ZYgbOq+Jkz
         hrbPV96XjJ+ZOCGEJcDjPeZwowCXrC38kICpV6HoIgb5Yb1I8YnZjqRDtie6A/wjff2j
         ydR2SwzSUbKzBpn5JRCEFT+mkKedPn7a9pCP1hr2YnWwTyXtpHtUfKQEMKwv5bavdXAw
         Mb9U2TMLsAU+QY2giTN9sxv5PQhUBY+YDnf5gP+WvDWLKejKIqRdItlul+LlD7agrujS
         ycX0DcDUP9lQPCHJPHQyI8tyYOMqd8F0eJe7uIy9JjUKUkLGO2eK7NbY8USLBNRoLlfK
         FE0w==
X-Gm-Message-State: AOAM532wUNnoKA9vEXo4kd77IKXiG+URXhxbPOgujXFpQVDdnTTXCF/B
        XZQhKq8Z9908zcLEVrf9einLSQ==
X-Google-Smtp-Source: ABdhPJyX3v53E3sGR+NqYk8VdcZ+9tMqaCcf1U1UYcqEVLFkZ0AH6wfZMSgjugIGqnkDuXaYBkZNhA==
X-Received: by 2002:aa7:8ad2:0:b029:1ee:16f0:7c70 with SMTP id b18-20020aa78ad20000b02901ee16f07c70mr3005656pfd.58.1615966823285;
        Wed, 17 Mar 2021 00:40:23 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:bdd3:3391:be74:f7be])
        by smtp.gmail.com with UTF8SMTPSA id q34sm17949527pgl.92.2021.03.17.00.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 00:40:22 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     gabriele.mzt@gmail.com, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v7 3/3] iio: acpi_als: Add trigger support
Date:   Wed, 17 Mar 2021 00:40:12 -0700
Message-Id: <20210317074012.2336454-4-gwendal@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210317074012.2336454-1-gwendal@chromium.org>
References: <20210317074012.2336454-1-gwendal@chromium.org>
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 Changes in v7:
 Rebased : no need to set indio_dev->modes directly anymore.
 Changes in v6:
 Inverted logic in acpi_als_notify()
 Put timestamp comments in the same paragraph.
 Changes in v5:
 Improve commit message readability, add note about backward
 compatibility.
 Remove unneeded include file.
 Changes in v4:
 Added comments when pf->timestamp is 0 and valid. Fix spelling.

 drivers/iio/light/acpi-als.c | 96 +++++++++++++++++++++++++-----------
 1 file changed, 68 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index a2107945cff93..30393f08e0825 100644
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
-
-	mutex_lock(&als->lock);
 
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
@@ -159,6 +149,41 @@ static const struct iio_info acpi_als_info = {
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
@@ -181,8 +206,23 @@ static int acpi_als_add(struct acpi_device *device)
 	indio_dev->channels = acpi_als_channels;
 	indio_dev->num_channels = ARRAY_SIZE(acpi_als_channels);
 
-	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
-					  INDIO_BUFFER_SOFTWARE, NULL);
+	als->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name, indio_dev->id);
+	if (!als->trig)
+		return -ENOMEM;
+
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
 	if (ret)
 		return ret;
 
-- 
2.31.0.rc2.261.g7f71774620-goog

