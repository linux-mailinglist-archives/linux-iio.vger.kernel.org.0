Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871D8318A6F
	for <lists+linux-iio@lfdr.de>; Thu, 11 Feb 2021 13:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhBKM0H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Feb 2021 07:26:07 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:31250 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230479AbhBKMXy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Feb 2021 07:23:54 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11BCLWNP025201;
        Thu, 11 Feb 2021 07:23:00 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36hrw905bh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 07:23:00 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11BCMxko004281
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Feb 2021 07:22:59 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Thu, 11 Feb 2021 07:22:58 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Thu, 11 Feb 2021 07:22:58 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 11 Feb 2021 07:22:58 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11BCMYWk011557;
        Thu, 11 Feb 2021 07:22:55 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <rafael@kernel.org>,
        <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v5 12/17] iio: buffer: introduce support for attaching more IIO buffers
Date:   Thu, 11 Feb 2021 14:24:47 +0200
Message-ID: <20210211122452.78106-13-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210211122452.78106-1-alexandru.ardelean@analog.com>
References: <20210211122452.78106-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_06:2021-02-10,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110110
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

With this change, calling iio_device_attach_buffer() will actually attach
more buffers.
Right now this doesn't do any validation of whether a buffer is attached
twice; maybe that can be added later (if needed). Attaching a buffer more
than once should yield noticeably bad results.

The first buffer is the legacy buffer, so a reference is kept to it.

At this point, accessing the data for the extra buffers (that are added
after the first one) isn't possible yet.

The iio_device_attach_buffer() is also changed to return an error code,
which for now is -ENOMEM if the array could not be realloc-ed for more
buffers.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/iio_core.h            |  2 +
 drivers/iio/industrialio-buffer.c | 96 +++++++++++++++++++++++++------
 drivers/iio/industrialio-core.c   |  6 +-
 include/linux/iio/buffer.h        |  4 +-
 include/linux/iio/buffer_impl.h   |  3 +
 include/linux/iio/iio-opaque.h    |  4 ++
 6 files changed, 93 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index 87868fff7d37..4690c3240a5d 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -77,6 +77,7 @@ void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev);
 
 void iio_disable_all_buffers(struct iio_dev *indio_dev);
 void iio_buffer_wakeup_poll(struct iio_dev *indio_dev);
+void iio_buffers_put(struct iio_dev *indio_dev);
 
 #else
 
@@ -92,6 +93,7 @@ static inline void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev) {}
 
 static inline void iio_disable_all_buffers(struct iio_dev *indio_dev) {}
 static inline void iio_buffer_wakeup_poll(struct iio_dev *indio_dev) {}
+static inline void iio_buffers_put(struct iio_dev *indio_dev) {}
 
 #endif
 
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 209b3a32bdbb..1e8e4c2ff00e 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -193,12 +193,14 @@ __poll_t iio_buffer_poll(struct file *filp,
  */
 void iio_buffer_wakeup_poll(struct iio_dev *indio_dev)
 {
-	struct iio_buffer *buffer = indio_dev->buffer;
-
-	if (!buffer)
-		return;
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+	struct iio_buffer *buffer;
+	unsigned int i;
 
-	wake_up(&buffer->pollq);
+	for (i = 0; i < iio_dev_opaque->attached_buffers_cnt; i++) {
+		buffer = iio_dev_opaque->attached_buffers[i];
+		wake_up(&buffer->pollq);
+	}
 }
 
 void iio_buffer_init(struct iio_buffer *buffer)
@@ -212,6 +214,18 @@ void iio_buffer_init(struct iio_buffer *buffer)
 }
 EXPORT_SYMBOL(iio_buffer_init);
 
+void iio_buffers_put(struct iio_dev *indio_dev)
+{
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+	struct iio_buffer *buffer;
+	unsigned int i;
+
+	for (i = 0; i < iio_dev_opaque->attached_buffers_cnt; i++) {
+		buffer = iio_dev_opaque->attached_buffers[i];
+		iio_buffer_put(buffer);
+	}
+}
+
 static ssize_t iio_show_scan_index(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
@@ -1453,9 +1467,11 @@ static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
 
 int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 {
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	const struct iio_chan_spec *channels;
-	int i;
+	struct iio_buffer *buffer;
+	int unwind_idx;
+	int ret, i;
 
 	channels = indio_dev->channels;
 	if (channels) {
@@ -1466,22 +1482,46 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 		indio_dev->masklength = ml;
 	}
 
-	if (!buffer)
+	if (!iio_dev_opaque->attached_buffers_cnt)
 		return 0;
 
-	return __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev, 0);
+	for (i = 0; i < iio_dev_opaque->attached_buffers_cnt; i++) {
+		buffer = iio_dev_opaque->attached_buffers[i];
+		ret = __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev, i);
+		if (ret) {
+			unwind_idx = i;
+			goto error_unwind_sysfs_and_mask;
+		}
+	}
+
+	return 0;
+
+error_unwind_sysfs_and_mask:
+	for (; unwind_idx >= 0; unwind_idx--) {
+		buffer = iio_dev_opaque->attached_buffers[unwind_idx];
+		__iio_buffer_free_sysfs_and_mask(buffer);
+	}
+	kfree(iio_dev_opaque->attached_buffers);
+	return ret;
 }
 
 void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
 {
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+	struct iio_buffer *buffer;
+	int i;
 
-	if (!buffer)
+	if (!iio_dev_opaque->attached_buffers_cnt)
 		return;
 
 	iio_buffer_unregister_legacy_sysfs_groups(indio_dev);
 
-	__iio_buffer_free_sysfs_and_mask(buffer);
+	for (i = iio_dev_opaque->attached_buffers_cnt - 1; i >= 0; i--) {
+		buffer = iio_dev_opaque->attached_buffers[i];
+		__iio_buffer_free_sysfs_and_mask(buffer);
+	}
+
+	kfree(iio_dev_opaque->attached_buffers);
 }
 
 /**
@@ -1599,13 +1639,35 @@ EXPORT_SYMBOL_GPL(iio_buffer_put);
  * @indio_dev: The device the buffer should be attached to
  * @buffer: The buffer to attach to the device
  *
+ * Return 0 if successful, negative if error.
+ *
  * This function attaches a buffer to a IIO device. The buffer stays attached to
- * the device until the device is freed. The function should only be called at
- * most once per device.
+ * the device until the device is freed. For legacy reasons, the first attached
+ * buffer will also be assigned to 'indio_dev->buffer'.
  */
