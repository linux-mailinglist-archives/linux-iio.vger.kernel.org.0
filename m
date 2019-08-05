Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7419D82523
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 20:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbfHES5X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 14:57:23 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:14614 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730222AbfHES5X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Aug 2019 14:57:23 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x75IpuX9010007;
        Mon, 5 Aug 2019 20:57:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=STMicroelectronics;
 bh=C5Ilg9oa2EhmRzeCTEN+xN7Bnx5Q3scVd3cizwlWTSE=;
 b=iJEmRlEDLQmI0q6QBwBU8cUJR9Fw1VoBqhp3HsWhBdk6eySGqLtKcmKvo19sH1dDf3+3
 PaVNxEJL/7Fea55JzGX+pmtVK8R8g7eQI8uwVB/sDSPu51GRjA+Z3gFTIe770ORsFpyd
 NvxrpZc5QYdzwYN+8BCLtpTF6OZeKyFPuO+c/79SA2zz3UwvZM6dDqeJWhL0Xzx71U2u
 C2I5zEAvBR2XI5E6f5yxbtzeu/ePSHyDVtA/HuFEgDvbVhns+mr0SaT0LKx+Mxom6Njc
 QD6+RjVqt8z0NUf6HPLENeMN+ZC9xUneNiVDD2Fi1Bq8On4gbg4ZHXnHGSMouY5w7qSg 0g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2u5sd1fvfa-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 05 Aug 2019 20:57:15 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 60E8A31;
        Mon,  5 Aug 2019 18:57:14 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag1node1.st.com [10.75.127.1])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 52DDC3BE572;
        Mon,  5 Aug 2019 20:57:14 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG1NODE1.st.com (10.75.127.1)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 5 Aug 2019 20:57:13
 +0200
