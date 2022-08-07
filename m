Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238F758BE42
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 01:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbiHGXHr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 19:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234631AbiHGXHo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 19:07:44 -0400
Received: from sonic309-25.consmr.mail.ir2.yahoo.com (sonic309-25.consmr.mail.ir2.yahoo.com [77.238.179.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A913B55A1
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 16:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1659913662; bh=s8hMp8JriMdWMFhNLLvIXtmbLU7UlvwcBiIrbiApJJg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ry03yBWDSNbfLcAUaQIVkfs5q4GU3fjG+Y6yUHTL7d4cCJmeqi8FmujvHaje68VfKz3gtkbXbJclz1a74Qy3coIZEVo3RInqjJuHusaaDvVsUsGolcC2QQy0efIfJabLAZnTnQeIBq91H0P1mey2omP4N6TAfmFVItqlUYa6kv25YJNGoOhLJcwp3veZ810xuvUS/+u5YZWMStRIIXYKSjEn1t2xYjyMvfWPUnmf8T4w0mdE/uub+b4BSHtmvOzdRaB68BLELk89J80Tym22lOD88iOOjU0dd0LrZz6iOT1x3eO0p35Hf4LuezHdlVs25T60kkd9WqzDhu3EkcsR3w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1659913662; bh=XKuHMD8mJ0DtEJLZO5tWGhBSLPcWtl+rEdnMOpRCEkS=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=WA1F19oBuZPdl/oQQW3fcbNl5KUS1KMwjJqArAqLl7dQCWuz3Xd2DlvfX5gK6+tkVF0GZ4wUmKkWoVal7HTulxZYQUe8v6MiBJ8oDiY0DyqdX7Y/1fSn2STtpMcfOBNRSFKnu5tcAmmPFq2Wr656Ph53R6Ko5da9h1vs8xh5BbNe2rV5YIzssFfZ3Bjr44XjsUtCmOxnRuHUEfD3gWeQJJs6EbnVSqd3qc0CGkAW5gIBKSc/WvvzTSDcewi0iGQ9jPKLAm7/JI2ffyRtIN9DW/SNFRB9KHSmdF/nOph6HnqDN28PbN9lVwykCl4qdxnC8YxUP9bnu9pxu5ljq+m8SA==
X-YMail-OSG: hx1UQhYVM1nARTMWneeAo5bIF2a.HPbXwCLMN_W5etC8xw.DewlzFRXs9oTDsec
 ngCoszBb6Ljgr0xaXD8Kk2eSbFmpQFhYiR7a9IJVY2cdgwL.lWXSWq28wCEiWpFa_LC2xmoN_Cw1
 iH4ksd4QXKld8kTtKRV1zFgcfDAQkuTj_Y3SscjzRvDaMBoyyWedveUS9AMQeKZ6KtJU2K3a8cpZ
 RDVWZrf4n4ZLYF3l3hZDWxqpvXwDT2oocSTgw8.yldM32G_FXEkshR7ECD_9nRXDBlwwInifpLwx
 3dulnW9QzdGnaEPW.y2qiJKPrkiCC7jYFRhQDYWVfrTX7kEu05J4oKyth.VZDuMylNlu4bZojQXr
 T3EwZM6pBu3WEGcuJor1DylL3KYrYb_ttGZLlzsD6a3Tw38zLCLEtEb6Vc6b64dks7s3bY10wa3V
 iDI2qYvJMTm0MXI6AU.fCez3BWEO4zfjETPwCghGFEGWx1m693wkEPfHkRQTRczfFetQN8d03z3D
 jX4wxcQfwk0mSoAIDLqGHE5VXm6sbFjZny3d8MxdUnE59grSLVBlR8k8ZflU_SlDsU5KSwkhqPbB
 lAL7LiXo81daXAsha43HVkU4uEjl5lrjjacRjH09VkAgnHy2XHPS4cpSWJO83cwFH7nym756icp7
 hdGycHTkOw9szIVlHICImbc_VidcdEx2ZO.GasDG2IL9cc2Wboh.B5I8hDgIeV67h1umFsN783bD
 qn9NhWuXIkbK9ogU.ZTxi_ULYsZf5k7yJ6r4mFCtPxS0jLS6wr33zSv1OnZEEFhbk9CohqPNM0cy
 lAhKeqD7zkPcFAznCuiBC2hM4_2yC5SgdOt50mk.cxFagwK7uLKJOoKNW.76dhwwbt9MYzZvT8Cj
 Bxl.mrEe79bHhn2.Z3WqV3ZIddozhrpJumWmDkGFw5VyRvWwoBRySt8luvRW9c5tzjLuR0qrlTJa
 D4oXbTLDpmaAPcyr_bfsmWUU6VTLhG1SQHIITTzq9LmivboJBWpmFTn1lDg6EHAY9VSkMS.LmCNW
 Q4ckfzJWs.bz6UOUl8YBysae1ZOl1eEPwPXP9zLbiFm.bDrJcYgLFDRedWS8ENucGgOBlha63J1J
 h0XPJlxWCrs.q3pv2FCkjreHjkHSchJfmttXl5j9.yVJC7Af8gHKqZSUZ8krLR06HanZIbWEdi0N
 MjsAkELakrhapTqrNocwA6DbmvnkHD9JHzMZpNmXBLnqjm_ydicArdQcCZNvVTQjXAgwzOLBc.am
 UfO.KOkbq1J2fIxkqMDIfAa7IZyxpKVtt5uiA0Fk7rXHp2goZru.BExgwY1mUAT2Gd70CVOwu6FL
 4U.jzBiWOhDgI0V1RlDKnDJTMp6QL9NZOBB0f0G3QY7nNuOJLUCElHVG7.NNPatScTlybjWz98Ib
 xKtfUAXFOtIuTWqGqLk7wbrFVAU2NeYENda52ZyN0VtOdg_UzOuxwFa7G0yXaA1dKhhPlRtAVmlL
 0NKAUgv2tvCVj1uWKi70A5ASUgIMGkIvL4YqzLmVhjB.VuAYqbVceq3yQEQ4bqZhs9Hd5SDJXlPW
 0Kwmohx1tm7a1OzE5llz3zt7w_mP5tbnh8Gl_BrXRkOT3RPdAfc6dlJVHD2SdE1G3VbfuY0NtuUB
 _IHjdjrWYyd9rkDmC2Cw.7LQO.USn63kck5ZnvSosiDJEVkgi_yFcv.jGPSZBHoKK7t05yTRJAaf
 DTKFrD.6vI90KX_1Dx3MksH4MlK65B1OUWxwX_4fJACjW5CcGve8wpuSwJRt77_0FEXYJVlMc7GS
 qtL3vMNGwL2suvhQYud9HLNLBVf0cXlWaymcApmH1OncZVDYMAd.I5QjvnnU.ERPKIWAm.tZESxs
 YuG8joLzmCaPrdtPpcZ9Bdzqty1Bpo0rFV8XIHcIJ.eXaKi3BEpqUdaUoLoEW9sTjO6ZpuVVLlKN
 RfDADw84oZMoSAEGWfqfRBjUdfGWadpB5K1LJSBDztJ6cp3rh_NataXEenC1NLxLzLMKxHd_oYd1
 KP.j2.VPo6jXE8zsNuJ9mtPQIMiCwn5Ffv5Zl.5eezGc37XMdfkWUevdhHEQJ2s582QthpH3j3eL
 W4nycXhALFLxUgoGMo0WvlmZlfZ7BS5iRSeUA8qEjQnzWEkx2EY97MqBQjzrnZraIThthuFlJMw4
 fvDrx6x3pOk2K2g.kK5bNPnkgM14t4QIajn23qGAYX5Mve7_.Rj30uO8Fu69pP9lQI7zEkXkyAvt
 1L2UOnDK8NZByqEZT8w40bgDb0mNbphMvNkoORfIuPKZF8QA..lZj6TXpOl9eHRtW2MyHQsIJPO2
 ISFvWFgFLDHN.q5oq
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ir2.yahoo.com with HTTP; Sun, 7 Aug 2022 23:07:42 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-2vqg6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID dc92a55cf24372a35650a28a19dee6ae;
          Sun, 07 Aug 2022 23:07:41 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v5 13/14] iio: magnetometer: yas530: Add function pointers to "chip_info"
Date:   Mon,  8 Aug 2022 01:06:52 +0200
Message-Id: <20ad0e793df229e71575c4e7d0bc4f6a5fb49f29.1659909060.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1659909060.git.jahau@rocketmail.com>
References: <cover.1659909060.git.jahau@rocketmail.com>
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

Add funtion pointers to the "chip_info" structure to ease the handling of
different YAS variants.

In the function yas5xx_probe(), the function call for "measure_offsets" was
added as a conditional "if (yas5xx->chip_info->measure_offsets)". This is a
preparatory step for YAS537, as this variant doesn't need an offset
measurement.

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 65 +++++++++++++++---------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 780c7f4d1eff..62d5f23d8e08 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -168,6 +168,11 @@ struct yas5xx;
  * @scaling_val2: scaling value for IIO_CHAN_INFO_SCALE
  * @t_ref: number of counts at reference temperature
  * @min_temp_x10: starting point of temperature counting in 1/10:s degrees Celsius
+ * @get_measure: function pointer to get a measurement
+ * @get_calibration_data: function pointer to get calibration data
+ * @dump_calibration: function pointer to dump calibration for debugging
+ * @measure_offsets: function pointer to measure the offsets
+ * @power_on: function pointer to power-on procedure
  */
 struct yas5xx_chip_info {
 	unsigned int devid;
@@ -178,13 +183,18 @@ struct yas5xx_chip_info {
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
  * @chip: enumeration of the device variant
- * @chip_info: device-specific data
+ * @chip_info: device-specific data and function pointers
  * @version: device version
  * @calibration: calibration settings from the OTP storage
  * @hard_offsets: offsets for each axis measured with initcoil actuated
@@ -488,7 +498,7 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_PROCESSED:
 	case IIO_CHAN_INFO_RAW:
 		pm_runtime_get_sync(yas5xx->dev);
-		ret = yas530_get_measure(yas5xx, &t, &x, &y, &z);
+		ret = yas5xx->chip_info->get_measure(yas5xx, &t, &x, &y, &z);
 		pm_runtime_mark_last_busy(yas5xx->dev);
 		pm_runtime_put_autosuspend(yas5xx->dev);
 		if (ret)
@@ -528,7 +538,7 @@ static void yas5xx_fill_buffer(struct iio_dev *indio_dev)
 	int ret;
 
 	pm_runtime_get_sync(yas5xx->dev);
-	ret = yas530_get_measure(yas5xx, &t, &x, &y, &z);
+	ret = yas5xx->chip_info->get_measure(yas5xx, &t, &x, &y, &z);
 	pm_runtime_mark_last_busy(yas5xx->dev);
 	pm_runtime_put_autosuspend(yas5xx->dev);
 	if (ret) {
@@ -941,6 +951,11 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
 		.scaling_val2 = 100000000, /* picotesla to Gauss */
 		.t_ref = t_ref_counts[yas530],
 		.min_temp_x10 = min_temp_celsius_x10[yas530],
+		.get_measure = yas530_get_measure,
+		.get_calibration_data = yas530_get_calibration_data,
+		.dump_calibration = yas530_dump_calibration,
+		.measure_offsets = yas530_measure_offsets,
+		.power_on = yas530_power_on,
 	},
 	[yas532] = {
 		.devid = YAS532_DEVICE_ID,
@@ -951,6 +966,11 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
 		.scaling_val2 = 100000, /* nanotesla to Gauss */
 		.t_ref = t_ref_counts[yas532],
 		.min_temp_x10 = min_temp_celsius_x10[yas532],
+		.get_measure = yas530_get_measure,
+		.get_calibration_data = yas532_get_calibration_data,
+		.dump_calibration = yas530_dump_calibration,
+		.measure_offsets = yas530_measure_offsets,
+		.power_on = yas530_power_on,
 	},
 	[yas533] = {
 		.devid = YAS532_DEVICE_ID,
@@ -961,6 +981,11 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
 		.scaling_val2 = 100000, /* nanotesla to Gauss */
 		.t_ref = t_ref_counts[yas533],
 		.min_temp_x10 = min_temp_celsius_x10[yas533],
+		.get_measure = yas530_get_measure,
+		.get_calibration_data = yas532_get_calibration_data,
+		.dump_calibration = yas530_dump_calibration,
+		.measure_offsets = yas530_measure_offsets,
+		.power_on = yas530_power_on,
 	},
 };
 
@@ -1031,35 +1056,25 @@ static int yas5xx_probe(struct i2c_client *i2c,
 		goto assert_reset;
 	}
 
-	switch (yas5xx->chip_info->devid) {
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
-		dev_err(dev, "unhandled device ID %02x\n",
-			yas5xx->chip_info->devid);
+	ret = yas5xx->chip_info->get_calibration_data(yas5xx);
+	if (ret)
 		goto assert_reset;
-	}
 
 	dev_info(dev, "detected %s %s\n", yas5xx->chip_info->product_name,
 		 yas5xx->chip_info->version_name[yas5xx->version]);
 
-	yas530_dump_calibration(yas5xx);
-	ret = yas530_power_on(yas5xx);
-	if (ret)
-		goto assert_reset;
-	ret = yas530_measure_offsets(yas5xx);
+	yas5xx->chip_info->dump_calibration(yas5xx);
+
+	ret = yas5xx->chip_info->power_on(yas5xx);
 	if (ret)
 		goto assert_reset;
 
+	if (yas5xx->chip_info->measure_offsets) {
+		ret = yas5xx->chip_info->measure_offsets(yas5xx);
+		if (ret)
+			goto assert_reset;
+	}
+
 	indio_dev->info = &yas5xx_info;
 	indio_dev->available_scan_masks = yas5xx_scan_masks;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -1155,7 +1170,7 @@ static int __maybe_unused yas5xx_runtime_resume(struct device *dev)
 	usleep_range(31000, 40000);
 	gpiod_set_value_cansleep(yas5xx->reset, 0);
 
-	ret = yas530_power_on(yas5xx);
+	ret = yas5xx->chip_info->power_on(yas5xx);
 	if (ret) {
 		dev_err(dev, "cannot power on\n");
 		goto out_reset;
-- 
2.35.1

