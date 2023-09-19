Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F27F7A6A19
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjISRuT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbjISRuM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:12 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA39C9
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:50:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierH-0006yJ-9x; Tue, 19 Sep 2023 19:49:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierG-007VYM-6r; Tue, 19 Sep 2023 19:49:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierF-0034ZP-Tv; Tue, 19 Sep 2023 19:49:57 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org,
        chrome-platform@lists.linux.dev, kernel@pengutronix.de
Subject: [PATCH 45/49] iio: proximity: cros_ec_mkbp: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:49:27 +0200
Message-Id: <20230919174931.1417681-46-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2043; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Kp2v2YhzJfVr5H9XEO3mwXm1/ylDiUj0N7nPU5I2scs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCd8iJyVBF+bUIHN3NYHUoI8iY6lHHMLw8oFCN rFZcOUyioOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQnfIgAKCRCPgPtYfRL+ TjP1CACNbj+Dh/TqsOnkjiGevQNvyfkgkkAFNtx+IwEodJp/Q4aKmd2BEqTucxhws3JWq9lsQ3Z VwirrbKbZifw6bCpJmeuSrpL+anacMu3na+IU7SJek4XRE8SChsvAk6ZzA6dc+KpkVJvv8TrMi+ 6Voni5VKdSSUgwn0YuJj0NWWeM6d9CwFH+t5vjcUeEgwQdGXytxFPO+K5cbdApnQGs/NUSYsfkF RvBgrlQEK8OsflQbXp+N1IR6RMII21eWSmTuDVU9v9ALjdLHxrdV3b8eORUpSsXhLqicpvqmXxt aCCSOMey5sfl4JoMUf9ZKrTcaLhqvehxN0+n4yGGc+UKBbgl
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
 drivers/iio/proximity/cros_ec_mkbp_proximity.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/cros_ec_mkbp_proximity.c b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
index 571ea1812246..4df506bb8b38 100644
--- a/drivers/iio/proximity/cros_ec_mkbp_proximity.c
+++ b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
@@ -239,15 +239,13 @@ static int cros_ec_mkbp_proximity_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int cros_ec_mkbp_proximity_remove(struct platform_device *pdev)
+static void cros_ec_mkbp_proximity_remove(struct platform_device *pdev)
 {
 	struct cros_ec_mkbp_proximity_data *data = platform_get_drvdata(pdev);
 	struct cros_ec_device *ec = data->ec;
 
 	blocking_notifier_chain_unregister(&ec->event_notifier,
 					   &data->notifier);
-
-	return 0;
 }
 
 static const struct of_device_id cros_ec_mkbp_proximity_of_match[] = {
@@ -263,7 +261,7 @@ static struct platform_driver cros_ec_mkbp_proximity_driver = {
 		.pm = pm_sleep_ptr(&cros_ec_mkbp_proximity_pm_ops),
 	},
 	.probe = cros_ec_mkbp_proximity_probe,
-	.remove = cros_ec_mkbp_proximity_remove,
+	.remove_new = cros_ec_mkbp_proximity_remove,
 };
 module_platform_driver(cros_ec_mkbp_proximity_driver);
 
-- 
2.40.1

