Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5953A58CF5C
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 22:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244222AbiHHUsL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 16:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244290AbiHHUsE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 16:48:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3017AE6F
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 13:48:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9fE-000465-8x; Mon, 08 Aug 2022 22:47:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9f6-002ZYp-UH; Mon, 08 Aug 2022 22:47:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9f8-00ARBE-Kc; Mon, 08 Aug 2022 22:47:46 +0200
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
Subject: [PATCH 02/13] iio: adc: ad7768-1: Benefit from devm_clk_get_enabled() to simplify
Date:   Mon,  8 Aug 2022 22:47:29 +0200
Message-Id: <20220808204740.307667-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
References: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1377; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ypZQ7kzeyhQi9gyCu7KCqyjpK3NdG+0yeMXcG+9AxOA=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi8XY+DUHjWD8O9253770FW7fkqF5Cb3x+Kt9X/t3X 7JECYE2JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYvF2PgAKCRDB/BR4rcrsCXFfCA CU8uBEXgX6CbpHJ032yYwf+pLAis3hHrOFPx5epPbUBWuAMI9wlE6YdHJ4CyFsEGMPzJHdIdu/rdrc SEn6oA1yn5Rtwdr0oEUD+ENDN0dVCKfl3LUUSpngzYUX7Vpf/2E5btigvKy/lZ7BCa7+MZya92qhcb scHPdbGA3w0tcIrDdYduiCBh5RqEvzTybglH9LRbzDOPZyRiA/87UKM4Fx8ty6KI+MuXuKHNc3AlG1 Naz9RruLdt2j44bFuN/6QNg1BNjm4XiEvkJVKWuYcIzJ6hVL80kRxxr0y2gVoa+mEOxT1oFUhnNmZA XZw5MwItrAGZA4jXmmyMsMiLJggg3d
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
 drivers/iio/adc/ad7768-1.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index aa42ba759fa1..8ae34ed8fabd 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -539,13 +539,6 @@ static void ad7768_regulator_disable(void *data)
 	regulator_disable(st->vref);
 }
 
-static void ad7768_clk_disable(void *data)
-{
-	struct ad7768_state *st = data;
-
-	clk_disable_unprepare(st->mclk);
-}
-
 static int ad7768_set_channel_label(struct iio_dev *indio_dev,
 						int num_channels)
 {
@@ -600,18 +593,10 @@ static int ad7768_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	st->mclk = devm_clk_get(&spi->dev, "mclk");
+	st->mclk = devm_clk_get_enabled(&spi->dev, "mclk");
 	if (IS_ERR(st->mclk))
 		return PTR_ERR(st->mclk);
 
-	ret = clk_prepare_enable(st->mclk);
-	if (ret < 0)
-		return ret;
-
-	ret = devm_add_action_or_reset(&spi->dev, ad7768_clk_disable, st);
-	if (ret)
-		return ret;
-
 	st->mclk_freq = clk_get_rate(st->mclk);
 
 	mutex_init(&st->lock);
-- 
2.36.1

