Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62AA7A6A0D
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjISRu2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbjISRuV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:21 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA09129
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:50:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierD-0006WN-V4; Tue, 19 Sep 2023 19:49:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier9-007VWj-Ri; Tue, 19 Sep 2023 19:49:51 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier9-0034Xn-I9; Tue, 19 Sep 2023 19:49:51 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Rob Herring <robh@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Zhang Shurong <zhang_shurong@foxmail.com>,
        Yangtao Li <frank.li@vivo.com>, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 20/49] iio: adc: stm32-adc-core: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:49:02 +0200
Message-Id: <20230919174931.1417681-21-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1996; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=WSJX25WSQLs7OvVKbqk6leOgh/V6E1BBL0l8Qm7+sJg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCd8GgNcFOnrFMcZcUSjQ4cgFpvB8rIlGVCMJ6 HvjdkWt3mKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQnfBgAKCRCPgPtYfRL+ TkPrB/wPefIGJwRrtcx9BIwo/98kaRZZsLmqVRPnnTmLsKha6RWmJsbfvJbPShgl8yzxbdJBz6h k9CqXjqwf63gzLPIeBjE1ZAwKQCgtjdQYZF2lKJbEGpc5BMPoUtJp1xmwJn/OdKzPSwps9bBZ3J 6zI7LlnSVucW5XSqMd8pejTj3NaRvsm2DNK5LC/GtPPtESiv/5ic7+QE5niLTMpTexw2p/r31i/ DGFh1hXjnF2XJb1S6mT2f15SmOlUb2fF15M+cFTUnlye4a6DucHWblAWf628EWnMYbkO4FM+2o4 Zev564enqS5DQsZjQkpjHsrfGAEIdwL4KUd1oC4eCpFXy+WD
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
 drivers/iio/adc/stm32-adc-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index bbd5bdd732f0..c19506b0aac8 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -819,7 +819,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int stm32_adc_remove(struct platform_device *pdev)
+static void stm32_adc_remove(struct platform_device *pdev)
 {
 	struct stm32_adc_common *common = platform_get_drvdata(pdev);
 	struct stm32_adc_priv *priv = to_stm32_adc_priv(common);
@@ -831,8 +831,6 @@ static int stm32_adc_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
-
-	return 0;
 }
 
 static int stm32_adc_core_runtime_suspend(struct device *dev)
@@ -913,7 +911,7 @@ MODULE_DEVICE_TABLE(of, stm32_adc_of_match);
 
 static struct platform_driver stm32_adc_driver = {
 	.probe = stm32_adc_probe,
-	.remove = stm32_adc_remove,
+	.remove_new = stm32_adc_remove,
 	.driver = {
 		.name = "stm32-adc-core",
 		.of_match_table = stm32_adc_of_match,
-- 
2.40.1

