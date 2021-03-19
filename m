Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6943341AD4
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 12:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhCSLCw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 07:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhCSLC3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 07:02:29 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21ABC06174A;
        Fri, 19 Mar 2021 04:02:28 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id v2so3425404pgk.11;
        Fri, 19 Mar 2021 04:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ecJ7k92m0DfcFt1BeccNAFge0TH40D/RcDRWwVj9l7I=;
        b=ZuFxGxChMhbMQg9PTqZGvyF/6ZSct7w2HVa1tbkOA+RI4ELbrcroE/QsWUJ8FWGtav
         VAH9QUmbHgYiMQddnw8ql5IxvAxD7TgqqgnG8Hs19A7eXklWhQ5xK8IzhhEhQYtccTt3
         uQ97mMm1YymTR/PXHxCeXl6rgwDy/JVPf/TJpgM0KSs8XSbx97yInEYiw849KHrcfSq1
         j22A4M8j2yf60az58Pvgi/61KLi1C+dnQS46BWdpD8yeV8hyKSAhHVYFIW8VLVCT1Hmw
         U96wffI+Doe05LNhBAKYs2nvluOuk7rlCkcXwrv33GNw8Nv8Bzp6y33TN+KJN59ldWhS
         K6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ecJ7k92m0DfcFt1BeccNAFge0TH40D/RcDRWwVj9l7I=;
        b=May0JPufjSav1q9r9npg8w8Jc2x85vebP301gQ/aJUIyHQDaFp0uKv7F3LTPGZi9zy
         Up2o75axePkp7bUSbp/ceIH82leKQNE0QHhmrPLXT2XQdLS/Nh3jZF/vMRmPpOn/zJi2
         GKj2K7yGadT7yay+CWIlAnmTJwde2+Fms50rHCSzvAua4tbfZvP+T6hpwFQuvoYD9hEs
         foaIwVaHmF3vKfPC5Q6NhWa1nTHUBy9AZQLKs0g33ub5weuXk/UW1D+nXJv27x39wZdz
         PvVba43TsWeNVVkkaZyK7x3vX0qKcaebxNMYoFVVHWHOqMTJKc2mTvRmCj/sYTY59nOJ
         U1Zw==
X-Gm-Message-State: AOAM531b7LB3yBk74hMGYkC8tmjBetC9eP65nuq/cSBhnKX5cXf/mctw
        rW0hHWFAldoxbiemyHT98q8=
X-Google-Smtp-Source: ABdhPJyZPrMcXR4vbb26JH5SvHP8Hfz8rE8wKT84uf2aNvKA1Glc39Sz/S7jRC1NXOOl/uy6/t8c4w==
X-Received: by 2002:a65:6a43:: with SMTP id o3mr6751137pgu.297.1616151748594;
        Fri, 19 Mar 2021 04:02:28 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id i22sm4879042pjz.56.2021.03.19.04.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 04:02:28 -0700 (PDT)
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
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v10 17/33] counter: stm32-timer-cnt: Add const qualifier for actions_list array
Date:   Fri, 19 Mar 2021 20:00:36 +0900
Message-Id: <87c00aa93ef03c058cbefefd5b8ab26ed51098f4.1616150619.git.vilhelm.gray@gmail.com>
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
stm32_synapse_actions to match actions_list.

Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Benjamin Gaignard <benjamin.gaignard@st.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/stm32-timer-cnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 0c18573a7837..603b30ada839 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -267,7 +267,7 @@ enum stm32_synapse_action {
 	STM32_SYNAPSE_ACTION_BOTH_EDGES
 };
 
-static enum counter_synapse_action stm32_synapse_actions[] = {
+static const enum counter_synapse_action stm32_synapse_actions[] = {
 	[STM32_SYNAPSE_ACTION_NONE] = COUNTER_SYNAPSE_ACTION_NONE,
 	[STM32_SYNAPSE_ACTION_BOTH_EDGES] = COUNTER_SYNAPSE_ACTION_BOTH_EDGES
 };
-- 
2.30.2

