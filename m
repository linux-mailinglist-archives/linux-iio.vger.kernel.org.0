Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390B9591720
	for <lists+linux-iio@lfdr.de>; Sat, 13 Aug 2022 00:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbiHLWFd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Aug 2022 18:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235626AbiHLWFc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2022 18:05:32 -0400
Received: from sonic304-23.consmr.mail.ir2.yahoo.com (sonic304-23.consmr.mail.ir2.yahoo.com [77.238.179.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A89073935
        for <linux-iio@vger.kernel.org>; Fri, 12 Aug 2022 15:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1660341927; bh=rwrJBC1EN3No5MvFpujm/uDVSFGv9ifS8IkWpNzBRm8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=hcMETl6gu8yCjmlgnTY8Nza1aKfJCC4/Sq0EYl6Apyf+c7beA95fRAIS234Eir5XVBTjyqboH2yFD7iCYO7fNRdrNbQWohxxqtsn/uLMtwh5rAumSbV1d/TYUNfy1VBUILEb6XitvjxtVtWZDeBhrFBgqlzrXMxPcf9C5TOQdc2zPEIbEEU5mUuCJW5JNb5NnZyjlEar3itG35BchN0HUkMwWQ0h1gyQ6PenkIKV7oit3NBhHJiBkPdUInd1JEhrV/FN9ePE36DhWn1/gMf1EvS8tZmXe4L4UGQJdgq4Np0QsxHRhIAuwJSYZznbsc6BpJx3ryKpu4MlQbgx88hlsw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660341927; bh=5kSy/aRPj1svObuf6SHFS4ytNbVyVxOyXpAE7DWAFj9=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=q60QeanD0NaFj6c/QeNsvqQxTSgjhs/VFjJTVDHnL+96XiWb8l/OI1nCk5PEp1pSVcgmeJi+ZzxJALZOmE8kn/fGocLtyOFYJNniCOTlRb5cfHC9J7PuBbqpyin4ibjeKphVS/mqadXwK1qa4HuS9bzBvXyo7HEyinGkmVWHz8wHSdO40AUdtWgNcP87PTr/gDrjq+HB+YqRv/4ZlUacE+lPFYr2hjnzijMDD4c/2yNd7AjeGEcgcms7hi/cR4VxHHB8kW9tv3GYXZnCZ7tDDCuY58irF3HbY4K8/QzBtL+hzrUWw4PMvohKMG1AGRybQ22T7/n3fNQ35Nw+xpvBQA==
X-YMail-OSG: wM.pzMEVM1lwchGJ1R3Es.8apy8nDf8QQGcXJgNaJO3fY7k208SYv5TmEMrWacm
 qQJbX6kU3S9IwsE7q7xeEPwNmel50sU.4lNjxsW5Ab4Ry8CaxM9E7dMOiVlxD4zDQ8B7lWKSYuuR
 uY4YNkMKGbhohMEpNSrOmCv1M7YsY9S47Wp7736IjYyZyGBIjoQtIff_15u4.2pm8WeXfpha9Fk9
 _CuyiN4SBiYOPPkhOJti_RpuChJ16kzpa_8K9JGdkXmSqZLt2QKlwpJOQlvk.EDF9ffOzF.Xfem7
 kQs5O0cQnvuMHC57rBqo7227czOmTZbldycZeYVs12UjECeE7bm2f_FHJmoM5exu6yD3sw6hA6AO
 ecQVAI3trBAyMoXlX65FmixtOpqQFfgE9KvjD3qFJTsPYGMqfphSaTOdrMLeijDjvQ7HOchE9gqE
 h8TSu7ipe3atxHTdvkYnQIk7rpu8HFrwUisOydKzi.Eif.ucmVE2_OdsRdsr86BsWAhMr2qz3vhd
 EdcPvoj1SpCGAo.DRJN5T1G9Ln.zWVTxGkdo.giPGRL5vVtlVFjk7d1jqnAos81K46Wk.jNrWXTT
 3Ek45EOmWeZmky39gJrghuj1b5iynjJ6acweOP1dPyFoHT8IyfE3IPRM7mR6gaN54sL.un3EkwMF
 ZXXnrOTIGEN9o4qFYDBaHNpXzOyrgedN1kznAcHJC5Qp.EzBIrkBwhLoWZuU74LWNrX12aWbIp8f
 _KbQT8bAZKN86_P7od52SXn0K9RbheCmM._QqIsJLmoC9LsdNp8Z4qPRIdvo8I1WT1GXgamJ_Hxe
 O3CsvoXWE1_QxUSo8RZp.B2yuINgLwVpzhSST9gAu4Aec.aLDYM6RSbJrE1S4FgatGgP6kN7CdHu
 TUMGrQN9F0qtz6pIgZ.6nRcIpJkdMx2jleCrJkFILir9opeOV7aHUQ_g.PObMvWAycKugzb0QznU
 60WP1858UayAnqkk3YgT56jZ.RrLO04o06ehQO4GwJnynV5auToglK7dmAmyTORqFElnX1nRsDbV
 q.PEJZhJObbg.GLKrk777Sc4DA.KKHsH8OYK6voXGC6uKz0.SCguVjqUB1aFN.tmjqFDtAmm.0W1
 E2qrrdbMx22wTEn2LPBZsMX5JLh8jeir8u9jpdkoLF.Ug74gcmk3DQyt_13pshiUkic_zNWTSs.L
 ASSj70yA6PgrexNNXj_1hPmqq6F5R0MVF3FbPbA2vXzjZuandb9TEXMvy7khOyPVX4nm2HrjESJ2
 iV48ujwfXUT7CExFfPtU_AURZf4KUpRylKWCHx.L5tYBBgcMZTjVgnGG0lN.zQEeustcoP7LSBD2
 9uM4tjpgimHvRVD6J5Onx0ZGfvAbBbPyvfloMyFNsFKWvNSH03ODDkPTIWS1nponwJawM1W9dKGd
 3Fcx0nSVUnnF0oU7TiVylhQqQeL04lkFVkfyfrFjwAw2HT_wPkvxCXdveAmi4JV3uIopBcvuY7XS
 VnWKJCJjluBEGUPCkGsa4yIKlMUWFLwDQLcPMWC5y1dU9HK4XEQ6aRvFaYwdAsR4526bxTFVFmqb
 qjUxSx.sfVn3uxfIV61pfg8ugaXrtMLmkwBR7fcyTLY0TRPIE0i1vJL7rwduuUfNJaLNSMqQhtmK
 .uurSxnoVDInV2pizshqadtrrsqy0JeQvWOJ9IhKepz6SV5KB2675laxcemow1j8K9LMDkD48bMU
 mIDJl97apoXuNurVyXstDle8.hzzymO2FX5Ftc4p1bRR00BGXQKaDlTNI2A_oRuyMw3aeceEhOCe
 YM48.HE7ofdG_Pa.SDIB0QY_fINOjNcFOBcmzz9EpAxGIASnRr1wOoFrdRHG4p5vrvgdGAjvuBqI
 Rjbzprht8HgMwEmmohT1aYQ7GRZacJF8T2ZsLuNff0zOb_ZqZy5455ONr5p8brnoUk8EZ8DQwMiZ
 d9Pm4hBxARptE9jFWfPOVoyqeDiDmLY72BJDj2xopnRoMREnoKZkbHjEJJHtgk0OhOdsndo.cvro
 a.zEPMEz45xbgHRgBlarXxjzlGbjt.aMy5ss5efgnTArLp6vpYnUM8_fdSH6n0gOgRUFoidYdiY9
 IJXh.BsmDSwYIUU4PgJ2x5crIdVipYF8P8QP3VHDqWG1E3CPI2uJ0EoxSDQmVyQi5JVlzQYuUhiD
 FGePG25iTjQoEUIhkjQJGzQe.nymptWYoU2HN8PedQ6Z.D3HekbcSeAWlfW1hC3j1qmfHAqEmvAo
 k1e5Lak.gdeGUEO36gHS9cxO01vS5TVr8Kk9Y1Ay6q7c2qKJL.Li0q.2E4AI7pMnFhKES2Qvwe20
 U3fdtgQVvsW51zA--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ir2.yahoo.com with HTTP; Fri, 12 Aug 2022 22:05:27 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-48gl8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c89c964524cd385a78dd9672c65b4e57;
          Fri, 12 Aug 2022 22:05:26 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v6 14/14] iio: magnetometer: yas530: Add YAS537 variant
Date:   Sat, 13 Aug 2022 00:05:03 +0200
Message-Id: <264c6488733a5c32089c9ab406a5bcb808c48fef.1660337264.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1660337264.git.jahau@rocketmail.com>
References: <cover.1660337264.git.jahau@rocketmail.com>
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

Add support for the magnetometer Yamaha YAS537. The additions are based on
comparison of Yamaha Android kernel drivers for YAS532 [1] and YAS537 [2].

In the Yamaha YAS537 Android driver, there is an overflow/underflow control
implemented. For regular usage, this seems not necessary. A similar overflow/
underflow control of Yamaha YAS530/532 Android driver isn't integrated in the
mainline driver. It is therefore skipped for YAS537 in the mainline too.

Also in the Yamaha YAS537 Android driver, at the end of the reset_yas537()
function, a measurement is saved in "last_after_rcoil". Later on, this is
compared to current measurements. If the difference gets too big, a new
reset is initialized. The difference in measurements needs to be quite big,
it's hard to say if this is necessary for regular operation. Therefore this
isn't integrated in the mainline driver either.

[1] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas532.c
[2] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas537.c

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
Result can be seen at:
https://github.com/Jakko3/linux/blob/yas537_v6/drivers/iio/magnetometer/yamaha-yas530.c

 drivers/iio/magnetometer/Kconfig         |   4 +-
 drivers/iio/magnetometer/yamaha-yas530.c | 422 ++++++++++++++++++++++-
 2 files changed, 423 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 07eb619bcfe8..b91fc5e6a26e 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -216,8 +216,8 @@ config YAMAHA_YAS530
 	select IIO_TRIGGERED_BUFFER
 	help
 	  Say Y here to add support for the Yamaha YAS530 series of
-	  3-Axis Magnetometers. Right now YAS530, YAS532 and YAS533 are
-	  fully supported.
+	  3-Axis Magnetometers. YAS530, YAS532, YAS533 and YAS537 are
+	  supported.
 
 	  This driver can also be compiled as a module.
 	  To compile this driver as a module, choose M here: the module
diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 18933d8937ae..65bb34c24810 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -17,6 +17,9 @@
  * named "inv_compass" in the Tegra Android kernel tree.
  * Copyright (C) 2012 InvenSense Corporation
  *
+ * Code functions for YAS537 based on Yamaha Android kernel driver.
+ * Copyright (c) 2014 Yamaha Corporation
+ *
  * Author: Linus Walleij <linus.walleij@linaro.org>
  */
 #include <linux/bitfield.h>
@@ -32,6 +35,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/random.h>
+#include <linux/units.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
@@ -56,6 +60,23 @@
 #define YAS530_TEST2			0x89
 #define YAS530_CAL			0x90
 
+/* Registers used by YAS537 */
+#define YAS537_MEASURE			0x81 /* Originally YAS537_REG_CMDR */
+#define YAS537_CONFIG			0x82 /* Originally YAS537_REG_CONFR */
+#define YAS537_MEASURE_INTERVAL		0x83 /* Originally YAS537_REG_INTRVLR */
+#define YAS537_OFFSET_X			0x84 /* Originally YAS537_REG_OXR */
+#define YAS537_OFFSET_Y1		0x85 /* Originally YAS537_REG_OY1R */
+#define YAS537_OFFSET_Y2		0x86 /* Originally YAS537_REG_OY2R */
+#define YAS537_AVR			0x87
+#define YAS537_HCK			0x88
+#define YAS537_LCK			0x89
+#define YAS537_SRST			0x90
+#define YAS537_ADCCAL			0x91
+#define YAS537_MTC			0x93
+#define YAS537_OC			0x9E
+#define YAS537_TRM			0x9F
+#define YAS537_CAL			0xC0
+
 /* Bits in the YAS5xx config register */
 #define YAS5XX_CONFIG_INTON		BIT(0) /* Interrupt on? */
 #define YAS5XX_CONFIG_INTHACT		BIT(1) /* Interrupt active high? */
@@ -67,6 +88,7 @@
 #define YAS5XX_MEASURE_LDTC		BIT(1)
 #define YAS5XX_MEASURE_FORS		BIT(2)
 #define YAS5XX_MEASURE_DLYMES		BIT(4)
+#define YAS5XX_MEASURE_CONT		BIT(5)
 
 /* Bits in the measure data register */
 #define YAS5XX_MEASURE_DATA_BUSY	BIT(7)
@@ -91,6 +113,22 @@
 #define YAS532_DATA_CENTER		BIT(YAS532_DATA_BITS - 1)
 #define YAS532_DATA_OVERFLOW		(BIT(YAS532_DATA_BITS) - 1)
 
+#define YAS537_DEVICE_ID		0x07 /* YAS537 (MS-3T) */
+#define YAS537_VERSION_0		0 /* Version naming unknown */
+#define YAS537_VERSION_1		1 /* Version naming unknown */
+#define YAS537_MAG_AVERAGE_32_MASK	GENMASK(6, 4)
+#define YAS537_MEASURE_TIME_WORST_US	1500
+#define YAS537_DEFAULT_SENSOR_DELAY_MS	50
+#define YAS537_MAG_RCOIL_TIME_US	65
+#define YAS537_MTC3_MASK_PREP		GENMASK(7, 0)
+#define YAS537_MTC3_MASK_GET		GENMASK(7, 5)
+#define YAS537_MTC3_ADD_BIT		BIT(4)
+#define YAS537_HCK_MASK_PREP		GENMASK(4, 0)
+#define YAS537_HCK_MASK_GET		GENMASK(7, 4)
+#define YAS537_LCK_MASK_PREP		GENMASK(4, 0)
+#define YAS537_LCK_MASK_GET		GENMASK(3, 0)
+#define YAS537_OC_MASK_GET		GENMASK(5, 0)
+
 /* Turn off device regulators etc after 5 seconds of inactivity */
 #define YAS5XX_AUTOSUSPEND_DELAY_MS	5000
 
@@ -98,6 +136,7 @@ enum chip_ids {
 	yas530,
 	yas532,
 	yas533,
+	yas537,
 };
 
 static const int yas530_volatile_reg[] = {
@@ -105,6 +144,10 @@ static const int yas530_volatile_reg[] = {
 	YAS530_MEASURE,
 };
 
+static const int yas537_volatile_reg[] = {
+	YAS537_MEASURE,
+};
+
 struct yas5xx_calibration {
 	/* Linearization calibration x, y1, y2 */
 	s32 r[3];
@@ -138,7 +181,7 @@ struct yas5xx;
  * @power_on: function pointer to power-on procedure
  *
  * The "t_ref" value for YAS532/533 is known from the Android driver.
- * For YAS530 it was approximately measured.
+ * For YAS530 and YAS537 it was approximately measured.
  *
  * The temperatures "min_temp_x10" are derived from the temperature resolutions
  * given in the data sheets.
@@ -312,6 +355,77 @@ static int yas530_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y
 	return ret;
 }
 
+/**
+ * yas537_measure() - Make a measure from the hardware
+ * @yas5xx: The device state
+ * @t: the raw temperature measurement
+ * @x: the raw x axis measurement
+ * @y1: the y1 axis measurement
+ * @y2: the y2 axis measurement
+ * @return: 0 on success or error code
+ */
+static int yas537_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y2)
+{
+	struct yas5xx_calibration *c = &yas5xx->calibration;
+	unsigned int busy;
+	u8 data[8];
+	u16 xy1y2[3];
+	s32 h[3], s[3];
+	int i, ret;
+
+	mutex_lock(&yas5xx->lock);
+
+	/* Contrary to YAS530/532, also a "cont" bit is set, meaning unknown */
+	ret = regmap_write(yas5xx->map, YAS537_MEASURE, YAS5XX_MEASURE_START |
+			   YAS5XX_MEASURE_CONT);
+	if (ret < 0)
+		goto out_unlock;
+
+	/* Use same timeout like YAS530/532 but the bit is in data row 2 */
+	ret = regmap_read_poll_timeout(yas5xx->map, YAS5XX_MEASURE_DATA + 2, busy,
+				       !(busy & YAS5XX_MEASURE_DATA_BUSY),
+				       500, 20000);
+	if (ret) {
+		dev_err(yas5xx->dev, "timeout waiting for measurement\n");
+		goto out_unlock;
+	}
+
+	ret = regmap_bulk_read(yas5xx->map, YAS5XX_MEASURE_DATA,
+			       data, sizeof(data));
+	if (ret)
+		goto out_unlock;
+
+	mutex_unlock(&yas5xx->lock);
+
+	*t = get_unaligned_be16(&data[0]);
+	xy1y2[0] = FIELD_GET(GENMASK(13, 0), get_unaligned_be16(&data[2]));
+	xy1y2[1] = get_unaligned_be16(&data[4]);
+	xy1y2[2] = get_unaligned_be16(&data[6]);
+
+	/* The second version of YAS537 needs to include calibration coefficients */
+	if (yas5xx->version == YAS537_VERSION_1) {
+		for (i = 0; i < 3; i++)
+			s[i] = xy1y2[i] - BIT(13);
+		h[0] = (c->k *   (128 * s[0] + c->a2 * s[1] + c->a3 * s[2])) / BIT(13);
+		h[1] = (c->k * (c->a4 * s[0] + c->a5 * s[1] + c->a6 * s[2])) / BIT(13);
+		h[2] = (c->k * (c->a7 * s[0] + c->a8 * s[1] + c->a9 * s[2])) / BIT(13);
+		for (i = 0; i < 3; i++) {
+			clamp_val(h[i], -BIT(13), BIT(13) - 1);
+			xy1y2[i] = h[i] + BIT(13);
+		}
+	}
+
+	*x = xy1y2[0];
+	*y1 = xy1y2[1];
+	*y2 = xy1y2[2];
+
+	return 0;
+
+out_unlock:
+	mutex_unlock(&yas5xx->lock);
+	return ret;
+}
+
 /* Used by YAS530, YAS532 and YAS533 */
 static s32 yas530_linearize(struct yas5xx *yas5xx, u16 val, int axis)
 {
@@ -457,6 +571,41 @@ static int yas530_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo,
 	return 0;
 }
 
+/**
+ * yas537_get_measure() - Measure a sample of all axis and process
+ * @yas5xx: The device state
+ * @to: Temperature out
+ * @xo: X axis out
+ * @yo: Y axis out
+ * @zo: Z axis out
+ * @return: 0 on success or error code
+ */
+static int yas537_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo, s32 *zo)
+{
+	u16 t, x, y1, y2;
+	int ret;
+
+	/* We first get raw data that needs to be translated to [x,y,z] */
+	ret = yas537_measure(yas5xx, &t, &x, &y1, &y2);
+	if (ret)
+		return ret;
+
+	/* Calculate temperature readout */
+	*to = yas5xx_calc_temperature(yas5xx, t);
+
+	/*
+	 * Unfortunately, no linearization or temperature compensation formulas
+	 * are known for YAS537.
+	 */
+
+	/* Calculate x, y, z from x, y1, y2 */
+	*xo = (x - BIT(13)) * 300;
+	*yo = (y1 - y2) * 1732 / 10;
+	*zo = (-y1 - y2 + BIT(14)) * 300;
+
+	return 0;
+}
+
 static int yas5xx_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2,
