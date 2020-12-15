Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB1C2DA7CE
	for <lists+linux-iio@lfdr.de>; Tue, 15 Dec 2020 06:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgLOFot (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Dec 2020 00:44:49 -0500
Received: from mga18.intel.com ([134.134.136.126]:57001 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbgLOFon (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 15 Dec 2020 00:44:43 -0500
IronPort-SDR: XwHRKz+mf8etRpKOrxFijn10Gz8zNqRBRwyjapvYP6FC4P2wLGhKto+bIwfyBOlKOpJ2p2UM1H
 8NWi8ucgiSvA==
X-IronPort-AV: E=McAfee;i="6000,8403,9835"; a="162576868"
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="162576868"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 21:43:41 -0800
IronPort-SDR: IdVDPJFzUfzpI/BE3l8QQLaOioZ6LxJiS/KDbPJvjUOWo7PPVnBTYKdgOk4oXSjomO50Aq2JLq
 dQZWtFynQ4WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="351719734"
Received: from host.sh.intel.com ([10.239.154.115])
  by orsmga002.jf.intel.com with ESMTP; 14 Dec 2020 21:43:39 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH v4 1/3] HID: hid-sensor-custom: Add custom sensor iio support
Date:   Tue, 15 Dec 2020 13:44:42 +0800
Message-Id: <20201215054444.9324-2-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201215054444.9324-1-xiang.ye@intel.com>
References: <20201215054444.9324-1-xiang.ye@intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Currently custom sensors properties are not decoded and it is up to
user space to interpret.

Some manufacturers already standardized the meaning of some custom sensors.
They can be presented as a proper IIO sensor. We can identify these sensors
based on manufacturer and serial number property in the report.

This change is identifying hinge sensor when the manufacturer is "INTEL".
This creates a platform device so that a sensor driver can be loaded to
process these sensors.

Signed-off-by: Ye Xiang <xiang.ye@intel.com>
---
 drivers/hid/hid-sensor-custom.c | 143 ++++++++++++++++++++++++++++++++
 include/linux/hid-sensor-ids.h  |  14 ++++
 2 files changed, 157 insertions(+)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index 4d25577a8573..2628bc53ed80 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2015, Intel Corporation.
  */
 
+#include <linux/ctype.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -21,6 +22,7 @@
 #define HID_CUSTOM_TOTAL_ATTRS		(HID_CUSTOM_MAX_CORE_ATTRS + 1)
 #define HID_CUSTOM_FIFO_SIZE		4096
 #define HID_CUSTOM_MAX_FEATURE_BYTES	64
+#define HID_SENSOR_USAGE_LENGTH (4 + 1)
 
 struct hid_sensor_custom_field {
 	int report_id;
@@ -50,6 +52,7 @@ struct hid_sensor_custom {
 	struct kfifo data_fifo;
 	unsigned long misc_opened;
 	wait_queue_head_t wait;
+	struct platform_device *custom_pdev;
 };
 
 /* Header for each sample to user space via dev interface */
@@ -746,11 +749,130 @@ static void hid_sensor_custom_dev_if_remove(struct hid_sensor_custom
 
 }
 
+/* luid defined in FW (e.g. ISH).  Maybe used to identify sensor. */
+static const char *const known_sensor_luid[] = { "020B000000000000" };
+
+static int get_luid_table_index(unsigned char *usage_str)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(known_sensor_luid); i++) {
+		if (!strncmp(usage_str, known_sensor_luid[i],
+			     strlen(known_sensor_luid[i])))
+			return i;
+	}
+
+	return -ENODEV;
+}
+
+static int get_known_custom_sensor_index(struct hid_sensor_hub_device *hsdev)
+{
+	struct hid_sensor_hub_attribute_info sensor_manufacturer = { 0 };
+	struct hid_sensor_hub_attribute_info sensor_luid_info = { 0 };
+	int report_size;
+	int ret;
+	static u16 w_buf[HID_CUSTOM_MAX_FEATURE_BYTES];
+	static char buf[HID_CUSTOM_MAX_FEATURE_BYTES];
+	int i;
+
+	memset(w_buf, 0, sizeof(w_buf));
+	memset(buf, 0, sizeof(buf));
+
+	/* get manufacturer info */
+	ret = sensor_hub_input_get_attribute_info(hsdev,
+			HID_FEATURE_REPORT, hsdev->usage,
+			HID_USAGE_SENSOR_PROP_MANUFACTURER, &sensor_manufacturer);
+	if (ret < 0)
+		return ret;
+
+	report_size =
+		sensor_hub_get_feature(hsdev, sensor_manufacturer.report_id,
+				       sensor_manufacturer.index, sizeof(w_buf),
+				       w_buf);
+	if (report_size <= 0) {
+		hid_err(hsdev->hdev,
+			"Failed to get sensor manufacturer info %d\n",
+			report_size);
+		return -ENODEV;
+	}
+
+	/* convert from wide char to char */
+	for (i = 0; i < ARRAY_SIZE(buf) - 1 && w_buf[i]; i++)
+		buf[i] = (char)w_buf[i];
+
+	/* ensure it's ISH sensor */
+	if (strncmp(buf, "INTEL", strlen("INTEL")))
+		return -ENODEV;
+
+	memset(w_buf, 0, sizeof(w_buf));
+	memset(buf, 0, sizeof(buf));
+
+	/* get real usage id */
+	ret = sensor_hub_input_get_attribute_info(hsdev,
+			HID_FEATURE_REPORT, hsdev->usage,
+			HID_USAGE_SENSOR_PROP_SERIAL_NUM, &sensor_luid_info);
+	if (ret < 0)
+		return ret;
+
+	report_size = sensor_hub_get_feature(hsdev, sensor_luid_info.report_id,
+					     sensor_luid_info.index, sizeof(w_buf),
+					     w_buf);
+	if (report_size <= 0) {
+		hid_err(hsdev->hdev, "Failed to get real usage info %d\n",
+			report_size);
+		return -ENODEV;
+	}
+
+	/* convert from wide char to char */
+	for (i = 0; i < ARRAY_SIZE(buf) - 1 && w_buf[i]; i++)
+		buf[i] = (char)w_buf[i];
+
+	if (strlen(buf) != strlen(known_sensor_luid[0]) + 5) {
+		hid_err(hsdev->hdev,
+			"%s luid length not match %zu != (%zu + 5)\n", __func__,
+			strlen(buf), strlen(known_sensor_luid[0]));
+		return -ENODEV;
+	}
+
+	/* get table index with luid (not matching 'LUID: ' in luid) */
+	return get_luid_table_index(&buf[5]);
+}
+
+static struct platform_device *
+hid_sensor_register_platform_device(struct platform_device *pdev,
+				    struct hid_sensor_hub_device *hsdev,
+				    int index)
+{
+	char real_usage[HID_SENSOR_USAGE_LENGTH] = { 0 };
+	struct platform_device *custom_pdev;
+	const char *dev_name;
+	char *c;
+
+	/* copy real usage id */
+	memcpy(real_usage, known_sensor_luid[index], 4);
+
+	/* usage id are all lowcase */
+	for (c = real_usage; *c != '\0'; c++)
+		*c = tolower(*c);
+
+	/* HID-SENSOR-INT-REAL_USAGE_ID */
+	dev_name = kasprintf(GFP_KERNEL, "HID-SENSOR-INT-%s", real_usage);
+	if (!dev_name)
+		return ERR_PTR(-ENOMEM);
+
+	custom_pdev = platform_device_register_data(pdev->dev.parent, dev_name,
+						    PLATFORM_DEVID_NONE, hsdev,
+						    sizeof(*hsdev));
+	kfree(dev_name);
+	return custom_pdev;
+}
+
 static int hid_sensor_custom_probe(struct platform_device *pdev)
 {
 	struct hid_sensor_custom *sensor_inst;
 	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
 	int ret;
+	int index;
 
 	sensor_inst = devm_kzalloc(&pdev->dev, sizeof(*sensor_inst),
 				   GFP_KERNEL);
@@ -764,6 +886,22 @@ static int hid_sensor_custom_probe(struct platform_device *pdev)
 	sensor_inst->pdev = pdev;
 	mutex_init(&sensor_inst->mutex);
 	platform_set_drvdata(pdev, sensor_inst);
+
+	index = get_known_custom_sensor_index(hsdev);
+	if (index >= 0 && index < ARRAY_SIZE(known_sensor_luid)) {
+		sensor_inst->custom_pdev =
+			hid_sensor_register_platform_device(pdev, hsdev, index);
+
+		ret = PTR_ERR_OR_ZERO(sensor_inst->custom_pdev);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"register_platform_device failed\n");
+			return ret;
+		}
+
+		return 0;
+	}
+
 	ret = sensor_hub_register_callback(hsdev, hsdev->usage,
 					   &sensor_inst->callbacks);
 	if (ret < 0) {
@@ -802,6 +940,11 @@ static int hid_sensor_custom_remove(struct platform_device *pdev)
 	struct hid_sensor_custom *sensor_inst = platform_get_drvdata(pdev);
 	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
 
+	if (sensor_inst->custom_pdev) {
+		platform_device_unregister(sensor_inst->custom_pdev);
+		return 0;
+	}
+
 	hid_sensor_custom_dev_if_remove(sensor_inst);
 	hid_sensor_custom_remove_attributes(sensor_inst);
 	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index 530c09f3e64a..ac631159403a 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -128,6 +128,10 @@
 #define HID_USAGE_SENSOR_UNITS_DEGREES_PER_SECOND		0x15
 
 /* Common selectors */
+#define HID_USAGE_SENSOR_PROP_DESC				0x200300
+#define HID_USAGE_SENSOR_PROP_FRIENDLY_NAME			0x200301
+#define HID_USAGE_SENSOR_PROP_SERIAL_NUM			0x200307
+#define HID_USAGE_SENSOR_PROP_MANUFACTURER			0x200305
 #define HID_USAGE_SENSOR_PROP_REPORT_INTERVAL			0x20030E
 #define HID_USAGE_SENSOR_PROP_SENSITIVITY_ABS			0x20030F
 #define HID_USAGE_SENSOR_PROP_SENSITIVITY_RANGE_PCT		0x200310
@@ -159,4 +163,14 @@
 #define HID_USAGE_SENSOR_PROP_REPORTING_STATE_NO_EVENTS_ENUM	0x200840
 #define HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM	0x200841
 
+/* Custom Sensor (2000e1) */
+#define HID_USAGE_SENSOR_HINGE				        0x20020B
+#define HID_USAGE_SENSOR_DATA_FIELD_LOCATION			0x200400
+#define HID_USAGE_SENSOR_DATA_FIELE_TIME_SINCE_SYS_BOOT		0x20052B
+#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_USAGE		0x200541
+#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_BASE           0x200543
+/* Custom Sensor data 28=>x>=0 */
+#define HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE(x)                            \
+	(HID_USAGE_SENSOR_DATA_FIELD_CUSTOM_VALUE_BASE + (x))
+
 #endif
-- 
2.17.1

