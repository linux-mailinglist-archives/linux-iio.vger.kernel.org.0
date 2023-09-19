Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8F77A6A1F
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjISRuM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbjISRuH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:07 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AA09E
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:50:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierA-0006XK-VZ; Tue, 19 Sep 2023 19:49:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierA-007VWr-Ac; Tue, 19 Sep 2023 19:49:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierA-0034Xv-1J; Tue, 19 Sep 2023 19:49:52 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 22/49] iio: adc: stm32-dfsdm-adc: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:49:04 +0200
Message-Id: <20230919174931.1417681-23-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2014; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=sIxbeL13+lF8KrifdITtoEeWPqQapatgwP5mvMYrHt8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCd8I4WK1OylHCGdXA8mRLCr9mGCYoL8I64o50 QHwuhakfKSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQnfCAAKCRCPgPtYfRL+ TieJB/9fx4MoIk9mbYWIS0YYhEoc9e3XBGofMguF5EG+fjbPHXosZ6NBt2HpGWoL6eazvwIfDxu jwkpD7dQ4LnUgxzqOupGv5zRK9+pC6PO79OAanOG8WbhLzGHnFNX8jGDUoT3ANIeIMQt3P1a9zO ti3etgekAlWIzxXat3aO0pFkkViXye2hW17/fikfdX3EkJgt5Fq70IxJL+3kUqsqnYdHR1mU1Qd K9CKSxwofm1d8mZ5Ot3d1ZZs6W/ZNvwGxEeAXGkJn/r8I5My5SgSk2dUw3gm9ReH8vGnwO5vVKs PhZA6WopoH7blsW/5QcdYATk/D2b9qWu9wh2vN1IY+/+PcI4
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
 drivers/iio/adc/stm32-dfsdm-adc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index b5cc43d12b6f..ca08ae3108b2 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -1620,7 +1620,7 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int stm32_dfsdm_adc_remove(struct platform_device *pdev)
+static void stm32_dfsdm_adc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
@@ -1629,8 +1629,6 @@ static int stm32_dfsdm_adc_remove(struct platform_device *pdev)
 		of_platform_depopulate(&pdev->dev);
 	iio_device_unregister(indio_dev);
 	stm32_dfsdm_dma_release(indio_dev);
-
-	return 0;
 }
 
 static int stm32_dfsdm_adc_suspend(struct device *dev)
@@ -1677,7 +1675,7 @@ static struct platform_driver stm32_dfsdm_adc_driver = {
 		.pm = pm_sleep_ptr(&stm32_dfsdm_adc_pm_ops),
 	},
 	.probe = stm32_dfsdm_adc_probe,
-	.remove = stm32_dfsdm_adc_remove,
+	.remove_new = stm32_dfsdm_adc_remove,
 };
 module_platform_driver(stm32_dfsdm_adc_driver);
 
-- 
2.40.1

