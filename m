Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A263FFB16
	for <lists+linux-iio@lfdr.de>; Fri,  3 Sep 2021 09:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347886AbhICHad (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Sep 2021 03:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347912AbhICHad (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Sep 2021 03:30:33 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69485C061764
        for <linux-iio@vger.kernel.org>; Fri,  3 Sep 2021 00:29:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id x11so10250208ejv.0
        for <linux-iio@vger.kernel.org>; Fri, 03 Sep 2021 00:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1KqigQ4tM0RySsTWyqhUi7bGFJ0gw2Fo1Hm3w8y7jnw=;
        b=om/xEpEuKYXGQyOY6bh+O6zF7CuLM+3MKZihofXqytwOnwmphD1JvjR5/J/m1zOHrE
         yjZcEctUsB9we9f7DCNv77dRZ4LwtssMyWPHeZYMQ0FVelyz0Fk3oFaceyPKFggW7VqM
         VfcPHup5vSCnfX+ZCAWD/s8O1dIrN0TPAVlUrPxF78/yNdY60AhYpyPweOcunu9BAk8e
         QSqnZ6FHvq7ecXvdBhZb0aHxUfr8DuXRPAU47h9bSzAudUvkOq+DrZ3qz6vCr/yMmHZj
         hPpYPlfsV5c2w9hrlWbDtr6/hNqh5GIH9FU+ALtydJ5nTtHnk1EOSY6LR7PddBX8x5Fs
         okpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1KqigQ4tM0RySsTWyqhUi7bGFJ0gw2Fo1Hm3w8y7jnw=;
        b=Y4RD/XS3I/b1CTpwt0cm0ppzavzJ369Ll9oefj4lLFX4Iw+VOZaR5D6GSspgxX9AiH
         AUPc6vqhg0FHzP3djpuCUmoaxnf3hPu9YOj4WoWXF7RYPc2rP/UaXXZob8S5rl7hsKAA
         61qs3amESCBE/gSO73XI7V4NPZC0/r/XeZPBF+gt0Ef+vk/LvMi7taDMlzpduEKOrFpo
         0cae54QmJLHqIxStdDt8p9Sm0d789GTdtQHmUHs27qTS74f1VE01J+xyEcFSPgzLVGZm
         /F+iqqY34YNm20/V+QskBCFU9csnWKQ+xVIQ7a8zF1yDBfOEcAbU1mMHDZV6qc3akwY2
         8lfg==
X-Gm-Message-State: AOAM531F+8oOWxpztFic7t3Sh8CW5wXmkQuCtSV0V+oot41wNEqt7Dsk
        yXXEAMSJUpfUq1HvpIORz0DnMQoYYhrvhA==
X-Google-Smtp-Source: ABdhPJwSO0CCkCGhRw1a/tkwxzP1RsvMkca/s6M4h3BZwT+ztnjoZFxeMrwNb5pmAezMWK2dGz0wUw==
X-Received: by 2002:a17:906:30d6:: with SMTP id b22mr2728381ejb.442.1630654171717;
        Fri, 03 Sep 2021 00:29:31 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id a15sm2376969edr.2.2021.09.03.00.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 00:29:31 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     jic23@kernel.org, hdegoede@redhat.com, wens@csie.org,
        andriy.shevchenko@linux.intel.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 1/5] iio: inkern: introduce devm_iio_map_array_register() short-hand function
Date:   Fri,  3 Sep 2021 10:29:13 +0300
Message-Id: <20210903072917.45769-2-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210903072917.45769-1-aardelean@deviqon.com>
References: <20210903072917.45769-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change introduces a device-managed variant to the
iio_map_array_register() function. It's a simple implementation of calling
iio_map_array_register() and registering a callback to
iio_map_array_unregister() with the devm_add_action_or_reset().

The function uses an explicit 'dev' parameter to bind the unwinding to. It
could have been implemented to implicitly use the parent of the IIO device,
however it shouldn't be too expensive to callers to just specify to which
device object to bind this unwind call.
It would make the API a bit more flexible.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 .../driver-api/driver-model/devres.rst          |  1 +
 drivers/iio/inkern.c                            | 17 +++++++++++++++++
 include/linux/iio/driver.h                      | 14 ++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 650096523f4f..148e19381b79 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -287,6 +287,7 @@ IIO
   devm_iio_device_register()
   devm_iio_dmaengine_buffer_setup()
   devm_iio_kfifo_buffer_setup()
+  devm_iio_map_array_register()
   devm_iio_triggered_buffer_setup()
   devm_iio_trigger_alloc()
   devm_iio_trigger_register()
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 391a3380a1d1..0222885b334c 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -85,6 +85,23 @@ int iio_map_array_unregister(struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL_GPL(iio_map_array_unregister);
 
+static void iio_map_array_unregister_cb(void *indio_dev)
+{
+	iio_map_array_unregister(indio_dev);
+}
+
+int devm_iio_map_array_register(struct device *dev, struct iio_dev *indio_dev, struct iio_map *maps)
+{
+	int ret;
+
+	ret = iio_map_array_register(indio_dev, maps);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, iio_map_array_unregister_cb, indio_dev);
+}
+EXPORT_SYMBOL_GPL(devm_iio_map_array_register);
+
 static const struct iio_chan_spec
 *iio_chan_spec_from_name(const struct iio_dev *indio_dev, const char *name)
 {
diff --git a/include/linux/iio/driver.h b/include/linux/iio/driver.h
index 36de60a5da7a..7a157ed218f6 100644
--- a/include/linux/iio/driver.h
+++ b/include/linux/iio/driver.h
@@ -8,6 +8,7 @@
 #ifndef _IIO_INKERN_H_
 #define _IIO_INKERN_H_
 
+struct device;
 struct iio_dev;
 struct iio_map;
 
@@ -26,4 +27,17 @@ int iio_map_array_register(struct iio_dev *indio_dev,
  */
 int iio_map_array_unregister(struct iio_dev *indio_dev);
 
+/**
+ * devm_iio_map_array_register - device-managed version of iio_map_array_register
+ * @dev:	Device object to which to bind the unwinding of this registration
+ * @indio_dev:	Pointer to the iio_dev structure
+ * @maps:	Pointer to an IIO map object which is to be registered to this IIO device
+ *
+ * This function will call iio_map_array_register() to register an IIO map object
+ * and will also hook a callback to the iio_map_array_unregister() function to
+ * handle de-registration of the IIO map object when the device's refcount goes to
+ * zero.
+ */
+int devm_iio_map_array_register(struct device *dev, struct iio_dev *indio_dev, struct iio_map *maps);
+
 #endif
-- 
2.31.1

