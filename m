Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE35B7A69E2
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjISRuA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjISRt7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:49:59 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC3A8F
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:49:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier6-0006KU-TV; Tue, 19 Sep 2023 19:49:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier6-007VVt-H0; Tue, 19 Sep 2023 19:49:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier6-0034Wx-7e; Tue, 19 Sep 2023 19:49:48 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 07/49] iio: adc: dln2: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:48:49 +0200
Message-Id: <20230919174931.1417681-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1670; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=oWDpssMuP6XBt56XuGAlj6vtaAGStLMERv7UhQ1Tnj8=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlTOe9/37Ar0ZLcxz0/kCNsS/tws/JPfa95Avo0vjjkrc PxyDzPtZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAiv/ey/1O7/NpFv9RoY5Z2 DovYf6lXmUtydvKZW7fsby3ZvXWrP4uwiTKLaE7bsx4nuR3b5Vqvxpr4csVJ59rJ8M8+fqn27By 9OZw13RFtvy6mvF3de3f6I+HD1zs6ihgmhtr6d1UrHnHhLMlgm5JlvD3p3defvGYqP3/uzs2QtQ /qUWecUfOt2n+5aNaBDa+vb1w13+70hqdC22RYLP95cDYv9uHKXrZeuPIbwzLZAImLAaclUxq05 X9kTIp7ZTtjWmLcxiKtw75d4dfjP+ZVehVLGi7W6Tjhwl62bh3Taem4VWamUxa6GnCqc134/Nw3 4TSz0YvJknOW+p3+F/Xg7/ZTs9juML2vmGBck+L9+6kmAA==
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
 drivers/iio/adc/dln2-adc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
index 97d162a3cba4..06cfbbabaf8d 100644
--- a/drivers/iio/adc/dln2-adc.c
+++ b/drivers/iio/adc/dln2-adc.c
@@ -691,19 +691,18 @@ static int dln2_adc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int dln2_adc_remove(struct platform_device *pdev)
+static void dln2_adc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 
 	iio_device_unregister(indio_dev);
 	dln2_unregister_event_cb(pdev, DLN2_ADC_CONDITION_MET_EV);
-	return 0;
 }
 
 static struct platform_driver dln2_adc_driver = {
 	.driver.name	= DLN2_ADC_MOD_NAME,
 	.probe		= dln2_adc_probe,
-	.remove		= dln2_adc_remove,
+	.remove_new	= dln2_adc_remove,
 };
 
 module_platform_driver(dln2_adc_driver);
-- 
2.40.1

