Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CCC564A28
	for <lists+linux-iio@lfdr.de>; Mon,  4 Jul 2022 00:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiGCWDP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Jul 2022 18:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiGCWDP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jul 2022 18:03:15 -0400
Received: from sonic314-20.consmr.mail.ir2.yahoo.com (sonic314-20.consmr.mail.ir2.yahoo.com [77.238.177.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADF460C7
        for <linux-iio@vger.kernel.org>; Sun,  3 Jul 2022 15:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1656885792; bh=RGArz7Zwo1YrpUAyYAm1grVSpdiCN8Oa/NeiK93F+nA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=E8rEHxxNPATRrPOhCb7TC/Ds7C1fI8MqX3LHhe+4Rcoh6bCIPtb/ILIfPztNp5mttb5PSG+Qw7w14I63hp2Hd1IBN0XVRfrlGitdC3sv+KdZD0lpAo23dDKJoTjmMN2ZIwMu+bytSgUxDWGVsCBXPHw39oth92nqa4C5p6f/P/5MRoUsV9O7gd/JBkJWHvzXtlzmgvwtNVwUwbR63ltsvbHlGFAQc0rJGghWGWW0zu0j2EMPpr4+j3C+K+TaaYK70o3megPKbnEWm3VcgsO/LOGCYsC2c76C9I4yHYgRe9jDY1PNhqD54BITUsKUInFsShl9mK0hd2rIU9+VWl/lcQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656885792; bh=ddrCvG9hXzO2nfSrDplf4wDuBnp22zvX5IqF/0PG6dT=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=WZce+XB9xNHAG2I8ox+IdKoSH9b8ZMgHbzxCd1lo1buEkmUDXDphcM2ma1PIA0xfz3aJ3P+73Pfcbyql4+lKXYhTobJHiwu1Kkraom9siTTf4wN0VnLTksq5kj0tdEUBCobyTOcHqCN5RsMF6fDnEpdfrX8qlekXe5InqdO8fCtrAjuCRehJzigQCTRAmJoxJqUfBw2ArtEo2YP4eq8MRy5l4Rpay0nRULySRv/TUB3FLdN8GgDWjoRM743MssGbxUqmT1vV3Ni88b0myrm2PhpveFwvQuOu7kj/P0sWXjM38B51u1ooQmffBvDscs0Ip95A/hQxw/kJ+utPZ37wSg==
X-YMail-OSG: iXGguFMVM1nOcucGXjiWKWpZSxDLiWJF3HzeAuW0sbyp.3HjxrmBtlyIbwbeOVh
 GX7oMZR65ioNCrspauxAAoFnRl.mbLN6a2Z_QMID1pj6C.YRQemT2fC0kP.6tRk_5XpTzu2Vbi8L
 rSrVfrtf9i8GGG2J85iTTqpMwe0mW.TEiNjejOjBwHMdQ3u5Ql0WSA2aMnBqp5ztie3g3Izz8XE7
 eA8aZ0_gieSf8EcNpLeuRrGJ3SAjIgLszlqt1Yo.eDaIdMjkN_aaQMauRmqEjxksC89ayYuJDs.x
 WCo2hlcY..SxlBLICsd8WSCZpJ71fA2yTyheCWJQeXQRVPPd.oMTN9WvfmR.AQCvL1_pifQ8xPIS
 T0MSKn.J8nmJG_z..ZINkR3XU0IrHK0TL3jvYOR64xlyI1ZX3zd0YgGQLPfyZsxYmg9xUfBWzYrb
 rmLyA2aLKHsyG5K5MxTiAgDaryY0b.vzUHZF4rUOrO7z8blpJymTrO7a5EIgfKNENBq_hon82Fwc
 fkDYcqdwsLO0hhlch8TSeHCqWVeC.R.qgusV6lfHwypSFjfgHFSakYTiCg.85Ct.NiYF4rao4gtC
 5._8Pjw8ZeA76VDwboeUhPkdSpQ8lWlBT5SqNagWMdWSXP0ofPhKGQs9R0IQHcgwsRflrDQ3L6va
 DZgY9nw4tmQrJuvEs3buBzUie2GUMseW6LVWrOKSVyFJoQ58AWYuqH5kJit7218HuEu3PHjt7JGm
 4CTaZ7dVVQ90_qti4jbeyI_WIfCjAReObALkPgmNEBhwRHG38wzsFuD00xwxx2QT0k5KLSogY0k2
 wKb_UrgS9OWLkKnI2nQ1yI.y.8NClNbrcBg4reZ1vrJEqlfpvciQimWKQsw3u.lfbdQZNDEcIdyR
 4zZEisLgzCI4PDmlaaoWjd7LUfZNI.f6_GCjRLvMw7Uob3luCFPhmTJy5NJYXPrn7ZcYsNdTl1d3
 Nhfj9oNkSrI.QsPZRXB4lxOQebnVeR5FPbnTChdWNxqUPBpC0wYpoH1eqnX8d3COjT7p9dteuDRN
 iztTiQVegMsF5rzarE3nEmiDToNhC1FPH9zpbo3uNjYYyU34xgzBSF9PNah1lUN7cHR7SEGbPexF
 Jhg2dLxpdoR_U3nWTL_.iWhRMPjYhuTIrDsRlJqXN1mQgJaNyszFaEjOOmOv1LPSRfU1_yeV0bod
 T7QlH.zVAmYbUE13wzFR76jxFne4vggzKOYsVacOFIrFX82npdxkNW6GJQJkC3F3lXKnSgzgYnGj
 pggLm6FDHGvi9m5xwwDc0IIj8sIU93skPJt6vUOFpeo3C2kBRfoQe0GI_hssoFMRpslsEE4zXbm6
 0qgMXnfXXXHSre.kdqlj7IMBIj7rXlBVz.aPulGR0_ItNEeMQhF7hWFI37yjCXd60CsZvblwnWcn
 5GzSMrYCkugBSNIAMvR_vHu0RFYhZcmTZ3G8Rl_dD8Sinww_S9c.fXh6qSwLEZkCaeJ2CrF.LY_8
 DXy91lXSjJQM2FI.R82dbtWU_6SaAWxaNRCsV5g6vNRPX6kQxgOetSLpEObODfO9ikP_tuByQ54A
 uM0JwnUMDSAWiSCMTdbpyU.UCFf5T6WnjhzX..zKTpDia4jJUTZktv3l0wcLyzCAkqRZDNKd8OWD
 Gj8DAdNCXqiuMFZn_b_caV2lCOOYnQD3aiBWUIsG6JEK.N6P1.sBA_7EE_t8TXFvxm5aqdAxTgXC
 uOKHuDpsPYZ33.ZetiFmS3cz6GFhxlak1uI9y7PN1Q4GGFI7krcOWlKkNFdAXv1DuBiZTjRZr7Cl
 Ykv8.vSkUEblQHlaPmoButrPDNPjBrP7eqYWIfeBX13tZFSy6xPTUtymOwKeQOzODRxEkKAu6u6P
 tygVl01x7gMv.3BinxsDutMioDaC4sEnjXnaBBBdC.TzzmLCyyKv_nInvdS1o.nUnH_UMyisSlpR
 rrG9jyfex9h4rOSv3ataiXO6VMZoIWcnhlshUIHy4c.b3wZyO4Nq7KMqox5Uag81XJuB0nvRc.wE
 xPaQOmFQHkuK_AjKRuwMSU5zlvv7Sg5or37ZQxS9oaRAMC0e4l8Agkttynjx6.ow6zr0TCtoqKtA
 yzS4LIPq56I.A5w.ZaiaKB0ei_cUHKrQE_Q1xNwapjfxJYfqhw90Ep3TpzmslUt32nnk02hbvAK0
 1BXOABLcY1HV_yyemWSwI2EUhxBZ28UG_XlkNadnlc23rLsBOt4Q_tW_yt2O8AADPjmm3DkL6K2Z
 fTXRWn99r9eVrFI1s8hAmVC_v1ZtjfwozpDay9KkLdkCtETQej6OtirQTmhIlkhIiQaWQFU872X8
 CwyXPFMafrsm6ivZ2
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ir2.yahoo.com with HTTP; Sun, 3 Jul 2022 22:03:12 +0000
Received: by hermes--canary-production-ir2-74b4d6d794-tv8mb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0849bd8970b52a790a5a1bb96f2e336c;
          Sun, 03 Jul 2022 22:03:06 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v4 01/10] iio: magnetometer: yas530: Change data type of hard_offsets to signed
Date:   Mon,  4 Jul 2022 00:02:35 +0200
Message-Id: <84be5d9fc769d6f90270e025872b771f2a4c86fc.1656883851.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1656883851.git.jahau@rocketmail.com>
References: <cover.1656883851.git.jahau@rocketmail.com>
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
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index b2bc637150bf..40192aa46b04 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -132,7 +132,7 @@ struct yas5xx {
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

