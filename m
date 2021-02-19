Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6359531F980
	for <lists+linux-iio@lfdr.de>; Fri, 19 Feb 2021 13:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhBSMlX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Feb 2021 07:41:23 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:58178 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230228AbhBSMlU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Feb 2021 07:41:20 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11JCOiIB000345;
        Fri, 19 Feb 2021 07:40:27 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 36p9gbadbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 07:40:27 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 11JCePhm052008
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Feb 2021 07:40:25 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Fri, 19 Feb 2021
 04:40:24 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Fri, 19 Feb 2021 04:40:23 -0800
Received: from saturn.ad.analog.com ([10.48.65.120])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11JCeH4s008911;
        Fri, 19 Feb 2021 07:40:22 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 3/6] iio: triggered-buffer: extend support to configure output buffers
Date:   Fri, 19 Feb 2021 14:40:09 +0200
Message-ID: <20210219124012.92897-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210219124012.92897-1-alexandru.ardelean@analog.com>
References: <20210219124012.92897-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_05:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190101
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Now that output (kfifo) buffers are supported, we need to extend the
{devm_}iio_triggered_buffer_setup_ext() parameter list to take a direction
parameter.

This allows us to attach an output triggered buffer to a DAC device.
Unfortunately it's a bit difficult to add another macro to avoid changing 5
drivers where {devm_}iio_triggered_buffer_setup_ext() is used.
Well, it's doable, but may not be worth the trouble vs just updating all
these 5 drivers.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/accel/adxl372.c                           |  1 +
 drivers/iio/accel/bmc150-accel-core.c                 |  1 +
 drivers/iio/adc/at91-sama5d2_adc.c                    |  4 ++--
 drivers/iio/buffer/industrialio-triggered-buffer.c    |  8 ++++++--
 .../iio/common/cros_ec_sensors/cros_ec_sensors_core.c |  1 +
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c   |  5 +++--
 include/linux/iio/triggered_buffer.h                  | 11 +++++++++--
 7 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 8ba1453b8dbf..f2e077f72531 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -1214,6 +1214,7 @@ int adxl372_probe(struct device *dev, struct regmap *regmap,
 	ret = devm_iio_triggered_buffer_setup_ext(dev,
 						  indio_dev, NULL,
 						  adxl372_trigger_handler,
+						  IIO_BUFFER_DIRECTION_IN,
 						  &adxl372_buffer_ops,
 						  adxl372_fifo_attributes);
 	if (ret < 0)
diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index b0dbd12cbf42..3e0305b0065b 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1743,6 +1743,7 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 	ret = iio_triggered_buffer_setup_ext(indio_dev,
 					     &iio_pollfunc_store_time,
 					     bmc150_accel_trigger_handler,
+					     IIO_BUFFER_DIRECTION_IN,
 					     &bmc150_accel_buffer_ops,
 					     fifo_attrs);
 	if (ret < 0) {
diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index a7826f097b95..fc134f9c0200 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1680,8 +1680,8 @@ static int at91_adc_buffer_and_trigger_init(struct device *dev,
 		fifo_attrs = NULL;
 
 	ret = devm_iio_triggered_buffer_setup_ext(&indio->dev, indio,
-		&iio_pollfunc_store_time,
-		&at91_adc_trigger_handler, &at91_buffer_setup_ops, fifo_attrs);
+		&iio_pollfunc_store_time, &at91_adc_trigger_handler,
+		IIO_BUFFER_DIRECTION_IN, &at91_buffer_setup_ops, fifo_attrs);
 	if (ret < 0) {
 		dev_err(dev, "couldn't initialize the buffer.\n");
 		return ret;
diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
index b2b1b7d27af4..f400e978cd1e 100644
--- a/drivers/iio/buffer/industrialio-triggered-buffer.c
+++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
@@ -19,6 +19,7 @@
  * @indio_dev:		IIO device structure
  * @h:			Function which will be used as pollfunc top half
  * @thread:		Function which will be used as pollfunc bottom half
+ * @direction:		Direction of the data stream (in/out).
  * @setup_ops:		Buffer setup functions to use for this device.
  *			If NULL the default setup functions for triggered
  *			buffers will be used.
@@ -38,6 +39,7 @@
 int iio_triggered_buffer_setup_ext(struct iio_dev *indio_dev,
 	irqreturn_t (*h)(int irq, void *p),
 	irqreturn_t (*thread)(int irq, void *p),
+	enum iio_buffer_direction direction,
 	const struct iio_buffer_setup_ops *setup_ops,
 	const struct attribute **buffer_attrs)
 {
@@ -68,6 +70,7 @@ int iio_triggered_buffer_setup_ext(struct iio_dev *indio_dev,
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 
+	buffer->direction = direction;
 	buffer->attrs = buffer_attrs;
 
 	ret = iio_device_attach_buffer(indio_dev, buffer);
@@ -105,6 +108,7 @@ int devm_iio_triggered_buffer_setup_ext(struct device *dev,
 					struct iio_dev *indio_dev,
 					irqreturn_t (*h)(int irq, void *p),
 					irqreturn_t (*thread)(int irq, void *p),
+					enum iio_buffer_direction direction,
 					const struct iio_buffer_setup_ops *ops,
 					const struct attribute **buffer_attrs)
 {
@@ -118,8 +122,8 @@ int devm_iio_triggered_buffer_setup_ext(struct device *dev,
 
 	*ptr = indio_dev;
 
-	ret = iio_triggered_buffer_setup_ext(indio_dev, h, thread, ops,
-					     buffer_attrs);
+	ret = iio_triggered_buffer_setup_ext(indio_dev, h, thread, direction,
+					     ops, buffer_attrs);
 	if (!ret)
 		devres_add(dev, ptr);
 	else
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index f8824afe595e..afe8917f8c49 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -369,6 +369,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 			 */
 			ret = devm_iio_triggered_buffer_setup_ext(
 					dev, indio_dev, NULL, trigger_capture,
+					IIO_BUFFER_DIRECTION_IN,
 					NULL, fifo_attrs);
 			if (ret)
 				return ret;
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 064c32bec9c7..dfaadbcac08a 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -248,8 +248,9 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 		fifo_attrs = NULL;
 
 	ret = iio_triggered_buffer_setup_ext(indio_dev,
-					     &iio_pollfunc_store_time,
-					     NULL, NULL, fifo_attrs);
+					     &iio_pollfunc_store_time, NULL,
+					     IIO_BUFFER_DIRECTION_IN,
+					     NULL, fifo_attrs);
 	if (ret) {
 		dev_err(&indio_dev->dev, "Triggered Buffer Setup Failed\n");
 		return ret;
diff --git a/include/linux/iio/triggered_buffer.h b/include/linux/iio/triggered_buffer.h
index 7f154d1f8739..7490b05fc5b2 100644
--- a/include/linux/iio/triggered_buffer.h
+++ b/include/linux/iio/triggered_buffer.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_IIO_TRIGGERED_BUFFER_H_
 #define _LINUX_IIO_TRIGGERED_BUFFER_H_
 
+#include <linux/iio/buffer.h>
 #include <linux/interrupt.h>
 
 struct attribute;
@@ -11,21 +12,27 @@ struct iio_buffer_setup_ops;
 int iio_triggered_buffer_setup_ext(struct iio_dev *indio_dev,
 	irqreturn_t (*h)(int irq, void *p),
 	irqreturn_t (*thread)(int irq, void *p),
+	enum iio_buffer_direction direction,
 	const struct iio_buffer_setup_ops *setup_ops,
 	const struct attribute **buffer_attrs);
 void iio_triggered_buffer_cleanup(struct iio_dev *indio_dev);
 
 #define iio_triggered_buffer_setup(indio_dev, h, thread, setup_ops)		\
-	iio_triggered_buffer_setup_ext((indio_dev), (h), (thread), (setup_ops), NULL)
+	iio_triggered_buffer_setup_ext((indio_dev), (h), (thread),		\
+					IIO_BUFFER_DIRECTION_IN, (setup_ops),	\
+					NULL)
 
 int devm_iio_triggered_buffer_setup_ext(struct device *dev,
 					struct iio_dev *indio_dev,
 					irqreturn_t (*h)(int irq, void *p),
 					irqreturn_t (*thread)(int irq, void *p),
+					enum iio_buffer_direction direction,
 					const struct iio_buffer_setup_ops *ops,
 					const struct attribute **buffer_attrs);
 
 #define devm_iio_triggered_buffer_setup(dev, indio_dev, h, thread, setup_ops)	\
-	devm_iio_triggered_buffer_setup_ext((dev), (indio_dev), (h), (thread), (setup_ops), NULL)
+	devm_iio_triggered_buffer_setup_ext((dev), (indio_dev), (h), (thread),	\
+					    IIO_BUFFER_DIRECTION_IN,		\
+					    (setup_ops), NULL)
 
 #endif
-- 
2.27.0

