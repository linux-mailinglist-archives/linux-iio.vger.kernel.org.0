Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F5A7A69FE
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbjISRuL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjISRuG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:06 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE92BD
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:50:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierC-0006eU-Pi; Tue, 19 Sep 2023 19:49:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierB-007VX7-AU; Tue, 19 Sep 2023 19:49:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierB-0034YB-1L; Tue, 19 Sep 2023 19:49:53 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 26/49] iio: adc: twl4030-madc: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:49:08 +0200
Message-Id: <20230919174931.1417681-27-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1929; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=fmnKrUJW/ope+cd9hQkl0LhrFRTeucbAZgSP6LTDl2A=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlTO+zy5Km6yp0xr9zk9XOKtxSLFf8f+WtrjB1zLtiaER wZs2OLeyWjMwsDIxSArpshi37gm06pKLrJz7b/LMINYmUCmMHBxCsBECmaz/2TkXu3vMjPkQ+WJ 3vylBwyOTkow/103te+zS/mz53fm9B/rTPZ0/iYnydm4Yb0xu/L9HK/5btri9T3fV8/fteTHxha Zp4z/Wd/9+O4ptlOp/k2MWXpFq9jiEyn704q5Q+1ddtyIfDVDRsA1Mcl407L2x3vldH84vUh+2b FMS6jibU+XmsJeh0eLbWsMj5zjLTnU1H1Ac9UX4cVt+w2m52rXinAbZzEy3r7a63k4lVnD6vxf1 dkBx1Tjf8wOiDIz05zzeYtQ/w2ZV4+kC4tuyu8yY97/V2LijMDje9do+1iyuNnIrbKZZtSaV/ps 0hRXzUYdw8UfJOb4sM1nuVsoZaCcG64R6s9+mW1dbYc6AA==
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
 drivers/iio/adc/twl4030-madc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
index c279c4f2c9b7..4a247ca25a44 100644
--- a/drivers/iio/adc/twl4030-madc.c
+++ b/drivers/iio/adc/twl4030-madc.c
@@ -892,7 +892,7 @@ static int twl4030_madc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int twl4030_madc_remove(struct platform_device *pdev)
+static void twl4030_madc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *iio_dev = platform_get_drvdata(pdev);
 	struct twl4030_madc_data *madc = iio_priv(iio_dev);
@@ -903,8 +903,6 @@ static int twl4030_madc_remove(struct platform_device *pdev)
 	twl4030_madc_set_power(madc, 0);
 
 	regulator_disable(madc->usb3v1);
-
-	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -917,7 +915,7 @@ MODULE_DEVICE_TABLE(of, twl_madc_of_match);
 
 static struct platform_driver twl4030_madc_driver = {
 	.probe = twl4030_madc_probe,
-	.remove = twl4030_madc_remove,
+	.remove_new = twl4030_madc_remove,
 	.driver = {
 		   .name = "twl4030_madc",
 		   .of_match_table = of_match_ptr(twl_madc_of_match),
-- 
2.40.1

