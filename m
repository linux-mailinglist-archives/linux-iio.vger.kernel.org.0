Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2173C6DDA
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jul 2021 11:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbhGMJ47 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Jul 2021 05:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbhGMJ46 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Jul 2021 05:56:58 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57062C0613E9;
        Tue, 13 Jul 2021 02:54:07 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g24so11804344pji.4;
        Tue, 13 Jul 2021 02:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oI/jb4FSNRxGimD7smahqlBTafXVAVl5TCLVppcZnms=;
        b=PPAjdNqKd3Wqj6ZRv0/NuOWWNVuJ5/95jjyR8dtAr9Hj6NmLoFLJbl5w2yZfx87Ewb
         HAnbcT3OK0mU/GRNF0DUrEzMQoJTQMcVJB7fVGB/2zBWe05XHfCy0s9TMm49LDrapNhF
         RCDRQQxpWReqNVyhWBrH2ykukEKC9BTHPV8uGwZDIqcI/tnPsfn0RFH5uiRScUeW+e1v
         kOtoTaz4kp9JV6WVQW+Yzav3HlWU7bAH7SR3bikp8eo9RZ+e2CQb+u9PiSCmoUDxdPPB
         HLvezkk4TGsI74O9gEbzmWYIqCUt5xY7kHEHqc/4fZ+TFzeC+Gnn8i0neEWRmYWTP3pi
         g+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oI/jb4FSNRxGimD7smahqlBTafXVAVl5TCLVppcZnms=;
        b=EUCUkaiHYJVnFBU9+8A5717ug5Y8F/KExVJ2t6n3lBYawx4mVnLXow2No0qZZymlW+
         EkaKhqV8DZNzEp/E4AdePXVUzGXVZ/VNkWQykZPv6SbU4osdSYSGO7/y/AkkEDlxEDAf
         DMn6AxKJS/xu6TGvAjdo60DkDxV13fybUIWpeZoNIktg6ZrQvsfWX1nQxN634u+m+H/D
         Q8Oeg0aYRtd2xMywBvjbUG7j5dw09MoqYdVuol68JkeM4zIHV7Nor5Tnv1OHtItM9V3o
         fdR0Y2C4Xsg+6IqueqWe4LUyX1XG9YUUU8WZsXw0xyiHaGKozOHAqU1ZxX0G2PoIXDBs
         cKVg==
X-Gm-Message-State: AOAM532gv9yASOiqClOHYQphAQMDylb/UvAzp/rGiPCzXiKmQHM3JSzP
        FLFHW/rTCwaUL3ifTTXcXjk=
X-Google-Smtp-Source: ABdhPJxKB9Zj9Rnj4TnlbX5ttAhI5YiAcyBp/ut92mM2jHkwrLchAhz1NgL5YMTWsZaBToCbeICw/g==
X-Received: by 2002:a17:90b:224f:: with SMTP id hk15mr2752739pjb.180.1626170046943;
        Tue, 13 Jul 2021 02:54:06 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id f6sm18153854pfj.28.2021.07.13.02.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 02:54:06 -0700 (PDT)
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
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH v13 05/17] counter: Rename counter_count_function to counter_function
Date:   Tue, 13 Jul 2021 18:53:09 +0900
Message-Id: <299778e04778847ecbff60f7860e557bdbf647d7.1626165765.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1626165764.git.vilhelm.gray@gmail.com>
References: <cover.1626165764.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The phrase "Counter Count function" is verbose and unintentionally
implies that function is a Count extension. This patch adjusts the
Counter subsystem code to use the more direct "Counter function" phrase
to make the intent of this code clearer.

Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Patrick Havelange <patrick.havelange@essensium.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: David Lechner <david@lechnology.com>
Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c            | 10 +++----
 drivers/counter/counter.c               | 38 ++++++++++++-------------
 drivers/counter/ftm-quaddec.c           |  5 ++--
 drivers/counter/intel-qep.c             |  4 +--
 drivers/counter/interrupt-cnt.c         |  4 +--
 drivers/counter/microchip-tcb-capture.c |  4 +--
 drivers/counter/stm32-lptimer-cnt.c     |  6 ++--
 drivers/counter/stm32-timer-cnt.c       | 10 +++----
 drivers/counter/ti-eqep.c               | 10 +++----
 include/linux/counter.h                 | 20 ++++++-------
 10 files changed, 55 insertions(+), 56 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index b4dd07cf51eb..5283ff128c17 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -194,11 +194,11 @@ enum quad8_count_function {
 	QUAD8_COUNT_FUNCTION_QUADRATURE_X4
 };
 
