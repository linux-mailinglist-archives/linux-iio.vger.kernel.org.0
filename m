Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7636341AC2
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 12:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhCSLCW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 07:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhCSLCO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 07:02:14 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF571C06174A;
        Fri, 19 Mar 2021 04:02:13 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id o2so2785030plg.1;
        Fri, 19 Mar 2021 04:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CzS3NlE62IcJjUyZ5qk3czC9f+XUZUeA9uXPPXXnAM8=;
        b=dtjQRf0CP07sJ2z6Eneel0Gon/lsArlDmbRz3ilHaaIf6tLCjQ75zJ+hQMh90HxX7+
         Im7ilddYq70zNTOEkZLRerrCW6QT+mlit1re7YhLWszt/dg8BNF5l/0t2BhlmT9DAUt1
         pWc4sKTXeqHAUym9rdNfJjrIuUjaLSKAmPUjt+fgSVi9lZCyOY6lqnevZj2X8cmtD+FR
         miZoYmsDlr3U/4i9GhNt5If18c1KXoect8VRsOkuembFBKk/MYFcpCe02muVPltNyr+C
         qZ5EY2SwIDq0UQW9G8kF8t5wwbZ8N1Mfa2Xilw+RXrmSlIJZgVspwC6uXCfF3QFy4vp1
         3pkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CzS3NlE62IcJjUyZ5qk3czC9f+XUZUeA9uXPPXXnAM8=;
        b=haz9i7FkrCnN5rohFBN8x075uWZCkxWADo4QY1vAnYyji608gXOzCufWbcydfD0mkn
         eGpDXZsuMTyXiuQfx1f36qisl6Lz+XnjAm7BkhajvxjJFafPjYcYvN9+sV3PLculJthI
         F4ucehcFaMHue1lapKCO8FUAGUzZofvkwiMEAOp3yoZ0aPB93XesvLWkQWewKMi43uPd
         3sqMsVYww4iVDK9CsPsSx1A12BHo+ULzFSetECU5xzOONX/LgXc0QAuleQ5uQhMNCOw4
         +7HwsBHwVzgcMxuqamOsrehMiNHbxE2SXRymz5p/HcBEXh7rWm09VWsv7tfuTKGPYFs+
         dlEg==
X-Gm-Message-State: AOAM5307vFFpt8uP/jgh1LQvJZU2e798Df1xMgik/iij/CYywt9gsPO2
        C/uzuIPfRMNIZ4PndcjRya8=
X-Google-Smtp-Source: ABdhPJyq+X+ih+kVYAP/TinmHgoIzLZQepjdalrkaduhO8V2BqB+ieMb4gPKsDDBHOEkNy1Gvl3YLw==
X-Received: by 2002:a17:902:70c5:b029:e6:cba1:5d94 with SMTP id l5-20020a17090270c5b02900e6cba15d94mr11170116plt.84.1616151733578;
        Fri, 19 Mar 2021 04:02:13 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id i22sm4879042pjz.56.2021.03.19.04.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 04:02:13 -0700 (PDT)
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
Subject: [PATCH v10 14/33] counter: interrupt-cnt: Add const qualifier for actions_list array
Date:   Fri, 19 Mar 2021 20:00:33 +0900
Message-Id: <961bd5450371a32492d5cb189ccfdbe7d9160975.1616150619.git.vilhelm.gray@gmail.com>
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
interrupt_cnt_synapse_actionss to match actions_list.

Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/interrupt-cnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
index 827d785e19b4..0e07607f2cd3 100644
--- a/drivers/counter/interrupt-cnt.c
+++ b/drivers/counter/interrupt-cnt.c
@@ -77,7 +77,7 @@ static const struct counter_count_ext interrupt_cnt_ext[] = {
 	},
 };
 
-static enum counter_synapse_action interrupt_cnt_synapse_actionss[] = {
+static const enum counter_synapse_action interrupt_cnt_synapse_actionss[] = {
 	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
 };
 
-- 
2.30.2

