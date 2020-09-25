Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09092782D7
	for <lists+linux-iio@lfdr.de>; Fri, 25 Sep 2020 10:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgIYIiX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Sep 2020 04:38:23 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:59954 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726990AbgIYIiX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Sep 2020 04:38:23 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08P8Ye1i009084;
        Fri, 25 Sep 2020 04:38:11 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33r5u9f978-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Sep 2020 04:38:11 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08P8cA2x054320
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 25 Sep 2020 04:38:10 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 25 Sep 2020 04:38:07 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 25 Sep 2020 04:38:07 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 25 Sep 2020 04:38:07 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08P8c5uE006205;
        Fri, 25 Sep 2020 04:38:07 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 1/5] iio: cros_ec: unify hw fifo attributes into the core file
Date:   Fri, 25 Sep 2020 11:37:39 +0300
Message-ID: <20200925083743.46469-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200925083743.46469-1-alexandru.ardelean@analog.com>
References: <20200925083743.46469-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-25_02:2020-09-24,2020-09-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250059
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The intent here is to minimize the use of iio_buffer_set_attrs(). Since we
are planning to add support for multiple IIO buffers per IIO device, the
issue has to do with:
1. Accessing 'indio_dev->buffer' directly (as is done with
   'iio_buffer_set_attrs(indio_dev->buffer, <attrs>)').
2. The way that the buffer attributes would get handled or expanded when
   there are more buffers per IIO device. Current a sysfs kobj_type expands
   into a 'device' object that expands into an 'iio_dev' object.
   We will need to change this, so that the sysfs attributes for IIO
   buffers expand into IIO buffers at some point.

Right now, the current IIO framework works fine for the
'1 IIO device == 1 IIO buffer' case (that is now).

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/accel/cros_ec_accel_legacy.c              |  2 +-
 .../iio/common/cros_ec_sensors/cros_ec_lid_angle.c    |  3 ++-
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c  |  5 ++---
 .../iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 11 ++++++++---
 drivers/iio/light/cros_ec_light_prox.c                |  5 ++---
 drivers/iio/pressure/cros_ec_baro.c                   |  5 ++---
 include/linux/iio/common/cros_ec_sensors_core.h       |  4 ++--
 7 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
index b6f3471b62dc..8f1232c38e0d 100644
--- a/drivers/iio/accel/cros_ec_accel_legacy.c
+++ b/drivers/iio/accel/cros_ec_accel_legacy.c
@@ -215,7 +215,7 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
-					cros_ec_sensors_capture, NULL);
+					cros_ec_sensors_capture, NULL, false);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
index af801e203623..752f59037715 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
@@ -97,7 +97,8 @@ static int cros_ec_lid_angle_probe(struct platform_device *pdev)
 	if (!indio_dev)
 		return -ENOMEM;
 
-	ret = cros_ec_sensors_core_init(pdev, indio_dev, false, NULL, NULL);
+	ret = cros_ec_sensors_core_init(pdev, indio_dev, false, NULL,
+					NULL, false);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index 130ab8ce0269..57038ca48d93 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -236,12 +236,11 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
 
 	ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
 					cros_ec_sensors_capture,
-					cros_ec_sensors_push_data);
+					cros_ec_sensors_push_data,
+					true);
 	if (ret)
 		return ret;
 
