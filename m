Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C91D3C6DD2
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jul 2021 11:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbhGMJ4q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Jul 2021 05:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbhGMJ4q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Jul 2021 05:56:46 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6837C0613DD;
        Tue, 13 Jul 2021 02:53:56 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id p22so6124608pfh.8;
        Tue, 13 Jul 2021 02:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=stljVzismgi0bhtAbjcWPPl7QduNl8XesIvoC90of/Y=;
        b=XbqbBYt2KAlG3Au5ST8HktTGY8nR/iVlmTPfNPtKlHejTMWpvIAi1rty+h5f4iQLHE
         nJXvg3R96ugxInztBlrgyDUwlPlR8ZR5+vE3DyTuJXpEDGLMoNAMNIe3anaw7IVwY34n
         qhNu4yWR1zY7b30U6/xItFlqhZjMtoXQ5Khn8oFPSRh5rtjQ0zxTZKBzdBRTlNH9By5/
         uamK3z3t43yzWYuCUGqARsrkq/8Xoko0odTVsqujpwIqPA2El8XxDGHnMJ6Ih5ocfxHw
         RmY/qkUpRLzFfdkEACjgeuKNf4NsXjwh5qGJUPrXsziVCPNvzdenTIGHvLndzj41MPFZ
         utUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=stljVzismgi0bhtAbjcWPPl7QduNl8XesIvoC90of/Y=;
        b=rvlgKvUhU89bqAHCU2J7mfEHGojjwuI/HGh+Xwsga7gkeNljZcKbSv+dYl3vXxi3xm
         CUPQYBshVuw073DT88SFwy3Q9ST34t8xIBHanJu1e8bHR/mNWX0uDfbnIiRvZAiClppR
         55qdazOZ/xowFxtgKMv7bHAIJpdiIECxTYkf8ffP/c3i0ASc+OKIcvtf2qmGP3cSAA0j
         RI2SnNnKmLNovdF93fl3MZu14uRSKZF15UO1hE+onTXliP6k0AHxv/SAdw0MH2htSj3U
         pNaRKk5wA3fRhLObtZcQiHa44mVTy5PF6VprXIEtVO7RPYuF/l+UTUju1a3MJwEVpS9u
         FsJQ==
X-Gm-Message-State: AOAM5308Hf+Z3h+g8he91M9VVZR9JnoAaO4p3lQ4o1H7JDV6MPvdgTCy
        wMpHVAPLWCfMQe5RXrBlkiA=
X-Google-Smtp-Source: ABdhPJwvrFfpLw+74Tmy0kgPix7l+4vhDX9i+6oMqVqeiHrrv4/yf8ifuQ/AwxIDzsU9gxJ8SiZ6Eg==
X-Received: by 2002:a62:87c6:0:b029:327:8be4:978e with SMTP id i189-20020a6287c60000b02903278be4978emr3659746pfe.50.1626170036164;
        Tue, 13 Jul 2021 02:53:56 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id f6sm18153854pfj.28.2021.07.13.02.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 02:53:55 -0700 (PDT)
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
Subject: [PATCH v13 03/17] counter: Standardize to ERANGE for limit exceeded errors
Date:   Tue, 13 Jul 2021 18:53:07 +0900
Message-Id: <275a0de80b2eb272f5dc1641c511ed601c9f5848.1626165765.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1626165764.git.vilhelm.gray@gmail.com>
References: <cover.1626165764.git.vilhelm.gray@gmail.com>
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
index 8d7ae28fbd67..85dd328ae1f6 100644
--- a/drivers/counter/intel-qep.c
+++ b/drivers/counter/intel-qep.c
@@ -320,7 +320,7 @@ static ssize_t spike_filter_ns_write(struct counter_device *counter,
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

