Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59DC627CE32
	for <lists+linux-iio@lfdr.de>; Tue, 29 Sep 2020 14:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgI2Mzp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Sep 2020 08:55:45 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:42772 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729141AbgI2Mzm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Sep 2020 08:55:42 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08TCtCIZ007691;
        Tue, 29 Sep 2020 08:55:34 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 33syg63548-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 08:55:34 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 08TCtXlJ009266
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 29 Sep 2020 08:55:33 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 29 Sep
 2020 08:55:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 29 Sep 2020 08:55:25 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08TCtIuQ024384;
        Tue, 29 Sep 2020 08:55:28 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <eugen.hristev@microchip.com>,
        <nicolas.ferre@microchip.com>, <ludovic.desroches@microchip.com>,
        <bleung@chromium.org>, <enric.balletbo@collabora.com>,
        <groeck@chromium.org>, <srinivas.pandruvada@linux.intel.com>,
        <andy.shevchenko@gmail.com>, <gwendal@chromium.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 3/9] iio: triggered-buffer: add {devm_}iio_triggered_buffer_setup_ext variants
Date:   Tue, 29 Sep 2020 15:59:43 +0300
Message-ID: <20200929125949.69934-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929125949.69934-1-alexandru.ardelean@analog.com>
References: <20200929125949.69934-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_04:2020-09-29,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=2 lowpriorityscore=0
 spamscore=0 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290113
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change adds a parameter to the {devm_}iio_triggered_buffer_setup()
functions to assign the extra sysfs buffer attributes that are typically
assigned via iio_buffer_set_attrs().

The functions also get renamed to iio_triggered_buffer_setup_ext() &
devm_iio_triggered_buffer_setup_ext().
For backwards compatibility the old {devm_}iio_triggered_buffer_setup()
functions are now macros wrap the new (renamed) functions with NULL for the
buffer attrs.

The aim is to remove iio_buffer_set_attrs(), so in the
iio_triggered_buffer_setup_ext() function the attributes are assigned
directly to 'buffer->attrs'.

When adding multiple IIO buffers per IIO device, it can be pretty
cumbersome to first allocate a set of buffers, then to dig them out of IIO
to assign extra attributes (with iio_buffer_set_attrs()).

Naturally, the best way would be to provide them at allocation time, which
is what this change does.

At this moment, buffers allocated with {devm_}iio_triggered_buffer_setup()
are the only ones in mainline IIO to call iio_buffer_set_attrs().

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../buffer/industrialio-triggered-buffer.c    | 31 ++++++++++++-------
 include/linux/iio/triggered_buffer.h          | 23 +++++++++-----
 2 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
index 6c20a83f887e..92b8aea3e063 100644
--- a/drivers/iio/buffer/industrialio-triggered-buffer.c
+++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
@@ -9,18 +9,20 @@
 #include <linux/module.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/buffer_impl.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 
 /**
- * iio_triggered_buffer_setup() - Setup triggered buffer and pollfunc
+ * iio_triggered_buffer_setup_ext() - Setup triggered buffer and pollfunc
  * @indio_dev:		IIO device structure
  * @h:			Function which will be used as pollfunc top half
  * @thread:		Function which will be used as pollfunc bottom half
  * @setup_ops:		Buffer setup functions to use for this device.
  *			If NULL the default setup functions for triggered
  *			buffers will be used.
+ * @buffer_attrs:	Extra sysfs buffer attributes for this IIO buffer
  *
  * This function combines some common tasks which will normally be performed
  * when setting up a triggered buffer. It will allocate the buffer and the
@@ -33,10 +35,11 @@
  * To free the resources allocated by this function call
  * iio_triggered_buffer_cleanup().
  */
