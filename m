Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5D66B8136
	for <lists+linux-iio@lfdr.de>; Mon, 13 Mar 2023 19:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjCMSzO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Mar 2023 14:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjCMSyy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2023 14:54:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912E777C87
        for <linux-iio@vger.kernel.org>; Mon, 13 Mar 2023 11:53:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbnIf-0005Kc-NC; Mon, 13 Mar 2023 19:53:37 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbnIe-003uRY-0f; Mon, 13 Mar 2023 19:53:36 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbnId-004cTW-DV; Mon, 13 Mar 2023 19:53:35 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2] iio: frequency: admv1013: Benefit from devm_clk_get_enabled() to simplify
Date:   Mon, 13 Mar 2023 19:53:33 +0100
Message-Id: <20230313185333.2776785-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2337; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=pzGVyHCbLq4BupO3KybW+Gupoqc1RXoJAFLS7A4hdM4=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkD3EpOWaEzTbeSn0Y5G7j9HktwEpmtTCfkhOMh YFdo/0RuImJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZA9xKQAKCRDB/BR4rcrs CTQGB/0R1AIatw81fQwjImY3Bod5i6R8KbbJsr0mgdrZamkxAZFBKj+YYOYz3w3ynRySXcOIWEs X9J6iKIjutfv06vSMizuUQInJc+LkVyHI+XLbunMghJTPwQylDPXDokcsKMW9PC1EgWzUj4IEwv e2mzcm1uawCr7FfcIhI6FfXV3SH8bx91s4GPb7Iux+GYWuROjpHk3Wvb5BQgWaxbMjAIuwg+8U1 S3BC9p6tsk6MHAweY+C7hEPOxBDt0TK8H0WuDA3GczdITwaZUOQjfM1nTUCFRyne641PeGZyyVR lbTsdpf3cIxgzK0H3Y6EYDtpX/1VjZfqzox8QzEBxeBtbiYA
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Make use of devm_clk_get_enabled() to replace some code that effectively
open codes this new function.

To retain ordering move the request to a place that is executed later.
This way the time of enable keeps the same.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

(implicit) v1 of this patch was part of a bigger series some time
ago[1].

In v1 the call to devm_clk_get_enabled() was where devm_clk_get used to
be. Jonathan had the valid concern that this changes ordering which
might introduce subtle regressions. Andy suggested to move the call to
the later place.

Best regards
Uwe

[1] https://lore.kernel.org/linux-iio/20220808204740.307667-11-u.kleine-koenig@pengutronix.de

 drivers/iio/frequency/admv1013.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
index ed8167271358..9bf8337806fc 100644
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
@@ -559,11 +554,6 @@ static int admv1013_properties_parse(struct admv1013_state *st)
 		return dev_err_probe(&spi->dev, PTR_ERR(st->reg),
 				     "failed to get the common-mode voltage\n");
 
-	st->clkin = devm_clk_get(&spi->dev, "lo_in");
-	if (IS_ERR(st->clkin))
-		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
-				     "failed to get the LO input clock\n");
-
 	return 0;
 }
 
@@ -601,13 +591,10 @@ static int admv1013_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = clk_prepare_enable(st->clkin);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(&spi->dev, admv1013_clk_disable, st->clkin);
-	if (ret)
-		return ret;
+	st->clkin = devm_clk_get_enabled(&spi->dev, "lo_in");
+	if (IS_ERR(st->clkin))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
+				     "failed to get the LO input clock\n");
 
 	st->nb.notifier_call = admv1013_freq_change;
 	ret = devm_clk_notifier_register(&spi->dev, st->clkin, &st->nb);
-- 
2.39.1

