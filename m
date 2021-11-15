Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEC544FD8C
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 04:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236991AbhKODqt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 22:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236975AbhKODqi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Nov 2021 22:46:38 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB1FC061767;
        Sun, 14 Nov 2021 19:43:43 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id f20so14081216qtb.4;
        Sun, 14 Nov 2021 19:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Petjn8wOVRgbGhHpVIXk1V8uScdJMFucnSi/yCBhRaU=;
        b=nZL2M21XBEkgJywhAn6qtQMz/KyxzuoC/ryZVNj5xJJq96qOGJ6aZmpduntslF+/OW
         S3DZnV+TyOYZEdRxRgnBrizJI4N4BB516u4XEsBCamSkX3SdohNn7oaWu8FhjAHGTx0R
         Zy2NAmTYqTgY4K+PPQCCDYMyFuaaket4UThSSkx7okMp2h+bAqBBmTcDphjQ2IMp8raa
         H2TlhaTg3QfbS9jZsbpBkPYDoKI+rWG6XiRY1O3yXrR8fMUzN/38BcH8WBmSTkkLf9yu
         yH8pOeZatv9ZL3VM2IqOsTM+Soem1QTZrTqtV4nM74nKTZ0Qi7IgMqjZfak9NSV2BkHR
         whew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Petjn8wOVRgbGhHpVIXk1V8uScdJMFucnSi/yCBhRaU=;
        b=GqGGiGFc7CtaGDWWXGWgMpJ8iK6y0/0lb95hZIQMe4PKcrgCwPce47lYmp3mYZf7Vr
         RvlPAWjMeUNYi9iLYMqVIIRG6T9yh8sRTg4s9vcLHrhqyM//7uTrPBSVYFpAtMCind3C
         +JHkxRQ76LnPviFFM4pSW9Pd5J6Fsx+XTdoemRVxoTzMCOybYobXZoHZVY5qaIwcXNtw
         AngefXzjZ2CjGB8B/n12TSDosXBsKRzImsDsK1WqqF3kA0xmLdVmscI1jEPKLDTih/6t
         ekVCZdVV4Ls9KTo+IjmOLjZhRLsfFWEiPIqCtaNW5XycZu875MyALxZKrVWdddI418KZ
         9IxA==
X-Gm-Message-State: AOAM531f9NN9H7Amb2MHPb+6OKB6nscY5hXQ6OKUhSuyL19Diuw5dz5P
        CLvvi2WD8O6iPueTW7H7QtU=
X-Google-Smtp-Source: ABdhPJzqAdDOiO6S2FiCYtpNmkh1L85teqKeCkxqksjwNVsppYpYQYinWIuZ90tifePoaGvT2vNydQ==
X-Received: by 2002:a05:622a:170d:: with SMTP id h13mr32524468qtk.99.1636947822458;
        Sun, 14 Nov 2021 19:43:42 -0800 (PST)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id h5sm206519qkn.62.2021.11.14.19.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 19:43:41 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v9 01/14] iio: inkern: apply consumer scale on IIO_VAL_INT cases
Date:   Sun, 14 Nov 2021 22:43:21 -0500
Message-Id: <20211115034334.1713050-2-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
In-Reply-To: <20211115034334.1713050-1-liambeguin@gmail.com>
References: <20211115034334.1713050-1-liambeguin@gmail.com>
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
index 0222885b334c..021e1397ffc5 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -616,7 +616,7 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 
 	switch (scale_type) {
 	case IIO_VAL_INT:
-		*processed = raw64 * scale_val;
+		*processed = raw64 * scale_val * scale;
 		break;
 	case IIO_VAL_INT_PLUS_MICRO:
 		if (scale_val2 < 0)
-- 
2.32.0.452.g940fe202adcb

