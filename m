Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3572D68FF
	for <lists+linux-iio@lfdr.de>; Thu, 10 Dec 2020 21:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393257AbgLJUnJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Dec 2020 15:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbgLJUnJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Dec 2020 15:43:09 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC607C061794
        for <linux-iio@vger.kernel.org>; Thu, 10 Dec 2020 12:42:28 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id c12so4856856pgm.4
        for <linux-iio@vger.kernel.org>; Thu, 10 Dec 2020 12:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vc0hna1MMQXcI9WHF5sYV5Q5q5p+6qbvyeixpWRhxpg=;
        b=bGycRMOLqTdh0xLH7G+D4rsqRWzBs12WPAdwx1hSI2heG0ERRdwJZkLL0Wlz9u2O3F
         l8aeyCU8+G64e6tW54FphsKC/b7auHSEBtS2yOx2M2pE6R24mxTznywS8+AX9DNhCC6b
         WmFCElEe7u+L9gCujRaYMt8BQbLgbzezNsjPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vc0hna1MMQXcI9WHF5sYV5Q5q5p+6qbvyeixpWRhxpg=;
        b=bZuZV7wR8en3dxV58q4l7taBGzozIIoz6qs/NUCSR7tcjvwxUpub7Ps1WNriS01IHq
         wcC5W9pphPnDSFuqwFzML7wgtslbabRskQL2+IPDitPyatO1HTrYnOr0G1mYdNtVTiW7
         iZmYX1WICwKDVdZT1cAktUgSl2liIgw5BK9avs+lpULcGqG6R3jfYdT0u+VsG4wgNPaw
         H5e9pkgtHUJ+vPwgS2PXg0o7VgwAaPNGXR2q9SFjfbDINFOQiNAP7teJ9dfu+wyK4ece
         eQfkOsjcVUl/iktVYFulPcmvMEDeJDx4JEMS4R0Q+hOO9at4IL9JDyZ4QotDQ2UXu19z
         Jj/A==
X-Gm-Message-State: AOAM530tnNQDGS1BiEJYrQgc90vIfVOLe+r3deBX2JK4XCUWf+nxq2Va
        HiL4i9JU9sdhPH+Nj6q2dq/AJg==
X-Google-Smtp-Source: ABdhPJwclV0n72FmARFTysM+4EE7k4J7+Lmpzg/p5wC7NDUIpTQoggGD3h/7ByUBsJsa6Sf+/Z3dug==
X-Received: by 2002:a62:dd94:0:b029:19e:92ec:722a with SMTP id w142-20020a62dd940000b029019e92ec722amr8257426pff.50.1607632948437;
        Thu, 10 Dec 2020 12:42:28 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id h16sm7254927pgd.62.2020.12.10.12.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 12:42:27 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 4/7] iio: gp2ap020a00f: Remove code to set trigger parent
Date:   Thu, 10 Dec 2020 12:42:08 -0800
Message-Id: <20201210204211.967018-5-gwendal@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201210204211.967018-1-gwendal@chromium.org>
References: <20201210204211.967018-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Already done in boiler plate code

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/light/gp2ap020a00f.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index e2850c1a7353..d1d9f2d319e4 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -1551,7 +1551,6 @@ static int gp2ap020a00f_probe(struct i2c_client *client,
 	}
 
 	data->trig->ops = &gp2ap020a00f_trigger_ops;
-	data->trig->dev.parent = &data->client->dev;
 
 	init_irq_work(&data->work, gp2ap020a00f_iio_trigger_work);
 
-- 
2.29.2.576.ga3fc446d84-goog

