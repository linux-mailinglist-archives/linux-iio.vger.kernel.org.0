Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894CF550126
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jun 2022 02:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbiFRAPE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jun 2022 20:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237818AbiFRAPD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jun 2022 20:15:03 -0400
Received: from sonic302-21.consmr.mail.ir2.yahoo.com (sonic302-21.consmr.mail.ir2.yahoo.com [87.248.110.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E82D1ADB8
        for <linux-iio@vger.kernel.org>; Fri, 17 Jun 2022 17:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1655511300; bh=gn54fJeWT1i1GAWZ2VjHhSE1vulAvEE7gdAL7I29ZjQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=lZxWVKTjzgqsc+S25/rgkZgHDl7W6NrU3T5B4eL8JPP0L1q6HJYydvUB+s7aQcZFYgtLh9MuW+rDv8Vzc4u+n6NBim8t1yPkF+1Yh4o7VH59S++iTl2e8s+lkjHtHG7HM+s8Gc0uVoveH8vSJz1OALAmVsdhPUrWdZZYgB4tSLklGEKNL3b3SwV/grn+8x09hJaoyhMU6aEbx3CO/Icmn4Ky9RYXWI+6KDx9/QDBZv7Ff7aSnweCvLwwsrUXm7I5qfMxvhpxm2k4tOuOHW5WPuu99XO+2fQePzHcf+3Z/rkAu8mV7AsgFV68XPsL3aD8Y9WnoguFyQx8k2PIu9m9ZQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655511300; bh=b0b6wVP9pLIjBtic3csdPYA3fzeQ91iT64trBwhn5Bs=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Y8YLCKO1IRDRKazzn7iuMCUOzUNL/W0Pwe8YW7h/mal6hag8Xb3v+6C72W+Z5tUhDSF0qW7GNhT9JYsrfCt63t0flg+O0mw3XPPN1Zf5sjtKJQFANu71nggg/vzhD3blMG+rotk8e6xrQfqdtlN6Z0LscqiAm48zG4r5aQO++9IDZTQLfgcmdEfXuAhpmc5kt7bzpynXKxrgUEPxDJwyY+cN/XAsO6+Mg23D8bi6VyoNlEUp8wSr5brZuXqCHjDkIUDFbshgNWGf/0PrO6LoVavDbq1TBgGCIQ2X4mjrXXvSskKP6ly4IJqaDBEC8na2tteSdHE+SDRRQOXd6obXxg==
X-YMail-OSG: bgxXkkcVM1matpcQhTYDyd89HQe37irQ1mVtL6EEvfQf6n6zk5Iv2oUiKM2BHUh
 4jhp8UsNsr.Sdgu1i_dwP5rWfTWiTLoB2VyUyq7I.AO_ckf9cqNByH.6tuniAwmlB6R8ys6V6_l8
 Q4ttCkw9vc9Gz2Zx1v_el.8byn9MrNsGqscilyUygf3uYSYVz_qOFIXGlqvfnJlh8T__56pFX0CB
 q7e3AKBkgeIjkBpDIAUIP79qxBdF5_xJ1c3PvFKFxdxCGRaEJQL7fmuOKTBIqpMx6t7wtbHMmUrK
 YY7mNNyKoc20dx3cOTLkTUY_vWmPS8TQsOlOvderCty2JSsKcw_vlesAv9URmmUaUSsQ8rzhvP.I
 HzokBJ10yKFLT09Vl2SC0G_GBNMwdJGgGVMp1YGrxlGzpprGx97fOXiT0NWS.yHkW4jRiR.ccGzM
 sBUAmK5JOFr_JuYOqjxPh676WCJgZMGwqYW3v6kLOIGiztcuwj8TXOt6dkyJN.1haGJvHHYH3Lce
 RivHKcns_yuSIteQC95HZinOA7lQ7fPFNPRL0jME.Cv8fhCo8xbRySClXppTnjT95ZIBjZOpzHBt
 QK.nu6K7ynGa8.L5fZBFMLc44xlbC71ZB0wotw49poeSghvxAbt2kBslDZxUehDkgHNiFVkAX5R4
 K0bd13p7O6cesYINzFK_YLDMQl4PHpCauYVHSgUU3hw1Sdznvv8jaiN_TdjNSgUCqgUxzTzyI1uV
 0uqJIAstD15nSfQW0Nq5Z67cZikdH1whh6JSy5HXoNARSiPb05TAo0QJRnY3kCNJvW5wnhNkaeri
 P_Zjc19nq5A821L.3hr9r78fXFIJ5f61Kpq82.eBwEXH8WO5XbolMJijQCUPXI7hYcR0zB712w3b
 KD3WnKvOzuqXzTEe9nFcZ4MHZj8RCjUWRrayd7oUdR6CADYSeCjPL8yniKqhB2_JDaSLsDUtMofh
 nPW0ZyKKfTFUQTdIL_J90VyDziSh_tIkmas9vwSVHL9z8PUtS55tdOVrCZPN__SbgwBxBtn96qBo
 HtoCMz.U3LM7mx3cGyNfULGmc0vHPNsRBOtsS_K4UfDUeyCYgmvqJwDS3aEbSLiJ4t8e_iqwmtdE
 xY2ZZ5gWI1VmoBvzdhoZ9L.OgIlZP5Q9T48XVnK.ce9CWDjQneTsYAv.qU2GKpCe3JDkBeEu902g
 t72D21kSqTe2BMukWnMPjG9QRivg8hqHPp0unqcH3a2ma1TJc0tNqF1lSmk5vqgQwFcTG8tA1tAr
 1_STRPVl.CCca9MJW4Muo5UdJfMaRLgeeiHzIqHR3QBUYUh7Fy1cwEnkD0lFv2Qz_ufZDq6d7Ytc
 6WcJhQskIqKiYQEH5ThquWplNxvMQSGfD7UAYs9sj4ZQ5sc1j3VeMK.0sqs_NS7fNdA4PzFBTTVO
 wt1HYTpSq85F0WIF15doYfVRte.eYkhgr84iekX_KNmuAtRz7og9NBfiOTO_XjOqXSTcoG2pt4SG
 i0HihzuHePY12PUVNfcQloj3XlLMIjK6SZFDn324qRkaho1UquY4WePNOLfMoELpnWxWWVRYPIES
 6yIjKdU8a5JfEbXuyaO9OI5AqI6nQePNGmth7p9PrFtswu1uU5psW_jS8bDApuB_LCV17OQ.nJJt
 jP1jHX23eaToAdGyxYpJUnCpeZ.EvT_uj3V28O8oDEKV9zfcWw0NtMxwwye3HCinhWdukDctV5Ci
 vU0f3CkXQKqpMtTQ9S4X2Sg5t71d0B9ItQ_sQCROe0DI_SHq8HS9h1DSJYjwcSNkATbZQxt2jCih
 4gLiXpntXusd4kFbDJ0qLxtddiNTJ6rY60dBV5u_aTsxUkcSEiJlFWxTjrNMNN3BD9JcWC5ZYV4B
 hSHEMEAHc6PiJRvRuBdhpDqvRQsXzigauy7DKTvd3ZUSl3wXiXHycxyWjAL6Osit3qkLk28eKFIF
 dNAtUheYejKBTo7xVC7UGz3sU81Cb_4zaf84Cc8NSCRLBMEoyoWc8ZaCN5dRaNLmDYB9tpFey18x
 104Z8uWbNnoUi0oUcpRuOpBsNb9aFkg0aYc.r_0yJMgXUX40LfoFNSk5XgvFeFWCD8YKfndLoMPx
 NkhdcKQ1ji8QzDUF78miJfstAvdZ6zjv0neUypz4KOuOuWFsUQpLvUUzR2c4rxekWUm2WlQEIElA
 F4DdHMydKJsjPHLXAYRaSt4f0iLcxwJ.DpPwkCEvf23PKab_eaOCUDp.RYt.dUvHexzNQ4y1DVza
 ZSe1ig5GLOFKflB8Yzj3lknRGlN7KxS6shMi.S6VTMBIJvElLK15FLJKoL6he0ViTadv56yQRAqH
 F.y29..D01O5Z0Fn9q7E-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Sat, 18 Jun 2022 00:15:00 +0000
Received: by hermes--canary-production-ir2-c9bf9d9bc-74fwm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8b08f14069c990c2ed22165f3e3da032;
          Sat, 18 Jun 2022 00:14:59 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v3 4/8] iio: magnetometer: yas530: Correct temperature handling
Date:   Sat, 18 Jun 2022 02:13:12 +0200
Message-Id: <076e87f66378be8c729723cb9be5bc9151c081ab.1655509425.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655509425.git.jahau@rocketmail.com>
References: <cover.1655509425.git.jahau@rocketmail.com>
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

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 99 ++++++++++++++++++------
 1 file changed, 76 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index bd43b2555b73..9b45a550f31e 100644
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
+		 * and finally multiply by 100 to return milli degrees Celsius.
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
@@ -513,7 +566,7 @@ static const struct iio_chan_spec yas5xx_channels[] = {
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

