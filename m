Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC1D32FC0B
	for <lists+linux-iio@lfdr.de>; Sat,  6 Mar 2021 17:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhCFQrn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Mar 2021 11:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbhCFQrT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Mar 2021 11:47:19 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95ED5C06174A;
        Sat,  6 Mar 2021 08:47:18 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id w9so7641117edc.11;
        Sat, 06 Mar 2021 08:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HTmzVH6F27bVo/jL4T9WmcbbcHUCcKhAg31wR0zB0oM=;
        b=QwJdHo6TScIhOJ5jNDajpA9vWKzCB+rVGnYkoclo4AYTxoyi1a9hmj0PGbEGo5ayJB
         rLJ6N23pRa0/hBlskydFAxONs0JvBnV+E0CRhcgcMj+jDweCLJ/u7bSSrTzqt/mTgGM8
         SmKrhVZAuMoWredOnHOi3XpP+FHDfBQ6n4Vm896g1mH9sdhI3ZKekhfTTWFzY/Jm26LG
         I14oGLE6MUElm0vEpbGjO84t34Q+h23DgjycdT4ECJE+KK5pnP1iJCECcb7pa+E7mMi7
         YTy0mWWtTyKI66PJ9eoXOACV1JZiZPuqYZE2IrF4ok7eCNlGwVQYgQozKUntLjcM8hf+
         2vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HTmzVH6F27bVo/jL4T9WmcbbcHUCcKhAg31wR0zB0oM=;
        b=Xlqo9z5T1DHzHLvTFGJ7CyTKIndvT4E/Syzv/1E2x+pAnVu7bnhB4J7RWZWUsJ1L5M
         5bjuMUYCEpueL5PRmGhjycqRgSSlHsPV/mwpIuj+cbmKHLjXuGGs5VTv1d9gHyoQXvR/
         G6SQr3zG3yCjZXqxmFXDit2YitcksPN4Ih+Rpr10/NtO8zqJlMqUT41nNtHGP7V3rx36
         jwLSvcbAhkYQ8bnLGzQsmgHP5OnTCEAHzZcIFhmXYfYzqlrOc3i6tAIPjxgZ9GWMzcto
         nZLXLapOCUdKn5KpKnQHm0K087vFuu71jxFS5dDPIr8QqxhAn6KowGQQOfOLvI0+gvkL
         L/8g==
X-Gm-Message-State: AOAM530Myae17Hb4641iSAHYKdJeqASgOpZUlndX36LNZuYfEqtzGryU
        zCIFeKTPaYOoRtHoOEB59+rV3o+jiFBiuA==
X-Google-Smtp-Source: ABdhPJw4FCHFUwCjsqNfRqYAbvBHuvizzKfzzsCk6rusonvL8wvw8ESRp+pnbENDAaQMnbnUswZjkA==
X-Received: by 2002:aa7:df14:: with SMTP id c20mr14590404edy.197.1615049237071;
        Sat, 06 Mar 2021 08:47:17 -0800 (PST)
Received: from saturn.lan ([188.27.130.90])
        by smtp.googlemail.com with ESMTPSA id la15sm3519137ejb.46.2021.03.06.08.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 08:47:16 -0800 (PST)
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Alexandru Ardelean <ardeleanalex@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: buffer: fix use-after-free for attached_buffers array
Date:   Sat,  6 Mar 2021 18:47:10 +0200
Message-Id: <20210306164710.9944-1-ardeleanalex@gmail.com>
X-Mailer: git-send-email 2.25.1
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
 drivers/iio/industrialio-buffer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 1a415e97174e..3d0712651d43 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
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
+ * The array allocated here, will be free'd via the iio_buffers_put() call,
+ * which is handled by the iio_device_free().
  */
 int iio_device_attach_buffer(struct iio_dev *indio_dev,
 			     struct iio_buffer *buffer)
-- 
2.25.1

