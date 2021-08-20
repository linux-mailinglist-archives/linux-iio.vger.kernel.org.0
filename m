Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCF93F3482
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 21:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239217AbhHTTSx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 15:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238706AbhHTTSp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 15:18:45 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDBAC06129E;
        Fri, 20 Aug 2021 12:18:02 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id y144so11942987qkb.6;
        Fri, 20 Aug 2021 12:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YnnFSbZWVuY/lp3GGbUfkpd0TSOBOPS1Fj7ATDd62Jc=;
        b=I0nxilWJsRfK6KtVkgqY1F+/052IFgYsFi0t+OjNXb5/PwEZFX3DA9Ur4ERAnX8GJo
         cOO+Quz3JR/+GxzwAf6Nf2lvnLyz7uT5SPVSJEmJuqq0DFXkStJr+VpVOr8XFqTiufiz
         c601xsY2Bo/RcQYPfL+SnDKZimjgoMTaGE21QnAmHkvR0q/RmP6TU25g9d8twzbawXrz
         KYz4pYtEDVXu1z4Pgh9xm4npobIhayS9s5gYz/IHdvEe+ya/xKwr64DFB2Mt91/LJtpJ
         OORaIMUZLZba89uJKWWdvE8qAudL6BvC631/F1LMsqlxpGrt+worD9u/6i5PEfqKVWzf
         Ypgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YnnFSbZWVuY/lp3GGbUfkpd0TSOBOPS1Fj7ATDd62Jc=;
        b=Le4kUv0Emvy/yxDkNjdFEWIgDGYMHV14SPn31EtkOX74TrBWjY9kVSHIsUDdo1iLWo
         iosMnyNgfHCY7LvzItbY46IxiaYnXupp/6iFdLUpnAxZIaa0vKiWqt7s6+REghFU7ZTw
         jPMLJhb4urQhCZFvL4QjrIJtCqaiRWfz4x1rKCpwKmykYG7k4dhEwCnO9r4lNFvDdygk
         JCKHkiMZd7Wu/8mjSWnog9/5ZDeX6A3gmDM7ah2ZAUHGdPzgAFAh3S2Ft4T/qlmskMzK
         AMl4z5N/S1z2OGiKM5kfGSudRbOpPSQCI21WCwM9zDjK0hLEDdb6eGXcU7A4I1fFfCYQ
         wOhw==
X-Gm-Message-State: AOAM532qrbQVaTxCpeSBFswGH74yrjIkF9Jtv8bECZYRbxmw+m2x3hTq
        pzHYdh2RA35kRyYXLT9fByE=
X-Google-Smtp-Source: ABdhPJwxWS8FwzBKx8rfEPSBwNSO4R9/W4j+cQ4I+2f0wsrarpZxDoUQUQ0evZ1PRY5OlXj0LNaNHA==
X-Received: by 2002:a05:620a:2045:: with SMTP id d5mr3628969qka.281.1629487081316;
        Fri, 20 Aug 2021 12:18:01 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id o6sm3603869qkp.111.2021.08.20.12.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 12:18:00 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v8 09/14] iio: afe: rescale: fix accuracy for small fractional scales
Date:   Fri, 20 Aug 2021 15:17:09 -0400
Message-Id: <20210820191714.69898-10-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
In-Reply-To: <20210820191714.69898-1-liambeguin@gmail.com>
References: <20210820191714.69898-1-liambeguin@gmail.com>
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
 drivers/iio/afe/iio-rescale.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index c408c4057c08..7304306c9806 100644
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
 
@@ -38,8 +38,31 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 		tmp = (s64)*val * 1000000000LL;
 		tmp = div_s64(tmp, rescale->denominator);
 		tmp *= rescale->numerator;
-		tmp = div_s64(tmp, 1000000000LL);
+
+		tmp = div_s64_rem(tmp, 1000000000LL, &rem);
 		*val = tmp;
+
+		/*
+		 * For small values, the approximation can be costly,
+		 * change scale type to maintain accuracy.
+		 *
+		 * 100 vs. 10000000 NANO caps the error to about 100 ppm.
+		 */
+		if (scale_type == IIO_VAL_FRACTIONAL)
+			tmp = *val2;
+		else
+			tmp = 1 << *val2;
+
+		 if (abs(rem) > 10000000 && abs(*val / tmp) < 100) {
+			 *val = div_s64_rem(*val, tmp, &rem2);
+
+			 *val2 = div_s64(rem, tmp);
+			 if (rem2)
+				 *val2 += div_s64(rem2 * 1000000000LL, tmp);
+
+			 return IIO_VAL_INT_PLUS_NANO;
+		 }
+
 		return scale_type;
 	case IIO_VAL_INT_PLUS_NANO:
 	case IIO_VAL_INT_PLUS_MICRO:
-- 
2.32.0.452.g940fe202adcb

