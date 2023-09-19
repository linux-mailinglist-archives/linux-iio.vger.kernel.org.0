Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444EB7A69E7
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjISRuF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjISRuD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:03 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5ED6A6
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:49:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier9-0006W0-Vv; Tue, 19 Sep 2023 19:49:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier9-007VWe-Iw; Tue, 19 Sep 2023 19:49:51 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier9-0034Xj-96; Tue, 19 Sep 2023 19:49:51 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 19/49] iio: adc: rcar-gyroadc: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:49:01 +0200
Message-Id: <20230919174931.1417681-20-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2022; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=itXS2C7x7tk83C9vbcghcJjQXIIRcFIqwVRAGB3BrJw=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlTO+6x71ojHyse8dfW1YGgMNDWY4brzq/vVnMYNR3IW9 jumC7t3MhqzMDByMciKKbLYN67JtKqSi+xc++8yzCBWJpApDFycAjCRtPkcDKsCuzT/H97FODFQ Zf7iJws+BQsxHYz7tz/afdv2kAyO3ad8uPaea6s40pRdJnrmdt/84rtlMnzsN+aoVghqneuzju2 te6mkrOV419+pwfC4a9HHW4+rgqbvnXZ+S0xI4rJVoUtsWfXb584TcxAUnvObKeRMaFXPv7XTjS KX7+6+pcO/8Y7nRn7ODIesKKbWn5cedjzRr3G8KLXj7f20D5XPy6fzxKVXhOzP4urMVD798qHuy 2f+LGfseR4Zebq8e7ggUWtuT9wd9d9TZxkHe5ZXWKhp2zVqTW02DRUKYZQVOZgb8t1Y2jVaeX6B UP39kITlVS6s+d9e6fHvPfGoUPNW7ELTqtvVGXd6Z2QDAA==
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
 drivers/iio/adc/rcar-gyroadc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
index b8972f673c9d..d524f2e8e927 100644
--- a/drivers/iio/adc/rcar-gyroadc.c
+++ b/drivers/iio/adc/rcar-gyroadc.c
@@ -559,7 +559,7 @@ static int rcar_gyroadc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int rcar_gyroadc_remove(struct platform_device *pdev)
+static void rcar_gyroadc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct rcar_gyroadc *priv = iio_priv(indio_dev);
@@ -573,8 +573,6 @@ static int rcar_gyroadc_remove(struct platform_device *pdev)
 	pm_runtime_set_suspended(dev);
 	clk_disable_unprepare(priv->clk);
 	rcar_gyroadc_deinit_supplies(indio_dev);
-
-	return 0;
 }
 
 static int rcar_gyroadc_suspend(struct device *dev)
@@ -603,7 +601,7 @@ static const struct dev_pm_ops rcar_gyroadc_pm_ops = {
 
 static struct platform_driver rcar_gyroadc_driver = {
 	.probe          = rcar_gyroadc_probe,
-	.remove         = rcar_gyroadc_remove,
+	.remove_new     = rcar_gyroadc_remove,
 	.driver         = {
 		.name		= DRIVER_NAME,
 		.of_match_table	= rcar_gyroadc_match,
-- 
2.40.1

