Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1613007F5
	for <lists+linux-iio@lfdr.de>; Fri, 22 Jan 2021 16:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbhAVP4u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Jan 2021 10:56:50 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:32714 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729172AbhAVP42 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Jan 2021 10:56:28 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10MFUuU1019154;
        Fri, 22 Jan 2021 10:55:34 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3668rbtjqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jan 2021 10:55:34 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 10MFtWl8002570
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Jan 2021 10:55:33 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Fri, 22 Jan 2021 07:55:31 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 22 Jan 2021 07:55:31 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 10MFtF5C014933;
        Fri, 22 Jan 2021 10:55:28 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 09/12] iio: re-route all buffer attributes through new buffer kobj_type
Date:   Fri, 22 Jan 2021 17:58:02 +0200
Message-ID: <20210122155805.83012-10-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210122155805.83012-1-alexandru.ardelean@analog.com>
References: <20210122155805.83012-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-22_11:2021-01-22,2021-01-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 malwarescore=0 impostorscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101220087
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Now that the iio_buffer_set_attrs() has been removed, we can be sure that
no accidents can happen with drivers that try to provide extra buffer
attributes that expand to iio_dev objects.

So, we can convert all remaining buffer attributes to expand to iio_buffer
objects.
These will look a bit weird at first, as most of them will just pass back
their reference to the IIO device.
But this can also allow for newer (maybe more interesting) uses.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/accel/adxl372.c                   | 36 ++++-----
 drivers/iio/accel/bmc150-accel-core.c         | 34 ++++-----
 drivers/iio/adc/at91-sama5d2_adc.c            | 30 ++++----
 .../buffer/industrialio-buffer-dmaengine.c    | 13 ++--
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 30 ++++----
 .../common/hid-sensors/hid-sensor-trigger.c   | 32 ++++----
 drivers/iio/industrialio-buffer.c             | 73 +++----------------
 include/linux/iio/sysfs.h                     | 50 +++++++++++++
 8 files changed, 148 insertions(+), 150 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 8ba1453b8dbf..a90aaa518816 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -978,39 +978,39 @@ static ssize_t adxl372_show_filter_freq_avail(struct device *dev,
 	return len;
 }
 
-static ssize_t adxl372_get_fifo_enabled(struct device *dev,
-					  struct device_attribute *attr,
-					  char *buf)
+static ssize_t adxl372_get_fifo_enabled(struct iio_buffer *buffer,
+					struct iio_buf_attr *attr,
+					char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev *indio_dev = iio_buffer_get_iio_dev(buffer);
 	struct adxl372_state *st = iio_priv(indio_dev);
 
 	return sprintf(buf, "%d\n", st->fifo_mode);
 }
 
-static ssize_t adxl372_get_fifo_watermark(struct device *dev,
-					  struct device_attribute *attr,
+static ssize_t adxl372_get_fifo_watermark(struct iio_buffer *buffer,
+					  struct iio_buf_attr *attr,
 					  char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev *indio_dev = iio_buffer_get_iio_dev(buffer);
 	struct adxl372_state *st = iio_priv(indio_dev);
 
 	return sprintf(buf, "%d\n", st->watermark);
 }
 
-static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
-static IIO_CONST_ATTR(hwfifo_watermark_max,
-		      __stringify(ADXL372_FIFO_SIZE));
-static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
-		       adxl372_get_fifo_watermark, NULL, 0);
-static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
-		       adxl372_get_fifo_enabled, NULL, 0);
+static IIO_BUF_CONST_ATTR(hwfifo_watermark_min, "1");
+static IIO_BUF_CONST_ATTR(hwfifo_watermark_max,
+			  __stringify(ADXL372_FIFO_SIZE));
+static IIO_BUF_ATTR(hwfifo_watermark, 0444,
+		    adxl372_get_fifo_watermark, NULL);
+static IIO_BUF_ATTR(hwfifo_enabled, 0444,
+		    adxl372_get_fifo_enabled, NULL);
 
 static const struct attribute *adxl372_fifo_attributes[] = {
-	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
-	&iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
-	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
-	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
+	&iio_buf_const_attr_hwfifo_watermark_min.buf_attr.attr,
+	&iio_buf_const_attr_hwfifo_watermark_max.buf_attr.attr,
+	&iio_buf_attr_hwfifo_watermark.attr,
+	&iio_buf_attr_hwfifo_enabled.attr,
 	NULL,
 };
 
diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 7e425ebcd7ea..87b1ad523106 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -867,11 +867,11 @@ static int bmc150_accel_validate_trigger(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-static ssize_t bmc150_accel_get_fifo_watermark(struct device *dev,
-					       struct device_attribute *attr,
+static ssize_t bmc150_accel_get_fifo_watermark(struct iio_buffer *buffer,
+					       struct iio_buf_attr *attr,
 					       char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev *indio_dev = iio_buffer_get_iio_dev(buffer);
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 	int wm;
 
@@ -882,11 +882,11 @@ static ssize_t bmc150_accel_get_fifo_watermark(struct device *dev,
 	return sprintf(buf, "%d\n", wm);
 }
 
-static ssize_t bmc150_accel_get_fifo_state(struct device *dev,
-					   struct device_attribute *attr,
+static ssize_t bmc150_accel_get_fifo_state(struct iio_buffer *buffer,
+					   struct iio_buf_attr *attr,
 					   char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev *indio_dev = iio_buffer_get_iio_dev(buffer);
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 	bool state;
 
@@ -911,19 +911,19 @@ static const struct iio_chan_spec_ext_info bmc150_accel_ext_info[] = {
 	{ }
 };
 
-static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
-static IIO_CONST_ATTR(hwfifo_watermark_max,
-		      __stringify(BMC150_ACCEL_FIFO_LENGTH));
-static IIO_DEVICE_ATTR(hwfifo_enabled, S_IRUGO,
-		       bmc150_accel_get_fifo_state, NULL, 0);
-static IIO_DEVICE_ATTR(hwfifo_watermark, S_IRUGO,
-		       bmc150_accel_get_fifo_watermark, NULL, 0);
+static IIO_BUF_CONST_ATTR(hwfifo_watermark_min, "1");
+static IIO_BUF_CONST_ATTR(hwfifo_watermark_max,
+			  __stringify(BMC150_ACCEL_FIFO_LENGTH));
+static IIO_BUF_ATTR(hwfifo_enabled, S_IRUGO,
+		    bmc150_accel_get_fifo_state, NULL);
+static IIO_BUF_ATTR(hwfifo_watermark, S_IRUGO,
+		    bmc150_accel_get_fifo_watermark, NULL);
 
 static const struct attribute *bmc150_accel_fifo_attributes[] = {
-	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
-	&iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
-	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
-	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
+	&iio_buf_const_attr_hwfifo_watermark_min.buf_attr.attr,
+	&iio_buf_const_attr_hwfifo_watermark_max.buf_attr.attr,
+	&iio_buf_attr_hwfifo_watermark.attr,
+	&iio_buf_attr_hwfifo_enabled.attr,
 	NULL,
 };
 
diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index a7826f097b95..a573f0d5d0d8 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1610,31 +1610,29 @@ static void at91_adc_hw_init(struct iio_dev *indio_dev)
 	at91_adc_config_emr(st);
 }
 
-static ssize_t at91_adc_get_fifo_state(struct device *dev,
-				       struct device_attribute *attr, char *buf)
+static ssize_t at91_adc_get_fifo_state(struct iio_buffer *buffer,
+				       struct iio_buf_attr *attr, char *buf)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = iio_buffer_get_iio_dev(buffer);
 	struct at91_adc_state *st = iio_priv(indio_dev);
 
 	return scnprintf(buf, PAGE_SIZE, "%d\n", !!st->dma_st.dma_chan);
 }
 
-static ssize_t at91_adc_get_watermark(struct device *dev,
-				      struct device_attribute *attr, char *buf)
+static ssize_t at91_adc_get_watermark(struct iio_buffer *buffer,
+				      struct iio_buf_attr *attr, char *buf)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = iio_buffer_get_iio_dev(buffer);
 	struct at91_adc_state *st = iio_priv(indio_dev);
 
 	return scnprintf(buf, PAGE_SIZE, "%d\n", st->dma_st.watermark);
 }
 
-static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
-		       at91_adc_get_fifo_state, NULL, 0);
-static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
-		       at91_adc_get_watermark, NULL, 0);
+static IIO_BUF_ATTR(hwfifo_enabled, 0444, at91_adc_get_fifo_state, NULL);
+static IIO_BUF_ATTR(hwfifo_watermark, 0444, at91_adc_get_watermark, NULL);
 
