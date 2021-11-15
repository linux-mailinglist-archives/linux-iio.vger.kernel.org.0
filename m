Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1034144FDA6
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 04:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237015AbhKODq7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 22:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236996AbhKODqs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Nov 2021 22:46:48 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61A7C06120A;
        Sun, 14 Nov 2021 19:43:50 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id p4so6964673qkm.7;
        Sun, 14 Nov 2021 19:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jbkvNiZPeqKZDFobOFBdHT7ASm74e41udPizXrb8loc=;
        b=gqQu1qRYyYkbkTxRfa2gJq13cZESiPU6TwYXyhhtszE8OP2w0N/JT842Bqu0t8la7u
         9dTURCd3Q8xz+cqeusNg8cgUPy9NrTsdINrJUjf0RwKSg9u7WYr5G/DHaUz7VZTW2LtF
         qdCsWFfpOdu9KTRoov6p4KQzRDR10ChVZPotvFX6yrGz7jrW9/6sn6WUid5PN6N+sq9S
         bQ8Ahys8rltIeg5lyX36PwJMXRNysE8+yY/e1pmHniL//RFm81MkettaJHYQLnoJuq9L
         M8qMXkqJQz08lyQGYr+ajgSnzxV2aqxPi0SeA1Ip7q/rFRlzyCPYUOm6ffgfZhViygoo
         jlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jbkvNiZPeqKZDFobOFBdHT7ASm74e41udPizXrb8loc=;
        b=e6cksk26ka196tMSJXeZDp2MwvgD5+osKtRZ+/Bz5NpyjdCPxP+j9I+5grFShahegb
         rb5rwuO9gI8vc/h/mHXJz3Dwf52TFUpGwXYRLBwfQkeT9Zz0lNffDiRt9Yn8pIiy93GW
         XRjgEiGkCJ+ozPjWUz+wHcmW0f9VS9kqQuOy/MNCuICo+71IfHU/AefVMf4U3dLY3ED5
         +C8tnAY7Fy+1XOBCA95y3FNphnEWP2aOZjQ+quyET+LcT3gcbSXI5jBQycwBispKSg5b
         /UvOVjQy1DpM+eHLa/+9E8jyqIErhuDQoecYI4ifwfnCb0g0ODcVGvdY+95ycg3z67hE
         dMQw==
X-Gm-Message-State: AOAM532ysMEQoLeIwS9UcOM6l6Yne2rAj6ica+v28h0jvkInd9Qu3E5C
        NiQFDKspDn+ZuwbE4B3g6swi1m+dJRY=
X-Google-Smtp-Source: ABdhPJwXbbMyQTknT3hcPa31IUIno454eah6cdfqQiinZd09ZQjFYtKMbMa3fLmY/o2bEBfNR0awtA==
X-Received: by 2002:a05:620a:4248:: with SMTP id w8mr27476306qko.228.1636947829962;
        Sun, 14 Nov 2021 19:43:49 -0800 (PST)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id h5sm206519qkn.62.2021.11.14.19.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 19:43:49 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v9 09/14] iio: afe: rescale: fix accuracy for small fractional scales
Date:   Sun, 14 Nov 2021 22:43:29 -0500
Message-Id: <20211115034334.1713050-10-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
In-Reply-To: <20211115034334.1713050-1-liambeguin@gmail.com>
References: <20211115034334.1713050-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

The approximation caused by integer divisions can be costly on smaller
scale values since the decimal part is significant compared to the
integer part. Switch to an IIO_VAL_INT_PLUS_NANO scale type in such
cases to maintain accuracy.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 17036130d364..8a2f1c0ca5a3 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -22,7 +22,7 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 			  int *val, int *val2)
 {
 	s64 tmp;
-	s32 rem;
+	s32 rem, rem2;
 	u32 mult;
 	u32 neg;
 
@@ -38,9 +38,26 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 		tmp = (s64)*val * 1000000000LL;
 		tmp = div_s64(tmp, rescale->denominator);
 		tmp *= rescale->numerator;
-		tmp = div_s64(tmp, 1000000000LL);
+
+		tmp = div_s64_rem(tmp, 1000000000LL, &rem);
 		*val = tmp;
-		return scale_type;
+
+		if (!rem)
+			return scale_type;
+
+		if (scale_type == IIO_VAL_FRACTIONAL)
+			tmp = *val2;
+		else
+			tmp = 1 << *val2;
+
+		rem2 = *val % (int)tmp;
+		*val = *val / (int)tmp;
+
+		*val2 = rem / (int)tmp;
+		if (rem2)
+			*val2 += div_s64((s64)rem2 * 1000000000LL, tmp);
+
+		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_VAL_INT_PLUS_NANO:
 	case IIO_VAL_INT_PLUS_MICRO:
 		if (scale_type == IIO_VAL_INT_PLUS_NANO)
-- 
2.32.0.452.g940fe202adcb

