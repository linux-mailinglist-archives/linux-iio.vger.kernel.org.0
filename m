Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1707E7A6A10
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjISRuU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjISRuO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:14 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88666C9
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:50:08 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier9-0006Rs-FF; Tue, 19 Sep 2023 19:49:51 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier8-007VWL-9S; Tue, 19 Sep 2023 19:49:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier7-0034XP-W7; Tue, 19 Sep 2023 19:49:50 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        George Stark <gnstark@sberdevices.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 14/49] iio: adc: meson_saradc: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:48:56 +0200
Message-Id: <20230919174931.1417681-15-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1849; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ZkHR8CcCKeoe8xpI5iFY6J8XzVrFo+5T9mEj+BOCCRc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCd7/5JGdT0Pmt5nBcw4BnW+XEh9vgD4K29Z5b xfXIBzNO1eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQne/wAKCRCPgPtYfRL+ TtyyB/9KGPYvM1mpZrWC77cLxlyXUUW16f9paXIMqOTsdqN39ku0SKFMXl5GdBt6GF637YrNRh+ 4/ZziIgwi7gR+93R8mb4L54W1xfR1Y5mB2mvxa/pNKf2pgDBFq6GCdvmqgry+4Z9N9AoHqRSt9p bZ5RJXyZ2jjOTmJqm1Hqicgj+b4RqyzoYth6L4+No+gL8J1k1W/IoxDJQKB0qbLSD26EHGzzSJ8 SfVRQsvSeWNv1tyWvb7jdleAKqoiQBGYadXYx7rni1LtfAJ07wJIfeHeHYfvVsqfP4pYDs0b5dI j6zrkn00M1RW/dA07rttTGsnJYcFlVOFjhuB5bMUvOGC3BBv
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
 drivers/iio/adc/meson_saradc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 320e3e7e3d4d..a40986fb285c 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -1437,15 +1437,13 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int meson_sar_adc_remove(struct platform_device *pdev)
+static void meson_sar_adc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 
 	iio_device_unregister(indio_dev);
 
 	meson_sar_adc_hw_disable(indio_dev);
-
-	return 0;
 }
 
 static int meson_sar_adc_suspend(struct device *dev)
@@ -1480,7 +1478,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(meson_sar_adc_pm_ops,
 
 static struct platform_driver meson_sar_adc_driver = {
 	.probe		= meson_sar_adc_probe,
-	.remove		= meson_sar_adc_remove,
+	.remove_new	= meson_sar_adc_remove,
 	.driver		= {
 		.name	= "meson-saradc",
 		.of_match_table = meson_sar_adc_of_match,
-- 
2.40.1

