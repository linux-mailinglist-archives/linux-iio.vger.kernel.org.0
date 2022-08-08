Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3085B58CF5D
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 22:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244285AbiHHUsN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 16:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244329AbiHHUsE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 16:48:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CC8B1DD
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 13:48:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9fE-000464-8w; Mon, 08 Aug 2022 22:47:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9f6-002ZYl-OQ; Mon, 08 Aug 2022 22:47:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9f8-00ARBB-Es; Mon, 08 Aug 2022 22:47:46 +0200
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
Subject: [PATCH 01/13] iio: adc: ad7124: Benefit from devm_clk_get_enabled() to simplify
Date:   Mon,  8 Aug 2022 22:47:28 +0200
Message-Id: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=6MhAZxMoftj9x+FzMFLhO/Kc6uT7FQ38eSRlrngBJmo=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi8XY6jfxJUlrQ+bVGqpuw9vmGHDDS7VgPkSr/1L0U vghl0UqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYvF2OgAKCRDB/BR4rcrsCSbhB/ 9fBl6/YeqehD8NPK1ZeJyxhZhshfjPk+qh2sxekH00BOWCwM1T3EY/LLuE5b+YFntSen4GEDcIALP4 pXxcg8iJRVJ0BgLRre4aWY3qdY7ZicvKPDAc58Oo4EZAQsHxGbQ/7yolbtPbk8n7cJtUTi6BEDosaA mBdUCdAhPbkrx7JDzZqXce8Y5CR3oDVV8ekSf9zBWX3VL/wOFfevAujqoHNNXGT3DyK09yrPHGCUiO 7HWkRfhrOhRjhbbGn9ypvvojdojr2ak8f5i+z8tyaSeykwjzTH11WMFz+Kq9wU+o8XSPJmzdG6mrE3 fvvEmIITTCNNCn/bKY4uecxRxs2YPi
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
 drivers/iio/adc/ad7124.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index c5b785d8b241..4088786e1026 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -936,11 +936,6 @@ static void ad7124_reg_disable(void *r)
 	regulator_disable(r);
 }
 
-static void ad7124_clk_disable(void *c)
-{
-	clk_disable_unprepare(c);
-}
-
 static int ad7124_probe(struct spi_device *spi)
 {
 	const struct ad7124_chip_info *info;
@@ -993,18 +988,10 @@ static int ad7124_probe(struct spi_device *spi)
 			return ret;
 	}
 
-	st->mclk = devm_clk_get(&spi->dev, "mclk");
+	st->mclk = devm_clk_get_enabled(&spi->dev, "mclk");
 	if (IS_ERR(st->mclk))
 		return PTR_ERR(st->mclk);
 
-	ret = clk_prepare_enable(st->mclk);
-	if (ret < 0)
-		return ret;
-
-	ret = devm_add_action_or_reset(&spi->dev, ad7124_clk_disable, st->mclk);
-	if (ret)
-		return ret;
-
 	ret = ad7124_soft_reset(st);
 	if (ret < 0)
 		return ret;

base-commit: 8b3d743fc9e2542822826890b482afabf0e7522a
-- 
2.36.1

