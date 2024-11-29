Return-Path: <linux-iio+bounces-12834-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B6B9DECFA
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 22:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6E616120C
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 21:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE87D1A0724;
	Fri, 29 Nov 2024 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b="g0ASI+3A"
X-Original-To: linux-iio@vger.kernel.org
Received: from sonic305-21.consmr.mail.ir2.yahoo.com (sonic305-21.consmr.mail.ir2.yahoo.com [77.238.177.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E073224
	for <linux-iio@vger.kernel.org>; Fri, 29 Nov 2024 21:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.177.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732916138; cv=none; b=PVGPWqsb0zUyLrrIqukzxOZJMNxbxaRRrpH/8QnskP7OEFS+LUOwd4VTpot6a9B9KI5v90zF4LK3/P9hKWfdYdIDsxN9RgR9w1MiZweOoXHqi2lXeZQDJx6Niux/f1T9wJDGB5UIOFuGxrPa5agN5YEYJS2PzFNEz8poBHSF2LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732916138; c=relaxed/simple;
	bh=SxiSf8BuguILzkj9Rs29j4f5ZlVFhtCZpSfmR0MOXxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZlzhijtT6Mu5WgDhEd+u/gIcwkneAsR31RgTBeHA8G8nnALw99zzrQPWj1rEPDHjQQ8kshPxfpfAftI3x+ecifaemvZg6zVcQVDlUb5n7FARUZKnlkeCDIHOjzt306Lc8acvjBEqJ3GMl/t6qYLC1RQfqr9lTXBNayLDcSBXhCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com; spf=pass smtp.mailfrom=rocketmail.com; dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b=g0ASI+3A; arc=none smtp.client-ip=77.238.177.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rocketmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1732916135; bh=G0smavV7bDd9712eK/n12vhKXxEOPpjsobTA/EgGKuc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=g0ASI+3ApKYzVLRovITotvvPfYT2u1Vt8OeE8D73xRzZjo8fRlygOzqMnFcgbClyvcJYzHwpkqoJYx9z9ebwGQ5U9BdMesrZ7L5DP1RdL50Ex+ozBTfGzkMbYQRHUyL1hKS6SxQ4UDbNqpbj60YyMaEhv9M1VbKSJaF3P6IRQ3WfD3y0VQc+9F6JHErom0xln5QbGSY6yT93n7Kn1ArBESzU5j/Tg7TyS0Hu+fI5sWAFympUtC8ir5q5DT9gEX3lzGHgbgaRbXCt5RCubvkcZrYBrJ4sJ9EYNYMEjAgqWtz7CykEIcr/qWS9dDiOGh1SS+HSQ8VRWV3tuJOhLW8LNA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732916135; bh=sZaadzcqns39VcIObWnhZg5StWeh7smTT3jnGoiQeJ3=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=jSwbjj9kjldCx4P5Gk30NeBVkk9zJSWCeWspvUK0PEbwJKeGS6qquhLmKoJClR3u/8/OqnipiENvrYN5rMb9+6/ud9NRLLTam5U0xhWUyUQPteAvUmCPcagLihhrZ83IxLfVeJ43ixMOJDoF/4GX9WvSFbx/e4KxVVthfNGZrUlpE8ImqufWf1mai8Qjn0u5ZBZNYBVHVXenOsRWcOGahPxKqm2ZbRq+7JAcxF4hyxqiaS5QugHNRyKD/A7SuoZ391V9m+qZjM05tzzyLnoZNcLlkBlL0lyOey0SxYUc/r0jahHS/1KSxK1Q8ceaJpzTUumuHKqZIaISuL21/+S2ZA==
X-YMail-OSG: 7YOMjhYVM1mnJRAYdKokaDP6LlW9jCUdMwatuit8c31x6g0v.AKceUmgnRoHKu3
 L07jKZJEV1hOvBh7dTr1CY2JdLLjgVmSV4jHd5srdLNxyoiD8ML7iWOMYhA_Z_9d64Qgh1m3T_bo
 nIMNS9TqXfsbtYHK8SsuwGKSwZQH0TzwULc7UKiuRDi.7RAAARQTPK_9bZlVuq58TlAe83WrQwf3
 7AQaEHJOXRGvy6ie8ebcirvNLBIsfAL6VAgurQozzlpDdd6908XGLo58rBRQPNknOEvHdOml_kYt
 zdBwS9BAcmTYpxtk29SrtrKbasth1fbIKd.mPGXfOmlMrhthdAX1CHj9ZG9H_kfP7C.lxzk.dDNZ
 PTq3hK40OalXxXmd81W3RuT_oR2mVcfuupfEjXUG394Mo5h3uo9i4luM1w_hz6aCF02TuKkNk6We
 u19cIrcaIF716CWSgik8R3x4OjVIMiVUqFq.cMtKGKhHP8W261mdgOYDwNp8zxpmX8IMmf370Gj3
 iGd52C9h349oJTtMGnWI_XIvGmwDtU2iJckkBRuf_Hqe348rnf2g1t9asA6hqY5jTWD.qFy1_2b2
 k1dzueUlSrfyf2yk9_V9NUAB24pa5w44fMTIYa6WhEE8ho8KxrCu0CN1.oWgtr.GK70KwghJtZsx
 IvY99w_3mU.FR.V_VxzUSQscdCnj5QpNGMN24Mf_qU7flFfDuVM.C1D4rk5mkOXMgLl3Tsneljsq
 Aw.THHiqvYhoz3zZmvA4NcKRscBwkLBdibVvInXU.7mvy2x_tQNbhGzDw6dGJ192MVr.iTe5dBPd
 ozhaJHHqKZtHzRZcyY6WbhOjJpKv1_REJTtP0C.p6Bxt9Wy3HrMfBIZ7AQ.KDsYzoD3IBfgXBFTb
 l7nV.ogBcw5C5kmNhApzzqxV1hkJCRxqCqrON9GsRhgIPDffQ97TnKq6ZaF8x2ktWZ4P.5ty5SEG
 JeImKHucpsUGnczA8ZinffB5MPcEIcsoTuYI.O7jzB0vbZzDi9WK5HzQYteYCub3L8thkhXz7Etz
 vSFEzEHr53Sf0PmsVKo6QkIVFh_Uknq3EM262Ez4FbBzudhhiSmdK5U6LkGOolMxp19yXi_wWD3q
 kqPVM5YZTjiHAWoS5Hg6Gv3pjRh70mBoN2aVHIl1BEZZjkrj3vwKMK84A9F_kv30bXvPLaZJFcEt
 xVviVix2SqFSSQ9vXME996iDFqpTIWXVkja0rks4kUibn9U3jjaO54Wb_mu_urQrrvKzBN30nmcn
 5Z4hf8Bzsqpyn07jwrQRzOQ5LZiNG63Sj0ESISyG5JKoKfJ_B07GBe1PFDqq4Lnm3QT0pQMOmPdt
 lNnJBYv3J.Z1Vuw_guYBwKlW._7EMsEk63jXDBZm_jeMWgf3lZBhssHX11LeayA2B_LVLj8LR2vj
 2e4U5OHloGmneJG3FAwyiG3NOJHKqH9BFLfWKYdP_vOp.jHbABOiuqvrxzFubl4m5qMUeQwA5cXn
 M5UqjM3EqyV0H6DWXk.pqGDXKr04qbHc7reCDMpGrT4tDE7IdfFUW3Zp6ZBMQ79_Ghg2xWa_LcH.
 KlBQ_5DUuqLpJcVpp4HOoRDivLFiuKIDa9prS5MEpfcdFkbNwjY6Yi4tp0MLBMhpKAJvFwjjO3a.
 t3GAc2AnYe2_YvOLv52hsnOKmV32oLu3YohLFv45bQXCVqDvgKYi7kCzzKRBTiz22Mo_bD5evc3k
 htGQ_DNVB4ty9xe6ZhjoVx91rS_W_KVyU79gY7FNzbXPtjDKiBr4zAsm2Bn0eeBGLSFp6PnYf1Kd
 GBVJttyoxtGu3Q4f0tmA0e70KGDfoSAXWtmQt0iy3DSywedRMF8wZAJg_AKSmLAD_nxQqsZkH5QK
 b.vD4hKeaWipiU45tpej6zY5aNwroVVvO80hclzaOMqEPcvhKwc.Hlq9o0W8cPhENrXik2FDJ755
 jpy2aOoZPnrGG28fJEhjtvYa_Jj1tM98DxRUYkRWOMvehsxouqhwglntgznWLPqxBUMyA5eyczo4
 UgKP.azA21WjVEauJ9Wv6fE_auEAx9YSHgmXG.U2HQMuOpcQr4re7DKtDqwCITQOwPGVBURzF_vP
 dwAGIRwBD7_xrOkJ2yWihKubjABTXLsL3GI_Iq7icrPKfmZS4kq9nrkAnGI_8kay5JIlhUminsdp
 liyFJ2JshiLVmUnLTKx10rQmXM9z7qQKg8YlY2WcjLYATZAgKIJzQB5Nt8SiPWm6PzF8hVwrmuHe
 pyHW2STmhVnxCZsjioi3.OX26yLVRDk3npZElv_8xiw5r8vaa9ounRxqqvAf04QzchXYTmF7mEV9
 gj5ikfMqNd1vwD3dibKiTo81tU9xcQi1mIbDa9mW.Jg--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: d0072ecb-2302-422b-a388-5525090a8772
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ir2.yahoo.com with HTTP; Fri, 29 Nov 2024 21:35:35 +0000
Received: by hermes--production-ir2-c694d79d9-mr45v (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2edcbec70aefc2846e815ac55c2b6c1e;
          Fri, 29 Nov 2024 21:25:25 +0000 (UTC)
From: Jakob Hauser <jahau@rocketmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: David Laight <david.laight@aculab.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jakob Hauser <jahau@rocketmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] iio: magnetometer: yas530: Use signed integer type for clamp limits
Date: Fri, 29 Nov 2024 22:25:07 +0100
Message-Id: <11609b2243c295d65ab4d47e78c239d61ad6be75.1732914810.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <11609b2243c295d65ab4d47e78c239d61ad6be75.1732914810.git.jahau@rocketmail.com>
References: <11609b2243c295d65ab4d47e78c239d61ad6be75.1732914810.git.jahau@rocketmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the function yas537_measure() there is a clamp_val() with limits of
-BIT(13) and  BIT(13) - 1. The input clamp value h[] is of type s32. The BIT()
is of type unsigned long integer due to its define in include/vdso/bits.h.
The lower limit -BIT(13) is recognized as -8192 but expressed as an unsigned
long integer. The size of an unsigned long integer differs between 32-bit and
64-bit architectures. Converting this to type s32 may lead to undesired
behavior.

Additionally, in the calculation lines h[0], h[1] and h[2] the unsigned long
integer divisor BIT(13) causes an unsigned division, shifting the left-hand
side of the equation back and forth, possibly ending up in large positive
values instead of negative values on 32-bit architectures.

To solve those two issues, declare a signed integer with a value of BIT(13).

There is another omission in the clamp line: clamp_val() returns a value and
it's going nowhere here. Self-assign it to h[i] to make use of the clamp
macro.

Finally, replace clamp_val() macro by clamp() because after changing the limits
from type unsigned long integer to signed integer it's fine that way.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202411230458.dhZwh3TT-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202411282222.oF0B4110-lkp@intel.com/
Fixes: 65f79b501030 ("iio: magnetometer: yas530: Add YAS537 variant")
Cc: David Laight <david.laight@aculab.com>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
The patch is based on torvalds/linux v6.12.

The calculation lines h[0], h[1] and h[2] exceed the limit of 80 characters per
line. In terms of readability I would prefer to keep it that way.

Changes in v2:
 - Self-assigned the clamp macro to h[i].
 - Changed from clamp_val() macro to clamp().
 - In commit message added issues on divisor BIT(13) and missing clamp
   assignment.
 - In tags added another (duplicate) report by the kernel test robot.

Link to v1: https://lore.kernel.org/linux-iio/20241126234021.19749-1-jahau@rocketmail.com/T/#t
---
 drivers/iio/magnetometer/yamaha-yas530.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 65011a8598d3..c55a38650c0d 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -372,6 +372,7 @@ static int yas537_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y
 	u8 data[8];
 	u16 xy1y2[3];
 	s32 h[3], s[3];
+	int half_range = BIT(13);
 	int i, ret;
 
 	mutex_lock(&yas5xx->lock);
@@ -406,13 +407,13 @@ static int yas537_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y
 	/* The second version of YAS537 needs to include calibration coefficients */
 	if (yas5xx->version == YAS537_VERSION_1) {
 		for (i = 0; i < 3; i++)
-			s[i] = xy1y2[i] - BIT(13);
-		h[0] = (c->k *   (128 * s[0] + c->a2 * s[1] + c->a3 * s[2])) / BIT(13);
-		h[1] = (c->k * (c->a4 * s[0] + c->a5 * s[1] + c->a6 * s[2])) / BIT(13);
-		h[2] = (c->k * (c->a7 * s[0] + c->a8 * s[1] + c->a9 * s[2])) / BIT(13);
+			s[i] = xy1y2[i] - half_range;
+		h[0] = (c->k *   (128 * s[0] + c->a2 * s[1] + c->a3 * s[2])) / half_range;
+		h[1] = (c->k * (c->a4 * s[0] + c->a5 * s[1] + c->a6 * s[2])) / half_range;
+		h[2] = (c->k * (c->a7 * s[0] + c->a8 * s[1] + c->a9 * s[2])) / half_range;
 		for (i = 0; i < 3; i++) {
-			clamp_val(h[i], -BIT(13), BIT(13) - 1);
-			xy1y2[i] = h[i] + BIT(13);
+			h[i] = clamp(h[i], -half_range, half_range - 1);
+			xy1y2[i] = h[i] + half_range;
 		}
 	}
 
-- 
2.43.0


