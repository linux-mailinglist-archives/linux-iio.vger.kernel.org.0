Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267CF33268D
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 14:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhCINU6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 08:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhCINUr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 08:20:47 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66DEC06174A;
        Tue,  9 Mar 2021 05:20:47 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so5189533pjb.0;
        Tue, 09 Mar 2021 05:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zj7+sm7nk2JUK10WGHF14mMymh0P+kdsvv/edNpXnVQ=;
        b=dr1NBz1sIQAoYrrUbrRdkjOj9yhfd+zFT5TTFhG3smfCVNmH9EJ+fW/RiBfPXdYJCz
         KMAE5GLHZYPIP9vCq7Uua1LiPg9IQQG+GRHW3Hx1HbzjdDfB0SxDKTWwwib7W8IyZcCm
         Ym6Dzq/2XIPH8v0wb4Wysob7fTtAZY1cFZ9vVNBv9rUjqW4mOKCYPoxImr1aRa1jiiiw
         OSrX3TDkO0w9BsbVGwVFO6pSiJ1OAhnuQZWQ+64HbUQyihAucSifjk2iQ/bWlAWzOSgQ
         l4noN+n6Yb9on9upQPWXzpVHI6tGqprEl8odS2YcDAikDBq2+VkhPHxWE6CD0Pxw3mbz
         JhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zj7+sm7nk2JUK10WGHF14mMymh0P+kdsvv/edNpXnVQ=;
        b=mtp2xSF9KaBKbwwfclI1OexbkvAM95843XSJVwTETLgGXUm8MkxL1lczt5Ki0Vta9F
         ZKQX2H1g+Lfm3NOlx+WyiPauC4hHaHT3GFWfsYqMrTAZ9YDidNKoHj4qL7ifR0XuPADv
         6ijTfttJkH09nRNRThUxu2oF7sVih4rWX0XiA+GfexYQvKz8o5bmCeULVuuX0EFP6eFd
         ITGctqgb6nhaKcIWYeF/o9xESx7eMj2E3DZKXHdDiN8az4GvbglJazL847AQU/nyfXRn
         J8HBtFhuzvD0tGorqgB2JcFDaqVRH6Wq1CG6Hh/a4OVjKXpbYe4ud/DLzNhx8mSmD96G
         dVMA==
X-Gm-Message-State: AOAM532J2B9jCPUgOxsM1mGX9v5DdmMg7TY6YV7I8HjsR89wRCHrpPZU
        E+2FkajGxFj1qGF3I5ybYesdASyNbPM4IA==
X-Google-Smtp-Source: ABdhPJxVIxri8CSPeQwEBxpL4lyaoQVUFDNOXibjSAlsHzjikvlIqauj3O0He51c/uXIyeIi0wkRTw==
X-Received: by 2002:a17:902:8ec9:b029:e6:c5e:cf18 with SMTP id x9-20020a1709028ec9b02900e60c5ecf18mr13935274plo.47.1615296047360;
        Tue, 09 Mar 2021 05:20:47 -0800 (PST)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id y9sm7647421pfl.201.2021.03.09.05.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 05:20:46 -0800 (PST)
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
Subject: [PATCH v9 07/33] counter: 104-quad-8: Add const qualifier for functions_list array
Date:   Tue,  9 Mar 2021 22:19:20 +0900
Message-Id: <4d899b2fb1ed37f97f827af5880fdde916c5c4bf.1615293276.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1615293276.git.vilhelm.gray@gmail.com>
References: <cover.1615293276.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The struct counter_count functions_list member expects a const enum
counter_count_function array. This patch adds the const qualifier to the
quad8_count_functions_list to match functions_list.

Cc: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 51fba8cf9c2a..ae89ad7a91c6 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -193,7 +193,7 @@ enum quad8_count_function {
 	QUAD8_COUNT_FUNCTION_QUADRATURE_X4
 };
 
-static enum counter_count_function quad8_count_functions_list[] = {
+static const enum counter_count_function quad8_count_functions_list[] = {
 	[QUAD8_COUNT_FUNCTION_PULSE_DIRECTION] = COUNTER_COUNT_FUNCTION_PULSE_DIRECTION,
 	[QUAD8_COUNT_FUNCTION_QUADRATURE_X1] = COUNTER_COUNT_FUNCTION_QUADRATURE_X1_A,
 	[QUAD8_COUNT_FUNCTION_QUADRATURE_X2] = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,
-- 
2.30.1

