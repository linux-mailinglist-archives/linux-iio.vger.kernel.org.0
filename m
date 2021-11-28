Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3D346095C
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 20:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbhK1T2Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 14:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238987AbhK1T0N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 14:26:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93577C0613F6
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 11:21:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 331F1610A3
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 19:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40461C53FC7;
        Sun, 28 Nov 2021 19:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638127314;
        bh=j/enLGAh9XergT5w4bKoFrNjPANvjP9rIM0U8HXyvug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KZYrl7569NJH1ZGnmSSPI0ix+ZjluL1UqpuSea6vp0IihuEiyiZocrwy9ktK/RNsG
         MtLvHzx8sQXjJ48UV/E1t/rrzxkrxDvM6XVDB5HC+5v9OpOl7oVLrHPNz8HgnZ6MGO
         5Y9YwIY4FjQMCJC6kjuHbU//+abUBddwYDw6bhMiEuHFRBzMh04xZBFjG/jCtS5Dyw
         xky0CfZ0QpW/WzOpaDPkwAFEji0ku4gTOP3EGNhBoO+ZUm/3BoCd/fh2rZR6tbIOpq
         spN40W6hoCWzu8DdrysWR+zD9E8HZCo34cvVZgpCM45f6l3H3J5l/73t1VQOjJ8V9R
         YQseNFNw9kS7A==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 06/12] iio:light:cm3605: Switch to generic firmware properties.
Date:   Sun, 28 Nov 2021 19:26:29 +0000
Message-Id: <20211128192635.2724359-7-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211128192635.2724359-1-jic23@kernel.org>
References: <20211128192635.2724359-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This enables use of other firmware types with minimal driver changes.
Part of an ongoing effort to move all IIO drivers over to generic
accessors in order to reduce the chance of of_* versions being
copied into new drivers.  Also updated the headers to reflect this change
including using mod_devicetable.h for struct of_device_id definition
rather than going via of.h

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/light/cm3605.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/cm3605.c b/drivers/iio/light/cm3605.c
index 3e7fb16ab1f6..50d34a98839c 100644
--- a/drivers/iio/light/cm3605.c
+++ b/drivers/iio/light/cm3605.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
@@ -18,7 +19,7 @@
 #include <linux/init.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
-#include <linux/of.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
@@ -156,7 +157,6 @@ static int cm3605_probe(struct platform_device *pdev)
 	struct cm3605 *cm3605;
 	struct iio_dev *indio_dev;
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	enum iio_chan_type ch_type;
 	u32 rset;
 	int irq;
@@ -171,7 +171,7 @@ static int cm3605_probe(struct platform_device *pdev)
 	cm3605->dev = dev;
 	cm3605->dir = IIO_EV_DIR_FALLING;
 
-	ret = of_property_read_u32(np, "capella,aset-resistance-ohms", &rset);
+	ret = device_property_read_u32(dev, "capella,aset-resistance-ohms", &rset);
 	if (ret) {
 		dev_info(dev, "no RSET specified, assuming 100K\n");
 		rset = 100000;
-- 
2.34.1

