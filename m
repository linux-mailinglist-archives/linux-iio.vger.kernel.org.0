Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA42481D6D
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 16:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241051AbhL3PDU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 10:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240710AbhL3PDL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 10:03:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA79EC061574
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 07:03:11 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxR-0000ey-Ev; Thu, 30 Dec 2021 16:03:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxQ-007VLf-Ey; Thu, 30 Dec 2021 16:03:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxP-0007k5-7D; Thu, 30 Dec 2021 16:03:07 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 21/23] counter: stm32-lptimer-cnt: Convert to new counter registration
Date:   Thu, 30 Dec 2021 16:02:58 +0100
Message-Id: <20211230150300.72196-22-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
References: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2830; h=from:subject; bh=Z30Y5klYFwnFI5jJS4Jj6GD8bn4cD3tqmAq9j/Gq+4c=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBhzcmzcwTnYraxEudTA2g4uyLsOHdO8G35dTdIsTc6 TGeqWNSJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYc3JswAKCRDB/BR4rcrsCbTsB/ 4sHcSMVx026q0hGj12f7lLbPCtyoOL0yHuhBXYyYgkwJt08N9b4tg5tQhkY1h4SF7gRzeYF9TwQXC+ aYeKBBnNjx+b0IOgqnvq3lH4QyrIPDZCYteD3o2e8GJE3air52PqqIrym1p4MFKgOoKig12LBH5ThF wON8fqwPZpE/Wp3IKbZhnRIJhqHPF92cuRpxk5w+NJj5lIi24HE9Z2ps4ODIqFg//kdRVpsJnOrE68 qptifsgVFn1hxobcKrQx3nCQ8VGY1eh4Li52yoO9YaElTpfYoZqXlgiStBWq52PjbU9FHwW2XKGhRo Y6pk5JxaCZdpvf5PZwkSBLb6e0HP0E
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This fixes device lifetime issues where it was possible to free a live
struct device.

Fixes: 597f55e3f36c ("counter: stm32-lptimer: add counter device")
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/stm32-lptimer-cnt.c | 33 +++++++++++++++++------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
index 9cf00e929cc0..68031d93ce89 100644
--- a/drivers/counter/stm32-lptimer-cnt.c
+++ b/drivers/counter/stm32-lptimer-cnt.c
@@ -20,7 +20,6 @@
 #include <linux/types.h>
 
 struct stm32_lptim_cnt {
-	struct counter_device counter;
 	struct device *dev;
 	struct regmap *regmap;
 	struct clk *clk;
@@ -411,14 +410,17 @@ static struct counter_count stm32_lptim_in1_counts = {
 static int stm32_lptim_cnt_probe(struct platform_device *pdev)
 {
 	struct stm32_lptimer *ddata = dev_get_drvdata(pdev->dev.parent);
+	struct counter_device *counter;
 	struct stm32_lptim_cnt *priv;
+	int ret;
 
 	if (IS_ERR_OR_NULL(ddata))
 		return -EINVAL;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
+	counter = devm_counter_alloc(&pdev->dev, sizeof(*priv));
+	if (!counter)
 		return -ENOMEM;
+	priv = counter_priv(counter);
 
 	priv->dev = &pdev->dev;
 	priv->regmap = ddata->regmap;
@@ -426,23 +428,26 @@ static int stm32_lptim_cnt_probe(struct platform_device *pdev)
 	priv->ceiling = STM32_LPTIM_MAX_ARR;
 
 	/* Initialize Counter device */
-	priv->counter.name = dev_name(&pdev->dev);
-	priv->counter.parent = &pdev->dev;
-	priv->counter.ops = &stm32_lptim_cnt_ops;
+	counter->name = dev_name(&pdev->dev);
+	counter->parent = &pdev->dev;
+	counter->ops = &stm32_lptim_cnt_ops;
 	if (ddata->has_encoder) {
-		priv->counter.counts = &stm32_lptim_enc_counts;
-		priv->counter.num_signals = ARRAY_SIZE(stm32_lptim_cnt_signals);
+		counter->counts = &stm32_lptim_enc_counts;
+		counter->num_signals = ARRAY_SIZE(stm32_lptim_cnt_signals);
 	} else {
-		priv->counter.counts = &stm32_lptim_in1_counts;
-		priv->counter.num_signals = 1;
+		counter->counts = &stm32_lptim_in1_counts;
+		counter->num_signals = 1;
 	}
-	priv->counter.num_counts = 1;
-	priv->counter.signals = stm32_lptim_cnt_signals;
-	priv->counter.priv = priv;
+	counter->num_counts = 1;
+	counter->signals = stm32_lptim_cnt_signals;
 
 	platform_set_drvdata(pdev, priv);
 
-	return devm_counter_register(&pdev->dev, &priv->counter);
+	ret = devm_counter_add(&pdev->dev, counter);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "Failed to add counter\n");
+
+	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.34.1

