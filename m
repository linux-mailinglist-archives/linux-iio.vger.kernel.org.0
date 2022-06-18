Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4DD55012E
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jun 2022 02:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbiFRAPS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jun 2022 20:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381999AbiFRAPS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jun 2022 20:15:18 -0400
Received: from sonic303-21.consmr.mail.ir2.yahoo.com (sonic303-21.consmr.mail.ir2.yahoo.com [77.238.178.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8822E28990
        for <linux-iio@vger.kernel.org>; Fri, 17 Jun 2022 17:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1655511312; bh=FUCFiv/rH7deJKomtcQ5oy/kYcRcwMHqiUcoKWdEu24=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=UFWdND6Xp/4jJC8pX6XjmWqA2K53ag/EinpHvnOB9jnp2kGbcLYXVm0J6UASKJ9aTK5bLMdC7phdBH/P/PopKtyM0Cz+Q41gCxZ/VvdTdQdOvZ84VG3Qsp92/YdINXiOsqUdgCkgCVDLq8Tf2XreUjWVEdJ52d4mpku5wZQ51GsF+6xnc2w2+SGvcHYT3E5e1dc1QyJbmCc/8jyExJf9gaJqKITpeMtPbj7eHD9ydMfmqf0y390nEZuomSpmc3JxrSARXqFLiXqCE/aNO193m1JSpD0TxNmO+5S3ZXAfGIC1u+z3ZtnPQkII/DIYSqf2ZUf/kdXsLyE9UR0z7tST1A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655511312; bh=luYNOaEpTKmp6IkfuxJYU3Zmn+X6y285eYh3AsjvxRB=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=DH9fcR/IJv4iu44kPJPLA8bydSybXsBYBJvkqX00glgDCB/p+6Ar7lpxpiFLGIcw/1AhpJ9r+JlZuWaUu8n1VVRijFu3kB8kPrQzV9yBmm1f6Jj+4g9JXU1n9jcvYedbqXAFNUuotdkUCWSHeXogw2A4jCy0PSxi7RClMwD/XtaXcssuXSQ69XEsP7H7Im1yLjeA+T9UBQUcndoFKDhUQ2Fh3cz/X//fW+2ihIEcaR9kJqarMZ1/gAqrkfOUcrLNnji1w4x2WJQIt2PhQ3ISvCmUZi+QCUUdXpGJE6sC5A1nETJ7hLLgNhSctb1RMGP1IR/Ezz5sYuINVqrPa8FFWw==
X-YMail-OSG: SszBAzsVM1mphO.uwg2jGepT5zUVzEJDZmq4yajJXtkKCxFBaKK.2QJSKovLlXV
 IHI_mDMA895YY502za9uk7Ti6MjfdE5fkAlCP5MzIUTI882eHxpnp2dsHHRJS9l34KaaPi7DX3ux
 3f8pIb_mvlf_kj50VC1dJZowvG9VhRSYuFPfBQXIyfeYeXRrZeI39R7TLmx4sSUFqwHUwNVbpxoc
 F2spSEGfiCxTQEB5yl7urNnhWf3DFDJ25btHeFe2Nx9Bc8JRvE3nUvEO_3HVFqckfUF0SHW4DZzM
 F5jX8AEqHUTjyQO9EyAvxwr4THC7s.8rBVvLwJtZtp4YXy3thpXhBCVMW7M5rYsAhVJ5AGVoOR_P
 zvIHZ1S1NOEtywyD8T7ZX3AMmD6DfYne2lb1ToEP1BKsqfmM_0IHry20TpwjTTnHDghRSL.2VAV3
 GYLOFpnm2BA9crwej5FkhOFngIS1o_ILzFXhgwNfU2zJuREEpmb3uOWAAJQIb4O9yQXM3PSohP.1
 dbGb9dYE3.JVcfHuYwCUtELlD82Cw1ngx.o8qKyo34Eg7H7HufDhXlDoeoShX78kC77mqV4VfXmi
 se7IB9ik2cNjkHf54xXNdoidz.Xe1VcMSSX5FMyDT93G4P2fgdKB5XSHUEbL21FtSH7edBS4VIDu
 AGEZpBHBfpxcd7E49RWzh8QRWfWCM14jGTEAQDYu8qXBpkrU3HvILMMzd40rVJTpt1ASngcYwfFV
 5a7g6Kf9iN1QJOjRbEndN5WpwdgzjNy9cugyiEG_RQpCZhOWtAbeJmhHVNkMyepiRM3ogz3zEdGR
 TEYwYj8Y45Btfh.n_rmMgNzO77cULrtXoxtQELoCMNvU0gnrKJmvErE5m9PUaM16I3A28bUaHYTz
 9ELd7D5BRE4vpuNC4nHXMRFE1bVpWbvVgTi3GRJIV4QPUmV_o.rM3J7C9KDPGr8tLYDATHTExMWs
 3cO_rVJ7zDmoQP9Eq49MPIJOkTLi9XzFCTMOzgMpN9arHZxZWKZx0uUDr2CqRS.oOAHhXGqVQRKp
 qs8jszJmjzTKf93rHz1qLoH4mDwg27.sP05nrMlc9LJHpYrS7Dq_HYpUjL_KmZgnbLyq9WUCwvlU
 1l2m3zdw6qpnbt4GPfPBepx2adVPBn6ioaURE94kQeFBxwv1eHUnHpqGXXDE9RoXiOdsCZdPBzd0
 l4lXhVnSfvrO7hfaVi9WfsjLz9dpuSPqG3U4AzgC0XzJLERJS3HA4LvRFzlVa8nEGBQeyijfZKJi
 TNEefiQKGmzLRzOeA6UFt1JAzXuICx7O3_JCYgxB_elO.gmctLon6hdCiSeEI4YHQUiBS3RuVvHo
 8rQhmhSdMlEz63VQNpnlB8rt61JSWiP3btHfRKSjx6Oy2FEYxu_MaHFkQmKbTn0pkN5zjOvTqu0T
 evNYu7l_LgmAVXZIv5T9xd9VBAq13lBmSq3DATkpo2643Q6s_fOjgCYNTTRaYu_eZ47DhgRs93Hu
 AYU6Mnxj.IcLSrAuBBxecBat4oopkbIy5icJJUwCTSPWs3JSr3rWbCO.86CoRR99KrsF8n4FjOFN
 nAtzktiJ4y0FF1.ooAU7BhEXvjTrM36MZwXB2R8MqMjVkYfU1f4ilHwbmee2g4U2fZLq7nfMmJA7
 VILGGUfcYwT0f9MxbDZLwF1ZhYmzxtFvv99Gp5HkkvyOC.8bz.uDeYSgh0YZuvp9bBwwG868x6R7
 4OGNZWk._hbSddGlnHBQkrhCO3F8dOE0Ouo5gZc_qQ7238qu9GoTQ7O3LkoVcDUanjY1jF1SLPeC
 _czTUx.Dy1q8Yff1dmIwbOlqzH06VBqesYglR.m063vRUaJbOKKskGS9Nli8K3Pq3fBhar8j61U5
 eWg5vbv71Vw_17j1UTGuVnxT1tX0T_Xsu7kgveuV6CxM_g_lTIOovgXm_aHo.CvKmQDArPDMb60B
 Lhq_Bppz9.BYYvy1l4afsCz2MzzOMvdvu08cHVlrOyq6Nxysl7INtoRKj7LB4Ng4jAbeUgkgd2lv
 pDtpAPxOtRfmMnnXth2mw6qRAJ1ilhTrztjGyrVxosnzrxI19UhiUNC1yLaODaE0wP2Cp1clS1K2
 5G1amOXqd_9SKVpfHDOyU.8QmbdiOaEJzcTafSEwik85pB0oEwKKjXUoGbH5DFDiiMjwD5iioeh_
 _5WBn0.a8jKPYvghZ4ikT5hbSfV75yuhOz6uR.ip8gboM6YVOE94G1qE5EFpuJjwjaLY2LN5k63g
 kJliM_rBIX3Pw_cblaYCAHY6VNK.dgX4dHgMWrDFz779Pn0BIiq1araQklEPrMKxO2qRyDsqZUcx
 sf2XjdLXhoOZeeLLqkgA-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ir2.yahoo.com with HTTP; Sat, 18 Jun 2022 00:15:12 +0000
Received: by hermes--canary-production-ir2-c9bf9d9bc-74fwm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8b08f14069c990c2ed22165f3e3da032;
          Sat, 18 Jun 2022 00:15:08 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v3 8/8] iio: magnetometer: yas530: Add YAS537 variant
Date:   Sat, 18 Jun 2022 02:13:16 +0200
Message-Id: <3bdb392bb75073bdfe10aab1739fee2d6c64f10c.1655509425.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655509425.git.jahau@rocketmail.com>
References: <cover.1655509425.git.jahau@rocketmail.com>
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

This adds support for the magnetometer Yamaha YAS537. The additions are based
on comparison of Yamaha Android kernel drivers for YAS532 [1] and YAS537 [2].

In the Yamaha YAS537 Android driver, there is an overflow/underflow control
implemented. For regular usage, this seems not necessary. A similar overflow/
underflow control of Yamaha YAS530/532 Android driver isn't integrated in the
mainline driver. It is therefore skipped for YAS537 in mainline too.

Also in the Yamaha YAS537 Android driver, at the end of the reset_yas537()
function, a measurement is saved in "last_after_rcoil". Later on, this is
compared to current measurements. If the difference gets too big, a new
reset is initialized. The difference in measurements needs to be quite big,
it's hard to say if this is necessary for regular operation. Therefore this
isn't integrated in the mainline driver either.

[1] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas532.c
[2] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas537.c

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
The diff on function yas5xx_probe() is a bit confusing. Maybe better to
understand when comparing before and after code.
before: https://github.com/torvalds/linux/blob/v5.19-rc2/drivers/iio/magnetometer/yamaha-yas530.c#L873-L902
after: https://github.com/Jakko3/linux/blob/yas537_v3/drivers/iio/magnetometer/yamaha-yas530.c#L1416-L1463

 drivers/iio/magnetometer/Kconfig         |   4 +-
 drivers/iio/magnetometer/yamaha-yas530.c | 553 +++++++++++++++++++++--
 2 files changed, 529 insertions(+), 28 deletions(-)

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
index 72a75dc57e11..e6123d1d9383 100644
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
@@ -56,6 +59,23 @@
 #define YAS530_532_TEST2		0x89
 #define YAS530_532_CAL			0x90
 
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
@@ -67,6 +87,7 @@
 #define YAS5XX_MEASURE_LDTC		BIT(1)
 #define YAS5XX_MEASURE_FORS		BIT(2)
 #define YAS5XX_MEASURE_DLYMES		BIT(4)
+#define YAS5XX_MEASURE_CONT		BIT(5)
 
 /* Bits in the measure data register */
 #define YAS5XX_MEASURE_DATA_BUSY	BIT(7)
@@ -93,8 +114,15 @@
 #define YAS532_DATA_OVERFLOW		(BIT(YAS532_DATA_BITS) - 1)
 #define YAS532_20DEGREES		390 /* Counts starting at -50 °C */
 
-/* These variant IDs are known from code dumps */
 #define YAS537_DEVICE_ID		0x07 /* YAS537 (MS-3T) */
+#define YAS537_VERSION_0		0 /* Version naming unknown */
+#define YAS537_VERSION_1		1 /* Version naming unknown */
+#define YAS537_MAG_AVERAGE_32_MASK	GENMASK(6, 4)
+#define YAS537_MEASURE_TIME_WORST_US	1500
+#define YAS537_DEFAULT_SENSOR_DELAY_MS	50
+#define YAS537_MAG_RCOIL_TIME_US	65
+#define YAS537_20DEGREES		8120 /* Counts starting at -386 °C */
+
 #define YAS539_DEVICE_ID		0x08 /* YAS539 (MS-3S) */
 
 /* Turn off device regulators etc after 5 seconds of inactivity */
@@ -267,6 +295,78 @@ static int yas530_532_measure(struct yas5xx *yas5xx, u16 *t,
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
 static s32 yas530_532_linearize(struct yas5xx *yas5xx, u16 val, int axis)
 {
 	struct yas5xx_calibration *c = &yas5xx->calibration;
@@ -437,6 +537,58 @@ static int yas530_532_get_measure(struct yas5xx *yas5xx, s32 *to,
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
+	 * Raw temperature value t is the number of counts. YAS537 product
+	 * description No. PBAS537A-000-01-e mentions a temperature resolution
+	 * of 0.05 °C/count. A readout of the t value at ca. 20 °C returns
+	 * approx. 8120 counts.
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
@@ -450,7 +602,18 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
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
+		default:
+			dev_err(yas5xx->dev, "unknown device type\n");
+			return -EINVAL;
+		}
 		pm_runtime_mark_last_busy(yas5xx->dev);
 		pm_runtime_put_autosuspend(yas5xx->dev);
 		if (ret)
@@ -484,9 +647,10 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
 			*val2 = 100000000;
 			break;
 		case YAS532_DEVICE_ID:
+		case YAS537_DEVICE_ID:
 			/*
-			 * Raw values of YAS532 are in nanotesla. Divide by
-			 * 100000 (10^5) to get Gauss.
+			 * Raw values of YAS532 and YAS537 are in nanotesla.
+			 * Divide by 100000 (10^5) to get Gauss.
 			 */
 			*val = 1;
 			*val2 = 100000;
@@ -506,7 +670,18 @@ static void yas5xx_fill_buffer(struct iio_dev *indio_dev)
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
+	default:
+		dev_err(yas5xx->dev, "unknown device type\n");
+		return;
+	}
 	pm_runtime_mark_last_busy(yas5xx->dev);
 	pm_runtime_put_autosuspend(yas5xx->dev);
 	if (ret) {
@@ -592,9 +767,34 @@ static const struct iio_info yas5xx_info = {
 
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
+	default:
+		dev_err(yas5xx->dev, "unknown device type\n");
+		break;
+		/* fall through */
+	}
+
+	return false;
 }
 
 /* TODO: enable regmap cache, using mark dirty and sync at runtime resume */
@@ -749,6 +949,216 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
 	return 0;
 }
 
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
+	dev_dbg(yas5xx->dev, "calibration data: %17ph\n", data);
+
+	/* Sanity check, is this all zeroes? */
+	if (!memchr_inv(data, 0x00, 16)) {
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
+				   (data[3] & GENMASK(7, 5)) | BIT(4));
+		if (ret)
+			return ret;
+		ret = regmap_write(yas5xx->map, YAS537_HCK,
+				   FIELD_GET(GENMASK(7, 4), data[15]) << 1);
+		if (ret)
+			return ret;
+		ret = regmap_write(yas5xx->map, YAS537_LCK,
+				   FIELD_GET(GENMASK(3, 0), data[15]) << 1);
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
+		/* Get data into these four blocks val1 to val4 */
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
 static void yas530_532_dump_calibration(struct yas5xx *yas5xx)
 {
 	struct yas5xx_calibration *c = &yas5xx->calibration;
@@ -772,6 +1182,26 @@ static void yas530_532_dump_calibration(struct yas5xx *yas5xx)
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
 static int yas530_532_set_offsets(struct yas5xx *yas5xx, s8 ox, s8 oy1, s8 oy2)
 {
 	int ret;
@@ -888,6 +1318,45 @@ static int yas530_532_power_on(struct yas5xx *yas5xx)
 	return regmap_write(yas5xx->map, YAS530_532_MEASURE_INTERVAL, 0);
 }
 
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
+	intrvl = (YAS537_DEFAULT_SENSOR_DELAY_MS * 1000
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
 static int yas5xx_probe(struct i2c_client *i2c,
 			const struct i2c_device_id *id)
 {
@@ -946,35 +1415,53 @@ static int yas5xx_probe(struct i2c_client *i2c,
 
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
+		dev_info(dev, "detected YAS537 MS-3T version %s",
+			 yas5xx->version ? "1" : "0");
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
 
-	yas530_532_dump_calibration(yas5xx);
-	ret = yas530_532_power_on(yas5xx);
-	if (ret)
-		goto assert_reset;
-	ret = yas530_532_measure_offsets(yas5xx);
-	if (ret)
-		goto assert_reset;
-
 	indio_dev->info = &yas5xx_info;
 	indio_dev->available_scan_masks = yas5xx_scan_masks;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -1070,7 +1557,19 @@ static int __maybe_unused yas5xx_runtime_resume(struct device *dev)
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
+	default:
+		dev_err(yas5xx->dev, "unknown device type\n");
+		ret = -EINVAL;
+		break;
+	}
 	if (ret) {
 		dev_err(dev, "cannot power on\n");
 		goto out_reset;
@@ -1096,6 +1595,7 @@ static const struct i2c_device_id yas5xx_id[] = {
 	{"yas530", },
 	{"yas532", },
 	{"yas533", },
+	{"yas537", },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, yas5xx_id);
@@ -1104,6 +1604,7 @@ static const struct of_device_id yas5xx_of_match[] = {
 	{ .compatible = "yamaha,yas530", },
 	{ .compatible = "yamaha,yas532", },
 	{ .compatible = "yamaha,yas533", },
+	{ .compatible = "yamaha,yas537", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, yas5xx_of_match);
-- 
2.35.1

