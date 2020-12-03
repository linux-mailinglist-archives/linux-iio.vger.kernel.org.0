Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC982CD2E7
	for <lists+linux-iio@lfdr.de>; Thu,  3 Dec 2020 10:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbgLCJu7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Dec 2020 04:50:59 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:11812 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730201AbgLCJu6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Dec 2020 04:50:58 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B39UIM8020964;
        Thu, 3 Dec 2020 04:50:16 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 355vjen8ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 04:50:16 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0B39oFup007861
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 3 Dec 2020 04:50:15 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 3 Dec 2020 04:50:14 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 3 Dec 2020 04:50:14 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 3 Dec 2020 04:50:14 -0500
Received: from saturn.ad.analog.com ([10.48.65.108])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0B39o9EC002710;
        Thu, 3 Dec 2020 04:50:12 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 3/3] iio: dummy: use devm_iio_triggered_buffer_setup() for buffer setup
Date:   Thu, 3 Dec 2020 11:50:05 +0200
Message-ID: <20201203095005.72252-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201203095005.72252-1-alexandru.ardelean@analog.com>
References: <20201203095005.72252-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_06:2020-12-03,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030058
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The iio_simple_dummy_configure_buffer() function is pretty much just the
iio_triggered_buffer_setup() function.
This change makes use of the devm_iio_triggered_buffer_setup() directly so
that we can tie the life-time and unwinding to the same parent object in
the probe function.

With this, the devm_iio_device_register() can be used directly in the probe
function, removing the iio_dummy_remove() function entirely.

One side-effect that is negligible for this driver is that the name of
the poll-function gets changed from 'iio_simple_dummy_consumer%d' to
'%s_consumer%d' where %s is 'indio_dev->name'.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/dummy/iio_simple_dummy.c        | 37 +---------
 drivers/iio/dummy/iio_simple_dummy.h        | 11 +--
 drivers/iio/dummy/iio_simple_dummy_buffer.c | 78 ++-------------------
 3 files changed, 13 insertions(+), 113 deletions(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
index a746b34ae7a3..06baa356e264 100644
--- a/drivers/iio/dummy/iio_simple_dummy.c
+++ b/drivers/iio/dummy/iio_simple_dummy.c
@@ -630,47 +630,17 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
 	if (ret < 0)
 		return ERR_PTR(ret);
 
-	ret = iio_simple_dummy_configure_buffer(indio_dev);
+	ret = iio_simple_dummy_configure_buffer(parent, indio_dev);
 	if (ret < 0)
 		return ERR_PTR(ret);
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(parent, indio_dev);
 	if (ret < 0)
-		goto error_unconfigure_buffer;
+		return ERR_PTR(ret);
 
 	iio_swd_group_init_type_name(swd, name, &iio_dummy_type);
 
 	return swd;
-error_unconfigure_buffer:
-	iio_simple_dummy_unconfigure_buffer(indio_dev);
-	return ERR_PTR(ret);
-}
-
-/**
- * iio_dummy_remove() - device instance removal function
- * @swd: pointer to software IIO device abstraction
- *
- * Parameters follow those of iio_dummy_probe for buses.
- */
-static int iio_dummy_remove(struct iio_sw_device *swd)
-{
-	/*
-	 * Get a pointer to the device instance iio_dev structure
-	 * from the bus subsystem. E.g.
-	 * struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	 * struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	 */
-	struct iio_dev *indio_dev = swd->device;
-
-	/* Unregister the device */
-	iio_device_unregister(indio_dev);
-
-	/* Device specific code to power down etc */
-
-	/* Buffered capture related cleanup */
-	iio_simple_dummy_unconfigure_buffer(indio_dev);
-
-	return 0;
 }
 
 /*
@@ -685,7 +655,6 @@ static int iio_dummy_remove(struct iio_sw_device *swd)
  */
 static const struct iio_sw_device_ops iio_dummy_device_ops = {
 	.probe = iio_dummy_probe,
-	.remove = iio_dummy_remove,
 };
 
 static struct iio_sw_device_type iio_dummy_device = {
diff --git a/drivers/iio/dummy/iio_simple_dummy.h b/drivers/iio/dummy/iio_simple_dummy.h
index b1ca6e97ed3f..d4fd16b8691b 100644
--- a/drivers/iio/dummy/iio_simple_dummy.h
+++ b/drivers/iio/dummy/iio_simple_dummy.h
@@ -105,17 +105,12 @@ enum iio_simple_dummy_scan_elements {
 };
 
 #ifdef CONFIG_IIO_SIMPLE_DUMMY_BUFFER
-int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev);
-void iio_simple_dummy_unconfigure_buffer(struct iio_dev *indio_dev);
+int iio_simple_dummy_configure_buffer(struct device *parent, struct iio_dev *indio_dev);
 #else
