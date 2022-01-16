Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346B448FE44
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jan 2022 18:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiAPR7n (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jan 2022 12:59:43 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58316 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbiAPR7m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Jan 2022 12:59:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8525660F9D
        for <linux-iio@vger.kernel.org>; Sun, 16 Jan 2022 17:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F47C36AF2;
        Sun, 16 Jan 2022 17:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642355982;
        bh=aVFWR6Syp8iVUinofZsgdoHLdMRdMiNsYlO7sy9tGV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=th//2vY3IzBVuH9xs1k9vZZjjOtit3dDMkLAM6oT/+u0xgV6P3Fj+xVpXqbCL3yam
         AAqxAmxzHSyH5VEacSaB8C5V+9YBMipDpASSTq67oSfvm/BGfkd/JKLriYqE9kxPE+
         phpamqOh16P4TsCg+rDnJaPoKHk5pjhVDSJrmyp36P4Nlaf2PPlKIQDSar+wc7cHTu
         5ax8upk/l4nFPvQUSUbZMFeiS1722w1LVEattKRsyAZkzbaAKBj5pGdwnmlm3EANUj
         GXPsbfVWiey9mWqXcUV/kksUf6TQgiSFQPc5u7jDRUqEzJWL4CWPHG7dCggfoiXcZO
         99fccPkAFSs0Q==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 02/13] iio:accel:mma7455_core: Move exports into IIO_MMA7455 namespace
Date:   Sun, 16 Jan 2022 18:05:24 +0000
Message-Id: <20220116180535.2367780-3-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220116180535.2367780-1-jic23@kernel.org>
References: <20220116180535.2367780-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

In order to avoid unnecessary pollution of the global symbol namespace
move the core mma7455 functions into an mma7455 specific namespace and
import that into the two bus modules.

For more information see https://lwn.net/Articles/760045/

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/accel/mma7455_core.c | 6 +++---
 drivers/iio/accel/mma7455_i2c.c  | 1 +
 drivers/iio/accel/mma7455_spi.c  | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mma7455_core.c b/drivers/iio/accel/mma7455_core.c
index e6739ba74edf..a34195b3215d 100644
--- a/drivers/iio/accel/mma7455_core.c
+++ b/drivers/iio/accel/mma7455_core.c
@@ -238,7 +238,7 @@ const struct regmap_config mma7455_core_regmap = {
 	.val_bits = 8,
 	.max_register = MMA7455_REG_TW,
 };
-EXPORT_SYMBOL_GPL(mma7455_core_regmap);
+EXPORT_SYMBOL_NS_GPL(mma7455_core_regmap, IIO_MMA7455);
 
 int mma7455_core_probe(struct device *dev, struct regmap *regmap,
 		       const char *name)
@@ -293,7 +293,7 @@ int mma7455_core_probe(struct device *dev, struct regmap *regmap,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(mma7455_core_probe);
+EXPORT_SYMBOL_NS_GPL(mma7455_core_probe, IIO_MMA7455);
 
 void mma7455_core_remove(struct device *dev)
 {
@@ -306,7 +306,7 @@ void mma7455_core_remove(struct device *dev)
 	regmap_write(mma7455->regmap, MMA7455_REG_MCTL,
 		     MMA7455_MCTL_MODE_STANDBY);
 }
-EXPORT_SYMBOL_GPL(mma7455_core_remove);
+EXPORT_SYMBOL_NS_GPL(mma7455_core_remove, IIO_MMA7455);
 
 MODULE_AUTHOR("Joachim Eastwood <manabian@gmail.com>");
 MODULE_DESCRIPTION("Freescale MMA7455L core accelerometer driver");
diff --git a/drivers/iio/accel/mma7455_i2c.c b/drivers/iio/accel/mma7455_i2c.c
index 8a5256516f9f..a3b84e8a3ea8 100644
--- a/drivers/iio/accel/mma7455_i2c.c
+++ b/drivers/iio/accel/mma7455_i2c.c
@@ -61,3 +61,4 @@ module_i2c_driver(mma7455_i2c_driver);
 MODULE_AUTHOR("Joachim Eastwood <manabian@gmail.com>");
 MODULE_DESCRIPTION("Freescale MMA7455L I2C accelerometer driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_MMA7455);
diff --git a/drivers/iio/accel/mma7455_spi.c b/drivers/iio/accel/mma7455_spi.c
index ecf690692dcc..564a0e12cebe 100644
--- a/drivers/iio/accel/mma7455_spi.c
+++ b/drivers/iio/accel/mma7455_spi.c
@@ -49,3 +49,4 @@ module_spi_driver(mma7455_spi_driver);
 MODULE_AUTHOR("Joachim Eastwood <manabian@gmail.com>");
 MODULE_DESCRIPTION("Freescale MMA7455L SPI accelerometer driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_MMA7455);
-- 
2.34.1

