Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87F25916F5
	for <lists+linux-iio@lfdr.de>; Fri, 12 Aug 2022 23:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbiHLV5C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Aug 2022 17:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbiHLV5A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2022 17:57:00 -0400
Received: from sonic305-21.consmr.mail.ir2.yahoo.com (sonic305-21.consmr.mail.ir2.yahoo.com [77.238.177.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880F899259
        for <linux-iio@vger.kernel.org>; Fri, 12 Aug 2022 14:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1660341417; bh=nuMoHzZRdeYccWIDIyDSTJ5ryNgtfIJF3s4M09Vr0oU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Ge9a8lac4zAhLE4Son5FO/CXCn5kc/dPGgAmtDa1eslF83nMlJOj2zsFABmMukogxqOmb9kawtGsI4F2sD0pvkjS2Dm6IXcFJY03WGfk3bBqXW62KaNQT0rkf9+v7Fov82s+QpbNhw5wyY9Bj4EOBTrnPBXlineiqH/0aX3K83xQRnyMwGwz6tAApTRVmWCx4RS6Xj1oCHwiXxqNDHoQ1+9y4yPgtZrky9l1WKutqMCNYYudz+eTgl6xnDhM2wBfuviiQNpjQD0C+HSxpuEIQLsHTJbMVixaZhVctC9S7lrIqQkDFs4rR9qRTCrkGV0RMO7DW3ivqnaBy/ta3HCYVA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660341417; bh=zqqrR3UrpbrRMJ+HiDCFCWJ9rnoFujiaifHyhdHHE7p=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=pPoE9OE+gHzY4EWbA++xNxoenUueMWFD15d4ZRUJOzW2xZplchO20uA6JyVIBZfSDapANnDVNqxQdpRXa2SZyEmnZ36TgF53luuwYTwMrxP6Ll9tbhoSHiDX8CuuznPM8dpguxtN0BxYVrh41zyzge3jgmA+Z0ncwsXpAWElTzRmzq5YjmNgd4Ges1Z8LwvreLz9eem208kwWj2HOUlU59rq+G5S8al8/g8O5DMsKXbnxAj5N4i1rZWt7XpcGZCSdDEjyC30Ck7gncrxkixKZk5MHojBrDuB9HkyEYuk0vE8uHGRD5Zy3NVfx4XQI618wJtF0U65Ao33kVVxypQdaw==
X-YMail-OSG: uahWN0oVM1lwyiDRffZTeqLsZUZsqWqUZcQdgfiCH2GyTj4dTIa.BaD9_yZHHNH
 uxi01oLrPiDjpS.mjt0dlx8otNuVwecG4cKhynPEFduY_ZnD26URYMndC_N.JSgHzDFQ8PnQA1Fr
 r8TfGHRLnwya_6VZ.zd_F_YEwtkhzXFf0Go41k_Wvlh52WRTKXhyRdapIEprgxLvrOhqyVTJDw.Y
 YFwY5p8qL0obzU.BcfyNNf5AFhieVxAnoeJ87z.5Hr_CnZDN5ONU9zaxRXnUFb7i3aNmuidRz2LY
 Qy98wwbX75tmYLeh9jlzVwJpkW.ZP7cwBCM0EWE_1BWqFUMHfN_PtvcQ4hVj0tpuVZPX8_83XcPC
 iqnysAnD4y..5kJUB6jdKmPuTSvVjc.j3lBLVISuXF4bbhHZEZLIqPECKY6_vzrDVoNzgHrzpd4y
 I57gJ5mYyqeYTEmWMCRap4S4z6cHL3VXH6BrGFGW.0qyUGeGgd2NI_DBcW69gVFglHKOVka4dheF
 l_kMGtBq9q0hDsZWDPxoG7VPECdl.lwDIPRhd4Hma3QVxYUofdWvxcJWsyPMAdhho5O7jbxZa7pK
 lKrJtTNFKki.tAXuMVOaTKqP_jz_938pT4YDESxRLIq1o7LSgT_vQ.CTuvqkeDpyFVtojgnMwIef
 jPWmtq_vqWuYgxZCs8RM9O1XVBRsBSi7srdHDQRnmTuIc5O4SKnand1NLNkXEkkYhPjyhQdi7mTa
 DJhWpOWeqboAI7Btl.VIoNntYmhY4kB7f6SF5ZSqGxzEf0LGW5r7F3E9ua9U_aK5QPuay3S2XgVK
 .VtUfmuEcJCYZaRdigVR6pPvAY3w6gRR.lGjaPETVMR.sVTQSUM.Lm6nW9ASTQoH.Lugz30nOkuQ
 IlmuQvfOa5oFZf91dQ9AK0iS4QB2FAo82jQbrmN92Qkb.zc6TUxkeY5v9g7SFZhMg.meDweHOu9q
 DxYII.neDtKUDb_COQ2zkdzz6negQo6B11xbRPDMWodkn4Xqd2bGGU6pW3fnBFvApUn.ita4gemN
 AqmMC1THCe9vFPB8kBwMR0zXG8Lh.yQVaa3FHTFemV1pzXZZp9MQ457mHZEyE0vbEaCg6gxHn5pI
 HT4sRSAOdxuhdQ7V3xHTUybUpHlgEKUKKqm7Eg57mOwv3cXxsL7z47rJQ4MAFBc4c3HGhWIRCgRX
 dfFshBWk84Sruiqvf9nCGiLwBrVYgbBT1vH7yLyno.Vn1FrKsv4EKEkr82cLChJoP4yeGpEfvSqy
 Uab2eBp1Rvo0rsaesp2tcitOqPgGxp4Wc3WZVtnCyVz4jOCYMQ0cORm6tf.4xWXyhAmB8A.nBPKl
 pxCxp6pcvusRhR4PiRORs6721H0WGjs4fx4u3CPvbu.gygx540IXFB0uwVVzgU_0JOaMqF7yHpF.
 0h2OcGJ7ZFydZeh.RtHBNPM7PtwjeQqmY7wbG4BaBiDiGn2C1dKlRqrNFZhI305DB4SUNQLJk._T
 BKpYPJq1RU8WzFEk0Drg224ejbBiulkF9oLubXnCHHWEyniKIo0YoUKh2VxaU0mt4yuMz4g3MQuL
 YEJqS0L5bY_5EE82ixKCuDgO5G6bXWWsOhjHwjmcu.jxYspLvV2d2zVTVae_oSqLGHT8MWd8FEzb
 RRAIug3GgqtwXHEaH7xlL1_VZEhduib6bwpytPJ3BFtzJWjkbc57A5_jarSY8SqmvxC3g.x2zIym
 o_FWBhRw2_05aSXolDmZQZSW3D1RSFHGUeRjAu6Dm0M_WJxJ6oLaEG8fINONxXh8KbFwY3wccVKu
 .zvKOVSNCpgz9tbYJ70SGv96QFgDSGSSTUIMCqNx2iBWTiPVCzUWmaHs5F954PoSOONQF2kli1Ka
 6tNfDQPBXA4KpzPDK_s0PGHgqiSXumGuXioeY_kLPOonk3hF25tcnaobJ1KGWHMIKXfQxj34E8X5
 wgurRG.ZUyCYLpYMJMFQtFZLJHy0HqXxyCZC6aZh.w_bPHpVLcPxX3zg0Q_OH83kd_4JOiIWIZ_j
 CHnF1snDTQpKuxOKwIU5zy4.r77Gar7ad2WJtvqyYOPbUZGqvMIdd0Zr9d3YFCJM27A.zVmIy9ky
 nVNSHZSv8LSPu6u3IV_X99VvIiy41wApSLCIYrLjUrXbiYXmCDG_5nlR85.2KeGuzVt7ySV0ZXhB
 hLtUclcrH3TW4vnSuMeFk_hC.FT.PwWeak4hmvHyAkA2AknX3EHl_A04T1xXvFS90W2l7O1eRlBr
 H7RdSR4Iq9IHGNl9asnaPh6Z20uvdr1.4Y31rLjRJjN3SQZFakGAYI_VXBM0BtjiTfTY2Pkq_i3D
 dHDLaeKnIwZygOw--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ir2.yahoo.com with HTTP; Fri, 12 Aug 2022 21:56:57 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-2vqg6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 15f5a750f82727a3561822ee8056ab25;
          Fri, 12 Aug 2022 21:56:53 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v6 05/14] iio: magnetometer: yas530: Change data type of calibration coefficients
Date:   Fri, 12 Aug 2022 23:54:10 +0200
Message-Id: <f1e53bd6672aebe59f9b236b41374482edf888f8.1660337264.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1660337264.git.jahau@rocketmail.com>
References: <cover.1660337264.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is a preparation for adding YAS537 variant.

YAS537 uses other data types on the calibration coefficients [1] than YAS530 [2]
and YAS532 [3].

On YAS537, at least for a4 and a7 this could matter because 8-bit unsigned data
from the register gets stored into a signed data type, therefore this should be
8-bit as well.

For YAS530/532, on the other hand, it doesn't seem to matter. The size of a2-a9
and k is smaller than 8-bit at extraction, also the applied math is low. And
Cx/Cy1/Cy2, now being defined as signed 16-bit, are extracted as unsigned 8-bit
and undergo only minor math.

[1] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas537.c#L76-L78
[2] https://github.com/NovaFusion/android_kernel_samsung_golden/blob/cm-12.1/drivers/sensor/compass/yas_mag_driver-yas530.c#L526-L527
[3] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas532.c#L76-L77

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 6296ea3140ef..a9d7cf3ad77f 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -103,9 +103,11 @@ struct yas5xx_calibration {
 	s32 r[3];
 	u32 f[3];
 	/* Temperature compensation calibration */
-	s32 Cx, Cy1, Cy2;
+	s16 Cx, Cy1, Cy2;
 	/* Misc calibration coefficients */
-	s32 a2, a3, a4, a5, a6, a7, a8, a9, k;
+	s8  a2, a3, a4, a6, a7, a8;
+	s16 a5, a9;
+	u8  k;
 	/* clock divider */
 	u8 dck;
 };
-- 
2.35.1

