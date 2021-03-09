Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E44F3326C8
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 14:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhCINWC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 08:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbhCINV4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 08:21:56 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2109DC06174A;
        Tue,  9 Mar 2021 05:21:56 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id fu20so888127pjb.2;
        Tue, 09 Mar 2021 05:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DEdrckemkYx8poMfzLkSrC8voq/zhDbA2hHX3mjuC00=;
        b=gSm3nOAhQpNaoc9DhpyynvRflsKnVrTliD/EKys5s2XaVe3XdtcPZitAtkRfA2Ue7e
         kyDInGmi75lZDn2yQcOQ1K36tp7klrINgBQ6hId4ltFEpVDMnv41uWrvh0Z7Dxcrroee
         y8OA0VAefY5uKssVhZWUfxKRn4/eCO2OvG7QkgNpGJHGMbmywieml8kU+jrSiep2aNeZ
         tm5xDd+huO1imAR65vXf7AWIYGvTzV2O8BdTeYwutzEXFtgSnDHxAyTVmyGvrRMcwUgA
         uN359zIPB6H00sUNdd8saIO6urHL4Vrmq1wQuqESkap0b7nKWO50UN/OaEwAFlIS2Pln
         uCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DEdrckemkYx8poMfzLkSrC8voq/zhDbA2hHX3mjuC00=;
        b=XuAfGXShPyCvWKkszuiDUHjMRPQW8f995m0NCjXhk9KWDMipQqv9C7A7r0Jhhcq+sG
         S1M4GCAgcJEr5rib721Csopj6P0pnNMbqFulQMtKye8GkkMPfPWu+hxt9xsf3y8Qrpog
         EIlFU8y19AztnrBbE457P745cY0uSEB4xhhsA8tTQLWGSS2EOkOecGHE+zMEoceCHQ21
         k++WH4ufoifUdg84hQC8+6CwSBju4UQWml5Xm1jjNO2KCtGmItsZ5DBUOVmlVYpOYKCa
         yfV57SVAWTszW1eyThH3wzFpVc9xtdSaOsa7tlbzaAI8L35Jpx3MYvOKlvDMP9F9h3fz
         kObg==
X-Gm-Message-State: AOAM531zWGYcV2HGq8YEpbaw17XXGBdcqwNur8HLJO0h4mFKnd9xumtv
        Xo1tQ08VWWVuLiSUzTPBkbA=
X-Google-Smtp-Source: ABdhPJxikR/4OBFVRgIgoR6k3L4k6CVzNZEZcGEhKBe+7N0nCIU0wUPQOunrdVHaAsSWDpONqyL7yg==
X-Received: by 2002:a17:90a:8:: with SMTP id 8mr4736713pja.6.1615296115742;
        Tue, 09 Mar 2021 05:21:55 -0800 (PST)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id y9sm7647421pfl.201.2021.03.09.05.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 05:21:55 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v9 20/33] counter: Rename counter_signal_value to counter_signal_level
Date:   Tue,  9 Mar 2021 22:19:33 +0900
Message-Id: <4aadcb1779d212e01c89d052926bbc422fd12174.1615293276.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1615293276.git.vilhelm.gray@gmail.com>
References: <cover.1615293276.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signal values will always be levels so let's be explicit it about it to
make the intent of the code clear.

