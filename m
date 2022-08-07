Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9B458BE3E
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 01:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbiHGXHm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 19:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbiHGXHi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 19:07:38 -0400
Received: from sonic311-32.consmr.mail.ir2.yahoo.com (sonic311-32.consmr.mail.ir2.yahoo.com [77.238.176.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7672DF3
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 16:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1659913655; bh=Opg3ThBOVGGnk1ZxUbIiwtDZRXpPBEgLU8xaQT4yBRQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Mc6LjdlL6W2ZHQa3v560uX66WFIlInXmVnIuJ5hdl5okmDwWf7cru+zbCgqpxKCm7XsIFJpap3l16ZbQ3l+rZ/uzmB1ues3JbAY0JB0RBPHQxDcKGtuujZmsnolEsWcklPuoq3CiyKPQOF3xYjHK+XbWdXlbrT525J9AcUnr5Rj/m/c2yaGO4qOIscaLWuYz82o3Zv4epsiWN4sMx8H+JrxptweNh4tUt7nbVeprEjxK98HHoJ9yBRuI/dtOR8WNjc18t/deUyg0pS/RcucvYsVxGBmP9QvpDHPsCErG0aVU90349eb1158oOyBiziOaYUbo/DByuiBrgLhcpYRvnQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1659913655; bh=7UQfk7K66c7nWn29A8/87YBxGS+pHxn5N3JiGADxCn/=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=cOIEanBbSnEGFpXUWLcdJXzbFBCJpR7OTvkNA2aLzmQDGDd3dpA7wWoAyS6fpw1otZa6Oe5Tw2c2eYe5vkDR68p+sXViYt3hKRBnVG6wrHTQMqHNWOeBIoou3iXnu2RyNhSzxXh4OoJ4en46lJ0O2TwWcwpJi/oUJHjQSXbb2RGcdbj2OUywpQjMHyeZeT7S/Ighm6JS6thHX/2+f0qXHFpSpZm6HPClnnkIZNe2L7G3b8FpxnJLq33eWMhN1Fnquc6AR8CY4ds922XgXaGQ3r32xMbc/D3u+tocEriw3rWQNFGNUPFEokwWUy8AWpyTRAENSoU/TN5xMlUxC2dqiw==
X-YMail-OSG: _WgWblwVM1lCN3d6.VcuxuMj12khNGRR74WoOpXy8Ur5jtW56KUS1LUwBHkWjD6
 alLKCAu8axM2_vztsj3xIiVjLRNV7jGBJf0vCBR4X5JXsC3NU1hIYxOE0d_11bbg9p7VPFgReGrB
 wJeIcUvNyoZPqblsLx4SydhCXk_m.MUSszm52SoyRCzBITw3JvHlceHqUBfM2RYx5nN85Y_vzk7T
 FE8xn.1lg8EtFa8UwsmodEPA1wD.M7sSbo3HGrTGF9Cq9x41gt_n4Rq7ZGe57UXfXYLkKDVakw6l
 ImY8tbxjU396TyuFmW4xdiEswad1xstTJ89pIODfRCUQ005f9iLVH3tYgfs2Q0XsQpCpnKCk5hy6
 Q62D51XRE8xKihQs6uqp7yhly5iGvY5BxgQQYWLAFidRtWBtKHNJKbv5kXyY9JZ71N4kqTA4wemX
 FJCaKw4fd6AjS6YWI4MF2AWgBs432fT.xGT38cgOgrRAGubn6zPh6T4GnAUMho5BB.FeKvcbNUP6
 QAg0OpVjO9f4PSesQwq1_ugBObhmzfbJK9VVrmqkWcRfdt4jWMn1aHDtDvnoLdqXwS107DoT9nvn
 9PWTR2HxB.zdtOAmAh8gC_2IKpuGgprBGgriOikoMTZD749OUfuMkOlzjL3LA5aP_jGpzS5UImag
 8ldGsuvGaqglEFsqZsurKRf1wBJHSY1LVyQ9v5AdQYK9IQZYUjaU6mwkSKF5rqUQuE05J_niHni9
 Xm3Cw8sSllC9_vV0pYPfHjdH_MlNQnWvkSQ0gZuH9SUGEi9m0mSBn8NZiu7_4fjZFqscGcwLeSZ0
 x_0r2jpBtJEBI8ak2qL37cp1FYKrdr9qsvcZ7F4FFInOzlXAo.a.LxB5qWbUbCndMbuzzY9byFbR
 2sCfLqgLAE3aU1YfFqC5YuwkZggtc9WRkKHL0_TZ0Hub0AMLjAX5Shvd4S6nEtcY6FvksT2PY86w
 zcvhJ7Nbo1_.agisW_BRfIfra9dp_zsFHIwVFg.BXXpR9FsYQB7YgMCmRnuCDYb324J0ua_xozjV
 z4znhWic1er.O1i4bzQGDw11lxpQgrAIk3IJb6ryN8qXaZq4G..bI28LZc6QOJ4fqdU2lQ90Tybo
 qAlDwK3DlUAGE4DPyi5leYFvdYbIrxpF6ZqQ78R.CdgJX7LYxHl4qudS7Dg9n7RauzHb9YuWINzm
 zQkuEcBV6Ge8ivZfovITiLzLD4k1NaZH2qrzi4E9jGfoiBUXVE0.1M8a1Qm4wzA1LPUW_QGHAkft
 3Cou6ami2g2o19czbe5RJ9OL09QTuJCxLIWLpuuXOdpTS8vdWgwGQR4dhkDoavY5_gCSIFZgfa0p
 g2ev_oio3ALAu0Mj64WNJdTcaeV8sFAgJxPcH5NIQyPxhnUIJCgfsqGsSQCHdDa.H.eHVpB0_Pf4
 HrVaiBMu8C8wbrNSzn4S_2o6OtmKhrl0nAgf5TdB2nkQKx24IoOUULdmuPXXmeJZXUpcsC3nGMgJ
 KUKhpcLq9uY0jNNpQpZyV1qrx37bXj8YKvro5gKX16srmIUMInICwOwxB6r_ExBwwf6Frl0MPlQT
 PRmc_zbn5YaV.OMYq2rCahquzF9hQPLopseBCXIn1Ad8fuYIMyRbFQ4e5ZNJcYAEREL3S48tKm0i
 fJIUF5xX0M8VI32sXK95sdk9QbuwHHqR2eLOssLEr8VfkQ76T9sYot6keUpn.WxaGGkPGGsQOCRX
 zl57fmlJZHaIn.3o2GEv4PBJNb1zhXO.ujVvr9Fv8lidAV3RJ77rgbBn7PQIoEJR5.LY44vzowC8
 HFmLdAAAD06l1DzC82RozPaVw4PV28N0oBZsQGNBzTR2L9H0B8cxR47T99bITz2QCgUhtf4h9dzr
 lDWyHrwpY2sbqGiHSpZ2zgGXQPtyhXFGRGSdklrP8KqVwH6AOkdDCKrlDkxh4EPst3wxlvZ4WH1U
 Bn8rOk4UjosXAKteeLaFGkUEdJn3caGmjcxVYVntAdcPDRlu_O5PznUxY2VG29A3sAE96tEvA2Ge
 XiXHfpAASj2khunTZKhnvkyuu1iCVDfF5MXU0VJe9VgpbFVuu8FxslBOZwizxzyet9umO.LyrV4J
 HKg.uScfKGLHqOVOGc9qLM3ji9NXBcTB8xDOy0yahCDKpRhq7Tlh6zEvvRgBwUYYG20T6oJ70u20
 STUBZORaXKjAzgE2Ma7jsMSLilGJlUrq6YZ5FvZUARJNxm38WVpdwcB5MRqsP24_IgczpNqjl3ta
 t3svcYsXvUe4uE4nQ29tveZqc0tp8Fm_As8Ti8Sqdc6Ibve9CO9da2J5IV9L6_0VaLKYscw_ytS0
 NDix2hH2vxbmGrJo-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ir2.yahoo.com with HTTP; Sun, 7 Aug 2022 23:07:35 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-2vqg6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID dc92a55cf24372a35650a28a19dee6ae;
          Sun, 07 Aug 2022 23:07:33 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v5 10/14] iio: magnetometer: yas530: Add volatile registers to "chip_info"
Date:   Mon,  8 Aug 2022 01:06:49 +0200
Message-Id: <aa1936a9e3687cb9d112232b87db8a9f9e1a7ffa.1659909060.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1659909060.git.jahau@rocketmail.com>
References: <cover.1659909060.git.jahau@rocketmail.com>
MIME-Version: 1.0
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

Add volatile registers to the "chip_info" structure to ease the handling of
different YAS variants.

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 37 ++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index ecc2b61a5c4f..914f7f0a243e 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -114,6 +114,11 @@ static const char * const yas5xx_version_names[][2] = {
 	[yas533] = { "AB", "AC" },
 };
 
+static const int yas530_volatile_reg[] = {
+	YAS530_ACTUATE_INIT_COIL,
+	YAS530_MEASURE,
+};
+
 struct yas5xx_calibration {
 	/* Linearization calibration x, y1, y2 */
 	s32 r[3];
@@ -135,11 +140,15 @@ struct yas5xx;
  * @devid: device ID number
  * @product_name: product name of the YAS variant
  * @version_name: version letter or naming
+ * @volatile_reg: device-specific volatile registers
+ * @volatile_reg_qty: quantity of device-specific volatile registers
  */
 struct yas5xx_chip_info {
 	unsigned int devid;
 	const char *product_name;
 	const char * const *version_name;
+	const int *volatile_reg;
+	int volatile_reg_qty;
 };
 
 /**
@@ -626,9 +635,25 @@ static const struct iio_info yas5xx_info = {
 
 static bool yas5xx_volatile_reg(struct device *dev, unsigned int reg)
 {
-	return reg == YAS530_ACTUATE_INIT_COIL ||
-		reg == YAS530_MEASURE ||
-		(reg >= YAS5XX_MEASURE_DATA && reg < YAS5XX_MEASURE_DATA + 8);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct yas5xx *yas5xx = iio_priv(indio_dev);
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
+	reg_qty = yas5xx->chip_info->volatile_reg_qty;
+	for (i = 0; i < reg_qty; i++) {
+		if (reg == yas5xx->chip_info->volatile_reg[i])
+			return true;
+	}
+
+	return false;
 }
 
 /* TODO: enable regmap cache, using mark dirty and sync at runtime resume */
@@ -932,16 +957,22 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
 		.devid = YAS530_DEVICE_ID,
 		.product_name = yas5xx_product_name[yas530],
 		.version_name = yas5xx_version_names[yas530],
+		.volatile_reg = yas530_volatile_reg,
+		.volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
 	},
 	[yas532] = {
 		.devid = YAS532_DEVICE_ID,
 		.product_name = yas5xx_product_name[yas532],
 		.version_name = yas5xx_version_names[yas532],
+		.volatile_reg = yas530_volatile_reg,
+		.volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
 	},
 	[yas533] = {
 		.devid = YAS532_DEVICE_ID,
 		.product_name = yas5xx_product_name[yas533],
 		.version_name = yas5xx_version_names[yas533],
+		.volatile_reg = yas530_volatile_reg,
+		.volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
 	},
 };
 
-- 
2.35.1

