Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D717A69E3
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjISRuD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjISRuA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:00 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BADC92
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:49:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier5-0006Jl-Mw; Tue, 19 Sep 2023 19:49:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier5-007VVb-4I; Tue, 19 Sep 2023 19:49:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier4-0034WQ-RD; Tue, 19 Sep 2023 19:49:46 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 02/49] iio: adc: ab8500-gpadc: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:48:44 +0200
Message-Id: <20230919174931.1417681-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1996; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=8Kf9UvPjihuqCXJ3bJi5qzhcHJvDA9ZRlZhcXbymNC8=; b=owEBbAGT/pANAwAKAY+A+1h9Ev5OAcsmYgBlCd7xpJZzLEqA/YbTr5b62mwkJDt4IGtJcjvJq q/wy5VhS7mJATIEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQne8QAKCRCPgPtYfRL+ TtEVB/itmCTGxyXx1wfEcalu5fWQdSDHm1w+ET7TXIjiFbHcWNWG21kSQhH5nC3VnPWNIJzfR9n GpnIs8HDoWa980eFkb57wC2MK0znBzDMMhYwFOg0MzgIqGD/rJm85e6n/NZ68l114PYazLO+cTj JvgtlKJTcY78DjbIpLR3exG7rMQezR8lEO0MYe+hu6gYnKdbOLwNJSlxn7/N5X6h1XQdr4+o4ZH BxsshoQJMpR7lgnQ0TKuHYMJ/OZG5fXcxMTlu5KlyM9l9AStBT+NhSvLSM1IiCMLwlb7aQJHX3G H3Dman/1y+KGvguS7/XMI/EGELfA2e44eerE7n+TIEQE5ww=
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
 drivers/iio/adc/ab8500-gpadc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ab8500-gpadc.c b/drivers/iio/adc/ab8500-gpadc.c
index 3b1bdd0b531d..80645fee79a4 100644
--- a/drivers/iio/adc/ab8500-gpadc.c
+++ b/drivers/iio/adc/ab8500-gpadc.c
@@ -1179,7 +1179,7 @@ static int ab8500_gpadc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ab8500_gpadc_remove(struct platform_device *pdev)
+static void ab8500_gpadc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct ab8500_gpadc *gpadc = iio_priv(indio_dev);
@@ -1188,8 +1188,6 @@ static int ab8500_gpadc_remove(struct platform_device *pdev)
 	pm_runtime_put_noidle(gpadc->dev);
 	pm_runtime_disable(gpadc->dev);
 	regulator_disable(gpadc->vddadc);
-
-	return 0;
 }
 
 static DEFINE_RUNTIME_DEV_PM_OPS(ab8500_gpadc_pm_ops,
@@ -1198,7 +1196,7 @@ static DEFINE_RUNTIME_DEV_PM_OPS(ab8500_gpadc_pm_ops,
 
 static struct platform_driver ab8500_gpadc_driver = {
 	.probe = ab8500_gpadc_probe,
-	.remove = ab8500_gpadc_remove,
+	.remove_new = ab8500_gpadc_remove,
 	.driver = {
 		.name = "ab8500-gpadc",
 		.pm = pm_ptr(&ab8500_gpadc_pm_ops),
-- 
2.40.1

