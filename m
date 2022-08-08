Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B711458CF56
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 22:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbiHHUsG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 16:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238714AbiHHUsD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 16:48:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E179586
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 13:48:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9fE-000466-8u; Mon, 08 Aug 2022 22:47:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9f7-002ZYu-BY; Mon, 08 Aug 2022 22:47:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9f8-00ARBH-RB; Mon, 08 Aug 2022 22:47:46 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 03/13] iio: adc: ad9467: Benefit from devm_clk_get_enabled() to simplify
Date:   Mon,  8 Aug 2022 22:47:30 +0200
Message-Id: <20220808204740.307667-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
References: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1494; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=M3jLOozacGEg4QCSKMgMqODHF16wU2n/8ESLmHFouj0=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi8XZCZc0deQRi0x/HW/orJyEmsBj0pqyxSw8v0SC+ VO6pnfyJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYvF2QgAKCRDB/BR4rcrsCWGpB/ 9wbkbRJ0Tt3hN9bB/tqHNgIh9o9rpNd9RSLtN4e2smmKQSsMc/lDRelL1MKc6DjkoKnDpWHgZ9W+/v bUMS65dKd1lvChvCG2ohXrPfpRHvXlXZJ3Ol+9BRtWplk05kJJgMc7kgJnVg5KyIQBDpeSI9fYfARe 2yZ7LIRykFXKSh8j7cLkH7GysRIN2Dy4k4peEfgqOgIbmkff9qH+GfuHzNHRS4gXOnObWlc7XERMyz C4FnOgj6Gv7Eb41SXcHG5wLYHeJPwe2t5CFhGxL2q90I6wpuXbJ5SvR3cwEx5cOfSIhZoCHExPDC/K b6G2l1tX4ajJA5julTxVnVuVkkUD5o
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Make use of devm_clk_get_enabled() to replace some code that effectively
open codes this new function.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/adc/ad9467.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index dbfc8517cb8a..a07df0fd3329 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -378,13 +378,6 @@ static int ad9467_preenable_setup(struct adi_axi_adc_conv *conv)
 	return ad9467_outputmode_set(st->spi, st->output_mode);
 }
 
-static void ad9467_clk_disable(void *data)
-{
-	struct ad9467_state *st = data;
-
-	clk_disable_unprepare(st->clk);
-}
-
 static int ad9467_probe(struct spi_device *spi)
 {
 	const struct ad9467_chip_info *info;
@@ -404,18 +397,10 @@ static int ad9467_probe(struct spi_device *spi)
 	st = adi_axi_adc_conv_priv(conv);
 	st->spi = spi;
 
-	st->clk = devm_clk_get(&spi->dev, "adc-clk");
+	st->clk = devm_clk_get_enabled(&spi->dev, "adc-clk");
 	if (IS_ERR(st->clk))
 		return PTR_ERR(st->clk);
 
-	ret = clk_prepare_enable(st->clk);
-	if (ret < 0)
-		return ret;
-
-	ret = devm_add_action_or_reset(&spi->dev, ad9467_clk_disable, st);
-	if (ret)
-		return ret;
-
 	st->pwrdown_gpio = devm_gpiod_get_optional(&spi->dev, "powerdown",
 						   GPIOD_OUT_LOW);
 	if (IS_ERR(st->pwrdown_gpio))
-- 
2.36.1

