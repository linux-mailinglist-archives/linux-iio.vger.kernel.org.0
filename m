Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F767A69FF
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjISRuL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjISRuH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:07 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7698BBF
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:50:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierB-0006ZI-3o; Tue, 19 Sep 2023 19:49:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierA-007VWv-Iz; Tue, 19 Sep 2023 19:49:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierA-0034Xz-8V; Tue, 19 Sep 2023 19:49:52 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 23/49] iio: adc: stm32-dfsdm-core: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:49:05 +0200
Message-Id: <20230919174931.1417681-24-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2001; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Odd+RR/837MbYsuNsjeIILdO7UZ1l2djK0pXJyvvXZY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCd8JhnGrgHxpbOtocYCzcmAv0UfW0RNx5SRtn ms407trrqmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQnfCQAKCRCPgPtYfRL+ Tnb/B/0T7M+EoxRTfYd4HzCi4fKQ9VAJh/8vm7CHs8ueNMkZDeaQ5AlHb82E0Z1TY81AwiyYxjK PrISBLIgClRTlT/7ePynekBXnDrnOeac2jV45A/Rv35clsVuJfFmpoWB6cC9/7Q03jIwcupExWE Eihzqi0UplRv9Z0EXi5mvNCOQkJtVQ+3YxflvngX67PJ4Yr5LyZq7aRUDci/X0oCSJpzlzYgsGL W/QJeeDHcbbOPPBVwK+YJJ0RXjEclxf2Hi+Xw22W4bd0agJ3K1GLhpniYvXMfzySQo5zeNuD6Yj aAYmIPmSQKArdaMDxmQl0lZPqebMn3mX4UA/qSd+FtJ8YBnG
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
 drivers/iio/adc/stm32-dfsdm-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
index 0f6ebb3061a0..a05d978b8cb8 100644
--- a/drivers/iio/adc/stm32-dfsdm-core.c
+++ b/drivers/iio/adc/stm32-dfsdm-core.c
@@ -436,7 +436,7 @@ static int stm32_dfsdm_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int stm32_dfsdm_core_remove(struct platform_device *pdev)
+static void stm32_dfsdm_core_remove(struct platform_device *pdev)
 {
 	struct stm32_dfsdm *dfsdm = platform_get_drvdata(pdev);
 
@@ -446,8 +446,6 @@ static int stm32_dfsdm_core_remove(struct platform_device *pdev)
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 	stm32_dfsdm_clk_disable_unprepare(dfsdm);
-
-	return 0;
 }
 
 static int stm32_dfsdm_core_suspend(struct device *dev)
@@ -508,7 +506,7 @@ static const struct dev_pm_ops stm32_dfsdm_core_pm_ops = {
 
 static struct platform_driver stm32_dfsdm_driver = {
 	.probe = stm32_dfsdm_probe,
-	.remove = stm32_dfsdm_core_remove,
+	.remove_new = stm32_dfsdm_core_remove,
 	.driver = {
 		.name = "stm32-dfsdm",
 		.of_match_table = stm32_dfsdm_of_match,
-- 
2.40.1

