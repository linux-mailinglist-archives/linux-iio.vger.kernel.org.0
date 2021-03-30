Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CC634E98B
	for <lists+linux-iio@lfdr.de>; Tue, 30 Mar 2021 15:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbhC3NsW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Mar 2021 09:48:22 -0400
Received: from foss.arm.com ([217.140.110.172]:34596 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231622AbhC3Nrs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 30 Mar 2021 09:47:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5A0F31B;
        Tue, 30 Mar 2021 06:47:47 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE5623F719;
        Tue, 30 Mar 2021 06:47:46 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com,
        Jyoti Bhayana <jbhayana@google.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v8 25/38] iio/scmi: Port driver to the new scmi_sensor_proto_ops interface
Date:   Tue, 30 Mar 2021 14:47:11 +0100
Message-Id: <20210330134711.1962-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210330123325.00000456@Huawei.com>
References: <20210330123325.00000456@Huawei.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Port the scmi iio driver to the new SCMI sensor interface based on
protocol handles and common devm_get_ops().

Link: https://lore.kernel.org/r/20210316124903.35011-26-cristian.marussi@arm.com
Cc: Jyoti Bhayana <jbhayana@google.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
----
v7 --> v8
- make sensor_ops NON global
---
 drivers/iio/common/scmi_sensors/scmi_iio.c | 100 ++++++++++-----------
 1 file changed, 50 insertions(+), 50 deletions(-)

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index 872d87ca6256..8f4154d92c68 100644
--- a/drivers/iio/common/scmi_sensors/scmi_iio.c
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -22,7 +22,8 @@
 #define SCMI_IIO_NUM_OF_AXIS 3
 
 struct scmi_iio_priv {
-	struct scmi_handle *handle;
+	const struct scmi_sensor_proto_ops *sensor_ops;
+	struct scmi_protocol_handle *ph;
 	const struct scmi_sensor_info *sensor_info;
 	struct iio_dev *indio_dev;
 	/* adding one additional channel for timestamp */
@@ -82,7 +83,6 @@ static int scmi_iio_sensor_update_cb(struct notifier_block *nb,
 static int scmi_iio_buffer_preenable(struct iio_dev *iio_dev)
 {
 	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
-	u32 sensor_id = sensor->sensor_info->id;
 	u32 sensor_config = 0;
 	int err;
 
@@ -92,27 +92,12 @@ static int scmi_iio_buffer_preenable(struct iio_dev *iio_dev)
 
 	sensor_config |= FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
 				    SCMI_SENS_CFG_SENSOR_ENABLE);
-
-	err = sensor->handle->notify_ops->register_event_notifier(sensor->handle,
-			SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
-			&sensor_id, &sensor->sensor_update_nb);
-	if (err) {
-		dev_err(&iio_dev->dev,
-			"Error in registering sensor update notifier for sensor %s err %d",
-			sensor->sensor_info->name, err);
-		return err;
-	}
-
-	err = sensor->handle->sensor_ops->config_set(sensor->handle,
-			sensor->sensor_info->id, sensor_config);
-	if (err) {
-		sensor->handle->notify_ops->unregister_event_notifier(sensor->handle,
-				SCMI_PROTOCOL_SENSOR,
-				SCMI_EVENT_SENSOR_UPDATE, &sensor_id,
-				&sensor->sensor_update_nb);
+	err = sensor->sensor_ops->config_set(sensor->ph,
+					     sensor->sensor_info->id,
+					     sensor_config);
+	if (err)
 		dev_err(&iio_dev->dev, "Error in enabling sensor %s err %d",
 			sensor->sensor_info->name, err);
-	}
 
 	return err;
 }
@@ -120,25 +105,14 @@ static int scmi_iio_buffer_preenable(struct iio_dev *iio_dev)
 static int scmi_iio_buffer_postdisable(struct iio_dev *iio_dev)
 {
 	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
-	u32 sensor_id = sensor->sensor_info->id;
 	u32 sensor_config = 0;
 	int err;
 
 	sensor_config |= FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
 				    SCMI_SENS_CFG_SENSOR_DISABLE);
-
-	err = sensor->handle->notify_ops->unregister_event_notifier(sensor->handle,
-			SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
-			&sensor_id, &sensor->sensor_update_nb);
-	if (err) {
-		dev_err(&iio_dev->dev,
-			"Error in unregistering sensor update notifier for sensor %s err %d",
-			sensor->sensor_info->name, err);
-		return err;
-	}
-
-	err = sensor->handle->sensor_ops->config_set(sensor->handle, sensor_id,
-						     sensor_config);
+	err = sensor->sensor_ops->config_set(sensor->ph,
+					     sensor->sensor_info->id,
+					     sensor_config);
 	if (err) {
 		dev_err(&iio_dev->dev,
 			"Error in disabling sensor %s with err %d",
@@ -161,8 +135,9 @@ static int scmi_iio_set_odr_val(struct iio_dev *iio_dev, int val, int val2)
 	u32 sensor_config;
 	char buf[32];
 
-	int err = sensor->handle->sensor_ops->config_get(sensor->handle,
-			sensor->sensor_info->id, &sensor_config);
+	int err = sensor->sensor_ops->config_get(sensor->ph,
+						 sensor->sensor_info->id,
+						 &sensor_config);
 	if (err) {
 		dev_err(&iio_dev->dev,
 			"Error in getting sensor config for sensor %s err %d",
@@ -208,8 +183,9 @@ static int scmi_iio_set_odr_val(struct iio_dev *iio_dev, int val, int val2)
 	sensor_config |=
 		FIELD_PREP(SCMI_SENS_CFG_ROUND_MASK, SCMI_SENS_CFG_ROUND_AUTO);
 
-	err = sensor->handle->sensor_ops->config_set(sensor->handle,
-			sensor->sensor_info->id, sensor_config);
+	err = sensor->sensor_ops->config_set(sensor->ph,
+					     sensor->sensor_info->id,
+					     sensor_config);
 	if (err)
 		dev_err(&iio_dev->dev,
 			"Error in setting sensor update interval for sensor %s value %u err %d",
@@ -274,8 +250,9 @@ static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int *val2)
 	u32 sensor_config;
 	int mult;
 
-	int err = sensor->handle->sensor_ops->config_get(sensor->handle,
-			sensor->sensor_info->id, &sensor_config);
+	int err = sensor->sensor_ops->config_get(sensor->ph,
+						 sensor->sensor_info->id,
+						 &sensor_config);
 	if (err) {
 		dev_err(&iio_dev->dev,
 			"Error in getting sensor config for sensor %s err %d",
@@ -542,15 +519,19 @@ static int scmi_iio_buffers_setup(struct iio_dev *scmi_iiodev)
 	return 0;
 }
 
-static struct iio_dev *scmi_alloc_iiodev(struct device *dev,
-					 struct scmi_handle *handle,
-					 const struct scmi_sensor_info *sensor_info)
+static struct iio_dev *
+scmi_alloc_iiodev(struct scmi_device *sdev,
+		  const struct scmi_sensor_proto_ops *ops,
+		  struct scmi_protocol_handle *ph,
+		  const struct scmi_sensor_info *sensor_info)
 {
 	struct iio_chan_spec *iio_channels;
 	struct scmi_iio_priv *sensor;
 	enum iio_modifier modifier;
 	enum iio_chan_type type;
 	struct iio_dev *iiodev;
+	struct device *dev = &sdev->dev;
+	const struct scmi_handle *handle = sdev->handle;
 	int i, ret;
 
 	iiodev = devm_iio_device_alloc(dev, sizeof(*sensor));
@@ -560,7 +541,8 @@ static struct iio_dev *scmi_alloc_iiodev(struct device *dev,
 	iiodev->modes = INDIO_DIRECT_MODE;
 	iiodev->dev.parent = dev;
 	sensor = iio_priv(iiodev);
-	sensor->handle = handle;
+	sensor->sensor_ops = ops;
+	sensor->ph = ph;
 	sensor->sensor_info = sensor_info;
 	sensor->sensor_update_nb.notifier_call = scmi_iio_sensor_update_cb;
 	sensor->indio_dev = iiodev;
@@ -595,6 +577,17 @@ static struct iio_dev *scmi_alloc_iiodev(struct device *dev,
 					  sensor_info->axis[i].id);
 	}
 
+	ret = handle->notify_ops->devm_event_notifier_register(sdev,
+				SCMI_PROTOCOL_SENSOR, SCMI_EVENT_SENSOR_UPDATE,
+				&sensor->sensor_info->id,
+				&sensor->sensor_update_nb);
+	if (ret) {
+		dev_err(&iiodev->dev,
+			"Error in registering sensor update notifier for sensor %s err %d",
+			sensor->sensor_info->name, ret);
+		return ERR_PTR(ret);
+	}
+
 	scmi_iio_set_timestamp_channel(&iio_channels[i], i);
 	iiodev->channels = iio_channels;
 	return iiodev;
@@ -604,24 +597,30 @@ static int scmi_iio_dev_probe(struct scmi_device *sdev)
 {
 	const struct scmi_sensor_info *sensor_info;
 	struct scmi_handle *handle = sdev->handle;
+	const struct scmi_sensor_proto_ops *sensor_ops;
+	struct scmi_protocol_handle *ph;
 	struct device *dev = &sdev->dev;
 	struct iio_dev *scmi_iio_dev;
 	u16 nr_sensors;
 	int err = -ENODEV, i;
 
-	if (!handle || !handle->sensor_ops) {
+	if (!handle)
+		return -ENODEV;
+
+	sensor_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_SENSOR, &ph);
+	if (IS_ERR(sensor_ops)) {
 		dev_err(dev, "SCMI device has no sensor interface\n");
-		return -EINVAL;
+		return PTR_ERR(sensor_ops);
 	}
 
-	nr_sensors = handle->sensor_ops->count_get(handle);
+	nr_sensors = sensor_ops->count_get(ph);
 	if (!nr_sensors) {
 		dev_dbg(dev, "0 sensors found via SCMI bus\n");
 		return -ENODEV;
 	}
 
 	for (i = 0; i < nr_sensors; i++) {
-		sensor_info = handle->sensor_ops->info_get(handle, i);
+		sensor_info = sensor_ops->info_get(ph, i);
 		if (!sensor_info) {
 			dev_err(dev, "SCMI sensor %d has missing info\n", i);
 			return -EINVAL;
@@ -636,7 +635,8 @@ static int scmi_iio_dev_probe(struct scmi_device *sdev)
 		    sensor_info->axis[0].type != RADIANS_SEC)
 			continue;
 
-		scmi_iio_dev = scmi_alloc_iiodev(dev, handle, sensor_info);
+		scmi_iio_dev = scmi_alloc_iiodev(sdev, sensor_ops, ph,
+						 sensor_info);
 		if (IS_ERR(scmi_iio_dev)) {
 			dev_err(dev,
 				"failed to allocate IIO device for sensor %s: %ld\n",
-- 
2.17.1

