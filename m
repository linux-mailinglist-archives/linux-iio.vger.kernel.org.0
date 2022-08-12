Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED455916FE
	for <lists+linux-iio@lfdr.de>; Fri, 12 Aug 2022 23:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbiHLV7P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Aug 2022 17:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiHLV7N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2022 17:59:13 -0400
Received: from sonic302-21.consmr.mail.ir2.yahoo.com (sonic302-21.consmr.mail.ir2.yahoo.com [87.248.110.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94566B443F
        for <linux-iio@vger.kernel.org>; Fri, 12 Aug 2022 14:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1660341551; bh=PuAzVUYJCPGAi2dhIABGwnKhY1GAm8cD88e7vvhikLU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=OltVJ0tmxCiDnGoMhiaZ3qPmI43swIgcOVWvlrRA/vhkEaOJ/neLM5vAimL/7/MviSbzfX4+XLFWon18M0umJCmurT7zu8cDqk+DIo9wN3OSa3h6bxHdNddh+oDPsIUHzHGQqAnOT4am58eEpUps2RwPpskN+n0uptMdOLqXWmojli+aN3qLfJ6LZ9Rg/YskZ4xrlOac4SECX28rs0m7xadaIihl1AHarH0/cq57fW97nvvlIEIhKBEuApvumMMd15pmvkhyj++sU9eDRQnK/4wOgl+lISMuquO6WU6RqMZk7Ymj1qw7X37gU2BeWQpn9x1O69jb+31P4Tyj7ckZhg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660341551; bh=9cN/+z3JU59JYRqm84u99sfrH9t1C3/eaSCtTsUXhAP=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=PtlvbMwlBF5BU4hOQ5z+JWSz8zIp92vYrzLPIUPwoZ3aU5vBxdV/7O7FbFYKPADuur6o3rmZ3tAI3yOkJOjEbVkqlw6Os76N6h+AFj32e2FJOXpYPNlKEsbqMKuGbIf+/6pVvapld9ebKsHI6h7ByKg9L2WaDnREkrmMuDgiLhyi3ZowQDqeF2IWZLB6Mnzwxd+2NOKajTfx6dNsodRItQAVLblctmYJ+vSSwtnGdvRQf1QmKdix/5Ga+6vrhiMrdrIT3KdgOLP+C756rJNDks4twxpwf0VcJv0S1FksUX9r5Xt5LR4xEhw+nmn4UiJ5+SKuXvkKrD77jHs3B1FgVQ==
X-YMail-OSG: tR7TvtEVM1mBr52ZL30JJNjTpDZSO7qgd1eTSJolFpvLQl0K42TikJHHeL3_ZJQ
 shX09qTYFBb44JCuqchLrW.OSo6nN4to2O5iebb5rpIy67HhwPLTcWBsZ.ZJnjXWVm0eGDImJQJy
 TrSPj9E4wppScAeJAovsxfMzo9scpCJCpQweIjmCDPE1WtVeCx3lQPwqMivfUcXXHn7Vj3lS7VC9
 bYIHWHN.QlPGnkANBe7oiPxZYr.7MET4KXQfuC7N27LSSUx0SenJvupQZC4UydOarfHTbczRnRMK
 6nj3ERvOCM.ZlTsRfoa1pgu6GilJaRPpA_qY7r9si6MkdBStO8hVRwbMo8fwMnnLaX7k2MVKS7SK
 7iHofOQf_CQT5Lbxug1p__yUm5PJEgS.E3AbTev5pMIBGw6CPGV1VEO93GPstiFiCpyo2kHcV7MV
 qkD21WyfPbZnRxIqLlDZmgAXWI2DNXc3Rm0tjqDXSss6OngK7kA7dGYvZVb0rzrIFjEylUE4ROjp
 StND7SmOsww0s2isy57IXjTk_atOPtZ8SjQvhieQdRWh2.0xlCLIeobEkj.vUHmbXaZfFg27WOui
 emepDXK26IgtM9rx7CiZdR2coB_uOD6zMSVKqVmM1rx1lkjBY4c5ks5F5BIntReu0cWF7ZQV4UBZ
 vbCvi8u2oJOJ207qp.0UVSuNgW2u0wG3iWE3Ps.maFkhbYvT8A2T.kABUI66IGJ2u8ssJRwhnj6C
 jof.EDh2Ed1RaO_9OzxUmcvvnlXoPsxiMkhtG2h_goAUPaEyAj4Bak1wp6o3dKXGbFYf.nQzXvje
 uIZRIEiMogrrQcwp2CQrItgKz7vrm01t_rLDS9hKkeOqmqyJ9KSjSNKYShSCKJ3SR7kCM3xuPRbt
 3qTMeAN0nymk3pMM81UhNb6dWymWN7f_E7jBFCEyBhzfEzY32.pH8eBzgeo6arDI0yCxJ.L4Jx2I
 T3uMvrEiZfhpMT0Qys9wry1Sj4dx_x4nxVza0AefIMX91jgdjNiwWdmiVABbg3_B1xEo0nXNsVND
 aXN7waWGCBPVKI0SoRLpJ0q828wCuXxFSgsW6HCYDAbOaC8bXpc2jnN.L8enpHB7gIaH_.JXwIbA
 fVXllEcX_PHrYmXxwSfJke0KDR.e7usNQOxwxJvaKB0OhxqUqj29.3hkWFfEmezLYHXhmWt02eaA
 MbWt33YOQugHRdl3WzFS4XSKpx5C1UxenC6awp9_.N848lpdyt0HKkVhtC2jqByRbOtCJvI2U5Bw
 NRRhbPeCVXU9JUSxzhZpalvYERk4ffdn8bKo3hzVOIbipkg7d0NLowCR2Dh4o7zxgr0P270___fX
 WLM7s4GhyPIRPfkvaqO39iooQW1qCo693.NKfH4hSXMng7vcNmw3L9.SIdBHcl1J4djHaRk0WrFl
 TM_3ycxi8.SvEV2.buaxqxVxXaSnedQyBgh05i16I57wY4kwGvP7SNUOEYe1dVsDkN5lXp37fr7D
 m3IIMMGSm9vXHK8hxKD5xRuSMWlpNbCYVlnewF3myMwXMcmunM17.Mlfk9bnVAYa71YaQ_gn1z_6
 DEc92PqUKkt7YatAM0WtR5Gk_SwxyOa.89U7SyXiQw1lwCRwhSMb.jiQVg93Y42462oKXfpJD1H6
 _RNSrOozG6B82DZtA2uHqEYR0s9J4KShHmhCQACT1Md7NoGXEghsJRlGu3_3hkcTS2.O9AYxnHWt
 2hbBPWNTY5mTpZTkuHH_sQExScBhD5SBH7x.7A6.FOYouYDL8X9GGgJLdWpjEGsWZCed_OVwIaVb
 b_XYEQ3wPXA791cnALukAFYaxfQiK8XIv1JwNz4WY6QlE3pD1wsgRZiXxdsolvTVe7XDJAxUOAj1
 C_8yT3POt.8xnkTJ5fVedPt_15kiYNTYdBncfXMMI6_Szhd1hLoBecIRY_9StSKgtWo2921UGagu
 1j88vf7JRfBjckPaFqLaW4_NB0TTFGrJHM.pSzd8cAvHMbr6iXK0q6J9JFKYZmABA.4EbKXpdCMX
 WGpMbvne4f8lLn2Zg4m4gixoryD.RvUWDRfHoVFEvzdhTAa3QIYc3yUWYFX3fkx5HjjIoy6IksgG
 SFUPO2UAYhBLd_KwSsWLx4XMTbGbQWoco4VAepNyIUCdCWr.cpmSSHkvpwTWu4ShDW5JTuKYtqSL
 8IcJ_wIxJktsPjMGq030yrmaCfqio1Yx6.1bPka5tysG9cuTSoNVA2bVKXDNR8nJN71v2uw2GQCI
 vpedZn8m4kjKzr6EfDc2z0qkblnvTaRQwfU_5unUQMDQ.19pwz93GJaEOXegMx.Sjhj0wfRrPv7d
 hps2MsV.chxrTBkms_A0-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Fri, 12 Aug 2022 21:59:11 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-5bdfc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID da2640015b5c2c3b63bd3f8312c2da46;
          Fri, 12 Aug 2022 21:59:07 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v6 08/14] iio: magnetometer: yas530: Apply documentation and style fixes
Date:   Fri, 12 Aug 2022 23:54:13 +0200
Message-Id: <300e394a76eb30fa031ecb69b594e9f9a70dac42.1660337264.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1660337264.git.jahau@rocketmail.com>
References: <cover.1660337264.git.jahau@rocketmail.com>
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
index beb48f3a959c..f81868de5995 100644
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

