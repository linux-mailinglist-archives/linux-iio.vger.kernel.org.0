Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2827F7A69F3
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjISRuI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjISRuF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:05 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7888995
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:49:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier8-0006Ps-Ez; Tue, 19 Sep 2023 19:49:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier7-007VWD-No; Tue, 19 Sep 2023 19:49:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier7-0034XH-EN; Tue, 19 Sep 2023 19:49:49 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Haibo Chen <haibo.chen@nxp.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 12/49] iio: adc: imx8qxp: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:48:54 +0200
Message-Id: <20230919174931.1417681-13-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1926; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=q5nb4FK8nsEMv6NwxZJXP90sT91P3mWI6khuLzp74qw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCd79qbfKyIsI34TRT+0OCBanzHaaUC7G1mqZ2 EthfuPXblSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQne/QAKCRCPgPtYfRL+ TrCNCACySEPK8JAEa6Ie0ZWmHPwklazr6c84g0jnKf5djZOYxgpjd/+cdIypnWEoqAKQALD5LEr BOZ8AJ5t/e725WVHIoLLLPIWeKg3ees4kXNHLq5SZ5ZBG71qYPL4kkCfr0x6kpbNxkOklIDGzzL Qy+7grxRWVfP7OVvjjh1wRmBKJzLWA+/ueLNQHWMZaQpyL/YU8KEWtYQCnf6eul1I+gjYHMaoIu lFy0KDJJgetEdoTfrlovrS+g0diSONLiib7+B5ualx3Rcd9K/EKLBP+1gCM+KdXUxR3RfA/wEim 7EC0lo5okHELRvtrYcOxZmkIiy5Gn0lH45IbeiytniTEQ6VY
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
 drivers/iio/adc/imx8qxp-adc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/imx8qxp-adc.c b/drivers/iio/adc/imx8qxp-adc.c
index fff6e5a2d956..fe82198170d5 100644
--- a/drivers/iio/adc/imx8qxp-adc.c
+++ b/drivers/iio/adc/imx8qxp-adc.c
@@ -404,7 +404,7 @@ static int imx8qxp_adc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int imx8qxp_adc_remove(struct platform_device *pdev)
+static void imx8qxp_adc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct imx8qxp_adc *adc = iio_priv(indio_dev);
@@ -422,8 +422,6 @@ static int imx8qxp_adc_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);
-
-	return 0;
 }
 
 static int imx8qxp_adc_runtime_suspend(struct device *dev)
@@ -489,7 +487,7 @@ MODULE_DEVICE_TABLE(of, imx8qxp_adc_match);
 
 static struct platform_driver imx8qxp_adc_driver = {
 	.probe		= imx8qxp_adc_probe,
-	.remove		= imx8qxp_adc_remove,
+	.remove_new	= imx8qxp_adc_remove,
 	.driver		= {
 		.name	= ADC_DRIVER_NAME,
 		.of_match_table = imx8qxp_adc_match,
-- 
2.40.1

