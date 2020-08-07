Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CDD23F531
	for <lists+linux-iio@lfdr.de>; Sat,  8 Aug 2020 01:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgHGXV5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Aug 2020 19:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgHGXV5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Aug 2020 19:21:57 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF431C061756
        for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2020 16:21:56 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a14so2381243edx.7
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2020 16:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WzDswwBfXvOnych9mKo86pvZBTTMjA75hoRZ23jMux8=;
        b=ARlbCnCAReWvHkvrUcB0+effjhlObIgwsFI9tzxNGhL/ZSDNxYifZIq9H1kafIQph8
         B31tujSpH34tRhoYvtIvAsLjsiZ+Mc6Ac+2AqXJ3n6HCKwfatrShXqBcF2qBMofWaY8u
         Vr7I593mVLi0qTTY8eCP2ImTFOv3IfH35GcmvudurNQS1tNyTXJD+vhDPnpn8VWpLXbY
         huR5ATnV7q8mKwekkAs+RxUtFpyFVGdnYuzL4OXg358ceABnh7LGi2sgrlRsMoMaXfF9
         YWteGmr6lUozQl5ZTQ2omka04OY0K5NdaaP2gmiPO5obgnr+IWp+iNHDd4psHnTNbxeN
         7JCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WzDswwBfXvOnych9mKo86pvZBTTMjA75hoRZ23jMux8=;
        b=jRRfYlc4QjIOftgLof0e2rd0M3u31eayLfp/Q9gdOXdHPZ8yHBH1nVvFm46wnxQxyE
         UYfWYkrqbhIL/5CQ+uIyKOgpLXaVzT876LjPw2P2zHnDSYXR095UToN9VCA8jxU/+cp0
         P7NmJPl//87Kg33A/gW793x2rEI8T/o9JOW2o54CCs12ubbRYPyEWrCVvV3lXo3RJVpc
         D4SDOrUhmAOCDTU5AOQ4m5Sy3CW54EZeu36bjEPFR+aiGomb9s/a3K7X4bQveE89WYU8
         ept5CV478o/yOMd7OqS9gOExECrCILAIQ0j5PFtSZXOYns5WH/MLA7k1vN8iIyKI3sDB
         khcw==
X-Gm-Message-State: AOAM531e5Da/vPj+LKaLM8QosHPYX4sp1aHzvSScc1Gl+8E1nKeaISfM
        8lceGokkXqbwWn0K3/lGaFLbxA==
X-Google-Smtp-Source: ABdhPJxOzFPkzRbFazxGU9ryBNmQ8aLnpG80WbsKp2DM6lv+b9O7HITKlCWK7MJMBdsAqhaKQTeXSA==
X-Received: by 2002:a50:ee96:: with SMTP id f22mr10644132edr.243.1596842515514;
        Fri, 07 Aug 2020 16:21:55 -0700 (PDT)
Received: from localhost.localdomain (ptr-4xajgywt9p1tstfsdfc.18120a2.ip6.access.telenet.be. [2a02:1810:a421:dd00:b0e6:1cd9:30c1:35f8])
        by smtp.gmail.com with ESMTPSA id y9sm6305574edt.34.2020.08.07.16.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 16:21:54 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v3 1/2] iio:temperature:mlx90632: Reduce number of equal calulcations
Date:   Sat,  8 Aug 2020 01:21:03 +0200
Message-Id: <20200807232104.1256119-2-cmo@melexis.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200807232104.1256119-1-cmo@melexis.com>
References: <20200807232104.1256119-1-cmo@melexis.com>
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

