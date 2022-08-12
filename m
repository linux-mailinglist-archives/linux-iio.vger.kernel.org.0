Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347505916F6
	for <lists+linux-iio@lfdr.de>; Fri, 12 Aug 2022 23:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiHLV5D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Aug 2022 17:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiHLV5A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2022 17:57:00 -0400
Received: from sonic308-18.consmr.mail.ir2.yahoo.com (sonic308-18.consmr.mail.ir2.yahoo.com [77.238.178.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89722B443D
        for <linux-iio@vger.kernel.org>; Fri, 12 Aug 2022 14:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1660341417; bh=NHYENK3/2zrXtIKxNQM0pVoNCqaTCcdUoYVQRHxdJwQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=tN4RUISAr6O8OHTNmwebzcrXbHaqVhfrYtcy8bmUeuaw/gWXSd7MJNvsd1P+l5xaMw4ZyyXQVNAr+Nx92tXOI95VKfE60qW71ir7Vv8C9tzA2JmHMTvDwIhKf8P2V1Nlmoj9UJvZ2Y/yW0hs21pkZ3n8C9hX+zSbYB5y9uaGPKmmO9JWJrlX36Nq0txvWQi5scSCOQGe+JumcuPx2IO6dGka56SNUyQjUmW3vjDejzX6HusMtPvBwhg/LIkOcrfRYimltpKCD8rUh1WszXbN4SARYexK/wjSXOrJqnWMC0s37AbYROGdUYXkw6L8y5OhzcI64Jcc4f+qwA5OcdDp1w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660341417; bh=lXp/T7mL7tnuMqHKVc9INrCzk1ZxzsDVgPSSkGE+lgp=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=D+fNhGup1y+jAZQukYH1xtDPDS+ukN9xBo/ehlA1n+aXHxsBxk4LiJJjtsp+UFs5JNurFG0FbvZVUJRNUyKG3cawIiPEovDWyKwrEy+mGtaqQKfya/+/OJwmj/NHtBMG/u5dqiEkeIGCy6ALX6ZXDL3BUAdlAlFPHUvmgfxcrRFqlzjKNWxOG2nmXnqqy5MMQ3skCyCZOE3JJ0A8oPaDLzRocYTEtSl2Hx3G1Yhwt8sX1Vkz7oGwmRReK2/vsnSKVsgisRxRBB/antbVi8phDD9ihtLfIZcOvuEvhTKOKM7B2ayn0BS9OOwfx6zyz/o5vfySQnstr5xkIi37yJpLYg==
X-YMail-OSG: RH58FRcVM1lR8bTmTV5waZVGXGr8mU_rVkx1uNp6Zpy3eQJsyTNXFVLbLOnGDc8
 jriLa4OPTXVPvxr.Sl0dF3KxkCjuagyelpLFAdTJqHkhNsE0sq.rm.7ujePSPYUIbpsIQev7f6FV
 8mmb9LEgpHT0VFpukzDuGjdv8ITN6jvmXssUA0bMSh5GLnNyN6aDZXG1pAWxQ_cblfhYVjUnV4mW
 F87CiluWBP85V1xYozC9YarSg6IXd9DhFp0ZjAQjzOEm6lOy3vPe.18.fluc8CJCbnBnENikQhfC
 DFLE408_Z3Sj.jYmYfiKQLQpRFGDgjzahSYUf4_Tw.4wvWgm.NpFafYzMx9Mju45OfvJ_lEr3BYo
 VxwCwESEYUeWiLCNiMWVBwSjm_ZiDfsuqS3COvtRo3a__Tefi.pZJMl3.XNVkKYmzbgavfGK4nG9
 tI3Xi1VpUnnbi6BX9EIOTWYpgZWmL17iUSuYchQ8HzgWG_x078ViFHX.XZOdQORwKNxX6ixoLjN7
 JddUM0d9LyOTmGHRiGmj.ONA28Rmrwre8FCQDrVhM844SNV2Qvek_Mc5YGJhwpr_pgZSfkf_y_jT
 8zETapABhYv9yryoYcVL3JVBT5HAYl.yozOmG6vAbu6PIptOkJShu4iwnv1.2DAIpsUUwDg2nXJt
 mRf.HQ9AWHUygBBsZeXldWwteBJOXi5Dqv4Z.ddPGmJLsGIs5ukVjFm8deMP7v.blt43up7wlrQR
 kENsgLD9eIbulufMX1fsNLzyC7.dNPb33Iw3livc_sOmr24qufCUrMCojF7kxN_0vJOYKGmYZHR7
 q5iZwGNYsiZ8uwOqpeobT4.o0wEvoX8Y4ph3dLwdtvLOiDPJMGaxqMA2jZEb71vqW2mwGQ5qk1g9
 7jEE.cUXxJ28_J6ZIMzEb9R2jJuOVxgq7ViJpjW7aLoaaiUQEfNYGmRMCQfYDzanNMPgFjRGX_GL
 6ZJEP2XJ_i3uJd8HFVBBmBp1r.ElXHi25rTIH.nPXTt5HfMC32PFlBjzu4nKDhr1FyKRHHdt1WO2
 A.Z8gVXUrjtzq68iEp9N7ZwTODL2DHGPRyNg2eUKEBN_jSfrI_KarX8jjupo62fNqtZQbupCTG7H
 MLy1QLRkmOtUXDpg24wyCLixCDjMLpvP5T2fuWwWsN0aNR_E9XtZys2Hh_y10y0rIMYp2IVSb3jI
 qo0Wk.iRS0yO2.EnhejzUmatN6VhVBetO4dsIyQRM_b2l96aZa5wq.1BzNWIvcMgLc3qy0AXEBHJ
 9TQor0tSZ7dV9acqAPCVA039sQiynV46d2MCxpR.bgDdM6Z5gosChXvXYErAF5GnwbhxrB.Alcho
 oQ2whA6qWonzjwei3otcl4p4anU3oLWqYEe1sv9ngzO5cHhtVL.zjCb5qv4IPc3e8DMdGPVlcOXz
 nMgHLqVWuGRH_AQ_5nqMeghVlkhOSo42Wsbgj2kmVvMpXEROPC_SFuvxpPyjoSPCBz_efuCGAYl7
 k5.gy46ssBirxWiQfhPugBVJWXa.NI99c5Mw88rFsG67_SveKfNL2mBxy2o1h.E2A8c4xmgTf0N3
 ymLXHpwa82YTRrjlcJw_bFy_zqj03YwH2PX0lQW4iGExWf3S5unBWMQwQSOpDnbLh978eHqqZGTQ
 2bSgnlYsdGG3WJYMG3s__MO5FxOXgz_JrDqFLsiYDp92_WiHABNMZHo39RYaaAI8VCQzk0J4Hm97
 MQJ1H1jher3ofEdcy21KngLt1u.3R7J.y1N3sfhSjKI1XjFjNeGHYc2T5Wd1h9yLEaZrL.PXeSSn
 A6xJmvLpv.k7hsnDLkmIXTP3Y8FjE7L_2mpE_PHDZPbOWf9ZvFHG_fvReLutnddCLcRt1PIvW6CH
 MLyszIRkxhWzs6uzmMFJsX70iWnsT4G2.d4Y9lP70vmEuHDEyYaztLj1F7DPEJJquWJ.2Sno2sqe
 SwJaUt6p_._D3M94_2qlrDJ_4UeNoHxZlr2bq55Ern6G9G2eu1Y92Jy.LF9YnH2hTkowLRWL2IYi
 hnFv1ZvCsOQuGJcNn7IDs6CAbmdoVdtoVK8yD33AMTWQri7h42WNFjp0kOb4Xmfb1.OR89X.AH5Y
 KwtI5Hjxe4S6tNLl7f4cBjgZmG_dpYrCEXcFseALJ7B2m2EvwTpiNkxw5LRJ0vxbwdJnNZsjA.IP
 SFFkQzOR9.Pyb0lmOZ9ZuhPW361qhg0PvUoXCI6BoO1W2GpJGDWj.sU552NFkJjYDC4zJbYkXZao
 _veMoiYqUhuBWd8J9vz_njW94V5OlvQzdSlUNozFkMPDnY4bEcsLoEpFCXULGaw5EjrRFYI8DJ8u
 LYPafjTuieDB6jcQXDPwU
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Fri, 12 Aug 2022 21:56:57 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-2vqg6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 15f5a750f82727a3561822ee8056ab25;
          Fri, 12 Aug 2022 21:56:54 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v6 06/14] iio: magnetometer: yas530: Rename functions and registers
Date:   Fri, 12 Aug 2022 23:54:11 +0200
Message-Id: <344d3b2f5e050eab79ce9962c24781486774d9fb.1660337264.git.jahau@rocketmail.com>
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

This is a preparation for adding the YAS537 variant.

Functions that are used only by YAS530, YAS532 and YAS533 are renamed from
yas5xx to yas530. Same for the registers.

To avoid part listing in function and registers names, the name of the first
variant is used. Where appropriate, comments were added that these functions
are used by more than one variant.

Functions that will be used by all variants including YAS537 remain in the
naming scheme yas5xx. Or YAS5XX for registers, respectively.

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 126 +++++++++++++----------
 1 file changed, 70 insertions(+), 56 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index a9d7cf3ad77f..40cd6bbc9952 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -40,20 +40,22 @@
 
 #include <asm/unaligned.h>
 
-/* This register map covers YAS530 and YAS532 but differs in YAS 537 and YAS539 */
+/* Commonly used registers */
 #define YAS5XX_DEVICE_ID		0x80
-#define YAS5XX_ACTUATE_INIT_COIL	0x81
-#define YAS5XX_MEASURE			0x82
-#define YAS5XX_CONFIG			0x83
-#define YAS5XX_MEASURE_INTERVAL		0x84
-#define YAS5XX_OFFSET_X			0x85 /* [-31 .. 31] */
-#define YAS5XX_OFFSET_Y1		0x86 /* [-31 .. 31] */
-#define YAS5XX_OFFSET_Y2		0x87 /* [-31 .. 31] */
-#define YAS5XX_TEST1			0x88
-#define YAS5XX_TEST2			0x89
-#define YAS5XX_CAL			0x90
 #define YAS5XX_MEASURE_DATA		0xB0
 
+/* These registers are used by YAS530, YAS532 and YAS533 */
+#define YAS530_ACTUATE_INIT_COIL	0x81
+#define YAS530_MEASURE			0x82
+#define YAS530_CONFIG			0x83
+#define YAS530_MEASURE_INTERVAL		0x84
+#define YAS530_OFFSET_X			0x85 /* [-31 .. 31] */
+#define YAS530_OFFSET_Y1		0x86 /* [-31 .. 31] */
+#define YAS530_OFFSET_Y2		0x87 /* [-31 .. 31] */
+#define YAS530_TEST1			0x88
+#define YAS530_TEST2			0x89
+#define YAS530_CAL			0x90
+
 /* Bits in the YAS5xx config register */
 #define YAS5XX_CONFIG_INTON		BIT(0) /* Interrupt on? */
 #define YAS5XX_CONFIG_INTHACT		BIT(1) /* Interrupt active high? */
@@ -182,15 +184,17 @@ static u16 yas532_extract_axis(u8 *data)
 }
 
 /**
- * yas5xx_measure() - Make a measure from the hardware
+ * yas530_measure() - Make a measure from the hardware
  * @yas5xx: The device state
  * @t: the raw temperature measurement
  * @x: the raw x axis measurement
  * @y1: the y1 axis measurement
  * @y2: the y2 axis measurement
  * @return: 0 on success or error code
+ *
+ * Used by YAS530, YAS532 and YAS533.
  */
