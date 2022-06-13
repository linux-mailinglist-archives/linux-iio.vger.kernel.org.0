Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34192547D54
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jun 2022 03:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237029AbiFMBSF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Jun 2022 21:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236137AbiFMBSF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Jun 2022 21:18:05 -0400
Received: from sonic309-26.consmr.mail.ir2.yahoo.com (sonic309-26.consmr.mail.ir2.yahoo.com [77.238.179.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D8D313A4
        for <linux-iio@vger.kernel.org>; Sun, 12 Jun 2022 18:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1655083081; bh=v4O4Iy9W/xsQCJK8BUZfcQQrPHSzBe6EcmCxJTi0P0w=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=LU2dF8AZwwJmEugW86Jpyen4MILoHEPtcKBHwE0k46M/2aApbVwmTuFaJG6afYuofeE1yIq20JQFf06oF/ugXxsGnXtOdo+JJoB3elCw2aeseAW558sfnxkyRysVMRH9a5RNrpiy8SYbDjrUfbttzMGBDVd2ATNkNrDLksbJaxyb7uT+dXhX4jtLGrPJYbwnwD0Uw5rQ90GfthHxbsTMCa/UTrZLS0kmfkOIhYIN5wuAxaxk/Z50Pas/R503q6ruaXT61N4mgEhs2LXQ2QkPoiuxWHRVHkRzhXgbmDVEyhRraU+G9/jLYrlW0jyLU51Jo7iXHc5vX6MBo99O+fOoww==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655083081; bh=7L6ZVRAmcmeewInr4OZF/UrGUwuYcqiN5JweVSog3Lf=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Qm7nP9Evkyrv07fGd8hfWrhwPDhlk1Olf/UV9ebGv5MLrIEuIZJdL6lKjuVfEVuiWafwYklq64CeNF0GPdkj6cbXIL/ElbvGEFXVNwCggHNChm3Git1PHwpGo6Mr9XzG9eK+0MHhJAFqMRPwmgRrSvz6Y6rpzPoik9j+RS6NOHZlZwgtk9L4c9Pnk+5jkBqAu4kWEEN7YO+NPwqvS2jN/Q66aTsGD0TVzBuSgfiSemu2J/cZp58pYEkB3iRYdBJnan9GmYJtepwqVLr7dQB80aOvoXgdLCuDTeauKlTsIcMuhAGVlEnGMUv2ycgvRYXhxHhb5jjmtWZnbSfVdDcPPQ==
X-YMail-OSG: iXstDf4VM1m.5vSTxh.ewtMTqU6HV5pzPHLIlgdWSLQ33Iw40QC6lQ8y7dzkqMy
 0SiHw5c.JxAQtcj24nUKXOPSWdl6V7is6lTq.bgipJ3471wrYzQC2OIb9qPRc9RtZehtvQbP51Y_
 qQCpFU43BhQK04L9ltwehA.WhOk5utnYn0pk6OcOBSXqwyanRwhkwSaaL2TjqFQpOu_i0JbahMDp
 RFOZe9ha1VrDzu9paiGxMiYlhsappyq_eBL_HOhmrvJlgh_2O5ydKDnHWpSHQWNQAzNUHQlLfIOB
 WfDE82GIqJJIT3jPRSFgxNVcmD32WsMHooOLVjPNIDPOZhBew703pufON_eJPIsSBdUoBhaH.OZF
 B7sinaUmRETmvLgWGv6nyoKcHlWi7NUSPy0gzYbKHRbe_wZFP1.NSYGB42bOZye_sygAocGKL9Ji
 zdXLq7kNLw4uCl2W3_VTNeCcMzd_n7ABzAfGesJRIr3XutSRZCQUoY8Ak7TwBPfIRq7RXs44LTfx
 _DT5Ggm6RqjUHS.RZ5TkIZ4zcifp.QBpg3T9m_3J3Fs2ZiSI415.gqMFZWWOowcIVwnlK1tr5gwX
 HzYqs3mLBEtUkBBnvO8YIskhT5hx5t3yWHLx1_q78UMqAFRi_wgVFPmbW3X6PmUmLjM7XhmRByTk
 KUkilzJ3o6LyZYT6j_NaSB6DzN3drVv4Ofk8LEvqhXdEvlqBXKgGtwGjiGAOEXDcl59I9ZEXyOcd
 S_WDf77K0iyDgyNOH7zhRj6does1MRrlRrUKh1ffF.XTsL4QDal_s_fS44UezvKHQeGczz9C4NMW
 m3rGHfZYQA1tAyGR97y.BLvc_v._FsVeroRO3RR_XzjMZFybXvX0V18pZSepTuLDMq10p6C3O_Zi
 6JwP3Mh1841eT3q5rVq.c2MYFVBTsryr5vsbcPNgPMSQzN1vn4wRw51Xy.v7wj7.Bh5rpmRBSOLM
 SeesrCU1cFVHm_q8v.FkcLaKhgCaAngAgY_WXmWfDsX8ubmilDWtPMSuvtv0uC26tf4hgeSgpxOc
 g16MKUWPQys2de9HlE3NJ3mbVNuRDx3NtOqNnxkVDEYINg9vahhBqb9.faYlgxqL2EAVds.rRUm_
 n9QvaOJhARH.4aHR2ddaler0FXUD2H7tOKwjVE0igzoxz1ZD67EbdHxkfAPRRmPgKtI_hdV_Hbha
 F0JzyZMJcyX8LryWOPfloiMwi1lDUVkFuDmYLxcYHdMHF63DsPPc8.jwHIdaOS0emuDnK5pzgHy9
 4.zJtKgtjkCq8x5Wv2qQ8Lpylhz5abqcGy2DNNkhVLHnB4bu_KZwdeeUGPXIgDJyj2lAjNfLjgDy
 OQZk8h7VSXtOxnN_pRhpMvftcm.0FVmnR9CkMx6TX8vmn8n_C1j6IQpVerQDaKc1rCCVlyHwV8J4
 HM2ai4Lu6JlQXKu4CAh.wUR_qgpewPNq7x5uKal6lDeu5beH9uUfmsTnt0FmmPY4h2N6Ndrhm_Xv
 3nIbPP7HzegWwKAJNKLJkjJmAoXNdfakOGDzdVL1DrDq0A.4uwo2UE0idTT67feMeIxdmBbn.Z_p
 IUF6qfL.k_IMa7iI1UB.LqbDk6aS1FNTTenxM4R5LuY26KgPUgbnccODsGpOyUEy0JcSL.9ihkew
 YolZk497UOUE5NuUa_bUd5IkpL.fqvR3c7TTlEvbpPGr_maf3jJYEsB11l9mKjfMoH7i8lMF3WPy
 9ZoX8El8dY1eREKKRe9o3aREMjgUWJmMAUNat8CHgT7QO.KBraE.MmDCAwswreen5m_2O0YNiULq
 NVykzMJDY_6kjifwGhk8NWp6Z0r2IUQi3TDp2rQ0qcdjoCcR.x__pG.Ws0BNPKuPAaPJ7HlVwPz8
 waIu_8cLJIAZF.TA22jEI_thQCegaiKTTZIMzbFtNhT1xXjvmhndFvdQ.QqE7ySlWOGLj59uXU6u
 NcFhiqQpiYGThthkl88lGkxXRM1qqs6m2UCxov_byGbk9qLa7RJonVo8IjpluMSOC3mvNYUrkDJy
 eHLykoiT5NAApOuLUxiGPg3wyc_RlraiRshrT7U6hkZD1UTmMvkAure2qsXqYRqXHynuvXmM4Ba0
 F9rOWbSGKp.i.jN6iE6XP5ItnpdbMFfn409x3UoY02bjh_PYBJ.IczCGqNLbguUv7I_ktcZjQ4uR
 hX3kJblKjeVej1sOUn5PMWO82ia033CkrSGItccMcrgN9ZrPDXxAW3pRDDyv7jS..55egX6ULgqS
 3xpJDEsmKTnDPKSJTr7maI5JM1V6o0Y_YJ4pGTxo94.9I6zuiUInIgwu7b15tex27OX6JHoFCAB9
 b_b0Zy16rtKiEBOG5
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ir2.yahoo.com with HTTP; Mon, 13 Jun 2022 01:18:01 +0000
Received: by hermes--canary-production-ir2-6c7595c778-c54g9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4419c1e75f73c3038b6a16962b132f56;
          Mon, 13 Jun 2022 01:17:59 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v2 6/7] iio: magnetometer: yas530: Rename functions and registers
Date:   Mon, 13 Jun 2022 03:17:13 +0200
Message-Id: <826851a63ce792ae105638c73b9e3c818cb45e6b.1655081082.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655081082.git.jahau@rocketmail.com>
References: <cover.1655081082.git.jahau@rocketmail.com>
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
---
 drivers/iio/magnetometer/yamaha-yas530.c | 106 ++++++++++++-----------
 1 file changed, 55 insertions(+), 51 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 31637a890b7f..72958bc0849b 100644
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
@@ -596,11 +600,11 @@ static const struct regmap_config yas5xx_regmap_config = {
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
 
@@ -638,12 +642,12 @@ static int yas530_get_calibration_data(struct yas5xx *yas5xx)
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
@@ -655,7 +659,7 @@ static int yas530_get_calibration_data(struct yas5xx *yas5xx)
 	c->Cx = data[0] * 6 - 768;
 	c->Cy1 = data[1] * 6 - 768;
 	c->Cy2 = data[2] * 6 - 768;
-	yas53x_extract_calibration(&data[3], c);
+	yas530_532_extract_calibration(&data[3], c);
 
 	/*
 	 * Extract linearization:
@@ -686,11 +690,11 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
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
@@ -709,7 +713,7 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
 	c->Cx = data[0] * 10 - 1280;
 	c->Cy1 = data[1] * 10 - 1280;
 	c->Cy2 = data[2] * 10 - 1280;
-	yas53x_extract_calibration(&data[3], c);
+	yas530_532_extract_calibration(&data[3], c);
 	/*
 	 * Extract linearization:
 	 * Linearization layout in the 32 bits at byte 10:
@@ -732,7 +736,7 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
 	return 0;
 }
 
-static void yas5xx_dump_calibration(struct yas5xx *yas5xx)
+static void yas530_532_dump_calibration(struct yas5xx *yas5xx)
 {
 	struct yas5xx_calibration *c = &yas5xx->calibration;
 
@@ -755,20 +759,20 @@ static void yas5xx_dump_calibration(struct yas5xx *yas5xx)
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
@@ -777,7 +781,7 @@ static s8 yas5xx_adjust_offset(s8 old, int bit, u16 center, u16 measure)
 	return old;
 }
 
-static int yas5xx_meaure_offsets(struct yas5xx *yas5xx)
+static int yas530_532_measure_offsets(struct yas5xx *yas5xx)
 {
 	int ret;
 	u16 center;
@@ -786,7 +790,7 @@ static int yas5xx_meaure_offsets(struct yas5xx *yas5xx)
 	int i;
 
 	/* Actuate the init coil and measure offsets */
-	ret = regmap_write(yas5xx->map, YAS5XX_ACTUATE_INIT_COIL, 0);
+	ret = regmap_write(yas5xx->map, YAS530_532_ACTUATE_INIT_COIL, 0);
 	if (ret)
 		return ret;
 
@@ -820,26 +824,26 @@ static int yas5xx_meaure_offsets(struct yas5xx *yas5xx)
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
 
@@ -848,27 +852,27 @@ static int yas5xx_meaure_offsets(struct yas5xx *yas5xx)
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
@@ -950,11 +954,11 @@ static int yas5xx_probe(struct i2c_client *i2c,
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

