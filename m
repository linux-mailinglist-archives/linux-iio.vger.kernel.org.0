Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CC33BB8B4
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jul 2021 10:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhGEIWH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Jul 2021 04:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhGEIWH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jul 2021 04:22:07 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C5DC061574;
        Mon,  5 Jul 2021 01:19:29 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id b12so14951619pfv.6;
        Mon, 05 Jul 2021 01:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lwJZ+FRHmPdVwm0/Cne9BWGWHB7Nx2ph+8GMBriVPGo=;
        b=qghfU1Ic26rrzYU0rkpTSWDcEhb5c0NOIgjgWfhYyp5axzpVaF2tWiTEhum0GRfWhM
         Y0G/UPaghUKDzGYLyilG8VdUkM8yhrjsPXIDct8QTi8xO50pcLumVGtnv6acUX2ME8Qb
         g5OsIjaoRxtxwjVdUsiXXXmt1Y9sVN2ubtppGC8rqkBnyvD6nQ4l3ZyJ/LsnZYdO0K+2
         C7UFf0YQDr6LeFAGJnVuR2dOvnT/lRdpz+m93stZPw3eTbvQ98EvcEenTRXWk4SlKL0U
         bj+hY54Hif9QH8SuDY71yRHkWQwHug7w4wVQ4IvCDhzVrhXqlc5QkNQoRyqooJlzwk4N
         uAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lwJZ+FRHmPdVwm0/Cne9BWGWHB7Nx2ph+8GMBriVPGo=;
        b=lVW9gqB5fL8ZyXCgppdwuH84rtlCP/VXFIJ3tIqGKgAsOzpHZRBl/cadQKcjgU2Kc6
         312tN1qHfK822hO/K+G7cIFO1W32ku1Is8CQ8LwVZAHhmmqB6uj5VqZjie0XjedvUiRR
         cgpXUjoecTgpm61RmFh1+umqopU/sTr3vaDGf0Jg12eYgKC3Slrf3prnj7bhbPgpoEET
         MuNWgUa4nNTzLpAK08+9epvjvXiRQmTyDihD3R1oZKZrCjj/yM1wyyXL7VaEer7OmGbY
         7/WUCOpvK9RdPPY+aqiN72V1baCjHeb61YnUqrjeZcj6j9sVi2njGGNIH09iwGFduqYg
         +bbQ==
X-Gm-Message-State: AOAM532oMUT6Oafho4Ke0IC0BlEipq7H2WKZypVhi3D7NBKfezN6Sqsa
        O8yyx0tU0I50eJr068cr8Ps=
X-Google-Smtp-Source: ABdhPJzDzeeL4WGvM1opfkx9OeUUJ5r5Ef7PkA03J1pzloGnM3C4c5JHEqnlXWV5KzY6fSkJyIDvIQ==
X-Received: by 2002:aa7:943b:0:b029:321:809a:f0b with SMTP id y27-20020aa7943b0000b0290321809a0f0bmr794524pfo.32.1625473169361;
        Mon, 05 Jul 2021 01:19:29 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id y11sm12209986pfo.160.2021.07.05.01.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 01:19:28 -0700 (PDT)
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
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v12 01/17] counter: 104-quad-8: Return error when invalid mode during ceiling_write
Date:   Mon,  5 Jul 2021 17:18:49 +0900
Message-Id: <8a7614a06dbc60650fe60c31fa47d398890200f8.1625471640.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1625471640.git.vilhelm.gray@gmail.com>
References: <cover.1625471640.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The 104-QUAD-8 only has two count modes where a ceiling value makes
sense: Range Limit and Modulo-N. Outside of these two modes, setting a
ceiling value is an invalid operation -- so let's report it as such by
returning -EINVAL.

Fixes: fc069262261c ("counter: 104-quad-8: Add lock guards - generic interface")
Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 09a9a77cce06..81f9642777fb 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -715,12 +715,13 @@ static ssize_t quad8_count_ceiling_write(struct counter_device *counter,
 	case 1:
 	case 3:
 		quad8_preset_register_set(priv, count->id, ceiling);
-		break;
+		mutex_unlock(&priv->lock);
+		return len;
 	}
 
 	mutex_unlock(&priv->lock);
 
-	return len;
+	return -EINVAL;
 }
 
 static ssize_t quad8_count_preset_enable_read(struct counter_device *counter,
-- 
2.32.0

