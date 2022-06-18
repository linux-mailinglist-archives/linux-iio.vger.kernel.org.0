Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40C3550128
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jun 2022 02:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245202AbiFRAPM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jun 2022 20:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348242AbiFRAPL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jun 2022 20:15:11 -0400
Received: from sonic306-21.consmr.mail.ir2.yahoo.com (sonic306-21.consmr.mail.ir2.yahoo.com [77.238.176.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AB81ADB8
        for <linux-iio@vger.kernel.org>; Fri, 17 Jun 2022 17:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1655511307; bh=sGHa/AM5SkKKVfdyjAJJqV4wePUji04k+kdekMfkmzo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=tss8RT3EYkuy7JrG2MIEiis5L2FA9RcH0MkqJPn6X0rwujw53HiGspLlxrw9MtOjS+p9+0Gg/OA5Oz3s1q7dsHlyOmpTpjaR7eDxVdY6xP9VrKyFgT/HgnC+yWf8Bj4V3CYzB8eRKV7Q0smaMrwFdYeimyXFVEFrIrgqPvG9iwJ2fNgntUmbkuwWoniWDkYOziMkFRuXJRpQHZRIc/k5GAomi7IH8UxhhFu4Y6DAeDExf8da/IunMS5AxpWPHnWZb4GKtLzJkF0Ahx57+ukCxzrvpMVvSvSaFVG5BSmc3moKb+AWaeIaViTDzOH5GQkrqykxJws/zSxMoG6uTCD3ew==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655511307; bh=v/5euCm9wK27F2Yqo6Qttn3KnhZz3EBVJKGagpzW6fP=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=spW9Y0xO1SvsgPj4QHbua3VcSDc1dkOzdfvy8UJCQWS9mzYIES7YYzddUfe8pBNFUx0qihsvbaUUfO80q4bZiwxK+io7YUYhlp3gL60Dwscd7y7lwkcKuf9chQUs4Bot32AE2BA9xahytvOjkSpZhAGEHKP8jiRvayzXG0zXVCTUKQixlAW4F/bnNnkMfbttfcUrq5/ENvTRzZAgD4n/XkLLp4Ex8QQY/uUqoLeUYz+vGuxQavQAoglWfS59wirAxnV5Z2clhzplhUj8kEpV530utik4oVA0mGA/n40E3HJlceSGTrBkxaErK706sQHr8HiXW+QkHZMBdVS/w4KTKw==
X-YMail-OSG: GkZdy4kVM1nqojiH6zXwT1QZdZ7J2UzovN28miqs0m_WzUpRyFM.wuCBqEPQYPA
 _b7ZIm9GeLgjmWuOkIQD3sWxO.9opZt4I2DOQjcqm4ty9e04b4gn90Hz6QoQS2t30jvTJ5KQweW4
 tEe0qeBLeARTcoTYUVCR4_at1avK9iNmvxmy3.p4wV2.aBmmqjV32OxCi59jVbM3w8DcN5SRVbFq
 CELcQh.YZKpdyOJUHijyX4x59MN.4t1eTIZZUa.JtWUP.Oy1Met7Zyprd63dpmyZFEVgDvWxyln5
 QbQMHw0xfSRpiMVXJbkUxCeZcsMBVRqmeepwIvu8tn8.pGAOxYnC.DBPvRZlt4002VemPQS0vYDG
 TRx53GINtDqQ9sV_tg9sNGyUTaQ6CSGEDxzhMDzdn8FfuWG88rCsBkBE269AJY0RknB78fBZGofu
 6CrJ7R3GccVASMVIcOfvOW5g_sshIXqCnb74FmDZc6nAFIfKgLIiryyLJYyXPCHWAeC7_mteGQ2_
 tuCEp_0cjfpBH7TJyiXYi1Wj_klzVQ3QCJomtb9qXwR7rhYG421X6TPYG6SlYsdiclQ86EJAWill
 _RiCxZukb7EjFWVB1cx8K4tUmlcHgLnCfPya7OHtn4.Y2SAa2YpkJYA086Ia86RlERQIEWjgRJpW
 L1AS95_rW3bjiqNLTUQHr_zXut5KAfhb3_YX8ogVtOh5oOjJohdnO24Po.uIjIdZRG0Ib.gwssA_
 zGXY1zsf7PdMiQ5ZqZkUd2CIManKUH4wBLl.0gq_B8EF01O0oHxtOgPJgGXvwq9BO3cQQo_lE9kF
 tQQ.W4hK_MN0.YoyCYy1AvuZvWajx2oz_73B0yeufeVKqBnY51ydR_VIbiPcKUHaRZu3BetCMhI4
 Rfjh20zbbbp0EqannmTVe3Lsht9OoHQG.5gMImpVhV.kqIngbIGr2k1.Pz.QJqcIrPGCVioTMjFz
 TJsaP_O6DubRJyvQaFAL1obwFq6TET4uGoe1BZqhjXTb5Wnru6DKGtx6KU9dAkbfThAR6WLyAZNL
 TPVTDIYnMnbWgVjm52Q5DTGsoFMMX0oWiLObwOJKWLW8c3ehRPS9OiQim4F0OFA8A4LAvyFAbnr4
 3qSd466TZ_ufoIJD0I05LGzO71ccB1yBYOlYrIvBM4jxq1hyjdmsiQVT2NGdxtGS7CEkN4MJzAAY
 qeGvXne7Grp_Hr9E.MlJWf4_tVMJSvygtBOqjHer6LjcxmcmOu3xh4dIlCmK2_Yosx9vK4WpB3G0
 weZdSIbbkdcMrnoR89aEBS..YJTgybR9U7RBlZ58BFCfzQCsBnUosfsPjnbBinKZS6DMZIwxps8e
 ouoxuo2jnmvcqLcINI60y6dX8m_eJ7.v6kPDuMzjubpkyX6cfo9esNbgfLMgQutM9g95CxePqdMP
 rwsdfnYEWNgR.9DNGYrf4BR5EopN6_dEJbyphUGwjZDL9IK7NCDIcGWXFSkU63oDv0zhfpujNt.G
 eqSZ1bcxP081ZmRIp3l0gZ8BnuseaJ5vnYtDoapPVDhDFAWXhQiDikKezH18Ce10irFMU8yGU_ib
 0uSOu6iY9nb4Fc2IISS0T9bMGBH8zG04iGrYSfi4TMMOTclVOd7F_16CU62zWH2BEfJnugW2Jx1O
 1J9suAiInGAVNqhraijet_vYXA7sTV8TYYvIWOcW4TCS7VAnPsOPSL8aVQf2TUPkaG25i9R0JSdD
 _HITAKDLmU1ngZNaBTqMfANsciMUUV1HlhKWNLLTjGqPbnaSeszH0G4wyQdoZHRQoS42mzG0wdtG
 cNmtMWYh6cQMBm3wkdY.nErtoDy02yz3Y2LEtkj3uqLOkceH7gshllsZQtSftJbeoxP5eH9DXebU
 RsYKqiJn6A2WhL8GHiBhGG4yIfRjXWfJDnGdZAEtrFRw5RfDbW0wAxmChfQ.He2xvokGzOif717s
 OHygUIlhdxZN2O1etKIiKlXp4DJ17sWr6uM03MVDBJ5fJOCrkMVvOjGJO7k4DGMvGj.etSq0hfDz
 z0j_MwcoUdcPdexj5G3XTeyX3jxRxB.0qlbgHXHgL6I9G6n_QUL6LTHSzf7ETlB2EmLN5EVXMyBe
 6_sRxlGc7IJLh9YE1JeWUlxtqtZb.DlUqaiFabhD37bHRE.5o7k4d38zrBHwvK3MzXyU9qZ.CP9Q
 doXKIQYEyZsRzUQXExOSM9dsO0qscZjrbQj80jrcu47.V7I5JBXHVj7MiPwbbXAC4zgF8FRRqLX3
 9iStj9VG8N6A2VLZqMpVMI0.6j_2eyn92HYHZuWeGEWdZMZu4Wm8m7hR.f5CRqAAe50TWP27RhvI
 osbJnvLqKnlZrFYDJUQ0-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ir2.yahoo.com with HTTP; Sat, 18 Jun 2022 00:15:07 +0000
Received: by hermes--canary-production-ir2-c9bf9d9bc-74fwm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8b08f14069c990c2ed22165f3e3da032;
          Sat, 18 Jun 2022 00:15:04 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v3 6/8] iio: magnetometer: yas530: Rename functions and registers
Date:   Sat, 18 Jun 2022 02:13:14 +0200
Message-Id: <f1a49262b124cbcdf4a258f65fd54ee389de3a29.1655509425.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655509425.git.jahau@rocketmail.com>
References: <cover.1655509425.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is a preparation for adding YAS537 variant.

Rename functions used only by YAS530 & YAS532 from yas5xx to yas530_532.
Same for the registers.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 106 ++++++++++++-----------
 1 file changed, 55 insertions(+), 51 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index c6f5f25793c4..98c8d365fab7 100644
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
 
+/* Registers used by YAS530 and YAS532 */
+#define YAS530_532_ACTUATE_INIT_COIL	0x81
+#define YAS530_532_MEASURE		0x82
+#define YAS530_532_CONFIG		0x83
+#define YAS530_532_MEASURE_INTERVAL	0x84
+#define YAS530_532_OFFSET_X		0x85 /* [-31 .. 31] */
+#define YAS530_532_OFFSET_Y1		0x86 /* [-31 .. 31] */
+#define YAS530_532_OFFSET_Y2		0x87 /* [-31 .. 31] */
+#define YAS530_532_TEST1		0x88
+#define YAS530_532_TEST2		0x89
+#define YAS530_532_CAL			0x90
+
 /* Bits in the YAS5xx config register */
 #define YAS5XX_CONFIG_INTON		BIT(0) /* Interrupt on? */
 #define YAS5XX_CONFIG_INTHACT		BIT(1) /* Interrupt active high? */
@@ -182,7 +184,7 @@ static u16 yas532_extract_axis(u8 *data)
 }
 
 /**
- * yas5xx_measure() - Make a measure from the hardware
+ * yas530_532_measure() - Make a measure from the hardware
  * @yas5xx: The device state
  * @t: the raw temperature measurement
  * @x: the raw x axis measurement
@@ -190,7 +192,8 @@ static u16 yas532_extract_axis(u8 *data)
  * @y2: the y2 axis measurement
  * @return: 0 on success or error code
  */
