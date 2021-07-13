Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D163C6DD5
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jul 2021 11:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbhGMJ4w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Jul 2021 05:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbhGMJ4w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Jul 2021 05:56:52 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC67C0613DD;
        Tue, 13 Jul 2021 02:54:02 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id x16so9942065plg.3;
        Tue, 13 Jul 2021 02:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TLjqZWQe/YbRhTdSUAIfqvZl6++obXP7V1QPjhbJF6E=;
        b=VqjJteYY8PoahZaBoBlIUVVt0XCm51hCLujotcxdwFiu2ExSbNMXmRCGzZ18Ukgw0Y
         7DR3UE4PdLgvYIaieTAMrA4mWtuitbne6Gbf/+hmBlzFgag2/SiIWY4iDelm4iyi6o2A
         4w+n16bhE3cd2L4wqHKdL++SDkuFNwWfHBO8ZXieVstWxrlydixfp/uqif2BlXrmdB66
         VqFJ/ezO95TjRnwQcjBeJWCrbX/5EXGVIiX/E7Uq1bQYU2gtFRy5b3i4z6CaMJOnTkFJ
         nYQAAwNH6phSi9taU8acMom3+hSEJ0i6Axghs8V6KTYR98EmKx6HW6cNTaqgMI5aRaeS
         XzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TLjqZWQe/YbRhTdSUAIfqvZl6++obXP7V1QPjhbJF6E=;
        b=ISTOFEeWDr8z8kEJaJE5Dj/pZSGx0c7vtAaMujY877TJ6WO+LzmrkksW0+4jGajqxg
         GDiDbZhPE987uY6OSJ26+PiFYVO9IgHgSUU0PCqom+c/R/jDlgmOweb6JN5f9Z787jaf
         SbYoNu2px3BYzL5DREFIxS5seXkpcSX9R6PuRRuP/E2JgWFTNUCq34BKCN5c1OFLX+WI
         /TGM5XwSKQHQPQwrU0mNxAi/G3jh4aPrTslsV5/LAtTNgTpxvZgICkH5G/3ERcHcrrv6
         XlInXYjQTcm9niydDw+7iHFmGuwDtHRj690lIU7W1K8z2LPCt7w7cM6NnpUiPbRgB+a/
         C1kw==
X-Gm-Message-State: AOAM533kHtu4g2r3PyMvple7m/5QcliRwJUbp0MMy3rlpX85NQkcdXTq
        tonsGyE2VvuXmbdG2KrX7rU=
X-Google-Smtp-Source: ABdhPJyrXwfRe1Jh95BJAOgbRZZE085qakigviNpPQeln+Y1QZw2odVZV+cDwggTCel8D7saHj3eMw==
X-Received: by 2002:a17:90a:6d89:: with SMTP id a9mr18674672pjk.194.1626170041559;
        Tue, 13 Jul 2021 02:54:01 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id f6sm18153854pfj.28.2021.07.13.02.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 02:54:01 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v13 04/17] counter: Rename counter_signal_value to counter_signal_level
Date:   Tue, 13 Jul 2021 18:53:08 +0900
Message-Id: <30461f10525acfa9070f31c45dbb2c7e62bfb32e.1626165765.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1626165764.git.vilhelm.gray@gmail.com>
References: <cover.1626165764.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signal values will always be levels so let's be explicit it about it to
make the intent of the code clear.

Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
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
index d54efdb8d393..b4dd07cf51eb 100644
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
index 66cac4900327..d06367bef8f0 100644
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
2.32.0

