Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5AF58CF5E
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 22:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244290AbiHHUsP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 16:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244298AbiHHUsE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 16:48:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D2BB1DA
        for <linux-iio@vger.kernel.org>; Mon,  8 Aug 2022 13:48:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9fH-00046F-4P; Mon, 08 Aug 2022 22:47:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9f9-002ZZT-01; Mon, 08 Aug 2022 22:47:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oL9fA-00ARBo-IK; Mon, 08 Aug 2022 22:47:48 +0200
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
Subject: [PATCH 12/13] iio: frequency: adrf6780: Benefit from devm_clk_get_enabled() to simplify
Date:   Mon,  8 Aug 2022 22:47:39 +0200
Message-Id: <20220808204740.307667-12-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
References: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1533; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=cQhDZ8E0u+8jl/B5kp8w0i/1LWWH9ucHePlXeQ3g8ms=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi8XZlrPGrzb1Cn9uL2NNJdwQqqYL6IBv/5hSpvJuh YYbhYwaJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYvF2ZQAKCRDB/BR4rcrsCdtqB/ 9JaaPW6rjkqnIsO8mrrPJYfpywc7EsxfP6obww58+OspyhO6N5fME4uvbc4QS6az9QrFWtc+AfI+XJ Lb+dCh8MGmJesmwixBe2ewm42Tp/pPOrctbJeeqdHuR+TMBiiq7J2ZsCtqS07QxmeQrN/pSX/DPK2j 4ER+7eEGW94CC65MdB1qLLYN7Agb8YATHweZKBe8PhZLShXQs9NPGWO8zFFakkpQTtSaEVB98760/w LZyK2XIsNxcS+UdrcVjTNtclNHQFu/A8WLOwW5F3CX/3Aw58Bb7gPivuxonqe2oD7Nhl9udhr20oEq Ns2YFCBf4Nv7u6FCJZvVDNmVdO/mPm
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
 drivers/iio/frequency/adrf6780.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/iio/frequency/adrf6780.c b/drivers/iio/frequency/adrf6780.c
index 8255ffd174f6..d7bf34ceedd8 100644
--- a/drivers/iio/frequency/adrf6780.c
+++ b/drivers/iio/frequency/adrf6780.c
@@ -441,11 +441,6 @@ static void adrf6780_properties_parse(struct adrf6780_state *st)
 	st->vdet_out_en = device_property_read_bool(&spi->dev, "adi,vdet-out-en");
 }
 
-static void adrf6780_clk_disable(void *data)
-{
-	clk_disable_unprepare(data);
-}
-
 static void adrf6780_powerdown(void *data)
 {
 	/* Disable all components in the Enable Register */
@@ -473,20 +468,11 @@ static int adrf6780_probe(struct spi_device *spi)
 
 	adrf6780_properties_parse(st);
 
-	st->clkin = devm_clk_get(&spi->dev, "lo_in");
+	st->clkin = devm_clk_get_enabled(&spi->dev, "lo_in");
 	if (IS_ERR(st->clkin))
 		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
 				     "failed to get the LO input clock\n");
 
-	ret = clk_prepare_enable(st->clkin);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(&spi->dev, adrf6780_clk_disable,
-				       st->clkin);
-	if (ret)
-		return ret;
-
 	mutex_init(&st->lock);
 
 	ret = adrf6780_init(st);
-- 
2.36.1

