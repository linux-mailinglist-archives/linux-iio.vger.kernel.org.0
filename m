Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE16C330417
	for <lists+linux-iio@lfdr.de>; Sun,  7 Mar 2021 20:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbhCGS4Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Mar 2021 13:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbhCGSzy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Mar 2021 13:55:54 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90101C06174A;
        Sun,  7 Mar 2021 10:55:54 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id mm21so15715261ejb.12;
        Sun, 07 Mar 2021 10:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pks+SrZ4znCBShGaFDbraYaxx/WgoLb7ivk6yT2CVXY=;
        b=RtBh84WWcNNnvJc7FEOLo2pkSzlGIEFCW1k2mog0UuBkYQZvCyPo2pml/XQ+JpzkxG
         Ea2IS7GJfU5pncqESMR1fGHHoFvOLSPTdSBMdlVXhHCnKF3qDMldXdWW7YpUol5O6lN7
         Afdtxy4KdE4j1V2R8i1buP/UxRh0h3sH6545wii0o+U1OysWmdSrFlrtomaQbnlHK1nP
         lxlLpiRPXWggcXM5xar5worxyAcLp6C9shnwfnWeJHF7LSawnPah9vFu9xxEcObJCjsR
         ilzyyVBjLoSjZwc98Ww/dy9BhgIJvE9y5t7cLqq804cyBuxLsYEf0wibKHki7AXsv2oI
         RTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pks+SrZ4znCBShGaFDbraYaxx/WgoLb7ivk6yT2CVXY=;
        b=q+EBXHy+zKnIq6b+Wtf2pyUBuc24Tcm0Vrota0fr+XIA1aHBFfMhpn9dwJ3u4epQNT
         h+BBcFT2sRCdbfEUDzFwQ7Mu5HM5P+WF/QWYXtCX9meZGnEj5I4N3ENAqTsit9bpYQsR
         bhN21QX/1p9fZQc02njmbfEkO34sKu0136MhrOHqFGuCZAe7qM+av2aNeMZOZA0+ikJ+
         mVkKYD/AQix/MIyd4xyBFZNvQII6Jl3AEPrxSDYlaynkcCg6udrQ7Ak7CE89E/QLutCO
         ga7juQFSDSW4nJPTbKXm4M60bC42vbr67u50XKIuIXLqd2V7wGo8jB1d6juFZSS5izWT
         wmwA==
X-Gm-Message-State: AOAM530DObcktO4ISLgOBNo3THXAJk+Lsg1ioOQa+mZJlakjU4LviY7d
        hy9z5KA0cHtyWQZKTTbK5YlT1xoA06vp1Q==
X-Google-Smtp-Source: ABdhPJxv/HnUHsX+0WflxtJwZncZ7VD+zLgQiHjGaj74bItsw1iyBcfOJSjfopc6ZqXKCYPEvPiD4g==
X-Received: by 2002:a17:906:4993:: with SMTP id p19mr11807991eju.421.1615143353046;
        Sun, 07 Mar 2021 10:55:53 -0800 (PST)
Received: from saturn.lan ([188.27.130.90])
        by smtp.googlemail.com with ESMTPSA id r19sm1046074ejr.55.2021.03.07.10.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 10:55:52 -0800 (PST)
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Alexandru Ardelean <ardeleanalex@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2] iio: buffer: fix use-after-free for attached_buffers array
Date:   Sun,  7 Mar 2021 20:54:44 +0200
Message-Id: <20210307185444.32924-1-ardeleanalex@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210306164710.9944-1-ardeleanalex@gmail.com>
References: <20210306164710.9944-1-ardeleanalex@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Thanks to Lars for finding this.
The free of the 'attached_buffers' array should be done as late as
possible. This change moves it to iio_buffers_put(), which looks like
the best place for it, since it takes place right before the IIO device
data is free'd.
The free of this array will be handled by calling iio_device_free().
The iio_buffers_put() function is renamed to iio_device_detach_buffers()
since the role of this function changes a bit.

