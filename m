Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C383CC6DC
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jul 2021 01:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhGQXkp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Jul 2021 19:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbhGQXka (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 17 Jul 2021 19:40:30 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B97C061762;
        Sat, 17 Jul 2021 16:37:33 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u8-20020a7bcb080000b02901e44e9caa2aso8086151wmj.4;
        Sat, 17 Jul 2021 16:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w4Deofgk9HydoSwsSwYhSOQ6AZsKWmThrjuDOLQIJSI=;
        b=tTHN8RTiCkN/u7Gbn97q4JpAMsasfakEr/B3J8YpXz9hfM9fty/H+aGOKk5jp2g0Tp
         12Zb6Vx1XHpRvm1DTeRYTZfar4rF85rfb7Kzj3srhwVnfsfiG9df7rHWHtalo1bW57dv
         aCUOOWHPWC3rnfAFSp8aAuxn6UubejdrhndpyCBFspbQZLRM2ZKbGCvXruQcKYNt2Rkq
         v7oO5j0HGGMqDJr7dnRkVy5+rvc4l7GXpRmj4wAAVsY8g+SiTk/BoGoJ11ox7Rp4mmxn
         O4KQdExtxE2myqpI3hsOcocHYc7mUib7GFTZaFanybABokArmzPFMmxmkfhaiFvR1AoZ
         0kgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w4Deofgk9HydoSwsSwYhSOQ6AZsKWmThrjuDOLQIJSI=;
        b=mQfwTp4X9Ezusgu38hy8YtCy8HHrWzu6JjcnE3fL3vo6LjcPe8N9+Whgc+GlhPHPa6
         W03C8xibia6yC+bmUZpJUDnXfIHUTVTMQWK0JGDWCH6h5n6325X8UN49OKYwPd4sGhqj
         6oirSUAImhij/RtiYhB7tyWs6wo+74uUCNq8Y3CkJCkSnGQbzkIwrmR4+h5mos6IL7nE
         QWlPDo9lMfffahTPrIUizgXXDYALmII9MeqCjHZEauCfaV2FBVUZ7zPD1Ie6WfRU1b7h
         Nmax4sAGi7GxVD+10wovk+vLatWSvy4WJ8zIC6qLJXAijxAEV3YBAIbc3iGqL+mrX2tn
         yOyQ==
X-Gm-Message-State: AOAM532NbCLPg36auGuuhRq/KB4tZPfvb0pRzDCwhx1NbJRWIkQqrdXA
        2vmFzsjAy76BJVTJjUhsWPGLVeXj3/4=
X-Google-Smtp-Source: ABdhPJwraMU1GDmwhidsRZxMlU3RDNSzTZ2alCY2KohjN9YprNOVczppy8RoAv0EuRw77Hg9HkzYMg==
X-Received: by 2002:a7b:cd15:: with SMTP id f21mr18955629wmj.148.1626565051265;
        Sat, 17 Jul 2021 16:37:31 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-7602-4e00-f22f-74ff-fe21-0725.c22.pool.telefonica.de. [2a01:c22:7602:4e00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id q7sm12347527wmq.33.2021.07.17.16.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 16:37:31 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, jic23@kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/3] iio: adc: meson-saradc: Add missing space between if and parenthesis
Date:   Sun, 18 Jul 2021 01:37:17 +0200
Message-Id: <20210717233718.332267-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210717233718.332267-1-martin.blumenstingl@googlemail.com>
References: <20210717233718.332267-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a missing space between if and the opening parenthesis to make the
coding style consistent across the whole driver. No functional changes
intended.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/iio/adc/meson_saradc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index e140db3e4016..b4e16f2e957f 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -347,7 +347,7 @@ static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
 	int regval, fifo_chan, fifo_val, count;
 
-	if(!wait_for_completion_timeout(&priv->done,
+	if (!wait_for_completion_timeout(&priv->done,
 				msecs_to_jiffies(MESON_SAR_ADC_TIMEOUT)))
 		return -ETIMEDOUT;
 
-- 
2.32.0

