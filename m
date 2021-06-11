Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B09E3A4790
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 19:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhFKROT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 13:14:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231448AbhFKROR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 13:14:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08742613F5;
        Fri, 11 Jun 2021 17:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623431539;
        bh=nGFd4vtJI4PTkpop3e8DLbZwAGfX81EDKSoGFbYLRJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VeQQ/X+b2JfyTuZF+/8Wy2cMQdHWT/Whx4kHKzutJInORNbXaqdON+j01ZSRbmzry
         ZWDdBwxIejQetHv43Fk7+3NJa3Mu8YnklcSzoSF6fqEkIxDeLQkKSkgXi9xYDTgNsK
         wRo/a7JJyVYupTZFgRKQDCSTEInOWqx4rhaMjOoBL5wnHaKOQWp8fnzjZFziH4xxAD
         TsvWjQ0YBFGc5s6b3Ae/xA0RMcrTwRP0DYNMx4Ljw9Z1UoXPt1e0lHJDWzRF1qL3hI
         tuZR0CLg8iIuCrIAc2YMy3Jp01oWP25IJvVomFPiE+VeDb1UCLNowNlB5YlfMW6Eho
         K7ahLqd9+BX/w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 07/12] iio:accel:kionix drivers: Cleanup includes
Date:   Fri, 11 Jun 2021 18:13:49 +0100
Message-Id: <20210611171355.202903-8-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611171355.202903-1-jic23@kernel.org>
References: <20210611171355.202903-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Based on consideration of the output of include-what-you-use
Mixture of removing unused headers, adding some that are directly used
from the code and a few forwards definitions to avoid any potential
future issues with header ordering.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/kxcjk-1013.c | 4 +++-
 drivers/iio/accel/kxsd9-i2c.c  | 3 ---
 drivers/iio/accel/kxsd9-spi.c  | 5 +----
 drivers/iio/accel/kxsd9.c      | 1 -
 drivers/iio/accel/kxsd9.h      | 2 ++
 5 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index a51fdd3c9b5b..e4813706a52a 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -5,13 +5,15 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/bitops.h>
-#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/acpi.h>
+#include <linux/mutex.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
index b580d605f848..7e1d1158f80e 100644
--- a/drivers/iio/accel/kxsd9-i2c.c
+++ b/drivers/iio/accel/kxsd9-i2c.c
@@ -1,11 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
-#include <linux/slab.h>
 #include <linux/i2c.h>
-#include <linux/delay.h>
 #include <linux/regmap.h>
 
 #include "kxsd9.h"
diff --git a/drivers/iio/accel/kxsd9-spi.c b/drivers/iio/accel/kxsd9-spi.c
index 7971ec1eeb7e..78a168d5b1fa 100644
--- a/drivers/iio/accel/kxsd9-spi.c
+++ b/drivers/iio/accel/kxsd9-spi.c
@@ -1,11 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#include <linux/device.h>
 #include <linux/kernel.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/spi/spi.h>
 #include <linux/module.h>
-#include <linux/slab.h>
+#include <linux/mod_devicetable.h>
 #include <linux/regmap.h>
 
 #include "kxsd9.h"
diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index bf7ed9e7d00f..3d15f590ed4a 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -14,7 +14,6 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/sysfs.h>
-#include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/bitops.h>
diff --git a/drivers/iio/accel/kxsd9.h b/drivers/iio/accel/kxsd9.h
index 5e3ca212f5be..172b756eb901 100644
--- a/drivers/iio/accel/kxsd9.h
+++ b/drivers/iio/accel/kxsd9.h
@@ -4,6 +4,8 @@
 
 #define KXSD9_STATE_RX_SIZE 2
 #define KXSD9_STATE_TX_SIZE 2
+struct device;
+struct regmap;
 
 int kxsd9_common_probe(struct device *dev,
 		       struct regmap *map,
-- 
2.31.1

