Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE6D7A6A1D
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjISRuY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbjISRuR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:17 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125CC12E
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:50:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierC-0006bL-OO; Tue, 19 Sep 2023 19:49:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierA-007VWy-SX; Tue, 19 Sep 2023 19:49:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierA-0034Y3-Ic; Tue, 19 Sep 2023 19:49:52 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Mark Brown <broonie@kernel.org>,
        Ido Schimmel <idosch@nvidia.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@pengutronix.de
Subject: [PATCH 24/49] iio: adc: sun4i-gpadc-iio: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:49:06 +0200
Message-Id: <20230919174931.1417681-25-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2017; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=vKYM85Enz4pou5ekT5Ktb0dJDDb+Kt9AqUIC5ww0puw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCd8K0HyN/wX2GvrzR04r9GsHvAGR/PqKMmxWK HYc6NA8DLGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQnfCgAKCRCPgPtYfRL+ Tqf3CACFmE7ZSKV6Qeoh7ezG709dzwNKskftcv+6evfD/fT6Luyn3hbHUJYohe4o98YkpHIaU2V wNTc3vCY1oxxxzKuQapJ4g3+mcBzpvqEDHSS+9BrO4iAxFA2z1AuYCTQXAAoLBtMk6VThfqSwi6 L0bA9txo2JVp5gg30IhWaKExatCClBQPHJPuK7fBmkSPxD22OHJWNO4l2oQulFcKWNox/zAy12Z yS0VXaA9DmlpISdc93LiwvqV7tdJrM/Q6r9bRqyEw3akt+2vRy8GJ0M4n3s11nXfPTuZ6ZS96hj U2RCMSfBZW3WcCrhl/w5uemQXclI4SICL5ei3FmK25cEu+3B
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
 drivers/iio/adc/sun4i-gpadc-iio.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 25bba96367a8..100ecced5fc1 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -669,7 +669,7 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sun4i_gpadc_remove(struct platform_device *pdev)
+static void sun4i_gpadc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
@@ -678,12 +678,10 @@ static int sun4i_gpadc_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 
 	if (!IS_ENABLED(CONFIG_THERMAL_OF))
-		return 0;
+		return;
 
 	if (!info->no_irq)
 		iio_map_array_unregister(indio_dev);
-
-	return 0;
 }
 
 static const struct platform_device_id sun4i_gpadc_id[] = {
@@ -702,7 +700,7 @@ static struct platform_driver sun4i_gpadc_driver = {
 	},
 	.id_table = sun4i_gpadc_id,
 	.probe = sun4i_gpadc_probe,
-	.remove = sun4i_gpadc_remove,
+	.remove_new = sun4i_gpadc_remove,
 };
 MODULE_DEVICE_TABLE(of, sun4i_gpadc_of_id);
 
-- 
2.40.1

