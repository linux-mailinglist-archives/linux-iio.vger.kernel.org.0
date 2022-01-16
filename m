Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DF648FE4B
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jan 2022 19:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbiAPR77 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jan 2022 12:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbiAPR76 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Jan 2022 12:59:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744B5C061574
        for <linux-iio@vger.kernel.org>; Sun, 16 Jan 2022 09:59:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1293A60F9D
        for <linux-iio@vger.kernel.org>; Sun, 16 Jan 2022 17:59:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6094C36AF2;
        Sun, 16 Jan 2022 17:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642355997;
        bh=4GS4rgftbwE+Cr6YTQP9R3FNeIl3z+V5MODT62o3kGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=srQWqYN8WyAkBEv2D0RteOIB/E9S1JkHdQBZvCkuaCqlVAE+umE8Hzwi63ZgGZn7C
         WPF+w1FP6ewjgIG5Mm241gw4xbh3f6TPEjG1JwNr04kssheXMhbToKyQ3/bLa0P1Lo
         O6lYS5gWUKLx6onbro+o1102CRD61HUtPocADpj+wLrTlm6ogBELji8l+ARYAN0Iw0
         UI+svsPfsL2XhkjQ29mW/GG37g+ckXTBmkRFarcZNpbiig1ksD8v+q2z6JlfAVZ+l+
         kXQGtVNNrLV0ePkf6NwvB/qS3q60yzZmbfg0SmT1B5nYK/dCpOXoXWEVTbgj/OLFeu
         VGTN7p8gMQnQw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 09/13] iio:accel:bmc150: Move exports into IIO_BMC150 namespace
Date:   Sun, 16 Jan 2022 18:05:31 +0000
Message-Id: <20220116180535.2367780-10-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220116180535.2367780-1-jic23@kernel.org>
References: <20220116180535.2367780-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

To avoid unnecessary pollution of the global symbol namespace move the
driver core exports into their own namespace and import that into the two
bus modules.

For more info see https://lwn.net/Articles/760045/

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 8 ++++----
 drivers/iio/accel/bmc150-accel-i2c.c  | 1 +
 drivers/iio/accel/bmc150-accel-spi.c  | 1 +
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index e6081dd0a880..a5e0214b7be6 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -203,7 +203,7 @@ const struct regmap_config bmc150_regmap_conf = {
 	.val_bits = 8,
 	.max_register = 0x3f,
 };
-EXPORT_SYMBOL_GPL(bmc150_regmap_conf);
+EXPORT_SYMBOL_NS_GPL(bmc150_regmap_conf, IIO_BMC150);
 
 static int bmc150_accel_set_mode(struct bmc150_accel_data *data,
 				 enum bmc150_power_modes mode,
@@ -1798,7 +1798,7 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(bmc150_accel_core_probe);
+EXPORT_SYMBOL_NS_GPL(bmc150_accel_core_probe, IIO_BMC150);
 
 void bmc150_accel_core_remove(struct device *dev)
 {
@@ -1821,7 +1821,7 @@ void bmc150_accel_core_remove(struct device *dev)
 	regulator_bulk_disable(ARRAY_SIZE(data->regulators),
 			       data->regulators);
 }
-EXPORT_SYMBOL_GPL(bmc150_accel_core_remove);
+EXPORT_SYMBOL_NS_GPL(bmc150_accel_core_remove, IIO_BMC150);
 
 #ifdef CONFIG_PM_SLEEP
 static int bmc150_accel_suspend(struct device *dev)
@@ -1896,7 +1896,7 @@ const struct dev_pm_ops bmc150_accel_pm_ops = {
 	SET_RUNTIME_PM_OPS(bmc150_accel_runtime_suspend,
 			   bmc150_accel_runtime_resume, NULL)
 };
-EXPORT_SYMBOL_GPL(bmc150_accel_pm_ops);
+EXPORT_SYMBOL_NS_GPL(bmc150_accel_pm_ops, IIO_BMC150);
 
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index 9e52df9a8f07..dff4d7dd101c 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -280,3 +280,4 @@ module_i2c_driver(bmc150_accel_driver);
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("BMC150 I2C accelerometer driver");
+MODULE_IMPORT_NS(IIO_BMC150);
diff --git a/drivers/iio/accel/bmc150-accel-spi.c b/drivers/iio/accel/bmc150-accel-spi.c
index 11559567cb39..000632c52800 100644
--- a/drivers/iio/accel/bmc150-accel-spi.c
+++ b/drivers/iio/accel/bmc150-accel-spi.c
@@ -84,3 +84,4 @@ module_spi_driver(bmc150_accel_driver);
 MODULE_AUTHOR("Markus Pargmann <mpa@pengutronix.de>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("BMC150 SPI accelerometer driver");
+MODULE_IMPORT_NS(IIO_BMC150);
-- 
2.34.1

