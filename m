Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F0C543FF4
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jun 2022 01:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbiFHXj5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Jun 2022 19:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbiFHXjz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jun 2022 19:39:55 -0400
Received: from sonic307-7.consmr.mail.ir2.yahoo.com (sonic307-7.consmr.mail.ir2.yahoo.com [87.248.110.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1433B20F6A
        for <linux-iio@vger.kernel.org>; Wed,  8 Jun 2022 16:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1654731545; bh=vWR+UX8A3ZClgreBBWX2lrgw+WBdMQRKnORcOZicy2Q=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=tevXbOJe2MckaL4xlk8lwxLUQa3a0v9ExEKwlo4iLXV6E2j9F9F/ZARIUR14i76V7MiEGlWlasTlA5gBPAkF1k/1mbv7RvWVuBRkrNcj3hwZUB6FgPkK8CTnB/WF+NkFsbnF2kVRVHMnI1f2hGus08funkXFAmgkH8ptptGiZ6F3TU2JOWcJyQVUl5NUGuMQrkGtodhIXlTPTiS0IMqUAKlr8ZFWcU9GGr2RbnbzSo6OQzKjVkoCwxOFMBJdbVSo641biGyjpYtqVGar/1um1ZsEvlelc2EVVFhMs4knY66mAE1RxFi6Yk7PuzlBzXAPOvCLszVRwnigdkn4TWPW/A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654731545; bh=pNycn/pavnH/7FmiymjR8lHNnBTMvKaP1OqxzN7KBJ6=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=PsvjBRmHldzTe25Qybf4+5rDGer2Brbgingj33Kmg9y1/R0UCFT4XbGRFSLH0VZvJlQ0QH3h58P7mmazxgLZxH8GFP/qv2uibCN39pvkjiATd6LH0lD8XmaWwiu3zmARy/agGReqJPd2pgxL6tThHn3zwRmh4w20C43ylof/6Jx5WhfgcjSpTKy+68NDJ1xG/sEPhqWuX58pdxy1FnTklQ2vyi37vM/F6KTXo8xXbU1ra0iETI4o2pRAtosDjzDth8Ko36qVGcmGyxGOL51b08VSnARTp2nf5+lyMSm4vawnBIVVB338BTyTWuq8QJstU5EK2yWIuChVF0mu1zW1Lg==
X-YMail-OSG: rWQs9TIVM1ncur5OPX1ko3W4fiRVMi4t.p4XeEk59LEMkFXMOlqysLjAzuIr48B
 _HPyYn8i5HlXG9.f8qSEKX3L.2kChHLl_Yg..QpnY.yNly__VP_lsno20FG1_JXrm3Dc5X6hA3SY
 1VLDYpUsXB09fZBUzS8qIF.B34npNSDDJOfL1UdvyvlOnoiUrn7LUPQ66Zrhr_N.uxQwbzIkn6sb
 l.Gc9BeiZVya8U8W4AgSqGZijg7eFn0y62JL0IgB5UmiVxiAntEzgg9tq4w_.aVKWqPS_Y4hxHmn
 fJBTIFAqccMOo5fop0e3pl3qrX5dUdNWt8TO6FR.frOAUb_sJd2clZmRnOGTOMGLiStRRogYPkJW
 ZjzKPu5a7OjfN27hgrRD1xKQXNqpJat5r7V6BxEmajhgKwfG1YgTwS9rJ7Lb9rnjNppf.WOaURWz
 gGVnTdkl5jO7by38RTIHR45yll8bVGMy7aAuSA6gNc8uHhK54nHB3Oo25yttzs7qiUlU63aIPJYS
 lNaVP0tE50pSDe_dsJq3CtDsIR6.IBgC3LdA48Q5Udk59IYWW8HciIMEKH2LexO7SdHgwXmj8d8E
 2DPNJSzmNWZGJMNi9HGrsELVWZVW_ueLaz_Xp7MkxML040fPHjbf0YnBzyj_80JpR65CCmhtJJBR
 PyEH4o6RRHp7iQ66AcRrngu0dGprwjNDNVkSC6OtfKxCpVuA1TOCmbcL1T0NM_yoJPGJhVFZmdXu
 1SlSLThhCDPKmZRpqUcIMPqnWRMRkPl_WyQ.HyTfUWykmRJAv9RfLFO11yhVJ3SrK._x1Fy9rcxX
 _n6CDz_8aSDt.IQokpiTzkgBFL4G8wpM7GOZVoDxLp639BTCt6mhD0ncu.6J0UuwcCfeHhYnmCyZ
 fSScMIInwkRg3LTRsJj0cEP0hqVEhwOBWyFCJXjdRMRpWGKoZtdizBJwPanb0QhxlnfbVyRYrIBC
 AtIGqXxgBdPTueel9medSMIJU8_a9MGqKVbeWTbI0NP.a1LsAjA7iKQL4AnZK_fek0Xnv8iDIUih
 gMCk6YARAWpTAgt5M..WujYWJs_XSJJHSlVr4RnPMrHx7ecYcmZvE34ms3bcL4kDS1XYDVs3oQmG
 SOOLAMv.rR.rNM3bkKuZZlvxbwlG5BzGfcsQncDE6LYPApIHQ6GdNlB5ORUULazCrdYj1ENHaem9
 OsgIKRVZbYpVeghvBppnCbEONKau75PLlNNxffQtUA6NO3C1n1kp4kH3N5DCVOJLsRiZy1OrzKln
 BRttErRN1FSPa_dWaxHxmXJOHI7_CJD0skW9lVmfMrgQ9l8nrdBc6VORtQyzIIVI6LIqxsWnzTBh
 5o2MCBDmag2NU7pDgKbIOXwX2M1nM7pMnEhpBFroIAt1VCkm3fEjjhNiyQ_QRWaF0zAdvTI7F6PW
 nzqM287dk1h6kq1GsOvfhPqP0fSPqaBHs532X36Oapx7w1gHrQE4u_n9_5rmOjb9W5u4kBHB8QLV
 RdT_LAENgcYjCxlfyfFn2sRFiSUdFctDTZMLvgHvkvMqltz4txxCULkjLyW.C4DIK._qFeyHfYP0
 Kv_RYklLa0dCJsI_ldRinC2ScIzua_ePaPTrLiX3zAy.FeThJKo8_RmQRBRrJ2oV.IdSY3nwisj8
 qEtoeHL7qWdg.K4B5sG0mIbf5gCUn0e106YiR4IimBMNhWbrbGe2EfVXuItkzaBBHGfKA8pVaWYC
 UffSAdRFU1oeoSfgY7yJXLj.er7JAX0vi2qbdi2ZqBJjXpK1PayaX11VCSn0Oep_45VEMZ6m3vbf
 J2clbwKT5lBxGvBwN9gpF7FnKH6Y9BG5r0k9INlMx.i7rgMlIg4L469p.xaeZOibTcNSWI9fGZma
 dILUPFW2sHMvFM8MnA5L0yTyw6DD8kGkwLyS2mCG59_DJI2grbcwcFL9JG1tp8790ju9D7ekaZvR
 IHaKraz4fgLnRcUBa7A20LYyPQSRfHaCKx3hMMJmWyn4HQkVNZEwCC7DQuSnoq6J74d0kaMkudZ7
 JliqPhgD.tQRCUK5.aT0v68ScTzpUjns1NHV3js1QnywC00iuOh4sKGisNvrxckr3VBoiV9uDVQo
 2548wfDaU7ffJDf_Lzunc404NyvwlSMH3Ul2WU4ffhPDQdMz0RIOLXq_jUJ3uw9HHzZWbv2kACJ4
 ym03LsfE1fRegKhxyzrTAW458Pe8Xts2IMuWM4dDPtKrKA1kPrp.kftCj.Qu7zMll6xKs29jkrbr
 HPSw8AqYeHPdjq1i1EPv.42E0XsSq1Dz2TMedREfsphuo9LZrH9wJDsHUS7UWjpbym3nhxChNiNf
 kXWsMs58ddLqC8To-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Wed, 8 Jun 2022 23:39:05 +0000
Received: by hermes--canary-production-ir2-6c7595c778-tcd7b (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f9021a74071b88f5034921531ba09f62;
          Wed, 08 Jun 2022 23:39:03 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH 5/7] iio: magnetometer: yas530: Change data type of calibration coefficients
Date:   Thu,  9 Jun 2022 01:38:04 +0200
Message-Id: <b2e1c3e59b72f83c51701470091560f9375ebc61.1654727058.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1654727058.git.jahau@rocketmail.com>
References: <cover.1654727058.git.jahau@rocketmail.com>
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

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 9bfb3b573907..31637a890b7f 100644
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

