Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4727A69FA
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjISRuK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjISRuG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:06 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE44D92
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:50:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierD-0006gT-3G; Tue, 19 Sep 2023 19:49:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierB-007VXA-Gj; Tue, 19 Sep 2023 19:49:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierB-0034YF-7j; Tue, 19 Sep 2023 19:49:53 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 27/49] iio: adc: twl6030-gpadc: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:49:09 +0200
Message-Id: <20230919174931.1417681-28-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1919; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=+N5SSJNw+D7KWJpJpBrtIXTLZ0ZmVptkd7O11WsNrvM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCd8O9BWsS1U7sS7fKb+6kZX6G4jABZ7c4oH/G wOPcn10LlqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQnfDgAKCRCPgPtYfRL+ TgDFB/9SVdKZ3lFPlmZiXKNcsQm4l1teLWofbaeCBbKhBkylCwQigThs/V69ObqJWTVGXgv7jJH KM2/HoJhtNSIHDevadG6mHqhHvwKQG0z2sS46HQ78ZxzxM/BLobLvFuH1HuOlBYIqK65wB0ViCq /iOm3aER+6I8Ad/8FZh3L0CIBzsZqe6tdHL1iYiNEwPLTsro2/a674bX+lV3vF+SeUyRklaAxJY yFyUvY9s8SyskxS0PhHJN7x2xFy12ntOdBjtk46TN1bqgrBh0GqoI9KEfH0Mtow0UlJ30UbHth1 M5abNii7RcvKNK8w3Bu5FaBsJ6fo3TQlQUvTh4UV/db4ER0y
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
 drivers/iio/adc/twl6030-gpadc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index 32873fb5f367..224e9cb5e147 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -968,14 +968,12 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
 	return iio_device_register(indio_dev);
 }
 
-static int twl6030_gpadc_remove(struct platform_device *pdev)
+static void twl6030_gpadc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 
 	twl6030_gpadc_disable_irq(TWL6030_GPADC_RT_SW1_EOC_MASK);
 	iio_device_unregister(indio_dev);
-
-	return 0;
 }
 
 static int twl6030_gpadc_suspend(struct device *pdev)
@@ -1007,7 +1005,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(twl6030_gpadc_pm_ops, twl6030_gpadc_suspend,
 
 static struct platform_driver twl6030_gpadc_driver = {
 	.probe		= twl6030_gpadc_probe,
-	.remove		= twl6030_gpadc_remove,
+	.remove_new	= twl6030_gpadc_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.pm	= pm_sleep_ptr(&twl6030_gpadc_pm_ops),
-- 
2.40.1

