Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 905E3B5E51
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 09:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfIRHxY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 03:53:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40195 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbfIRHxY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 03:53:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so3521803pgj.7;
        Wed, 18 Sep 2019 00:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y1oWvoEblal6EMi7QOA2PERi1JLfxSYAnMiBp+6pVPo=;
        b=CnEdhhsRkpafJvgJT4mL3c+IcDmTmsQB0iDRkZeA/NAmKxpkZza0NRe67uVCmcfyRZ
         GWdbH1S0liYCjA94q29e/woGC2zdHfnKWDjDONnLWwTCwBAKkNcI4cD6jwkUQc4yxKz1
         Qt6d4xNERDcmfK5Po3W6mKGQIykecevxBvyMiJeRAmTOapSV2mHPTlSe3hWRRo1lKIqn
         CXhZ0kb4jBW6B3LCuK82M7IfscaIKJZ4Ju+H0fdwY/jKrrpdth6quh4c2V5yXEnF+ABg
         rlnswzlq9NKl3EIjGhwcfsmaPP9KfDEWViGEY4i2+4rEEf1qDZad0gfIfY2Pnc8sANA3
         6Uzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y1oWvoEblal6EMi7QOA2PERi1JLfxSYAnMiBp+6pVPo=;
        b=m+n9rDdrvN1OalzD2c8KUFPxDeyxEvMhduErzYvcBo3TS/yL7+2/9BeDCczK10V+tC
         Hykla/S2ax6cjHDJSxREqFk3iBiTrx/PrTKEYMAqtkZcA+7//IQP48nl2ku/YOc3fvyu
         Ql8Xi65voxVvGr8Coy8ZRLkosj98+eS/EQacm2es3rbi7KN7cyP2u4HK97CfSend8Skl
         DZRfOq7rjRb6IKsdTst9d8vL4pLtpGuU4iUU69AcQkiF8kMEE/ryu2cbsWRhSBcRbEL1
         ua7DTDRPnL4qvxH/IGuP8LF8zTVYD5pZrA1HU0UQ7qpbQxinr15wyUQB4j8EgSHFofmR
         AYyw==
X-Gm-Message-State: APjAAAVSChKf5e4uefRvL4h7SCvy6Ca3Y2OS98usYkPHItShMu5an6rq
        HoPjVYJmW5/5p4b4+bcdCus=
X-Google-Smtp-Source: APXvYqz1GM0wIGoCacIl0DFSJZeVxpLMqSHlnKe5HnoF5L2gn6G5UNxU1R9svnqYxwXg8JzOg1r+XQ==
X-Received: by 2002:a17:90a:fe04:: with SMTP id ck4mr2425601pjb.74.1568793203428;
        Wed, 18 Sep 2019 00:53:23 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c147:d9df:f819:e399:825f:f2dc])
        by smtp.gmail.com with ESMTPSA id h8sm5580715pfo.64.2019.09.18.00.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 00:53:22 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@jic23.retrosnub.co.uk
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v2 2/7] counter: Simplify the signal_read callback
Date:   Wed, 18 Sep 2019 16:52:43 +0900
Message-Id: <422cb5fa006ec10f1c6d1130a282f2a5d2cdd9df.1568792697.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568792697.git.vilhelm.gray@gmail.com>
References: <cover.1568792697.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The signal_read callback is simplified to pass val as a
counter_signal_val enum rather than as an opaque data structure. The
opaque counter_signal_read_value structure and relevant
counter_signal_read_value_set function are removed as they are no longer
used. In addition, the counter_signal_level enum is replaced by the
similar counter_signal_value enum.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/counter.c | 35 +++++++----------------------------
 include/linux/counter.h   | 31 +++++--------------------------
 2 files changed, 12 insertions(+), 54 deletions(-)

diff --git a/drivers/counter/counter.c b/drivers/counter/counter.c
index 1d08f1437b1b..6a683d086008 100644
--- a/drivers/counter/counter.c
+++ b/drivers/counter/counter.c
@@ -220,32 +220,6 @@ ssize_t counter_device_enum_available_read(struct counter_device *counter,
 }
 EXPORT_SYMBOL_GPL(counter_device_enum_available_read);
 
