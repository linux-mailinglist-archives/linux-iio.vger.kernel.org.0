Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EB458CF58
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 22:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243206AbiHHUsH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 16:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244118AbiHHUsE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 16:48:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32EEB1C6
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 13:48:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9fE-000469-8v; Mon, 08 Aug 2022 22:47:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9f7-002ZZ6-Ti; Mon, 08 Aug 2022 22:47:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9f9-00ARBO-88; Mon, 08 Aug 2022 22:47:47 +0200
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
Subject: [PATCH 05/13] iio: adc: lpc18xx: Benefit from devm_clk_get_enabled() to simplify
Date:   Mon,  8 Aug 2022 22:47:32 +0200
Message-Id: <20220808204740.307667-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
References: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1651; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=SRf2ny64RNoTKajeXyg5Fvb5LxqoYU5FaSSBnFbR2s0=; b=owEBbAGT/pANAwAKAcH8FHityuwJAcsmYgBi8XZJNCbpIak+JDXcLoZAtqQqcVMhjXTASFPwnLcH owCugRWJATIEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYvF2SQAKCRDB/BR4rcrsCZVIB/ j7UdA6Wm9swC1K7bwrC3EzhY+/fjDyn3JkTiDCcxa2trRW58fWoLTjW4lMCS6SWa2iWBTQur5h4oZe ALSpZQnBOQXRpu+44fA4uahOQQ9F1IgJmv0DO1abb3MLzAsGA3hD5nXpy62w9vWEAEBmR1qCMz+AMg gHI7Z7Sp7zFGqQ04cn3ggjvD3fSjeXOb1CT5azHLrUAt9UorM0vm31DYatFpHH0iz89aEQwEqbstEA s9us+tBRxiEytJVmrzc7Gmk7yQS36sKORMJ7Xjh5vHEC9JZkGxQVSmNitaW38j60WWxHYhdrjSEeBW +DZPzBao/flMa6lJ+sO0m0MtFSTXU=
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
 drivers/iio/adc/lpc18xx_adc.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/iio/adc/lpc18xx_adc.c b/drivers/iio/adc/lpc18xx_adc.c
index ae9c9384f23e..8bbc18aaa474 100644
--- a/drivers/iio/adc/lpc18xx_adc.c
+++ b/drivers/iio/adc/lpc18xx_adc.c
@@ -122,11 +122,6 @@ static void lpc18xx_clear_cr_reg(void *data)
 	writel(0, adc->base + LPC18XX_ADC_CR);
 }
 
-static void lpc18xx_clk_disable(void *clk)
-{
-	clk_disable_unprepare(clk);
-}
-
 static void lpc18xx_regulator_disable(void *vref)
 {
 	regulator_disable(vref);
@@ -152,7 +147,7 @@ static int lpc18xx_adc_probe(struct platform_device *pdev)
 	if (IS_ERR(adc->base))
 		return PTR_ERR(adc->base);
 
-	adc->clk = devm_clk_get(&pdev->dev, NULL);
+	adc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(adc->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(adc->clk),
 				     "error getting clock\n");
@@ -178,17 +173,6 @@ static int lpc18xx_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(adc->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to enable clock\n");
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(&pdev->dev, lpc18xx_clk_disable,
-				       adc->clk);
-	if (ret)
-		return ret;
-
 	rate = clk_get_rate(adc->clk);
 	clkdiv = DIV_ROUND_UP(rate, LPC18XX_ADC_CLK_TARGET);
 
-- 
2.36.1

