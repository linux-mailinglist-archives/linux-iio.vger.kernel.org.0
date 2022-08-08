Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D8158CF53
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 22:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244340AbiHHUsE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 16:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238453AbiHHUsD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 16:48:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D9D9585
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 13:48:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9fE-000467-8w; Mon, 08 Aug 2022 22:47:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9f7-002ZYw-DA; Mon, 08 Aug 2022 22:47:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9f9-00ARBK-1Q; Mon, 08 Aug 2022 22:47:47 +0200
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
Subject: [PATCH 04/13] iio: adc: ad9467: Benefit from devm_clk_get_prepared() to simplify
Date:   Mon,  8 Aug 2022 22:47:31 +0200
Message-Id: <20220808204740.307667-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
References: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1820; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=jTSw2x0IXgxT5HkXNnQuZObGveYNYe4KOq4/JJi/gq4=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi8XZGTQTcvwL71I2tLA+EIKudTdFLqj60Y3q9VFrO pulc07yJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYvF2RgAKCRDB/BR4rcrsCZDFB/ 9EGUK18i6xWii9SRWiVt4MymwMoo4IW6wR7krxYT85Fwk5tVSg3tOK/sFBRCshXNfLCjHHtU9DZYEK gPZiIIFDV4tbNpXFSAcU2W7Q2gj9DHSfiQlOfrRRKG05GYApxQR6vwG66Aui3r2FppbmIvGhALJg4u uPLF7saeE08xwKRBruysrj0z2Ws0F9p38FPSiSwmoBTVG+oWISl+PxsTe4VYktBnug3QJaqQQ5UYLy 6/XWmp4gPJrqaTm4kI2SBN2sOoGkqYQtBktyuq3IUZv/exINxdIBHdMWM/+J1jeAWD3+U1aM+vFsrJ PsQtrS0uPd/yOdiUAp7gxxBntUCn2m
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

Make use of devm_clk_get_prepared() to replace some code that effectively
open codes this new function.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/adc/ingenic-adc.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index 2b3912c6ca6b..b6433bcd53f5 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -732,11 +732,6 @@ static int ingenic_adc_of_xlate(struct iio_dev *iio_dev,
 	return -EINVAL;
 }
 
-static void ingenic_adc_clk_cleanup(void *data)
-{
-	clk_unprepare(data);
-}
-
 static const struct iio_info ingenic_adc_info = {
 	.write_raw = ingenic_adc_write_raw,
 	.read_raw = ingenic_adc_read_raw,
@@ -856,13 +851,13 @@ static int ingenic_adc_probe(struct platform_device *pdev)
 	if (IS_ERR(adc->base))
 		return PTR_ERR(adc->base);
 
-	adc->clk = devm_clk_get(dev, "adc");
+	adc->clk = devm_clk_get_prepared(dev, "adc");
 	if (IS_ERR(adc->clk)) {
 		dev_err(dev, "Unable to get clock\n");
 		return PTR_ERR(adc->clk);
 	}
 
-	ret = clk_prepare_enable(adc->clk);
+	ret = clk_enable(adc->clk);
 	if (ret) {
 		dev_err(dev, "Failed to enable clock\n");
 		return ret;
@@ -891,12 +886,6 @@ static int ingenic_adc_probe(struct platform_device *pdev)
 	usleep_range(2000, 3000); /* Must wait at least 2ms. */
 	clk_disable(adc->clk);
 
-	ret = devm_add_action_or_reset(dev, ingenic_adc_clk_cleanup, adc->clk);
-	if (ret) {
-		dev_err(dev, "Unable to add action\n");
-		return ret;
-	}
-
 	iio_dev->name = "jz-adc";
 	iio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
 	iio_dev->setup_ops = &ingenic_buffer_setup_ops;
-- 
2.36.1

