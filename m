Return-Path: <linux-iio+bounces-2114-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0B784856B
	for <lists+linux-iio@lfdr.de>; Sat,  3 Feb 2024 13:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896701F239CA
	for <lists+linux-iio@lfdr.de>; Sat,  3 Feb 2024 12:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455745D91E;
	Sat,  3 Feb 2024 12:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTVayd1H"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F184D5D73A;
	Sat,  3 Feb 2024 12:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706961733; cv=none; b=h/aDEc3RmVlEIN/5d9JkZXnLsa93CxUz05Ca5TnT/l+CfaUCIBqyT9y/jKH/Y9+xCUbz/h2lxqbmwHmhDeGkCd5Hrvp5gMx1SQfTxMJcjWbUxNFInr0tJfEsWaWlFX/86XxKao3qdmbRT3X3cku7zWV8SMlXbbgxJZXU5XhPe7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706961733; c=relaxed/simple;
	bh=PcSPrRcint2UJrLgeUUP9qfZXV+1aav3zsupmlqAYC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HS5nwKcrpeQy0CKyAQsSI7LbnuyVDjVxNz465FRGL7lwMqk0PYmxGGxM8B/UGk6mb6OAdK7JTm4Os8FSf3fw0qX6pUW/WCCJGEPvZRZ1dZcjUZkrgU+Arv6RrJAu82FKsEugSQ9tByUN6vAyhQy8lmGG7Vz+Ieb1zSYgLR6ARTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTVayd1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD557C433F1;
	Sat,  3 Feb 2024 12:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706961732;
	bh=PcSPrRcint2UJrLgeUUP9qfZXV+1aav3zsupmlqAYC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fTVayd1Hjf/QK9/xMwCyGMibDEdSEoL+gG6puRF5bjXVnFxXicexYJEzm5B8f5gXU
	 5wLc95k1bN3GD/zpPV4tV+oG0v9V0e01H28QVqtV1QBKJF4keiRoBLAL53Z9eoxsuN
	 F02ggucE0PR6cS3dCN3eK6j4BbssOYkmyjRXsdSqk/waVCwcQyBFYX5+DH723UOH89
	 xVjIiIgvCKlqOXVvxXjx0XIt4yk0ZNWQlCkG4tNCfs1+PNvkFoqmaYi5vjc6gYztHz
	 BXrZegwmMYjGHNJKqUOMN5J7WmWKUdJnHjzvajWZuqffbAlzt7e4Fu3q8UFyXYvVs+
	 AN0W17ZBU61TQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	lorenzo.bianconi@redhat.com,
	devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org
Subject: [PATCH v4 1/3] iio: imu: st_lsm6dsx: improve kernel docs and comments
Date: Sat,  3 Feb 2024 13:01:36 +0100
Message-ID: <d365d048253d2ff9ee0092d391bbaa9cf0737cff.1706961432.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706961432.git.lorenzo@kernel.org>
References: <cover.1706961432.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve kernel docs and comments reporting supported sensors in a list in
order to make more easy to add new devices in the future.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/Kconfig            | 30 +++++++++++++++----
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 27 +++++++++++++++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 28 +++++++++++++----
 3 files changed, 71 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
index 5865a295a4df..24914946f914 100644
--- a/drivers/iio/imu/st_lsm6dsx/Kconfig
+++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
@@ -11,11 +11,31 @@ config IIO_ST_LSM6DSX
 	select IIO_ST_LSM6DSX_I3C if (I3C)
 	help
 	  Say yes here to build support for STMicroelectronics LSM6DSx imu
