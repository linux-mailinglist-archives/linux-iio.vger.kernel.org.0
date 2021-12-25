Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660F847F3C0
	for <lists+linux-iio@lfdr.de>; Sat, 25 Dec 2021 17:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbhLYQLS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Dec 2021 11:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbhLYQLR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Dec 2021 11:11:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501EEC061401
        for <linux-iio@vger.kernel.org>; Sat, 25 Dec 2021 08:11:16 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dY-0008Dv-Nr; Sat, 25 Dec 2021 17:11:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dU-006ahc-RO; Sat, 25 Dec 2021 17:11:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dT-0007hj-R4; Sat, 25 Dec 2021 17:11:07 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        kernel@pengutronix.de, Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH v1 21/23] counter: stm32-lptimer-cnt: Convert to new counter registration
Date:   Sat, 25 Dec 2021 17:10:54 +0100
Message-Id: <20211225161056.682797-22-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
References: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=3ifQeCGsrN8bDZ+8L0RwjEjBBqDg0yaW9Y6socn1Xa8=; m=bh1D/32vqT5ZQCdwe9S838jSJgWgolNVHJYJDwXN/TI=; p=pJzg69aNue7hAcBVfXoVSTVMsFTFo3LAeRjoB3UydzI=; g=836db4a11bf0dbaa143b374b2fe2833ce5e5b8ab
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHHQn8ACgkQwfwUeK3K7An+rwf+IpS JALPaFzwIHo4aLpFolHfxg8MH9vWSoEJ1cp0YQhjz8M3CQOfyPBC0AJk0UbhY+N2ZbPDx4jO3XHSh 4RQhwShUbti1I+y3nfFIABZzPepwZyeAayzJ5PaWUOuWf+ieCBu8vpBn1p6ikrbWkQKU3zf4UDIJs 6DZZzYbvuzAK7TfwT8xuGmkrcceOYMotIULtJtiVw/coBaMS8CCQxkHe1J52RpWvNn1zLYMkDNDTk hV4ImdqZVsiGNSZCVdP2cIiOQbs6Z+o6oXI9EPTlhJ8DV4BAnBE9V5x3iJco5ZTeDh/UwM0YlU5cF iEZiUPFZEeUDVtMiN4UULVbOX5cVNjw==
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
2.33.0

