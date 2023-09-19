Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431FF7A69E4
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbjISRuE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjISRuC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:02 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961C08F
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:49:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier8-0006OR-4X; Tue, 19 Sep 2023 19:49:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier7-007VWA-GN; Tue, 19 Sep 2023 19:49:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier7-0034XC-6t; Tue, 19 Sep 2023 19:49:49 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andreas Klinger <ak@it-klinger.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 11/49] iio: adc: hx711: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:48:53 +0200
Message-Id: <20230919174931.1417681-12-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1819; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=xMmeumzR43g1BZpZw1Jwv5XAWvv0aW7vULxH49ZQdLw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCd77MKHthnWZsFQlBQrF9oOQ1inH6a8yHxxYH VCpu/listyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQne+wAKCRCPgPtYfRL+ ThJtB/9BQe71bYcxvNjD5K9aEqTWsoQ0Hplbf8wWvwaziEF8HZLzkugKkqz3BxR8IlzVfXmIZsW 9GhuouKfWccpNmPh6WXkNyav7Ob4z53Nx9FlcImjcrwN1PYxEdTp3pJNzE0tt4nu4lLBZouqc7A m+XYaSWo2uVTCojdT4D7F3S28NxUWWWeRrXvV3e7mS/Tz3pvzyLpI9DJRHanC75MKQOJAU0wbCt YjbVN0B4Kw/i6oXdnr72mc78wfDZDDyW4emFcpiszyJxGAo/uXRGV1MkNTAfuWW2zbIXjNQ7t+P YXuRl4huMwQZXofcISSM6k8XAsl0xCF1Y6SBr1Mx+6m0KJ9H
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
 drivers/iio/adc/hx711.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index f7ee856a6b8b..c80c55fb8c6c 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -580,7 +580,7 @@ static int hx711_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int hx711_remove(struct platform_device *pdev)
+static void hx711_remove(struct platform_device *pdev)
 {
 	struct hx711_data *hx711_data;
 	struct iio_dev *indio_dev;
@@ -593,8 +593,6 @@ static int hx711_remove(struct platform_device *pdev)
 	iio_triggered_buffer_cleanup(indio_dev);
 
 	regulator_disable(hx711_data->reg_avdd);
-
-	return 0;
 }
 
 static const struct of_device_id of_hx711_match[] = {
@@ -606,7 +604,7 @@ MODULE_DEVICE_TABLE(of, of_hx711_match);
 
 static struct platform_driver hx711_driver = {
 	.probe		= hx711_probe,
-	.remove		= hx711_remove,
+	.remove_new	= hx711_remove,
 	.driver		= {
 		.name		= "hx711-gpio",
 		.of_match_table	= of_hx711_match,
-- 
2.40.1

