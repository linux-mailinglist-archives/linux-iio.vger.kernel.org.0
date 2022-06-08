Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C406543FF3
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jun 2022 01:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiFHXjz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Jun 2022 19:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbiFHXjP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jun 2022 19:39:15 -0400
Received: from sonic312-26.consmr.mail.ir2.yahoo.com (sonic312-26.consmr.mail.ir2.yahoo.com [77.238.178.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E49163F51
        for <linux-iio@vger.kernel.org>; Wed,  8 Jun 2022 16:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1654731536; bh=zztxOSarD2exUNokXxxFH/AA5YBq9ZClXIUs3CFOvOc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=j4sVWHxoUaHpOCmhfE5kaXBYI/O/5LcFw8HQmLfki918PTpj1At1G2RzOpai+FHFBQuFlpKcGmef2kCFROqzcdpKX64C0n/b3T0KFqU8XKVmssM1SK/R4Jbri7rvfAAFVMlwKyTS+88gDbuE8cgVYK1ikMtN8j6/QqKD8/NHAamQ7r+E3pRV9b3trkWrJJunFZTGN7yDZfKjORJeJvMshVy0hBp739uVUqMANrnFRt2+s172xgCl31oYjH1OP8hEdTRtugW64GJYr1C7q2wEX1Ni8VGZXHbe5tLNBdL0qK40iq8Un+3CvuraasGEkxb5Zo6JQiYkOb+dVUSfuTIzyw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654731536; bh=7QYLiBGWSt9BYDbFDZTQLNRMwiLO4cVvby/QfW13X4h=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=iM8sE4yr2Y2ZAZHEav7q7lS31Xf09vlJplo4jECrfRUKtfNy8XF6Yb8SVxlDENK1kUGwSnJvNOU1acHZBehdgsxpTd1yFnzWI2xaSgKm2fbB0FSwIV2TvCjSgaBYv5t9NDWGdRH02REgOp20hFJRHVr6XwBJbt0Vkusec9IEZHhvxLVrYaStHvdc3NJkbJQg8PiMtlHRkylyERqvaGek9EWkkIC/Q/ENqSnnBPd6L+mYoxzSmLNu3v43/gwDaZFgVt/Zjxbgcqn2qP1RYQiUMJe8/77sm84xOo3POG6PhfNSGddlWFAgj/e2MD0llrOYOTxd3q8hq3TL6O2ozBfYJw==
X-YMail-OSG: CZiVGrkVM1l6Mjfc59VXg8O2l955fgAqpShz1kGWed6dE1edZBf_u1d65UnscE4
 uUb7nj27yRudgoQvSCHVU2cY1CPtYrHrOlKch4OOvxewenxzBTSOpE7G6kZi9jzlK20QO7SF.wSv
 V3mH2n6SPViiR5inKT4rEBvGvnmDOAOQ5__3MysSBYsouXZhHaSbYLU2Af0ejpQtSqu9dX4Rbmc5
 2w06GfWXphZBThzpLWNiIqvw6K3htHohzatMhvpOB6JIqBIwyyGKamd9C_55XYh_Zod_L.DS_mN9
 WeqG2Wf74oO_.hPynBvGYelD8GYoMdbe5YUiXnK9DOWXags5zJcG9eazsDvmyk2nhi__VEmsagvO
 hzpwB7FsmbhJqnToIHdX__XfjydUkQHNadY1DLlHCWBiNGQXcpeq2WTO2eAYX1IHq5_jIRKquaWo
 zHuTTOAVbmcK1VwYsgHJIDkIlbFEICN9MHOsFvHX.Ee47LOT8P7o92mN4nJlfxYDu.wTMl0JB6Q2
 E5hA6cmW.iVQV5M0TeiXJzQRu2GCpzduJw7Yjrp.jTPJyDjocJxD1OQx2uWQnGS72xvDhlWYYTvl
 lsYPLECApeXggGcZ_C2U3.Bdec9_q0BmYaA9QheMnSJ9qOBHJ1FauP8SCKBFsX_5rQF.fpWV7TaN
 p.T6ujLkTRNCoT5PHToT6olvw_ks.zaL7UKyChPvWHvGEBMs0LyaTk_3fmNSuYMtdHpPDx2jbt2k
 a8dCTf9VdCR8qKkCAq5MnFGPJjkN3QDnbmErSqaHWq__tDLDquDIs1zNTZqqfzuwIeksPUnFymQ0
 tRxsxuZWa0Kza8SHcMhD16J8R1LiEjHjCzbftCh4wCVY7Nau1wqXY1MODwMf7gp.I3nbmDdyNO0Q
 bXeegjVED_f6nFwo9ES1T4CA1qWs1kqWwD4rFC9_rSCCXfwLHYWU1z6LYgPMciZ13B9vLU99owVs
 .trqUrhw0vilnOSVJqBE7_5E_81XaJJ8tykNwkRoy.9ZHEuwHnAQjFxdndMIGkPwfxHt4Hjx7XpB
 GKMtV5Om8nRcwkL5TIcQej0J9RmqsnaF5pZ7DsrI5EvMUHe6CJmqLnDMLTppvMekKWOM6dglFMmc
 0UHLlVZ9vlZw3XArJPgrswAXPUOIrnhihYCgiz8WidG4V_thzxRdB8hPIzJtDGOdG6HsM4xWi2Pi
 .SGO7TmGMYIRDSCcVGP8uH02fDPJGJYolNgIfsowr3E84MuK5.D6zuHQIAUNIseUULNj4Qcbgi.I
 w71lai3iUVLp6DEpx3PEI4mgf.pukFQI6Bk0ooLoaimBj5azlXiEut_w_ElOqUli2iEyN38zJV6t
 kAa5YwZpWln5kZv7qljl94dnENmM86i1INArQbB6CDrR4OyUocUVPz8z7_knS6m6ToUy_Q.aQT2n
 uByzYAlbI0HvTLbseXWLs9QRWdGpfIeI3yaJGbPGIR_CY_CVqAxTqc629eTJ__YnuZQKkUwBBUFB
 NJ6xFLUFypK4fF.1loRJHbV3AZ8ZMc8nMrA3ZKL8jAbn_9Xfgc2O4os2Ejw0cZl2igTKFhP9.dmt
 KulygGi1bCOvckLhshwPiwUVDYFXTej2VT3hKlhjkCPeJWEZJMTc0.K2LaDdoa19D4uUFpEHVHCs
 JVdpbPLGQlGONihIZfAIVzlgq5wTt7.hLh2YAqMMLlVbWoLMEuYts3spx6wBbMMWZ82GNxHUQXT8
 tw_CMrxoiUl2G0NofQxmyhUOx4q939tTYY0wn42w6k4YKBTTxATr3oK4s4zANrmVqCPs9FOgebOe
 fIHeZLueLIMJx_xJvSIw5I1hlW6vVjNgAOY9oFwJVGRCXXubMHAh7QtPQL5U5ql_ZdTliE2UWHuq
 Ndoh8_8MfSMSN8ilVZYpRN982oTnjpFM1mQo3dOgVtoZ8120WTx6BKiNjzRFyBixjIizKbQKdT64
 Br8sdePFFdQQTjpzPMeABz70zt4ymD8vXRonv_15MvhVUvUvIHzoY8JR..SQ4UfPEbQezo4TTOaU
 nj6QNLSunAuVLWTynseq7WvI3.P346ghU_ZBChcPkW4pxsyXMLKLUv0Cb.TCm7dz_B01BYS3MEEM
 Cgpyu7d5kXuWCdiNMbx4FsIyPdWYW6BfW2li.AUeETNLvsFkMHzJoAVh_vizU28FqpO0I8NSyhvY
 Z_ECjuk9ZHk5uJpVU5EkY1oX801D36eA9B8sVfX3N4XCxBB6XaC7FKwbyv_Uj37Qe.zvyfslBmEB
 ljT1L76xqbswm5cFBV30GO82CLRl5GC_pjbYBr8Dxt1.sC.HZJaZiioPQ.g33oC0RAknISILC2Cl
 C9S2dK84_FibBI_rp
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Wed, 8 Jun 2022 23:38:56 +0000
Received: by hermes--canary-production-ir2-6c7595c778-tcd7b (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f9021a74071b88f5034921531ba09f62;
          Wed, 08 Jun 2022 23:38:55 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH 4/7] iio: magnetometer: yas530: Change data type of hard_offsets to signed
Date:   Thu,  9 Jun 2022 01:38:03 +0200
Message-Id: <1b6e152e1dda138c68ea8c207e46f91337989d35.1654727058.git.jahau@rocketmail.com>
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

The "hard_offsets" are currently unsigned u8 but they should be signed as they
can get negative. They are signed in function yas5xx_meaure_offsets() and in the
Yamaha drivers [1][2].

[1] https://github.com/NovaFusion/android_kernel_samsung_golden/blob/cm-12.1/drivers/sensor/compass/yas.h#L156
[2] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas532.c#L91

Fixes: de8860b1ed47 ("iio: magnetometer: Add driver for Yamaha YAS530")
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 2e8d20b05217..9bfb3b573907 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -133,7 +133,7 @@ struct yas5xx {
 	unsigned int version;
 	char name[16];
 	struct yas5xx_calibration calibration;
-	u8 hard_offsets[3];
+	s8 hard_offsets[3];
 	struct iio_mount_matrix orientation;
 	struct regmap *map;
 	struct regulator_bulk_data regs[2];
-- 
2.35.1

