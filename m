Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28191543FFA
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jun 2022 01:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbiFHXkI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Jun 2022 19:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbiFHXkA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jun 2022 19:40:00 -0400
Received: from sonic302-21.consmr.mail.ir2.yahoo.com (sonic302-21.consmr.mail.ir2.yahoo.com [87.248.110.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6625B15EA7D
        for <linux-iio@vger.kernel.org>; Wed,  8 Jun 2022 16:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1654731562; bh=+w6vXblxdr04/ds+benH4vi4a7Q9Yjx67tkPsFkFVt0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=l52eye+IPk+HMi6lYry1Bte+5rmrbP7tAgKlYMqVxm3grncXWdPMroN300MDnDYtWOZ2nokIbnfvfrTCjQNiY2YvShzMLuMd9+YPZpieO9G+oxXjOBd/M3hV4SCtBHQaTTcN9PJS+r18gWTbjGefI4tRngUtIfWOxOTMQixQWLb1/o9/yfxhny47FCFUxn5CEvbu7jqnRllAZs8VMBmWyJyxvIEmXFVtQuvpd4fDsUq83uukgFCnbRsLyjjQNnwa/wbTVtvqzhiBrqQ/oLG6pjrH5voyU/lv/CMQ+w/XrZADQxe80bUNIMQc0A2E5wTsh1xaysiUKq8slUzkvRqWGQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654731562; bh=E4omoP06wXs+fbrgF2uTV+XyczS+RLQY1nb2ZRsf4BA=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=M5sdVSjWSzcXS249nAWLlxcRDICbHPHFndYjfl/uTsnqz8RkngLhldvyOpeueYsWnFmUAKqQcleRxbX5TL4+4aDRjmmU35MgZI8I1zef58ifn3VJT38IMx9raCFNpj1ZMdo3trVbdcsUMEYd4P/eNaYZ9V86vntYKvVpOvk01cRvRhCNaQ81Gtkxoh7QNbY0FvVS93gZhmsIUKM3FrOgdgkuY+9PTcJ6G8S1qXlWm2mMchl9IhurB8S7gsCFZjC5kJ4lL/+4pCvLHq8SyKK01G9/xBK8Y0KIMDR3+gl04Hv+XktB6ifvb6qhxBYTLY9Yh3cEHUIEpBpDR6XBYiKACQ==
X-YMail-OSG: LlRrmIYVM1lBYHldacCkxmDZPM2E5uEIxPR6Oj2tDtOpR1K6GUZOtnF2FxtDmjh
 qxa6lEDIIyaFMGY.oAZi99FwBTU45K.ui_2H7apP_GlQBEaAtamw_zEH1Dl1Ks_2hydqv4EEyD16
 xrTcmne4FwqatA4ulRWcHHVzqk9Fy0Nt1q21q5DqeWY_LQuj87mmkZ4HxQiZ1yF_lMa23XCHjLdC
 .SgYU8UQGUGLsPsB.i6G08NZcPf.kAvHuATb0ihBtSKamqSHo_9.rggvF81Iir0r9hvhlfUxx52a
 j71XY.f4vwMdZB39IVnTat5A0PPPY5CdwketZe4Ep_hwwl4XyL8ZV5dE6ISbxMU5YUxwLfkf_2tv
 eiUby2Umo6a7rs1q1mhBY8FN7scbKgBmBNyU8yIwgDg0zYuZFOOwGx_Dew2jsG6aCrSFECX_JfIQ
 3_ORPIxSkzfeCggN6Iqx9JHCMnxKFeOydeGP6obQrUbJU0e7W6qBH6kKYGAVS8SRsWZSu1UoSdjx
 x68_dUFpIL3ZAVEmYN1hryq6necf6CEYIE20P4CbnEDz1kGgdvIK0vi.JyHIyPtv84XoFNzNc9jz
 ki96uRVNWgeloCKJv4ukEw8dJhcyrX1qboEsp6v2kAmhrOn8XbuIUfKZTU4N6.YSxe.k6THn923D
 zjdmGk3oBDhL._vmbIMTaVB5Ag0duK94yjQo_ZRD0XxDPO8_2s9OeXL6IagVEcQeyV0Fnj1a7x9D
 4jJTSuC_tNGxI.fLFdS.fEBNDCj33XYOmMtw5bZXOoa8cjQBGBtELHv4pweuz86Ovy6DOwEiLDi.
 iFSdgWcwXdhKwSCFl07Rj.t6Nu5rgpdFj6GiYkEEn5.bossROp8fJtfYEXheTDcx8CAdc_m.1GDk
 xFMyE3Pi90BdueRypzxn1xmF1U95faPkn8BfCPrQKldtNUNXY5AorYi9EK0Ls_ucrn1BuZ8LKmdL
 IylVjkfDuaXAA1bt7NPgU7tG6dCq_MCsGHZ63xITPuzmnoBWyfMEUlVdHE95.4uQ_4XFrjKpiN2s
 iH_4PrjOAXAE.b40IUiTEpdhjaRiP9yP_rXsHu2ebtzKX7k8ARE29HNioZz1nk9ms9rU1jyAGKoW
 uCgrOpZm0uAgGJDvdyEvV5MqfXHi.RzTPXhMnYVIZPVrJWm3FIuKBa6_mSEPhD4PLvZa2fe4.tu2
 7OBqv_tElTF_cGA0TIkaOhPgNlfnHWMSK6fXefQrnyvVGp1_9b6K67045bL5oOMDRVQujTX4qgTv
 oYQKCHsIn7lXX.OCeWVDC4oyq0lwsXOs5ftZg16PvLO.vbxynurpoJm_Pq1hX6UebpFyCpCzGUem
 .UKUfXXfJYbHQNFPWwY7nd0PCUFtd1y52echI.bnVZfLGtDGa1RpI..r42JdRVOzUsPElIWj6O0S
 buBeW01bm0vRgfRDEOvaVLwjp.Fj.BoYFJaBpiidtSswUviyeCOCOb4O6o2QWn3KOcdcgt2QSkpQ
 B5GaDIl_xM11hWAzZ2irydwW52M3p4LYQD_p6gU6gdJU9mZiNrR4N_E0LacDeH7JkfeEE2x18GqO
 nGXmks.h2K1UxN3yQAur5EVJQfwMfHvNc55e1lGwKGmkjyhbe5hilFyMc8bNhtYe8.dAOmhZ3rba
 HpmtkNb77lE9at55sa92S9K3K6TyWuDzmCnfwZ33VFR2pNwYt6X39q.OZByHLSlhP5Gsxd8ZFa1h
 dzFlDA2bByWCyXuCV.s6_xt0Gzg9BjMpmk0tk1EUv.NEUFUm7sFSs7EgiGXsfJb1vx5p_ffAt3yi
 8QAq9Aba3fvOYOHSzlNO20PtcSUWoNPEMDkubrJgw8dRyaGFXj33glLYvWmxJnmo4F3nVCHItEHa
 FtygwxHvWa3LFAUJgP_.mKJI0n8eemd00yXga2osCd0o7ATgr9k5xwqbc7dDYDTUqPg7XCw5RuKf
 KlNhPg8sUtdD6RyuvghEpucRlll_ElktTuDE4IfwVAzLwGSXEK3yO_mCdm7kHWTZ.Z01XFMwvXts
 BKRaym2XzbRVZsQizkyX.vTwSkb9DXrvgyG7QyOLMOcb8plRJvpSVC.r9Ei2Mk2ysG6bYibStwXN
 o4_uDiQl3u.ci5IGYTrt8tao7jk.MjuYPQEyERg9SXhktWgv_hOcf1nZSmE3PxQfRyLjA1MAdQBh
 coJ_G23Vl5wH4Rcp5PwxjO5G2REFivoQiNqpiPodwFMjad0d6gK6m0SsFGHoa4mxcbPE2uhSz9Zf
 sZqw.EgxM0oYxRO0n8xrNf69KqeHogKhHabUFOgWABqK0QMrLdu.d0U4oTH2LauhmYmOaGLl0GcG
 YAXIG_VgJtIiy1zjb
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Wed, 8 Jun 2022 23:39:22 +0000
Received: by hermes--canary-production-ir2-6c7595c778-tcd7b (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f9021a74071b88f5034921531ba09f62;
          Wed, 08 Jun 2022 23:39:16 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH 7/7] iio: magnetometer: yas530: Add YAS537 variant
Date:   Thu,  9 Jun 2022 01:38:06 +0200
Message-Id: <a914ca0ea6f0149cd2941d60ae6fa2f49927f66a.1654727058.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1654727058.git.jahau@rocketmail.com>
References: <cover.1654727058.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This adds support for the magnetometer Yamaha YAS537. The additions are based
on comparison of Yamaha Android kernel drivers for YAS532 [1] and YAS537 [2].

Functions used by YAS530 & YAS532 only were renamed from yas5xx to yas530_532.
Registers were renamed accordingly.

In the Yamaha YAS537 Android driver, there is an overflow/underflow control
implemented. For regular usage, this seems not necessary. A similar overflow/
underflow control of Yamaha YAS530/532 Android driver isn't integrated in the
mainline driver. It is therefore skipped for YAS537 in mainline too.

Also in the Yamaha YAS537 Android driver, at the end of the reset_yas537()
function, a measurement is saved in "last_after_rcoil". Later on, this is
compared to current measurements. If the difference gets too big, a new
reset is intialized. The difference in measurements needs to be quite big,
it's hard to say if this is necessary for regular operation. Therefore this
isn't integrated in the mainline driver either.

[1] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas532.c
[2] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas537.c

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 drivers/iio/magnetometer/Kconfig         |   4 +-
 drivers/iio/magnetometer/yamaha-yas530.c | 683 ++++++++++++++++++++---
 2 files changed, 609 insertions(+), 78 deletions(-)

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 07eb619bcfe8..868128cee835 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -216,8 +216,8 @@ config YAMAHA_YAS530
 	select IIO_TRIGGERED_BUFFER
 	help
 	  Say Y here to add support for the Yamaha YAS530 series of
-	  3-Axis Magnetometers. Right now YAS530, YAS532 and YAS533 are
-	  fully supported.
+	  3-Axis Magnetometers. Right now YAS530, YAS532, YAS533 and
+	  YAS537 are fully supported.
 
 	  This driver can also be compiled as a module.
 	  To compile this driver as a module, choose M here: the module
diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 59844e1b794c..ca755b72f7c4 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -10,13 +10,16 @@
  * (YAS534 is a magnetic switch, not handled)
  * YAS535 MS-6C
  * YAS536 MS-3W
- * YAS537 MS-3T (2015 Samsung Galaxy S6, Note 5, Xiaomi)
+ * YAS537 MS-3T (2015 Samsung Galaxy S6, Note 5, Galaxy S7)
  * YAS539 MS-3S (2018 Samsung Galaxy A7 SM-A750FN)
  *
  * Code functions found in the MPU3050 YAS530 and YAS532 drivers
  * named "inv_compass" in the Tegra Android kernel tree.
  * Copyright (C) 2012 InvenSense Corporation
  *
+ * Code functions for YAS537 based on Yamaha Android kernel driver.
+ * Copyright (c) 2014 Yamaha Corporation
+ *
  * Author: Linus Walleij <linus.walleij@linaro.org>
  */
 #include <linux/bitfield.h>
@@ -40,20 +43,39 @@
 
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
@@ -65,6 +87,7 @@
 #define YAS5XX_MEASURE_LDTC		BIT(1)
 #define YAS5XX_MEASURE_FORS		BIT(2)
 #define YAS5XX_MEASURE_DLYMES		BIT(4)
+#define YAS5XX_MEASURE_CONT		BIT(5)
 
 /* Bits in the measure data register */
 #define YAS5XX_MEASURE_DATA_BUSY	BIT(7)
@@ -91,8 +114,15 @@
 #define YAS532_DATA_OVERFLOW		(BIT(YAS532_DATA_BITS) - 1)
 #define YAS532_20DEGREES		390 /* Counts starting at -50 °C */
 
-/* These variant IDs are known from code dumps */
 #define YAS537_DEVICE_ID		0x07 /* YAS537 (MS-3T) */
+#define YAS537_VERSION_0		0 /* Version naming unknown */
+#define YAS537_VERSION_1		1 /* Version naming unknown */
+#define YAS537_MAG_AVERAGE_32_MASK	GENMASK(6, 4) /* corresponds to 0x70 */
+#define YAS537_MEASURE_TIME_WORST	1500 /* us */
+#define YAS537_DEFAULT_SENSOR_DELAY	50   /* ms */
+#define YAS537_MAG_RCOIL_TIME		65   /* us */
+#define YAS537_20DEGREES		8120 /* Counts starting at -386 °C */
+
 #define YAS539_DEVICE_ID		0x08 /* YAS539 (MS-3S) */
 
 /* Turn off device regulators etc after 5 seconds of inactivity */
@@ -182,7 +212,7 @@ static u16 yas532_extract_axis(u8 *data)
 }
 
 /**
- * yas5xx_measure() - Make a measure from the hardware
+ * yas530_532_measure() - Make a measure from the hardware
  * @yas5xx: The device state
  * @t: the raw temperature measurement
  * @x: the raw x axis measurement
@@ -190,7 +220,8 @@ static u16 yas532_extract_axis(u8 *data)
  * @y2: the y2 axis measurement
  * @return: 0 on success or error code
  */
-static int yas5xx_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y2)
+static int yas530_532_measure(struct yas5xx *yas5xx, u16 *t,
+			      u16 *x, u16 *y1, u16 *y2)
 {
 	unsigned int busy;
 	u8 data[8];
@@ -198,7 +229,7 @@ static int yas5xx_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y
 	u16 val;
 
 	mutex_lock(&yas5xx->lock);
-	ret = regmap_write(yas5xx->map, YAS5XX_MEASURE, YAS5XX_MEASURE_START);
+	ret = regmap_write(yas5xx->map, YAS530_532_MEASURE, YAS5XX_MEASURE_START);
 	if (ret < 0)
 		goto out_unlock;
 
@@ -260,7 +291,85 @@ static int yas5xx_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y
 	return ret;
 }
 
