Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369A9319E22
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 13:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhBLMQC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 07:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbhBLMPj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2021 07:15:39 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D1DC0613D6;
        Fri, 12 Feb 2021 04:14:58 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id q8so1136646qvx.11;
        Fri, 12 Feb 2021 04:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GMBo1ioqzSWP/+ctxewh1wOwLDNrQeon20dNDOAUAHw=;
        b=hQ0Mp5RpZlnJ4z7vBeY7wfDFk7YmZgacLz9RZUwVCSvVP3N1CQLZvJ2TvXO7rCvuvV
         z37Fi3XcatNtV1SOTkawn4TtfwGaU0t66rIF5Q88q+Z4YdrjF6leoL7K3RLGZs5ZTEua
         LKq7PBLsjiZJUH8F5/BV8At8laep9rTiJD32bLubMRVrySWSYtbN+8uIuS15dy52UAsx
         w6xlOJC0BJN/Y2gKGEnU3NSSFzAyCS9paLiv97kmnL6iLz/CMM8zB+BKbeQB6YkLsSAz
         rqvNntr3HKHG1VNCd7aNL3Rr0iqsf24x/qITyyj75jWXaplyVeD1Dzyhc/m4Q6K80u5o
         OWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GMBo1ioqzSWP/+ctxewh1wOwLDNrQeon20dNDOAUAHw=;
        b=tbVxlA2hfIpIi1ZrmTLs2N03pBc+4+chaQJ8qHIdxTLeEgExWBnZ6Dp7K/FpWsctba
         HJXKzolNsuF8uOHFnf0qLiiHCrRv/Irw1cU4I5LBlemgIiSqYLyh1jlRDH4h8K/IBo4u
         UWdHIaCeAnqO2C/QvhfD1Si7GwW33gsDJR3J+cKC/jhN5iDpSmsjzGogH2vRIdA29+kQ
         b280zDRWIY+TV29Ot/5t+oYbbNc2Aj8OeRyVKv0C4IAfLgSX7bNXnGBgYpngOWJQYTWq
         8d9XOf/hUzfSPrwTdD5DZdBkEFtqPTw4IZPQIkI1ctcFnb+fVExFPOlaJ6nnYevQe0cc
         jPbQ==
X-Gm-Message-State: AOAM532GIg+umQnXU021seSjgkYxiTrFRy+dTiD2vs1emd/upxIsxpQc
        L5eiEFdyHHpL3r0MBsQXhNk=
X-Google-Smtp-Source: ABdhPJyz0q+/nPHNN5O8M7RjDuPNfxOYsgS2grh/B4LOITzmnACa6UfxzpaYY/SEWbBLqAPpQ27sYA==
X-Received: by 2002:ad4:4693:: with SMTP id bq19mr2242483qvb.43.1613132098140;
        Fri, 12 Feb 2021 04:14:58 -0800 (PST)
Received: from localhost.localdomain ([193.27.12.132])
        by smtp.gmail.com with ESMTPSA id y135sm6278534qkb.14.2021.02.12.04.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 04:14:57 -0800 (PST)
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
Subject: [PATCH v8 10/22] counter: Standardize to ERANGE for limit exceeded errors
Date:   Fri, 12 Feb 2021 21:13:34 +0900
Message-Id: <7fa80c10fcd10d1d47d1bddced2b2cca3ff59ba9.1613131238.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1613131238.git.vilhelm.gray@gmail.com>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

ERANGE is a semantically better error code to return when an argument
value falls outside the supported limit range of a device.

Cc: Syed Nayyar Waris <syednwaris@gmail.com>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c        | 6 +++---
 drivers/counter/stm32-lptimer-cnt.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 674263b4d2c4..a2cabb028db0 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -154,7 +154,7 @@ static int quad8_count_write(struct counter_device *counter,
 
 	/* Only 24-bit values are supported */
 	if (val > 0xFFFFFF)
-		return -EINVAL;
+		return -ERANGE;
 
 	mutex_lock(&priv->lock);
 
@@ -671,7 +671,7 @@ static ssize_t quad8_count_preset_write(struct counter_device *counter,
 
 	/* Only 24-bit values are supported */
 	if (preset > 0xFFFFFF)
-		return -EINVAL;
+		return -ERANGE;
 
 	mutex_lock(&priv->lock);
 
@@ -716,7 +716,7 @@ static ssize_t quad8_count_ceiling_write(struct counter_device *counter,
 
 	/* Only 24-bit values are supported */
 	if (ceiling > 0xFFFFFF)
-		return -EINVAL;
+		return -ERANGE;
 
 	mutex_lock(&priv->lock);
 
diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
index daf988e7b208..d5f9d580d06d 100644
--- a/drivers/counter/stm32-lptimer-cnt.c
+++ b/drivers/counter/stm32-lptimer-cnt.c
@@ -283,7 +283,7 @@ static ssize_t stm32_lptim_cnt_ceiling_write(struct counter_device *counter,
 		return ret;
 
 	if (ceiling > STM32_LPTIM_MAX_ARR)
-		return -EINVAL;
+		return -ERANGE;
 
 	priv->ceiling = ceiling;
 
-- 
2.30.0

