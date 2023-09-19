Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DB27A6A1A
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjISRu1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbjISRuU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:20 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39D7D9
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:50:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierH-0006w0-0T; Tue, 19 Sep 2023 19:49:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierF-007VY9-JA; Tue, 19 Sep 2023 19:49:57 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierF-0034ZD-8o; Tue, 19 Sep 2023 19:49:57 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 42/49] iio: orientation: hid-sensor-rotation: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:49:24 +0200
Message-Id: <20230919174931.1417681-43-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2146; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=M5KJaEC0r6hyiz93LrjvNIjI5lXA3JxdGcPMPplvUuM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCd8eUstTMY0rI4t/ZTzfQ2pHreWhl9r1RkMeS NiuOCeQb4KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQnfHgAKCRCPgPtYfRL+ TvFECAC5vtwC65OjcJLNu95zPyLrzX1yjaQhIeA6njY2pI8aoqE/cXPtuAiVdXzugFrUkwW97AB G0kQ5ehXMD2oxGaS8KbETCcK2Yy1IcvmSCoN3xMI9PPU/YhjzORX7/A+KSXv7Lb5yzBrzllRnuX DWrT+sAAWJexb1c8za1MwG+3VuNZzc9x8Yhdu1WlD7UPBk3tslsv+V3/wGp3s/uHFry2F1gUnUS /7lR7K8e4lYdwB7y1XD3kFu1buanWa+pEyOopm9l21M1L1hbsWQVEmZJ5wccOzWwXv2PEQ5075Z CeWEZnXpNobt8H9x2QygcytXqz5vVKq8MKT95eWJ8NMOFitW
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
 drivers/iio/orientation/hid-sensor-rotation.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index a033699910e8..5e8cadd5177a 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -327,7 +327,7 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 }
 
 /* Function to deinitialize the processing for usage id */
-static int hid_dev_rot_remove(struct platform_device *pdev)
+static void hid_dev_rot_remove(struct platform_device *pdev)
 {
 	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
@@ -336,8 +336,6 @@ static int hid_dev_rot_remove(struct platform_device *pdev)
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	iio_device_unregister(indio_dev);
 	hid_sensor_remove_trigger(indio_dev, &rot_state->common_attributes);
-
-	return 0;
 }
 
 static const struct platform_device_id hid_dev_rot_ids[] = {
@@ -364,7 +362,7 @@ static struct platform_driver hid_dev_rot_platform_driver = {
 		.pm     = &hid_sensor_pm_ops,
 	},
 	.probe		= hid_dev_rot_probe,
-	.remove		= hid_dev_rot_remove,
+	.remove_new	= hid_dev_rot_remove,
 };
 module_platform_driver(hid_dev_rot_platform_driver);
 
-- 
2.40.1

