Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81961481FDD
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 20:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240337AbhL3T14 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 14:27:56 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43972 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240206AbhL3T1z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 14:27:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EA50B81741
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 19:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C36C36AE9;
        Thu, 30 Dec 2021 19:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640892472;
        bh=Hr+BdoUBrzpcIN0KwCVKsDU4f8QNq6WJqdqDGukKv+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=An4Ngp6m648EPaiMs9HkcN8EE0F/I807YHXoRx0GI9FLt7WHvnzOux0IBjBRQ27et
         2yAEjuNwqV2gyZpPDOmuKs2NwEhTldW26gtwMd5BHsWT5qUf+opCRh99TtWUpFC2bA
         XWKDTWUfM09rI8dPAjDbh2dM5YgjD+mK2pnoPwgwchlK/uvfsQymHOr8/wK1Ji+sO+
         d++ATr/ywJmfq41w5gFaCHhjwMuI+daxwvTmmSxWdplD1cZTsZGrXVjlEx7hlecpOj
         jGCDo6/XvkeEGIr1GKwNcWUXx1bSq9eU9CRp9EU+s0USJO6kXJsfrQVBR9PGvG561y
         ClNVmc4j0cpEQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 02/13] iio:accel:mma7455_core: Move exports into MMA7455 namespace
Date:   Thu, 30 Dec 2021 19:33:20 +0000
Message-Id: <20211230193331.283503-3-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230193331.283503-1-jic23@kernel.org>
References: <20211230193331.283503-1-jic23@kernel.org>
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
index e6739ba74edf..4ece5e83a8ab 100644
--- a/drivers/iio/accel/mma7455_core.c
+++ b/drivers/iio/accel/mma7455_core.c
@@ -238,7 +238,7 @@ const struct regmap_config mma7455_core_regmap = {
 	.val_bits = 8,
 	.max_register = MMA7455_REG_TW,
 };
-EXPORT_SYMBOL_GPL(mma7455_core_regmap);
+EXPORT_SYMBOL_NS_GPL(mma7455_core_regmap, MMA7455);
 
 int mma7455_core_probe(struct device *dev, struct regmap *regmap,
 		       const char *name)
@@ -293,7 +293,7 @@ int mma7455_core_probe(struct device *dev, struct regmap *regmap,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(mma7455_core_probe);
+EXPORT_SYMBOL_NS_GPL(mma7455_core_probe, MMA7455);
 
 void mma7455_core_remove(struct device *dev)
 {
@@ -306,7 +306,7 @@ void mma7455_core_remove(struct device *dev)
 	regmap_write(mma7455->regmap, MMA7455_REG_MCTL,
 		     MMA7455_MCTL_MODE_STANDBY);
 }
-EXPORT_SYMBOL_GPL(mma7455_core_remove);
+EXPORT_SYMBOL_NS_GPL(mma7455_core_remove, MMA7455);
 
 MODULE_AUTHOR("Joachim Eastwood <manabian@gmail.com>");
 MODULE_DESCRIPTION("Freescale MMA7455L core accelerometer driver");
diff --git a/drivers/iio/accel/mma7455_i2c.c b/drivers/iio/accel/mma7455_i2c.c
index 8a5256516f9f..b7a3d5da8f87 100644
--- a/drivers/iio/accel/mma7455_i2c.c
+++ b/drivers/iio/accel/mma7455_i2c.c
@@ -61,3 +61,4 @@ module_i2c_driver(mma7455_i2c_driver);
 MODULE_AUTHOR("Joachim Eastwood <manabian@gmail.com>");
 MODULE_DESCRIPTION("Freescale MMA7455L I2C accelerometer driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(MMA7455);
diff --git a/drivers/iio/accel/mma7455_spi.c b/drivers/iio/accel/mma7455_spi.c
index ecf690692dcc..cc17755a1026 100644
--- a/drivers/iio/accel/mma7455_spi.c
+++ b/drivers/iio/accel/mma7455_spi.c
@@ -49,3 +49,4 @@ module_spi_driver(mma7455_spi_driver);
 MODULE_AUTHOR("Joachim Eastwood <manabian@gmail.com>");
 MODULE_DESCRIPTION("Freescale MMA7455L SPI accelerometer driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(MMA7455);
-- 
2.34.1

