Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F3B330AC5
	for <lists+linux-iio@lfdr.de>; Mon,  8 Mar 2021 11:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhCHKCa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Mar 2021 05:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbhCHKCa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Mar 2021 05:02:30 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6022C06174A
        for <linux-iio@vger.kernel.org>; Mon,  8 Mar 2021 02:02:29 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id r3so11903710lfc.13
        for <linux-iio@vger.kernel.org>; Mon, 08 Mar 2021 02:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ywGXmbO4ZKXPKOBwo/VXhEMMza2MItTJHpVMCLgWzHA=;
        b=uvse9CuNLuA4stytN0lktycADnkVRupsZWHElb/Fv1IUS7wn2l02KhqV4ziMKnyP/P
         icxN/oYf/DjHn1xYpzNJWtUrCiuvsl647yM7SwDIcDGBXHTaoZnfppvovckTaYQ71OBr
         eXjRW/juaeUAR74xKdINk6djQsykuyTwnI8qlWHDxnLHweuLLok/YrM103uqat1E0OPD
         hIQLEMGzQ1d4mr8TJjVi8uj0sS/TJmuI9aOb9mMpdSkhmNJxKoCUQ1H5a4bmAMOZdQOF
         Kntqmm2jyEUhqseFDuEEyPcaZLa4guU7yGY3BoxqhzbLDVpcm1ZnSS6PEQ9e+Maub6vc
         fzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ywGXmbO4ZKXPKOBwo/VXhEMMza2MItTJHpVMCLgWzHA=;
        b=QTuJs7GppxOynIEm/Woo8qcIfhIax49IZgQ+MeJN/f3hlMaY5FbkAiD5Of4KUfMJlK
         B0iK0+V3htqnXhN1oZu2nr0XBopF79Xig2PNbQWkxhTQXuUEE8/rR0bqo8qD9XP2t7j4
         NzzdEh6O2T51RZfN/6IR2ZfyLmyYfGK8PPhL9cxqp9dmihZQUIGRb8BFTHx/tqEZekc9
         hEVix/4F8QDn/8Wma2Z95mCC3QOTYm8BjpSpjQDaThy54QKNDaB+OF77jF+yqia6FJEP
         oR4eo2xn8USFy0QGwmisaeDmYlOkd2L03kho/Abn3K1FEDZmFIEoAp7z18koBNZ66ULO
         PrRg==
X-Gm-Message-State: AOAM532bKBQC1QVRxdHN8vGaqkTmToq3mXkIX9p++l2vGZeJp6pmPm6U
        29XnLwJL+Dbs9Sofd4L2N3s+JQ==
X-Google-Smtp-Source: ABdhPJxpcQ1cJ+xMZWapyn3H6YQ4+LSsev0FuM4ni8mrS+/uh51GnhMg/z/YgRGsUdxxP9ub+hdDLg==
X-Received: by 2002:a19:48ca:: with SMTP id v193mr14601914lfa.323.1615197748405;
        Mon, 08 Mar 2021 02:02:28 -0800 (PST)
Received: from localhost.localdomain (c-d7cb225c.014-348-6c756e10.bbcust.telenor.se. [92.34.203.215])
        by smtp.gmail.com with ESMTPSA id v2sm1425734ljg.89.2021.03.08.02.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 02:02:28 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-hwmon@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Rosin <peda@axentia.se>,
        Chris Lesiak <chris.lesiak@licor.com>,
        linux-iio@vger.kernel.org
Subject: [PATCH 1/2 v4] iio: Provide iio_read_channel_processed_scale() API
Date:   Mon,  8 Mar 2021 11:02:18 +0100
Message-Id: <20210308100219.2732156-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since the old iio_read_channel_processed() would
lose precision if we fall back to reading raw and
scaling, we introduce a new API that will pass in
a scale factor when reading a processed channel:
iio_read_channel_processed_scale().

Refactor iio_read_channel_processed() as a special
case with scale factor 1.

Cc: Peter Rosin <peda@axentia.se>
Cc: Chris Lesiak <chris.lesiak@licor.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Link: https://lore.kernel.org/linux-iio/20201224011607.1059534-1-linus.walleij@linaro.org/
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Split off as separate API-introducing patch.
- Fix a goto err when scaling.
- My suggestion is to apply this patch with Jonathan's ACK
  to the hwmon tree.
---
 drivers/iio/inkern.c         | 16 ++++++++++++++--
 include/linux/iio/consumer.h | 15 +++++++++++++++
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index db77a2d4a56b..c61fc06f98b8 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -688,7 +688,8 @@ int iio_read_channel_offset(struct iio_channel *chan, int *val, int *val2)
 }
 EXPORT_SYMBOL_GPL(iio_read_channel_offset);
 
-int iio_read_channel_processed(struct iio_channel *chan, int *val)
+int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
+				     unsigned int scale)
 {
 	int ret;
 
@@ -701,11 +702,15 @@ int iio_read_channel_processed(struct iio_channel *chan, int *val)
 	if (iio_channel_has_info(chan->channel, IIO_CHAN_INFO_PROCESSED)) {
 		ret = iio_channel_read(chan, val, NULL,
 				       IIO_CHAN_INFO_PROCESSED);
+		if (ret)
+			goto err_unlock;
+		*val *= scale;
 	} else {
 		ret = iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_RAW);
 		if (ret < 0)
 			goto err_unlock;
-		ret = iio_convert_raw_to_processed_unlocked(chan, *val, val, 1);
+		ret = iio_convert_raw_to_processed_unlocked(chan, *val, val,
+							    scale);
 	}
 
 err_unlock:
@@ -713,6 +718,13 @@ int iio_read_channel_processed(struct iio_channel *chan, int *val)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(iio_read_channel_processed_scale);
+
+int iio_read_channel_processed(struct iio_channel *chan, int *val)
+{
+	/* This is just a special case with scale factor 1 */
+	return iio_read_channel_processed_scale(chan, val, 1);
+}
 EXPORT_SYMBOL_GPL(iio_read_channel_processed);
 
 int iio_read_channel_scale(struct iio_channel *chan, int *val, int *val2)
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 0a90ba8fa1bb..5fa5957586cf 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -241,6 +241,21 @@ int iio_read_channel_average_raw(struct iio_channel *chan, int *val);
  */
 int iio_read_channel_processed(struct iio_channel *chan, int *val);
 
+/**
+ * iio_read_channel_processed_scale() - read and scale a processed value
+ * @chan:		The channel being queried.
+ * @val:		Value read back.
+ * @scale:		Scale factor to apply during the conversion
+ *
+ * Returns an error code or 0.
+ *
+ * This function will read a processed value from a channel. This will work
+ * like @iio_read_channel_processed() but also scale with an additional
+ * scale factor while attempting to minimize any precision loss.
+ */
+int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
+				     unsigned int scale);
+
 /**
  * iio_write_channel_attribute() - Write values to the device attribute.
  * @chan:	The channel being queried.
-- 
2.29.2

