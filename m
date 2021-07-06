Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50243BDB0E
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jul 2021 18:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhGFQMj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Jul 2021 12:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhGFQMb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Jul 2021 12:12:31 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E7EC061760;
        Tue,  6 Jul 2021 09:09:51 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id b18so9130592qkc.5;
        Tue, 06 Jul 2021 09:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OKwbA7CkZ/dV0H/nAmt5zTOn4ixRO23QkLcRozVJn9c=;
        b=l9bgPB70cW+ZDWBhR+0VT551KHAu6Gd4kifcH3anozVFskHhH5GKOT2y4IG9BVEXUp
         UbQc4wY/NfoYABiRDVAq/wfb5irgnLRK08nlsMBxoMT3tAVFVDSPPxVbiTJ2h0qJBrIn
         gIcCIPZAmrScFmOd5E/kNHSchaHhuyyWaGVBFCYDomfHy8kE09sDYbUgciMqvhqZkc0V
         awJf5oGNlS4rnxivafWj12RUjo+zObocedf3VvgilSLQaLFCVoMNgpnFk3Mkxxrrp5ZA
         ADM84DioKBATmIpFrxDsuC/7fNaV8mcNyFbj/cPvcJcK7uLcLzWjjBPuSXCHfPr++sQQ
         LO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OKwbA7CkZ/dV0H/nAmt5zTOn4ixRO23QkLcRozVJn9c=;
        b=T6/LQdzC4h7rxyzt5GSGN9J4ye0KHY2hTxtQiC9N6Qj58gAwRYPyGwwlLVPKY5EOZ7
         idgI3KCKKNQwNyGJiJGtoSWbZD74U7mcTw4TKR9WHMsvoeDe1zYz5r2A3mjWzd6QpCj9
         qTs680w3x5lbVh/5mVbr0+uBwWLOMGuopB1MWw8L+7P385zyvCnTzDeGkbONpsCp38+9
         5lWpib0iAR7kF/Q12HqKpvt/RpkwRkr15QjXA7iJQU7jJeFty03BxqeMT9/JDoPVeuLi
         cxuaeBs/2MOXOHUUq+cR25w1p/tdmIaEZFiTI1HcNWhgp7dEvLo5JeZaLnaKGeAQVOZq
         bZHg==
X-Gm-Message-State: AOAM531zVsTYkggly07PA7WpQHJZN3xWhtPAdnJFLu6C6wKPPE65U8iq
        za2TWE5f7uK2Vu2U1c2eN8Q=
X-Google-Smtp-Source: ABdhPJzGdBnd6HPVbpfhjvoOCrBsLso3Jwx++T1QiiSrjPkd2MBn03G26+PJD5PgI6cIr0U2h6ShrQ==
X-Received: by 2002:a37:278a:: with SMTP id n132mr16257901qkn.339.1625587790857;
        Tue, 06 Jul 2021 09:09:50 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id n64sm6995371qkd.79.2021.07.06.09.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 09:09:50 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v4 02/10] iio: inkern: apply consumer scale when no channel scale is available
Date:   Tue,  6 Jul 2021 12:09:34 -0400
Message-Id: <20210706160942.3181474-3-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210706160942.3181474-1-liambeguin@gmail.com>
References: <20210706160942.3181474-1-liambeguin@gmail.com>
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

