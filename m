Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983A92C0DC7
	for <lists+linux-iio@lfdr.de>; Mon, 23 Nov 2020 15:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733086AbgKWOfV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Nov 2020 09:35:21 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:15280 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729366AbgKWOfU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Nov 2020 09:35:20 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0ANEZ63u006719;
        Mon, 23 Nov 2020 09:35:16 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 34y08uw1pg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 09:35:16 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0ANEZEGR049464
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 23 Nov 2020 09:35:15 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 23 Nov 2020 06:35:13 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 23 Nov 2020 06:35:13 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0ANEZAqN024147;
        Mon, 23 Nov 2020 09:35:10 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <jic23@kernel.org>, <bleung@chromium.org>,
        <enric.balletbo@collabora.com>, <groeck@chromium.org>,
        <gwendal@chromium.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/2] iio: cros_ec: do an early exit if not physical_device case
Date:   Mon, 23 Nov 2020 16:40:16 +0200
Message-ID: <20201123144017.18311-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-23_11:2020-11-23,2020-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 clxscore=1011 priorityscore=1501 impostorscore=0 suspectscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011230100
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This whole code-block was put under one big if() condition/block.
This change does an early return if the 'physical_device' boolean is false,
thus unindenting the block by one level.

No other functional change has been done.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 161 +++++++++---------
 1 file changed, 81 insertions(+), 80 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 5c6c4e6fec9b..9470014936f2 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -287,89 +287,90 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 
 	indio_dev->name = pdev->name;
 
-	if (physical_device) {
-		state->param.cmd = MOTIONSENSE_CMD_INFO;
-		state->param.info.sensor_num = sensor_platform->sensor_num;
-		ret = cros_ec_motion_send_host_cmd(state, 0);
-		if (ret) {
-			dev_warn(dev, "Can not access sensor info\n");
+	if (!physical_device)
+		return 0;
+
+	state->param.cmd = MOTIONSENSE_CMD_INFO;
+	state->param.info.sensor_num = sensor_platform->sensor_num;
+	ret = cros_ec_motion_send_host_cmd(state, 0);
+	if (ret) {
+		dev_warn(dev, "Can not access sensor info\n");
+		return ret;
+	}
+	state->type = state->resp->info.type;
+	state->loc = state->resp->info.location;
+
+	/* Set sign vector, only used for backward compatibility. */
+	memset(state->sign, 1, CROS_EC_SENSOR_MAX_AXIS);
+
+	for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++)
+		state->calib[i].scale = MOTION_SENSE_DEFAULT_SCALE;
+
+	/* 0 is a correct value used to stop the device */
+	if (state->msg->version < 3) {
+		get_default_min_max_freq(state->resp->info.type,
+					 &frequencies[1],
+					 &frequencies[2],
+					 &state->fifo_max_event_count);
+	} else {
+		frequencies[1] = state->resp->info_3.min_frequency;
+		frequencies[2] = state->resp->info_3.max_frequency;
+		state->fifo_max_event_count =
+		    state->resp->info_3.fifo_max_event_count;
+	}
+	for (i = 0; i < ARRAY_SIZE(frequencies); i++) {
+		state->frequencies[2 * i] = frequencies[i] / 1000;
+		state->frequencies[2 * i + 1] =
+			(frequencies[i] % 1000) * 1000;
+	}
+
+	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
+		/*
+		 * Create a software buffer, feed by the EC FIFO.
+		 * We can not use trigger here, as events are generated
+		 * as soon as sample_frequency is set.
+		 */
+		struct iio_buffer *buffer;
+
+		buffer = devm_iio_kfifo_allocate(dev);
+		if (!buffer)
+			return -ENOMEM;
+
+		iio_device_attach_buffer(indio_dev, buffer);
+		indio_dev->modes = INDIO_BUFFER_SOFTWARE;
+
+		ret = cros_ec_sensorhub_register_push_data(
+				sensor_hub, sensor_platform->sensor_num,
+				indio_dev, push_data);
+		if (ret)
 			return ret;
-		}
-		state->type = state->resp->info.type;
-		state->loc = state->resp->info.location;
 
-		/* Set sign vector, only used for backward compatibility. */
-		memset(state->sign, 1, CROS_EC_SENSOR_MAX_AXIS);
+		ret = devm_add_action_or_reset(
+				dev, cros_ec_sensors_core_clean, pdev);
+		if (ret)
+			return ret;
 
-		for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++)
-			state->calib[i].scale = MOTION_SENSE_DEFAULT_SCALE;
-
-		/* 0 is a correct value used to stop the device */
-		if (state->msg->version < 3) {
-			get_default_min_max_freq(state->resp->info.type,
-						 &frequencies[1],
-						 &frequencies[2],
-						 &state->fifo_max_event_count);
-		} else {
-			frequencies[1] = state->resp->info_3.min_frequency;
-			frequencies[2] = state->resp->info_3.max_frequency;
-			state->fifo_max_event_count =
-			    state->resp->info_3.fifo_max_event_count;
-		}
-		for (i = 0; i < ARRAY_SIZE(frequencies); i++) {
-			state->frequencies[2 * i] = frequencies[i] / 1000;
-			state->frequencies[2 * i + 1] =
-				(frequencies[i] % 1000) * 1000;
-		}
-
-		if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
-			/*
-			 * Create a software buffer, feed by the EC FIFO.
-			 * We can not use trigger here, as events are generated
-			 * as soon as sample_frequency is set.
-			 */
-			struct iio_buffer *buffer;
-
-			buffer = devm_iio_kfifo_allocate(dev);
-			if (!buffer)
-				return -ENOMEM;
-
-			iio_device_attach_buffer(indio_dev, buffer);
-			indio_dev->modes = INDIO_BUFFER_SOFTWARE;
-
-			ret = cros_ec_sensorhub_register_push_data(
-					sensor_hub, sensor_platform->sensor_num,
-					indio_dev, push_data);
-			if (ret)
-				return ret;
-
-			ret = devm_add_action_or_reset(
-					dev, cros_ec_sensors_core_clean, pdev);
-			if (ret)
-				return ret;
-
-			/* Timestamp coming from FIFO are in ns since boot. */
-			ret = iio_device_set_clock(indio_dev, CLOCK_BOOTTIME);
-			if (ret)
-				return ret;
-		} else {
-			const struct attribute **fifo_attrs;
-
-			if (has_hw_fifo)
-				fifo_attrs = cros_ec_sensor_fifo_attributes;
-			else
-				fifo_attrs = NULL;
-
-			/*
-			 * The only way to get samples in buffer is to set a
-			 * software trigger (systrig, hrtimer).
-			 */
-			ret = devm_iio_triggered_buffer_setup_ext(
-					dev, indio_dev, NULL, trigger_capture,
-					NULL, fifo_attrs);
-			if (ret)
-				return ret;
-		}
+		/* Timestamp coming from FIFO are in ns since boot. */
+		ret = iio_device_set_clock(indio_dev, CLOCK_BOOTTIME);
+		if (ret)
+			return ret;
+	} else {
+		const struct attribute **fifo_attrs;
+
+		if (has_hw_fifo)
+			fifo_attrs = cros_ec_sensor_fifo_attributes;
+		else
+			fifo_attrs = NULL;
+
+		/*
+		 * The only way to get samples in buffer is to set a
+		 * software trigger (systrig, hrtimer).
+		 */
+		ret = devm_iio_triggered_buffer_setup_ext(
+				dev, indio_dev, NULL, trigger_capture,
+				NULL, fifo_attrs);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
-- 
2.17.1

