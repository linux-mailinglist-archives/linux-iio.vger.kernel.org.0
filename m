Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9732E4A3987
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 21:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356320AbiA3UvT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 15:51:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40702 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347678AbiA3UvT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 15:51:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38AE1B829BD
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 20:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B79BC340EB;
        Sun, 30 Jan 2022 20:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643575876;
        bh=P4iksB+wx3OPUBFc4dzYW0NFCurGhkfq9X8/rufc/gI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BBfV1s0FXc5VMXCjM7jX2NnNVk+2oWHUcNeBLp2svCw69ODHOliNH3LsqYaIDwlKz
         T24hs2AY3JqhU3eIDclCN9TjnODNWDPEz1tfcOuUgEETLzsGAt2ZvzqgYvxJ9xhsuh
         kTL6yPH+yelVpnf3zR+hSzRXfL/zRd4GsOsyzkvm1XHkwInpfurAi6kgaiF7Ycfl1F
         hPxW/Dcpza3BwGX1wV+/8HnKVRyE/0JG+8yh/5tF95spMSLlVcsnUVh9RhugBzVYsR
         cx9DxRy3MB9UriwQcgFvc5/mmpuMtglk+5+8sJ0rCrj6mC/RPiM5o3Wv/+u9U0tZyA
         UMxKYAZQk4uhw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH 12/16] iio:magnetometer:rm3100: Move exports to IIO_RM3100 namespace
Date:   Sun, 30 Jan 2022 20:56:57 +0000
Message-Id: <20220130205701.334592-13-jic23@kernel.org>
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
Cc: Song Qiang <songqiang1304521@gmail.com>
---
 drivers/iio/magnetometer/rm3100-core.c | 8 ++++----
 drivers/iio/magnetometer/rm3100-i2c.c  | 1 +
 drivers/iio/magnetometer/rm3100-spi.c  | 1 +
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index 13914273c999..26195733ea3e 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -100,7 +100,7 @@ const struct regmap_access_table rm3100_readable_table = {
 	.yes_ranges = rm3100_readable_ranges,
 	.n_yes_ranges = ARRAY_SIZE(rm3100_readable_ranges),
 };
-EXPORT_SYMBOL_GPL(rm3100_readable_table);
+EXPORT_SYMBOL_NS_GPL(rm3100_readable_table, IIO_RM3100);
 
 static const struct regmap_range rm3100_writable_ranges[] = {
 	regmap_reg_range(RM3100_W_REG_START, RM3100_W_REG_END),
@@ -110,7 +110,7 @@ const struct regmap_access_table rm3100_writable_table = {
 	.yes_ranges = rm3100_writable_ranges,
 	.n_yes_ranges = ARRAY_SIZE(rm3100_writable_ranges),
 };
-EXPORT_SYMBOL_GPL(rm3100_writable_table);
+EXPORT_SYMBOL_NS_GPL(rm3100_writable_table, IIO_RM3100);
 
 static const struct regmap_range rm3100_volatile_ranges[] = {
 	regmap_reg_range(RM3100_V_REG_START, RM3100_V_REG_END),
@@ -120,7 +120,7 @@ const struct regmap_access_table rm3100_volatile_table = {
 	.yes_ranges = rm3100_volatile_ranges,
 	.n_yes_ranges = ARRAY_SIZE(rm3100_volatile_ranges),
 };
-EXPORT_SYMBOL_GPL(rm3100_volatile_table);
+EXPORT_SYMBOL_NS_GPL(rm3100_volatile_table, IIO_RM3100);
 
 static irqreturn_t rm3100_thread_fn(int irq, void *d)
 {
@@ -607,7 +607,7 @@ int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-EXPORT_SYMBOL_GPL(rm3100_common_probe);
+EXPORT_SYMBOL_NS_GPL(rm3100_common_probe, IIO_RM3100);
 
 MODULE_AUTHOR("Song Qiang <songqiang1304521@gmail.com>");
 MODULE_DESCRIPTION("PNI RM3100 3-axis magnetometer i2c driver");
diff --git a/drivers/iio/magnetometer/rm3100-i2c.c b/drivers/iio/magnetometer/rm3100-i2c.c
index 1ac622c6d6c9..ba669ab7113d 100644
--- a/drivers/iio/magnetometer/rm3100-i2c.c
+++ b/drivers/iio/magnetometer/rm3100-i2c.c
@@ -52,3 +52,4 @@ module_i2c_driver(rm3100_driver);
 MODULE_AUTHOR("Song Qiang <songqiang1304521@gmail.com>");
 MODULE_DESCRIPTION("PNI RM3100 3-axis magnetometer i2c driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_RM3100);
diff --git a/drivers/iio/magnetometer/rm3100-spi.c b/drivers/iio/magnetometer/rm3100-spi.c
index 65d5eb9e4f5e..76dc9b66cd3c 100644
--- a/drivers/iio/magnetometer/rm3100-spi.c
+++ b/drivers/iio/magnetometer/rm3100-spi.c
@@ -62,3 +62,4 @@ module_spi_driver(rm3100_driver);
 MODULE_AUTHOR("Song Qiang <songqiang1304521@gmail.com>");
 MODULE_DESCRIPTION("PNI RM3100 3-axis magnetometer spi driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_RM3100);
-- 
2.35.1

