Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59175481FE7
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 20:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241953AbhL3T2S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 14:28:18 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44204 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241904AbhL3T2R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 14:28:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6D44B81D02
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 19:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33B0C36AE7;
        Thu, 30 Dec 2021 19:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640892495;
        bh=6MeFfkXTpJvpl3/uN+qElKiOp2oWaR/qLRCMqEzSj+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rq45Z8yvL2Ta/sz8z7UYNs456NdT58Z6Pen/Y0RQ834sNGnp4s+X6VWELzlK67USa
         kEOO6aHlO4EdnyH5MxoSgOaSl4uKagV802ROC6rHbqt0CruX9G2hWmY8OkS4J5Lrjk
         etFcp+540BtfHp8XbvtvwjVfvpqpAk/IMBcyqLfSNy4nxS3CGLp6UB61dbLnD6o1DH
         vdP+TXzPmsFF4L3vlUAcF/BkjoLD18Ex3U0pF33XTny18LLoGOo+0vKP1m6ErdCXiw
         NczudQHLvhyR8yJ0py0TiSRMt3qzI4BbLedFilzkksjqxzfQ39j4ZfpWxWjVfWnJZF
         de9FAPT14xPDg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 12/13] iio:st-sensors: Remove duplicate MODULE_*
Date:   Thu, 30 Dec 2021 19:33:30 +0000
Message-Id: <20211230193331.283503-13-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230193331.283503-1-jic23@kernel.org>
References: <20211230193331.283503-1-jic23@kernel.org>
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

