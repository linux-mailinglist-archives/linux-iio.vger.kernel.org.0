Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701FB3DED67
	for <lists+linux-iio@lfdr.de>; Tue,  3 Aug 2021 14:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbhHCMHJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Aug 2021 08:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbhHCMHI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Aug 2021 08:07:08 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E27C061757;
        Tue,  3 Aug 2021 05:06:57 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id nh14so17615831pjb.2;
        Tue, 03 Aug 2021 05:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q8bVpT2MoqkjornEKoFHBVMieEPYdCJK4XzKGZdm4q8=;
        b=Kf9Q6e/v4hWfe77Y24cfiGiGqTODHtRYxB1tCVdydcmX5UNAj7w6A39opK3yK3Ai9v
         iMTVgUSzDwMw+bV9wewAjZlqmiGdIuZXrlq+QnpF3D64R1aRhi1d+QKYOIBnKG0287Mm
         4QZWYPojQsqGzN7vUCrtO/oQXktRPfOyGEn+Y5CJCkCHdU4faVaxBKv+1P5lBTYBhWxo
         hm4yKkqf16BJAGfHmGq3GyK6KK8isVKHOT5kuAiYYPt3HTaKuvTZVwLmTqKCFJzHEVVH
         vFaIGLz0+pv7q1tAoJFyZnJcc2Pmkt1aknOB3zN1p02v6aOjEUr+ES8JEQ4MnyI6YiAU
         3/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q8bVpT2MoqkjornEKoFHBVMieEPYdCJK4XzKGZdm4q8=;
        b=OnT+p6PzegzQNZNBcts57VhMs7SujTXpeoIMCKBSMwWGlsJYGkzEnHmkdXxh7cMgHS
         y3VS69hv39dehdB0vWyBMS0GQ19mk7+MwkHrw9JEyL0lbdKH1jOFdSYHiLjZMWWVDIsN
         njzCrT3UZouqVt5VdjXPx05Jk8a0sIsSvezjPpWCB1hMiTt9Cu4C2gyaeUMa+N3T9O1j
         Tls32q9SvIUuARn3NDZb1O5P7x4/oLl5UCLyHrHhIMvg5LGr1AaHKsIGWe1WPUO5LaDK
         4k7y7GJL+5vLr3wxWnN5dvO5VNdS2RhPNj9YHOdr79NHiTYIFmFUexRhV/4FfGshImFW
         Zqgw==
X-Gm-Message-State: AOAM530OGLMwR7gnXH/dYc/j5k9aZVbQ7pjpP0FZ8ukIJsUr52ewMILx
        yRPg8yg8qJ0mTYFPkmvCu0g=
X-Google-Smtp-Source: ABdhPJwgpyAbzc4kf8j39thCjtzGOlp7fsbR9hmxUuzl8miA1+X2WXqDT4AtOywTmcvluefg4GROhQ==
X-Received: by 2002:a17:902:e544:b029:12c:58ea:2e1f with SMTP id n4-20020a170902e544b029012c58ea2e1fmr18103971plf.45.1627992416780;
        Tue, 03 Aug 2021 05:06:56 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id n35sm7197502pfv.152.2021.08.03.05.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 05:06:55 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH v14 03/17] counter: Standardize to ERANGE for limit exceeded errors
Date:   Tue,  3 Aug 2021 21:06:13 +0900
Message-Id: <ae8d3b20b8b02c96b1c9898ffa2f9fa5d99edc81.1627990337.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1627990337.git.vilhelm.gray@gmail.com>
References: <cover.1627990337.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

ERANGE is a semantically better error code to return when an argument
value falls outside the supported limit range of a device.

Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
Reviewed-by: David Lechner <david@lechnology.com>
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c        | 6 +++---
 drivers/counter/intel-qep.c         | 2 +-
 drivers/counter/interrupt-cnt.c     | 3 +++
 drivers/counter/stm32-lptimer-cnt.c | 2 +-
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index b358b2b2b883..d54efdb8d393 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -154,7 +154,7 @@ static int quad8_count_write(struct counter_device *counter,
 
 	/* Only 24-bit values are supported */
 	if (val > 0xFFFFFF)
-		return -EINVAL;
+		return -ERANGE;
 
 	mutex_lock(&priv->lock);
 
@@ -669,7 +669,7 @@ static ssize_t quad8_count_preset_write(struct counter_device *counter,
 
 	/* Only 24-bit values are supported */
 	if (preset > 0xFFFFFF)
-		return -EINVAL;
+		return -ERANGE;
 
 	mutex_lock(&priv->lock);
 
@@ -714,7 +714,7 @@ static ssize_t quad8_count_ceiling_write(struct counter_device *counter,
 
 	/* Only 24-bit values are supported */
 	if (ceiling > 0xFFFFFF)
-		return -EINVAL;
+		return -ERANGE;
 
 	mutex_lock(&priv->lock);
 
diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
index 1a9512e28519..204f94577666 100644
--- a/drivers/counter/intel-qep.c
+++ b/drivers/counter/intel-qep.c
@@ -319,7 +319,7 @@ static ssize_t spike_filter_ns_write(struct counter_device *counter,
 	}
 
 	if (length > INTEL_QEPFLT_MAX_COUNT(length))
-		return -EINVAL;
+		return -ERANGE;
 
 	mutex_lock(&qep->lock);
 	if (qep->enabled) {
diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
index 5df7cd13d4c7..66cac4900327 100644
--- a/drivers/counter/interrupt-cnt.c
+++ b/drivers/counter/interrupt-cnt.c
@@ -107,6 +107,9 @@ static int interrupt_cnt_write(struct counter_device *counter,
 {
 	struct interrupt_cnt_priv *priv = counter->priv;
 
+	if (val != (typeof(priv->count.counter))val)
+		return -ERANGE;
+
 	atomic_set(&priv->count, val);
 
 	return 0;
diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
index 78f383b77bd2..49aeb9e393f3 100644
--- a/drivers/counter/stm32-lptimer-cnt.c
+++ b/drivers/counter/stm32-lptimer-cnt.c
@@ -283,7 +283,7 @@ static ssize_t stm32_lptim_cnt_ceiling_write(struct counter_device *counter,
 		return ret;
 
 	if (ceiling > STM32_LPTIM_MAX_ARR)
-		return -EINVAL;
+		return -ERANGE;
 
 	priv->ceiling = ceiling;
 
-- 
2.32.0

