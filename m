Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE796481FDE
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 20:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240206AbhL3T15 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 14:27:57 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43994 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240350AbhL3T15 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 14:27:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC024B81D02
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 19:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1F8C36AE7;
        Thu, 30 Dec 2021 19:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640892474;
        bh=xNs3HyQTL0OCz8RV4CUQnOsUucTSdpLxYcmPvOyoxB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eco9vDFPcklD14/KIFL3VOuDpfEsOHx5TgcqjuRFrJ75LARmexoY80CLfA8pUVjTy
         VpWmTPA5wpm+j4wstAqfknHHtEqeJLayTdoA81t/sU5gTboIN+MTRSoDs2xUYTMJET
         WbODNJ0EYzz5I5lcEHAgG+6Tx4XoiPWyUzZWzrd+KnoOpKStc1kpcKbFF/Q68mvFdF
         8U8h822kiW9T6n7IVr8uwQBJK4UVp9K63zNkzwig1vRM+GuSi+AcZI0VxqOIx0oWkZ
         iyXiGceOuAUcOoxuAyuAE+xLGGmUu/LyncxNmGjV4mT0lh3eHaiyhpyWs4Lx1Z4w58
         9mtTDAoJxK0hg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 03/13] iio:accel:kxsd9: Move exports into KDSD9 namespace
Date:   Thu, 30 Dec 2021 19:33:21 +0000
Message-Id: <20211230193331.283503-4-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230193331.283503-1-jic23@kernel.org>
References: <20211230193331.283503-1-jic23@kernel.org>
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
index 274b41a6e603..d68b371dd1b3 100644
--- a/drivers/iio/accel/kxsd9-i2c.c
+++ b/drivers/iio/accel/kxsd9-i2c.c
@@ -65,3 +65,4 @@ module_i2c_driver(kxsd9_i2c_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("KXSD9 accelerometer I2C interface");
+MODULE_IMPORT_NS(KXSD9);
diff --git a/drivers/iio/accel/kxsd9-spi.c b/drivers/iio/accel/kxsd9-spi.c
index 441e6b764281..0832ed1ecba6 100644
--- a/drivers/iio/accel/kxsd9-spi.c
+++ b/drivers/iio/accel/kxsd9-spi.c
@@ -66,3 +66,4 @@ module_spi_driver(kxsd9_spi_driver);
 MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
 MODULE_DESCRIPTION("Kionix KXSD9 SPI driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(KXSD9);
diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 552eba5e8b4f..b11e663d08c4 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -476,7 +476,7 @@ int kxsd9_common_probe(struct device *dev,
 
 	return ret;
 }
-EXPORT_SYMBOL(kxsd9_common_probe);
+EXPORT_SYMBOL_NS(kxsd9_common_probe, KXSD9);
 
 void kxsd9_common_remove(struct device *dev)
 {
@@ -490,7 +490,7 @@ void kxsd9_common_remove(struct device *dev)
 	pm_runtime_disable(dev);
 	kxsd9_power_down(st);
 }
-EXPORT_SYMBOL(kxsd9_common_remove);
+EXPORT_SYMBOL_NS(kxsd9_common_remove, KXSD9);
 
 #ifdef CONFIG_PM
 static int kxsd9_runtime_suspend(struct device *dev)
@@ -516,7 +516,7 @@ const struct dev_pm_ops kxsd9_dev_pm_ops = {
 	SET_RUNTIME_PM_OPS(kxsd9_runtime_suspend,
 			   kxsd9_runtime_resume, NULL)
 };
-EXPORT_SYMBOL(kxsd9_dev_pm_ops);
+EXPORT_SYMBOL_NS(kxsd9_dev_pm_ops, KXSD9);
 
 MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
 MODULE_DESCRIPTION("Kionix KXSD9 driver");
-- 
2.34.1

