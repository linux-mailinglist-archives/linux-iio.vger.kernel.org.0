Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529FE58CF5B
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 22:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244118AbiHHUsJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 16:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244285AbiHHUsE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 16:48:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31E9AE70
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 13:48:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9fE-00046A-8z; Mon, 08 Aug 2022 22:47:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9f8-002ZZD-DS; Mon, 08 Aug 2022 22:47:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9f9-00ARBV-K7; Mon, 08 Aug 2022 22:47:47 +0200
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
Subject: [PATCH 07/13] iio: adc: ti-ads131e08: Benefit from devm_clk_get_enabled() to simplify
Date:   Mon,  8 Aug 2022 22:47:34 +0200
Message-Id: <20220808204740.307667-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
References: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1640; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=s4UJ6E3vV491iJC6Up6tC28UGopVyXCAyX+kizQIAfQ=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi8XZRjr1Td7m2QoGKA4fAatIuApBira8Mok034GRr VuvmO/aJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYvF2UQAKCRDB/BR4rcrsCalUB/ 4kuHVU5yAoZACBJxxJEwAQ0aD8Rrs5Z1alCx+S9vpS3A9C3iRA3ehMIXsUywvCBPozB7pQDeke5K63 cveR4oWs2c3apZ0b3ICVOm4W7SCsZt5RZAuLkxkdv3yEoU0zQG3XVL80chqdgE6YwtwDz0Nd7jKSlq o4DywuvvSqHNmKBpA7KIwvEgt64hEpO/MHSRMTRTHRy1ZTA9rHDunr8EXaNao+6weuNUG1khNVfeMt V1wdN+U0Fy/xJ/mwu0PQtmC5P3m571IbaYcKqiCiKeAngYdvro0eyeF7ptSUvzrRomCbDrX12W01gr Z5/Z1LaQTlUFo99S6mV8ms1NvpEqM3
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
 drivers/iio/adc/ti-ads131e08.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
index 0c2025a22575..7d7a8f0d3ab5 100644
--- a/drivers/iio/adc/ti-ads131e08.c
+++ b/drivers/iio/adc/ti-ads131e08.c
@@ -793,13 +793,6 @@ static void ads131e08_regulator_disable(void *data)
 	regulator_disable(st->vref_reg);
 }
 
-static void ads131e08_clk_disable(void *data)
-{
-	struct ads131e08_state *st = data;
-
-	clk_disable_unprepare(st->adc_clk);
-}
-
 static int ads131e08_probe(struct spi_device *spi)
 {
 	const struct ads131e08_info *info;
@@ -892,21 +885,11 @@ static int ads131e08_probe(struct spi_device *spi)
 		st->vref_reg = NULL;
 	}
 
-	st->adc_clk = devm_clk_get(&spi->dev, "adc-clk");
+	st->adc_clk = devm_clk_get_enabled(&spi->dev, "adc-clk");
 	if (IS_ERR(st->adc_clk))
 		return dev_err_probe(&spi->dev, PTR_ERR(st->adc_clk),
 				     "failed to get the ADC clock\n");
 
-	ret = clk_prepare_enable(st->adc_clk);
-	if (ret) {
-		dev_err(&spi->dev, "failed to prepare/enable the ADC clock\n");
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(&spi->dev, ads131e08_clk_disable, st);
-	if (ret)
-		return ret;
-
 	adc_clk_hz = clk_get_rate(st->adc_clk);
 	if (!adc_clk_hz) {
 		dev_err(&spi->dev, "failed to get the ADC clock rate\n");
-- 
2.36.1

