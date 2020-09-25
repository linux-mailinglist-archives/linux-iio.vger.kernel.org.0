Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4642782DB
	for <lists+linux-iio@lfdr.de>; Fri, 25 Sep 2020 10:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgIYIi1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Sep 2020 04:38:27 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:63410 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727044AbgIYIi1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Sep 2020 04:38:27 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08P8atVa006843;
        Fri, 25 Sep 2020 04:38:15 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33r5p6f7u7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Sep 2020 04:38:14 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08P8cCHI054332
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 25 Sep 2020 04:38:13 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 25 Sep 2020 01:38:10 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 25 Sep 2020 01:38:10 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 25 Sep 2020 01:38:10 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08P8c5uG006205;
        Fri, 25 Sep 2020 04:38:10 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 3/5] iio: triggered-buffer: add sysfs buffer attributes as args for setup
Date:   Fri, 25 Sep 2020 11:37:41 +0300
Message-ID: <20200925083743.46469-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200925083743.46469-1-alexandru.ardelean@analog.com>
References: <20200925083743.46469-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-25_02:2020-09-24,2020-09-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 spamscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 suspectscore=2 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250059
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change adds a parameter to the {devm_}iio_triggered_buffer_setup()
functions to assign the extra sysfs buffer attributes that are typically
assigned via iio_buffer_set_attrs().

When adding multiple IIO buffers per IIO device, it can be pretty
cumbersome to first allocate a set of buffers, then to dig them out of IIO
to assign extra attributes.

Naturally, the best way would be to provide them at allocation time, which
is what this change does for {devm_}iio_triggered_buffer_setup() allocated
buffers.

At this moment, buffers allocated with {devm_}iio_triggered_buffer_setup()
are the only ones in mainline IIO to call iio_buffer_set_attrs(), and this
works well for the single-buffer-per-IIO-device case.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/buffer/industrialio-triggered-buffer.c | 12 +++++++++---
 include/linux/iio/triggered_buffer.h               |  7 +++++--
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
index 6c20a83f887e..b79acdc623b7 100644
--- a/drivers/iio/buffer/industrialio-triggered-buffer.c
+++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
@@ -21,6 +21,7 @@
  * @setup_ops:		Buffer setup functions to use for this device.
  *			If NULL the default setup functions for triggered
  *			buffers will be used.
+ * @buffer_attrs:	Extra sysfs buffer attributes for this IIO buffer
  *
  * This function combines some common tasks which will normally be performed
  * when setting up a triggered buffer. It will allocate the buffer and the
@@ -36,7 +37,8 @@
 int iio_triggered_buffer_setup(struct iio_dev *indio_dev,
 	irqreturn_t (*h)(int irq, void *p),
 	irqreturn_t (*thread)(int irq, void *p),
-	const struct iio_buffer_setup_ops *setup_ops)
+	const struct iio_buffer_setup_ops *setup_ops,
+	const struct attribute **buffer_attrs)
 {
 	struct iio_buffer *buffer;
 	int ret;
@@ -67,6 +69,8 @@ int iio_triggered_buffer_setup(struct iio_dev *indio_dev,
 	/* Flag that polled ring buffering is possible */
 	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 
+	iio_buffer_set_attrs(buffer, buffer_attrs);
+
 	return 0;
 
 error_kfifo_free:
@@ -96,7 +100,8 @@ int devm_iio_triggered_buffer_setup(struct device *dev,
 				    struct iio_dev *indio_dev,
 				    irqreturn_t (*h)(int irq, void *p),
 				    irqreturn_t (*thread)(int irq, void *p),
-				    const struct iio_buffer_setup_ops *ops)
+				    const struct iio_buffer_setup_ops *ops,
+				    const struct attribute **buffer_attrs)
 {
 	struct iio_dev **ptr;
 	int ret;
@@ -108,7 +113,8 @@ int devm_iio_triggered_buffer_setup(struct device *dev,
 
 	*ptr = indio_dev;
 
-	ret = iio_triggered_buffer_setup(indio_dev, h, thread, ops);
+	ret = iio_triggered_buffer_setup(indio_dev, h, thread, ops,
+					 buffer_attrs);
 	if (!ret)
 		devres_add(dev, ptr);
 	else
diff --git a/include/linux/iio/triggered_buffer.h b/include/linux/iio/triggered_buffer.h
index e99c91799359..33c1f5bb1ee5 100644
--- a/include/linux/iio/triggered_buffer.h
+++ b/include/linux/iio/triggered_buffer.h
@@ -4,19 +4,22 @@
 
 #include <linux/interrupt.h>
 
+struct attribute;
 struct iio_dev;
 struct iio_buffer_setup_ops;
 
 int iio_triggered_buffer_setup(struct iio_dev *indio_dev,
 	irqreturn_t (*h)(int irq, void *p),
 	irqreturn_t (*thread)(int irq, void *p),
-	const struct iio_buffer_setup_ops *setup_ops);
+	const struct iio_buffer_setup_ops *setup_ops,
+	const struct attribute **buffer_attrs);
 void iio_triggered_buffer_cleanup(struct iio_dev *indio_dev);
 
 int devm_iio_triggered_buffer_setup(struct device *dev,
 				    struct iio_dev *indio_dev,
 				    irqreturn_t (*h)(int irq, void *p),
 				    irqreturn_t (*thread)(int irq, void *p),
-				    const struct iio_buffer_setup_ops *ops);
+				    const struct iio_buffer_setup_ops *ops,
+				    const struct attribute **buffer_attrs);
 
 #endif
-- 
2.17.1

