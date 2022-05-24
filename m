Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6711532051
	for <lists+linux-iio@lfdr.de>; Tue, 24 May 2022 03:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiEXBmH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 May 2022 21:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiEXBmG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 May 2022 21:42:06 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C269544C4
        for <linux-iio@vger.kernel.org>; Mon, 23 May 2022 18:42:04 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id b11so4711371qvv.4
        for <linux-iio@vger.kernel.org>; Mon, 23 May 2022 18:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9hL+x5Ygd1NcLiZZnlB/7GD/5D3stuShZTqJ8m8NMlo=;
        b=JSSkh84KT5LSgXj0HxSZl44ttzFTPU+mudVNaX+4Uh4yhvZGjYYdTBiHsn5VRXY5eE
         6JFg6Svui+AHt4BQfYKqzenJFcISDafTSD1WCVGjJitCcx7HuOuyWHpSEdh6SCsWIO0k
         8HxKPSYkirOCHgsUDFFNxd1MAZ8hSapjIgoa9Y711inZb/8bW6YgmITqoepXHA02hMNF
         Gkv7BrbYLkRxkmo1noziFJSteoh8IHSbkEenwrR3y9L7pPTewubAlH+f7fwCZHLy1Jv8
         EkFvP0rHI9c+ZXaxkU9xkxLkEk/oZ3idhFw+3Db7I+ISgZUajLP+PR7Uyejo69WA5Rcu
         a36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9hL+x5Ygd1NcLiZZnlB/7GD/5D3stuShZTqJ8m8NMlo=;
        b=gDR/m4hokJGkiqGJfRlkcLw79KAIfN22x/5QAnJz5jGgaaEzzOSQwTcTevRXfd2oTl
         9FCmxyt72e8gSwf5nDfiGvVJQDgvTiWdWtTx3vHDbFV0lwNVCo7WP4VIdxlnAWF/AhGC
         Xg4GtbBAykrFYFPegesPRnxiVakE7vSb0PGd6qDL09/HXDMSnqClYiEw2UvvbBTwmIKo
         7vfhjX+ZNjUg03guYl+Lgxxnl2tQRu830hURUqdGme3GzMq3Z7xkRpa17uZSNs+EP5+N
         NwuD5qW7foJfqeedU25b9JRuqrxoS3GmKwfoTFYqEjYmL4ox7MRrwz/3v3c8bsOeO0Dt
         raSQ==
X-Gm-Message-State: AOAM532+Z66W3BqTGBaJjSMVZaWQ12Svchqn5z+quH/cfvI85JddLXXA
        bSXNBsRW2oyf7aIbWBZDd80PeuKzOnw=
X-Google-Smtp-Source: ABdhPJwnvnSVjuWrJ9Emm+47tZC0kccNBSkDkww2OEzKjmp18jhf+0/LBbyIHhmV9maI1ztLvvx7SA==
X-Received: by 2002:ad4:4d06:0:b0:461:d807:4157 with SMTP id l6-20020ad44d06000000b00461d8074157mr19496982qvl.89.1653356523662;
        Mon, 23 May 2022 18:42:03 -0700 (PDT)
Received: from spruce.. (c-71-206-142-238.hsd1.va.comcast.net. [71.206.142.238])
        by smtp.gmail.com with ESMTPSA id h143-20020a379e95000000b0069fc13ce226sm5302904qke.87.2022.05.23.18.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 18:42:03 -0700 (PDT)
From:   Joe Simmons-Talbott <joetalbott@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Joe Simmons-Talbott <joetalbott@gmail.com>
Subject: [PATCH] iio: Prefer octal over symbolic permissions.
Date:   Mon, 23 May 2022 21:41:58 -0400
Message-Id: <20220524014158.482746-1-joetalbott@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

As reported by checkpatch.pl.

