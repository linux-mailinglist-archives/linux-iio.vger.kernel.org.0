Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2518A5916F3
	for <lists+linux-iio@lfdr.de>; Fri, 12 Aug 2022 23:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiHLV46 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Aug 2022 17:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiHLV45 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2022 17:56:57 -0400
Received: from sonic311-31.consmr.mail.ir2.yahoo.com (sonic311-31.consmr.mail.ir2.yahoo.com [77.238.176.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DF5B443D
        for <linux-iio@vger.kernel.org>; Fri, 12 Aug 2022 14:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1660341414; bh=6EErivruwsgZKC+fXIpLXsbvYq9f75MRwEyexn+OXd0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=g4g304DONim6/WSBdq6apSzI0ADyDIuIyBY0pKHXJL4doqcMesrl8hdEL/mgksJwcGzYmRD5scvTDpq62jeOUhefrYlFsecQkyssRAdMmkfdXgVuCRtQgNNwnX7uFK0ajsfEP3hqdk29Q4wfKxigjKq9wrjb9X+a49LLzuAGyu+jlx9JshH7d9pj7Tt2H/dMTJ1sOTzI8ty7NMfUXy7wnx6G6/2Q2s35aL54i7YrvlTB/4kJHBmvgcv4mEdRJHjBo7TPHumWdgl4pzR9BAniGuhKwwcvKyQW5wL3+0cpjHWEs/RBHndxFoD79843fkDG59CF8ZryY5V+rTIcJ78Fkg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660341414; bh=rpR8H/53ymVa+HXLXn/dDnxmnoH8soakZl+H2+loy/c=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=SC0WiAzIVJgQKEneYwMJ/SBNuzM9mgKSiv8NrdJTXK7sUH0vBbuAsfKeQIUcPewxdUMszcbTp4hSuwHQkrXl1cxGzmeHR1GuHW2jYAVf3K3BtvCgnaqPEFRAWJqLNPPF3Tiq1f71vgjCZA8YbwPvO1x+D+/N2CYIEPuxSlBgYxb3/gK9sEjpbLzlR3ZiDJawJU/aduGOyFox/80Q+WteJtSP2vFGY+a8Vc0siOsiBEvmAh2PQcj4ekbOxVOlLwXY6ODdo4vRAz+M9I4PmPgWWXhzIKLJ+IsMnD86uPz8xY6d2Xt7kSGGow5cKi1vrdEM+s66JiebM/vMF7OL4ga3pQ==
X-YMail-OSG: KMCJDzYVM1kD_TJZOyZ8Mrt3fJhguf2R_mflQ_aTkaDMf7iUl5s77yNQscXx7K1
 AFXoYnFWzQlSGqIW224OpN9YPq3FNR833T91NXltIt2A8MFYK1j7QHAOv0JXdG.PKF8actwHokxl
 zDkB4lU6VvSkssSGAlc9WWoQ.AO.ySg7n8iWefl2h0UvHz.DeVES0K_rA4kpKuNPjOvJY8SC5ILO
 bDGO7N9KH11z5P.RmUH4aX_UlUpELtN9MXv9ixuQd50_yP2rZpfCOT7t3vGGbGVqT1aiK2dRA5kF
 ioIOOBgoqpncPXpbJzQp3EuXEddS7TCgsRXCo3zAbKqUD.sE_LXBBXllhYGrl4z7jQetZ_XI9YTL
 qDK3wrSHbqPISHCY5TRT4PtecqX0fU4OWAi4QgR6iRPQT9lPsn9w5GLYlhyOCmxqLA3z9riDTa4w
 DtlOWj82aNVfJFq3EKfdcn2rFYm0t2wjpWy3nXT999lXNVUa9AwJduR9Ustjm8mecvbpQkecvEqY
 mL_R3.XnqBz37D3PQSN9NfsA620jHoyVRiWRG6Zoc93I1pAy3U66OE95n3hS94sj.Q2FSg3YrXp_
 11eb2D4SXghiRzmpw_LFgTk85u09joWb4fhZbC7tlKK9LXa33SG93xyRQopz_tDrJdeS0MDGER9j
 oxN70cBx5eimC91KypRcRcaMTgtE8W3ecUmvds4Z1ysCx0fPCVul8H71ktF9YAH7EEXQPvrIU9gk
 GbsAIIgsg2pUP6XUHTkKd3irpUzbaDVg8fn.NTljg0eIJD1w7hiwe60g7H05gD1cnuXX2KOwmQPV
 cMSZm__WmGUN8KILna_h2yFsBAvhBH99sgVq2fWbquYrsb5uz3EkZcIbZOlGZUsXVmDR7JBxYm5f
 VfiDJgf3C8Xzy2a569p6X3RYuebcuePY36J6AvAeAIp_qXkH6n1DyTdbUm.lMD0emFXS4Q2yGpqe
 G8IBtHRDGukBZiSxNQ0NBcsksT0L1Jf1DXQ3AL.thNPBjP8MsrSjM4gQjFchc9hxmkNRis_HuQjJ
 Rie.z.2eFrf3B6mUoZp9JdTUQtzGLA_D2qrmE13sUR6Vh7nPv7olTy_fgXl1I82ZYHgpB6kG8xLX
 o0G8ovfVZ4nYe_NJQuV3RfjL28R_Zvtg_IZpbcWnslY8ddCFr8dwHN5ZVV0DGkPikOuKrP7hrNet
 R_azD0XLTp0hEGGLhfpqGbhkucdln0r_QriMaiq9rZHwK1a7GYQCxRS4.3DvsMTrjFLPsK6NQG1T
 GHQfW4T1mcMLHdzOf4BXv8l171UkXJAwOg6TcgCu9F0DUwWqtM7yXzsifkFegTd.nOWICTTR4fRF
 XFp62s.0IYZLjuuWmPMV7mZSfScCbtWrTery6Pg4vjdn2VBzu2oIEUycMJSO5BVlug8cMxVwTZrp
 e9pvANSxTKhdThNSjLYGRE7NIvXe08_xl24MrgyTNknYuJzkq2_Yj9W1k1jjI55yCq7qyw3gbajL
 ITJAZVg7fNExejAaUufCFnUVVluJPugIDGZvnR99p.632BjMTfsm07mZtCPsTPO3m8_hyiGGXKcq
 tDfTZISBBZiCPvomfe_Hb4N5GrpyxWiWzE6NZrbKGwU2b7sdjsG3HVZh8kET_lT9aRfD0R.sgssb
 YncvVAH7Xx7zD1M0utjF32rRaMNKbRj8GX6eLrkD0uY8Eaga.iRBA0psS7vlK.KN1iNfsW_KFYOM
 4oU_IPpDdqDpu4fW2XWnInedXTMcqqMiKWzMbr.zCHQQaywirCtMlkDj88lyvGls0EqV75rfogba
 2kJKHpaelkCqfH8BZDjJU20433BOe4mBBv_qRSSY_aB0EUSfNAit592BSqPNBPYCxIfEK5.XLEsD
 zxE6MwFBfqlHEf8xml7qKYCnTTON1w8obl8__LdzPSdPNb1tO_Nuo6Gno5mRPNjTiS7LuvOw7oAS
 h_VzFddWIMYD4gcQYlVli_IpJLKu0jAyW7XWbSgX9TBZdHFiqE7LwgC_uZyjn2PiEk.QvnqtKH7F
 W5_PS4u7muOI_ppDH36cOs1KSUtAYszYrCZJiuIf7ak3CXizDu4ScfouylkGGuGT5a7QHSquBhSH
 edbuZZfpS_J4diOqwEJ1VaOuXpsVIhBDte_uf0Te9oZQMrAsiNp9lG51c8oPT6XKpiEHHauLRDbF
 cjcE40o05W9N4kQ3wPOf_cl_H75o6NytXVUEukg4qczEouRwZudRx6S.HIubSKgELL6gH.SW6Ccb
 eS_25lM.XRXLSV6s2g.O14NfhzsIYeoGKZnF7ea_oesns4yBMc96A7nH3HtVSiwRv_TchP9ylyNK
 XPjjxvifOKbGCxdU-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ir2.yahoo.com with HTTP; Fri, 12 Aug 2022 21:56:54 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-2vqg6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 15f5a750f82727a3561822ee8056ab25;
          Fri, 12 Aug 2022 21:56:52 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v6 04/14] iio: magnetometer: yas530: Correct temperature handling
Date:   Fri, 12 Aug 2022 23:54:09 +0200
Message-Id: <eb45f328c7a81eb622c6a8cfc5c468ea58bbdace.1660337264.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1660337264.git.jahau@rocketmail.com>
References: <cover.1660337264.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The raw temperature value is a number of counts from a certain starting
point. The resolution of the temperature counts is different for the YAS
variants.

Temperature compensation for YAS532 version AC seems to be handled differently.
It uses the deviation from 20 degree Celsius [1] whereas YAS530 and older
versions of YAS532 apply solely the t value as a multiplier [2][3].

In funtion yas5xx_read_raw(), add case IIO_CHAN_INFO_PROCESSED. Remove scale
of temperature as this isn't applied.

Additionally correct sign of temperature channel in iio_chan_spec. It's already
defined that way in the yas5xx_get_measure() function.

[1] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas532.c#L442
[2] https://github.com/NovaFusion/android_kernel_samsung_golden/blob/cm-12.1/drivers/sensor/compass/yas_mag_driver-yas530.c#L881-L883
[3] https://github.com/LineageOS/android_kernel_samsung_msm8930-common/blob/lineage-18.1/drivers/sensors/geomagnetic/yas_mag_driver-yas53x.c#L856-L858

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 99 ++++++++++++++++++------
 1 file changed, 76 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 199d83013e6f..6296ea3140ef 100644
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
@@ -329,16 +330,46 @@ static int yas5xx_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo,
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
+	default:
+		dev_err(yas5xx->dev, "unknown device type\n");
+		return -EINVAL;
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
@@ -347,11 +378,37 @@ static int yas5xx_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo,
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
+		 * Raw temperature value t is the number of counts starting
+		 * at -62 °C. Reference value t_ref is the number of counts
+		 * between -62 °C and 20 °C (82 °C range).
+		 *
+		 * Temperature in °C would be (82 / t_ref * t) - 62.
+		 *
+		 * Contrary to this, perform multiplication first and division
+		 * second due to calculating with integers.
+		 *
+		 * To get a nicer result, calculate with 1/10:s degrees Celsius
+		 * and finally multiply by 100 to return millidegrees Celsius.
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
+	default:
+		dev_err(yas5xx->dev, "unknown device type\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * Calibrate [x,y,z] with some formulas like this:
 	 *
@@ -384,6 +441,7 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
 	case IIO_CHAN_INFO_RAW:
 		pm_runtime_get_sync(yas5xx->dev);
 		ret = yas5xx_get_measure(yas5xx, &t, &x, &y, &z);
@@ -410,11 +468,6 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
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
@@ -516,7 +569,7 @@ static const struct iio_chan_spec yas5xx_channels[] = {
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

