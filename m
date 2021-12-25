Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D514547F3B9
	for <lists+linux-iio@lfdr.de>; Sat, 25 Dec 2021 17:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbhLYQLQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Dec 2021 11:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbhLYQLO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Dec 2021 11:11:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E6EC06175B
        for <linux-iio@vger.kernel.org>; Sat, 25 Dec 2021 08:11:13 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dV-0008Du-At; Sat, 25 Dec 2021 17:11:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dU-006ahX-Ob; Sat, 25 Dec 2021 17:11:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n19dT-0007hQ-6V; Sat, 25 Dec 2021 17:11:07 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        kernel@pengutronix.de,
        Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH v1 18/23] counter: ftm-quaddec: Convert to new counter registration
Date:   Sat, 25 Dec 2021 17:10:51 +0100
Message-Id: <20211225161056.682797-19-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
References: <20211225161056.682797-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=T9Exz3wKL9LBHOoGq1qDfP1qZAK927KAHy9K6Esz8lk=; m=ZZb0WZj9AWrp3lat8A5ZAyjFwLerq6gaSWzN2AryO3E=; p=4YmOyzSfCXHg8TuS+A7Hr2+tdXJjH9e2q8RKRuuXffs=; g=18681c49123f90c571b215c1780661f11d7e4271
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHHQnMACgkQwfwUeK3K7AlVxwf+ISC mlGej/lhB/98ZfclMmOqWoO+1ye/Q45jp2b+chntkutLsEQCPlDlQ0E9b1zWDLgAGgMoKOs29nwGC PlG7kL36FgXxJfC/Sh+e5+qm4BBgObm3o87py3eWccrNaN4FIlof7oEQ8F6Df0lsahZU+Y3f5eNm1 XRGtugcz5On7KpTy0GmS6dnXTTKHvllBoKBer0UoZRwv+6vmb7l00vW8rSAOrOOqDq4DBguh4zY7F xu96grvZ6yZl9GMS0YgDxzls+2LJd0th1b/HLq/w+VMTJf+wFbP8g/B9G+r0IXAudZgeUGN71R653 oj1NOahdPRnWs3xvcbxt/pF+lw/WonA==
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

Fixes: a3b9a99980d9 ("counter: add FlexTimer Module Quadrature decoder counter driver")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/ftm-quaddec.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
index f5d92df6a611..d73506436e58 100644
--- a/drivers/counter/ftm-quaddec.c
+++ b/drivers/counter/ftm-quaddec.c
@@ -26,7 +26,6 @@
 	})
 
 struct ftm_quaddec {
-	struct counter_device counter;
 	struct platform_device *pdev;
 	void __iomem *ftm_base;
 	bool big_endian;
@@ -259,15 +258,16 @@ static struct counter_count ftm_quaddec_counts = {
 
 static int ftm_quaddec_probe(struct platform_device *pdev)
 {
+	struct counter_device *counter;
 	struct ftm_quaddec *ftm;
-
 	struct device_node *node = pdev->dev.of_node;
 	struct resource *io;
 	int ret;
 
-	ftm = devm_kzalloc(&pdev->dev, sizeof(*ftm), GFP_KERNEL);
-	if (!ftm)
+	counter = devm_counter_alloc(&pdev->dev, sizeof(*ftm));
+	if (!counter)
 		return -ENOMEM;
+	ftm = counter_priv(counter);
 
 	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!io) {
@@ -283,14 +283,13 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Failed to map memory region\n");
 		return -EINVAL;
 	}
-	ftm->counter.name = dev_name(&pdev->dev);
-	ftm->counter.parent = &pdev->dev;
-	ftm->counter.ops = &ftm_quaddec_cnt_ops;
-	ftm->counter.counts = &ftm_quaddec_counts;
-	ftm->counter.num_counts = 1;
-	ftm->counter.signals = ftm_quaddec_signals;
-	ftm->counter.num_signals = ARRAY_SIZE(ftm_quaddec_signals);
-	ftm->counter.priv = ftm;
+	counter->name = dev_name(&pdev->dev);
+	counter->parent = &pdev->dev;
+	counter->ops = &ftm_quaddec_cnt_ops;
+	counter->counts = &ftm_quaddec_counts;
+	counter->num_counts = 1;
+	counter->signals = ftm_quaddec_signals;
+	counter->num_signals = ARRAY_SIZE(ftm_quaddec_signals);
 
 	mutex_init(&ftm->ftm_quaddec_mutex);
 
@@ -300,9 +299,9 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = devm_counter_register(&pdev->dev, &ftm->counter);
+	ret = devm_counter_add(&pdev->dev, counter);
 	if (ret)
-		return ret;
+		return dev_err_probe(&pdev->dev, "Failed to add counter\n");
 
 	return 0;
 }
-- 
2.33.0

