Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC677A69EA
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjISRuG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjISRuE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:04 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19170BD
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:49:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier7-0006Kb-7N; Tue, 19 Sep 2023 19:49:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier6-007VVx-Nl; Tue, 19 Sep 2023 19:49:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier6-0034X1-E4; Tue, 19 Sep 2023 19:49:48 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 08/49] iio: adc: ep93xx: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:48:50 +0200
Message-Id: <20230919174931.1417681-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1807; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=XKIy+ICWzna8L+cSganw9EvqBPBW1EZCKmut/BLDRFE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCd746snvDh7PPEjPC4mMaCZyzFl/1U11JzUvL mybOM1Z1H+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQne+AAKCRCPgPtYfRL+ Tr1fB/9TxY066IOKCo42q0x0+vMFrjyIqWRDkOFuDesA4a4DHEWbI/my16it4pS5UyuaFqCuyAW QlBKE/zgtr9nm+MWmHD7z2p+kPlaK9RDlsYrYOYDiFEyW3KVBHYnt4OcooDT56ub5pJ+c1+VZkr d9sxnT6dOXxd0rpY9QF7WncGvHbYhaXauGLIDV395ZrcVd6eTe0qoCKftkPWXX6G6Z++lCnIWZ5 qnSD6K2KmwXgHHmeq4Ct4xX1aTZyexZ2npZBlSzAtFgI7J+7Vfu8OUqGdTJZ1WN1sdPTo+OIwoa NO/4W58jP2DLRTFH3Uc0aO2oOfPlaf02nTeBm/DawhU2Yvpo
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
 drivers/iio/adc/ep93xx_adc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ep93xx_adc.c b/drivers/iio/adc/ep93xx_adc.c
index a35e6cead67d..971942ce4c66 100644
--- a/drivers/iio/adc/ep93xx_adc.c
+++ b/drivers/iio/adc/ep93xx_adc.c
@@ -217,15 +217,13 @@ static int ep93xx_adc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ep93xx_adc_remove(struct platform_device *pdev)
+static void ep93xx_adc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *iiodev = platform_get_drvdata(pdev);
 	struct ep93xx_adc_priv *priv = iio_priv(iiodev);
 
 	iio_device_unregister(iiodev);
 	clk_disable_unprepare(priv->clk);
-
-	return 0;
 }
 
 static const struct of_device_id ep93xx_adc_of_ids[] = {
@@ -240,7 +238,7 @@ static struct platform_driver ep93xx_adc_driver = {
 		.of_match_table = ep93xx_adc_of_ids,
 	},
 	.probe = ep93xx_adc_probe,
-	.remove = ep93xx_adc_remove,
+	.remove_new = ep93xx_adc_remove,
 };
 module_platform_driver(ep93xx_adc_driver);
 
-- 
2.40.1

