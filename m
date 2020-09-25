Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA5B2782E1
	for <lists+linux-iio@lfdr.de>; Fri, 25 Sep 2020 10:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbgIYIig (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Sep 2020 04:38:36 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:1356 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727608AbgIYIi3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Sep 2020 04:38:29 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08P8Yirv009417;
        Fri, 25 Sep 2020 04:38:18 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33r5u9f983-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Sep 2020 04:38:18 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08P8cHGH054359
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 25 Sep 2020 04:38:17 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 25 Sep 2020 04:38:14 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 25 Sep 2020 04:38:14 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 25 Sep 2020 04:38:14 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08P8c5uI006205;
        Fri, 25 Sep 2020 04:38:12 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 5/5] iio: remove iio_buffer_set_attrs() and assign buffer attrs during alloc
Date:   Fri, 25 Sep 2020 11:37:43 +0300
Message-ID: <20200925083743.46469-6-alexandru.ardelean@analog.com>
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

The iio_buffer_set_attrs() function needn't necessarily be removed, but
rather hidden inside IIO core.[1]
However, if doing that, then it's almost no reason not to remove it.

This change moves the HW FIFO buffer attributes as a parameter of
{devm_}iio_triggered_buffer_setup().
This makes it clear to which IIO buffer these attributes are bound to.

One minor downside (also related to point [1]) is that
'linux/iio/buffer_impl.h' needs to be included in
'industrialio-triggered-buffer.c' to be able to access the 'attrs' field of
the buffer. This is also because there is no clear place where to place
iio_buffer_set_attrs() inside IIO core.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/accel/adxl372.c                   |  5 ++--
 drivers/iio/accel/bmc150-accel-core.c         | 19 ++++++++------
 drivers/iio/adc/at91-sama5d2_adc.c            | 25 +++++++++++--------
 .../buffer/industrialio-triggered-buffer.c    |  3 ++-
 .../cros_ec_sensors/cros_ec_sensors_core.c    | 13 ++++++----
 .../common/hid-sensors/hid-sensor-trigger.c   | 19 ++++++--------
 drivers/iio/industrialio-buffer.c             | 12 ---------
 include/linux/iio/buffer.h                    |  3 ---
 8 files changed, 45 insertions(+), 54 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 0c0de7f47815..6214dae6c1a2 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -1214,12 +1214,11 @@ int adxl372_probe(struct device *dev, struct regmap *regmap,
 	ret = devm_iio_triggered_buffer_setup(dev,
 					      indio_dev, NULL,
 					      adxl372_trigger_handler,
-					      &adxl372_buffer_ops, NULL);
+					      &adxl372_buffer_ops,
+					      adxl372_fifo_attributes);
 	if (ret < 0)
 		return ret;
 
