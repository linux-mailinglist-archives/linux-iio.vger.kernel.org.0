Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70037564A30
	for <lists+linux-iio@lfdr.de>; Mon,  4 Jul 2022 00:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbiGCWD1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Jul 2022 18:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbiGCWDZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jul 2022 18:03:25 -0400
Received: from sonic310-12.consmr.mail.ir2.yahoo.com (sonic310-12.consmr.mail.ir2.yahoo.com [77.238.177.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432DE2AD4
        for <linux-iio@vger.kernel.org>; Sun,  3 Jul 2022 15:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1656885800; bh=GR8ksOaf4DkPasL6sXDaIM2/cMoDf6p7jL0ro40UYps=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=QcxjmgEmKbifpS+q5qYZ1YFmYVtcKoh8osHXMh799LO+2qqczgyECl37e8GQlNMwddw+8Ye3yuml8q82CEQJzHLVvys6oAABqdycWvb2ZyU/XZeKffcjH5EZ9zZOfQzJkkyK3LXD/1QwFGrXl5KHLmnV/nlQa5H5GQHabgyqw0PkabkaVlAyOR5sfkhoHhIZ8nQ0UAKIWW7olYKYXV0BIWfm3r/G+QxluXdbhoEs0/j24Kt/wAy1OhY4EGh2ezleEzIBB31WbvwSNZxIKtX7aLB6UXsZri6W3dietSu2N8ZkSMGJBjvfu9GNg6qB8yFk+GxXbOWnyPImdgCfbmowDQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656885800; bh=GXq8UhEZp6WTWu3YrUwCUOAJg6BORGMf779gHVoSqQb=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=kzA1FjG5KvFyAvLDWvacoyYfUppa1FTyY9wbZQE1NaffafduPN+iXzRDj3Hw89t1OXRJZxwAwu2K2ToP0GVyjDQzUB1rzaYXsIQ+xdCiwhXnh4cQDJO2EuFeAlTOvRqcl58l1i3Re6POAOTj2DxIJ5gnWPW0POZnqSxh9jnkuNMau522ouARxNOR/S5TslOdbserOZTnOsNda5Tyk56EE6UujzIg3vnqWpAySdIK4mqCWABKJ8gmFKj5jf8UvzbRitT7NRe+13aw1gGqdUcMozxBkEU8NtLMmbCeYuhqibiBey36atSMHSv2hjTbZOGWWrsQXV56oDDi0HO+00jEeg==
X-YMail-OSG: fmZSPZIVM1m4UsPp2Z6HJntg8k5AUw1ySzkrwvClhGy3unqI.OcI5O4kO0IMVp0
 utki4VN91B2nF21rr8abi0sYz2GkiOXcvOWNV_tGqLF_O6gLHkKnudd7.xByPnh0eMQ0XCjLnStS
 xufMRQqZR.UIzeyESUL2.Xw6YzdbXNdIp6YroQAe_1tdMT8HNYhNATLC1U5WnJ8BOWT1YXqApLS4
 8T6ZLk.whRe6xE57SlSWoY30KFy998lV_tmPycEnmTstvnNx7V3O2g3Hiqc5He2WItvXmMEMOgex
 z.RjGratdc.uP_6D2GF4pim_H1EAB_YCy6sDOddxU4bS8VrlR0No7a7JzlUIFu9IpMNb1gnPeKOO
 VuqEQUmKuE1lSqEDXHhbrhEi5SKzixGXERBnZURPJ8_Lc7iRcTPmezYitXZqB7jXmbI4D8hBZAXP
 E9Wnu0rlimJU7l4qNNEVf2T9WRQHOP419UHSToiZ2TaD4aLj8XakW0p0P7UmdwLtn.FZ5F034q5J
 EVgP7S15umMtSNOt5cGrMH_hwgigCQThsQ8uMRwxobQgf7zcSRUUb7BbKVLQnVo6Ek_VYcEat1x5
 Y8kJyYC5gSnQQfKQOyCAqQ8PCfvA1B1Z6M4W4AeOnInRw.VCiZ1U09bczYA2JW6UgM98xn6bi7Gq
 xqxUUz6n84.J0hnCft2vO17JBMXkGDwzgbqkXH7K7Eezf9eijEO1X6A3fTbWUWqmLwmh7VpRRGhK
 wUe_oufKB.H1790yZLmbs28q9PLBHlew1LyCNujyMx7A_4YmSWmQ9Y5w8U21fS3QBgLY2cm.bvUJ
 IktvEm0YV9DEV_aT8qjAWqIXtLPSeg935kjpToi2x3bzcO9eWnO.xVK2evSpGPRDlQzi7IwHsPjK
 SFyTxqBg3Jt0QR.eQxns73HPgpLh2qZc0RZKTTOfzmmBrYijIklzB1PkZlI5a0kV0Vol4HtSwNZn
 0aeU_qtn51lbpqkIBBnQJXFOam.AKSP88gSJeZKAyUW.1vSg8eIzYqUtg8tbdYL1o.SIMILlI3r_
 uHUNQE7LKh5tbywtBSwwDlEiXjdxyr55kB3tPbmmxcXX4pXiXY8yVagxeL61ZM0cjhBOxm1aZ3Jb
 e2oNmcqSg5NK6M79qxst9H0ztHf7cFBS35Zb4P1QY0EaHcES4PZ4xRhq4DTM.AWZBc_aLmT3GMc2
 h774XCLNb88sviUiMl4wUYWk4.PPsGX5nm.G_FMwaOhXZzjrFmcA43wWT6bbXUP6TYwHf9V75d5d
 3BE.ToP5WJjOrOpOMNh4Ub02AYheEj.poCjctg5fFY8.TVYNWVZIk7Er4g0v11KIDQFb_PDxh4zn
 8iTaJU3bXagecmnRzAkdBh5oPwP8BP9hqnrpjOZgXm6pOD35LpJrU9f8XpdDiBO5F9mKK8U3CzYz
 kORuyVchxFn1u1Xibh6tFPJIFekib_mChC0oav9b4eGQt.JWsRxOElCCgsBE2fCDyacJDNvNeHdK
 KOsvWZShKMJ10zX76NTAVfq.c.CAMepkZiZBTwN.pENDgJWhxraaeo2FO9CB5LEwd1yxtIq91UQe
 yK9sB6k3mZTFMzA_PZhPOMzFwiHJNe5cRvi.LMIy8R.rZzMPKzRipCKgSqza6Suozg_mD7n7FKtI
 Np8ELamAMgSYa3ZTbQw7l5LBB.grfD2h9bNCfudybAraDp3a3U4qFw7IdXNK_2wPzIDc3ZHgj0IP
 YRgMcCo78Mma9fRvC9M94.y5qgAvHFD77OtMCX3Ao4o98BJi3DrILdr8vEVQN8vNeN0z32Iykrhy
 nkPBNa7kLEKyTy9kNG47emR9LhpkD.jbZUHs07.pT2JhosYrtb7Vos3WWrzKoEPZ_3E8d7PydbLi
 YqJPnC7lZ5YuDVPiFgLroMXT_Ecfn24mYgzLPth4DQU_tk8QYZG4G70vMXeyhsCHFyD6KQZmbLsp
 s6CDi7VIRcienHuNNJ05AkgoyaQg4TTK8z1S5rj68e6D1CF35.NBwaozT.mc3CtyZzsy6fUC7BUg
 czzDpFT9DZxYybYBfKvc0WgftqQbmgrgSpSwH7D5wUB13VZJScGvbINvMzaaTpWiVLv_I.0t4BCY
 FLJZ4sryGuydDRaukZd9xiQoI4KR6G2JYtvxzT1SYQQiUBuUBT_P25XRsyQT1sxVeKmbiRnM_MlI
 LupuIiT9Hcd3IuGgV0kjKbDcHpYeGp61FqZ0ZNatkYwFbQ9miYzyKhK1yq3FEOocB4eZGpqIsXIV
 jpYmaJZly7uw6HvRWGY7ZEQjAzceoQlpXNVq5oejZ9PCYcpvIfjYfNSJX5korCoVZLczrKILQx3S
 2q6o4IwOPSPNN_QKKtw--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ir2.yahoo.com with HTTP; Sun, 3 Jul 2022 22:03:20 +0000
Received: by hermes--canary-production-ir2-74b4d6d794-tv8mb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0849bd8970b52a790a5a1bb96f2e336c;
          Sun, 03 Jul 2022 22:03:16 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v4 05/10] iio: magnetometer: yas530: Change data type of calibration coefficients
Date:   Mon,  4 Jul 2022 00:02:39 +0200
Message-Id: <502f2d4425af785efe49c9e3841cbfe90fd1b713.1656883851.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1656883851.git.jahau@rocketmail.com>
References: <cover.1656883851.git.jahau@rocketmail.com>
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
index c6889a30a1b5..839baeca673a 100644
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