From:   Denis Ciocca <denis.ciocca@st.com>
To:     <linux-iio@vger.kernel.org>, <jic23@kernel.org>
CC:     <alexandru.Ardelean@analog.com>, Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH] iio:st_sensors: remove buffer allocation at each buffer enable
Date:   Mon, 5 Aug 2019 11:57:11 -0700
Message-ID: <20190805185711.2890-1-denis.ciocca@st.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG1NODE1.st.com
 (10.75.127.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-05_09:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch is removing the buffer allocation at each buffer enable.
We just allocate enough memory in the main structure during probe
to cover maximum size needed (that anyway is pretty small) [16bytes].

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/accel/st_accel_buffer.c       | 12 +-----------
 drivers/iio/gyro/st_gyro_buffer.c         | 12 +-----------
 drivers/iio/magnetometer/st_magn_buffer.c | 12 +-----------
 drivers/iio/pressure/st_pressure_buffer.c | 12 +-----------
 include/linux/iio/common/st_sensors.h     | 14 +++++++++-----
 5 files changed, 13 insertions(+), 49 deletions(-)

diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
index 59dcef02ec19..9f2b40474b8e 100644
--- a/drivers/iio/accel/st_accel_buffer.c
+++ b/drivers/iio/accel/st_accel_buffer.c
@@ -31,17 +31,11 @@ int st_accel_trig_set_state(struct iio_trigger *trig, bool state)
 
 static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
 {
-	struct st_sensor_data *adata = iio_priv(indio_dev);
 	int err;
 
-	adata->buffer_data = kmalloc(indio_dev->scan_bytes,
-				     GFP_DMA | GFP_KERNEL);
-	if (!adata->buffer_data)
-		return -ENOMEM;
-
 	err = iio_triggered_buffer_postenable(indio_dev);
 	if (err < 0)
-		goto st_accel_free_buffer;
+		return err;
 
 	err = st_sensors_set_axis_enable(indio_dev,
 					 (u8)indio_dev->active_scan_mask[0]);
@@ -58,14 +52,11 @@ static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
 	st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
 st_accel_buffer_predisable:
 	iio_triggered_buffer_predisable(indio_dev);
-st_accel_free_buffer:
-	kfree(adata->buffer_data);
 	return err;
 }
 
 static int st_accel_buffer_predisable(struct iio_dev *indio_dev)
 {
-	struct st_sensor_data *adata = iio_priv(indio_dev);
 	int err, err2;
 
 	err = st_sensors_set_enable(indio_dev, false);
@@ -79,7 +70,6 @@ static int st_accel_buffer_predisable(struct iio_dev *indio_dev)
 	if (!err)
 		err = err2;
 
-	kfree(adata->buffer_data);
 	return err;
 }
 
diff --git a/drivers/iio/gyro/st_gyro_buffer.c b/drivers/iio/gyro/st_gyro_buffer.c
index c6ddfecc1fc3..7465ad62391c 100644
--- a/drivers/iio/gyro/st_gyro_buffer.c
+++ b/drivers/iio/gyro/st_gyro_buffer.c
@@ -31,17 +31,11 @@ int st_gyro_trig_set_state(struct iio_trigger *trig, bool state)
 
 static int st_gyro_buffer_postenable(struct iio_dev *indio_dev)
 {
-	struct st_sensor_data *gdata = iio_priv(indio_dev);
 	int err;
 
-	gdata->buffer_data = kmalloc(indio_dev->scan_bytes,
-				     GFP_DMA | GFP_KERNEL);
-	if (!gdata->buffer_data)
-		return -ENOMEM;
-
 	err = iio_triggered_buffer_postenable(indio_dev);
 	if (err < 0)
-		goto st_gyro_free_buffer;
+		return err;
 
 	err = st_sensors_set_axis_enable(indio_dev,
 					 (u8)indio_dev->active_scan_mask[0]);
@@ -58,15 +52,12 @@ static int st_gyro_buffer_postenable(struct iio_dev *indio_dev)
 	st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
 st_gyro_buffer_predisable:
 	iio_triggered_buffer_predisable(indio_dev);
-st_gyro_free_buffer:
-	kfree(gdata->buffer_data);
 	return err;
 }
 
 static int st_gyro_buffer_predisable(struct iio_dev *indio_dev)
 {
 	int err, err2;
-	struct st_sensor_data *gdata = iio_priv(indio_dev);
 
 	err = st_sensors_set_enable(indio_dev, false);
 	if (err < 0)
@@ -79,7 +70,6 @@ static int st_gyro_buffer_predisable(struct iio_dev *indio_dev)
 	if (!err)
 		err = err2;
 
-	kfree(gdata->buffer_data);
 	return err;
 }
 
diff --git a/drivers/iio/magnetometer/st_magn_buffer.c b/drivers/iio/magnetometer/st_magn_buffer.c
index 658d627dad8e..bb425c167a96 100644
--- a/drivers/iio/magnetometer/st_magn_buffer.c
+++ b/drivers/iio/magnetometer/st_magn_buffer.c
@@ -31,17 +31,11 @@ int st_magn_trig_set_state(struct iio_trigger *trig, bool state)
 
 static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
 {
-	struct st_sensor_data *mdata = iio_priv(indio_dev);
 	int err;
 
-	mdata->buffer_data = kmalloc(indio_dev->scan_bytes,
-				     GFP_DMA | GFP_KERNEL);
-	if (!mdata->buffer_data)
-		return -ENOMEM;
-
 	err = iio_triggered_buffer_postenable(indio_dev);
 	if (err < 0)
-		goto st_magn_free_buffer;
+		return err;
 
 	err = st_sensors_set_enable(indio_dev, true);
 	if (err < 0)
@@ -51,14 +45,11 @@ static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
 
 st_magn_buffer_predisable:
 	iio_triggered_buffer_predisable(indio_dev);
-st_magn_free_buffer:
-	kfree(mdata->buffer_data);
 	return err;
 }
 
 static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
 {
-	struct st_sensor_data *mdata = iio_priv(indio_dev);
 	int err, err2;
 
 	err = st_sensors_set_enable(indio_dev, false);
@@ -67,7 +58,6 @@ static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
 	if (!err)
 		err = err2;
 
-	kfree(mdata->buffer_data);
 	return err;
 }
 
diff --git a/drivers/iio/pressure/st_pressure_buffer.c b/drivers/iio/pressure/st_pressure_buffer.c
index 77cb2d862f19..418dbf9e6e1e 100644
--- a/drivers/iio/pressure/st_pressure_buffer.c
+++ b/drivers/iio/pressure/st_pressure_buffer.c
@@ -31,17 +31,11 @@ int st_press_trig_set_state(struct iio_trigger *trig, bool state)
 
 static int st_press_buffer_postenable(struct iio_dev *indio_dev)
 {
-	struct st_sensor_data *press_data = iio_priv(indio_dev);
 	int err;
 
-	press_data->buffer_data = kmalloc(indio_dev->scan_bytes,
-					  GFP_DMA | GFP_KERNEL);
-	if (!press_data->buffer_data)
-		return -ENOMEM;
-
 	err = iio_triggered_buffer_postenable(indio_dev);
 	if (err < 0)
-		goto st_press_free_buffer;
+		return err;
 
 	err = st_sensors_set_enable(indio_dev, true);
 	if (err < 0)
@@ -51,14 +45,11 @@ static int st_press_buffer_postenable(struct iio_dev *indio_dev)
 
 st_press_buffer_predisable:
 	iio_triggered_buffer_predisable(indio_dev);
-st_press_free_buffer:
-	kfree(press_data->buffer_data);
 	return err;
 }
 
 static int st_press_buffer_predisable(struct iio_dev *indio_dev)
 {
-	struct st_sensor_data *press_data = iio_priv(indio_dev);
 	int err, err2;
 
 	err = st_sensors_set_enable(indio_dev, false);
@@ -67,7 +58,6 @@ static int st_press_buffer_predisable(struct iio_dev *indio_dev)
 	if (!err)
 		err = err2;
 
-	kfree(press_data->buffer_data);
 	return err;
 }
 
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 4d0889bf1c6c..686be532f4cb 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -20,8 +20,12 @@
 
 #include <linux/platform_data/st_sensors_pdata.h>
 
-#define ST_SENSORS_TX_MAX_LENGTH		2
-#define ST_SENSORS_RX_MAX_LENGTH		6
+/*
+ * Buffer size max case: 2bytes per channel, 3 channels in total +
+ *			 8bytes timestamp channel (s64)
+ */
+#define ST_SENSORS_MAX_BUFFER_SIZE		(ALIGN(2 * 3, sizeof(s64)) + \
+						 sizeof(s64))
 
 #define ST_SENSORS_ODR_LIST_MAX			10
 #define ST_SENSORS_FULLSCALE_AVL_MAX		10
