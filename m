Return-Path: <linux-iio+bounces-21543-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB5BB009A4
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 19:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A9871C878A0
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 17:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF2042A9D;
	Thu, 10 Jul 2025 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQbqbMY4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4B82F0C76
	for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167495; cv=none; b=LuKHPcHpxDiZ8F/BmZXF0yDXk5r1zFY2Dwl4myu9jUVXMDIdX9krTghzIHjBWh3emJ8BbTWPpFmPaWk2C11yQIP/WC9rD1E8ju7G+tWL97vXsOjXmm4bcvkhMRQslHueIqEsGqL6s+6/Sa0PfNPisQ5GThPh7kS0d4AwzcIMaG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167495; c=relaxed/simple;
	bh=8DiZhErwf5b9Dkka8EHoDnoq4HtKyKz1QyqIbESb1fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4lUwS4IDOYKaZEUJ828TuzkNbI+UtuFLmg6iBRoKAR6YwWTWLsvhd38l2EGXb2c9GG0EmVn3w6oVtVu/mKnSBi2UE2QKax1tLPMUuPtTnbhfPoOebUd0GKViN7aMMLEzGUpE4F7LOfrMeV/02WWiuaPU8qsw+o7gxniXrW5Ar8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQbqbMY4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA958C4CEE3;
	Thu, 10 Jul 2025 17:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752167494;
	bh=8DiZhErwf5b9Dkka8EHoDnoq4HtKyKz1QyqIbESb1fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nQbqbMY4POPda/2tOcFBoqGC0Su/PZfUE8N7Pm2/h8EF78Ax2/TUtAInaRdGjwm1W
	 F5WSkHARzbVBxilKn4gP9ZRLR/Ht0do7CqN6JaiUWqEkHXztdUAfmA/AMskSxSGmuU
	 tF4LgjqaHmoL3BM36ln/YVGDzgxJ39+S+KJ5pb0rKDQsSa6aCI2QY1ERItHag8LgOY
	 C5EADsWUEoUVfDR4chxmlkhpyp90lEdPJtXOR8yXyfFkvxRG0phIZvzF6xWCvCGn0e
	 fQpnfjpp2xJJK5f6wfOVuEB6kE4VIghwplsD4urKP7nZBAgjaXQLi8DLjlDmmpuZ6w
	 qsfMk7YrRu+pQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>
Cc: Denis Ciocca <denis.ciocca@st.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 7/7] iio: st_sensors: Apply IWYU principles to includes
Date: Thu, 10 Jul 2025 18:11:07 +0100
Message-ID: <20250710171107.443790-8-jic23@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710171107.443790-1-jic23@kernel.org>
References: <20250710171107.443790-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Motivated initially by the new W=1 warning for missing linux/export.h
includes, this is taking a fresh look at what should be included
across the various library and type specific bits of st_sensors.

It approximately follows include what you use principles but with some
fuzzy matching for things like dev_printk.h. If only dev_err()
etc are used in code and device.h does not otherwise need to be included
we only include linux/dev_printk.h. If device.h is needed for other reasons
only include that.  That is we assume device.h will continue to
include dev_printk.h.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Note I haven't figure out what official path to PAGE_SIZE is but
 the relevant code needs a rewrite anyway so I've left it for now.
 
 drivers/iio/accel/st_accel_buffer.c           |  6 ++++--
 drivers/iio/accel/st_accel_core.c             | 12 +++++++++---
 drivers/iio/accel/st_accel_i2c.c              |  5 ++++-
 drivers/iio/accel/st_accel_spi.c              |  3 ++-
 .../iio/common/st_sensors/st_sensors_buffer.c | 15 ++++++++++-----
 .../iio/common/st_sensors/st_sensors_core.c   | 19 +++++++++++++++----
 .../iio/common/st_sensors/st_sensors_core.h   |  2 ++
 .../iio/common/st_sensors/st_sensors_i2c.c    |  8 ++++++--
 .../iio/common/st_sensors/st_sensors_spi.c    | 11 +++++++++--
 .../common/st_sensors/st_sensors_trigger.c    | 13 ++++++++++---
 drivers/iio/gyro/st_gyro_buffer.c             |  6 ++++--
 drivers/iio/gyro/st_gyro_core.c               | 11 ++++++++---
 drivers/iio/gyro/st_gyro_i2c.c                |  3 ++-
 drivers/iio/gyro/st_gyro_spi.c                |  3 ++-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c  |  5 ++++-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c   |  5 ++---
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c   |  5 ++---
 drivers/iio/magnetometer/st_magn_buffer.c     |  5 +++--
 drivers/iio/magnetometer/st_magn_core.c       | 11 ++++++++---
 drivers/iio/magnetometer/st_magn_i2c.c        |  3 ++-
 drivers/iio/magnetometer/st_magn_spi.c        |  3 ++-
 drivers/iio/pressure/st_pressure_buffer.c     |  6 ++++--
 drivers/iio/pressure/st_pressure_core.c       |  9 ++++++---
 drivers/iio/pressure/st_pressure_i2c.c        |  3 ++-
 drivers/iio/pressure/st_pressure_spi.c        |  3 ++-
 include/linux/iio/common/st_sensors_i2c.h     |  5 ++---
 include/linux/iio/common/st_sensors_spi.h     |  5 ++---
 27 files changed, 128 insertions(+), 57 deletions(-)

diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
index b2977ae19b69..53ed46db122d 100644
--- a/drivers/iio/accel/st_accel_buffer.c
+++ b/drivers/iio/accel/st_accel_buffer.c
@@ -7,9 +7,11 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
-#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
+
 #include <linux/iio/iio.h>
-#include <linux/iio/buffer.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/triggered_buffer.h>
 
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 99cb661fabb2..c1a44eca4e15 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -7,16 +7,22 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
-#include <linux/kernel.h>
+#include <linux/acpi.h>
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
 #include <linux/sysfs.h>
 #include <linux/slab.h>
-#include <linux/acpi.h>
+#include <linux/stddef.h>
+
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
 
+#include <linux/platform_data/st_sensors_pdata.h>
 #include <linux/iio/common/st_sensors.h>
 #include "st_accel.h"
 
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index f24449500533..3f567c63c287 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -7,12 +7,15 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
-#include <linux/kernel.h>
+#include <linux/dev_printk.h>
+#include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/i2c.h>
+
 #include <linux/iio/iio.h>
 
+#include <linux/iio/common/st_sensors.h>
 #include <linux/iio/common/st_sensors_i2c.h>
 #include "st_accel.h"
 
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index d8ec0555f42a..7d9f56df3f75 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -7,7 +7,8 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
-#include <linux/kernel.h>
+#include <linux/dev_printk.h>
+#include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/spi/spi.h>
diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
index 57f087c2216f..56943bc37592 100644
--- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
+++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
@@ -7,14 +7,19 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
-#include <linux/kernel.h>
+#include <linux/align.h>
+#include <linux/bitmap.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/math.h>
+#include <linux/irqreturn.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
 #include <linux/iio/iio.h>
-#include <linux/iio/trigger.h>
-#include <linux/interrupt.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
-#include <linux/irqreturn.h>
-#include <linux/regmap.h>
 
 #include <linux/iio/common/st_sensors.h>
 
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 8ce1dccfea4f..ab6e38f1f23a 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -7,16 +7,27 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/slab.h>
+#include <linux/array_size.h>
+#include <linux/bitops.h>
 #include <linux/delay.h>
-#include <linux/iio/iio.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/math.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/sprintf.h>
+#include <linux/stddef.h>
+#include <linux/string.h>
 #include <linux/unaligned.h>
+
+#include <linux/iio/iio.h>
+
+#include <linux/platform_data/st_sensors_pdata.h>
 #include <linux/iio/common/st_sensors.h>
 
 #include "st_sensors_core.h"
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.h b/drivers/iio/common/st_sensors/st_sensors_core.h
index 09f3e602a2e2..efd7cc1a97ed 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.h
+++ b/drivers/iio/common/st_sensors/st_sensors_core.h
@@ -4,6 +4,8 @@
  */
 #ifndef __ST_SENSORS_CORE_H
 #define __ST_SENSORS_CORE_H
+#include <linux/types.h>
+
 struct iio_dev;
 int st_sensors_write_data_with_mask(struct iio_dev *indio_dev,
 				    u8 reg_addr, u8 mask, u8 data);
diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
index 7156302fe997..e524845e4e09 100644
--- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
+++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
@@ -7,12 +7,16 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/export.h>
 #include <linux/i2c.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/iio/iio.h>
 #include <linux/regmap.h>
 
+#include <linux/iio/iio.h>
+
+#include <linux/iio/common/st_sensors.h>
 #include <linux/iio/common/st_sensors_i2c.h>
 
 #define ST_SENSORS_I2C_MULTIREAD	0x80
diff --git a/drivers/iio/common/st_sensors/st_sensors_spi.c b/drivers/iio/common/st_sensors/st_sensors_spi.c
index 0da27013943d..8310e235c019 100644
--- a/drivers/iio/common/st_sensors/st_sensors_spi.c
+++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
@@ -7,13 +7,20 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
-#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/export.h>
 #include <linux/module.h>
-#include <linux/iio/iio.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
+
+#include <linux/iio/iio.h>
 
+#include <linux/platform_data/st_sensors_pdata.h>
+#include <linux/iio/common/st_sensors.h>
 #include <linux/iio/common/st_sensors_spi.h>
 
 #define ST_SENSORS_SPI_MULTIREAD	0xc0
diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
index 9d4bf822a15d..9746e5a30de0 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -7,11 +7,18 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
-#include <linux/kernel.h>
-#include <linux/iio/iio.h>
-#include <linux/iio/trigger.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/regmap.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+
 #include <linux/iio/common/st_sensors.h>
 #include "st_sensors_core.h"
 
diff --git a/drivers/iio/gyro/st_gyro_buffer.c b/drivers/iio/gyro/st_gyro_buffer.c
index 1ebfe7aa6c96..cb78552e17a1 100644
--- a/drivers/iio/gyro/st_gyro_buffer.c
+++ b/drivers/iio/gyro/st_gyro_buffer.c
@@ -7,9 +7,11 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
-#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
+
 #include <linux/iio/iio.h>
-#include <linux/iio/buffer.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/triggered_buffer.h>
 
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index 7fd82cd707c7..ac6b35fb7aac 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -7,15 +7,20 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
-#include <linux/kernel.h>
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/interrupt.h>
+#include <linux/stddef.h>
 #include <linux/sysfs.h>
+
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
 
+#include <linux/platform_data/st_sensors_pdata.h>
 #include <linux/iio/common/st_sensors.h>
 #include "st_gyro.h"
 
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index aef5ec8f9dee..d699518a18ab 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -7,7 +7,8 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
-#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/i2c.h>
diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index f645da157372..61c03b72b57e 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -7,7 +7,8 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
-#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/spi/spi.h>
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
index 8f4a67edb335..8af4ab21bd22 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c
@@ -8,7 +8,8 @@
  */
 
 #include <linux/array_size.h>
-#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/export.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
@@ -18,6 +19,8 @@
 
 #include "st_lsm9ds0.h"
 
