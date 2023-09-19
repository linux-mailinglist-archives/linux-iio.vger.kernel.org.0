Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5757A69F6
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjISRuJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjISRuG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:06 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C94BBC
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:50:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierC-0006cl-Cj; Tue, 19 Sep 2023 19:49:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierB-007VX1-2C; Tue, 19 Sep 2023 19:49:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierA-0034Y7-PB; Tue, 19 Sep 2023 19:49:52 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 25/49] iio: adc: ti_am335x_adc: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:49:07 +0200
Message-Id: <20230919174931.1417681-26-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1867; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=TGyPLY7mmTxktAfTFEv4MwQRCkt9deYJSsidQBhqb/U=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlTO+9zrl3K02Ui9P+Wf67Vcw8Ek4vwFeY1Mg0NiJxqmX 9jzcYlsJ6MxCwMjF4OsmCKLfeOaTKsqucjOtf8uwwxiZQKZwsDFKQAT6bNg/19wps3Ra8Xbs00G G6LsN9U9zD1Xz6Y7x36R35f+ptOvoiRVBby8sj0/B53/KlkyQzTmY/NjV16WiYYcuzvC1NTd2Nk 7ZL1rJ3A5Mq6olG2bVSd39s6ENFEFF3XtDQ9nz52lJLsm98yfmY2ydQH/u1izc3136YsqK2/jEr 81K/aOj6WA6KX6xst1N9eIXT31y6JrU4TvwRPRHuvizif9ODKrdZXAejmFaVKbf/Nz39t+ZLXrZ 8d/il+2Pg4q22287LK7brhvLvfEGcEzpj23sDso/lLOdr6G+eeSZtGr1+xVLsc93Otr6e9iJht8 oOe8wX/+t/svyFm7NIQtX1TkWRnpO8+nyEBMZqbpC1dhAA==
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
 drivers/iio/adc/ti_am335x_adc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 8db7a01cb5fb..c755e8cd5220 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -681,7 +681,7 @@ static int tiadc_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int tiadc_remove(struct platform_device *pdev)
+static void tiadc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct tiadc_device *adc_dev = iio_priv(indio_dev);
@@ -697,8 +697,6 @@ static int tiadc_remove(struct platform_device *pdev)
 
 	step_en = get_adc_step_mask(adc_dev);
 	am335x_tsc_se_clr(adc_dev->mfd_tscadc, step_en);
-
-	return 0;
 }
 
 static int tiadc_suspend(struct device *dev)
@@ -747,7 +745,7 @@ static struct platform_driver tiadc_driver = {
 		.of_match_table = ti_adc_dt_ids,
 	},
 	.probe	= tiadc_probe,
-	.remove	= tiadc_remove,
+	.remove_new = tiadc_remove,
 };
 module_platform_driver(tiadc_driver);
 
-- 
2.40.1

