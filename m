Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C8D341ADA
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 12:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhCSLCy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 07:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhCSLCj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 07:02:39 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E145C06174A;
        Fri, 19 Mar 2021 04:02:39 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id g15so5631728pfq.3;
        Fri, 19 Mar 2021 04:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zPb+gWSSK34KYiB/GIEQN8ZRP7v+HVonTQM6Ywh1zp8=;
        b=GbwBST6OLctHRPpje6CQQ6A0Etw7HHv1ibi/PtZt9dyNRoMGuT/crP0iLQKj+aLj6I
         K/IwLftAjimPHfvY9mp3porI9HYjP7YXlIOnP1uJkPtYFabbNtskz2nJXNmU/rnVqQ2x
         6HKZl7I0BLC//HE9GOXCad+5TGP1HsfWiGMnmOdcxhxnFB7qLpBLLEh5OiojaBuHNPUz
         ARmLhaNGvylVdtTbIT0UTfCa5UdaEJ2GwiQGtRgh3J0tbKxm6RjyhHxIkhkg8psrUO0m
         M/WP+Jnw1swX2FmDEitAolGz7NkD0SupqG/Y9GOTNuL5ZYt1Jq2JigRVC+rrdrnu8nq9
         yXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zPb+gWSSK34KYiB/GIEQN8ZRP7v+HVonTQM6Ywh1zp8=;
        b=dvTa6S/uKJ2YuJZXnYijQLWhJwdF7PpmMp2B94DezsjBEYaoXGoHGqgPCiB4HLXuiX
         ex7Fd16NW/BczHtzDs//25scefvUsID4R2sWnHE/8d5wpqEbPb6wwRlC72C6F9sUpcm5
         b68j1y+BlIejzmWltGF9RIdty9mYNE36bYRK4l0/9G2rVUGUCafefDDi/ELa0ixRX5Z6
         g3fQNJcYDKAbtA62deYupIkWoS0p8pibUAAU/n/1ZgHQ9kEs0LFEPNQK5vPm61o7dzDY
         QRY3O6C++0ozj4M6TQAlfQIyGSN6Qx9psuLWCg+K+pWCE8euT6zcTM/kpZqxCAiZdz/x
         ms7Q==
X-Gm-Message-State: AOAM533z2G2VUeS6624cStl8ohcJRV1VSGcyflILXHihZTVKRW4E1HIR
        lfuUN8TPGcysKhuhXsZrOCQ=
X-Google-Smtp-Source: ABdhPJw5U90GgbXrwB9X3j7ERBM6UKrmDzqcszz+pkiLkuNCUFc69EhY4Lrh6+GU35xS6cCocLbUcA==
X-Received: by 2002:a65:520d:: with SMTP id o13mr10970910pgp.57.1616151758644;
        Fri, 19 Mar 2021 04:02:38 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id i22sm4879042pjz.56.2021.03.19.04.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 04:02:38 -0700 (PDT)
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
Subject: [PATCH v10 19/33] counter: Standardize to ERANGE for limit exceeded errors
Date:   Fri, 19 Mar 2021 20:00:38 +0900
Message-Id: <f09068dd8b89aa81c4310ea39cbdb0d631dddf98.1616150619.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616150619.git.vilhelm.gray@gmail.com>
References: <cover.1616150619.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

ERANGE is a semantically better error code to return when an argument
value falls outside the supported limit range of a device.

Cc: Syed Nayyar Waris <syednwaris@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Reviewed-by: David Lechner <david@lechnology.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c        | 6 +++---
 drivers/counter/interrupt-cnt.c     | 3 +++
 drivers/counter/stm32-lptimer-cnt.c | 2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index b7d6c1c43655..0409b1771fd9 100644
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
 
diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
index 0e07607f2cd3..f27dea317965 100644
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
2.30.2

