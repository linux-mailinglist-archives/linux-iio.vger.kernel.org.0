Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD77258BE3B
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 01:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbiHGXHi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 19:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiHGXHh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 19:07:37 -0400
Received: from sonic308-19.consmr.mail.ir2.yahoo.com (sonic308-19.consmr.mail.ir2.yahoo.com [77.238.178.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B380538AE
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 16:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1659913654; bh=rYmtJgOdAlGhRoNXlxz5JKGNwmCEyFeKqqyMbfjetF8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=WyNrx+YEhjS7nCiOqsJz8PghheM/im8DnEo5okghCbIHkNUkaE8tpwmJexhGpea/PH7mgCjkInKBlVtyxg/KWVdkj1rIUxqLGkZvoXEE1chp+Q7mO6Jhit/9PWnuhcDqYSnCPxWSZk3j9Sjw4yLSEw84ADy1NFEF2BeRXXdje0iRDmrLT6dn/dcqkAkKTBumL5s4uYWt4wpw/5XqLzuWe8ah651bKUKm0gYy1BJuhP76/xmq6yqdGrxcdHfcgA6aOEDR7WrYBGibtkgeHTSerKNSD5jcUI9WMSUUvvuBQ7Gjfn/Qe5iQbP/uLiTsibzSPOpS6ZkL/Yk1Z2pT6LxdAQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1659913654; bh=cmhFbtHd7Gg3jvxxchS98fapl8vzO8fdx23cIVdOUPo=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=tKRJxzK7zI+AkoPJxvnf3utd1Lt4sUNeZSG7uMmnkldeGReIv3meTMvzmX4JXB2T+OqTTy/sJ2gajOcwBz95ljawW1nCPEsiVqPKqkqe8/JiWqFDqgaLkY5I09G/LJERyMtjBPU+0v3W9HrOZRf7SRE8HvLsYIldRUfuN8HG/QK9WP7TXNNkQuFgHb8BpllP7+mtEqxVH4Vt9Hv3th73FUvQcL3NDziSpZHq4SStr4IPmnDWjv919PWKfqjD4KZgR/gzBdImldQJ3OJLCr5XkTQJX6j1e2/PapIA35mW/mza3oF3vzRFRpwC8VO+/i7Zdx5pD2YKwdvfIdJZ/EYcZQ==
X-YMail-OSG: WJJq5voVM1m4L.qvUjCyh6PbSmdsPwdtyskiiZiOYSidYTTI4skRGSYDL4igkeh
 2oKBLztbdMRLFRbnnuQFl.7wWTBT5HExyNL8XXjPPr_7ldpUtriN3eiPm2mkJjjnQRH3gqonx8P7
 asHtkxpzBqZoZ6oDwVIhtP29gOf79O6gVbVMrV5kMk4KEh4N2m06KVa5Slh1AM5PMiUC2oDn6wAa
 FYL6KZob.YgaS9PUG.3_CZFheHFju8gS8Bv1yYLlCpDejU2vvCmg9xdq8GECaT6KD_9ZN9DjxIF1
 rrxkTZehY.mLcvxArehuVySdwMevIzfsHYF5LzoG88yp8FApVH.s2Vv_a5XbT4uKSJ4er.cgetM_
 nsPvWhQUo_EN1mmKGwN6knNwOjiM_lG22WwHqoRq5A0P2x18PBFGvrpdfnDsp3MixsE9CQdwMLQr
 XRvCVC9azSTLCLI_lAn2PkcSdIKCcXfSqH9hXxVMEDow6.mun09sYiACzBFPEunEk1IBYv2JXJ30
 uM0f3LPHAZsCahZcJZga9TJSw85x5ap74SFkW1O20p9X0WTObne0yM6rGLhdD7ZvagGZE4mi5Trp
 gAPadoEQvpP3S4GeEysgUcvII6tvTQs4yoIwLQbryMy4sqBMNtDMOoZMdDKxN4ahac7w1O41B5yk
 6i9dYvitgX41icB9WHJjbwBG.XSx9vcmF9IiGny4cZsLpOpEVfpMB.2OEmNegtrL1h.wBUA3DhVW
 rDD.yA2zXHAUN5X2ZlRw2Nc0VnSK6US2ft.QzSWf3x276dtaWyPTwv4cmCp4gsol5tx2OIYi314Q
 XylBu0VLrfj9up7kOvMTH5hsodiFrX6TzV4xb0HZllRFI7qdWNcvNPOxa9hOp.d1aAStmeypt11m
 xmfm_JuSAvkuoJzGIGLaUaeP8wbISMmAxv2I4NLkiITyqw7QUPIPMwOo0kuwtgC86ymFwdblKqL8
 zKy69wRTXI8OVDn3i6SuSBTBlYkVP3qJVuttVTSd4rcG5be279T5WAqOcumjb4dvW_VKI8hlaotz
 tt7ufc.4kQIFed129arIhQYVntbJ.6IXYsaZro8Hn8_f4qo4FbmkgsEQ6bxQQfkS_FQTqgyUhXxK
 VRStsbw1wi_JMLOvoGw5gjy3_AlGwcSgxwj0hTAw0xzoekdD4QiCEekpLY8u88qo.jAeyiHupTg4
 ySE_GwTaiYSE9HY3ObMMICC_20REAjIwzyXVWHuphe3UmXSZI_jpVEBIT6dJ.dvtdPGnWjtQPjLk
 sD3KeWybdmOPpILgyy4wlRwsTlcP8_KpD7Fw30ri8g8qwUqFW3ACBESKgZYQ0C5GT4HV_iAHVG2F
 aseY2IN8CtcAHMaYTAKPvhqwoSvcoiY8VKOe4vnumnbYYTTcT6ZNQa5R4awZKN_FY8.4KB1PNBpC
 .rYmqMiZvqhuVqF__lZH.NcFt_a2GwqgXFeM09WLeRpLQZizQIysBGJxW3u6JvFOMEtUHVTh5C2h
 n.V2xp0XI2BqatbM2RraJHYezguZXGcXMremqE0rhYK9lxzqAumXFEUJ11P1VIa8mwfslIrHa7Wm
 DqkMn_PpSGW84Hm3rAlOYaN3c7_AY3qMiwQdGVJ733bLK32lK8rsaPQRuVDfjRxDyfwzVuhM9Unm
 HLsQFsXj1vlOi20r7mlwNefFIxKGagnFZuD.eri6F8TXtsXpSdtwT3VtJUEvIZ8tqXuieoTsNGtq
 Z9FyRjNvpXdkARC13bKphZaT2OByLQWOIu3VOM5wwNBwDSSm2x6zdfUikZR5B5SbyfQ_vKwa.gzf
 _MlKZKIhOGyO8T0VoUQ.O_iCZmOEvzojglXlEMaYZet2WgeGgEocm2zjVFlbo09FqF_FdXpi3hle
 A.DXmpZn55Z5K3dgtFG97tM3cwqnf0bPFE0X1ah8SAF0hqziiCCP5I0byrgrDvoVheRlU8lMuc.w
 ebgIKtseXH3jF6ifDUwvVHvJQzzLJTvlnI4HZ0GMtBfNYF6Cs3Q8.otusl_Xy0FUW2Sjy.niNTuo
 Bfr4KyTWBV8JFrUWMVJ0LbEDANlyfY86npVoP5VPWeANZZ.DUCbT6lm4EKjkMp3NEaeCiS1YSKTt
 vpgjUbfmf9.AqUy9.RiK6MCbA4gAYomucfTxrz2J_Jrk_HNxf2POiDEPVRKRIWstx3aKTHu7_ITN
 e9cVCIJ_5RXC2P5wHvtO6Tm3GGoBADrTwMM30R_Y1PRPkxQEwql9cZW_UhNLvWELusb97L5I28U_
 7U0DwwPnNoBN4XNZ2I6nswZbqdOWu9faN8e1qvaf1m8spV_YNPqdVG79OevOX7nVJL9jimEM.iT6
 fviOYUzo89rxhpb4-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Sun, 7 Aug 2022 23:07:34 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-2vqg6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID dc92a55cf24372a35650a28a19dee6ae;
          Sun, 07 Aug 2022 23:07:28 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v5 08/14] iio: magnetometer: yas530: Apply documentation and style fixes
Date:   Mon,  8 Aug 2022 01:06:47 +0200
Message-Id: <5a00a21e9414ad00117b67064eb585f589abfee1.1659909060.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1659909060.git.jahau@rocketmail.com>
References: <cover.1659909060.git.jahau@rocketmail.com>
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

This commit gathers several minor changes.

In the device examples, "Xiaomi" is too generic, specific devices should be
listed here. E.g. Xiaomi Redmi 2 seems to have YAS537 but it's not fully clear
if this applies to all its variants. Samsung Galaxy S7 is often quoted in
conjunction with YAS537.

Removed defines for device IDs of YAS537 and YAS539, they are not needed so far.

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 48995176fa39..bf0aa64ac1a2 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -10,7 +10,7 @@
  * (YAS534 is a magnetic switch, not handled)
  * YAS535 MS-6C
  * YAS536 MS-3W
- * YAS537 MS-3T (2015 Samsung Galaxy S6, Note 5, Xiaomi)
+ * YAS537 MS-3T (2015 Samsung Galaxy S6, Note 5, Galaxy S7)
  * YAS539 MS-3S (2018 Samsung Galaxy A7 SM-A750FN)
  *
  * Code functions found in the MPU3050 YAS530 and YAS532 drivers
@@ -93,10 +93,6 @@
 #define YAS532_DATA_OVERFLOW		(BIT(YAS532_DATA_BITS) - 1)
 #define YAS532_20DEGREES		390 /* Counts starting at -50 °C */
 
-/* These variant IDs are known from code dumps */
-#define YAS537_DEVICE_ID		0x07 /* YAS537 (MS-3T) */
-#define YAS539_DEVICE_ID		0x08 /* YAS539 (MS-3S) */
-
 /* Turn off device regulators etc after 5 seconds of inactivity */
 #define YAS5XX_AUTOSUSPEND_DELAY_MS	5000
 
@@ -325,7 +321,7 @@ static int yas530_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo,
 {
 	struct yas5xx_calibration *c = &yas5xx->calibration;
 	u16 t_ref, t, x, y1, y2;
-	/* These are "signed x, signed y1 etc */
+	/* These are signed x, signed y1 etc */
 	s32 sx, sy1, sy2, sy, sz;
 	int ret;
 
@@ -666,7 +662,10 @@ static int yas530_get_calibration_data(struct yas5xx *yas5xx)
 		return ret;
 	dev_dbg(yas5xx->dev, "calibration data: %16ph\n", data);
 
+	/* Contribute calibration data to the input pool for kernel entropy */
 	add_device_randomness(data, sizeof(data));
+
+	/* Extract version */
 	yas5xx->version = data[15] & GENMASK(1, 0);
 
 	/* Extract the calibration from the bitfield */
@@ -693,6 +692,7 @@ static int yas530_get_calibration_data(struct yas5xx *yas5xx)
 	c->r[0] = sign_extend32(FIELD_GET(GENMASK(28, 23), val), 5);
 	c->r[1] = sign_extend32(FIELD_GET(GENMASK(20, 15), val), 5);
 	c->r[2] = sign_extend32(FIELD_GET(GENMASK(12, 7), val), 5);
+
 	return 0;
 }
 
@@ -714,12 +714,12 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
 	dev_dbg(yas5xx->dev, "calibration data: %14ph\n", data);
 
 	/* Sanity check, is this all zeroes? */
-	if (memchr_inv(data, 0x00, 13) == NULL) {
-		if (!(data[13] & BIT(7)))
-			dev_warn(yas5xx->dev, "calibration is blank!\n");
-	}
+	if (!memchr_inv(data, 0x00, 13) && !(data[13] & BIT(7)))
+		dev_warn(yas5xx->dev, "calibration is blank!\n");
 
+	/* Contribute calibration data to the input pool for kernel entropy */
 	add_device_randomness(data, sizeof(data));
+
 	/* Only one bit of version info reserved here as far as we know */
 	yas5xx->version = data[13] & BIT(0);
 
@@ -728,6 +728,7 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
 	c->Cy1 = data[1] * 10 - 1280;
 	c->Cy2 = data[2] * 10 - 1280;
 	yas530_extract_calibration(&data[3], c);
+
 	/*
 	 * Extract linearization:
 	 * Linearization layout in the 32 bits at byte 10:
-- 
2.35.1