-static s32 yas5xx_linearize(struct yas5xx *yas5xx, u16 val, int axis)
+/**
+ * yas537_measure() - Make a measure from the hardware
+ * @yas5xx: The device state
+ * @t: the raw temperature measurement
+ * @x: the raw x axis measurement
+ * @y1: the y1 axis measurement
+ * @y2: the y2 axis measurement
+ * @return: 0 on success or error code
+ */
+static int yas537_measure(struct yas5xx *yas5xx, u16 *t,
+			  u16 *x, u16 *y1, u16 *y2)
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
+	ret = regmap_write(yas5xx->map, YAS537_MEASURE, (YAS5XX_MEASURE_START |
+			   YAS5XX_MEASURE_CONT));
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
+	/* Read data */
+	ret = regmap_bulk_read(yas5xx->map, YAS5XX_MEASURE_DATA,
+			       data, sizeof(data));
+	if (ret)
+		goto out_unlock;
+
+	mutex_unlock(&yas5xx->lock);
+
+	/* Arrange data */
+	*t = ((data[0] << 8) | data[1]);
+	xy1y2[0] = ((FIELD_GET(GENMASK(5, 0), data[2]) << 8) | data[3]);
+	xy1y2[1] = ((data[4] << 8) | data[5]);
+	xy1y2[2] = ((data[6] << 8) | data[7]);
+
+	/* The second version of YAS537 needs to include calibration coefficients */
+	if (yas5xx->version == YAS537_VERSION_1) {
+		for (i = 0; i < 3; i++)
+			s[i] = xy1y2[i] - 8192;
+		h[0] = (c->k *   (128 * s[0] + c->a2 * s[1] + c->a3 * s[2])) / 8192;
+		h[1] = (c->k * (c->a4 * s[0] + c->a5 * s[1] + c->a6 * s[2])) / 8192;
+		h[2] = (c->k * (c->a7 * s[0] + c->a8 * s[1] + c->a9 * s[2])) / 8192;
+		for (i = 0; i < 3; i++) {
+			if (h[i] < -8192)
+				h[i] = -8192;
+			if (h[i] > 8191)
+				h[i] = 8191;
+			xy1y2[i] = h[i] + 8192;
+		}
+	}
+
+	/* Assign data */
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
+static s32 yas530_532_linearize(struct yas5xx *yas5xx, u16 val, int axis)
 {
 	struct yas5xx_calibration *c = &yas5xx->calibration;
 	static const s32 yas532ac_coef[] = {
@@ -299,7 +408,7 @@ static s32 yas5xx_linearize(struct yas5xx *yas5xx, u16 val, int axis)
 }
 
 /**
- * yas5xx_get_measure() - Measure a sample of all axis and process
+ * yas530_532_get_measure() - Measure a sample of all axis and process
  * @yas5xx: The device state
  * @to: Temperature out
  * @xo: X axis out
@@ -307,23 +416,24 @@ static s32 yas5xx_linearize(struct yas5xx *yas5xx, u16 val, int axis)
  * @zo: Z axis out
  * @return: 0 on success or error code
  */
-static int yas5xx_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo, s32 *zo)
+static int yas530_532_get_measure(struct yas5xx *yas5xx, s32 *to,
+				  s32 *xo, s32 *yo, s32 *zo)
 {
 	struct yas5xx_calibration *c = &yas5xx->calibration;
 	u16 t_ref, t, x, y1, y2;
-	/* These are "signed x, signed y1 etc */
+	/* These are signed x, signed y1 etc */
 	s32 sx, sy1, sy2, sy, sz;
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
@@ -420,6 +530,57 @@ static int yas5xx_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo,
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
+static int yas537_get_measure(struct yas5xx *yas5xx, s32 *to,
+			      s32 *xo, s32 *yo, s32 *zo)
+{
+	u16 t_ref, t, x, y1, y2;
+	int ret;
+
+	/* We first get raw data that needs to be translated to [x,y,z] */
+	ret = yas537_measure(yas5xx, &t, &x, &y1, &y2);
+	if (ret)
+		return ret;
+
+	/* Set the temperature reference value (unit: counts) */
+	t_ref = YAS537_20DEGREES;
+
+	/*
+	 * Raw temperature value t is number of counts. A product description
+	 * of YAS537 mentions a temperature resulution of 0.05 °C/count.
+	 * A readout of the t value at ca. 20 °C returns approx. 8120 counts.
+	 *
+	 * 8120 counts x 0.05 °C/count corresponds to a range of 406 °C.
+	 * 0 counts would be at theoretical -386 °C.
+	 *
+	 * The formula used for YAS530/532 needs to be adapted to this
+	 * theoretical starting temperature, again calculating with 1/10:s
+	 * of degrees Celsius and finally multiplying by 100 to get milli
+	 * degrees Celsius.
+	 */
+	*to = ((4060 * t / t_ref) - 3860) * 100;
+
+	/*
+	 * Unfortunately, no linearization or temperature compensation formulas
+	 * are known for YAS537.
+	 */
+
+	/* Calculate x, y, z from x, y1, y2 */
+	*xo = (x - 8192) * 300;
+	*yo = (y1 - y2) * 1732 / 10;
+	*zo = (-y1 - y2 + 16384) * 300;
+
+	return 0;
+}
+
 static int yas5xx_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2,
@@ -433,7 +594,15 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_PROCESSED:
 	case IIO_CHAN_INFO_RAW:
 		pm_runtime_get_sync(yas5xx->dev);
-		ret = yas5xx_get_measure(yas5xx, &t, &x, &y, &z);
+		switch (yas5xx->devid) {
+		case YAS530_DEVICE_ID:
+		case YAS532_DEVICE_ID:
+			ret = yas530_532_get_measure(yas5xx, &t, &x, &y, &z);
+			break;
+		case YAS537_DEVICE_ID:
+			ret = yas537_get_measure(yas5xx, &t, &x, &y, &z);
+			break;
+		}
 		pm_runtime_mark_last_busy(yas5xx->dev);
 		pm_runtime_put_autosuspend(yas5xx->dev);
 		if (ret)
@@ -467,9 +636,10 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
 			*val2 = 100000000;
 			break;
 		case YAS532_DEVICE_ID:
+		case YAS537_DEVICE_ID:
 			/*
-			 * Raw values of YAS532 are in nanotesla. Devide by
-			 * 100000 (10^5) to get Gauss.
+			 * Raw values of YAS532 and YAS537 are in nanotesla.
+			 * Devide by 100000 (10^5) to get Gauss.
 			 */
 			*val = 1;
 			*val2 = 100000;
@@ -489,7 +659,15 @@ static void yas5xx_fill_buffer(struct iio_dev *indio_dev)
 	int ret;
 
 	pm_runtime_get_sync(yas5xx->dev);
-	ret = yas5xx_get_measure(yas5xx, &t, &x, &y, &z);
+	switch (yas5xx->devid) {
+	case YAS530_DEVICE_ID:
+	case YAS532_DEVICE_ID:
+		ret = yas530_532_get_measure(yas5xx, &t, &x, &y, &z);
+		break;
+	case YAS537_DEVICE_ID:
+		ret = yas537_get_measure(yas5xx, &t, &x, &y, &z);
+		break;
+	}
 	pm_runtime_mark_last_busy(yas5xx->dev);
 	pm_runtime_put_autosuspend(yas5xx->dev);
 	if (ret) {
@@ -575,9 +753,30 @@ static const struct iio_info yas5xx_info = {
 
 static bool yas5xx_volatile_reg(struct device *dev, unsigned int reg)
 {
-	return reg == YAS5XX_ACTUATE_INIT_COIL ||
-		reg == YAS5XX_MEASURE ||
-		(reg >= YAS5XX_MEASURE_DATA && reg <= YAS5XX_MEASURE_DATA + 7);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct yas5xx *yas5xx = iio_priv(indio_dev);
+
+	if (reg >= YAS5XX_MEASURE_DATA && reg <= YAS5XX_MEASURE_DATA + 7)
+		return true;
+
+	/*
+	 * YAS versions share different registers on the same address,
+	 * need to differentiate.
+	 */
+	switch (yas5xx->devid) {
+	case YAS530_DEVICE_ID:
+	case YAS532_DEVICE_ID:
+		if (reg == YAS530_532_ACTUATE_INIT_COIL ||
+		    reg == YAS530_532_MEASURE)
+			return true;
+		break;
+	case YAS537_DEVICE_ID:
+		if (reg == YAS537_MEASURE)
+			return true;
+		break;
+	}
+
+	return false;
 }
 
 /* TODO: enable regmap cache, using mark dirty and sync at runtime resume */
@@ -589,11 +788,11 @@ static const struct regmap_config yas5xx_regmap_config = {
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
 
@@ -631,24 +830,27 @@ static int yas530_get_calibration_data(struct yas5xx *yas5xx)
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
 
+	/* Contribute calibration data to the input pool for kernel entropy */
 	add_device_randomness(data, sizeof(data));
+
+	/* Extract version */
 	yas5xx->version = data[15] & GENMASK(1, 0);
 
 	/* Extract the calibration from the bitfield */
 	c->Cx = data[0] * 6 - 768;
 	c->Cy1 = data[1] * 6 - 768;
 	c->Cy2 = data[2] * 6 - 768;
-	yas53x_extract_calibration(&data[3], c);
+	yas530_532_extract_calibration(&data[3], c);
 
 	/*
 	 * Extract linearization:
@@ -668,6 +870,7 @@ static int yas530_get_calibration_data(struct yas5xx *yas5xx)
 	c->r[0] = sign_extend32(FIELD_GET(GENMASK(28, 23), val), 5);
 	c->r[1] = sign_extend32(FIELD_GET(GENMASK(20, 15), val), 5);
 	c->r[2] = sign_extend32(FIELD_GET(GENMASK(12, 7), val), 5);
+
 	return 0;
 }
 
@@ -679,11 +882,11 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
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
@@ -694,7 +897,9 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
 			dev_warn(yas5xx->dev, "calibration is blank!\n");
 	}
 
+	/* Contribute calibration data to the input pool for kernel entropy */
 	add_device_randomness(data, sizeof(data));
+
 	/* Only one bit of version info reserved here as far as we know */
 	yas5xx->version = data[13] & BIT(0);
 
@@ -702,7 +907,8 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
 	c->Cx = data[0] * 10 - 1280;
 	c->Cy1 = data[1] * 10 - 1280;
 	c->Cy2 = data[2] * 10 - 1280;
-	yas53x_extract_calibration(&data[3], c);
+	yas530_532_extract_calibration(&data[3], c);
+
 	/*
 	 * Extract linearization:
 	 * Linearization layout in the 32 bits at byte 10:
@@ -725,7 +931,217 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
 	return 0;
 }
 
-static void yas5xx_dump_calibration(struct yas5xx *yas5xx)
+static int yas537_get_calibration_data(struct yas5xx *yas5xx)
+{
+	struct yas5xx_calibration *c = &yas5xx->calibration;
+	u8 data[17];
+	u32 val1, val2, val3, val4;
+	int i, ret;
+
+	/* Writing SRST register, the exact meaning is unknown */
+	ret = regmap_write(yas5xx->map, YAS537_SRST, BIT(1));
+	if (ret)
+		return ret;
+
+	/* Calibration readout, YAS537 needs one readout only */
+	ret = regmap_bulk_read(yas5xx->map, YAS537_CAL, data, sizeof(data));
+	if (ret)
+		return ret;
+	dev_dbg(yas5xx->dev, "calibration data: %*ph\n", 17, data);
+
+	/* Sanity check, is this all zeroes? */
+	if (memchr_inv(data, 0x00, 16) == NULL) {
+		if (FIELD_GET(GENMASK(5, 0), data[16]) == 0)
+			dev_warn(yas5xx->dev, "calibration is blank!\n");
+	}
+
+	/* Contribute calibration data to the input pool for kernel entropy */
+	add_device_randomness(data, sizeof(data));
+
+	/* Extract version information */
+	yas5xx->version = FIELD_GET(GENMASK(7, 6), data[16]);
+
+	/* There are two versions of YAS537 behaving differently */
+	switch (yas5xx->version) {
+
+	case YAS537_VERSION_0:
+
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
+
+		for (i = 0; i < 17; i++) {
+			if (i < 12) {
+				ret = regmap_write(yas5xx->map,
+						   YAS537_MTC + i,
+						   data[i]);
+				if (ret)
+					return ret;
+			} else if (i < 15) {
+				ret = regmap_write(yas5xx->map,
+						   YAS537_OFFSET_X + i - 12,
+						   data[i]);
+				if (ret)
+					return ret;
+				yas5xx->hard_offsets[i - 12] = data[i];
+			} else {
+				ret = regmap_write(yas5xx->map,
+						   YAS537_HCK + i - 15,
+						   data[i]);
+				if (ret)
+					return ret;
+			}
+		}
+
+		break;
+
+	case YAS537_VERSION_1:
+
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
+
+		for (i = 0; i < 3; i++) {
+			ret = regmap_write(yas5xx->map, YAS537_MTC + i,
+					   data[i]);
+			if (ret)
+				return ret;
+			ret = regmap_write(yas5xx->map, YAS537_OFFSET_X + i,
+					   data[i + 12]);
+			if (ret)
+				return ret;
+			yas5xx->hard_offsets[i] = data[i + 12];
+		}
+
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
+
+		ret = regmap_write(yas5xx->map, YAS537_MTC + 3,
+				   ((data[3] & GENMASK(7, 5)) | BIT(4)));
+		if (ret)
+			return ret;
+		ret = regmap_write(yas5xx->map, YAS537_HCK,
+				   (FIELD_GET(GENMASK(7, 4), data[15]) << 1));
+		if (ret)
+			return ret;
+		ret = regmap_write(yas5xx->map, YAS537_LCK,
+				   (FIELD_GET(GENMASK(3, 0), data[15]) << 1));
+		if (ret)
+			return ret;
+		ret = regmap_write(yas5xx->map, YAS537_OC,
+				   FIELD_GET(GENMASK(5, 0), data[16]));
+		if (ret)
+			return ret;
+
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
+
+		/* Get data into these three blocks val1 to val3 */
+		val1 = get_unaligned_be32(&data[0]);
+		val2 = get_unaligned_be32(&data[3]);
+		val3 = get_unaligned_be32(&data[6]);
+		val4 = get_unaligned_be32(&data[9]);
+
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
+
+		break;
+
+	default:
+		dev_err(yas5xx->dev, "unknown version of YAS537\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void yas530_532_dump_calibration(struct yas5xx *yas5xx)
 {
 	struct yas5xx_calibration *c = &yas5xx->calibration;
 
@@ -748,20 +1164,68 @@ static void yas5xx_dump_calibration(struct yas5xx *yas5xx)
 	dev_dbg(yas5xx->dev, "dck = %d\n", c->dck);
 }
 
-static int yas5xx_set_offsets(struct yas5xx *yas5xx, s8 ox, s8 oy1, s8 oy2)
+static void yas537_dump_calibration(struct yas5xx *yas5xx)
+{
+	struct yas5xx_calibration *c = &yas5xx->calibration;
+	unsigned int val;
+	int i;
+
+	switch (yas5xx->version) {
+	case YAS537_VERSION_0:
+		for (i = 0x84; i < 0x9f; i++) {
+			if (i <= 0x86 || ((i >= 0x88) & (i <= 0x89)) ||
+			    i >= 0x93) {
+				regmap_read(yas5xx->map, i, &val);
+				dev_dbg(yas5xx->dev, "register 0x%02x: %u\n",
+					i, val);
+			}
+		}
+		break;
+	case YAS537_VERSION_1:
+		for (i = 0x84; i < 0x9f; i++) {
+			if (i <= 0x86 || ((i >= 0x88) & (i <= 0x89)) ||
+			    ((i >= 0x93) & (i <= 0x96)) || i == 0x9e) {
+				regmap_read(yas5xx->map, i, &val);
+				dev_dbg(yas5xx->dev, "register 0x%02x: %u\n",
+					i, val);
+			}
+		}
+		dev_dbg(yas5xx->dev, "hard_offset x: %d\n",
+			yas5xx->hard_offsets[0]);
+		dev_dbg(yas5xx->dev, "hard_offset y1: %d\n",
+			yas5xx->hard_offsets[1]);
+		dev_dbg(yas5xx->dev, "hard_offset y2: %d\n",
+			yas5xx->hard_offsets[2]);
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
+		break;
+	}
+}
+
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
@@ -770,7 +1234,7 @@ static s8 yas5xx_adjust_offset(s8 old, int bit, u16 center, u16 measure)
 	return old;
 }
 
-static int yas5xx_meaure_offsets(struct yas5xx *yas5xx)
+static int yas530_532_measure_offsets(struct yas5xx *yas5xx)
 {
 	int ret;
 	u16 center;
@@ -779,7 +1243,7 @@ static int yas5xx_meaure_offsets(struct yas5xx *yas5xx)
 	int i;
 
 	/* Actuate the init coil and measure offsets */
-	ret = regmap_write(yas5xx->map, YAS5XX_ACTUATE_INIT_COIL, 0);
+	ret = regmap_write(yas5xx->map, YAS530_532_ACTUATE_INIT_COIL, 0);
 	if (ret)
 		return ret;
 
@@ -810,26 +1274,26 @@ static int yas5xx_meaure_offsets(struct yas5xx *yas5xx)
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
 
@@ -838,27 +1302,64 @@ static int yas5xx_meaure_offsets(struct yas5xx *yas5xx)
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
+}
+
+static int yas537_power_on(struct yas5xx *yas5xx)
+{
+	int ret;
+	u8 intrvl;
+
+	/* Write registers according to Android driver */
+	ret = regmap_write(yas5xx->map, YAS537_ADCCAL, GENMASK(1, 0));
+	if (ret)
+		return ret;
+	ret = regmap_write(yas5xx->map, YAS537_ADCCAL+1, GENMASK(7, 3));
+	if (ret)
+		return ret;
+	ret = regmap_write(yas5xx->map, YAS537_TRM, GENMASK(7, 0));
+	if (ret)
+		return ret;
+
+	/* The interval value is static in regular operation */
+	intrvl = (YAS537_DEFAULT_SENSOR_DELAY * 1000
+		 - YAS537_MEASURE_TIME_WORST) / 4100;
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
+	usleep_range(YAS537_MAG_RCOIL_TIME, YAS537_MAG_RCOIL_TIME+100);
+
+	return 0;
 }
 
 static int yas5xx_probe(struct i2c_client *i2c,
@@ -919,35 +1420,55 @@ static int yas5xx_probe(struct i2c_client *i2c,
 
 	switch (yas5xx->devid) {
 	case YAS530_DEVICE_ID:
-		ret = yas530_get_calibration_data(yas5xx);
+	case YAS532_DEVICE_ID:
+
+		if (yas5xx->devid == YAS530_DEVICE_ID) {
+			ret = yas530_get_calibration_data(yas5xx);
+			if (ret)
+				goto assert_reset;
+			dev_info(dev, "detected YAS530 MS-3E %s",
+				 yas5xx->version ? "B" : "A");
+			strncpy(yas5xx->name, "yas530", sizeof(yas5xx->name));
+		} else {
+			ret = yas532_get_calibration_data(yas5xx);
+			if (ret)
+				goto assert_reset;
+			dev_info(dev, "detected YAS532/YAS533 MS-3R/F %s",
+				 yas5xx->version ? "AC" : "AB");
+			strncpy(yas5xx->name, "yas532", sizeof(yas5xx->name));
+		}
+
+		yas530_532_dump_calibration(yas5xx);
+		ret = yas530_532_power_on(yas5xx);
+		if (ret)
+			goto assert_reset;
+		ret = yas530_532_measure_offsets(yas5xx);
 		if (ret)
 			goto assert_reset;
-		dev_info(dev, "detected YAS530 MS-3E %s",
-			 yas5xx->version ? "B" : "A");
-		strncpy(yas5xx->name, "yas530", sizeof(yas5xx->name));
 		break;
-	case YAS532_DEVICE_ID:
-		ret = yas532_get_calibration_data(yas5xx);
+
+	case YAS537_DEVICE_ID:
+		ret = yas537_get_calibration_data(yas5xx);
+		if (ret)
+			goto assert_reset;
+		dev_info(dev, "detected YAS537 MS-3T");
+		/* As the version naming is unknown, provide it for debug only */
+		dev_dbg(yas5xx->dev, "YAS537 version: %s\n",
+			yas5xx->version ? "1" : "0");
+		strncpy(yas5xx->name, "yas537", sizeof(yas5xx->name));
+
+		yas537_dump_calibration(yas5xx);
+		ret = yas537_power_on(yas5xx);
 		if (ret)
 			goto assert_reset;
-		dev_info(dev, "detected YAS532/YAS533 MS-3R/F %s",
-			 yas5xx->version ? "AC" : "AB");
-		strncpy(yas5xx->name, "yas532", sizeof(yas5xx->name));
 		break;
+
 	default:
 		ret = -ENODEV;
 		dev_err(dev, "unhandled device ID %02x\n", yas5xx->devid);
 		goto assert_reset;
 	}
 
-	yas5xx_dump_calibration(yas5xx);
-	ret = yas5xx_power_on(yas5xx);
-	if (ret)
-		goto assert_reset;
-	ret = yas5xx_meaure_offsets(yas5xx);
-	if (ret)
-		goto assert_reset;
-
 	indio_dev->info = &yas5xx_info;
 	indio_dev->available_scan_masks = yas5xx_scan_masks;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -1043,7 +1564,15 @@ static int __maybe_unused yas5xx_runtime_resume(struct device *dev)
 	usleep_range(31000, 40000);
 	gpiod_set_value_cansleep(yas5xx->reset, 0);
 
-	ret = yas5xx_power_on(yas5xx);
+	switch (yas5xx->devid) {
+	case YAS530_DEVICE_ID:
+	case YAS532_DEVICE_ID:
+		ret = yas530_532_power_on(yas5xx);
+		break;
+	case YAS537_DEVICE_ID:
+		ret = yas537_power_on(yas5xx);
+		break;
+	}
 	if (ret) {
 		dev_err(dev, "cannot power on\n");
 		goto out_reset;
@@ -1069,6 +1598,7 @@ static const struct i2c_device_id yas5xx_id[] = {
 	{"yas530", },
 	{"yas532", },
 	{"yas533", },
+	{"yas537", },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, yas5xx_id);
@@ -1077,6 +1607,7 @@ static const struct of_device_id yas5xx_of_match[] = {
 	{ .compatible = "yamaha,yas530", },
 	{ .compatible = "yamaha,yas532", },
 	{ .compatible = "yamaha,yas533", },
+	{ .compatible = "yamaha,yas537", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, yas5xx_of_match);
-- 
2.35.1

