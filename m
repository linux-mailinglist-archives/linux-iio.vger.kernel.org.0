Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C1531B773
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 11:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhBOKkh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 05:40:37 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:3900 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230232AbhBOKkN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2021 05:40:13 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11FAa3wW029101;
        Mon, 15 Feb 2021 05:39:19 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36pcjamake-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 05:39:19 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11FAdIjF023164
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 15 Feb 2021 05:39:18 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 15 Feb
 2021 05:39:17 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 15 Feb 2021 05:39:17 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11FAcQUm017530;
        Mon, 15 Feb 2021 05:39:14 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v6 19/24] iio: buffer: introduce support for attaching more IIO buffers
Date:   Mon, 15 Feb 2021 12:40:38 +0200
Message-ID: <20210215104043.91251-20-alexandru.ardelean@analog.com>
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
To adapt to this new change iio_device_attach_buffer() is called last in
all place where it's called. The realloc failure is a bit difficult to
handle during un-managed calls when unwinding, so it's better to have this
as the last error in the setup_buffer calls.

At this point, no driver should call iio_device_attach_buffer() directly,
it should call one of the {devm_}iio_triggered_buffer_setup() or
devm_iio_kfifo_buffer_setup() or devm_iio_dmaengine_buffer_setup()
functions. This makes iio_device_attach_buffer() a bit easier to handle.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../buffer/industrialio-buffer-dmaengine.c    |   4 +-
 .../buffer/industrialio-triggered-buffer.c    |  10 +-
 drivers/iio/buffer/kfifo_buf.c                |   4 +-
 drivers/iio/iio_core.h                        |  10 +-
 drivers/iio/industrialio-buffer.c             | 100 ++++++++++++++----
 drivers/iio/industrialio-core.c               |  12 +--
 include/linux/iio/buffer.h                    |   4 +-
 include/linux/iio/buffer_impl.h               |   3 +
 include/linux/iio/iio-opaque.h                |   4 +
 9 files changed, 111 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index a64b222289be..d76179878ff9 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -290,9 +290,7 @@ int devm_iio_dmaengine_buffer_setup(struct device *dev,
 
 	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
 
-	iio_device_attach_buffer(indio_dev, buffer);
-
-	return 0;
+	return iio_device_attach_buffer(indio_dev, buffer);
 }
 EXPORT_SYMBOL_GPL(devm_iio_dmaengine_buffer_setup);
 
diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
index 92b8aea3e063..b2b1b7d27af4 100644
--- a/drivers/iio/buffer/industrialio-triggered-buffer.c
+++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
@@ -50,8 +50,6 @@ int iio_triggered_buffer_setup_ext(struct iio_dev *indio_dev,
 		goto error_ret;
 	}
 
-	iio_device_attach_buffer(indio_dev, buffer);
-
 	indio_dev->pollfunc = iio_alloc_pollfunc(h,
 						 thread,
 						 IRQF_ONESHOT,
@@ -72,10 +70,16 @@ int iio_triggered_buffer_setup_ext(struct iio_dev *indio_dev,
 
 	buffer->attrs = buffer_attrs;
 
+	ret = iio_device_attach_buffer(indio_dev, buffer);
+	if (ret < 0)
+		goto error_dealloc_pollfunc;
+
 	return 0;
 
+error_dealloc_pollfunc:
+	iio_dealloc_pollfunc(indio_dev->pollfunc);
 error_kfifo_free:
-	iio_kfifo_free(indio_dev->buffer);
+	iio_kfifo_free(buffer);
 error_ret:
 	return ret;
 }
diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
index c35a625280b1..34289ce12f20 100644
--- a/drivers/iio/buffer/kfifo_buf.c
+++ b/drivers/iio/buffer/kfifo_buf.c
@@ -235,12 +235,10 @@ int devm_iio_kfifo_buffer_setup(struct device *dev,
 	if (!buffer)
 		return -ENOMEM;
 
-	iio_device_attach_buffer(indio_dev, buffer);
-
 	indio_dev->modes |= mode_flags;
 	indio_dev->setup_ops = setup_ops;
 
-	return 0;
+	return iio_device_attach_buffer(indio_dev, buffer);
 }
 EXPORT_SYMBOL_GPL(devm_iio_kfifo_buffer_setup);
 
diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index 87868fff7d37..7990c759f1f5 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -69,29 +69,31 @@ __poll_t iio_buffer_poll(struct file *filp,
 ssize_t iio_buffer_read_outer(struct file *filp, char __user *buf,
 			      size_t n, loff_t *f_ps);
 
-int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev);
-void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev);
+int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev);
+void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev);
 
 #define iio_buffer_poll_addr (&iio_buffer_poll)
 #define iio_buffer_read_outer_addr (&iio_buffer_read_outer)
 
 void iio_disable_all_buffers(struct iio_dev *indio_dev);
 void iio_buffer_wakeup_poll(struct iio_dev *indio_dev);
+void iio_buffers_put(struct iio_dev *indio_dev);
 
 #else
 
 #define iio_buffer_poll_addr NULL
 #define iio_buffer_read_outer_addr NULL
 
-static inline int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
+static inline int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 {
 	return 0;
 }
 
-static inline void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev) {}
+static inline void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev) {}
 
 static inline void iio_disable_all_buffers(struct iio_dev *indio_dev) {}
 static inline void iio_buffer_wakeup_poll(struct iio_dev *indio_dev) {}
+static inline void iio_buffers_put(struct iio_dev *indio_dev) {}
 
 #endif
 
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 7efa32dd9c61..7b5827b91280 100644
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
@@ -1451,11 +1465,13 @@ static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
 	iio_free_chan_devattr_list(&buffer->buffer_attr_list);
 }
 
-int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
+int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
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
 
-void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
+void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev)
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
index 1d500ea246af..f7f785431106 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1583,7 +1583,7 @@ static void iio_dev_release(struct device *device)
 	iio_device_unregister_eventset(indio_dev);
 	iio_device_unregister_sysfs(indio_dev);
 
-	iio_buffer_put(indio_dev->buffer);
+	iio_buffers_put(indio_dev);
 
 	ida_simple_remove(&iio_ida, indio_dev->id);
 	kfree(iio_dev_opaque);
@@ -1860,7 +1860,7 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 
 	iio_device_register_debugfs(indio_dev);
 
-	ret = iio_buffer_alloc_sysfs_and_mask(indio_dev);
+	ret = iio_buffers_alloc_sysfs_and_mask(indio_dev);
 	if (ret) {
 		dev_err(indio_dev->dev.parent,
 			"Failed to create buffer sysfs interfaces\n");
@@ -1886,12 +1886,12 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
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
@@ -1910,7 +1910,7 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 error_free_sysfs:
 	iio_device_unregister_sysfs(indio_dev);
 error_buffer_free_sysfs:
-	iio_buffer_free_sysfs_and_mask(indio_dev);
+	iio_buffers_free_sysfs_and_mask(indio_dev);
 error_unreg_debugfs:
 	iio_device_unregister_debugfs(indio_dev);
 	return ret;
@@ -1944,7 +1944,7 @@ void iio_device_unregister(struct iio_dev *indio_dev)
 
 	mutex_unlock(&indio_dev->info_exist_lock);
 
-	iio_buffer_free_sysfs_and_mask(indio_dev);
+	iio_buffers_free_sysfs_and_mask(indio_dev);
 }
 EXPORT_SYMBOL(iio_device_unregister);
 
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
index 1a9310b0145f..b6ebc04af3e7 100644
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

