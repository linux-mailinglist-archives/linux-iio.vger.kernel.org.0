Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5E358BE3D
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 01:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiHGXHk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 19:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbiHGXHi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 19:07:38 -0400
Received: from sonic308-19.consmr.mail.ir2.yahoo.com (sonic308-19.consmr.mail.ir2.yahoo.com [77.238.178.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F66558B
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 16:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1659913654; bh=CfOunXujCoN/8Uh5lR6rRFFlbyWsLrhKulkfgGP1eFc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=GKPhWw3T23SA6XDGPcWFswBsAqk2TsHNPmcGWwPvBRWswTqjXBe+TaEcdPqt5gIs2CPA6I+iILRmrA3XjPk/PRB5QxgyUAbJOBKp89whZ4yX08MPjScB6IxfeHIGRdX0dblRzXn7rLzm1qti6da3SkITchNlWNGOuEzgEp6+n6vQcloo2c2HFtkACtThiGutX3arjLm0N83M+6bACNCCYFhNWMyZSmvgQkowqQCTMOo+HUyTkRDzR5JT6xJl+ETLGjf5sylgb63JG7C7/O+TcnK9MDHVWMPr8cThMjt2aSo0gInX/pc/0EjkqnaGEQC6/9nXxuI1hPo3o8DqjdqrxQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1659913654; bh=Ll+xCr+Ozm0u7kdN8rzg4L5fezoAjHMBkHVYdfeiBRN=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=qUiTbbtPUUC62BYQoAcbJymajmVcD77UiOuTxfKgEvP7N52tGchASisejXF2cO7+1BfPaRWfOcwHlIrE61BO4ZDcUGolzAcMzymVd2rca6W1tFR9W7LF/duuu899T3Hc8bXPewJFWzFpihheF1+VPjZYowl8f+3mGVZJSpkhRKux+75DR+lG9fPYhDWzge55pZO69Pc+dDn5ptuEQKzD6eh7riAc3EAP5KF/WcCbnTvH/ABD2iVosti7rObRdH3JpT9KEj99XjA8UQgqH54lpR//Had/1EoOPFZvuir59P++KZQwTODz1fAg+Pu0CyTE1Lior1+v+azx/pXI+KJzrA==
X-YMail-OSG: Sda1YSYVM1nbwDjoK6aVYi0UfInd_cyfvgRvCtpu_6qfSjl6PhdJfueo69RurEK
 5M5glmcO3kldVJ3Iqa64AGmR2zgq5RbtrJzGfr.0Ry9LU0KnXRmCt5CKdYCvLIAB5_i406vjj9Rf
 J.NG1gnD_EhPuRGJccJ7f4f4SZeSzOj6KJi9sq9UZV7Qd16cZpxcp8.pqudjfXmXcyW66Q_V7QLg
 Z4I68KZ9Z9oGKWF2Gc9mtoq_xrYr7A1PTm.I7EUZPez0hJdDXBncqTGIV9C5u1Kop.5e49apen2d
 4TSSaBMyUfD5.qgmoPof._pGMv7ZFLvR6J9zmKEJ.zFwk5e_Ymk1Du1E5WztWRfuCRKHfFHBqOzl
 cCkSkezHxSXiJaiaob5YAfe7_8gaeko0lKvjESRoMrUkOC2pcFnE0oI99EBfHmsuA64KI6ppZQFX
 HrLbhLd0GJsZm5cKwcujW05_0JqICvnhVjAEKq1M4lXu49FJB3yT49MEAwFiP5MM.PtnfQCF08DQ
 VN0dB3wY4SMwlOn0v95EOUIq3T5UshWt_th_zxjMUCae2aYdpOV81UR_Off4LyAH8pl8ULeCcFQ.
 QVsucGbql0mesmggjDgtgn5sR3aljorTNTMgTH7_HO4jDRXuOyYJiQKcwYTKjmi_shec.Ibq2No9
 Ubb9yFXqWaLPTAhLoVI7mSm3znFI2HWkgjX6c_VPlgXz2KjWlnyel4F6utuVqCnWwffevszZXJwD
 os8yjsBTpg1stwkyGk2kMZatuU.cpsqvRHf_JTXV09LB98I.TDI4QLrnDLMi2xtigxpS2l7vQ3Dy
 yZUSSEc32BY2DSQ40n_fKBkvwJGBlr4yLETlzzwq2QvFY0CD1khRMnp6mOTyAfDIK9NahVj5SOQ8
 UmboUX2rDJQjxpOvkT7F9CpjtpRK2D2.3DqE3.cZXlzRLoxf29VhOjktpwexRQ4A30In7ANqyZac
 m4ZP7PD9p_tyR_1L4t5Yvmta4U8MT4SMXAVYwolDteWvwa2zKaBq66j6JeHOr6eEEMMnJQadB4I9
 2ovikgaXZ_NE7eK67DC1fR14eEw3SCMPqgw3SoZRVnNePp.8K4c41As9oyQEwmFzCL63eRfXWcmC
 Q03vLQ.sQRDgJZ_0m5d6CooTzxpplhCjAaxYTof7tnKxMX7mAy1NVUdQwTmOjh7TsoDi9ClgkuEG
 wU9bhCf2T8rJUvSa.XGStMUDvzr2XnhJEIumQPN18g3LsBAigrtAFHpebsKbtz9a38ibGIGMp3HX
 dSFW5L5xrsN.9MrjXuVhAU4N2oR0Xnc1S.AJgUhGY9oqQ7Mpm2EQnMsl2RmHP0TqIqNFFNm8d99u
 JaW9u3Bofnda5goTmpMd3emjyMGu.Lww5xHvAjd4PEGO99sw1xdyAVnqtczZb9svsbQJxQ0OK1wX
 tFfP8RDQx6rlL1rJ879zP94TuwRLbLKnrlbtPpptGupahmrt3WGVxl3LtEM8T4kgsTO2HHc7ghBP
 YgGDilx1s0b6bzjlovMSDAtWMNJhR9W_hPTIQEfx0.JNlbJ_AFICVYUu50ruDBinQb5mYcXfu7.Q
 NLbTVxABXIgV5s3MPnlY6AS2J9kTXWWbNRLdi.lkI0Ei737JcfC72fCM1NclaJ8UxaQz33_sd8ud
 WPhL8lYiFKvSUhtiyqrW3v5OpWSIvlh7K7XaAKAg7L2Mw7tmI0OveIp8JDLS5JyROZS55DVFFhlw
 rGV7fl6tk1EEjc8W_K4GmVH_4xX1c7OZcGfEhRicacXkZHh1ou2dqSBSrku4eWxgHwbORDCYd.G2
 uY_FlzcPDbbaU2IdhCZphlnGxS3vio7eHw9bT2oaadngPLMlvnVIqsZXyXFcucV5pCao6Y0Kd39Z
 Q8TJYCc9282DIFsKM0gIEV4h.jo6rtx9wPf4xMXMD_mEkPHQhS6XqnxaOJTOGXTFa0arwB8GOeJ1
 1iiJh7ec5TYdtYpYhRttSdnZAOXSEh.rbmKlVf38b4uE6POCUfo1cGce9wht3fj3oN3GPr01uUQc
 GhqZoZyfBGf6Zeu6Z61xDVE9KtJsIcmc2WOLE8RBj3_vLXgkiNNYpeB9TiD8PQr9Yyao3ONRYJiP
 1.C5RvbnFDRLiSgT0c8bNLSnciPhVHCBfR9ZPCjLwiTO8GRr.Fk4qMhpHxDfhoNfKimdDYCLnTj9
 zsd4xycUATwlTwGy8E9Qly.njJ1ACPaGw.T0l2FAWDZ64ZcK_knVIf6nYFvv_39hw4wXJTYAY.lW
 e.XUaJZYGyRs6E4rnOHz0wveL2CeXTLbFgFXN473QMf2jZ6EvciAjYR0K7i.NhgC_thyFIEy0AuF
 u3q90X.D9Y.u9ekc-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Sun, 7 Aug 2022 23:07:34 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-2vqg6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID dc92a55cf24372a35650a28a19dee6ae;
          Sun, 07 Aug 2022 23:07:31 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v5 09/14] iio: magnetometer: yas530: Introduce "chip_info" structure
Date:   Mon,  8 Aug 2022 01:06:48 +0200
Message-Id: <8f5f58c9bf0f4006fabd01b5564af071d20f2a2d.1659909060.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1659909060.git.jahau@rocketmail.com>
References: <cover.1659909060.git.jahau@rocketmail.com>
MIME-Version: 1.0
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

This commit introduces the "chip_info" structure approach for better variant
handling.

The variant to be used is now chosen by the Device Tree (enum "chip_ids"),
not by the chip ID in the register. However, there is a check to make sure
they match (using integer "id_check").

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 107 ++++++++++++++++++-----
 1 file changed, 83 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index bf0aa64ac1a2..ecc2b61a5c4f 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -96,6 +96,24 @@
 /* Turn off device regulators etc after 5 seconds of inactivity */
 #define YAS5XX_AUTOSUSPEND_DELAY_MS	5000
 
+enum chip_ids {
+	yas530,
+	yas532,
+	yas533,
+};
+
+static const char * const yas5xx_product_name[] = {
+	"YAS530 MS-3E",
+	"YAS532 MS-3R",
+	"YAS533 MS-3F",
+};
+
+static const char * const yas5xx_version_names[][2] = {
+	[yas530] = { "A", "B" },
+	[yas532] = { "AB", "AC" },
+	[yas533] = { "AB", "AC" },
+};
+
 struct yas5xx_calibration {
 	/* Linearization calibration x, y1, y2 */
 	s32 r[3];
@@ -110,12 +128,26 @@ struct yas5xx_calibration {
 	u8 dck;
 };
 
+struct yas5xx;
+
+/**
+ * struct yas5xx_chip_info - device-specific data and function pointers
+ * @devid: device ID number
+ * @product_name: product name of the YAS variant
+ * @version_name: version letter or naming
+ */
+struct yas5xx_chip_info {
+	unsigned int devid;
+	const char *product_name;
+	const char * const *version_name;
+};
+
 /**
  * struct yas5xx - state container for the YAS5xx driver
  * @dev: parent device pointer
- * @devid: device ID number
+ * @chip: enumeration of the device variant
+ * @chip_info: device-specific data
  * @version: device version
- * @name: device name
  * @calibration: calibration settings from the OTP storage
  * @hard_offsets: offsets for each axis measured with initcoil actuated
  * @orientation: mounting matrix, flipped axis etc
@@ -129,9 +161,9 @@ struct yas5xx_calibration {
  */
 struct yas5xx {
 	struct device *dev;
-	unsigned int devid;
+	enum chip_ids chip;
+	const struct yas5xx_chip_info *chip_info;
 	unsigned int version;
-	char name[16];
 	struct yas5xx_calibration calibration;
 	s8 hard_offsets[3];
 	struct iio_mount_matrix orientation;
@@ -222,7 +254,7 @@ static int yas530_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y
 
 	mutex_unlock(&yas5xx->lock);
 
-	switch (yas5xx->devid) {
+	switch (yas5xx->chip_info->devid) {
 	case YAS530_DEVICE_ID:
 		/*
 		 * The t value is 9 bits in big endian format
@@ -276,7 +308,7 @@ static s32 yas530_linearize(struct yas5xx *yas5xx, u16 val, int axis)
 	s32 coef;
 
 	/* Select coefficients */
-	switch (yas5xx->devid) {
+	switch (yas5xx->chip_info->devid) {
 	case YAS530_DEVICE_ID:
 		if (yas5xx->version == YAS530_VERSION_A)
 			coef = YAS530_VERSION_A_COEF;
@@ -336,7 +368,7 @@ static int yas530_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo,
 	sy2 = yas530_linearize(yas5xx, y2, 2);
 
 	/* Set the temperature reference value (unit: counts) */
-	switch (yas5xx->devid) {
+	switch (yas5xx->chip_info->devid) {
 	case YAS530_DEVICE_ID:
 		t_ref = YAS530_20DEGREES;
 		break;
@@ -349,7 +381,7 @@ static int yas530_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo,
 	}
 
 	/* Temperature compensation for x, y1, y2 respectively */
-	if (yas5xx->devid == YAS532_DEVICE_ID &&
+	if (yas5xx->chip_info->devid == YAS532_DEVICE_ID &&
 	    yas5xx->version == YAS532_VERSION_AC) {
 		/*
 		 * YAS532 version AC uses the temperature deviation as a
@@ -384,7 +416,7 @@ static int yas530_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo,
 	sz = -sy1 - sy2;
 
 	/* Process temperature readout */
-	switch (yas5xx->devid) {
+	switch (yas5xx->chip_info->devid) {
 	case YAS530_DEVICE_ID:
 		/*
 		 * Raw temperature value t is the number of counts starting
@@ -473,7 +505,7 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
 		}
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		switch (yas5xx->devid) {
+		switch (yas5xx->chip_info->devid) {
 		case YAS530_DEVICE_ID:
 			/*
 			 * Raw values of YAS530 are in picotesla. Divide by
@@ -814,7 +846,7 @@ static int yas530_measure_offsets(struct yas5xx *yas5xx)
 		return ret;
 
 	/* When the initcoil is active this should be around the center */
-	switch (yas5xx->devid) {
+	switch (yas5xx->chip_info->devid) {
 	case YAS530_DEVICE_ID:
 		center = YAS530_DATA_CENTER;
 		break;
@@ -895,12 +927,31 @@ static int yas530_power_on(struct yas5xx *yas5xx)
 	return regmap_write(yas5xx->map, YAS530_MEASURE_INTERVAL, 0);
 }
 
+static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
+	[yas530] = {
+		.devid = YAS530_DEVICE_ID,
+		.product_name = yas5xx_product_name[yas530],
+		.version_name = yas5xx_version_names[yas530],
+	},
+	[yas532] = {
+		.devid = YAS532_DEVICE_ID,
+		.product_name = yas5xx_product_name[yas532],
+		.version_name = yas5xx_version_names[yas532],
+	},
+	[yas533] = {
+		.devid = YAS532_DEVICE_ID,
+		.product_name = yas5xx_product_name[yas533],
+		.version_name = yas5xx_version_names[yas533],
+	},
+};
+
 static int yas5xx_probe(struct i2c_client *i2c,
 			const struct i2c_device_id *id)
 {
 	struct iio_dev *indio_dev;
 	struct device *dev = &i2c->dev;
 	struct yas5xx *yas5xx;
+	int id_check;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*yas5xx));
@@ -947,33 +998,41 @@ static int yas5xx_probe(struct i2c_client *i2c,
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
+	if (id_check != yas5xx->chip_info->devid) {
+		ret = dev_err_probe(dev, -ENODEV,
+				    "device ID %02x doesn't match %s\n",
+				    id_check, id->name);
+		goto assert_reset;
+	}
+
+	switch (yas5xx->chip_info->devid) {
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
+		dev_err(dev, "unhandled device ID %02x\n",
+			yas5xx->chip_info->devid);
 		goto assert_reset;
 	}
 
+	dev_info(dev, "detected %s %s\n", yas5xx->chip_info->product_name,
+		 yas5xx->chip_info->version_name[yas5xx->version]);
+
 	yas530_dump_calibration(yas5xx);
 	ret = yas530_power_on(yas5xx);
 	if (ret)
@@ -985,7 +1044,7 @@ static int yas5xx_probe(struct i2c_client *i2c,
 	indio_dev->info = &yas5xx_info;
 	indio_dev->available_scan_masks = yas5xx_scan_masks;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->name = yas5xx->name;
+	indio_dev->name = id->name;
 	indio_dev->channels = yas5xx_channels;
 	indio_dev->num_channels = ARRAY_SIZE(yas5xx_channels);
 
@@ -1100,9 +1159,9 @@ static const struct dev_pm_ops yas5xx_dev_pm_ops = {
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

