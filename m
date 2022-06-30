Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4F45612BC
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jun 2022 08:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbiF3GvB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Jun 2022 02:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiF3GvB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jun 2022 02:51:01 -0400
X-Greylist: delayed 910 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Jun 2022 23:50:58 PDT
Received: from master.debian.org (master.debian.org [IPv6:2001:41b8:202:deb:216:36ff:fe40:4001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB73B31383
        for <linux-iio@vger.kernel.org>; Wed, 29 Jun 2022 23:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
         s=smtpauto.master; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=PMdtybpwHr8ZJWM3c+NFjg1r58uzGcITaNp0gRSvrtc=; b=vX
        G2m22woMuGR7OoqCsMipnC0CZbv2xyBAmHhLlpUsdz8dYjdlQ5Bg1cyXXKu09K/1NMTjajSIaPEGj
        qyILN1pUGArjyoxOo4EUfkGnAk5qY8wfhCgx8F965R3LDat/UMc1HQ04+FfwlKe8POUsYqUMffxH4
        o+7KqgckNDiT4FfhoQgRJr08iu2eaNNBuHS4akcNTd0v2p5bEQ+XQ+zaKBCG0HuujNXI1b8GZdIb2
        YvWQTYg4HiE518IA/U/c3UZQss3OXxA37/UntVs72VpZNeO6p47tmWdJVMyhK8KclYDADODJ1Fofx
        wYN2v84m1v+YQuMMMo2Fmh2H0BlI0soQ==;
Received: from ukleinek by master.debian.org with local (Exim 4.92)
        (envelope-from <ukleinek@master.debian.org>)
        id 1o6nm3-0001sN-9j; Thu, 30 Jun 2022 06:35:35 +0000
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, Yves-Alexis Perez <corsac@debian.org>
Subject: [PATCH] iio: humidity: dht11: Improve error reporting in .probe()
Date:   Thu, 30 Jun 2022 08:35:28 +0200
Message-Id: <20220630063528.205327-1-ukleinek@debian.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2070; h=from:subject; bh=Po0iyfJMMAXUsMOAwMSKBC057wPeT3q3uhc0ssk7a7M=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBivUQtHBOIOh50VgjS+LlZRkMUEDsCKqvPyNFK5kL7 LnkN9ieJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYr1ELQAKCRDB/BR4rcrsCSfRCA CBVMK9K4pwINP+xvlNF/BJGkQzxoDv3f4rocHZm67z/DGwzVhG3Te0xqk4TSas/Pzi2qHz5Hc+7/y3 ej6aX3qCBwh8lz5WxOl7J7uSgwQETklaeCRUVHxdc/A0x73HxWFFsTgPsJwJG/riF3uj82gcwVadDB Ak90FndLDeV1vjO9gmEcFT+y1qggrTWkrXmXQd/s3MHG6O9Fqlz2G/LT3sNnkEeEehOhzZcLn6WVO+ ohh55GvLUiVvOtMeP/hRA//4shUAVdPhoNEgVzuOeOeYUkFPrPjq6OQSoyyhyLOjkeoWwYn7sJsar5 JQjg6QBZbJKsaVfMV/x5MV18L1qYex
X-Developer-Key: i=ukleinek@debian.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Don't emit a message for -ENOMEM, the kernel is already loud enough in
this case. Add a message if getting the GPIO or registering the iio
device fails and use dev_err_probe for improved behaviour on
-EPROBE_DEFER.

Signed-off-by: Uwe Kleine-König <ukleinek@debian.org>
---
 drivers/iio/humidity/dht11.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
index c97e25448772..d8b2cb3ef81e 100644
--- a/drivers/iio/humidity/dht11.c
+++ b/drivers/iio/humidity/dht11.c
@@ -293,24 +293,23 @@ static int dht11_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct dht11 *dht11;
 	struct iio_dev *iio;
+	int ret;
 
 	iio = devm_iio_device_alloc(dev, sizeof(*dht11));
-	if (!iio) {
-		dev_err(dev, "Failed to allocate IIO device\n");
+	if (!iio)
 		return -ENOMEM;
-	}
 
 	dht11 = iio_priv(iio);
 	dht11->dev = dev;
 	dht11->gpiod = devm_gpiod_get(dev, NULL, GPIOD_IN);
 	if (IS_ERR(dht11->gpiod))
-		return PTR_ERR(dht11->gpiod);
+		return dev_err_probe(dev, PTR_ERR(dht11->gpiod),
+				     "Failed to acquire GPIO\n");
 
 	dht11->irq = gpiod_to_irq(dht11->gpiod);
-	if (dht11->irq < 0) {
-		dev_err(dev, "GPIO %d has no interrupt\n", desc_to_gpio(dht11->gpiod));
-		return -EINVAL;
-	}
+	if (dht11->irq < 0)
+		return dev_err_probe(dev, -EINVAL, "GPIO %d has no interrupt\n",
+				     desc_to_gpio(dht11->gpiod));
 
 	dht11->timestamp = ktime_get_boottime_ns() - DHT11_DATA_VALID_TIME - 1;
 	dht11->num_edges = -1;
@@ -325,7 +324,11 @@ static int dht11_probe(struct platform_device *pdev)
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

base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.36.1

