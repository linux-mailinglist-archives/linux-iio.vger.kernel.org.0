Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE207336E85
	for <lists+linux-iio@lfdr.de>; Thu, 11 Mar 2021 10:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhCKJLl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Mar 2021 04:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbhCKJLT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Mar 2021 04:11:19 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1ADC061760
        for <linux-iio@vger.kernel.org>; Thu, 11 Mar 2021 01:11:18 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id u16so967236wrt.1
        for <linux-iio@vger.kernel.org>; Thu, 11 Mar 2021 01:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9DitI0GIw7M/uW0yaGKejSPhIr9D7AFcMrPB/RQmZC8=;
        b=WS/blPZ55rMViyWmEX5z1LFh5ip7U3WmY/o+SXO/Itpd71mOWXPx2i4+3ctDrVgrQv
         3HPa1yxaTrtr4tII7cI7C4CmeFFTyTboLFGR5JnPYFqVKMATf0KnMznQY2s3wf50WU+b
         p8qGDmOM9bcgTmL+9RsmaWowccqnFswh3ukLza3pAEBY+TR0U2ls9F9YHH6NRq3bK4s0
         kjtMy/w5m0/nmGwv7ACIGjm+fgx5LhqusU14TBJJnqnLKv5lZAUoxrcaH+dIDAIGQwNX
         ZR0ZlDMo8jKdPvRZ3DlvbXDqFylLPd0iq5v57uwJOZjhLLVPUVoAq4woWUSb/ilgVHtJ
         4s2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9DitI0GIw7M/uW0yaGKejSPhIr9D7AFcMrPB/RQmZC8=;
        b=A5pErmbTDN1jABRWz1kZhgbkvecVaAog0wyo70W1tqlfoNybHNkFRa63BK7euL+Fq9
         OcHwpVMi/lLaiJl/jskeNOjrTeBETiK32HQORgi96lQvYnPyhEQlWks/FUO9YeH3+IG0
         drJ+xcPBwuGloRudrCO+onpEPjuY5sIxszxvqt88tsVCfqgkqXgula76OAbjC6+/qG5I
         ugnPdsWzJ3HstekU/lka8Ymym9quJRqvaKkNLGKVQbKs8xAW1gp1aKSYw7cV/6lhjL1+
         HoBbvImANgPXsBIM6JQ/g82HVsXoQqNvr7tJRsOEDe44mWBxzL+MwBPqafobXmnXzKHD
         Y6uw==
X-Gm-Message-State: AOAM532SYFsPUjr4WpM9lIs4dDT0rv/C2eUHSKJW6HMMvI50Xh719sWx
        7A/EO0wyIir4TbFhHtwT19RP2jy47RE6Dh8u
X-Google-Smtp-Source: ABdhPJwgp7q6GBL3vF9TkxX9xTGyh5zqM/I2vryzdXFHItt+NyEzx087+DviBaOlOmYu2aKRZJV4sw==
X-Received: by 2002:a5d:6a81:: with SMTP id s1mr7658152wru.401.1615453877241;
        Thu, 11 Mar 2021 01:11:17 -0800 (PST)
Received: from localhost.localdomain ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id y16sm2814092wrh.3.2021.03.11.01.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 01:11:16 -0800 (PST)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux@deviqon.com, jic23@kernel.org, gwendal@chromium.org,
        groeck@chromium.org, Jonathan.Cameron@huawei.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] iio: kfifo: add devm_iio_triggered_buffer_setup_ext variant
