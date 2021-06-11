Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635793A478C
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 19:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhFKRON (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 13:14:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230186AbhFKRON (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 13:14:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C878E6124C;
        Fri, 11 Jun 2021 17:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623431535;
        bh=9NSaJ82TbEOvGft3/X4heYLYiZbUwXl75lhxIszw4Vw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dgphvJyuGXnskXmwJJen+2+U6PYd2fKh2FhWl7h1qp95+Wsq3lYxcRpDIeQyMgvCv
         9/l3JaQyYIRgLcXnEXICELR3lGRZitRsDxZAKVVHG08dQFGNdR9qj6olg1UCign5I/
         H8skjPK/fFciHtwaWSCEH3s/fe3csxGZtnM3ZTW5rn/a+Wi8k4CmWV5PP4duKZwTQO
         uk0GSE4Tk0CQPwZsTrhP+/3+yoqD2kkZaZGYv65HHnt6rQFuy4wPPXf8v4mzhC2C0c
         h6Ccc2cVeKTNHsoBb6PbA0RtwFKntSLlhU6gJPbGPzrQ0Kt8yzwgNJNppG82l5cLz/
         LzPFDGgYsoVxg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Robertson <dan@dlrobertson.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 03/12] iio:accel:bosch drivers: Cleanup includes
Date:   Fri, 11 Jun 2021 18:13:45 +0100
Message-Id: <20210611171355.202903-4-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611171355.202903-1-jic23@kernel.org>
References: <20210611171355.202903-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Based on consideration of the output of the include-what-you-use tool.
Remove unused headers and add some that are directly used in the
files.

There are no hard rules on when to use direct includes and when to
rely on a chain of headers.  Here I'm trying to make those
decisions approximately the same across IIO.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dan Robertson <dan@dlrobertson.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/bma180.c            | 4 ++--
 drivers/iio/accel/bma220_spi.c        | 2 +-
 drivers/iio/accel/bma400_core.c       | 1 -
 drivers/iio/accel/bma400_spi.c        | 1 -
 drivers/iio/accel/bmc150-accel-core.c | 1 +
 drivers/iio/accel/bmc150-accel-spi.c  | 1 -
 drivers/iio/accel/bmi088-accel-core.c | 3 ---
 drivers/iio/accel/bmi088-accel-spi.c  | 3 ++-
 8 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 0e0d9317c084..2042cf86b199 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -14,14 +14,14 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/property.h>
+#include <linux/mutex.h>
 #include <linux/bitops.h>
 #include <linux/regulator/consumer.h>
-#include <linux/slab.h>
-#include <linux/string.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 0622c7936499..c447463d0844 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -9,11 +9,11 @@
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/spi/spi.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 21520e022a21..8595dd666c44 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -14,7 +14,6 @@
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
diff --git a/drivers/iio/accel/bma400_spi.c b/drivers/iio/accel/bma400_spi.c
index 7c2825904e08..0ae3d1a203b4 100644
--- a/drivers/iio/accel/bma400_spi.c
+++ b/drivers/iio/accel/bma400_spi.c
@@ -6,7 +6,6 @@
  *
  */
 #include <linux/bits.h>
-#include <linux/init.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 46ab7675186c..06e396b66e02 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
+#include <linux/mutex.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/iio/iio.h>
diff --git a/drivers/iio/accel/bmc150-accel-spi.c b/drivers/iio/accel/bmc150-accel-spi.c
index 74a8aee4f612..0786c9a0dcbb 100644
--- a/drivers/iio/accel/bmc150-accel-spi.c
+++ b/drivers/iio/accel/bmc150-accel-spi.c
@@ -4,7 +4,6 @@
  * Copyright © 2015 Pengutronix, Markus Pargmann <mpa@pengutronix.de>
  */
 
-#include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/acpi.h>
diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
index a06dae5c971d..d50db25cce64 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -8,13 +8,10 @@
 
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
-#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
-#include <linux/slab.h>
 #include <asm/unaligned.h>
 
 #include "bmi088-accel.h"
diff --git a/drivers/iio/accel/bmi088-accel-spi.c b/drivers/iio/accel/bmi088-accel-spi.c
index dd1e3f6cf211..ae999c08e038 100644
--- a/drivers/iio/accel/bmi088-accel-spi.c
+++ b/drivers/iio/accel/bmi088-accel-spi.c
@@ -6,9 +6,10 @@
  * Copyright (c) 2018-2020, Topic Embedded Products
  */
 
+#include <linux/bits.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/regmap.h>
-#include <linux/slab.h>
 #include <linux/spi/spi.h>
 
 #include "bmi088-accel.h"
-- 
2.31.1

