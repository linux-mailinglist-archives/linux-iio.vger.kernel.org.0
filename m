Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5829C7A69FC
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjISRuK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbjISRuG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:06 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88136BE
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:50:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierD-0006jf-Ca; Tue, 19 Sep 2023 19:49:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierB-007VXD-VB; Tue, 19 Sep 2023 19:49:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierB-0034YK-M8; Tue, 19 Sep 2023 19:49:53 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Haibo Chen <haibo.chen@nxp.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Subject: [PATCH 28/49] iio: adc: vf610_adc: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:49:10 +0200
Message-Id: <20230919174931.1417681-29-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1989; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=B5wagjHFmPOAe6+zbpVj8I44CnDhJscGiT24pljvvos=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCd8PiKPrfzCduUHR+l59jxM9W6GyS3qb7Attc dtPDPElDZGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQnfDwAKCRCPgPtYfRL+ Tv2XB/4iZzGCtXopJXQd82ckY2J/97kyRqGC8wyNJ0fZbOJRXdNAkd1B8XT0sYTfQ+zxkDF991T EdKl0ptybVMTgTURgt2cNq5T8M2LVJyD20oOZBL2xuehEY5OAo8va7zoTZRAPKHXfaZlETLq+ZW NL7j5tZPLGxNNc9EXIiiM92b0kCdAysuj0aTXpFPs3uBoV4aAtIhwrFxNdD6mXgyESlbECzUkgc tJ9h/k1R2lko0/cnKpnGe1WWzp4tSp6a6YkKS7DVqvaEfQwhmt+WsrRBZuLndp9h8ZF+VXtMh3c 3r3lU2aCf9Bxb/TIy1nDSMAWE8oHltXcjxZ1pc5TIbmG8qp0
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
 drivers/iio/adc/vf610_adc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index ae31aafd2653..e4548df3f8fb 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -916,7 +916,7 @@ static int vf610_adc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int vf610_adc_remove(struct platform_device *pdev)
+static void vf610_adc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct vf610_adc *info = iio_priv(indio_dev);
@@ -925,8 +925,6 @@ static int vf610_adc_remove(struct platform_device *pdev)
 	iio_triggered_buffer_cleanup(indio_dev);
 	regulator_disable(info->vref);
 	clk_disable_unprepare(info->clk);
-
-	return 0;
 }
 
 static int vf610_adc_suspend(struct device *dev)
@@ -974,7 +972,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(vf610_adc_pm_ops, vf610_adc_suspend,
 
 static struct platform_driver vf610_adc_driver = {
 	.probe          = vf610_adc_probe,
-	.remove         = vf610_adc_remove,
+	.remove_new     = vf610_adc_remove,
 	.driver         = {
 		.name   = DRIVER_NAME,
 		.of_match_table = vf610_adc_match,
-- 
2.40.1

