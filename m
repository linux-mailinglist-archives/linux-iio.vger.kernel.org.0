Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC5148FE4E
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jan 2022 19:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbiAPSAI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jan 2022 13:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235948AbiAPSAG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Jan 2022 13:00:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126D0C06161C
        for <linux-iio@vger.kernel.org>; Sun, 16 Jan 2022 10:00:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A88B760FA6
        for <linux-iio@vger.kernel.org>; Sun, 16 Jan 2022 18:00:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C00C36AF2;
        Sun, 16 Jan 2022 18:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642356005;
        bh=X6+w6AuVXCb00WfbyFqGZv+obeYZTLSGezrbVqN5iSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ITt8f4WFgbPPKxX2wulMkYkOQ/NGMXzmp6bLNGhKnqJIQ/rvFrxnS/Ez3BVWiaIDj
         oUiUBtLiGdLCsJhqVkZUksR8rSR+Q/Hs8ZYOeHi0iKBE+vCxgvNKI+vhiZ3ByZ4B7C
         nTM/4OWg+RYQL3GXCD5sVMNK+uZb5qs6QXiHFR+SwTGPKFhbouNWrpB/vQom5c0nfC
         xrCx2zECrJT8cunwErFyd5YhpEx7zCp8eq5dAj26wjWIRleBHGBd6MINa39vjDS7kJ
         JJoSEOwyVyPxSSWRXHlRl2CJLBA0jkoSLUoEnob9l9GP3QsBk27XRA+Fp9PBpW4S1X
         Am5ujeDXOLtQw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH v2 12/13] iio:st-sensors: Remove duplicate MODULE_*
Date:   Sun, 16 Jan 2022 18:05:34 +0000
Message-Id: <20220116180535.2367780-13-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220116180535.2367780-1-jic23@kernel.org>
References: <20220116180535.2367780-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The core module and type specific core modules are made up of
several files. There is no benefit in duplicating the MODULE_* macros
in each file so remove them.

Noticed whilst adding MODULE_IMPORT_NS() as I missed some files and
it still worked, making it clear not all of these blocks were needed.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Denis Ciocca <denis.ciocca@st.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/accel/st_accel_buffer.c                | 5 -----
 drivers/iio/common/st_sensors/st_sensors_buffer.c  | 5 -----
 drivers/iio/common/st_sensors/st_sensors_trigger.c | 5 -----
 drivers/iio/gyro/st_gyro_buffer.c                  | 4 ----
 drivers/iio/magnetometer/st_magn_buffer.c          | 4 ----
 drivers/iio/pressure/st_pressure_buffer.c          | 5 -----
 6 files changed, 28 deletions(-)

diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
index fc82fa83f1fb..b2977ae19b69 100644
--- a/drivers/iio/accel/st_accel_buffer.c
+++ b/drivers/iio/accel/st_accel_buffer.c
@@ -7,7 +7,6 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
-#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -65,7 +64,3 @@ int st_accel_allocate_ring(struct iio_dev *indio_dev)
 	return devm_iio_triggered_buffer_setup(indio_dev->dev.parent, indio_dev,
 		NULL, &st_sensors_trigger_handler, &st_accel_buffer_setup_ops);
 }
-
-MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
-MODULE_DESCRIPTION("STMicroelectronics accelerometers buffer");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
index dccc471e79da..5f2b1fb95fd7 100644
--- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
+++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
@@ -8,7 +8,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
 #include <linux/interrupt.h>
@@ -78,7 +77,3 @@ irqreturn_t st_sensors_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 EXPORT_SYMBOL(st_sensors_trigger_handler);
-
-MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
-MODULE_DESCRIPTION("STMicroelectronics ST-sensors buffer");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
index 392d74449886..ab7a5a24fa6e 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -8,7 +8,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
 #include <linux/interrupt.h>
@@ -241,7 +240,3 @@ int st_sensors_validate_device(struct iio_trigger *trig,
 	return 0;
 }
 EXPORT_SYMBOL(st_sensors_validate_device);
-
-MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
-MODULE_DESCRIPTION("STMicroelectronics ST-sensors trigger");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/gyro/st_gyro_buffer.c b/drivers/iio/gyro/st_gyro_buffer.c
index 4ae33ef25b9c..1ebfe7aa6c96 100644
--- a/drivers/iio/gyro/st_gyro_buffer.c
+++ b/drivers/iio/gyro/st_gyro_buffer.c
@@ -7,7 +7,6 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
-#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -65,6 +64,3 @@ int st_gyro_allocate_ring(struct iio_dev *indio_dev)
 		NULL, &st_sensors_trigger_handler, &st_gyro_buffer_setup_ops);
 }
 
-MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
-MODULE_DESCRIPTION("STMicroelectronics gyroscopes buffer");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/magnetometer/st_magn_buffer.c b/drivers/iio/magnetometer/st_magn_buffer.c
index cb43ccda808d..79987f42e8d9 100644
--- a/drivers/iio/magnetometer/st_magn_buffer.c
+++ b/drivers/iio/magnetometer/st_magn_buffer.c
@@ -7,7 +7,6 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
-#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -45,6 +44,3 @@ int st_magn_allocate_ring(struct iio_dev *indio_dev)
 		NULL, &st_sensors_trigger_handler, &st_magn_buffer_setup_ops);
 }
 
-MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
-MODULE_DESCRIPTION("STMicroelectronics magnetometers buffer");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/pressure/st_pressure_buffer.c b/drivers/iio/pressure/st_pressure_buffer.c
index 25dbd5476b26..0dbf357c2c22 100644
--- a/drivers/iio/pressure/st_pressure_buffer.c
+++ b/drivers/iio/pressure/st_pressure_buffer.c
@@ -7,7 +7,6 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
-#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -44,7 +43,3 @@ int st_press_allocate_ring(struct iio_dev *indio_dev)
 	return devm_iio_triggered_buffer_setup(indio_dev->dev.parent, indio_dev,
 		NULL, &st_sensors_trigger_handler, &st_press_buffer_setup_ops);
 }
-
-MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
-MODULE_DESCRIPTION("STMicroelectronics pressures buffer");
-MODULE_LICENSE("GPL v2");
-- 
2.34.1

