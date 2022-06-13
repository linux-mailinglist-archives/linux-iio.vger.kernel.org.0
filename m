Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780EC547D58
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jun 2022 03:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236137AbiFMBST (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Jun 2022 21:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236559AbiFMBSS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Jun 2022 21:18:18 -0400
Received: from sonic309-26.consmr.mail.ir2.yahoo.com (sonic309-26.consmr.mail.ir2.yahoo.com [77.238.179.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA4F3388D
        for <linux-iio@vger.kernel.org>; Sun, 12 Jun 2022 18:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1655083091; bh=3wgWYrQ3kNag7wzZsh0DmsHVlTwHiBr5d6GO/gIQ6CQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ILmJ8bCX5Ty9bN1ZCUzueWk5gorgjFoYzXoaXWXozGiActAEsROL3pfOYurDgXpKxj/A0juRjQVqCcK/JyA83kiWiKbZaIyzbx2Si+MF1lfC7md7Oyq/gpZEOyXZbE6R8+QL64Lz8aWcYcRoMpd9Pgt4hiA8FxajbqtOej+AIa9ZPns2mX2Ntxu6ogLN/GFua4Mg3/4bDF8vLYAI7uY4EPw3+jHy1IDTO3UXI4jhtro8gI4Xm89PnWAhNIzZ5KErK48QVjx37Ayxk2H3uZJ8VQoYKxpEJXbCI9F3FB2fnTuxe6o56m/3qitvvtWY6WxvQxdEykQV4M1CJqrovDho7Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655083091; bh=PUbCupjV0ux+MasRGiQHOqhRxFtC/zLG29Tn211BTas=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=AQEKXZrF9wThFvPilj7RcvTLri3o5iCMlb+hx8KmBXAWPxZ7MpPkPA1B1Eu3tFgqrY2hSDrAfGDrD87b9rv3aPqqLxIwbUY8HMjO/RWWXEx6wE6LCySGcZbdfRptt2piIgdDYGR2+mDX9OTvwTjsZSvVGNbAUvelvvnI7WNvf9c2WJt+ZFdXCSE2ypwTtL9X0/W+SBZPoXm9QzTsaJr+ljOVEppE+/NzZOD58q+dcTH8Ox2v6kZ3ZZMYooqqFlYWmQ3ITYiXJ8X+4NB7i8eFPf9QcZaqFUig22/JnjjiRXJfiS0kNT/cRHoPz48G+0G8+yANUWKAbG9DUHw4p1w0Zw==
X-YMail-OSG: yJhPqn0VM1kEDosov_xmCMHuNug9srBp3eiyvCr7Q35UC1dYdUDF_LVEjf2_Va1
 s9Rzmrs2VQo6IJBxImBu5qg2LWvvIdoQl927eUisKXk6ggajXKIkoV37jzl0PrWowZbUIvqfEXJs
 9m.HiUJbYh6avs605JxR8vahVf.nsYcFU1EvrkXq5dpshquUXj58xBFFIloBtxHtRkJP0xqGYUD1
 sqH866mmoF8Zwh7RacYcjN0pb_p2SycKA2IVPNQyCqyvrvgD0o80QBu7jtIowhUb8R3Hz6.DSD3d
 KGKTp87ncYd.ImPQ8jwquZIUjtjR.KcqmvijuSEIzMTn.HfHTKbTYl_cpgdLqT2RdB2.YZumT93U
 DSvuzwS2cFJu_4EvO5JDFnH1Q4ixDoAZVDhzcuM.DYJmj1p20KIGlAKW2o_Y3vGMcCmOZ02LEDyR
 ReKx97VDCI4V78rYRVziMRMlNzHsBQ1Y9vDLbci1K1TfBpvJO.p.CG6_4dNVd33sYt8C5c6LQnNh
 IlJn4cwOWALxu8CRsQLmeOWWRMhC.GF4ZDFEdv6mzyYUnlARpo2ePBdx_uQBRQ9LR26l17gf77wu
 CnqwNB1M0b0ZCb2TP0sXTL.gG1bUqOnrfZRA.4.Mkw8qWMkmoCPDa60r9iVcOGFshyf3VE9AakyR
 MbQg0ZHXNSoqOW8za8ENpDRd83IDA2Ic__TOMOvEenKdGAXqhxefWSzl8vZDmU_w3OckEc8dya4p
 ax0aqLh456ZUtfRiuJPCInFB3yMbL3KY0MbwwW.wmyQBKiiDp5r96EbW4Q8olAOXjZFIuiyQD8_x
 QfOFzRck9SsneTEinZBzkPEvyWGpsHyP2FmU7tkArIPE6M4kvUlKFFbxQdHTCXnjsyD2NZ6W7ncT
 yBF8d34vrbDkowosleTr_SX_sU7j66QPPx0M6wLHWwARRJuUVk1mUgAXV1lfMPF18G0fYw0KvYKo
 shhK19pyfqED7d6mENoCDTF4YFI0vfPtnayKMHePD0fjNamlAR04E3gCUDuYX6Fro2hULEsRISrv
 3uzK3z9RYAjWFc0_FgwuKPg4VAq3Y7iarrg87v94nr8AQ2Gp_4ymtleOlgL9Hr7TQSZRilee_wKS
 fLI_4fjg5xasMM2BcaCSfLvmE2Td.v2atA12Rd4Zhfq7CVr6G173F9_mBc0S5znJdAuv2BKyUmUU
 VaVWK3frzKHjb7FyR0HcnOOsk9I_EXy6Sj_e8oRilTaOve6oKC.hzKEWI4MLXH9DOc49BSrfI_nr
 CELczHFy3VbMP0tTeIsBFhgjt6eyuA626U..BzAsoH4gFXYHIU.4RpVbQKw.26ULqCA8O_MZdGOc
 ii0OVtLd2ogIJPPaue0UXIp6ve71UPn8Z9qJroWGJOZO8u.VMB5PcAZw2Heti7UWztXlaJdqtVOA
 wxh0EBwSc14M6YWv2BoLp8xUjaEw8P4wpMrKyzPcA2PJqdt_mOBn7BHzTywnlIaLArFuCQgz4mvU
 3yI0re8lmN3NLojbdcEwZPFiePoF5j9_nOWhFi5lMy7sG5vM9xgq1GP3tOPSy1BUGEsXo.cLQfk5
 lpVgrM6ZElAEZRc4P65S5RGXBJDahPOEeV0JtKRGXWEW71ucZucE62upMJJysYeRdlPNQFiqeidi
 julLXGXM3a5ATDpzDY2MLy0_yRPyZh8uaBK.8IQjSl4eoyre8STKdaQLQOKsIyI_ZFdDqppH7udU
 0DLN6sqTmi9m9n5rvPbEcZ6GUUxArMg2rK6iSDsTobmSxXV5wp4HX85CZzA3K0NvdkA_Zgwnl6CP
 a4mGMbRJgELI5ZJm0TRt30.Wl1pS4MBuPuH_YhDjHogtc8hcS4S6VQQO8NApKBxZphXPnH37R4au
 wktultVFLi5kF3x1dpHabK4UMsadcMDIlNddLk6dvvoIAxC79OSwC.32UyeWgzyR6g119XTgv6fc
 QWFJ9GSMbx6mPnjzoJx_GYH6BKk4xT1uStlOj227m9QTruC8xJlXrf4ch2e4ijLzYRN2rLMCiS2L
 HegnVBBlY4fGzMb7XzBB8vAjOEXh20bxrzApDy4zqzbXrXIhqCpFO3Nui9lAAMSiKNHUUBRJ_tk1
 tSMEpjkQhzggKxb0j0U9XahlprYZXCdrEUCHdxl7mTNutkbvH.HLR2DzHczbGGtxnZp.hFttzVTj
 QFNWlu8Q8xC56vcDfm_JjZV6G_26ggN92bHBoCXUdcoMZOfy.STEUbRujB2xObdy_Gi.gpMeI.Js
 kygRDFXMIvJAgCCtyUCTsIP_3jpz14IfpV7irJQg7lBZgunesWEfcaql.wnx.9d1SGO8NibNAOMX
 HH_p4wyZvzugJTxM-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ir2.yahoo.com with HTTP; Mon, 13 Jun 2022 01:18:11 +0000
Received: by hermes--canary-production-ir2-6c7595c778-c54g9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4419c1e75f73c3038b6a16962b132f56;
          Mon, 13 Jun 2022 01:18:07 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v2 7/7] iio: magnetometer: yas530: Add YAS537 variant
Date:   Mon, 13 Jun 2022 03:17:14 +0200
Message-Id: <b6e100de37921c22ebf0698f8e0e99794053303a.1655081082.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655081082.git.jahau@rocketmail.com>
References: <cover.1655081082.git.jahau@rocketmail.com>
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
after: https://github.com/Jakko3/linux/blob/yas537_v2/drivers/iio/magnetometer/yamaha-yas530.c#L1413-L1462

 drivers/iio/magnetometer/Kconfig         |   4 +-
 drivers/iio/magnetometer/yamaha-yas530.c | 569 +++++++++++++++++++++--
 2 files changed, 543 insertions(+), 30 deletions(-)

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
index 72958bc0849b..10b87bffccae 100644
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
+#define YAS537_MAG_AVERAGE_32_MASK	GENMASK(6, 4) /* corresponds to 0x70 */
+#define YAS537_MEASURE_TIME_WORST	1500 /* us */
+#define YAS537_DEFAULT_SENSOR_DELAY	50   /* ms */
+#define YAS537_MAG_RCOIL_TIME		65   /* us */
+#define YAS537_20DEGREES		8120 /* Counts starting at -386 °C */
+
 #define YAS539_DEVICE_ID		0x08 /* YAS539 (MS-3S) */
 
 /* Turn off device regulators etc after 5 seconds of inactivity */
@@ -267,6 +295,84 @@ static int yas530_532_measure(struct yas5xx *yas5xx, u16 *t,
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
 static s32 yas530_532_linearize(struct yas5xx *yas5xx, u16 val, int axis)
 {
 	struct yas5xx_calibration *c = &yas5xx->calibration;
@@ -322,7 +428,7 @@ static int yas530_532_get_measure(struct yas5xx *yas5xx, s32 *to,
 {
 	struct yas5xx_calibration *c = &yas5xx->calibration;
 	u16 t_ref, t, x, y1, y2;
-	/* These are "signed x, signed y1 etc */
+	/* These are signed x, signed y1 etc */
 	s32 sx, sy1, sy2, sy, sz;
 	int ret;
 
@@ -431,6 +537,57 @@ static int yas530_532_get_measure(struct yas5xx *yas5xx, s32 *to,
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
@@ -444,7 +601,18 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
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
@@ -478,9 +646,10 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
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
@@ -500,7 +669,18 @@ static void yas5xx_fill_buffer(struct iio_dev *indio_dev)
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
@@ -586,9 +766,34 @@ static const struct iio_info yas5xx_info = {
 
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
@@ -652,7 +857,10 @@ static int yas530_get_calibration_data(struct yas5xx *yas5xx)
 		return ret;
 	dev_dbg(yas5xx->dev, "calibration data: %*ph\n", 14, data);
 
+	/* Contribute calibration data to the input pool for kernel entropy */
 	add_device_randomness(data, sizeof(data));
+
+	/* Extract version */
 	yas5xx->version = data[15] & GENMASK(1, 0);
 
 	/* Extract the calibration from the bitfield */
@@ -679,6 +887,7 @@ static int yas530_get_calibration_data(struct yas5xx *yas5xx)
 	c->r[0] = sign_extend32(FIELD_GET(GENMASK(28, 23), val), 5);
 	c->r[1] = sign_extend32(FIELD_GET(GENMASK(20, 15), val), 5);
 	c->r[2] = sign_extend32(FIELD_GET(GENMASK(12, 7), val), 5);
+
 	return 0;
 }
 
@@ -705,7 +914,9 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
 			dev_warn(yas5xx->dev, "calibration is blank!\n");
 	}
 
+	/* Contribute calibration data to the input pool for kernel entropy */
 	add_device_randomness(data, sizeof(data));
+
 	/* Only one bit of version info reserved here as far as we know */
 	yas5xx->version = data[13] & BIT(0);
 
@@ -714,6 +925,7 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
 	c->Cy1 = data[1] * 10 - 1280;
 	c->Cy2 = data[2] * 10 - 1280;
 	yas530_532_extract_calibration(&data[3], c);
+
 	/*
 	 * Extract linearization:
 	 * Linearization layout in the 32 bits at byte 10:
@@ -736,6 +948,216 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
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
 static void yas530_532_dump_calibration(struct yas5xx *yas5xx)
 {
 	struct yas5xx_calibration *c = &yas5xx->calibration;
@@ -759,6 +1181,26 @@ static void yas530_532_dump_calibration(struct yas5xx *yas5xx)
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
@@ -875,6 +1317,43 @@ static int yas530_532_power_on(struct yas5xx *yas5xx)
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
+}
+
 static int yas5xx_probe(struct i2c_client *i2c,
 			const struct i2c_device_id *id)
 {
@@ -933,35 +1412,55 @@ static int yas5xx_probe(struct i2c_client *i2c,
 
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
@@ -1057,7 +1556,19 @@ static int __maybe_unused yas5xx_runtime_resume(struct device *dev)
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
@@ -1083,6 +1594,7 @@ static const struct i2c_device_id yas5xx_id[] = {
 	{"yas530", },
 	{"yas532", },
 	{"yas533", },
+	{"yas537", },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, yas5xx_id);
@@ -1091,6 +1603,7 @@ static const struct of_device_id yas5xx_of_match[] = {
 	{ .compatible = "yamaha,yas530", },
 	{ .compatible = "yamaha,yas532", },
 	{ .compatible = "yamaha,yas533", },
+	{ .compatible = "yamaha,yas537", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, yas5xx_of_match);
-- 
2.35.1