-static IIO_CONST_ATTR(hwfifo_watermark_min, "2");
-static IIO_CONST_ATTR(hwfifo_watermark_max, AT91_HWFIFO_MAX_SIZE_STR);
+static IIO_BUF_CONST_ATTR(hwfifo_watermark_min, "2");
+static IIO_BUF_CONST_ATTR(hwfifo_watermark_max, AT91_HWFIFO_MAX_SIZE_STR);
 
 static IIO_CONST_ATTR(oversampling_ratio_available,
 		      __stringify(AT91_OSR_1SAMPLES) " "
@@ -1651,10 +1649,10 @@ static const struct attribute_group at91_adc_attribute_group = {
 };
 
 static const struct attribute *at91_adc_fifo_attributes[] = {
-	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
-	&iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
-	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
-	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
+	&iio_buf_const_attr_hwfifo_watermark_min.buf_attr.attr,
+	&iio_buf_const_attr_hwfifo_watermark_max.buf_attr.attr,
+	&iio_buf_attr_hwfifo_watermark.attr,
+	&iio_buf_attr_hwfifo_enabled.attr,
 	NULL,
 };
 
diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index b0cb9a35f5cd..2cd5fd3fe191 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -129,21 +129,20 @@ static const struct iio_dma_buffer_ops iio_dmaengine_default_ops = {
 	.abort = iio_dmaengine_buffer_abort,
 };
 
-static ssize_t iio_dmaengine_buffer_get_length_align(struct device *dev,
-	struct device_attribute *attr, char *buf)
+static ssize_t iio_dmaengine_buffer_get_length_align(struct iio_buffer *buffer,
+	struct iio_buf_attr *attr, char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct dmaengine_buffer *dmaengine_buffer =
-		iio_buffer_to_dmaengine_buffer(indio_dev->buffer);
+		iio_buffer_to_dmaengine_buffer(buffer);
 
 	return sprintf(buf, "%zu\n", dmaengine_buffer->align);
 }
 
-static IIO_DEVICE_ATTR(length_align_bytes, 0444,
-		       iio_dmaengine_buffer_get_length_align, NULL, 0);
+static IIO_BUF_ATTR(length_align_bytes, 0444,
+		    iio_dmaengine_buffer_get_length_align, NULL);
 
 static const struct attribute *iio_dmaengine_buffer_attrs[] = {
-	&iio_dev_attr_length_align_bytes.dev_attr.attr,
+	&iio_buf_attr_length_align_bytes.attr,
 	NULL,
 };
 
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 4e7b3bc187c9..99f2f9146fab 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -116,11 +116,11 @@ static int cros_ec_sensor_set_ec_rate(struct cros_ec_sensors_core_state *st,
 	return ret;
 }
 
-static ssize_t cros_ec_sensor_set_report_latency(struct device *dev,
-						 struct device_attribute *attr,
+static ssize_t cros_ec_sensor_set_report_latency(struct iio_buffer *buffer,
+						 struct iio_buf_attr *attr,
 						 const char *buf, size_t len)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev *indio_dev = iio_buffer_get_iio_dev(buffer);
 	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
 	int integer, fract, ret;
 	int latency;
@@ -138,11 +138,11 @@ static ssize_t cros_ec_sensor_set_report_latency(struct device *dev,
 	return len;
 }
 
-static ssize_t cros_ec_sensor_get_report_latency(struct device *dev,
-						 struct device_attribute *attr,
+static ssize_t cros_ec_sensor_get_report_latency(struct iio_buffer *buffer,
+						 struct iio_buf_attr *attr,
 						 char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev *indio_dev = iio_buffer_get_iio_dev(buffer);
 	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
 	int latency, ret;
 
@@ -161,25 +161,25 @@ static ssize_t cros_ec_sensor_get_report_latency(struct device *dev,
 		       (latency % 1000) * 1000);
 }
 
-static IIO_DEVICE_ATTR(hwfifo_timeout, 0644,
-		       cros_ec_sensor_get_report_latency,
-		       cros_ec_sensor_set_report_latency, 0);
+static IIO_BUF_ATTR(hwfifo_timeout, 0644,
+		    cros_ec_sensor_get_report_latency,
+		    cros_ec_sensor_set_report_latency);
 
-static ssize_t hwfifo_watermark_max_show(struct device *dev,
-					 struct device_attribute *attr,
+static ssize_t hwfifo_watermark_max_show(struct iio_buffer *buffer,
+					 struct iio_buf_attr *attr,
 					 char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev *indio_dev = iio_buffer_get_iio_dev(buffer);
 	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
 
 	return sprintf(buf, "%d\n", st->fifo_max_event_count);
 }
 
-static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
+static IIO_BUF_ATTR(hwfifo_watermark_max, 0444, hwfifo_watermark_max_show, NULL);
 
 static const struct attribute *cros_ec_sensor_fifo_attributes[] = {
-	&iio_dev_attr_hwfifo_timeout.dev_attr.attr,
-	&iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
+	&iio_buf_attr_hwfifo_timeout.attr,
+	&iio_buf_attr_hwfifo_watermark_max.attr,
 	NULL,
 };
 
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 064c32bec9c7..c04dca7a457b 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -19,11 +19,11 @@
 #include <linux/iio/sysfs.h>
 #include "hid-sensor-trigger.h"
 
-static ssize_t _hid_sensor_set_report_latency(struct device *dev,
-					      struct device_attribute *attr,
+static ssize_t _hid_sensor_set_report_latency(struct iio_buffer *buffer,
+					      struct iio_buf_attr *attr,
 					      const char *buf, size_t len)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev *indio_dev = iio_buffer_get_iio_dev(buffer);
 	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
 	int integer, fract, ret;
 	int latency;
@@ -42,11 +42,11 @@ static ssize_t _hid_sensor_set_report_latency(struct device *dev,
 	return len;
 }
 
-static ssize_t _hid_sensor_get_report_latency(struct device *dev,
-					      struct device_attribute *attr,
+static ssize_t _hid_sensor_get_report_latency(struct iio_buffer *buffer,
+					      struct iio_buf_attr *attr,
 					      char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev *indio_dev = iio_buffer_get_iio_dev(buffer);
 	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
 	int latency;
 
@@ -57,11 +57,11 @@ static ssize_t _hid_sensor_get_report_latency(struct device *dev,
 	return sprintf(buf, "%d.%06u\n", latency / 1000, (latency % 1000) * 1000);
 }
 
-static ssize_t _hid_sensor_get_fifo_state(struct device *dev,
-					  struct device_attribute *attr,
+static ssize_t _hid_sensor_get_fifo_state(struct iio_buffer *buffer,
+					  struct iio_buf_attr *attr,
 					  char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev *indio_dev = iio_buffer_get_iio_dev(buffer);
 	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
 	int latency;
 
@@ -72,15 +72,15 @@ static ssize_t _hid_sensor_get_fifo_state(struct device *dev,
 	return sprintf(buf, "%d\n", !!latency);
 }
 
-static IIO_DEVICE_ATTR(hwfifo_timeout, 0644,
-		       _hid_sensor_get_report_latency,
-		       _hid_sensor_set_report_latency, 0);
-static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
-		       _hid_sensor_get_fifo_state, NULL, 0);
+static IIO_BUF_ATTR(hwfifo_timeout, 0644,
+		    _hid_sensor_get_report_latency,
+		    _hid_sensor_set_report_latency);
+static IIO_BUF_ATTR(hwfifo_enabled, 0444,
+		    _hid_sensor_get_fifo_state, NULL);
 
 static const struct attribute *hid_sensor_fifo_attributes[] = {
-	&iio_dev_attr_hwfifo_timeout.dev_attr.attr,
-	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
+	&iio_buf_attr_hwfifo_timeout.attr,
+	&iio_buf_attr_hwfifo_enabled.attr,
 	NULL,
 };
 
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index a2dd30567072..887c71272e9c 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -26,31 +26,19 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/buffer_impl.h>
 
-/**
- * struct iio_buf_attr - iio buffer specific attribute
- * @attr:	underlying attribute
- * @address:	associated register address
- * @l:		list head for maintaining list of dynamically created attrs
- * @c:		specification for the underlying channel
- * @show:	sysfs show hook for this attribute
- * @store:	sysfs store hook for this attribute
- */
-struct iio_buf_attr {
-	struct attribute attr;
-	u64 address;
-	struct list_head l;
-	struct iio_chan_spec const *c;
-	ssize_t (*show)(struct iio_buffer *buffer, struct iio_buf_attr *attr,
-			char *buf);
-	ssize_t (*store)(struct iio_buffer *buffer, struct iio_buf_attr *attr,
-			 const char *buf, size_t count);
-};
-
 static const char * const iio_endian_prefix[] = {
 	[IIO_BE] = "be",
 	[IIO_LE] = "le",
 };
 
+ssize_t iio_read_buf_const_attr(struct iio_buffer *buffer,
+				struct iio_buf_attr *attr,
+				char *buf)
+{
+	return sprintf(buf, "%s\n", to_iio_buf_const_attr(attr)->string);
+}
+EXPORT_SYMBOL(iio_read_buf_const_attr);
+
 static bool iio_buffer_is_active(struct iio_buffer *buf)
 {
 	return !list_empty(&buf->buffer_list);
@@ -1300,10 +1288,6 @@ static ssize_t iio_dma_show_data_available(struct iio_buffer *buffer,
 	return sprintf(buf, "%zu\n", iio_buffer_data_available(buffer));
 }
 
-#define IIO_BUF_ATTR(_name, _mode, _show, _store)	\
-	struct iio_buf_attr iio_buf_attr_##_name =	\
-		__ATTR(_name, _mode, _show, _store)
-
 static IIO_BUF_ATTR(length, S_IRUGO | S_IWUSR,
 		    iio_buffer_read_length, iio_buffer_write_length);
 static struct iio_buf_attr buf_attr_length_ro = __ATTR(length,
@@ -1324,39 +1308,14 @@ static struct attribute *iio_buffer_attrs[] = {
 	&iio_buf_attr_data_available.attr,
 };
 
-static bool iio_buffer_attr_is_core(struct attribute *attr)
-{
-	struct attribute *a;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(iio_buffer_attrs); i++) {
-		a = iio_buffer_attrs[i];
-		if (!strcmp(attr->name, a->name))
-			return true;
-	}
-
-	return false;
-}
-
-#define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
-#define to_iio_buf_attr(_attr) container_of(_attr, struct iio_buf_attr, attr)
-
 static ssize_t iio_buffer_dir_attr_show(struct kobject *kobj,
 					struct attribute *attr,
 					char *buf)
 {
 	struct iio_buffer *buffer = container_of(kobj, struct iio_buffer, buffer_dir);
-	struct device_attribute *dattr;
-	struct iio_buf_attr *battr;
-
-	if (iio_buffer_attr_is_core(attr)) {
-		battr = to_iio_buf_attr(attr);
-		return battr->show(buffer, battr, buf);
-	}
-
-	dattr = to_dev_attr(attr);
+	struct iio_buf_attr *battr = to_iio_buf_attr(attr);
 
-	return dattr->show(&buffer->indio_dev->dev, dattr, buf);
+	return battr->show(buffer, battr, buf);
 }
 
 static ssize_t iio_buffer_dir_attr_store(struct kobject *kobj,
@@ -1365,17 +1324,9 @@ static ssize_t iio_buffer_dir_attr_store(struct kobject *kobj,
 					 size_t len)
 {
 	struct iio_buffer *buffer = container_of(kobj, struct iio_buffer, buffer_dir);
-	struct device_attribute *dattr;
-	struct iio_buf_attr *battr;
-
-	if (iio_buffer_attr_is_core(attr)) {
-		battr = to_iio_buf_attr(attr);
-		return battr->store(buffer, battr, buf, len);
-	}
-
-	dattr = to_dev_attr(attr);
+	struct iio_buf_attr *battr = to_iio_buf_attr(attr);
 
-	return dattr->store(&buffer->indio_dev->dev, dattr, buf, len);
+	return battr->store(buffer, battr, buf, len);
 }
 
 static const struct sysfs_ops iio_buffer_dir_sysfs_ops = {
diff --git a/include/linux/iio/sysfs.h b/include/linux/iio/sysfs.h
index b532c875bc24..d25b47971c09 100644
--- a/include/linux/iio/sysfs.h
+++ b/include/linux/iio/sysfs.h
@@ -9,6 +9,7 @@
 #ifndef _INDUSTRIAL_IO_SYSFS_H_
 #define _INDUSTRIAL_IO_SYSFS_H_
 
+struct iio_buffer;
 struct iio_chan_spec;
 
 /**
@@ -28,6 +29,55 @@ struct iio_dev_attr {
 #define to_iio_dev_attr(_dev_attr)				\
 	container_of(_dev_attr, struct iio_dev_attr, dev_attr)
 
+/**
+ * struct iio_buf_attr - iio buffer specific attribute
+ * @attr:	underlying attribute
+ * @address:	associated register address
+ * @l:		list head for maintaining list of dynamically created attrs
+ * @c:		specification for the underlying channel
+ * @show:	sysfs show hook for this attribute
+ * @store:	sysfs store hook for this attribute
+ */
+struct iio_buf_attr {
+	struct attribute attr;
+	u64 address;
+	struct list_head l;
+	struct iio_chan_spec const *c;
+	ssize_t (*show)(struct iio_buffer *buffer, struct iio_buf_attr *attr,
+			char *buf);
+	ssize_t (*store)(struct iio_buffer *buffer, struct iio_buf_attr *attr,
+			 const char *buf, size_t count);
+};
+
+/**
+ * struct iio_buf_const_attr - constant buffer specific attribute
+ *                         often used for things constant parameters of buffers
+ * @string:	attribute string
+ * @buf_attr:	underlying buffer attribute
+ */
+struct iio_buf_const_attr {
+	const char *string;
+	struct iio_buf_attr buf_attr;
+};
+
+#define to_iio_buf_attr(_attr) container_of(_attr, struct iio_buf_attr, attr)
+
+#define IIO_BUF_ATTR(_name, _mode, _show, _store)	\
+	struct iio_buf_attr iio_buf_attr_##_name =	\
+		__ATTR(_name, _mode, _show, _store)
+
+#define IIO_BUF_CONST_ATTR(_name, _string)				\
+	struct iio_buf_const_attr iio_buf_const_attr_##_name		\
+	= { .string = _string,						\
+	    .buf_attr = __ATTR(_name, 0444, iio_read_buf_const_attr, NULL)}
+
+#define to_iio_buf_const_attr(_buf_attr) \
+	container_of(_buf_attr, struct iio_buf_const_attr, buf_attr)
+
+ssize_t iio_read_buf_const_attr(struct iio_buffer *buffer,
+				struct iio_buf_attr *attr,
+				char *len);
+
 ssize_t iio_read_const_attr(struct device *dev,
 			    struct device_attribute *attr,
 			    char *len);
-- 
2.17.1

