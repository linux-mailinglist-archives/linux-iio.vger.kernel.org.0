Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD12C24903B
	for <lists+linux-iio@lfdr.de>; Tue, 18 Aug 2020 23:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbgHRViO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Aug 2020 17:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbgHRViN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Aug 2020 17:38:13 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F2BC061389
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2020 14:38:12 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r2so19592822wrs.8
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2020 14:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/CQP6Mp+jMuAdeJV/E9lJgqu50DuZ6HxUkaNbDh+BH8=;
        b=WLwkvH0X34iEz89yjYbiz9Pnl2Xb2a4TL2wKrUbnaXz9CeFlqMZ82f2i/dUPQ8TZsm
         BA93t7gmcpGQT4hjzxtmTr4e50mTi5oxht7xTmCW/5o+NxvhCKd7C2Dx+anOgMN2KtOJ
         K5LAdJH0zgM0K36ZZHxTOtCqcXdTjsggQBtxcbJ23CjL8eT42LUz8kgDnQDjNaZhSFF2
         h7mNmKlwn8+WGcuqo14+Y8IJMjiV6WV9yUcOB2BdD10lUWCs6RvL66H5lmxb1N446VRE
         KNhxU19b4kG2Bq8iczJDmqWriLfhauF62eakCeGzbDwHJdvZz8mWlmT5HjU+QT/Xwrez
         1y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/CQP6Mp+jMuAdeJV/E9lJgqu50DuZ6HxUkaNbDh+BH8=;
        b=gDlES5x4kaS6HlLNLnMBedsjad4zpQpv2PxJBbVdbK+QY/aX7JjVt+JScgCYIqAjYO
         iNmWw7FkSyjeSDYIFFCNy1HMT0a3UbpP0WKc1PclBvWjkWkPDBlMm/5tj9PM3a5U6Wo6
         5Mz5b6A9plo7VBgLVShtS5onZa0avfCQ42jautvuxhS36oHdu65LAkstavnKiU/KRMSo
         vULr4Hrx5ee6QTsOJ1jm32IQ2gGciCmIMV2Zw9NQPnjj/JjxGRbRNjqIXRn5eodAoBQq
         sbVDQz4qw9KG5jiUUyLgcTZcqD7SvhUE7mxJMzbht43PfuIxMceIhwLNE9VW7XXjTU2g
         9QxQ==
X-Gm-Message-State: AOAM532ZZeBZ1zOwH9aVrdtXBH5c3pirFdJae0DcCCvj6Bj5J/dEPxbE
        q9yBLI8ryk/PZbguANCi2DpNdg==
X-Google-Smtp-Source: ABdhPJx9hnLhvEEH1s0BzrqxMiQii6rmDst21X83uvV5CPQZKW28aixXL62YUtPpWR5oV0/TuKGg3A==
X-Received: by 2002:adf:df08:: with SMTP id y8mr23448704wrl.152.1597786690523;
        Tue, 18 Aug 2020 14:38:10 -0700 (PDT)
Received: from localhost.localdomain ([88.116.83.106])
        by smtp.gmail.com with ESMTPSA id z207sm1797860wmc.2.2020.08.18.14.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 14:38:09 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Crt Mori <cmo@melexis.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v6 1/5] iio:temperature:mlx90632: Reduce number of equal calulcations
Date:   Tue, 18 Aug 2020 23:37:33 +0200
Message-Id: <20200818213737.140613-2-cmo@melexis.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200818213737.140613-1-cmo@melexis.com>
References: <20200818213737.140613-1-cmo@melexis.com>
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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

