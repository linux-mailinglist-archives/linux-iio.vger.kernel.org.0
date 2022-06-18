Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B89A550129
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jun 2022 02:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380215AbiFRAPQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jun 2022 20:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348242AbiFRAPP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jun 2022 20:15:15 -0400
Received: from sonic314-20.consmr.mail.ir2.yahoo.com (sonic314-20.consmr.mail.ir2.yahoo.com [77.238.177.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E97E21259
        for <linux-iio@vger.kernel.org>; Fri, 17 Jun 2022 17:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1655511311; bh=jJGcjXdRFHjvy2vr53L1DCuPWMWBd4P6XV8ec+te0zA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Jki6R99TZeoRckSDEAevrRi4J1HWPZ2F9xjYI5nU21BUMqyK+IzVtUbzaQSqUDMoWB37n4hMcM8aDFK8adAecJgxkfDewGkogTZ7gaYb6FdFzsuUc7OnCCndPfwE0asK4c0rMJ9DfLKPbUnrY5+Dt9V2GkhSGW6a3c0NMsYgwks+VDEFGzjUNhB9Ou5r41j0Wz7bmjNTwO0596+LDiHA+GO4Z8d7mFzWRuZ9WpcP+QHhCqUvMlM3hLdyeGCe1WKwmlpFWrQ6cMPWBUzdeVKwb/d5XYH91OseIg+qi80bcGrUAFtg/+NJstxLTTt7mOJu9UZX8EeRoCyUZA1iFOrMrQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655511311; bh=SSiaz/+YBZgWALi9ebhnsk3aYAxL0RbuzoH/d+3P/Oa=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=m05IdJ64jaUyQwAdbvgMm+YyAjasok89Hrg+aIZbQpZPgtxZiZekKXdbi14tY/NKLi6yQKo09cU18YplSgLwOj8zdsnmzYo1KkkJmIr6v5NRhrC3mnIpSQVTsrWY9pInctc6iDty75VLe8Rr9NlcGA0BdobwsxA8G+K5k86JvQDIuYBOQ7pbtLUIlJGJwsN2vfz7TjYsp3CNkVkvfM98HPutFT7/Cqz33E4fPX2C+L23B9NvYUiI0zZeNW2kom5zPi2n/SLl37cLuI8FeQ+RZfsGvsT7QfR92Wowk4pRThr35Aaj2dZHDIgeOnk2CHDCwbIwY+B+JB/ngMaWcwR6xQ==
X-YMail-OSG: 1kJsjwgVM1kECFBiZj1FQ9JEV8ePbH4Tit0Vl_Men8jXl4n95pYAK6fwCQmbFJF
 IWNDqrW9JcXhYOPx8sPYhvYRcUsmjDpeWJeEB2AWtp1I..4BQQWHZR2G0yIAGzYh_QUNBjwpypqQ
 bj0KI3X0yM.NJICizq2XV85Qg.6NibVzTY01bJfTPmLGKOvHIuw12rR9lTzqxaW_Ea2CpLy8DhYQ
 dgaU45.IyE2htDPz1s1VdBAbJ5H3NklKEminMri_xZ3PIKbHdGUHLG01OV5vG0kb2KZwsxprUNpM
 9CzmyHWmpFFzeA8tQeshSA5K6aAzwPtLpxm0xGh5N_xvctcVE_9L3SwiDHJyoVDPhEz8LfAAEBfz
 ZH3mZjAfzqAzD1uN1zWGefRnf4OTqZnRgM9Ctsf9at_RF77AwFJkneUs3QpbpQfPD6E4IG6Kn6Ov
 4HcaOXplgomv.w9d7jAHTBVzyaoousHalpMeAi.tmpigp..MDEFFcnGONL5wHc2BGg54U8LvfFRY
 Z3Ds7lQ3bMosCnvpRA59ghuJFwmQhRMDzphhJDujbPUIMnSTO05Tk6kEVgJ4j8o436FJ8Wy7SYh0
 rXyOkw7UP6j9byMsj.Eww6OIHE9c.DLqsg8Kvb5FZmB6Y4Q_egSA0ig3Q.eAG86vRrprPSLvGhqG
 PPkYFz5kkRH2L5b97JjSUu0.J9Of04sS0eFLZmvWuz6QRXAB5hU5itRC4Wqu_fWgRlERw_2VOY2p
 n2GMY9Voos0z4iYSd3eN6RLyA56XmtEZRAp8wdksQFYzDW8mmpWf0WxymuziqtwMUfR7FeRay.NK
 Q6w2DHcLY6o91DlhAPLk230P.47Szt5LwGqfgNESjzZokF1v99KHPrB56wzWTjmoXgndc2j9mghs
 ehjBjVG_VhIffxowNEMDX0okrwQNlgL4Qxfi1R.jMqFwtTDd.xx.n.n0s0yV8yXvpoZ9Ol4SFXZT
 BlIlquhhUL7YWjESk2oUls.xd9ywIE8YGrwcILXkNHtaRZk.iXh8aXdS9boYnUeDHS4XrbuzGQw.
 I4ELuYih4tcWOnhFqAITLrr5UQS6tsaTcjHhiYdVB2Dik2Pqz3skWym026QQpPFqooO67yAcOuLa
 W0T4iz0JrFKW_kaUzF99FKhpakbDJxXY8thZ1eQrPSSOsyMpQOmSRrMzSdMnQitWjuH6EEK6KV_p
 O0PkAhz6xfoYTL8ptvhP6G0VwE1zKdePEXpyoEL7byI8yH3Az0FVGLSgyS5L4KhZJhqNFeaiWPwL
 Gay4pYOufjDXxNE49leILRr0Y0jkE3BbYtvY9tbeu6JIHqACCpRE2aXuwps7X3MJBOq_7hxy75ZH
 fTpUowkuky.so6KZR2MM6gPfOw7niSUD_SEF7QPpo6S1u517sA2nELKfppOdBAtGjnEmD6wIY_F_
 VI9u8f1ENI.k9wC7eqOFW0xomlTg7liCmpB_vMM49kBggOBcP9xwPUu1ehi_CHhh4DPG_SYpEN2i
 3J3FgPBysYEzna2eK7nYKeDkWC3dyt0lB_ETjK8hqKoHepDF7lpvwiWYYJBOnRP7YAYsvsyRnpe1
 7NuhFs99uO5I_vHuDDNVZVaujcPS86yd6IcGCWlAv55DmGfz2X06VTqEYI6jLAkd0BPTMntT_W9r
 xWCpNOFQTlBAgI1Bnq6wamTVKaIVnU1iiJJUrL2.9G7qfKIcg5TTLJImqUOz26A2kXuabaPXTUYJ
 1R6lEm8TpwD4huxpQ8m.1P.DDj8JWk8UpQG3kIWqszsSewAhuISoGomEdVcoP9bvmuVbZL2Ls_PV
 MAo4vntPyvp4kCdyL6g4XTE1kaCzpkL6ji9A2y6nry1_.JkBK2pWC5yolWsnd06N9wXPsvY57Wej
 AXORKc75tujuaQFhhtSWSKyE.OBeV0XbOAjEba6fHBaK7Zxrv.tafAQ44wgzYedaAjqzNJ2N4JNy
 w5cTJrOiVQbPG4HTfBm9PXynf6rVyMsoTb2AlEkZ56ovlyl1gzUkuezUz76LdjVXrtAHFYb_dHpX
 ZY1N7L0vPk8_tKD16KkLULAVcbrvDNi3xJvk9j4CrfjZ8CyfNCpv9qpYv1G.o1JfZSsLGu_AYMcS
 J3pbod2gT8MstdRdoN._HhpplzijiPvZbNdJLr3CcTDwSW6qIYUnqoMiRuedEDYaN13uivFp30T0
 .Bm1PUaC_BNfdZWdW0eccIXjTNsV.lcp_nGiv7YV8abex42riUtnpTuACRYf7mL.Xl6LgS_ksF_g
 AbgLz9qybxB0IdryerwmlLNuDcErOoVqYB3TfEfB1d2oGUv4Uc_1T.g3SjP4yBEvI7auAhYY3hB4
 q3bFVlD6u4n_D_oIvqQ--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ir2.yahoo.com with HTTP; Sat, 18 Jun 2022 00:15:11 +0000
Received: by hermes--canary-production-ir2-c9bf9d9bc-74fwm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8b08f14069c990c2ed22165f3e3da032;
          Sat, 18 Jun 2022 00:15:06 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v3 7/8] iio: magnetometer: yas530: Apply minor cleanups
Date:   Sat, 18 Jun 2022 02:13:15 +0200
Message-Id: <362744427c87bfcfa8c885b1bb174dacc4861ec3.1655509425.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655509425.git.jahau@rocketmail.com>
References: <cover.1655509425.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This commit gathers minor cleanups in the current driver.

In the device examples, "Xiaomi" is too generic, specific devices should be
listed here. E.g. Xiaomi Redmi 2 seems to have YAS537 but it's not fully clear
if this applies to all its variants. Samsung Galaxy S7 is often quoted in
conjunction with YAS537.

In the function yas530_get_calibration_data(), the debug dump was extended to
16 elements as this is the size of the calibration data array of YAS530.
---
 drivers/iio/magnetometer/yamaha-yas530.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 98c8d365fab7..72a75dc57e11 100644
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
@@ -322,7 +322,7 @@ static int yas530_532_get_measure(struct yas5xx *yas5xx, s32 *to,
 {
 	struct yas5xx_calibration *c = &yas5xx->calibration;
 	u16 t_ref, t, x, y1, y2;
-	/* These are "signed x, signed y1 etc */
+	/* These are signed x, signed y1 etc */
 	s32 sx, sy1, sy2, sy, sz;
 	int ret;
 
@@ -656,9 +656,12 @@ static int yas530_get_calibration_data(struct yas5xx *yas5xx)
 	ret = regmap_bulk_read(yas5xx->map, YAS530_532_CAL, data, sizeof(data));
 	if (ret)
 		return ret;
-	dev_dbg(yas5xx->dev, "calibration data: %*ph\n", 14, data);
+	dev_dbg(yas5xx->dev, "calibration data: %16ph\n", data);
 
+	/* Contribute calibration data to the input pool for kernel entropy */
 	add_device_randomness(data, sizeof(data));
+
+	/* Extract version */
 	yas5xx->version = data[15] & GENMASK(1, 0);
 
 	/* Extract the calibration from the bitfield */
@@ -685,6 +688,7 @@ static int yas530_get_calibration_data(struct yas5xx *yas5xx)
 	c->r[0] = sign_extend32(FIELD_GET(GENMASK(28, 23), val), 5);
 	c->r[1] = sign_extend32(FIELD_GET(GENMASK(20, 15), val), 5);
 	c->r[2] = sign_extend32(FIELD_GET(GENMASK(12, 7), val), 5);
+
 	return 0;
 }
 
@@ -703,15 +707,17 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
 	ret = regmap_bulk_read(yas5xx->map, YAS530_532_CAL, data, sizeof(data));
 	if (ret)
 		return ret;
-	dev_dbg(yas5xx->dev, "calibration data: %*ph\n", 14, data);
+	dev_dbg(yas5xx->dev, "calibration data: %14ph\n", data);
 
 	/* Sanity check, is this all zeroes? */
-	if (memchr_inv(data, 0x00, 13) == NULL) {
+	if (!memchr_inv(data, 0x00, 13)) {
 		if (!(data[13] & BIT(7)))
 			dev_warn(yas5xx->dev, "calibration is blank!\n");
 	}
 
+	/* Contribute calibration data to the input pool for kernel entropy */
 	add_device_randomness(data, sizeof(data));
+
 	/* Only one bit of version info reserved here as far as we know */
 	yas5xx->version = data[13] & BIT(0);
 
@@ -720,6 +726,7 @@ static int yas532_get_calibration_data(struct yas5xx *yas5xx)
 	c->Cy1 = data[1] * 10 - 1280;
 	c->Cy2 = data[2] * 10 - 1280;
 	yas530_532_extract_calibration(&data[3], c);
+
 	/*
 	 * Extract linearization:
 	 * Linearization layout in the 32 bits at byte 10:
-- 
2.35.1

