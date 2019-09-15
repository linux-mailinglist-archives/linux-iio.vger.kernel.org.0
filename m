Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2278FB2E85
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 07:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfIOF6p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 01:58:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38710 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfIOF6o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2019 01:58:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id d10so17471756pgo.5;
        Sat, 14 Sep 2019 22:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y1oWvoEblal6EMi7QOA2PERi1JLfxSYAnMiBp+6pVPo=;
        b=XqXxUFIabHtNEQs/ODV+krGKdOu/9F07NDIDgMqw5TRtza8eGpItgH3mr+HlR0UoH7
         +5gK90Qqvqyw+qdZBdJPzQtgDZBCQuHdrmrP7w39acKFTe1zbXXhtzkIvI8DUbiDNhCA
         e4+7Kg3ZGTHTVmsk6kHwtnDPgZToBJFpWrbd2cmh/gtXilEOGXWjjyap5O1lc67yi9m2
         qHwkpCeLj46hZoQnaDheYrHf3fB2lwxQFmZ1dqz7O0pyqH6y2zuxSqmvvomz9+1skyMI
         it+Mt0wDLqm/usj/uNASFRcBRLw5ccC7dj1w/QnZLnFe3IEpNPLdk0SpUrdKqDLcTTzr
         0N1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y1oWvoEblal6EMi7QOA2PERi1JLfxSYAnMiBp+6pVPo=;
        b=MY/FIS9NJUOcFevWZZZRXVZ5G1IryWjZEZWA6QZA6XW1vFu+/mENxZ4Lw8kpkfhWiM
         1dTSW9GV+I4UsvInjHeShF7TYXYg+eR+06lEFwwa2QLOKD3C1Bwvq085wIZUQBgn2Iv9
         6WIzB8KZVw3vPf9wilncdI10tKfa7P7SbdcnjsUtaf90l9+LLjG+SibMob4TRH8MxIaG
         IPkk4Xh3XVM20e5M+sqQCPcksWMRX3HCR8BkWyugwwbxMFrGSudJZMBWCp7TZ5pndBKY
         0KKJvQS0xoFLyYkHM8FIZS8zIhnIBU3YuLIoO8vnGH2mJrwfwTvV3Ccw1Hoj0DkvvwFT
         FM3w==
X-Gm-Message-State: APjAAAXs0F2b6t0X9Iy4AQEy0qsfmoJqoqY97boSGCaXAIbM8NAWV6kr
        YR62MjtyIL5Oay4B6yVu+TM=
X-Google-Smtp-Source: APXvYqxOvken+mjuq8Gu3saW8bcynzHFCLF3r7N2C3h58KecuVEdCIzVmp7i8XAPVMgxQ3rIKRIiNA==
X-Received: by 2002:a63:2346:: with SMTP id u6mr18346540pgm.304.1568527121195;
        Sat, 14 Sep 2019 22:58:41 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c144:8b8a:e7a2:82ca:6689:77bb])
        by smtp.gmail.com with ESMTPSA id 22sm3696658pfj.139.2019.09.14.22.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2019 22:58:40 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@jic23.retrosnub.co.uk
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [RFC 2/4] counter: Simplify the signal_read callback
Date:   Sun, 15 Sep 2019 14:57:57 +0900
Message-Id: <20190915055759.408690-3-vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190915055759.408690-1-vilhelm.gray@gmail.com>
References: <20190915055759.408690-1-vilhelm.gray@gmail.com>
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

