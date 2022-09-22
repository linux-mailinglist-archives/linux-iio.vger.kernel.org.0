Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33715E60CD
	for <lists+linux-iio@lfdr.de>; Thu, 22 Sep 2022 13:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiIVLVM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Sep 2022 07:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiIVLVL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Sep 2022 07:21:11 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22B9E05D1
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 04:21:09 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c19so5879119qkm.7
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 04:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=TeUFDnbgzk6Qzni8tpsAtgePE9982tK2aadkRLxu0D4=;
        b=BsfophC5dzhj9jjtOTN6dxvid/9RYicp0IkYnikTVNT8X77Ntwvny+ZLysn4IXf/ei
         snZOW1lC56nBZDTsAFNkmZcM/BU4MT/plAtgikj41nvuj05Wuqc9NfF9QwiUjGlRhgAM
         CRLONG/UvKl7Yy7oLZuFFXslr1kjDG/Rb5o+2Qz8RPjKpHApQ0ydUG30zWIMVo1PynTq
         MrMagl6hQPayWZpJBBFACZ8SsYUGx44v/A888pyJJZILTFv9M2p21mDcBHuij4eYoMT8
         C+z+cNvltELFJvWXQPuRwXikR7ZCPMx4o57h2LPS08nRB2+CYTHDhNT+Vs5xaAfQOkzv
         RABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TeUFDnbgzk6Qzni8tpsAtgePE9982tK2aadkRLxu0D4=;
        b=FjzP4HA0onLI2RHCzPpCBgrcA0nbf3LBefNM3tl6kDzrLHO9AWP6ap+slPYcsvLQ+H
         E7aC/Y1sBwe20PcN/G3iKEc/HHWK1KOS0EvzZJMu1yZ+T8o5+TPXUGGAKBm2TjhPu6ye
         BmtHmgLNQKBisJtJWRCBBCL4xTWLa264s09wrNMJcvvkjNm8KPiEX60aA9hmkqa5qsI9
         EDjSntbaQH+uMesNmG2JThGvV2ykKwvQwKqIKEmW654SMLy+2cwDvNBWaaeVFhXomcnQ
         C7FCmIzVB59OEW3XVkeC/AfXGVowwjzC1rc+EesRYJ3ZkNhXjLMXedEtuCz61wdXmTFk
         Nrww==
X-Gm-Message-State: ACrzQf2ew76AHdqolsC6dQbP1pLin6yuxq3WLlu1CPA9IhdoVyqNN25f
        swfmUi1qFRUPFFk0JJA3Pule4w==
X-Google-Smtp-Source: AMsMyM4P0eYnq4telbZUObL68V71jiEKqshc/qCiJSkmy2zdtdma2gJzJHDwl+qpnHvKwe86AVoUvw==
X-Received: by 2002:a37:790:0:b0:6cb:ebb2:2bd4 with SMTP id 138-20020a370790000000b006cbebb22bd4mr1676227qkh.612.1663845668678;
        Thu, 22 Sep 2022 04:21:08 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id f39-20020a05622a1a2700b0035cf31005e2sm3487115qtb.73.2022.09.22.04.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 04:21:08 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 1/2] counter: 104-quad-8: Fix skipped IRQ lines during events configuration
Date:   Thu, 22 Sep 2022 07:20:56 -0400
Message-Id: <179eed11eaf225dbd908993b510df0c8f67b1230.1663844776.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663844776.git.william.gray@linaro.org>
References: <cover.1663844776.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

IRQ trigger configuration is skipped if it has already been set before;
however, the IRQ line still needs to be OR'd to irq_enabled because
irq_enabled is reset for every events_configure call. This patch moves
the irq_enabled OR operation update to before the irq_trigger check so
that IRQ line enablement is not skipped.

Fixes: c95cc0d95702 ("counter: 104-quad-8: Fix persistent enabled events bug")
Link: https://lore.kernel.org/r/20220815122301.2750-1-william.gray@linaro.org/
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/counter/104-quad-8.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 62c2b7ac4339..4407203e0c9b 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -449,6 +449,9 @@ static int quad8_events_configure(struct counter_device *counter)
 			return -EINVAL;
 		}
 
+		/* Enable IRQ line */
+		irq_enabled |= BIT(event_node->channel);
+
 		/* Skip configuration if it is the same as previously set */
 		if (priv->irq_trigger[event_node->channel] == next_irq_trigger)
 			continue;
@@ -462,9 +465,6 @@ static int quad8_events_configure(struct counter_device *counter)
 			  priv->irq_trigger[event_node->channel] << 3;
 		iowrite8(QUAD8_CTR_IOR | ior_cfg,
 			 &priv->reg->channel[event_node->channel].control);
-
-		/* Enable IRQ line */
-		irq_enabled |= BIT(event_node->channel);
 	}
 
 	iowrite8(irq_enabled, &priv->reg->index_interrupt);
-- 
2.37.3