Date:   Thu, 11 Mar 2021 11:10:42 +0200
Message-Id: <20210311091042.22417-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is similar to the {devm_}iio_triggered_buffer_setup_ext variants added
via commit 5164c7889857 ("iio: triggered-buffer: add
{devm_}iio_triggered_buffer_setup_ext variants").

These can be used to pass extra buffer attributes to the buffer object.
This is a bit of temporary mechanism (hopefully) so that drivers that want
to allocate a kfifo buffer with extra buffer attributes, don't need to
include 'buffer_impl.h' directly. This can also become an API function (in
it's own right, unfortunately), but it may be a little less bad vs drivers
having to include 'buffer_impl.h'.

So, far the drivers that want to pass buffer attributes, all have to do
with some HW FIFO attributes, so there may be a chance of unifying them
into IIO core somehow (as some standard API). But, until that happens, we
just need to let them register their HW FIFO attributes directly (without
having to let them include 'buffer_impl.h' directly).

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---

Related to the discussion here:
  https://lore.kernel.org/linux-iio/CA+U=Dspk3cWjiiRmDrgfHAY6houjr-KtSD3u4BssUcb=c2ujpQ@mail.gmail.com/T/#mcfda9d6cb6426caefa4a5db6d634640bfdbe328e

 drivers/iio/buffer/kfifo_buf.c | 16 ++++++++++------
 include/linux/iio/kfifo_buf.h  | 12 ++++++++----
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
index 4ecfa0ec3016..13eea2e11cbc 100644
--- a/drivers/iio/buffer/kfifo_buf.c
+++ b/drivers/iio/buffer/kfifo_buf.c
@@ -206,22 +206,24 @@ static struct iio_buffer *devm_iio_kfifo_allocate(struct device *dev)
 }
 
 /**
- * devm_iio_kfifo_buffer_setup - Allocate a kfifo buffer & attach it to an IIO device
+ * devm_iio_kfifo_buffer_setup_ext - Allocate a kfifo buffer & attach it to an IIO device
  * @dev: Device object to which to attach the life-time of this kfifo buffer
  * @indio_dev: The device the buffer should be attached to
  * @mode_flags: The mode flags for this buffer (INDIO_BUFFER_SOFTWARE and/or
  *		INDIO_BUFFER_TRIGGERED).
  * @setup_ops: The setup_ops required to configure the HW part of the buffer (optional)
+ * @buffer_attrs: Extra sysfs buffer attributes for this IIO buffer
  *
  * This function allocates a kfifo buffer via devm_iio_kfifo_allocate() and
  * attaches it to the IIO device via iio_device_attach_buffer().
  * This is meant to be a bit of a short-hand/helper function as there are a few
  * drivers that seem to do this.
  */
-int devm_iio_kfifo_buffer_setup(struct device *dev,
-				struct iio_dev *indio_dev,
-				int mode_flags,
-				const struct iio_buffer_setup_ops *setup_ops)
+int devm_iio_kfifo_buffer_setup_ext(struct device *dev,
+				    struct iio_dev *indio_dev,
+				    int mode_flags,
+				    const struct iio_buffer_setup_ops *setup_ops,
+				    const struct attribute **buffer_attrs)
 {
 	struct iio_buffer *buffer;
 
@@ -237,8 +239,10 @@ int devm_iio_kfifo_buffer_setup(struct device *dev,
 	indio_dev->modes |= mode_flags;
 	indio_dev->setup_ops = setup_ops;
 
+	buffer->attrs = buffer_attrs;
+
 	return iio_device_attach_buffer(indio_dev, buffer);
 }
-EXPORT_SYMBOL_GPL(devm_iio_kfifo_buffer_setup);
+EXPORT_SYMBOL_GPL(devm_iio_kfifo_buffer_setup_ext);
 
 MODULE_LICENSE("GPL");
diff --git a/include/linux/iio/kfifo_buf.h b/include/linux/iio/kfifo_buf.h
index 1522896e1daf..ccd2ceae7b25 100644
--- a/include/linux/iio/kfifo_buf.h
+++ b/include/linux/iio/kfifo_buf.h
@@ -10,9 +10,13 @@ struct device;
 struct iio_buffer *iio_kfifo_allocate(void);
 void iio_kfifo_free(struct iio_buffer *r);
 
-int devm_iio_kfifo_buffer_setup(struct device *dev,
-				struct iio_dev *indio_dev,
-				int mode_flags,
-				const struct iio_buffer_setup_ops *setup_ops);
+int devm_iio_kfifo_buffer_setup_ext(struct device *dev,
+				    struct iio_dev *indio_dev,
+				    int mode_flags,
+				    const struct iio_buffer_setup_ops *setup_ops,
+				    const struct attribute **buffer_attrs);
+
+#define devm_iio_kfifo_buffer_setup(dev, indio_dev, mode_flags, setup_ops)	\
+	devm_iio_kfifo_buffer_setup_ext((dev), (indio_dev), (mode_flags), (setup_ops), NULL)
 
 #endif
-- 
2.29.2

