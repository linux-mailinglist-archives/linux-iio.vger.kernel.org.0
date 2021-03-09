Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B56A3326A0
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 14:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhCINV2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 08:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhCINVE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 08:21:04 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150D5C06174A;
        Tue,  9 Mar 2021 05:21:04 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id e2so1287583pld.9;
        Tue, 09 Mar 2021 05:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UIAVd9muG3GyzUO3PQ0xXOFMJbQ/8NwAgbwz6em0ZRg=;
        b=jW4gcFVXjW/JzLz3cPSkBjbDaBo7tO/oiG724aeK0AHoO05rKqd4AKWvx1if7eAHD+
         fiQSL6f8rZ8ViPuFQkYvAHO4kVlvV0jah/mzK5yD35slTRN4LKOJg0efzq02kONJvhXm
         QuV4bY5t7iLV8WfhAD4MSAeL/U99u3RMbSz9gUrJKK6M4sezn4AbIAPXat7GfNIyQxmb
         58pgasZgH2HmtV6jrHyhMsgl670VOZ2sI+tDluqgnCDCzFm5g+B49Kg7mDdolWgveF85
         2DW5U7GJyhwBacxmVtI8e8VQCaE6nyNuK/z8pg0hxwI1D5ddWFRs50DXcYQ7W9EBegz4
         nm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UIAVd9muG3GyzUO3PQ0xXOFMJbQ/8NwAgbwz6em0ZRg=;
        b=Dciwk5e2L+b4lAVZ7oeUG1cn2PoKL7enhIuSWC078pfnYmqKd2Uh1r9J8E5oX/79pB
         HGlqgNQ5GouPu2AWSFnie3Wf8bMQIkM97N4txIdGQPKnZMyXLs4Vbtlp3x02mxIuyA1Z
         58efyiZKyaLQ8dADyj2Q+Ao1fDymw5HdgWN82qhg2Uac0W1G6A/4Pos0/46Psuq9jW1B
         XI8VO1KMZXPk2RWvKfyBsNpeMGSRyev2SGpS8aD6QqjLqf9oXnYUrsgLYd7kHCz+SC0/
         NNgrZLuPMctLPmRbXEI7laDBI2WNNbIIyA0W9r66wZ7kIqntr+pCBsJWJTu95VgMQ+FV
         6cuQ==
X-Gm-Message-State: AOAM5329ReVvC9LtE0bUjsjAkkFwYQqZ6ovtXQ2iOKuoHUZ+rT/wfwS0
        6tMYF9uLZqNKLOSkVIXtvEw=
X-Google-Smtp-Source: ABdhPJxVXkw9bGWsBjUq7o7hg1B/IvBD9mBlo1XlR95LPUGnVPTey/VSv8pOU7IfUWfxSbINqhwdFw==
X-Received: by 2002:a17:90a:a584:: with SMTP id b4mr4701165pjq.186.1615296063689;
        Tue, 09 Mar 2021 05:21:03 -0800 (PST)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id y9sm7647421pfl.201.2021.03.09.05.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 05:21:03 -0800 (PST)
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
Subject: [PATCH v9 10/33] counter: stm32-lptimer-cnt: Add const qualifier for functions_list array
Date:   Tue,  9 Mar 2021 22:19:23 +0900
Message-Id: <6325a9857d8566c31c6bd7fb3812249c99350fbd.1615293276.git.vilhelm.gray@gmail.com>
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
stm32_lptim_cnt_functions to match functions_list.

Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/stm32-lptimer-cnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
index 937439635d53..0f7d3f1ec1b6 100644
--- a/drivers/counter/stm32-lptimer-cnt.c
+++ b/drivers/counter/stm32-lptimer-cnt.c
@@ -134,7 +134,7 @@ enum stm32_lptim_cnt_function {
 	STM32_LPTIM_ENCODER_BOTH_EDGE,
 };
 
-static enum counter_count_function stm32_lptim_cnt_functions[] = {
+static const enum counter_count_function stm32_lptim_cnt_functions[] = {
 	[STM32_LPTIM_COUNTER_INCREASE] = COUNTER_COUNT_FUNCTION_INCREASE,
 	[STM32_LPTIM_ENCODER_BOTH_EDGE] = COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
 };
-- 
2.30.1

