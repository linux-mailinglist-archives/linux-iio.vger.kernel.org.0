Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF5A319E1F
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 13:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhBLMPi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 07:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhBLMP1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2021 07:15:27 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8321C06178C;
        Fri, 12 Feb 2021 04:14:40 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 81so65819qkf.4;
        Fri, 12 Feb 2021 04:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4RVacsqoYzmylNKCath3c3Ne8oWPnlwk8NYh3tn8zeA=;
        b=SKctp4vDgTsV14fVKI7dhcglVl2L1UAIHQ/X/m4dhyJAABbwmQIbaHLQCJV0LfpTNg
         9QGhruNMC84onXhOn1rLtQD4JFNzmReZndfh6wDUcHzvjmDxvfMpOz5M9Vsph/RE5cad
         BmB90edCp+b5pgdhWxp08y1zSRWSZRrhLlKg26/XsPy6H580e23NRioA9rG25ER/fHUq
         6aCc9iN9h6RQcgwtuGrvn1kBXuhLfDfLbNt4eNqduF+6iHhx5zcYWsE12yuwhoeOEiDu
         rQ/8qWqSVjmUFqiMoTx2jJ5R5upBh+b1dXfxZkPcSMVF/u4QwuxQ/DdEnDFQGcPhbJVd
         Wzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4RVacsqoYzmylNKCath3c3Ne8oWPnlwk8NYh3tn8zeA=;
        b=iNFJ0vqgGLxOi7o+PU2HudrkS+j2QBqgL5KVkej5oeQC998qUbYdwRj6bqiQbD5VJo
         4CD5kFVfUZVFEBls0SRax0BFH6ut1guRIfdMbmcg+lLAobALpL4xGCAq5h/aYjNdOVnq
         M+u4TOq/hdbAYM3PczYXzTSMkk7NyuhqB4qMVkrzLKVWGIecS/AQ8keCDEsAzK2J9uAS
         4XZZeo7ho/LSXhosavoDwcSHoNUkf+xXrxTCQpTDdh38LkfBs8tCsYYXG6b8fQjSEYt2
         HF2FA8jeA/8W9E8/K0VDR3AcOVxBYjrpMzrYk6IHsXfamkfESSQj0AagSS2btSf3L1Bc
         K1Fw==
X-Gm-Message-State: AOAM530HlclXg7qpbQfocIz8Y2vaqC0yMs+dUwm9MZO1k+XNddoWXAiM
        P/8nma+qKHFRy3aFaZ+2Wnw=
X-Google-Smtp-Source: ABdhPJyAo21v5popAcAZAA/3yEpMI6qCZtg0s/4jH5oGtDgCZb40rgb3q4w+8k/AySBSxaYjvVEV0w==
X-Received: by 2002:a37:6484:: with SMTP id y126mr2179765qkb.430.1613132080125;
        Fri, 12 Feb 2021 04:14:40 -0800 (PST)
Received: from localhost.localdomain ([193.27.12.132])
        by smtp.gmail.com with ESMTPSA id y135sm6278534qkb.14.2021.02.12.04.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 04:14:39 -0800 (PST)
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
Subject: [PATCH v8 07/22] counter: 104-quad-8: Add const qualifier for actions_list array
Date:   Fri, 12 Feb 2021 21:13:31 +0900
Message-Id: <0ae8373f4e587981a409a36cfea70328b5153ed3.1613131238.git.vilhelm.gray@gmail.com>
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
quad8_index_actions_list and quad8_synapse_actions_list to match
actions_list.

Cc: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index af4e0503b074..9a96296b0625 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -305,12 +305,12 @@ enum quad8_synapse_action {
 	QUAD8_SYNAPSE_ACTION_BOTH_EDGES
 };
 
-static enum counter_synapse_action quad8_index_actions_list[] = {
+static const enum counter_synapse_action quad8_index_actions_list[] = {
 	[QUAD8_SYNAPSE_ACTION_NONE] = COUNTER_SYNAPSE_ACTION_NONE,
 	[QUAD8_SYNAPSE_ACTION_RISING_EDGE] = COUNTER_SYNAPSE_ACTION_RISING_EDGE
 };
 
-static enum counter_synapse_action quad8_synapse_actions_list[] = {
+static const enum counter_synapse_action quad8_synapse_actions_list[] = {
 	[QUAD8_SYNAPSE_ACTION_NONE] = COUNTER_SYNAPSE_ACTION_NONE,
 	[QUAD8_SYNAPSE_ACTION_RISING_EDGE] = COUNTER_SYNAPSE_ACTION_RISING_EDGE,
 	[QUAD8_SYNAPSE_ACTION_FALLING_EDGE] = COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
-- 
2.30.0

