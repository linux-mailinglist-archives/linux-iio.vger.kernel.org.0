Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8537A69FB
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjISRuK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjISRuG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:06 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2483695
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:50:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierD-0006lR-SI; Tue, 19 Sep 2023 19:49:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierC-007VXG-7C; Tue, 19 Sep 2023 19:49:54 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierB-0034YN-UE; Tue, 19 Sep 2023 19:49:53 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Peter Rosin <peda@axentia.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 29/49] iio: dac: dpot-dac: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:49:11 +0200
Message-Id: <20230919174931.1417681-30-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1804; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=wRsswWPtOlEdRXZw8Hq3E72c4J2Ovm6FcEaf66eA5A4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCd8QxRiTFMz+OVkIbTqDbUSgAUb+RUstJEemd QfASe4ldfyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQnfEAAKCRCPgPtYfRL+ TsTxB/9/resJd9R4lBnvYdes8eKvhWwr8KjnDT4UBnM5udOWARapMBJk6OZRKlwwiMF9Rw5kU37 j1zwP3tpDr1iM5jyuay7W02UF7Jd9/TpIgp/7+GEGk19GDNitKi2L2EG9A3ncCfb+IoYPocdRUZ s6M+/gTZ0cVzXVSW5BEUguaYMwleSMdt+k/ejD1P1fgMSixPV7ogfHRG2yFV/AODQ1xR40U/e+C IPPs0UWuCKhsHkf99yC0bTbLrKyhHiA1JchdL9AlHSBEVmFCq3Wk/R6N0+bexaEsA3S6/JnXyhA SkmaYzJDGVhL1362qc7icyr7tnwOaHIxbjsZuw//s2CLVqDx
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
 drivers/iio/dac/dpot-dac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/dpot-dac.c b/drivers/iio/dac/dpot-dac.c
index 83ce9489259c..7332064d0852 100644
--- a/drivers/iio/dac/dpot-dac.c
+++ b/drivers/iio/dac/dpot-dac.c
@@ -226,15 +226,13 @@ static int dpot_dac_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int dpot_dac_remove(struct platform_device *pdev)
+static void dpot_dac_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct dpot_dac *dac = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
 	regulator_disable(dac->vref);
-
-	return 0;
 }
 
 static const struct of_device_id dpot_dac_match[] = {
@@ -245,7 +243,7 @@ MODULE_DEVICE_TABLE(of, dpot_dac_match);
 
 static struct platform_driver dpot_dac_driver = {
 	.probe = dpot_dac_probe,
-	.remove = dpot_dac_remove,
+	.remove_new = dpot_dac_remove,
 	.driver = {
 		.name = "iio-dpot-dac",
 		.of_match_table = dpot_dac_match,
-- 
2.40.1

