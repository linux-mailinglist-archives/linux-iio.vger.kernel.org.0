Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576E723BB84
	for <lists+linux-iio@lfdr.de>; Tue,  4 Aug 2020 15:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgHDN4V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Aug 2020 09:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgHDN4S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Aug 2020 09:56:18 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41E1C06174A
        for <linux-iio@vger.kernel.org>; Tue,  4 Aug 2020 06:56:17 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a21so42512338ejj.10
        for <linux-iio@vger.kernel.org>; Tue, 04 Aug 2020 06:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WzDswwBfXvOnych9mKo86pvZBTTMjA75hoRZ23jMux8=;
        b=pmGgt5uNMDYr7vjNTIYqQDZw2nFS3qKA/7RvWdEmlg6MUlWxX/ooGUDm1hoPzxBMul
         NpjY26NP+K3PAFwDJq8Rz5EtNCLnohoUm0vT3gqcoGUwkcjhephDD6Nk1hzDDrsenADy
         R61GKcqfYiB2j73tkADN1vWO2kLoN63PzUq7q+t+kJ5NtMDucH9wn0TJZkzftcWY2mDH
         N1udxl/7iHsNvdmfRzBTZ+DTSRCbw/GCKVPlkjDRH4Laki1LCf6W2CNrLo9UkUC7v9fy
         72qnF8TXmn6l9zclNVoVmqh5PArB4RevO9Iqc9l6Soszra8nGAyWuEkC1VApdcHkdTI7
         2CIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WzDswwBfXvOnych9mKo86pvZBTTMjA75hoRZ23jMux8=;
        b=f5dQJU2GZYDiyXABtN8qUeBbVGCT6VQngUmvxZacsPNp6xbKDBhJ1U0LadL7Xox5WK
         Ym0bmy+I1pbmH4lVYL3imcwijgzqn378/RqsQMHbJrP+rxRdRqNX6bLjfDdu/qdd/gFB
         a8Dzv2s305staeRWhmYdoORpEHg9Ro4eLrwId7b7CjaC8RkWCfjtmjqv0CyEoVvDtcu9
         mXTkAZdIblbFyY9/ahavGcB1nrwSJsJusa88cKY2QVff6TLIBsira5jm2rl/um4p7NUL
         ALgHf0NeulfS0PQHZ5aobcyBUCk40xlq3sRwzze7B9fUv8yM+2C/mqXcb658YNYWYdpS
         LcIQ==
X-Gm-Message-State: AOAM532SDKjicM3dvQ0P2tDvREErcpb6XJ3cRNWcC4tKtGRTLjEsDD0V
        VbgquA6WgXtrhGcL1FNVnX/xRg==
X-Google-Smtp-Source: ABdhPJw91afCFXRk5zcL8K32et29oN+/1gU363aw7cgOdED79D7kHcsR2pgFw0GTKeXlVN6Viw6jcw==
X-Received: by 2002:a17:906:74d0:: with SMTP id z16mr21232387ejl.51.1596549376286;
        Tue, 04 Aug 2020 06:56:16 -0700 (PDT)
Received: from localhost.localdomain (ptr-4xajgyum9863qf6si3v.18120a2.ip6.access.telenet.be. [2a02:1810:a421:dd00:2092:7f6b:4676:cab])
        by smtp.gmail.com with ESMTPSA id r25sm18361473edy.93.2020.08.04.06.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 06:56:15 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v2] iio:temperature:mlx90632: Reduce number of equal calculations
Date:   Tue,  4 Aug 2020 15:55:55 +0200
Message-Id: <20200804135555.95186-1-cmo@melexis.com>
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

