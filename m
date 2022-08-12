Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C1A591721
	for <lists+linux-iio@lfdr.de>; Sat, 13 Aug 2022 00:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbiHLWFb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Aug 2022 18:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbiHLWF3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2022 18:05:29 -0400
Received: from sonic301-22.consmr.mail.ir2.yahoo.com (sonic301-22.consmr.mail.ir2.yahoo.com [77.238.176.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793FF6DF98
        for <linux-iio@vger.kernel.org>; Fri, 12 Aug 2022 15:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1660341927; bh=/EKCQ/W045XC71mexb1JnxWPWaTRucbF1YIpPiGxLEM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=r52xUdFMBB07M2RWC62kxXQJzKfv7hifkAWfFD5G9CwTPHTFUu5suZaYe0vUgpEoW2LAX8kc29stD8r7+TFoEzpwk8K8oc7HZX3KZftcIWrRXuRgFbJyJKmvLVWRtHd9Ug+Z5swyhmiMnBnCaz0TMV4FuV4ClrVwuBrMf4mUU9Jz4uaYq36zpftJUmk2fUZ7OGtUHIHlnX9SkBS2+BCOs9qBRewJ4jB6IpKWKEz5lLFo99IHb88JKkitYNyTQidHzBQwzIDnkauuZZnxqtmwQDqWqWRu7qVw1FyjhSN5+T1gej0Hh6cuv8i8ted+I9nVZj8nnnIdEiIbxB/QIO2vwA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660341927; bh=2fJcbDTsHGUEL4EZYoczl7RhJ/eVs0DPjLnUn9lpd+m=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=G8bbmUVDCdFJRj4GQheLBhf7jaPhXT/qKqYy2y6C67ex0MYMnhcyFbbiBPqzJnHSUvgYXUSHP3ah5arO/QozEzuTpJcHMP8z6s0ehFuQxiUOBMVvAJ+/FCHj4gitR/IfFng7UyA+XyQUBpgf/INkWa6xqix3ZQj0+/ZUfAP0/WHYjKF/cUvLuQz6JS1JWxl5atey/iPI/6xzu98NQ/MH97wqPY108abjMrmH0yA57mHaA6Wo/gOgaEcRW9AVELRUV0fLmpSajv7dlJg9xSdUjghdJee5hYVShC0nrdZxyc7OjOo6I9ODi7Z5R5/LSDMkR4id4q6/ksB8tgsdWFtm7g==
X-YMail-OSG: ErQ2Z2EVM1maSiISpRV7IafJutUO5L8E24It31QNYvHtw2ucFNC30SWcRl.ifml
 yHkp8L.gqGrL49h2TfxuS9DPLHqCfAiUkrNRHylFtfaaMEMP3WqjRU5hj.10RfFuw1DVN8KphGbr
 P0kQ8.yPAtYvy_xkK1Tyys38y9.3.980yawAuxNeKzXH6yn25tPx5FI65jp0snVXqWX5q3BoReX8
 iB8TgYhiBB2J9IS8sBABNqB8vhIwrUQciI.KS0FLOn.K28iFzyRrFvU3U1jMssaRk69VbucgchrB
 tfn2VsCIgg4cQZlh.ytqtznHQXPaYVC_s3MxY2X4xDfHacd5hmdwNTBnhMElqgObzqQYGwOzU8WJ
 Oi7rIAaI534PuzEen7GRr15HrJ9e4lNp3VPPl_rs_uGzz9EadCnxU.pk7PKyRKnQbeRJKG8fomnB
 0Lq2qmC.EwhsDbMHjHjrDRaeQW.ZR27msIFD_YhInm_cOqZ0RUEww_rW4Ss5rf5tvzcpfezx8jac
 TRIVCNBjvD5.Wu_Zj3Kh4Zp4uTukqwOcohNMumgkfyB4tHaxMwflVG6twNrkfUdWiur2IYcvzu1p
 .PgAgiVnvPulE0P5T8lTZ3KnL4ONTjvId6Q0kAcG7blcpjK3QkGUoICx8rTEoeRheHP430k1C5KY
 NZqD5OumLxEq12U6bPZffg6OfxrzK6mLvcyoja.MUCr6Y3BYySe3htYsPaA8WcNZseFJYvu0ylJg
 O3XOu3yEvZC07brlaYZ.8lt6fB5wuzzEe4NPnsG_.IF_WVsgBEYRyH5Wb6i9AS00PuNVfn9Qd8k1
 Fou6.acKoKnxHrTQ.GLa.G_TCuiaILtPHh1W5NuymUGIiL.zyPmqydz1Y8B2VpdS_0kgNbHKXYOr
 U4bbB5f1gb0XZin8U2w1m.DZMdmxEEXT1z_rmLNwaU8Vbw2CDtW55F2onhA_Duh8QfhxWZ_7.Fzd
 .U6S10sW8StnsFsOqyW9DDvcCGoBtTzYuFWP4ifKKN5A6r4L9B6uwdVnl_9PctYfeSKuSSPW_yDY
 utfmR6kfWXcsQpVapC.KMM8s330VTS1HPK58kePWSi38_m1VdfRdkKt_8aEZYx4eMGL3i8JjRDeI
 kwYFeBns0wsPRnUpcSWBI3C8YFjubUm6ZsCqRxjj2RbeZzSiKAdGAaSLViZAU_0cEoHfFxH__CCA
 T94rNFFgBFFVDOQuFFbG1Uwyo86ES6yWH4N.6Dti2LL4kXUp_Bse6TjlBhB.8DPyZpTixCwLObEy
 J2.4XRlwYzpmVGa4Vnwl9Ob1Yx7uSfWEw_c8tOMIdKy6BED77FgG_IQHt2boGtRHyZwFt_JpId1g
 fFWWz2I.gjmOvGDO6lQAtqFw5j.QFS.4Oa31LKCqJCy3bhUBvhVzUuQREfBdHzSfNuwuuazBzNO.
 tSRol6UOfodHbf8G_yBoTpfJXpotL2I_ZUhMP.PelSFqkJmBNWWLvvT0HaZXzpdhJ4Wmy0caC82k
 kdOGUcCK83BbSfcIyASlY3J6reCTLb_Bb4F35IEwxEkei0zBtNWxY5svNel0HmvSxKzNFkG_kzjm
 a2Vpq3YDsQpZIoZSYtV_zp6RnllvY29SVtZK28g31hCHclV8VDDN0SCkPmNdjjXjFcSaBTboo7.b
 g5P2SaO6ARnABOg49K0H1awRTSXIbXUwasknS__T96aGgDfkzuKsQe5Cw7czcZ8OHl8_fFNjH4qH
 sDVayi7hTv946BUbLrnfNirThHJFbq7BxkWFBDLsyMWUlpMcjUHR55uz2hIHaLAv5.NdsYm6bNB0
 .a3aBnyYlCe_SD8jopJKbwIK8n_zHTGllVT3nSaa8NIAnjanunJVZuIOV_zA2q8W84CUfwDhgYi8
 Z5gNc77Q4u3mC38nIKpM3ifkKhP4ikdnNUbe5LhWi1tYFTodHzbkp1Lxv1KEidtjjFRMSVkLh0J2
 Pa.MN6JOS0TjmP7u6Jf9Zh04QTHYnqol0Fr7k1NSZYY1Tagj4d5gdKVifZLIopxUadfS2pWiI76P
 Ojx9N8s7TM3BrMo_zM2IYwqmBe1DsceyUsUVot2hO8YRQY5D_hulBhBIwuVH175HylheAJuQSmEN
 ks_gQJ9mYPzt2cfu.oHr0TsYKLLyVfbY_86EGgTFsmO.HzKWtzVCjpojhRvinXbassuPsb5DWoOG
 DAQCyoKP_SH16BWANpoHCfZr9YTJc5LUe1mZzEpKMynmmdT7LJ9cMNqWNQiDa3Oa20FblzCqHRsw
 C6LKEK_LwfR6PgPwBTabd6fLnwRph5HOYUpl_B2oaUdRYmATmO2W.2cizZLcSEYZSobHRGcZY7Wb
 tjFz4rRxnvSuvgod9
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Fri, 12 Aug 2022 22:05:27 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-48gl8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c89c964524cd385a78dd9672c65b4e57;
          Fri, 12 Aug 2022 22:05:23 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v6 13/14] iio: magnetometer: yas530: Add function pointers to "chip_info"
Date:   Sat, 13 Aug 2022 00:05:02 +0200
Message-Id: <4bd3f96262e0132b7f9720521a801da3c18abd95.1660337264.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1660337264.git.jahau@rocketmail.com>
References: <cover.1660337264.git.jahau@rocketmail.com>
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

Add function pointers to the "chip_info" structure to ease the handling of
different YAS variants.

In the function yas5xx_probe(), the function call for "measure_offsets" was
added as a conditional "if (ci->measure_offsets)". This is a preparatory step
for YAS537, as this variant doesn't need an offset measurement.

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 66 +++++++++++++++---------
 1 file changed, 42 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index a5d3f0bff024..18933d8937ae 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -131,6 +131,11 @@ struct yas5xx;
  * @scaling_val2: scaling value for IIO_CHAN_INFO_SCALE
  * @t_ref: number of counts at reference temperature 20 °C
  * @min_temp_x10: starting point of temperature counting in 1/10:s degrees Celsius
+ * @get_measure: function pointer to get a measurement
+ * @get_calibration_data: function pointer to get calibration data
+ * @dump_calibration: function pointer to dump calibration for debugging
+ * @measure_offsets: function pointer to measure the offsets
+ * @power_on: function pointer to power-on procedure
  *
  * The "t_ref" value for YAS532/533 is known from the Android driver.
  * For YAS530 it was approximately measured.
@@ -147,12 +152,17 @@ struct yas5xx_chip_info {
 	u32 scaling_val2;
 	u16 t_ref;
 	s16 min_temp_x10;
+	int (*get_measure)(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo, s32 *zo);
+	int (*get_calibration_data)(struct yas5xx *yas5xx);
+	void (*dump_calibration)(struct yas5xx *yas5xx);
+	int (*measure_offsets)(struct yas5xx *yas5xx);
+	int (*power_on)(struct yas5xx *yas5xx);
 };
 
 /**
  * struct yas5xx - state container for the YAS5xx driver
  * @dev: parent device pointer
- * @chip_info: device-specific data
+ * @chip_info: device-specific data and function pointers
  * @version: device version
  * @calibration: calibration settings from the OTP storage
  * @hard_offsets: offsets for each axis measured with initcoil actuated
@@ -461,7 +471,7 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_PROCESSED:
 	case IIO_CHAN_INFO_RAW:
 		pm_runtime_get_sync(yas5xx->dev);
-		ret = yas530_get_measure(yas5xx, &t, &x, &y, &z);
+		ret = ci->get_measure(yas5xx, &t, &x, &y, &z);
 		pm_runtime_mark_last_busy(yas5xx->dev);
 		pm_runtime_put_autosuspend(yas5xx->dev);
 		if (ret)
@@ -497,11 +507,12 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
 static void yas5xx_fill_buffer(struct iio_dev *indio_dev)
 {
 	struct yas5xx *yas5xx = iio_priv(indio_dev);
+	const struct yas5xx_chip_info *ci = yas5xx->chip_info;
 	s32 t, x, y, z;
 	int ret;
 
 	pm_runtime_get_sync(yas5xx->dev);
-	ret = yas530_get_measure(yas5xx, &t, &x, &y, &z);
+	ret = ci->get_measure(yas5xx, &t, &x, &y, &z);
 	pm_runtime_mark_last_busy(yas5xx->dev);
 	pm_runtime_put_autosuspend(yas5xx->dev);
 	if (ret) {
@@ -916,6 +927,11 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
 		.scaling_val2 = 100000000, /* picotesla to Gauss */
 		.t_ref = 182, /* counts */
 		.min_temp_x10 = -620, /* 1/10:s degrees Celsius */
+		.get_measure = yas530_get_measure,
+		.get_calibration_data = yas530_get_calibration_data,
+		.dump_calibration = yas530_dump_calibration,
+		.measure_offsets = yas530_measure_offsets,
+		.power_on = yas530_power_on,
 	},
 	[yas532] = {
 		.devid = YAS532_DEVICE_ID,
@@ -926,6 +942,11 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
 		.scaling_val2 = 100000, /* nanotesla to Gauss */
 		.t_ref = 390, /* counts */
 		.min_temp_x10 = -500, /* 1/10:s degrees Celsius */
+		.get_measure = yas530_get_measure,
+		.get_calibration_data = yas532_get_calibration_data,
+		.dump_calibration = yas530_dump_calibration,
+		.measure_offsets = yas530_measure_offsets,
+		.power_on = yas530_power_on,
 	},
 	[yas533] = {
 		.devid = YAS532_DEVICE_ID,
@@ -936,6 +957,11 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
 		.scaling_val2 = 100000, /* nanotesla to Gauss */
 		.t_ref = 390, /* counts */
 		.min_temp_x10 = -500, /* 1/10:s degrees Celsius */
+		.get_measure = yas530_get_measure,
+		.get_calibration_data = yas532_get_calibration_data,
+		.dump_calibration = yas530_dump_calibration,
+		.measure_offsets = yas530_measure_offsets,
+		.power_on = yas530_power_on,
 	},
 };
 
