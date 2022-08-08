Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3552358CF57
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 22:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238714AbiHHUsH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 16:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244222AbiHHUsE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 16:48:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D264C63A7
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 13:48:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9fE-00046C-8y; Mon, 08 Aug 2022 22:47:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9f8-002ZZE-EJ; Mon, 08 Aug 2022 22:47:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9fA-00ARBd-0S; Mon, 08 Aug 2022 22:47:48 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 09/13] iio: adc: xilinx-xadc: Benefit from devm_clk_get_enabled() to simplify
Date:   Mon,  8 Aug 2022 22:47:36 +0200
Message-Id: <20220808204740.307667-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
References: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1487; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Cen+BnX+Gka/l32eMMXQv6nBCxob9Rhniotz6JjoQfk=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi8XZZK81bZN86tBgoyuaxx+QFNpfrGGg7sVsi3A4W Mjb5oSOJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYvF2WQAKCRDB/BR4rcrsCZsoB/ 0R65mc9cPcrP6hkbd0cwpPDNq5wy13DTVGnrnmCCwDzg6c4Xoa0YlaDIbZ2nE+OJzyGL6mOwsllA9G Akn/KDIr4I2FIO/+opwX71ppX0fihYpPFRLxn97oz/+XWYXe0kfKvP1JaNTZr3m/98WcgJ5AoR1rpk KkV5+qjaWPqvx8xt4Wr8dg+jUo+oYz10JchxD+vAZQa2mvRJgc95qFLKokVlbniQBW4QcOb2khDTWk wh7djLdv+cq1M3961rKtmU2pIvh4+R0YyWONdDTcoRwYJA5XYZGEN5Wlzg37wdmzOzfjMrUDkgynIu XWq6gQkwXRueJMZX5aJkIZE6YsAYaq
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Make use of devm_clk_get_enabled() to replace some code that effectively
open codes this new function.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/adc/xilinx-xadc-core.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 823c8e5f9809..a520e07e4e08 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1299,13 +1299,6 @@ static const char * const xadc_type_names[] = {
 	[XADC_TYPE_US] = "xilinx-system-monitor",
 };
 
-static void xadc_clk_disable_unprepare(void *data)
-{
-	struct clk *clk = data;
-
-	clk_disable_unprepare(clk);
-}
-
 static void xadc_cancel_delayed_work(void *data)
 {
 	struct delayed_work *work = data;
@@ -1383,19 +1376,10 @@ static int xadc_probe(struct platform_device *pdev)
 		}
 	}
 
-	xadc->clk = devm_clk_get(dev, NULL);
+	xadc->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(xadc->clk))
 		return PTR_ERR(xadc->clk);
 
-	ret = clk_prepare_enable(xadc->clk);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(dev,
-				       xadc_clk_disable_unprepare, xadc->clk);
-	if (ret)
-		return ret;
-
 	/*
 	 * Make sure not to exceed the maximum samplerate since otherwise the
 	 * resulting interrupt storm will soft-lock the system.
-- 
2.36.1

