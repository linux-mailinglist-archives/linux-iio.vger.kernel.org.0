Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC6A341AC1
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 12:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhCSLCW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 07:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhCSLCJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 07:02:09 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E26AC06174A;
        Fri, 19 Mar 2021 04:02:09 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gb6so4485374pjb.0;
        Fri, 19 Mar 2021 04:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o9szktyqVt36+WoTRvGFyjpFpuwX5mGOXWZAwxNI2o8=;
        b=EMmwrsrPY2L44xoGNJiGwrnlZa+lwCO8CezAqpflW1G8p+ctWLKic5p2ddU7hWwSfj
         AoqInfEQicqM0k1Kp5hbJ0YYztbI+LSnP5MRSbibyFqFcwdrT2JYDpYBAprhKkQDz9JF
         PXAcwaPTqcSE4451deTVvkHAs58NEg38VmsOK1vvUVvYIIO2EoRH1ouqFWt31kg77drP
         tsGPHvE0VL1P9ple9PkCaThQPxIcLWrDueIPEFUG1n2QYCayBsOxL8nEGyAqcn1/DSD4
         W7bpY2PjwNKI8UTJgmtik4Ueo/86b2UyJ+gOVIqa5pY+/ChN1bOx0kFxtEIx1UTk4NYT
         3jVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o9szktyqVt36+WoTRvGFyjpFpuwX5mGOXWZAwxNI2o8=;
        b=CXwZz8fkSUdn+B/wYH/q6GxYe1wyHdpSSuBy5SG3bGxsO7CiX2/hKF+olVrshlt0vn
         FkWFtA9Tz/YV1BjhxhpMsUl4oao5EAsFsPgZkatYMccUNjR/Fs6LWpHv2/8bzhef0RT9
         DqGS3+901XpewjWdmThjapQz2eBRUTg0kKaAb522ghpj8mDBjkPlZ7Go1JxeJVLNw7OV
         biRXFXUDCSJUESni0nkzx0I9ltu2mIJgXCoE7nRUwprMaMr6owOmJIb16mwINSRsEa1q
         kmFoBvwiEBVuPKmApWA4K55FUJv2K5I8wP/abnjydkVFqx8okbUWqIG/vrQuVG5rCvpm
         n5FA==
X-Gm-Message-State: AOAM531wAwR5yuvOFVP4NkGEmpjS7S+h8HMztcef60kMb53ggyKc4LWR
        ZZv37yuxa4Ees1JrsvmMnY0=
X-Google-Smtp-Source: ABdhPJxL8b/9G2djwsqj4texkb9XQeo1yDBgnCWHkTsY9yJ9mzWyPkA7BuNdLizCBhAJs7phJW3isQ==
X-Received: by 2002:a17:90a:d911:: with SMTP id c17mr8789491pjv.98.1616151728644;
        Fri, 19 Mar 2021 04:02:08 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id i22sm4879042pjz.56.2021.03.19.04.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 04:02:08 -0700 (PDT)
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
Subject: [PATCH v10 13/33] counter: ftm-quaddec: Add const qualifier for actions_list array
Date:   Fri, 19 Mar 2021 20:00:32 +0900
Message-Id: <26cb41a51178856fa99e2d8e1912dc9e4a37b605.1616150619.git.vilhelm.gray@gmail.com>
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
2.30.2

