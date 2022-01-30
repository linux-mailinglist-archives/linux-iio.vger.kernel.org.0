Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E506C4A3985
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 21:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356317AbiA3UvO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 15:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356322AbiA3UvN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 15:51:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6581AC061714
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 12:51:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0315560DE4
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 20:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B929C340EB;
        Sun, 30 Jan 2022 20:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643575872;
        bh=m7bUZItRfR4+7wyOTSdchuSJr0NBcloOiPCLkSdE7I8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rwue6XV7UM9oGdjurdDA/tU9H/xKEo942FCyqIMzwe3+eDJTPwxomR03T4z+jxZ51
         Fs84i12PvDAZ8fgAhKItKxo8zjdjdA2qXuUxzXGXK+/40G8gjU3qhYLzNkpGieyT/k
         rInEYD9G22+UdS/JJI4EkNbPX5nVk1vh2vgAf1Y6r2RbnpAmmtOZ/uBCxd7JNhJNOr
         mp68vudUznzZnE957ozBjYyjv4q013bftAAxFrrZn+ZTeYkqRkPmkG/uius+acuUSQ
         yzP8W+RnICnnkVXe/JL+nc62R+vMSk07t2Vj/+IkX23OZ8FKFWVS9BwAvLbnr797J7
         klPqULqmEqyOA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH 10/16] iio:pressure:ms5611: Move exports into IIO_MS5611 namespace
Date:   Sun, 30 Jan 2022 20:56:55 +0000
Message-Id: <20220130205701.334592-11-jic23@kernel.org>
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
Cc: Tomasz Duszynski <tduszyns@gmail.com>
---
 drivers/iio/pressure/ms5611_core.c | 4 ++--
 drivers/iio/pressure/ms5611_i2c.c  | 1 +
 drivers/iio/pressure/ms5611_spi.c  | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
index a4d0b54cde9b..717521de66c4 100644
--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -471,7 +471,7 @@ int ms5611_probe(struct iio_dev *indio_dev, struct device *dev,
 	ms5611_fini(indio_dev);
 	return ret;
 }
-EXPORT_SYMBOL(ms5611_probe);
+EXPORT_SYMBOL_NS(ms5611_probe, IIO_MS5611);
 
 void ms5611_remove(struct iio_dev *indio_dev)
 {
@@ -479,7 +479,7 @@ void ms5611_remove(struct iio_dev *indio_dev)
 	iio_triggered_buffer_cleanup(indio_dev);
 	ms5611_fini(indio_dev);
 }
-EXPORT_SYMBOL(ms5611_remove);
+EXPORT_SYMBOL_NS(ms5611_remove, IIO_MS5611);
 
 MODULE_AUTHOR("Tomasz Duszynski <tduszyns@gmail.com>");
 MODULE_DESCRIPTION("MS5611 core driver");
diff --git a/drivers/iio/pressure/ms5611_i2c.c b/drivers/iio/pressure/ms5611_i2c.c
index 1047a85527a9..3b1de71e0d15 100644
--- a/drivers/iio/pressure/ms5611_i2c.c
+++ b/drivers/iio/pressure/ms5611_i2c.c
@@ -140,3 +140,4 @@ module_i2c_driver(ms5611_driver);
 MODULE_AUTHOR("Tomasz Duszynski <tduszyns@gmail.com>");
 MODULE_DESCRIPTION("MS5611 i2c driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_MS5611);
diff --git a/drivers/iio/pressure/ms5611_spi.c b/drivers/iio/pressure/ms5611_spi.c
index 9fa2dcd71760..281b08398720 100644
--- a/drivers/iio/pressure/ms5611_spi.c
+++ b/drivers/iio/pressure/ms5611_spi.c
@@ -142,3 +142,4 @@ module_spi_driver(ms5611_driver);
 MODULE_AUTHOR("Tomasz Duszynski <tduszyns@gmail.com>");
 MODULE_DESCRIPTION("MS5611 spi driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_MS5611);
-- 
2.35.1

