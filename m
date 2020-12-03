Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3622CCDA1
	for <lists+linux-iio@lfdr.de>; Thu,  3 Dec 2020 04:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388043AbgLCDxg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Dec 2020 22:53:36 -0500
Received: from mga05.intel.com ([192.55.52.43]:12276 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388040AbgLCDxf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 2 Dec 2020 22:53:35 -0500
IronPort-SDR: mzsaN68xq38lnPYR6KlHN+CW38f9Sqr9qNUc3WWz2O2qLDkJQwjwQozwnWx2cfmYPytS7ihxAL
 76CirfM9hCuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="257842978"
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="257842978"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 19:52:54 -0800
IronPort-SDR: hgefrSggKZ0J6Pzw4L4ruOKFHrXgzytxCmJiD9BfZ93U2Mu0rkSkH5Pdv7+VGRzOe8j5kg6/SL
 ieebate+RKCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="550330030"
Received: from host.sh.intel.com ([10.239.154.115])
  by orsmga005.jf.intel.com with ESMTP; 02 Dec 2020 19:52:52 -0800
From:   Ye Xiang <xiang.ye@intel.com>
To:     jikos@kernel.org, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Xiang <xiang.ye@intel.com>
Subject: [PATCH v3 1/3] HID: hid-sensor-custom: Add custom sensor iio support
Date:   Thu,  3 Dec 2020 11:53:50 +0800
Message-Id: <20201203035352.13918-2-xiang.ye@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201203035352.13918-1-xiang.ye@intel.com>
References: <20201203035352.13918-1-xiang.ye@intel.com>
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
 drivers/hid/hid-sensor-custom.c | 181 ++++++++++++++++++++++++++++++++
 include/linux/hid-sensor-ids.h  |  14 +++
 2 files changed, 195 insertions(+)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index 4d25577a8573..b8e59021c6a8 100644
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
@@ -50,6 +52,8 @@ struct hid_sensor_custom {
 	struct kfifo data_fifo;
 	unsigned long misc_opened;
 	wait_queue_head_t wait;
+	struct platform_device *custom_pdev;
+	bool custom_pdev_exposed;
 };
 
 /* Header for each sample to user space via dev interface */
@@ -746,11 +750,164 @@ static void hid_sensor_custom_dev_if_remove(struct hid_sensor_custom
 
 }
 
+/*
+ * use sensors luid which is defined in FW, such as ISH,
+ * to identify sensor.
+ */
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
+	return -1;
+}
+
+static int get_known_custom_sensor_index(struct hid_sensor_hub_device *hsdev)
+{
+	struct hid_sensor_hub_attribute_info sensor_manufacturer = { 0 };
+	struct hid_sensor_hub_attribute_info sensor_luid_info = { 0 };
+	int report_size;
+	int ret;
+	u16 *w_buf;
+	char *buf;
+	int w_buf_len = sizeof(u16) * HID_CUSTOM_MAX_FEATURE_BYTES;
+	int buf_len = sizeof(char) * HID_CUSTOM_MAX_FEATURE_BYTES;
+	int i;
+	int index;
+
+	w_buf = kzalloc(w_buf_len, GFP_KERNEL);
+	if (!w_buf) {
+		ret = -ENOMEM;
+		goto error_out2;
+	}
+
+	buf = kzalloc(buf_len, GFP_KERNEL);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto error_out1;
+	}
+	/* get manufacturer info */
+	ret = sensor_hub_input_get_attribute_info(
+		hsdev, HID_FEATURE_REPORT, hsdev->usage,
+		HID_USAGE_SENSOR_PROP_MANUFACTURER, &sensor_manufacturer);
+	if (ret < 0) {
+		ret = -ENODEV;
+		goto error_out;
+	}
+
+	report_size =
+		sensor_hub_get_feature(hsdev, sensor_manufacturer.report_id,
+				       sensor_manufacturer.index, w_buf_len,
+				       w_buf);
+	if (report_size <= 0) {
+		hid_err(hsdev->hdev,
+			"Failed to get sensor manufacturer info %d\n",
+			report_size);
+		ret = -ENODEV;
+		goto error_out;
+	}
+
+	/* convert from wide char to char */
+	for (i = 0; i < buf_len - 1 && w_buf[i]; i++)
+		buf[i] = (char)w_buf[i];
+
+	/* ensure it's ISH sensor */
+	if (strncmp(buf, "INTEL", strlen("INTEL"))) {
+		ret = -ENODEV;
+		goto error_out;
+	}
+
+	memset(w_buf, 0, w_buf_len);
+	memset(buf, 0, buf_len);
+
+	/* get real usage id */
+	ret = sensor_hub_input_get_attribute_info(
+		hsdev, HID_FEATURE_REPORT, hsdev->usage,
+		HID_USAGE_SENSOR_PROP_SERIAL_NUM, &sensor_luid_info);
+	if (ret < 0) {
+		ret = -ENODEV;
+		goto error_out;
+	}
+
+	report_size = sensor_hub_get_feature(hsdev, sensor_luid_info.report_id,
+					     sensor_luid_info.index, w_buf_len,
+					     w_buf);
+	if (report_size <= 0) {
+		hid_err(hsdev->hdev, "Failed to get real usage info %d\n",
+			report_size);
+		ret = -ENODEV;
+		goto error_out;
+	}
+
+	/* convert from wide char to char */
+	for (i = 0; i < buf_len - 1 && w_buf[i]; i++)
+		buf[i] = (char)w_buf[i];
+
+	if (strlen(buf) != strlen(known_sensor_luid[0]) + 5) {
+		hid_err(hsdev->hdev,
+			"%s luid length not match %zu != (%zu + 5)\n", __func__,
+			strlen(buf), strlen(known_sensor_luid[0]));
+		ret = -ENODEV;
+		goto error_out;
+	}
+
+	/* get table index with luid (not matching 'LUID: ' in luid) */
+	index = get_luid_table_index(&buf[5]);
+	if (index >= 0)
+		ret = index;
+	else
+		ret = -ENODEV;
+
+error_out:
+	kfree(buf);
+error_out1:
+	kfree(w_buf);
+error_out2:
+	return ret;
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
+		return NULL;
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
@@ -764,6 +921,25 @@ static int hid_sensor_custom_probe(struct platform_device *pdev)
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
+		sensor_inst->custom_pdev_exposed = true;
+		return 0;
+	} else if (index < 0 && index != -ENODEV) {
+		return index;
+	}
+
 	ret = sensor_hub_register_callback(hsdev, hsdev->usage,
 					   &sensor_inst->callbacks);
 	if (ret < 0) {
@@ -802,6 +978,11 @@ static int hid_sensor_custom_remove(struct platform_device *pdev)
 	struct hid_sensor_custom *sensor_inst = platform_get_drvdata(pdev);
 	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
 
+	if (sensor_inst->custom_pdev_exposed) {
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

