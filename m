Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E765B5E4F
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 09:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfIRHxU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 03:53:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38488 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfIRHxT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 03:53:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id x10so3527330pgi.5;
        Wed, 18 Sep 2019 00:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xjl+nKMauFdQMucZCGYFJNYkEcd8nmtmKLzonD2DvBw=;
        b=aapYiITKELPyW4PHB8mGw+Qj50qIrsMGCgbf6vimpLFQn0kfedpldxpF+mnmGruaRd
         0D8dSrIxudPaQYKYtAJrGcKiT8MvXUOpimKbMaeDoAoX0MlxNUIblfM+rFIUdA6Fa+q0
         fthHylYRRRyzedpTzlaznmGMzytzDacZRuJ/ge1XH/9Y1p4sdx40bnlddoJYjB64oksE
         a8XW5eydVr6oBq2MGac+QDMkHOFsmbDn+Te32g8A+A2ELQedhj4qMBs4oKMkLNMEpd6A
         RdoZHCGo7QdWuRXFOQApsNZa6kL3Mi5LyXDjTJeM7rmc077HB3Z/t+V2mQBDbDe3Dl70
         3Zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xjl+nKMauFdQMucZCGYFJNYkEcd8nmtmKLzonD2DvBw=;
        b=Uoyl2hwqSu3OeMF0ZgN3ex+oaVqqiIXrCUY0c3rDXoHQVTeF7KHs0NhWRqduAgcJx8
         ByJc9Qp7qr3biecZtmyQ237RcBABzOny61py0EWIEJiyZoFTB5vMuU3Fz0tC0M8/uq/d
         8g/Uwz38FX6la8MNfA6Xi1s0eZlwWq29Opomqrdvkf6zv/kqAKVUg0f2Ol1OSDP7iu+d
         Qg4Mfp1xNMUno1hE3+GIFdCerLtAv9hkwvoZZimZonPPLRGuaI+bFm4rePu8F5vVqeC4
         lz8R7XSVYVvosbLCiiw2SkRJxoplWlM6dKZNA3hF6W/jYfZkPWjjERXiUUxBeMtoJ5R4
         sfyQ==
X-Gm-Message-State: APjAAAX0xtOiDWddO6rPy7QfoS+x4zmX7GgSGQ3OjtYZwqnDggojs7eV
        cJ0vHFGiyP3sJJiQwjXIC3Q=
X-Google-Smtp-Source: APXvYqy5KsztavGnDkcRDa8efg7SqNcEzpfdR8ZQEEx9n/F421fNVbt98mZe0yTO939Qqb5PhBhnRw==
X-Received: by 2002:a17:90a:2ecb:: with SMTP id h11mr2331197pjs.108.1568793198781;
        Wed, 18 Sep 2019 00:53:18 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c147:d9df:f819:e399:825f:f2dc])
        by smtp.gmail.com with ESMTPSA id h8sm5580715pfo.64.2019.09.18.00.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 00:53:17 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@jic23.retrosnub.co.uk
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v2 1/7] counter: Simplify the count_read and count_write callbacks
Date:   Wed, 18 Sep 2019 16:52:42 +0900
Message-Id: <f7969048e5db977cc6cc9daa8d32b170cf9f4c17.1568792697.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568792697.git.vilhelm.gray@gmail.com>
References: <cover.1568792697.git.vilhelm.gray@gmail.com>
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

