Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEEFA2B69D5
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 17:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgKQQTA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 11:19:00 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:30944 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727814AbgKQQS7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 11:18:59 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AHGEVB8001210;
        Tue, 17 Nov 2020 11:18:46 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 34t9ybjdh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 11:18:46 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0AHGIih1044687
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 17 Nov 2020 11:18:44 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 17 Nov 2020 08:18:43 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 17 Nov 2020 08:18:42 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0AHGIRTX032565;
        Tue, 17 Nov 2020 11:18:41 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 11/12] iio: buffer: introduce support for attaching more IIO buffers
Date:   Tue, 17 Nov 2020 18:23:39 +0200
Message-ID: <20201117162340.43924-12-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117162340.43924-1-alexandru.ardelean@analog.com>
References: <20201117162340.43924-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_06:2020-11-17,2020-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 suspectscore=2 impostorscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170117
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

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-buffer.c | 58 +++++++++++++++++++++++++------
 include/linux/iio/buffer_impl.h   |  3 ++
 include/linux/iio/iio-opaque.h    |  4 +++
 3 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index c83cec89eddf..daa68822cea7 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1513,6 +1513,7 @@ static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer);
 
 int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 {
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	struct iio_buffer *buffer = indio_dev->buffer;
 	const struct iio_chan_spec *channels;
 	int i, ret;
@@ -1529,15 +1530,18 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
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
@@ -1549,8 +1553,14 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 
 error_remove_buffer_dir_link:
 	sysfs_remove_link(&indio_dev->dev.kobj, "buffer");
-error_free_sysfs_and_mask:
-	__iio_buffer_free_sysfs_and_mask(buffer);
+	i = iio_dev_opaque->attached_buffers_cnt - 1;
+error_unwind_sysfs_and_mask:
+	for (; i >= 0; i--) {
+		buffer = iio_dev_opaque->attached_buffers[i];
+		__iio_buffer_free_sysfs_and_mask(buffer);
+	}
+	kfree(iio_dev_opaque->attached_buffers);
+	iio_dev_opaque->attached_buffers = NULL;
 	return ret;
 }
 
@@ -1568,7 +1578,9 @@ static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
 
 void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
 {
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	struct iio_buffer *buffer = indio_dev->buffer;
+	int i;
 
 	if (!buffer)
 		return;
@@ -1576,7 +1588,13 @@ void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
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
@@ -1709,14 +1727,32 @@ EXPORT_SYMBOL_GPL(iio_buffer_get_iio_dev);
  * @buffer: The buffer to attach to the device
  *
  * This function attaches a buffer to a IIO device. The buffer stays attached to
- * the device until the device is freed. The function should only be called at
- * most once per device.
+ * the device until the device is freed. For legacy reasons, the first attached
+ * buffer will also be assigned to 'indio_dev->buffer'.
  */
 void iio_device_attach_buffer(struct iio_dev *indio_dev,
 			      struct iio_buffer *buffer)
 {
-	indio_dev->buffer = iio_buffer_get(buffer);
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+	struct iio_buffer **new, **old = iio_dev_opaque->attached_buffers;
+	unsigned int cnt = iio_dev_opaque->attached_buffers_cnt;
+
+	cnt++;
+
+	new = krealloc(old, sizeof(*new) * cnt, GFP_KERNEL);
+	if (!new) {
+		kfree(old);
+		return;
+	}
+	iio_dev_opaque->attached_buffers = new;
+
+	/* first buffer is legacy; attach it to the IIO device directly */
+	if (!indio_dev->buffer)
+		indio_dev->buffer = iio_buffer_get(buffer);
+
+	buffer->indio_dev = indio_dev;
 
-	indio_dev->buffer->indio_dev = indio_dev;
+	iio_dev_opaque->attached_buffers[cnt - 1] = buffer;
+	iio_dev_opaque->attached_buffers_cnt = cnt;
 }
 EXPORT_SYMBOL_GPL(iio_device_attach_buffer);
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

