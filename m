Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F9E578AFC
	for <lists+linux-iio@lfdr.de>; Mon, 18 Jul 2022 21:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236154AbiGRTfy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Jul 2022 15:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236145AbiGRTfq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2022 15:35:46 -0400
Received: from master.debian.org (master.debian.org [IPv6:2001:41b8:202:deb:216:36ff:fe40:4001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEF62AC5D
        for <linux-iio@vger.kernel.org>; Mon, 18 Jul 2022 12:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
         s=smtpauto.master; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID
        :Content-Description; bh=MERd46pXoxdAbyvpkZTMb9RFV8Sr8RDXilhnlJdQTmw=; b=Hv27
        e3G5WMd/0DI5UGFMBWaHJn3X97WbAQhu/1e9pCAYU/mA85ZIZ8uAgxJIUEbF86qbcWO72OYSK2kv3
        V6Q035wddgePxjU4TCH7sSpmjBWmCaEHO++HplG5+Rds5hUQ0gn0HFpFTECB+hQyrkoYPD/rvWGr0
        Xhqlx+zG5kbdWdxQX2zCZhXB9T/j95Ln/GhQShc++l30uw8q7lh70qPT6/uxnAvWx5PQFRgVH/mkl
        B0OOGKRBzDr9TzUZswXl3fsJxS3V+hUc8oX7M97Riwn3wVJTYhQehX3UX2HUkHJTsPuKbIIPdjdsY
        gEEZNKrQJtBImel2lSY/Tvl6x8at7Q==;
Received: from ukleinek by master.debian.org with local (Exim 4.92)
        (envelope-from <ukleinek@master.debian.org>)
        id 1oDWWj-0000Mi-HJ; Mon, 18 Jul 2022 19:35:33 +0000
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, Yves-Alexis Perez <corsac@debian.org>
Subject: [PATCH 2/3] iio: humidity: dht11: Emit error messages for probe failures
Date:   Mon, 18 Jul 2022 21:35:19 +0200
Message-Id: <20220718193520.177648-2-ukleinek@debian.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220718193520.177648-1-ukleinek@debian.org>
References: <20220718193520.177648-1-ukleinek@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1568; h=from:subject; bh=9DQg2sf2ntMq7FMH0Xg0bGGvMeueWUkFFLpmrMWxG+4=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi1bXyyFKGSnwJ5lZc1JlugtwuNDfJrA9n3VMXO/Gu QtCK9uGJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYtW18gAKCRDB/BR4rcrsCRCFCA CYt38qXeRvEoBXJp3ArkF9TouHYHtnMnyxiwnGLgfLZz7AXhqhB7pt3W1DWkB6AYcz3zZJuL7SkyDV uh8fdToatAsukoENoDXja4rfuiQU3707hhXnRBR0r7hwXcfoFGGXRLlHyHekW5hz+jfEpVgoi+s9Fo 8S/Lv0V6ubii1N8vMUIYAsfFq4wKyle24NmmiJbKHz4n2rICLFmfZiyYvvrw1HvIdrH7zXpGoedgP3 cnxQgbxpn5HS4R3eFkltuIXs2zXwWiqUrWyxvpy846vF8qZ9f6X21MmUCVrD0Xh9PZUeAypm2vMIcI Z9SyowZsp9hVGgVqtp8r+Y3dPFCmOo
X-Developer-Key: i=ukleinek@debian.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There are two exit points in the driver's probe function that fail
silently. From a user perspective this is unsatisfactory because the
device is unusable but there is no hint in the kernel log about the
actual problem which makes it unnecessarily hard to fix the problem.

Make use of dev_err_probe() to emit a problem indication which also does
the right thing if requesting the gpio return -EPROBE_DEFER.

Signed-off-by: Uwe Kleine-König <ukleinek@debian.org>
---
 drivers/iio/humidity/dht11.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
index 891b6bf0b4ca..6182f4d2e9fc 100644
--- a/drivers/iio/humidity/dht11.c
+++ b/drivers/iio/humidity/dht11.c
@@ -302,7 +302,8 @@ static int dht11_probe(struct platform_device *pdev)
 	dht11->dev = dev;
 	dht11->gpiod = devm_gpiod_get(dev, NULL, GPIOD_IN);
 	if (IS_ERR(dht11->gpiod))
-		return PTR_ERR(dht11->gpiod);
+		return dev_err_probe(dev, PTR_ERR(dht11->gpiod),
+				     "Failed to aquire GPIO\n");
 
 	dht11->irq = gpiod_to_irq(dht11->gpiod);
 	if (dht11->irq < 0) {
@@ -323,7 +324,11 @@ static int dht11_probe(struct platform_device *pdev)
 	iio->channels = dht11_chan_spec;
 	iio->num_channels = ARRAY_SIZE(dht11_chan_spec);
 
-	return devm_iio_device_register(dev, iio);
+	ret = devm_iio_device_register(dev, iio);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to register iio device\n");
+
+	return 0;
 }
 
 static struct platform_driver dht11_driver = {
-- 
2.36.1

