Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1065758BE34
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 01:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbiHGXEF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 19:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbiHGXD6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 19:03:58 -0400
Received: from sonic306-21.consmr.mail.ir2.yahoo.com (sonic306-21.consmr.mail.ir2.yahoo.com [77.238.176.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EFD2DC0
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 16:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1659913433; bh=GR8ksOaf4DkPasL6sXDaIM2/cMoDf6p7jL0ro40UYps=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=shZhKhkHvg5biL4xfYK8X47HXkyAJ9OQdvNLghXK1lTABpTehMQmpdr9+fZl2klhIUK2XFVE4LU3uiRWTt/2Ao3JHcQyovTQZ2hcz1ZTI9CT9EgDZrmwSE/0gtJGc9xoj9DJBXkHxwCXKM5FUJlCkpHPyGAkLPYsqYx6BrZs6PROfp8fhUnICnXAACsdyGSHBwNmHacnJMs4iK2ZeH6YAaY/mu2IA7eyvvQbOHjSvqn9u5V5iGkcZbTtFwD6kMcWQtrNbyo4B5woIyJ2C7TjpJMNULoCD8PzWBY1wwSos4+uiu8v5LzUrIqMyPQWArl98fjBXe56iHvP869GWNuXXQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1659913433; bh=aI04ScFbkx9RmSULteyPDYRJD4P3BP+k0dKwXtEDDBI=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=k+NJZ8VxyUujezjbBkpNlAT8AM9TIWuOWTVjWY1hhSCPmE61a5P8KiLA6XczBiCQoPlepDYgViozjuMw5flNX78D+sxTPx5sa9WSnCVlGSqaZyjn9dIJ4K5uJWkiFFqmm9DrL5C0DzgoPk3x7TA2oP35QNhVeKgNBUmltO7dHW409L1jwMKhGzM84+p2oi7VjBJq8gtwH9jeS/NYVv7cK316xxCTUKPdJhH3n9Ra2Cl6SLUDx74+Bd2BIu97szWQnZMt+qgVDcn3L/vDbXR1Z0EO8lE1ypFaIfKJn66SPVpBVFTV4DZJDrbBTwl357jroAFOR23ieyRC2vB5IsTkiQ==
X-YMail-OSG: eKYLpq0VM1nP1Jz_pfTinRVHx7G1CD2TB_y5.k0zBzXVLq7Xbp74Uh0e_A2Dy6K
 a4nR7ByFOS5alZQVhSyco7e_ARiUo___3lSE_embKLLkwUpzic8emubw5paoTJJ4DEP7FQrSTOO0
 y.7NXAvRHtkP.jpbXPONA3GPKdfXSZWo2iSv7DzXA1n36ibnbBE0BiMTUnSJBoI2R7gOP6so9Pbu
 KdH9ZY9lme6wwHU_kD6e9hpihQmSZyR3Jq8DUT_8LD.pboEXta8MPDvBNGkxnxU5nmPLAWs9aVwe
 D.LtJlEWyGVUS2KUz0IZuoTJ_5aUXdhI_K5Lw0xagnIYM0HZjiK.hwBycCxRbA92aER4__wuGJU8
 Bru77YsQqZasvqLpe.cppYxcIcoeqVvwZfKI5.A5yVZGPglxoUi8dXEoqS2BEf76fmVPOOe5ZmOX
 XoDfLzXfu0T.wlA7fG4R_7QVNAeUq7qur7dJQprSM_m1tHR8o3WWeYoChqUDd1asvVa587JQll1t
 G1Gt.bafuxvgeZwOPhzO4QGOQbHzp5TAKcmdTWDsAgERmhhR4Ozt5p8nPiFvfcY8D9PEU.lk8AtZ
 628Q7SCfk7LLx0P4mMUGFXFEK2yt4w3QXmk2hdKt6NPiZ6MVY1I579EuHkqBIHJoKXsq9cfb3C0b
 8HRXvbFO8bbNiSdMuIa0pJ7YVHI741VJ1WKdXul3hCGZ4ej8Ak7R9xInddFWs7J8Y.5hvSjq6WOc
 WSVbL7Z6yEdtzdepUEMbnL3t2uIR09_iZW5Md3b0uc7Xb7euoGp4GyyNhBE1AZP8IwvHeQxhU8EH
 evjx_OKXPn.JDRNcoMp1j.61DNz6NVkv3yxtNQOWZFk8gQbYoWKmmtLJcZaFYlTokXl8nH0rU7t_
 aZPEmHLl0NJGxMUKw8ZVXQnpLb8FvGk3nk7.nfKlVAhqxo3yrRXQMs3_JLEtdoolcEvTPtXQ8uO2
 8sqvynfYudNSiTOS42GgrmRSkRMi8RxFxnq1ZzjOzMN.dgeoBcNTZ6tKnp25mbOl99j5fVx5vq4t
 2vzuC94Jcs.gxU7kJYN8V7NE.jhGr7l8weEXbwvXX9DpShjJFvkA4b7iJJ8JvF4aG5Ph.ZcqmTys
 D_qYja3xcAdNAVXVAqtLTmm1VQucvuaJ2Exrg_vCo.BMSyxp7I.6OvYNNmPkrNYkc9JKPOcLolXD
 5.zq0ZiYbV2s4mJBe2ho2VQnUmANFVqxUzO3Cb2YDnU5i0fwYsuMZY7WOmRg3ib3ocwBx6VwQP8y
 JPrjIfx5WYwF5DZ.NbPepUN9OZF9XahDNFbmCIM5JgJjY6uBn.RWCdQLtUtC.VdVFc1Z3szF7Lht
 6tvbQMUoNjaMJ7.8ztgH15eh5HKIKnzw7nfAYzjptTfpCQTf7CEBJHN82eTBvymIgLNfdPm0oMHg
 7nmcu2VFEcDqD5wRGl9ukxreDyBlT0XcTLAEwfiPdKCffHB2fNYkrfsbiXTJe6ahFyO.bSeiX3vH
 4GrdIf5H0LukhUNxMHyiJf2I4nsBPaTAOvw4WA9DX4Z0l_j90XRkwuL4VcsHt_tiktXCJU66qfHB
 A_uX6JiSVYfzv.U0vkGGIVOUSo29cwMuU4qgPfRYq86VhQFVcL_BXuzcgEwJLfXcd.GSvx3oqFhz
 v2JvdYjDcO3s.J24dMG2a5MSmLDqj.n.WFoyXnwApt3x3KjTcji_QyKzqL.KiG_sDpE.iVYIkCNC
 JEudkdDCGCMFBj3cdnllSOMk4KbfLD.uB7Wb_Kbh8LICHg8HiT9H2_gJ67xhDFg92fFFufipw4Yo
 9jSsVsLTqFUbh2cFZXb2EPv4GnGYjc2Q6bCCbfkuk.XE8Y_BQyZNIyOq9dgWXBQ4hcCJEPjFAHHJ
 P6Bxat4CXcdJ9VNKd_uuOG0CLH7TbF1_c_k1HS8r9rGUYsJbQCY6M95GfBk_E.wRvO3TuaV76eOa
 m4tXb3nYV7ROlsyoF8ylcu0Xf0zYR_kHdzsLqDdtmPwPDJykDW60S4L0lKukS1.gb76ZypbHqpFe
 3ricSiwefBFqpZTvTy6r1AvlUtOLRYPXl2Ts5w09Pklf0YLnQPvqorgTu3TQc2PDi9f6c9F0wrEZ
 hKD9QW4e8SSvbhxtpmE5Z6O9qqYD6cbp4IFuedGj5URKNihlVpQNDsCPiga1x0uF5o9lY9e7xzUw
 qLHPueWnMt_BEPBMy_ZbX2pJEEpwL3SkAFui6bhn2.m3oaIu7g6FRRK2AGKlV5T7SAlNJ1t99xZn
 c9zORHyC2cMylUfXDK5l_7i6978dcV9uaV4Dk9nOby6CQxdgOG5ogklvJ1OcEkj.tlM5tMB4jNF8
 Bq96FmutQHkNCXAlv91w-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ir2.yahoo.com with HTTP; Sun, 7 Aug 2022 23:03:53 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-r76pr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 12b0bfa600682cb6edf92800aaf76d46;
          Sun, 07 Aug 2022 23:03:49 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v5 05/14] iio: magnetometer: yas530: Change data type of calibration coefficients
Date:   Mon,  8 Aug 2022 01:02:10 +0200
Message-Id: <9e95569cf94790b77d82dd29a230716717cef100.1659909060.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1659909060.git.jahau@rocketmail.com>
References: <cover.1659909060.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

