Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339277A69F0
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjISRuG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjISRuE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:04 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D68CB3
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:49:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier5-0006Jv-Pu; Tue, 19 Sep 2023 19:49:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier5-007VVe-Bs; Tue, 19 Sep 2023 19:49:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier5-0034WT-2B; Tue, 19 Sep 2023 19:49:47 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Eugen Hristev <eugen.hristev@collabora.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 03/49] iio: adc: at91-sama5d2: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:48:45 +0200
Message-Id: <20230919174931.1417681-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1928; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=oPJUyIH6NolZvdQuh6xQdfsEJcgc48Renyw7JIOhqM8=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlTOe58keNb7xsx5cafVz0xLyWm7c6NRynaBrpc6uxeF7 q14bXquk9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJFIRwMOzs++sludIqzP3x mwkH2dIPpG2wnPigqllbO37frmOeWy02+MsUcS4U1v73nnWxUULpCvErCQv7qmyWyUnJ/rVxXSR t+bd/InehzKS3C9w8GkTfmG960cZfHjOd+9Qkl3Vv5itdyjTeEHWlP2/6v5zFi2cd6rdoi9lzfm JiPHvghWc3wqsan4UeLuDQaTstauoxS9D8RuPrqhsFZsa5+vmcLtKtWgd7RC+u9HiSrmc5Se9k6 ZL3Wsvm35rXZ+EVf/WbCLvFlYV3xB6L9x72a4zvZdnqL9W3VmFqXOjLx7kpW3cdWh39ofyJTcX/ xOl8rGcvcDWm15UJLszY0jfhuH9rYn4/T4zO8YRHYpqTAQ==
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
 drivers/iio/adc/at91-sama5d2_adc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index df67b63ccf69..d7fd21e7c6e2 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -2486,7 +2486,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int at91_adc_remove(struct platform_device *pdev)
+static void at91_adc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct at91_adc_state *st = iio_priv(indio_dev);
@@ -2501,8 +2501,6 @@ static int at91_adc_remove(struct platform_device *pdev)
 
 	regulator_disable(st->vref);
 	regulator_disable(st->reg);
-
-	return 0;
 }
 
 static int at91_adc_suspend(struct device *dev)
@@ -2627,7 +2625,7 @@ MODULE_DEVICE_TABLE(of, at91_adc_dt_match);
 
 static struct platform_driver at91_adc_driver = {
 	.probe = at91_adc_probe,
-	.remove = at91_adc_remove,
+	.remove_new = at91_adc_remove,
 	.driver = {
 		.name = "at91-sama5d2_adc",
 		.of_match_table = at91_adc_dt_match,
-- 
2.40.1

