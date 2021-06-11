Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239E13A4792
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 19:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhFKROU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 13:14:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhFKROT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 13:14:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C0FB613CF;
        Fri, 11 Jun 2021 17:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623431542;
        bh=/ccWvm+2Km7le07gw7bhFqVqTjzWRzqBPIEcB5exnEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kHWFxHqB4N9CHxFl6Edm2EZ5PuNFtFkRe5qa3XtkIcnJ0uQm8CypZI9k+xbUUPb3U
         UjgfaswWt9GwareZYB19txXGaanGXkVzcAQib9+m7PNSrTezJ2rO7oYnl4McfhVn4b
         WiF4HndApWY7AQVpCjH+ooZ1Kwb48HMqgUPrbjPUtLIzs+5C45gcckpIYkbPedho8+
         fiEi1+vAmp9YnwynTylaLduQd6o2DnyGRjHD1kPh2W1kjL7t9VXbQLIlbCUwf45DMK
         4ANwfbgXmnAO+HL147t6BLL+WcCVQWlPYoAzKQGLe/ENE5HHwCEpHm3BQvs0t4SBgV
         hiXgHbZVip6Dw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Harinath Nampally <harinath922@gmail.com>
Subject: [PATCH 09/12] iio:accel:freescale drivers: Cleanup includes
Date:   Fri, 11 Jun 2021 18:13:51 +0100
Message-Id: <20210611171355.202903-10-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611171355.202903-1-jic23@kernel.org>
References: <20210611171355.202903-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Based on consideration of the output of the include-what-you-use checker.
For these drivers most of the changes are the addition of includes
for headers directly used in the files
There is no hard and fast rule for when to include and when to assume
included by another header, so this is partly a matter of taste
and consistency.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Harinath Nampally <harinath922@gmail.com>
---
 drivers/iio/accel/mma7455_core.c | 3 ++-
 drivers/iio/accel/mma7455_i2c.c  | 1 +
 drivers/iio/accel/mma7455_spi.c  | 1 +
 drivers/iio/accel/mma7660.c      | 3 +++
 drivers/iio/accel/mma8452.c      | 5 +++++
 drivers/iio/accel/mma9551.c      | 7 ++++---
 drivers/iio/accel/mma9551_core.h | 2 ++
 drivers/iio/accel/mma9553.c      | 6 ++++--
 8 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/mma7455_core.c b/drivers/iio/accel/mma7455_core.c
index 922bd38ff6ea..94160c3e0e64 100644
--- a/drivers/iio/accel/mma7455_core.c
+++ b/drivers/iio/accel/mma7455_core.c
@@ -11,12 +11,13 @@
  */
 
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
-#include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 
diff --git a/drivers/iio/accel/mma7455_i2c.c b/drivers/iio/accel/mma7455_i2c.c
index cddeaa9e230a..c0dc648e4ada 100644
--- a/drivers/iio/accel/mma7455_i2c.c
+++ b/drivers/iio/accel/mma7455_i2c.c
@@ -6,6 +6,7 @@
 
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/regmap.h>
 
 #include "mma7455.h"
diff --git a/drivers/iio/accel/mma7455_spi.c b/drivers/iio/accel/mma7455_spi.c
index eb82cdfa8abc..8339099e8e3d 100644
--- a/drivers/iio/accel/mma7455_spi.c
+++ b/drivers/iio/accel/mma7455_spi.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
 
diff --git a/drivers/iio/accel/mma7660.c b/drivers/iio/accel/mma7660.c
index 47f5cd66e996..32d132749ebd 100644
--- a/drivers/iio/accel/mma7660.c
+++ b/drivers/iio/accel/mma7660.c
@@ -9,7 +9,10 @@
 
 #include <linux/acpi.h>
 #include <linux/i2c.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 715b8138fb71..1f5f6a24b7b8 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -19,6 +19,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -28,9 +29,13 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/events.h>
 #include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/pm_runtime.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/regulator/consumer.h>
 
 #define MMA8452_STATUS				0x00
diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index 4c359fb05480..dc9824eef7f7 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -5,15 +5,16 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
-#include <linux/slab.h>
 #include <linux/acpi.h>
-#include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/gpio/consumer.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
+#include <linux/kernel.h>
+#include <linux/mutex.h>
 #include <linux/pm_runtime.h>
 #include "mma9551_core.h"
 
diff --git a/drivers/iio/accel/mma9551_core.h b/drivers/iio/accel/mma9551_core.h
index 543454a31dc0..3d6c774d33f8 100644
--- a/drivers/iio/accel/mma9551_core.h
+++ b/drivers/iio/accel/mma9551_core.h
@@ -38,6 +38,8 @@ enum mma9551_gpio_pin {
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
 }
 
+struct i2c_client;
+struct iio_chan_spec;
 int mma9551_read_config_byte(struct i2c_client *client, u8 app_id,
 			     u16 reg, u8 *val);
 int mma9551_write_config_byte(struct i2c_client *client, u8 app_id,
diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index ba3ecb3b57dc..56664193500c 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -5,13 +5,15 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
-#include <linux/slab.h>
 #include <linux/acpi.h>
+#include <linux/device.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
+#include <linux/kernel.h>
+#include <linux/mutex.h>
 #include <linux/pm_runtime.h>
 #include "mma9551_core.h"
 
-- 
2.31.1

