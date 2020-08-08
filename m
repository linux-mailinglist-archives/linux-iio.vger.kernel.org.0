Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE3423F780
	for <lists+linux-iio@lfdr.de>; Sat,  8 Aug 2020 14:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgHHMNc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Aug 2020 08:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgHHMLG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2020 08:11:06 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF85C061A27
        for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2020 05:11:01 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a26so4771442ejc.2
        for <linux-iio@vger.kernel.org>; Sat, 08 Aug 2020 05:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AIzoyOqsmvq2UL6ht5EBrZhZITvwdcSbBz+FO/uaKCQ=;
        b=LyblSclQpF5crcdFVVNLh5GR6t/10gHDiCpaCcye5I3bANIIXnNhx/kjSO0QghXDNI
         RyrUoJ8DjDoQ5IzPKKIJB1nKQZnFFF2BUBsq9fRVXQsbBUfOOT2W5Bv0k+ryGtun9ffZ
         UuAchgJNtd1ZpQ531U1tArWf+URhm+u75sG5ME+qzmc0GNvfmd+Uty8mFheRqkuji7eP
         75A6QdPvTI7+m5ykdZpLrh0Jhx+Mt8zhuwjKx/Zt0xoa7ox2uGg+v3yary1dJpqY/xgD
         ZAX/jmYHZaiTqw/iyQ/lzkwPUY58PrHmy+rF3U3ZtvwQ4+XQNcI34zakwcQIWxSzBg6k
         1uEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AIzoyOqsmvq2UL6ht5EBrZhZITvwdcSbBz+FO/uaKCQ=;
        b=lkyxfnNbtB68+pj262SjecDWaU0J4BnZKL4ID0++97OgoWeAqkft3f5vfXVYzk1Coz
         C5gxzx/NPB9cEE51M8aP0V7pkvvumEnxplTIIRbqEYWiXX2mNL+nNG9sWJAGFGbhkMuO
         Hwz5aBY0WG968/3cbBMEGZHzrBEh3BtsEnQvMzV28hPp5fw5pcP935FeUNvCMzEUzHR3
         y4gtJzLB/R8/oogDIfv1uwp34Qjz5kbYi2mtInPhJBc3jmi1gJzOYT1EhFV3BfvcVO5l
         HYUCrwjXDd/Dj+7Lfnmn2QlbA4xNbSXZndGOXl4KYdbrAdU0y/A/8Bkk2KJykcgHV4KD
         PHOA==
X-Gm-Message-State: AOAM530fhL2qgYy9qU1VpD6eIapop9MRguAxBxSNltFKX2FcliwlfIv7
        MNTtVCJ8ozSVG9kuGmFu99xo1X/CNgCUnA==
X-Google-Smtp-Source: ABdhPJwlFvwjxLUDV8XeezUFPyAzMz7NFUXWNsDc9b6F2mY+eT4xy28+Bn61wngvBNrtD8502sM11A==
X-Received: by 2002:a17:906:7104:: with SMTP id x4mr14336172ejj.417.1596888658132;
        Sat, 08 Aug 2020 05:10:58 -0700 (PDT)
Received: from localhost.localdomain (ptr-4xajgywt9p1tstfsdfc.18120a2.ip6.access.telenet.be. [2a02:1810:a421:dd00:b0e6:1cd9:30c1:35f8])
        by smtp.gmail.com with ESMTPSA id b2sm8130833ejg.70.2020.08.08.05.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 05:10:57 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v4 1/4] iio:temperature:mlx90632: Reduce number of equal calulcations
Date:   Sat,  8 Aug 2020 14:10:23 +0200
Message-Id: <20200808121026.1300375-2-cmo@melexis.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808121026.1300375-1-cmo@melexis.com>
References: <20200808121026.1300375-1-cmo@melexis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

TAdut4 was calculated each iteration although it did not change. In light
of near future additions of the Extended range DSP calculations, this
function refactoring will help reduce unrelated changes in that series as
well as reduce the number of new functions needed.

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 drivers/iio/temperature/mlx90632.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 51b812bcff2e..c3de10ba5b1e 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -374,11 +374,11 @@ static s32 mlx90632_calc_temp_ambient(s16 ambient_new_raw, s16 ambient_old_raw,
 }
 
 static s32 mlx90632_calc_temp_object_iteration(s32 prev_object_temp, s64 object,
-					       s64 TAdut, s32 Fa, s32 Fb,
+					       s64 TAdut, s64 TAdut4, s32 Fa, s32 Fb,
 					       s32 Ga, s16 Ha, s16 Hb,
 					       u16 emissivity)
 {
-	s64 calcedKsTO, calcedKsTA, ir_Alpha, TAdut4, Alpha_corr;
+	s64 calcedKsTO, calcedKsTA, ir_Alpha, Alpha_corr;
 	s64 Ha_customer, Hb_customer;
 
 	Ha_customer = ((s64)Ha * 1000000LL) >> 14ULL;
@@ -393,30 +393,35 @@ static s32 mlx90632_calc_temp_object_iteration(s32 prev_object_temp, s64 object,
 	Alpha_corr = emissivity * div64_s64(Alpha_corr, 100000LL);
 	Alpha_corr = div64_s64(Alpha_corr, 1000LL);
 	ir_Alpha = div64_s64((s64)object * 10000000LL, Alpha_corr);
-	TAdut4 = (div64_s64(TAdut, 10000LL) + 27315) *
-		(div64_s64(TAdut, 10000LL) + 27315) *
-		(div64_s64(TAdut, 10000LL)  + 27315) *
-		(div64_s64(TAdut, 10000LL) + 27315);
 
 	return (int_sqrt64(int_sqrt64(ir_Alpha * 1000000000000LL + TAdut4))
 		- 27315 - Hb_customer) * 10;
 }
 
+static s64 mlx90632_calc_ta4(s64 TAdut, s64 scale)
+{
+	return (div64_s64(TAdut, scale) + 27315) *
+		(div64_s64(TAdut, scale) + 27315) *
+		(div64_s64(TAdut, scale) + 27315) *
+		(div64_s64(TAdut, scale) + 27315);
+}
+
 static s32 mlx90632_calc_temp_object(s64 object, s64 ambient, s32 Ea, s32 Eb,
 				     s32 Fa, s32 Fb, s32 Ga, s16 Ha, s16 Hb,
 				     u16 tmp_emi)
 {
-	s64 kTA, kTA0, TAdut;
+	s64 kTA, kTA0, TAdut, TAdut4;
 	s64 temp = 25000;
 	s8 i;
 
 	kTA = (Ea * 1000LL) >> 16LL;
 	kTA0 = (Eb * 1000LL) >> 8LL;
 	TAdut = div64_s64(((ambient - kTA0) * 1000000LL), kTA) + 25 * 1000000LL;
+	TAdut4 = mlx90632_calc_ta4(TAdut, 10000LL);
 
 	/* Iterations of calculation as described in datasheet */
 	for (i = 0; i < 5; ++i) {
-		temp = mlx90632_calc_temp_object_iteration(temp, object, TAdut,
+		temp = mlx90632_calc_temp_object_iteration(temp, object, TAdut, TAdut4,
 							   Fa, Fb, Ga, Ha, Hb,
 							   tmp_emi);
 	}
-- 
2.25.1

