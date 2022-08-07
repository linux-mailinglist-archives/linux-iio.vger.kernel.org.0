Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5271B58BE36
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 01:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiHGXEJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 19:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbiHGXEB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 19:04:01 -0400
Received: from sonic312-26.consmr.mail.ir2.yahoo.com (sonic312-26.consmr.mail.ir2.yahoo.com [77.238.178.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0D42DE3
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 16:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1659913437; bh=iSvqFPb7a8bm1SPtoNuwYDbtvuFTmw+0jFTTDM504tg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ETu3hpw38EpJkJvW/7pOwAlQG1lHmFiZQ1ykW9hmSEVJ4W1v7D7cDtChiJwkLJmlx/yNCsng5mvqh9cLqmK3tjUdvQPapdGE2F4kNXOD1y7L/N2mt+WaDHYMy25BajCQDPo+xxnzBssUMVtkmA4AqFnZt4fXZINcEP3ixeEmdd9N3oZgSfB32kZtJ/rO2n6LnPOJdP2DzCVQOUHWhlANB0AqSmOrTl8DAC1/i7gvphNDc9IRuzLb+z0ARu5z2uFlu8QQddSw+e7R75IkzNR+SqaPvLKjLZPFQ678H4Ewtt1E5JRU2dthLb8/AOB39gnXP6bwy9IxI35FFgmgaT0hjg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1659913437; bh=mGEBgVZ/OPKapfrNjMII7zdpFcOF/HmdIzOrzupIRTl=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=AXf+lZNSCDBA6EXai02C34IG+quUIia1DKeOAFhsXOqMAjAl9cl0RA3/4N9a+9hEitRf724+kg+O5ikv8tzwF43LVzsVtrS8Oaz8OEL4hz+CPUWUvkjMHpsILd4Pb4FDQi029RCpQJqWaYszQEGXBQjLB+d1ZA1X6Yq5dOX2BNoLuCIRiz5k+aoakjYSUjECqsWd9tL3uAzKXDq6nWl7AitX+3VIiigg9TbvCfGG2rajnNzoulmZZSHdn2MQCP8W12uCOaTa91FCF8W5oBWYbzqisKaKRsGLLaq82vCopCe+s5A4IW8cx0+0LImKzMsTO9LyDmnOWUiMoGfzQo4NvQ==
X-YMail-OSG: ZIpxIQAVM1na12q90iqZCaYnjjZ2fmpdzJNAeEoCNwK.cfKVujDtB1Ky9EOUIc9
 5TUVjY2PmCi4ARkuH05A2P6g1i5j1yCwEMxjQDQqF0DTR3RWqy8wbQPKHjV4LvXCF1KbUBLm3AUT
 WCtfzH_x.IvAWJ4AkniGfKGShD58gOdXHicCFfyEawEBdxkYOb5iDk933fr5_VaJlN0J9grVFqdv
 vGc0vaNYr.uwzbRCwG1ccVVjlWUfwx1w8RFvHHMWBqZtp9pj2c7MNYhHVYLLg9LbeWlJuvo4nHA7
 ZOHAlNedrNyg7B5_qweP59OosOXATaXfUo.11aZqJfkfVkicyueob68uvPhScNRAOFHBrP666_Sw
 U8e6fRlKzwgEqnAMAAe41TP6Te6oilXMBRuNHpzXq1l3cmxos0eiQCg5QmzqS4aRbAE3mzzErnFk
 qNbh78dyBv.Z_NcsM5NHhHgJr_LgaLWziD6BtLSw3nCeZM0zPTIEli1ds60deepoP6iRPeYY_Qof
 c5uGzjyTGXaGfnWCVVXm3rt_UXbCgocMKmFqHpRcoDsmn6WEhKAps8mO.bjfHTJm4tdQ7Re8t6dp
 vdfrZUcAz73n_v_YancSPTjLdLS4zah30vvorNXePhSbgbn.b4_9I_MUkjxbTJXokgpWlm_H0z60
 suI21toRtu.gP5SzUYAXXzs9JONRQDU1IdPIfo2KPmXT0v8gWUTbXK0VTENR4dYnTOOq3YLyydjV
 5pXPhAG63xkqwVmyqhEb.9BAPI1IeMPNfdNVsrIBkmk8cq3Jaya.Ejpr7Zv60IsyO3Fw1SRjDEHa
 kVPna0QnmyMLOflCOTfGH0hXJnfK7CF99Hg58OneQ.IwuIqQUOIAF264byblq_f6L_PZXBGtaPyt
 0XAV70TY8ImpQDKTgubKDMKWtWYfbMOO8VHRdU8TINJe9ezkSfRcOqXOuKVGyEGbtFbL2nxImD57
 OZUMbTOp3YuyIfRLVaq2vs6cDbeN5g24HrXCKsas86kmySLRGXyINI995KWg80U3HelVswN9uB5v
 R2ABO3TExcf2FUd140DMJ7NVGgXBq7VEQJQnyWHK_1AHfaLQGSjHN.VAKQbr.SdQ__zNug.GOxIr
 c86yq7oBF9osgBuhVX2jHtN4zxoV.GE1tLqmIYtcVmwg.GvcFfswHrUX2tphLxiQxbApxhQGHaub
 AP.1FubRQsWrZBILYpWyk1v4ABexlz9aeq1p1dTpqix.bzBb500gC2bnfDBvjRBNJFtflofd_xuL
 uEYkme_ySgOkXVccPTaYEUOdggcpxMePBueWfv6Qvo9Mu.djeV_MwHhcW9AuzOOWTeLMyYy3LioH
 s6zHnh4euZhLm6nEW6MyvCVjgd6pu1Pi7NLIqDta2gmqocur5iioghRtLTLKPGauwxE5SbcUhWWD
 lmDJjL4XhjCWg5GHU0HyFzzgPDq8vAOmBy.6GLNFT.xf2gjbbi82c7w_G9p4hvinuEWix_YAwm9Q
 43rC7RaP75q1TFgddBbcUkZB6AGoRPb_siVFPYC7atEGLoK20uMEE_lHQxFwTzeEchFJhKTrxruz
 QZdi0aws7zOKP5gNdO81AMdA4f5.etTVjKRKcg.KPZhhCDhSWSrOuRTt_WyFgJvnynLSH3yADG8R
 _gTJ9RWVL1iHRZVBHPizzzM6kAU5gWkhyUfy74F47YcuYR3N1gfMQYsWgtTwuTOtzBn3Ulr5jQf2
 TdnOPNICHzU3leVensqgBfzM0LcYpRz4eLS87gU4a1xy2JgaGGIU1oH6LKkMvMhYuMn9xN2YQl5c
 UJnUn8Jt5PEeq3pjRTJnkCKiSMemL3z5vMw_PbHfrWHcFlF3xF5B.WPHynaayvLUuQqwrjy4Yyg6
 r9xYBqL91NuBWF2Z1RN_J.iv_uTIg4rN2jhWPs9VP0Aqr.GNMyvwtWgFdI_Uv.v88FNLZQcfpSYf
 g2PWkk7L1gyv0_XsHH3B0pUd1Zbl8ULn3RcfJQDXT8H9puPYq1.tiu4NETXt0yZyS33guGt0AnyZ
 jRpsjSrHG1Olq8240NSQ.ZCb7_vhxMPc2K6VMOu2kAakUkxJ5AWUz5rcTn3d78KU_SeS6jnn1iFf
 W5OZMdbpnQXSj8uB5z5JWxrrTp0a228OjpQ0p8KnlxV99PoBo5I001NRA.witTHfGAd5gpDodghy
 M.1TXwpu9Qba_8nj1u7VG2ZlnUhoxL0STaydE56QNMybD7oRnoqIrejMLNY5kx.oaN_PD8tiTQgL
 YIqb6fdh31MjroJYIGqivdGct5cg5ZhL9XEeI8C0dBjTpRen3j1XhcwUm3K4CteaPbiXkebdR3k1
 8ApRipS_jubECas7HOpycjg--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Sun, 7 Aug 2022 23:03:57 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-r76pr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 12b0bfa600682cb6edf92800aaf76d46;
          Sun, 07 Aug 2022 23:03:55 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v5 06/14] iio: magnetometer: yas530: Rename functions and registers
Date:   Mon,  8 Aug 2022 01:02:11 +0200
Message-Id: <ca008512c5196a377042cd71254dedad3668bb44.1659909060.git.jahau@rocketmail.com>
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

This is a preparation for adding YAS537 variant.

Functions that are used only by YAS530, YAS532 and YAS533 are renamed from
yas5xx to yas530. Same for the registers.

To avoid part listing in function and registers names, the name of the first
variant is used. Where appropriate, comments were added that these functions
are used by more than one variant.

Functions that will be used by all variants including YAS537 remain in the
naming scheme yas5xx. Or YAS5XX for registers, respectively.

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 126 +++++++++++++----------
 1 file changed, 70 insertions(+), 56 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 839baeca673a..b27cc2b432ee 100644
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
+ * Used by YAS530, YAS532 and YAS533
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
+ * Used by YAS530, YAS532 and YAS533
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
+ * Used by YAS530, YAS532 and YAS533
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
 
@@ -1062,7 +1076,7 @@ static int __maybe_unused yas5xx_runtime_resume(struct device *dev)
 	usleep_range(31000, 40000);
 	gpiod_set_value_cansleep(yas5xx->reset, 0);
 
-	ret = yas5xx_power_on(yas5xx);
+	ret = yas530_power_on(yas5xx);
 	if (ret) {
 		dev_err(dev, "cannot power on\n");
 		goto out_reset;
-- 
2.35.1

