Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4178939FE2D
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jun 2021 19:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbhFHRv7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 13:51:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233950AbhFHRv6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 8 Jun 2021 13:51:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D7066135D;
        Tue,  8 Jun 2021 17:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623174605;
        bh=AtI1aZ+ah+w3Ip5As4yUviPRLeMUktdKcG7zGAUhC0A=;
        h=From:To:Cc:Subject:Date:From;
        b=Ewe1eu3Pqk6Nvox0iPbBFVuWgAUd7ArhkJRv1Ah13Lq4q3MVwCTbP9cH0YKljtrN4
         mjpGokzMiwAdKk0Lv8r+7SMfYz4MPyHsMzSfDOF59x8ZdTxcPuJYQNP+9eykc7MIQZ
         uItnJGJbK4uBVBffnpaAgNDR1In36XHH0Sjaa3NtsdScCEUtpZvZeQzmW9ukzsP38V
         Dyts46g66mscfbqbBw4RlF85IOUJrS4IEQ9IhmRqKQQvOzfNDC0CDfDRedjUSpmvzR
         aDPn90Frz/Xw1ArEeQdmFjP/PQXgMMDg0jNk0htliCrIf7eRLnkYpK6D/GadattNnA
         TVrt8m/PVG2rQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] iio: st-sensors: Remove some unused includes and add some that should be there
Date:   Tue,  8 Jun 2021 18:51:49 +0100
Message-Id: <20210608175149.4019289-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The st-sensors drivers have changed in structure over time, and includes
have not always kept up with this.  Let's bring them back to nearer
the ideal.

Identified with the  include-what-you-use tool and careful checking of
its suggestions.

Note I haven't been particularly aggressive here, so this is just the
cases where the include obviously isn't needed rather than the more
subtle corners.

Note I took the opportunity to add mod_devicetable.h as I generally
prefer to see that when acpi or of match tables are present.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Denis Ciocca <denis.ciocca@st.com>
Cc: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/st_accel_buffer.c                |  7 +------
 drivers/iio/accel/st_accel_core.c                  |  8 ++------
 drivers/iio/accel/st_accel_i2c.c                   |  3 +--
 drivers/iio/accel/st_accel_spi.c                   |  2 +-
 drivers/iio/common/st_sensors/st_sensors_buffer.c  |  2 --
 drivers/iio/common/st_sensors/st_sensors_core.c    |  1 +
 drivers/iio/common/st_sensors/st_sensors_core.h    |  1 +
 drivers/iio/common/st_sensors/st_sensors_i2c.c     |  3 +--
 drivers/iio/common/st_sensors/st_sensors_spi.c     |  3 +--
 drivers/iio/common/st_sensors/st_sensors_trigger.c |  1 -
 drivers/iio/gyro/st_gyro_buffer.c                  |  7 +------
 drivers/iio/gyro/st_gyro_core.c                    |  9 ++-------
 drivers/iio/gyro/st_gyro_i2c.c                     |  2 +-
 drivers/iio/gyro/st_gyro_spi.c                     |  2 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c       |  1 +
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c        |  3 ++-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c        |  3 ++-
 drivers/iio/magnetometer/st_magn_buffer.c          |  7 +------
 drivers/iio/magnetometer/st_magn_core.c            | 11 +++--------
 drivers/iio/magnetometer/st_magn_i2c.c             |  2 +-
 drivers/iio/magnetometer/st_magn_spi.c             |  2 +-
 drivers/iio/pressure/st_pressure_buffer.c          |  7 +------
 drivers/iio/pressure/st_pressure_core.c            | 10 ++--------
 drivers/iio/pressure/st_pressure_i2c.c             |  3 ++-
 drivers/iio/pressure/st_pressure_spi.c             |  2 +-
 25 files changed, 31 insertions(+), 71 deletions(-)

diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
index 492263589e04..f89770f251d9 100644
--- a/drivers/iio/accel/st_accel_buffer.c
+++ b/drivers/iio/accel/st_accel_buffer.c
@@ -9,14 +9,9 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/stat.h>
-#include <linux/interrupt.h>
-#include <linux/i2c.h>
-#include <linux/delay.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
-#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/trigger.h>
 #include <linux/iio/triggered_buffer.h>
 
 #include <linux/iio/common/st_sensors.h>
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 28fceac9f2f6..365e4e64ca18 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -9,17 +9,13 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/sysfs.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
-#include <linux/errno.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/i2c.h>
-#include <linux/irq.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
-#include <linux/iio/buffer.h>
 
 #include <linux/iio/common/st_sensors.h>
 #include "st_accel.h"
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index 95e305b88d5e..f711756e41e3 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -9,11 +9,10 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/slab.h>
+#include <linux/mod_devicetable.h>
 #include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
-#include <linux/property.h>
 
 #include <linux/iio/common/st_sensors_i2c.h>
 #include "st_accel.h"
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index 83d3308ce5cc..bb45d9ff95b8 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -9,7 +9,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/slab.h>
+#include <linux/mod_devicetable.h>
 #include <linux/spi/spi.h>
 #include <linux/iio/iio.h>
 
diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
index 802f9ae04cf4..dccc471e79da 100644
--- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
+++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
@@ -9,13 +9,11 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/slab.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
 #include <linux/interrupt.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/trigger_consumer.h>
-#include <linux/iio/triggered_buffer.h>
 #include <linux/irqreturn.h>
 #include <linux/regmap.h>
 
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 7a69c1be7393..0bbb090b108c 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
+#include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.h b/drivers/iio/common/st_sensors/st_sensors_core.h
index e8894be55660..09f3e602a2e2 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.h
+++ b/drivers/iio/common/st_sensors/st_sensors_core.h
@@ -4,6 +4,7 @@
  */
 #ifndef __ST_SENSORS_CORE_H
 #define __ST_SENSORS_CORE_H
+struct iio_dev;
 int st_sensors_write_data_with_mask(struct iio_dev *indio_dev,
 				    u8 reg_addr, u8 mask, u8 data);
 #endif
diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
index b9e59ad32a02..b3ff88700866 100644
--- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
+++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
@@ -7,15 +7,14 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
+#include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/slab.h>
 #include <linux/iio/iio.h>
 #include <linux/regmap.h>
 
 #include <linux/iio/common/st_sensors_i2c.h>
 
