Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC0B3A092A
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 03:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbhFIBfH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 21:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235685AbhFIBfF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 21:35:05 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E46C061574;
        Tue,  8 Jun 2021 18:33:11 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so436688pjs.2;
        Tue, 08 Jun 2021 18:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bitxx/XbIAxQ+3ku/Ck0eGbzGv7Jfqx1XIDiwjeLpr0=;
        b=Cm4lgvn1K3wLjgrx+rRm23T6dRACnIdASni2uM4/i5kkJxieL1zML733wmI+3AC6H0
         mlZT2pBdnl/2B5kx5GQN6PjeYGJQ4hdKKmentCRpVjfcTjNk5RgGw38ockGOHYC+alfC
         Fgrgiq26fO4Ix542suEce5f6XuA2y7AhqnCfhuN81tGcI78byXX9b57XxDwHkKDaRl4H
         xQaNcibGY69gloVh1jT1LnJSwucrxoRlX2FamQxeCrEozECXycTQhQmqsZ77ETyBLWU8
         6XYsPXMeXm20pgQCcbGk6lrBIsxkQNK9Fn3EzfSKKNiyTA7ZWzSFyL3G6fNGpDdxokGr
         lFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bitxx/XbIAxQ+3ku/Ck0eGbzGv7Jfqx1XIDiwjeLpr0=;
        b=KvZ2eOJFCwOoPl2V4mK9ezBJhu7ciWwCjHa96vMMWGP5mDfoNUeU+qiPSPKzFCBTEE
         Sn/BnEUinPnhXd+RybA1II9k2ojXwQ79jVUXt1woo1xB990yi8S7i1cJ0mYSIjrIQNWy
         JT5W/QrIXXuiJD1Ffn8JXiSIHLeqVTKjfZq7bYt1hj1h1hMHFxxuJSQOYwium82uRGTT
         sOPN3xT4ITaqIhfEt8gbJzJo2oN4PtVMAdlasVeP30sgQjM3hDiIyflqsqr8QwHbnZYe
         mjYwVYpqYLHQaoKlFMJyYjwkLx0pRT1cUworUoYsZG60mXLjYuXr13zgoyog7N3XM9QI
         3jgg==
X-Gm-Message-State: AOAM530J+sdJ97vd8Dfdf23oTh0algjo/++c/b0ZQeDdRncgptxZ0ftL
        9QK1KOxoUG2cJvB4EfwqANo=
X-Google-Smtp-Source: ABdhPJyMKmmHQ+mR1LtGofnKzVZSBQVARi0dlfhoCQT7X39eFTFYBwJ52Ckga5KRPHl9sp8NnBTsCw==
X-Received: by 2002:a17:90a:e541:: with SMTP id ei1mr28853250pjb.189.1623202391406;
        Tue, 08 Jun 2021 18:33:11 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id v14sm12659815pgl.86.2021.06.08.18.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 18:33:11 -0700 (PDT)
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
Subject: [PATCH v11 16/33] counter: stm32-lptimer-cnt: Add const qualifier for actions_list array
Date:   Wed,  9 Jun 2021 10:31:19 +0900
Message-Id: <785e0daa3633923ede42394f423fcf94c4469154.1623201081.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623201081.git.vilhelm.gray@gmail.com>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The struct counter_synapse actions_list member expects a const enum
counter_synapse_action array. This patch adds the const qualifier to the
stm32_lptim_cnt_synapse_actions to match actions_list.

Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
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
2.32.0