It looks like this issue was ocurring on the error path of
iio_buffers_alloc_sysfs_and_mask() and in
iio_buffers_free_sysfs_and_mask()

Added a comment in the doc-header of iio_device_attach_buffer() to
mention how this will be free'd in case anyone is reading the code
and becoming confused about it.

Fixes: 36f3118c414d ("iio: buffer: introduce support for attaching more IIO buffers")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <ardeleanalex@gmail.com>
---
 drivers/iio/iio_core.h            | 4 ++--
 drivers/iio/industrialio-buffer.c | 9 +++++----
 drivers/iio/industrialio-core.c   | 2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index 062fe16c6c49..8f4a9b264962 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -77,7 +77,7 @@ void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev);
 
 void iio_disable_all_buffers(struct iio_dev *indio_dev);
 void iio_buffer_wakeup_poll(struct iio_dev *indio_dev);
-void iio_buffers_put(struct iio_dev *indio_dev);
+void iio_device_detach_buffers(struct iio_dev *indio_dev);
 
 #else
 
@@ -93,7 +93,7 @@ static inline void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev) {}
 
 static inline void iio_disable_all_buffers(struct iio_dev *indio_dev) {}
 static inline void iio_buffer_wakeup_poll(struct iio_dev *indio_dev) {}
-static inline void iio_buffers_put(struct iio_dev *indio_dev) {}
+static inline void iio_device_detach_buffers(struct iio_dev *indio_dev) {}
 
 #endif
 
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 1a415e97174e..1ff7f731b044 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -326,7 +326,7 @@ void iio_buffer_init(struct iio_buffer *buffer)
 }
 EXPORT_SYMBOL(iio_buffer_init);
 
-void iio_buffers_put(struct iio_dev *indio_dev)
+void iio_device_detach_buffers(struct iio_dev *indio_dev)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	struct iio_buffer *buffer;
@@ -336,6 +336,8 @@ void iio_buffers_put(struct iio_dev *indio_dev)
 		buffer = iio_dev_opaque->attached_buffers[i];
 		iio_buffer_put(buffer);
 	}
+
+	kfree(iio_dev_opaque->attached_buffers);
 }
 
 static ssize_t iio_show_scan_index(struct device *dev,
@@ -1764,7 +1766,6 @@ int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 		buffer = iio_dev_opaque->attached_buffers[unwind_idx];
 		__iio_buffer_free_sysfs_and_mask(buffer);
 	}
-	kfree(iio_dev_opaque->attached_buffers);
 	return ret;
 }
 
@@ -1786,8 +1787,6 @@ void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev)
 		buffer = iio_dev_opaque->attached_buffers[i];
 		__iio_buffer_free_sysfs_and_mask(buffer);
 	}
-
-	kfree(iio_dev_opaque->attached_buffers);
 }
 
 /**
@@ -2062,6 +2061,8 @@ static int iio_buffer_mmap(struct file *filep, struct vm_area_struct *vma)
  * This function attaches a buffer to a IIO device. The buffer stays attached to
  * the device until the device is freed. For legacy reasons, the first attached
  * buffer will also be assigned to 'indio_dev->buffer'.
+ * The array allocated here, will be free'd via the iio_device_detach_buffers()
+ * call which is handled by the iio_device_free().
  */
 int iio_device_attach_buffer(struct iio_dev *indio_dev,
 			     struct iio_buffer *buffer)
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index d74fbac908df..3be5f75c2846 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1587,7 +1587,7 @@ static void iio_dev_release(struct device *device)
 	iio_device_unregister_eventset(indio_dev);
 	iio_device_unregister_sysfs(indio_dev);
 
-	iio_buffers_put(indio_dev);
+	iio_device_detach_buffers(indio_dev);
 
 	ida_simple_remove(&iio_ida, indio_dev->id);
 	kfree(iio_dev_opaque);
-- 
2.25.1