@@ -1007,34 +1033,25 @@ static int yas5xx_probe(struct i2c_client *i2c,
 		goto assert_reset;
 	}
 
-	switch (ci->devid) {
-	case YAS530_DEVICE_ID:
-		ret = yas530_get_calibration_data(yas5xx);
-		if (ret)
-			goto assert_reset;
-		break;
-	case YAS532_DEVICE_ID:
-		ret = yas532_get_calibration_data(yas5xx);
-		if (ret)
-			goto assert_reset;
-		break;
-	default:
-		ret = -ENODEV;
-		dev_err(dev, "unhandled device ID %02x\n", ci->devid);
+	ret = ci->get_calibration_data(yas5xx);
+	if (ret)
 		goto assert_reset;
-	}
 
 	dev_info(dev, "detected %s %s\n", ci->product_name,
 		 ci->version_names[yas5xx->version]);
 
-	yas530_dump_calibration(yas5xx);
-	ret = yas530_power_on(yas5xx);
-	if (ret)
-		goto assert_reset;
-	ret = yas530_measure_offsets(yas5xx);
+	ci->dump_calibration(yas5xx);
+
+	ret = ci->power_on(yas5xx);
 	if (ret)
 		goto assert_reset;
 
+	if (ci->measure_offsets) {
+		ret = ci->measure_offsets(yas5xx);
+		if (ret)
+			goto assert_reset;
+	}
+
 	indio_dev->info = &yas5xx_info;
 	indio_dev->available_scan_masks = yas5xx_scan_masks;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -1114,6 +1131,7 @@ static int yas5xx_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct yas5xx *yas5xx = iio_priv(indio_dev);
+	const struct yas5xx_chip_info *ci = yas5xx->chip_info;
 	int ret;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(yas5xx->regs), yas5xx->regs);
@@ -1130,7 +1148,7 @@ static int yas5xx_runtime_resume(struct device *dev)
 	usleep_range(31000, 40000);
 	gpiod_set_value_cansleep(yas5xx->reset, 0);
 
-	ret = yas530_power_on(yas5xx);
+	ret = ci->power_on(yas5xx);
 	if (ret) {
 		dev_err(dev, "cannot power on\n");
 		goto out_reset;
-- 
2.35.1

