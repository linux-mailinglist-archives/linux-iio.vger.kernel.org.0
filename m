Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184A37A6A1C
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjISRuO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjISRuI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:08 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FE2B3
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:50:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierD-0006np-Vf; Tue, 19 Sep 2023 19:49:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierC-007VXN-QQ; Tue, 19 Sep 2023 19:49:54 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierC-0034YV-H2; Tue, 19 Sep 2023 19:49:54 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 31/49] iio: dac: stm32-dac-core: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:49:13 +0200
Message-Id: <20230919174931.1417681-32-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1937; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=dmnIAymv8CNJCPiwRLOlHvdF2Tf0Xf8o90wtNRq3GDc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCd8SRgMUKbaWv9gUSvomUJ6Gc5+zXzKlEC1o2 YlBlzSTPH+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQnfEgAKCRCPgPtYfRL+ TtGLB/9WLjl6A/vXfiGlsa4FIvIL6cjjJUnlwft+OZnvRC01DtIQ4sz13F1qqx4UA12XVOzLZhq 3YAUSBlEcVkxZ5dxJHtRxwi4C5Wj7Z14OrOYehYl/EEwna45dkvdDKk9G1yLWLRfzmdDJRe0mWQ iMqHPTQq4tUm5deo3LeZrLoxzB26HfqjQSKhdUmJVu4GxOxDe4wlPfVKOK7j7HA1JI2daLYPbKl +sC/15meFfshu0eOfDc52iTgMvpQnv4Doy6lX+5dlrM6ot64/PAUslOsI6XDTBWAM/yuivDX0qn u1Rz8gTuVzlddqa67J0mrlTSgMY6mPvsERiAmx5HFz+d7OsD
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
 drivers/iio/dac/stm32-dac-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/stm32-dac-core.c b/drivers/iio/dac/stm32-dac-core.c
index 83bf184e3adc..15abe048729e 100644
--- a/drivers/iio/dac/stm32-dac-core.c
+++ b/drivers/iio/dac/stm32-dac-core.c
@@ -183,7 +183,7 @@ static int stm32_dac_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int stm32_dac_remove(struct platform_device *pdev)
+static void stm32_dac_remove(struct platform_device *pdev)
 {
 	pm_runtime_get_sync(&pdev->dev);
 	of_platform_depopulate(&pdev->dev);
@@ -191,8 +191,6 @@ static int stm32_dac_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
-
-	return 0;
 }
 
 static int stm32_dac_core_resume(struct device *dev)
@@ -249,7 +247,7 @@ MODULE_DEVICE_TABLE(of, stm32_dac_of_match);
 
 static struct platform_driver stm32_dac_driver = {
 	.probe = stm32_dac_probe,
-	.remove = stm32_dac_remove,
+	.remove_new = stm32_dac_remove,
 	.driver = {
 		.name = "stm32-dac-core",
 		.of_match_table = stm32_dac_of_match,
-- 
2.40.1

