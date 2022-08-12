Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A0C591702
	for <lists+linux-iio@lfdr.de>; Fri, 12 Aug 2022 23:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbiHLV7S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Aug 2022 17:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbiHLV7P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2022 17:59:15 -0400
Received: from sonic314-19.consmr.mail.ir2.yahoo.com (sonic314-19.consmr.mail.ir2.yahoo.com [77.238.177.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FF5B514B
        for <linux-iio@vger.kernel.org>; Fri, 12 Aug 2022 14:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1660341553; bh=soju2w1mmQ5qFukSEwLFpYSnFgCDfNKRtq3CDVaWa6I=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=OrAlXbF6zndCrfQfQE8if0ulr1zFO28G38BmLvAuMtO18CDz3OgRvJerRnT9tRP9f0CCA6A/UydmFcMeAndLjz4WLz8dvdJKWbNjjnijmM3JZ2vIQ2F9jUwNzmq21wWJcTYKwLwVTFb2qKFcHfbQinZvRVH5XJzNb9xNU/f06udk0jDcAD3fJy7YHfhQH7MUD1f6x1qxb/bjYPsx+zl12ImzdjEue/wEH+P1Kr9xMaWHcU7KxAmccm9gFohf2HN74k9w12zCw7yHH1KRejaM+12N3tJ+EeO68XCeQ0QDIYiqWG4WZsNqrDSatPZXqkzu7+7z6jtZWRH99rMkOdIAPw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660341553; bh=+sto39i1nGejNxdTEUzPOb32s1RoiXL/XKdYP0Bvqma=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=azEXT55hu4ZV9XiOzNoF4EnZse10bdKsH28O4wNKZraBR7BrEZJ/8lUttNsRG4Agbth4UL248Q0kLtcP2UlyYXo+0TloODinx96QdyiuIVOt0yWNQDKIlwGZ2ZBSntzDYeW16jqfMKkrOUrAItCfK4pGKysC5SlRrOJqaKdmiX+5rRLvvYxwCFB4j9ikDVAjVG6Dzvowt7V9vwklQCkkaMgQl5Az5Fe67ty/MHPIMv9TIwTPOh5FiqEZ+5w8E7DFsxbf7hSte4CIxq7iE+Wov/DSrhTbtkcFePbzPhdd+djG429FUbLgKe6PAyZmvIwPT4x3eNOBRxGtJVMoE8kuug==
X-YMail-OSG: 3LhErrsVM1nvezyH2rTRju6bSrQYq5oSFOIIF2g9DBA_GlPsus8DmVaOsD7_1H2
 13APOwMRjCOASJDQaVoNgzm3giD5O_HEzZU4nLFKBR0Cz4Pg1q5SaoPu0rKzpDK0RpuTk8JkPD9p
 0TSkLs4g9qrOJrLh9PM8SEMIfCHJB.6sQOhTxlYZEjdNHtFWVPXdqwBbmn0S0RSRsZqsW0erulJJ
 EcbMfER.xf0W_e0a.RDMxZwkALZ0v2L3VQwuzNTo_GLJxOuNKqEIB9coe7HvGzKPrR.LWOaJCVzf
 AqKW.39izWw4.UZVEqff8Sn3lWy7sj10Yu8834pGQZENVLbwt5HZCn7iqmiVmucuZzIO5ypCO8sA
 HDzt6b_rT5nFFTm_bjV.ZO85M4v0FLDJAjAvZQQtv6Wz3PG.skA.hFL7g.l2nwNDuyTW1xYuuMF0
 uEgFqGtiKkwZ53dAr84NxtxQp4ukYtKdH9LUhhAtBcxN2InjXDJ17WorkvEW5k.CNQaaYYLL7BdL
 AX7WrQ8huLh4Ux0x1dC.Aw9n3iHZKmX7CtmMAQ5.554Vk5KNsO3MWmCYqQCmn.28onMPWhAjn9pw
 EUEJ.ERTkl_UoPbNouehtOf8.SIm7l3S4P23BEk9Gh5iJ.uLlUW8VrdGFl1yS4744GsJlLjk9_9e
 OHwYFU0HL0o8PjdzneK0EEcIKm03mpoidPrLNmQdwUGMYb2cJBUl2NGOVeSY0bHtLW7e68Ui8OIq
 bhVNZuLnsKriKWKYL_HeUTXNsDZ6gSz_N36jVSeloSZ1qPNaa_PZncWrg2nAg.YayEq3UiB.vIH7
 .AY4LPtiyDJR5r1KkV9arDuGRXsrs8ozYN6jlXqTiofV.rokeLQ4PdEo827Zu6qo8oIYe1h98Nyi
 OO8LaAdacPX_a09MvCklubnaK3xK._npEHKgSdLZh9ngVflg7GtCD61m0qcGdNxeoyqOQmPLn1tm
 coJzu0oEq9e_YCtQZsFuvS3vWJWU7vssH0grW_Pk57R_dRUZ75VjrkJMap5SO8t8BCr6GU7ZHNUz
 rid03LlH0DX33ebSM8uqg93nzf3P3tuhnIqchyJrH.mDd3Z_ud3d1WprUJoUp9qyy2OsqBfAXusS
 nefxDLct2TWPO_hE.HHY.WWhI6OV4XwRtkPMkW5NVUYPCUKZpDxf6RfQYRJxt8TMuf6OID8ABtw3
 5WJn5LjdGv6gP0sGd4LfqequCsP0659msmvpEzR0M.BxJXqHp4hECu1gH755qGZO3SRFK18OZi2J
 mTrzecs8m1EMa06ojAjFviV9zhfT5AHAFi7pZtTru9y3db7Qg5MPcqxE7SROy7BoH8lW6YUw6alw
 .VxZJOusa7GEJe.n17MuIzI1WnMIu05VBYKO3v7MWxSCK32ELM1PDtCD_4Wp0CyTjhG2JSHDKNos
 AHBQ__KKMPAMdynevTJXNAD6olTvVBioVQNG8eT7QvUO19RvHstglGN8hwaR7Ic6d4eAS3jbnXFQ
 LaG18puKQOBxwDsFWWUlcyJEUv6I3ozC1J97SzD1kB2pJ4x9.NqoHjmdDuX7aZemTqY03ewOfbdf
 VT7ePt1b1vqLdLel30j1RAkkNqxrzhQRTcO026kxnCOFIFCFrpcqOMZr3bfHypXlK1Flx3ZrAsOV
 m_NUAyfla7drpLLOvTBXB4jC6vOQSzWl48itIFnumcN1YpAxC3djvW7OdHD6e_747xRRm0enxLOy
 dI_8e8U7XRc.sPFAT7bQWSUOBMat4FOVCr2oTRcs.WVj_C8Iv9yZ3y6xTLHCzanSwBuC3GFTtmde
 Z0IDNIGAQjAfNfGolSOlnStVS.ItP49UJiBdkg46ajYF1FwwFpu24VXnoYWqFCypNgorAE2CGBDG
 2Z.f21eYrtv4hlU6sYGCFicvyvAlmFgFlUglk8qmCcegudgKdSkGuHPvTmiXOBDpA4SMKo8W1vdV
 0NwrDGT44dD0kBSjg1LaCdCq2MUfC405iP2a.eR6WcEiMZtSnwr80SV3xdEtunfimGPxQJTLb1UB
 tifyu8Px1B_iXT47e0XA3KslS.6kdAfiurs7gPUwy.rZbr3zXo01KsjMKN2VFLv.vwnXfJ6WWdNG
 ZztMTnZkgUb.5NEokLRWQ17YnlictM92xcIlGbtkR7kB4lVc_tx_t3uMpDKpsHGfDsWz.ps2CC9C
 K.SmKvARNafDsneFl05srwX2hWLIea0K7NK1geBF2p0a5Xfbhjze9aGHvttfml6kgi6ltgwVrBKI
 6n6nNBb_wCj1DgLO2Tvgi5bBEUKqCjDjzI8MiEJju94XoG_Ab_JZED0FAC1KKm.6x4KTUGvAodiz
 KQ03Ow1oQetvvBDjFO6o-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ir2.yahoo.com with HTTP; Fri, 12 Aug 2022 21:59:13 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-5bdfc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID da2640015b5c2c3b63bd3f8312c2da46;
          Fri, 12 Aug 2022 21:59:09 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v6 10/14] iio: magnetometer: yas530: Add volatile registers to "chip_info"
Date:   Fri, 12 Aug 2022 23:54:15 +0200
Message-Id: <aeba3877933ba9d2c920b459a9037d9186c15a4f.1660337264.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1660337264.git.jahau@rocketmail.com>
References: <cover.1660337264.git.jahau@rocketmail.com>
MIME-Version: 1.0
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

Add volatile registers to the "chip_info" structure to ease the handling of
different YAS variants.

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 38 ++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 4fe7e8c820c3..fa317b975f8f 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -102,6 +102,11 @@ enum chip_ids {
 	yas533,
 };
 
+static const int yas530_volatile_reg[] = {
+	YAS530_ACTUATE_INIT_COIL,
+	YAS530_MEASURE,
+};
+
 struct yas5xx_calibration {
 	/* Linearization calibration x, y1, y2 */
 	s32 r[3];
@@ -123,11 +128,15 @@ struct yas5xx;
  * @devid: device ID number
  * @product_name: product name of the YAS variant
  * @version_names: version letters or namings
+ * @volatile_reg: device-specific volatile registers
+ * @volatile_reg_qty: quantity of device-specific volatile registers
  */
 struct yas5xx_chip_info {
 	unsigned int devid;
 	char *product_name;
 	char *version_names[2];
+	const int *volatile_reg;
+	int volatile_reg_qty;
 };
 
 /**
@@ -616,9 +625,26 @@ static const struct iio_info yas5xx_info = {
 
 static bool yas5xx_volatile_reg(struct device *dev, unsigned int reg)
 {
-	return reg == YAS530_ACTUATE_INIT_COIL ||
-		reg == YAS530_MEASURE ||
-		(reg >= YAS5XX_MEASURE_DATA && reg < YAS5XX_MEASURE_DATA + 8);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct yas5xx *yas5xx = iio_priv(indio_dev);
+	const struct yas5xx_chip_info *ci = yas5xx->chip_info;
+	int reg_qty;
+	int i;
+
+	if (reg >= YAS5XX_MEASURE_DATA && reg < YAS5XX_MEASURE_DATA + 8)
+		return true;
+
+	/*
+	 * YAS versions share different registers on the same address,
+	 * need to differentiate.
+	 */
+	reg_qty = ci->volatile_reg_qty;
+	for (i = 0; i < reg_qty; i++) {
+		if (reg == ci->volatile_reg[i])
+			return true;
+	}
+
+	return false;
 }
 
 /* TODO: enable regmap cache, using mark dirty and sync at runtime resume */
@@ -923,16 +949,22 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
 		.devid = YAS530_DEVICE_ID,
 		.product_name = "YAS530 MS-3E",
 		.version_names = { "A", "B" },
+		.volatile_reg = yas530_volatile_reg,
+		.volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
 	},
 	[yas532] = {
 		.devid = YAS532_DEVICE_ID,
 		.product_name = "YAS532 MS-3R",
 		.version_names = { "AB", "AC" },
+		.volatile_reg = yas530_volatile_reg,
+		.volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
 	},
 	[yas533] = {
 		.devid = YAS532_DEVICE_ID,
 		.product_name = "YAS533 MS-3F",
 		.version_names = { "AB", "AC" },
+		.volatile_reg = yas530_volatile_reg,
+		.volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
 	},
 };
 
-- 
2.35.1

