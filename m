Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC4F31B774
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 11:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhBOKkk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 05:40:40 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:4594 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230247AbhBOKkP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2021 05:40:15 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11FAZlFf028602;
        Mon, 15 Feb 2021 05:39:21 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36pcjamakf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 05:39:21 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11FAdKDt023171
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 15 Feb 2021 05:39:20 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 15 Feb
 2021 05:39:19 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Mon, 15 Feb 2021 05:39:19 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11FAcQUn017530;
        Mon, 15 Feb 2021 05:39:17 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v6 20/24] iio: buffer: add ioctl() to support opening extra buffers for IIO device
Date:   Mon, 15 Feb 2021 12:40:39 +0200
Message-ID: <20210215104043.91251-21-alexandru.ardelean@analog.com>
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

With this change, an ioctl() call is added to open a character device for a
buffer. The ioctl() number is 'i' 0x91, which follows the
IIO_GET_EVENT_FD_IOCTL ioctl.

The ioctl() will return an FD for the requested buffer index. The indexes
are the same from the /sys/iio/devices/iio:deviceX/bufferY (i.e. the Y
variable).

Since there doesn't seem to be a sane way to return the FD for buffer0 to
be the same FD for the /dev/iio:deviceX, this ioctl() will return another
FD for buffer0 (or the first buffer). This duplicate FD will be able to
access the same buffer object (for buffer0) as accessing directly the
/dev/iio:deviceX chardev.

Also, there is no IIO_BUFFER_GET_BUFFER_COUNT ioctl() implemented, as the
index for each buffer (and the count) can be deduced from the
'/sys/bus/iio/devices/iio:deviceX/bufferY' folders (i.e the number of
bufferY folders).

Used following C code to test this:
-------------------------------------------------------------------

 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <sys/ioctl.h>
 #include <fcntl.h"
 #include <errno.h>

 #define IIO_BUFFER_GET_FD_IOCTL      _IOWR('i', 0x91, int)

int main(int argc, char *argv[])
{
        int fd;
        int fd1;
        int ret;

        if ((fd = open("/dev/iio:device0", O_RDWR))<0) {
                fprintf(stderr, "Error open() %d errno %d\n",fd, errno);
                return -1;
        }

        fprintf(stderr, "Using FD %d\n", fd);

        fd1 = atoi(argv[1]);

        ret = ioctl(fd, IIO_BUFFER_GET_FD_IOCTL, &fd1);
        if (ret < 0) {
                fprintf(stderr, "Error for buffer %d ioctl() %d errno %d\n", fd1, ret, errno);
                close(fd);
                return -1;
        }

        fprintf(stderr, "Got FD %d\n", fd1);

        close(fd1);
        close(fd);

        return 0;
}
-------------------------------------------------------------------

Results are:
-------------------------------------------------------------------
 # ./test 0
 Using FD 3
 Got FD 4

 # ./test 1
 Using FD 3
 Got FD 4

 # ./test 2
 Using FD 3
 Got FD 4

 # ./test 3
 Using FD 3
 Got FD 4

 # ls /sys/bus/iio/devices/iio\:device0
 buffer  buffer0  buffer1  buffer2  buffer3  dev
 in_voltage_sampling_frequency  in_voltage_scale
 in_voltage_scale_available
 name  of_node  power  scan_elements  subsystem  uevent
-------------------------------------------------------------------

iio:device0 has some fake kfifo buffers attached to an IIO device.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/iio_core.h            |  12 +--
 drivers/iio/industrialio-buffer.c | 144 ++++++++++++++++++++++++++++--
 include/linux/iio/buffer_impl.h   |   5 ++
 include/linux/iio/iio-opaque.h    |   2 +
 include/uapi/linux/iio/buffer.h   |  10 +++
 5 files changed, 162 insertions(+), 11 deletions(-)
 create mode 100644 include/uapi/linux/iio/buffer.h

diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index 7990c759f1f5..062fe16c6c49 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -64,16 +64,16 @@ ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals);
 #ifdef CONFIG_IIO_BUFFER
 struct poll_table_struct;
 
-__poll_t iio_buffer_poll(struct file *filp,
-			     struct poll_table_struct *wait);
-ssize_t iio_buffer_read_outer(struct file *filp, char __user *buf,
-			      size_t n, loff_t *f_ps);
+__poll_t iio_buffer_poll_wrapper(struct file *filp,
+				 struct poll_table_struct *wait);
+ssize_t iio_buffer_read_wrapper(struct file *filp, char __user *buf,
+				size_t n, loff_t *f_ps);
 
 int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev);
 void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev);
 
