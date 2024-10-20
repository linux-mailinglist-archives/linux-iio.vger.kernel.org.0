Return-Path: <linux-iio+bounces-10823-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C210C9A55AF
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 20:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7364A2810B3
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 18:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE36194ACA;
	Sun, 20 Oct 2024 18:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFp67uDE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5517462
	for <linux-iio@vger.kernel.org>; Sun, 20 Oct 2024 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729447655; cv=none; b=f8qyf1xPF0ZnkO65O0MpYvKhniEMrTrKFkyAWDg/AE41xa12VOLWVE/M3/y9F5Wl8PCYKJqVrncLIo15jKPCOs5ilxNtIdJjAcekGU7s4vR4ZFmGj/QnIhhdR6zNQ6Z4HF5SbJz5wbK5TgZ+0Qfu3E9RR7Q2/qU3ycKl164/bL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729447655; c=relaxed/simple;
	bh=owU6QdBUBmqBnYeY6I+jqeKFcjm2zdyJtKjciWxA6qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nZhFxNdcekFtPX4Cy6qMzr8DCCz4HVrPF8CPG8lX7VghPIzm76zP94V4zl9E77fhdz8k1lHN9DpHpA9e5qhsKnB3CAdOo3FQbtjmBeNSMmY7TeyEwBA+1k4h4ojWE/+49iMHrWnDafGkSUFjZ461b0sApTTr3oyp1p+oOy3yjJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFp67uDE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD57C4CEC6;
	Sun, 20 Oct 2024 18:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729447655;
	bh=owU6QdBUBmqBnYeY6I+jqeKFcjm2zdyJtKjciWxA6qs=;
	h=From:To:Cc:Subject:Date:From;
	b=MFp67uDEXVw93Lovt36yUuTS0q1XqBrgvxtOrq2eUcPP9t9guWTuKzHX/MNAIsMLi
	 uh2xWBc167H6+iIjHN/I2WTvXbNy7Z2rzRb5qGU1kS0NUnzhJR+sD7V4lVilEjgJxh
	 NPx4N5Xmx57JcFT4VR9grbKvn1obitnMU+G/ADKi5v3t6e98ayT0cGrERnxgLiA7bj
	 S7l0/NRvrzvIc6ZlWJbcpdfVrASDBbOYgW7Pcx5gm97nZUnNvUikT/AYQ0rQHEm6UB
	 txK5V7rcUkYomnEak8up9GwI8raEzH0qYefUlktKPFwWeR8ozkbHYi95lxRWxG+DsF
	 uuhmYQhCwcAuw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] iio: accel: replace s64 __aligned(8) with aligned_s64
Date: Sun, 20 Oct 2024 19:07:20 +0100
Message-ID: <20241020180720.496327-1-jic23@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

e4ca0e59c394 ("types: Complement the aligned types with signed 64-bit one")
introduced aligned_s64. Use it for all IIO accelerometer drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---

I debated whether to split this up by driver by the time we've done all IIO
drivers that will be a very large number of trivial patches.

The changes are minor enough that they shouldn't present much of a
backporting challenge if needed for future fixes etc.

I'm find splitting them up if people prefer.
Next on my list is to look at adding runtime checks that the buffers
containing these timestamps are big enough but I want this out of the
way first.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/bma180.c          | 3 ++-
 drivers/iio/accel/bma220_spi.c      | 1 +
 drivers/iio/accel/bma400_core.c     | 2 +-
 drivers/iio/accel/bmc150-accel.h    | 3 ++-
 drivers/iio/accel/fxls8962af-core.c | 3 ++-
 drivers/iio/accel/kionix-kx022a.c   | 3 ++-
 drivers/iio/accel/kxcjk-1013.c      | 3 ++-
 drivers/iio/accel/kxsd9.c           | 3 ++-
 drivers/iio/accel/mma7455_core.c    | 3 ++-
 drivers/iio/accel/mma8452.c         | 3 ++-
 drivers/iio/accel/msa311.c          | 3 ++-
 drivers/iio/accel/mxc4005.c         | 3 ++-
 drivers/iio/accel/stk8312.c         | 3 ++-
 drivers/iio/accel/stk8ba50.c        | 3 ++-
 14 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 1fe20eb78a0b..41a517e1630f 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -21,6 +21,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/types.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
