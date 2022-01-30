Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200B84A3989
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 21:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347678AbiA3UvZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 15:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356322AbiA3UvW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 15:51:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B91CC061714
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 12:51:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD3BD60C60
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 20:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA99C340EB;
        Sun, 30 Jan 2022 20:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643575881;
        bh=nktAm811s9r3SAml9VSKOAomcxntEOuY0OydIIDzqvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hxYyZUNgcpc6Fv1mugxo1V+bdMNjWvrz2NC5Ekpgh7QqvYUMdeOcA923XCBiYBgtV
         On63SvPPCMqBrcsfPw3q2nBLlT5j+q1fUTO8J/7niSpz1caZkceEaQB4OcKWgmQzpM
         1sPc8Rp4TESqhVDND3ocjdzCNHkmCRtNhM8VSWPtsUJomIs3NbBKvRIZm7VyQYFHN8
         5Vc+wWYwCEI8UixzF2dh8ZxUJseD1NkII0T6cpzku1+FjWr/20V+lcq5yPbjPI4rgK
         pnrPTwHut0rs83RThbZB9K+Fs0i5u/d4SNrQLo3et1oRjm13xs87mfStAkO4zEOCLo
         mH+CDB1kIWqWQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 14/16] iio:magnetometer:hmc5843: Move exports to IIO_HMC5843 namespace
Date:   Sun, 30 Jan 2022 20:56:59 +0000
Message-Id: <20220130205701.334592-15-jic23@kernel.org>
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
move the common/library functions into a specific namespace and import
that into the bus specific device drivers that use them.

For more information see https://lwn.net/Articles/760045/

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/magnetometer/hmc5843_core.c | 8 ++++----
 drivers/iio/magnetometer/hmc5843_i2c.c  | 1 +
 drivers/iio/magnetometer/hmc5843_spi.c  | 1 +
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/magnetometer/hmc5843_core.c b/drivers/iio/magnetometer/hmc5843_core.c
index 5a730d9bdbb0..92eb2d156ddb 100644
--- a/drivers/iio/magnetometer/hmc5843_core.c
+++ b/drivers/iio/magnetometer/hmc5843_core.c
@@ -608,14 +608,14 @@ int hmc5843_common_suspend(struct device *dev)
 	return hmc5843_set_mode(iio_priv(dev_get_drvdata(dev)),
 				HMC5843_MODE_SLEEP);
 }
-EXPORT_SYMBOL(hmc5843_common_suspend);
+EXPORT_SYMBOL_NS(hmc5843_common_suspend, IIO_HMC5843);
 
 int hmc5843_common_resume(struct device *dev)
 {
 	return hmc5843_set_mode(iio_priv(dev_get_drvdata(dev)),
 		HMC5843_MODE_CONVERSION_CONTINUOUS);
 }
-EXPORT_SYMBOL(hmc5843_common_resume);
+EXPORT_SYMBOL_NS(hmc5843_common_resume, IIO_HMC5843);
 
 int hmc5843_common_probe(struct device *dev, struct regmap *regmap,
 			 enum hmc5843_ids id, const char *name)
@@ -669,7 +669,7 @@ int hmc5843_common_probe(struct device *dev, struct regmap *regmap,
 	hmc5843_set_mode(iio_priv(indio_dev), HMC5843_MODE_SLEEP);
 	return ret;
 }
-EXPORT_SYMBOL(hmc5843_common_probe);
+EXPORT_SYMBOL_NS(hmc5843_common_probe, IIO_HMC5843);
 
 void hmc5843_common_remove(struct device *dev)
 {
@@ -681,7 +681,7 @@ void hmc5843_common_remove(struct device *dev)
 	/*  sleep mode to save power */
 	hmc5843_set_mode(iio_priv(indio_dev), HMC5843_MODE_SLEEP);
 }
-EXPORT_SYMBOL(hmc5843_common_remove);
+EXPORT_SYMBOL_NS(hmc5843_common_remove, IIO_HMC5843);
 
 MODULE_AUTHOR("Shubhrajyoti Datta <shubhrajyoti@ti.com>");
 MODULE_DESCRIPTION("HMC5843/5883/5883L/5983 core driver");
diff --git a/drivers/iio/magnetometer/hmc5843_i2c.c b/drivers/iio/magnetometer/hmc5843_i2c.c
index bc6e12f1d521..8d2ff8fc204d 100644
--- a/drivers/iio/magnetometer/hmc5843_i2c.c
+++ b/drivers/iio/magnetometer/hmc5843_i2c.c
@@ -105,3 +105,4 @@ module_i2c_driver(hmc5843_driver);
 MODULE_AUTHOR("Josef Gajdusek <atx@atx.name>");
 MODULE_DESCRIPTION("HMC5843/5883/5883L/5983 i2c driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_HMC5843);
diff --git a/drivers/iio/magnetometer/hmc5843_spi.c b/drivers/iio/magnetometer/hmc5843_spi.c
index 89cf59a62c28..f2a8e98d8eb5 100644
--- a/drivers/iio/magnetometer/hmc5843_spi.c
+++ b/drivers/iio/magnetometer/hmc5843_spi.c
@@ -102,3 +102,4 @@ module_spi_driver(hmc5843_driver);
 MODULE_AUTHOR("Josef Gajdusek <atx@atx.name>");
 MODULE_DESCRIPTION("HMC5983 SPI driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_HMC5843);
-- 
2.35.1

