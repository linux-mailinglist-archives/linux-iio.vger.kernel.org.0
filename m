Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637CF229BEB
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jul 2020 17:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbgGVPxe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 11:53:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbgGVPxe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Jul 2020 11:53:34 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19A7E22BEF;
        Wed, 22 Jul 2020 15:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595433214;
        bh=Q1+lA1qWyLMqAmlkrxNs+4cWTmkFY09nI45VNF2csog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ULhzOULN8RQquvxDdHd6rTERpGFDni/XJzx3PBuC+X9szIjd58WgL7tLH8WvHAcsC
         HHYCNAl6+p+zE8UsJZTebQs2zfNFXy27McTNy9bVMG5mflFsik24GTrY1wZbfH6KxZ
         JB5huq1thciiIQedvQpg300X5Lfe9/rSgIzqlcro=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v3 17/27] iio:imu:inv_mpu6050 Fix dma and ts alignment and data leak issues.
Date:   Wed, 22 Jul 2020 16:50:53 +0100
Message-Id: <20200722155103.979802-18-jic23@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722155103.979802-1-jic23@kernel.org>
References: <20200722155103.979802-1-jic23@kernel.org>
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
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  8 +++++---
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 12 +++++-------
 2 files changed, 10 insertions(+), 10 deletions(-)

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
index b533fa2dad0a..d8e6b88ddffc 100644
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
@@ -160,11 +158,11 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	 * read fifo_count register to know how many bytes are inside the FIFO
 	 * right now
 	 */
-	result = regmap_bulk_read(st->map, st->reg->fifo_count_h, data,
-				  INV_MPU6050_FIFO_COUNT_BYTE);
+	result = regmap_bulk_read(st->map, st->reg->fifo_count_h,
+				  st->data, INV_MPU6050_FIFO_COUNT_BYTE);
 	if (result)
 		goto end_session;
-	fifo_count = get_unaligned_be16(&data[0]);
+	fifo_count = be16_to_cpup((__be16 *)&st->data[0]);
 
 	/*
 	 * Handle fifo overflow by resetting fifo.
@@ -182,7 +180,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	inv_mpu6050_update_period(st, pf->timestamp, nb);
 	for (i = 0; i < nb; ++i) {
 		result = regmap_bulk_read(st->map, st->reg->fifo_r_w,
-					  data, bytes_per_datum);
+					  st->data, bytes_per_datum);
 		if (result)
 			goto flush_fifo;
 		/* skip first samples if needed */
@@ -191,7 +189,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 			continue;
 		}
 		timestamp = inv_mpu6050_get_timestamp(st);
-		iio_push_to_buffers_with_timestamp(indio_dev, data, timestamp);
+		iio_push_to_buffers_with_timestamp(indio_dev, st->data, timestamp);
 	}
 
 end_session:
-- 
2.27.0

