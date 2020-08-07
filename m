Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F1623EA0E
	for <lists+linux-iio@lfdr.de>; Fri,  7 Aug 2020 11:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgHGJUK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Aug 2020 05:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbgHGJT6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Aug 2020 05:19:58 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA72C061574
        for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2020 02:19:57 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id di22so758484edb.12
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2020 02:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WzDswwBfXvOnych9mKo86pvZBTTMjA75hoRZ23jMux8=;
        b=A5k3r0AZjXI5l/OpMsrMSGwe9CvLtM/wZ/FbzlOoj/yIPnGPa3NvehBqFR/CgV7NZK
         YM8H/1tiFk4Ww9C4I2UQ3UXgj4rGc923MDncpGYMDshEwZ0ijw2ymCvAk84Je9NfiMqJ
         olAUMocpdlhxEWxE7pjaD+lQjOUY9Go84g5DgyJeI2DW5lnoslfNLVI4w2lvSGrpWYKq
         84LatWrSrlV1Pw1SCFf8sgnmtP17oMazpHRbBG+oz5gu4mhT14qxxU7wVL3kr0L4SEBy
         nhe23+UbSefFhk39RVuS0HN2ywvbd3QD0ZwDwFJkr8NiwNVzsDKhXYj/+XdmOhnCT/1x
         /KGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WzDswwBfXvOnych9mKo86pvZBTTMjA75hoRZ23jMux8=;
        b=s+aLqlf+NxprGEpCeAPJERilUsjkAeiHDwNnznUFRJE5tXeU7hyMarJK2kgJxQXjk6
         ywu8mYsgzMfVins794GpWyNgk7ea/PXoqgkgaD+AT7eOyt7E6FELGhj/cmCRWzoib04p
         vTWM8llgnMrgMYU6zx+RJcTLt7IkQMrMtXDxgF/3iXBNLHfYzGpyi+EFC5dxIxojJ7CJ
         3ul7c08Z3wmuhqD/ARYs7jIftlc0ngbaWC2s5ZypAlSxTZrI6SQ5hsyPGYbX2lOoxlnT
         KIyxJ2HDcgpRp4QE4VauEJSlLzJNl9tjx9gEYGrV6Qn9TNzJvd9dyxGCJv5An0U3O/f0
         8hMw==
X-Gm-Message-State: AOAM530SvsYcuPeBF/hoUcY4W/TvPfPYLDLLP7GvK+Nwwd6zXEIgGooU
        VJ0DFFFeJFQleBUQgGTFGTGriA==
X-Google-Smtp-Source: ABdhPJwBwzstwHc2j3/qVJpQcsd5JT+qFwUCQW4s3ccC8jHxxizJZcA/mTCwuHFx7e872tBdBuKaWQ==
X-Received: by 2002:a05:6402:84e:: with SMTP id b14mr7715423edz.115.1596791996585;
        Fri, 07 Aug 2020 02:19:56 -0700 (PDT)
Received: from localhost.localdomain (ptr-4xajgyum9863qf6si3v.18120a2.ip6.access.telenet.be. [2a02:1810:a421:dd00:2092:7f6b:4676:cab])
        by smtp.gmail.com with ESMTPSA id c20sm5134005edy.40.2020.08.07.02.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 02:19:55 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH 1/2 v2 resend] iio:temperature:mlx90632: Reduce number of equal calulcations
Date:   Fri,  7 Aug 2020 11:19:48 +0200
Message-Id: <20200807091948.967161-1-cmo@melexis.com>
X-Mailer: git-send-email 2.25.1
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
 drivers/iio/temperature/mlx90632.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 51b812bcff2e..763a148a0095 100644
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
@@ -393,10 +393,6 @@ static s32 mlx90632_calc_temp_object_iteration(s32 prev_object_temp, s64 object,
 	Alpha_corr = emissivity * div64_s64(Alpha_corr, 100000LL);
 	Alpha_corr = div64_s64(Alpha_corr, 1000LL);
 	ir_Alpha = div64_s64((s64)object * 10000000LL, Alpha_corr);
-	TAdut4 = (div64_s64(TAdut, 10000LL) + 27315) *
-		(div64_s64(TAdut, 10000LL) + 27315) *
-		(div64_s64(TAdut, 10000LL)  + 27315) *
-		(div64_s64(TAdut, 10000LL) + 27315);
 
 	return (int_sqrt64(int_sqrt64(ir_Alpha * 1000000000000LL + TAdut4))
 		- 27315 - Hb_customer) * 10;
@@ -406,17 +402,21 @@ static s32 mlx90632_calc_temp_object(s64 object, s64 ambient, s32 Ea, s32 Eb,
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
+	TAdut4 = (div64_s64(TAdut, 10000LL) + 27315) *
+		(div64_s64(TAdut, 10000LL) + 27315) *
+		(div64_s64(TAdut, 10000LL)  + 27315) *
+		(div64_s64(TAdut, 10000LL) + 27315);
 
 	/* Iterations of calculation as described in datasheet */
 	for (i = 0; i < 5; ++i) {
-		temp = mlx90632_calc_temp_object_iteration(temp, object, TAdut,
+		temp = mlx90632_calc_temp_object_iteration(temp, object, TAdut, TAdut4,
 							   Fa, Fb, Ga, Ha, Hb,
 							   tmp_emi);
 	}
-- 
2.25.1

