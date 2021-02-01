Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2251A30AAE0
	for <lists+linux-iio@lfdr.de>; Mon,  1 Feb 2021 16:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhBAO5D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Feb 2021 09:57:03 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:57218 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231253AbhBAOuQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Feb 2021 09:50:16 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 111El77M014271;
        Mon, 1 Feb 2021 09:48:48 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 36dbucuqb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 09:48:47 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 111EmjQp060987
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Feb 2021 09:48:46 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Mon, 1 Feb 2021 06:48:44 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 1 Feb 2021 06:48:44 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 111EmNuG027350;
        Mon, 1 Feb 2021 09:48:41 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <rafael@kernel.org>,
        <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 10/11] iio: buffer: introduce support for attaching more IIO buffers
Date:   Mon, 1 Feb 2021 16:51:04 +0200
Message-ID: <20210201145105.20459-11-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210201145105.20459-1-alexandru.ardelean@analog.com>
References: <20210201145105.20459-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-01_06:2021-01-29,2021-02-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010079
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
 drivers/iio/industrialio-buffer.c | 80 +++++++++++++++++++++++++------
 include/linux/iio/buffer.h        |  4 +-
 include/linux/iio/buffer_impl.h   |  3 ++
 include/linux/iio/iio-opaque.h    |  4 ++
 4 files changed, 74 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 692f721588e2..a69bb705d173 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1445,11 +1445,21 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 	return ret;
 }
 
+static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
+{
+	bitmap_free(buffer->scan_mask);
+	kfree(buffer->buffer_group.name);
+	kfree(buffer->buffer_group.attrs);
+	iio_free_chan_devattr_list(&buffer->buffer_attr_list);
+}
+
 int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 {
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	struct iio_buffer *buffer = indio_dev->buffer;
 	const struct iio_chan_spec *channels;
-	int i;
+	int unwind_idx;
+	int ret, i;
 
 	channels = indio_dev->channels;
 	if (channels) {
@@ -1463,27 +1473,45 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 	if (!buffer)
 		return 0;
 
-	return __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev, 0);
-}
+	for (i = 0; i < iio_dev_opaque->attached_buffers_cnt; i++) {
+		buffer = iio_dev_opaque->attached_buffers[i];
+		ret = __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev, i);
+		if (ret) {
+			unwind_idx = i;
+			goto error_unwind_sysfs_and_mask;
+		}
+	}
 
-static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
-{
-	bitmap_free(buffer->scan_mask);
-	kfree(buffer->buffer_group.name);
-	kfree(buffer->buffer_group.attrs);
-	iio_free_chan_devattr_list(&buffer->buffer_attr_list);
+	return 0;
+
+error_unwind_sysfs_and_mask:
+	for (; unwind_idx >= 0; unwind_idx--) {
+		buffer = iio_dev_opaque->attached_buffers[unwind_idx];
+		__iio_buffer_free_sysfs_and_mask(buffer);
+	}
+	kfree(iio_dev_opaque->attached_buffers);
+	iio_dev_opaque->attached_buffers = NULL;
+	return ret;
 }
 
 void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
 {
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	struct iio_buffer *buffer = indio_dev->buffer;
+	int i;
 
 	if (!buffer)
 		return;
 
 	iio_buffer_unregister_legacy_sysfs_groups(indio_dev);
 
-	__iio_buffer_free_sysfs_and_mask(buffer);
+	for (i = iio_dev_opaque->attached_buffers_cnt - 1; i >= 0; i--) {
+		buffer = iio_dev_opaque->attached_buffers[i];
+		__iio_buffer_free_sysfs_and_mask(buffer);
+	}
+
+	kfree(iio_dev_opaque->attached_buffers);
+	iio_dev_opaque->attached_buffers = NULL;
 }
 
 /**
@@ -1601,13 +1629,35 @@ EXPORT_SYMBOL_GPL(iio_buffer_put);
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

