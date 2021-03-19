Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103CE341AA2
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 12:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhCSLBr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 07:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhCSLBT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 07:01:19 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68273C06174A;
        Fri, 19 Mar 2021 04:01:19 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id h20so2782931plr.4;
        Fri, 19 Mar 2021 04:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YP6Y0iUlFGoxnb33nwnYEvQ4ZjRZgtWw9rrllhcAce8=;
        b=EfPTCnysQ2SO1zX7Yo4KRrKJd4T+NRxlDLzkn+xhVOtwG47MHAVbglbAXMQq/g7KTj
         e0ZUMRJrpemIZQRhRm4QevibXClI5xo33QBIsockGMprJ3UbtUz+b4lc2KcT2+bZserS
         IcUG/2q9s3Li/oSPW8Hha6ySTnMhg+/QIf0/mUIlYvT9NC15hMP9ZjenhUVJqenSXovu
         ZLj42xDF/jYkNMRWhGg+DD/QohSNPL4RKiEpMDMOh4wTaoBe6l05fEZ5ERgEMWnxjwrP
         FkEguiXLcwijo8aOSae1VgrxLrNyEKZkSumeOOEAK6CCH6+UHtFUul4dHZ17IUg+6gjB
         Vwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YP6Y0iUlFGoxnb33nwnYEvQ4ZjRZgtWw9rrllhcAce8=;
        b=NzHQ1gRw737FLOVbOp2QvhUY3099wG32VxvpQSoiDv9ydHUAlAO5uyusfkN6vLM6Pk
         UfiVcwAJzf3MHsc1I2eOLEYUlxR3tAYvnEEDhkkECgcTQnloU0D1GTXxPY1T7YZjCXVl
         nhtvlUABFInP+Jlkb5Gcq/gJcT97WQj33RUNRNXizzIDx88+9bIlpEqjnsk5sViV96rM
         MfPuv2WMZYspAIi4jXAe+ODDOl6RAfkIS8A0Prx9kEx8ELgTM7bC8I02bxJmnd92sjFo
         HikYzwEzZidw++GO4ZJMVTL0VJQGfddfObqfuTxYGt16KGIenzFCA2kBE+9zdIKvOCij
         PC1A==
X-Gm-Message-State: AOAM530HhiRLKULX2BaANIgHyu8sjbd7pn9G1LlB/bbwesPdVVmboQug
        wnZgFthsbTcnH3npllt7YjI=
X-Google-Smtp-Source: ABdhPJwEkXVpf7bCTq0t4YWhofrnRE9O3kVRUx9pwa8eP8pu6QtVdUaaJgXFqGgmXc7XvdKM4+CfGQ==
X-Received: by 2002:a17:90b:344c:: with SMTP id lj12mr9432230pjb.208.1616151678943;
        Fri, 19 Mar 2021 04:01:18 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id i22sm4879042pjz.56.2021.03.19.04.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 04:01:18 -0700 (PDT)
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
Subject: [PATCH v10 03/33] counter: 104-quad-8: Remove pointless comment
Date:   Fri, 19 Mar 2021 20:00:22 +0900
Message-Id: <e53df4416573f16069090f4c660afbd8d501f2a0.1616150619.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616150619.git.vilhelm.gray@gmail.com>
References: <cover.1616150619.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

It is obvious that devm_counter_register() is used to register a Counter
device, so a comment stating such is pointless here.

Cc: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 9691f8612be8..4bb9abffae48 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -1082,7 +1082,6 @@ static int quad8_probe(struct device *dev, unsigned int id)
 	/* Enable all counters */
 	outb(QUAD8_CHAN_OP_ENABLE_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);
 
-	/* Register Counter device */
 	return devm_counter_register(dev, &priv->counter);
 }
 
-- 
2.30.2

