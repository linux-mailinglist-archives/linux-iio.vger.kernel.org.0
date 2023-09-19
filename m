Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989B07A6A26
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjISRuU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjISRuM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:12 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692A6B3
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:50:06 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierH-00077L-Sq; Tue, 19 Sep 2023 19:49:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierH-007VYc-7B; Tue, 19 Sep 2023 19:49:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierG-0034Zf-Ts; Tue, 19 Sep 2023 19:49:58 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 49/49] iio: trigger: stm32-timer: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:49:31 +0200
Message-Id: <20230919174931.1417681-50-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2015; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=8KwHSL8TuAiHCNseqPqBrPjb/1yV+n3dsfUORSJVSa8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCd8mRFylT7xmEsuv/UaGPOvVUq6T4KbwmkjY0 ZBBzO1pMWqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQnfJgAKCRCPgPtYfRL+ TgzyB/46eFeGI2MjtA+6jtjaUeGp+5CaZEOXQtXsLjtmyfXu0XAN+MasjRicDZlUrC2IxlsRQSB XE8ckaVEvMDJB3GvGfdLvF0jD+mnZdlUVrkYHFPlQbd4KuKCqb7kP5+pNlKPZ3MPPq9Zi25UNPs PChl0TycPsFQRDaCb+zWmixoMnlBKNrYDRLGfxUqK3vjyEBD/B4UcXNBbwROnbK2wlNpDWYn+0y dolcxBJHkIglkyZRtp/U63sf+apE81dA+2gpkOPCIKOMwINVWPAdG3e1Mk+vDIfPWmj4AlEwWMe trMYYUeRNA3gQETXFInIhK4HX7aC4MNvKNaJBaGqt+oDTYa6
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
 drivers/iio/trigger/stm32-timer-trigger.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index 3643c4afae67..d76444030a28 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -809,7 +809,7 @@ static int stm32_timer_trigger_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int stm32_timer_trigger_remove(struct platform_device *pdev)
+static void stm32_timer_trigger_remove(struct platform_device *pdev)
 {
 	struct stm32_timer_trigger *priv = platform_get_drvdata(pdev);
 	u32 val;
@@ -824,8 +824,6 @@ static int stm32_timer_trigger_remove(struct platform_device *pdev)
 
 	if (priv->enabled)
 		clk_disable(priv->clk);
-
-	return 0;
 }
 
 static int stm32_timer_trigger_suspend(struct device *dev)
@@ -904,7 +902,7 @@ MODULE_DEVICE_TABLE(of, stm32_trig_of_match);
 
 static struct platform_driver stm32_timer_trigger_driver = {
 	.probe = stm32_timer_trigger_probe,
-	.remove = stm32_timer_trigger_remove,
+	.remove_new = stm32_timer_trigger_remove,
 	.driver = {
 		.name = "stm32-timer-trigger",
 		.of_match_table = stm32_trig_of_match,
-- 
2.40.1

