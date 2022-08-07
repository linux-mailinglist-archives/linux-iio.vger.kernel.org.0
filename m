Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509CF58BE44
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 01:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbiHGXHs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 19:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbiHGXHr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 19:07:47 -0400
Received: from sonic302-21.consmr.mail.ir2.yahoo.com (sonic302-21.consmr.mail.ir2.yahoo.com [87.248.110.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF205589
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 16:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1659913663; bh=/DR18V4fXYp9SrGrQSgOTOc2kOvov5DU33YvM1+CCoo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=CS7MZX8ZDF321tAEMSjizpMqWMOBY2T6dRnN/i6L2cvwTFdyYiB0n0t/ao5PTseLYgQoVlkjgOLpror8qHzAa/+Jv/uQ4y8E4aPgHLKDsQAeisKj97MPkJ3JIY/BxZF0rxu/zNM+57eljXhDT3icqbT7RSODBRp1SOHvhjStWZ3dmvP/oI31HYJpBXkD9XWMnsxCAzca7h70tN7WRPrRYTz4+sYIedVSR2VUzhcEsHU1WoQn9zJ/1KKIHnHoHU22AOcnjqpbY8EUajqsrfEBo6prLrLRAwG8HdaylGuJW3BJnVFADtaL3RQfVUG2SyrqwCNhlnmthCGTD+auvD+YOg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1659913663; bh=m/gwRuMdLvNfoPXJKAwMsQGiueKsxrcIi0vAQ8QLNw4=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=PQcXRGv56fXBLfeH3Iu8pw1j877DRbME8kUYibdsKa1HOsWIw8LFg/Myx0YCPfpdfYERMGQpJ97ljQQP4Y+cnKGEelSTpGjrBjwtypt90Yp55QroPwkwB4CNfWU7t9r+u0oL5+WuktCx3Rc7AOajqXM6KBWS5KelU+y9hNwjgYGIQZnDNrofoL8oRVf1GfBEtaz5yluJNJAm+gNEncAItgh60MufvzdDBVPezmTjtxiUco1kbHr7SM/Hs9lU9OeeaQGqOrNSzyez70WuHJya34ci6ew3yOnBlaewTFFFeNrbxAvbCyj3+Js0ojg+f8ohQGxFPfQbahL0ibkt2+6fLg==
X-YMail-OSG: iAMRQFQVM1l0f5.dFLKZZjZdns9OXvqs9.MBksHwYSKyK5F6S2QAcor75.iZAqT
 JULC6IGZEIZMtia0RyGr9lioWk1nNWWHGZ4gqrkp5k8a3vwm1GTMKC8sHyy6jVwGFhqgXOdlRTd6
 mgf8SkCm9F0GkNAjb6o1ubPq3r7W51gpi4f14NEpmyrLkmNAaPRzr2mLXJrguQkJGkujMNl4Dox4
 wJmm1bo7m.hHHvz.smmWi.DGgY07yiKKXKGKjjzvDZVJllK6uguYSH5QhyHSQWPIuV7yumb87BZv
 XuqJKjaTt.qtp8xwt5YbLW4R1awU1PWJAXfNEvvZC7Rejkvvi5pbRMYXrUp0EIyYpPq66IelNugq
 SYbc_w4e2JOggv2RNYAgbk1u5_3V86QR6.XhgZA7AmOwSfqgxTJMijT5QAdHkJ195Y7_uCEeng6R
 EmDEYMaBzVaUkTab2KSFV5vohopkpPfXlF3NdVeHJ8qGL7GsoFmtSQLm9HM3zTtynKvCAfI8nRTx
 sHcl5qJH9f1K0d.WIfzqA9v3.KqDpEFfUFAFtUbxXmLEwhlPwCTEneeFLEKBte.tC9wEvMvIHfXt
 uF9Tz9MchZe5C6rMFRrh2ytn4UTk7Gj8PX8ZsxYZpb_sfvJJbCagDG4.4Eb9fyIq0EoLDdDFMu98
 OoVa29_3xzeIvJffO1ezAlZq_LIa1q6fl9Bl_zzzRKA7WENaTxh.9WyuPMy3KEuu.C3fbmZDspyE
 _cL72I1Hj1EIWjbIz9SW.dU5eSppux.fMiG4BbPqmXsnzk94T6r7IqAGpzmcLxgt678Xw7Ec_Kp.
 xb.nDVoxXWqFmOlugXuvWS_vHgP4Tux1qY3SNsicMpq9mFF2tPvhdsjDgSQHHh7iJjJhnBa.nPNS
 7NDzs.PBhcE5sfoqq1jUlneJoxHmvwzMATMSnlympuvb5q0Pb7V6gRJjiPi.D8omeMRdHbnUzOX9
 A9_orIL0ygNsHXg1jAbxSMz06n7khu4sv3a2vObW3VCeC5Sq9dq9MKdaEWlOCQNKjHBBmC31EADa
 nMgDvBfOk7sqV6k1Y6sqroYQe_uwl.M9R4Vi4yRnqQJ7Yaj4dTpW1oONaFV9UF2r8KLrWEKWG4NI
 ad7uT5Zo9L2YHkhxMfjhzSi7ZSqTaaID4IZvW42pCj7zM44CdPsqJdShFPSBbAhagPUMZaC.A8yN
 jDF9zhyzCqFExBWqy_etX99Il4ZT2ZOQ0hG1T2WgtkfMXARoQbXMLVu.ngXDtqK2QSPDSm0pjWrB
 UQ1WJKVEFvFUY4cf6RcdRIEyf.7ijp_yJb_aRQjhUM2rdlo.nK_EkcD.21h_zJMc57wgMsvhj8xl
 gBSdq3z05zSB8PJTejBDwH8Q_2nE01HOcUh5MtH_j8s.F_d8JgLuRid6lH_v97Lon43baTzVGjpl
 llmJDlJilteSRjELEfIvRm5nFBbW8RrPMGCRqlvNMxSRq.Mc32a9S7N.XU0GOwgyu9Y_z2J.Q1zU
 SjivUWFMPWt4UaQDoO98epHbHBOP5ubPlQ6BLVVGm48jMpVde1cZVp1aW61HX8pyt9hk3KyiTaSu
 Cpy.vT4uc9A7FwyzFWg9Gq2Vhyl1C__8GfeoiOwp1E.cw276Ncbl5laySpuxKfJPB7Hop.eQVP6a
 POWPSzRL1Tz6Keve1ChAigLXvDxB6fzbg325JCBLm.Ylltwr6lxKlsaXBtoyZwGubzUiNx7vh0M5
 z3vq8III75WxipRQjNwkLfZIa7ImsWHMblBBHS9HvTGFTORZvqd6a0v9V1L5x2wW2G0818QP__IW
 Ur7DyEg.PzMIge.9I3vkIE4hBJ25QTrYVuFnqeWD7YmP6ET1dNHsln9an5DqdikpxJ6f4dkx95zK
 8I1uDqlUu.JQR5CxLmZA.SU2jtSXTG6bZ50tA7jSCuuOyAuam.z8uYEcc5qfQ3bC5TOIo6tBJ3bE
 oIxoeLyMo5R05oG1Z.cHcZaXJ__MPiaDlbzcEejc19.y9U6DvKSHGL.nFdu2bcjSaAq7HzD0FWov
 rGfcM05qici4VYrQaVMbC1noKh8dTUgMBHXe7wZwXKdMbS0ETRkJbDAxPrF0WhiIEukYvMYcALpO
 v4WrvJIvHaTJUhjiyHYzA5VxHuWzMXo7.W7KqLNOuP5eZfpxyPxYyLwF_jh4d_99GyqsgMVQvulu
 PUhA6M.A7X6e4fTMeoa62llE06mphdctTbQYS.su9E64nBcBvK9vFUCH.avHyKG3PZxDhDegkHgx
 kUp63OSJUL8G2dwh9IIgATpqJ0tRkqK6j2njW2hGlV2KigkYHMGwA4xbm2BDOEocy_92zY_sN.So
 r_ZOyKdVG3khM9pB.
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Sun, 7 Aug 2022 23:07:43 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-2vqg6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID dc92a55cf24372a35650a28a19dee6ae;
          Sun, 07 Aug 2022 23:07:37 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v5 12/14] iio: magnetometer: yas530: Add temperature calculation to "chip_info"
Date:   Mon,  8 Aug 2022 01:06:51 +0200
Message-Id: <2a93df6f99913e438dd2d394c074cf79544ab692.1659909060.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1659909060.git.jahau@rocketmail.com>
References: <cover.1659909060.git.jahau@rocketmail.com>
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

Add temperature calculation to the "chip_info" structure to ease the handling
of different YAS variants.

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 140 ++++++++++++-----------
 1 file changed, 71 insertions(+), 69 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 262a36c31616..780c7f4d1eff 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -79,7 +79,6 @@
 #define YAS530_DATA_BITS		12
 #define YAS530_DATA_CENTER		BIT(YAS530_DATA_BITS - 1)
 #define YAS530_DATA_OVERFLOW		(BIT(YAS530_DATA_BITS) - 1)
-#define YAS530_20DEGREES		182 /* Counts starting at -62 °C */
 
 #define YAS532_DEVICE_ID		0x02 /* YAS532/YAS533 (MS-3R/F) */
 #define YAS532_VERSION_AB		0 /* YAS532/533 AB (MS-3R/F AB) */
@@ -91,7 +90,6 @@
 #define YAS532_DATA_BITS		13
 #define YAS532_DATA_CENTER		BIT(YAS532_DATA_BITS - 1)
 #define YAS532_DATA_OVERFLOW		(BIT(YAS532_DATA_BITS) - 1)
-#define YAS532_20DEGREES		390 /* Counts starting at -50 °C */
 
 /* Turn off device regulators etc after 5 seconds of inactivity */
 #define YAS5XX_AUTOSUSPEND_DELAY_MS	5000
@@ -119,6 +117,31 @@ static const int yas530_volatile_reg[] = {
 	YAS530_MEASURE,
 };
 
+/*
+ * t_ref_counts is the number of counts at reference temperature.
+ *
+ * The temperature value at YAS magnetometers is a number of counts. The
+ * values in t_ref_counts[] are the counts at the reference temperature
+ * of 20 °C.
+ *
+ * For YAS532/533, this value is known from the Android driver. For YAS530,
+ * it was approximately measured.
+ */
+static const u16 t_ref_counts[] = { 182, 390, 390 };
+
+/*
+ * min_temp_celsius_x10 is the starting point of temperature counting
+ * in 1/10:s degrees Celsius.
+ *
+ * The array min_temp_celsius_x10[] contains the temperatures where the
+ * temperature value count is 0. The values are in 1/10:s degrees Celsius
+ * to ease the further temperature calculation.
+ *
+ * These temperatures are derived from the temperature resolutions given
+ * in the data sheets.
+ */
+static const s16 min_temp_celsius_x10[] = { -620, -500, -500 };
+
 struct yas5xx_calibration {
 	/* Linearization calibration x, y1, y2 */
 	s32 r[3];
@@ -143,6 +166,8 @@ struct yas5xx;
  * @volatile_reg: device-specific volatile registers
  * @volatile_reg_qty: quantity of device-specific volatile registers
  * @scaling_val2: scaling value for IIO_CHAN_INFO_SCALE
+ * @t_ref: number of counts at reference temperature
+ * @min_temp_x10: starting point of temperature counting in 1/10:s degrees Celsius
  */
 struct yas5xx_chip_info {
 	unsigned int devid;
@@ -151,6 +176,8 @@ struct yas5xx_chip_info {
 	const int *volatile_reg;
 	int volatile_reg_qty;
 	u32 scaling_val2;
+	u16 t_ref;
+	s16 min_temp_x10;
 };
 
 /**
@@ -349,6 +376,20 @@ static s32 yas530_linearize(struct yas5xx *yas5xx, u16 val, int axis)
 		(yas5xx->hard_offsets[axis] - c->r[axis]) * coef;
 }
 
+static s32 yas5xx_calc_temperature(struct yas5xx *yas5xx, u16 t)
+{
+	s32 to;
+	u16 t_ref;
+	int min_temp_x10, ref_temp_x10;
+
+	t_ref = yas5xx->chip_info->t_ref;
+	min_temp_x10 = yas5xx->chip_info->min_temp_x10;
+	ref_temp_x10 = 200;
+
+	to = (min_temp_x10 + ((ref_temp_x10 - min_temp_x10) * t / t_ref)) * 100;
+	return to;
+}
+
 /**
  * yas530_get_measure() - Measure a sample of all axis and process
  * @yas5xx: The device state
@@ -363,7 +404,7 @@ static s32 yas530_linearize(struct yas5xx *yas5xx, u16 val, int axis)
 static int yas530_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo, s32 *zo)
 {
 	struct yas5xx_calibration *c = &yas5xx->calibration;
-	u16 t_ref, t, x, y1, y2;
+	u16 t_ref, t_comp, t, x, y1, y2;
 	/* These are signed x, signed y1 etc */
 	s32 sx, sy1, sy2, sy, sz;
 	int ret;
@@ -378,47 +419,30 @@ static int yas530_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo,
 	sy1 = yas530_linearize(yas5xx, y1, 1);
 	sy2 = yas530_linearize(yas5xx, y2, 2);
 
-	/* Set the temperature reference value (unit: counts) */
-	switch (yas5xx->chip_info->devid) {
-	case YAS530_DEVICE_ID:
-		t_ref = YAS530_20DEGREES;
-		break;
-	case YAS532_DEVICE_ID:
-		t_ref = YAS532_20DEGREES;
-		break;
-	default:
-		dev_err(yas5xx->dev, "unknown device type\n");
-		return -EINVAL;
-	}
-
-	/* Temperature compensation for x, y1, y2 respectively */
+	/*
+	 * Set the temperature for compensation (unit: counts):
+	 * YAS532/YAS533 version AC uses the temperature deviation as a
+	 * multiplier. YAS530 and YAS532 version AB use solely the t value.
+	 */
+	t_ref = yas5xx->chip_info->t_ref;
 	if (yas5xx->chip_info->devid == YAS532_DEVICE_ID &&
 	    yas5xx->version == YAS532_VERSION_AC) {
-		/*
-		 * YAS532 version AC uses the temperature deviation as a
-		 * multiplier.
-		 *
-		 *          Cx * (t - t_ref)
-		 * x' = x - ----------------
-		 *                100
-		 */
-		sx = sx - (c->Cx * (t - t_ref)) / 100;
-		sy1 = sy1 - (c->Cy1 * (t - t_ref)) / 100;
-		sy2 = sy2 - (c->Cy2 * (t - t_ref)) / 100;
+		t_comp = t - t_ref;
 	} else {
-		/*
-		 * YAS530 and YAS532 version AB use solely the t value as a
-		 * multiplier.
-		 *
-		 *          Cx * t
-		 * x' = x - ------
-		 *           100
-		 */
-		sx = sx - (c->Cx * t) / 100;
-		sy1 = sy1 - (c->Cy1 * t) / 100;
-		sy2 = sy2 - (c->Cy2 * t) / 100;
+		t_comp = t;
 	}
 
+	/*
+	 * Temperature compensation for x, y1, y2 respectively:
+	 *
+	 *          Cx * t_comp
+	 * x' = x - -----------
+	 *              100
+	 */
+	sx = sx - (c->Cx * t_comp) / 100;
+	sy1 = sy1 - (c->Cy1 * t_comp) / 100;
+	sy2 = sy2 - (c->Cy2 * t_comp) / 100;
+
 	/*
 	 * Break y1 and y2 into y and z, y1 and y2 are apparently encoding
 	 * y and z.
@@ -426,36 +450,8 @@ static int yas530_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo,
 	sy = sy1 - sy2;
 	sz = -sy1 - sy2;
 
-	/* Process temperature readout */
-	switch (yas5xx->chip_info->devid) {
-	case YAS530_DEVICE_ID:
-		/*
-		 * Raw temperature value t is the number of counts starting
-		 * at -62 °C. Reference value t_ref is the number of counts
-		 * between -62 °C and 20 °C (82 °C range).
-		 *
-		 * Temperature in °C would be (82 / t_ref * t) - 62.
-		 *
-		 * Contrary to this, perform multiplication first and division
-		 * second due to calculating with integers.
-		 *
-		 * To get a nicer result, calculate with 1/10:s degrees Celsius
-		 * and finally multiply by 100 to return millidegrees Celsius.
-		 */
-		*to = ((820 * t / t_ref) - 620) * 100;
-		break;
-	case YAS532_DEVICE_ID:
-		/*
-		 * Actually same procedure for YAS532 but the starting point is
-		 * at -50 °C. Reference value t_ref is the number of counts
-		 * between -50 °C and 20 °C (70 °C range).
-		 */
-		*to = ((700 * t / t_ref) - 500) * 100;
-		break;
-	default:
-		dev_err(yas5xx->dev, "unknown device type\n");
-		return -EINVAL;
-	}
+	/* Calculate temperature readout */
+	*to = yas5xx_calc_temperature(yas5xx, t);
 
 	/*
 	 * Calibrate [x,y,z] with some formulas like this:
@@ -943,6 +939,8 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
 		.volatile_reg = yas530_volatile_reg,
 		.volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
 		.scaling_val2 = 100000000, /* picotesla to Gauss */
+		.t_ref = t_ref_counts[yas530],
+		.min_temp_x10 = min_temp_celsius_x10[yas530],
 	},
 	[yas532] = {
 		.devid = YAS532_DEVICE_ID,
@@ -951,6 +949,8 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
 		.volatile_reg = yas530_volatile_reg,
 		.volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
 		.scaling_val2 = 100000, /* nanotesla to Gauss */
+		.t_ref = t_ref_counts[yas532],
+		.min_temp_x10 = min_temp_celsius_x10[yas532],
 	},
 	[yas533] = {
 		.devid = YAS532_DEVICE_ID,
@@ -959,6 +959,8 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
 		.volatile_reg = yas530_volatile_reg,
 		.volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
 		.scaling_val2 = 100000, /* nanotesla to Gauss */
+		.t_ref = t_ref_counts[yas533],
+		.min_temp_x10 = min_temp_celsius_x10[yas533],
 	},
 };
 
-- 
2.35.1

