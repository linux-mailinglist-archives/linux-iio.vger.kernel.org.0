Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD02550127
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jun 2022 02:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356130AbiFRAPJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jun 2022 20:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236835AbiFRAPI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jun 2022 20:15:08 -0400
Received: from sonic302-21.consmr.mail.ir2.yahoo.com (sonic302-21.consmr.mail.ir2.yahoo.com [87.248.110.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F94E1ADB8
        for <linux-iio@vger.kernel.org>; Fri, 17 Jun 2022 17:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1655511305; bh=s8wR7NVG2hJ7U7KQaWy5POGWhS7BSCCGW2GyzhwYZk4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=jU3cNvkxptia1+tDmB3Wlo0JtPEWo4Kbchs7m5dXYGIf8RqNNVsYkWb8tAwBJYXiyporta8cGCY/Hlq1h/PiyEZmACmSM3WpJNBsocmifzfMrPgRh9qidEYniA4HrzzXOMM0vEMryix+KvRPnBZOZ5J5GbLEyLwhcuqH7eAXdGf/mlv2rDB1AWCdEHpCCiKu9d8ZvwXsovSAhOwovE8YYEC36nyblpHBs5w4AqabPYDDs2psw/mVgKmJFPuXcjnnq64FR1Z3SA5jRLQv99yL8ao29XUXeb3mrjjG0EotnzUNBfrLbuFIut+Eg8lxgoed28+hfa3oo90mso8zrdRT8w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655511305; bh=2iMU1ioS0GdtdzoOvcpgWqeuVJr6nGFM1/bBI928qir=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=QWWO1NxsOvczzEpNVluQHMiFQasqIocMqqL9NVyKKaqgmRWnvGgNIS6Wvys7INnF2PwPCNBoCkQcqD2lR55qUbr2VmK5NGiX2gPJofgICYXoC0AAPQnfFODCvRkt0jNuOsOVI7C+4A3XS9/f0R5Uxc9AT7OI4AZG5z2poyA8zRKKCUYq8H4l8r/KJqQ5ahAnm0+8Te6XP1MYJP0E0x5YbG5mfeVdTIajTDEbvrvWUfe6AZ7cxKCtv+XQ2g0kMQ0JAdqk7P0gp1uyQVuxFQT1ANIzi0K4vPXjcDcW/Xj8vuDIOKpgzZ5XRJaDnmUrD3WzCCF1hRGmDV1aOx/Fq5gSDw==
X-YMail-OSG: wJm6j0AVM1mge577QDo0bXNs2bHUXzTNlH7.mVl0ilJonwBp.1PDL5h9m3SFM2R
 Z1lP9yqLJElDulBvJVVjRVTv5_GD4SjbsgpMrDr6cyiH0LMHtmX5Rbd59Gusx9qo5Zobg8mf4eiU
 Xm9tYhhv4eAMWauhJQeFoYXuDW78hEOp1rq7DN6bOvUvnyoOGbuZa6GRxn4V2t5NBxJfZry4DuU1
 V.TFJhsvbqLrHOqVDj4u_JBAkF966llTFxA5uLYy8kSh85TNa2cwibRn_JsCi5ta1Jz.0lt8w..x
 iIa.c_qSg9M0NPx9WBDmwU8IVxOWiHaORV6qJjppmH1x9j9EQ4fa4DjRxlLJk2BY.a83LGOOZf5D
 VbXtE_7qs5.UXhhbcori.pay8kcA6.gmVaKNTJkiQ7IMVgSXtC2fH7eAqFWbGN832FieatASkLBX
 LDSAv3pa1AMieeH7nBpBlvwNZsGSMYjkko6A5ma628U2rS22gN8Qe2TvEsUAIRSuyUuwdNiOmXg8
 tHxEkrSjseEnTZdorP63FpHcRzGMi6WnkUN5DqNqsFuhwy3EaFzPrYRMaCbG7EQ63mssTZ2VypTw
 ZCXZgdvALq3AWP8q3eYIHODMcN_T9xbapkvhTx3qUlvsWRFJjBpVz6a_buQvHBLuC8lsYIkE84DY
 i9H.G7ovmApkyZq.huwP3CCyBflRrKhRx.uvTlV4eVyykxjstk5ZRLnFapD1JTseQpIPEEO7VM1o
 Duhl4OCVqcIYBognTeSfdTkLZPl9FOc.9iTkVyV4GsZ.ycIxZ0bEC9sMvtGF8y7fAjy54dLF_ciU
 fuNuN4tR4uqmtD3DhYNYxmg9qXyC1znjNttlA.srqZr4APPf0HeSStboCHTPFl6z.slxD9ka8qyA
 x_B6QO_0vY9mz460jDlmX2Ivj7lWNj7YIrg9o6Hn1qZfp5Rry1c2WrMaAAjPVahlEsKWum6GKL69
 Datj.4Lc7MO8UJ_bBqzowHVXsnk_jcF3T8eKovfBrbHpSor4XXxwRe5gkleZZt9Y6ZkCYq_qWfsb
 IjzuoQWXEES1rTlesOCU_HIkDQNbhDt0O569aBU2Y4LaDcaW8D4Fa88y7LImKrTh0LY3Lq_eRmip
 oJcaFCvyE2RnHDTIrtpP2_SrJyeJjt06oTvotdYa4O4QYVKq6U8k45EVYA6B5_FehOHo5po8yH4Z
 V37TuIQUcfRj6VZNl8KrNyOd1oN2kKMuK5NFmp89V8xBn3bEjtQR0bobSTiuOsRI723JJ.6jd8z3
 .LxT.770erOjG06HVzRc6MrgxtrNVFMBBDQo8EKMEyKZveOUI6ybjfMiRMK_He1kDrE_16AVqlun
 MrT.NzR0b0AsVCm9KGR490hEhhIJWutMNp4thPQuj6Ku3VsSyRSmgNwEC6DrYRvVfymspU1FXG.c
 Nfu_gGLe9oioCTow9YNj6_Qn.nWaGNgvmoYg1G614.8J.yvwgXe6qewkCzxk4kGEdHSKOMbkz4z3
 pYMhHJt1x2Y8ggK76y9MpPsa52CU8LslLvbwnJgswy8fcKmhvyz7QuoPgJY8E._CebrTVoKXKm4v
 Mf43M6WjdiHzi2jtyTOdfG2DRvvzgSYDkXx2aOft5SQN6sXQ2TJv3fOOGFKiH_4Hh.Q5F3zij5HE
 nddjeTrFbVbr1AgXfnC6pwxz6jyIFEcOhgrTpqwo1bnEbyyyFVwfjr1Eesce0pSK_Y1OsUFPCYBm
 VBUFv7in8E9g8xIu_N4AgHvyIL2KUpMsxdKm2IVPv2Du_A86B32x0VExUxWS6znU1YVq2OSdBxp2
 tIhsayHY1xOy8jWVW.UFqLcSUby8zRJ2YD5hUO8bVsDMPjbtSBAD.smC5GvlbOf8E2hVHvMQ.zxZ
 bYpsOnVvqixXsXNn9T6btdkumLQWT6jPiJSxpcWApyL44BRL.xYQv09._uPvpjO1H_nNzIzwRdFj
 iEjAGXSMxjrnqIlP08.FkDzIEUlOubABOO8hXF_YmbFeUKMpcPHZknqdLT9QAwzdz9HH0HinOqeA
 i_FXmqJ9DbPrUkiCVO0upbFAN8NDLeT3hO_25G9F_7fDAc.7JmZkwMwzFn3EyV_yLOoULs1kB5mw
 SPSKGs0.EFucpIvmZ198cPGqnexdR2cJfMuC8rXl9eRerNOlJnCN9JbF_FBoAqxwSilU_UuZj_2H
 IPUJ3d2c8lxqj2jSQMid_fmoDs2DIu0VvcourHJFOD4.iHwYFP5wHQbKT3aFALzyj5nG5BCldXHA
 5HJ.k4qwHkWNhfhE8qJgsKBEIabZ9CA8vmyjJiWSVAOSnBldZt437S6zAhT62laBoX6m9eBfbjHh
 gvGLscYSu.zK.A.Ql
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Sat, 18 Jun 2022 00:15:05 +0000
Received: by hermes--canary-production-ir2-c9bf9d9bc-74fwm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8b08f14069c990c2ed22165f3e3da032;
          Sat, 18 Jun 2022 00:15:01 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v3 5/8] iio: magnetometer: yas530: Change data type of calibration coefficients
Date:   Sat, 18 Jun 2022 02:13:13 +0200
Message-Id: <18f223776f6942d52af2e41dd10160e220a23311.1655509425.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655509425.git.jahau@rocketmail.com>
References: <cover.1655509425.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 9b45a550f31e..c6f5f25793c4 100644
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

