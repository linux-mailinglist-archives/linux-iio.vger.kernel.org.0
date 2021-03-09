Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C1A3326AE
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 14:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhCINVb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 08:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhCINVT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 08:21:19 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD39C06174A;
        Tue,  9 Mar 2021 05:21:19 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id w34so7691000pga.8;
        Tue, 09 Mar 2021 05:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t3RYDFFjHkpdIJ04TsWBr8TmaLo8cU+WLWiTJPwxr6A=;
        b=cPm80utEO4gK7NjFC0zhB5gCOPQtq5RrNUNd9cA58RKV54Pyfn5Ple+ImuNJKzBvpt
         n8wndmxhEJq8BsaC+on7Q07Q9RHLFCNoxNaPe97INCetElIrmTqsj+Bwb9lPnVIRGw1g
         Un727QcUYB5HiVK+udGrEKeO9EX8vCZYnIbjKJWtph48VCX2XFggT0wmSwc3TO0ybB5z
         CBXoOaDrVfuxpGeV99w8q8QegdY1RsYgGuSbz9gBE4n6XusXJbjRBb1RvX4eDWh0EO4l
         K58k5bv/48LTWLNqywOg69rT+vHYe/T9mxJJjOsyCGOR24wHn0wqcfvJkzzq0n+h9zZ5
         wnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t3RYDFFjHkpdIJ04TsWBr8TmaLo8cU+WLWiTJPwxr6A=;
        b=nHx1J2jp7uUmz3YSy/zap8/+7HjrZ6AOg7BN9+piOF0qlEaBMeAJSI4MEa2hz5y1SC
         uIP7G5blD5Aw/RDifzfMQHnTYVaFgOVcM3UR66Bi9+y72W28orHVjOkg1nP7/EvVOE+W
         w7LxNuFry7c2wtu5NZqPs1yXis7OfgLRXIWWix5gYKO2lH1Ks2t8bblcjd0fFe/+Bs6T
         DHT2UoecmyWnK6AqJIffrZkm7WGXGh3IgNBCJKf+96qGGs+AvsqgiHLv2yHBqfvyk6f0
         rYmElM+/7f1I4Xg4h+kNzx3/4AE2Jq5EBiN++7BFvhm1v+VV55h8CccrlwlQb8/bfnoG
         hDGQ==
X-Gm-Message-State: AOAM532ZEO8hhM/QmSPY2l5f3f7ZwZ+cB9hFw4z4pBW6AUkkRre9NXqJ
        /WbDd2PGyTabC8T1CNZFfbNhNOG9frDaXA==
X-Google-Smtp-Source: ABdhPJzuf+IfHPoOevXWiR5Tex/ci8k9Iu42/LT75i/JLS8DvEf89M7PROm+OH0amxUz5yHaHNf9Eg==
X-Received: by 2002:a63:d242:: with SMTP id t2mr24853367pgi.431.1615296079245;
        Tue, 09 Mar 2021 05:21:19 -0800 (PST)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id y9sm7647421pfl.201.2021.03.09.05.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 05:21:18 -0800 (PST)
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
Subject: [PATCH v9 13/33] counter: ftm-quaddec: Add const qualifier for actions_list array
Date:   Tue,  9 Mar 2021 22:19:26 +0900
Message-Id: <e9656724c31451a736d623920317b2e40524fa54.1615293276.git.vilhelm.gray@gmail.com>
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
2.30.1

