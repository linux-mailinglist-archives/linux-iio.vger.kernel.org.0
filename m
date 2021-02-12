Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBA2319E1E
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 13:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhBLMPe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 07:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhBLMP1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2021 07:15:27 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25C4C061574;
        Fri, 12 Feb 2021 04:14:46 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id o193so8401564qke.11;
        Fri, 12 Feb 2021 04:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wQvnOEOCiwFowILdQGnHkV7MlEe+qaKqvDn1S6Ccy7g=;
        b=bdsQe4Txc9lwEijLlKMFaPEa0e+EzyJkmU6+anMzUqwzXzWjrQXX64zJKXVt0J5UwR
         Sebzf93XCIn8+aRZ3aSRjMh+8Z6VrllNvRhbQKeV5yZH1a4BTDW3PCalIrpOuAykH5kN
         8rhVzzN3PrKmsuEogm98LrAzrgYK9Q+Rr18zR7idWcoa0vQcRT4oW5/Ua80kIxgWK37k
         d2yhgZbOWUHkvIrHsLCHEUfjqs8XP7AbNP5zMCFnX/tlbJpVPlbvXUZx3P1FdD/hsCqA
         WnUvEaIDGn8AZTn4/xcX2rnTujLNcXlfYXIRydGQ6rep13ggvlj0qn3LDZwmzAQx9wxV
         4ziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wQvnOEOCiwFowILdQGnHkV7MlEe+qaKqvDn1S6Ccy7g=;
        b=Nwj66vFLD6Co/M3TeqBZOrMz3VjcYBKu/Wur576Uqv07iCqBeoVgNDN5YQy1aRUuce
         qspSQGDIV/9OyblKYKabGCZtBOYplkaEUm8ZWe9MheVkcYoodmPplpFM0d1vUTsbmHFv
         W4Cc+fcXkZDdd+6nKqQFLJmCl6jKjo0BVMHDCqgpo8Q22WqDZbAbf6Q63M8VNesJVzVF
         gpF2CE60t79+9lAYWKyvmhdgK7lR+YSmDpwYhTkpoFAN+PIyvyj9ZH5hQnCNRfHPwCXY
         YUaznHCNKsWjDLSuB8PjQZiADfT+KRfepvmKDi5kR8MUNbIjfPMDcCvaghaKmGdPPvC2
         a3VA==
X-Gm-Message-State: AOAM531NkZcnmL4SlGZ21oZmC1j5Tx8xkwqtlpt1GD1BBEarO5X50kGL
        mBh++9YtsSHs2TkE5GW8AEU=
X-Google-Smtp-Source: ABdhPJwelSEgslAQWW2y09Ci4d8oryQY/d8G2mwivnjD0nkdPt3Wu1h6AiyrWucXHLu1Rw4Qq6YYTw==
X-Received: by 2002:a37:4242:: with SMTP id p63mr2258218qka.396.1613132086087;
        Fri, 12 Feb 2021 04:14:46 -0800 (PST)
Received: from localhost.localdomain ([193.27.12.132])
        by smtp.gmail.com with ESMTPSA id y135sm6278534qkb.14.2021.02.12.04.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 04:14:45 -0800 (PST)
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
Subject: [PATCH v8 08/22] counter: ftm-quaddec: Add const qualifier for actions_list array
Date:   Fri, 12 Feb 2021 21:13:32 +0900
Message-Id: <9089abe5800ba8a761c6bf1a83e77dfd2686e656.1613131238.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1613131238.git.vilhelm.gray@gmail.com>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The struct counter_synapse actions_list member expects a const enum
counter_synapse_action array. This patch adds the const qualifier to the
ftm_quaddec_synapse_actions to match actions_list.

Cc: Patrick Havelange <patrick.havelange@essensium.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/ftm-quaddec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
index c2b3fdfd8b77..9371532406ca 100644
--- a/drivers/counter/ftm-quaddec.c
+++ b/drivers/counter/ftm-quaddec.c
@@ -162,7 +162,7 @@ enum ftm_quaddec_synapse_action {
 	FTM_QUADDEC_SYNAPSE_ACTION_BOTH_EDGES,
 };
 
-static enum counter_synapse_action ftm_quaddec_synapse_actions[] = {
+static const enum counter_synapse_action ftm_quaddec_synapse_actions[] = {
 	[FTM_QUADDEC_SYNAPSE_ACTION_BOTH_EDGES] =
 	COUNTER_SYNAPSE_ACTION_BOTH_EDGES
 };
-- 
2.30.0

