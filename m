Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CE92AF6AD
	for <lists+linux-iio@lfdr.de>; Wed, 11 Nov 2020 17:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgKKQig (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Nov 2020 11:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgKKQig (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Nov 2020 11:38:36 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FF4C0613D1;
        Wed, 11 Nov 2020 08:38:34 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id h15so2194450qkl.13;
        Wed, 11 Nov 2020 08:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Ie/2g6h8fCMTgltIfv3Rfz0bo0YdcuquD7nLS1t6eg=;
        b=S6ejkkcPJz8EcNc+0Mp1+79wtHpaIv3/yiOHomedgDAmUL0q48zC8AH5XHUQtv6lSi
         N55COLQs1QlJnTjju6+m7I8aZ17xngDMxitQ2NGkZe1Mi2u6GrDqwod9mGajVSHmIrp4
         MHqzwbPMKZxM6OlhSwZQgflmOz/Cqqp/GzM6qII7PqwivMcTl+KYpX0VcrRKoAgfyHb4
         H23koW2AgNrmVyUyRBDdQ0vNWIPHX5hpeVZA3QSvblJ10P1Cd+GR7LawX+RfH9y070/V
         O/QkwXRy/BeBu6Uvk3hHcCqovgJ6wp7C3FFXHY6FePX9RskbRGCngoGs2t6aYZKu3Z1b
         U0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Ie/2g6h8fCMTgltIfv3Rfz0bo0YdcuquD7nLS1t6eg=;
        b=h8PuNKVKZ4gBp/DaYRY5oYjywXCMSnK2gkw05fur+Dp5v2haKJVmNDk9cZqLpk7U0g
         yLZgYs1kpAdB8DgRptltzm98cuUrkjkBIX9axUb0WJdMdGhLdonfsc9tzIudl2JCs6QG
         KrSp9p6ZPkHZTXsyjXTtPTfaaxWUIH/0XKOB2oQBwrtkb7B7B9SJAslnefVGmi0ywAie
         REvFIHxL/gRyR4iAYjbE2m18uGhQqQjSMatSma3I5ElTO6tmrPDUpRHhwuedjieNasbD
         b36sMijwgcEtkye3WKd8tGaaRKtxfpYWbZxeph5IP60IEMVivFtqCK8mNqtYL7Wm68kz
         0o6g==
X-Gm-Message-State: AOAM530vMlgM0jFbX7dzrfzUAleCUoquAkn2epi1maIQOXoklmZuNgwb
        xZrBsNtIfhq4x+Va4DW/nLk=
X-Google-Smtp-Source: ABdhPJyIbrh+4qgDsQQCVk/MHG7XDX40xL7zIDdJhzoJah7E7HCKx5G8Vxr7QIfkf5GgrQLhig7LVQ==
X-Received: by 2002:a37:4ac4:: with SMTP id x187mr25631324qka.197.1605112713595;
        Wed, 11 Nov 2020 08:38:33 -0800 (PST)
Received: from localhost.localdomain (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id l28sm2615051qkl.7.2020.11.11.08.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 08:38:32 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     robh+dt@kernel.org, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH] counter: microchip-tcb-capture: Fix CMR value check
Date:   Wed, 11 Nov 2020 11:38:07 -0500
Message-Id: <20201111163807.10201-1-vilhelm.gray@gmail.com>
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
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/microchip-tcb-capture.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 039c54a78aa5..142b389fc9db 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -183,16 +183,20 @@ static int mchp_tc_count_action_get(struct counter_device *counter,
 
 	regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], CMR), &cmr);
 
-	*action = MCHP_TC_SYNAPSE_ACTION_NONE;
-
-	if (cmr & ATMEL_TC_ETRGEDG_NONE)
+	switch (cmr & ATMEL_TC_ETRGEDG_BOTH) {
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

