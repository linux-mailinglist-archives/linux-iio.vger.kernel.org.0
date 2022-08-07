Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA1558BE32
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 01:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbiHGXEC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 19:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbiHGXDv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 19:03:51 -0400
Received: from sonic302-21.consmr.mail.ir2.yahoo.com (sonic302-21.consmr.mail.ir2.yahoo.com [87.248.110.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5A32BFF
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 16:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1659913428; bh=8VJGl0MuSHhL28Kf4k+uCd0Gflpcbk+QqcZEf6TEyHU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=nSgkCKPpBpgf34OQjXFnvRdv1OUWfDpTzc9uOZ8mw6hNQQIScQgJFH0HxfnOZCDXFHO1pRIXqo/W1WvuO8UzgMBYU4bLfRzDzmcmKO78Q5gHWsF+bC9ShL42Quy7FMGuYTkIBcKOdz8OR124vM3ZfXzpFFNE6VEXspG1sBR8g4d0mLdkIPZYpOmPt/SkkenPoWTPmqZJSF/kOiV+huSZPgHJP6j8e3rxG9+kQTpeVYJg/sH6px3qBEVPiNk+LBJHxGu5QzbMgVZTNMy9JcNWsxUm//dBTJn3+i8MYyqQj4m+m839MoQZnUzOK0lrlJmTM/rqPbWJLFdXOnSgSdsy4A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1659913428; bh=vSNsIW/Z1x5kP9oYVwwRlTHWqIHJMt9L3CEO+4nMkI9=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=eqNc0kdfTrNrhqrNtBWIoJVuxcVeMZCbt1Ypl/6DIaF/5TI0RytQ2OqAID3OJKa7uZT8XkHIulqXpyLQIVgFUbG8ik0ouDkRrlvIASD9PsOjTZ2zqBl6G5H0qxIqVoTJM9wc8GJb3b+GBPpEkXr7EV393OJl5yOzHTI9caLS34uGJd2wY6NCBbchiCj1ylKu5GjlFiXbqAomGsBcpCtuJHaDhCkMeqnfLqm6jayFZnNfoMjg46USZe0aBlZICvii1p2dcIlgieU4ndfpnxjSRcr+ePHuNVxAS7j5V8iaUemOV1kiNxxYzyZ0DY2+gnaaw9jzlqnHzN221QS8cBy8Cg==
X-YMail-OSG: Ds.pkC4VM1lx8Qt68uiA6VTuQZATjiDFmQtFZRQRHzwNWbbCuXeWHOFrVwmS39x
 3Akkgt_1wqzRKrcG_x7FJA0_iu8OW9GlouwtTitr8LcrHP9YtuHCdZNnF04uzsgxzgs2rstD6VKF
 L.Ln9LUor17I.G9wSj2TwtRYLw32_k1thdn5C15t1gHHIcy2HSi8P51a5CyEvp.FC_h953RpW.yY
 jmIsnaNTg1HONSKawq4jR6_BKyU.NYWlmOIw.zlG0q31b4tERXKfqwBEVKgdcLLoCipRi9u9QKp7
 GYCWe5oUDKtUB3f5seDiAU0FS05L1vKaYz_qsqxm7q0Ho0AUi6WwmCMQOZzusHhs1SKPBrMEvVhx
 jOgrUGl58v9vgbl5FJQ5F9DVtP6B4jcrsqJ1VCOlgbx3M3KIh1vKY0oCz3VoA1xBvOzoy9b4Rcu2
 Ydbfvj8SlIpqQUtu.9TdgdH4tN.rKwmRwwhOsaR.7vj9MOFayz8bbsI5cL90CIyXAwSI3fFqZh.y
 GYYcjAp5PG6vmdkaT6aGQrQwTc9WnzXdxgE.Szp7kFh.5LyiEDghOEDhivVO7DB12_dRSdiwHvzI
 biyz98sWh8iCBLR1v8Ea3mRaMBCJ1vuApuL8vJC6_eUwIDQ4j.KS8uRfYRMjak3SfrVo9M2220FY
 OpgKCkYcBQ3c6Q.3RUk2yJyBYedSv5New3GPCgviwu34W.SsGWZq_rAl9Fy5ixghsAG62GZS26JB
 hNZ8OjRZ1vHFafeir_puUrYiUoJ59dpnGP31J8tCRu0ZeAI4IuQxSwuXMfX747C61GB0ZE5NS0aB
 7fi742bUGmR1gOqj.SSlqF2UCo3dmWon1paL7sYO.OAl2DLjXtjd5NjYvrQfeiugM_.9dRfBD11.
 _fHCm5xV29jECosVjipDdyAlqx9.14EefCCMApeVXsdzH0iOHeVvbBa0xAvXR95hCOiBmJ1tYosX
 zzH8Iyryzcrz6r5VFMtpcqV88qkg_x4A8FZzEaor.0WzGIZvgxahOsxwMaY7EUtjZff8Wi12_5OI
 FL2kfLe1DEj9nznv4johoq0YkEcY9_EQSPDWEufmePBbU_e_D6hW.PI.WWy7WRerrnoaAiGHG38x
 rUEFRV1S8Fu_qSdZ_13CnGuW.Mh40Cl_AxK9i6nrm1a6lk58gGEnQbh4DaUDPxCkNgeOLQctYFhn
 bnydJbzmhw7FYQI8y7BGw_VcuSMN1erJBvYlnIuBV.ALAFgvUlWAThF3h11dCuUKn2dt47CP7Grf
 5iiBlMQKy.1uvQTlbitATgld5w0kn418hOfdnMjKZvJan.Vi5.1xwaZR5mIruxzNy5iR9czRXbJg
 Eg5zqTz6WpUA0qyi1OBfXI8lSJ094PDfZXPyHR2RrVg_Bbjy0s6O4gpPACqzDmV7IthSbKaGXAhI
 FGpmN067RBYd0WfzvJ9XEQs4Ut630Guc_OaItoqvQ8FKAWPdP1GtwcYD2PEdmZb2QVQ5Gzkb8.i0
 RtPGB2lqI0PBF7taTSkZ4t_J_8ot_DaAMgQAZ16vBbasQModjF3GLa5RzWrm3TknAxJ9n0lNER8A
 9J1nBeC08oUOPvVRuVFD6_GwuxeUq5xnV8_wEq5Rhx8s6KQzh6oab0LbynASKrEpW0Db2ZJlcMg_
 KqklOF.zolAOesyXOnqNcMyDpm2x8zMtlLUF8.OayCBWB2732IwbD8rG_KfQVsFdo3yjhrRsBWPW
 eIARH5N4DJg9t2ltYHo_ztvlYpt0Bxn7tkvXQ5ZeXbBBLORiPA4T__rXZs44s6.1MCnRASY_qXaO
 vaDcRprSVjuP.Ae8AUs1HNPLctuioXMLtmlFm7OjhHPewxA3JtqOMn_XZd0GOJtAh387XQOGFDDx
 b54izxj4bglezhXk.ss4cnp3L_RftX5YuctZIYny0SrFC7wTowOQFJg3fihyCXNRt55hyUEM8hQe
 VyHSix9_LBxUEPEUGOh53SWWzqqNRlaoeZdHtSs5_jXj8ME30vfThp42RiMUeutd8HIR69OpGr1h
 NnXE.F0HgA_nRkeItfnuqLh.CQBISjd_1svOn65AEYOThuxxe2ySPUK2dUAtTCxKnyOVL03mESDo
 i8buxCFMUu3yumRogbdX9QkJArvU377iJ05sxt.Xukm2RMhDgOInn2OekbL98jcgAxx9Fr1k937f
 ZE.iUTvKVzdHvTAeL50R3BYcvzkWUrYqxdhTy8.xupaT1X6HL9zrQJoy2Mh0UTOPemuRQd02IfAs
 dP60gnr6hZ0JhIn1KnmY2S0JQINxslha_tAucdybAue8fa9KhLu0oSMD68bahBPUQFSuN.N6XSBN
 r.t04n9AH3ZKBTJOPo6tJ
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Sun, 7 Aug 2022 23:03:48 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-r76pr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 12b0bfa600682cb6edf92800aaf76d46;
          Sun, 07 Aug 2022 23:03:46 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v5 04/14] iio: magnetometer: yas530: Correct temperature handling
Date:   Mon,  8 Aug 2022 01:02:09 +0200
Message-Id: <cc21392ec84ec93c5e58659585cacb9e7c9831a9.1659909060.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1659909060.git.jahau@rocketmail.com>
References: <cover.1659909060.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The raw temperature value is a number of counts from a certain starting
point. The resolution of the temperature counts is different for the YAS
variants.

Temperature compensation for YAS532 version AC seems to be handled differently.
It uses the deviation from 20 degree Celsius [1] whereas YAS530 and older
versions of YAS532 apply solely the t value as a multiplier [2][3].

In funtion yas5xx_read_raw(), add case IIO_CHAN_INFO_PROCESSED. Remove scale
of temperature as this isn't applied.

Additionally correct sign of temperature channel in iio_chan_spec. It's already
defined that way in the yas5xx_get_measure() function.

[1] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas532.c#L442
[2] https://github.com/NovaFusion/android_kernel_samsung_golden/blob/cm-12.1/drivers/sensor/compass/yas_mag_driver-yas530.c#L881-L883
[3] https://github.com/LineageOS/android_kernel_samsung_msm8930-common/blob/lineage-18.1/drivers/sensors/geomagnetic/yas_mag_driver-yas53x.c#L856-L858

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 99 ++++++++++++++++++------
 1 file changed, 76 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 8cad724fb328..c6889a30a1b5 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -77,6 +77,7 @@
 #define YAS530_DATA_BITS		12
 #define YAS530_DATA_CENTER		BIT(YAS530_DATA_BITS - 1)
 #define YAS530_DATA_OVERFLOW		(BIT(YAS530_DATA_BITS) - 1)
+#define YAS530_20DEGREES		182 /* Counts starting at -62 °C */
 
 #define YAS532_DEVICE_ID		0x02 /* YAS532/YAS533 (MS-3R/F) */
 #define YAS532_VERSION_AB		0 /* YAS532/533 AB (MS-3R/F AB) */
@@ -88,7 +89,7 @@
 #define YAS532_DATA_BITS		13
 #define YAS532_DATA_CENTER		BIT(YAS532_DATA_BITS - 1)
 #define YAS532_DATA_OVERFLOW		(BIT(YAS532_DATA_BITS) - 1)
-#define YAS532_20DEGREES		390 /* Looks like Kelvin */
+#define YAS532_20DEGREES		390 /* Counts starting at -50 °C */
 
 /* These variant IDs are known from code dumps */
 #define YAS537_DEVICE_ID		0x07 /* YAS537 (MS-3T) */
@@ -314,7 +315,7 @@ static s32 yas5xx_linearize(struct yas5xx *yas5xx, u16 val, int axis)
 static int yas5xx_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo, s32 *zo)
 {
 	struct yas5xx_calibration *c = &yas5xx->calibration;
-	u16 t, x, y1, y2;
+	u16 t_ref, t, x, y1, y2;
 	/* These are "signed x, signed y1 etc */
 	s32 sx, sy1, sy2, sy, sz;
 	int ret;
@@ -329,16 +330,46 @@ static int yas5xx_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo,
 	sy1 = yas5xx_linearize(yas5xx, y1, 1);
 	sy2 = yas5xx_linearize(yas5xx, y2, 2);
 
-	/*
-	 * Temperature compensation for x, y1, y2 respectively:
-	 *
-	 *          Cx * t
-	 * x' = x - ------
-	 *           100
-	 */
-	sx = sx - (c->Cx * t) / 100;
-	sy1 = sy1 - (c->Cy1 * t) / 100;
-	sy2 = sy2 - (c->Cy2 * t) / 100;
+	/* Set the temperature reference value (unit: counts) */
+	switch (yas5xx->devid) {
+	case YAS530_DEVICE_ID:
+		t_ref = YAS530_20DEGREES;
+		break;
+	case YAS532_DEVICE_ID:
+		t_ref = YAS532_20DEGREES;
+		break;
+	default:
+		dev_err(yas5xx->dev, "unknown device type\n");
+		return -EINVAL;
+	}
+
+	/* Temperature compensation for x, y1, y2 respectively */
+	if (yas5xx->devid == YAS532_DEVICE_ID &&
+	    yas5xx->version == YAS532_VERSION_AC) {
+		/*
+		 * YAS532 version AC uses the temperature deviation as a
+		 * multiplier.
+		 *
+		 *          Cx * (t - t_ref)
+		 * x' = x - ----------------
+		 *                100
+		 */
+		sx = sx - (c->Cx * (t - t_ref)) / 100;
+		sy1 = sy1 - (c->Cy1 * (t - t_ref)) / 100;
+		sy2 = sy2 - (c->Cy2 * (t - t_ref)) / 100;
+	} else {
+		/*
+		 * YAS530 and YAS532 version AB use solely the t value as a
+		 * multiplier.
+		 *
+		 *          Cx * t
+		 * x' = x - ------
+		 *           100
+		 */
+		sx = sx - (c->Cx * t) / 100;
+		sy1 = sy1 - (c->Cy1 * t) / 100;
+		sy2 = sy2 - (c->Cy2 * t) / 100;
+	}
 
 	/*
 	 * Break y1 and y2 into y and z, y1 and y2 are apparently encoding
@@ -347,11 +378,37 @@ static int yas5xx_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo,
 	sy = sy1 - sy2;
 	sz = -sy1 - sy2;
 
-	/*
-	 * FIXME: convert to Celsius? Just guessing this is given
-	 * as 1/10:s of degrees so multiply by 100 to get millicentigrades.
-	 */
-	*to = t * 100;
+	/* Process temperature readout */
+	switch (yas5xx->devid) {
+	case YAS530_DEVICE_ID:
+		/*
+		 * Raw temperature value t is the number of counts starting
+		 * at -62 °C. Reference value t_ref is the number of counts
+		 * between -62 °C and 20 °C (82 °C range).
+		 *
+		 * Temperature in °C would be (82 / t_ref * t) - 62.
+		 *
+		 * Contrary to this, perform multiplication first and division
+		 * second due to calculating with integers.
+		 *
+		 * To get a nicer result, calculate with 1/10:s degrees Celsius
+		 * and finally multiply by 100 to return millidegrees Celsius.
+		 */
+		*to = ((820 * t / t_ref) - 620) * 100;
+		break;
+	case YAS532_DEVICE_ID:
+		/*
+		 * Actually same procedure for YAS532 but the starting point is
+		 * at -50 °C. Reference value t_ref is the number of counts
+		 * between -50 °C and 20 °C (70 °C range).
+		 */
+		*to = ((700 * t / t_ref) - 500) * 100;
+		break;
+	default:
+		dev_err(yas5xx->dev, "unknown device type\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * Calibrate [x,y,z] with some formulas like this:
 	 *
@@ -384,6 +441,7 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
 	case IIO_CHAN_INFO_RAW:
 		pm_runtime_get_sync(yas5xx->dev);
 		ret = yas5xx_get_measure(yas5xx, &t, &x, &y, &z);
@@ -410,11 +468,6 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
 		}
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		if (chan->address == 0) {
-			/* Temperature is unscaled */
-			*val = 1;
-			return IIO_VAL_INT;
-		}
 		switch (yas5xx->devid) {
 		case YAS530_DEVICE_ID:
 			/*
@@ -516,7 +569,7 @@ static const struct iio_chan_spec yas5xx_channels[] = {
 		.address = 0,
 		.scan_index = 0,
 		.scan_type = {
-			.sign = 'u',
+			.sign = 's',
 			.realbits = 32,
 			.storagebits = 32,
 			.endianness = IIO_CPU,
-- 
2.35.1

