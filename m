Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B1A341AD1
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 12:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhCSLCv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 07:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbhCSLCZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 07:02:25 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BFFC06174A;
        Fri, 19 Mar 2021 04:02:23 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t18so4463219pjs.3;
        Fri, 19 Mar 2021 04:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lSxNdunUcfVjOwF1Ukve+wpGCmUe1GqXnjLiDip7r60=;
        b=Ijjt5X33sHG6VLfr/X33ofH/zw3C83x5jF2PbSQDxSentiAHZIdiWspxk+4wpX/j/k
         dll2UbF/VnvXh89Ud178c7zqeR+G4sJ9kXGUWQys5Xo57/GUxwevKvql1vB2pRI9s2O4
         D8RA3+HfIXxAwA2e9r37NxLzuu0F4RH2HJ9DmslDfOAp/DbJnmv3SEbR0U2UxXmHN7Mh
         saPQ19ko9HehDeewr55u+I6ikxva25/lNvth/kyOEKrC+9aZgJ43NxDjrjcpXa9VJMcJ
         jkHyArhlPzf/2CaRZ/kRVPzG2TZFzLvwSofJeOfhmkx4TFT9uXwU4TAvQfYNxBBCq6a9
         FT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lSxNdunUcfVjOwF1Ukve+wpGCmUe1GqXnjLiDip7r60=;
        b=CrO5C6cTwnTOCACO2KYcJZFBZj9Zs54Sb9hBowZbuuzvdw3pUZpVh1+I7MGZiI22HK
         Pu2ohwaBU6nq57OTc/5lgZbaOtKaLSY9jbyL0o0GhyFvnCSxgQpBE+Nf7BB3e2OMaR6H
         VzKK8sIeBvK098bKzRvE635Scd3bVPh8n2/PHJdzCT2KkDcjF2KYLWPD196VarSkDF+j
         KY9KGQA6//QIWtsalinT2DRL4WCC7eymkRpEBfRXGhvqOEBSXv8fVA5vBj1ToODbYd8t
         44QVnX2vcSsaoTBK0veymFOEkuNd20AjpJlj9PnushpoZclAo7Vb6TDNs6GWkkiVMzZH
         SACQ==
X-Gm-Message-State: AOAM531EGlkTlGcxpK4qkuUrgxaqc0+oovaT8+Zt65dLHK9vc/zHr+FJ
        PFF9CEzyRUsqJSlFlwYDoNV3e7hEJO5lmg==
X-Google-Smtp-Source: ABdhPJxakjll3igoMgwm09QbKi+PEN8Sji9wqQ7cN5cp5slUO1v+w3Ri5WLxTByTWvLWd5tA36ZOJQ==
X-Received: by 2002:a17:90a:1b0e:: with SMTP id q14mr3596346pjq.41.1616151743496;
        Fri, 19 Mar 2021 04:02:23 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id i22sm4879042pjz.56.2021.03.19.04.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 04:02:22 -0700 (PDT)
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
Subject: [PATCH v10 16/33] counter: stm32-lptimer-cnt: Add const qualifier for actions_list array
Date:   Fri, 19 Mar 2021 20:00:35 +0900
Message-Id: <1a454675b256daed71e0c0053377f36475f920d3.1616150619.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616150619.git.vilhelm.gray@gmail.com>
References: <cover.1616150619.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The struct counter_synapse actions_list member expects a const enum
counter_synapse_action array. This patch adds the const qualifier to the
stm32_lptim_cnt_synapse_actions to match actions_list.

Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/stm32-lptimer-cnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
index 0f7d3f1ec1b6..c19d998df5ba 100644
--- a/drivers/counter/stm32-lptimer-cnt.c
+++ b/drivers/counter/stm32-lptimer-cnt.c
@@ -146,7 +146,7 @@ enum stm32_lptim_synapse_action {
 	STM32_LPTIM_SYNAPSE_ACTION_NONE,
 };
 
-static enum counter_synapse_action stm32_lptim_cnt_synapse_actions[] = {
+static const enum counter_synapse_action stm32_lptim_cnt_synapse_actions[] = {
 	/* Index must match with stm32_lptim_cnt_polarity[] (priv->polarity) */
 	[STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE] = COUNTER_SYNAPSE_ACTION_RISING_EDGE,
 	[STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE] = COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
-- 
2.30.2

