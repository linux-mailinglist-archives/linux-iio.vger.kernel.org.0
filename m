Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE63547D53
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jun 2022 03:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbiFMBSD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Jun 2022 21:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbiFMBSC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Jun 2022 21:18:02 -0400
Received: from sonic308-19.consmr.mail.ir2.yahoo.com (sonic308-19.consmr.mail.ir2.yahoo.com [77.238.178.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E6632073
        for <linux-iio@vger.kernel.org>; Sun, 12 Jun 2022 18:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1655083080; bh=vXPdlzdIaQCvOW0mwdLK86CDLNZEeTOqD4lxgFzvo2k=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=jkBiBSFkkVbh7a6pvGLURcMNECNzbWcSj6rhGB0VecFU/Mir5F/avfqaXReq0LH6UjHl42f9ybeY3DGErk7KrWVbNtw64O9GnXhowksZl0UIiACTbsFzm3oRJW2A3rg5oSgowcsZPKAfK0JNtwad7hBKhlC5SpRB/RTV7azMCx51uhRSWtQ5iA/oE/X81W/DbK+dLpn0X/4woSdwSgy7sL6g3sQ/nMDByGEvammWKET7TpHtRYpgpZhXHioM0yd4xkBEJ1r60B4KahCDb9zxkg37qOYgf5YPW0vbgtYm/7xmbY+vou4UZCGqHVBwHPb9AaMKluntuWvExpMp9RzA3g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655083080; bh=H7wGRTRLNiUVfezm++Fhb9TbKtGC1/8Xw4NX3ydhg4M=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=bHyFO6llCZPV7roUiLE976m3qFDBoi271qPOh8CYrNmwTqtx8lHP6mrfOMuF6AhT+L8aCPnDD0TfPCoQG+AuRACr4rbADRb0wun8eVH6/pJY8rQ8aZi7hASR6GCZdRJkEa4rvsDBwogy0/AMnDVaz7pUNYy8lb2TvUI7qaf/HXVB+CnpHTqkFCyBDiA6Si+bY+Jwul8NIvf1JVsP+6qrMm8BTbqKq6KvHEARAwCY5+dcKPUIVnGtFCXEokuyUYZWdRDQBe7Bj9vM+rQmZ4Vz55IBzdycRLn81u4FuM8rXUAbMrTSnm4BzRjY5f5PMWwoXDXo9w2nSWpZP1oOWBdmyw==
X-YMail-OSG: dF7JMQ0VM1k677I_scA4Bm7EGuB0raNH3k1k3tSx0KstpA6ojUnSgpWW0Pv7hv3
 vEa0C.5aC.YZRatyzD.zanyjBC3wC7k8UrSJVxDpKQkb1_a.gOsbQdQxzP42JyrXv1cAciDq1G5N
 1Z2_rwDIBGsQVd_VF3rTDL72hqrQWA8WNs.TCpttNyDLCTpKndkgCE9iT7m3AZLCAZBIzN5NhunT
 dXkasKdXUmeFDCdCYj233cO5.hWUZNZiAucHq2TqQBhYVfTm1SJK8yA9oUAtReDJUtw55ma.Zsld
 5a3KFe8UZjA6Yf7GBhR2teWhbmY.a5i7a_y4wtMfRoP2oekPXKLmswxdA6Qc0ZprkmnoZhVotopD
 pIUzJbElZlCyRys5qnBWzJmSjdDP4o0cvhN3KRRxaTHbBxaaOqq9WY9rkwtConImxXYxfAJgq0Di
 t7fxrUdQCVL.5K5gXBlCwdVZKee5cT.D6iQ8WBYrrWYp8MJyQ4Rqk2gV.yoMoYfYC0PMQJwqxO.s
 dwXHSlUpR25XInn8neF7iRBurnkdrIoUAWgJPAs.L7tz.4Mz.g2apXRvSYmLhZFFGTzM.vXAS4x2
 Ta_d6CU1OXGQpBb2SSekLuf8df.M7nccRNeQ1zu4cwEeoWUd8tZwO8YqOR73CwgZw8mjiNl6SZLI
 vBYENxPHgAnT7rzuhBmSH_IvY.GiF2N5E5UDjMxgv7gNAgVXsKlTWc4zjaQ.o6cvbkkPttzOG7p0
 Wb.nT0E7tZ4I_GcgdHLc8VfXROVBCkHGFrLY8WmDnNczDdy2MTh6jTeAhPWvf5ubC.rmxZcANDGc
 1_fdVIqpox3gHRyyNG85O4VVqK9R0sQT_wAF.EUtL2YtGuLIMK8ez5HlNeSSiTJM.D2ceG0sTWYu
 d1L3V2raRHIQ1Z47RxcrBmsaR2yMOXGPXf2260hiQsyHHFyvrRy50TxOHI2DcI.LAvn2Qq.JAsP.
 NB8MEGYFQSuKx27a4A2b30CqkMawlQZ0A8uL27M11y3k89mdCGjPxO4gQyp92p.NuS9SkITrnTK7
 lIikUPxzHajvu1zEpL7AxRu5BENBOMf1azbynQzfbNmwFc_jp7bO_LpVVJKWPg55UGKCdvq9OGhj
 7pT6E1PMmyyGhG4MEQPmx1GLPhURhKpJsht7s3_Rf7GrxVN4Lu.1bKlfhEddwbAy8Duoora8QMUb
 P6REILD4JszhjENFQHN.KNYKr0gXy6KovIguMQcd3BJMexjPHHu28CiSuOXKHxPw3kPOoBuEsx7W
 iauFRpj8FKey7yMxoGNmQfH043.IcHqQMltBQPkWcA5FeTDPurVlLfuY0p50hi52HmZkO12YuEfK
 ZgToU.m1JEPiiYpot1TfubqBklujgkhroe.IlJl0mQLk0eU3vzuX.71gbDh37jAcI8t9NGHo2V8w
 mgHD99snKLYP00oBR2Em22BDEmIJ5YZe1nIpCTEWkARwn4xGgOELPAP5.TjCKm1xs8gupb.rBvcp
 88hpraFY3Bp9HQjFB7SwLaCt4XgBkjLg4J0ErD22LZH.mTFR95uWTMQbGNRyDfC.SZ1tiLcZNDhb
 UpPmjAkPrOcyERbC9vidy_4cmpBLgFTWjURhLVxvpX89.VthISo4HyZJveOSsgJZcB.U83.HeSmn
 X7fosGnKTc9iu8oz6v3ay0k5oGHeXpHr58wuGLgvX6__fV0uRj.FoEB4st9VMtQm59Uy6hJVuEzY
 IDoaMGuzOF6y93ihzDefVzj8shqwySSBAcp_r84GEQrYtDWgmYfi6dSjAylODkKpvai_3rKDmhmb
 7gextgJprTkAMVY29V42voBKXzAGf5LA1feGbOMR1b5pchXgF7_3STHbw4d34kbbj3DGgNGhOeq4
 HfgpDZ7NtVy5BqWVv6Yg0v01bW60ujVduuyVR0PUa6opSZXkEkKMJiVnDcFusKH6ekahq3QPHaKK
 WCS_cf2QH4Jtt27AX_T_cxEwBjQOc.4QrljLBu3CBkXRvyjmDWA4OKY3kY8Q5kh8-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Mon, 13 Jun 2022 01:18:00 +0000
Received: by hermes--canary-production-ir2-6c7595c778-c54g9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4419c1e75f73c3038b6a16962b132f56;
          Mon, 13 Jun 2022 01:17:55 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v2 5/7] iio: magnetometer: yas530: Change data type of calibration coefficients
Date:   Mon, 13 Jun 2022 03:17:12 +0200
Message-Id: <075d71215ac12279f6c9a9ed792a9c482ce7884b.1655081082.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655081082.git.jahau@rocketmail.com>
References: <cover.1655081082.git.jahau@rocketmail.com>
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
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
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

