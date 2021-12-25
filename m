Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809D447F3B8
	for <lists+linux-iio@lfdr.de>; Sat, 25 Dec 2021 17:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhLYQLP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Dec 2021 11:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbhLYQLO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Dec 2021 11:11:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3826C06175A
        for <linux-iio@vger.kernel.org>; Sat, 25 Dec 2021 08:11:13 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dU-0008Dk-LI; Sat, 25 Dec 2021 17:11:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dT-006ahO-Oi; Sat, 25 Dec 2021 17:11:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dS-0007gn-Q8; Sat, 25 Dec 2021 17:11:06 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: [PATCH v1 16/23] counter: interrupt-cnt: Convert to new counter registration
Date:   Sat, 25 Dec 2021 17:10:49 +0100
Message-Id: <20211225161056.682797-17-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
References: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=dfP4l5w7ij74pFCONBGSQx967EIzwUTODlebX85hIO4=; m=5Rmlhi4KMYhV00ngpcAw0obj1vkEwMFEkVi2+kKODFo=; p=HBuYj0SbyH16UlYcSDm9g6ApSaV7tM5gNoT5+/J6Xyg=; g=41eb642a9b8ece43b387edd65e8c5fdd3559b685
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHHQmoACgkQwfwUeK3K7AmBEwf+Nz4 feJMHDmOyY0iDJIURgEczIOrfbuQu+Oo2rgE7l0iRNUMt/Dfg/SRSfjNzzxlaGp0h6svH6rRHACfb Q7VqoMnuqc4jYZrp/7NlxZq20jJRlJE4DGXvHv7BXO2FC1QU7v4r6bbH2Do1XsBMysjLwDCsdHpjG SfZwcVNAO8CxI12YfbjqfFW6QeArfarGqVpr3/Qzm18RVo1zVUCn64B4aeOVFlOxKJwpFakyRWm7H AOiFANgyvlzImLQUaeiDUvBoYjY/2gtot9EPGcuWerEIBprWYZG4GoVX/Y237VxIUM0QBVjknqFqI buVlpRgJQOkss+r4JY35U2HOOeqNHKA==
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

Fixes: a55ebd47f21f ("counter: add IRQ or GPIO based counter")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/interrupt-cnt.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
index 4bf706ef46e2..3f816454220e 100644
--- a/drivers/counter/interrupt-cnt.c
+++ b/drivers/counter/interrupt-cnt.c
@@ -16,7 +16,6 @@
 
 struct interrupt_cnt_priv {
 	atomic_t count;
-	struct counter_device counter;
 	struct gpio_desc *gpio;
 	int irq;
 	bool enabled;
@@ -148,12 +147,14 @@ static const struct counter_ops interrupt_cnt_ops = {
 static int interrupt_cnt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct counter_device *counter;
 	struct interrupt_cnt_priv *priv;
 	int ret;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
+	counter = devm_counter_alloc(dev, sizeof(*priv));
+	if (!counter)
 		return -ENOMEM;
+	priv = counter_priv(counter);
 
 	priv->irq = platform_get_irq_optional(pdev,  0);
 	if (priv->irq == -ENXIO)
@@ -184,8 +185,8 @@ static int interrupt_cnt_probe(struct platform_device *pdev)
 	if (!priv->signals.name)
 		return -ENOMEM;
 
-	priv->counter.signals = &priv->signals;
-	priv->counter.num_signals = 1;
+	counter->signals = &priv->signals;
+	counter->num_signals = 1;
 
 	priv->synapses.actions_list = interrupt_cnt_synapse_actions;
 	priv->synapses.num_actions = ARRAY_SIZE(interrupt_cnt_synapse_actions);
@@ -199,12 +200,11 @@ static int interrupt_cnt_probe(struct platform_device *pdev)
 	priv->cnts.ext = interrupt_cnt_ext;
 	priv->cnts.num_ext = ARRAY_SIZE(interrupt_cnt_ext);
 
-	priv->counter.priv = priv;
-	priv->counter.name = dev_name(dev);
-	priv->counter.parent = dev;
-	priv->counter.ops = &interrupt_cnt_ops;
-	priv->counter.counts = &priv->cnts;
-	priv->counter.num_counts = 1;
+	counter->name = dev_name(dev);
+	counter->parent = dev;
+	counter->ops = &interrupt_cnt_ops;
+	counter->counts = &priv->cnts;
+	counter->num_counts = 1;
 
 	irq_set_status_flags(priv->irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(dev, priv->irq, interrupt_cnt_isr,
@@ -213,7 +213,11 @@ static int interrupt_cnt_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return devm_counter_register(dev, &priv->counter);
+	ret = devm_counter_add(dev, counter);
+	if (ret < 0)
+		return dev_err_probe(dev, err, "Failed to add counter\n");
+
+	return 0;
 }
 
 static const struct of_device_id interrupt_cnt_of_match[] = {
-- 
2.33.0

