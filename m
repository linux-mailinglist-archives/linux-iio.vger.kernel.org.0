Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1B93326C9
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 14:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhCINWC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 08:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhCINVv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 08:21:51 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA1BC06174A;
        Tue,  9 Mar 2021 05:21:51 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id t29so9340770pfg.11;
        Tue, 09 Mar 2021 05:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xBOjIvBEx7zNTTNiL0i0jumW/DpoGf2xNUhJv3RRJNM=;
        b=JOwllKhQNc2ZYTn9eNxf6x2/3Mexv3Bg4SwcbtPIy+9qnMpG1dvDsP/XaQfzR35bPK
         a9u1HyGuURMORUb3G9jqZ4QHyFTO4hPv5yBIeIZQIiykh7DfQ9YKpALQbEQKoyfTgWm7
         rHmrG/TQ6tqZ2mht+ZMH7CoTyZOtgbz0R9ckFDqxdmhtYhDgoCAIeLfawmpiugVuVQoJ
         a3hWPLlZP8y1NZ4vTJKlQGjwzbwklR9dsFSQ/4G0mwDdRfy4+SMZmh+7Lw9GFm0DHCHa
         jrNpre8mCaglaVIRiFoP8tO8UncjT5ww7nKEyjMaqSZrJcZ12gF59iekbsutr+bJv4hO
         cOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xBOjIvBEx7zNTTNiL0i0jumW/DpoGf2xNUhJv3RRJNM=;
        b=J9sk1kdiSpSULVjl1mtaOec/V87VvdWkU0yx6fnNvQQQfwH1kupd0q7iJa6ABiIvGr
         XqwXiRC+xRLfNaNHAMSotTTVQzS7GCJKPNJwdtIS/jbSXQPlKbvbb5OxApM8Qn9xq2KM
         nyztcxbCuBuRDNcpIgdx4pTe6xwQXn33HoJQcvAVTyChJ5vPxn3FAG8Ynytn1ugBO7tZ
         x5b7D3EFQ+YQgrouuQsTecjhfl8x00iwuRxFao2biNuZzlkZ4Ms39H7+2Z9l51XB4XTt
         ubtBw+N1RxF6NUwPcqjQlGN+zqAxpcxWZOLNWIRSt4IsDuFwxkW+/mb8UKVbm3nlsiMz
         RJfQ==
X-Gm-Message-State: AOAM533xMgs77bMK6OnRW+mbgBV09JUO96FZr9ZlpVLpi6LvzopgWSGo
        l909aqccvLw2AMe9m3Y0yCs=
X-Google-Smtp-Source: ABdhPJy2zbMwdBSGPR3dx1mMoqiMQh+zfCG7RLUlUDLCF1Ho5wLeEo9bj9hqdskuk9EJ6DI2k2fogw==
X-Received: by 2002:a65:53ca:: with SMTP id z10mr24946840pgr.271.1615296110710;
        Tue, 09 Mar 2021 05:21:50 -0800 (PST)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id y9sm7647421pfl.201.2021.03.09.05.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 05:21:50 -0800 (PST)
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
Subject: [PATCH v9 19/33] counter: Standardize to ERANGE for limit exceeded errors
Date:   Tue,  9 Mar 2021 22:19:32 +0900
Message-Id: <ef1245448a992f2e9b5a761b242febce0fdeed63.1615293276.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1615293276.git.vilhelm.gray@gmail.com>
References: <cover.1615293276.git.vilhelm.gray@gmail.com>
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
2.30.1