-static inline int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev)
+static inline int iio_simple_dummy_configure_buffer(struct device *parent,
+						    struct iio_dev *indio_dev)
 {
 	return 0;
 }
-
-static inline
-void iio_simple_dummy_unconfigure_buffer(struct iio_dev *indio_dev)
-{}
-
 #endif /* CONFIG_IIO_SIMPLE_DUMMY_BUFFER */
 #endif /* _IIO_SIMPLE_DUMMY_H_ */
diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/iio/dummy/iio_simple_dummy_buffer.c
index 5512d5edc707..76476b45dc8b 100644
--- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
+++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
@@ -16,9 +16,9 @@
 #include <linux/bitmap.h>
 
 #include <linux/iio/iio.h>
-#include <linux/iio/trigger_consumer.h>
 #include <linux/iio/buffer.h>
-#include <linux/iio/kfifo_buf.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 
 #include "iio_simple_dummy.h"
 
@@ -101,74 +101,10 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 static const struct iio_buffer_setup_ops iio_simple_dummy_buffer_setup_ops = {
 };
 
-int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev)
-{
-	int ret;
-	struct iio_buffer *buffer;
-
-	/* Allocate a buffer to use - here a kfifo */
-	buffer = iio_kfifo_allocate();
-	if (!buffer) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-
-	iio_device_attach_buffer(indio_dev, buffer);
-
-	/*
-	 * Tell the core what device type specific functions should
-	 * be run on either side of buffer capture enable / disable.
-	 */
-	indio_dev->setup_ops = &iio_simple_dummy_buffer_setup_ops;
-
-	/*
-	 * Configure a polling function.
-	 * When a trigger event with this polling function connected
-	 * occurs, this function is run. Typically this grabs data
-	 * from the device.
-	 *
-	 * NULL for the bottom half. This is normally implemented only if we
-	 * either want to ping a capture now pin (no sleeping) or grab
-	 * a timestamp as close as possible to a data ready trigger firing.
-	 *
-	 * IRQF_ONESHOT ensures irqs are masked such that only one instance
-	 * of the handler can run at a time.
-	 *
-	 * "iio_simple_dummy_consumer%d" formatting string for the irq 'name'
-	 * as seen under /proc/interrupts. Remaining parameters as per printk.
-	 */
-	indio_dev->pollfunc = iio_alloc_pollfunc(NULL,
-						 &iio_simple_dummy_trigger_h,
-						 IRQF_ONESHOT,
-						 indio_dev,
-						 "iio_simple_dummy_consumer%d",
-						 indio_dev->id);
-
-	if (!indio_dev->pollfunc) {
-		ret = -ENOMEM;
-		goto error_free_buffer;
-	}
-
-	/*
-	 * Notify the core that this device is capable of buffered capture
-	 * driven by a trigger.
-	 */
-	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
-
-	return 0;
-
-error_free_buffer:
-	iio_kfifo_free(indio_dev->buffer);
-error_ret:
-	return ret;
-}
-
-/**
- * iio_simple_dummy_unconfigure_buffer() - release buffer resources
- * @indio_dev: device instance state
- */
-void iio_simple_dummy_unconfigure_buffer(struct iio_dev *indio_dev)
+int iio_simple_dummy_configure_buffer(struct device *parent, struct iio_dev *indio_dev)
 {
-	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_kfifo_free(indio_dev->buffer);
+	return devm_iio_triggered_buffer_setup(parent, indio_dev,
+					       &iio_simple_dummy_trigger_h,
+					       NULL,
+					       &iio_simple_dummy_buffer_setup_ops);
 }
-- 
2.27.0

