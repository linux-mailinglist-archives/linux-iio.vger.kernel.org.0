Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB0AF12BE4
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2019 12:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfECKzA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 06:55:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45992 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfECKzA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 06:55:00 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e34:ee7d:73d0:5796:7015:7f6:aeeb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: aragua)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D8A802843CB;
        Fri,  3 May 2019 11:54:57 +0100 (BST)
From:   Fabien Lahoudere <fabien.lahoudere@collabora.com>
To:     linux-iio@vger.kernel.org
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>
Subject: [RFC 1/1] iio: common: cros_ec_sensors: add extra sensor API
Date:   Fri,  3 May 2019 12:54:46 +0200
Message-Id: <f30612908370460d61904450d6f7c5224082898e.1556873525.git.fabien.lahoudere@collabora.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1556873525.git.fabien.lahoudere@collabora.com>
References: <cover.1556873525.git.fabien.lahoudere@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Gwendal Grignou <gwendal@chromium.org>

Version 3 of the EC protocol provides min and max frequencies and fifo
size for EC sensors.
The driver allows EC to set parameters for version 3 and set default values
for earlier versions.
The sysfs entries are read only and cannot be used to impact on values.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
---
 .../ABI/testing/sysfs-bus-iio-cros-ec         |  24 ++++
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 126 +++++++++++++++++-
 .../linux/iio/common/cros_ec_sensors_core.h   |   7 +
 include/linux/mfd/cros_ec_commands.h          |  21 +++
 4 files changed, 177 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-cros-ec b/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
index 0e95c2ca105c..85d266f4a57e 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
+++ b/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
@@ -26,3 +26,27 @@ Description:
 		driver and represents the sensor ID as exposed by the EC. This
 		ID is used by the Android sensor service hardware abstraction
 		layer (sensor HAL) through the Android container on ChromeOS.
+
+What:		/sys/bus/iio/devices/iio:deviceX/min_frequency
+Date:		April 2019
+KernelVersion:	5.0
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute is exposed by CrOS EC sensors. It defines the
+		minimum frequency used by the sensor.
+
+What:		/sys/bus/iio/devices/iio:deviceX/max_frequency
+Date:		April 2019
+KernelVersion:	5.0
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute is exposed by CrOS EC sensors. It defines the
+		maximum frequency used by the sensor.
+
+What:		/sys/bus/iio/devices/iio:deviceX/max_events
+Date:		April 2019
+KernelVersion:	5.0
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute is exposed by CrOS EC sensors. It defines the
+		maximum number of events in the	fifo.
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 719a0df5aeeb..84908a4085ef 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -19,12 +19,84 @@
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 
+/*
+ * Hard coded to the first device to support sensor fifo.  The EC has a 2048
+ * byte fifo and will trigger an interrupt when fifo is 2/3 full.
+ */
+#define CROS_EC_FIFO_SIZE (2048 * 2 / 3)
+
 static char *cros_ec_loc[] = {
 	[MOTIONSENSE_LOC_BASE] = "base",
 	[MOTIONSENSE_LOC_LID] = "lid",
 	[MOTIONSENSE_LOC_MAX] = "unknown",
 };
 
+static void get_default_min_max_freq_and_fifo_size(enum motionsensor_type type,
+						   u32 *min_freq,
+						   u32 *max_freq,
+						   u32 *max_fifo_events)
+{
+	/* we don't know fifo size, set to size previously used by sensor HAL */
+	*max_fifo_events = CROS_EC_FIFO_SIZE;
+
+	switch (type) {
+	case MOTIONSENSE_TYPE_ACCEL:
+	case MOTIONSENSE_TYPE_GYRO:
+		*min_freq = 12500;
+		*max_freq = 100000;
+		break;
+	case MOTIONSENSE_TYPE_MAG:
+		*min_freq = 5000;
+		*max_freq = 25000;
+		break;
+	case MOTIONSENSE_TYPE_PROX:
+	case MOTIONSENSE_TYPE_LIGHT:
+		*min_freq = 100;
+		*max_freq = 50000;
+		break;
+	case MOTIONSENSE_TYPE_BARO:
+		*min_freq = 250;
+		*max_freq = 20000;
+		break;
+	case MOTIONSENSE_TYPE_ACTIVITY:
+	default:
+		*max_fifo_events = 0;
+		*min_freq = 0;
+		*max_freq = 0;
+		break;
+	}
+}
+
+static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
+					     u16 cmd_offset, u16 cmd, u32 *mask)
+{
+	struct {
+		struct cros_ec_command msg;
+		union {
+			struct ec_params_get_cmd_versions params;
+			struct ec_response_get_cmd_versions resp;
+		};
+	} __packed buf;
+	struct ec_params_get_cmd_versions *params = &buf.params;
+	struct ec_response_get_cmd_versions *resp = &buf.resp;
+	struct cros_ec_command *msg = &buf.msg;
+	int ret;
+
+	memset(&buf, 0, sizeof(buf));
+	msg->command = EC_CMD_GET_CMD_VERSIONS + cmd_offset;
+	msg->insize = sizeof(*resp);
+	msg->outsize = sizeof(*params);
+	params->cmd = cmd;
+	ret = cros_ec_cmd_xfer_status(ec_dev, msg);
+	if (ret >= 0) {
+		if (msg->result == EC_RES_SUCCESS)
+			*mask = resp->version_mask;
+		else
+			*mask = 0;
+	}
+	return ret;
+}
+
 int cros_ec_sensors_core_init(struct platform_device *pdev,
 			      struct iio_dev *indio_dev,
 			      bool physical_device)
