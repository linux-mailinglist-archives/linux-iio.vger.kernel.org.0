Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8134558CF59
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 22:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244070AbiHHUsI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 16:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243020AbiHHUsD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 16:48:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D5F63E9
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 13:48:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9fE-00046B-8y; Mon, 08 Aug 2022 22:47:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9f8-002ZZC-DH; Mon, 08 Aug 2022 22:47:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9f9-00ARBa-Q5; Mon, 08 Aug 2022 22:47:47 +0200
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
Subject: [PATCH 08/13] iio: adc: xilinx-ams: Benefit from devm_clk_get_enabled() to simplify
Date:   Mon,  8 Aug 2022 22:47:35 +0200
Message-Id: <20220808204740.307667-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
References: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1466; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=kCTsFzuh4WVPh5RbzyDUFC4MhsZm8EL94yZCRKD1Ops=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi8XZVnio5nuatyyaSCtSppb9kVW6/44c8HE3foEfR aQbRIAyJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYvF2VQAKCRDB/BR4rcrsCfj5B/ 91FC7bZvhybRYPXtWvrbt97H86COCaASuc0Nt/EqONvBpje+YbaOU6jrjGi+HnqAHa6AQl6t4WGcIS C1EFlCbzQCS9kZgH4MWpyIl/eOxMmFdv95FYw4X6DRBQPRykqW7ev3RvKDZpSDlCAnYWeVultqOw5q OIVyIJEQnfhgIonoxPLqUn3AUfpepDca7rXFb5n2d7GXAB9q1bbR7tuM060+xC5t44CMmqHFUR0bPD WP95mwktWBwiSwTYRKyDL2dLT+s+GOXMlGc/99kRq2rdqIrM8fJZD4c8jJ5weNTqSuDauXresn6CHc fZfjpv5yMNuVV+zRJlAin1EDWw2sGZ
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
 drivers/iio/adc/xilinx-ams.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index a55396c1f8b2..2cab7f0c0633 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -1351,11 +1351,6 @@ static const struct of_device_id ams_of_match_table[] = {
 };
 MODULE_DEVICE_TABLE(of, ams_of_match_table);
 
-static void ams_clk_disable_unprepare(void *data)
-{
-	clk_disable_unprepare(data);
-}
-
 static int ams_probe(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev;
@@ -1380,18 +1375,10 @@ static int ams_probe(struct platform_device *pdev)
 	if (IS_ERR(ams->base))
 		return PTR_ERR(ams->base);
 
-	ams->clk = devm_clk_get(&pdev->dev, NULL);
+	ams->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(ams->clk))
 		return PTR_ERR(ams->clk);
 
-	ret = clk_prepare_enable(ams->clk);
-	if (ret < 0)
-		return ret;
-
-	ret = devm_add_action_or_reset(&pdev->dev, ams_clk_disable_unprepare, ams->clk);
-	if (ret < 0)
-		return ret;
-
 	ret = devm_delayed_work_autocancel(&pdev->dev, &ams->ams_unmask_work,
 					   ams_unmask_worker);
 	if (ret < 0)
-- 
2.36.1

