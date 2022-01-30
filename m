Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BFF4A397C
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 21:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347651AbiA3UvA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 15:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243587AbiA3Uu7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 15:50:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A28C061714
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 12:50:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F280B829C0
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 20:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0C4C340EB;
        Sun, 30 Jan 2022 20:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643575857;
        bh=EOZr0Azl7og7xK15Gi+gi6L/jZ+Cxp4JZl79I7AK29I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BKEMynLSOYAzSo2sVwEMx+EQW1b/Y1lxhzW3DzYPTiSXmQ1Y949MHanGph2FifoJm
         i/Zkbsi9fgXSuATsApkBMO9S8qlORNHgdCO9fFL7tsNeT2jfUcWrbYyGbzdr2CPBE9
         8sGtzQLQuZe9KKHYzks1mU5wMaNBbVYoSnnLIusBmjMyu5gM6q0sYXmrfkBIrcjdoi
         VL60eute/qIKWPqLabWUjNmkjpCTkEa3nuYsDttUUQL1p159/Z2461WltJFqLJ+Yk3
         VGZQ1rgfHxq5E44HVHB71vRk26MMGa8fLpCUcltc9jqnr8hnd6AL+uP1/G/9uNVlGT
         P9RwXP7z299+w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 03/16] iio:adc:ad76060: Move exports into IIO_AD7606 namespace.
Date:   Sun, 30 Jan 2022 20:56:48 +0000
Message-Id: <20220130205701.334592-4-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220130205701.334592-1-jic23@kernel.org>
References: <20220130205701.334592-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

In order to avoid unnecessary pollution of the global symbol namespace
move the core/library functions into a specific namespace and import
that into the various bus specific device drivers that use them.

For more information see https://lwn.net/Articles/760045/

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7606.c     | 4 ++--
 drivers/iio/adc/ad7606_par.c | 1 +
 drivers/iio/adc/ad7606_spi.c | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 0a60ecc69d38..3b193dc26438 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -693,7 +693,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-EXPORT_SYMBOL_GPL(ad7606_probe);
+EXPORT_SYMBOL_NS_GPL(ad7606_probe, IIO_AD7606);
 
 #ifdef CONFIG_PM_SLEEP
 
@@ -725,7 +725,7 @@ static int ad7606_resume(struct device *dev)
 }
 
 SIMPLE_DEV_PM_OPS(ad7606_pm_ops, ad7606_suspend, ad7606_resume);
-EXPORT_SYMBOL_GPL(ad7606_pm_ops);
+EXPORT_SYMBOL_NS_GPL(ad7606_pm_ops, IIO_AD7606);
 
 #endif
 
diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
index f732b3ac7878..8888e56b5e90 100644
--- a/drivers/iio/adc/ad7606_par.c
+++ b/drivers/iio/adc/ad7606_par.c
@@ -101,3 +101,4 @@ module_platform_driver(ad7606_driver);
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_AD7606);
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 29945ad07dca..263a778bcf25 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -362,3 +362,4 @@ module_spi_driver(ad7606_driver);
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_AD7606);
-- 
2.35.1

