Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 133FFB2E83
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 07:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfIOF6j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 01:58:39 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36184 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfIOF6j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2019 01:58:39 -0400
Received: by mail-pl1-f194.google.com with SMTP id f19so15067250plr.3;
        Sat, 14 Sep 2019 22:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xjl+nKMauFdQMucZCGYFJNYkEcd8nmtmKLzonD2DvBw=;
        b=g655PQ9IlN8hq0p+5TDCqjVifJpojbCk/nQ0WgAKyarCg8+7bTpkJVNjgK6odD5wr+
         1TxRvIIJj6MpXscW2aQv6IlbpGCQviR2UF2AcdGcnPsNNsSDnGepF1Lfljeq79t/ygOU
         Fq8rlw3Nu7LruAJf5UUvqOoPVr1IulyjVcCSXNutWoD3WR9V8sFm5nR4gGHLOGzyErcK
         6mEhuwgE0s7YQ7zfb5z0UoTOJP8is1+uG29vTY7IrW1zPtkAuvx+ViHSqZ21ehP4FiB0
         6wAmNWeKWAFbj7Ghzr7z5wyH9r8rrmzVptoy6qktoSL0o1x+NY0vPRsruDSIzAopidpb
         Ermw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xjl+nKMauFdQMucZCGYFJNYkEcd8nmtmKLzonD2DvBw=;
        b=kKe40wOxdFleBY54HOsmfQHd9bjEjGMRx96AtZAhTL9thTOhT/iAFfAvSnlmaLlb3y
         DeyrzEn1PG9iO3SYWPyv/QdOjDl4luWAyRYXB9D6Yizkj9qbHkBk6dtcAZ6XuEm2ZWgr
         K1/WOeC4rCvxrYvTVlS+rVk6cqipPn/6M3udpQ39Msj0kHXvPZneA4h/dVK2djicyb2n
         +Rp34DnUh6ktLA2SaCsknwW3uHeWFsI+CX+X5Q3/YnjJDKWO+j/WxDajabFQvyqDnbpC
         4sPffN+06h8ahtMStgCNHoPvEEFEPsEBaZfB7owYpQKrVWrFdI6qyXAPmGOltiiqf0aa
         XGkA==
X-Gm-Message-State: APjAAAUpc6cdwH5yNgNpLcyrP5dbpQN0x+//G0FZh9GXaxuAeuUibgWr
        f2Wt1czwhkeTk4kHtRwxiLI=
X-Google-Smtp-Source: APXvYqwMaogFax2o3ovVUIdITmUISWpPbOBLK2pKyeuy2P7AkzNI8a9Qu92CjJyVBKLh59igBUfoEg==
X-Received: by 2002:a17:902:8d8d:: with SMTP id v13mr57498097plo.137.1568527117956;
        Sat, 14 Sep 2019 22:58:37 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c144:8b8a:e7a2:82ca:6689:77bb])
        by smtp.gmail.com with ESMTPSA id 22sm3696658pfj.139.2019.09.14.22.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2019 22:58:37 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@jic23.retrosnub.co.uk
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [RFC 1/4] counter: Simplify the count_read and count_write callbacks
Date:   Sun, 15 Sep 2019 14:57:56 +0900
Message-Id: <20190915055759.408690-2-vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190915055759.408690-1-vilhelm.gray@gmail.com>
References: <20190915055759.408690-1-vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The count_read and count_write callbacks are simplified to pass val as
unsigned long rather than as an opaque data structure. The opaque
counter_count_read_value and counter_count_write_value structures,
counter_count_value_type enum, and relevant counter_count_read_value_set
and counter_count_write_value_get functions, are removed as they are no
longer used.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/counter.c | 66 +++++----------------------------------
 include/linux/counter.h   | 43 +++----------------------
 2 files changed, 12 insertions(+), 97 deletions(-)

diff --git a/drivers/counter/counter.c b/drivers/counter/counter.c
index 106bc7180cd8..1d08f1437b1b 100644
--- a/drivers/counter/counter.c
+++ b/drivers/counter/counter.c
@@ -246,60 +246,6 @@ void counter_signal_read_value_set(struct counter_signal_read_value *const val,
 }
 EXPORT_SYMBOL_GPL(counter_signal_read_value_set);
 
