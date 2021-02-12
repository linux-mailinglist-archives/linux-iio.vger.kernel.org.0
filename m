Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7143E319E1C
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 13:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbhBLMP1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 07:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbhBLMPW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2021 07:15:22 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E1EC06178B;
        Fri, 12 Feb 2021 04:14:35 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id dr7so2268951qvb.1;
        Fri, 12 Feb 2021 04:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZF5NYOTPzb69Gy7SXzsmlFc2ufq8pLJB8ZkxKUF4FAI=;
        b=Ga3mew42ijkMgzZTymuZhgziBa7GfGyxP/sUENT/oaQm4Ks/rw54Vb/MEAgxCVIAuP
         xpd06dY2jnPYYUE9RETNoYnHuHFp3e+0+/POzIweMNWkSW0MjoHwIWUnMVLLGZaxxTh8
         cEk0G1RBGM5U/z6HNt1wy94+gmYRo7tvaMzAy2rv6WMUa1hFaiFidBMa1zxWfi9U0Ewp
         QQ6KaHAWRisgavcUS02nf8wCLHBQsVlJaAmM5soKtI3Bu4VERuX9slcHYfAgeH0MwiZV
         odm6K0SR1fDGBQEXYQrdgpuGgvUccmvBmZsvK/S+NKjyrJd60a+sj4f5rYcWmSWYQFCN
         tnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZF5NYOTPzb69Gy7SXzsmlFc2ufq8pLJB8ZkxKUF4FAI=;
        b=IOWdsG+NvdgjRPVX+D0BwBtqyT4/RRMjYEHIUCqF0etMfghxvnLBVgrf7GheOYua0+
         A5UPoDTdbfMciw5XQbQVUsJcsezJmBEkeRLzrKPPJLw+U8sDEhMUnTr1SJWsJuvL6+cF
         A86ApZFyKrpTgh/DRVkQhUWgHF95Nn9/b1AUYLOpZW4rWQmNHmkqYkZC4vV6vAMdld2D
         U+4PpaKljQTvFWWghHQ+NB1spcCE+qgjg+vjn9Kovq58AtBEqu8PCMqE/gsZjnU1pE1y
         tb9Q3cgt7hJ8Oq+oKpPYhPNSPdzHD48wTIJfHBop9ZTZZa2AFtEbtQsPbWOgp/aZCuSq
         BIag==
X-Gm-Message-State: AOAM530qiHbldIt0VpuIerDrkZdk/UC8XboU9S0jah9PQ12mfCUS4577
        RNvfVA+z/N3LqF9SXYL9ltg=
X-Google-Smtp-Source: ABdhPJxXtUVkYuMwGjYX4LL7Bmxk+a7OIIF7oZBwaewzQOS89EHeFy3G5Es/jtwqWQBlAOihBPa9aQ==
X-Received: by 2002:a0c:fcc4:: with SMTP id i4mr2247752qvq.57.1613132074308;
        Fri, 12 Feb 2021 04:14:34 -0800 (PST)
Received: from localhost.localdomain ([193.27.12.132])
        by smtp.gmail.com with ESMTPSA id y135sm6278534qkb.14.2021.02.12.04.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 04:14:33 -0800 (PST)
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
Subject: [PATCH v8 06/22] counter: 104-quad-8: Add const qualifier for functions_list array
Date:   Fri, 12 Feb 2021 21:13:30 +0900
Message-Id: <74ca1dd85fde4356fe403a524b502282abf4467b.1613131238.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1613131238.git.vilhelm.gray@gmail.com>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The struct counter_count functions_list member expects a const enum
counter_count_function array. This patch adds the const qualifier to the
quad8_functions_list to match functions_list.

Cc: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 70383b792ec6..af4e0503b074 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -193,7 +193,7 @@ enum quad8_count_function {
 	QUAD8_COUNT_FUNCTION_QUADRATURE_X4
 };
 
-static enum counter_count_function quad8_count_functions_list[] = {
+static const enum counter_count_function quad8_functions_list[] = {
 	[QUAD8_COUNT_FUNCTION_PULSE_DIRECTION] = COUNTER_COUNT_FUNCTION_PULSE_DIRECTION,
 	[QUAD8_COUNT_FUNCTION_QUADRATURE_X1] = COUNTER_COUNT_FUNCTION_QUADRATURE_X1_A,
 	[QUAD8_COUNT_FUNCTION_QUADRATURE_X2] = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,
-- 
2.30.0

