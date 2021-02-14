Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF40531B0C1
	for <lists+linux-iio@lfdr.de>; Sun, 14 Feb 2021 15:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhBNOcD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Feb 2021 09:32:03 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:15928 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229759AbhBNOcC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Feb 2021 09:32:02 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11EESdoH012191;
        Sun, 14 Feb 2021 09:31:10 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36p9gathg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Feb 2021 09:31:10 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11EEV9WG007471
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 14 Feb 2021 09:31:09 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Sun, 14 Feb 2021
 09:31:08 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Sun, 14 Feb 2021 09:31:08 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11EEV2tr027551;
        Sun, 14 Feb 2021 09:31:06 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/5] iio: kfifo: add devm_iio_kfifo_buffer_setup() helper
Date:   Sun, 14 Feb 2021 16:33:10 +0200
Message-ID: <20210214143313.67202-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210214143313.67202-1-alexandru.ardelean@analog.com>
References: <20210214143313.67202-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-14_04:2021-02-12,2021-02-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102140120
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change adds the devm_iio_kfifo_buffer_setup() helper/short-hand,
which groups the simple routine of allocating a kfifo buffers via
devm_iio_kfifo_allocate() and calling iio_device_attach_buffer().

The mode_flags parameter is required, as the IIO kfifo supports 2 modes:
INDIO_BUFFER_SOFTWARE & INDIO_BUFFER_TRIGGERED.
The setup_ops parameter is optional.

This function will be a bit more useful when needing to define multiple
buffers per IIO device.

The naming for this function has been inspired from
iio_triggered_buffer_setup() since that one does a kfifo alloc + a pollfunc
alloc. So, this should have a more familiar ring to what it is.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../driver-api/driver-model/devres.rst        |  1 +
 drivers/iio/buffer/kfifo_buf.c                | 39 +++++++++++++++++++
 include/linux/iio/kfifo_buf.h                 |  7 ++++
 3 files changed, 47 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index cd8b6e657b94..562f5722281e 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -286,6 +286,7 @@ IIO
   devm_iio_device_alloc()
   devm_iio_device_register()
   devm_iio_kfifo_allocate()
+  devm_iio_kfifo_buffer_setup()
   devm_iio_triggered_buffer_setup()
   devm_iio_trigger_alloc()
   devm_iio_trigger_register()
diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
index 1359abed3b31..6472c9fa1937 100644
--- a/drivers/iio/buffer/kfifo_buf.c
+++ b/drivers/iio/buffer/kfifo_buf.c
@@ -206,4 +206,43 @@ struct iio_buffer *devm_iio_kfifo_allocate(struct device *dev)
 }
 EXPORT_SYMBOL(devm_iio_kfifo_allocate);
 
+/**
+ * devm_iio_kfifo_buffer_setup - Allocate a kfifo buffer & attach it to an IIO device
+ * @dev: Device object to which to attach the life-time of this kfifo buffer
+ * @indio_dev: The device the buffer should be attached to
+ * @mode_flags: The mode flags for this buffer (INDIO_BUFFER_SOFTWARE and/or
+ *		INDIO_BUFFER_TRIGGERED).
+ * @setup_ops: The setup_ops required to configure the HW part of the buffer (optional)
+ *
+ * This function allocates a kfifo buffer via devm_iio_kfifo_allocate() and
+ * attaches it to the IIO device via iio_device_attach_buffer().
+ * This is meant to be a bit of a short-hand/helper function as there are a few
+ * drivers that seem to do this.
+ */
+int devm_iio_kfifo_buffer_setup(struct device *dev,
+				struct iio_dev *indio_dev,
+				int mode_flags,
+				const struct iio_buffer_setup_ops *setup_ops)
+{
+	struct iio_buffer *buffer;
+
+	if (mode_flags)
+		mode_flags &= kfifo_access_funcs.modes;
+
+	if (!mode_flags)
+		return -EINVAL;
+
+	buffer = devm_iio_kfifo_allocate(dev);
+	if (!buffer)
+		return -ENOMEM;
+
+	iio_device_attach_buffer(indio_dev, buffer);
+
+	indio_dev->modes |= mode_flags;
+	indio_dev->setup_ops = setup_ops;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_iio_kfifo_buffer_setup);
+
 MODULE_LICENSE("GPL");
diff --git a/include/linux/iio/kfifo_buf.h b/include/linux/iio/kfifo_buf.h
index 1fc1efa7799d..92c411b9ac26 100644
--- a/include/linux/iio/kfifo_buf.h
+++ b/include/linux/iio/kfifo_buf.h
@@ -3,6 +3,8 @@
 #define __LINUX_IIO_KFIFO_BUF_H__
 
 struct iio_buffer;
+struct iio_buffer_setup_ops;
+struct iio_dev;
 struct device;
 
 struct iio_buffer *iio_kfifo_allocate(void);
@@ -10,4 +12,9 @@ void iio_kfifo_free(struct iio_buffer *r);
 
 struct iio_buffer *devm_iio_kfifo_allocate(struct device *dev);
 
+int devm_iio_kfifo_buffer_setup(struct device *dev,
+				struct iio_dev *indio_dev,
+				int mode_flags,
+				const struct iio_buffer_setup_ops *setup_ops);
+
 #endif
-- 
2.17.1

