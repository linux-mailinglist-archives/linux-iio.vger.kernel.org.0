Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DD47A69E8
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjISRuF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjISRuD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:03 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2664995
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:49:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier6-0006KF-Jg; Tue, 19 Sep 2023 19:49:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier5-007VVn-UO; Tue, 19 Sep 2023 19:49:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier5-0034Wp-L3; Tue, 19 Sep 2023 19:49:47 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, Chen-Yu Tsai <wens@csie.org>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 05/49] iio: adc: axp20x: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:48:47 +0200
Message-Id: <20230919174931.1417681-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1865; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=1AMXcOV3/izrLbEGkEZM8kOp4GOpTwpeDeJvMgOowso=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCd710ZuGAA6QuN5bZ6FcxADjNznmUO5qcRjhU EekHkrWhwGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQne9QAKCRCPgPtYfRL+ Tn7YB/92xsrJmb9dpyxkm0/3ituAKdLjTUXt8SCxbmuCCw7Hgl+NjYDU6hIaVPjXAW1N2h7VTRU i6VYJbVaiKWg2Ncblr7B0Z6Xcw+R4b/1gFYvtvDJn8kIybbl8BnKNUP1ehD5i1ywVT58PeliUB+ IM0RzTY8mnQJZ1VDHoiiSB5Z8rtjfVL/kdEgqr7/9OjO6NE+M6e7kV+c3jxvxdfcOCD15QzbKHj 54pT7Hkgn4PPq7GXStiAjWnO6AdCcShfdAy2fOjuuErwmCusOxBabWekVi9Nk8p4U0RBCG2+Wbr i6R7uj2vqA4kaBn2FkQs2Cku/bfLHao9jRNTYBP3qJRj3Ln6
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.
To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new() which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/adc/axp20x_adc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index 75bda94dbce1..d6c51b0f48e3 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -745,7 +745,7 @@ static int axp20x_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int axp20x_remove(struct platform_device *pdev)
+static void axp20x_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct axp20x_adc_iio *info = iio_priv(indio_dev);
@@ -757,8 +757,6 @@ static int axp20x_remove(struct platform_device *pdev)
 
 	if (info->data->adc_en2_mask)
 		regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
-
-	return 0;
 }
 
 static struct platform_driver axp20x_adc_driver = {
@@ -768,7 +766,7 @@ static struct platform_driver axp20x_adc_driver = {
 	},
 	.id_table = axp20x_adc_id_match,
 	.probe = axp20x_probe,
-	.remove = axp20x_remove,
+	.remove_new = axp20x_remove,
 };
 
 module_platform_driver(axp20x_adc_driver);
-- 
2.40.1