-static int yas5xx_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y2)
+static int yas530_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y2)
 {
 	unsigned int busy;
 	u8 data[8];
@@ -198,7 +202,7 @@ static int yas5xx_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y
 	u16 val;
 
 	mutex_lock(&yas5xx->lock);
-	ret = regmap_write(yas5xx->map, YAS5XX_MEASURE, YAS5XX_MEASURE_START);
+	ret = regmap_write(yas5xx->map, YAS530_MEASURE, YAS5XX_MEASURE_START);
 	if (ret < 0)
 		goto out_unlock;
 
@@ -264,7 +268,8 @@ static int yas5xx_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y
 	return ret;
 }
 
-static s32 yas5xx_linearize(struct yas5xx *yas5xx, u16 val, int axis)
+/* Used by YAS530, YAS532 and YAS533 */
+static s32 yas530_linearize(struct yas5xx *yas5xx, u16 val, int axis)
 {
 	struct yas5xx_calibration *c = &yas5xx->calibration;
 	static const s32 yas532ac_coef[] = {
@@ -306,15 +311,17 @@ static s32 yas5xx_linearize(struct yas5xx *yas5xx, u16 val, int axis)
 }
 
 /**
- * yas5xx_get_measure() - Measure a sample of all axis and process
+ * yas530_get_measure() - Measure a sample of all axis and process
  * @yas5xx: The device state
  * @to: Temperature out
  * @xo: X axis out
  * @yo: Y axis out
  * @zo: Z axis out
  * @return: 0 on success or error code
+ *
+ * Used by YAS530, YAS532 and YAS533.
  */
-static int yas5xx_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo, s32 *zo)
+static int yas530_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo, s32 *zo)
 {
 	struct yas5xx_calibration *c = &yas5xx->calibration;
 	u16 t_ref, t, x, y1, y2;
@@ -323,14 +330,14 @@ static int yas5xx_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo,
 	int ret;
 
 	/* We first get raw data that needs to be translated to [x,y,z] */
-	ret = yas5xx_measure(yas5xx, &t, &x, &y1, &y2);
+	ret = yas530_measure(yas5xx, &t, &x, &y1, &y2);
 	if (ret)
 		return ret;
 
 	/* Do some linearization if available */
-	sx = yas5xx_linearize(yas5xx, x, 0);
-	sy1 = yas5xx_linearize(yas5xx, y1, 1);
-	sy2 = yas5xx_linearize(yas5xx, y2, 2);
+	sx = yas530_linearize(yas5xx, x, 0);
+	sy1 = yas530_linearize(yas5xx, y1, 1);
+	sy2 = yas530_linearize(yas5xx, y2, 2);
 
 	/* Set the temperature reference value (unit: counts) */
 	switch (yas5xx->devid) {
@@ -446,7 +453,7 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_PROCESSED:
 	case IIO_CHAN_INFO_RAW:
 		pm_runtime_get_sync(yas5xx->dev);
-		ret = yas5xx_get_measure(yas5xx, &t, &x, &y, &z);
+		ret = yas530_get_measure(yas5xx, &t, &x, &y, &z);
 		pm_runtime_mark_last_busy(yas5xx->dev);
 		pm_runtime_put_autosuspend(yas5xx->dev);
 		if (ret)
@@ -505,7 +512,7 @@ static void yas5xx_fill_buffer(struct iio_dev *indio_dev)
 	int ret;
 
 	pm_runtime_get_sync(yas5xx->dev);
-	ret = yas5xx_get_measure(yas5xx, &t, &x, &y, &z);
+	ret = yas530_get_measure(yas5xx, &t, &x, &y, &z);
 	pm_runtime_mark_last_busy(yas5xx->dev);
 	pm_runtime_put_autosuspend(yas5xx->dev);
 	if (ret) {
@@ -591,8 +598,8 @@ static const struct iio_info yas5xx_info = {
 
 static bool yas5xx_volatile_reg(struct device *dev, unsigned int reg)
 {
-	return reg == YAS5XX_ACTUATE_INIT_COIL ||
-		reg == YAS5XX_MEASURE ||
+	return reg == YAS530_ACTUATE_INIT_COIL ||
+		reg == YAS530_MEASURE ||
 		(reg >= YAS5XX_MEASURE_DATA && reg < YAS5XX_MEASURE_DATA + 8);
 }
 
@@ -605,11 +612,13 @@ static const struct regmap_config yas5xx_regmap_config = {
 };
 
 /**
- * yas53x_extract_calibration() - extracts the a2-a9 and k calibration
+ * yas530_extract_calibration() - extracts the a2-a9 and k calibration
  * @data: the bitfield to use
  * @c: the calibration to populate
+ *
+ * Used by YAS530, YAS532 and YAS533.
  */
-static void yas53x_extract_calibration(u8 *data, struct yas5xx_calibration *c)
+static void yas530_extract_calibration(u8 *data, struct yas5xx_calibration *c)
 {
 	u64 val = get_unaligned_be64(data);
 
@@ -647,12 +656,12 @@ static int yas530_get_calibration_data(struct yas5xx *yas5xx)
 	int ret;
 
 	/* Dummy read, first read is ALWAYS wrong */
-	ret = regmap_bulk_read(yas5xx->map, YAS5XX_CAL, data, sizeof(data));
+	ret = regmap_bulk_read(yas5xx->map, YAS530_CAL, data, sizeof(data));
 	if (ret)
 		return ret;
 
 	/* Actual calibration readout */
-	ret = regmap_bulk_read(yas5xx->map, YAS5XX_CAL, data, sizeof(data));
+	ret = regmap_bulk_read(yas5xx->map, YAS530_CAL, data, sizeof(data));
 	if (ret)
 		return ret;
 	dev_dbg(yas5xx->dev, "calibration data: %*ph\n", 14, data);
@@ -664,7 +673,7 @@ static int yas530_get_calibration_data(struct yas5xx *yas5xx)
 	c->Cx = data[0] * 6 - 768;
 	c->Cy1 = data[1] * 6 - 768;
 	c->Cy2 = data[2] * 6 - 768;
-	yas53x_extract_calibration(&data[3], c);
+	yas530_extract_calibration(&data[3], c);
 
 	/*
 	 * Extract linearization:
@@ -695,11 +704,11 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
 	int ret;
 
 	/* Dummy read, first read is ALWAYS wrong */
-	ret = regmap_bulk_read(yas5xx->map, YAS5XX_CAL, data, sizeof(data));
+	ret = regmap_bulk_read(yas5xx->map, YAS530_CAL, data, sizeof(data));
 	if (ret)
 		return ret;
 	/* Actual calibration readout */
-	ret = regmap_bulk_read(yas5xx->map, YAS5XX_CAL, data, sizeof(data));
+	ret = regmap_bulk_read(yas5xx->map, YAS530_CAL, data, sizeof(data));
 	if (ret)
 		return ret;
 	dev_dbg(yas5xx->dev, "calibration data: %*ph\n", 14, data);
@@ -718,7 +727,7 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
 	c->Cx = data[0] * 10 - 1280;
 	c->Cy1 = data[1] * 10 - 1280;
 	c->Cy2 = data[2] * 10 - 1280;
-	yas53x_extract_calibration(&data[3], c);
+	yas530_extract_calibration(&data[3], c);
 	/*
 	 * Extract linearization:
 	 * Linearization layout in the 32 bits at byte 10:
@@ -741,7 +750,8 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
 	return 0;
 }
 
-static void yas5xx_dump_calibration(struct yas5xx *yas5xx)
+/* Used by YAS530, YAS532 and YAS533 */
+static void yas530_dump_calibration(struct yas5xx *yas5xx)
 {
 	struct yas5xx_calibration *c = &yas5xx->calibration;
 
@@ -764,20 +774,22 @@ static void yas5xx_dump_calibration(struct yas5xx *yas5xx)
 	dev_dbg(yas5xx->dev, "dck = %d\n", c->dck);
 }
 
-static int yas5xx_set_offsets(struct yas5xx *yas5xx, s8 ox, s8 oy1, s8 oy2)
+/* Used by YAS530, YAS532 and YAS533 */
+static int yas530_set_offsets(struct yas5xx *yas5xx, s8 ox, s8 oy1, s8 oy2)
 {
 	int ret;
 
-	ret = regmap_write(yas5xx->map, YAS5XX_OFFSET_X, ox);
+	ret = regmap_write(yas5xx->map, YAS530_OFFSET_X, ox);
 	if (ret)
 		return ret;
-	ret = regmap_write(yas5xx->map, YAS5XX_OFFSET_Y1, oy1);
+	ret = regmap_write(yas5xx->map, YAS530_OFFSET_Y1, oy1);
 	if (ret)
 		return ret;
-	return regmap_write(yas5xx->map, YAS5XX_OFFSET_Y2, oy2);
+	return regmap_write(yas5xx->map, YAS530_OFFSET_Y2, oy2);
 }
 
-static s8 yas5xx_adjust_offset(s8 old, int bit, u16 center, u16 measure)
+/* Used by YAS530, YAS532 and YAS533 */
+static s8 yas530_adjust_offset(s8 old, int bit, u16 center, u16 measure)
 {
 	if (measure > center)
 		return old + BIT(bit);
@@ -786,7 +798,8 @@ static s8 yas5xx_adjust_offset(s8 old, int bit, u16 center, u16 measure)
 	return old;
 }
 
-static int yas5xx_meaure_offsets(struct yas5xx *yas5xx)
+/* Used by YAS530, YAS532 and YAS533 */
+static int yas530_measure_offsets(struct yas5xx *yas5xx)
 {
 	int ret;
 	u16 center;
@@ -795,7 +808,7 @@ static int yas5xx_meaure_offsets(struct yas5xx *yas5xx)
 	int i;
 
 	/* Actuate the init coil and measure offsets */
-	ret = regmap_write(yas5xx->map, YAS5XX_ACTUATE_INIT_COIL, 0);
+	ret = regmap_write(yas5xx->map, YAS530_ACTUATE_INIT_COIL, 0);
 	if (ret)
 		return ret;
 
@@ -829,26 +842,26 @@ static int yas5xx_meaure_offsets(struct yas5xx *yas5xx)
 	oy2 = 0;
 
 	for (i = 4; i >= 0; i--) {
-		ret = yas5xx_set_offsets(yas5xx, ox, oy1, oy2);
+		ret = yas530_set_offsets(yas5xx, ox, oy1, oy2);
 		if (ret)
 			return ret;
 
-		ret = yas5xx_measure(yas5xx, &t, &x, &y1, &y2);
+		ret = yas530_measure(yas5xx, &t, &x, &y1, &y2);
 		if (ret)
 			return ret;
 		dev_dbg(yas5xx->dev, "measurement %d: x=%d, y1=%d, y2=%d\n",
 			5-i, x, y1, y2);
 
-		ox = yas5xx_adjust_offset(ox, i, center, x);
-		oy1 = yas5xx_adjust_offset(oy1, i, center, y1);
-		oy2 = yas5xx_adjust_offset(oy2, i, center, y2);
+		ox = yas530_adjust_offset(ox, i, center, x);
+		oy1 = yas530_adjust_offset(oy1, i, center, y1);
+		oy2 = yas530_adjust_offset(oy2, i, center, y2);
 	}
 
 	/* Needed for calibration algorithm */
 	yas5xx->hard_offsets[0] = ox;
 	yas5xx->hard_offsets[1] = oy1;
 	yas5xx->hard_offsets[2] = oy2;
-	ret = yas5xx_set_offsets(yas5xx, ox, oy1, oy2);
+	ret = yas530_set_offsets(yas5xx, ox, oy1, oy2);
 	if (ret)
 		return ret;
 
@@ -857,27 +870,28 @@ static int yas5xx_meaure_offsets(struct yas5xx *yas5xx)
 	return 0;
 }
 
-static int yas5xx_power_on(struct yas5xx *yas5xx)
+/* Used by YAS530, YAS532 and YAS533 */
+static int yas530_power_on(struct yas5xx *yas5xx)
 {
 	unsigned int val;
 	int ret;
 
 	/* Zero the test registers */
-	ret = regmap_write(yas5xx->map, YAS5XX_TEST1, 0);
+	ret = regmap_write(yas5xx->map, YAS530_TEST1, 0);
 	if (ret)
 		return ret;
-	ret = regmap_write(yas5xx->map, YAS5XX_TEST2, 0);
+	ret = regmap_write(yas5xx->map, YAS530_TEST2, 0);
 	if (ret)
 		return ret;
 
 	/* Set up for no interrupts, calibrated clock divider */
 	val = FIELD_PREP(YAS5XX_CONFIG_CCK_MASK, yas5xx->calibration.dck);
-	ret = regmap_write(yas5xx->map, YAS5XX_CONFIG, val);
+	ret = regmap_write(yas5xx->map, YAS530_CONFIG, val);
 	if (ret)
 		return ret;
 
 	/* Measure interval 0 (back-to-back?)  */
-	return regmap_write(yas5xx->map, YAS5XX_MEASURE_INTERVAL, 0);
+	return regmap_write(yas5xx->map, YAS530_MEASURE_INTERVAL, 0);
 }
 
 static int yas5xx_probe(struct i2c_client *i2c,
@@ -959,11 +973,11 @@ static int yas5xx_probe(struct i2c_client *i2c,
 		goto assert_reset;
 	}
 
-	yas5xx_dump_calibration(yas5xx);
-	ret = yas5xx_power_on(yas5xx);
+	yas530_dump_calibration(yas5xx);
+	ret = yas530_power_on(yas5xx);
 	if (ret)
 		goto assert_reset;
-	ret = yas5xx_meaure_offsets(yas5xx);
+	ret = yas530_measure_offsets(yas5xx);
 	if (ret)
 		goto assert_reset;
 
@@ -1062,7 +1076,7 @@ static int yas5xx_runtime_resume(struct device *dev)
 	usleep_range(31000, 40000);
 	gpiod_set_value_cansleep(yas5xx->reset, 0);
 
-	ret = yas5xx_power_on(yas5xx);
+	ret = yas530_power_on(yas5xx);
 	if (ret) {
 		dev_err(dev, "cannot power on\n");
 		goto out_reset;
-- 
2.35.1