@@ -215,7 +219,6 @@ struct st_sensor_settings {
  * @vdd_io: Pointer to sensor's Vdd-IO power supply
  * @regmap: Pointer to specific sensor regmap configuration.
  * @enabled: Status of the sensor (false->off, true->on).
- * @buffer_data: Data used by buffer part.
  * @odr: Output data rate of the sensor [Hz].
  * num_data_channels: Number of data channels used in buffer.
  * @drdy_int_pin: Redirect DRDY on pin 1 (1) or pin 2 (2).
@@ -224,6 +227,7 @@ struct st_sensor_settings {
  * @edge_irq: the IRQ triggers on edges and need special handling.
  * @hw_irq_trigger: if we're using the hardware interrupt on the sensor.
  * @hw_timestamp: Latest timestamp from the interrupt handler, when in use.
+ * @buffer_data: Data used by buffer part.
  */
 struct st_sensor_data {
 	struct device *dev;
@@ -237,8 +241,6 @@ struct st_sensor_data {
 
 	bool enabled;
 
-	char *buffer_data;
-
 	unsigned int odr;
 	unsigned int num_data_channels;
 
@@ -249,6 +251,8 @@ struct st_sensor_data {
 	bool edge_irq;
 	bool hw_irq_trigger;
 	s64 hw_timestamp;
+
+	char buffer_data[ST_SENSORS_MAX_BUFFER_SIZE] ____cacheline_aligned;
 };
 
 #ifdef CONFIG_IIO_BUFFER
-- 
2.22.0

