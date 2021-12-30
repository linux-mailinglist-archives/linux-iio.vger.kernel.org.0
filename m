Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C87A481FE4
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 20:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241943AbhL3T2L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 14:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241904AbhL3T2L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 14:28:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE46C061574
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 11:28:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 972CAB81741
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 19:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE948C36AE9;
        Thu, 30 Dec 2021 19:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640892488;
        bh=ZUmNdhr6+YB0CqItQ2IhziY3TGgGKjlQf6JjbT+lwsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AEUHtfDXySs/GJTl0GscwC5SCe27E0vJFg++tXXDJ7kSZCX4x0hsFlomLSkmB7OM1
         IHk51Olg/I2LHFeFtt26+uKnGDAYAHG2Ogjvhfv5/Yp3IuvECwzyKsprk5c9+FmCOq
         avZbvv4bbI9X3uQiZgukGGROVpa4ggMpodbdxOucmBJHJAOZb2iA42CjOAtiHN9u1/
         AQ05Pwq1ixgJti8uXWr8AItIwx9FfPjV+bRh+ICBBH4GWjCUTpwBGprMHYVD3aJcYB
         YjTUm9YF+rb5DPcojwKTlwtFUyZNupUkDYZcfyjaQqMq4Eh8u8Qj1XxcrtZzA5GG7V
         rMiKQQsSdyx4A==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 09/13] iio:accel:bmc150: Move exports into BMC150 namespace
Date:   Thu, 30 Dec 2021 19:33:27 +0000
Message-Id: <20211230193331.283503-10-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230193331.283503-1-jic23@kernel.org>
References: <20211230193331.283503-1-jic23@kernel.org>
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

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 8 ++++----
 drivers/iio/accel/bmc150-accel-i2c.c  | 1 +
 drivers/iio/accel/bmc150-accel-spi.c  | 1 +
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index e6081dd0a880..711928d626c5 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -203,7 +203,7 @@ const struct regmap_config bmc150_regmap_conf = {
 	.val_bits = 8,
 	.max_register = 0x3f,
 };
-EXPORT_SYMBOL_GPL(bmc150_regmap_conf);
+EXPORT_SYMBOL_NS_GPL(bmc150_regmap_conf, BMC150);
 
 static int bmc150_accel_set_mode(struct bmc150_accel_data *data,
 				 enum bmc150_power_modes mode,
@@ -1798,7 +1798,7 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(bmc150_accel_core_probe);
+EXPORT_SYMBOL_NS_GPL(bmc150_accel_core_probe, BMC150);
 
 void bmc150_accel_core_remove(struct device *dev)
 {
@@ -1821,7 +1821,7 @@ void bmc150_accel_core_remove(struct device *dev)
 	regulator_bulk_disable(ARRAY_SIZE(data->regulators),
 			       data->regulators);
 }
-EXPORT_SYMBOL_GPL(bmc150_accel_core_remove);
+EXPORT_SYMBOL_NS_GPL(bmc150_accel_core_remove, BMC150);
 
 #ifdef CONFIG_PM_SLEEP
 static int bmc150_accel_suspend(struct device *dev)
@@ -1896,7 +1896,7 @@ const struct dev_pm_ops bmc150_accel_pm_ops = {
 	SET_RUNTIME_PM_OPS(bmc150_accel_runtime_suspend,
 			   bmc150_accel_runtime_resume, NULL)
 };
-EXPORT_SYMBOL_GPL(bmc150_accel_pm_ops);
+EXPORT_SYMBOL_NS_GPL(bmc150_accel_pm_ops, BMC150);
 
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index 9e52df9a8f07..e5d10e7be332 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -280,3 +280,4 @@ module_i2c_driver(bmc150_accel_driver);
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("BMC150 I2C accelerometer driver");
+MODULE_IMPORT_NS(BMC150);
diff --git a/drivers/iio/accel/bmc150-accel-spi.c b/drivers/iio/accel/bmc150-accel-spi.c
index 11559567cb39..e6d05f3625b7 100644
--- a/drivers/iio/accel/bmc150-accel-spi.c
+++ b/drivers/iio/accel/bmc150-accel-spi.c
@@ -84,3 +84,4 @@ module_spi_driver(bmc150_accel_driver);
 MODULE_AUTHOR("Markus Pargmann <mpa@pengutronix.de>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("BMC150 SPI accelerometer driver");
+MODULE_IMPORT_NS(BMC150);
-- 
2.34.1

