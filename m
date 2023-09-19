Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5467A6A0F
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjISRuV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbjISRuQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:16 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8A58F
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:50:09 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierF-0006rH-88; Tue, 19 Sep 2023 19:49:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierE-007VXh-0U; Tue, 19 Sep 2023 19:49:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierD-0034Yp-Ny; Tue, 19 Sep 2023 19:49:55 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Kevin Tsai <ktsai@capellamicro.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 36/49] iio: light: cm3605: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:49:18 +0200
Message-Id: <20230919174931.1417681-37-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1877; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=/yWIKyJ9jRwFsUkfzXpsCKY9EzTPCuQCo+LvN8unr7M=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCd8YYoBEAoMxR1PSxK3k+umZdhnE9g6o2l5Xl FLeMnFGbkqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQnfGAAKCRCPgPtYfRL+ TqhhCACVeWbeyh/9VCYifcfsiDbyu2v3bIxTT13yJ+Z7nWBzQVsag5Mh57mdumuh8es4GQvWJrJ ero1g35uRlbZIlS2XOmqAF/W6dbnHhBN2KlklKQF2p7pzKZhxZfIg5d7DL3Hv1dRKmMYAe/eiyQ HA96pH45sVIPmQ9PmQgAUQndn4QjFRBeW7Av9nXRrq++w39IotcZKKqb7L6ONSB+DhvEApo4Qj9 CITbVfqyWJFMV7RlCi27UVVO79HJfxKDFNiFD3k0xFUcNASEl03qJtAoTivIGpqXZs4YX6VP/EL xQpoetsnncmfRIt52pSiuhSVkCVmSnhnpdjzTLL5meoXV8FU
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
 drivers/iio/light/cm3605.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/cm3605.c b/drivers/iio/light/cm3605.c
index e7f0b81b7f5a..22a63a89f289 100644
--- a/drivers/iio/light/cm3605.c
+++ b/drivers/iio/light/cm3605.c
@@ -266,7 +266,7 @@ static int cm3605_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int cm3605_remove(struct platform_device *pdev)
+static void cm3605_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct cm3605 *cm3605 = iio_priv(indio_dev);
@@ -276,8 +276,6 @@ static int cm3605_remove(struct platform_device *pdev)
 	gpiod_set_value_cansleep(cm3605->aset, 0);
 	iio_device_unregister(indio_dev);
 	regulator_disable(cm3605->vdd);
-
-	return 0;
 }
 
 static int cm3605_pm_suspend(struct device *dev)
@@ -320,7 +318,7 @@ static struct platform_driver cm3605_driver = {
 		.pm = pm_sleep_ptr(&cm3605_dev_pm_ops),
 	},
 	.probe = cm3605_probe,
-	.remove = cm3605_remove,
+	.remove_new = cm3605_remove,
 };
 module_platform_driver(cm3605_driver);
 
-- 
2.40.1

