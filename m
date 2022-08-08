Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B272758CF5F
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 22:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244255AbiHHUsQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 16:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244331AbiHHUsE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 16:48:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE10B1EC
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 13:48:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9fG-00046E-UW; Mon, 08 Aug 2022 22:47:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9f8-002ZZQ-PN; Mon, 08 Aug 2022 22:47:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9fA-00ARBl-CB; Mon, 08 Aug 2022 22:47:48 +0200
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
Subject: [PATCH 11/13] iio: frequency: admv1013: Benefit from devm_clk_get_enabled() to simplify
Date:   Mon,  8 Aug 2022 22:47:38 +0200
Message-Id: <20220808204740.307667-11-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
References: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1684; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=+IQmTHHsLQggEJn1lKUhtzC5PhH/00fSr6vbteKf01A=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi8XZhskIAjqSkpgABGnj5jqgowtpcHCofjxNc3SXW 2Y/+uk6JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYvF2YQAKCRDB/BR4rcrsCS/DCA CA/PaAMHdhh0JbsTI9OuhXmYfOqHkAdZGgGPdvGRms5/J18TggGd8MJGRFVWkO+U22UdhGxOO9pLrn 025+zMUbIJgmAK4IDzIBGFggaLX0Cept8Rvntqn4S8VeYttVoyymM8ajfIS68dKOTyzmnPWCXwEJpP PzXgX3+bmTf+tdo4iY/MfqdJDdDAOHkN/8gaDtBi+33z3cGse/+v3afMFk2QkdL9bUZaJyPQmXza4P 95jFQlHt0zxIpaWUvOLaLO9FBWqlxz8rUBXffpgvBnzohT7jAn5gsmJatPDozQcyHZ8+htRFg7OC6X g/xzwTm779+kwfliq1EB0kX+KnaF1L
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
 drivers/iio/frequency/admv1013.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
index b0e1f6571afb..1346d77df77f 100644
--- a/drivers/iio/frequency/admv1013.c
+++ b/drivers/iio/frequency/admv1013.c
@@ -490,11 +490,6 @@ static int admv1013_init(struct admv1013_state *st)
 					  st->input_mode);
 }
 
-static void admv1013_clk_disable(void *data)
-{
-	clk_disable_unprepare(data);
-}
-
 static void admv1013_reg_disable(void *data)
 {
 	regulator_disable(data);
@@ -559,7 +554,7 @@ static int admv1013_properties_parse(struct admv1013_state *st)
 		return dev_err_probe(&spi->dev, PTR_ERR(st->reg),
 				     "failed to get the common-mode voltage\n");
 
-	st->clkin = devm_clk_get(&spi->dev, "lo_in");
+	st->clkin = devm_clk_get_enabled(&spi->dev, "lo_in");
 	if (IS_ERR(st->clkin))
 		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
 				     "failed to get the LO input clock\n");
@@ -601,14 +596,6 @@ static int admv1013_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(st->clkin);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(&spi->dev, admv1013_clk_disable, st->clkin);
-	if (ret)
-		return ret;
-
 	st->nb.notifier_call = admv1013_freq_change;
 	ret = devm_clk_notifier_register(&spi->dev, st->clkin, &st->nb);
 	if (ret)
-- 
2.36.1