Signed-off-by: Joe Simmons-Talbott <joetalbott@gmail.com>
---
 drivers/iio/industrialio-buffer.c  | 12 ++++++------
 drivers/iio/industrialio-core.c    | 10 +++++-----
 drivers/iio/industrialio-trigger.c |  4 ++--
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 06141ca27e1f..ff4da7944e28 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1394,17 +1394,17 @@ static ssize_t direction_show(struct device *dev,
 	}
 }
 
-static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
+static DEVICE_ATTR(length, 0644, iio_buffer_read_length,
 		   iio_buffer_write_length);
 static struct device_attribute dev_attr_length_ro = __ATTR(length,
-	S_IRUGO, iio_buffer_read_length, NULL);
-static DEVICE_ATTR(enable, S_IRUGO | S_IWUSR,
+	0444, iio_buffer_read_length, NULL);
+static DEVICE_ATTR(enable, 0644,
 		   iio_buffer_show_enable, iio_buffer_store_enable);
-static DEVICE_ATTR(watermark, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(watermark, 0644,
 		   iio_buffer_show_watermark, iio_buffer_store_watermark);
 static struct device_attribute dev_attr_watermark_ro = __ATTR(watermark,
-	S_IRUGO, iio_buffer_show_watermark, NULL);
-static DEVICE_ATTR(data_available, S_IRUGO,
+	0444, iio_buffer_show_watermark, NULL);
+static DEVICE_ATTR(data_available, 0444,
 		iio_dma_show_data_available, NULL);
 static DEVICE_ATTR_RO(direction);
 
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index adf054c7a75e..ac5244591752 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1127,12 +1127,12 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
 	dev_attr->attr.name = name;
 
 	if (readfunc) {
-		dev_attr->attr.mode |= S_IRUGO;
+		dev_attr->attr.mode |= 0444;
 		dev_attr->show = readfunc;
 	}
 
 	if (writefunc) {
-		dev_attr->attr.mode |= S_IWUSR;
+		dev_attr->attr.mode |= 0200;
 		dev_attr->store = writefunc;
 	}
 
@@ -1414,7 +1414,7 @@ static ssize_t iio_show_dev_name(struct device *dev,
 	return sysfs_emit(buf, "%s\n", indio_dev->name);
 }
 
-static DEVICE_ATTR(name, S_IRUGO, iio_show_dev_name, NULL);
+static DEVICE_ATTR(name, 0444, iio_show_dev_name, NULL);
 
 static ssize_t iio_show_dev_label(struct device *dev,
 				 struct device_attribute *attr,
@@ -1424,7 +1424,7 @@ static ssize_t iio_show_dev_label(struct device *dev,
 	return sysfs_emit(buf, "%s\n", indio_dev->label);
 }
 
-static DEVICE_ATTR(label, S_IRUGO, iio_show_dev_label, NULL);
+static DEVICE_ATTR(label, 0444, iio_show_dev_label, NULL);
 
 static ssize_t iio_show_timestamp_clock(struct device *dev,
 					struct device_attribute *attr,
@@ -1522,7 +1522,7 @@ int iio_device_register_sysfs_group(struct iio_dev *indio_dev,
 	return 0;
 }
 
-static DEVICE_ATTR(current_timestamp_clock, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(current_timestamp_clock, 0644,
 		   iio_show_timestamp_clock, iio_store_timestamp_clock);
 
 static int iio_device_register_sysfs(struct iio_dev *indio_dev)
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index b093511c0375..ad22ceb1e319 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -54,7 +54,7 @@ static ssize_t iio_trigger_read_name(struct device *dev,
 	return sysfs_emit(buf, "%s\n", trig->name);
 }
 
-static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
+static DEVICE_ATTR(name, 0444, iio_trigger_read_name, NULL);
 
 static struct attribute *iio_trig_dev_attrs[] = {
 	&dev_attr_name.attr,
@@ -494,7 +494,7 @@ static ssize_t iio_trigger_write_current(struct device *dev,
 	return ret;
 }
 
-static DEVICE_ATTR(current_trigger, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(current_trigger, 0644,
 		   iio_trigger_read_current,
 		   iio_trigger_write_current);
 
-- 
2.35.3