-#define iio_buffer_poll_addr (&iio_buffer_poll)
-#define iio_buffer_read_outer_addr (&iio_buffer_read_outer)
+#define iio_buffer_poll_addr (&iio_buffer_poll_wrapper)
+#define iio_buffer_read_outer_addr (&iio_buffer_read_wrapper)
 
 void iio_disable_all_buffers(struct iio_dev *indio_dev);
 void iio_buffer_wakeup_poll(struct iio_dev *indio_dev);
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 7b5827b91280..4848932d4394 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -9,9 +9,11 @@
  * - Better memory allocation techniques?
  * - Alternative access techniques?
  */
+#include <linux/anon_inodes.h>
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/device.h>
+#include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/cdev.h>
 #include <linux/slab.h>
@@ -89,7 +91,7 @@ static bool iio_buffer_ready(struct iio_dev *indio_dev, struct iio_buffer *buf,
 }
 
 /**
- * iio_buffer_read_outer() - chrdev read for buffer access
+ * iio_buffer_read() - chrdev read for buffer access
  * @filp:	File structure pointer for the char device
  * @buf:	Destination buffer for iio buffer read
  * @n:		First n bytes to read
@@ -101,8 +103,8 @@ static bool iio_buffer_ready(struct iio_dev *indio_dev, struct iio_buffer *buf,
  * Return: negative values corresponding to error codes or ret != 0
  *	   for ending the reading activity
  **/
