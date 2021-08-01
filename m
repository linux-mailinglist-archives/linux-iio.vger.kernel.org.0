Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D373DCD4F
	for <lists+linux-iio@lfdr.de>; Sun,  1 Aug 2021 21:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhHATkX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Aug 2021 15:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhHATkW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Aug 2021 15:40:22 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4DEC0613D3;
        Sun,  1 Aug 2021 12:40:13 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id l24so10334887qtj.4;
        Sun, 01 Aug 2021 12:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aLIjEv3Y3XGxT5C/sRBa0wIugXh2Hwubx4IA7LHkqcs=;
        b=dzG+MAqz/Sb4ya3ePvJyRkD31JJY5HYLT4GhK/3639OAm/Xjau+2W9xk4zufy0aR5d
         RTbkIZ3QaQwrkVJl6McyArrDE8BL1XUiwK1WanxCrmBVp3ntp5b3MKplgHRho6R5i825
         UBDjWewYc28JVpvBFOMV77v/SSjuWZC/vV/TeJZe4MOf5SLfvNA+199O1Xl/0AXsg1PK
         Y4orGBsUODq7LwHrxTPIAlnKUmHa4F9UU0uE83SypnUzO8bAEny4LaMIaECdnwc4xz05
         OOJFYMzPjtIMqG4sOy0LFWOyn94vcr78FOHVVDa17UBN1DLY6Bnv5TAhOCXSBOWlQ37z
         MUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aLIjEv3Y3XGxT5C/sRBa0wIugXh2Hwubx4IA7LHkqcs=;
        b=gE9s8PySc9ULKv/26JX6DQs2gGuNEuDnN4DSJVKZaPCcI5o6KJg8EIqb0QA1XGBNkT
         3nMLwNnqM4urWqjVG25g9fQK6NIhredxiifUeyq6rni2YCdP7qWfXxQmPyjFroRkUdok
         fFg0nlk6Clw+iIwPPu+SfMNg60wD3UIZs/rFMZdBfBT94mrpTwbOupo5xDupESGy3eF9
         0GeicPbA2wpiEBZdLuEOWbf3g1kHlsYVT7bMDQ5GL/zgjUISsCU4+HapM8Ut5mGv2SDX
         9oo7Fo65AYNNBPhwBM/St+6rAAgQnGmeXUDKoBummLTck29A+6NA650puqR0QQgyRl4N
         b8vw==
X-Gm-Message-State: AOAM533K7omN161G2G+BFtatBaYbPmL6AEBhMQgvKalwy3GzYO5um8ij
        MF6WNzem1dgCEfm49FHx7l4=
X-Google-Smtp-Source: ABdhPJx0v0bhE0Ov2CnPwdwv1McBjkgelOuMproMqFlOMrmvZ5PanoporcwO+bI1pg1UcfQpUw7paQ==
X-Received: by 2002:ac8:665a:: with SMTP id j26mr11530747qtp.254.1627846811657;
        Sun, 01 Aug 2021 12:40:11 -0700 (PDT)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id f10sm3621606qto.31.2021.08.01.12.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 12:40:11 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v7 01/13] iio: inkern: apply consumer scale on IIO_VAL_INT cases
Date:   Sun,  1 Aug 2021 15:39:48 -0400
Message-Id: <20210801194000.3646303-2-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210801194000.3646303-1-liambeguin@gmail.com>
References: <20210801194000.3646303-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

When a consumer calls iio_read_channel_processed() and the channel has
an integer scale, the scale channel scale is applied and the processed
value is returned as expected.

On the other hand, if the consumer calls iio_convert_raw_to_processed()
the scaling factor requested by the consumer is not applied.

This for example causes the consumer to process mV when expecting uV.
Make sure to always apply the scaling factor requested by the consumer.

Fixes: 48e44ce0f881 ("iio:inkern: Add function to read the processed value")
Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/inkern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 391a3380a1d1..b752fe5818e7 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -599,7 +599,7 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 
 	switch (scale_type) {
 	case IIO_VAL_INT:
-		*processed = raw64 * scale_val;
+		*processed = raw64 * scale_val * scale;
 		break;
 	case IIO_VAL_INT_PLUS_MICRO:
 		if (scale_val2 < 0)
-- 
2.30.1.489.g328c10930387

