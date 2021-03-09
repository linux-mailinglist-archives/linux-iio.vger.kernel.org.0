Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659D43326C4
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 14:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhCINWA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 08:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhCINVf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 08:21:35 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9774C06174A;
        Tue,  9 Mar 2021 05:21:34 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id a188so9478198pfb.4;
        Tue, 09 Mar 2021 05:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lKQBbBWNoQCAzrzOLXLXaWKO88BEqFAf4JzZ/BOkGvk=;
        b=h9WuVuuqiNzrtydGX1I+OAyd5xdQWeCeb19No6Q9k349Tqh4H6uH3x5Cxx3KM7/kCf
         b6FtVO35EmYC/8BDUs3JwcHbVvGVzJ5KeIMV4iW8anmQIiVcIgsDAXYEiRMAbkBU1866
         C9sC1208pC96x5X5JBEurygLyzBSDY0tjlcGo3HYD8jTF1DDdenq+AQW/IlU2l5zyAVn
         2qe7tPOajW1VwQj9H9O6u90GfeGun8cbzNKaTNFRTwaKBUNNp4dcoN6AQF2KC5ANnr+2
         ajp6E3j6wuMCtmkCV7Bq4WFPmXpPJlLpf6quj0pFmlewc0Lx6wfdaVY9kFrBGGH51R+5
         KBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lKQBbBWNoQCAzrzOLXLXaWKO88BEqFAf4JzZ/BOkGvk=;
        b=VFeJzRvzculfjFcB2IVAQw0UNj7lKNCJ/J+qVI2LmfLTSMGz23XsuYiAnczcqheQAN
         lrLTEmAu+4fZxif1nZnYvQ5sRktOZAc0FLL+a5vaOWuRWT62+IPcKmBIpg0iU6YlsYSv
         WvtSmxqUTjMZ/3hXiYsBmMbDFnYs3kh5kbxAO+pSVJ8StWynNC+ScUypKQq0UBSoJdX4
         Bnjfj4a8+k3oWio7dMGYesmffHggVJQnexhZhrXk8riIK5prezsTAPzgFr0YIlBuCtDi
         t2f22tsNPicPmzVWxm0PDq1s8mN1Y/cH8saBQv8V9EohsG/eu9kF7pEE0hWTd26vTeLo
         A45g==
X-Gm-Message-State: AOAM532QKzcsCOJp8T52DuhHs75XJE5KwcblRKxUOWEfCZwDR24B46As
        C7rDidui/XlC+Nsr8Bb27lY=
X-Google-Smtp-Source: ABdhPJwhZtTdMde26dsAarCbRJh8s9mIuxXONPgp8SHKC13ALeUMBJEC0fjJIDp7ScHjRLkR5ibpnA==
X-Received: by 2002:aa7:9298:0:b029:1ed:fd64:e6b7 with SMTP id j24-20020aa792980000b02901edfd64e6b7mr25686117pfa.5.1615296094436;
        Tue, 09 Mar 2021 05:21:34 -0800 (PST)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id y9sm7647421pfl.201.2021.03.09.05.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 05:21:34 -0800 (PST)
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
Subject: [PATCH v9 16/33] counter: stm32-lptimer-cnt: Add const qualifier for actions_list array
Date:   Tue,  9 Mar 2021 22:19:29 +0900
Message-Id: <01cafeb117b6c12288db7d36ff295ff903397e34.1615293276.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1615293276.git.vilhelm.gray@gmail.com>
References: <cover.1615293276.git.vilhelm.gray@gmail.com>
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
2.30.1

