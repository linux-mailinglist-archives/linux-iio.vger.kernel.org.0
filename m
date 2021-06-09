Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC99B3A094C
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 03:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbhFIBfr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 21:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbhFIBfo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 21:35:44 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E3EC061795;
        Tue,  8 Jun 2021 18:33:38 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mp5-20020a17090b1905b029016dd057935fso423268pjb.5;
        Tue, 08 Jun 2021 18:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=esbImDEzraxhlJjj+D+oz9e9+/+EZ5lRJmu3FQmNfmM=;
        b=W+78e4k30cM33Gr2gEOY3ZqFRScSYfEFhsN1bGQOTxf/3A5rnC7Zhuszk7KlwUN2CI
         1ClrpJOTSc4bMiPKtIQt7bmKNo7kpLMngB9nvI07mg5KROLZBhLn5XKsRd8xYbq/44lX
         KpKP4hUPBndUpBbqzqzfZk8ewY3WQHbY9JbC9al9xeaMFIcBWLOXzwg2w+QAPXvo0LlN
         OGZeCOzdwrGwMybtn6hiM/AAtI3qFPFNqUqzLyUKF77r6hVo9NFk8rl4CPgPU2/MrEzk
         COPUeeTdlPMNDPFB/cCJUeiobOIJIKhORvpVmgf9cEe5fQCTIaCiY3x9ZeQCCVcsXv/+
         0XGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=esbImDEzraxhlJjj+D+oz9e9+/+EZ5lRJmu3FQmNfmM=;
        b=HMLyZYw5JmR9rNZMJkiH07qkBUHAzWnQnYR9/S52zfUV5vlEY9Fc/9XasaNnCt0aAh
         tijE9y6mYW9l9uyVKJ22jsnC0/n4bM1/2mTaxfzO7h5zTHZgEzbyMItZm3LwSjWYGM/Z
         7iDSfx6om7yjKzXQjsQXQRKAzFsBKuBXByApxRM/CZEsYGObm8TPumV7Y7NHl1vM5Rg9
         cMCtypJKFIL/1PtdDY6lde+8qU//ROJMnrUEy8mZrgCzk3ZSLUB1uzk+hRSE2dqS4f2s
         nh5UReVbz9W5Pc6M7feS1Qklz9FSEyeonWThBUJ3KypnAK7WYp3zbweC3j6POMQIQ82o
         gS1g==
X-Gm-Message-State: AOAM531H2gWVDbvn/YqYBtHfn5vOoR2sAEOGJ2cZP75k+U55Guj4MZcm
        8eYYXyihNnhqP6Mtj4TZePo=
X-Google-Smtp-Source: ABdhPJxgFidu3XZco0lPbZetC4VOWQ3qpz0HTVykkobTVBMBx7840JY4PVV4Znkse2+KfLsZz1+b1w==
X-Received: by 2002:a17:90a:ea86:: with SMTP id h6mr8053706pjz.71.1623202418227;
        Tue, 08 Jun 2021 18:33:38 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id v14sm12659815pgl.86.2021.06.08.18.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 18:33:37 -0700 (PDT)
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
Subject: [PATCH v11 21/33] counter: Rename counter_count_function to counter_function
Date:   Wed,  9 Jun 2021 10:31:24 +0900
Message-Id: <01615b23a3b96c9f2fb214ed1df943c7308dab46.1623201082.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623201081.git.vilhelm.gray@gmail.com>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
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
index fb0f021c0751..5a49ace2d4a6 100644
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
index 7b4eb8ff8348..51f16ed1a7a0 100644
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
index cce579c1c6ae..3dbb8acc67eb 100644
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
index 878725c2f010..04be25ebf4a4 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -284,11 +284,11 @@ static struct counter_signal ti_eqep_signals[] = {
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

