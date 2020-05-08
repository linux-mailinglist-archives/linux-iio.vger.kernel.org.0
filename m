Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642A11CB119
	for <lists+linux-iio@lfdr.de>; Fri,  8 May 2020 15:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgEHNym (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 May 2020 09:54:42 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:57498 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728387AbgEHNyY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 May 2020 09:54:24 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 048Dqt9C016870;
        Fri, 8 May 2020 09:54:12 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 30vtek2gd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 09:54:12 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 048DsBT8040872
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 8 May 2020 09:54:11 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Fri, 8 May 2020
 09:54:10 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 8 May 2020 09:54:10 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 048Drpx0030263;
        Fri, 8 May 2020 09:54:09 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 14/14] iio: buffer: convert single buffer to list of buffers
Date:   Fri, 8 May 2020 16:53:48 +0300
Message-ID: <20200508135348.15229-15-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508135348.15229-1-alexandru.ardelean@analog.com>
References: <20200508135348.15229-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_13:2020-05-08,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=777 lowpriorityscore=0 phishscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005080123
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

WIP

Time to add support for multiple buffers.
At this point it should be just managing a list.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-buffer.c | 74 ++++++++++++++++++++++---------
 drivers/iio/industrialio-core.c   |  1 +
 include/linux/iio/buffer_impl.h   |  3 ++
 include/linux/iio/iio.h           |  2 +
 4 files changed, 58 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index aa2f46c0949f..c335484a6651 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -244,12 +244,13 @@ static int iio_buffer_chrdev_release(struct inode *inode, struct file *filp)
  */
 void iio_buffer_wakeup_poll(struct iio_dev *indio_dev)
 {
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *b;
 
-	if (!buffer)
+	if (list_empty(&indio_dev->attached_buffers))
 		return;
 
-	wake_up(&buffer->pollq);
+	list_for_each_entry(b, &indio_dev->attached_buffers, attached_entry)
+		wake_up(&b->pollq);
 }
 
 void iio_buffer_init(struct iio_buffer *buffer)
