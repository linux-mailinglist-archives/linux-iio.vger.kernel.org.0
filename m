Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB81D564A31
	for <lists+linux-iio@lfdr.de>; Mon,  4 Jul 2022 00:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiGCWD2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Jul 2022 18:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiGCWD0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jul 2022 18:03:26 -0400
Received: from sonic301-22.consmr.mail.ir2.yahoo.com (sonic301-22.consmr.mail.ir2.yahoo.com [77.238.176.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EB72BEC
        for <linux-iio@vger.kernel.org>; Sun,  3 Jul 2022 15:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1656885801; bh=3q+WLnoTc6L3URW0sHdvF2JD+anBhYh2Gfku7wYwxQo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=D4evdxNCE8sZEdnjULQlbWzD98aQfqq+6ZvdW6ACiE3KRotL2Xs6lgqPgOos48kfY28utzUmQb35VfE7Ef8CSwZEb8Ycxxxf8QmOFtGs3Q2eAZHEbp2Kwt9oIv4cRshqKh5Pkq8SDhnX9jeX3T4uurmMta2Xk7wb64+B4dR+o+j7gwbI7NxRC44GL+tbJ/4yjRS/LCRqookhonhhuHqjinPy+YEtkk3T4H+S2qN/80qgfeVXaYQ9oJOBAgJY9t1ADAxN7vn5+9s6LVtufEvVBWuVzj1uTNe/KTVO0jP0U9NYbUOZQsM8+2Lq50Koii+oCE+3mW3SKTq9bGcl8Pi6kQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656885801; bh=n1rtSzd97lyqjxCG6LKRCnauniBYf/ToxkRWkfvZCBZ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=V7hQxtKL2Bl4zzKX4OWmlogF8HkhoAQDbdiDpyXJSiSRUl06VERkfH1PxYENzLlS5vlBkZblUuIyz2hw31pE9A0SugXjAXDWD4aLeEPK7eewIau1scZHbpsMm+UiOn6AQ1s2TOi+gOyDepnaN0vNEFNdWEDdTpwX5ajPRXuNYbAtxkVCAvnxJ/lGnpIj2x85ElPf3EymINzLPwYGv2Z6sTKuZQhx86SBmNATTkfDo5joETxG6smFgISkKD5nc1kPMwE+eIeZKgIxs1w/u1hf7J17DyCnTYRlE/O+w/I5aUTtThZT+UKdrgn1Fgsop0F5g0+Beew+CRLcsZBmJWRiYg==
X-YMail-OSG: lrY_qCcVM1l9ke.xGy_ubIzCIwNTjzYXAxHVovmB9y1SQSdmp78zrXo8oLqhEDP
 0Pzz7L286B2A0X4JeCPZYm9Ac5pgf8ogXh6pUqZCBtzWUMdfo7eSTTu7OuXqeFlO3Ai.aewpVjFQ
 i44m_raEvF2BnEvRnDcfrt.qm.nQWsKlcObgwswYXIe7ex_g4swSITaCQe4K05FggjkPLfEZevNz
 PBdVLbHjt2qDSBSucEWetAlLYVvNlheM0J2emgx6TU4Jf5jXi7TjoD5lXqV64QxOnQkA6Kf5nqs8
 UAXWzoL06Cbn23r6d.T8.mIuoYh2XYiF7WfG15hOniT5Nzxz7tHWE5b4kTNwFhxhBRt4zG6Idmet
 4eAfB6IU2lfo2R_85EwsvND1dfTo_pRBnr8p3fuwvYlwrIiySD9bM11qbBGhr6c07plP5bc6Va8Z
 PzHkn.06w.kWw50CgSlmeDF1APt3iHqrB9glS0J8WtjzCeXz9BSd6ev_DZDvjaezeNCKCQBWqpwk
 E6q41O.6UyB5snQ_SJFa6_GlRyooyM1iP94H71.4PJ9soEfhG8aiYSRWYGY1VLpMGJGcXKG1tLUQ
 4nwbXOW79xjOJP0K3wIVU43KFlRcvsBed3GoD5yut_.SNn7E9c5ajsHcVYWg1e4VCeIheXjWrHyz
 2kyz4Iyl70CNx8uH46Wrk3IxFXJI5t_5Fb45gYsLieKBXiynLLKs3OUHTcfQmtVivbUrzEKsZVql
 8ctbrrznY93kPKwluBrR.QboUsdjpdXW3dgLRHmrzf92qeJvtA8UORthkJCLmTE_4wE2z9tMu.Xk
 Q6LUNHEhQ_apTtk9BYe5GFmA62gRE9TY1_B3w1BeBwiLZIm3usTo5IBiOiVfhmtfJL3T_7OcQly8
 h8fc6zi9hzB.BZIArGaTCRlMd7sWhzjDOrARgcr4nK3dfK7seOlG6aLtuf1VaXkgHMjxm3SIaDop
 Y7lXe.gDFub.7kM7uLaLm2yS8KBqbF4P3_XPN4F6CfEP0.JeiOMmcZYgGo6HQkIgmFCehX1ZbPWV
 S6ApHk_cCI7GCmLuDeESrx8Voua0YMIBoMmsUZcLGnQaNH1rjz4AuOdSkED2FcgMDuEOmy39nOWn
 lLedWJOtOXdToyKCm9_Zhe_BF2c4uAUEjK96rev_1DJ_v7qQMCIFfc9l169d7K9s03CKtTAJvgx2
 YiuclD_HkamgOPxgzq0.P6W4NA1zsp_chALlCDA6oipbaekBk1nEGc0ee0FjjaFhtPjz3dVYaLum
 MeZ2UqHTNS1pR5xmPoadaBkW36WlOlZEMs6TwXjl5FErj3zBrNvTU5YwJLZG53Ayppdb2adomn2D
 eNcuecREF2uTZV0uCyx1riJMbKbVPAnsPBTBf003.Yg9x06J11nUSFs0awwtcka2R5eYop1fdw0M
 Bf4qzJOwP9qSpCLE1u9.VASClPtH.r5kV31t4oHM5p.acZ4OxTvai1yEvXBNMyeabJyGSH0KlolR
 xEahCXdrNCXAyaMl8a16Lt4e60tgBWrK0rqtH1ZmMAUSivFP2DGBO3YgKUZ6a8sTRQ23aZ.UHckN
 d2iAPRRLqobY8FJsr8u_6HFym0WwsadLxtveVRvJxBfLV.FqW1T3yPHm6LOhb5jirdXg2LKUGy6S
 EOIb6LSj0G7VtLpaK2s2Iy7zDV_739wRcnw.pSvogiRddT.VZRxuEmAgCVmn5GQySvy1V4a4fs6w
 BHRbsffTbUtcn5Yqf.tV8RoixN9u7GoSJ.dwCLeV6Ls9rCKDHZ3wKxA5R8WylDNvccoe6vEifk1o
 Wkc9Sw4wXv7h65P9aDfsOJYNKAQa49dYGAWigUF21m1aCCzha17cuTTDcr3JDnQd8A30Hv5cePbY
 4qdBdy3UTdJLLokmpBunhfZKnHPz0yGlKDBRXqqzPqCKABpB1GSp2_e8STPgOnLth4lziV3sH78n
 svW9n9ZBZz6sIRSDZkn.yfu.2wzuYIMw8DKvtMMfHIRq25DW3jqrk6JppGNN1UknKnvbMrmwiSp4
 cASyTdzNb_qVqHwofYm_hqbEKXQC9vUZuhGgXzG3kOy5SScXDQiLPjz3Nu2sE3G_oBHhw4cez1a1
 cRAuNLS2DbEDim.ikyDllvRi3e_M91gyE3ZyBoUQRnSEffSR8s3ayehaZMnl48YgeYo17MZnJXHF
 90diKb.UHQJJLWak9fUyt1V9JRxq1i.Bmdf_g2AtIbleRerjjFsn2e4JlkwzWEHBbRQRUXjjvwCx
 ujFIKUXcv2EsW8DygnyHE6STUkpHPCypd.2Uwx_62dFjmd4GiI._i6_6TKUcQDefKD5beVKy19Pu
 UFuWstPGPt6Lnzpq.DA--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Sun, 3 Jul 2022 22:03:21 +0000
Received: by hermes--canary-production-ir2-74b4d6d794-tv8mb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0849bd8970b52a790a5a1bb96f2e336c;
          Sun, 03 Jul 2022 22:03:18 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v4 06/10] iio: magnetometer: yas530: Rename functions and registers
Date:   Mon,  4 Jul 2022 00:02:40 +0200
Message-Id: <24d0ed13b317de4209cfd0b7ecd258af87b1b952.1656883851.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1656883851.git.jahau@rocketmail.com>
References: <cover.1656883851.git.jahau@rocketmail.com>
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
 drivers/iio/magnetometer/yamaha-yas530.c | 113 +++++++++++++----------
 1 file changed, 62 insertions(+), 51 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 839baeca673a..c250909df8f4 100644
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
@@ -182,7 +184,7 @@ static u16 yas532_extract_axis(u8 *data)
 }
 
 /**
- * yas5xx_measure() - Make a measure from the hardware
+ * yas530_measure() - Make a measure from the hardware
  * @yas5xx: The device state
  * @t: the raw temperature measurement
  * @x: the raw x axis measurement
@@ -190,7 +192,8 @@ static u16 yas532_extract_axis(u8 *data)
  * @y2: the y2 axis measurement
  * @return: 0 on success or error code
  */
