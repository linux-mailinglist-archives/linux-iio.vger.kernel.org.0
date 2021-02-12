Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009AB319E1B
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 13:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhBLMP0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 07:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhBLMPW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2021 07:15:22 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26923C06178A;
        Fri, 12 Feb 2021 04:14:29 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id w19so7958100qki.13;
        Fri, 12 Feb 2021 04:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BjJkilAOMGiWiSD9J4QR2aEeHu+r/1qYrSNyG3boNpc=;
        b=BLt4sjlCky7CbAc9/dLfGcwAvsWUzPTf4qP6jWbY9HDc4vxvHbqwfw2gO5Yb8HOjf6
         rkst6aD34iVSCEHlOGhRA3Yn8niNgmuNNuu6RoICNh9W+VjiTpdSd+SB+i32v3pHjPZr
         HAg1MwfATZpc6EcnxaUdfEZHfs4ZSE8O0oZtiZOvC3dIzl4es1cUiFXTc60qjE6tn7/V
         /LwRKPjXtzfhMbSyMkJuDNEY+/JMupnGIj0Y5XmcpZvDcH9EkjMSsJkYM3zlwjfJwQsk
         r8ZQuH9ohwU6xO6YH41XKAn41CX5Viei5boWdFpNW43QCp0+cYQkxzM6eTkcpqZZGI4c
         dmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BjJkilAOMGiWiSD9J4QR2aEeHu+r/1qYrSNyG3boNpc=;
        b=iYo1h5ogoBlWkPg1Ry1rth1AQOFbyQZV7dNesFObd4H5Debw5ftCpDbxGml2IYyfnb
         fV8dnAvhXwNtlofIE4dvc4wtjvVHFl1akg+7JH12Jk/W56pcrgE/V1PMsHQZi/F30JRR
         /dJ46XrKMZmV7XtRDR85EBDJu2nx7bR5Le6OqNwyC/Fq+zzJNhoytXoX/VzB2U2Vf7jH
         9XptQnnggJs1PpoNkRhqPgpTuxknjQgkbA5bkYh+2LTTfsUgcS3p6tXekKU3F3FJOwfk
         K3ABLbPxy6d/b60jabiiW2vOJmSwb//v52jQUjuruc8Z/heVeww1l3Bzk7uEuD7BjMC1
         FjQg==
X-Gm-Message-State: AOAM5325T61/hCuMwA33eyZWQz+AOhyaH8gn5QZukinDXFxvSupQ4iqX
        3f7OtvUSexeHJm5FcA5ahQY=
X-Google-Smtp-Source: ABdhPJzGvQvyQZE7dX5RO3K9tktCugN52yaK4b68hwIqb2DyJmUOu4SVpRBxm3I5s1tE3VfsUB2Hig==
X-Received: by 2002:a05:620a:38e:: with SMTP id q14mr2251979qkm.239.1613132068379;
        Fri, 12 Feb 2021 04:14:28 -0800 (PST)
Received: from localhost.localdomain ([193.27.12.132])
        by smtp.gmail.com with ESMTPSA id y135sm6278534qkb.14.2021.02.12.04.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 04:14:28 -0800 (PST)
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
Subject: [PATCH v8 05/22] counter: 104-quad-8: Add const qualifiers for quad8_preset_register_set
Date:   Fri, 12 Feb 2021 21:13:29 +0900
Message-Id: <92f7ef2bc516c1f9d54b3904bf78b908497a1978.1613131238.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1613131238.git.vilhelm.gray@gmail.com>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add some safety by qualifying the quad8_preset_register_set() function
parameters as const.

Cc: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 37551d3016de..70383b792ec6 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -632,8 +632,8 @@ static ssize_t quad8_count_preset_read(struct counter_device *counter,
 	return sprintf(buf, "%u\n", priv->preset[count->id]);
 }
 
-static void quad8_preset_register_set(struct quad8 *priv, int id,
-				      unsigned int preset)
+static void quad8_preset_register_set(struct quad8 *const priv, const int id,
+				      const unsigned int preset)
 {
 	const unsigned int base_offset = priv->base + 2 * id;
 	int i;
-- 
2.30.0