-static const char *const counter_signal_level_str[] = {
-	[COUNTER_SIGNAL_LEVEL_LOW] = "low",
-	[COUNTER_SIGNAL_LEVEL_HIGH] = "high"
-};
-
-/**
- * counter_signal_read_value_set - set counter_signal_read_value data
- * @val:	counter_signal_read_value structure to set
- * @type:	property Signal data represents
- * @data:	Signal data
- *
- * This function sets an opaque counter_signal_read_value structure with the
- * provided Signal data.
- */
-void counter_signal_read_value_set(struct counter_signal_read_value *const val,
-				   const enum counter_signal_value_type type,
-				   void *const data)
-{
-	if (type == COUNTER_SIGNAL_LEVEL)
-		val->len = sprintf(val->buf, "%s\n",
-				   counter_signal_level_str[*(enum counter_signal_level *)data]);
-	else
-		val->len = 0;
-}
-EXPORT_SYMBOL_GPL(counter_signal_read_value_set);
-
 struct counter_attr_parm {
 	struct counter_device_attr_group *group;
 	const char *prefix;
@@ -315,6 +289,11 @@ struct counter_signal_unit {
 	struct counter_signal *signal;
 };
 
+static const char *const counter_signal_value_str[] = {
+	[COUNTER_SIGNAL_LOW] = "low",
+	[COUNTER_SIGNAL_HIGH] = "high"
+};
+
 static ssize_t counter_signal_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -323,13 +302,13 @@ static ssize_t counter_signal_show(struct device *dev,
 	const struct counter_signal_unit *const component = devattr->component;
 	struct counter_signal *const signal = component->signal;
 	int err;
-	struct counter_signal_read_value val = { .buf = buf };
+	enum counter_signal_value val;
 
 	err = counter->ops->signal_read(counter, signal, &val);
 	if (err)
 		return err;
 
-	return val.len;
+	return sprintf(buf, "%s\n", counter_signal_value_str[val]);
 }
 
 struct counter_name_unit {
diff --git a/include/linux/counter.h b/include/linux/counter.h
index 7e40796598a6..32fb4d8cc3fd 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -290,24 +290,16 @@ struct counter_device_state {
 	const struct attribute_group **groups;
 };
 
-/**
- * struct counter_signal_read_value - Opaque Signal read value
- * @buf:	string representation of Signal read value
- * @len:	length of string in @buf
- */
-struct counter_signal_read_value {
-	char *buf;
-	size_t len;
+enum counter_signal_value {
+	COUNTER_SIGNAL_LOW = 0,
+	COUNTER_SIGNAL_HIGH
 };
 
 /**
  * struct counter_ops - Callbacks from driver
  * @signal_read:	optional read callback for Signal attribute. The read
  *			value of the respective Signal should be passed back via
- *			the val parameter. val points to an opaque type which
- *			should be set only by calling the
- *			counter_signal_read_value_set function from within the
- *			signal_read callback.
+ *			the val parameter.
  * @count_read:		optional read callback for Count attribute. The read
  *			value of the respective Count should be passed back via
  *			the val parameter.
@@ -332,7 +324,7 @@ struct counter_signal_read_value {
 struct counter_ops {
 	int (*signal_read)(struct counter_device *counter,
 			   struct counter_signal *signal,
-			   struct counter_signal_read_value *val);
+			   enum counter_signal_value *val);
 	int (*count_read)(struct counter_device *counter,
 			  struct counter_count *count, unsigned long *val);
 	int (*count_write)(struct counter_device *counter,
@@ -452,19 +444,6 @@ struct counter_device {
 	void *priv;
 };
 
-enum counter_signal_level {
-	COUNTER_SIGNAL_LEVEL_LOW = 0,
-	COUNTER_SIGNAL_LEVEL_HIGH
-};
-
-enum counter_signal_value_type {
-	COUNTER_SIGNAL_LEVEL = 0
-};
-
-void counter_signal_read_value_set(struct counter_signal_read_value *const val,
-				   const enum counter_signal_value_type type,
-				   void *const data);
-
 int counter_register(struct counter_device *const counter);
 void counter_unregister(struct counter_device *const counter);
 int devm_counter_register(struct device *dev,
-- 
2.23.0