-	iio_buffer_set_attrs(indio_dev->buffer, cros_ec_sensor_fifo_attributes);
-
 	indio_dev->info = &ec_sensors_info;
 	state = iio_priv(indio_dev);
 	for (channel = state->channels, i = CROS_EC_SENSOR_X;
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 1bc6efa47316..c62cacc04672 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -177,12 +177,11 @@ static ssize_t hwfifo_watermark_max_show(struct device *dev,
 
 static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
 
-const struct attribute *cros_ec_sensor_fifo_attributes[] = {
+static const struct attribute *cros_ec_sensor_fifo_attributes[] = {
 	&iio_dev_attr_hwfifo_timeout.dev_attr.attr,
 	&iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
 	NULL,
 };
-EXPORT_SYMBOL_GPL(cros_ec_sensor_fifo_attributes);
 
 int cros_ec_sensors_push_data(struct iio_dev *indio_dev,
 			      s16 *data,
@@ -241,6 +240,7 @@ static void cros_ec_sensors_core_clean(void *arg)
  *    for backward compatibility.
  * @push_data:          function to call when cros_ec_sensorhub receives
  *    a sample for that sensor.
+ * @has_hw_fifo:	Set true if this device has/uses a HW FIFO
  *
  * Return: 0 on success, -errno on failure.
  */
@@ -248,7 +248,8 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 			      struct iio_dev *indio_dev,
 			      bool physical_device,
 			      cros_ec_sensors_capture_t trigger_capture,
-			      cros_ec_sensorhub_push_data_cb_t push_data)
+			      cros_ec_sensorhub_push_data_cb_t push_data,
+			      bool has_hw_fifo)
 {
 	struct device *dev = &pdev->dev;
 	struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
@@ -361,6 +362,10 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 					NULL);
 			if (ret)
 				return ret;
+
+			if (has_hw_fifo)
+				iio_buffer_set_attrs(indio_dev->buffer,
+						     cros_ec_sensor_fifo_attributes);
 		}
 	}
 
diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
index fed79ba27fda..75d6b5fcf2cc 100644
--- a/drivers/iio/light/cros_ec_light_prox.c
+++ b/drivers/iio/light/cros_ec_light_prox.c
@@ -182,12 +182,11 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
 
 	ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
 					cros_ec_sensors_capture,
-					cros_ec_sensors_push_data);
+					cros_ec_sensors_push_data,
+					true);
 	if (ret)
 		return ret;
 
-	iio_buffer_set_attrs(indio_dev->buffer, cros_ec_sensor_fifo_attributes);
-
 	indio_dev->info = &cros_ec_light_prox_info;
 	state = iio_priv(indio_dev);
 	state->core.type = state->core.resp->info.type;
diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
index f0938b6fbba0..aa043cb9ac42 100644
--- a/drivers/iio/pressure/cros_ec_baro.c
+++ b/drivers/iio/pressure/cros_ec_baro.c
@@ -139,12 +139,11 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
 
 	ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
 					cros_ec_sensors_capture,
-					cros_ec_sensors_push_data);
+					cros_ec_sensors_push_data,
+					true);
 	if (ret)
 		return ret;
 
-	iio_buffer_set_attrs(indio_dev->buffer, cros_ec_sensor_fifo_attributes);
-
 	indio_dev->info = &cros_ec_baro_info;
 	state = iio_priv(indio_dev);
 	state->core.type = state->core.resp->info.type;
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index caa8bb279a34..c9b80be82440 100644
--- a/include/linux/iio/common/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -96,7 +96,8 @@ struct platform_device;
 int cros_ec_sensors_core_init(struct platform_device *pdev,
 			      struct iio_dev *indio_dev, bool physical_device,
 			      cros_ec_sensors_capture_t trigger_capture,
-			      cros_ec_sensorhub_push_data_cb_t push_data);
+			      cros_ec_sensorhub_push_data_cb_t push_data,
+			      bool has_hw_fifo);
 
 irqreturn_t cros_ec_sensors_capture(int irq, void *p);
 int cros_ec_sensors_push_data(struct iio_dev *indio_dev,
@@ -125,6 +126,5 @@ extern const struct dev_pm_ops cros_ec_sensors_pm_ops;
 
 /* List of extended channel specification for all sensors. */
 extern const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[];
-extern const struct attribute *cros_ec_sensor_fifo_attributes[];
 
 #endif  /* __CROS_EC_SENSORS_CORE_H */
-- 
2.17.1

