Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B573F31D9
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 19:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhHTRBy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 13:01:54 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:50102 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232659AbhHTRBx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 13:01:53 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17KDkh2m004350;
        Fri, 20 Aug 2021 13:01:05 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3ajdjwrppe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 13:01:05 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 17KH13rn019204
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Aug 2021 13:01:03 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Fri, 20 Aug 2021
 13:01:03 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Fri, 20 Aug 2021 13:01:02 -0400
Received: from ubuntuservermchindri.ad.analog.com ([10.32.225.46])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 17KH0YNQ013729;
        Fri, 20 Aug 2021 13:01:00 -0400
From:   Mihail Chindris <mihail.chindris@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <alexandru.ardelean@analog.com>
Subject: [PATCH v4 3/6] iio: triggered-buffer: extend support to configure output buffers
Date:   Fri, 20 Aug 2021 16:59:24 +0000
Message-ID: <20210820165927.4524-4-mihail.chindris@analog.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210820165927.4524-1-mihail.chindris@analog.com>
References: <20210820165927.4524-1-mihail.chindris@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: TyfrGdqq7D--2JYVVgux5Ynkl0Edb-oX
X-Proofpoint-GUID: TyfrGdqq7D--2JYVVgux5Ynkl0Edb-oX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-20_06,2021-08-20_03,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108200095
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

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
 .../iio/common/cros_ec_sensors/cros_ec_sensors_core.c |  5 +++--
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c   |  5 +++--
 include/linux/iio/triggered_buffer.h                  | 11 +++++++++--
 7 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index fc9592407717..758952584f8c 100644
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
index e8693a42ad46..63216321cdb5 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1734,6 +1734,7 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 	ret = iio_triggered_buffer_setup_ext(indio_dev,
 					     &iio_pollfunc_store_time,
 					     bmc150_accel_trigger_handler,
+					     IIO_BUFFER_DIRECTION_IN,
 					     &bmc150_accel_buffer_ops,
 					     fifo_attrs);
 	if (ret < 0) {
diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index ea5ca163d879..7093611e321e 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1681,8 +1681,8 @@ static int at91_adc_buffer_and_trigger_init(struct device *dev,
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
index f77c4538141e..8d4fc97d1005 100644
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
@@ -105,13 +108,14 @@ int devm_iio_triggered_buffer_setup_ext(struct device *dev,
 					struct iio_dev *indio_dev,
 					irqreturn_t (*h)(int irq, void *p),
 					irqreturn_t (*thread)(int irq, void *p),
+					enum iio_buffer_direction direction,
 					const struct iio_buffer_setup_ops *ops,
 					const struct attribute **buffer_attrs)
 {
 	int ret;
 
-	ret = iio_triggered_buffer_setup_ext(indio_dev, h, thread, ops,
-					     buffer_attrs);
+	ret = iio_triggered_buffer_setup_ext(indio_dev, h, thread, direction,
+					     ops, buffer_attrs);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 28bde13003b7..e9f64da06f89 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -360,8 +360,9 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 			 * The only way to get samples in buffer is to set a
 			 * software trigger (systrig, hrtimer).
 			 */
-			ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-					NULL, trigger_capture, NULL);
+			ret = devm_iio_triggered_buffer_setup_ext(dev,
+					indio_dev, NULL, trigger_capture,
+					IIO_BUFFER_DIRECTION_IN, NULL);
 			if (ret)
 				return ret;
 		}
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index a4ec11a3b68a..1151434038d4 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -241,8 +241,9 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
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

