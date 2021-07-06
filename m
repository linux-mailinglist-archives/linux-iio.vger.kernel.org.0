Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA983BDB0D
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jul 2021 18:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhGFQMi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Jul 2021 12:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhGFQMa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Jul 2021 12:12:30 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32060C06175F;
        Tue,  6 Jul 2021 09:09:50 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id w5so9967396qvu.10;
        Tue, 06 Jul 2021 09:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aLIjEv3Y3XGxT5C/sRBa0wIugXh2Hwubx4IA7LHkqcs=;
        b=ooslgVwkuacSRwFRUx3MQosPkIjBAmT1hvngoQwho/oDPfTpn98k0W0nJhrBCbg2ZU
         i/rSq4Yi0vlHu/tQC3sPFeQtkFQ0YlTG18WgLeySs2Vl4wcsxVYI/eFK+6mxY7mbAbSD
         hKZ2QIP1j8I+2Jy25o04vpuWy8A+5t3MODrI/FUAx/Oa4i2Q9JqgoLfUunz0m4fEP72h
         pygiXZ7BoWDQyqyJPPBiBHSHZIjpAeRYssrHWKC1g2iacdnFbCCVpXG5jYqIa67N9/qg
         000TSkBguEzHmRer+4Y0fl4HHcRWP8cHTqQwtxOuoJtoEAgohdiIcLsXswzVFJZjaXYO
         5VZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aLIjEv3Y3XGxT5C/sRBa0wIugXh2Hwubx4IA7LHkqcs=;
        b=CSXOjFtEIkkZZVuU4mmzDcsSVA4Jl3JEw2MkLwE1FVP/SFIuhJp0e9qILymucu4O96
         15XebaL9Gw2tTlw6i1G3fiVtYwCwoxbs3EcmxLDo8A8Ps8S0H5wgIHnZ4ijhZyRzDY/m
         hFR2Olyu0ansu+iABifczfJbuFF2K4BBxS30AzelFik7sr/KmalwAkNFvo7Zdj5hdusN
         xY1cTjxf133/kT5BY9uoORctaeONf93zjpkXwkbRTKb5EjW3krhGCcBS8fAAocC7Q1JP
         4dgerfBcRIy21G+ceVsyVWErLBPBhRC70pitSPYM7eiSGNS82Da+VppoP6ds309qzwTk
         jTAg==
X-Gm-Message-State: AOAM533dHSIwpIPOwRTd5TxlWNuit/UkobSQPw2SJQn/OiKDEtErGpEn
        kDKkeb9iuMUVMPctUoJGSP4=
X-Google-Smtp-Source: ABdhPJwbcFRmDtFITFktcIQ5QmKVh4aTMpyIGd5fZYXuEHQMzLSfYmURJnVZHsdhwxqeCopttVvqYg==
X-Received: by 2002:ad4:5012:: with SMTP id s18mr19056044qvo.42.1625587789942;
        Tue, 06 Jul 2021 09:09:49 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id n64sm6995371qkd.79.2021.07.06.09.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 09:09:49 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v4 01/10] iio: inkern: apply consumer scale on IIO_VAL_INT cases
Date:   Tue,  6 Jul 2021 12:09:33 -0400
Message-Id: <20210706160942.3181474-2-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210706160942.3181474-1-liambeguin@gmail.com>
References: <20210706160942.3181474-1-liambeguin@gmail.com>
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

