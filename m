Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A911F564A2D
	for <lists+linux-iio@lfdr.de>; Mon,  4 Jul 2022 00:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiGCWDY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Jul 2022 18:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiGCWDU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jul 2022 18:03:20 -0400
Received: from sonic312-26.consmr.mail.ir2.yahoo.com (sonic312-26.consmr.mail.ir2.yahoo.com [77.238.178.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170E0B3E
        for <linux-iio@vger.kernel.org>; Sun,  3 Jul 2022 15:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1656885797; bh=8VJGl0MuSHhL28Kf4k+uCd0Gflpcbk+QqcZEf6TEyHU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=jN4B2HjoNpceXb+Z9R7fBxCBwj19JcvD07XYVVzF01lk3QHOuPtOw/Pk4vW7XRIrsLwjyfbDDgDrg25XRFY6WwR3XCYsasVPO+66ZFZbSN1sbGJb+oSkXsd9IEiKPEjtENFHDAX7v79kcvl/ZJAyBf+eay0HTK8G+CFgAskXVQaavTKWSyay/KjIYFc1jrwXSna1yXj6rrW4qEekbDSoSUKkod1u+Uor4K5BTQHzl72T28aMLrCBLLG4WLZWSvb0B8s93GYHJJW51wfMXm/uXl+6Q7qe4xHMO7aWiIDh796gNIGvfMEiEhOUKWyQxh047eH1AuYR+9vy+rQsyGIREA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656885797; bh=Agd1qJ2LKU88Y+fcOLxP4nOnN6Tbk47qHo1w0O0YfYa=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=sK0lj1IrqNEAGWXPL2geuGHT3/i3IF0RlnthK6lsowhTj/iXwXeYcTspuk6c36gg6Dhtemt6O1vKSlKWYFfcSJpEwuyMhwqY7zoL8MrthXagLb5r/fKKJRCivHtc2MJjtCcOADC2yoQNVxS6DWbVLQTIVD9MxSUb1UxLIbEpp2aM+x+yMG2J7iDc6JBuxazMEDQT9YSKPuqXAQ1PSzy6sUY9Mh/FHFHNhM540xmvbMS+5l6AgXiLlqj9hA4l2wQBpxVD0nrP3J/6iMa4YBaf7ihzIGYT87df+kcH2NwrfGtsF/kxoDwnH6V5jGl/pqKofbKbKnLhGAqPmpPsZh3CYw==
X-YMail-OSG: sbkZNNoVM1nogSynXsfzPQFVTbmx3WTPGn_Hm_9ZgEiUsYbKLgdN3St6_pWaM2l
 AeNf6y519xYZr8IgchtfXDnKA6oRj1Y1i5.abGW0GxdAzZVYdlYq.SzV5_LjqIzimtu3hmkonVUM
 jqPBf.8ahdoiiy4fzn4M8a4DCVc7FaqIdF22722ep_uj3zojQHPERTpaphzWwi6mjyoFQl4UJ1rX
 dIlJbrVNw4IfEh05rMuMF1ryxxsNNAfcKfPQQeeNTMAK6cVaCJCKI2mQ3qCxJ2tDl3L0yI3tohcy
 U9L_alO6HOnD35OkkTHWJFW2Ss6j.odXb0.0SMj4O2l0Bz.0o1BQuDjUEDxEIidaohoM5zevR2al
 NLvB3HqE8LbNwKdw2NIGT12CSb5mT.QcPW_qxaQgXReWxvi8JKWAYkuX8zn6cTh8ysfa.uOweB0z
 9U6nPCNU23PbQhG7ygEqSzRu0tXGTJsbOZ2qR_FMDWXEcd15cFAut2klypjLO85mhYGx1R9CViJS
 sGsgP.MehRCzcAR0reOTPN.8rdrulaaNbkgaVAKiqEyIP4kcXoEZKCbS6lw4_DtJJbhQ5eJirYIr
 epBfnl5m2syozRrW9Z2jHrpXdTQGgeS6xe90zr0AsssTMf9wV_sjoXIc.nwcjneLE6jeqro.kgdC
 O2If_KU_wTo_p5lrEj39QSuwq87Jq7wHGOp1oGN3kckk3iaHezcCrLi.KwRNtRue7c9GG2qQ8YPb
 9kQG8lsSmRwD5AzuA17.ccBbo8R.3m3XD6qlPryPfPpljj_Msh8lCDazw73Ztg_KMsSQ3AEu9Ck2
 eWO8Q1HvOX.0ORWDafwfTNjG9MBnUggv.hxuj5IHFtV9_lP3gUmDQKCWDEvAJyKTwrXWtJI5MdjD
 dWGyZ7duMug5RSbTZscJpUFyc70ITaNcIIb54lIl161rVWnz2172tb.H3BivB2WQrS84ABVGKS_K
 6Lc8Y1Cchl2Jh8rlzlL7Cq3EjG1UFgjthToWq.G8lbHRXoZn6xJ0QqN5Xvmvtk2s0.vZBBcOTY6K
 VYU.4Ph6B40eSGtei1Bk1H4R.zDC95jXyP2D78Dw2nz35ZIPCTkdSu6Tlxh47GMvM3UibQ3Q_UMq
 qsDCFq9F8ia88TFMvOx5G5JNPo35NKsibmhA_ffHdbCQn4YTLH4PkrxMMY_NWJhb6Yjz5LhvinRG
 6PZMXj2MJM.2EIU8zArrKeDZ6cB9Lw6rnImhJelQdx7T_GQIzWE6ke2MkqyTentkLoP6OOsNaFBn
 pYpsCFz9Cb0mAzlHK1T4j25fklq59z40XQY1aPd.G3tfCkfcTBtmcKMYWpFOdNizEQx.pGmrV4cU
 rUTos0Vi4SJo0yamBc8gjGXzCFO87BXYyrDPTs5ig9ecBErW6FCKa.VII24ZPTdB.1SlKZR3BcH8
 D21FOka.v38gve6dfKQwL3k8uQ3KY7BSv.Qx2HWpjnT3u8h8MYslSEA.UjgzBztSKW2VEl6IRmiH
 o6SyshVjHsIJ1fySkRR24Q_h_tB6Ffdq0lrr4_NFzgsNSy0YUWKbHT95GZBwg.hGk1zEvHg9l6_0
 G2nJMBxina2fvzog0MfsmbjEO.UavK9SNoJbBpbqz2Jq.yZ70_7MKOJ7dG6F91NwkJT6p7Axf.Jl
 cGuIerKJniAyL27sYkkFCMSYdSjuWYpbLNw22MCSscbAJ4X9iW7U0JePpj1o5zfJ.EZ.Lx6n6umm
 AcuMpwHbTS82RXebhcCGY89a0vUATxCNADqY76lhijdlr5ayEiywmkMcK3zAfymnFOxaLU2fGSbG
 f0WVYqr81Gw74_XHnXbFHZFhZ0Su_G0mTH_Y4yOTGHWv.zxcIYCU61GjXzHJP0T50rvfuPgj3x.0
 Yt6bzKDbA234YQvEQwCX39E9IotoCghEvmVSe_HtSoFyQzt.yWoZ058gFJAEnebyFbBFa8Ow2Rg3
 zU4MLN_oizFPE463YhYfzuexd7sHwVLlYgrSI3HWnoPQLDKYom67tMld32RqFwuR7Ig_NQlvAswE
 8H7EifjokGoS0J7mzdib0xbadYVviNCrDomYpVlFF120mCksjdFJb1hIMqSIuJx4NOaNIf4GdC.4
 giHKm2xO9_LkMuD98OXIuHgfpgwjqo21sMGXANckkrXnByAv_NcxGRxWF0EBv3Pt3amRJXUwCyIR
 P9044tbsipzlGp2KtvBYiImcIxxK4Cj_NvAb5kZS8k1.j6BjSTXdMUeBxS2r7RQcoa7QhcRlTc7y
 eVubjVHIhUL_b5MxkYTJKeChwx6VPEQZitVaoxL_av8MIXHWmJsKjkqzoL5PrhpYXfSfKy4PISot
 cBGh9qdBhIX0hi5iBuw--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Sun, 3 Jul 2022 22:03:17 +0000
Received: by hermes--canary-production-ir2-74b4d6d794-tv8mb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0849bd8970b52a790a5a1bb96f2e336c;
          Sun, 03 Jul 2022 22:03:14 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v4 04/10] iio: magnetometer: yas530: Correct temperature handling
Date:   Mon,  4 Jul 2022 00:02:38 +0200
Message-Id: <61e778798703b53a5e4870a5d1e12c6c56a1ae4a.1656883851.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1656883851.git.jahau@rocketmail.com>
References: <cover.1656883851.git.jahau@rocketmail.com>
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