@@ -772,6 +921,202 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
 	return 0;
 }
 
+static int yas537_get_calibration_data(struct yas5xx *yas5xx)
+{
+	struct yas5xx_calibration *c = &yas5xx->calibration;
+	u8 data[17];
+	u32 val1, val2, val3, val4;
+	int i, ret;
+
+	/* Writing SRST register */
+	ret = regmap_write(yas5xx->map, YAS537_SRST, BIT(1));
+	if (ret)
+		return ret;
+
+	/* Calibration readout, YAS537 needs one readout only */
+	ret = regmap_bulk_read(yas5xx->map, YAS537_CAL, data, sizeof(data));
+	if (ret)
+		return ret;
+	dev_dbg(yas5xx->dev, "calibration data: %17ph\n", data);
+
+	/* Sanity check, is this all zeroes? */
+	if (!memchr_inv(data, 0x00, 16) && !FIELD_GET(GENMASK(5, 0), data[16]))
+		dev_warn(yas5xx->dev, "calibration is blank!\n");
+
+	/* Contribute calibration data to the input pool for kernel entropy */
+	add_device_randomness(data, sizeof(data));
+
+	/* Extract version information */
+	yas5xx->version = FIELD_GET(GENMASK(7, 6), data[16]);
+
+	/* There are two versions of YAS537 behaving differently */
+	switch (yas5xx->version) {
+	case YAS537_VERSION_0:
+		/*
+		 * The first version simply writes data back into registers:
+		 *
+		 * data[0]  YAS537_MTC		0x93
+		 * data[1]			0x94
+		 * data[2]			0x95
+		 * data[3]			0x96
+		 * data[4]			0x97
+		 * data[5]			0x98
+		 * data[6]			0x99
+		 * data[7]			0x9a
+		 * data[8]			0x9b
+		 * data[9]			0x9c
+		 * data[10]			0x9d
+		 * data[11] YAS537_OC		0x9e
+		 *
+		 * data[12] YAS537_OFFSET_X	0x84
+		 * data[13] YAS537_OFFSET_Y1	0x85
+		 * data[14] YAS537_OFFSET_Y2	0x86
+		 *
+		 * data[15] YAS537_HCK		0x88
+		 * data[16] YAS537_LCK		0x89
+		 */
+		for (i = 0; i < 12; i++) {
+			ret = regmap_write(yas5xx->map, YAS537_MTC + i,
+					   data[i]);
+			if (ret)
+				return ret;
+		}
+		for (i = 0; i < 3; i++) {
+			ret = regmap_write(yas5xx->map, YAS537_OFFSET_X + i,
+					   data[i + 12]);
+			if (ret)
+				return ret;
+			yas5xx->hard_offsets[i] = data[i + 12];
+		}
+		for (i = 0; i < 2; i++) {
+			ret = regmap_write(yas5xx->map, YAS537_HCK + i,
+					   data[i + 15]);
+			if (ret)
+				return ret;
+		}
+		break;
+	case YAS537_VERSION_1:
+		/*
+		 * The second version writes some data into registers but also
+		 * extracts calibration coefficients.
+		 *
+		 * Registers being written:
+		 *
+		 * data[0]  YAS537_MTC			0x93
+		 * data[1]  YAS537_MTC+1		0x94
+		 * data[2]  YAS537_MTC+2		0x95
+		 * data[3]  YAS537_MTC+3 (partially)	0x96
+		 *
+		 * data[12] YAS537_OFFSET_X		0x84
+		 * data[13] YAS537_OFFSET_Y1		0x85
+		 * data[14] YAS537_OFFSET_Y2		0x86
+		 *
+		 * data[15] YAS537_HCK (partially)	0x88
+		 *          YAS537_LCK (partially)	0x89
+		 * data[16] YAS537_OC  (partially)	0x9e
+		 */
+		for (i = 0; i < 3; i++) {
+			ret = regmap_write(yas5xx->map, YAS537_MTC + i,
+					   data[i]);
+			if (ret)
+				return ret;
+		}
+		for (i = 0; i < 3; i++) {
+			ret = regmap_write(yas5xx->map, YAS537_OFFSET_X + i,
+					   data[i + 12]);
+			if (ret)
+				return ret;
+			yas5xx->hard_offsets[i] = data[i + 12];
+		}
+		/*
+		 * Visualization of partially taken data:
+		 *
+		 * data[3]       n 7 6 5 4 3 2 1 0
+		 * YAS537_MTC+3    x x x 1 0 0 0 0
+		 *
+		 * data[15]      n 7 6 5 4 3 2 1 0
+		 * YAS537_HCK      x x x x 0
+		 *
+		 * data[15]      n 7 6 5 4 3 2 1 0
+		 * YAS537_LCK              x x x x 0
+		 *
+		 * data[16]      n 7 6 5 4 3 2 1 0
+		 * YAS537_OC           x x x x x x
+		 */
+		ret = regmap_write(yas5xx->map, YAS537_MTC + 3,
+				   FIELD_PREP(YAS537_MTC3_MASK_PREP,
+				   FIELD_GET(YAS537_MTC3_MASK_GET, data[3])) |
+				   YAS537_MTC3_ADD_BIT);
+		if (ret)
+			return ret;
+		ret = regmap_write(yas5xx->map, YAS537_HCK,
+				   FIELD_PREP(YAS537_HCK_MASK_PREP,
+				   FIELD_GET(YAS537_HCK_MASK_GET, data[15])));
+		if (ret)
+			return ret;
+		ret = regmap_write(yas5xx->map, YAS537_LCK,
+				   FIELD_PREP(YAS537_LCK_MASK_PREP,
+				   FIELD_GET(YAS537_LCK_MASK_GET, data[15])));
+		if (ret)
+			return ret;
+		ret = regmap_write(yas5xx->map, YAS537_OC,
+				   FIELD_GET(YAS537_OC_MASK_GET, data[16]));
+		if (ret)
+			return ret;
+		/*
+		 * For data extraction, build some blocks. Four 32-bit blocks
+		 * look appropriate.
+		 *
+		 *            n    7  6  5  4  3  2  1  0
+		 *  data[0]   0 [ Cx Cx Cx Cx Cx Cx Cx Cx ] bits 31 .. 24
+		 *  data[1]   1 [ Cx C1 C1 C1 C1 C1 C1 C1 ] bits 23 .. 16
+		 *  data[2]   2 [ C1 C1 C2 C2 C2 C2 C2 C2 ] bits 15 .. 8
+		 *  data[3]   3 [ C2 C2 C2                ] bits  7 .. 0
+		 *
+		 *            n    7  6  5  4  3  2  1  0
+		 *  data[3]   0 [          a2 a2 a2 a2 a2 ] bits 31 .. 24
+		 *  data[4]   1 [ a2 a2 a3 a3 a3 a3 a3 a3 ] bits 23 .. 16
+		 *  data[5]   2 [ a3 a4 a4 a4 a4 a4 a4 a4 ] bits 15 .. 8
+		 *  data[6]   3 [ a4                      ] bits  7 .. 0
+		 *
+		 *            n    7  6  5  4  3  2  1  0
+		 *  data[6]   0 [    a5 a5 a5 a5 a5 a5 a5 ] bits 31 .. 24
+		 *  data[7]   1 [ a5 a5 a6 a6 a6 a6 a6 a6 ] bits 23 .. 16
+		 *  data[8]   2 [ a6 a7 a7 a7 a7 a7 a7 a7 ] bits 15 .. 8
+		 *  data[9]   3 [ a7                      ] bits  7 .. 0
+		 *
+		 *            n    7  6  5  4  3  2  1  0
+		 *  data[9]   0 [    a8 a8 a8 a8 a8 a8 a8 ] bits 31 .. 24
+		 *  data[10]  1 [ a9 a9 a9 a9 a9 a9 a9 a9 ] bits 23 .. 16
+		 *  data[11]  2 [ a9  k  k  k  k  k  k  k ] bits 15 .. 8
+		 *  data[12]  3 [                         ] bits  7 .. 0
+		 */
+		val1 = get_unaligned_be32(&data[0]);
+		val2 = get_unaligned_be32(&data[3]);
+		val3 = get_unaligned_be32(&data[6]);
+		val4 = get_unaligned_be32(&data[9]);
+		/* Extract calibration coefficients and modify */
+		c->Cx  = FIELD_GET(GENMASK(31, 23), val1) - 256;
+		c->Cy1 = FIELD_GET(GENMASK(22, 14), val1) - 256;
+		c->Cy2 = FIELD_GET(GENMASK(13,  5), val1) - 256;
+		c->a2  = FIELD_GET(GENMASK(28, 22), val2) -  64;
+		c->a3  = FIELD_GET(GENMASK(21, 15), val2) -  64;
+		c->a4  = FIELD_GET(GENMASK(14,  7), val2) - 128;
+		c->a5  = FIELD_GET(GENMASK(30, 22), val3) - 112;
+		c->a6  = FIELD_GET(GENMASK(21, 15), val3) -  64;
+		c->a7  = FIELD_GET(GENMASK(14,  7), val3) - 128;
+		c->a8  = FIELD_GET(GENMASK(30, 24), val4) -  64;
+		c->a9  = FIELD_GET(GENMASK(23, 15), val4) - 112;
+		c->k   = FIELD_GET(GENMASK(14,  8), val4);
+		break;
+	default:
+		dev_err(yas5xx->dev, "unknown version of YAS537\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /* Used by YAS530, YAS532 and YAS533 */
 static void yas530_dump_calibration(struct yas5xx *yas5xx)
 {
@@ -796,6 +1141,26 @@ static void yas530_dump_calibration(struct yas5xx *yas5xx)
 	dev_dbg(yas5xx->dev, "dck = %d\n", c->dck);
 }
 
+static void yas537_dump_calibration(struct yas5xx *yas5xx)
+{
+	struct yas5xx_calibration *c = &yas5xx->calibration;
+
+	if (yas5xx->version == YAS537_VERSION_1) {
+		dev_dbg(yas5xx->dev, "Cx = %d\n", c->Cx);
+		dev_dbg(yas5xx->dev, "Cy1 = %d\n", c->Cy1);
+		dev_dbg(yas5xx->dev, "Cy2 = %d\n", c->Cy2);
+		dev_dbg(yas5xx->dev, "a2 = %d\n", c->a2);
+		dev_dbg(yas5xx->dev, "a3 = %d\n", c->a3);
+		dev_dbg(yas5xx->dev, "a4 = %d\n", c->a4);
+		dev_dbg(yas5xx->dev, "a5 = %d\n", c->a5);
+		dev_dbg(yas5xx->dev, "a6 = %d\n", c->a6);
+		dev_dbg(yas5xx->dev, "a7 = %d\n", c->a7);
+		dev_dbg(yas5xx->dev, "a8 = %d\n", c->a8);
+		dev_dbg(yas5xx->dev, "a9 = %d\n", c->a9);
+		dev_dbg(yas5xx->dev, "k = %d\n", c->k);
+	}
+}
+
 /* Used by YAS530, YAS532 and YAS533 */
 static int yas530_set_offsets(struct yas5xx *yas5xx, s8 ox, s8 oy1, s8 oy2)
 {
@@ -917,6 +1282,44 @@ static int yas530_power_on(struct yas5xx *yas5xx)
 	return regmap_write(yas5xx->map, YAS530_MEASURE_INTERVAL, 0);
 }
 
+static int yas537_power_on(struct yas5xx *yas5xx)
+{
+	__be16 buf;
+	int ret;
+	u8 intrvl;
+
+	/* Writing ADCCAL and TRM registers */
+	buf = cpu_to_be16(GENMASK(9, 3));
+	ret = regmap_bulk_write(yas5xx->map, YAS537_ADCCAL, &buf, sizeof(buf));
+	if (ret)
+		return ret;
+	ret = regmap_write(yas5xx->map, YAS537_TRM, GENMASK(7, 0));
+	if (ret)
+		return ret;
+
+	/* The interval value is static in regular operation */
+	intrvl = (YAS537_DEFAULT_SENSOR_DELAY_MS * MILLI
+		 - YAS537_MEASURE_TIME_WORST_US) / 4100;
+	ret = regmap_write(yas5xx->map, YAS537_MEASURE_INTERVAL, intrvl);
+	if (ret)
+		return ret;
+
+	/* The average value is also static in regular operation */
+	ret = regmap_write(yas5xx->map, YAS537_AVR, YAS537_MAG_AVERAGE_32_MASK);
+	if (ret)
+		return ret;
+
+	/* Perform the "rcoil" part but skip the "last_after_rcoil" read */
+	ret = regmap_write(yas5xx->map, YAS537_CONFIG, BIT(3));
+	if (ret)
+		return ret;
+
+	/* Wait until the coil has ramped up */
+	usleep_range(YAS537_MAG_RCOIL_TIME_US, YAS537_MAG_RCOIL_TIME_US + 100);
+
+	return 0;
+}
+
 static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
 	[yas530] = {
 		.devid = YAS530_DEVICE_ID,
@@ -963,6 +1366,21 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
 		.measure_offsets = yas530_measure_offsets,
 		.power_on = yas530_power_on,
 	},
+	[yas537] = {
+		.devid = YAS537_DEVICE_ID,
+		.product_name = "YAS537 MS-3T",
+		.version_names = { "v0", "v1" }, /* version naming unknown */
+		.volatile_reg = yas537_volatile_reg,
+		.volatile_reg_qty = ARRAY_SIZE(yas537_volatile_reg),
+		.scaling_val2 = 100000, /* nanotesla to Gauss */
+		.t_ref = 8120, /* counts */
+		.min_temp_x10 = -3860, /* 1/10:s degrees Celsius */
+		.get_measure = yas537_get_measure,
+		.get_calibration_data = yas537_get_calibration_data,
+		.dump_calibration = yas537_dump_calibration,
+		/* .measure_offets is not needed for yas537 */
+		.power_on = yas537_power_on,
+	},
 };
 
 static int yas5xx_probe(struct i2c_client *i2c,
@@ -1170,6 +1588,7 @@ static const struct i2c_device_id yas5xx_id[] = {
 	{"yas530", yas530 },
 	{"yas532", yas532 },
 	{"yas533", yas533 },
+	{"yas537", yas537 },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, yas5xx_id);
@@ -1178,6 +1597,7 @@ static const struct of_device_id yas5xx_of_match[] = {
 	{ .compatible = "yamaha,yas530", },
 	{ .compatible = "yamaha,yas532", },
 	{ .compatible = "yamaha,yas533", },
+	{ .compatible = "yamaha,yas537", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, yas5xx_of_match);
-- 
2.35.1

