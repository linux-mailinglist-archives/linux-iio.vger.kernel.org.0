Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74793202A75
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jun 2020 14:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbgFUMb4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Jun 2020 08:31:56 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:3968 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729965AbgFUMbz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2020 08:31:55 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05LCOWmk003518;
        Sun, 21 Jun 2020 08:31:40 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 31sca6jr40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 Jun 2020 08:31:39 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 05LCVckR040909
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sun, 21 Jun 2020 08:31:38 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Sun, 21 Jun
 2020 08:31:37 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Sun, 21 Jun 2020 08:31:37 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 05LCVWVb007980;
        Sun, 21 Jun 2020 08:31:35 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <knaack.h@gmx.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 2/7] iio: core: wrap IIO device into an iio_dev_opaque object
Date:   Sun, 21 Jun 2020 15:33:40 +0300
Message-ID: <20200621123345.2469-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200621123345.2469-1-alexandru.ardelean@analog.com>
References: <20200621123345.2469-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-21_05:2020-06-19,2020-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0
 mlxlogscore=999 priorityscore=1501 cotscore=-2147483648 lowpriorityscore=0
 suspectscore=2 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006210101
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There are plenty of bad designs we want to discourage or not have to review
manually usually about accessing private (marked as [INTERN]) fields of
'struct iio_dev'.

Sometimes users copy drivers that are not always the best examples.

A better idea is to hide those fields into the framework.
For 'struct iio_dev' this is a 'struct iio_dev_opaque' which wraps a public
'struct iio_dev' object.

In the next series, some fields will be moved to this new struct, each with
it's own rework.

This rework will not be complete-able for a while, as many fields need some
drivers to be reworked in order to finalize them (e.g. 'indio_dev->mlock').

But some fields can already be moved, and in time, all of them may get
there (in the 'struct iio_dev_opaque' object).

Since a lot of drivers also call 'iio_priv()', in order to preserve
fast-paths (where this matters), the public iio_dev object will have a
'priv' field that will have the pointer to the private information already
computed. The reference returned by this field should be guaranteed to be
cacheline aligned.

As for the 'iio_priv_to_dev()' helper, this needs to be hidden away. There
aren't many users of this helper, and arguably drivers shouldn't need to
use it in any fast-paths, as they can maintain a reference to the IIO
device.

The opaque parts will be moved into the 'include/linux/iio/iio-opaque.h'
header. Should the hidden information be required for some debugging or
some special needs, it can be made available via this header.
Otherwise, only the IIO core files should include this file.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-core.c | 19 +++++++++++++------
 include/linux/iio/iio-opaque.h  | 17 +++++++++++++++++
 include/linux/iio/iio.h         |  6 +++++-
 3 files changed, 35 insertions(+), 7 deletions(-)
 create mode 100644 include/linux/iio/iio-opaque.h

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 75661661aaba..33e2953cf021 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -25,6 +25,7 @@
 #include <linux/debugfs.h>
 #include <linux/mutex.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/iio-opaque.h>
 #include "iio_core.h"
 #include "iio_core_trigger.h"
 #include <linux/iio/sysfs.h>
@@ -1473,6 +1474,8 @@ static void iio_device_unregister_sysfs(struct iio_dev *indio_dev)
 static void iio_dev_release(struct device *device)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(device);
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+
 	if (indio_dev->modes & INDIO_ALL_TRIGGERED_MODES)
 		iio_device_unregister_trigger_consumer(indio_dev);
 	iio_device_unregister_eventset(indio_dev);
@@ -1481,7 +1484,7 @@ static void iio_dev_release(struct device *device)
 	iio_buffer_put(indio_dev->buffer);
 
 	ida_simple_remove(&iio_ida, indio_dev->id);
-	kfree(indio_dev);
+	kfree(iio_dev_opaque);
 }
 
 struct device_type iio_device_type = {
@@ -1495,10 +1498,11 @@ struct device_type iio_device_type = {
  **/
 struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 {
+	struct iio_dev_opaque *iio_dev_opaque;
 	struct iio_dev *dev;
 	size_t alloc_size;
 
-	alloc_size = sizeof(struct iio_dev);
+	alloc_size = sizeof(struct iio_dev_opaque);
 	if (sizeof_priv) {
 		alloc_size = ALIGN(alloc_size, IIO_ALIGN);
 		alloc_size += sizeof_priv;
@@ -1506,11 +1510,14 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	/* ensure 32-byte alignment of whole construct ? */
 	alloc_size += IIO_ALIGN - 1;
 
-	dev = kzalloc(alloc_size, GFP_KERNEL);
-	if (!dev)
+	iio_dev_opaque = kzalloc(alloc_size, GFP_KERNEL);
+	if (!iio_dev_opaque)
 		return NULL;
 
-	dev->dev.parent = parent;
+	dev = &iio_dev_opaque->indio_dev;
+	dev->priv = (char *)iio_dev_opaque +
+		ALIGN(sizeof(struct iio_dev_opaque), IIO_ALIGN);
+
 	dev->dev.groups = dev->groups;
 	dev->dev.type = &iio_device_type;
 	dev->dev.bus = &iio_bus_type;
@@ -1524,7 +1531,7 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	if (dev->id < 0) {
 		/* cannot use a dev_err as the name isn't available */
 		pr_err("failed to get device id\n");
-		kfree(dev);
+		kfree(iio_dev_opaque);
 		return NULL;
 	}
 	dev_set_name(&dev->dev, "iio:device%d", dev->id);
diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
new file mode 100644
index 000000000000..1375674f14cd
--- /dev/null
+++ b/include/linux/iio/iio-opaque.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _INDUSTRIAL_IO_OPAQUE_H_
+#define _INDUSTRIAL_IO_OPAQUE_H_
+
+/**
+ * struct iio_dev_opaque - industrial I/O device opaque information
+ * @indio_dev:			public industrial I/O device information
+ */
+struct iio_dev_opaque {
+	struct iio_dev			indio_dev;
+};
+
+#define to_iio_dev_opaque(indio_dev)		\
+	container_of(indio_dev, struct iio_dev_opaque, indio_dev)
+
+#endif
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 10a6d97a8e3e..86112e35ae5f 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -522,6 +522,8 @@ struct iio_buffer_setup_ops {
  * @flags:		[INTERN] file ops related flags including busy flag.
  * @debugfs_dentry:	[INTERN] device specific debugfs dentry.
  * @cached_reg_addr:	[INTERN] cached register address for debugfs reads.
+ * @priv:		[DRIVER] reference to driver's private information
+ *			**MUST** be accessed **ONLY** via iio_priv() helper
  */
 struct iio_dev {
 	int				id;
@@ -571,6 +573,7 @@ struct iio_dev {
 	char				read_buf[20];
 	unsigned int			read_buf_len;
 #endif
+	void				*priv;
 };
 
 const struct iio_chan_spec
@@ -698,9 +701,10 @@ static inline void *iio_device_get_drvdata(const struct iio_dev *indio_dev)
 #define IIO_ALIGN L1_CACHE_BYTES
 struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv);
 
+/* The information at the returned address is guaranteed to be cacheline aligned */
 static inline void *iio_priv(const struct iio_dev *indio_dev)
 {
-	return (char *)indio_dev + ALIGN(sizeof(struct iio_dev), IIO_ALIGN);
+	return indio_dev->priv;
 }
 
 void iio_device_free(struct iio_dev *indio_dev);
-- 
2.17.1

