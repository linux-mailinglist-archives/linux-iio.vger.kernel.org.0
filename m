Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3C8319E24
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 13:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhBLMQL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 07:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhBLMP5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2021 07:15:57 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F4AC061794;
        Fri, 12 Feb 2021 04:15:10 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id x3so6490570qti.5;
        Fri, 12 Feb 2021 04:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lNdgRpmFy7PFYtzYfdP9BDKwZ163iKun0eVwG4jGtRI=;
        b=WNrL2DxZnBKnlNiRfjrfWoPb6xmeIlBmrIiSZcZWjF+vHIaWpZZbl9bE+kNGDXRtDa
         n1plFqjS2C7VBFcTD9++OgmXtjiIbChPhqLDTOHEGdSXnlNpT+NFI4UgJK4na1UgAECv
         Vf60P3ryr0EE/SwO9ju0iyn5dX/tAt9q4HE8iGfAy7z1GLIbj5Ky+2s+i2ObDb8UOo+e
         1kZUshJW/dZZxWHUE2QDTZUDKe1X3DU2570V2RMWNTj2dYUTB0DXdd8bG3QNy2G2VNwC
         9XqnBpC18/CAaJghMOqn1zLn4ldyAowCkR0Wz5byz+F6y/BRQhV7uY1tCy17ANDqiKtk
         nN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lNdgRpmFy7PFYtzYfdP9BDKwZ163iKun0eVwG4jGtRI=;
        b=nfwrxdzDgNp3QqVkcV4G5QlZftFSzoPh1Rcp1OLxbXFY6EPyU/hJWQF/HELEJetT9r
         Ut7JyIQ5JKOEGXz1TqtVayMsuTExXrdtgNjCcUtzosnx5QoBid2uipp01N9YCr4ETK5N
         flJ0c6qQuqsHZow4xlqR39zN9Gs6uiJ5xE0QFemGNMlKcYi7v8SkcC0ngCjQrOBZzVoI
         atg3h6314zw54UEn8GA5RYbrl8NNwoGXO8O/Pbj2dQ61HOQ8D38ar7AykPZrnUOoM7Eo
         c+nUbuS6t786QEl3BqdHnbsAxuf+W5pWJH8GAFHQOIJy6blJtBW2tnAHpO8abvyZ9ozV
         cDLQ==
X-Gm-Message-State: AOAM533SroUQ5fvcds79Rju8iSvhRKYIE9yRovLGjQBYKWbbLJjz3VUZ
        yqPWWDpbzVxYcwnJ4a1GyPc=
X-Google-Smtp-Source: ABdhPJwHIyFWFI8QHgnM52dmOXT595TjhGsWSBKJy5jvFJxADlU+ZScXQCrn5QULOyLpHH2etuRKVQ==
X-Received: by 2002:ac8:7417:: with SMTP id p23mr2011017qtq.319.1613132109964;
        Fri, 12 Feb 2021 04:15:09 -0800 (PST)
Received: from localhost.localdomain ([193.27.12.132])
        by smtp.gmail.com with ESMTPSA id y135sm6278534qkb.14.2021.02.12.04.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 04:15:09 -0800 (PST)
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
Subject: [PATCH v8 12/22] counter: Rename counter_count_function to counter_function
Date:   Fri, 12 Feb 2021 21:13:36 +0900
Message-Id: <355aaaaf44b36c5de1704e4074a4671abcb9699d.1613131238.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1613131238.git.vilhelm.gray@gmail.com>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The phrase "Counter Count function" is verbose and unintentionally
implies that function is a Count extension. This patch adjusts the
Counter subsystem code to use the more direct "Counter function" phrase
to make the intent of this code clearer. The phrase "Count action" is
adjusted herein as well for the same reason.

Cc: Syed Nayyar Waris <syednwaris@gmail.com>
Cc: Patrick Havelange <patrick.havelange@essensium.com>
Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: David Lechner <david@lechnology.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c            | 62 +++++++++++-----------
 drivers/counter/counter.c               | 38 +++++++-------
 drivers/counter/ftm-quaddec.c           | 23 ++++-----
 drivers/counter/microchip-tcb-capture.c | 44 ++++++++--------
 drivers/counter/stm32-lptimer-cnt.c     | 56 ++++++++++----------
 drivers/counter/stm32-timer-cnt.c       | 68 ++++++++++++-------------
 drivers/counter/ti-eqep.c               | 28 +++++-----
 include/linux/counter.h                 | 20 ++++----
 8 files changed, 166 insertions(+), 173 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index ead0eeb6c846..eca3f6482719 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -187,18 +187,18 @@ static int quad8_count_write(struct counter_device *counter,
 	return 0;
 }
 
