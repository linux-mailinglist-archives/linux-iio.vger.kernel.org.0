Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BDB3A0969
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 03:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbhFIBgj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 21:36:39 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:42757 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236006AbhFIBgi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 21:36:38 -0400
Received: by mail-pl1-f178.google.com with SMTP id v13so11685076ple.9;
        Tue, 08 Jun 2021 18:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OA5u6SJNK+s6oS+KIo8wUe9rkDbx6noCrm5mbnVV26Q=;
        b=t5sxJ1MAHxmqdS803zvW9Bc9ytt4EUQkB/MtGvpZ4GDQklGyUWuxj1/4RO1OxH2UTh
         TT0Zl9zbGRa64y7SHP0FbInNIkKi90lOwMT/2x46LyBqSIv+Q7K8nJ3/2XBhOjxUtbB0
         Qpz/EnHY+qi8m34N5ZJLiW4dh4ar48u705JT+Xrop61bxNLIBYqLorYG1PNmEvO+aC8m
         knENULK78Nr5Hf2Z5ZV8YR9ebsWnsjbFo9EF7ACDDfkXsZSqojqOntg0gdsgUc21Rl1h
         G8UaVAteLegWkiqkjWtffuoS99dc3G+wWHs1IKReFflbb/q07/J9PCAI3UFNgKCIMdNk
         aBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OA5u6SJNK+s6oS+KIo8wUe9rkDbx6noCrm5mbnVV26Q=;
        b=UmzH19E3GatQRI9qLQ9EmUSPIxvrE4cGMXe8VFRrAInYdHpLGjEgI9QkF6LgwZKJ3D
         b/9gxdgcksM44jJPvJmmleyAt8sdrAH+llimLNGbYiyxOVB6q54133mAcTzm7bSfqZf8
         usBKr6+7YCW7ny/s2gs/NbcZshXgvYkUoAw1GeyKboUFN/+Y+sKTNLtqk64BOV4FMR5R
         8zIdbFZLKC64MpqsAnwL2BQVK4JfnpmD6QMey5xnqA2UTySYQJmEsxfiq0pPCmn5sxC+
         kdv6rkNEnbaWQIRA3lWWq1m9QPyPQPSBCEyKhTK2NAld3KIKlf73Ed5o1PK9nCbDwRSH
         OVUA==
X-Gm-Message-State: AOAM5328Js0qe4YYlzduMAxj9dSfDfJiKBVrHjXXLeOzet8HHFV+bgUM
        2WhPLSvks6idSDM7c+PcIDI=
X-Google-Smtp-Source: ABdhPJzOX1QfGFsgNbJdkNatPZQBiutpv1h03G3EVGcDc+K8siHkuOlBJWelslwucoRLQs+gHCwCeQ==
X-Received: by 2002:a17:90b:8d6:: with SMTP id ds22mr29638127pjb.54.1623202412891;
        Tue, 08 Jun 2021 18:33:32 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id v14sm12659815pgl.86.2021.06.08.18.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 18:33:32 -0700 (PDT)
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
Subject: [PATCH v11 20/33] counter: Rename counter_signal_value to counter_signal_level
Date:   Wed,  9 Jun 2021 10:31:23 +0900
Message-Id: <6751025f2f1a9ea87fac9563ecb58eec22bb27a5.1623201081.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623201081.git.vilhelm.gray@gmail.com>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
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
2.32.0

