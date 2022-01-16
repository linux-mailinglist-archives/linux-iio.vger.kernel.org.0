Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE7648FE45
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jan 2022 18:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbiAPR7q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jan 2022 12:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235936AbiAPR7p (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Jan 2022 12:59:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AB4C061574
        for <linux-iio@vger.kernel.org>; Sun, 16 Jan 2022 09:59:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3321460F9D
        for <linux-iio@vger.kernel.org>; Sun, 16 Jan 2022 17:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6060FC36AE7;
        Sun, 16 Jan 2022 17:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642355983;
        bh=mBQqLRBrU0Hn1vi4UDHJKaWXHRFmSSiWxxsogOeOJzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MVaJx0KxPnBsN8HG6hg40YQxHzEH6f9u+b2GUCBgpRS7R2BOkL9gSiy1CE/bvadWZ
         e21AxX0PzyWfOJOgTeCCPqPpOqegaFjUTq8u6b/Q5pbye/FDvSnBHAyaSc2TF7B45/
         f6YIHIKlk/77s8iPILY6QzC5cEfR3GTRR/1GvMqpC+QYmnlXqIHXcjljEKJwVUlFzd
         zvyM448MUjheesgZKyJpZ/RfqjWFPN/eU3rtazpsmfVR55+rgWZfXA65pESj3/BhWx
         nSE71EbFy8Hl1sNKHG5lgfkEKiXf9BSAzn2HyNhTtjeFLuIjdX3p1MT7KFFJhi4LOk
         3f3kgxImSIymQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 03/13] iio:accel:kxsd9: Move exports into IIO_KDSD9 namespace
Date:   Sun, 16 Jan 2022 18:05:25 +0000
Message-Id: <20220116180535.2367780-4-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220116180535.2367780-1-jic23@kernel.org>
References: <20220116180535.2367780-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

In order to avoid unnecessary pollution of the global symbol namespace
move the core kxsd9 functions into a kxsd9 specific namespace and import
that into the two bus modules.

For more information see https://lwn.net/Articles/760045/

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/kxsd9-i2c.c | 1 +
 drivers/iio/accel/kxsd9-spi.c | 1 +
 drivers/iio/accel/kxsd9.c     | 6 +++---
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
index 274b41a6e603..c8dc52f11037 100644
--- a/drivers/iio/accel/kxsd9-i2c.c
+++ b/drivers/iio/accel/kxsd9-i2c.c
@@ -65,3 +65,4 @@ module_i2c_driver(kxsd9_i2c_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("KXSD9 accelerometer I2C interface");
+MODULE_IMPORT_NS(IIO_KXSD9);
diff --git a/drivers/iio/accel/kxsd9-spi.c b/drivers/iio/accel/kxsd9-spi.c
index 441e6b764281..a06a3a273de7 100644
--- a/drivers/iio/accel/kxsd9-spi.c
+++ b/drivers/iio/accel/kxsd9-spi.c
@@ -66,3 +66,4 @@ module_spi_driver(kxsd9_spi_driver);
 MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
 MODULE_DESCRIPTION("Kionix KXSD9 SPI driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_KXSD9);
diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 552eba5e8b4f..3975860331a6 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -476,7 +476,7 @@ int kxsd9_common_probe(struct device *dev,
 
 	return ret;
 }
-EXPORT_SYMBOL(kxsd9_common_probe);
+EXPORT_SYMBOL_NS(kxsd9_common_probe, IIO_KXSD9);
 
 void kxsd9_common_remove(struct device *dev)
 {
@@ -490,7 +490,7 @@ void kxsd9_common_remove(struct device *dev)
 	pm_runtime_disable(dev);
 	kxsd9_power_down(st);
 }
-EXPORT_SYMBOL(kxsd9_common_remove);
+EXPORT_SYMBOL_NS(kxsd9_common_remove, IIO_KXSD9);
 
 #ifdef CONFIG_PM
 static int kxsd9_runtime_suspend(struct device *dev)
@@ -516,7 +516,7 @@ const struct dev_pm_ops kxsd9_dev_pm_ops = {
 	SET_RUNTIME_PM_OPS(kxsd9_runtime_suspend,
 			   kxsd9_runtime_resume, NULL)
 };
-EXPORT_SYMBOL(kxsd9_dev_pm_ops);
+EXPORT_SYMBOL_NS(kxsd9_dev_pm_ops, IIO_KXSD9);
 
 MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
 MODULE_DESCRIPTION("Kionix KXSD9 driver");
-- 
2.34.1

