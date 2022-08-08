Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C187B58CF5A
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 22:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243020AbiHHUsI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 16:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244255AbiHHUsE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 16:48:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F93AE44
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 13:48:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9fE-00046G-90; Mon, 08 Aug 2022 22:47:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9f9-002ZZW-Ao; Mon, 08 Aug 2022 22:47:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9fA-00ARBt-Oy; Mon, 08 Aug 2022 22:47:48 +0200
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
Subject: [PATCH 13/13] iio: imu: adis16475: Benefit from devm_clk_get_enabled() to simplify
Date:   Mon,  8 Aug 2022 22:47:40 +0200
Message-Id: <20220808204740.307667-13-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
References: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1479; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=mesiVR7V6YHiAtxlfdRN9GTwpshIJEXhF3uj276VGmE=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi8XZpPFiK8j6zlX9wZroTuk4p5ND1o+eHXhcXHBWB pklEy8aJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYvF2aQAKCRDB/BR4rcrsCdTOB/ 9KT1Os1viGW1RcGwgXzAa0Y7XgQ+yf1bN6ka0ro7zDV3BepKQM2cdmYf1o1PN6Iom+r5Xu0RLcSeOe qcySPGQeDV/Bj8HJZfQgBZtP4TnxxeQI2UvfUogpGljN713yvTWq+xuqnKrs29mke+1aSHilgR6Cy+ DaQQi9m+hvDkbH8TPriP4NyQr6Ut/IZic+2yTkJ6j3e34H4Rphmbh0WIXZNecCh2ocQSqdlOh/r4Iv Em/wT2jHiO349z0T3tApTmSiW33r7KN5eXotNrhY76MIOahMvTxKEPAA6zxckrVHX6UP7OPpIGsws6 yola1w3oKKW4pKkRzO06QEpdScuUz+
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
 drivers/iio/imu/adis16475.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index ff2b0fab840a..aec55f7e1f26 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -1120,11 +1120,6 @@ static irqreturn_t adis16475_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-static void adis16475_disable_clk(void *data)
-{
-	clk_disable_unprepare((struct clk *)data);
-}
-
 static int adis16475_config_sync_mode(struct adis16475 *st)
 {
 	int ret;
@@ -1150,19 +1145,11 @@ static int adis16475_config_sync_mode(struct adis16475 *st)
 
 	/* All the other modes require external input signal */
 	if (sync->sync_mode != ADIS16475_SYNC_OUTPUT) {
-		struct clk *clk = devm_clk_get(dev, NULL);
+		struct clk *clk = devm_clk_get_enabled(dev, NULL);
 
 		if (IS_ERR(clk))
 			return PTR_ERR(clk);
 
-		ret = clk_prepare_enable(clk);
-		if (ret)
-			return ret;
-
-		ret = devm_add_action_or_reset(dev, adis16475_disable_clk, clk);
-		if (ret)
-			return ret;
-
 		st->clk_freq = clk_get_rate(clk);
 		if (st->clk_freq < sync->min_rate ||
 		    st->clk_freq > sync->max_rate) {
-- 
2.36.1

