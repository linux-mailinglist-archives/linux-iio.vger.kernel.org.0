Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D3C1E133B
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 19:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391298AbgEYRJT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 13:09:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391297AbgEYRJR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 25 May 2020 13:09:17 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 885A92089D;
        Mon, 25 May 2020 17:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590426556;
        bh=0ufRuxJl/lRnXdoUBSaEpO75Gd2neFd+09jSJEB88JI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kMFLyO2uXqeL6vUVHMI8e1xpxgTBlsWTstMx9G27b4gFywumWcUqwDrnhVYy/F17y
         G08U928epfIMI9VmxDiCyxuQfmUImKvbvyqyMwCgpkZhI13NC4rW+frBGC1FuyNQIR
         4gam4LBzm0/wjMhh4+np10vWFCBbeYdyQT0af73w=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 13/25] iio:imu:inv_mpu6050 Fix dma and ts alignment and data leak issues.
Date:   Mon, 25 May 2020 18:06:16 +0100
Message-Id: <20200525170628.503283-14-jic23@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525170628.503283-1-jic23@kernel.org>
References: <20200525170628.503283-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This case is a bit different to the rest of the series.  The driver
was doing a regmap_bulk_read into a buffer that wasn't dma safe
as it was on the stack with no guarantee of it being in a cacheline
on it's own.   Fixing that also dealt with the data leak and
alignment issues that Lars-Peter pointed out.

Also removed some unaligned handling as we are now aligned.

Fixes tag is for the dma safe buffer issue. Potentially we would
need to backport timestamp alignment futher but that is a totally
different patch.

Fixes: fd64df16f40e ("iio: imu: inv_mpu6050: Add SPI support for MPU6000")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  8 +++++---
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 12 ++++++------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index cd38b3fccc7b..e4df2d51b689 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -122,6 +122,9 @@ struct inv_mpu6050_chip_config {
 	u8 user_ctrl;
 };
 
+/* 6 + 6 + 2 + 7 (for MPU9x50) = 21 round up to 24 and plus 8 */
+#define INV_MPU6050_OUTPUT_DATA_SIZE         32
+
 /**
  *  struct inv_mpu6050_hw - Other important hardware information.
  *  @whoami:	Self identification byte from WHO_AM_I register
@@ -165,6 +168,7 @@ struct inv_mpu6050_hw {
  *  @magn_raw_to_gauss:	coefficient to convert mag raw value to Gauss.
  *  @magn_orient:       magnetometer sensor chip orientation if available.
  *  @suspended_sensors:	sensors mask of sensors turned off for suspend
+ *  @data:		dma safe buffer used for bulk reads.
  */
 struct inv_mpu6050_state {
 	struct mutex lock;
@@ -190,6 +194,7 @@ struct inv_mpu6050_state {
 	s32 magn_raw_to_gauss[3];
 	struct iio_mount_matrix magn_orient;
 	unsigned int suspended_sensors;
+	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE] ____cacheline_aligned;
 };
 
 /*register and associated bit definition*/
@@ -334,9 +339,6 @@ struct inv_mpu6050_state {
 #define INV_ICM20608_TEMP_OFFSET	     8170
 #define INV_ICM20608_TEMP_SCALE		     3059976
 
-/* 6 + 6 + 2 + 7 (for MPU9x50) = 21 round up to 24 and plus 8 */
-#define INV_MPU6050_OUTPUT_DATA_SIZE         32
-
 #define INV_MPU6050_REG_INT_PIN_CFG	0x37
 #define INV_MPU6050_ACTIVE_HIGH		0x00
 #define INV_MPU6050_ACTIVE_LOW		0x80
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 9511e4715e2c..554c16592d47 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -13,7 +13,6 @@
 #include <linux/interrupt.h>
 #include <linux/poll.h>
 #include <linux/math64.h>
-#include <asm/unaligned.h>
 #include "inv_mpu_iio.h"
 
 /**
@@ -121,7 +120,6 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
 	size_t bytes_per_datum;
 	int result;
-	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];
 	u16 fifo_count;
 	s64 timestamp;
 	int int_status;
@@ -160,11 +158,12 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	 * read fifo_count register to know how many bytes are inside the FIFO
 	 * right now
 	 */
-	result = regmap_bulk_read(st->map, st->reg->fifo_count_h, data,
+	result = regmap_bulk_read(st->map, st->reg->fifo_count_h,
+				  st->data,
 				  INV_MPU6050_FIFO_COUNT_BYTE);
 	if (result)
 		goto end_session;
-	fifo_count = get_unaligned_be16(&data[0]);
+	fifo_count = be16_to_cpup((__be16 *)&st->data[0]);
 
 	/*
 	 * Handle fifo overflow by resetting fifo.
@@ -182,7 +181,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	inv_mpu6050_update_period(st, pf->timestamp, nb);
 	for (i = 0; i < nb; ++i) {
 		result = regmap_bulk_read(st->map, st->reg->fifo_r_w,
-					  data, bytes_per_datum);
+					  st->data, bytes_per_datum);
 		if (result)
 			goto flush_fifo;
 		/* skip first samples if needed */
@@ -191,7 +190,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 			continue;
 		}
 		timestamp = inv_mpu6050_get_timestamp(st);
-		iio_push_to_buffers_with_timestamp(indio_dev, data, timestamp);
+		iio_push_to_buffers_with_timestamp(indio_dev, st->data,
+						   timestamp);
 	}
 
 end_session:
-- 
2.26.2

