Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57BBB325B4F
	for <lists+linux-iio@lfdr.de>; Fri, 26 Feb 2021 02:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhBZBa1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Feb 2021 20:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhBZBa0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Feb 2021 20:30:26 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239E9C061574;
        Thu, 25 Feb 2021 17:29:46 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d11so4408307plo.8;
        Thu, 25 Feb 2021 17:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XmwUKf+hUjG27sz2bJqruSzlU36nwLMx6Yr1Y6X8O/s=;
        b=MUdlHZntR8igfGXzxHRYarSsJ1VNGC47LvAonEOY8JSg3/voXJcOe3iDjmLmjdWvLD
         KMQxxUFn4AJKArwdElca1UiZ4WmORYgbm4q+yfMsgHRSIO/XwZ6smKLQ+zbl2qx/x19k
         tYcVIoLCSGkXu9Qn9ocH+OsddRAXQ3WYhrfkyCfjTpuXv8iAo1cJyB/vJd+Xl8PR4car
         gL7ieHzLY58KcoC3VYLAyBHw2rL+aRQ8W1z2YFBTExa1mEZSpZIgZF8o4uKKFHVT/l2o
         JpDztCwRXGCdtsE0AbIfVd6QVjZlomLGclNvkjnxs5FAvR4eowQO5epx2bYWE5rywPnL
         D1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XmwUKf+hUjG27sz2bJqruSzlU36nwLMx6Yr1Y6X8O/s=;
        b=ujJCK5Q6pcQAehLBMFmEg2FXgZ3rYeLpYuXdPfBZxnZ+AM6J4sGuUJ9zDbtlzBCfiw
         DJcpfke0+hmme0VxMKA3DFPVH8KOmxItBCg+7MpMveI44YA2Oww0AOdKxNp/8jOiuw8v
         fUS3ww6Hh/O7oSf0XbTIIiARIBL1JCAZE7NxSQA6tgFcV5wP4XaA7vo+BAVN71/bXxX8
         qytDUUUvKnV6vPAOMLefTkzB9lhC/T7TUZQvwbIQnofz2LpAgOBMBY2Kse6tGcBtR62J
         efXsVGQ7f+uqyBEHAcIP/i6lnXMV8ani6scmWa2leDfFeV3Eg+WcEvMk9QOUZnTNP1cH
         52CA==
X-Gm-Message-State: AOAM533ZwMiTyVEOf7Nfi51ocizO9RwtMSpVJHH7z8V8fHAXqmCEXOgr
        uNcKwx4+2vISTmHKcEkY3U+eHIgJy9MnOw==
X-Google-Smtp-Source: ABdhPJzDOcY0htBukhNsAGlPVzopVjSgvQVb9Vo/MdNoJwT2X1CB9g6ODBTdELCMsls/NK6rrrmQ3w==
X-Received: by 2002:a17:902:e54f:b029:e2:8f59:6fe0 with SMTP id n15-20020a170902e54fb02900e28f596fe0mr618450plf.76.1614302985633;
        Thu, 25 Feb 2021 17:29:45 -0800 (PST)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id c6sm7773242pfc.94.2021.02.25.17.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 17:29:44 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, benjamin.gaignard@st.com,
        fabrice.gasnier@foss.st.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v2] counter: stm32-timer-cnt: Report count function when SLAVE_MODE_DISABLED
Date:   Fri, 26 Feb 2021 10:29:31 +0900
Message-Id: <20210226012931.161429-1-vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When in SLAVE_MODE_DISABLED mode, the count still increases if the
counter is enabled because an internal clock is used. This patch fixes
the stm32_count_function_get() and stm32_count_function_set() functions
to properly handle this behavior.

