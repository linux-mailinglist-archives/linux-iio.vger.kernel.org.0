Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9614A397F
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 21:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356209AbiA3UvE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 15:51:04 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40612 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356306AbiA3UvD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 15:51:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCBF2B829C0
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 20:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208DBC340EB;
        Sun, 30 Jan 2022 20:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643575861;
        bh=YUgzD2ubKXJ+K0Iq+YfEtgbXQwWZFLfdDJVC42NMeTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tpABE/TkVZAPkDuBD+gqsTEQCbAGs+tXdzT0za6n020F1lmd8IvcSofECYibO6vlK
         2EgCwXZ+GD4VEi+82m14V9YA/y0GUxKZPWF6P5SgyA1yCuZmkfTOkFLJMgrSLaQOzs
         5r1pLIOwngyTFZ8QhfkW4kEA+yMO1v8X2ZZszD51+olNkIxsL+nYVZpiSHp51Etlr1
         B3Z9RlqENY6A5bi3bEo10AIL6ChBIQt+fuvZhlsRPE2WjBSDCzvTXFTL2EKFE3O22j
         uDfsZVykqXR68mmK4TY29QusJTgJGMOlEaqbUEcWlnRRcTnIlumqRvTv8YNTF47jM7
         ymwnlgKTd3k4A==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 05/16] iio:common:ssp_sensors: Move exports into IIO_SSP_SENSORS namespace
Date:   Sun, 30 Jan 2022 20:56:50 +0000
Message-Id: <20220130205701.334592-6-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220130205701.334592-1-jic23@kernel.org>
References: <20220130205701.334592-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

In order to avoid unnecessary pollution of the global symbol namespace
move the common/library functions into a specific namespace and import
that into the various specific device drivers that use them.

For more information see https://lwn.net/Articles/760045/

Both the exports used between the two common modules and the individual
drivers are moved to a single namespace as greater granularity does
not feel useful.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/ssp_accel_sensor.c     |  1 +
 drivers/iio/common/ssp_sensors/ssp_dev.c | 10 +++++-----
 drivers/iio/common/ssp_sensors/ssp_iio.c |  7 ++++---
 drivers/iio/gyro/ssp_gyro_sensor.c       |  1 +
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/ssp_accel_sensor.c b/drivers/iio/accel/ssp_accel_sensor.c
index 04dcb2b657ee..a1164b439f41 100644
--- a/drivers/iio/accel/ssp_accel_sensor.c
+++ b/drivers/iio/accel/ssp_accel_sensor.c
@@ -142,3 +142,4 @@ module_platform_driver(ssp_accel_driver);
 MODULE_AUTHOR("Karol Wrona <k.wrona@samsung.com>");
 MODULE_DESCRIPTION("Samsung sensorhub accelerometers driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_SSP_SENSORS);
diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index 1aee87100038..f95f964a7fd7 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -204,7 +204,7 @@ u32 ssp_get_sensor_delay(struct ssp_data *data, enum ssp_sensor_type type)
 {
 	return data->delay_buf[type];
 }
-EXPORT_SYMBOL(ssp_get_sensor_delay);
+EXPORT_SYMBOL_NS(ssp_get_sensor_delay, IIO_SSP_SENSORS);
 
 /**
  * ssp_enable_sensor() - enables data acquisition for sensor
@@ -266,7 +266,7 @@ int ssp_enable_sensor(struct ssp_data *data, enum ssp_sensor_type type,
 derror:
 	return ret;
 }
-EXPORT_SYMBOL(ssp_enable_sensor);
+EXPORT_SYMBOL_NS(ssp_enable_sensor, IIO_SSP_SENSORS);
 
 /**
  * ssp_change_delay() - changes data acquisition for sensor
@@ -297,7 +297,7 @@ int ssp_change_delay(struct ssp_data *data, enum ssp_sensor_type type,
 
 	return 0;
 }
-EXPORT_SYMBOL(ssp_change_delay);
+EXPORT_SYMBOL_NS(ssp_change_delay, IIO_SSP_SENSORS);
 
 /**
  * ssp_disable_sensor() - disables sensor
@@ -334,7 +334,7 @@ int ssp_disable_sensor(struct ssp_data *data, enum ssp_sensor_type type)
 
 	return 0;
 }
-EXPORT_SYMBOL(ssp_disable_sensor);
+EXPORT_SYMBOL_NS(ssp_disable_sensor, IIO_SSP_SENSORS);
 
 static irqreturn_t ssp_irq_thread_fn(int irq, void *dev_id)
 {
@@ -490,7 +490,7 @@ void ssp_register_consumer(struct iio_dev *indio_dev, enum ssp_sensor_type type)
 
 	data->sensor_devs[type] = indio_dev;
 }
-EXPORT_SYMBOL(ssp_register_consumer);
+EXPORT_SYMBOL_NS(ssp_register_consumer, IIO_SSP_SENSORS);
 
 static int ssp_probe(struct spi_device *spi)
 {
diff --git a/drivers/iio/common/ssp_sensors/ssp_iio.c b/drivers/iio/common/ssp_sensors/ssp_iio.c
index 5336db81ba0a..88b8b56bfa51 100644
--- a/drivers/iio/common/ssp_sensors/ssp_iio.c
+++ b/drivers/iio/common/ssp_sensors/ssp_iio.c
@@ -32,7 +32,7 @@ int ssp_common_buffer_postenable(struct iio_dev *indio_dev)
 	return ssp_enable_sensor(data, spd->type,
 				 ssp_get_sensor_delay(data, spd->type));
 }
-EXPORT_SYMBOL(ssp_common_buffer_postenable);
+EXPORT_SYMBOL_NS(ssp_common_buffer_postenable, IIO_SSP_SENSORS);
 
 /**
  * ssp_common_buffer_postdisable() - generic postdisable callback for ssp buffer
@@ -55,7 +55,7 @@ int ssp_common_buffer_postdisable(struct iio_dev *indio_dev)
 
 	return ret;
 }
-EXPORT_SYMBOL(ssp_common_buffer_postdisable);
+EXPORT_SYMBOL_NS(ssp_common_buffer_postdisable, IIO_SSP_SENSORS);
 
 /**
  * ssp_common_process_data() - Common process data callback for ssp sensors
@@ -91,8 +91,9 @@ int ssp_common_process_data(struct iio_dev *indio_dev, void *buf,
 	return iio_push_to_buffers_with_timestamp(indio_dev, spd->buffer,
 						  calculated_time);
 }
-EXPORT_SYMBOL(ssp_common_process_data);
+EXPORT_SYMBOL_NS(ssp_common_process_data, IIO_SSP_SENSORS);
 
 MODULE_AUTHOR("Karol Wrona <k.wrona@samsung.com>");
 MODULE_DESCRIPTION("Samsung sensorhub commons");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_SSP_SENSORS);
diff --git a/drivers/iio/gyro/ssp_gyro_sensor.c b/drivers/iio/gyro/ssp_gyro_sensor.c
index 46ed12771d2f..5fd1bf9902ea 100644
--- a/drivers/iio/gyro/ssp_gyro_sensor.c
+++ b/drivers/iio/gyro/ssp_gyro_sensor.c
@@ -142,3 +142,4 @@ module_platform_driver(ssp_gyro_driver);
 MODULE_AUTHOR("Karol Wrona <k.wrona@samsung.com>");
 MODULE_DESCRIPTION("Samsung sensorhub gyroscopes driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_SSP_SENSORS);
-- 
2.35.1

