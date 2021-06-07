Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98AE939DF11
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jun 2021 16:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhFGOtW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Jun 2021 10:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhFGOtV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Jun 2021 10:49:21 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA22C061787;
        Mon,  7 Jun 2021 07:47:30 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id t17so12731039qta.11;
        Mon, 07 Jun 2021 07:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aLIjEv3Y3XGxT5C/sRBa0wIugXh2Hwubx4IA7LHkqcs=;
        b=Wukgpd3X99m/VjzCKIAqRLn3sMsuyPWDI1dsqTY5oQiUjzEEr+0ONVG7ZZrCB4bVop
         K7DfFqXo0r9vJHcO6HP/iL3U81rjqXHLnVyXvun6XwDEJgyfW/Sq/+k5EmmeuEGbIIz0
         86sCxnzk6hmhbmbViRjDZdxjm9BTVkoNNn8PgyuBTwjdKznurLlOQ+q470jeYSgJgyom
         wSU6a2iVmgv7CX2sye2MlDmCt6ZrjegMMc3Oz4LSaV50WqT4wXT0nS2bhW8JNXyDcX5v
         rPZ5agOZ1YJ+FkAb8XYvZeRv92CjEHFo6mci9m3CmNH4zj9S5vNF1NrMgYKhcSW2cqdx
         vh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aLIjEv3Y3XGxT5C/sRBa0wIugXh2Hwubx4IA7LHkqcs=;
        b=BMMBu7zF6S6CB+YAbGKXNeDN+GRm26CmcHlzVRbwdjdolJ1ct/aCHtySOLyKeoYbpe
         JDDMykGQH8ZrdwjmtiyBrA+uxZ9Wwuv11vsE90SGV6+zPEZLaOs2ULk10+U6BwDrUXFB
         UTCMedkIzRhbbzI/Etm04qMepsBo5TQ4Oc9V0bRsKExKCP5KcfiVdF+hZoNL+IJseHUY
         Gw5vGo1IZwJTUV2rdnIe+qYZ8uztVZwZ3XJk+nAvOWwjMlhdSUAngtNUGEjf2DOvsAgb
         J+gDlSAP6lHkPX1l4JUjIyMpZsuUElMyNk+dB9MLq+qN02+TyJXrZ60vG6meptTgy3XK
         pQFg==
X-Gm-Message-State: AOAM531jE98xyK2WRchqDOwalBcLKR/0a2/28wW5LL5HCs/SiobspCIR
        IB71r5h7Exi07Z98aip0XPA=
X-Google-Smtp-Source: ABdhPJwPiDTDsvGF4sYulFsvUfdsPXRpiCmpGhthbyRGp4DltexZj74T1IXf8CDGsKJoDs5p/obOFw==
X-Received: by 2002:ac8:7215:: with SMTP id a21mr12382069qtp.329.1623077249206;
        Mon, 07 Jun 2021 07:47:29 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id s7sm4157855qkp.35.2021.06.07.07.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 07:47:28 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v2 1/8] iio: inkern: apply consumer scale on IIO_VAL_INT cases
Date:   Mon,  7 Jun 2021 10:47:11 -0400
Message-Id: <20210607144718.1724413-2-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210607144718.1724413-1-liambeguin@gmail.com>
References: <20210607144718.1724413-1-liambeguin@gmail.com>
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