-static int yas5xx_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y2)
+/* Used by YAS530, YAS532 and YAS533 */
+static int yas530_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y2)
 {
 	unsigned int busy;
 	u8 data[8];
@@ -198,7 +201,7 @@ static int yas5xx_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y
 	u16 val;
 
 	mutex_lock(&yas5xx->lock);
-	ret = regmap_write(yas5xx->map, YAS5XX_MEASURE, YAS5XX_MEASURE_START);
+	ret = regmap_write(yas5xx->map, YAS530_MEASURE, YAS5XX_MEASURE_START);
 	if (ret < 0)
 		goto out_unlock;
 
@@ -264,7 +267,8 @@ static int yas5xx_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y
 	return ret;
 }
 
-static s32 yas5xx_linearize(struct yas5xx *yas5xx, u16 val, int axis)
+/* Used by YAS530, YAS532 and YAS533 */
+static s32 yas530_linearize(struct yas5xx *yas5xx, u16 val, int axis)
 {
 	struct yas5xx_calibration *c = &yas5xx->calibration;
 	static const s32 yas532ac_coef[] = {
@@ -306,7 +310,7 @@ static s32 yas5xx_linearize(struct yas5xx *yas5xx, u16 val, int axis)
 }
 
 /**
- * yas5xx_get_measure() - Measure a sample of all axis and process
+ * yas530_get_measure() - Measure a sample of all axis and process
  * @yas5xx: The device state
  * @to: Temperature out
  * @xo: X axis out
@@ -314,7 +318,8 @@ static s32 yas5xx_linearize(struct yas5xx *yas5xx, u16 val, int axis)
  * @zo: Z axis out
  * @return: 0 on success or error code
  */
-static int yas5xx_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo, s32 *zo)
+/* Used by YAS530, YAS532 and YAS533 */
+static int yas530_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo, s32 *zo)
 {
 	struct yas5xx_calibration *c = &yas5xx->calibration;
 	u16 t_ref, t, x, y1, y2;
@@ -323,14 +328,14 @@ static int yas5xx_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo,
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
@@ -605,11 +610,12 @@ static const struct regmap_config yas5xx_regmap_config = {
 };
 
 /**
- * yas53x_extract_calibration() - extracts the a2-a9 and k calibration
+ * yas530_extract_calibration() - extracts the a2-a9 and k calibration
  * @data: the bitfield to use
  * @c: the calibration to populate
  */
-static void yas53x_extract_calibration(u8 *data, struct yas5xx_calibration *c)
+/* Used by YAS530, YAS532 and YAS533 */
+static void yas530_extract_calibration(u8 *data, struct yas5xx_calibration *c)
 {
 	u64 val = get_unaligned_be64(data);
 
@@ -647,12 +653,12 @@ static int yas530_get_calibration_data(struct yas5xx *yas5xx)
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
@@ -664,7 +670,7 @@ static int yas530_get_calibration_data(struct yas5xx *yas5xx)
 	c->Cx = data[0] * 6 - 768;
 	c->Cy1 = data[1] * 6 - 768;
 	c->Cy2 = data[2] * 6 - 768;
-	yas53x_extract_calibration(&data[3], c);
+	yas530_extract_calibration(&data[3], c);
 
 	/*
 	 * Extract linearization:
@@ -695,11 +701,11 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
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
@@ -718,7 +724,7 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
 	c->Cx = data[0] * 10 - 1280;
 	c->Cy1 = data[1] * 10 - 1280;
 	c->Cy2 = data[2] * 10 - 1280;
-	yas53x_extract_calibration(&data[3], c);
+	yas530_extract_calibration(&data[3], c);
 	/*
 	 * Extract linearization:
 	 * Linearization layout in the 32 bits at byte 10:
@@ -741,7 +747,8 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
 	return 0;
 }
 
-static void yas5xx_dump_calibration(struct yas5xx *yas5xx)
+/* Used by YAS530, YAS532 and YAS533 */
+static void yas530_dump_calibration(struct yas5xx *yas5xx)
 {
 	struct yas5xx_calibration *c = &yas5xx->calibration;
 
@@ -764,20 +771,22 @@ static void yas5xx_dump_calibration(struct yas5xx *yas5xx)
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
@@ -786,7 +795,8 @@ static s8 yas5xx_adjust_offset(s8 old, int bit, u16 center, u16 measure)
 	return old;
 }
 
-static int yas5xx_meaure_offsets(struct yas5xx *yas5xx)
+/* Used by YAS530, YAS532 and YAS533 */
+static int yas530_measure_offsets(struct yas5xx *yas5xx)
 {
 	int ret;
 	u16 center;
@@ -795,7 +805,7 @@ static int yas5xx_meaure_offsets(struct yas5xx *yas5xx)
 	int i;
 
 	/* Actuate the init coil and measure offsets */
-	ret = regmap_write(yas5xx->map, YAS5XX_ACTUATE_INIT_COIL, 0);
+	ret = regmap_write(yas5xx->map, YAS530_ACTUATE_INIT_COIL, 0);
 	if (ret)
 		return ret;
 
@@ -829,26 +839,26 @@ static int yas5xx_meaure_offsets(struct yas5xx *yas5xx)
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
 
@@ -857,27 +867,28 @@ static int yas5xx_meaure_offsets(struct yas5xx *yas5xx)
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
@@ -959,11 +970,11 @@ static int yas5xx_probe(struct i2c_client *i2c,
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
 
-- 
2.35.1

