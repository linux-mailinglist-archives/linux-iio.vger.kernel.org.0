Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6BD564A36
	for <lists+linux-iio@lfdr.de>; Mon,  4 Jul 2022 00:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiGCWDc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Jul 2022 18:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiGCWDb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jul 2022 18:03:31 -0400
Received: from sonic314-20.consmr.mail.ir2.yahoo.com (sonic314-20.consmr.mail.ir2.yahoo.com [77.238.177.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B013E2BDB
        for <linux-iio@vger.kernel.org>; Sun,  3 Jul 2022 15:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1656885807; bh=OfDSYQwQvZKC/QF+iVLWNzwkWD6d9XWRERzlXTFUHKQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=MWDDQCuJX8kKggLex6fS5SyrjfvgGJxFYqz5t6tQhXycdDtMmDhrBeiro43HFCiB2ahxO7gYQo9O5UawzxvlcULTFDEVyT4uwOZhU6oyGO2lx+FsZaTpvcHAvTx6YmNgB/uyeZ0wjg6UQ8Su8Q/FdF9723eCkDujcfbjXrila/KlXxll0K0DwjDRA7EHJ3OF+X9DK0ZxPOPE92qqfl8lsQrxG3Aj9KbjLUq9x+9e8vRB4oscylwe6RgEn3LsHdmcPjJsGwbMmH0RIfqJPUmeiqeNTKn/l/y3prEFYSiqLkQpOKS5ZEsOMvL9N+UwQdEPSSsNoSirfqQJn3Z8FCXO/g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656885807; bh=/2V4NheHlXOBXV3OKEUEe5Arrqzf1oIHGnUD9ZYW2yR=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=qUnEQMBD1I6KiZAVKuNwp22YmMpW/I8ZCQ3pSuxTFX4/eUCysCmRVQN8nDoLmIl0jT1+/CTvTHQXj34B/G9067pJJBVPO0ivRqfmevIXFyMsbG4ai53qMFyOtyjFV1D8l0RvgVB373y4KJTCeXLM5N0kXANorQ5SMLBF+OeWYYUvozv8+1qmTgmqKwLxrHobFAvNfgpBGL+Z4yXcenUXW5NktEVVqgxlW6pgKK6aQoeA7DxgwBDXEYCaYfOzTlu3Y4U9k+qcvlia0fJOo97tLo0OJ8qTr0aHPFuggQOLwXJ81Xpyy1lxuiR+4/UDQMaAlOK24Mxk3gF9WXo2ddQ6NA==
X-YMail-OSG: zDoUJ_EVM1mOYs.fkoXbSAXtv1OQJwx_4CXaegpzQ_Um3hw2ZPwaILfVSe.HxAA
 jbqWs426im_rjJBjIqzAKz8mAS4FNilSq5xU4preM1ix9YffDYmoXceKKAlDkxhWh5jCKJT46TGb
 lYlcAWc6.paa4qS1kNXaVvI2qOOzjNz776YGesXcmxU07V1M8dbxDp_bliWLDPwjqVDAmty0jjAQ
 Yktj4q18pUavNj5oUrovg7rZJ.UNH70rq4C6CccDsi9s6dpFuonE9eqSc0RrzK2.iSjG4UUvabXz
 MzoMjtkRLes9De8WMOGquFJboHFolzx191KVgxdTuaE5l.zcsemxYA4gH5olC9e.z5WN7c6zPPcT
 OpRzDnSTHyMFa7ot2t9UzyAy7h_BdpY4pNB91PEbyu3gDWCGUXLLzzpzBI1B73dPRvSsgHNiSDxM
 ewzfFz2fAWnsj85JxFyevd4tOvQSZAY2flvlP1Mv5pqCpgCDo1GL8jkENlSlF_Y97UhNZDbikWmL
 zywfQdRArGpw.x8HNiDUcAVkK4aU.z_Dq60hiDurcmPJtrUXt.GYq1mJDsUf4W2y80i.bwpkIA1E
 BIsu624ai59GEG_l4yOR8JIbZbsJo8EW0I0Mke1g777hYdVD_cbjbSEGm7DjeUXRUHUPby5gzK6l
 CJ3etXFznYsZvzCIMtcTyaOmNyA653lgrrkJuMHsiDoHW2z1ve6VBtp1qiMF3FP3YvOROo0xaIW9
 ZR9aOAXw_AJa9jLQIyan4ABIDKkESGODQCEA4Bgh7loHW4wN6p32hJzTF8x6ftWaByr3DSEJ5hZc
 xzcAmAtD_wQwvus7ncbpyuDtwLWGq33DMdO3CuAzEu1HKrFs_5qN8DCaIRKx8w2bvqKTqUZUkzR1
 ShdJjXNXUOWUM90XlCc3_yycCpr_QGP8WZpG87eEKwG8P9qGRwye2ffY.BR0TJtwzTJHvrD2iDxH
 H08WdoPltRrwfuOvsoeOHh5y0uR_6n4t4LkFp9mI0LUTcnw3dzDSuDy3FQ5vjbdOFQFeamwE0WRM
 76rX2JOZStR1ifVNZDkYljQyMeQasDENnI.FJAp6xPuifOB5X.jpS7y4jafXP8QBSHDxinFeM6Gr
 hYsFPksDcgJ5k6bVKeB57O4XsNamrqf0ypRU_3b1kXYKNVb.PbTo5rTfjrVynoHU6HIAMRpe52pi
 2_RMRhhTIratzO2cC53kf1pagNhAbDvR7onmkLUtLGDfxTFCbc1PYGQDLjmDzgUUw4aXP8CptIqE
 4ErV5Yde2DX57CEg9AH60z_alElFNeRkoYDIWpD_aCRQZwe3awIcxh27mmX.n7aZW9Q8TOXpysWm
 JAlDKchqNeMehs3Zk5jFLpWvdVjnGtbWdIFiQf2Y1xrzQgQzTeeQuNmHwl0D8sU4Tv8GjwDqBrVS
 n1RA0mJt_zv7B84.zvrGbnJg4WlzXedPTAXWiliI.zIXDJ1YmmI6lLo6ETwcRCzxHnzkuWdhlApq
 k68QGAyS28Rfm4PHDHgGTNj9p7..ZzOddAL0brVdw2DZoOXbX2k10TYW6bUVjdVWB0IAJiggCKoH
 r0hJdgvlyE.OycDf4YAPF8sYc5ank8Uw7roS1iG7DFS4kL.VsfXxOu.hPnIKc29jms3QV0PIZCws
 vhBxcisBfBB3h5fqi8vu.UXKCpp8aW7AzTpO7zD8tdRuK9AyuZp7MNM6RMOY0FpZ.TNyygUIn.jO
 9Xxrlx2TvIG7o45VZV82AbnvG2rlxe6WqT6wI.gloLj9dYOlTz6IPtXZS2yFC5DaFig3JHDrDkjn
 oN9Z03rUcLqlQvkkAekJYUnKBIx02snURYpVem7nJSAMwDZqxXFqVyvm8XjBgz.n7Gmx.n_LorJr
 tL20jxVeSNoTaRrFtuTAlRnhENjVlxim.Uf2UfxrsP_p3pp_hpnlaDTm0txmItf.4x.T5Vrw8fiL
 6yg1jBucS.VCRkGHojpdi_XFee3z0sW8eQYIEDdxDwVbHHDqJs_7gOimjHN_ttI._b6vnnu9JA7I
 Vokx.QyEmZVR0XoJhPiIHZQKwEwseM_4ik6hUMNvlHm0osnGv_6CL1PTe0PUrdlXbbBGmeN4UBtm
 98CSSl3TK78B3F.avosYcXY9GoeGedF2eDf9KIEwsDsm90ft.uGhQ5GItODFnTP2Z8lXQPo6sBrs
 uze_2dNa5WCN7arjnRgKYqWbKtnfi.IdWIvDvbA2mo2EPIO6AC14z9E6JRMltV0fKuZx79bw.ZZq
 U6ON55sY_q9CAxTi0PQIvnESfvfLu5jxvyj3.WkYA0xAj3MoY.HP1QmorlBLPb5ikwM7FTaEm.Lp
 qNmWEGkAp7Hkrdh2ALg--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ir2.yahoo.com with HTTP; Sun, 3 Jul 2022 22:03:27 +0000
Received: by hermes--canary-production-ir2-74b4d6d794-tv8mb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0849bd8970b52a790a5a1bb96f2e336c;
          Sun, 03 Jul 2022 22:03:22 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v4 08/10] iio: magnetometer: yas530: Apply documentation and style fixes
Date:   Mon,  4 Jul 2022 00:02:42 +0200
Message-Id: <8a1fb0faedc25aa2fbf9852cf4e1d9d085675ad6.1656883851.git.jahau@rocketmail.com>
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

This commit gathers several minor changes.

In the device examples, "Xiaomi" is too generic, specific devices should be
listed here. E.g. Xiaomi Redmi 2 seems to have YAS537 but it's not fully clear
if this applies to all its variants. Samsung Galaxy S7 is often quoted in
conjunction with YAS537.

Removed defines for device IDs of YAS537 and YAS539, they are not needed so far.

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 8358d4b3d1e2..4e2f460a4efd 100644
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
 
@@ -323,7 +319,7 @@ static int yas530_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo,
 {
 	struct yas5xx_calibration *c = &yas5xx->calibration;
 	u16 t_ref, t, x, y1, y2;
-	/* These are "signed x, signed y1 etc */
+	/* These are signed x, signed y1 etc */
 	s32 sx, sy1, sy2, sy, sz;
 	int ret;
 
@@ -663,7 +659,10 @@ static int yas530_get_calibration_data(struct yas5xx *yas5xx)
 		return ret;
 	dev_dbg(yas5xx->dev, "calibration data: %16ph\n", data);
 
+	/* Contribute calibration data to the input pool for kernel entropy */
 	add_device_randomness(data, sizeof(data));
+
+	/* Extract version */
 	yas5xx->version = data[15] & GENMASK(1, 0);
 
 	/* Extract the calibration from the bitfield */
@@ -690,6 +689,7 @@ static int yas530_get_calibration_data(struct yas5xx *yas5xx)
 	c->r[0] = sign_extend32(FIELD_GET(GENMASK(28, 23), val), 5);
 	c->r[1] = sign_extend32(FIELD_GET(GENMASK(20, 15), val), 5);
 	c->r[2] = sign_extend32(FIELD_GET(GENMASK(12, 7), val), 5);
+
 	return 0;
 }
 
@@ -711,12 +711,12 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
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
 
@@ -725,6 +725,7 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
 	c->Cy1 = data[1] * 10 - 1280;
 	c->Cy2 = data[2] * 10 - 1280;
 	yas530_extract_calibration(&data[3], c);
+
 	/*
 	 * Extract linearization:
 	 * Linearization layout in the 32 bits at byte 10:
-- 
2.35.1

