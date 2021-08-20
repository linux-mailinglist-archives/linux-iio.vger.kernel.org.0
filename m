Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BDC3F346F
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 21:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236938AbhHTTSd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 15:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhHTTSc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 15:18:32 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39370C061756;
        Fri, 20 Aug 2021 12:17:54 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id c14so6057201qvs.9;
        Fri, 20 Aug 2021 12:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zjI68m1FTfjUdZFdXRsH4SrtzTIRTWjQ+J9nVQl3/gM=;
        b=RMxWScVpPE3neU8juyICJt1HGTKsL72aDk8XFEEMY+WIyOOz27regfjg6Q9MpRk7hV
         +sgdqSjhlG0/xR1bg6/aOIfQvgNLJqUVIJVv3UzcUsHL98JSkys0qyppd2hgNIaXJnYN
         SaxmH0owmTFWA+fKz+44QkS1gq/f3bIGwMaDRH464HZ89b92MGOU5OWs0N/XFs2nky+D
         zj5nNXCLICCsSyowm0rKzAUt++ObXwzS3MAXp+6KJBADki5RrSGIjjjGrHW4kMM/rYG2
         SDGm566kzOvBInNpyTQ3B7J5ITtw8q+2+E44W79hWdSUBy/UyvxJDCsJ4fUiXoq34OyO
         F/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zjI68m1FTfjUdZFdXRsH4SrtzTIRTWjQ+J9nVQl3/gM=;
        b=UAZ8ZW8nTQCKCMwmf2Z/sYkyklxpcBdwYYzJ3AxT3IrXosdnNabMverHerjWiE3EB3
         rxe/FQLqwSbjs+W6yKCXNF63fMNGzv/fupGAcsW8S4haUXTReT6npA6d6hwmyq/yy8Fw
         y4f5lFvh3ei2N38pwx8XYJwhHDshWmNTAGcoMfmA1fbWFhWsPwX5443kbfnz3cXryl1D
         2ngKjqcMOM+jcbQjwoEtCo68tKdIf94o855yAJuDoYCNi7Ha6y3t+JFprImxVNM+OFAx
         savDzafO9+sVyZHvym9ZFaETeZNiTVrSNpXTyJkkuLuZhThBKd4IP/S+rQA9roOXuKoV
         5g7w==
X-Gm-Message-State: AOAM5336nIe3qz1ILUpTp5imQPlwH9S+3VGOSjrGyLhCEFmjrGqmcrJn
        4xq+Nmg88Tn5tRh7VOxozJ4=
X-Google-Smtp-Source: ABdhPJwwrtH02moIkCR7p+xQpPoIbZMqCGezsi/+cK4G+KMVWtOQd55Mxe7BNTYVOtEVnb3VF6uYZg==
X-Received: by 2002:a05:6214:d65:: with SMTP id 5mr21856713qvs.11.1629487073450;
        Fri, 20 Aug 2021 12:17:53 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id o6sm3603869qkp.111.2021.08.20.12.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 12:17:53 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v8 01/14] iio: inkern: apply consumer scale on IIO_VAL_INT cases
Date:   Fri, 20 Aug 2021 15:17:01 -0400
Message-Id: <20210820191714.69898-2-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
In-Reply-To: <20210820191714.69898-1-liambeguin@gmail.com>
References: <20210820191714.69898-1-liambeguin@gmail.com>
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
2.32.0.452.g940fe202adcb

