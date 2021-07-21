Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD7C3D0719
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 05:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhGUC0g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Jul 2021 22:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbhGUC0Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jul 2021 22:26:25 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743DEC061574;
        Tue, 20 Jul 2021 20:07:02 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id q15so1065099qtp.0;
        Tue, 20 Jul 2021 20:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OKwbA7CkZ/dV0H/nAmt5zTOn4ixRO23QkLcRozVJn9c=;
        b=tpT0Bo0saWDiswje5emv5emtlmtpDKJqhEw32Dm+/AqpGcCMns0YWXgNkSEDaFyJ6s
         gCyTU23DQt4+eAz8NiDnjC4qQ5wecJYrpnyj7oc1jUsGlNPYA+AtRw4Nmb4ZSq2l3EnR
         nXCDjzNAajq1GziHbTokT4iHxAmF0hzDFJT2CkpXnojc0anOxsQqTaofChO+mfEGZQPs
         d0fZBuACGXNQhEsE2tCh5hHgfAAXliCY3iqAvxzvuR4tSLjFTWKUp7jAao1KIkUNY8Jy
         /wckLOYCx3bu+GSUPKdZpWfyIDTWlPkZHeFh+/yevuANDyndr3e8Ml5Ctab+AnLSprn/
         FJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OKwbA7CkZ/dV0H/nAmt5zTOn4ixRO23QkLcRozVJn9c=;
        b=OTmKuD7IM7aKX4JxA0C2GJUiQ4q0EgJmYObKA/iMrb581FOHsdzLGNF9d87Y65lZ7j
         p3dEDY1EcAYGQL4CcxcyOUXiw8hN1On+6Mlz9ZafYdxIZHXHDj8OZbNpjPYfV4ppS0S+
         6LHipblJQJCHiD8Z1GdSoRFyFr+EkQS4LBIjKOSvVHEkEgQrQ1zDhgNnJ2KFbZaaZRdg
         Jlvv2GAK3N8lDika5NzcPDtaxzL0HI3n24a/MdrEqXnLNl1xEyMnFvBHS8TpSu+zb1h+
         AT7230CUCuSBja2LD0g4D8hYKENVpPF8gDy4mtyWIVXpQL6O8TIksE9q9QD4Xlj38vs3
         Uuxw==
X-Gm-Message-State: AOAM530hHEM0yIS3Zhk4d6CIilLohIMro82gWxhRmpcSbRN+5a1lTgUa
        7+NRWPhNtkYNvHU8RhurOSE=
X-Google-Smtp-Source: ABdhPJxP9OgxwC3BWp8HPuEJCPPTiTkrLCVMGTSbFULt6l66+Emzl1EerVGjeAa+ySSty5NRjDpVGQ==
X-Received: by 2002:a05:622a:d5:: with SMTP id p21mr3817934qtw.75.1626836821656;
        Tue, 20 Jul 2021 20:07:01 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id g76sm10561024qke.127.2021.07.20.20.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 20:07:01 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v6 02/13] iio: inkern: apply consumer scale when no channel scale is available
Date:   Tue, 20 Jul 2021 23:06:02 -0400
Message-Id: <20210721030613.3105327-3-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210721030613.3105327-1-liambeguin@gmail.com>
References: <20210721030613.3105327-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

When a consumer calls iio_read_channel_processed() and no channel scale
is available, it's assumed that the scale is one and the raw value is
returned as expected.

On the other hand, if the consumer calls iio_convert_raw_to_processed()
the scaling factor requested by the consumer is not applied.

This for example causes the consumer to process mV when expecting uV.
Make sure to always apply the scaling factor requested by the consumer.

Fixes: adc8ec5ff183 ("iio: inkern: pass through raw values if no scaling")
Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/inkern.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index b752fe5818e7..b69027690ed5 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -590,10 +590,10 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 					IIO_CHAN_INFO_SCALE);
 	if (scale_type < 0) {
 		/*
-		 * Just pass raw values as processed if no scaling is
-		 * available.
+		 * If no channel scaling is available apply consumer scale to
+		 * raw value and return.
 		 */
-		*processed = raw;
+		*processed = raw * scale;
 		return 0;
 	}
 
-- 
2.30.1.489.g328c10930387

