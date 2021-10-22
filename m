Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A5E4370A6
	for <lists+linux-iio@lfdr.de>; Fri, 22 Oct 2021 06:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbhJVEMa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Oct 2021 00:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhJVEM3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Oct 2021 00:12:29 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3CBC061764
        for <linux-iio@vger.kernel.org>; Thu, 21 Oct 2021 21:10:12 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id o4so3482257oia.10
        for <linux-iio@vger.kernel.org>; Thu, 21 Oct 2021 21:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DdgjWsmZv/kZGNUbeAgYT36Gdfi8zvgJLOlEmSHZjKc=;
        b=jby2Xvld2B5M5QYJGCBHmsCDVmCh8ZeHMHyfeDpRPxGmA+m2hCF4FqA3D3s3uLyi6R
         q+d0swAY/6G4AHdUD4EwRJnNjC+bSXDRYUSJSClajLdYXf7YrvkcnDJ1/UnVsuUM3eXu
         ftcBxsqidvZxUE2RpAkR+jMMxuUtRm/kNNpWR1DJQhSNX8p0ql1VPODvyId9gnLXb4Vs
         ikXM3Kc/fyplrafm+Iz1EO7uj+Nj58ZvWelDej2GTjHpEYFlHpp1ZREjRpBEVYsiFOaI
         tZWtHEZvGaGJzO729Mu2givmpJwNuZlfOoNS2fs2WbL6BYP5JZyoHJCf7VFzyY1fnvO0
         c0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DdgjWsmZv/kZGNUbeAgYT36Gdfi8zvgJLOlEmSHZjKc=;
        b=SAVuk+Ekq4FSx80SkdqABXTfexoc8KKKqh0ZoSBQFVLcSHCazkBgzXFdaGVjdgYRra
         9YrK34b4XACO1LUFGvvUARXmwnVEa9xgFMivd5FmRsd8G9/t6sOn868KW6YFwEfVgrEY
         RZUTL4F94wb7KXQteuDoSSnM0a+yyeEUGrT8x0WD6a2NxHJQ4AWRoFEFQeavU/75UPGc
         7oZC1Ib8XOTFHbLK3B9w6i9xa2fh3d3eagrAwgSJZn3YRomnus3s0uA0yBE9LzN9e/kP
         WT26TEWlNa7c+QMJernjSdfjEXuSYO8hSq8/AblJTlfH7OOj6Og7g0IYkrkEAMuYytbu
         7D9A==
X-Gm-Message-State: AOAM533gSLsiXAwe9BzQrvuucR1pwp3KB/oyPNEpsghjkyA1aT0un4SP
        c5a2Q15lS+W3oakn9LQGIEc=
X-Google-Smtp-Source: ABdhPJwChRnzov13qCvUoSMCMZD0dQpL7tHKul9REE4c+PMuihOLRDyt7vSTxGdWPy7JD1RTyvACZw==
X-Received: by 2002:a05:6808:90e:: with SMTP id w14mr7566311oih.131.1634875811466;
        Thu, 21 Oct 2021 21:10:11 -0700 (PDT)
Received: from localhost.localdomain ([8.47.15.131])
        by smtp.gmail.com with ESMTPSA id j12sm1456744ota.47.2021.10.21.21.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 21:10:11 -0700 (PDT)
From:   Yanteng Si <siyanteng01@gmail.com>
X-Google-Original-From: Yanteng Si <siyanteng@loongson.cn>
To:     jic23@kernel.org, cmo@melexis.com, lars@metafoo.de
Cc:     Yanteng Si <siyanteng@loongson.cn>, linux-iio@vger.kernel.org,
        sterlingteng@gmail.com, chenhuacai@kernel.org
Subject: [PATCH v2] iio/mlx90632: restyle mlx90632
Date:   Fri, 22 Oct 2021 12:09:49 +0800
Message-Id: <20211022040949.4037879-1-siyanteng@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

ref: Documentation/process/coding-style.rst:
C programmers do not use cute names like ThisVariableIsATemporaryCounter

so,restyle mlx90632 driver.

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
v1:

