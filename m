Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C397A69F8
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjISRuJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbjISRuG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:06 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B14C8F
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:50:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier9-0006UC-Tr; Tue, 19 Sep 2023 19:49:51 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier8-007VWX-V4; Tue, 19 Sep 2023 19:49:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qier8-0034Xb-Ls; Tue, 19 Sep 2023 19:49:50 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Lars-Peter Clausen <lars@metafoo.de>, openbmc@lists.ozlabs.org,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 17/49] iio: adc: npcm: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:48:59 +0200
Message-Id: <20230919174931.1417681-18-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1792; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=+d0cPaCaU/WWOivdiqsSJ1LmcZHrlbSQQORSLo9taac=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCd8C0+5IHUbxwzaDaql4FpQ2zC697FU7r8PAe Oe0cJ1pks2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQnfAgAKCRCPgPtYfRL+ TucuB/43f+LaPNEq2ODcy0dMxc0mi/ZVMNbCKNl2MDI3snKQ0NySoWGKDxfQWZD7ej0G6aAeEo5 6uE/b3/yhIHgRLdgh8dEeJ+0InePdpmiBIxJ9NV4LCEfZJJQGbHwy9/ERxpnHqk/YqFn74z9AJE 0X51IRodV0Rhg18McM5I3uGZ1t0sG1XfAyamvcj3FbgCZdrogZ00li6+s8g1jecVveLf+R0PdXi e6uxg4ta6peqOpNQb6jnPjEwPNatOABCNqcDpijg3ZkdHCC5VW4ytceQ8PE3Fq4BGFGe7DnqQJ3 eX9FTxSubMzIjgLCaIUGn4uMzBHNaDIuSD6CHXCtr518FhCJ
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
 drivers/iio/adc/npcm_adc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
index 3d9207c160eb..3a55465951e7 100644
--- a/drivers/iio/adc/npcm_adc.c
+++ b/drivers/iio/adc/npcm_adc.c
@@ -320,7 +320,7 @@ static int npcm_adc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int npcm_adc_remove(struct platform_device *pdev)
+static void npcm_adc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct npcm_adc *info = iio_priv(indio_dev);
@@ -333,13 +333,11 @@ static int npcm_adc_remove(struct platform_device *pdev)
 	if (!IS_ERR(info->vref))
 		regulator_disable(info->vref);
 	clk_disable_unprepare(info->adc_clk);
-
-	return 0;
 }
 
 static struct platform_driver npcm_adc_driver = {
 	.probe		= npcm_adc_probe,
-	.remove		= npcm_adc_remove,
+	.remove_new	= npcm_adc_remove,
 	.driver		= {
 		.name	= "npcm_adc",
 		.of_match_table = npcm_adc_match,
-- 
2.40.1