-int iio_triggered_buffer_setup(struct iio_dev *indio_dev,
+int iio_triggered_buffer_setup_ext(struct iio_dev *indio_dev,
 	irqreturn_t (*h)(int irq, void *p),
 	irqreturn_t (*thread)(int irq, void *p),
-	const struct iio_buffer_setup_ops *setup_ops)
+	const struct iio_buffer_setup_ops *setup_ops,
+	const struct attribute **buffer_attrs)
 {
 	struct iio_buffer *buffer;
 	int ret;
@@ -67,6 +70,8 @@ int iio_triggered_buffer_setup(struct iio_dev *indio_dev,
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 
+	buffer->attrs = buffer_attrs;
+
 	return 0;
 
 error_kfifo_free:
@@ -74,10 +79,10 @@ int iio_triggered_buffer_setup(struct iio_dev *indio_dev,
 error_ret:
 	return ret;
 }
-EXPORT_SYMBOL(iio_triggered_buffer_setup);
+EXPORT_SYMBOL(iio_triggered_buffer_setup_ext);
 
 /**
- * iio_triggered_buffer_cleanup() - Free resources allocated by iio_triggered_buffer_setup()
+ * iio_triggered_buffer_cleanup() - Free resources allocated by iio_triggered_buffer_setup_ext()
  * @indio_dev: IIO device structure
  */
 void iio_triggered_buffer_cleanup(struct iio_dev *indio_dev)
@@ -92,11 +97,12 @@ static void devm_iio_triggered_buffer_clean(struct device *dev, void *res)
 	iio_triggered_buffer_cleanup(*(struct iio_dev **)res);
 }
 
-int devm_iio_triggered_buffer_setup(struct device *dev,
-				    struct iio_dev *indio_dev,
-				    irqreturn_t (*h)(int irq, void *p),
-				    irqreturn_t (*thread)(int irq, void *p),
-				    const struct iio_buffer_setup_ops *ops)
+int devm_iio_triggered_buffer_setup_ext(struct device *dev,
+					struct iio_dev *indio_dev,
+					irqreturn_t (*h)(int irq, void *p),
+					irqreturn_t (*thread)(int irq, void *p),
+					const struct iio_buffer_setup_ops *ops,
+					const struct attribute **buffer_attrs)
 {
 	struct iio_dev **ptr;
 	int ret;
@@ -108,7 +114,8 @@ int devm_iio_triggered_buffer_setup(struct device *dev,
 
 	*ptr = indio_dev;
 
-	ret = iio_triggered_buffer_setup(indio_dev, h, thread, ops);
+	ret = iio_triggered_buffer_setup_ext(indio_dev, h, thread, ops,
+					     buffer_attrs);
 	if (!ret)
 		devres_add(dev, ptr);
 	else
@@ -116,7 +123,7 @@ int devm_iio_triggered_buffer_setup(struct device *dev,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(devm_iio_triggered_buffer_setup);
+EXPORT_SYMBOL_GPL(devm_iio_triggered_buffer_setup_ext);
 
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_DESCRIPTION("IIO helper functions for setting up triggered buffers");
diff --git a/include/linux/iio/triggered_buffer.h b/include/linux/iio/triggered_buffer.h
index e99c91799359..7f154d1f8739 100644
--- a/include/linux/iio/triggered_buffer.h
+++ b/include/linux/iio/triggered_buffer.h
@@ -4,19 +4,28 @@
 
 #include <linux/interrupt.h>
 
+struct attribute;
 struct iio_dev;
 struct iio_buffer_setup_ops;
 
-int iio_triggered_buffer_setup(struct iio_dev *indio_dev,
+int iio_triggered_buffer_setup_ext(struct iio_dev *indio_dev,
 	irqreturn_t (*h)(int irq, void *p),
 	irqreturn_t (*thread)(int irq, void *p),
-	const struct iio_buffer_setup_ops *setup_ops);
+	const struct iio_buffer_setup_ops *setup_ops,
+	const struct attribute **buffer_attrs);
 void iio_triggered_buffer_cleanup(struct iio_dev *indio_dev);
 
-int devm_iio_triggered_buffer_setup(struct device *dev,
-				    struct iio_dev *indio_dev,
-				    irqreturn_t (*h)(int irq, void *p),
-				    irqreturn_t (*thread)(int irq, void *p),
-				    const struct iio_buffer_setup_ops *ops);
+#define iio_triggered_buffer_setup(indio_dev, h, thread, setup_ops)		\
+	iio_triggered_buffer_setup_ext((indio_dev), (h), (thread), (setup_ops), NULL)
+
+int devm_iio_triggered_buffer_setup_ext(struct device *dev,
+					struct iio_dev *indio_dev,
+					irqreturn_t (*h)(int irq, void *p),
+					irqreturn_t (*thread)(int irq, void *p),
+					const struct iio_buffer_setup_ops *ops,
+					const struct attribute **buffer_attrs);
+
+#define devm_iio_triggered_buffer_setup(dev, indio_dev, h, thread, setup_ops)	\
+	devm_iio_triggered_buffer_setup_ext((dev), (indio_dev), (h), (thread), (setup_ops), NULL)
 
 #endif
-- 
2.17.1