-	iio_buffer_set_attrs(indio_dev->buffer, adxl372_fifo_attributes);
-
 	if (st->irq) {
 		st->dready_trig = devm_iio_trigger_alloc(dev,
 							 "%s-dev%d",
diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index fe3aa6554c23..768c96dc94fb 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1558,6 +1558,7 @@ static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
 int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 			    const char *name, bool block_supported)
 {
+	const struct attribute **fifo_attrs;
 	struct bmc150_accel_data *data;
 	struct iio_dev *indio_dev;
 	int ret;
@@ -1590,10 +1591,19 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bmc150_accel_info;
 
+	if (block_supported) {
+		indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
+		indio_dev->info = &bmc150_accel_info_fifo;
+		fifo_attrs = bmc150_accel_fifo_attributes;
+	} else {
+		fifo_attrs = NULL;
+	}
+
 	ret = iio_triggered_buffer_setup(indio_dev,
 					 &iio_pollfunc_store_time,
 					 bmc150_accel_trigger_handler,
-					 &bmc150_accel_buffer_ops, NULL);
+					 &bmc150_accel_buffer_ops,
+					 fifo_attrs);
 	if (ret < 0) {
 		dev_err(dev, "Failed: iio triggered buffer setup\n");
 		return ret;
@@ -1628,13 +1638,6 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 		ret = bmc150_accel_triggers_setup(indio_dev, data);
 		if (ret)
 			goto err_buffer_cleanup;
-
-		if (block_supported) {
-			indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
-			indio_dev->info = &bmc150_accel_info_fifo;
-			iio_buffer_set_attrs(indio_dev->buffer,
-					     bmc150_accel_fifo_attributes);
-		}
 	}
 
 	ret = pm_runtime_set_active(dev);
diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 89a18184b59a..3a234682fc87 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1156,13 +1156,6 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-static int at91_adc_buffer_init(struct iio_dev *indio)
-{
-	return devm_iio_triggered_buffer_setup(&indio->dev, indio,
-		&iio_pollfunc_store_time,
-		&at91_adc_trigger_handler, &at91_buffer_setup_ops, NULL);
-}
-
 static unsigned at91_adc_startup_time(unsigned startup_time_min,
 				      unsigned adc_clk_khz)
 {
@@ -1683,6 +1676,21 @@ static const struct iio_info at91_adc_info = {
 	.hwfifo_set_watermark = &at91_adc_set_watermark,
 };
 
+static int at91_adc_buffer_init(struct iio_dev *indio)
+{
+	const struct attribute **fifo_attrs;
+	struct at91_adc_state *st = iio_priv(indio);
+
+	if (st->selected_trig->hw_trig)
+		fifo_attrs = at91_adc_fifo_attributes;
+	else
+		fifo_attrs = NULL;
+
+	return devm_iio_triggered_buffer_setup(&indio->dev, indio,
+		&iio_pollfunc_store_time,
+		&at91_adc_trigger_handler, &at91_buffer_setup_ops, fifo_attrs);
+}
+
 static int at91_adc_probe(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev;
@@ -1835,9 +1843,6 @@ static int at91_adc_probe(struct platform_device *pdev)
 		 * a watermark of 1
 		 */
 		st->dma_st.watermark = 1;
-
-		iio_buffer_set_attrs(indio_dev->buffer,
-				     at91_adc_fifo_attributes);
 	}
 
 	if (dma_coerce_mask_and_coherent(&indio_dev->dev, DMA_BIT_MASK(32)))
diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
index b79acdc623b7..2e8af526ddaa 100644
--- a/drivers/iio/buffer/industrialio-triggered-buffer.c
+++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/buffer_impl.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
@@ -69,7 +70,7 @@ int iio_triggered_buffer_setup(struct iio_dev *indio_dev,
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 
-	iio_buffer_set_attrs(buffer, buffer_attrs);
+	buffer->attrs = buffer_attrs;
 
 	return 0;
 
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 678cb9ad9e29..093adb7da5d6 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -353,19 +353,22 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 			if (ret)
 				return ret;
 		} else {
+			const struct attribute **fifo_attrs;
+
+			if (has_hw_fifo)
+				fifo_attrs = cros_ec_sensor_fifo_attributes;
+			else
+				fifo_attrs = NULL;
+
 			/*
 			 * The only way to get samples in buffer is to set a
 			 * software trigger (systrig, hrtimer).
 			 */
 			ret = devm_iio_triggered_buffer_setup(
 					dev, indio_dev, NULL, trigger_capture,
-					NULL, NULL);
+					NULL, fifo_attrs);
 			if (ret)
 				return ret;
-
-			if (has_hw_fifo)
-				iio_buffer_set_attrs(indio_dev->buffer,
-						     cros_ec_sensor_fifo_attributes);
 		}
 	}
 
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 2f1cf242c156..eb875ac4bd29 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -84,15 +84,6 @@ static const struct attribute *hid_sensor_fifo_attributes[] = {
 	NULL,
 };
 
-static void hid_sensor_setup_batch_mode(struct iio_dev *indio_dev,
-					struct hid_sensor_common *st)
-{
-	if (!hid_sensor_batch_mode_supported(st))
-		return;
-
-	iio_buffer_set_attrs(indio_dev->buffer, hid_sensor_fifo_attributes);
-}
-
 static int _hid_sensor_power_state(struct hid_sensor_common *st, bool state)
 {
 	int state_val;
@@ -247,11 +238,17 @@ static const struct iio_trigger_ops hid_sensor_trigger_ops = {
 int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 				struct hid_sensor_common *attrb)
 {
+	const struct attribute **fifo_attrs;
 	int ret;
 	struct iio_trigger *trig;
 
+	if (hid_sensor_batch_mode_supported(attrb))
+		fifo_attrs = hid_sensor_fifo_attributes;
+	else
+		fifo_attrs = NULL;
+
 	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
-					 NULL, NULL, NULL);
+					 NULL, NULL, fifo_attrs);
 	if (ret) {
 		dev_err(&indio_dev->dev, "Triggered Buffer Setup Failed\n");
 		return ret;
@@ -276,8 +273,6 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 	attrb->trigger = trig;
 	indio_dev->trig = iio_trigger_get(trig);
 
-	hid_sensor_setup_batch_mode(indio_dev, attrb);
-
 	ret = pm_runtime_set_active(&indio_dev->dev);
 	if (ret)
 		goto error_unreg_trigger;
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index a4f6bb96d4f4..9663dec3dcf3 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -210,18 +210,6 @@ void iio_buffer_init(struct iio_buffer *buffer)
 }
 EXPORT_SYMBOL(iio_buffer_init);
 
-/**
- * iio_buffer_set_attrs - Set buffer specific attributes
- * @buffer: The buffer for which we are setting attributes
- * @attrs: Pointer to a null terminated list of pointers to attributes
- */
-void iio_buffer_set_attrs(struct iio_buffer *buffer,
-			 const struct attribute **attrs)
-{
-	buffer->attrs = attrs;
-}
-EXPORT_SYMBOL_GPL(iio_buffer_set_attrs);
-
 static ssize_t iio_show_scan_index(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index fbba4093f06c..8febc23f5f26 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -11,9 +11,6 @@
 
 struct iio_buffer;
 
-void iio_buffer_set_attrs(struct iio_buffer *buffer,
-			 const struct attribute **attrs);
-
 int iio_push_to_buffers(struct iio_dev *indio_dev, const void *data);
 
 /**
-- 
2.17.1