-static int yas5xx_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y2)
+static int yas530_532_measure(struct yas5xx *yas5xx, u16 *t,
+			      u16 *x, u16 *y1, u16 *y2)
 {
 	unsigned int busy;
 	u8 data[8];
@@ -198,7 +201,7 @@ static int yas5xx_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y
 	u16 val;
 
 	mutex_lock(&yas5xx->lock);
-	ret = regmap_write(yas5xx->map, YAS5XX_MEASURE, YAS5XX_MEASURE_START);
+	ret = regmap_write(yas5xx->map, YAS530_532_MEASURE, YAS5XX_MEASURE_START);
 	if (ret < 0)
 		goto out_unlock;
 
@@ -264,7 +267,7 @@ static int yas5xx_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y
 	return ret;
 }
 
-static s32 yas5xx_linearize(struct yas5xx *yas5xx, u16 val, int axis)
+static s32 yas530_532_linearize(struct yas5xx *yas5xx, u16 val, int axis)
 {
 	struct yas5xx_calibration *c = &yas5xx->calibration;
 	static const s32 yas532ac_coef[] = {
@@ -306,7 +309,7 @@ static s32 yas5xx_linearize(struct yas5xx *yas5xx, u16 val, int axis)
 }
 
 /**
- * yas5xx_get_measure() - Measure a sample of all axis and process
+ * yas530_532_get_measure() - Measure a sample of all axis and process
  * @yas5xx: The device state
  * @to: Temperature out
  * @xo: X axis out
@@ -314,7 +317,8 @@ static s32 yas5xx_linearize(struct yas5xx *yas5xx, u16 val, int axis)
  * @zo: Z axis out
  * @return: 0 on success or error code
  */
-static int yas5xx_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo, s32 *zo)
+static int yas530_532_get_measure(struct yas5xx *yas5xx, s32 *to,
+				  s32 *xo, s32 *yo, s32 *zo)
 {
 	struct yas5xx_calibration *c = &yas5xx->calibration;
 	u16 t_ref, t, x, y1, y2;
@@ -323,14 +327,14 @@ static int yas5xx_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo,
 	int ret;
 
 	/* We first get raw data that needs to be translated to [x,y,z] */
-	ret = yas5xx_measure(yas5xx, &t, &x, &y1, &y2);
+	ret = yas530_532_measure(yas5xx, &t, &x, &y1, &y2);
 	if (ret)
 		return ret;
 
 	/* Do some linearization if available */
-	sx = yas5xx_linearize(yas5xx, x, 0);
-	sy1 = yas5xx_linearize(yas5xx, y1, 1);
-	sy2 = yas5xx_linearize(yas5xx, y2, 2);
+	sx = yas530_532_linearize(yas5xx, x, 0);
+	sy1 = yas530_532_linearize(yas5xx, y1, 1);
+	sy2 = yas530_532_linearize(yas5xx, y2, 2);
 
 	/* Set the temperature reference value (unit: counts) */
 	switch (yas5xx->devid) {
@@ -602,11 +606,11 @@ static const struct regmap_config yas5xx_regmap_config = {
 };
 
 /**
- * yas53x_extract_calibration() - extracts the a2-a9 and k calibration
+ * yas530_532_extract_calibration() - extracts the a2-a9 and k calibration
  * @data: the bitfield to use
  * @c: the calibration to populate
  */
-static void yas53x_extract_calibration(u8 *data, struct yas5xx_calibration *c)
+static void yas530_532_extract_calibration(u8 *data, struct yas5xx_calibration *c)
 {
 	u64 val = get_unaligned_be64(data);
 
@@ -644,12 +648,12 @@ static int yas530_get_calibration_data(struct yas5xx *yas5xx)
 	int ret;
 
 	/* Dummy read, first read is ALWAYS wrong */
-	ret = regmap_bulk_read(yas5xx->map, YAS5XX_CAL, data, sizeof(data));
+	ret = regmap_bulk_read(yas5xx->map, YAS530_532_CAL, data, sizeof(data));
 	if (ret)
 		return ret;
 
 	/* Actual calibration readout */
-	ret = regmap_bulk_read(yas5xx->map, YAS5XX_CAL, data, sizeof(data));
+	ret = regmap_bulk_read(yas5xx->map, YAS530_532_CAL, data, sizeof(data));
 	if (ret)
 		return ret;
 	dev_dbg(yas5xx->dev, "calibration data: %*ph\n", 14, data);
@@ -661,7 +665,7 @@ static int yas530_get_calibration_data(struct yas5xx *yas5xx)
 	c->Cx = data[0] * 6 - 768;
 	c->Cy1 = data[1] * 6 - 768;
 	c->Cy2 = data[2] * 6 - 768;
-	yas53x_extract_calibration(&data[3], c);
+	yas530_532_extract_calibration(&data[3], c);
 
 	/*
 	 * Extract linearization:
@@ -692,11 +696,11 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
 	int ret;
 
 	/* Dummy read, first read is ALWAYS wrong */
-	ret = regmap_bulk_read(yas5xx->map, YAS5XX_CAL, data, sizeof(data));
+	ret = regmap_bulk_read(yas5xx->map, YAS530_532_CAL, data, sizeof(data));
 	if (ret)
 		return ret;
 	/* Actual calibration readout */
-	ret = regmap_bulk_read(yas5xx->map, YAS5XX_CAL, data, sizeof(data));
+	ret = regmap_bulk_read(yas5xx->map, YAS530_532_CAL, data, sizeof(data));
 	if (ret)
 		return ret;
 	dev_dbg(yas5xx->dev, "calibration data: %*ph\n", 14, data);
@@ -715,7 +719,7 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
 	c->Cx = data[0] * 10 - 1280;
 	c->Cy1 = data[1] * 10 - 1280;
 	c->Cy2 = data[2] * 10 - 1280;
-	yas53x_extract_calibration(&data[3], c);
+	yas530_532_extract_calibration(&data[3], c);
 	/*
 	 * Extract linearization:
 	 * Linearization layout in the 32 bits at byte 10:
@@ -738,7 +742,7 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
 	return 0;
 }
 
-static void yas5xx_dump_calibration(struct yas5xx *yas5xx)
+static void yas530_532_dump_calibration(struct yas5xx *yas5xx)
 {
 	struct yas5xx_calibration *c = &yas5xx->calibration;
 
@@ -761,20 +765,20 @@ static void yas5xx_dump_calibration(struct yas5xx *yas5xx)
 	dev_dbg(yas5xx->dev, "dck = %d\n", c->dck);
 }
 
-static int yas5xx_set_offsets(struct yas5xx *yas5xx, s8 ox, s8 oy1, s8 oy2)
+static int yas530_532_set_offsets(struct yas5xx *yas5xx, s8 ox, s8 oy1, s8 oy2)
 {
 	int ret;
 
-	ret = regmap_write(yas5xx->map, YAS5XX_OFFSET_X, ox);
+	ret = regmap_write(yas5xx->map, YAS530_532_OFFSET_X, ox);
 	if (ret)
 		return ret;
-	ret = regmap_write(yas5xx->map, YAS5XX_OFFSET_Y1, oy1);
+	ret = regmap_write(yas5xx->map, YAS530_532_OFFSET_Y1, oy1);
 	if (ret)
 		return ret;
-	return regmap_write(yas5xx->map, YAS5XX_OFFSET_Y2, oy2);
+	return regmap_write(yas5xx->map, YAS530_532_OFFSET_Y2, oy2);
 }
 
-static s8 yas5xx_adjust_offset(s8 old, int bit, u16 center, u16 measure)
+static s8 yas530_532_adjust_offset(s8 old, int bit, u16 center, u16 measure)
 {
 	if (measure > center)
 		return old + BIT(bit);
@@ -783,7 +787,7 @@ static s8 yas5xx_adjust_offset(s8 old, int bit, u16 center, u16 measure)
 	return old;
 }
 
-static int yas5xx_meaure_offsets(struct yas5xx *yas5xx)
+static int yas530_532_measure_offsets(struct yas5xx *yas5xx)
 {
 	int ret;
 	u16 center;
@@ -792,7 +796,7 @@ static int yas5xx_meaure_offsets(struct yas5xx *yas5xx)
 	int i;
 
 	/* Actuate the init coil and measure offsets */
-	ret = regmap_write(yas5xx->map, YAS5XX_ACTUATE_INIT_COIL, 0);
+	ret = regmap_write(yas5xx->map, YAS530_532_ACTUATE_INIT_COIL, 0);
 	if (ret)
 		return ret;
 
@@ -826,26 +830,26 @@ static int yas5xx_meaure_offsets(struct yas5xx *yas5xx)
 	oy2 = 0;
 
 	for (i = 4; i >= 0; i--) {
-		ret = yas5xx_set_offsets(yas5xx, ox, oy1, oy2);
+		ret = yas530_532_set_offsets(yas5xx, ox, oy1, oy2);
 		if (ret)
 			return ret;
 
-		ret = yas5xx_measure(yas5xx, &t, &x, &y1, &y2);
+		ret = yas530_532_measure(yas5xx, &t, &x, &y1, &y2);
 		if (ret)
 			return ret;
 		dev_dbg(yas5xx->dev, "measurement %d: x=%d, y1=%d, y2=%d\n",
 			5-i, x, y1, y2);
 
-		ox = yas5xx_adjust_offset(ox, i, center, x);
-		oy1 = yas5xx_adjust_offset(oy1, i, center, y1);
-		oy2 = yas5xx_adjust_offset(oy2, i, center, y2);
+		ox = yas530_532_adjust_offset(ox, i, center, x);
+		oy1 = yas530_532_adjust_offset(oy1, i, center, y1);
+		oy2 = yas530_532_adjust_offset(oy2, i, center, y2);
 	}
 
 	/* Needed for calibration algorithm */
 	yas5xx->hard_offsets[0] = ox;
 	yas5xx->hard_offsets[1] = oy1;
 	yas5xx->hard_offsets[2] = oy2;
-	ret = yas5xx_set_offsets(yas5xx, ox, oy1, oy2);
+	ret = yas530_532_set_offsets(yas5xx, ox, oy1, oy2);
 	if (ret)
 		return ret;
 
@@ -854,27 +858,27 @@ static int yas5xx_meaure_offsets(struct yas5xx *yas5xx)
 	return 0;
 }
 
-static int yas5xx_power_on(struct yas5xx *yas5xx)
+static int yas530_532_power_on(struct yas5xx *yas5xx)
 {
 	unsigned int val;
 	int ret;
 
 	/* Zero the test registers */
-	ret = regmap_write(yas5xx->map, YAS5XX_TEST1, 0);
+	ret = regmap_write(yas5xx->map, YAS530_532_TEST1, 0);
 	if (ret)
 		return ret;
-	ret = regmap_write(yas5xx->map, YAS5XX_TEST2, 0);
+	ret = regmap_write(yas5xx->map, YAS530_532_TEST2, 0);
 	if (ret)
 		return ret;
 
 	/* Set up for no interrupts, calibrated clock divider */
 	val = FIELD_PREP(YAS5XX_CONFIG_CCK_MASK, yas5xx->calibration.dck);
-	ret = regmap_write(yas5xx->map, YAS5XX_CONFIG, val);
+	ret = regmap_write(yas5xx->map, YAS530_532_CONFIG, val);
 	if (ret)
 		return ret;
 
 	/* Measure interval 0 (back-to-back?)  */
-	return regmap_write(yas5xx->map, YAS5XX_MEASURE_INTERVAL, 0);
+	return regmap_write(yas5xx->map, YAS530_532_MEASURE_INTERVAL, 0);
 }
 
 static int yas5xx_probe(struct i2c_client *i2c,
@@ -956,11 +960,11 @@ static int yas5xx_probe(struct i2c_client *i2c,
 		goto assert_reset;
 	}
 
-	yas5xx_dump_calibration(yas5xx);
-	ret = yas5xx_power_on(yas5xx);
+	yas530_532_dump_calibration(yas5xx);
+	ret = yas530_532_power_on(yas5xx);
 	if (ret)
 		goto assert_reset;
-	ret = yas5xx_meaure_offsets(yas5xx);
+	ret = yas530_532_measure_offsets(yas5xx);
 	if (ret)
 		goto assert_reset;
 
-- 
2.35.1

