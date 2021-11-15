Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671CE44FD8D
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 04:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236998AbhKODqr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 22:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236980AbhKODqj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Nov 2021 22:46:39 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23806C0613B9;
        Sun, 14 Nov 2021 19:43:44 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id q14so14362189qtx.10;
        Sun, 14 Nov 2021 19:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VMY/JioF3zIz+Odh4I/DMfpPOO5BAQwBFBQHl1YqOXg=;
        b=XCzh1vVCyZqeQus0OO+L0Fq/KxcL9FHjGn3HgY4xzR+SFl7FH3xZ1F7zapXOLVi0Wm
         Cb4tZ4Tin4Kk1/mwxVNR1w6ihE2R2397a4hjNJdOJr+Sa8dLU7lGG/0+4xkbaC05xxIB
         93zeARHa7zcTDjR4fbQr5n8k8gAvkCjmaUDjxDEl0WKNWEjePljFGM8W40/aI3ygFO1x
         NJJpCFHDcP+TPIAw7ycor47Q1TFADXZzTbtpm5U96njlmJkIuWmEyJF4jko7SpbkX863
         nbc/PrC49Uoa5fcgk8R/prVAUhFq5L1bfutwGhG3gLZ9Q5ASIZfBzH4m+FYVkEciZ1Lm
         bXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VMY/JioF3zIz+Odh4I/DMfpPOO5BAQwBFBQHl1YqOXg=;
        b=4h+9OmV0Y4amhgcSM/GkEhuASkc3WUNGLAuePnF7boOwdihXynjg5absLb1BVrUQfS
         grINRSzQrZL21Z3XRpXygQNDXRFXSFCXfBA4haPeRGWUPo50aKlEkNrGpS2Gbjsy+Hey
         SFcs6ovbSTlfZ/xHjjbTylLvQw06xHP76ZMsRvzorancey24Cm7MMAJTbPV+pDs+V14i
         3qXg4s5iqll7MZb4FCuf4NOnTvlmodCcFzQQ/ULqejsxA4cP+niznu4VXki8u/LdqVKe
         qQ5Ht1djj3Fx7/7yX8Dhiz+g8NDzgXdxe4W+b76tRREQj73D/eEJoRJab74U0S/4ek65
         w+gQ==
X-Gm-Message-State: AOAM5309f7/e/rbQzxLSJTP0BK6ZXvJw9ekngDCWVSt1soj2alTHNKef
        odxgj8QU7Dddea6Ud4s19Fw=
X-Google-Smtp-Source: ABdhPJwCrPSlOg81o6BVcDvxJvuSkeNrb/3pXRDLCJNzhPWKtFnGibkV7lDiTGLMKmaOqROS2JDmoA==
X-Received: by 2002:ac8:5c16:: with SMTP id i22mr12526397qti.313.1636947823306;
        Sun, 14 Nov 2021 19:43:43 -0800 (PST)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id h5sm206519qkn.62.2021.11.14.19.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 19:43:42 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v9 02/14] iio: inkern: apply consumer scale when no channel scale is available
Date:   Sun, 14 Nov 2021 22:43:22 -0500
Message-Id: <20211115034334.1713050-3-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
In-Reply-To: <20211115034334.1713050-1-liambeguin@gmail.com>
References: <20211115034334.1713050-1-liambeguin@gmail.com>
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
index 021e1397ffc5..dbe13fad3cbb 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -607,10 +607,10 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
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
2.32.0.452.g940fe202adcb

