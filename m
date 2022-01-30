Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5599B4A3984
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 21:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356318AbiA3UvN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 15:51:13 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40664 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356315AbiA3UvM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 15:51:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63206B829B7
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 20:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C6FC340E4;
        Sun, 30 Jan 2022 20:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643575870;
        bh=MSj+uh+C5aLIbyNfo2TmzS09F4ubdsAZh114sxRjj14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i2IIOBKL+6ZM02vbEq/gtW8kjdR728dQ9Vd03xiIyo/iA6mVJ/5MfEVxnKG1gv0ZW
         1bi02RFmpFedZ2IiM0NIWtta08jFTO/H4OSLMBwWp1uzgAuNdoKy62TqYpdHf+/TuK
         /qyzQLAFdXm9r+Ycy+kvUhQDQ5PT1cGqxJZgX9IXQd3/C92BpibLfRhopQhd+BI0yP
         NVgZEqNfCN3YIenmnHcgiQ5yNRdFELB/pmx+3ZjRsmaztXD9LDpsNbOFFKJvANBJnv
         aixAnHZMFso37sw451D7+YRBHzWi0YcnAGdDCwilkYn1/h+7rqXKmzn2k/p+pzHTBi
         fytKag9BYeSJg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 09/16] iio:pressure:zpa2326: Move exports into IIO_ZPA2326 namespace
Date:   Sun, 30 Jan 2022 20:56:54 +0000
Message-Id: <20220130205701.334592-10-jic23@kernel.org>
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
 drivers/iio/pressure/zpa2326.c     | 12 ++++++------
 drivers/iio/pressure/zpa2326_i2c.c |  1 +
 drivers/iio/pressure/zpa2326_spi.c |  1 +
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index 89295c90f801..67119a9b95fc 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -162,7 +162,7 @@ bool zpa2326_isreg_writeable(struct device *dev, unsigned int reg)
 		return false;
 	}
 }
-EXPORT_SYMBOL_GPL(zpa2326_isreg_writeable);
+EXPORT_SYMBOL_NS_GPL(zpa2326_isreg_writeable, IIO_ZPA2326);
 
 bool zpa2326_isreg_readable(struct device *dev, unsigned int reg)
 {
@@ -191,7 +191,7 @@ bool zpa2326_isreg_readable(struct device *dev, unsigned int reg)
 		return false;
 	}
 }
-EXPORT_SYMBOL_GPL(zpa2326_isreg_readable);
+EXPORT_SYMBOL_NS_GPL(zpa2326_isreg_readable, IIO_ZPA2326);
 
 bool zpa2326_isreg_precious(struct device *dev, unsigned int reg)
 {
@@ -204,7 +204,7 @@ bool zpa2326_isreg_precious(struct device *dev, unsigned int reg)
 		return false;
 	}
 }
-EXPORT_SYMBOL_GPL(zpa2326_isreg_precious);
+EXPORT_SYMBOL_NS_GPL(zpa2326_isreg_precious, IIO_ZPA2326);
 
 /**
  * zpa2326_enable_device() - Enable device, i.e. get out of low power mode.
@@ -649,7 +649,7 @@ const struct dev_pm_ops zpa2326_pm_ops = {
 	SET_RUNTIME_PM_OPS(zpa2326_runtime_suspend, zpa2326_runtime_resume,
 			   NULL)
 };
-EXPORT_SYMBOL_GPL(zpa2326_pm_ops);
+EXPORT_SYMBOL_NS_GPL(zpa2326_pm_ops, IIO_ZPA2326);
 
 /**
  * zpa2326_resume() - Request the PM layer to power supply the device.
@@ -1698,7 +1698,7 @@ int zpa2326_probe(struct device *parent,
 
 	return err;
 }
-EXPORT_SYMBOL_GPL(zpa2326_probe);
+EXPORT_SYMBOL_NS_GPL(zpa2326_probe, IIO_ZPA2326);
 
 void zpa2326_remove(const struct device *parent)
 {
@@ -1709,7 +1709,7 @@ void zpa2326_remove(const struct device *parent)
 	zpa2326_sleep(indio_dev);
 	zpa2326_power_off(indio_dev, iio_priv(indio_dev));
 }
-EXPORT_SYMBOL_GPL(zpa2326_remove);
+EXPORT_SYMBOL_NS_GPL(zpa2326_remove, IIO_ZPA2326);
 
 MODULE_AUTHOR("Gregor Boirie <gregor.boirie@parrot.com>");
 MODULE_DESCRIPTION("Core driver for Murata ZPA2326 pressure sensor");
diff --git a/drivers/iio/pressure/zpa2326_i2c.c b/drivers/iio/pressure/zpa2326_i2c.c
index 95d9739444c4..0db0860d386b 100644
--- a/drivers/iio/pressure/zpa2326_i2c.c
+++ b/drivers/iio/pressure/zpa2326_i2c.c
@@ -87,3 +87,4 @@ module_i2c_driver(zpa2326_i2c_driver);
 MODULE_AUTHOR("Gregor Boirie <gregor.boirie@parrot.com>");
 MODULE_DESCRIPTION("I2C driver for Murata ZPA2326 pressure sensor");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_ZPA2326);
diff --git a/drivers/iio/pressure/zpa2326_spi.c b/drivers/iio/pressure/zpa2326_spi.c
index 85201a4bae44..5fbd2586c4ea 100644
--- a/drivers/iio/pressure/zpa2326_spi.c
+++ b/drivers/iio/pressure/zpa2326_spi.c
@@ -91,3 +91,4 @@ module_spi_driver(zpa2326_spi_driver);
 MODULE_AUTHOR("Gregor Boirie <gregor.boirie@parrot.com>");
 MODULE_DESCRIPTION("SPI driver for Murata ZPA2326 pressure sensor");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_ZPA2326);
-- 
2.35.1

