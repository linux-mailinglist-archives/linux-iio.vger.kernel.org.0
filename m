Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DB2341AD0
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 12:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhCSLCu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 07:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhCSLCT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 07:02:19 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFBDC06174A;
        Fri, 19 Mar 2021 04:02:18 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id f17so2786856plr.0;
        Fri, 19 Mar 2021 04:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lP4DMV1k2SKwBGG4XgbDMs9P1GWZ9vtwOGQw009rdwI=;
        b=KXlYrHJXMRHv6/1HCs2KIjiBVTKWFcJfWoq67AacvPXMLIx+iRiPEyXQpwMIqLG7ou
         Wcd7Zj9VztkSNbvD3Gehrs7eVsyKUTEwfZBgHJl3cYLBe0X6X1vTdIMuiLP2wpzXSqRY
         Rlm2iL0l0mtBWVcW5IHqZcpor5yYkorjL9n32skrpRf0N1Uf5OgO+cCKI0VKIY7+c0du
         VPNSz3dd+Il5jrGCtorVnVWMKLrTPn7HmHaGqs7FhZH/j6zG7Kzr+g2AW8UNE61/BLY0
         nq/D1ajtYgjR435gVplkiX57/0+lormJ9Nm8RgkTghuZGJisD4o/AsiBX+cD2+lzwHKo
         EkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lP4DMV1k2SKwBGG4XgbDMs9P1GWZ9vtwOGQw009rdwI=;
        b=mxWLmLLTFSEeRTp4srU+7XLGRMP8I38X3uLDGYdYlhpFzNe831TJadrPz0kurMuMwp
         K5p61xyUsrOrSQq2g+FH7rlOxaQIah1GtNh8eA3GliHlRB8e4yjn3hRmOvnFxKmg1JrC
         49K6wC8pWA+NiyCTy2t4Ug0sHP+Mrw7Jh4FyCPuAoOrrAy8HG5BMXSfbae24kGmkyGcG
         vng9kLP+AKmMw5MKYnDrjFwrHWEBz+ueGQ6grLVuDDx16BiIWKmrSw2ajM8ydeaBBcXm
         4epbdjKAVqbpHXQRwF3np7Etr7T80q/INuk9NFBT3AIv1EPOo8OBgN0mplgyATafZ+Iw
         qGYw==
X-Gm-Message-State: AOAM530HA+8fFYu8bjf6ydYZ8TeBie29GHCZTwdmTJeoKd7HzoT2BXKs
        6AiSAbCNa5+FSahV69jWBsI=
X-Google-Smtp-Source: ABdhPJyLCSHLBNb1i1M1D6923w5s3KUyG3J7/Ct9odrQ4EqOHGCrgICCXj/iH02jQFwP21RlrYmnDQ==
X-Received: by 2002:a17:90a:69c6:: with SMTP id s64mr8922168pjj.37.1616151738483;
        Fri, 19 Mar 2021 04:02:18 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id i22sm4879042pjz.56.2021.03.19.04.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 04:02:18 -0700 (PDT)
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
Subject: [PATCH v10 15/33] counter: microchip-tcb-capture: Add const qualifier for actions_list array
Date:   Fri, 19 Mar 2021 20:00:34 +0900
Message-Id: <5043d74887ca245274e535633a8eb472f690bb7b.1616150619.git.vilhelm.gray@gmail.com>
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
mchp_tc_synapse_actions to match actions_list.

Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/microchip-tcb-capture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index cabcfebfc799..51b8af80f98b 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -49,7 +49,7 @@ enum mchp_tc_synapse_action {
 	MCHP_TC_SYNAPSE_ACTION_BOTH_EDGE
 };
 
-static enum counter_synapse_action mchp_tc_synapse_actions[] = {
+static const enum counter_synapse_action mchp_tc_synapse_actions[] = {
 	[MCHP_TC_SYNAPSE_ACTION_NONE] = COUNTER_SYNAPSE_ACTION_NONE,
 	[MCHP_TC_SYNAPSE_ACTION_RISING_EDGE] = COUNTER_SYNAPSE_ACTION_RISING_EDGE,
 	[MCHP_TC_SYNAPSE_ACTION_FALLING_EDGE] = COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
-- 
2.30.2