-
 #define ST_SENSORS_I2C_MULTIREAD	0x80
 
 static const struct regmap_config st_sensors_i2c_regmap_config = {
diff --git a/drivers/iio/common/st_sensors/st_sensors_spi.c b/drivers/iio/common/st_sensors/st_sensors_spi.c
index 48fc41dc5633..0d1d66c77cd8 100644
--- a/drivers/iio/common/st_sensors/st_sensors_spi.c
+++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
@@ -9,13 +9,12 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/slab.h>
 #include <linux/iio/iio.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/spi/spi.h>
 
 #include <linux/iio/common/st_sensors_spi.h>
-#include "st_sensors_core.h"
 
 #define ST_SENSORS_SPI_MULTIREAD	0xc0
 
diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
index 0b511665dee5..64e0a748a855 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -9,7 +9,6 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/slab.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
 #include <linux/interrupt.h>
diff --git a/drivers/iio/gyro/st_gyro_buffer.c b/drivers/iio/gyro/st_gyro_buffer.c
index 4feb7ada7195..02b5562b6585 100644
--- a/drivers/iio/gyro/st_gyro_buffer.c
+++ b/drivers/iio/gyro/st_gyro_buffer.c
@@ -9,14 +9,9 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/stat.h>
-#include <linux/interrupt.h>
-#include <linux/i2c.h>
-#include <linux/delay.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
-#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/trigger.h>
 #include <linux/iio/triggered_buffer.h>
 
 #include <linux/iio/common/st_sensors.h>
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index b86ee4d940d9..fe227ad400f0 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -9,17 +9,12 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/errno.h>
-#include <linux/types.h>
+#include <linux/mutex.h>
 #include <linux/interrupt.h>
-#include <linux/i2c.h>
-#include <linux/irq.h>
-#include <linux/delay.h>
+#include <linux/sysfs.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
-#include <linux/iio/buffer.h>
 
 #include <linux/iio/common/st_sensors.h>
 #include "st_gyro.h"
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index a25cc0379e16..3ef86e16ee65 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -9,7 +9,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/slab.h>
+#include <linux/mod_devicetable.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 
diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index 18d6a2aeda45..41d835493347 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -9,7 +9,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/slab.h>
+#include <linux/mod_devicetable.h>
 #include <linux/spi/spi.h>
 #include <linux/iio/iio.h>
 
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
index 8204f7303fd7..5e6625140db7 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
@@ -10,6 +10,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
 #include <linux/iio/common/st_sensors.h>
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
index 50a36ab53bc3..78bede358747 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
@@ -10,7 +10,8 @@
 #include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/slab.h>
+#include <linux/mod_devicetable.h>
+#include <linux/regmap.h>
 
 #include <linux/iio/common/st_sensors_i2c.h>
 
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
index 272c88990dd0..180b54e66438 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
@@ -9,7 +9,8 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/slab.h>
+#include <linux/mod_devicetable.h>
+#include <linux/regmap.h>
 #include <linux/spi/spi.h>
 
 #include <linux/iio/common/st_sensors_spi.h>
diff --git a/drivers/iio/magnetometer/st_magn_buffer.c b/drivers/iio/magnetometer/st_magn_buffer.c
index 4917721fa2e5..68f01714304f 100644
--- a/drivers/iio/magnetometer/st_magn_buffer.c
+++ b/drivers/iio/magnetometer/st_magn_buffer.c
@@ -9,14 +9,9 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/stat.h>
-#include <linux/interrupt.h>
-#include <linux/i2c.h>
-#include <linux/delay.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
-#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/trigger.h>
 #include <linux/iio/triggered_buffer.h>
 
 #include <linux/iio/common/st_sensors.h>
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 0048c3cd36ee..2c44a92590fc 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -9,16 +9,11 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/errno.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/i2c.h>
-#include <linux/irq.h>
-#include <linux/delay.h>
+#include <linux/mutex.h>
+#include <linux/sysfs.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-#include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
 
 #include <linux/iio/common/st_sensors.h>
 #include "st_magn.h"
diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
index 3e23c117de8e..2dfe4ee99591 100644
--- a/drivers/iio/magnetometer/st_magn_i2c.c
+++ b/drivers/iio/magnetometer/st_magn_i2c.c
@@ -9,7 +9,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/slab.h>
+#include <linux/mod_devicetable.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 
diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
index 03c0a737aba6..fba978796395 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -9,7 +9,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/slab.h>
+#include <linux/mod_devicetable.h>
 #include <linux/spi/spi.h>
 #include <linux/iio/iio.h>
 
diff --git a/drivers/iio/pressure/st_pressure_buffer.c b/drivers/iio/pressure/st_pressure_buffer.c
index 7cf6f06797e1..b651e7c31e90 100644
--- a/drivers/iio/pressure/st_pressure_buffer.c
+++ b/drivers/iio/pressure/st_pressure_buffer.c
@@ -9,14 +9,9 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/stat.h>
-#include <linux/interrupt.h>
-#include <linux/i2c.h>
-#include <linux/delay.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
-#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/trigger.h>
 #include <linux/iio/triggered_buffer.h>
 
 #include <linux/iio/common/st_sensors.h>
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 7912b5a68395..4ff6d40e3670 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -9,17 +9,11 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/errno.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/i2c.h>
-#include <linux/irq.h>
-#include <linux/delay.h>
+#include <linux/mutex.h>
+#include <linux/sysfs.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
-#include <linux/iio/buffer.h>
 #include <asm/unaligned.h>
 
 #include <linux/iio/common/st_sensors.h>
diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index f0a5af314ceb..52fa98f24478 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -7,9 +7,10 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
+#include <linux/acpi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/slab.h>
+#include <linux/mod_devicetable.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 
diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
index b48cf7d01cd7..ee393df54cee 100644
--- a/drivers/iio/pressure/st_pressure_spi.c
+++ b/drivers/iio/pressure/st_pressure_spi.c
@@ -9,7 +9,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/slab.h>
+#include <linux/mod_devicetable.h>
 #include <linux/spi/spi.h>
 #include <linux/iio/iio.h>
 
-- 
2.31.1

