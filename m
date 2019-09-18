Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65ADDB65F4
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 16:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbfIROXc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 10:23:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43098 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfIROXb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 10:23:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id a2so43401pfo.10;
        Wed, 18 Sep 2019 07:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rsHKe2GEAFIqvfRUpuT6Tf+GbURK9WG8ZDQF21uKEP8=;
        b=SkP76KnKeC1K9oTwwMrjV5xtCCKCtUFH8PaLV3fcuXe9vSx7YQpi2alNyUQoCMPmd+
         RAS3C1aG7p+q4HnCpOY1PYqSNOE9tXuP5ahV21OJ3bcGXujvgC5dviv1dNqR2nqNydUb
         H0ofxI3xbjgxkfMqAgtoGKIDMAxY6MJBMocv455YDpU+1CYRe3231Vf5NplvOMIpd6hu
         WOa25rP0hGZ6Tzxcy//l5uV+KWttyZ1UFBEbbEa3Mnw2z39rII5VnST9m1rU1lqhEd09
         qR279WJFpN2M5nVRp7gUY9n3ll6Srwh2guzNFbcJV9dp6KEHii38EZemwlekdD+bx4Zr
         eHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rsHKe2GEAFIqvfRUpuT6Tf+GbURK9WG8ZDQF21uKEP8=;
        b=fzCXlREY8FZX9nkR1zAFDwAdPagUHooWHxPYD4AGxTPmHQGUvTLVyEhIGnHaDvhvvT
         KbEKyT6RGW9rflqbVvpl3I4mA9vS4e2S94HY7y9Dhw5FLYRSE9OqCCF8x76eZ1f8g6Nj
         gEO4otOk7hNF7H3lyl19VbzkH0y/tFs8CgR20pD1J80YOAHLY+e2co5NaPOOwitgGZws
         Gy3Iw259rPAjDvzlzkGxSLBAn2Qrng0ORy7cN/ZXJIRi4PNgs2RZoQ359+YzulcG1Syw
         ufgVDnONe9H+8NIGpNd9MJnhnP4Fy/SwpLsUwOYBsnJo3CLJoyZPELEEZoHP3LWQBw6A
         Si6A==
X-Gm-Message-State: APjAAAU4NTyywpoxNXsIqyujwfG9whoxfhxWv5vCTR/+ZSxnBpIb1ad7
        RoPq+BC6nHsLIC0z7gv4xz4=
X-Google-Smtp-Source: APXvYqyV/Ii4D4d6czIlxEJuRGsWlTRgEeXaJQAauWkLPIu0GY8ldaVmKQCIi7GZ6TZ0JiqtKR9Ljw==
X-Received: by 2002:a65:5543:: with SMTP id t3mr4227024pgr.242.1568816610632;
        Wed, 18 Sep 2019 07:23:30 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c145:8e3a:1c91:3b66:30:c335])
        by smtp.gmail.com with ESMTPSA id d5sm10996675pfa.180.2019.09.18.07.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 07:23:29 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@jic23.retrosnub.co.uk
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, benjamin.gaignard@linaro.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v3 1/2] counter: Simplify the count_read and count_write callbacks
Date:   Wed, 18 Sep 2019 23:22:45 +0900
Message-Id: <1fa62c1a52d3acde272a017de15e69ecf6b8b0f7.1568816248.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568816248.git.vilhelm.gray@gmail.com>
References: <cover.1568816248.git.vilhelm.gray@gmail.com>
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

