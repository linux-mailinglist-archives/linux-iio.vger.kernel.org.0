Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF4C59171B
	for <lists+linux-iio@lfdr.de>; Sat, 13 Aug 2022 00:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbiHLWF1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Aug 2022 18:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbiHLWF0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2022 18:05:26 -0400
Received: from sonic301-22.consmr.mail.ir2.yahoo.com (sonic301-22.consmr.mail.ir2.yahoo.com [77.238.176.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9C45FACE
        for <linux-iio@vger.kernel.org>; Fri, 12 Aug 2022 15:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1660341922; bh=jr2xytb/J/2n6Kd3wfYldek1d2bL7GKUO3ekuqQrFmw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=e7sTNEN7W6FMqKzxcT+x1SoTF9UjXmYSY0P/2R4sTjxP8wE9zAFgKdC6oLvCi0C2AxZfAAAdc2WprPKHO1DDtRgrxOAtB39cYCUVuCnHTv/DdWYaJjGxOv2SNEmdAXFu6skpy8LKy+IMujMCHbK1E4fjAXIbKoKfrvtaDpZBuVKIg0B2G/UWpCQlhV0BezJzU3pNp2bjSE8QEmtUD+rOLyacZ6jkmqinyRm/cr1d3RVgV0YYuGrGWXZ488Xuu2C4Bf/ZvpTXdMZdTqVEYZf8vA1JBdj6zzhuXpSZRrw0b4wQSDgtlLthJzGQlwifSUR7zaJwAlUE8nCW3rJV56NIJw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660341922; bh=88yQBi06fqvxFRvHA8z5fmgPw6cYF6LDK4uthjBdXlk=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=FkO5/IZ8qckWqpqp1/ymXo1+dUIVFYb+mb9IFyDYQhsbPJj3C26p1YK2iGViwDyhs6pbj0Btm7Ky95NbAX+C04qwebZVn+kYyyfSI4DRBn2JUzO+WfKgByOYFCsWbrq6W+xuMLS8LFWKR7bKb6OgymGUV0yTaviZwSUcVmrOcZM38cS6RTPi6RFSZEfmepSiCwKr1lSn4pJMGoCpIyRSYkyaBKfZ0otczEPS9o2n/EX9ubwIvtHGniyp4F00He6tZGqmbf/56bQ+YjhqL9EBRr3BSB3QCu8x0l3VOxbvB8N46qmxsenX6gXwpJ9bA2s3UadhmgH6aQfft2LFyDPVDA==
X-YMail-OSG: LlMz71oVM1m2cdm82sO9JqBSax_KJzNEBmUIKhOIu.y4YVIQyIRmtCn1cEwJBQk
 NfZs9ZxmAYG0Xl_DHBjz3VG8Rnb5V0djBgaYP4ZVEcFB_sWOEploa2sG4lFAjWgQkHIyGyxDbEZA
 RBsMCLYgnCRGbSgs4EVNu7oHo_HX14s9b7y11vp4iJYhH9rugUpKXd6TKc55nOnDl70OC.Bj__rC
 b8zgG9Ty.kP0qdTKUx8wAHBLf3uq4tzjxugJHJ5__YxgZPEXqNLKOyb_dTXGaFAucvFQ1rynJRiA
 _nfC89ExaTiWvHAmGjOLgo6BrnAz_zrrZZRgeyEVb43CKh8BXF5V0aJhsxsAK4413OCzY4xhmRNA
 ycDlVqYN.M9PFvKx0bh.4JEpUyb4eQIKgnLYO0JqmB8wwJwMlTKc0berTqJIJiIsrBGBwOQkOsGW
 yVRaBH2X5UWeCLTt9VQb_Zpb9fPVvTJx0kbwbhs.N7xMZA7aE.mo6zqc5ZCyd1XPo5_ALfJ0_OiA
 QbLPyY7wzWJqkNqSrhFv1IkLDYtehsyueLt8lP5js2xLdC9J7j24cFfgWb0C6CbiSQ8A_QX6sLrr
 aZx4I.1h9lzJofpjnHmbpdQBJkgAXZBXDjSx3wSZQ_voHyr0MghvNy9PuaAx_MArcL6Fb26EcxKB
 ePkOwETpwuZ5I_IiD_bMsYPXZvIsPM9OazYPfMoxjALz00LRMJgf3awNnUW7NB0DeufMYSWBT1O6
 2YK_66wWlmZl_TbgP2nRkjFf2R59VIyMAXGdxFBubIkvOWI9ObnCn2xPawPi5iTyRONDxXHwYrL9
 6pkNByIWURmC9Rq_iRRd1vOy_phn8EteIAUU66Ro4jpOCMEalhiTSaO2Gifl6cKaxhI7WN9sxmmA
 KfjZGnWTGLW7qUrOaEy8rBOOzVUomGRZg_AfCsdnV9ZehwWE4NV.YgsW8CjHou0gqeWcd8vdpTFH
 rFSu3D3a79mlJ.Trr0.RCRDpGOUnpsHNWWfCz8VdranUdjgRMFPeHZsjfOvkiVF2DBPIkjyKslGY
 nrqzcyLZZlZxsiCclv4NKak7SuXJh2Tm5xwTBKWW7B70KfBIBc7OKf7eSuCuG5lIpM0S.YcqPY9q
 NvXrTTOyfmhZjI2h9FyWl8A_Zf8mfu0r8odztuvhV9W6SJbpKSu.kY5eETNNI5Wy7b0jW19I5q9B
 p98YxcixvPiv6I6C0KCpkNj7X6rS3aZ_igjNzJtvqnbdjS1pjOAkBgMfATELlA3mQOK.6ezGZzj4
 c08m.8Oj.cuj6pzhJ7_N8BeUeU8GAJn.MixTn5nC4Kt.8.9QB76ubhtenRUPZ37atfIahMRBRpGN
 yEnNNMsHvlpynEHXkxNd_43mgJgLHUDDRpFQentYNddYHcFs0tBBtEFuZhLImoeBEsbZZ9oBYGkQ
 _ipzI.6W0svDrw.L2flXqRAz00T8QzWdiaYQJhALmbeL9n9DyivxLyHus7pL.vT.9dOXjXM53vlm
 HSt3KFAiUlXMD_hdRZwpVncUrgDIda44DZAF.zZKPF.vvkxjUqv422pxmLw8mRR4ekzbmbC7k1UC
 x.9CFSlioSE6nW0WjA0x9msTxbVKhc4BJ2gGdbLvT6Ad9MaFGAWmT0m1fcsLm1eZKfRB4lBDuwep
 pRWlglBFo8ecEe.NMh7uFlOUPZe2tcW8NH._g.0XSnKvMVK6j2XzQ2L6rk4KpaBZsRjsOvrI9SFY
 P6NbjmlKpuvPGAxYE0y6Cg_HtRe.4A8Tdbov0YAsM5XT7YEr18QkJPrO0T8UYBQsETg4a_.xqco0
 WCkcM27rYqWhJTQCCtiUiQkyBngqYamQ1weS6lAluaNQOVuhXgwW2kjedTJc2mmC.VNVs4UHSbeU
 V9BCFXGYNYBy5Ui6PUvxYhlm3iLPBbANR9RknyvkUefwDIhMwSSSSmvWXKuk9421APqNmxaC7Uav
 hJv291qMLbFMYrJKKLqERhz2rYijMtazJNygRaI2SQaJxiIAtTEqSkkOm9QtZoWFSi7F_8iDA37y
 WbwinyuLW4mis8u4ifYX9_ZlbAadNGhnQppryPikWeroeXdtVar8xnjNIGNwuVcMdD2Xv4aTsyHR
 TV2RQBIG0Xp9QevlNhIpNnLxsWJ.7rB5bIwkVh7r89NIFePbZNIAQOV4Vgofq2icUE_Uot7C0FGb
 zgwLM3wO812GuL6LvarEX0fVH_k876PtLdzeHKkrAUT82mrK5F55fte8eUpoH3KfFFElK6RX1zqU
 VePGSDwpvwnVEwyw2hM02MbQSyo.rDHESww6_GbK1DnOuHsBPd5iNVb7C.76_MrLXwztbZMl_Ty.
 UZCV4T43HsgWQJqU-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Fri, 12 Aug 2022 22:05:22 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-48gl8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c89c964524cd385a78dd9672c65b4e57;
          Fri, 12 Aug 2022 22:05:21 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v6 12/14] iio: magnetometer: yas530: Add temperature calculation to "chip_info"
Date:   Sat, 13 Aug 2022 00:05:01 +0200
Message-Id: <1a8bffdb7e807455620a73f2d61981e7f9aab8d5.1660337264.git.jahau@rocketmail.com>
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

Add temperature calculation to the "chip_info" structure to ease the handling
of different YAS variants.

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 123 ++++++++++-------------
 1 file changed, 54 insertions(+), 69 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index af5c090098fb..a5d3f0bff024 100644
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
@@ -131,6 +129,14 @@ struct yas5xx;
  * @volatile_reg: device-specific volatile registers
  * @volatile_reg_qty: quantity of device-specific volatile registers
  * @scaling_val2: scaling value for IIO_CHAN_INFO_SCALE
+ * @t_ref: number of counts at reference temperature 20 °C
+ * @min_temp_x10: starting point of temperature counting in 1/10:s degrees Celsius
+ *
+ * The "t_ref" value for YAS532/533 is known from the Android driver.
+ * For YAS530 it was approximately measured.
+ *
+ * The temperatures "min_temp_x10" are derived from the temperature resolutions
+ * given in the data sheets.
  */
 struct yas5xx_chip_info {
 	unsigned int devid;
@@ -139,6 +145,8 @@ struct yas5xx_chip_info {
 	const int *volatile_reg;
 	int volatile_reg_qty;
 	u32 scaling_val2;
+	u16 t_ref;
+	s16 min_temp_x10;
 };
 
 /**
@@ -337,6 +345,22 @@ static s32 yas530_linearize(struct yas5xx *yas5xx, u16 val, int axis)
 		(yas5xx->hard_offsets[axis] - c->r[axis]) * coef;
 }
 
+static s32 yas5xx_calc_temperature(struct yas5xx *yas5xx, u16 t)
+{
+	const struct yas5xx_chip_info *ci = yas5xx->chip_info;
+	s32 to;
+	u16 t_ref;
+	s16 min_temp_x10;
+	int ref_temp_x10;
+
+	t_ref = ci->t_ref;
+	min_temp_x10 = ci->min_temp_x10;
+	ref_temp_x10 = 200;
+
+	to = (min_temp_x10 + ((ref_temp_x10 - min_temp_x10) * t / t_ref)) * 100;
+	return to;
+}
+
 /**
  * yas530_get_measure() - Measure a sample of all axis and process
  * @yas5xx: The device state
@@ -352,7 +376,7 @@ static int yas530_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo,
 {
 	const struct yas5xx_chip_info *ci = yas5xx->chip_info;
 	struct yas5xx_calibration *c = &yas5xx->calibration;
-	u16 t_ref, t, x, y1, y2;
+	u16 t_ref, t_comp, t, x, y1, y2;
 	/* These are signed x, signed y1 etc */
 	s32 sx, sy1, sy2, sy, sz;
 	int ret;
@@ -367,47 +391,30 @@ static int yas530_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo,
 	sy1 = yas530_linearize(yas5xx, y1, 1);
 	sy2 = yas530_linearize(yas5xx, y2, 2);
 
-	/* Set the temperature reference value (unit: counts) */
-	switch (ci->devid) {
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
+	t_ref = ci->t_ref;
 	if (ci->devid == YAS532_DEVICE_ID &&
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
@@ -415,36 +422,8 @@ static int yas530_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo,
 	sy = sy1 - sy2;
 	sz = -sy1 - sy2;
 
-	/* Process temperature readout */
-	switch (ci->devid) {
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
@@ -935,6 +914,8 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
 		.volatile_reg = yas530_volatile_reg,
 		.volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
 		.scaling_val2 = 100000000, /* picotesla to Gauss */
+		.t_ref = 182, /* counts */
+		.min_temp_x10 = -620, /* 1/10:s degrees Celsius */
 	},
 	[yas532] = {
 		.devid = YAS532_DEVICE_ID,
@@ -943,6 +924,8 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
 		.volatile_reg = yas530_volatile_reg,
 		.volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
 		.scaling_val2 = 100000, /* nanotesla to Gauss */
+		.t_ref = 390, /* counts */
+		.min_temp_x10 = -500, /* 1/10:s degrees Celsius */
 	},
 	[yas533] = {
 		.devid = YAS532_DEVICE_ID,
@@ -951,6 +934,8 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
 		.volatile_reg = yas530_volatile_reg,
 		.volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
 		.scaling_val2 = 100000, /* nanotesla to Gauss */
+		.t_ref = 390, /* counts */
+		.min_temp_x10 = -500, /* 1/10:s degrees Celsius */
 	},
 };
 
-- 
2.35.1

