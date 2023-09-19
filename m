Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CA47A6A05
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjISRuO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbjISRuI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:08 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487078F
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:50:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierE-0006mi-6k; Tue, 19 Sep 2023 19:49:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierC-007VXK-Gw; Tue, 19 Sep 2023 19:49:54 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierC-0034YR-7g; Tue, 19 Sep 2023 19:49:54 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Vladimir Zapolskiy <vz@mleia.com>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 30/49] iio: dac: lpc18xx_dac: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:49:12 +0200
Message-Id: <20230919174931.1417681-31-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1970; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=iglzgZjrrpqhrO/w7htw7qg1+yTI4aosf9h1TKojrNQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCd8RtsY4yGpn4umfQiGuUIkmmefzO6rq+asMa QsqQFlCft6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQnfEQAKCRCPgPtYfRL+ TjJwB/9q9JsU5o3zPTkS9MBt5dqdrePeo9XLe6PE/5W/rYSpcZqlmqh8mQ/uzIjIVKc8U+CdhRM 6gkleE06DVBwZYLdHjcweWmdsofP1cI5r3fD3eZTrxOn778j1iVifhtKKAu/E8q3RhKJxfwG24C J306a8Ww/8UU6ecXhHLiHqlLKquz9ZGmN3xV/E4390hH8TGCGNR7YfDaG4ZRfgTjxREPHegkY8y K1RrCTaCnEwhAboK6UcyiiSP5ebIZenq18a6Y79BupER+rEter2KFxKCw1oSt37pSlXnGhFCynA LdKa945cJRmxAhG4s6HSSqzcF2aVNgm/NRdDBhh8J7DlGYL7
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
 drivers/iio/dac/lpc18xx_dac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/lpc18xx_dac.c b/drivers/iio/dac/lpc18xx_dac.c
index 60467c6f2c6e..b3aa4443a6a4 100644
--- a/drivers/iio/dac/lpc18xx_dac.c
+++ b/drivers/iio/dac/lpc18xx_dac.c
@@ -165,7 +165,7 @@ static int lpc18xx_dac_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int lpc18xx_dac_remove(struct platform_device *pdev)
+static void lpc18xx_dac_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct lpc18xx_dac *dac = iio_priv(indio_dev);
@@ -175,8 +175,6 @@ static int lpc18xx_dac_remove(struct platform_device *pdev)
 	writel(0, dac->base + LPC18XX_DAC_CTRL);
 	clk_disable_unprepare(dac->clk);
 	regulator_disable(dac->vref);
-
-	return 0;
 }
 
 static const struct of_device_id lpc18xx_dac_match[] = {
@@ -187,7 +185,7 @@ MODULE_DEVICE_TABLE(of, lpc18xx_dac_match);
 
 static struct platform_driver lpc18xx_dac_driver = {
 	.probe	= lpc18xx_dac_probe,
-	.remove	= lpc18xx_dac_remove,
+	.remove_new = lpc18xx_dac_remove,
 	.driver	= {
 		.name = "lpc18xx-dac",
 		.of_match_table = lpc18xx_dac_match,
-- 
2.40.1