Fixes: ad29937e206f ("counter: Add STM32 Timer quadrature encoder")
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
Changes in v2:
 - Support an explicit 0 case for function_get()/function_set()

 drivers/counter/stm32-timer-cnt.c | 39 ++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index ef2a974a2f10..cd50dc12bd02 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -44,13 +44,14 @@ struct stm32_timer_cnt {
  * @STM32_COUNT_ENCODER_MODE_3: counts on both TI1FP1 and TI2FP2 edges
  */
 enum stm32_count_function {
-	STM32_COUNT_SLAVE_MODE_DISABLED = -1,
+	STM32_COUNT_SLAVE_MODE_DISABLED,
 	STM32_COUNT_ENCODER_MODE_1,
 	STM32_COUNT_ENCODER_MODE_2,
 	STM32_COUNT_ENCODER_MODE_3,
 };
 
 static enum counter_count_function stm32_count_functions[] = {
+	[STM32_COUNT_SLAVE_MODE_DISABLED] = COUNTER_COUNT_FUNCTION_INCREASE,
 	[STM32_COUNT_ENCODER_MODE_1] = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,
 	[STM32_COUNT_ENCODER_MODE_2] = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_B,
 	[STM32_COUNT_ENCODER_MODE_3] = COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
@@ -90,6 +91,9 @@ static int stm32_count_function_get(struct counter_device *counter,
 	regmap_read(priv->regmap, TIM_SMCR, &smcr);
 
 	switch (smcr & TIM_SMCR_SMS) {
+	case 0:
+		*function = STM32_COUNT_SLAVE_MODE_DISABLED;
+		return 0;
 	case 1:
 		*function = STM32_COUNT_ENCODER_MODE_1;
 		return 0;
@@ -99,9 +103,9 @@ static int stm32_count_function_get(struct counter_device *counter,
 	case 3:
 		*function = STM32_COUNT_ENCODER_MODE_3;
 		return 0;
+	default:
+		return -EINVAL;
 	}
-
-	return -EINVAL;
 }
 
 static int stm32_count_function_set(struct counter_device *counter,
@@ -112,6 +116,9 @@ static int stm32_count_function_set(struct counter_device *counter,
 	u32 cr1, sms;
 
 	switch (function) {
+	case STM32_COUNT_SLAVE_MODE_DISABLED:
+		sms = 0;
+		break;
 	case STM32_COUNT_ENCODER_MODE_1:
 		sms = 1;
 		break;
@@ -122,8 +129,7 @@ static int stm32_count_function_set(struct counter_device *counter,
 		sms = 3;
 		break;
 	default:
-		sms = 0;
-		break;
+		return -EINVAL;
 	}
 
 	/* Store enable status */
@@ -274,31 +280,36 @@ static int stm32_action_get(struct counter_device *counter,
 	size_t function;
 	int err;
 
-	/* Default action mode (e.g. STM32_COUNT_SLAVE_MODE_DISABLED) */
-	*action = STM32_SYNAPSE_ACTION_NONE;
-
 	err = stm32_count_function_get(counter, count, &function);
 	if (err)
-		return 0;
+		return err;
 
 	switch (function) {
+	case STM32_COUNT_SLAVE_MODE_DISABLED:
+		/* counts on internal clock when CEN=1 */
+		*action = STM32_SYNAPSE_ACTION_NONE;
+		return 0;
 	case STM32_COUNT_ENCODER_MODE_1:
 		/* counts up/down on TI1FP1 edge depending on TI2FP2 level */
 		if (synapse->signal->id == count->synapses[0].signal->id)
 			*action = STM32_SYNAPSE_ACTION_BOTH_EDGES;
-		break;
+		else
+			*action = STM32_SYNAPSE_ACTION_NONE;
+		return 0;
 	case STM32_COUNT_ENCODER_MODE_2:
 		/* counts up/down on TI2FP2 edge depending on TI1FP1 level */
 		if (synapse->signal->id == count->synapses[1].signal->id)
 			*action = STM32_SYNAPSE_ACTION_BOTH_EDGES;
-		break;
+		else
+			*action = STM32_SYNAPSE_ACTION_NONE;
+		return 0;
 	case STM32_COUNT_ENCODER_MODE_3:
 		/* counts up/down on both TI1FP1 and TI2FP2 edges */
 		*action = STM32_SYNAPSE_ACTION_BOTH_EDGES;
-		break;
+		return 0;
+	default:
+		return -EINVAL;
 	}
-
-	return 0;
 }
 
 static const struct counter_ops stm32_timer_cnt_ops = {
-- 
2.30.1

