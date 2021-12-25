Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE85347F3C1
	for <lists+linux-iio@lfdr.de>; Sat, 25 Dec 2021 17:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbhLYQLS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Dec 2021 11:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbhLYQLR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Dec 2021 11:11:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CF3C061757
        for <linux-iio@vger.kernel.org>; Sat, 25 Dec 2021 08:11:16 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dY-0008Dr-Nv; Sat, 25 Dec 2021 17:11:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dU-006ahb-Jf; Sat, 25 Dec 2021 17:11:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dT-0007hW-Ki; Sat, 25 Dec 2021 17:11:07 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        kernel@pengutronix.de,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH v1 20/23] counter: stm32-timer-cnt: Convert to new counter registration
Date:   Sat, 25 Dec 2021 17:10:53 +0100
Message-Id: <20211225161056.682797-21-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
References: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=v4zGYhOHsyg9iYZhNI1UDYcjthPJ6td3ckU3nWtgO68=; m=2JnEkPCaowZOKuyzD9yTFMIdrv+hKJ42Y0wCXUyIor0=; p=dDV9QrmT4JqkzSSSjNjq6wOVUXb8Sd9mQHeOzq19VTY=; g=6e4c634470f6219b318c73337ce4f94afb61474d
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHHQnsACgkQwfwUeK3K7Akeiwf/W4A DXz+7ZvplVTELFX37oJw4lzQl2zQsDU9SYSeBzeGh0aeXPdp2CjdMjfTzT/g97QwzmjHbpTgsfzkD lNGdp5CJaO+V6SW9E8pX0bE22JdnInRjhcW0X9TY4mnP4KgdaGyeDYNqbGnfQCBt5In85i5f9VClF Zb69/BW9Yy2wxDIjKLCSdPs4qldnT2pazmLgwqlDWQjNnI0dBjzU+EOMWTw4PvulPEN3Pyh0ZnqJ6 pkkFuXOPGK+DbJQHk2mLQ6ugyAnJslGSiDloQrIqqiedlmYmivoaUPC+uhzbGN/HrwPx+VXMrKfwH RZL1mSVDAI06XtmB7ms7h7GUKnDJXow==
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

Fixes: ad29937e206f ("counter: Add STM32 Timer quadrature encoder")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/stm32-timer-cnt.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 4b05b198a8d8..5779ae7c73cf 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -29,7 +29,6 @@ struct stm32_timer_regs {
 };
 
 struct stm32_timer_cnt {
-	struct counter_device counter;
 	struct regmap *regmap;
 	struct clk *clk;
 	u32 max_arr;
@@ -317,31 +316,38 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
 	struct stm32_timers *ddata = dev_get_drvdata(pdev->dev.parent);
 	struct device *dev = &pdev->dev;
 	struct stm32_timer_cnt *priv;
+	struct counter_device *counter;
+	int ret;
 
 	if (IS_ERR_OR_NULL(ddata))
 		return -EINVAL;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
+	counter = devm_counter_alloc(dev, sizeof(*priv));
+	if (!counter)
 		return -ENOMEM;
 
+	priv = counter_priv(counter);
+
 	priv->regmap = ddata->regmap;
 	priv->clk = ddata->clk;
 	priv->max_arr = ddata->max_arr;
 
-	priv->counter.name = dev_name(dev);
-	priv->counter.parent = dev;
-	priv->counter.ops = &stm32_timer_cnt_ops;
-	priv->counter.counts = &stm32_counts;
-	priv->counter.num_counts = 1;
-	priv->counter.signals = stm32_signals;
-	priv->counter.num_signals = ARRAY_SIZE(stm32_signals);
-	priv->counter.priv = priv;
+	counter->name = dev_name(dev);
+	counter->parent = dev;
+	counter->ops = &stm32_timer_cnt_ops;
+	counter->counts = &stm32_counts;
+	counter->num_counts = 1;
+	counter->signals = stm32_signals;
+	counter->num_signals = ARRAY_SIZE(stm32_signals);
 
 	platform_set_drvdata(pdev, priv);
 
 	/* Register Counter device */
-	return devm_counter_register(dev, &priv->counter);
+	ret = devm_counter_add(dev, counter);
+	if (ret < 0)
+		dev_err_probe(dev, ret, "Failed to add counter\n");
+
+	return ret;
 }
 
 static int __maybe_unused stm32_timer_cnt_suspend(struct device *dev)
-- 
2.33.0

