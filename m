Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5241026564
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2019 16:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbfEVOKO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 May 2019 10:10:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56032 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728457AbfEVOKO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 May 2019 10:10:14 -0400
Received: from laptop.home (unknown [IPv6:2a01:cb19:8ad6:900:42dd:dd1c:19ee:7c60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: aragua)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id AF7CE27E5F5;
        Wed, 22 May 2019 15:10:11 +0100 (BST)
From:   Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     kernel@collabora.com,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iio: common: cros_ec_sensors: support protocol v3 message
Date:   Wed, 22 May 2019 16:09:52 +0200
Message-Id: <9d5dbba798410321177efa5d8a562105ff8cf429.1558533743.git.fabien.lahoudere@collabora.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Version 3 of the EC protocol provides min and max frequencies and fifo
size for EC sensors.

Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
---
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 98 ++++++++++++++++++-
 .../linux/iio/common/cros_ec_sensors_core.h   |  7 ++
 include/linux/mfd/cros_ec_commands.h          | 21 ++++
 3 files changed, 125 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 719a0df5aeeb..d5c8b4714ad6 100644
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
index dcec96f01879..27d71cbf22f1 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -1744,6 +1744,27 @@ struct ec_response_motion_sense {
 			uint8_t chip;
 		} info;
 
+		/* Used for MOTIONSENSE_CMD_INFO version 3 */
+		struct __ec_todo_unpacked {
+			/* Should be element of enum motionsensor_type. */
+			uint8_t type;
+
+			/* Should be element of enum motionsensor_location. */
+			uint8_t location;
+
+			/* Should be element of enum motionsensor_chip. */
+			uint8_t chip;
+
+			/* Minimum sensor sampling frequency */
+			uint32_t min_frequency;
+
+			/* Maximum sensor sampling frequency */
+			uint32_t max_frequency;
+
+			/* Max number of sensor events that could be in fifo */
+			uint32_t fifo_max_event_count;
+		} info_3;
+
 		/* Used for MOTIONSENSE_CMD_DATA */
 		struct ec_response_motion_sensor_data data;
 
-- 
2.20.1

