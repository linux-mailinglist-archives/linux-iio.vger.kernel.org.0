Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60BD849CA3
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2019 11:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbfFRJH1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Jun 2019 05:07:27 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60036 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbfFRJH0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Jun 2019 05:07:26 -0400
Received: from laptop.home (unknown [IPv6:2a01:cb19:8ad6:900:42dd:dd1c:19ee:7c60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: aragua)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8072A283982;
        Tue, 18 Jun 2019 10:07:24 +0100 (BST)
From:   Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     kernel@collabora.com,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Nick Vaccaro <nvaccaro@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/8] iio: common: cros_ec_sensors: support protocol v3 message
Date:   Tue, 18 Jun 2019 11:06:37 +0200
Message-Id: <ac3cdc104e59565d178dfa86f2727045224dc4da.1560848479.git.fabien.lahoudere@collabora.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1560848479.git.fabien.lahoudere@collabora.com>
References: <cover.1560848479.git.fabien.lahoudere@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Version 3 of the EC protocol provides min and max frequencies for EC sensors.

Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
Signed-off-by: Nick Vaccaro <nvaccaro@chromium.org>
---
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 85 ++++++++++++++++++-
 .../linux/iio/common/cros_ec_sensors_core.h   |  3 +
 2 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 57034e212fe1..2ce077b576a4 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -26,6 +26,66 @@ static char *cros_ec_loc[] = {
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
+	int ret;
+	struct {
+		struct cros_ec_command msg;
+		union {
+			struct ec_params_get_cmd_versions params;
+			struct ec_response_get_cmd_versions resp;
+		};
+	} __packed buf = {
+		.msg = {
+			.command = EC_CMD_GET_CMD_VERSIONS + cmd_offset,
+			.insize = sizeof(struct ec_response_get_cmd_versions),
+			.outsize = sizeof(struct ec_params_get_cmd_versions)
+			},
+		.params = {.cmd = cmd}
+	};
+
+	ret = cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
+	if (ret >= 0) {
+		if (buf.msg.result == EC_RES_SUCCESS)
+			*mask = buf.resp.version_mask;
+		else
+			*mask = 0;
+	}
+	return ret;
+}
+
 int cros_ec_sensors_core_init(struct platform_device *pdev,
 			      int num_channels,
 			      bool physical_device)
@@ -35,6 +95,8 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 	struct cros_ec_dev *ec = dev_get_drvdata(pdev->dev.parent);
 	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
 	struct iio_dev *indio_dev;
+	u32 ver_mask;
+	int ret;
 
 	if (num_channels > CROS_EC_SENSORS_CORE_MAX_CHANNELS)
 		return -EINVAL;
@@ -57,8 +119,16 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 
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
 
@@ -76,6 +146,19 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 		}
 		state->type = state->resp->info.type;
 		state->loc = state->resp->info.location;
+
+		/* Value to stop the device */
+		state->frequency_range[0] = 0;
+		if (state->msg->version < 3) {
+			get_default_min_max_freq(state->resp->info.type,
+						 &state->frequency_range[1],
+						 &state->frequency_range[2]);
+		} else {
+			state->frequency_range[1] =
+			    state->resp->info_3.min_frequency;
+			state->frequency_range[2] =
+			    state->resp->info_3.max_frequency;
+		}
 	}
 
 	indio_dev->info = &state->info;
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index 3e6de427076e..89937ad242ef 100644
--- a/include/linux/iio/common/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -74,6 +74,9 @@ struct cros_ec_sensors_core_state {
 	int curr_sampl_freq;
 	struct iio_info info;
 	struct iio_chan_spec channels[CROS_EC_SENSORS_CORE_MAX_CHANNELS];
+
+	/* Disable, Min and Max Sampling Frequency in mHz */
+	int frequency_range[3];
 };
 
 /**
-- 
2.20.1

