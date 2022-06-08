Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9755F543FF2
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jun 2022 01:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiFHXjN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Jun 2022 19:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbiFHXi4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jun 2022 19:38:56 -0400
Received: from sonic311-32.consmr.mail.ir2.yahoo.com (sonic311-32.consmr.mail.ir2.yahoo.com [77.238.176.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666AE15EA7D
        for <linux-iio@vger.kernel.org>; Wed,  8 Jun 2022 16:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1654731530; bh=dXTxOcGNDsNXmiQewwOib+VIGQVgNUbzL3mpuChYt5Y=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=d8/D4VSotil6ICNZ6nlRva9C9yyBpMwxCFpExbNxuxHziM6bE/DWXFZwXlGtYDPJlEDnUIshP9XO9QQul9/UK6yxwdXIwFuD1NTYgPOHoNdcDrOkI4q8qdYAcsOS0A2EjdnuMPFCfTjRAfJFtiEpPk67fETVO2lD8+HXycgF28KLDoN1woKTnzNzx1N2Mn6xlPHQ+oo49hzH9jKzx0vYjqldKaYfo4aIUZV1hoxxc8O6jcHaQj2L95j86z1N9QNX/5LOAmCDFtqdKC6Tb31CCL2poz1VPI7dKuAW59PWWirCaLDhXnbX/DZeR7FtzF0wC/7Nlkth0YVEMS91VedMQA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654731530; bh=1R1LGZ6Wf1/XtMVD6mzd10F14Tup57XPygO/FpIyGnT=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=h89e6JGSNauEVHlg7/JdxkwU7JLUJ5wXlwya9EvXnP21Vb6izKV5eGixyOaaTqQETrAvSf4q6nxkmzS8X2gHmotequFRzPidXI03Aoz/c6GbREjmm0BNuYpnO315DfkH46ajx0TSZIWwd0cD7vLFn7Uem6VfpeN4/wOf8A843581DaUavZGVSmKsekg5ULMQyJIr2cQuJGbIg6Cw3kLcCogHW/ULjfWI42iocTQPXH8J0FEn5As5cW/DZt8bN+AJCsETCsm6B7yicFXHF2WL+FT5tuJfj6wx8McrRL2hr3Y1sfM147Hc1bCJlwUnCraN6NtK7PanpFX1zfz7EvBmQw==
X-YMail-OSG: hDeHWc8VM1mLML.I94tF0t65OBvTp0qEas83M5yEc0xFa9ifPwf01ArILy7YiQm
 TMJMf3nMnvuHpgvc_hb3qDv2.pEGaZ5P9X1eDyaQqsptvwhhiZlvkS0Ktdu9MPUsartDWRf0W9qz
 kXf8tVchqsYFwD17zwFNeJalMDVY8xbD2L5IvmxMg_mkb.JOdEKqLX4apXVh7H26YSQzPBdhGinK
 EvdiToXJqQU3Qebtdug7X7rWtGNuWaNPNjCF37qHJ_d3Y0EGp83qsnTs999G9S4olaca21B242jj
 Lc1WNAWheX9YfaMoo.08.XYteibxMzcrJDyIsnKcgMCQWdF_0nkn2qJTjlJHsfqv2hLY4bCc7Rej
 LnI7MpxnGXyAOIZUbn0zWwuJTjlWA1bPuV_C2E6rkkFKtJv48nlWiT5vCkKtCqSWuxIvIdEVL42o
 Fgzk9Mw8pgR_hoDL0MwJaeITyYthlAPKPGv6Aev9o4SsdptunKCm_atd9um6KSr71lZih5v.gABg
 V05YqzGuQZHzDfChnV8IdLD_hOaikZ7Ku31kfBMfSY5OSgMOvBJtH3JFtnv4MlhLbiJaMIDQXhzV
 hpJk9PCzDUfQqWwLwTCK89vVt9bLjsufnNPhhG7DC3zQsonK1g3fYaD7ZxnCjfnhyMyXeqxjvMm9
 Bz44lbQ3fxw3XChcHK5G0xtN5OeMNNDws66qr42GTo4CJv8f3sBjG4V7ywHQ_rHmtg9LIadAanvY
 1CSs7nssNR4TO2fNAQ.G.RCq5kMvVK4WIsN7wKkU5_E0gAVusuknsUYwtezv6ZtzKadT3jT5vDp8
 rdGfi9cLiAt9WQqLFZsQAfeWZbMsHLUBp0PeTf25V3DTDHDapbu6qw32L_5jXQftQnyEADYpEBkp
 .j9qwvlFUQNnHtPXdRKjLs47.WA7zZevyUfefBzfLcVVbPJ1bx4MuHF1SbQnrdQfSaNLbMFjIT0Z
 R_KPR_jaZH4CKtyvYYbuoaUY0YAaRa5MVh4M3iob5XfNDtiAMX476nE6LXaLjvN5NWUD2Oz95KTA
 YpwjfhdzXW3w_zvPmUHy4KQmpi8JvoTizFys4fYfVRTEPtCKvgHL2MEUb4kfV8em.iH2IaJj57.p
 y0Vq7.7QBpql8qChW1PBlZ2Z6u_5yNkaTIumFjvNz4b4RrNyrvflY8axFkKvZJxy_43Xhs7NZIuP
 sS0HjesknOEvdC96yFLMLuNKYRJgUk9V7ET0llH6U0xm3k93cKpLIxoITjPQ0V6frtvqOnJ86Ufs
 fdgU1Utctz2X16eqvnegJ8tQENF3qwPyiqgP2gSXX8zpPJ5m_kgqIfIOduZRQoDlP3wMlicuxTnK
 rP1c5vYbMM03m5HoTaVmR17WSt.6SZ0x9ie9boxkoD0etmvWVzYKxfJ8cj2dBngjHLyB0lgRMjrj
 l_99CukZJDGNRoBetGNFEDZdTt0dzCXSkKspiQ0h6NtwwXQKRixY0Y7yjadMiPy3ojs75Hmdw0S_
 F63nCMeeutEch6mLyMABJI1PsTdII8aJJ5KLG3aLs_u27Z3Y_xWM8wWbzhQwFPD2t1uUcDya279d
 ErSGRpndU3eLOCNYGLchjJDpzozDFAa2lzkd2Xzv0mogR33S2GgLl0VEBDPfTsU7eMVyMbX8FJF7
 xAveHHGf6oJoMxw9TkX1s3DGWzrmp21Mbzmy8em1CjLuxPhz7.Wg6Bopx1WCQoeGddsijVkEwq1C
 Xd4Z3ashANzLD8e7P2FG096ftuKrXlbvwNiagHVEJs4nDpwQ50099TtueZziG5ZYnJ_HayKEjmA9
 Pk64wLKAeTy01eoz2hoMIM9hYWDMqjVVAvwa4zgeoZOjQSQIlvK5onQEU3WKhWch1WEul8Q86S0s
 zGkekjbW9eLswhFUu5iDFP5LkzYWsbl_UPZsyRZqtRgfidhH9pXjo0.cLaXtfDVda4n5lhS915yI
 95ivnSPgq_uX62TQeBagsyk9dv6pLQoWzKplmwTkKZ8st9mP8WVU.ccjV8Pua2F8iD.ad5bn6jmB
 U3MYLsWsd25Z2vol14qL_VpfUUPciZv4MkidECHEbLGlTHeGv2wqOQj0j4cENXpRRbotD9vGDBLF
 W4Od89_0S9jsqoGuEwUPSqRzKVGM7FeDU4ZZBy7K1PShd1m8ARBMHQsrhQaaICL_96QXGcYQnLfF
 u4dwazu4B8dXLZ016ohFDMMCpi1o72MSJrZ3MPi0.3ZqrXl9gDqBpXLhRL97iTNGb4TVROG8BCXp
 1tFk9ih3q9NSVHVZtFjx4BzvB0_JvMxksxOe1X1RqGYWIaIyHE31XfxzShAiOVWPr9fKefyDgZHe
 okTsF6DwZzKECx5jdwQ--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ir2.yahoo.com with HTTP; Wed, 8 Jun 2022 23:38:50 +0000
Received: by hermes--canary-production-ir2-6c7595c778-tcd7b (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f9021a74071b88f5034921531ba09f62;
          Wed, 08 Jun 2022 23:38:49 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH 3/7] iio: magnetometer: yas530: Correct temperature handling
Date:   Thu,  9 Jun 2022 01:38:02 +0200
Message-Id: <80d86bb542274dd30be9c5a22dda00736c605222.1654727058.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1654727058.git.jahau@rocketmail.com>
References: <cover.1654727058.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The raw temperature value is a number of counts from a certain starting
point. The resolution of the temperature counts is different for the YAS
variants.

Temperature compensation for YAS532 version AC seems to be handled differently.
It uses the deviation from 20 degree Celsius [1] whereas YAS530 and older
versions of YAS532 apply solely the t value as a multiplier [2][3].

In funtion yas5xx_read_raw(), add case IIO_CHAN_INFO_PROCESSED. Remove scale
of temperature as this isn't applied.

Additionally correct sign of temperature channel in iio_chan_spec. It's already
defined that way in yas5xx_get_measure() function.

[1] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas532.c#L442
[2] https://github.com/NovaFusion/android_kernel_samsung_golden/blob/cm-12.1/drivers/sensor/compass/yas_mag_driver-yas530.c#L881-L883
[3] https://github.com/LineageOS/android_kernel_samsung_msm8930-common/blob/lineage-18.1/drivers/sensors/geomagnetic/yas_mag_driver-yas53x.c#L856-L858

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 93 ++++++++++++++++++------
 1 file changed, 70 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 5c7d0ac533ac..2e8d20b05217 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -77,6 +77,7 @@
 #define YAS530_DATA_BITS		12
 #define YAS530_DATA_CENTER		BIT(YAS530_DATA_BITS - 1)
 #define YAS530_DATA_OVERFLOW		(BIT(YAS530_DATA_BITS) - 1)
+#define YAS530_20DEGREES		182 /* Counts starting at -62 °C */
 
 #define YAS532_DEVICE_ID		0x02 /* YAS532/YAS533 (MS-3R/F) */
 #define YAS532_VERSION_AB		0 /* YAS532/533 AB (MS-3R/F AB) */
@@ -88,7 +89,7 @@
 #define YAS532_DATA_BITS		13
 #define YAS532_DATA_CENTER		BIT(YAS532_DATA_BITS - 1)
 #define YAS532_DATA_OVERFLOW		(BIT(YAS532_DATA_BITS) - 1)
-#define YAS532_20DEGREES		390 /* Looks like Kelvin */
+#define YAS532_20DEGREES		390 /* Counts starting at -50 °C */
 
 /* These variant IDs are known from code dumps */
 #define YAS537_DEVICE_ID		0x07 /* YAS537 (MS-3T) */
@@ -314,7 +315,7 @@ static s32 yas5xx_linearize(struct yas5xx *yas5xx, u16 val, int axis)
 static int yas5xx_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo, s32 *zo)
 {
 	struct yas5xx_calibration *c = &yas5xx->calibration;
-	u16 t, x, y1, y2;
+	u16 t_ref, t, x, y1, y2;
 	/* These are "signed x, signed y1 etc */
 	s32 sx, sy1, sy2, sy, sz;
 	int ret;
@@ -329,16 +330,43 @@ static int yas5xx_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo,
 	sy1 = yas5xx_linearize(yas5xx, y1, 1);
 	sy2 = yas5xx_linearize(yas5xx, y2, 2);
 
-	/*
-	 * Temperature compensation for x, y1, y2 respectively:
-	 *
-	 *          Cx * t
-	 * x' = x - ------
-	 *           100
-	 */
-	sx = sx - (c->Cx * t) / 100;
-	sy1 = sy1 - (c->Cy1 * t) / 100;
-	sy2 = sy2 - (c->Cy2 * t) / 100;
+	/* Set the temperature reference value (unit: counts) */
+	switch (yas5xx->devid) {
+	case YAS530_DEVICE_ID:
+		t_ref = YAS530_20DEGREES;
+		break;
+	case YAS532_DEVICE_ID:
+		t_ref = YAS532_20DEGREES;
+		break;
+	}
+
+	/* Temperature compensation for x, y1, y2 respectively */
+	if (yas5xx->devid == YAS532_DEVICE_ID &&
+	    yas5xx->version == YAS532_VERSION_AC) {
+		/*
+		 * YAS532 version AC uses the temperature deviation as a
+		 * multiplier.
+		 *
+		 *          Cx * (t - t_ref)
+		 * x' = x - ----------------
+		 *                100
+		 */
+		sx = sx - (c->Cx * (t - t_ref)) / 100;
+		sy1 = sy1 - (c->Cy1 * (t - t_ref)) / 100;
+		sy2 = sy2 - (c->Cy2 * (t - t_ref)) / 100;
+	} else {
+		/*
+		 * YAS530 and YAS532 version AB use solely the t value as a
+		 * multiplier.
+		 *
+		 *          Cx * t
+		 * x' = x - ------
+		 *           100
+		 */
+		sx = sx - (c->Cx * t) / 100;
+		sy1 = sy1 - (c->Cy1 * t) / 100;
+		sy2 = sy2 - (c->Cy2 * t) / 100;
+	}
 
 	/*
 	 * Break y1 and y2 into y and z, y1 and y2 are apparently encoding
@@ -347,11 +375,34 @@ static int yas5xx_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo,
 	sy = sy1 - sy2;
 	sz = -sy1 - sy2;
 
-	/*
-	 * FIXME: convert to Celsius? Just guessing this is given
-	 * as 1/10:s of degrees so multiply by 100 to get millicentigrades.
-	 */
-	*to = t * 100;
+	/* Process temperature readout */
+	switch (yas5xx->devid) {
+	case YAS530_DEVICE_ID:
+		/*
+		 * Raw temperature value t is number of counts starting at
+		 * -62 °C. Reference value t_ref is the number of counts
+		 * between -62 °C and 20 °C (82 °C range).
+		 *
+		 * Temperature in °C would be (82 / t_ref * t) - 62.
+		 *
+		 * Contrary to this, perform multiplication first and division
+		 * second due to calculating with integers.
+		 *
+		 * To get a nicer result, calculate with 1/10:s degrees Celsius
+		 * and finally multiply by 100 to return milli degrees Celsius.
+		 */
+		*to = ((820 * t / t_ref) - 620) * 100;
+		break;
+	case YAS532_DEVICE_ID:
+		/*
+		 * Actually same procedure for YAS532 but the starting point is
+		 * at -50 °C. Reference value t_ref is the number of counts
+		 * between -50 °C and 20 °C (70 °C range).
+		 */
+		*to = ((700 * t / t_ref) - 500) * 100;
+		break;
+	}
+
 	/*
 	 * Calibrate [x,y,z] with some formulas like this:
 	 *
@@ -384,6 +435,7 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
 	case IIO_CHAN_INFO_RAW:
 		pm_runtime_get_sync(yas5xx->dev);
 		ret = yas5xx_get_measure(yas5xx, &t, &x, &y, &z);
@@ -410,11 +462,6 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
 		}
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		if (chan->address == 0) {
-			/* Temperature is unscaled */
-			*val = 1;
-			return IIO_VAL_INT;
-		}
 		switch (yas5xx->devid) {
 		case YAS530_DEVICE_ID:
 			/*
@@ -513,7 +560,7 @@ static const struct iio_chan_spec yas5xx_channels[] = {
 		.address = 0,
 		.scan_index = 0,
 		.scan_type = {
-			.sign = 'u',
+			.sign = 's',
 			.realbits = 32,
 			.storagebits = 32,
 			.endianness = IIO_CPU,
-- 
2.35.1