-ssize_t iio_buffer_read_outer(struct file *filp, char __user *buf,
-			      size_t n, loff_t *f_ps)
+static ssize_t iio_buffer_read(struct file *filp, char __user *buf,
+			       size_t n, loff_t *f_ps)
 {
 	struct iio_dev_buffer_pair *ib = filp->private_data;
 	struct iio_buffer *rb = ib->buffer;
@@ -168,8 +170,8 @@ ssize_t iio_buffer_read_outer(struct file *filp, char __user *buf,
  * Return: (EPOLLIN | EPOLLRDNORM) if data is available for reading
  *	   or 0 for other cases
  */
-__poll_t iio_buffer_poll(struct file *filp,
-			     struct poll_table_struct *wait)
+static __poll_t iio_buffer_poll(struct file *filp,
+				struct poll_table_struct *wait)
 {
 	struct iio_dev_buffer_pair *ib = filp->private_data;
 	struct iio_buffer *rb = ib->buffer;
@@ -184,6 +186,32 @@ __poll_t iio_buffer_poll(struct file *filp,
 	return 0;
 }
 
+ssize_t iio_buffer_read_wrapper(struct file *filp, char __user *buf,
+				size_t n, loff_t *f_ps)
+{
+	struct iio_dev_buffer_pair *ib = filp->private_data;
+	struct iio_buffer *rb = ib->buffer;
+
+	/* check if buffer was opened through new API */
+	if (test_bit(IIO_BUSY_BIT_POS, &rb->flags))
+		return -EBUSY;
+
+	return iio_buffer_read(filp, buf, n, f_ps);
+}
+
+__poll_t iio_buffer_poll_wrapper(struct file *filp,
+				 struct poll_table_struct *wait)
+{
+	struct iio_dev_buffer_pair *ib = filp->private_data;
+	struct iio_buffer *rb = ib->buffer;
+
+	/* check if buffer was opened through new API */
+	if (test_bit(IIO_BUSY_BIT_POS, &rb->flags))
+		return 0;
+
+	return iio_buffer_poll(filp, wait);
+}
+
 /**
  * iio_buffer_wakeup_poll - Wakes up the buffer waitqueue
  * @indio_dev: The IIO device
@@ -1343,6 +1371,96 @@ static void iio_buffer_unregister_legacy_sysfs_groups(struct iio_dev *indio_dev)
 	kfree(iio_dev_opaque->legacy_scan_el_group.attrs);
 }
 
+static int iio_buffer_chrdev_release(struct inode *inode, struct file *filep)
+{
+	struct iio_dev_buffer_pair *ib = filep->private_data;
+	struct iio_dev *indio_dev = ib->indio_dev;
+	struct iio_buffer *buffer = ib->buffer;
+
+	wake_up(&buffer->pollq);
+
+	kfree(ib);
+	clear_bit(IIO_BUSY_BIT_POS, &buffer->flags);
+	iio_device_put(indio_dev);
+
+	return 0;
+}
+
+static const struct file_operations iio_buffer_chrdev_fileops = {
+	.owner = THIS_MODULE,
+	.llseek = noop_llseek,
+	.read = iio_buffer_read,
+	.poll = iio_buffer_poll,
+	.release = iio_buffer_chrdev_release,
+};
+
+static long iio_device_buffer_getfd(struct iio_dev *indio_dev, unsigned long arg)
+{
+	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
+	int __user *ival = (int __user *)arg;
+	struct iio_dev_buffer_pair *ib;
+	struct iio_buffer *buffer;
+	int fd, idx, ret;
+
+	if (copy_from_user(&idx, ival, sizeof(idx)))
+		return -EFAULT;
+
+	if (idx >= iio_dev_opaque->attached_buffers_cnt)
+		return -ENODEV;
+
+	iio_device_get(indio_dev);
+
+	buffer = iio_dev_opaque->attached_buffers[idx];
+
+	if (test_and_set_bit(IIO_BUSY_BIT_POS, &buffer->flags)) {
+		ret = -EBUSY;
+		goto error_iio_dev_put;
+	}
+
+	ib = kzalloc(sizeof(*ib), GFP_KERNEL);
+	if (!ib) {
+		ret = -ENOMEM;
+		goto error_clear_busy_bit;
+	}
+
+	ib->indio_dev = indio_dev;
+	ib->buffer = buffer;
+
+	fd = anon_inode_getfd("iio:buffer", &iio_buffer_chrdev_fileops,
+			      ib, O_RDWR | O_CLOEXEC);
+	if (fd < 0) {
+		ret = fd;
+		goto error_free_ib;
+	}
+
+	if (copy_to_user(ival, &fd, sizeof(fd))) {
+		put_unused_fd(fd);
+		ret = -EFAULT;
+		goto error_free_ib;
+	}
+
+	return fd;
+
+error_free_ib:
+	kfree(ib);
+error_clear_busy_bit:
+	clear_bit(IIO_BUSY_BIT_POS, &buffer->flags);
+error_iio_dev_put:
+	iio_device_put(indio_dev);
+	return ret;
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
 					     int index)
@@ -1472,6 +1590,7 @@ int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 	struct iio_buffer *buffer;
 	int unwind_idx;
 	int ret, i;
+	size_t sz;
 
 	channels = indio_dev->channels;
 	if (channels) {
@@ -1493,6 +1612,18 @@ int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 			goto error_unwind_sysfs_and_mask;
 		}
 	}
+	unwind_idx = iio_dev_opaque->attached_buffers_cnt - 1;
+
+	sz = sizeof(*(iio_dev_opaque->buffer_ioctl_handler));
+	iio_dev_opaque->buffer_ioctl_handler = kzalloc(sz, GFP_KERNEL);
+	if (!iio_dev_opaque->buffer_ioctl_handler) {
+		ret = -ENOMEM;
+		goto error_unwind_sysfs_and_mask;
+	}
+
+	iio_dev_opaque->buffer_ioctl_handler->ioctl = iio_device_buffer_ioctl;
+	iio_device_ioctl_handler_register(indio_dev,
+					  iio_dev_opaque->buffer_ioctl_handler);
 
 	return 0;
 
@@ -1514,6 +1645,9 @@ void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev)
 	if (!iio_dev_opaque->attached_buffers_cnt)
 		return;
 
+	iio_device_ioctl_handler_unregister(iio_dev_opaque->buffer_ioctl_handler);
+	kfree(iio_dev_opaque->buffer_ioctl_handler);
+
 	iio_buffer_unregister_legacy_sysfs_groups(indio_dev);
 
 	for (i = iio_dev_opaque->attached_buffers_cnt - 1; i >= 0; i--) {
diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
index 768b90c64412..245b32918ae1 100644
--- a/include/linux/iio/buffer_impl.h
+++ b/include/linux/iio/buffer_impl.h
@@ -6,6 +6,8 @@
 
 #ifdef CONFIG_IIO_BUFFER
 
+#include <uapi/linux/iio/buffer.h>
+
 struct iio_dev;
 struct iio_buffer;
 
@@ -72,6 +74,9 @@ struct iio_buffer {
 	/** @length: Number of datums in buffer. */
 	unsigned int length;
 
+	/** @flags: File ops flags including busy flag. */
+	unsigned long flags;
+
 	/**  @bytes_per_datum: Size of individual datum including timestamp. */
 	size_t bytes_per_datum;
 
diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
index b6ebc04af3e7..32addd5e790e 100644
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
@@ -28,6 +29,7 @@ struct iio_dev_opaque {
 	struct iio_event_interface	*event_interface;
 	struct iio_buffer		**attached_buffers;
 	unsigned int			attached_buffers_cnt;
+	struct iio_ioctl_handler	*buffer_ioctl_handler;
 	struct list_head		buffer_list;
 	struct list_head		channel_attr_list;
 	struct attribute_group		chan_attr_group;
diff --git a/include/uapi/linux/iio/buffer.h b/include/uapi/linux/iio/buffer.h
new file mode 100644
index 000000000000..13939032b3f6
--- /dev/null
+++ b/include/uapi/linux/iio/buffer.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* industrial I/O buffer definitions needed both in and out of kernel
+ */
+
+#ifndef _UAPI_IIO_BUFFER_H_
+#define _UAPI_IIO_BUFFER_H_
+
+#define IIO_BUFFER_GET_FD_IOCTL			_IOWR('i', 0x91, int)
+
+#endif /* _UAPI_IIO_BUFFER_H_ */
-- 
2.17.1

