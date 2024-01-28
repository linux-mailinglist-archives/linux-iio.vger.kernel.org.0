Return-Path: <linux-iio+bounces-1972-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 765D383F527
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 12:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2565928370A
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 11:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA521F60B;
	Sun, 28 Jan 2024 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIB9lSFh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21781DA44;
	Sun, 28 Jan 2024 11:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706441184; cv=none; b=afY984vJaWdFlqSxY3v25KlFzowUuYUflbn5zoQeACsEGMKnARqOkzZJc1AUz87442/5Y/WbsalhrOs+487NN4QUviNVontrkvioG9s2KPcAKsU+EjE3eIqMNS05l6jf23uCkq4ZDQW/qgYSTWG9g8wD9gCYT2vBSRbqphNG7og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706441184; c=relaxed/simple;
	bh=PcSPrRcint2UJrLgeUUP9qfZXV+1aav3zsupmlqAYC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEwKwanuYBc+12QlqYqPholO5wSF7S9dmHLKgZEyA+m3hiRbFn+q0aTLGKfm2qrge8ZYR3j1ll7vJHWEykrAoCNSiF1ilc/bmQZEIYVefnIfzC81WT1N1pw1lqolDqDWIj9RoVcOHSjwOiNvK/P8ddNODu6E3xIcNPp4QP1W8WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIB9lSFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494D2C433F1;
	Sun, 28 Jan 2024 11:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706441184;
	bh=PcSPrRcint2UJrLgeUUP9qfZXV+1aav3zsupmlqAYC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AIB9lSFhleSXDcQVdjLwP5wVFzZxGe5E8UbJMTjrrtJaPNo9YdZf71e19BO2cXv4L
	 3aB0VHdUnbT5ZXQST4voqnfQnYjh5BehsL5MfvsHxrK5iLongHbGFVJAI8eq4J9twE
	 g9fzrJNYbDRjfxqiohxpB7TZiea3/49cNfI9nhw/lHO2UxNYeZW62hxxdAoM0uIHxv
	 eP/tqHaJDweKPKr07CUR5qTEXjCbet0SF9I62sbUwK6fDCXeNODkOPNWo62nXkWSQu
	 CLpLD4NoxBYi4uhhTwi+J+XGGG8ttUzKnPA8+02Mcxj5ZQewj2BYbGRcx0abkUULtA
	 x62e7DG0wzccw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	lorenzo.bianconi@redhat.com,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v2 1/3] iio: imu: st_lsm6dsx: improve kernel docs and comments
Date: Sun, 28 Jan 2024 12:25:43 +0100
Message-ID: <c87c21a62f8c1aa2627a9ea30372334a61a23d1e.1706441008.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706441008.git.lorenzo@kernel.org>
References: <cover.1706441008.git.lorenzo@kernel.org>
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


