Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656467A6A14
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjISRuZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbjISRuU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:20 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D461511C
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:50:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierF-0006t7-I1; Tue, 19 Sep 2023 19:49:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierE-007VXr-Hm; Tue, 19 Sep 2023 19:49:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierE-0034Yx-80; Tue, 19 Sep 2023 19:49:56 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 38/49] iio: light: hid-sensor-prox: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:49:20 +0200
Message-Id: <20230919174931.1417681-39-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2063; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=9InOe8eBQN4BfxU+d0oPtNrpfmneHomGKn+oBC5Wt5U=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCd8a5kC5Xle7OYZtn5cPdMfbzzP4vfuWGFfIz rLOJO+4Y6GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQnfGgAKCRCPgPtYfRL+ TqG/CAC47dI86pAkLIkJTCWzIaSW7nP6OOoZ58lvz/EltwAzYwBtIaK+VsSYY1KyMw/llyUM4gT Nh6KHhYi/85iAhOD4Hob4Vk7VwB18FxR4iStwv0FRWiLqdgjWONuRSHJpJoRb19cS52XW1M53b7 /A0IIB/wn9F8XjYgef77TNYKFpQvVaV5ml5tTqv3oBb+2NfJc/vzRy87Y6lyKE28S3O8MwZz4F9 XOqLFgLdij16iavNatEOa7KfOoVxxH5Fem/6GCzmYzlq3eUwlWawdbEdA98No4kXKQLx+mbgMRQ jq+bxYAUUMRyRsKAXEoebuNz9ZVp5HFxqugRc0E4qwt7Pj0V
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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
 drivers/iio/light/hid-sensor-prox.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index a47591e1bad9..26c481d2998c 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -313,7 +313,7 @@ static int hid_prox_probe(struct platform_device *pdev)
 }
 
 /* Function to deinitialize the processing for usage id */
-static int hid_prox_remove(struct platform_device *pdev)
+static void hid_prox_remove(struct platform_device *pdev)
 {
 	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
@@ -322,8 +322,6 @@ static int hid_prox_remove(struct platform_device *pdev)
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	iio_device_unregister(indio_dev);
 	hid_sensor_remove_trigger(indio_dev, &prox_state->common_attributes);
-
-	return 0;
 }
 
 static const struct platform_device_id hid_prox_ids[] = {
@@ -346,7 +344,7 @@ static struct platform_driver hid_prox_platform_driver = {
 		.pm	= &hid_sensor_pm_ops,
 	},
 	.probe		= hid_prox_probe,
-	.remove		= hid_prox_remove,
+	.remove_new	= hid_prox_remove,
 };
 module_platform_driver(hid_prox_platform_driver);
 
-- 
2.40.1

