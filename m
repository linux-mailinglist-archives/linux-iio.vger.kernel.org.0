Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211E47A6A08
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjISRuS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbjISRuL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:11 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5718F
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:50:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierH-00070b-Ei; Tue, 19 Sep 2023 19:49:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierG-007VYQ-H7; Tue, 19 Sep 2023 19:49:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierG-0034ZT-8B; Tue, 19 Sep 2023 19:49:58 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andreas Klinger <ak@it-klinger.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 46/49] iio: proximity: srf04: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:49:28 +0200
Message-Id: <20230919174931.1417681-47-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1894; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=FpcatRTvWlM5Ia3C7jqp3+eLPJG46k4KUMMlpmAiVSA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCd8jtGVWQbDlgkJRnHuGynA7sCl7SAP60tTmD X6YzCFTcYaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQnfIwAKCRCPgPtYfRL+ TmcXB/9wvKwfJeZZzwM13/ZzjdwmA6mdzXTzeGre7m7bXpwpnPAh0xZMziHlAfQgeqmyrQnAmps kW4I5CYwrlO5U6Gh5+FERdEybJb43t3Q/yWajyZ0mzk2ov/FMtKMN8SejCRs9g1y/n6iAtQTu5h 4tbEZyI4OyCG5VyuiGW49eUQZrVNAUGOFcHaZeJHCYSxqN203q0tQHdoXFNwgPpNL9zovGXAZHb iBd+HN34qY33mIK2wpf6Ofk2BFsPpfXDkF7Yb7Bi3HSigLiMlCi52ngz090iYJWeKi9EIQ9Mcb7 GCWVLfa8157HSbabKa86681q8wZMS7SeYPI3mlk4Cv7CG2cf
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
 drivers/iio/proximity/srf04.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
index faf2f806ce80..86c57672fc7e 100644
--- a/drivers/iio/proximity/srf04.c
+++ b/drivers/iio/proximity/srf04.c
@@ -344,7 +344,7 @@ static int srf04_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int srf04_remove(struct platform_device *pdev)
+static void srf04_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct srf04_data *data = iio_priv(indio_dev);
@@ -355,8 +355,6 @@ static int srf04_remove(struct platform_device *pdev)
 		pm_runtime_disable(data->dev);
 		pm_runtime_set_suspended(data->dev);
 	}
-
-	return 0;
 }
 
 static int  srf04_pm_runtime_suspend(struct device *dev)
@@ -391,7 +389,7 @@ static const struct dev_pm_ops srf04_pm_ops = {
 
 static struct platform_driver srf04_driver = {
 	.probe		= srf04_probe,
-	.remove		= srf04_remove,
+	.remove_new	= srf04_remove,
 	.driver		= {
 		.name		= "srf04-gpio",
 		.of_match_table	= of_srf04_match,
-- 
2.40.1