-void iio_device_attach_buffer(struct iio_dev *indio_dev,
-			      struct iio_buffer *buffer)
+int iio_device_attach_buffer(struct iio_dev *indio_dev,
+			     struct iio_buffer *buffer)
 {
-	indio_dev->buffer = iio_buffer_get(buffer);
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+	struct iio_buffer **new, **old = iio_dev_opaque->attached_buffers;
+	unsigned int cnt = iio_dev_opaque->attached_buffers_cnt;
+
+	cnt++;
+
+	new = krealloc(old, sizeof(*new) * cnt, GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+	iio_dev_opaque->attached_buffers = new;
+
+	buffer = iio_buffer_get(buffer);
+
+	/* first buffer is legacy; attach it to the IIO device directly */
+	if (!indio_dev->buffer)
+		indio_dev->buffer = buffer;
+
+	iio_dev_opaque->attached_buffers[cnt - 1] = buffer;
+	iio_dev_opaque->attached_buffers_cnt = cnt;
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(iio_device_attach_buffer);
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 1be94df3e591..26b05dddfa71 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1583,7 +1583,7 @@ static void iio_dev_release(struct device *device)
 	iio_device_unregister_eventset(indio_dev);
 	iio_device_unregister_sysfs(indio_dev);
 
-	iio_buffer_put(indio_dev->buffer);
+	iio_buffers_put(indio_dev);
 
 	ida_simple_remove(&iio_ida, indio_dev->id);
 	kfree(iio_dev_opaque);
@@ -1884,12 +1884,12 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 		indio_dev->setup_ops == NULL)
 		indio_dev->setup_ops = &noop_ring_setup_ops;
 
-	if (indio_dev->buffer)
+	if (iio_dev_opaque->attached_buffers_cnt)
 		cdev_init(&indio_dev->chrdev, &iio_buffer_fileops);
 	else if (iio_dev_opaque->event_interface)
 		cdev_init(&indio_dev->chrdev, &iio_event_fileops);
 
-	if (indio_dev->buffer || iio_dev_opaque->event_interface) {
+	if (iio_dev_opaque->attached_buffers_cnt || iio_dev_opaque->event_interface) {
 		indio_dev->dev.devt = MKDEV(MAJOR(iio_devt), indio_dev->id);
 		indio_dev->chrdev.owner = this_mod;
 	}
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 8febc23f5f26..b6928ac5c63d 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -41,7 +41,7 @@ static inline int iio_push_to_buffers_with_timestamp(struct iio_dev *indio_dev,
 bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
 				   const unsigned long *mask);
 
-void iio_device_attach_buffer(struct iio_dev *indio_dev,
-			      struct iio_buffer *buffer);
+int iio_device_attach_buffer(struct iio_dev *indio_dev,
+			     struct iio_buffer *buffer);
 
 #endif /* _IIO_BUFFER_GENERIC_H_ */
diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
index 41044320e581..768b90c64412 100644
--- a/include/linux/iio/buffer_impl.h
+++ b/include/linux/iio/buffer_impl.h
@@ -112,6 +112,9 @@ struct iio_buffer {
 	/* @demux_bounce: Buffer for doing gather from incoming scan. */
 	void *demux_bounce;
 
+	/* @attached_entry: Entry in the devices list of buffers attached by the driver. */
+	struct list_head attached_entry;
+
 	/* @buffer_list: Entry in the devices list of current buffers. */
 	struct list_head buffer_list;
 
diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
index 3e4c3cd248fd..c909835b6247 100644
--- a/include/linux/iio/iio-opaque.h
+++ b/include/linux/iio/iio-opaque.h
@@ -7,6 +7,8 @@
  * struct iio_dev_opaque - industrial I/O device opaque information
  * @indio_dev:			public industrial I/O device information
  * @event_interface:		event chrdevs associated with interrupt lines
+ * @attached_buffers:		array of buffers statically attached by the driver
+ * @attached_buffers_cnt:	number of buffers in the array of statically attached buffers
  * @buffer_list:		list of all buffers currently attached
  * @channel_attr_list:		keep track of automatically created channel
  *				attributes
@@ -24,6 +26,8 @@
 struct iio_dev_opaque {
 	struct iio_dev			indio_dev;
 	struct iio_event_interface	*event_interface;
+	struct iio_buffer		**attached_buffers;
+	unsigned int			attached_buffers_cnt;
 	struct list_head		buffer_list;
 	struct list_head		channel_attr_list;
 	struct attribute_group		chan_attr_group;
-- 
2.17.1