-	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
-	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, asm330lhhx, lsm6dsr,
-	  lsm6ds3tr-c, ism330dhcx, lsm6dsrx, lsm6ds0, lsm6dsop, lsm6dstx,
-	  lsm6dsv, lsm6dsv16x, lsm6dso16is, ism330is, asm330lhb, lsm6dst
-	  and the accelerometer/gyroscope of lsm9ds1.
+	  sensor.
+	  Supported devices:
+	  - asm330lhb
+	  - asm330lhh
+	  - asm330lhhx
+	  - ism330dhcx
+	  - ism330dlc
+	  - ism330is
+	  - lsm6ds0
+	  - lsm6ds3
+	  - lsm6ds3h
+	  - lsm6ds3tr-c
+	  - lsm6dsl
+	  - lsm6dsm
+	  - lsm6dso
+	  - lsm6dso16is
+	  - lsm6dsop
+	  - lsm6dsox
+	  - lsm6dsr
+	  - lsm6dsrx
+	  - lsm6dst
+	  - lsm6dstx
+	  - lsm6dsv
+	  - lsm6dsv16x
+	  - lsm9ds1
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called st_lsm6dsx.
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 066fe561c5e8..154f92fa9a87 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -2,7 +2,7 @@
 /*
  * STMicroelectronics st_lsm6dsx FIFO buffer library driver
  *
- * LSM6DS3/LSM6DS3H/LSM6DSL/LSM6DSM/ISM330DLC/LSM6DS3TR-C:
+ * Pattern FIFO:
  * The FIFO buffer can be configured to store data from gyroscope and
  * accelerometer. Samples are queued without any tag according to a
  * specific pattern based on 'FIFO data sets' (6 bytes each):
@@ -14,12 +14,33 @@
  * (e.g. Gx, Gy, Gz, Ax, Ay, Az), then data are repeated depending on the
  * value of the decimation factor and ODR set for each FIFO data set.
  *
- * LSM6DSO/LSM6DSOX/ASM330LHH/ASM330LHHX/LSM6DSR/LSM6DSRX/ISM330DHCX/
- * LSM6DST/LSM6DSOP/LSM6DSTX/LSM6DSV/ASM330LHB:
+ * Supported devices:
+ * - ISM330DLC
+ * - LSM6DS3
+ * - LSM6DS3H
+ * - LSM6DS3TR-C
+ * - LSM6DSL
+ * - LSM6DSM
+ *
+ * Tagged FIFO:
  * The FIFO buffer can be configured to store data from gyroscope and
  * accelerometer. Each sample is queued with a tag (1B) indicating data
  * source (gyroscope, accelerometer, hw timer).
  *
+ * Supported devices:
+ * - ASM330LHB
+ * - ASM330LHH
+ * - ASM330LHHX
+ * - ISM330DHCX
+ * - LSM6DSO
+ * - LSM6DSOP
+ * - LSM6DSOX
+ * - LSM6DSR
+ * - LSM6DSRX
+ * - LSM6DST
+ * - LSM6DSTX
+ * - LSM6DSV
+ *
  * FIFO supported modes:
  *  - BYPASS: FIFO disabled
  *  - CONTINUOUS: FIFO enabled. When the buffer is full, the FIFO index
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index b6e6b1df8a61..01ef9d38aadd 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -14,34 +14,50 @@
  * by a different driver.
  *
  * Supported sensors:
- * - LSM6DS3:
+ *
+ * - LSM6DS3
  *   - Accelerometer/Gyroscope supported ODR [Hz]: 12.5, 26, 52, 104, 208, 416
  *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
  *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
  *   - FIFO size: 8KB
  *
- * - LSM6DS3H/LSM6DSL/LSM6DSM/ISM330DLC/LSM6DS3TR-C:
+ * - ISM330DLC
+ * - LSM6DS3H
+ * - LSM6DS3TR-C
+ * - LSM6DSL
+ * - LSM6DSM
  *   - Accelerometer/Gyroscope supported ODR [Hz]: 12.5, 26, 52, 104, 208, 416
  *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
  *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
  *   - FIFO size: 4KB
  *
- * - LSM6DSO/LSM6DSOX/ASM330LHH/ASM330LHHX/LSM6DSR/ISM330DHCX/LSM6DST/LSM6DSOP/
- *   LSM6DSTX/LSM6DSO16IS/ISM330IS:
+ * - ASM330LHH
+ * - ASM330LHHX
+ * - ISM330DHCX
+ * - ISM330IS
+ * - LSM6DSO
+ * - LSM6DSO16IS
+ * - LSM6DSOP
+ * - LSM6DSOX
+ * - LSM6DSR
+ * - LSM6DST
+ * - LSM6DSTX
  *   - Accelerometer/Gyroscope supported ODR [Hz]: 12.5, 26, 52, 104, 208, 416,
  *     833
  *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
  *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
  *   - FIFO size: 3KB
  *
- * - LSM6DSV/LSM6DSV16X:
+ * - LSM6DSV
+ * - LSM6DSV16X
  *   - Accelerometer/Gyroscope supported ODR [Hz]: 7.5, 15, 30, 60, 120, 240,
  *     480, 960
  *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
  *   - Gyroscope supported full-scale [dps]: +-125/+-250/+-500/+-1000/+-2000
  *   - FIFO size: 3KB
  *
- * - LSM9DS1/LSM6DS0:
+ * - LSM6DS0
+ * - LSM9DS1
  *   - Accelerometer supported ODR [Hz]: 10, 50, 119, 238, 476, 952
  *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
  *   - Gyroscope supported ODR [Hz]: 15, 60, 119, 238, 476, 952
-- 
2.43.0


