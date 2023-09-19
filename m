Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261AE7A6A22
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjISRuP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbjISRuJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:09 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF89A8F
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:50:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierE-0006oc-D5; Tue, 19 Sep 2023 19:49:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierD-007VXW-97; Tue, 19 Sep 2023 19:49:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierD-0034Yd-08; Tue, 19 Sep 2023 19:49:55 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 33/49] iio: dac: vf610: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:49:15 +0200
Message-Id: <20230919174931.1417681-34-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1973; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=MVk8cFwmCeuzb4vrNFzwZpK7yJ7lGWzGAMEQK5pN6Tg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCd8UiHkNcaY5TAV6FuP9nz+IOyzVaksC3SPoX Z8+P7lMArKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQnfFAAKCRCPgPtYfRL+ TsdzCACRoYsvdpY73L0XPXVVziwT9uOgVaouXrdPk6BygNILZP+k2oySQ/LPmO4oDZFLWYyH6QE YvfpDZVzFHa7LU1RQ9+pYyhf3NjqRsELXrn3s7rr7INF3Vjmo8caSkNOi24i/67O6XI9RzDU8To WNT7yCN1ZlxHuYvb4ENx17KJiZJHs3QN8O2S3Gxa9L6KJ//pvBzBrpMkKLG8LADLtDKVv2Xcnjv 0jH2q1bKAGLGlBNvVTBWKV5/g06ppGYyqw62jAIKclukadKxmAY4ifqRajyoBe1/OXoPzdEf71k y8M1/MyUyhTyGZkjh8RBAkQvN2qywjlIeF4lNkkJCZ0XNv7s
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
 drivers/iio/dac/vf610_dac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/vf610_dac.c b/drivers/iio/dac/vf610_dac.c
index fc182250c622..de73bc5a1c93 100644
--- a/drivers/iio/dac/vf610_dac.c
+++ b/drivers/iio/dac/vf610_dac.c
@@ -231,7 +231,7 @@ static int vf610_dac_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int vf610_dac_remove(struct platform_device *pdev)
+static void vf610_dac_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct vf610_dac *info = iio_priv(indio_dev);
@@ -239,8 +239,6 @@ static int vf610_dac_remove(struct platform_device *pdev)
 	iio_device_unregister(indio_dev);
 	vf610_dac_exit(info);
 	clk_disable_unprepare(info->clk);
-
-	return 0;
 }
 
 static int vf610_dac_suspend(struct device *dev)
@@ -274,7 +272,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(vf610_dac_pm_ops, vf610_dac_suspend,
 
 static struct platform_driver vf610_dac_driver = {
 	.probe          = vf610_dac_probe,
-	.remove         = vf610_dac_remove,
+	.remove_new     = vf610_dac_remove,
 	.driver         = {
 		.name   = "vf610-dac",
 		.of_match_table = vf610_dac_match,
-- 
2.40.1