@@ -144,7 +145,7 @@ struct bma180_data {
 	/* Ensure timestamp is naturally aligned */
 	struct {
 		s16 chan[4];
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 };
 
diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index d33218e40c79..2d27a592a61e 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/types.h>
 #include <linux/spi/spi.h>
 
 #include <linux/iio/buffer.h>
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index d96840d135c6..eb32c963dfc8 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -115,7 +115,7 @@ struct bma400_data {
 	struct {
 		__le16 buff[3];
 		u8 temperature;
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} buffer __aligned(IIO_DMA_MINALIGN);
 	__le16 status;
 	__be16 duration;
diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
index 7775c5edaeef..7a7baf52e595 100644
--- a/drivers/iio/accel/bmc150-accel.h
+++ b/drivers/iio/accel/bmc150-accel.h
@@ -6,6 +6,7 @@
 #include <linux/iio/iio.h>
 #include <linux/mutex.h>
 #include <linux/regulator/consumer.h>
+#include <linux/types.h>
 #include <linux/workqueue.h>
 
 struct regmap;
@@ -69,7 +70,7 @@ struct bmc150_accel_data {
 	 */
 	struct {
 		__le16 channels[3];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 	u8 bw_bits;
 	u32 slope_dur;
diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 37f33c29fb4b..ab427f3461db 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -22,6 +22,7 @@
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
+#include <linux/types.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
@@ -163,7 +164,7 @@ struct fxls8962af_data {
 	const struct fxls8962af_chip_info *chip_info;
 	struct {
 		__le16 channels[3];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 	int64_t timestamp, old_timestamp;	/* Only used in hw fifo mode. */
 	struct iio_mount_matrix orientation;
diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index 53d59a04ae15..32387819995d 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -16,6 +16,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/string_choices.h>
+#include <linux/types.h>
 #include <linux/units.h>
 
 #include <linux/iio/iio.h>
@@ -292,7 +293,7 @@ struct kx022a_data {
 	__le16 buffer[8] __aligned(IIO_DMA_MINALIGN);
 	struct {
 		__le16 channels[3];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 };
 
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index b76df8816323..bbf65fc97b08 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -11,6 +11,7 @@
 #include <linux/bitops.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/types.h>
 #include <linux/acpi.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
@@ -250,7 +251,7 @@ struct kxcjk1013_data {
 	/* Ensure timestamp naturally aligned */
 	struct {
 		s16 chans[AXIS_MAX];
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 	u8 odr_bits;
 	u8 range;
diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 70dfd6e354db..6d2b0a22e550 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/sysfs.h>
 #include <linux/slab.h>
+#include <linux/types.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/bitops.h>
@@ -215,7 +216,7 @@ static irqreturn_t kxsd9_trigger_handler(int irq, void *p)
 	 */
 	struct {
 		__be16 chan[4];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} hw_values;
 	int ret;
 
diff --git a/drivers/iio/accel/mma7455_core.c b/drivers/iio/accel/mma7455_core.c
index a34195b3215d..50f7ac1845c6 100644
--- a/drivers/iio/accel/mma7455_core.c
+++ b/drivers/iio/accel/mma7455_core.c
@@ -19,6 +19,7 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/types.h>
 
 #include "mma7455.h"
 
@@ -58,7 +59,7 @@ struct mma7455_data {
 	 */
 	struct {
 		__le16 channels[3];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 };
 
diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 62e6369e2269..de4525b30edc 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -32,6 +32,7 @@
 #include <linux/delay.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
+#include <linux/types.h>
 
 #define MMA8452_STATUS				0x00
 #define  MMA8452_STATUS_DRDY			(BIT(2) | BIT(1) | BIT(0))
@@ -115,7 +116,7 @@ struct mma8452_data {
 	/* Ensure correct alignment of time stamp when present */
 	struct {
 		__be16 channels[3];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} buffer;
 };
 
diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
index 57025354c7cd..e7fb860f3233 100644
--- a/drivers/iio/accel/msa311.c
+++ b/drivers/iio/accel/msa311.c
@@ -34,6 +34,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/string_choices.h>
+#include <linux/types.h>
 #include <linux/units.h>
 
 #include <linux/iio/buffer.h>
@@ -893,7 +894,7 @@ static irqreturn_t msa311_buffer_thread(int irq, void *p)
 	__le16 axis;
 	struct {
 		__le16 channels[MSA311_SI_Z + 1];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} buf;
 
 	memset(&buf, 0, sizeof(buf));
diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index fc54a2a4693c..cb5c4e354fc0 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -11,6 +11,7 @@
 #include <linux/iio/iio.h>
 #include <linux/mod_devicetable.h>
 #include <linux/regmap.h>
+#include <linux/types.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/buffer.h>
@@ -69,7 +70,7 @@ struct mxc4005_data {
 	/* Ensure timestamp is naturally aligned */
 	struct {
 		__be16 chans[3];
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 	bool trigger_enabled;
 	unsigned int control;
diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index abead190254b..471c154c3631 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
+#include <linux/types.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -105,7 +106,7 @@ struct stk8312_data {
 	/* Ensure timestamp is naturally aligned */
 	struct {
 		s8 chans[3];
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 };
 
diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index a32a77324e92..cab592a68622 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/types.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -94,7 +95,7 @@ struct stk8ba50_data {
 	/* Ensure timestamp is naturally aligned */
 	struct {
 		s16 chans[3];
-		s64 timetamp __aligned(8);
+		aligned_s64 timetamp;
 	} scan;
 };
 
-- 
2.46.2


