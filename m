Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80924278D7
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2019 11:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbfEWJII (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 May 2019 05:08:08 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34588 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfEWJII (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 May 2019 05:08:08 -0400
Received: from laptop.home (unknown [IPv6:2a01:cb19:8ad6:900:42dd:dd1c:19ee:7c60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: aragua)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id BC331280175;
        Thu, 23 May 2019 10:08:05 +0100 (BST)
From:   Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     kernel@collabora.com,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Nick Vaccaro <nvaccaro@chromium.org>,
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
Subject: [PATCH v2 1/3] iio: common: cros_ec_sensors: support protocol v3 message
Date:   Thu, 23 May 2019 11:07:35 +0200
Message-Id: <b619ce4f7f2d10ce1ede2b99d7262828f5b24952.1558601329.git.fabien.lahoudere@collabora.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1558601329.git.fabien.lahoudere@collabora.com>
References: <cover.1558601329.git.fabien.lahoudere@collabora.com>
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
Signed-off-by: Nick Vaccaro <nvaccaro@chromium.org>
---
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 83 ++++++++++++++++++-
 .../linux/iio/common/cros_ec_sensors_core.h   |  4 +
 include/linux/mfd/cros_ec_commands.h          | 21 +++++
 3 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 719a0df5aeeb..ac53ea32c1b1 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -25,6 +25,67 @@ static char *cros_ec_loc[] = {
 	[MOTIONSENSE_LOC_MAX] = "unknown",
 };
 
+static void get_default_min_max_freq(enum motionsensor_type type,
+				     u32 *min_freq,
+				     u32 *max_freq)
+{
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
@@ -33,6 +94,8 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 	struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
 	struct cros_ec_dev *ec = dev_get_drvdata(pdev->dev.parent);
 	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
+	u32 ver_mask;
+	int ret;
 
 	platform_set_drvdata(pdev, indio_dev);
 
@@ -47,8 +110,16 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 
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
 
@@ -66,6 +137,16 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 		}
 		state->type = state->resp->info.type;
 		state->loc = state->resp->info.location;
+		if (state->msg->version < 3) {
+			get_default_min_max_freq(state->resp->info.type,
+						 &state->min_freq,
+						 &state->max_freq);
+		} else {
+			state->min_freq =
+				state->resp->info_3.min_frequency;
+			state->max_freq =
+				state->resp->info_3.max_frequency;
+		}
 	}
 
 	return 0;
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index ce16445411ac..32fd08bbcf52 100644
--- a/include/linux/iio/common/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -78,6 +78,10 @@ struct cros_ec_sensors_core_state {
 				    unsigned long scan_mask, s16 *data);
 
 	int curr_sampl_freq;
+
+	/* Min and Max Sampling Frequency in mHz */
+	u32 min_freq;
+	u32 max_freq;
 };
 
 /**
diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index dcec96f01879..db2e3a9a656e 100644
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
+			/* Reserved field */
+			uint32_t reserved;
+		} info_3;
+
 		/* Used for MOTIONSENSE_CMD_DATA */
 		struct ec_response_motion_sensor_data data;
 
-- 
2.20.1

