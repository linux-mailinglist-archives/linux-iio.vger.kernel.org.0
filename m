Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1CB23A93F
	for <lists+linux-iio@lfdr.de>; Mon,  3 Aug 2020 17:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgHCPRK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Aug 2020 11:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgHCPRK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2020 11:17:10 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D34C06174A
        for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2020 08:17:09 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o18so39002829eje.7
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2020 08:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dLm6RINMH46rAju8aGEaViT9JcB4pyQ99/jBApaK+S0=;
        b=oPm1We6Bc+I97BVWffAWoHsPhvAUGjT7Kj6DIAlP5zhnNcHgLNQ9sxn8gzCh/NC3aq
         1kDGUNHhk/91pb3z6jaJjkHHZoTTptPRf2eJQx9tSxLt8boDj/KofgbX2SJNSlUF2WGh
         rJLpbzfqvDxgXGzDMGfLCjPAAbPqrG15gGoT39G3jgriOgUPTFA4y3NSnCmBa1MpsGhW
         XIeDJjsDaKiJEJ2coa/hZztY8T0I1CNhKzc7biDvXguoiXVLdX0UFhlCKypx0Qp5Fa8h
         pxUG/joDrIUxF41qCXrnLBKSlr2shQ8KTSbmybBp4LvAa/BiNaTQaIXxpS0pfWFrsOt6
         NUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dLm6RINMH46rAju8aGEaViT9JcB4pyQ99/jBApaK+S0=;
        b=JNw+phpL4QajYzDQjGikjzTOzPM0HMbRoM1AL/FJbhxit9hkJuXG67JjSWHRwNecW1
         DPSGuHCPOykEd5AjF4sfA82scTFjr264vA6+V6/ShGkvZkTlvkQredRxyicRIwPdYmAU
         NW05g2SdaUf3u8OKpDnifhQx7lC4uNzlnHds+uYlMBw7ojub+vj7M6p/R1gL6zFX7GB0
         SNbHGUjTQpxqAcJfT5r7zhjX9VZ0VjVW5c6EOGQ5G2nUTvF2RH0DWtCQk4CUJXGgNGgA
         PBZ69D0E1rsSM5CHLRFxYfPmwmVWp23h2GJizG8IfueMrBcqDCLm8pdcZRzAxI+7RPED
         jJsw==
X-Gm-Message-State: AOAM530XlLAOEiIpz9wIxVUkm4NHWq3bEPDzTxgv/yyOE74NZA2jD899
        ldzGpUfbEi/AULL1x2KuqhYRwjdboow7OA==
X-Google-Smtp-Source: ABdhPJwIi1gfqG6PphSUak94KTiMuClqh8Huyz45Vf4y7H6tlUuZmK22I+1+y+D6T6cW9892Oisfqg==
X-Received: by 2002:a17:906:7c86:: with SMTP id w6mr16632690ejo.178.1596467828400;
        Mon, 03 Aug 2020 08:17:08 -0700 (PDT)
Received: from cmo-t495.tess.elex.be ([194.150.35.21])
        by smtp.gmail.com with ESMTPSA id g25sm16027481ejh.110.2020.08.03.08.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 08:17:05 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH] iio:temperature:mlx90632: Reduce number of equal calulcations
Date:   Mon,  3 Aug 2020 17:16:56 +0200
Message-Id: <20200803151656.332559-1-cmo@melexis.com>
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

Also converted shifts in this function of signed integers to divisions as
that is less implementation-defined behavior.

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 drivers/iio/temperature/mlx90632.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index eaca6ba06864..d7ba0b2fe3c0 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -374,29 +374,25 @@ static s32 mlx90632_calc_temp_ambient(s16 ambient_new_raw, s16 ambient_old_raw,
 }
 
 static s32 mlx90632_calc_temp_object_iteration(s32 prev_object_temp, s64 object,
-					       s64 TAdut, s32 Fa, s32 Fb,
+					       s64 TAdut, s64 TAdut4, s32 Fa, s32 Fb,
 					       s32 Ga, s16 Ha, s16 Hb,
 					       u16 emissivity)
 {
 	s64 calcedKsTO, calcedKsTA, ir_Alpha, TAdut4, Alpha_corr;
 	s64 Ha_customer, Hb_customer;
 
-	Ha_customer = ((s64)Ha * 1000000LL) >> 14ULL;
-	Hb_customer = ((s64)Hb * 100) >> 10ULL;
+	Ha_customer = div64_s64((s64)Ha * 1000000LL, 16384);
+	Hb_customer = div64_s64((s64)Hb * 100, 1024);
 
-	calcedKsTO = ((s64)((s64)Ga * (prev_object_temp - 25 * 1000LL)
-			     * 1000LL)) >> 36LL;
-	calcedKsTA = ((s64)(Fb * (TAdut - 25 * 1000000LL))) >> 36LL;
-	Alpha_corr = div64_s64((((s64)(Fa * 10000000000LL) >> 46LL)
-				* Ha_customer), 1000LL);
+	calcedKsTO = div64_s64((s64)((s64)Ga * (prev_object_temp - 25 * 1000LL)
+				     * 1000LL), 68719476736);
+	calcedKsTA = div64_s64((s64)(Fb * (TAdut - 25 * 1000000LL)), 68719476736);
+	Alpha_corr = div64_s64(div64_s64((s64)(Fa * 10000000000LL), 70368744177664)
+			       * Ha_customer, 1000LL);
 	Alpha_corr *= ((s64)(1 * 1000000LL + calcedKsTO + calcedKsTA));
 	Alpha_corr = emissivity * div64_s64(Alpha_corr, 100000LL);
 	Alpha_corr = div64_s64(Alpha_corr, 1000LL);
 	ir_Alpha = div64_s64((s64)object * 10000000LL, Alpha_corr);
-	TAdut4 = (div64_s64(TAdut, 10000LL) + 27315) *
-		(div64_s64(TAdut, 10000LL) + 27315) *
-		(div64_s64(TAdut, 10000LL)  + 27315) *
-		(div64_s64(TAdut, 10000LL) + 27315);
 
 	return (int_sqrt64(int_sqrt64(ir_Alpha * 1000000000000LL + TAdut4))
 		- 27315 - Hb_customer) * 10;
@@ -413,10 +409,14 @@ static s32 mlx90632_calc_temp_object(s64 object, s64 ambient, s32 Ea, s32 Eb,
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

