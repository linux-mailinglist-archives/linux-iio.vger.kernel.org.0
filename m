Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0EAB543FF1
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jun 2022 01:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbiFHXjM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Jun 2022 19:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbiFHXix (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jun 2022 19:38:53 -0400
Received: from sonic314-20.consmr.mail.ir2.yahoo.com (sonic314-20.consmr.mail.ir2.yahoo.com [77.238.177.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8903736B67
        for <linux-iio@vger.kernel.org>; Wed,  8 Jun 2022 16:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1654731526; bh=Q+ULoWft3rEVWCRwk+DgaTR0NPWVTGyYbvzo5viv2T4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=E4DVQSDLWBeH3fGZBQ1bzIJVhThYXmlwZh4xtYmPfQNWdUCJqAEzrp4J8hXTFDzpd1YUwHVgpAdfvk21OCUb7h3JwS2cMvTvE13/rnCNhgB3QInRk0QLoDuHZzKA5e4XJmRNceeU/0r0+xt5bZkJIEotGevACjxY2rDTq4AqDUqlUC6vM3uVf5uVcYPyzvvJcs4+HLuVn3UHZnABSSB7maxGxKIchDoGeQaw62Nm176hGKbCdusqlODb8MWNepTLEBbpNxrdGWFXfehhZPwEus62nrB0zyI68gfGtxWLUxhvoVoNmCsAcMEiel9OEn6Z6EvQtZRK9/1/kgvBqk6csg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654731526; bh=os3ohYQG9WkqzVxynjnr43Sea0LLHSt4+3HdxubbvEt=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=CgDV2MX4sRZXGHk5s02ZtTgqisRCuhiLgozMowzoSA/BoiM3xvPAfUBFsazRoX34XFVVjpAz2aPpN+xFW5+QxtTHfzVlZhsu7/pyq5ozchfmuJYqDlhD/2H2AN0K9qNDj1eEmNkqC6XAP4giTu03lQEq73Fv7KOIgKYzEkKkhX0BDCZRs5Dka+gmE5JCB8I+DgXiJ58m2kRhl3AyeP/cooH4OayxPHf6fPc76PbEP9pDrb0Iufof4/iPOoX3IDK7RxFns/p/6CCnyagK4IKy2XswCXRPEYV/WAUjMca+huSrOzVIaPI3sextllfNOKboG/DN36Fv+Tl/jjPrPlcadA==
X-YMail-OSG: 89npXmIVM1lGsRHTrNXlgiE6f7ZTwKAhfikqhzlkoC5WpR2w9y2pQySk_oZnXe.
 61kW6NN0q.Okd35nJq89ky4LLIXJTI4t456EBcbFewsIkkBlwA3GH4qP21CtDGtgLDfg2APJZ5TB
 .7D.CcneR3q.Uc_VM9V93iZFyo3h5062vJ.4HqHQLxx43YmhD_gXGIQceGv0vbAbs9EYmRTUm9dV
 u_zwy9S_TILC_IOgfC6qkQIsYxa.WJDaUDA0hxlRMCw88YQpVYz6MH6RlJP83pWDzCYHvHqubfJA
 CFgQGHgiYgjyh32zkzbBG255P7ZnTF_IzQpF.v._LyRiIygF.L4h9IWw_j6rshij61.nYn8WAHH7
 kJ9gBXVDxqcHZZdk8ea24V4c4u01rtPa8edOpj2mSEiJpsm6gqsSqC_u7I_I8A1_T4iVemF.NUpq
 NlW4cTKCQH.BIFb0LinUUkMpOo5v1oCNWdiXXpZjZaK.ZIfF29m_ZNBykq2vKaeXrNBP.XJXQp_Y
 SaWfXwODXGU3ZLwPXuz22bJVYZfnUbjXEXrdnwS.FhhVj73X9ZLV27BX3DGjhOY7e.igbZSIufsg
 CYGl8v6GqUP5SXeQfb_r6BN0NTgz8tu_SolN5D6sgUNtVnGfiqM3yiDc2TPrSBd5AAiPacD350Ug
 xQLIDbGOJVmRIK54sAeZi4kYHxlPi.z4Cu_oTeo8TyGjaZqtPjr79IcpPRDQblcPwdJfA9HDOMQK
 LUvF2EJnmBao9fQTDDi0vK5TCZtPGxeWhcJUeAxX9irKm6WtvGVEoTIwZkMp14_IAmZ1OBLkXyjQ
 7kLcfK59mKwmXSoS5Iu_lmLQYJzJ30WuhoS748gj2sPdcwKO6jfhcPSipVdXKDRPoaSUF_RnQpwP
 SgEqb48dG1tn2SHlw29uiuUPwtSMZfXDCI7Ckli4vxra7ln9vSpE76711OOl0Q_hcPvXIpfEf5dA
 3Peb_EChWd_lQoiVLGichoZV0hiUbM.Id6rzinpwJAt1pTUhnvBR0jcDY5cZS1U12xvRTAHu0FOy
 plTDBtccRuncsFyJ6YLtZK5jvGKlXt_A.y9gz4.276musQdZdpCINQaqx4y6fJJg3at0nCaH3WED
 6lISWlxHGB8Bg9AKc5KecXi.ephm20OXxQxKAuZRmt8PgNs9l4tqIjk91frZaiIPv.pqkjKRcBEo
 P3UVp5bnHktLKF_OmP550Xoafq2cCOhQ5amd9lUHb8F1X3Q12ReQu14a0qKHqdF2rsUZsFDmi2vA
 HDxruGKr2IVkglTsy3RWjYdp.buJuSAhbNN0OxE_ZlG7WaHsA0Wo42b0J5E77sB6cDrdz7pMqyid
 o_OtAPX_3y8.ze3b2cplr39t0gxQ_JY0NMgtIhV_zuKhCtKklzHstZ9DUfoSVe5qlph4TwSdUlzs
 3Cn2qtJdKRuLujNLHggCXE1ioSjk8XKnit_Orn.jHOHt8gi1Ngws08ycXT1zTSKEZBNVigHLU5wN
 49jEb7PmCLMR_5vDH9VE8ohEyJqvBXGdgV_5w4j968rZ4JZ_syZVNtNBiA9KOLJoEMRy1yE9CAzO
 YDgfTPrrKq7ZcO1UPz8y0mxKEBD9Vrl4U95ezAqI.uxegKsSCTSs6I9Taz3PxNtiVeRsmL6hoqYd
 s.SkieetSKuwgpwHqg4GL_1U5PqEKoYi2rbdYF8e5VBxPFn4t9P_d3CsoG8IxWgvSAmvNt1jrOVC
 sduMY4N3tgHsJDVqHyY8SAufVHCI9TC_CusezcpvPbPzsAzlKA246KQZn_BuCSmBXF.HtCqq9uoj
 I6pgoVXPd.bYaTXwZpR7JJmmzaertONq5RQzM1SJUzD7DIiAn6hi40BJzFC4jfDciuLzdBWMAWdA
 Djm.CrO3ZZmpaVm2LvYiq.p_eMCOstY2P5Taaff3QOaAybgmJKOiQ2B.g8AIiQgw9Vw1_kH8Bf0Y
 PegjjjcOop2t2c.K0KLSUKndYyBh8INBxF3m36lGZz1XKDCtba77HZbeer.oqxmuw7yjlyVBlnil
 L9ENlr9sxdR_Qmuk1s_0M44xHgyd.g.oF1Tkxsynp09GYLZKcOCKF636BubsKGkLLEcYOQH6Y8sj
 9U0zwMNMY_93MLZh597VzE_2tReIGnPPI98JgP.dEFzTjJiND__D3hHSqjs8aIexg8MdWPnNH0Ab
 FGv6mo533aXdMwTZyELaWu7NErT62CoEZ1bfcZuj88dXCZNIDO7wYctUKfT994WsOqdolvFZUh7M
 qQCWF2Oc1YW6iyDlBSY2QOJ7lIEBuMLhaI8gUXBZoE3wqmZSdOCtKeyENutQ86xxFoGAw7jm1rHg
 LOQtRcPfPSKWLbNI-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ir2.yahoo.com with HTTP; Wed, 8 Jun 2022 23:38:46 +0000
Received: by hermes--canary-production-ir2-6c7595c778-tcd7b (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f9021a74071b88f5034921531ba09f62;
          Wed, 08 Jun 2022 23:38:40 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH 2/7] iio: magnetometer: yas530: Correct scaling of magnetic axes
Date:   Thu,  9 Jun 2022 01:38:01 +0200
Message-Id: <b7203b1bd378fc554fc2cdd435176d597272cd89.1654727058.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1654727058.git.jahau@rocketmail.com>
References: <cover.1654727058.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Looks like YAS530 raw values return picotesla and YAS532 nanotesla. Adapt
comments and scaling.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 28 +++++++++++++++---------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 425281401324..5c7d0ac533ac 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -310,8 +310,6 @@ static s32 yas5xx_linearize(struct yas5xx *yas5xx, u16 val, int axis)
  * @yo: Y axis out
  * @zo: Z axis out
  * @return: 0 on success or error code
- *
- * Returned values are in nanotesla according to some code.
  */
 static int yas5xx_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo, s32 *zo)
 {
@@ -417,14 +415,24 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
 			*val = 1;
 			return IIO_VAL_INT;
 		}
-		/*
-		 * The axis values are in nanotesla according to the vendor
-		 * drivers, but is clearly in microtesla according to
-		 * experiments. Since 1 uT = 0.01 Gauss, we need to divide
-		 * by 100000000 (10^8) to get to Gauss from the raw value.
-		 */
-		*val = 1;
-		*val2 = 100000000;
+		switch (yas5xx->devid) {
+		case YAS530_DEVICE_ID:
+			/*
+			 * Raw values of YAS530 are in picotesla. Devide by
+			 * 100000000 (10^8) to get Gauss.
+			 */
+			*val = 1;
+			*val2 = 100000000;
+			break;
+		case YAS532_DEVICE_ID:
+			/*
+			 * Raw values of YAS532 are in nanotesla. Devide by
+			 * 100000 (10^5) to get Gauss.
+			 */
+			*val = 1;
+			*val2 = 100000;
+			break;
+		}
 		return IIO_VAL_FRACTIONAL;
 	default:
 		/* Unknown request */
-- 
2.35.1

