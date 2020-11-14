Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441472B3163
	for <lists+linux-iio@lfdr.de>; Sun, 15 Nov 2020 00:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgKNX2Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Nov 2020 18:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgKNX2Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Nov 2020 18:28:24 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C54EC0613D1;
        Sat, 14 Nov 2020 15:28:24 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id p12so10109107qtp.7;
        Sat, 14 Nov 2020 15:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pEEvmIH+xLHYOZ5QQR7HSpYTdM1EvSRmH2wXZTi8hzE=;
        b=UbZRIwROaDs4ijKnxts5kDfUPWEXHMA8ejCVABuoIwxuCxnglLfjsfpMc27bhaB5Cn
         6u/Pv/nLNiWiOgF7CIET1SOSjlQEZU3oNQ7k59UiF/GkpTY+c4l5DraPTDb53F1Y3IXP
         I4aNHL2ZbZU5l4Wsh05tpzmyN338vcXLlXm17ZXeveE1iTZz8HEnxaITnulNh5z5empS
         qeuAfgtfhi0FwdVC7zFNzVEFYUs/htAaKdv9hHzXTD+ijj8Jo0sfVA2olIQAyJBwn6Nb
         k37Npz5qY+r1N/0bHO/pbBqVt5O14Bb5tyP9ZxuYggvEoD9wAmPsXmrVXMGrFKa/2Wnk
         Ypbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pEEvmIH+xLHYOZ5QQR7HSpYTdM1EvSRmH2wXZTi8hzE=;
        b=VZF8jlqSzYqymkHvBEFZIbgl4EeqK65ui3TYny1fldE46+jSuUjHUIhf1hOHsndVGZ
         wbx/PxYRbbbAhH1qpsXgnApHZ+2SeSdhbc3Tv0VYpRojiB5tI6yB6Jmcq6RiEsAlR6Cu
         pCjaFB0hR+CY4L1+WhhbXOr3i01szErlG4aN+xG5fTYZL4tOwXaRhAjJd+i5WK/EKmfj
         JgmKi9DkzYqdcnVNu5WegsiBNYaNVVskxL0aL7JSbMqn9nBHW9v7A21IewRt0gfxfDOr
         kO/J+/yNXD+whKQ0VybKKBrxCdatCFtLP5QMhcP60cEQGFULwSt+Wf8sMl9pEIyyoK9W
         08Mw==
X-Gm-Message-State: AOAM5316D185cWL911TXaAjFT+tMI9jAObl74osVWyhUMnmnW1/8nbap
        ifrf/XP9FuqgdPSAiiY3PA0=
X-Google-Smtp-Source: ABdhPJz/Nm2vZQnKSMQPtQdgh8a7vdzmisfu6umiOzujJEmgdGL/Tu0tWzLcLzH2IcuwJpc7WHLEkg==
X-Received: by 2002:a05:622a:86:: with SMTP id o6mr8106003qtw.147.1605396503546;
        Sat, 14 Nov 2020 15:28:23 -0800 (PST)
Received: from localhost.localdomain (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id h125sm9630656qkc.36.2020.11.14.15.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 15:28:22 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     robh+dt@kernel.org, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH v2] counter: microchip-tcb-capture: Fix CMR value check
Date:   Sat, 14 Nov 2020 18:28:05 -0500
Message-Id: <20201114232805.253108-1-vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ATMEL_TC_ETRGEDG_* defines are not masks but rather possible values
for CMR. This patch fixes the action_get() callback to properly check
for these values rather than mask them.

Fixes: 106b104137fd ("counter: Add microchip TCB capture counter")
Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/microchip-tcb-capture.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 039c54a78aa5..710acc0a3704 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -183,16 +183,20 @@ static int mchp_tc_count_action_get(struct counter_device *counter,
 
 	regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], CMR), &cmr);
 
-	*action = MCHP_TC_SYNAPSE_ACTION_NONE;
-
-	if (cmr & ATMEL_TC_ETRGEDG_NONE)
+	switch (cmr & ATMEL_TC_ETRGEDG) {
+	default:
 		*action = MCHP_TC_SYNAPSE_ACTION_NONE;
-	else if (cmr & ATMEL_TC_ETRGEDG_RISING)
+		break;
+	case ATMEL_TC_ETRGEDG_RISING:
 		*action = MCHP_TC_SYNAPSE_ACTION_RISING_EDGE;
-	else if (cmr & ATMEL_TC_ETRGEDG_FALLING)
+		break;
+	case ATMEL_TC_ETRGEDG_FALLING:
 		*action = MCHP_TC_SYNAPSE_ACTION_FALLING_EDGE;
-	else if (cmr & ATMEL_TC_ETRGEDG_BOTH)
+		break;
+	case ATMEL_TC_ETRGEDG_BOTH:
 		*action = MCHP_TC_SYNAPSE_ACTION_BOTH_EDGE;
+		break;
+	}
 
 	return 0;
 }
-- 
2.29.2

