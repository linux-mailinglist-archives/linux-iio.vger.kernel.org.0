Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA17F4A3988
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 21:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356330AbiA3UvY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 15:51:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40718 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347676AbiA3UvV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 15:51:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72730B829BF
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 20:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1FFC340E4;
        Sun, 30 Jan 2022 20:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643575879;
        bh=q4x4Ivl9U3Xm4hKSYjwKPkktXWnYWLLWsFGuLnFx8io=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oPTiuKD/muCpE9DcAmfq6rEbEHsPQvbgzcC2DQnRJgBEULTVMzbExJ8O6/HULd1UA
         48Mv9EhHIbrsIRppkAUb55ii4QoxuFUMNNeWmJFDsiZHCy1phJFg7NWANl3h3aoQgn
         QHN+DkY6iV/xNRbCqEdKV6yuhroYwgkgYUsIa1ewVL6oMc2W2HjXhdXEX0K5MCdL0/
         5Hp4x/1s9gKuMu7AeGcP/Ee9UMqXpIgL1R2C7IGx+4LkxqlyQMpJ+IY5Vqj/2UITAz
         fWD2b9d+D2GBmU60ym7j3bHzW1ceFxbX2TnG5hrDuDiCQiuIEp827cU9xwIHT1RGiT
         1lXjlQmgMfIWA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 13/16] iio:magnetometer:bmc150: Move exports to IIO_BMC150_MAGN namespace
Date:   Sun, 30 Jan 2022 20:56:58 +0000
Message-Id: <20220130205701.334592-14-jic23@kernel.org>
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

Note the MAGN postfix here is reflecting that this driver is only
responsible for part of the BMC150 device.

For more information see https://lwn.net/Articles/760045/

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/magnetometer/bmc150_magn.c     | 8 ++++----
 drivers/iio/magnetometer/bmc150_magn_i2c.c | 1 +
 drivers/iio/magnetometer/bmc150_magn_spi.c | 1 +
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index f96f53175349..85f8bbf4b793 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -226,7 +226,7 @@ const struct regmap_config bmc150_magn_regmap_config = {
 	.writeable_reg = bmc150_magn_is_writeable_reg,
 	.volatile_reg = bmc150_magn_is_volatile_reg,
 };
-EXPORT_SYMBOL(bmc150_magn_regmap_config);
+EXPORT_SYMBOL_NS(bmc150_magn_regmap_config, IIO_BMC150_MAGN);
 
 static int bmc150_magn_set_power_mode(struct bmc150_magn_data *data,
 				      enum bmc150_magn_power_modes mode,
@@ -982,7 +982,7 @@ int bmc150_magn_probe(struct device *dev, struct regmap *regmap,
 	bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND, true);
 	return ret;
 }
-EXPORT_SYMBOL(bmc150_magn_probe);
+EXPORT_SYMBOL_NS(bmc150_magn_probe, IIO_BMC150_MAGN);
 
 int bmc150_magn_remove(struct device *dev)
 {
@@ -1009,7 +1009,7 @@ int bmc150_magn_remove(struct device *dev)
 	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
 	return 0;
 }
-EXPORT_SYMBOL(bmc150_magn_remove);
+EXPORT_SYMBOL_NS(bmc150_magn_remove, IIO_BMC150_MAGN);
 
 #ifdef CONFIG_PM
 static int bmc150_magn_runtime_suspend(struct device *dev)
@@ -1077,7 +1077,7 @@ const struct dev_pm_ops bmc150_magn_pm_ops = {
 	SET_RUNTIME_PM_OPS(bmc150_magn_runtime_suspend,
 			   bmc150_magn_runtime_resume, NULL)
 };
-EXPORT_SYMBOL(bmc150_magn_pm_ops);
+EXPORT_SYMBOL_NS(bmc150_magn_pm_ops, IIO_BMC150_MAGN);
 
 MODULE_AUTHOR("Irina Tirdea <irina.tirdea@intel.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/magnetometer/bmc150_magn_i2c.c b/drivers/iio/magnetometer/bmc150_magn_i2c.c
index 876e96005e33..e39b89661ad1 100644
--- a/drivers/iio/magnetometer/bmc150_magn_i2c.c
+++ b/drivers/iio/magnetometer/bmc150_magn_i2c.c
@@ -80,3 +80,4 @@ module_i2c_driver(bmc150_magn_driver);
 MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("BMC150 I2C magnetometer driver");
+MODULE_IMPORT_NS(IIO_BMC150_MAGN);
diff --git a/drivers/iio/magnetometer/bmc150_magn_spi.c b/drivers/iio/magnetometer/bmc150_magn_spi.c
index c6ed3ea8460a..0db363ffc462 100644
--- a/drivers/iio/magnetometer/bmc150_magn_spi.c
+++ b/drivers/iio/magnetometer/bmc150_magn_spi.c
@@ -66,3 +66,4 @@ module_spi_driver(bmc150_magn_spi_driver);
 MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com");
 MODULE_DESCRIPTION("BMC150 magnetometer SPI driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_BMC150_MAGN);
-- 
2.35.1