Cc: Patrick Havelange <patrick.havelange@essensium.com>
Acked-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c        |  33 +++------
 drivers/counter/counter.c           | 101 +++++-----------------------
 drivers/counter/ftm-quaddec.c       |  14 ++--
 drivers/counter/stm32-lptimer-cnt.c |   5 +-
 drivers/counter/stm32-timer-cnt.c   |  17 ++---
 include/linux/counter.h             |  74 +++-----------------
 6 files changed, 45 insertions(+), 199 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 00b113f4b958..17e67a84777d 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -562,11 +562,10 @@ static const struct iio_chan_spec quad8_channels[] = {
 };
 
 static int quad8_signal_read(struct counter_device *counter,
-	struct counter_signal *signal, struct counter_signal_read_value *val)
+	struct counter_signal *signal, enum counter_signal_value *val)
 {
 	const struct quad8_iio *const priv = counter->priv;
 	unsigned int state;
-	enum counter_signal_level level;
 
 	/* Only Index signal levels can be read */
 	if (signal->id < 16)
@@ -575,22 +574,19 @@ static int quad8_signal_read(struct counter_device *counter,
 	state = inb(priv->base + QUAD8_REG_INDEX_INPUT_LEVELS)
 		& BIT(signal->id - 16);
 
-	level = (state) ? COUNTER_SIGNAL_LEVEL_HIGH : COUNTER_SIGNAL_LEVEL_LOW;
-
-	counter_signal_read_value_set(val, COUNTER_SIGNAL_LEVEL, &level);
+	*val = (state) ? COUNTER_SIGNAL_HIGH : COUNTER_SIGNAL_LOW;
 
 	return 0;
 }
 
 static int quad8_count_read(struct counter_device *counter,
-	struct counter_count *count, struct counter_count_read_value *val)
+	struct counter_count *count, unsigned long *val)
 {
 	const struct quad8_iio *const priv = counter->priv;
 	const int base_offset = priv->base + 2 * count->id;
 	unsigned int flags;
 	unsigned int borrow;
 	unsigned int carry;
-	unsigned long position;
 	int i;
 
 	flags = inb(base_offset + 1);
@@ -598,36 +594,27 @@ static int quad8_count_read(struct counter_device *counter,
 	carry = !!(flags & QUAD8_FLAG_CT);
 
 	/* Borrow XOR Carry effectively doubles count range */
-	position = (unsigned long)(borrow ^ carry) << 24;
+	*val = (unsigned long)(borrow ^ carry) << 24;
 
 	/* Reset Byte Pointer; transfer Counter to Output Latch */
 	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_CNTR_OUT,
 	     base_offset + 1);
 
 	for (i = 0; i < 3; i++)
-		position |= (unsigned long)inb(base_offset) << (8 * i);
-
-	counter_count_read_value_set(val, COUNTER_COUNT_POSITION, &position);
+		*val |= (unsigned long)inb(base_offset) << (8 * i);
 
 	return 0;
 }
 
 static int quad8_count_write(struct counter_device *counter,
-	struct counter_count *count, struct counter_count_write_value *val)
+	struct counter_count *count, unsigned long val)
 {
 	const struct quad8_iio *const priv = counter->priv;
 	const int base_offset = priv->base + 2 * count->id;
-	int err;
-	unsigned long position;
 	int i;
 
-	err = counter_count_write_value_get(&position, COUNTER_COUNT_POSITION,
-					    val);
-	if (err)
-		return err;
-
 	/* Only 24-bit values are supported */
-	if (position > 0xFFFFFF)
+	if (val > 0xFFFFFF)
 		return -EINVAL;
 
 	/* Reset Byte Pointer */
@@ -635,7 +622,7 @@ static int quad8_count_write(struct counter_device *counter,
 
 	/* Counter can only be set via Preset Register */
 	for (i = 0; i < 3; i++)
-		outb(position >> (8 * i), base_offset);
+		outb(val >> (8 * i), base_offset);
 
 	/* Transfer Preset Register to Counter */
 	outb(QUAD8_CTR_RLD | QUAD8_RLD_PRESET_CNTR, base_offset + 1);
@@ -644,9 +631,9 @@ static int quad8_count_write(struct counter_device *counter,
 	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
 
 	/* Set Preset Register back to original value */
-	position = priv->preset[count->id];
+	val = priv->preset[count->id];
 	for (i = 0; i < 3; i++)
-		outb(position >> (8 * i), base_offset);
+		outb(val >> (8 * i), base_offset);
 
 	/* Reset Borrow, Carry, Compare, and Sign flags */
 	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_FLAGS, base_offset + 1);
diff --git a/drivers/counter/counter.c b/drivers/counter/counter.c
index 106bc7180cd8..6a683d086008 100644
--- a/drivers/counter/counter.c
+++ b/drivers/counter/counter.c
@@ -220,86 +220,6 @@ ssize_t counter_device_enum_available_read(struct counter_device *counter,
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
@@ -369,6 +289,11 @@ struct counter_signal_unit {
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
@@ -377,13 +302,13 @@ static ssize_t counter_signal_show(struct device *dev,
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
@@ -788,13 +713,13 @@ static ssize_t counter_count_show(struct device *dev,
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
@@ -806,9 +731,13 @@ static ssize_t counter_count_store(struct device *dev,
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
 
diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
index 4046aa9f9234..c2b3fdfd8b77 100644
--- a/drivers/counter/ftm-quaddec.c
+++ b/drivers/counter/ftm-quaddec.c
@@ -178,31 +178,25 @@ static const enum counter_count_function ftm_quaddec_count_functions[] = {
 
 static int ftm_quaddec_count_read(struct counter_device *counter,
 				  struct counter_count *count,
-				  struct counter_count_read_value *val)
+				  unsigned long *val)
 {
 	struct ftm_quaddec *const ftm = counter->priv;
 	uint32_t cntval;
 
 	ftm_read(ftm, FTM_CNT, &cntval);
 
-	counter_count_read_value_set(val, COUNTER_COUNT_POSITION, &cntval);
+	*val = cntval;
 
 	return 0;
 }
 
 static int ftm_quaddec_count_write(struct counter_device *counter,
 				   struct counter_count *count,
-				   struct counter_count_write_value *val)
+				   const unsigned long val)
 {
 	struct ftm_quaddec *const ftm = counter->priv;
-	u32 cnt;
-	int err;
 
-	err = counter_count_write_value_get(&cnt, COUNTER_COUNT_POSITION, val);
-	if (err)
-		return err;
-
-	if (cnt != 0) {
+	if (val != 0) {
 		dev_warn(&ftm->pdev->dev, "Can only accept '0' as new counter value\n");
 		return -EINVAL;
 	}
diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
index bbc930a5962c..73bb773f5e6d 100644
--- a/drivers/counter/stm32-lptimer-cnt.c
+++ b/drivers/counter/stm32-lptimer-cnt.c
@@ -377,8 +377,7 @@ static enum counter_synapse_action stm32_lptim_cnt_synapse_actions[] = {
 };
 
 static int stm32_lptim_cnt_read(struct counter_device *counter,
-				struct counter_count *count,
-				struct counter_count_read_value *val)
+				struct counter_count *count, unsigned long *val)
 {
 	struct stm32_lptim_cnt *const priv = counter->priv;
 	u32 cnt;
@@ -388,7 +387,7 @@ static int stm32_lptim_cnt_read(struct counter_device *counter,
 	if (ret)
 		return ret;
 
-	counter_count_read_value_set(val, COUNTER_COUNT_POSITION, &cnt);
+	*val = cnt;
 
 	return 0;
 }
diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 644ba18a72ad..839083543323 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -48,34 +48,27 @@ static enum counter_count_function stm32_count_functions[] = {
 };
 
 static int stm32_count_read(struct counter_device *counter,
-			    struct counter_count *count,
-			    struct counter_count_read_value *val)
+			    struct counter_count *count, unsigned long *val)
 {
 	struct stm32_timer_cnt *const priv = counter->priv;
 	u32 cnt;
 
 	regmap_read(priv->regmap, TIM_CNT, &cnt);
-	counter_count_read_value_set(val, COUNTER_COUNT_POSITION, &cnt);
+	*val = cnt;
 
 	return 0;
 }
 
 static int stm32_count_write(struct counter_device *counter,
 			     struct counter_count *count,
-			     struct counter_count_write_value *val)
+			     const unsigned long val)
 {
 	struct stm32_timer_cnt *const priv = counter->priv;
-	u32 cnt;
-	int err;
-
-	err = counter_count_write_value_get(&cnt, COUNTER_COUNT_POSITION, val);
-	if (err)
-		return err;
 
-	if (cnt > priv->ceiling)
+	if (val > priv->ceiling)
 		return -EINVAL;
 
-	return regmap_write(priv->regmap, TIM_CNT, cnt);
+	return regmap_write(priv->regmap, TIM_CNT, val);
 }
 
 static int stm32_count_function_get(struct counter_device *counter,
diff --git a/include/linux/counter.h b/include/linux/counter.h
index a061cdcdef7c..32fb4d8cc3fd 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -290,53 +290,22 @@ struct counter_device_state {
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
-};
-
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
@@ -355,13 +324,11 @@ struct counter_count_write_value {
 struct counter_ops {
 	int (*signal_read)(struct counter_device *counter,
 			   struct counter_signal *signal,
-			   struct counter_signal_read_value *val);
+			   enum counter_signal_value *val);
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
@@ -477,29 +444,6 @@ struct counter_device {
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
-enum counter_count_value_type {
-	COUNTER_COUNT_POSITION = 0,
-};
-
-void counter_signal_read_value_set(struct counter_signal_read_value *const val,
-				   const enum counter_signal_value_type type,
-				   void *const data);
-void counter_count_read_value_set(struct counter_count_read_value *const val,
-				  const enum counter_count_value_type type,
-				  void *const data);
-int counter_count_write_value_get(void *const data,
-				  const enum counter_count_value_type type,
-				  const struct counter_count_write_value *const val);
-
 int counter_register(struct counter_device *const counter);
 void counter_unregister(struct counter_device *const counter);
 int devm_counter_register(struct device *dev,
-- 
2.23.0

