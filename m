Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33C831B771
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 11:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhBOKk2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 05:40:28 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:1716 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230219AbhBOKkJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2021 05:40:09 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11FAZkTq028471;
        Mon, 15 Feb 2021 05:39:18 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36pcjamakc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 05:39:17 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11FAdGTg023159
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 15 Feb 2021 05:39:16 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 15 Feb
 2021 05:39:15 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 15 Feb 2021 05:39:15 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11FAcQUl017530;
        Mon, 15 Feb 2021 05:39:12 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v6 18/24] iio: dummy: iio_simple_dummy_buffer: use triggered buffer core calls
Date:   Mon, 15 Feb 2021 12:40:37 +0200
Message-ID: <20210215104043.91251-19-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210215104043.91251-1-alexandru.ardelean@analog.com>
References: <20210215104043.91251-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-15_03:2021-02-12,2021-02-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102150087
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The iio_simple_dummy_configure_buffer() function is essentially a
re-implementation of the iio_triggered_buffer_setup() function.

This change makes use of the iio_triggered_buffer_setup() function. The
reason is so that we don't have to modify the iio_device_attach_buffer()
function in this driver as well.

One minor drawback is that the pollfunc name may not be 100% identical
with the one in the original code, but since it's an example, it should be
a big problem.

This change does a minor re-arranging of the included iio headers, as a
minor tidy-up.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/dummy/iio_simple_dummy_buffer.c | 68 ++-------------------
 1 file changed, 6 insertions(+), 62 deletions(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/iio/dummy/iio_simple_dummy_buffer.c
index 5512d5edc707..59aa60d4ca37 100644
--- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
+++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
@@ -16,9 +16,9 @@
 #include <linux/bitmap.h>
 
 #include <linux/iio/iio.h>
-#include <linux/iio/trigger_consumer.h>
 #include <linux/iio/buffer.h>
-#include <linux/iio/kfifo_buf.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #include "iio_simple_dummy.h"
 
@@ -103,64 +103,9 @@ static const struct iio_buffer_setup_ops iio_simple_dummy_buffer_setup_ops = {
 
 int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev)
 {
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
+	return iio_triggered_buffer_setup(indio_dev, NULL,
+					  iio_simple_dummy_trigger_h,
+					  &iio_simple_dummy_buffer_setup_ops);
 }
 
 /**
@@ -169,6 +114,5 @@ int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev)
  */
 void iio_simple_dummy_unconfigure_buffer(struct iio_dev *indio_dev)
 {
-	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_kfifo_free(indio_dev->buffer);
+	iio_triggered_buffer_cleanup(indio_dev);
 }
-- 
2.17.1

