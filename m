Return-Path: <linux-iio+bounces-12720-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4799D9FDF
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 01:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD58165A89
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 00:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC52A23;
	Wed, 27 Nov 2024 00:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b="ETUKRSIe"
X-Original-To: linux-iio@vger.kernel.org
Received: from sonic306-21.consmr.mail.ir2.yahoo.com (sonic306-21.consmr.mail.ir2.yahoo.com [77.238.176.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DBB322A
	for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2024 00:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.176.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732665662; cv=none; b=it3NVUm51zGSbFcWNVoUIQiWt5OhJypjD207md9QRrUhPXKUoCStTygcGJFDeVNEDw/0uqft7fzjQ7HSNGyFNWqWP/f/6Xq0kHHY+FJvsJMXI2YZZgHit6mfbzsdR6awlCcG/J5k/r09V/7dykhBDcJAkUShEQeSXMv/g75wFkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732665662; c=relaxed/simple;
	bh=wSnTftQjXX6IVevyMrORMn78ByIlh5J0F8vJt1MQnXk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:References; b=UroVwahQBygWeiQOfLkO56TzZwI0cimb4xyU/jkh6b21dcOCaZH/cBnNQmtYpkKsAsml5FkOVmicDad6i1ymhRGcipR7GYsasOdcTSB0OAEVSTb9LmgwmaWVGJT2elbbggrJbXfbl7i6on7HSbwXMrG7dd5eHm4/RGIeFm3fNOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com; spf=pass smtp.mailfrom=rocketmail.com; dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b=ETUKRSIe; arc=none smtp.client-ip=77.238.176.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rocketmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1732665658; bh=MgL+Y0R2nrnBm7+Isag/O8JP2FWkBIMIsTL0WZZiGH0=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=ETUKRSIeupNEVKjktPxYwY9EaMcEDSMNGMXKydJzTDQOQMbtRH68J2raVMjpSh99LBz8IPwqYczXMGNIF4jCU8wpeRuCO1IwaxaMnqVV8KDLRvcr+95v9RqYteg6s3CLqlybKC/90miL60cGlz7oS/5eYADtDBHjTxW8HwcEBMuz+WcMBnnM+BuQIICBxqECLHccEhbhoySiFsXe3dUpS3mUtwhJMTLImhg3SvFUry/k5oMBKEMGDHN4VTGOvYQLtzyTlXDnxzA0KiUpc0eaFxwzJlFRxHoqK72kGezvoM4VVfvJRt1bN2/qQcXuLE+Er0chyuGKmM7FSonzgC8qdg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732665658; bh=P8frwMjJHijWeYSd8SvffR9oIrKOskb5WgXm/+dJ3s/=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=EKUg7TWguw3SKOvpcrxbW3ds0uanPDf7N9V/yvY4BRdwciO1MEJ18q9oBuLAsXBgZtMwUKsT6FRlupm9DhDTWUio+CHOSLBTOU1ndX7fSGGzyrbu/xpmhn1AQlRX//k1GNjAXVl5xoyvUhZanjUWuC6VxkeOk4yNrGYwX1b8AYRa+snymoyhYGMOtdIzNSnakMoWjRQUIgUhIL5Gx7eOGqHekzWt777XPasrQcIl30Y10xV4tvCsremA9tITB7eNNfiuvhHlriZDmyogIv9oe8NR+TMWV5fRj+HMG5EINgZGQUYVd5HlyGdHAnYiqm4uOQHxiTwdPUbavxEQ8r3t2g==
X-YMail-OSG: 9rcZ73MVM1m1cw2dukGKTtFNYFlxJ03MMqfvacqEXKJIetLz2Dn4pzvbsaIJjr8
 diA1MEl3.gXJWdaFVtH.Nhi591wJG.Q8zZbMA2McImuPvQp0ChT78flK3tQf44d.lsm4i3ZIDwMr
 IBSzgEhFSZECZz7ainjEONQJX2Nlft6WPCAmnPMn5aHyULmtbNlskmxfRtuYqHK_p9VEwU_3Rti0
 F8wx5.bvWPgCS0q1HEJQoVi0X024gtkFRmL.Ts5g4Btg8k_sBoVsCXHU.n7gb4LRddd0kIZ6Z2b0
 WlpADe81f78d3huAkQw4e7vHhZHTbGIGHqwPZO9kPLEPtKx28gVggV6oawdPghvRd4aA9maZy19o
 q5LLN4IIbp9v4mVa96jPQ2uwAMZLi8r5VKQQv8e3ewckF_3JRbcyPMnDr4cHmSyMxbv97qqXtQXn
 P3gAts_jGn.SavlNgGN_9eh2U04.KUk9VgC1ooVywb1KZ4t7bBLa6d7G7Tf4zbD7e9u8c1RMN_H1
 Ma7FYhUCAQmMVpnhpAuCY45DTXGO7_40qO_iQxLeXvRJ_EJ2LQchMSP_orfse1OOtCNGtKxyw8As
 EiGN2EA2xSJY6FXHe10NLs_NWVXnexnrORdnVqpfkuLu_SLkZQBzRgZKGsmTZtoGQCvvyHcObKAB
 Cf6QTOzGIEDiRCfAbKxkgAPGuf0IXn5ooLsJetAs2oCN..5VfJJuwCMUHSBcEfxmoOk9jyU_cZQR
 gdDsjjU66EUny5HN9t3cxGOzYxKPrqFJ5Ash8ZU8B1ghS.e3i1._WO3.F.Fv.E1PmbGR9ECRSEId
 fNww4KyXYxf.iLUDkaR4CrVpnqJX.iSoeH6_U.V89vtUbE1akxFV92QZeAZXQibfMhHFkxCgbroo
 M0GTnvuXM6vqKXHbpkRwonHRDz7bdRPYZq0UWS5CK5fH4vj.ok7qq1wF.0hgSlSlFe402pnazfKu
 PWu6tOwMsP47JG1jkFyu4YdWQ6Tdg.97mKbDrWGvUeSF_qSLe6XkZoljkkFGHqtpugnRDbpoRuh7
 eW5U2M5BgRT65nyyAqSTxGjFmcUKoOExNYKkUUKZRP4IHN1wyCDemimcIGJXTzLOeyaSgx7VDUBU
 vvLgrS9a64dzx7.0JH6kNtHu6sszxGfFuKjW_L4fhVxKUSb6b053NK9ysKThp2OGnlNo0Z1aVJaH
 19S5aOSHYHU7LOeZvws35G_Ek3_YBj6wCmrYST2NB.XtSkFchSOaizece1cKlmMri7nl_5jq2wS1
 08EtjbZc7VczTyKkSRGXasBobNBaScwxJGuo7AdxTvuWB4fcgcE0uVfeWaodf7MY2DoVRBPzFmEF
 72q9gYhiTS_x_HaKEsEHWTVGJVH2MEnE.vecZ_p0YMYX5Y2nphpVpv4sQbcQVyr6xwI0NEw6ZknF
 p.lvM3SPiUOv57UadyAZ_LM.G8qyfFHDj9Tl5yFskbhElgJikBWn2kNYCHNnSS3cvSXfWM5SuG67
 EZxxYbYuBT7Oosz3JoHqIFw4iSEAiIJCoz2baEu8GttIUg1nCrrWDJ36BK.rgQByTy7MRGve5YKD
 bktKfaGNiwXCa2Bu8KVW8D9bIpGgWK2KCUR8evrhmNbtKgUCs64GL48DrOWn5858ecPMP4gH08yY
 .qI3JlvuGNDWzpVQDo8rpSkMhDVKFhtju_KUkvcrx8456OWL_ga57I7wan1YpSwnzZ5XreAYj254
 hfrLlvCKUwdxdwzEznlwbLKQj8VmWeGWW3ddCOVCz3L3Y952GgEzyS6bOJtTEATqOWXLRl09w_vC
 GnIjCOQOzL654s4rnYpSSk_fUMZi0FxpJXquFwizRWin3yJm4o3MTkqEl.QHkRhIgbQfuaOtHuLz
 M6UMCP7gSSdg2s8gkblND_gmIXLPBhC14_o7NhvujQaR.Wtdr3StfwP_iF1Ot5qgzKwjrEsL7z0C
 x1ZGH3.BvUwJVu5UPv6PA6mJgwHr_nCVOALBrqrQeBa1Fpm.hd7q2CdVJuOYYDe2V1NBpbPh63Yz
 OrWOTuk1P7U9sg3wREOOOV2yVtTq.Uf3RAvLMcPd0YrQFsaRkmOEIvjLm5gbwCaR981m6hy1iHJn
 Pey6gumWXbzG7e5YVWziw9XR5.MCf5OFQByW.QlOZmsT7JfkLQJuT4VLqk_uJl9jcUSt2iPzHFkr
 angyWaHh5Wfr3qozEXz9Zehn9rAdzT1YPzywF62TsHgrl0ENeXNxnc5OlhOPqKrfNTYNmbzj.FdQ
 oK4XguY8PxzCtNnctAseOkxDK_CTDaBW1MgNrLHYVuB4pk.3Kg8ixtHiE9fpjTCfeTe5eypKcz7p
 DChlbRRJdFGCrnUh3Y4xUDu.XfvoQhQDCmWkctFRjVQ--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: f08bebbc-9d09-4fe1-97ea-51ff3b275371
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ir2.yahoo.com with HTTP; Wed, 27 Nov 2024 00:00:58 +0000
Received: by hermes--production-ir2-c694d79d9-qp6kn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d91172f74165254868bee18e8bab607a;
          Tue, 26 Nov 2024 23:40:38 +0000 (UTC)
From: Jakob Hauser <jahau@rocketmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: David Laight <david.laight@aculab.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jakob Hauser <jahau@rocketmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] iio: magnetometer: yas530: Use signed integer type for clamp limits
Date: Wed, 27 Nov 2024 00:40:21 +0100
Message-Id: <20241126234021.19749-1-jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20241126234021.19749-1-jahau.ref@rocketmail.com>

In the function yas537_measure() there is a clamp_val() with limits of
-BIT(13) and  BIT(13) - 1. The input clamp value h[] is of type s32. The BIT()
is of type unsigned long integer due to its define in include/vdso/bits.h.
The lower limit -BIT(13) is recognized as -8192 but expressed as an unsigned
long integer. The size of an unsigned long integer differs between 32-bit and
64-bit architectures. Converting this to type s32 may lead to undesired
behavior.

Declaring a signed integer with a value of BIT(13) allows to use it more
specifically as a negative value on the lower clamp limit.

While at it, replace all BIT(13) in the function yas537_measure() by the signed
integer.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202411230458.dhZwh3TT-lkp@intel.com/
Fixes: 65f79b501030 ("iio: magnetometer: yas530: Add YAS537 variant")
Cc: David Laight <david.laight@aculab.com>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
The patch is based on torvalds/linux v6.12.

The calculation lines h[0], h[1] and h[2] exceed the limit of 80 characters per
line. In terms of readability I would prefer to keep it that way.
---
 drivers/iio/magnetometer/yamaha-yas530.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 65011a8598d3..938b35536e0d 100644
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
+			clamp_val(h[i], -half_range, half_range - 1);
+			xy1y2[i] = h[i] + half_range;
 		}
 	}
 
-- 
2.43.0


