Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DD3341AB9
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 12:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhCSLCS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 07:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhCSLBt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 07:01:49 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE49C06174A;
        Fri, 19 Mar 2021 04:01:48 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so6546124pjc.2;
        Fri, 19 Mar 2021 04:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wYRkXjsb1PVUWcJtSf+4c08/zRkX/J8HBJAhSg6Bbvc=;
        b=n7oeCws7sjZvBebyHE7fBiK6RqTLulu55vDhMPuOzayEz6rz+d1gs3fVWFOtfrJ62e
         toRYYupwhq6QMZ5DL/ZttFp2LB0dIA4DYRM8vCsiVJBqibRMSZJ9aKWhzqptHY2Uu/e2
         OCWOrGDxQ8lNJyRInF/2dOcoyCNxLFJx7Op7QtC2eSoui30LlusueFXfj0813mUgDO1s
         Cyle8ufF1veYYkQltfkhXjr5Zq2lMjcsaOvqM4H2osxFTnzc6gE/RRMgf5IXRAPb8+l9
         QrBSx+4OsUTFOd/rRATdLLUJ6IKwYArS0AZEJ5j7S+L3tJSJ/GP1mejYNihDbI33ikBq
         pmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wYRkXjsb1PVUWcJtSf+4c08/zRkX/J8HBJAhSg6Bbvc=;
        b=ulc8kKnjGrjwKDRFCjtDN+YQBb8Tm4H3HQ5w+VvbuqVJbtG4M6iCfyT1hqZYS9VdHP
         lulw6tW9IK6EUQktSoYYQJSx4nkNmNne2hxpEASIjt1fdz3f6/zHAtN/zHBghikSkhcK
         hcId+UIXIEq0zdHfUlJ9ECcosm9+iqmNYH2e7aYGulUpzwG/CK4/S2wpJM8NJ7GlHy7I
         7wCyjvt75JyTNh0qhtlyoy5xCC35sC8dcBiLJbfp9AOFAQqghvX6Mn5+0aLuJTuPDVGq
         LhFGmlWiZrVXbdcycAnKLPhfP3X8MW34FVNRuFNWvRgx+ggJJk1WTy/GN5aDFJHCqFwU
         P1vA==
X-Gm-Message-State: AOAM532u91VwSiNMEtjSbG1sGJt9op0GFJWlQqSK/2FBF2vmic+RTci3
        6I34H9JGT0DAIRez6wdw81w=
X-Google-Smtp-Source: ABdhPJzLKllTLseOaGqWk7ZaQmgb/qzKLLE1uT5g8JgA/XofhROJiz2cVxQ4Lv0hd09wd8lboU/QnQ==
X-Received: by 2002:a17:902:7609:b029:e6:9f29:625f with SMTP id k9-20020a1709027609b02900e69f29625fmr14284842pll.80.1616151708526;
        Fri, 19 Mar 2021 04:01:48 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id i22sm4879042pjz.56.2021.03.19.04.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 04:01:48 -0700 (PDT)
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
Subject: [PATCH v10 09/33] counter: microchip-tcb-capture: Add const qualifier for functions_list array
Date:   Fri, 19 Mar 2021 20:00:28 +0900
Message-Id: <130ef8380b67430aed17ecd938e6460e73f80058.1616150619.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616150619.git.vilhelm.gray@gmail.com>
References: <cover.1616150619.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The struct counter_count functions_list member expects a const enum
counter_count_function array. This patch adds the const qualifier to the
mchp_tc_count_functions to match functions_list.

Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/microchip-tcb-capture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 710acc0a3704..cabcfebfc799 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -37,7 +37,7 @@ enum mchp_tc_count_function {
 	MCHP_TC_FUNCTION_QUADRATURE,
 };
 
-static enum counter_count_function mchp_tc_count_functions[] = {
+static const enum counter_count_function mchp_tc_count_functions[] = {
 	[MCHP_TC_FUNCTION_INCREASE] = COUNTER_COUNT_FUNCTION_INCREASE,
 	[MCHP_TC_FUNCTION_QUADRATURE] = COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
 };
-- 
2.30.2

