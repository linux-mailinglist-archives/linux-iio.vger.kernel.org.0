Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774F03DCD5F
	for <lists+linux-iio@lfdr.de>; Sun,  1 Aug 2021 21:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbhHATkb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Aug 2021 15:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhHATk1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Aug 2021 15:40:27 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6369FC0613D5;
        Sun,  1 Aug 2021 12:40:18 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id m11so10321912qtx.7;
        Sun, 01 Aug 2021 12:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3wCGWQrzyuyd2FP596gwvPjVMRpxLtI0wwZ+j1tmNrA=;
        b=S9lp6eWG7lBaoA98OImEGiEoKIIDOTtu+o9P1tKGLIK62LBeWOfT1BioOtb+mA+q5F
         WOm1cRz3rsBoB/kceGolZzn/SfX0rv7QJnck+HDNTYwEAFddqF8fMyqntvZJCK2bVyJa
         x5w+E/iijjZwGHhvdaIvgEqHipjvbgmQHl8uygsCprcHzD51IX5h/iXwjo7u35KWtz8H
         HDdL54eKI/eD8LFTMuIhpmF0fQGBVlmcnymPXOkUOjKd0EIYGhzD9YtDxa4hFqtGogEk
         3nxegSYimyzjyq1U9FVnEDOoYtfCipo9899AvRPfFEDqAEnZenwAuZImYrLdBSyhL5Qh
         OWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3wCGWQrzyuyd2FP596gwvPjVMRpxLtI0wwZ+j1tmNrA=;
        b=qS7ijG0mPdXOQWBRTBeykZApc9VCIOMgppBuRKoGLkY+LHs0Vg1MoscurpA0EtD1G3
         CkSM60BQdvoKvKMvrAA325Vk9qlSvDK4jVbJIiGpHO90g/EUM3yiTZUuRbXz6Sg3n0j3
         G4sp74VWmY3phf9dqBnvXrgCoTQWVX8qqGD/tMbObcKCe1WLDa+qg7uF4Fha9wRy1bV/
         c+vCAbqovnT93N+8l4f/lS6D0nj7zUuTg1mxDsdBPRdELsqxUJEhO32bo9ayRaJlR6b/
         vZSK+sr75TxpYOCnoeGLR/D5UMV5NgTkiF6JQ7ALfqeBKZz9MIcbYBiIB8ad0ErP3YJX
         0fnw==
X-Gm-Message-State: AOAM533Nv+yIRci/hwWtgTLZo9FRkOWjX0+0hEYM5/+rNP/k5oaJPGbZ
        HiQKgMLWHj+yHPryzpgIYFg=
X-Google-Smtp-Source: ABdhPJz++KDa/exeB4OJsZoSUuZ3V7OvRvdNF9/t3RzTkLFN0Q3JUzTclHN1Et6fvW3CcUozEvOdbg==
X-Received: by 2002:a05:622a:104a:: with SMTP id f10mr85170qte.340.1627846817584;
        Sun, 01 Aug 2021 12:40:17 -0700 (PDT)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id f10sm3621606qto.31.2021.08.01.12.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 12:40:17 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v7 07/13] iio: afe: rescale: reduce risk of integer overflow
Date:   Sun,  1 Aug 2021 15:39:54 -0400
Message-Id: <20210801194000.3646303-8-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210801194000.3646303-1-liambeguin@gmail.com>
References: <20210801194000.3646303-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Reduce the risk of integer overflow by doing the scale calculation with
64bit integers and looking for a Greatest Common Divider for both parts
of the fractional value when required.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 623744da269a..abd7ad73d1ce 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -21,15 +21,24 @@
 int rescale_process_scale(struct rescale *rescale, int scale_type,
 			  int *val, int *val2)
 {
-	unsigned long long tmp;
+	s64 tmp, tmp2;
+	u32 factor;
 	u32 mult;
 	u32 rem;
 	u32 neg;
 
 	switch (scale_type) {
 	case IIO_VAL_FRACTIONAL:
-		*val *= rescale->numerator;
-		*val2 *= rescale->denominator;
+		if (check_mul_overflow(*val, rescale->numerator, (s32 *)&tmp) ||
+		    check_mul_overflow(*val2, rescale->denominator, (s32 *)&tmp2)) {
+			tmp = (s64)*val * rescale->numerator;
+			tmp2 = (s64)*val2 * rescale->denominator;
+			factor = gcd(abs(tmp), abs(tmp2));
+			tmp = div_s64(tmp, factor);
+			tmp2 = div_s64(tmp2, factor);
+		}
+		*val = tmp;
+		*val2 = tmp2;
 		return scale_type;
 	case IIO_VAL_INT:
 		*val *= rescale->numerator;
-- 
2.30.1.489.g328c10930387

