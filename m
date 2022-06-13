Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B40547D51
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jun 2022 03:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbiFMBR4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Jun 2022 21:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbiFMBR4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Jun 2022 21:17:56 -0400
Received: from sonic305-21.consmr.mail.ir2.yahoo.com (sonic305-21.consmr.mail.ir2.yahoo.com [77.238.177.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD713313A7
        for <linux-iio@vger.kernel.org>; Sun, 12 Jun 2022 18:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1655083073; bh=JEy0Xl+ycXv9aNpCiOvSpSyWnMAxNZhiWxVAZJUZsWw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=SCUekVOxHIEpwu1SRLr5EcETxJ7PqMWUuFAO5I7kA3Pwha/X7HLQXN6OX0/mT7HpTMVzazNqC6VdntzpL43Uon1ReCYNPUGR2oqwFU3E3Hvl9+437sE54lGgr+V1BTRPWmsoLrVpDmc7MEfU9sb1GOTerNyRCqvYKR/7gsVKovdCpcAhHUD5k03y92tk6cmrqGULmaNK63/OvaDAqyJZ1pSHUCUnEqk6kQPRlH9eN0ykfImrbJDGexWbdL1vzoW3PXRA7xqWyRYscCEQ5kEXEryKfeekMP6wZ3RuDQcktPgoD+MXxp2LvdwWJXZsNsh/vZ5goLq8Kxy8V/bPkKIUkA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655083073; bh=/fSLFB+5jqwW0XtbTZKZAtYAC2NsOorSeu87flvfACm=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=sFo1xtlk6wKyMg7zOKEk739Vnh3n/6aRWfasnOahb3255279UqFwv3Z+4NWB0SEMQ07MRvwe9oKKKa93qVQWRHkhi4EN3Kx8nkPiw+chWDGtqUmV74p5i0vc/7GJhW4oezqq94kfu2W74lJhwnqs4V5tPszi3tzefQIjOeo0Vs3HfTMAoANpgVhgZyglyV96Y7qu8G97Mbs5julZXKfeSWaVLMtLKWFAYZjj7TIMg9HXxrrE0IDjWaOwfVM+NDay008skKYXCewAp6KPgfRIptI7tlEtYoJVAbvPn/zEYuOk8wlnKVJG1MVjItlV4xEEM5XEV+SYuxIXFUI5O3SufA==
X-YMail-OSG: XvOHR0IVM1l02EeXLUxJyf7eRZmF5ScNCUiJxYO99k.IgoN6jm9bGWe8meRMwdU
 E6u3cdkPqsxvzShTtOg8.8Ojkf4u17Fpe2vDRl86jHAD.ViKkUUegC1Io4xYbJq.pmxQ0drDP5_b
 dxxJeRVcp1bx_qdwgWyNafAnRuYRzTgU5y0wVlC59t1nFXEP0dY5zKDJxwLXlFv.LNLiQ9btpNjg
 Np5IVvRWFQqVEB7ktUY8sDznMN4B4UVZ5V15K1MnfcWDyEWJUTmoR_jKXedGkjUbUzwzz7s8mhDu
 EJoU24_C8gm16U1q6OUtHmSLtrEYCcHrdsKw7LoJckq9rXbN1aCCxL5ueTwL83BMG0BcSmiQLw60
 Dd9lo_t9hikzkw6ZT42WNlvFBqLSaaUpP8HVZ7dkx6WVrPycd6NQWDOokgRkTn4qdEqh0ylSu3e2
 guLFLIRAO0c49fatzzb6eYxm0k8tUJeNqZoC9Z_od4fYhG4biIutXtsOMIognWQt0UL2vKKfvmJ7
 ZuXjxvaQj5GM9sc6LPF9SRcZ9AXbdTnTpUsfZtkLWJbeLXwr1bHDtRLF607LZP7EBtWMGRw93ilm
 FX4y1yekm2XR43T96W0sz3_N9MTOmzOWcieNvB7tR7gQXrjCJJXqiu3bbz7bRD3.lkpWhejfyoSQ
 KAPw7eif65IiBipt_0E9quO6UuifpKVkSnYc_MKjy7LXCYdUFEcvzW1Qmh2_zor5mIeX6XmapnVT
 T4Tmqo6ymh3zm13Ol_LeJMsIcsK1Q1PaGjaLOOYzf2y4YWq6_DvZimBb_Xzu3npJijOKSL.zQ59U
 mh0dzskGcLUImZaXPpoSVMiRiirC_nbTQd2TXlngih7wqQhKYISaocnfaeITF3R9FtCp8BfOnrCO
 nr9RT9dyH6c3RbBQHerAcxppSDx18W1Y5XO6akzgWIDREhmndYBopzKupZ9A1LLBkEhrlCV7.MfC
 uLAZl2ELqnJkyAt8WR05Mdl_jkqsCG.bbiRqgCWP1Uz58ZE5EpK7l2_TfJepIaqgEOd0QHGJfXA8
 IdMoxvruwKntUuC3dVvRyD4guuh0W2GQqQq7W_A2W2As58rgJoBl2J4sxqVJsQDo8SXSGSqtFs5_
 ZK0iPCtZ0D6WNRG2Xq8vRJRhHN6GeUONz3XLXZ6XCgxkLTN_yENAhttivtYsjFki1BQird2x2Yrd
 CpT3Zn0PsueJkvAIENjWoYOJ057FNnTEznucmw5I5yB8T0XAcCrySOel2QYwci6gw2lqRwEWh.PD
 ulAaO.pZXwN9L.PasooUerKRXeCFcyGnOasGN_X_EZIMk28nmVpcOBGAbNKsqPTKy4cPCqxE7yb_
 duGv0F.rg5owDC3rUZcrvdnYOkWYo5U0ilmj1mV.WQni9mhNnJgKCjxUrmPPF0kJS.jyTJfIGrty
 L3i_G2QMX998tUxJVQbfyJplg7WxrKMKzA_feBpNb10J1GvrWZFrSwHDto00CqIjwejq2DmZj1oz
 DMLdCpzr6IaZV67eCavZVtdJUL.oCj1GNHT4wAu6TDC34VNqyQCeKjFPeAimZ9xT9D2XQ4kfOY5F
 jyhSYiOKS89vTORinemGnYySou9Ss9HSjkoqNnkKwCz1b5CbVeypiDZvfY5sqmV55vQBA4U.T0IA
 9ZMw3z2ho37ESCBIJmR75VGhrmvNRczCdPa6KcmU2X4Uamt54a5m9BQDhdhz4Ebga5GOiEjKxW6U
 7YZrXSLeAyfrQbxT3rNdP5NPQOk7wyPbbAQWwgNzpegNr6HriHg_F0bnGX.6hrGq1Z35e2ZGileR
 cxy7Kz1ZJPT_wOad6.ulATaZcy5VMkoe12cqM6R45QeKxNh_pvb78BlYeWlVSxMuvr6pSc0eF3Pk
 5VPtekgKUYayKwaTNqTK9l31RdXOXfb1v5WLYTBJOJiH_lXxSNpMazBmJzrA1CbcJEDZM4_gOfId
 H5ofnkydpVF4uTKEJX97h91i2p9G8RD_DqrN6jfPMyppN1KY17b5GTzSLWD_pK0WIB_0oSFnUdt8
 PivisDnQkRuhDf5yR84n4qA.PPxyRh9GUwnu41T3T8ViJP8vQSAZ_iQIm6K.90WbEeoXp4l_poVA
 AE1SKLKvknWajawU8Heh19Ab3zYSGW1XdqYK4XKJ4ndlM6avCS9GQZGZ_jyf4QV2fmgzb4_6h9L8
 GcxmrlJYdkeqwRbYuQRS_JdBeWMM1plnPeYnIND9ZoWlAsJeAKirPkwUxV9hCDp15On8lxlYkBK8
 3wJn49aKIGtd8j66RaUk7SIyc083x8wmG5G_kL_APxJq1jYKvnzyXftGFkuj1ApYSMOCY29au0kw
 bGRhxQ8U4ZBLhe2Qz
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ir2.yahoo.com with HTTP; Mon, 13 Jun 2022 01:17:53 +0000
Received: by hermes--canary-production-ir2-6c7595c778-c54g9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4419c1e75f73c3038b6a16962b132f56;
          Mon, 13 Jun 2022 01:17:51 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v2 4/7] iio: magnetometer: yas530: Correct temperature handling
Date:   Mon, 13 Jun 2022 03:17:11 +0200
Message-Id: <2e4622b2c98eda75c262d460533162f74cfb8605.1655081082.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655081082.git.jahau@rocketmail.com>
References: <cover.1655081082.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 93 ++++++++++++++++++------
 1 file changed, 70 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 40c81c082782..9bfb3b573907 100644
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

