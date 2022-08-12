Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F15591700
	for <lists+linux-iio@lfdr.de>; Fri, 12 Aug 2022 23:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbiHLV7Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Aug 2022 17:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbiHLV7P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2022 17:59:15 -0400
Received: from sonic312-26.consmr.mail.ir2.yahoo.com (sonic312-26.consmr.mail.ir2.yahoo.com [77.238.178.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B401AB5143
        for <linux-iio@vger.kernel.org>; Fri, 12 Aug 2022 14:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1660341552; bh=4DWIioWw8aydWG5RN5ZpQ4gaiQLP6WsFfJYNUaD+nn8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=IgRjUE5MNyR7mUxCe3bWnXnhld2hiw19hntRj89g/jo8h7eTJ03sdChxct1Okxo+gHmvPuVDoaA9U5c0kdsBjZYncKmfc/7RXW91Q1+NRv7gqryOQCttr2fdfgpWy2gW3R0OYzTPIRKWg2VSD7fNp1RYaOdIGN8rNB97rVWNiSOdMLRp7WO681QoyEYY0n4YzqcXumP1x5iBhrFkNUv5aHtfMPyr4/E/rDdB3ojZip1KmbBvosA8bhUl/Gr0/2OGJgV3l9D/SHTHJBQtUBJTxuXUTSNWFk7ddl60WSO7vgQbDAEoof/SdEeQvbnREtMNjl+xnotAVww0QJZzplPYiQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660341552; bh=PKYX4hJwVuKR0KfCQNwkwHYsds34GG1jsl/faTVldP6=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=MNDCklcFKxGn24RfDTVbt9OYa8qytI8n5s+uEKwgtvlPirmgY2MKD6spxzKXsErHtz/+KNzNKUjmqmge/v0s3wOXxkfRgoD+6g1QVSvKNojGqWiafx3mm5sOIjEbYJYn0ca6wk0B6qj1awU+aZlPKhqN/j9phmOCHU7ziEvtV8/01EDOv7dN1ZDe4eYoFBopV3gWBZiO7tcZItDOw3ERxeOn5R/EODsuGLSFlLukX4V7qE1w4zTtyCmVK+SOvUcgttDZJQADqw0M9IWZbMvoyJUnrfyVE0xSZ6TpNthizSBjpyLaXtXsXBVJkIBg5h7hA1gwgW7nIekCtNv/ogJTVg==
X-YMail-OSG: SnTEAUwVM1lSiu6qevHKEbSIoq4DxsygTjzTohOADqu0jlsBcqPSruSYkypsFLs
 jlCeXfiNcrpixoatxP6wBcip8nPA4vCkXm_8ai.y67ofrfTAarLjQBbnc9KAawkT.lrnqRGj3ZLL
 cT6Xkyn61tvtNHfsmcO2BNqQO4GM6tUX_jgb0dlrPpIJjqzJvQlXKglsvHTzZNRsLKY02n6m5aHo
 40VcWRPeW8sANrvTRVq1lzg6tmERbfjSsgHnP9cK_hbUCeIJ30jk8dr_qv2Ew0rr86ZNdJqYsn4m
 VI1Top2wG1HUO2wBUR.muKZhXyhwCTAr4zqqN6tEOI8iiFM.u7CuezGAzt6JlBIbH1vqAZsZ1lox
 91lh_RVjv9cgPiWPTqM6TZyuO4Y2qRSTEH.CJqOWYlKxxZ8rjJM6C05zfGrKSxwsJ1Skc0oO6588
 elEuvOVEHS3F5P7wUA0L7H26qFs.yWCQJ_orB_dny9BeH3hbu8x0epSOr55UPOvvYaWZ6BMT2xuh
 W9lr1OLhN7lHapY4f7iBvNLn6NJsXpRHw4OJshuIiHhGCpqJC_uCgYOgeE9vskHYsgEbZ7yuc3li
 cigKxN.Wk2FrAPME4puGOWzWmtq_iGDdr0PrgOwKHNs1lDgmGF0OArSIiuowzpbcB6M2rTqPtIlX
 cX6g7xyN2Odi0raHd36.B5ItYYJFsZQye8.mtLPlVx8xpQQF4oDH6nSyF8tZHzeFA7BhFN5DY6_C
 XNnzfkERgGGWgNr5nWw57T_ndCLF5zo1_hTpHCwlLvhsX8ZApnR7mcb8Sl8lWJQaBzicJNGney8w
 KwOpwMqBbQoKFjgvxp8FHjt2JpZ8RZWoqkigRC0bn5aGz6rPcOEZrW0sAdw0LoM9e2JY8s3W46Gw
 WvJLL77rN0r4w39MOIIpY2Nj5M1hbxdebXrfrCAMCu7TZiaCbUSYYvsPPwRpSKO8RsOQPUOGW5bE
 xo5RKC4QYF1.REcxUVI.FrFY8hWV.qJ.EkdmpOdI_VYqjwB8AcQdzHSKw1uvSwXmPDN04qlss54c
 uR_JLJWZKAIAle24HAfMtq5KQLGRrl3LAGALYuCkw3WRFjgkgHfo0.sOXwmJc.OuF0GhIg90jm9s
 GDTLjrFaPRG1uKWkCMpzbB2YQL5S0aIf4jBR.oAd9M0oCeLrZ8GcCA6uoiMEORifmNR8JD3He5HO
 cOtbrLOEBwV0J1o1d2qt5P.OcROg7O3Z.xuXhPqKKsKKIIcKi2mYYPR8QO1abRNBejn9GSI1ezdi
 X5TvD1OJsfyVdw0knA4oAF728lBvo2bB9oiwk1O8ZSP1VVrnmTdxKbaz3BFwb9And7LhFlgEwMIu
 zCXqUqZ4YhZUzAm5kuMvTIfLbbGTMRa.2PYN12NeMoXxLvYEy3zSLXn.n2NE.Qr6nLp8FicHothV
 6p2M4mvqKr8yxTu7IySToLThsaEGr5cSLiGuV98gY3rWcdIrLLQN2uj5d8DN6wVMHcH8BEWHWBjx
 xQZIfUM0e4t7OqnU5jwAonaoYa1UH95LUjlcmI7tOs3UeqfsUJnQCBEKBdphhJ7Q1ZM89kaV.Qou
 eGOr.HuP0AUx8Ae1L5cB4KRpLqVUcdN1E2n4IjUjd4nQJmgbgGKjIwe4uFtq8MBqLT0VIMq6KI6I
 S4epI00n4nff_UmRSj3DVxQgT1Y3M8_yo.W3eVIR.RJxi24eB.jLwhH5l4z_CQY69I9mOLOUyD8o
 qt3ivtXm4e_cVk.lVpv6D.oaGgHdVupo_KqF_mPYzY3u.v9OTz0RBbPPw0qydbJAxcWgO.r_NxxJ
 D9zJx0Ne8ViwmvZOvq6lSoxNYWrTe97fZaljnDihoEJPteNxibB05JexC1NccondqqMzIFKySMtN
 Md0fouluQNHhNe6Jy9HRB23AQ8Gm9qNmhro3l8JQlxylnpPBzBlgjFCe6p2oGiFO1Lqj_wG3ujbD
 ZdF9VOB5R0JHojvNYVWFlDz1gZERkwiahJFCOuqfW1SvbbgcrV92mzsWhoO.rgGlidQLGYeGAvU.
 kFyY_MUpK8.abCxBfyO2XB5sKVivsKL9csdXBNkrtEHabR3yEGaRXZ_XYrwULdNmviCPmvHJgshW
 qwnPGDoyu.DgE6RY0pnKi5k9uEETsOHH3aADn3PH1ABT4iHuJQstYTtd1xMJc0ICe_B1s01SNIDu
 cAhTprRXSQwsNDuGhIRm5sY_CKmgXHPnMNO_P2Lz_x3lX.GDAddok6jwXYOQS7IRC4kbvgdefdy1
 KCN2xrXC3umCaEyywnqbpPJ4qkdKAm12x.cTNoUDWDbCZKNQ9vijX_N.fkOwRMNeEoidumsciQqR
 sAGsVA.dMxvkCmiU7HWTt
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Fri, 12 Aug 2022 21:59:12 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-5bdfc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID da2640015b5c2c3b63bd3f8312c2da46;
          Fri, 12 Aug 2022 21:59:08 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v6 09/14] iio: magnetometer: yas530: Introduce "chip_info" structure
Date:   Fri, 12 Aug 2022 23:54:14 +0200
Message-Id: <57236545107286771d351b95091bf56815d3717d.1660337264.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1660337264.git.jahau@rocketmail.com>
References: <cover.1660337264.git.jahau@rocketmail.com>
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

Introduce the "chip_info" structure approach for better variant handling.

The variant to be used is now chosen by the Device Tree (enum "chip_ids"),
not by the chip ID in the register. However, there is a check to make sure
they match (using integer "id_check").

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 98 ++++++++++++++++++------
 1 file changed, 74 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index f81868de5995..4fe7e8c820c3 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -96,6 +96,12 @@
 /* Turn off device regulators etc after 5 seconds of inactivity */
 #define YAS5XX_AUTOSUSPEND_DELAY_MS	5000
 
+enum chip_ids {
+	yas530,
+	yas532,
+	yas533,
+};
+
 struct yas5xx_calibration {
 	/* Linearization calibration x, y1, y2 */
 	s32 r[3];
@@ -110,12 +116,25 @@ struct yas5xx_calibration {
 	u8 dck;
 };
 
+struct yas5xx;
+
+/**
+ * struct yas5xx_chip_info - device-specific data and function pointers
+ * @devid: device ID number
+ * @product_name: product name of the YAS variant
+ * @version_names: version letters or namings
+ */
+struct yas5xx_chip_info {
+	unsigned int devid;
+	char *product_name;
+	char *version_names[2];
+};
+
 /**
  * struct yas5xx - state container for the YAS5xx driver
  * @dev: parent device pointer
- * @devid: device ID number
+ * @chip_info: device-specific data
  * @version: device version
- * @name: device name
  * @calibration: calibration settings from the OTP storage
  * @hard_offsets: offsets for each axis measured with initcoil actuated
  * @orientation: mounting matrix, flipped axis etc
@@ -129,9 +148,8 @@ struct yas5xx_calibration {
  */
 struct yas5xx {
 	struct device *dev;
-	unsigned int devid;
+	const struct yas5xx_chip_info *chip_info;
 	unsigned int version;
-	char name[16];
 	struct yas5xx_calibration calibration;
 	s8 hard_offsets[3];
 	struct iio_mount_matrix orientation;
@@ -192,6 +210,7 @@ static u16 yas532_extract_axis(u8 *data)
  */
 static int yas530_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y2)
 {
+	const struct yas5xx_chip_info *ci = yas5xx->chip_info;
 	unsigned int busy;
 	u8 data[8];
 	int ret;
@@ -222,7 +241,7 @@ static int yas530_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y
 
 	mutex_unlock(&yas5xx->lock);
 
-	switch (yas5xx->devid) {
+	switch (ci->devid) {
 	case YAS530_DEVICE_ID:
 		/*
 		 * The t value is 9 bits in big endian format
@@ -267,6 +286,7 @@ static int yas530_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y
 /* Used by YAS530, YAS532 and YAS533 */
 static s32 yas530_linearize(struct yas5xx *yas5xx, u16 val, int axis)
 {
+	const struct yas5xx_chip_info *ci = yas5xx->chip_info;
 	struct yas5xx_calibration *c = &yas5xx->calibration;
 	static const s32 yas532ac_coef[] = {
 		YAS532_VERSION_AC_COEF_X,
@@ -276,7 +296,7 @@ static s32 yas530_linearize(struct yas5xx *yas5xx, u16 val, int axis)
 	s32 coef;
 
 	/* Select coefficients */
-	switch (yas5xx->devid) {
+	switch (ci->devid) {
 	case YAS530_DEVICE_ID:
 		if (yas5xx->version == YAS530_VERSION_A)
 			coef = YAS530_VERSION_A_COEF;
@@ -319,6 +339,7 @@ static s32 yas530_linearize(struct yas5xx *yas5xx, u16 val, int axis)
  */
 static int yas530_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo, s32 *zo)
 {
+	const struct yas5xx_chip_info *ci = yas5xx->chip_info;
 	struct yas5xx_calibration *c = &yas5xx->calibration;
 	u16 t_ref, t, x, y1, y2;
 	/* These are signed x, signed y1 etc */
@@ -336,7 +357,7 @@ static int yas530_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo,
 	sy2 = yas530_linearize(yas5xx, y2, 2);
 
 	/* Set the temperature reference value (unit: counts) */
-	switch (yas5xx->devid) {
+	switch (ci->devid) {
 	case YAS530_DEVICE_ID:
 		t_ref = YAS530_20DEGREES;
 		break;
@@ -349,7 +370,7 @@ static int yas530_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo,
 	}
 
 	/* Temperature compensation for x, y1, y2 respectively */
-	if (yas5xx->devid == YAS532_DEVICE_ID &&
+	if (ci->devid == YAS532_DEVICE_ID &&
 	    yas5xx->version == YAS532_VERSION_AC) {
 		/*
 		 * YAS532 version AC uses the temperature deviation as a
@@ -384,7 +405,7 @@ static int yas530_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo,
 	sz = -sy1 - sy2;
 
 	/* Process temperature readout */
-	switch (yas5xx->devid) {
+	switch (ci->devid) {
 	case YAS530_DEVICE_ID:
 		/*
 		 * Raw temperature value t is the number of counts starting
@@ -442,6 +463,7 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
 			   long mask)
 {
 	struct yas5xx *yas5xx = iio_priv(indio_dev);
+	const struct yas5xx_chip_info *ci = yas5xx->chip_info;
 	s32 t, x, y, z;
 	int ret;
 
@@ -473,7 +495,7 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
 		}
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		switch (yas5xx->devid) {
+		switch (ci->devid) {
 		case YAS530_DEVICE_ID:
 			/*
 			 * Raw values of YAS530 are in picotesla. Divide by
@@ -802,6 +824,7 @@ static s8 yas530_adjust_offset(s8 old, int bit, u16 center, u16 measure)
 /* Used by YAS530, YAS532 and YAS533 */
 static int yas530_measure_offsets(struct yas5xx *yas5xx)
 {
+	const struct yas5xx_chip_info *ci = yas5xx->chip_info;
 	int ret;
 	u16 center;
 	u16 t, x, y1, y2;
@@ -814,7 +837,7 @@ static int yas530_measure_offsets(struct yas5xx *yas5xx)
 		return ret;
 
 	/* When the initcoil is active this should be around the center */
-	switch (yas5xx->devid) {
+	switch (ci->devid) {
 	case YAS530_DEVICE_ID:
 		center = YAS530_DATA_CENTER;
 		break;
@@ -895,12 +918,32 @@ static int yas530_power_on(struct yas5xx *yas5xx)
 	return regmap_write(yas5xx->map, YAS530_MEASURE_INTERVAL, 0);
 }
 
+static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
+	[yas530] = {
+		.devid = YAS530_DEVICE_ID,
+		.product_name = "YAS530 MS-3E",
+		.version_names = { "A", "B" },
+	},
+	[yas532] = {
+		.devid = YAS532_DEVICE_ID,
+		.product_name = "YAS532 MS-3R",
+		.version_names = { "AB", "AC" },
+	},
+	[yas533] = {
+		.devid = YAS532_DEVICE_ID,
+		.product_name = "YAS533 MS-3F",
+		.version_names = { "AB", "AC" },
+	},
+};
+
 static int yas5xx_probe(struct i2c_client *i2c,
 			const struct i2c_device_id *id)
 {
 	struct iio_dev *indio_dev;
 	struct device *dev = &i2c->dev;
 	struct yas5xx *yas5xx;
+	const struct yas5xx_chip_info *ci;
+	int id_check;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*yas5xx));
@@ -947,33 +990,40 @@ static int yas5xx_probe(struct i2c_client *i2c,
 		goto assert_reset;
 	}
 
-	ret = regmap_read(yas5xx->map, YAS5XX_DEVICE_ID, &yas5xx->devid);
+	yas5xx->chip_info = &yas5xx_chip_info_tbl[id->driver_data];
+	ci = yas5xx->chip_info;
+
+	ret = regmap_read(yas5xx->map, YAS5XX_DEVICE_ID, &id_check);
 	if (ret)
 		goto assert_reset;
 
-	switch (yas5xx->devid) {
+	if (id_check != ci->devid) {
+		ret = dev_err_probe(dev, -ENODEV,
+				    "device ID %02x doesn't match %s\n",
+				    id_check, id->name);
+		goto assert_reset;
+	}
+
+	switch (ci->devid) {
 	case YAS530_DEVICE_ID:
 		ret = yas530_get_calibration_data(yas5xx);
 		if (ret)
 			goto assert_reset;
-		dev_info(dev, "detected YAS530 MS-3E %s",
-			 yas5xx->version ? "B" : "A");
-		strncpy(yas5xx->name, "yas530", sizeof(yas5xx->name));
 		break;
 	case YAS532_DEVICE_ID:
 		ret = yas532_get_calibration_data(yas5xx);
 		if (ret)
 			goto assert_reset;
-		dev_info(dev, "detected YAS532/YAS533 MS-3R/F %s",
-			 yas5xx->version ? "AC" : "AB");
-		strncpy(yas5xx->name, "yas532", sizeof(yas5xx->name));
 		break;
 	default:
 		ret = -ENODEV;
-		dev_err(dev, "unhandled device ID %02x\n", yas5xx->devid);
+		dev_err(dev, "unhandled device ID %02x\n", ci->devid);
 		goto assert_reset;
 	}
 
+	dev_info(dev, "detected %s %s\n", ci->product_name,
+		 ci->version_names[yas5xx->version]);
+
 	yas530_dump_calibration(yas5xx);
 	ret = yas530_power_on(yas5xx);
 	if (ret)
@@ -985,7 +1035,7 @@ static int yas5xx_probe(struct i2c_client *i2c,
 	indio_dev->info = &yas5xx_info;
 	indio_dev->available_scan_masks = yas5xx_scan_masks;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->name = yas5xx->name;
+	indio_dev->name = id->name;
 	indio_dev->channels = yas5xx_channels;
 	indio_dev->num_channels = ARRAY_SIZE(yas5xx_channels);
 
@@ -1096,9 +1146,9 @@ static DEFINE_RUNTIME_DEV_PM_OPS(yas5xx_dev_pm_ops, yas5xx_runtime_suspend,
 				 yas5xx_runtime_resume, NULL);
 
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