-/**
- * counter_count_read_value_set - set counter_count_read_value data
- * @val:	counter_count_read_value structure to set
- * @type:	property Count data represents
- * @data:	Count data
- *
- * This function sets an opaque counter_count_read_value structure with the
- * provided Count data.
- */
-void counter_count_read_value_set(struct counter_count_read_value *const val,
-				  const enum counter_count_value_type type,
-				  void *const data)
-{
-	switch (type) {
-	case COUNTER_COUNT_POSITION:
-		val->len = sprintf(val->buf, "%lu\n", *(unsigned long *)data);
-		break;
-	default:
-		val->len = 0;
-	}
-}
-EXPORT_SYMBOL_GPL(counter_count_read_value_set);
-
-/**
- * counter_count_write_value_get - get counter_count_write_value data
- * @data:	Count data
- * @type:	property Count data represents
- * @val:	counter_count_write_value structure containing data
- *
- * This function extracts Count data from the provided opaque
- * counter_count_write_value structure and stores it at the address provided by
- * @data.
- *
- * RETURNS:
- * 0 on success, negative error number on failure.
- */
-int counter_count_write_value_get(void *const data,
-				  const enum counter_count_value_type type,
-				  const struct counter_count_write_value *const val)
-{
-	int err;
-
-	switch (type) {
-	case COUNTER_COUNT_POSITION:
-		err = kstrtoul(val->buf, 0, data);
-		if (err)
-			return err;
-		break;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(counter_count_write_value_get);
-
 struct counter_attr_parm {
 	struct counter_device_attr_group *group;
 	const char *prefix;
@@ -788,13 +734,13 @@ static ssize_t counter_count_show(struct device *dev,
 	const struct counter_count_unit *const component = devattr->component;
 	struct counter_count *const count = component->count;
 	int err;
-	struct counter_count_read_value val = { .buf = buf };
+	unsigned long val;
 
 	err = counter->ops->count_read(counter, count, &val);
 	if (err)
 		return err;
 
-	return val.len;
+	return sprintf(buf, "%lu\n", val);
 }
 
 static ssize_t counter_count_store(struct device *dev,
@@ -806,9 +752,13 @@ static ssize_t counter_count_store(struct device *dev,
 	const struct counter_count_unit *const component = devattr->component;
 	struct counter_count *const count = component->count;
 	int err;
-	struct counter_count_write_value val = { .buf = buf };
+	unsigned long val;
+
+	err = kstrtoul(buf, 0, &val);
+	if (err)
+		return err;
 
-	err = counter->ops->count_write(counter, count, &val);
+	err = counter->ops->count_write(counter, count, val);
 	if (err)
 		return err;
 
diff --git a/include/linux/counter.h b/include/linux/counter.h
index a061cdcdef7c..7e40796598a6 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -300,24 +300,6 @@ struct counter_signal_read_value {
 	size_t len;
 };
 
-/**
- * struct counter_count_read_value - Opaque Count read value
- * @buf:	string representation of Count read value
- * @len:	length of string in @buf
- */
-struct counter_count_read_value {
-	char *buf;
-	size_t len;
-};
-
-/**
- * struct counter_count_write_value - Opaque Count write value
- * @buf:	string representation of Count write value
- */
-struct counter_count_write_value {
-	const char *buf;
-};
-
 /**
  * struct counter_ops - Callbacks from driver
  * @signal_read:	optional read callback for Signal attribute. The read
@@ -328,15 +310,10 @@ struct counter_count_write_value {
  *			signal_read callback.
  * @count_read:		optional read callback for Count attribute. The read
  *			value of the respective Count should be passed back via
- *			the val parameter. val points to an opaque type which
- *			should be set only by calling the
- *			counter_count_read_value_set function from within the
- *			count_read callback.
+ *			the val parameter.
  * @count_write:	optional write callback for Count attribute. The write
  *			value for the respective Count is passed in via the val
- *			parameter. val points to an opaque type which should be
- *			accessed only by calling the
- *			counter_count_write_value_get function.
+ *			parameter.
  * @function_get:	function to get the current count function mode. Returns
  *			0 on success and negative error code on error. The index
  *			of the respective Count's returned function mode should
@@ -357,11 +334,9 @@ struct counter_ops {
 			   struct counter_signal *signal,
 			   struct counter_signal_read_value *val);
 	int (*count_read)(struct counter_device *counter,
-			  struct counter_count *count,
-			  struct counter_count_read_value *val);
+			  struct counter_count *count, unsigned long *val);
 	int (*count_write)(struct counter_device *counter,
-			   struct counter_count *count,
-			   struct counter_count_write_value *val);
+			   struct counter_count *count, unsigned long val);
 	int (*function_get)(struct counter_device *counter,
 			    struct counter_count *count, size_t *function);
 	int (*function_set)(struct counter_device *counter,
@@ -486,19 +461,9 @@ enum counter_signal_value_type {
 	COUNTER_SIGNAL_LEVEL = 0
 };
 
-enum counter_count_value_type {
-	COUNTER_COUNT_POSITION = 0,
-};
-
 void counter_signal_read_value_set(struct counter_signal_read_value *const val,
 				   const enum counter_signal_value_type type,
 				   void *const data);
-void counter_count_read_value_set(struct counter_count_read_value *const val,
-				  const enum counter_count_value_type type,
-				  void *const data);
-int counter_count_write_value_get(void *const data,
-				  const enum counter_count_value_type type,
-				  const struct counter_count_write_value *const val);
 
 int counter_register(struct counter_device *const counter);
 void counter_unregister(struct counter_device *const counter);
-- 
2.23.0

