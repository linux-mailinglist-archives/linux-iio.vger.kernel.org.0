Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770707A6A0C
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjISRuP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbjISRuI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:08 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E3C92
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:50:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierF-0006u7-Uw; Tue, 19 Sep 2023 19:49:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierE-007VXv-RO; Tue, 19 Sep 2023 19:49:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierE-0034Z1-F2; Tue, 19 Sep 2023 19:49:56 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 39/49] iio: light: lm3533-als: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:49:21 +0200
Message-Id: <20230919174931.1417681-40-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1883; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=PVS8IxDTB3Jw0SBYvhTRp9Ing77iLLbhO90ZXRZavD0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCd8bVNF+6/v9Y85pax9ina+TOjl1hPfatki20 SI1P4fJEoSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQnfGwAKCRCPgPtYfRL+ TsCXB/9uh5lHIDBDUs2LEABppgITxo56iE7w7/9XxUIBPDpQdJfjZGv29jwjSBGfVIphVPBHb7J L8cLqmpeaJHu0XDL7nJSgI1OuKoKZ85AU+fCLTuS0MnMbhznhwtTmuGd99KGDlGoSZevJIHncrJ 1SDs1vRlOsf+87KT+FDu09pdiDH+n5d7n7JsUy6uAzb/9l9t3N4i0NZ8cxvaPenjVvPuo/xjwqA HFKdaI+hM+7GSuDSwbTYL9bqJvO15UMCvDLbRzK8w2+ti97QbIdlNmBLUOlpSFtVZsku38aiR2Q ZsP2si1nkB6XqAL7xgYOXd5XIz9WMeSbGE3AL5ny9/YKvOY/
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
 drivers/iio/light/lm3533-als.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index 827bc25269e9..7800f7fa51b7 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -895,7 +895,7 @@ static int lm3533_als_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int lm3533_als_remove(struct platform_device *pdev)
+static void lm3533_als_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct lm3533_als *als = iio_priv(indio_dev);
@@ -905,8 +905,6 @@ static int lm3533_als_remove(struct platform_device *pdev)
 	lm3533_als_disable(als);
 	if (als->irq)
 		free_irq(als->irq, indio_dev);
-
-	return 0;
 }
 
 static struct platform_driver lm3533_als_driver = {
@@ -914,7 +912,7 @@ static struct platform_driver lm3533_als_driver = {
 		.name	= "lm3533-als",
 	},
 	.probe		= lm3533_als_probe,
-	.remove		= lm3533_als_remove,
+	.remove_new	= lm3533_als_remove,
 };
 module_platform_driver(lm3533_als_driver);
 
-- 
2.40.1

