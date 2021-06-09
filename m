Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9EF3A0923
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 03:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbhFIBey (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 21:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbhFIBex (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 21:34:53 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950A1C061787;
        Tue,  8 Jun 2021 18:32:48 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id v11so3204473ply.6;
        Tue, 08 Jun 2021 18:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lJOl39aSDR3XMZTfLJ4I1sJIXKWA+Mc9CKAY9Y1edUw=;
        b=N4BtFt7FKmHJOsOu7wd8wbYhg/V8Iacpd+LoaodYrH47vUearjxlWzr6UXsS90bxNN
         qE3x0WSNUL+PO3Ugc5kt0LAwiszsQi4E1xZbTp1ouAX82RTkCoRY+HTeEIsMkJS497hl
         7pElnbcH23GzUaPNzETgdXVQN0mxQ/nQM+75UUysaQrmmZSjbhDDD+ovl7rA8iEFEfzJ
         jjPCPTx+2YjXJ3D+0l2uFbPOfZaB+uwcDv42iYxs6Dh6Q3Jl3rPwEo1d+ecP8a/iEfPf
         BPdyAzAO71tfgOth5dCS+vdb3G0KYAuxMdnydZ+1/L2qxUYV+nhhdvNW70NHVr371wZc
         CDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lJOl39aSDR3XMZTfLJ4I1sJIXKWA+Mc9CKAY9Y1edUw=;
        b=knaeYZNi9yYJUFC2I1TiszWq990rI8y8709ETwzQ1dYrhvyuXY2dqCqCl4jh2zub0W
         1lw5s7E1uSkePi0NWLhwR6HHjWhWPTUXUrKyt0KH1cAnRvT5aSae+2lY6tSrIoc8m9FL
         uYWZu+vJImSGyGDMoTeNr9+sCB4mKtoxnfkgF78eFDw3owQQnrRQH4pOtfJi7ggnHSsy
         RAhu3pfIMTQNrgX+XAM5PYzvpPS/FVUTEGbVdmd1OsFUq+FqjsKxg4rWVzJIN+PKOzr1
         C86+WP2WWIczj2wQlEaqljOBKFhMHm8xmmd7UlH8rviU+Vo4glFWmM+mYzklQqREaR/g
         onbA==
X-Gm-Message-State: AOAM531oeargfLylSEud4+TEInTUZ/MR5bK2WNKdebQnC4rqkvl1YwOl
        M3i0eiRRmKW6+lvOtn4PA6w=
X-Google-Smtp-Source: ABdhPJwDjSkwZmmGs7WYbwxZ9wlvEo3/cwEjTyNpABkfh5ykOFVRM2a3J6ExtQshEWSpp03qwauVMg==
X-Received: by 2002:a17:90b:8d6:: with SMTP id ds22mr29635108pjb.54.1623202365659;
        Tue, 08 Jun 2021 18:32:45 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id v14sm12659815pgl.86.2021.06.08.18.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 18:32:45 -0700 (PDT)
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
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH v11 11/33] counter: stm32-timer-cnt: Add const qualifier for functions_list array
Date:   Wed,  9 Jun 2021 10:31:14 +0900
Message-Id: <46a1e7096dd9280d8f241894186b3c903956a55f.1623201081.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623201081.git.vilhelm.gray@gmail.com>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The struct counter_count functions_list member expects a const enum
counter_count_function array. This patch adds the const qualifier to the
stm32_count_functions to match functions_list.

Cc: Benjamin Gaignard <benjamin.gaignard@st.com>
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/stm32-timer-cnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 75bc401fdd18..0c18573a7837 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -50,7 +50,7 @@ enum stm32_count_function {
 	STM32_COUNT_ENCODER_MODE_3,
 };
 
-static enum counter_count_function stm32_count_functions[] = {
+static const enum counter_count_function stm32_count_functions[] = {
 	[STM32_COUNT_SLAVE_MODE_DISABLED] = COUNTER_COUNT_FUNCTION_INCREASE,
 	[STM32_COUNT_ENCODER_MODE_1] = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,
 	[STM32_COUNT_ENCODER_MODE_2] = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_B,
-- 
2.32.0

