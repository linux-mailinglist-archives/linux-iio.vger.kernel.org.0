Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A1058CF55
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 22:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238305AbiHHUsF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 16:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237173AbiHHUsD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 16:48:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C4763E2
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 13:48:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9fE-000468-8x; Mon, 08 Aug 2022 22:47:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9f7-002ZZ3-Qb; Mon, 08 Aug 2022 22:47:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9f9-00ARBS-Eq; Mon, 08 Aug 2022 22:47:47 +0200
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
Subject: [PATCH 06/13] iio: adc: rockchip_saradc: Benefit from devm_clk_get_enabled() to simplify
Date:   Mon,  8 Aug 2022 22:47:33 +0200
Message-Id: <20220808204740.307667-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
References: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2594; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=m2J91koXuWWTdhWzR71C1YnaNiDGpCKmOazRviw4QB4=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi8XZNOLiSASZN3QkwAJTy0evbVnco5pJweqDhhU9u nQxqZFuJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYvF2TQAKCRDB/BR4rcrsCWXlB/ 92YgDSgsr6/tZHHRYqHV18IuCyQ48OxlDycsQ3o7n9j48HlGIa4DuLOsYClwrhnvg9PgZrrcUhKXQD EysY2H5mViTUU3zodoJzFIwPn4hQN3wN0siZ6t1AcoeMoN2iQPRf97LALc4M58pcwbfqL4nWDhVobI aDvyaUL9k/Pvyaret1+Ly/oHH+sZqYZAVZFPqVxHZNHqV9H5BBYFbDytDYycOsyH71FXfFgnotATQx MihjUDKrP4khsxTamgO89cNBVGddacjSVncFXK2M9ILibNOY+wPqiZw2+BilR7Amy33FrDTViO7DSQ EN98WbSHmAh/YEanvz5QG1xdKe1g4h
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
 drivers/iio/adc/rockchip_saradc.c | 44 ++-----------------------------
 1 file changed, 2 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index b87ea7148b58..db1190faa223 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -233,20 +233,6 @@ static void rockchip_saradc_reset_controller(struct reset_control *reset)
 	reset_control_deassert(reset);
 }
 
-static void rockchip_saradc_clk_disable(void *data)
-{
-	struct rockchip_saradc *info = data;
-
-	clk_disable_unprepare(info->clk);
-}
-
-static void rockchip_saradc_pclk_disable(void *data)
-{
-	struct rockchip_saradc *info = data;
-
-	clk_disable_unprepare(info->pclk);
-}
-
 static void rockchip_saradc_regulator_disable(void *data)
 {
 	struct rockchip_saradc *info = data;
@@ -380,12 +366,12 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	info->pclk = devm_clk_get(&pdev->dev, "apb_pclk");
+	info->pclk = devm_clk_get_enabled(&pdev->dev, "apb_pclk");
 	if (IS_ERR(info->pclk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(info->pclk),
 				     "failed to get pclk\n");
 
-	info->clk = devm_clk_get(&pdev->dev, "saradc");
+	info->clk = devm_clk_get_enabled(&pdev->dev, "saradc");
 	if (IS_ERR(info->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(info->clk),
 				     "failed to get adc clock\n");
@@ -427,32 +413,6 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 
 	info->uv_vref = ret;
 
-	ret = clk_prepare_enable(info->pclk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to enable pclk\n");
-		return ret;
-	}
-	ret = devm_add_action_or_reset(&pdev->dev,
-				       rockchip_saradc_pclk_disable, info);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register devm action, %d\n",
-			ret);
-		return ret;
-	}
-
-	ret = clk_prepare_enable(info->clk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to enable converter clock\n");
-		return ret;
-	}
-	ret = devm_add_action_or_reset(&pdev->dev,
-				       rockchip_saradc_clk_disable, info);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register devm action, %d\n",
-			ret);
-		return ret;
-	}
-
 	platform_set_drvdata(pdev, indio_dev);
 
 	indio_dev->name = dev_name(&pdev->dev);
-- 
2.36.1