-enum quad8_count_function {
-	QUAD8_COUNT_FUNCTION_PULSE_DIRECTION = 0,
-	QUAD8_COUNT_FUNCTION_QUADRATURE_X1,
-	QUAD8_COUNT_FUNCTION_QUADRATURE_X2,
-	QUAD8_COUNT_FUNCTION_QUADRATURE_X4
+enum quad8_function {
+	QUAD8_FUNCTION_PULSE_DIRECTION = 0,
+	QUAD8_FUNCTION_QUADRATURE_X1,
+	QUAD8_FUNCTION_QUADRATURE_X2,
+	QUAD8_FUNCTION_QUADRATURE_X4
 };
 
-static const enum counter_count_function quad8_functions_list[] = {
-	[QUAD8_COUNT_FUNCTION_PULSE_DIRECTION] = COUNTER_COUNT_FUNCTION_PULSE_DIRECTION,
-	[QUAD8_COUNT_FUNCTION_QUADRATURE_X1] = COUNTER_COUNT_FUNCTION_QUADRATURE_X1_A,
-	[QUAD8_COUNT_FUNCTION_QUADRATURE_X2] = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,
-	[QUAD8_COUNT_FUNCTION_QUADRATURE_X4] = COUNTER_COUNT_FUNCTION_QUADRATURE_X4
+static const enum counter_function quad8_functions_list[] = {
+	[QUAD8_FUNCTION_PULSE_DIRECTION] = COUNTER_FUNCTION_PULSE_DIRECTION,
+	[QUAD8_FUNCTION_QUADRATURE_X1] = COUNTER_FUNCTION_QUADRATURE_X1_A,
+	[QUAD8_FUNCTION_QUADRATURE_X2] = COUNTER_FUNCTION_QUADRATURE_X2_A,
+	[QUAD8_FUNCTION_QUADRATURE_X4] = COUNTER_FUNCTION_QUADRATURE_X4
 };
 
 static int quad8_function_get(struct counter_device *counter,
@@ -212,17 +212,17 @@ static int quad8_function_get(struct counter_device *counter,
 	if (priv->quadrature_mode[id])
 		switch (priv->quadrature_scale[id]) {
 		case 0:
-			*function = QUAD8_COUNT_FUNCTION_QUADRATURE_X1;
+			*function = QUAD8_FUNCTION_QUADRATURE_X1;
 			break;
 		case 1:
-			*function = QUAD8_COUNT_FUNCTION_QUADRATURE_X2;
+			*function = QUAD8_FUNCTION_QUADRATURE_X2;
 			break;
 		case 2:
-			*function = QUAD8_COUNT_FUNCTION_QUADRATURE_X4;
+			*function = QUAD8_FUNCTION_QUADRATURE_X4;
 			break;
 		}
 	else
-		*function = QUAD8_COUNT_FUNCTION_PULSE_DIRECTION;
+		*function = QUAD8_FUNCTION_PULSE_DIRECTION;
 
 	mutex_unlock(&priv->lock);
 
@@ -246,7 +246,7 @@ static int quad8_function_set(struct counter_device *counter,
 	mode_cfg = priv->count_mode[id] << 1;
 	idr_cfg = priv->index_polarity[id] << 1;
 
-	if (function == QUAD8_COUNT_FUNCTION_PULSE_DIRECTION) {
+	if (function == QUAD8_FUNCTION_PULSE_DIRECTION) {
 		*quadrature_mode = 0;
 
 		/* Quadrature scaling only available in quadrature mode */
@@ -262,15 +262,15 @@ static int quad8_function_set(struct counter_device *counter,
 		*quadrature_mode = 1;
 
 		switch (function) {
-		case QUAD8_COUNT_FUNCTION_QUADRATURE_X1:
+		case QUAD8_FUNCTION_QUADRATURE_X1:
 			*scale = 0;
 			mode_cfg |= QUAD8_CMR_QUADRATURE_X1;
 			break;
-		case QUAD8_COUNT_FUNCTION_QUADRATURE_X2:
+		case QUAD8_FUNCTION_QUADRATURE_X2:
 			*scale = 1;
 			mode_cfg |= QUAD8_CMR_QUADRATURE_X2;
 			break;
-		case QUAD8_COUNT_FUNCTION_QUADRATURE_X4:
+		case QUAD8_FUNCTION_QUADRATURE_X4:
 			*scale = 2;
 			mode_cfg |= QUAD8_CMR_QUADRATURE_X4;
 			break;
@@ -351,11 +351,11 @@ static int quad8_action_get(struct counter_device *counter,
 
 	/* Determine action mode based on current count function mode */
 	switch (function) {
-	case QUAD8_COUNT_FUNCTION_PULSE_DIRECTION:
+	case QUAD8_FUNCTION_PULSE_DIRECTION:
 		if (synapse->signal->id == signal_a_id)
 			*action = QUAD8_SYNAPSE_ACTION_RISING_EDGE;
 		break;
-	case QUAD8_COUNT_FUNCTION_QUADRATURE_X1:
+	case QUAD8_FUNCTION_QUADRATURE_X1:
 		if (synapse->signal->id == signal_a_id) {
 			quad8_direction_get(counter, count, &direction);
 
@@ -365,11 +365,11 @@ static int quad8_action_get(struct counter_device *counter,
 				*action = QUAD8_SYNAPSE_ACTION_FALLING_EDGE;
 		}
 		break;
-	case QUAD8_COUNT_FUNCTION_QUADRATURE_X2:
+	case QUAD8_FUNCTION_QUADRATURE_X2:
 		if (synapse->signal->id == signal_a_id)
 			*action = QUAD8_SYNAPSE_ACTION_BOTH_EDGES;
 		break;
-	case QUAD8_COUNT_FUNCTION_QUADRATURE_X4:
+	case QUAD8_FUNCTION_QUADRATURE_X4:
 		*action = QUAD8_SYNAPSE_ACTION_BOTH_EDGES;
 		break;
 	default:
@@ -1010,15 +1010,15 @@ static const struct counter_count_ext quad8_count_ext[] = {
 	}
 };
 
-#define QUAD8_COUNT(_id, _cntname) {					\
-	.id = (_id),							\
-	.name = (_cntname),						\
-	.functions_list = quad8_count_functions_list,			\
-	.num_functions = ARRAY_SIZE(quad8_count_functions_list),	\
-	.synapses = quad8_count_synapses[(_id)],			\
-	.num_synapses =	2,						\
-	.ext = quad8_count_ext,						\
-	.num_ext = ARRAY_SIZE(quad8_count_ext)				\
+#define QUAD8_COUNT(_id, _cntname) {				\
+	.id = (_id),						\
+	.name = (_cntname),					\
+	.functions_list = quad8_functions_list,			\
+	.num_functions = ARRAY_SIZE(quad8_functions_list),	\
+	.synapses = quad8_count_synapses[(_id)],		\
+	.num_synapses =	2,					\
+	.ext = quad8_count_ext,					\
+	.num_ext = ARRAY_SIZE(quad8_count_ext)			\
 }
 
 static struct counter_count quad8_counts[] = {
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
index 9371532406ca..97599061ca31 100644
--- a/drivers/counter/ftm-quaddec.c
+++ b/drivers/counter/ftm-quaddec.c
@@ -167,13 +167,12 @@ static const enum counter_synapse_action ftm_quaddec_synapse_actions[] = {
 	COUNTER_SYNAPSE_ACTION_BOTH_EDGES
 };
 
-enum ftm_quaddec_count_function {
-	FTM_QUADDEC_COUNT_ENCODER_MODE_1,
+enum ftm_quaddec_function {
+	FTM_QUADDEC_ENCODER_MODE_1,
 };
 
-static const enum counter_count_function ftm_quaddec_count_functions[] = {
-	[FTM_QUADDEC_COUNT_ENCODER_MODE_1] =
-	COUNTER_COUNT_FUNCTION_QUADRATURE_X4
+static const enum counter_function ftm_quaddec_functions[] = {
+	[FTM_QUADDEC_ENCODER_MODE_1] = COUNTER_FUNCTION_QUADRATURE_X4
 };
 
 static int ftm_quaddec_count_read(struct counter_device *counter,
@@ -206,11 +205,11 @@ static int ftm_quaddec_count_write(struct counter_device *counter,
 	return 0;
 }
 
-static int ftm_quaddec_count_function_get(struct counter_device *counter,
-					  struct counter_count *count,
-					  size_t *function)
+static int ftm_quaddec_function_get(struct counter_device *counter,
+				    struct counter_count *count,
+				    size_t *function)
 {
-	*function = FTM_QUADDEC_COUNT_ENCODER_MODE_1;
+	*function = FTM_QUADDEC_ENCODER_MODE_1;
 
 	return 0;
 }
@@ -228,7 +227,7 @@ static int ftm_quaddec_action_get(struct counter_device *counter,
 static const struct counter_ops ftm_quaddec_cnt_ops = {
 	.count_read = ftm_quaddec_count_read,
 	.count_write = ftm_quaddec_count_write,
-	.function_get = ftm_quaddec_count_function_get,
+	.function_get = ftm_quaddec_function_get,
 	.action_get = ftm_quaddec_action_get,
 };
 
@@ -264,8 +263,8 @@ static const struct counter_count_ext ftm_quaddec_count_ext[] = {
 static struct counter_count ftm_quaddec_counts = {
 	.id = 0,
 	.name = "Channel 1 Count",
-	.functions_list = ftm_quaddec_count_functions,
-	.num_functions = ARRAY_SIZE(ftm_quaddec_count_functions),
+	.functions_list = ftm_quaddec_functions,
+	.num_functions = ARRAY_SIZE(ftm_quaddec_functions),
 	.synapses = ftm_quaddec_count_synapses,
 	.num_synapses = ARRAY_SIZE(ftm_quaddec_count_synapses),
 	.ext = ftm_quaddec_count_ext,
diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index f56c4e328018..d4cfaffe9499 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -32,14 +32,14 @@ struct mchp_tc_data {
 	bool trig_inverted;
 };
 
-enum mchp_tc_count_function {
+enum mchp_tc_function {
 	MCHP_TC_FUNCTION_INCREASE,
 	MCHP_TC_FUNCTION_QUADRATURE,
 };
 
-static enum counter_count_function mchp_tc_count_functions[] = {
-	[MCHP_TC_FUNCTION_INCREASE] = COUNTER_COUNT_FUNCTION_INCREASE,
-	[MCHP_TC_FUNCTION_QUADRATURE] = COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
+static enum counter_function mchp_tc_functions[] = {
+	[MCHP_TC_FUNCTION_INCREASE] = COUNTER_FUNCTION_INCREASE,
+	[MCHP_TC_FUNCTION_QUADRATURE] = COUNTER_FUNCTION_QUADRATURE_X4,
 };
 
 enum mchp_tc_synapse_action {
@@ -80,9 +80,8 @@ static struct counter_synapse mchp_tc_count_synapses[] = {
 	}
 };
 
-static int mchp_tc_count_function_get(struct counter_device *counter,
-				      struct counter_count *count,
-				      size_t *function)
+static int mchp_tc_function_get(struct counter_device *counter,
+				struct counter_count *count, size_t *function)
 {
 	struct mchp_tc_data *const priv = counter->priv;
 
@@ -94,9 +93,8 @@ static int mchp_tc_count_function_get(struct counter_device *counter,
 	return 0;
 }
 
-static int mchp_tc_count_function_set(struct counter_device *counter,
-				      struct counter_count *count,
-				      size_t function)
+static int mchp_tc_function_set(struct counter_device *counter,
+				struct counter_count *count, size_t function)
 {
 	struct mchp_tc_data *const priv = counter->priv;
 	u32 bmr, cmr;
@@ -176,10 +174,9 @@ static int mchp_tc_count_signal_read(struct counter_device *counter,
 	return 0;
 }
 
-static int mchp_tc_count_action_get(struct counter_device *counter,
-				    struct counter_count *count,
-				    struct counter_synapse *synapse,
-				    size_t *action)
+static int mchp_tc_action_get(struct counter_device *counter,
+			      struct counter_count *count,
+			      struct counter_synapse *synapse, size_t *action)
 {
 	struct mchp_tc_data *const priv = counter->priv;
 	u32 cmr;
@@ -204,10 +201,9 @@ static int mchp_tc_count_action_get(struct counter_device *counter,
 	return 0;
 }
 
-static int mchp_tc_count_action_set(struct counter_device *counter,
-				    struct counter_count *count,
-				    struct counter_synapse *synapse,
-				    size_t action)
+static int mchp_tc_action_set(struct counter_device *counter,
+			      struct counter_count *count,
+			      struct counter_synapse *synapse, size_t action)
 {
 	struct mchp_tc_data *const priv = counter->priv;
 	u32 edge = ATMEL_TC_ETRGEDG_NONE;
@@ -256,8 +252,8 @@ static struct counter_count mchp_tc_counts[] = {
 	{
 		.id = 0,
 		.name = "Timer Counter",
-		.functions_list = mchp_tc_count_functions,
-		.num_functions = ARRAY_SIZE(mchp_tc_count_functions),
+		.functions_list = mchp_tc_functions,
+		.num_functions = ARRAY_SIZE(mchp_tc_functions),
 		.synapses = mchp_tc_count_synapses,
 		.num_synapses = ARRAY_SIZE(mchp_tc_count_synapses),
 	},
@@ -266,10 +262,10 @@ static struct counter_count mchp_tc_counts[] = {
 static const struct counter_ops mchp_tc_ops = {
 	.signal_read  = mchp_tc_count_signal_read,
 	.count_read   = mchp_tc_count_read,
-	.function_get = mchp_tc_count_function_get,
-	.function_set = mchp_tc_count_function_set,
-	.action_get   = mchp_tc_count_action_get,
-	.action_set   = mchp_tc_count_action_set
+	.function_get = mchp_tc_function_get,
+	.function_set = mchp_tc_function_set,
+	.action_get   = mchp_tc_action_get,
+	.action_set   = mchp_tc_action_set
 };
 
 static const struct atmel_tcb_config tcb_rm9200_config = {
diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
index d5f9d580d06d..31477c6a0611 100644
--- a/drivers/counter/stm32-lptimer-cnt.c
+++ b/drivers/counter/stm32-lptimer-cnt.c
@@ -108,7 +108,7 @@ static int stm32_lptim_setup(struct stm32_lptim_cnt *priv, int enable)
 }
 
 /**
- * enum stm32_lptim_cnt_function - enumerates LPTimer counter & encoder modes
+ * enum stm32_lptim_function - enumerates LPTimer counter & encoder modes
  * @STM32_LPTIM_COUNTER_INCREASE: up count on IN1 rising, falling or both edges
  * @STM32_LPTIM_ENCODER_BOTH_EDGE: count on both edges (IN1 & IN2 quadrature)
  *
@@ -129,14 +129,14 @@ static int stm32_lptim_setup(struct stm32_lptim_cnt *priv, int enable)
  * | edges   | Low  ->  |   Up     |   Down  |   Down   |   Up    |
  * +---------+----------+----------+---------+----------+---------+
  */
-enum stm32_lptim_cnt_function {
+enum stm32_lptim_function {
 	STM32_LPTIM_COUNTER_INCREASE,
 	STM32_LPTIM_ENCODER_BOTH_EDGE,
 };
 
-static enum counter_count_function stm32_lptim_cnt_functions[] = {
-	[STM32_LPTIM_COUNTER_INCREASE] = COUNTER_COUNT_FUNCTION_INCREASE,
-	[STM32_LPTIM_ENCODER_BOTH_EDGE] = COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
+static enum counter_function stm32_lptim_functions[] = {
+	[STM32_LPTIM_COUNTER_INCREASE] = COUNTER_FUNCTION_INCREASE,
+	[STM32_LPTIM_ENCODER_BOTH_EDGE] = COUNTER_FUNCTION_QUADRATURE_X4,
 };
 
 enum stm32_lptim_synapse_action {
@@ -170,9 +170,9 @@ static int stm32_lptim_cnt_read(struct counter_device *counter,
 	return 0;
 }
 
-static int stm32_lptim_cnt_function_get(struct counter_device *counter,
-					struct counter_count *count,
-					size_t *function)
+static int stm32_lptim_function_get(struct counter_device *counter,
+				    struct counter_count *count,
+				    size_t *function)
 {
 	struct stm32_lptim_cnt *const priv = counter->priv;
 
@@ -189,9 +189,9 @@ static int stm32_lptim_cnt_function_get(struct counter_device *counter,
 	return -EINVAL;
 }
 
-static int stm32_lptim_cnt_function_set(struct counter_device *counter,
-					struct counter_count *count,
-					size_t function)
+static int stm32_lptim_function_set(struct counter_device *counter,
+				    struct counter_count *count,
+				    size_t function)
 {
 	struct stm32_lptim_cnt *const priv = counter->priv;
 
@@ -303,16 +303,16 @@ static const struct counter_count_ext stm32_lptim_cnt_ext[] = {
 	},
 };
 
-static int stm32_lptim_cnt_action_get(struct counter_device *counter,
-				      struct counter_count *count,
-				      struct counter_synapse *synapse,
-				      size_t *action)
+static int stm32_lptim_action_get(struct counter_device *counter,
+				  struct counter_count *count,
+				  struct counter_synapse *synapse,
+				  size_t *action)
 {
 	struct stm32_lptim_cnt *const priv = counter->priv;
 	size_t function;
 	int err;
 
-	err = stm32_lptim_cnt_function_get(counter, count, &function);
+	err = stm32_lptim_function_get(counter, count, &function);
 	if (err)
 		return err;
 
@@ -333,10 +333,10 @@ static int stm32_lptim_cnt_action_get(struct counter_device *counter,
 	}
 }
 
-static int stm32_lptim_cnt_action_set(struct counter_device *counter,
-				      struct counter_count *count,
-				      struct counter_synapse *synapse,
-				      size_t action)
+static int stm32_lptim_action_set(struct counter_device *counter,
+				  struct counter_count *count,
+				  struct counter_synapse *synapse,
+				  size_t action)
 {
 	struct stm32_lptim_cnt *const priv = counter->priv;
 	size_t function;
@@ -345,7 +345,7 @@ static int stm32_lptim_cnt_action_set(struct counter_device *counter,
 	if (stm32_lptim_is_enabled(priv))
 		return -EBUSY;
 
-	err = stm32_lptim_cnt_function_get(counter, count, &function);
+	err = stm32_lptim_function_get(counter, count, &function);
 	if (err)
 		return err;
 
@@ -366,10 +366,10 @@ static int stm32_lptim_cnt_action_set(struct counter_device *counter,
 
 static const struct counter_ops stm32_lptim_cnt_ops = {
 	.count_read = stm32_lptim_cnt_read,
-	.function_get = stm32_lptim_cnt_function_get,
-	.function_set = stm32_lptim_cnt_function_set,
-	.action_get = stm32_lptim_cnt_action_get,
-	.action_set = stm32_lptim_cnt_action_set,
+	.function_get = stm32_lptim_function_get,
+	.function_set = stm32_lptim_function_set,
+	.action_get = stm32_lptim_action_get,
+	.action_set = stm32_lptim_action_set,
 };
 
 static struct counter_signal stm32_lptim_cnt_signals[] = {
@@ -400,8 +400,8 @@ static struct counter_synapse stm32_lptim_cnt_synapses[] = {
 static struct counter_count stm32_lptim_enc_counts = {
 	.id = 0,
 	.name = "LPTimer Count",
-	.functions_list = stm32_lptim_cnt_functions,
-	.num_functions = ARRAY_SIZE(stm32_lptim_cnt_functions),
+	.functions_list = stm32_lptim_functions,
+	.num_functions = ARRAY_SIZE(stm32_lptim_functions),
 	.synapses = stm32_lptim_cnt_synapses,
 	.num_synapses = ARRAY_SIZE(stm32_lptim_cnt_synapses),
 	.ext = stm32_lptim_cnt_ext,
@@ -412,7 +412,7 @@ static struct counter_count stm32_lptim_enc_counts = {
 static struct counter_count stm32_lptim_in1_counts = {
 	.id = 0,
 	.name = "LPTimer Count",
-	.functions_list = stm32_lptim_cnt_functions,
+	.functions_list = stm32_lptim_functions,
 	.num_functions = 1,
 	.synapses = stm32_lptim_cnt_synapses,
 	.num_synapses = 1,
diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 431a3d08ed6c..02a7c8bd77df 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -37,23 +37,23 @@ struct stm32_timer_cnt {
 };
 
 /**
- * enum stm32_count_function - enumerates stm32 timer counter encoder modes
- * @STM32_COUNT_SLAVE_MODE_DISABLED: counts on internal clock when CEN=1
- * @STM32_COUNT_ENCODER_MODE_1: counts TI1FP1 edges, depending on TI2FP2 level
- * @STM32_COUNT_ENCODER_MODE_2: counts TI2FP2 edges, depending on TI1FP1 level
- * @STM32_COUNT_ENCODER_MODE_3: counts on both TI1FP1 and TI2FP2 edges
+ * enum stm32_function - enumerates stm32 timer counter encoder modes
+ * @STM32_SLAVE_MODE_DISABLED: counts on internal clock when CEN=1
+ * @STM32_ENCODER_MODE_1: counts TI1FP1 edges, depending on TI2FP2 level
+ * @STM32_ENCODER_MODE_2: counts TI2FP2 edges, depending on TI1FP1 level
+ * @STM32_ENCODER_MODE_3: counts on both TI1FP1 and TI2FP2 edges
  */
-enum stm32_count_function {
-	STM32_COUNT_SLAVE_MODE_DISABLED = -1,
-	STM32_COUNT_ENCODER_MODE_1,
-	STM32_COUNT_ENCODER_MODE_2,
-	STM32_COUNT_ENCODER_MODE_3,
+enum stm32_function {
+	STM32_SLAVE_MODE_DISABLED = -1,
+	STM32_ENCODER_MODE_1,
+	STM32_ENCODER_MODE_2,
+	STM32_ENCODER_MODE_3,
 };
 
-static enum counter_count_function stm32_count_functions[] = {
-	[STM32_COUNT_ENCODER_MODE_1] = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,
-	[STM32_COUNT_ENCODER_MODE_2] = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_B,
-	[STM32_COUNT_ENCODER_MODE_3] = COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
+static enum counter_function stm32_functions[] = {
+	[STM32_ENCODER_MODE_1] = COUNTER_FUNCTION_QUADRATURE_X2_A,
+	[STM32_ENCODER_MODE_2] = COUNTER_FUNCTION_QUADRATURE_X2_B,
+	[STM32_ENCODER_MODE_3] = COUNTER_FUNCTION_QUADRATURE_X4,
 };
 
 static int stm32_count_read(struct counter_device *counter,
@@ -80,9 +80,8 @@ static int stm32_count_write(struct counter_device *counter,
 	return regmap_write(priv->regmap, TIM_CNT, val);
 }
 
-static int stm32_count_function_get(struct counter_device *counter,
-				    struct counter_count *count,
-				    size_t *function)
+static int stm32_function_get(struct counter_device *counter,
+			      struct counter_count *count, size_t *function)
 {
 	struct stm32_timer_cnt *const priv = counter->priv;
 	u32 smcr;
@@ -91,34 +90,33 @@ static int stm32_count_function_get(struct counter_device *counter,
 
 	switch (smcr & TIM_SMCR_SMS) {
 	case 1:
-		*function = STM32_COUNT_ENCODER_MODE_1;
+		*function = STM32_ENCODER_MODE_1;
 		return 0;
 	case 2:
-		*function = STM32_COUNT_ENCODER_MODE_2;
+		*function = STM32_ENCODER_MODE_2;
 		return 0;
 	case 3:
-		*function = STM32_COUNT_ENCODER_MODE_3;
+		*function = STM32_ENCODER_MODE_3;
 		return 0;
 	}
 
 	return -EINVAL;
 }
 
-static int stm32_count_function_set(struct counter_device *counter,
-				    struct counter_count *count,
-				    size_t function)
+static int stm32_function_set(struct counter_device *counter,
+			      struct counter_count *count, size_t function)
 {
 	struct stm32_timer_cnt *const priv = counter->priv;
 	u32 cr1, sms;
 
 	switch (function) {
-	case STM32_COUNT_ENCODER_MODE_1:
+	case STM32_ENCODER_MODE_1:
 		sms = 1;
 		break;
-	case STM32_COUNT_ENCODER_MODE_2:
+	case STM32_ENCODER_MODE_2:
 		sms = 2;
 		break;
-	case STM32_COUNT_ENCODER_MODE_3:
+	case STM32_ENCODER_MODE_3:
 		sms = 3;
 		break;
 	default:
@@ -274,25 +272,25 @@ static int stm32_action_get(struct counter_device *counter,
 	size_t function;
 	int err;
 
-	/* Default action mode (e.g. STM32_COUNT_SLAVE_MODE_DISABLED) */
+	/* Default action mode (e.g. STM32_SLAVE_MODE_DISABLED) */
 	*action = STM32_SYNAPSE_ACTION_NONE;
 
-	err = stm32_count_function_get(counter, count, &function);
+	err = stm32_function_get(counter, count, &function);
 	if (err)
 		return 0;
 
 	switch (function) {
-	case STM32_COUNT_ENCODER_MODE_1:
+	case STM32_ENCODER_MODE_1:
 		/* counts up/down on TI1FP1 edge depending on TI2FP2 level */
 		if (synapse->signal->id == count->synapses[0].signal->id)
 			*action = STM32_SYNAPSE_ACTION_BOTH_EDGES;
 		break;
-	case STM32_COUNT_ENCODER_MODE_2:
+	case STM32_ENCODER_MODE_2:
 		/* counts up/down on TI2FP2 edge depending on TI1FP1 level */
 		if (synapse->signal->id == count->synapses[1].signal->id)
 			*action = STM32_SYNAPSE_ACTION_BOTH_EDGES;
 		break;
-	case STM32_COUNT_ENCODER_MODE_3:
+	case STM32_ENCODER_MODE_3:
 		/* counts up/down on both TI1FP1 and TI2FP2 edges */
 		*action = STM32_SYNAPSE_ACTION_BOTH_EDGES;
 		break;
@@ -307,8 +305,8 @@ static int stm32_action_get(struct counter_device *counter,
 static const struct counter_ops stm32_timer_cnt_ops = {
 	.count_read = stm32_count_read,
 	.count_write = stm32_count_write,
-	.function_get = stm32_count_function_get,
-	.function_set = stm32_count_function_set,
+	.function_get = stm32_function_get,
+	.function_set = stm32_function_set,
 	.action_get = stm32_action_get,
 };
 
@@ -339,8 +337,8 @@ static struct counter_synapse stm32_count_synapses[] = {
 static struct counter_count stm32_counts = {
 	.id = 0,
 	.name = "Channel 1 Count",
-	.functions_list = stm32_count_functions,
-	.num_functions = ARRAY_SIZE(stm32_count_functions),
+	.functions_list = stm32_functions,
+	.num_functions = ARRAY_SIZE(stm32_functions),
 	.synapses = stm32_count_synapses,
 	.num_synapses = ARRAY_SIZE(stm32_count_synapses),
 	.ext = stm32_count_ext,
diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index 7844fdf78a97..8d45b0443610 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -73,11 +73,11 @@ enum {
 };
 
 /* Position Counter Input Modes */
-enum {
-	TI_EQEP_COUNT_FUNC_QUAD_COUNT,
-	TI_EQEP_COUNT_FUNC_DIR_COUNT,
-	TI_EQEP_COUNT_FUNC_UP_COUNT,
-	TI_EQEP_COUNT_FUNC_DOWN_COUNT,
+enum ti_eqep_function {
+	TI_EQEP_FUNCTION_QUAD_COUNT,
+	TI_EQEP_FUNCTION_DIR_COUNT,
+	TI_EQEP_FUNCTION_UP_COUNT,
+	TI_EQEP_FUNCTION_DOWN_COUNT,
 };
 
 enum {
@@ -152,13 +152,13 @@ static int ti_eqep_action_get(struct counter_device *counter,
 		return err;
 
 	switch (function) {
-	case TI_EQEP_COUNT_FUNC_QUAD_COUNT:
+	case TI_EQEP_FUNCTION_QUAD_COUNT:
 		/* In quadrature mode, the rising and falling edge of both
 		 * QEPA and QEPB trigger QCLK.
 		 */
 		*action = TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES;
 		break;
-	case TI_EQEP_COUNT_FUNC_DIR_COUNT:
+	case TI_EQEP_FUNCTION_DIR_COUNT:
 		/* In direction-count mode only rising edge of QEPA is counted
 		 * and QEPB gives direction.
 		 */
@@ -171,8 +171,8 @@ static int ti_eqep_action_get(struct counter_device *counter,
 			break;
 		}
 		break;
-	case TI_EQEP_COUNT_FUNC_UP_COUNT:
-	case TI_EQEP_COUNT_FUNC_DOWN_COUNT:
+	case TI_EQEP_FUNCTION_UP_COUNT:
+	case TI_EQEP_FUNCTION_DOWN_COUNT:
 		/* In up/down-count modes only QEPA is counted and QEPB is not
 		 * used.
 		 */
@@ -327,11 +327,11 @@ static struct counter_signal ti_eqep_signals[] = {
 	},
 };
 
-static const enum counter_count_function ti_eqep_position_functions[] = {
-	[TI_EQEP_COUNT_FUNC_QUAD_COUNT]	= COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
-	[TI_EQEP_COUNT_FUNC_DIR_COUNT]	= COUNTER_COUNT_FUNCTION_PULSE_DIRECTION,
-	[TI_EQEP_COUNT_FUNC_UP_COUNT]	= COUNTER_COUNT_FUNCTION_INCREASE,
-	[TI_EQEP_COUNT_FUNC_DOWN_COUNT]	= COUNTER_COUNT_FUNCTION_DECREASE,
+static const enum counter_function ti_eqep_position_functions[] = {
+	[TI_EQEP_FUNCTION_QUAD_COUNT]	= COUNTER_FUNCTION_QUADRATURE_X4,
+	[TI_EQEP_FUNCTION_DIR_COUNT]	= COUNTER_FUNCTION_PULSE_DIRECTION,
+	[TI_EQEP_FUNCTION_UP_COUNT]	= COUNTER_FUNCTION_INCREASE,
+	[TI_EQEP_FUNCTION_DOWN_COUNT]	= COUNTER_FUNCTION_DECREASE,
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
2.30.0