@@ -33,6 +105,8 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 	struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
 	struct cros_ec_dev *ec = dev_get_drvdata(pdev->dev.parent);
 	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
+	u32 ver_mask;
+	int ret;
 
 	platform_set_drvdata(pdev, indio_dev);
 
@@ -47,8 +121,16 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 
 	mutex_init(&state->cmd_lock);
 
+	/* determine what version of MOTIONSENSE CMD EC has */
+	ret = cros_ec_get_host_cmd_version_mask(state->ec,
+						ec->cmd_offset,
+						EC_CMD_MOTION_SENSE_CMD,
+						&ver_mask);
+	if (ret < 0 || ver_mask == 0)
+		return -ENODEV;
+
 	/* Set up the host command structure. */
-	state->msg->version = 2;
+	state->msg->version = fls(ver_mask) - 1;
 	state->msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
 	state->msg->outsize = sizeof(struct ec_params_motion_sense);
 
@@ -66,6 +148,20 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 		}
 		state->type = state->resp->info.type;
 		state->loc = state->resp->info.location;
+		if (state->msg->version < 3) {
+			get_default_min_max_freq_and_fifo_size(
+					state->resp->info.type,
+					&state->min_freq,
+					&state->max_freq,
+					&state->fifo_max_event_count);
+		} else {
+			state->min_freq =
+				state->resp->info_3.min_frequency;
+			state->max_freq =
+				state->resp->info_3.max_frequency;
+			state->fifo_max_event_count =
+				state->resp->info_3.fifo_max_event_count;
+		}
 	}
 
 	return 0;
@@ -134,6 +230,19 @@ static ssize_t cros_ec_sensors_loc(struct iio_dev *indio_dev,
 	return snprintf(buf, PAGE_SIZE, "%s\n", cros_ec_loc[st->loc]);
 }
 
+#define DEVICE_STATE_INT_ATTR(_name, _var) \
+static ssize_t cros_ec_sensors_##_name(struct iio_dev *indio_dev, \
+		uintptr_t private, const struct iio_chan_spec *chan, \
+		char *buf) \
+{ \
+	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev); \
+	return snprintf(buf, PAGE_SIZE, "%d\n", st->_var); \
+}
+
+DEVICE_STATE_INT_ATTR(min_freq, min_freq);
+DEVICE_STATE_INT_ATTR(max_freq, max_freq);
+DEVICE_STATE_INT_ATTR(max_events, fifo_max_event_count);
+
 const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[] = {
 	{
 		.name = "calibrate",
@@ -145,6 +254,21 @@ const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[] = {
 		.shared = IIO_SHARED_BY_ALL,
 		.read = cros_ec_sensors_loc
 	},
+	{
+		.name = "min_frequency",
+		.shared = IIO_SHARED_BY_ALL,
+		.read = cros_ec_sensors_min_freq
+	},
+	{
+		.name = "max_frequency",
+		.shared = IIO_SHARED_BY_ALL,
+		.read = cros_ec_sensors_max_freq
+	},
+	{
+		.name = "max_events",
+		.shared = IIO_SHARED_BY_ALL,
+		.read = cros_ec_sensors_max_events
+	},
 	{ },
 };
 EXPORT_SYMBOL_GPL(cros_ec_sensors_ext_info);
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index ce16445411ac..4742a9637a85 100644
--- a/include/linux/iio/common/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -78,6 +78,13 @@ struct cros_ec_sensors_core_state {
 				    unsigned long scan_mask, s16 *data);
 
 	int curr_sampl_freq;
+
+	/* Min and Max Sampling Frequency in mHz */
+	u32 min_freq;
+	u32 max_freq;
+
+	/* event fifo size represented in number of events */
+	u32 fifo_max_event_count;
 };
 
 /**
diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 43bee4f7d137..7fbf29416a0b 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -1714,6 +1714,27 @@ struct ec_response_motion_sense {
 			uint8_t chip;
 		} info;
 
+		/* Used for MOTIONSENSE_CMD_INFO version 3 */
+		struct __ec_todo_unpacked {
+			/* Should be element of enum motionsensor_type. */
+			u8 type;
+
+			/* Should be element of enum motionsensor_location. */
+			u8 location;
+
+			/* Should be element of enum motionsensor_chip. */
+			u8 chip;
+
+			/* Minimum sensor sampling frequency */
+			u32 min_frequency;
+
+			/* Maximum sensor sampling frequency */
+			u32 max_frequency;
+
+			/* Max number of sensor events that could be in fifo */
+			u32 fifo_max_event_count;
+		} info_3;
+
 		/* Used for MOTIONSENSE_CMD_DATA */
 		struct ec_response_motion_sensor_data data;
 
-- 
2.19.2