-static const enum counter_count_function quad8_count_functions_list[] = {
-	[QUAD8_COUNT_FUNCTION_PULSE_DIRECTION] = COUNTER_COUNT_FUNCTION_PULSE_DIRECTION,
-	[QUAD8_COUNT_FUNCTION_QUADRATURE_X1] = COUNTER_COUNT_FUNCTION_QUADRATURE_X1_A,
-	[QUAD8_COUNT_FUNCTION_QUADRATURE_X2] = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,
-	[QUAD8_COUNT_FUNCTION_QUADRATURE_X4] = COUNTER_COUNT_FUNCTION_QUADRATURE_X4
+static const enum counter_function quad8_count_functions_list[] = {
+	[QUAD8_COUNT_FUNCTION_PULSE_DIRECTION] = COUNTER_FUNCTION_PULSE_DIRECTION,
+	[QUAD8_COUNT_FUNCTION_QUADRATURE_X1] = COUNTER_FUNCTION_QUADRATURE_X1_A,
+	[QUAD8_COUNT_FUNCTION_QUADRATURE_X2] = COUNTER_FUNCTION_QUADRATURE_X2_A,
+	[QUAD8_COUNT_FUNCTION_QUADRATURE_X4] = COUNTER_FUNCTION_QUADRATURE_X4
 };
 
 static int quad8_function_get(struct counter_device *counter,
diff --git a/drivers/counter/counter.c b/drivers/counter/counter.c
index cb92673552b5..de921e8a3f72 100644
--- a/drivers/counter/counter.c
+++ b/drivers/counter/counter.c
@@ -744,15 +744,15 @@ static ssize_t counter_count_store(struct device *dev,
 	return len;
 }
 
-static const char *const counter_count_function_str[] = {
-	[COUNTER_COUNT_FUNCTION_INCREASE] = "increase",
-	[COUNTER_COUNT_FUNCTION_DECREASE] = "decrease",
-	[COUNTER_COUNT_FUNCTION_PULSE_DIRECTION] = "pulse-direction",
-	[COUNTER_COUNT_FUNCTION_QUADRATURE_X1_A] = "quadrature x1 a",
-	[COUNTER_COUNT_FUNCTION_QUADRATURE_X1_B] = "quadrature x1 b",
-	[COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A] = "quadrature x2 a",
-	[COUNTER_COUNT_FUNCTION_QUADRATURE_X2_B] = "quadrature x2 b",
-	[COUNTER_COUNT_FUNCTION_QUADRATURE_X4] = "quadrature x4"
+static const char *const counter_function_str[] = {
+	[COUNTER_FUNCTION_INCREASE] = "increase",
+	[COUNTER_FUNCTION_DECREASE] = "decrease",
+	[COUNTER_FUNCTION_PULSE_DIRECTION] = "pulse-direction",
+	[COUNTER_FUNCTION_QUADRATURE_X1_A] = "quadrature x1 a",
+	[COUNTER_FUNCTION_QUADRATURE_X1_B] = "quadrature x1 b",
+	[COUNTER_FUNCTION_QUADRATURE_X2_A] = "quadrature x2 a",
+	[COUNTER_FUNCTION_QUADRATURE_X2_B] = "quadrature x2 b",
+	[COUNTER_FUNCTION_QUADRATURE_X4] = "quadrature x4"
 };
 
 static ssize_t counter_function_show(struct device *dev,
@@ -764,7 +764,7 @@ static ssize_t counter_function_show(struct device *dev,
 	const struct counter_count_unit *const component = devattr->component;
 	struct counter_count *const count = component->count;
 	size_t func_index;
-	enum counter_count_function function;
+	enum counter_function function;
 
 	err = counter->ops->function_get(counter, count, &func_index);
 	if (err)
@@ -773,7 +773,7 @@ static ssize_t counter_function_show(struct device *dev,
 	count->function = func_index;
 
 	function = count->functions_list[func_index];
-	return sprintf(buf, "%s\n", counter_count_function_str[function]);
+	return sprintf(buf, "%s\n", counter_function_str[function]);
 }
 
 static ssize_t counter_function_store(struct device *dev,
@@ -785,14 +785,14 @@ static ssize_t counter_function_store(struct device *dev,
 	struct counter_count *const count = component->count;
 	const size_t num_functions = count->num_functions;
 	size_t func_index;
-	enum counter_count_function function;
+	enum counter_function function;
 	int err;
 	struct counter_device *const counter = dev_get_drvdata(dev);
 
 	/* Find requested Count function mode */
 	for (func_index = 0; func_index < num_functions; func_index++) {
 		function = count->functions_list[func_index];
-		if (sysfs_streq(buf, counter_count_function_str[function]))
+		if (sysfs_streq(buf, counter_function_str[function]))
 			break;
 	}
 	/* Return error if requested Count function mode not found */
@@ -880,25 +880,25 @@ static int counter_count_ext_register(
 }
 
 struct counter_func_avail_unit {
-	const enum counter_count_function *functions_list;
+	const enum counter_function *functions_list;
 	size_t num_functions;
 };
 
-static ssize_t counter_count_function_available_show(struct device *dev,
+static ssize_t counter_function_available_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	const struct counter_device_attr *const devattr = to_counter_attr(attr);
 	const struct counter_func_avail_unit *const component = devattr->component;
-	const enum counter_count_function *const func_list = component->functions_list;
+	const enum counter_function *const func_list = component->functions_list;
 	const size_t num_functions = component->num_functions;
 	size_t i;
-	enum counter_count_function function;
+	enum counter_function function;
 	ssize_t len = 0;
 
 	for (i = 0; i < num_functions; i++) {
 		function = func_list[i];
 		len += sprintf(buf + len, "%s\n",
-			       counter_count_function_str[function]);
+			       counter_function_str[function]);
 	}
 
 	return len;
@@ -968,7 +968,7 @@ static int counter_count_attributes_create(
 	parm.group = group;
 	parm.prefix = "";
 	parm.name = "function_available";
-	parm.show = counter_count_function_available_show;
+	parm.show = counter_function_available_show;
 	parm.store = NULL;
 	parm.component = avail_comp;
 	err = counter_attribute_create(&parm);
diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
index 9371532406ca..53c15f84909b 100644
--- a/drivers/counter/ftm-quaddec.c
+++ b/drivers/counter/ftm-quaddec.c
@@ -171,9 +171,8 @@ enum ftm_quaddec_count_function {
 	FTM_QUADDEC_COUNT_ENCODER_MODE_1,
 };
 
-static const enum counter_count_function ftm_quaddec_count_functions[] = {
-	[FTM_QUADDEC_COUNT_ENCODER_MODE_1] =
-	COUNTER_COUNT_FUNCTION_QUADRATURE_X4
+static const enum counter_function ftm_quaddec_count_functions[] = {
+	[FTM_QUADDEC_COUNT_ENCODER_MODE_1] = COUNTER_FUNCTION_QUADRATURE_X4
 };
 
 static int ftm_quaddec_count_read(struct counter_device *counter,
diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
index 85dd328ae1f6..f4be9d78c84c 100644
--- a/drivers/counter/intel-qep.c
+++ b/drivers/counter/intel-qep.c
@@ -127,8 +127,8 @@ static int intel_qep_count_read(struct counter_device *counter,
 	return 0;
 }
 
-static const enum counter_count_function intel_qep_count_functions[] = {
-	COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
+static const enum counter_function intel_qep_count_functions[] = {
+	COUNTER_FUNCTION_QUADRATURE_X4,
 };
 
 static int intel_qep_function_get(struct counter_device *counter,
diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
index d06367bef8f0..1de4243db488 100644
--- a/drivers/counter/interrupt-cnt.c
+++ b/drivers/counter/interrupt-cnt.c
@@ -115,8 +115,8 @@ static int interrupt_cnt_write(struct counter_device *counter,
 	return 0;
 }
 
-static const enum counter_count_function interrupt_cnt_functions[] = {
-	COUNTER_COUNT_FUNCTION_INCREASE,
+static const enum counter_function interrupt_cnt_functions[] = {
+	COUNTER_FUNCTION_INCREASE,
 };
 
 static int interrupt_cnt_function_get(struct counter_device *counter,
diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 6be3adf74114..4c57d43e7d66 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -38,8 +38,8 @@ enum mchp_tc_count_function {
 };
 
 static const enum counter_count_function mchp_tc_count_functions[] = {
-	[MCHP_TC_FUNCTION_INCREASE] = COUNTER_COUNT_FUNCTION_INCREASE,
-	[MCHP_TC_FUNCTION_QUADRATURE] = COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
+	[MCHP_TC_FUNCTION_INCREASE] = COUNTER_FUNCTION_INCREASE,
+	[MCHP_TC_FUNCTION_QUADRATURE] = COUNTER_FUNCTION_QUADRATURE_X4,
 };
 
 enum mchp_tc_synapse_action {
diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
index 49aeb9e393f3..13656957c45f 100644
--- a/drivers/counter/stm32-lptimer-cnt.c
+++ b/drivers/counter/stm32-lptimer-cnt.c
@@ -134,9 +134,9 @@ enum stm32_lptim_cnt_function {
 	STM32_LPTIM_ENCODER_BOTH_EDGE,
 };
 
-static const enum counter_count_function stm32_lptim_cnt_functions[] = {
-	[STM32_LPTIM_COUNTER_INCREASE] = COUNTER_COUNT_FUNCTION_INCREASE,
-	[STM32_LPTIM_ENCODER_BOTH_EDGE] = COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
+static const enum counter_function stm32_lptim_cnt_functions[] = {
+	[STM32_LPTIM_COUNTER_INCREASE] = COUNTER_FUNCTION_INCREASE,
+	[STM32_LPTIM_ENCODER_BOTH_EDGE] = COUNTER_FUNCTION_QUADRATURE_X4,
 };
 
 enum stm32_lptim_synapse_action {
diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 603b30ada839..3fb0debd7425 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -50,11 +50,11 @@ enum stm32_count_function {
 	STM32_COUNT_ENCODER_MODE_3,
 };
 
-static const enum counter_count_function stm32_count_functions[] = {
-	[STM32_COUNT_SLAVE_MODE_DISABLED] = COUNTER_COUNT_FUNCTION_INCREASE,
-	[STM32_COUNT_ENCODER_MODE_1] = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,
-	[STM32_COUNT_ENCODER_MODE_2] = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_B,
-	[STM32_COUNT_ENCODER_MODE_3] = COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
+static const enum counter_function stm32_count_functions[] = {
+	[STM32_COUNT_SLAVE_MODE_DISABLED] = COUNTER_FUNCTION_INCREASE,
+	[STM32_COUNT_ENCODER_MODE_1] = COUNTER_FUNCTION_QUADRATURE_X2_A,
+	[STM32_COUNT_ENCODER_MODE_2] = COUNTER_FUNCTION_QUADRATURE_X2_B,
+	[STM32_COUNT_ENCODER_MODE_3] = COUNTER_FUNCTION_QUADRATURE_X4,
 };
 
 static int stm32_count_read(struct counter_device *counter,
diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index c303eb17c111..94fe58bb3eab 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -294,11 +294,11 @@ static struct counter_signal ti_eqep_signals[] = {
 	},
 };
 
-static const enum counter_count_function ti_eqep_position_functions[] = {
-	[TI_EQEP_COUNT_FUNC_QUAD_COUNT]	= COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
-	[TI_EQEP_COUNT_FUNC_DIR_COUNT]	= COUNTER_COUNT_FUNCTION_PULSE_DIRECTION,
-	[TI_EQEP_COUNT_FUNC_UP_COUNT]	= COUNTER_COUNT_FUNCTION_INCREASE,
-	[TI_EQEP_COUNT_FUNC_DOWN_COUNT]	= COUNTER_COUNT_FUNCTION_DECREASE,
+static const enum counter_function ti_eqep_position_functions[] = {
+	[TI_EQEP_COUNT_FUNC_QUAD_COUNT]	= COUNTER_FUNCTION_QUADRATURE_X4,
+	[TI_EQEP_COUNT_FUNC_DIR_COUNT]	= COUNTER_FUNCTION_PULSE_DIRECTION,
+	[TI_EQEP_COUNT_FUNC_UP_COUNT]	= COUNTER_FUNCTION_INCREASE,
+	[TI_EQEP_COUNT_FUNC_DOWN_COUNT]	= COUNTER_FUNCTION_DECREASE,
 };
 
 static const enum counter_synapse_action ti_eqep_position_synapse_actions[] = {
diff --git a/include/linux/counter.h b/include/linux/counter.h
index 79f5dcaf6ba0..d16ce2819b48 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -162,15 +162,15 @@ struct counter_count_ext {
 	void *priv;
 };
 
-enum counter_count_function {
-	COUNTER_COUNT_FUNCTION_INCREASE = 0,
-	COUNTER_COUNT_FUNCTION_DECREASE,
-	COUNTER_COUNT_FUNCTION_PULSE_DIRECTION,
-	COUNTER_COUNT_FUNCTION_QUADRATURE_X1_A,
-	COUNTER_COUNT_FUNCTION_QUADRATURE_X1_B,
-	COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,
-	COUNTER_COUNT_FUNCTION_QUADRATURE_X2_B,
-	COUNTER_COUNT_FUNCTION_QUADRATURE_X4
+enum counter_function {
+	COUNTER_FUNCTION_INCREASE = 0,
+	COUNTER_FUNCTION_DECREASE,
+	COUNTER_FUNCTION_PULSE_DIRECTION,
+	COUNTER_FUNCTION_QUADRATURE_X1_A,
+	COUNTER_FUNCTION_QUADRATURE_X1_B,
+	COUNTER_FUNCTION_QUADRATURE_X2_A,
+	COUNTER_FUNCTION_QUADRATURE_X2_B,
+	COUNTER_FUNCTION_QUADRATURE_X4
 };
 
 /**
@@ -192,7 +192,7 @@ struct counter_count {
 	const char *name;
 
 	size_t function;
-	const enum counter_count_function *functions_list;
+	const enum counter_function *functions_list;
 	size_t num_functions;
 
 	struct counter_synapse *synapses;
-- 
2.32.0