@@ -1547,10 +1548,27 @@ static int iio_device_link_legacy_folders(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static void __iio_device_buffers_cleanup(struct iio_dev *indio_dev, int idx)
+{
+	struct iio_buffer *b;
+
+	if (list_empty(&indio_dev->attached_buffers))
+		return;
+
+	list_for_each_entry(b, &indio_dev->attached_buffers, attached_entry) {
+		if (idx == 0)
+			break;
+
+		iio_device_buffer_cleanup(b);
+		if (idx > 0)
+			idx--;
+	}
+}
+
 int iio_device_buffers_init(struct iio_dev *indio_dev)
 {
-	struct iio_buffer *buffer = indio_dev->buffer;
 	const struct iio_chan_spec *channels;
+	struct iio_buffer *b;
 	int i, ret;
 
 	channels = indio_dev->channels;
@@ -1562,32 +1580,38 @@ int iio_device_buffers_init(struct iio_dev *indio_dev)
 		indio_dev->masklength = ml;
 	}
 
-	if (!buffer)
+	if (list_empty(&indio_dev->attached_buffers))
 		return 0;
 
-	ret = iio_device_buffer_init(indio_dev, buffer, 0);
-	if (ret)
-		return ret;
+	i = 0;
+	list_for_each_entry(b, &indio_dev->attached_buffers, attached_entry) {
+		ret = iio_device_buffer_init(indio_dev, b, i);
+		if (ret)
+			goto error_buffers_cleanup;
 
-	ret = iio_device_link_legacy_folders(indio_dev, buffer);
-	if (ret)
-		goto error_buffers_cleanup;
+		if (i == 0) {
+			ret = iio_device_link_legacy_folders(indio_dev, b);
+			if (ret) {
+				iio_device_buffer_cleanup(b);
+				goto error_buffers_cleanup;
+			}
+		}
+		i++;
+	}
 
 	return 0;
 
 error_buffers_cleanup:
-	iio_device_buffer_cleanup(buffer);
-	return 0;
+	__iio_device_buffers_cleanup(indio_dev, i);
+	return ret;
 }
 
 void iio_device_buffers_cleanup(struct iio_dev *indio_dev)
 {
-	struct iio_buffer *buffer = indio_dev->buffer;
-
 	sysfs_remove_link(&indio_dev->dev.kobj, "buffer");
 	sysfs_remove_link(&indio_dev->dev.kobj, "scan_elements");
 
-	iio_device_buffer_cleanup(buffer);
+	__iio_device_buffers_cleanup(indio_dev, -1);
 }
 
 static const struct file_operations iio_buffer_fileops = {
@@ -1615,12 +1639,13 @@ void iio_device_buffer_attach_chrdev(struct iio_dev *indio_dev)
 
 void iio_device_buffers_put(struct iio_dev *indio_dev)
 {
-	struct iio_buffer *buffer = indio_dev->buffer;
+	struct iio_buffer *b;
 
-	if (!buffer)
+	if (list_empty(&indio_dev->attached_buffers))
 		return;
 
-	iio_buffer_put(buffer);
+	list_for_each_entry(b, &indio_dev->attached_buffers, attached_entry)
+		iio_buffer_put(b);
 }
 
 /**
@@ -1733,7 +1758,7 @@ void iio_buffer_put(struct iio_buffer *buffer)
 EXPORT_SYMBOL_GPL(iio_buffer_put);
 
 /**
- * iio_device_attach_buffer - Attach a buffer to a IIO device
+ * iio_device_attach_buffer_dir - Attach a buffer to a IIO device direction
  * @indio_dev: The device the buffer should be attached to
  * @buffer: The buffer to attach to the device
  *
@@ -1744,8 +1769,13 @@ EXPORT_SYMBOL_GPL(iio_buffer_put);
 void iio_device_attach_buffer(struct iio_dev *indio_dev,
 			      struct iio_buffer *buffer)
 {
-	indio_dev->buffer = iio_buffer_get(buffer);
+	buffer = iio_buffer_get(buffer);
+	buffer->indio_dev = indio_dev;
+
+	/* keep this for legacy */
+	if (!indio_dev->buffer)
+		indio_dev->buffer = buffer;
 
-	indio_dev->buffer->indio_dev = indio_dev;
+	list_add_tail(&buffer->attached_entry, &indio_dev->attached_buffers);
 }
 EXPORT_SYMBOL_GPL(iio_device_attach_buffer);
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index b27fabf13e9c..067e5de76b6c 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1534,6 +1534,7 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
 	}
 	dev_set_name(&dev->dev, "iio:device%d", dev->id);
 	INIT_LIST_HEAD(&dev->buffer_list);
+	INIT_LIST_HEAD(&dev->attached_buffers);
 	INIT_LIST_HEAD(&dev->ioctl_handlers);
 
 	return dev;
diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
index e8203b6d51a1..9ee3a7c0a657 100644
--- a/include/linux/iio/buffer_impl.h
+++ b/include/linux/iio/buffer_impl.h
@@ -130,6 +130,9 @@ struct iio_buffer {
 	/* @demux_bounce: Buffer for doing gather from incoming scan. */
 	void *demux_bounce;
 
+	/* @attached_buffers: Entry in the devices list of attached buffers. */
+	struct list_head attached_entry;
+
 	/* @buffer_list: Entry in the devices list of current buffers. */
 	struct list_head buffer_list;
 
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 671f5818fa67..32ba1a303454 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -492,6 +492,7 @@ struct iio_buffer_setup_ops {
  * @event_interface:	[INTERN] event chrdevs associated with interrupt lines
  * @buffer:		[DRIVER] any buffer present
  * @buffer_list:	[INTERN] list of all buffers currently attached
+ * @attached_buffers:	[INTERN] list of all attached buffers
  * @scan_bytes:		[INTERN] num bytes captured to be fed to buffer demux
  * @mlock:		[INTERN] lock used to prevent simultaneous device state
  *			changes
@@ -536,6 +537,7 @@ struct iio_dev {
 
 	struct iio_buffer		*buffer;
 	struct list_head		buffer_list;
+	struct list_head		attached_buffers;
 	int				scan_bytes;
 	struct mutex			mlock;
 
-- 
2.17.1

