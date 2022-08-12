Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF5C5916F7
	for <lists+linux-iio@lfdr.de>; Fri, 12 Aug 2022 23:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiHLV5E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Aug 2022 17:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbiHLV5D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2022 17:57:03 -0400
Received: from sonic307-54.consmr.mail.ir2.yahoo.com (sonic307-54.consmr.mail.ir2.yahoo.com [87.248.110.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B893FB5146
        for <linux-iio@vger.kernel.org>; Fri, 12 Aug 2022 14:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1660341418; bh=mIUQiLcLvAOL7SpGV1ZiJOCq32eACtPmZycCkGSkGCw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ZkkY7AQPKhvfe4i864U6aqnEEsxHEwS+MZUseCUOsR5gc1CWZHevptoBA6Ogygs7eSq3PGLAYjZKZHNmVF9LAwSd5J0YZVynUcCXN57MpAqgmusxQD8XxzERxoh2rcR3EImvnBK+mM0Lu1IYhp+rJqwv3nHJi2YLeuozxfX9LZ8MRUHoFhXmL6ZJcowcM3RMR/aRHkEddZf8sT5+wRGEpvpzCNfpEwbFNQ219WlQ9ZiRcwZt8RviumPAAeV3duOqusO0MYgIg+hhcu1DhVrS8zZn7H34s9P77hG/Ly2agPgNL0/cU3I3cEOoL8/OfsnGHexCOMGY3YO8sEq34ewgiQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660341418; bh=VZVsB9Et19YPn6aP1OmcH+W3+7xLDoKoO/1qWgfgq9f=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=EWcC543b3COPx+Bi8+LnwFnjR9lvyWaDSAl7itdKRc/Z3H+tAhCdwPcX5cd+NkUh9iUa47BnZEdaxSwDaE2cNlnNv7azlUIMJpPGXzV4DP+9uBBtykMOVkVHsK7Sm0Y7n+y8FqoQSPiIhfSPznmSzQwuI541Oe12pcgG+joKV3tQ0M1vJa1P3i4A6AlgvGRDpfiCULWIWcKFQ5mq3nI/8HwW2/6mL4bpAQ1SkHIk6b1vOZAfvwpKGTERoIioWBuZVKMWlsbMXcbjQ2n1gNPBGl40SDIroI7a1ifAKcY2EzQ1vQO8Jejw47wm0aQZOPjKiPsUZzp+9g444IhUPjr8jQ==
X-YMail-OSG: ewzIJlMVM1kOlJ_bAKj1.AVeRZVgSHvO6rPkScVgDcfo3eim27b46pwL11Gp.nS
 UTwY2DZvYZZ08lr776B6OE6Wn3btgxN6BsdNfQZdzMB2s3Ks.8PsYg7qGin3wobR0FCGlEfqgm1A
 sRENjDVNolIjQrjqdP9cEasIfGJr7rCRqbP0F0ZyMpucYwgfsaed1OvGSwuaBmAKdxJ.AiA8g23U
 YEA2Uo4zJ4NQe3SJmfjDtFVuTbMgLIBNDmZI3l.QnDQGPYsFYvgmWKXmGRzLpcQOR_vbKQcspJlF
 ihsqQyyn7h9b35wnNap_ucqUTpHlf3K5isydrDb9wFGnO80U.BinZT_P99TylApP2KpleiIz449h
 gR3vmjy0.sSZvj4Lnx8Mhl20NTCMcwRsU23ZONUh5UXIYgEEhxErZ657I1d8sm73dlStewAPkYkN
 v05OE_b7B3EjX2itI7VPNAnGTAhJHTZTwvgYkEKSC94Anypyi7ZIX9KxFsEPq.CFZQG1mXNknZD8
 PkbBY7RPjORDiEhI4N0u0XEsImiGrLVuWKmJeqoU1MDP_OPrGAlKNov9CYLpWseQs_a_Qiqy3jvJ
 m96I0xgkzvZeYxTy_pSFLXzaBlnT_CnX3ZHKCxeww1uCR19JOVHzduxLb7fhCZsMgeYNSILVLkX4
 UjSbxcF5ytB2cbnTNvJfcg661vO7w4qMoEVKfDRFtbpDzcYMRxcZ7DyrrggvtAfNgpUoc_7.nXts
 lAE_PSi5KiAm.OAT8iojk.We1MquV8d5hDBFxdN3qSJlcNzr1wHkB0mlTm4SYPG4H8LuBp2UAfUL
 QCO25fwqBUaxA.m3Bsp5IXXQJcd2xzZ2fG.iNvVMsCtzj0iURsqPuF..1u0jSrL__CsEcXEOAdzv
 BVk0dOpL04W9INK0CmJgyxnH7UCGbhFXKmBukEQ5CXGkIemLQ4clNKtD.Nf3Juhd5w002y3NPDuJ
 h156m.ElpETeA3tAmvj0VyM60o8ZUeSjByRavLz.zWnjqCxrK_dPi.lqm0uVeQa0jsIaDYVinBbB
 5uk_n_eIBq3ZPW12s.PM6dgOtfjY.IuyMYtKunyjytURDQDwl8pjicEYK0Zug0drlyhmNOHS_NOA
 hBrU9SdvXtxMI5ajB4PSVuAOdLOvdMVYzmu5azdrJ6Dct4wWBEgx9exb0GRBscWnUblb9bNHbzhS
 xtqGeEXcS6ZgUwaqsikF7ptRBW4ACTmxprx.IJ1mWZyWsVAH9AsLDK0B8KpiBaXUlJYRDYbQk.OH
 rBfwBqNRjZGUFTHN2S2bbhHzyRfZRTnHx23ud0sKIXfEtwbtRDgWDHvAM0C.z9aYdDMnFWuoBjWO
 q7muHLvEm8JvYZfuZsv4G2CWUPY7zH0jac_GjpCxEp9hcsxi2jQ1EHAGD9T4Av5pc2ptrA3nm6pB
 jJKb7Mn_4XtuIU1eSbXuqWkfq9EYg4nHn_MnXNg_mViFg..GuVZgIvczAIk0EYMj0YL3LwawM1Le
 _Ndi0jCyfwxUGCv_DG99tovM3ymmoUNxofpmbZrTuKklobvqWtw1Rg7VJTNavpwLjRKqXpSqBDD9
 l9OCpw7X7a6fjEPuIUBpDFHoPehW8yXJr2ETJ4xqRB3bVlN_aKDmwNt24R9Bt_En8nfNLpaXJM0D
 LwH_pBl2iq7npkA6Bl1876b7LK2JZcH_3I6RcKXNpqt6Q5x6q9Azn.r9mfNmIqQuRCiv_glkkGZZ
 A84InWJJmo9szF_FIeOzPda.wViVQeDkPd3PekH0oC_F6Lzk7b9hjUe.JQrzGp.Tuc4ULO96bA5w
 ELyHaAHRPYyX5f4pZvfgUq1OgPEVLaqrAShSIldoIpetLrZl2OT_gMhRv0xm1iSlrcIzIj0YGNEm
 In2DtOWDKD1R2BijlUWMTmsmu5jApyZgpeDX8bI42x3tRm4kJGAxyE6P5CLQa7MIJwp3EXbuulCh
 eexyUQ84d2j.Xd5rh_7mKx1s2j5xJY.UKhjZENbOh0LzmjqqRnSFUa0Qb0QaLVHhkvDO930HTo6F
 bwTOt9C_yCH.MW4M1t3EnlH0aYl_fcY8xUkK2qm8NrOgdQt9pBl7x5W0EhkVqVfTb.pRryT6KHxG
 nHcmbCYJCxI3jf1fxONQnn9jF4QacQyUHvZfLQtaKlUxheUiR2PR.ESWy6GrClM3kcq3C.Xcn7me
 qPPsIFZYNdaLHiGcHeyEpAvzrwlbRk6pPdq9Pg0vA2p7__A_fyq5qZBCUJ5ZekuUkUua3MQ70Wys
 7lYa68sWFMKXWgh.5pUsS6JXEHCiqP184WqS0mh5oFnQqFB_eq3Upv9xkeBZ5Y0LV8da3MaxQXM0
 yfqmmxkDTkBEDjlWJLt4-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Fri, 12 Aug 2022 21:56:58 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-2vqg6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 15f5a750f82727a3561822ee8056ab25;
          Fri, 12 Aug 2022 21:56:55 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v6 07/14] iio: magnetometer: yas530: Move printk %*ph parameters out from stack
Date:   Fri, 12 Aug 2022 23:54:12 +0200
Message-Id: <93b50c20adb1b2acb4cddb1ab25755070edd7c07.1660337264.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1660337264.git.jahau@rocketmail.com>
References: <cover.1660337264.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use less stack by modifying %*ph parameters.

While at it, in the function yas530_get_calibration_data(), the debug dump was
extended to 16 elements as this is the size of the calibration data array of
YAS530.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 40cd6bbc9952..beb48f3a959c 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -664,7 +664,7 @@ static int yas530_get_calibration_data(struct yas5xx *yas5xx)
 	ret = regmap_bulk_read(yas5xx->map, YAS530_CAL, data, sizeof(data));
 	if (ret)
 		return ret;
-	dev_dbg(yas5xx->dev, "calibration data: %*ph\n", 14, data);
+	dev_dbg(yas5xx->dev, "calibration data: %16ph\n", data);
 
 	add_device_randomness(data, sizeof(data));
 	yas5xx->version = data[15] & GENMASK(1, 0);
@@ -711,7 +711,7 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
 	ret = regmap_bulk_read(yas5xx->map, YAS530_CAL, data, sizeof(data));
 	if (ret)
 		return ret;
-	dev_dbg(yas5xx->dev, "calibration data: %*ph\n", 14, data);
+	dev_dbg(yas5xx->dev, "calibration data: %14ph\n", data);
 
 	/* Sanity check, is this all zeroes? */
 	if (memchr_inv(data, 0x00, 13) == NULL) {
-- 
2.35.1

