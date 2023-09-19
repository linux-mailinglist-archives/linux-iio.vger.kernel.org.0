Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A267A69F2
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjISRuH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjISRuE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:04 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0A492
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:49:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier8-0006L7-8G; Tue, 19 Sep 2023 19:49:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier6-007VW0-Ux; Tue, 19 Sep 2023 19:49:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier6-0034X5-Ld; Tue, 19 Sep 2023 19:49:48 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 09/49] iio: adc: exynos: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:48:51 +0200
Message-Id: <20230919174931.1417681-10-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1968; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=BsqfNTwJdlz+LevSIl7H41XOmHPIvO8Y6ld7+BIbnfM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCd75eK5dSkdZ64Kwlc4XhWqdejgJjU3KJzw7s VevhTO5J8aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQne+QAKCRCPgPtYfRL+ TkemB/9WOntbKVIxy02vMHYgGFx4BBV2yA2oadceg7P5RHZyDMRUl3T1zmVYifTcwrtpTAijNCv k/pSjCE0BAtKms0xR802bAPsr/HbyiqWp8uRwU1FBjrhw1Rf7ZBM1EFrM3VK0zZ3WVS7I3o236Q iSS6xoK0ypniyYLExhLnE+3075SkjwUKitPptEdDalW/YfTICtsq0JsuGxqAkjA+9tdp6WGBvKI Xa55M9BzTmzo/W+HDh/V6XPUGgSE20Lr9WSgVENhkoA0ngbPGNtkbTUEs3IYQ+Zbn+Q4auO1BYg U1kU5t93Zrn3I/zT8xopoFkSQC/jo2jGdV1sS/HNiXUpSwNI
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
 drivers/iio/adc/exynos_adc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index cff1ba57fb16..eb7a2dd59517 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -946,7 +946,7 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int exynos_adc_remove(struct platform_device *pdev)
+static void exynos_adc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct exynos_adc *info = iio_priv(indio_dev);
@@ -964,8 +964,6 @@ static int exynos_adc_remove(struct platform_device *pdev)
 	exynos_adc_disable_clk(info);
 	exynos_adc_unprepare_clk(info);
 	regulator_disable(info->vdd);
-
-	return 0;
 }
 
 static int exynos_adc_suspend(struct device *dev)
@@ -1006,7 +1004,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(exynos_adc_pm_ops, exynos_adc_suspend,
 
 static struct platform_driver exynos_adc_driver = {
 	.probe		= exynos_adc_probe,
-	.remove		= exynos_adc_remove,
+	.remove_new	= exynos_adc_remove,
 	.driver		= {
 		.name	= "exynos-adc",
 		.of_match_table = exynos_adc_match,
-- 
2.40.1