Restyle the whole driver under Crt's advice.

 drivers/iio/temperature/mlx90632.c | 80 +++++++++++++++---------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 608ccb1d8bc8..17b47f5d1742 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -480,11 +480,11 @@ static int mlx90632_read_ee_register(struct regmap *regmap, u16 reg_lsb,
 static s64 mlx90632_preprocess_temp_amb(s16 ambient_new_raw,
 					s16 ambient_old_raw, s16 Gb)
 {
-	s64 VR_Ta, kGb, tmp;
+	s64 VR_Ta, k_Gb, tmp;
 
-	kGb = ((s64)Gb * 1000LL) >> 10ULL;
+	k_Gb = ((s64)Gb * 1000LL) >> 10ULL;
 	VR_Ta = (s64)ambient_old_raw * 1000000LL +
-		kGb * div64_s64(((s64)ambient_new_raw * 1000LL),
+		k_Gb * div64_s64(((s64)ambient_new_raw * 1000LL),
 			(MLX90632_REF_3));
 	tmp = div64_s64(
 			 div64_s64(((s64)ambient_new_raw * 1000000000000LL),
@@ -496,11 +496,11 @@ static s64 mlx90632_preprocess_temp_obj(s16 object_new_raw, s16 object_old_raw,
 					s16 ambient_new_raw,
 					s16 ambient_old_raw, s16 Ka)
 {
-	s64 VR_IR, kKa, tmp;
+	s64 VR_IR, k_Ka, tmp;
 
-	kKa = ((s64)Ka * 1000LL) >> 10ULL;
+	k_Ka = ((s64)Ka * 1000LL) >> 10ULL;
 	VR_IR = (s64)ambient_old_raw * 1000000LL +
-		kKa * div64_s64(((s64)ambient_new_raw * 1000LL),
+		k_Ka * div64_s64(((s64)ambient_new_raw * 1000LL),
 			(MLX90632_REF_3));
 	tmp = div64_s64(
 			div64_s64(((s64)((object_new_raw + object_old_raw) / 2)
@@ -512,11 +512,11 @@ static s64 mlx90632_preprocess_temp_obj(s16 object_new_raw, s16 object_old_raw,
 static s64 mlx90632_preprocess_temp_obj_extended(s16 object_new_raw, s16 ambient_new_raw,
 						 s16 ambient_old_raw, s16 Ka)
 {
-	s64 VR_IR, kKa, tmp;
+	s64 VR_IR, k_Ka, tmp;
 
-	kKa = ((s64)Ka * 1000LL) >> 10ULL;
+	k_Ka = ((s64)Ka * 1000LL) >> 10ULL;
 	VR_IR = (s64)ambient_old_raw * 1000000LL +
-		kKa * div64_s64((s64)ambient_new_raw * 1000LL,
+		k_Ka * div64_s64((s64)ambient_new_raw * 1000LL,
 				MLX90632_REF_3);
 	tmp = div64_s64(
 			div64_s64((s64) object_new_raw * 1000000000000LL, MLX90632_REF_12),
@@ -527,70 +527,70 @@ static s64 mlx90632_preprocess_temp_obj_extended(s16 object_new_raw, s16 ambient
 static s32 mlx90632_calc_temp_ambient(s16 ambient_new_raw, s16 ambient_old_raw,
 				      s32 P_T, s32 P_R, s32 P_G, s32 P_O, s16 Gb)
 {
-	s64 Asub, Bsub, Ablock, Bblock, Cblock, AMB, sum;
+	s64 A_sub, B_sub, A_block, B_block, C_block, AMB, sum;
 
 	AMB = mlx90632_preprocess_temp_amb(ambient_new_raw, ambient_old_raw,
 					   Gb);
-	Asub = ((s64)P_T * 10000000000LL) >> 44ULL;
-	Bsub = AMB - (((s64)P_R * 1000LL) >> 8ULL);
-	Ablock = Asub * (Bsub * Bsub);
-	Bblock = (div64_s64(Bsub * 10000000LL, P_G)) << 20ULL;
-	Cblock = ((s64)P_O * 10000000000LL) >> 8ULL;
+	A_sub = ((s64)P_T * 10000000000LL) >> 44ULL;
+	B_sub = AMB - (((s64)P_R * 1000LL) >> 8ULL);
+	A_block = A_sub * (B_sub * B_sub);
+	B_block = (div64_s64(B_sub * 10000000LL, P_G)) << 20ULL;
+	C_block = ((s64)P_O * 10000000000LL) >> 8ULL;
 
-	sum = div64_s64(Ablock, 1000000LL) + Bblock + Cblock;
+	sum = div64_s64(A_block, 1000000LL) + B_block + C_block;
 
 	return div64_s64(sum, 10000000LL);
 }
 
 static s32 mlx90632_calc_temp_object_iteration(s32 prev_object_temp, s64 object,
-					       s64 TAdut, s64 TAdut4, s32 Fa, s32 Fb,
+					       s64 TA_dut, s64 TA_dut4, s32 Fa, s32 Fb,
 					       s32 Ga, s16 Ha, s16 Hb,
 					       u16 emissivity)
 {
-	s64 calcedKsTO, calcedKsTA, ir_Alpha, Alpha_corr;
+	s64 calced_Ks_TO, calced_Ks_TA, ir_Alpha, Alpha_corr;
 	s64 Ha_customer, Hb_customer;
 
 	Ha_customer = ((s64)Ha * 1000000LL) >> 14ULL;
 	Hb_customer = ((s64)Hb * 100) >> 10ULL;
 
-	calcedKsTO = ((s64)((s64)Ga * (prev_object_temp - 25 * 1000LL)
+	calced_Ks_TO = ((s64)((s64)Ga * (prev_object_temp - 25 * 1000LL)
 			     * 1000LL)) >> 36LL;
-	calcedKsTA = ((s64)(Fb * (TAdut - 25 * 1000000LL))) >> 36LL;
+	calced_Ks_TA = ((s64)(Fb * (TA_dut - 25 * 1000000LL))) >> 36LL;
 	Alpha_corr = div64_s64((((s64)(Fa * 10000000000LL) >> 46LL)
 				* Ha_customer), 1000LL);
-	Alpha_corr *= ((s64)(1 * 1000000LL + calcedKsTO + calcedKsTA));
+	Alpha_corr *= ((s64)(1 * 1000000LL + calced_Ks_TO + calced_Ks_TA));
 	Alpha_corr = emissivity * div64_s64(Alpha_corr, 100000LL);
 	Alpha_corr = div64_s64(Alpha_corr, 1000LL);
 	ir_Alpha = div64_s64((s64)object * 10000000LL, Alpha_corr);
 
-	return (int_sqrt64(int_sqrt64(ir_Alpha * 1000000000000LL + TAdut4))
+	return (int_sqrt64(int_sqrt64(ir_Alpha * 1000000000000LL + TA_dut4))
 		- 27315 - Hb_customer) * 10;
 }
 
-static s64 mlx90632_calc_ta4(s64 TAdut, s64 scale)
+static s64 mlx90632_calc_ta4(s64 TA_dut, s64 scale)
 {
-	return (div64_s64(TAdut, scale) + 27315) *
-		(div64_s64(TAdut, scale) + 27315) *
-		(div64_s64(TAdut, scale) + 27315) *
-		(div64_s64(TAdut, scale) + 27315);
+	return (div64_s64(TA_dut, scale) + 27315) *
+		(div64_s64(TA_dut, scale) + 27315) *
+		(div64_s64(TA_dut, scale) + 27315) *
+		(div64_s64(TA_dut, scale) + 27315);
 }
 
 static s32 mlx90632_calc_temp_object(s64 object, s64 ambient, s32 Ea, s32 Eb,
 				     s32 Fa, s32 Fb, s32 Ga, s16 Ha, s16 Hb,
 				     u16 tmp_emi)
 {
-	s64 kTA, kTA0, TAdut, TAdut4;
+	s64 k_TA, k_TA0, TA_dut, TA_dut4;
 	s64 temp = 25000;
 	s8 i;
 
-	kTA = (Ea * 1000LL) >> 16LL;
-	kTA0 = (Eb * 1000LL) >> 8LL;
-	TAdut = div64_s64(((ambient - kTA0) * 1000000LL), kTA) + 25 * 1000000LL;
-	TAdut4 = mlx90632_calc_ta4(TAdut, 10000LL);
+	k_TA = (Ea * 1000LL) >> 16LL;
+	k_TA0 = (Eb * 1000LL) >> 8LL;
+	TA_dut = div64_s64(((ambient - k_TA0) * 1000000LL), k_TA) + 25 * 1000000LL;
+	TA_dut4 = mlx90632_calc_ta4(TA_dut, 10000LL);
 
 	/* Iterations of calculation as described in datasheet */
 	for (i = 0; i < 5; ++i) {
-		temp = mlx90632_calc_temp_object_iteration(temp, object, TAdut, TAdut4,
+		temp = mlx90632_calc_temp_object_iteration(temp, object, TA_dut, TA_dut4,
 							   Fa, Fb, Ga, Ha, Hb,
 							   tmp_emi);
 	}
@@ -601,20 +601,20 @@ static s32 mlx90632_calc_temp_object_extended(s64 object, s64 ambient, s64 refle
 					      s32 Ea, s32 Eb, s32 Fa, s32 Fb, s32 Ga,
 					      s16 Ha, s16 Hb, u16 tmp_emi)
 {
-	s64 kTA, kTA0, TAdut, TAdut4, Tr4, TaTr4;
+	s64 k_TA, k_TA0, TA_dut, TA_dut4, Tr4, Ta_Tr4;
 	s64 temp = 25000;
 	s8 i;
 
-	kTA = (Ea * 1000LL) >> 16LL;
-	kTA0 = (Eb * 1000LL) >> 8LL;
-	TAdut = div64_s64((ambient - kTA0) * 1000000LL, kTA) + 25 * 1000000LL;
+	k_TA = (Ea * 1000LL) >> 16LL;
+	k_TA0 = (Eb * 1000LL) >> 8LL;
+	TA_dut = div64_s64((ambient - k_TA0) * 1000000LL, k_TA) + 25 * 1000000LL;
 	Tr4 = mlx90632_calc_ta4(reflected, 10);
-	TAdut4 = mlx90632_calc_ta4(TAdut, 10000LL);
-	TaTr4 = Tr4 - div64_s64(Tr4 - TAdut4, tmp_emi) * 1000;
+	TA_dut4 = mlx90632_calc_ta4(TA_dut, 10000LL);
+	Ta_Tr4 = Tr4 - div64_s64(Tr4 - TA_dut4, tmp_emi) * 1000;
 
 	/* Iterations of calculation as described in datasheet */
 	for (i = 0; i < 5; ++i) {
-		temp = mlx90632_calc_temp_object_iteration(temp, object, TAdut, TaTr4,
+		temp = mlx90632_calc_temp_object_iteration(temp, object, TA_dut, Ta_Tr4,
 							   Fa / 2, Fb, Ga, Ha, Hb,
 							   tmp_emi);
 	}
-- 
2.27.0

