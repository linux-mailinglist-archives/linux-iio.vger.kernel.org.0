Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED8E31F6F3
	for <lists+linux-iio@lfdr.de>; Fri, 19 Feb 2021 11:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhBSKAY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Feb 2021 05:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhBSKAJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Feb 2021 05:00:09 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2DCC061574;
        Fri, 19 Feb 2021 01:59:27 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id fy5so3397141pjb.5;
        Fri, 19 Feb 2021 01:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rO0e+NuITIQhnPgueO8o0H2uruJAZQF5INjcDz5MY5k=;
        b=Y0IzD+lGc6c+loGdb8VZjnxwjd1fqDUpS+RfBDHINBazzFZ176nBqigOl3s29SmnBr
         WEQbA6KkV+cfYe4DR6GmreHByy2Vac8HAJReV/SdlTzw+OEOZUG6U5UvqMfLJSG5Jpdx
         9V03pBgHlaHX/jUbPbd+Ehu9F5eeHavFCLmLM4ysAGKlooCjRy/nPOTYHC2sRpKBbRRj
         wlWT8vvlBKbyvO2Ya94J0l94I7TS1T2uQmONsFgrnWLn8fpSr4NU3Gfy1b7vLMO5GUBS
         I0ZG9DYKFhEupLXhumjB5aqjLQcodfeqlHhkx96h79Zf7UlW3PJ5Ei7pK4DSxxlnx6HV
         I7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rO0e+NuITIQhnPgueO8o0H2uruJAZQF5INjcDz5MY5k=;
        b=oztpiKYxD0tYNU7NUg7JiXhzkTlj9ndU967Oq8M+xU7JgkK+v/EicI/zgrV+aN6Qri
         uwLB6M28citc8QqwxN6OYgM3Y0D0ryH9uF8gGZw9uRuxxCocb51DEKnXxbp/daMw2TmL
         /BEQ51u2cntYjOHcEa1PQZqAjEBV57C/IxiVCb+UDHDiy1lhkRGeo+3kfdIKuDhvZetg
         WUQZkjWpKS+wY0kyBWFf0nBnES+RVOkGH2hSvrI1b37sGFXPqGt7Y8jMCh9o840L6abO
         lBd1vPJ/CaqnUdQjFVLG8jw36dzw0kHjAnuwYzQcF5CkuhfD332UzTJVpGUimlv0d/mB
         Cp9g==
X-Gm-Message-State: AOAM533u/eKn8qfnKovrCVuh44TFloGTN+T/o2GFZmzLIo3HxTQy+D/S
        CMYKIdDVctqBKORNROHv7dk=
X-Google-Smtp-Source: ABdhPJw8JkW1fb08x5fPxcAAg6KungWG6R/Q1ALRmTD5unlLBcDpQTcqEeIR3O2PwX08iUi89mc7Fw==
X-Received: by 2002:a17:90a:b282:: with SMTP id c2mr8635023pjr.54.1613728767387;
        Fri, 19 Feb 2021 01:59:27 -0800 (PST)
Received: from localhost.localdomain (113x37x72x20.ap113.ftth.ucom.ne.jp. [113.37.72.20])
        by smtp.gmail.com with ESMTPSA id y16sm8361475pgg.20.2021.02.19.01.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 01:59:26 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH] counter: stm32-timer-cnt: Report count function when SLAVE_MODE_DISABLED
Date:   Fri, 19 Feb 2021 18:59:06 +0900
Message-Id: <20210219095906.220382-1-vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When in SLAVE_MODE_DISABLED mode, the count still increases if the
counter is enabled because an internal clock is used. This patch fixes
the stm32_count_function_get() function to properly report this
behavior.

Fixes: ad29937e206f ("counter: Add STM32 Timer quadrature encoder")
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/stm32-timer-cnt.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index ef2a974a2f10..ec6d9e89c028 100644
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
@@ -99,9 +100,10 @@ static int stm32_count_function_get(struct counter_device *counter,
 	case 3:
 		*function = STM32_COUNT_ENCODER_MODE_3;
 		return 0;
+	default:
+		*function = STM32_COUNT_SLAVE_MODE_DISABLED;
+		return 0;
 	}
-
-	return -EINVAL;
 }
 
 static int stm32_count_function_set(struct counter_device *counter,
@@ -274,31 +276,36 @@ static int stm32_action_get(struct counter_device *counter,
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
+	case STM32_COUNT_SLAVE_MODE_DISABLED:
+		/* counts on internal clock when CEN=1 */
+		*action = STM32_SYNAPSE_ACTION_NONE;
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