+struct regmap;
+
 static int st_lsm9ds0_probe_accel(struct st_lsm9ds0 *lsm9ds0, struct regmap *regmap)
 {
 	const struct st_sensor_settings *settings;
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
index 4232a9d800fc..0eb0564801cb 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
@@ -7,15 +7,14 @@
  * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  */
 
-#include <linux/device/devres.h>
+#include <linux/device.h>
 #include <linux/err.h>
-#include <linux/gfp_types.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/regmap.h>
 
-#include <linux/iio/common/st_sensors_i2c.h>
+#include <linux/iio/common/st_sensors.h>
 
 #include "st_lsm9ds0.h"
 
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
index acea8a0757d7..b72ad380aa2f 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
@@ -7,15 +7,14 @@
  * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  */
 
-#include <linux/device/devres.h>
+#include <linux/device.h>
 #include <linux/err.h>
-#include <linux/gfp_types.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
 
-#include <linux/iio/common/st_sensors_spi.h>
+#include <linux/iio/common/st_sensors.h>
 
 #include "st_lsm9ds0.h"
 
diff --git a/drivers/iio/magnetometer/st_magn_buffer.c b/drivers/iio/magnetometer/st_magn_buffer.c
index 79987f42e8d9..91f4b077a554 100644
--- a/drivers/iio/magnetometer/st_magn_buffer.c
+++ b/drivers/iio/magnetometer/st_magn_buffer.c
@@ -6,10 +6,11 @@
  *
  * Denis Ciocca <denis.ciocca@st.com>
  */
+#include <linux/device.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
 
-#include <linux/kernel.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/buffer.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/triggered_buffer.h>
 
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index ef348d316c00..7508a7cf74d4 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -6,15 +6,20 @@
  *
  * Denis Ciocca <denis.ciocca@st.com>
  */
-
-#include <linux/kernel.h>
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
+#include <linux/stddef.h>
 #include <linux/sysfs.h>
+
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
 
+#include <linux/platform_data/st_sensors_pdata.h>
 #include <linux/iio/common/st_sensors.h>
 #include "st_magn.h"
 
diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
index ed70e782af5e..e58fec268be1 100644
--- a/drivers/iio/magnetometer/st_magn_i2c.c
+++ b/drivers/iio/magnetometer/st_magn_i2c.c
@@ -7,7 +7,8 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
-#include <linux/kernel.h>
+#include <linux/dev_printk.h>
+#include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/i2c.h>
diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
index 68816362bb95..2a6b0715bb85 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -7,7 +7,8 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
-#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/spi/spi.h>
diff --git a/drivers/iio/pressure/st_pressure_buffer.c b/drivers/iio/pressure/st_pressure_buffer.c
index 0dbf357c2c22..b83eb7bad11a 100644
--- a/drivers/iio/pressure/st_pressure_buffer.c
+++ b/drivers/iio/pressure/st_pressure_buffer.c
@@ -7,9 +7,11 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
-#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
+
 #include <linux/iio/iio.h>
-#include <linux/iio/buffer.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/triggered_buffer.h>
 
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index b70d1cee82f3..cb5cca094ca9 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -7,14 +7,17 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
-#include <linux/kernel.h>
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
+#include <linux/stddef.h>
 #include <linux/sysfs.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
-#include <linux/unaligned.h>
 
 #include <linux/iio/common/st_sensors.h>
 #include "st_pressure.h"
diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index 0f50bac1fb4d..c6ace6ec6e81 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -7,7 +7,8 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
-#include <linux/kernel.h>
+#include <linux/dev_printk.h>
+#include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/i2c.h>
diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
index 39827e6841ca..9df0b94f9ccf 100644
--- a/drivers/iio/pressure/st_pressure_spi.c
+++ b/drivers/iio/pressure/st_pressure_spi.c
@@ -7,7 +7,8 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
-#include <linux/kernel.h>
+#include <linux/dev_printk.h>
+#include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/spi/spi.h>
diff --git a/include/linux/iio/common/st_sensors_i2c.h b/include/linux/iio/common/st_sensors_i2c.h
index 5f15cf01036c..e9d9a477ef67 100644
--- a/include/linux/iio/common/st_sensors_i2c.h
+++ b/include/linux/iio/common/st_sensors_i2c.h
@@ -10,9 +10,8 @@
 #ifndef ST_SENSORS_I2C_H
 #define ST_SENSORS_I2C_H
 
-#include <linux/i2c.h>
-#include <linux/iio/common/st_sensors.h>
-
+struct iio_dev;
+struct i2c_client;
 int st_sensors_i2c_configure(struct iio_dev *indio_dev,
 			     struct i2c_client *client);
 
diff --git a/include/linux/iio/common/st_sensors_spi.h b/include/linux/iio/common/st_sensors_spi.h
index 90b25f087f06..0bd341330b80 100644
--- a/include/linux/iio/common/st_sensors_spi.h
+++ b/include/linux/iio/common/st_sensors_spi.h
@@ -10,9 +10,8 @@
 #ifndef ST_SENSORS_SPI_H
 #define ST_SENSORS_SPI_H
 
-#include <linux/spi/spi.h>
-#include <linux/iio/common/st_sensors.h>
-
+struct iio_dev;
+struct spi_device;
 int st_sensors_spi_configure(struct iio_dev *indio_dev,
 			     struct spi_device *spi);
 
-- 
2.50.0


