Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8707E3007F6
	for <lists+linux-iio@lfdr.de>; Fri, 22 Jan 2021 16:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbhAVP4o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Jan 2021 10:56:44 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:35894 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729209AbhAVP43 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Jan 2021 10:56:29 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10MFU0BX004515;
        Fri, 22 Jan 2021 10:55:37 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3668rcjhxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jan 2021 10:55:37 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 10MFtZx5002576
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Jan 2021 10:55:35 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Fri, 22 Jan 2021 07:55:33 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 22 Jan 2021 07:55:33 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 10MFtF5E014933;
        Fri, 22 Jan 2021 10:55:31 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 11/12] iio: buffer: introduce support for attaching more IIO buffers
Date:   Fri, 22 Jan 2021 17:58:04 +0200
Message-ID: <20210122155805.83012-12-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210122155805.83012-1-alexandru.ardelean@analog.com>
References: <20210122155805.83012-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-22_11:2021-01-22,2021-01-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101220087
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
 drivers/iio/industrialio-buffer.c | 67 ++++++++++++++++++++++++-------
 include/linux/iio/buffer.h        |  4 +-
 include/linux/iio/buffer_impl.h   |  3 ++
 include/linux/iio/iio-opaque.h    |  4 ++
 4 files changed, 62 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 62cb90385246..2f429616e998 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1561,9 +1561,10 @@ static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
  */
 int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 {
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	struct iio_buffer *buffer = indio_dev->buffer;
 	const struct iio_chan_spec *channels;
-	int i, ret;
+	int i, cnt, ret;
 
 	channels = indio_dev->channels;
 	if (channels) {
@@ -1577,15 +1578,18 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 	if (!buffer)
 		return 0;
 
-	ret = __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev, 0);
-	if (ret)
-		return ret;
+	for (i = 0; i < iio_dev_opaque->attached_buffers_cnt; i++) {
+		buffer = iio_dev_opaque->attached_buffers[i];
+		ret = __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev, i);
+		if (ret)
+			goto error_unwind_sysfs_and_mask;
+	}
 
 	ret = sysfs_create_link(&indio_dev->dev.kobj,
 				&indio_dev->buffer->buffer_dir,
 				"buffer");
 	if (ret)
-		goto error_free_sysfs_and_mask;
+		goto error_unwind_sysfs_and_mask;
 
 	ret = sysfs_create_link(&indio_dev->dev.kobj,
 				&indio_dev->buffer->scan_el_dir,
@@ -1597,8 +1601,14 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 
 error_remove_buffer_dir_link:
 	sysfs_remove_link(&indio_dev->dev.kobj, "buffer");
-error_free_sysfs_and_mask:
-	__iio_buffer_free_sysfs_and_mask(buffer);
+	cnt = iio_dev_opaque->attached_buffers_cnt - 1;
+error_unwind_sysfs_and_mask:
+	for (; cnt >= 0; cnt--) {
+		buffer = iio_dev_opaque->attached_buffers[cnt];
+		__iio_buffer_free_sysfs_and_mask(buffer);
+	}
+	kfree(iio_dev_opaque->attached_buffers);
+	iio_dev_opaque->attached_buffers = NULL;
 	return ret;
 }
 
@@ -1610,7 +1620,9 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
  */
 void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
 {
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	struct iio_buffer *buffer = indio_dev->buffer;
+	int i;
 
 	if (!buffer)
 		return;
@@ -1618,7 +1630,13 @@ void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
 	sysfs_remove_link(&indio_dev->dev.kobj, "scan_elements");
 	sysfs_remove_link(&indio_dev->dev.kobj, "buffer");
 
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
@@ -1750,15 +1768,36 @@ EXPORT_SYMBOL_GPL(iio_buffer_get_iio_dev);
  * @indio_dev: The device the buffer should be attached to
  * @buffer: The buffer to attach to the device
  *
+ * Return 0 if buffer attached, or negative if error occured.
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
 
-	indio_dev->buffer->indio_dev = indio_dev;
+	iio_dev_opaque->attached_buffers = new;
+
+	/* first buffer is legacy; attach it to the IIO device directly */
+	if (!indio_dev->buffer)
+		indio_dev->buffer = iio_buffer_get(buffer);
+
+	buffer->indio_dev = indio_dev;
+
+	iio_dev_opaque->attached_buffers[cnt - 1] = buffer;
+	iio_dev_opaque->attached_buffers_cnt = cnt;
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(iio_device_attach_buffer);
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index b27d8c81f32c..5532eddb7808 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -43,7 +43,7 @@ static inline int iio_push_to_buffers_with_timestamp(struct iio_dev *indio_dev,
 bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
 				   const unsigned long *mask);
 
-void iio_device_attach_buffer(struct iio_dev *indio_dev,
-			      struct iio_buffer *buffer);
+int iio_device_attach_buffer(struct iio_dev *indio_dev,
+			     struct iio_buffer *buffer);
 
 #endif /* _IIO_BUFFER_GENERIC_H_ */
diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
index 77e169e51434..e25d26a7f601 100644
--- a/include/linux/iio/buffer_impl.h
+++ b/include/linux/iio/buffer_impl.h
@@ -124,6 +124,9 @@ struct iio_buffer {
 	/* @demux_bounce: Buffer for doing gather from incoming scan. */
 	void *demux_bounce;
 
+	/* @attached_entry: Entry in the devices list of buffers attached by the driver. */
+	struct list_head attached_entry;
+
 	/* @buffer_list: Entry in the devices list of current buffers. */
 	struct list_head buffer_list;
 
diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
index 07c5a8e52ca8..1db0ea09520e 100644
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
@@ -20,6 +22,8 @@
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