Cc: Syed Nayyar Waris <syednwaris@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
Reviewed-by: David Lechner <david@lechnology.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c            |  5 +++--
 drivers/counter/counter.c               | 12 ++++++------
 drivers/counter/interrupt-cnt.c         |  4 ++--
 drivers/counter/microchip-tcb-capture.c |  4 ++--
 include/linux/counter.h                 | 12 ++++++------
 5 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 0409b1771fd9..fb0f021c0751 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -97,7 +97,8 @@ struct quad8 {
 #define QUAD8_CMR_QUADRATURE_X4 0x18
 
 static int quad8_signal_read(struct counter_device *counter,
-	struct counter_signal *signal, enum counter_signal_value *val)
+			     struct counter_signal *signal,
+			     enum counter_signal_level *level)
 {
 	const struct quad8 *const priv = counter->priv;
 	unsigned int state;
@@ -109,7 +110,7 @@ static int quad8_signal_read(struct counter_device *counter,
 	state = inb(priv->base + QUAD8_REG_INDEX_INPUT_LEVELS)
 		& BIT(signal->id - 16);
 
-	*val = (state) ? COUNTER_SIGNAL_HIGH : COUNTER_SIGNAL_LOW;
+	*level = (state) ? COUNTER_SIGNAL_LEVEL_HIGH : COUNTER_SIGNAL_LEVEL_LOW;
 
 	return 0;
 }
diff --git a/drivers/counter/counter.c b/drivers/counter/counter.c
index 6a683d086008..cb92673552b5 100644
--- a/drivers/counter/counter.c
+++ b/drivers/counter/counter.c
@@ -289,9 +289,9 @@ struct counter_signal_unit {
 	struct counter_signal *signal;
 };
 
-static const char *const counter_signal_value_str[] = {
-	[COUNTER_SIGNAL_LOW] = "low",
-	[COUNTER_SIGNAL_HIGH] = "high"
+static const char *const counter_signal_level_str[] = {
+	[COUNTER_SIGNAL_LEVEL_LOW] = "low",
+	[COUNTER_SIGNAL_LEVEL_HIGH] = "high"
 };
 
 static ssize_t counter_signal_show(struct device *dev,
@@ -302,13 +302,13 @@ static ssize_t counter_signal_show(struct device *dev,
 	const struct counter_signal_unit *const component = devattr->component;
 	struct counter_signal *const signal = component->signal;
 	int err;
-	enum counter_signal_value val;
+	enum counter_signal_level level;
 
-	err = counter->ops->signal_read(counter, signal, &val);
+	err = counter->ops->signal_read(counter, signal, &level);
 	if (err)
 		return err;
 
-	return sprintf(buf, "%s\n", counter_signal_value_str[val]);
+	return sprintf(buf, "%s\n", counter_signal_level_str[level]);
 }
 
 struct counter_name_unit {
diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
index f27dea317965..cce579c1c6ae 100644
--- a/drivers/counter/interrupt-cnt.c
+++ b/drivers/counter/interrupt-cnt.c
@@ -130,7 +130,7 @@ static int interrupt_cnt_function_get(struct counter_device *counter,
 
 static int interrupt_cnt_signal_read(struct counter_device *counter,
 				     struct counter_signal *signal,
-				     enum counter_signal_value *val)
+				     enum counter_signal_level *level)
 {
 	struct interrupt_cnt_priv *priv = counter->priv;
 	int ret;
@@ -142,7 +142,7 @@ static int interrupt_cnt_signal_read(struct counter_device *counter,
 	if (ret < 0)
 		return ret;
 
-	*val = ret ? COUNTER_SIGNAL_HIGH : COUNTER_SIGNAL_LOW;
+	*level = ret ? COUNTER_SIGNAL_LEVEL_HIGH : COUNTER_SIGNAL_LEVEL_LOW;
 
 	return 0;
 }
diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 0c9a61962911..6be3adf74114 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -158,7 +158,7 @@ static int mchp_tc_count_function_set(struct counter_device *counter,
 
 static int mchp_tc_count_signal_read(struct counter_device *counter,
 				     struct counter_signal *signal,
-				     enum counter_signal_value *val)
+				     enum counter_signal_level *lvl)
 {
 	struct mchp_tc_data *const priv = counter->priv;
 	bool sigstatus;
@@ -171,7 +171,7 @@ static int mchp_tc_count_signal_read(struct counter_device *counter,
 	else
 		sigstatus = (sr & ATMEL_TC_MTIOA);
 
-	*val = sigstatus ? COUNTER_SIGNAL_HIGH : COUNTER_SIGNAL_LOW;
+	*lvl = sigstatus ? COUNTER_SIGNAL_LEVEL_HIGH : COUNTER_SIGNAL_LEVEL_LOW;
 
 	return 0;
 }
diff --git a/include/linux/counter.h b/include/linux/counter.h
index 9dbd5df4cd34..79f5dcaf6ba0 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -290,16 +290,16 @@ struct counter_device_state {
 	const struct attribute_group **groups;
 };
 
-enum counter_signal_value {
-	COUNTER_SIGNAL_LOW = 0,
-	COUNTER_SIGNAL_HIGH
+enum counter_signal_level {
+	COUNTER_SIGNAL_LEVEL_LOW,
+	COUNTER_SIGNAL_LEVEL_HIGH,
 };
 
 /**
  * struct counter_ops - Callbacks from driver
  * @signal_read:	optional read callback for Signal attribute. The read
- *			value of the respective Signal should be passed back via
- *			the val parameter.
+ *			level of the respective Signal should be passed back via
+ *			the level parameter.
  * @count_read:		optional read callback for Count attribute. The read
  *			value of the respective Count should be passed back via
  *			the val parameter.
@@ -324,7 +324,7 @@ enum counter_signal_value {
 struct counter_ops {
 	int (*signal_read)(struct counter_device *counter,
 			   struct counter_signal *signal,
-			   enum counter_signal_value *val);
+			   enum counter_signal_level *level);
 	int (*count_read)(struct counter_device *counter,
 			  struct counter_count *count, unsigned long *val);
 	int (*count_write)(struct counter_device *counter,
-- 
2.30.1

