Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65032B69DD
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 17:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgKQQTD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 11:19:03 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:36964 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727877AbgKQQTC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 11:19:02 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AHGImGs028498;
        Tue, 17 Nov 2020 11:18:49 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 34td199y85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 11:18:48 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0AHGIjcx044690
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 17 Nov 2020 11:18:45 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 17 Nov 2020 11:18:44 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 17 Nov 2020 11:18:44 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 17 Nov 2020 11:18:44 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0AHGIRTY032565;
        Tue, 17 Nov 2020 11:18:42 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 12/12] iio: buffer: add ioctl() to support opening extra buffers for IIO device
Date:   Tue, 17 Nov 2020 18:23:40 +0200
Message-ID: <20201117162340.43924-13-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117162340.43924-1-alexandru.ardelean@analog.com>
References: <20201117162340.43924-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_06:2020-11-17,2020-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=2
 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170117
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

With this change, an ioctl() call is added to open a character device for a
buffer.
The ioctl() will not work for the first buffer, as that buffer is already
opened/reserved for the IIO device's character device.
This is also to preserve backwards compatibility.

For any other extra buffer (after the first buffer) this ioctl() will be
required.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-buffer.c | 111 ++++++++++++++++++++++++++++++
 drivers/iio/industrialio-core.c   |   8 +++
 include/linux/iio/buffer_impl.h   |   5 ++
 include/linux/iio/iio-opaque.h    |   2 +
 include/uapi/linux/iio/buffer.h   |  16 +++++
 5 files changed, 142 insertions(+)
 create mode 100644 include/uapi/linux/iio/buffer.h

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index daa68822cea7..77f02870cd18 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -9,6 +9,7 @@
  * - Better memory allocation techniques?
  * - Alternative access techniques?
  */
+#include <linux/anon_inodes.h>
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/device.h>
@@ -1399,6 +1400,99 @@ static void iio_sysfs_del_attrs(struct kobject *kobj, struct attribute **ptr)
 		sysfs_remove_file(kobj, ptr[i]);
 }
 
+static int iio_buffer_chrdev_release(struct inode *inode, struct file *filep)
+{
+	struct iio_dev_buffer_pair *ib = filep->private_data;
+	struct iio_dev *indio_dev = ib->indio_dev;
+	struct iio_buffer *buffer = ib->buffer;
+
+	clear_bit(IIO_BUSY_BIT_POS, &buffer->flags);
+	iio_device_put(indio_dev);
+	kfree(ib);
+
+	return 0;
+}
+
+static const struct file_operations iio_buffer_chrdev_fileops = {
+	.owner = THIS_MODULE,
+	.llseek = noop_llseek,
+	.read = iio_buffer_read_outer_addr,
+	.poll = iio_buffer_poll_addr,
+	.compat_ioctl = compat_ptr_ioctl,
+	.release = iio_buffer_chrdev_release,
+};
+
+static long iio_device_buffer_getfd(struct iio_dev *indio_dev, unsigned long arg)
+{
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+	int __user *ival = (int __user *)arg;
+	char buf_name[sizeof("iio:buffer:xxx")];
+	struct iio_dev_buffer_pair *ib;
+	struct iio_buffer *buffer;
+	int fd, idx;
+
+	if (copy_from_user(&idx, ival, sizeof(idx)))
+		return -EFAULT;
+
+	if (idx >= iio_dev_opaque->attached_buffers_cnt)
+		return -ENOENT;
+
+	fd = mutex_lock_interruptible(&indio_dev->mlock);
+	if (fd)
+		return fd;
+
+	buffer = iio_dev_opaque->attached_buffers[idx];
+
+	if (test_and_set_bit(IIO_BUSY_BIT_POS, &buffer->flags)) {
+		fd = -EBUSY;
+		goto error_unlock;
+	}
+
+	iio_device_get(indio_dev);
+
+	ib = kzalloc(sizeof(*ib), GFP_KERNEL);
+	if (!ib) {
+		fd = -ENOMEM;
+		goto error_iio_dev_put;
+	}
+
+	ib->indio_dev = indio_dev;
+	ib->buffer = buffer;
+
+	fd = anon_inode_getfd(buf_name, &iio_buffer_chrdev_fileops,
+			      ib, O_RDWR | O_CLOEXEC);
+	if (fd < 0)
+		goto error_free_ib;
+
+	if (copy_to_user(ival, &fd, sizeof(fd))) {
+		fd = -EFAULT;
+		goto error_free_ib;
+	}
+
+	mutex_unlock(&indio_dev->mlock);
+	return fd;
+
+error_free_ib:
+	kfree(ib);
+error_iio_dev_put:
+	iio_device_put(indio_dev);
+	clear_bit(IIO_BUSY_BIT_POS, &buffer->flags);
+error_unlock:
+	mutex_unlock(&indio_dev->mlock);
+	return fd;
+}
+
+static long iio_device_buffer_ioctl(struct iio_dev *indio_dev, struct file *filp,
+				    unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	case IIO_BUFFER_GET_FD_IOCTL:
+		return iio_device_buffer_getfd(indio_dev, arg);
+	default:
+		return IIO_IOCTL_UNHANDLED;
+	}
+}
+
 static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
 					     struct iio_dev *indio_dev,
 					     unsigned int idx)
