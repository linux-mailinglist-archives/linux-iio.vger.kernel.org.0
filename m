Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747017A6A20
	for <lists+linux-iio@lfdr.de>; Tue, 19 Sep 2023 19:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbjISRuR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 13:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbjISRuL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 13:50:11 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB33BC
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 10:50:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierH-000743-H5; Tue, 19 Sep 2023 19:49:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierG-007VYY-VE; Tue, 19 Sep 2023 19:49:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qierG-0034Zb-Lc; Tue, 19 Sep 2023 19:49:58 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 48/49] iio: trigger: iio-trig-interrupt: Convert to platform remove callback returning void
Date:   Tue, 19 Sep 2023 19:49:30 +0200
Message-Id: <20230919174931.1417681-49-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
References: <20230919174931.1417681-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1890; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=uwdm9cfJTfrYI4M4wti3TqLuKQrRP2PkegH/yRNGUco=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCd8luSjNOcFpcWhyfeoh7Wh1n8yVlWEio84oX YTc9r/eUa2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQnfJQAKCRCPgPtYfRL+ ToKeB/0Sv9Mwr1fOV3UrBOqAGmaKvaZq2TKZ1UhUzflU82nteOnwqDpHqSK/u4DVKzfeOC6AFwS a/xBYt+XZKEkkjwarTUEWTBk+F2Qzc01l9dNdmX9m6Oy485IcTc9bFC5SE7TxrHaZGYISl7Ytky 8dC8lSlaF7WFHLCo06ag+HIof64x4fSAo/yic8+WqOiygpbE/LNVS5VGi7ldwPDi3Zxzy6wcW3U kJhfRJukGf6j/8jI61lYp3L/wnHSCxqVxbf60kCGqSTK37b7lmQEGQDD5EDKkCilOso5ux8cjI2 he5AQcVtp3iVc8W5owiIur4Grr59tDxdr4gAUJ8w09M++Ygg
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
 drivers/iio/trigger/iio-trig-interrupt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/trigger/iio-trig-interrupt.c b/drivers/iio/trigger/iio-trig-interrupt.c
index 5f49cd105fae..dec256bfbd73 100644
--- a/drivers/iio/trigger/iio-trig-interrupt.c
+++ b/drivers/iio/trigger/iio-trig-interrupt.c
@@ -81,7 +81,7 @@ static int iio_interrupt_trigger_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int iio_interrupt_trigger_remove(struct platform_device *pdev)
+static void iio_interrupt_trigger_remove(struct platform_device *pdev)
 {
 	struct iio_trigger *trig;
 	struct iio_interrupt_trigger_info *trig_info;
@@ -92,13 +92,11 @@ static int iio_interrupt_trigger_remove(struct platform_device *pdev)
 	free_irq(trig_info->irq, trig);
 	kfree(trig_info);
 	iio_trigger_free(trig);
-
-	return 0;
 }
 
 static struct platform_driver iio_interrupt_trigger_driver = {
 	.probe = iio_interrupt_trigger_probe,
-	.remove = iio_interrupt_trigger_remove,
+	.remove_new = iio_interrupt_trigger_remove,
 	.driver = {
 		.name = "iio_interrupt_trigger",
 	},
-- 
2.40.1

