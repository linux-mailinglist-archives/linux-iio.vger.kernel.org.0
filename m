Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49089564A3A
	for <lists+linux-iio@lfdr.de>; Mon,  4 Jul 2022 00:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiGCWEm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Jul 2022 18:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiGCWEm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jul 2022 18:04:42 -0400
Received: from sonic311-31.consmr.mail.ir2.yahoo.com (sonic311-31.consmr.mail.ir2.yahoo.com [77.238.176.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184D52AC5
        for <linux-iio@vger.kernel.org>; Sun,  3 Jul 2022 15:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1656885878; bh=zhV4kNJHQ91AOiE3U+WxaLMR79nF0FGx7CXAYspbze0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=aVkuSHkVRC3e15Dgu4DrU3vm5j8H7u+GslK/jY5eaH2vQI8x0Hzh/CTrwWN3PWM2il43H5d/dHYddYlLraFdX1BNoMkRRv4HSnSALHapL56zut8vBseMIFryN/FEe614nGkErrkWj80l0QUmQBGYfcdc7PQ3N4qVvk/aegdPKQN6J0fz2GG/MFKxsuATz80VK3S9ZgcAb+PgrblhAdd83UW0IUFN4ypQalTsmyH6xENJfWF/rKkhFqKD8cZhFVaI6Yo3C/Jr05m7Pwqz5kczAurhsJPqDeagU2+zkQ1YELAcVazheKY1lG1gkY28mUE/Ot9ZZDByNfeAaWy2VQARJg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656885878; bh=tjfRZoKcJyn5uosTvxCJYVRbtC5sb9+/1SWTnI4GGDP=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=icTxwsIcCdMX5OYdEou/0CWs4WzEX3iz16gIImEDdOcaKXgQM9dxGtt4qhXhfeMxcL6wUy/10MCgYH7iE+sI1je7OmYGyirie63jXed1F59/Fu/tZBsJL61HuLpPksnEf6sxATur0D8N6+CgaS/3GOKN67SV1CilUnOzlpzLac+iAtPAb8Wv15Zu+M3t14oM5MLulm4W/69kva4+m5hoy+0l6dnVfiNMW61FbnzehcoxaS/4mQ9oTZKQTbAkF9wdfGZ5CCRiBKjNFzcpvcg+he3vexqFAryKMKzaXXQP/Z5bnuLnIMyUqvJG4gKZLGWZBvRAy2IlZ6IzaBKx906OVw==
X-YMail-OSG: DPGLBKMVM1nElwBL7_g9ZpYy00wPQTPFhhulvoMfC9OZHvaq7.psm5xj8GBZiqM
 QsJpQYfsylOIUpSo7Yxi4W88tAdOWJ1tbtsiUDrujgv5tMvwHI6bWSr4li78x.nYF57ISuu82_bZ
 Y8507sMfekIoJRyiQ0EjewkDXSApT8jFK00ouaRJIJtYD4LseoxYrd3ijRZJwyinf9yVvC44bkHa
 B6t56sxiMq3aLApl4abC7Oa43g4LFUY_7RMbSX219eDQg1Bh53ah94MuG9zA9qfnGUZ4NYjY32J7
 lMVWSQdpdH.dw5NZHdKH_M.N6ikDRIHNBZtuzIV_7qhXhD1_J1.U420WitbLOJUgrhg1AUyEoMmk
 lH9D9QFoMiZ0DGhUL5GjTN7klinU8yQ3uJZRw3SNfTpjOjkmkPL1E3LpXCBOjRhrOjNRY6v7dMwk
 nL8p83dnkMkesLDyojEsQmYvgVMDwNZN_Sg2RvGMwa8Vq1agcWewF4aEpnqqfcXdcxK1g83Td_rG
 6ci.F2sEAc_gXQeOSCJUUxRxcnS3gm0rE9fFlNe5onXtcLjXcrT0vpME_pg06wTnLO0h3tWBE6XA
 rU_y8hEbjfr_ohyU_MtgogIRcOrBnCAJhfyFWuj6WQzgPHCNyTfPtNfUSgekSL62VQzstmyMJZWl
 V8a.b65_xfZ.uqUAKb58ksMKaltQSLNCsrlUP8IETdgDMU_mFJCVdoroE4ld9zmgLkjLbFsubcNK
 1rwpUYPUJ.s2XQWEaBCZzGPT.razHtaJH3_YhmV_1sVILjyIIsuSdUrhVSpWCJHTDZkK.Ggd085R
 R89iNyAPStwjlruINrHjfINSTb.DBY0K4oPHrQfTwuhnDrJnxmwRTmdv8aVgF9VuT8t2DWeJBmFZ
 AF1TQYtDp5e2voSfiMDsX8tVGeuEGK6JqeDWKHBuXBG1nbBRwa9RBLmrOi3Df2aROXxmoP93tYL4
 M6nroal.zVw_wNhm2u5U1u1d6LHpqJ1KqDGPZTJ7rha3hoXwW_N6fplLPrYYQrzek95S1Q2Q260M
 GUntdpU9ZjXkoLN7t4QLCgopLXewogVoFVAhhc3xLfNEyukaVkvxRwevoZZXA60J8jidRZHpzHb2
 .p7ihBphYIXCBxvERxLl6XNBlccD0GkGnA7Vw0lJRsoFNaEBSfgtlLE6L5L0WpQmsZyHN1GrYOoo
 kruLF88FE1JG755NVT_GGBfIqbbsnO0OY7rTJCz75tUxyYGTa3TSfHrsfjvAZEilIJHTq7QwQ5IT
 T5RZdRVwqfpAv6V0C250t0hqfz.XKuxeRBLet10fVhauiQsgXOqULWzkRxmKycudTAfqPHa9XBba
 1ebXr7_Wmgmthy1WvlLq_w1YKyu2__vVSHySDuGo4fmDSbTN9d3luYoyJKo0.6RiBxf9lWsldMQg
 xRIYOQbRDxYfIq5ecd4cCTDXtXBYUUw6cQzi0t_Bgk3LawGiLKURYX1DJIbUd0m6ihNurJCAba3N
 eFXXh8kSgAAAgKlcSRUJjNHyl9BMXa8eK5m14bMDISqOtK6DwbgJZkvWwk4SufjBwIGvehzk6t.f
 NBRJ9cl27Nj_Z.7Kdp8lw.KEvzcvRu74Lb8iXQ_ryvGD8zBHUgVzvfonXsuz28ov_aGHiZ.az.Mj
 3bgaA97SqB0Sd9DWASzr2AhUKCbYHrGfnlXuxVoQcowSx6FZ1b5XSTqsqShxJPGQnL5AuJU.KjXU
 DMbpbJ7X3kpL9jlOzs4JHzNtxx2ZBYOtrd8eVWz9MMsyI6JlxVvUzmeEpzdBPJZNrYwTGDZ0j95W
 tZrF66sHIQNcj1xekGpKfUProMtTpImfl6_faWTwYpRViOos4NLaPrtrZHYWWEZtCGtJ7iI4Ks46
 _2FMPTqNmy7AMEsErC.GjNunromuvj0uchL0_VlCOWqV3mahEZ4Y9KH1xbRXbtVPp_5iu2rZf1BE
 .JEsqXSdvDJr3h.RNlxUZITdrstRkqsBmWhWxvHo335jQCrYgTa0hL1fRqwYwn6ZLD1xxB6u90QJ
 _7cOml0SkNT6V0StA20JWZV.ibpOUNyYdr_thTU56ZTbUlLbyoZoHh7pW0AfY3WHz9.zrLP9XTpy
 W9pDuvWtYLNxwrMf.UDZSFuKVP3db7bHlh1AcJImTozTMVeZs6ErN0j6675lV5FP.CJfLdPOLOI2
 6RlQ7oue.WhaE.kjg_sZT7zTvYg_wJ.bNdEbGwjpwkPeRWS2ZSa2r7lp4pOMAUppWzo2.eGbn_Ic
 UTDC8_qLFhFRAMEf6wigYPxyVMQG2SVQQvZvXX.tC22vTg4Mxl7LcvCIfllSTSjPWx_ws0crQByG
 LHqXsfABhO45EKIYV11Hkb8na
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ir2.yahoo.com with HTTP; Sun, 3 Jul 2022 22:04:38 +0000
Received: by hermes--canary-production-ir2-74b4d6d794-rsm7w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0750169e44cb0b4394403fc70acb325a;
          Sun, 03 Jul 2022 22:04:36 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v4 09/10] iio: magnetometer: yas530: Introduce "chip_info" structure
Date:   Mon,  4 Jul 2022 00:04:17 +0200
Message-Id: <28a2a9ec27c6fb4073149b897415475a8f04e3f7.1656883851.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1656883851.git.jahau@rocketmail.com>
References: <cover.1656883851.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This commit introduces the "chip_info" structure approach for better variant
handling.

The variant to be used is now chosen by the devicetree (enum "chip_ids"),
not by the chip ID in the register. However, there is a check to make sure
they match (using integer "id_check").

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
Result of the patch can be seen at:
https://github.com/Jakko3/linux/blob/28a2a9ec27c6fb4073149b897415475a8f04e3f7/drivers/iio/magnetometer/yamaha-yas530.c

 drivers/iio/magnetometer/yamaha-yas530.c | 314 +++++++++++++----------
 1 file changed, 182 insertions(+), 132 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 4e2f460a4efd..ce9c1077c121 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -79,7 +79,6 @@
 #define YAS530_DATA_BITS		12
 #define YAS530_DATA_CENTER		BIT(YAS530_DATA_BITS - 1)
 #define YAS530_DATA_OVERFLOW		(BIT(YAS530_DATA_BITS) - 1)
-#define YAS530_20DEGREES		182 /* Counts starting at -62 °C */
 
 #define YAS532_DEVICE_ID		0x02 /* YAS532/YAS533 (MS-3R/F) */
 #define YAS532_VERSION_AB		0 /* YAS532/533 AB (MS-3R/F AB) */
@@ -91,11 +90,39 @@
 #define YAS532_DATA_BITS		13
 #define YAS532_DATA_CENTER		BIT(YAS532_DATA_BITS - 1)
 #define YAS532_DATA_OVERFLOW		(BIT(YAS532_DATA_BITS) - 1)
-#define YAS532_20DEGREES		390 /* Counts starting at -50 °C */
 
 /* Turn off device regulators etc after 5 seconds of inactivity */
 #define YAS5XX_AUTOSUSPEND_DELAY_MS	5000
 
+enum chip_ids {
+	yas530,
+	yas532,
+	yas533,
+};
+
+static const char yas5xx_product_name[][13] = {
+	"YAS530 MS-3E",
+	"YAS532 MS-3R",
+	"YAS533 MS-3F"
+};
+
+static const char yas5xx_version_name[][2][3] = {
+	{ "A", "B" },
+	{ "AB", "AC" },
+	{ "AB", "AC" }
+};
+
+static const int yas530_volatile_reg[] = {
+	YAS530_ACTUATE_INIT_COIL,
+	YAS530_MEASURE
+};
+
+/* Number of counts between minimum and reference temperature */
+const u16 t_ref_counts[] = { 182, 390, 390 };
+
+/* Starting point of temperature counting in 1/10:s degrees Celsius */
+const s16 min_temp_celcius_x10[] = { -620, -500, -500 };
+
 struct yas5xx_calibration {
 	/* Linearization calibration x, y1, y2 */
 	s32 r[3];
@@ -110,12 +137,38 @@ struct yas5xx_calibration {
 	u8 dck;
 };
 
+struct yas5xx;
+
+/**
+ * struct yas5xx_chip_info - device-specific data and function pointers
+ * @devid: device ID number
+ * @volatile_reg: device-specific volatile registers
+ * @volatile_reg_qty: quantity of device-specific volatile registers
+ * @scaling_val2: scaling value for IIO_CHAN_INFO_SCALE
+ * @get_measure: function pointer to get a measurement
+ * @get_calibration_data: function pointer to get calibration data
+ * @dump_calibration: function pointer to dump calibration for debugging
+ * @measure_offsets: function pointer to measure the offsets
+ * @power_on: function pointer to power-on procedure
+ */
+struct yas5xx_chip_info {
+	unsigned int devid;
+	const int *volatile_reg;
+	const int volatile_reg_qty;
+	const u32 scaling_val2;
+	int (*get_measure)(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo, s32 *zo);
+	int (*get_calibration_data)(struct yas5xx *yas5xx);
+	void (*dump_calibration)(struct yas5xx *yas5xx);
+	int (*measure_offsets)(struct yas5xx *yas5xx);
+	int (*power_on)(struct yas5xx *yas5xx);
+};
+
 /**
  * struct yas5xx - state container for the YAS5xx driver
  * @dev: parent device pointer
- * @devid: device ID number
+ * @chip: enumeration of the device variant
+ * @chip_info: device-specific data and function pointers
  * @version: device version
- * @name: device name
  * @calibration: calibration settings from the OTP storage
  * @hard_offsets: offsets for each axis measured with initcoil actuated
  * @orientation: mounting matrix, flipped axis etc
@@ -129,9 +182,9 @@ struct yas5xx_calibration {
  */
 struct yas5xx {
 	struct device *dev;
-	unsigned int devid;
+	enum chip_ids chip;
+	struct yas5xx_chip_info *chip_info;
 	unsigned int version;
-	char name[16];
 	struct yas5xx_calibration calibration;
 	s8 hard_offsets[3];
 	struct iio_mount_matrix orientation;
@@ -221,7 +274,7 @@ static int yas530_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y
 
 	mutex_unlock(&yas5xx->lock);
 
-	switch (yas5xx->devid) {
+	switch (yas5xx->chip_info->devid) {
 	case YAS530_DEVICE_ID:
 		/*
 		 * The t value is 9 bits in big endian format
@@ -275,7 +328,7 @@ static s32 yas530_linearize(struct yas5xx *yas5xx, u16 val, int axis)
 	s32 coef;
 
 	/* Select coefficients */
-	switch (yas5xx->devid) {
+	switch (yas5xx->chip_info->devid) {
 	case YAS530_DEVICE_ID:
 		if (yas5xx->version == YAS530_VERSION_A)
 			coef = YAS530_VERSION_A_COEF;
@@ -305,6 +358,20 @@ static s32 yas530_linearize(struct yas5xx *yas5xx, u16 val, int axis)
 		(yas5xx->hard_offsets[axis] - c->r[axis]) * coef;
 }
 
+static s32 yas5xx_calc_temperature(struct yas5xx *yas5xx, u16 t)
+{
+	s32 to;
+	u16 t_ref;
+	int min_temp_x10, ref_temp_x10;
+
+	t_ref = t_ref_counts[yas5xx->chip];
+	min_temp_x10 = min_temp_celcius_x10[yas5xx->chip];
+	ref_temp_x10 = 200;
+
+	to = (min_temp_x10 + ((ref_temp_x10 - min_temp_x10) * t / t_ref)) * 100;
+	return to;
+}
+
 /**
  * yas530_get_measure() - Measure a sample of all axis and process
  * @yas5xx: The device state
@@ -318,7 +385,7 @@ static s32 yas530_linearize(struct yas5xx *yas5xx, u16 val, int axis)
 static int yas530_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo, s32 *zo)
 {
 	struct yas5xx_calibration *c = &yas5xx->calibration;
-	u16 t_ref, t, x, y1, y2;
+	u16 t_ref, t_comp, t, x, y1, y2;
 	/* These are signed x, signed y1 etc */
 	s32 sx, sy1, sy2, sy, sz;
 	int ret;
@@ -333,47 +400,30 @@ static int yas530_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo,
 	sy1 = yas530_linearize(yas5xx, y1, 1);
 	sy2 = yas530_linearize(yas5xx, y2, 2);
 
-	/* Set the temperature reference value (unit: counts) */
-	switch (yas5xx->devid) {
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
-	if (yas5xx->devid == YAS532_DEVICE_ID &&
+	/*
+	 * Set the temperature for compensation (unit: counts):
+	 * YAS532/YAS533 version AC uses the temperature deviation as a
+	 * multiplier. YAS530 and YAS532 version AB use solely the t value.
+	 */
+	t_ref = t_ref_counts[yas5xx->chip];
+	if (yas5xx->chip_info->devid == YAS532_DEVICE_ID &&
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
@@ -381,36 +431,8 @@ static int yas530_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo,
 	sy = sy1 - sy2;
 	sz = -sy1 - sy2;
 
-	/* Process temperature readout */
-	switch (yas5xx->devid) {
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
@@ -447,7 +469,7 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_PROCESSED:
 	case IIO_CHAN_INFO_RAW:
 		pm_runtime_get_sync(yas5xx->dev);
-		ret = yas5xx_get_measure(yas5xx, &t, &x, &y, &z);
+		ret = yas5xx->chip_info->get_measure(yas5xx, &t, &x, &y, &z);
 		pm_runtime_mark_last_busy(yas5xx->dev);
 		pm_runtime_put_autosuspend(yas5xx->dev);
 		if (ret)
@@ -471,27 +493,8 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
 		}
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		switch (yas5xx->devid) {
-		case YAS530_DEVICE_ID:
-			/*
-			 * Raw values of YAS530 are in picotesla. Divide by
-			 * 100000000 (10^8) to get Gauss.
-			 */
-			*val = 1;
-			*val2 = 100000000;
-			break;
-		case YAS532_DEVICE_ID:
-			/*
-			 * Raw values of YAS532 are in nanotesla. Divide by
-			 * 100000 (10^5) to get Gauss.
-			 */
-			*val = 1;
-			*val2 = 100000;
-			break;
-		default:
-			dev_err(yas5xx->dev, "unknown device type\n");
-			return -EINVAL;
-		}
+		*val = 1;
+		*val2 = yas5xx->chip_info->scaling_val2;
 		return IIO_VAL_FRACTIONAL;
 	default:
 		/* Unknown request */
@@ -506,7 +509,7 @@ static void yas5xx_fill_buffer(struct iio_dev *indio_dev)
 	int ret;
 
 	pm_runtime_get_sync(yas5xx->dev);
-	ret = yas5xx_get_measure(yas5xx, &t, &x, &y, &z);
+	ret = yas5xx->chip_info->get_measure(yas5xx, &t, &x, &y, &z);
 	pm_runtime_mark_last_busy(yas5xx->dev);
 	pm_runtime_put_autosuspend(yas5xx->dev);
 	if (ret) {
@@ -592,9 +595,24 @@ static const struct iio_info yas5xx_info = {
 
 static bool yas5xx_volatile_reg(struct device *dev, unsigned int reg)
 {
-	return reg == YAS5XX_ACTUATE_INIT_COIL ||
-		reg == YAS5XX_MEASURE ||
-		(reg >= YAS5XX_MEASURE_DATA && reg < YAS5XX_MEASURE_DATA + 8);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct yas5xx *yas5xx = iio_priv(indio_dev);
+	int i, j;
+
+	if (reg >= YAS5XX_MEASURE_DATA && reg < YAS5XX_MEASURE_DATA + 8)
+		return true;
+
+	/*
+	 * YAS versions share different registers on the same address,
+	 * need to differentiate.
+	 */
+	j = yas5xx->chip_info->volatile_reg_qty;
+	for (i = 0; i < j; i++) {
+		if (reg == yas5xx->chip_info->volatile_reg[i])
+			return true;
+	}
+
+	return false;
 }
 
 /* TODO: enable regmap cache, using mark dirty and sync at runtime resume */
@@ -811,7 +829,7 @@ static int yas530_measure_offsets(struct yas5xx *yas5xx)
 		return ret;
 
 	/* When the initcoil is active this should be around the center */
-	switch (yas5xx->devid) {
+	switch (yas5xx->chip_info->devid) {
 	case YAS530_DEVICE_ID:
 		center = YAS530_DATA_CENTER;
 		break;
@@ -892,13 +910,49 @@ static int yas530_power_on(struct yas5xx *yas5xx)
 	return regmap_write(yas5xx->map, YAS530_MEASURE_INTERVAL, 0);
 }
 
+static struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
+	[yas530] = {
+		.devid = YAS530_DEVICE_ID,
+		.volatile_reg = yas530_volatile_reg,
+		.volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
+		.scaling_val2 = 100000000, /* picotesla to Gauss */
+		.get_measure = yas530_get_measure,
+		.get_calibration_data = yas530_get_calibration_data,
+		.dump_calibration = yas530_dump_calibration,
+		.measure_offsets = yas530_measure_offsets,
+		.power_on = yas530_power_on,
+	},
+	[yas532] = {
+		.devid = YAS532_DEVICE_ID,
+		.volatile_reg = yas530_volatile_reg,
+		.volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
+		.scaling_val2 = 100000, /* nanotesla to Gauss */
+		.get_measure = yas530_get_measure,
+		.get_calibration_data = yas532_get_calibration_data,
+		.dump_calibration = yas530_dump_calibration,
+		.measure_offsets = yas530_measure_offsets,
+		.power_on = yas530_power_on,
+	},
+	[yas533] = {
+		.devid = YAS532_DEVICE_ID,
+		.volatile_reg = yas530_volatile_reg,
+		.volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
+		.scaling_val2 = 100000, /* nanotesla to Gauss */
+		.get_measure = yas530_get_measure,
+		.get_calibration_data = yas532_get_calibration_data,
+		.dump_calibration = yas530_dump_calibration,
+		.measure_offsets = yas530_measure_offsets,
+		.power_on = yas530_power_on,
+	}
+};
+
 static int yas5xx_probe(struct i2c_client *i2c,
 			const struct i2c_device_id *id)
 {
 	struct iio_dev *indio_dev;
 	struct device *dev = &i2c->dev;
 	struct yas5xx *yas5xx;
-	int ret;
+	int id_check, ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*yas5xx));
 	if (!indio_dev)
@@ -944,45 +998,41 @@ static int yas5xx_probe(struct i2c_client *i2c,
 		goto assert_reset;
 	}
 
-	ret = regmap_read(yas5xx->map, YAS5XX_DEVICE_ID, &yas5xx->devid);
+	yas5xx->chip = id->driver_data;
+	yas5xx->chip_info = &yas5xx_chip_info_tbl[yas5xx->chip];
+
+	ret = regmap_read(yas5xx->map, YAS5XX_DEVICE_ID, &id_check);
 	if (ret)
 		goto assert_reset;
 
-	switch (yas5xx->devid) {
-	case YAS530_DEVICE_ID:
-		ret = yas530_get_calibration_data(yas5xx);
-		if (ret)
-			goto assert_reset;
-		dev_info(dev, "detected YAS530 MS-3E %s",
-			 yas5xx->version ? "B" : "A");
-		strncpy(yas5xx->name, "yas530", sizeof(yas5xx->name));
-		break;
-	case YAS532_DEVICE_ID:
-		ret = yas532_get_calibration_data(yas5xx);
-		if (ret)
-			goto assert_reset;
-		dev_info(dev, "detected YAS532/YAS533 MS-3R/F %s",
-			 yas5xx->version ? "AC" : "AB");
-		strncpy(yas5xx->name, "yas532", sizeof(yas5xx->name));
-		break;
-	default:
+	if (id_check != yas5xx->chip_info->devid) {
 		ret = -ENODEV;
-		dev_err(dev, "unhandled device ID %02x\n", yas5xx->devid);
+		dev_err(dev, "device ID %02x doesn't match %s\n",
+			id_check, id->name);
 		goto assert_reset;
 	}
 
-	yas530_dump_calibration(yas5xx);
-	ret = yas530_power_on(yas5xx);
+	ret = yas5xx->chip_info->get_calibration_data(yas5xx);
 	if (ret)
 		goto assert_reset;
-	ret = yas530_measure_offsets(yas5xx);
+
+	dev_info(dev, "detected %s %s\n", yas5xx_product_name[yas5xx->chip],
+		 yas5xx_version_name[yas5xx->chip][yas5xx->version]);
+
+	yas5xx->chip_info->dump_calibration(yas5xx);
+
+	ret = yas5xx->chip_info->power_on(yas5xx);
+	if (ret)
+		goto assert_reset;
+
+	ret = yas5xx->chip_info->measure_offsets(yas5xx);
 	if (ret)
 		goto assert_reset;
 
 	indio_dev->info = &yas5xx_info;
 	indio_dev->available_scan_masks = yas5xx_scan_masks;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->name = yas5xx->name;
+	indio_dev->name = id->name;
 	indio_dev->channels = yas5xx_channels;
 	indio_dev->num_channels = ARRAY_SIZE(yas5xx_channels);
 
@@ -1074,7 +1124,7 @@ static int __maybe_unused yas5xx_runtime_resume(struct device *dev)
 	usleep_range(31000, 40000);
 	gpiod_set_value_cansleep(yas5xx->reset, 0);
 
-	ret = yas5xx_power_on(yas5xx);
+	ret = yas5xx->chip_info->power_on(yas5xx);
 	if (ret) {
 		dev_err(dev, "cannot power on\n");
 		goto out_reset;
@@ -1097,9 +1147,9 @@ static const struct dev_pm_ops yas5xx_dev_pm_ops = {
 };
 
 static const struct i2c_device_id yas5xx_id[] = {
-	{"yas530", },
-	{"yas532", },
-	{"yas533", },
+	{"yas530", yas530 },
+	{"yas532", yas532 },
+	{"yas533", yas533 },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, yas5xx_id);
-- 
2.35.1

