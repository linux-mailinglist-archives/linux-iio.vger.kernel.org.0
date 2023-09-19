Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EA77A6A09
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbjISRuQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjISRuK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:10 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE5C9E
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:50:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierA-0006TQ-Ev; Tue, 19 Sep 2023 19:49:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier8-007VWU-NU; Tue, 19 Sep 2023 19:49:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier8-0034XX-Dv; Tue, 19 Sep 2023 19:49:50 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jiakai Luo <jkluo@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 16/49] iio: adc: mxs-lradc: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:48:58 +0200
Message-Id: <20230919174931.1417681-17-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1937; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=JIKNd5ZQy17uCDf4YkKQr4GfskmFWOTclLtDGaMhHt8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCd8Bu+fLxRMziScCU0qZGV41nR2Sq9+W2OYaD cggcy9UC6mJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQnfAQAKCRCPgPtYfRL+ TmX/CAC3QkNJxRtGuVyEW54uyK2F+Ccr9zim/ShGQgF7je5WODwDkf5U0BrkKTZww6nGCuEAXas lwAElORSOitjIsdkbSWF5OMOQiKTOJw44XwEfZgqx+ESVH/DXuhTOHaxPbLHtFjQl1lMNsTp0+A iM/2iW9pn6vWIpRMVdoBqMGsRUPkOp/WiJRmrnU1VBUQPtzuuEFVxrCbBURKqTUaNTO7/nTqrnl 9yQ2fvB22gKl4DGHIo+9BO69W/ManL8zF+fmL65fVSMzngtKGW04l10gK2xcijHoudtEsV+H6N/ tqL9X2VhpWtbKFy8l0uaTdq7Vyt37HdrJx/kn4pKoIhp3Cf2
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
 drivers/iio/adc/mxs-lradc-adc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index a50f39143d3e..2e60c10ee4ff 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -807,7 +807,7 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mxs_lradc_adc_remove(struct platform_device *pdev)
+static void mxs_lradc_adc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *iio = platform_get_drvdata(pdev);
 	struct mxs_lradc_adc *adc = iio_priv(iio);
@@ -816,8 +816,6 @@ static int mxs_lradc_adc_remove(struct platform_device *pdev)
 	mxs_lradc_adc_hw_stop(adc);
 	iio_triggered_buffer_cleanup(iio);
 	mxs_lradc_adc_trigger_remove(iio);
-
-	return 0;
 }
 
 static struct platform_driver mxs_lradc_adc_driver = {
@@ -825,7 +823,7 @@ static struct platform_driver mxs_lradc_adc_driver = {
 		.name	= "mxs-lradc-adc",
 	},
 	.probe	= mxs_lradc_adc_probe,
-	.remove = mxs_lradc_adc_remove,
+	.remove_new = mxs_lradc_adc_remove,
 };
 module_platform_driver(mxs_lradc_adc_driver);
 
-- 
2.40.1