@@ -1549,8 +1643,21 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 	if (ret)
 		goto error_remove_buffer_dir_link;
 
+	i = sizeof(*(iio_dev_opaque->buffer_ioctl_handler));
+	iio_dev_opaque->buffer_ioctl_handler = kzalloc(i, GFP_KERNEL);
+	if (!iio_dev_opaque->buffer_ioctl_handler) {
+		ret = -ENOMEM;
+		goto error_remove_scan_el_dir;
+	}
+
+	iio_dev_opaque->buffer_ioctl_handler->ioctl = iio_device_buffer_ioctl;
+	iio_device_ioctl_handler_register(indio_dev,
+					  iio_dev_opaque->buffer_ioctl_handler);
+
 	return 0;
 
+error_remove_scan_el_dir:
+	sysfs_remove_link(&indio_dev->dev.kobj, "scan_elements");
 error_remove_buffer_dir_link:
 	sysfs_remove_link(&indio_dev->dev.kobj, "buffer");
 	i = iio_dev_opaque->attached_buffers_cnt - 1;
@@ -1585,6 +1692,10 @@ void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
 	if (!buffer)
 		return;
 
+	iio_device_ioctl_handler_unregister(iio_dev_opaque->buffer_ioctl_handler);
+	kfree(iio_dev_opaque->buffer_ioctl_handler);
+	iio_dev_opaque->buffer_ioctl_handler = NULL;
+
 	sysfs_remove_link(&indio_dev->dev.kobj, "scan_elements");
 	sysfs_remove_link(&indio_dev->dev.kobj, "buffer");
 
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 9e7a76723f00..b4f7dd75bef5 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1685,6 +1685,9 @@ static int iio_chrdev_open(struct inode *inode, struct file *filp)
 	ib->indio_dev = indio_dev;
 	ib->buffer = indio_dev->buffer;
 
+	if (indio_dev->buffer)
+		test_and_set_bit(IIO_BUSY_BIT_POS, &indio_dev->buffer->flags);
+
 	filp->private_data = ib;
 
 	return 0;
@@ -1702,6 +1705,11 @@ static int iio_chrdev_release(struct inode *inode, struct file *filp)
 	struct iio_dev_buffer_pair *ib = filp->private_data;
 	struct iio_dev *indio_dev = container_of(inode->i_cdev,
 						struct iio_dev, chrdev);
+	struct iio_buffer *buffer = ib->buffer;
+
+	if (buffer)
+		clear_bit(IIO_BUSY_BIT_POS, &buffer->flags);
+
 	clear_bit(IIO_BUSY_BIT_POS, &indio_dev->flags);
 	iio_device_put(indio_dev);
 	kfree(ib);
diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
index e25d26a7f601..78da590b5607 100644
--- a/include/linux/iio/buffer_impl.h
+++ b/include/linux/iio/buffer_impl.h
@@ -6,6 +6,8 @@
 
 #ifdef CONFIG_IIO_BUFFER
 
+#include <uapi/linux/iio/buffer.h>
+
 struct iio_dev;
 struct iio_buffer;
 
@@ -75,6 +77,9 @@ struct iio_buffer {
 	/** @length: Number of datums in buffer. */
 	unsigned int length;
 
+	/** @flags: File ops flags including busy flag. */
+	unsigned long flags;
+
 	/**  @bytes_per_datum: Size of individual datum including timestamp. */
 	size_t bytes_per_datum;
 
diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
index 1db0ea09520e..d0429b13afa8 100644
--- a/include/linux/iio/iio-opaque.h
+++ b/include/linux/iio/iio-opaque.h
@@ -9,6 +9,7 @@
  * @event_interface:		event chrdevs associated with interrupt lines
  * @attached_buffers:		array of buffers statically attached by the driver
  * @attached_buffers_cnt:	number of buffers in the array of statically attached buffers
+ * @buffer_ioctl_handler:	ioctl() handler for this IIO device's buffer interface
  * @buffer_list:		list of all buffers currently attached
  * @channel_attr_list:		keep track of automatically created channel
  *				attributes
@@ -24,6 +25,7 @@ struct iio_dev_opaque {
 	struct iio_event_interface	*event_interface;
 	struct iio_buffer		**attached_buffers;
 	unsigned int			attached_buffers_cnt;
+	struct iio_ioctl_handler	*buffer_ioctl_handler;
 	struct list_head		buffer_list;
 	struct list_head		channel_attr_list;
 	struct attribute_group		chan_attr_group;
diff --git a/include/uapi/linux/iio/buffer.h b/include/uapi/linux/iio/buffer.h
new file mode 100644
index 000000000000..3794eca78dad
--- /dev/null
+++ b/include/uapi/linux/iio/buffer.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* industrial I/O buffer definitions needed both in and out of kernel
+ *
+ * Copyright (c) 2020 Alexandru Ardelean
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#ifndef _UAPI_IIO_BUFFER_H_
+#define _UAPI_IIO_BUFFER_H_
+
+#define IIO_BUFFER_GET_FD_IOCTL		_IOWR('i', 0xa0, int)
+
+#endif /* _UAPI_IIO_BUFFER_H_ */
-- 
2.17.1

