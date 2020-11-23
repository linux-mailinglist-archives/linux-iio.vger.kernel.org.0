Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFB32C0DCA
	for <lists+linux-iio@lfdr.de>; Mon, 23 Nov 2020 15:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388866AbgKWOfW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Nov 2020 09:35:22 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:17504 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733292AbgKWOfW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Nov 2020 09:35:22 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0ANEQIm7022742;
        Mon, 23 Nov 2020 09:35:18 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 34y0p8514y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 09:35:17 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0ANEZG7h049467
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 23 Nov 2020 09:35:16 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 23 Nov 2020 06:35:14 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 23 Nov 2020 06:35:14 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0ANEZAqO024147;
        Mon, 23 Nov 2020 09:35:12 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <jic23@kernel.org>, <bleung@chromium.org>,
        <enric.balletbo@collabora.com>, <groeck@chromium.org>,
        <gwendal@chromium.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/2] iio: cros_ec: un-indent block that configures motion sensor fifo
Date:   Mon, 23 Nov 2020 16:40:17 +0200
Message-ID: <20201123144017.18311-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201123144017.18311-1-alexandru.ardelean@analog.com>
References: <20201123144017.18311-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-23_11:2020-11-23,2020-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011230099
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change also reverses the condition of the FIFO setup. If the feature
setup does not include a EC_FEATURE_MOTION_SENSE_FIFO flag, then the
IIO triggered buffer setup is done and first and early exit is performed.
It'a done like this because the code block (for the IIO triggered buffer
setup) is smaller.

The code block for the EC_FEATURE_MOTION_SENSE_FIFO flag has been
un-indented.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 63 +++++++++----------
 1 file changed, 28 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 9470014936f2..921eccd4f6a6 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -258,6 +258,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
 	u32 ver_mask;
 	int frequencies[ARRAY_SIZE(state->frequencies) / 2] = { 0 };
+	struct iio_buffer *buffer;
 	int ret, i;
 
 	platform_set_drvdata(pdev, indio_dev);
@@ -324,37 +325,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 			(frequencies[i] % 1000) * 1000;
 	}
 
-	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
-		/*
-		 * Create a software buffer, feed by the EC FIFO.
-		 * We can not use trigger here, as events are generated
-		 * as soon as sample_frequency is set.
-		 */
-		struct iio_buffer *buffer;
-
-		buffer = devm_iio_kfifo_allocate(dev);
-		if (!buffer)
-			return -ENOMEM;
-
-		iio_device_attach_buffer(indio_dev, buffer);
-		indio_dev->modes = INDIO_BUFFER_SOFTWARE;
-
-		ret = cros_ec_sensorhub_register_push_data(
-				sensor_hub, sensor_platform->sensor_num,
-				indio_dev, push_data);
-		if (ret)
-			return ret;
-
-		ret = devm_add_action_or_reset(
-				dev, cros_ec_sensors_core_clean, pdev);
-		if (ret)
-			return ret;
-
-		/* Timestamp coming from FIFO are in ns since boot. */
-		ret = iio_device_set_clock(indio_dev, CLOCK_BOOTTIME);
-		if (ret)
-			return ret;
-	} else {
+	if (!cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
 		const struct attribute **fifo_attrs;
 
 		if (has_hw_fifo)
@@ -366,14 +337,36 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 		 * The only way to get samples in buffer is to set a
 		 * software trigger (systrig, hrtimer).
 		 */
-		ret = devm_iio_triggered_buffer_setup_ext(
+		return devm_iio_triggered_buffer_setup_ext(
 				dev, indio_dev, NULL, trigger_capture,
 				NULL, fifo_attrs);
-		if (ret)
-			return ret;
 	}
 
-	return 0;
+	/*
+	 * Create a software buffer, feed by the EC FIFO.
+	 * We can not use trigger here, as events are generated
+	 * as soon as sample_frequency is set.
+	 */
+	buffer = devm_iio_kfifo_allocate(dev);
+	if (!buffer)
+		return -ENOMEM;
+
+	iio_device_attach_buffer(indio_dev, buffer);
+	indio_dev->modes = INDIO_BUFFER_SOFTWARE;
+
+	ret = cros_ec_sensorhub_register_push_data(
+			sensor_hub, sensor_platform->sensor_num,
+			indio_dev, push_data);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(
+			dev, cros_ec_sensors_core_clean, pdev);
+	if (ret)
+		return ret;
+
+	/* Timestamp coming from FIFO are in ns since boot. */
+	return iio_device_set_clock(indio_dev, CLOCK_BOOTTIME);
 }
 EXPORT_SYMBOL_GPL(cros_ec_sensors_core_init);
 
-- 
2.17.1

