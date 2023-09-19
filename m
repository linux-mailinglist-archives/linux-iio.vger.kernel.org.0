Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF09D7A6A04
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjISRuQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjISRuK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:10 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC381B3
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:50:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierA-0006Wb-Va; Tue, 19 Sep 2023 19:49:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierA-007VWo-45; Tue, 19 Sep 2023 19:49:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier9-0034Xr-Qz; Tue, 19 Sep 2023 19:49:51 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tom Rix <trix@redhat.com>, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 21/49] iio: adc: stm32-adc: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:49:03 +0200
Message-Id: <20230919174931.1417681-22-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1911; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=2IJdHWO8PCUHXhN+Bf4BVhDD3vEc4XIIPPlau+wZ0uo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCd8Hn8QSiO65e7135FOiFXMptlEfZQTvMivAr YuJEVQ4s0GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQnfBwAKCRCPgPtYfRL+ TqiDB/9446oEn288cKhe9v5Dbz86mSVC0C+6AyNrQLcz+DfPw2bGistuFJWBU6wJXFNJWUbz9TQ q0BsZS39uexqH/N7Sw5riQj2GSQOQ1Imy3AEh6yCSRN5BgSuEQ0C/LzSev1i0UacY/bADx36dPj qmpRGU6pOKLARKDi7acmJ7Sx6TnxOa8CfzP3xj2ceoCW6aJhfHNJ20Lg4wwlsszT4YYL7sqzkFh ZAILfjmL664WgKyhV36VdmM7ks1reg6zi63CkMswRTlGZsHXG2Z0bR1ncKm/eP22CvB4ppZjzxh XVLpjjKy7yY0ZW6JZNYlTv4H44MD2Uk0RE2lInVK6Y+GKIZ/
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
 drivers/iio/adc/stm32-adc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index f7613efb870d..25a912805439 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -2513,7 +2513,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int stm32_adc_remove(struct platform_device *pdev)
+static void stm32_adc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct stm32_adc *adc = iio_priv(indio_dev);
@@ -2532,8 +2532,6 @@ static int stm32_adc_remove(struct platform_device *pdev)
 				  adc->rx_buf, adc->rx_dma_buf);
 		dma_release_channel(adc->dma_chan);
 	}
-
-	return 0;
 }
 
 static int stm32_adc_suspend(struct device *dev)
@@ -2659,7 +2657,7 @@ MODULE_DEVICE_TABLE(of, stm32_adc_of_match);
 
 static struct platform_driver stm32_adc_driver = {
 	.probe = stm32_adc_probe,
-	.remove = stm32_adc_remove,
+	.remove_new = stm32_adc_remove,
 	.driver = {
 		.name = "stm32-adc",
 		.of_match_table = stm32_adc_of_match,
-- 
2.40.1

