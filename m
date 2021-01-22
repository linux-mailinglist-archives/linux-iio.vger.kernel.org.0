Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC193007F4
	for <lists+linux-iio@lfdr.de>; Fri, 22 Jan 2021 16:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbhAVP4l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Jan 2021 10:56:41 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:38258 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729210AbhAVP4a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Jan 2021 10:56:30 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10MFU9K7004779;
        Fri, 22 Jan 2021 10:55:38 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3668rcjhxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jan 2021 10:55:38 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 10MFtbsk002579
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Jan 2021 10:55:37 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Fri, 22 Jan 2021 10:55:36 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Fri, 22 Jan 2021 10:55:36 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Fri, 22 Jan 2021 10:55:36 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 10MFtF5F014933;
        Fri, 22 Jan 2021 10:55:33 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 12/12] iio: buffer: add ioctl() to support opening extra buffers for IIO device
Date:   Fri, 22 Jan 2021 17:58:05 +0200
Message-ID: <20210122155805.83012-13-alexandru.ardelean@analog.com>
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

With this change, an ioctl() call is added to open a character device for a
buffer.
The ioctl() will return a 0 FD for the first buffer, as that FD for buffer0
is the same FD as the one used for this ioctl().

For any other extra buffer, this ioctl() will return an anon inode FD that
would access any extra buffer.

Right now, there doesn't seem to be (or I couldn't find) a way for this
ioctl() to return the FD for buffer0 (i.e. to return the same FD as used
for the ioctl()).
So, usespace would need to know that  ioctl(fd,
IIO_BUFFER_GET_BUFFER_COUNT, 0) will return FD 0.
We could also return another FD for buffer 0, but duplicating FDs for the
same IIO buffer sounds problematic.

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

 #define IIO_BUFFER_GET_FD_IOCTL      _IOWR('i', 0xb0, int)

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
 Got FD 0

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
 drivers/iio/industrialio-buffer.c | 119 ++++++++++++++++++++++++++++++
 drivers/iio/industrialio-core.c   |   8 ++
 include/linux/iio/buffer_impl.h   |   5 ++
 include/linux/iio/iio-opaque.h    |   2 +
 include/uapi/linux/iio/buffer.h   |  10 +++
 5 files changed, 144 insertions(+)
 create mode 100644 include/uapi/linux/iio/buffer.h

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 2f429616e998..e619ec35c431 100644
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
@@ -1399,6 +1400,106 @@ static void iio_sysfs_del_attrs(struct kobject *kobj, struct attribute **ptr)
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
+	if (idx == 0) {
+		fd = 0;
+		if (copy_to_user(ival, &fd, sizeof(fd)))
+			return -EFAULT;
+		return 0;
+	}
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
 /**
  * __iio_buffer_alloc_sysfs_and_mask() - Allocate sysfs attributes to an attached buffer
  * @buffer: the buffer object for which the sysfs attributes are created for
@@ -1565,6 +1666,7 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 	struct iio_buffer *buffer = indio_dev->buffer;
 	const struct iio_chan_spec *channels;
 	int i, cnt, ret;
+	size_t sz;
 
 	channels = indio_dev->channels;
 	if (channels) {
@@ -1597,8 +1699,21 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 	if (ret)
 		goto error_remove_buffer_dir_link;
 
+	sz = sizeof(*(iio_dev_opaque->buffer_ioctl_handler));
+	iio_dev_opaque->buffer_ioctl_handler = kzalloc(sz, GFP_KERNEL);
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
 	cnt = iio_dev_opaque->attached_buffers_cnt - 1;
@@ -1627,6 +1742,10 @@ void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
 	if (!buffer)
 		return;
 
+	iio_device_ioctl_handler_unregister(iio_dev_opaque->buffer_ioctl_handler);
+	kfree(iio_dev_opaque->buffer_ioctl_handler);
+	iio_dev_opaque->buffer_ioctl_handler = NULL;
+
 	sysfs_remove_link(&indio_dev->dev.kobj, "scan_elements");
 	sysfs_remove_link(&indio_dev->dev.kobj, "buffer");
 
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 0d1880837776..898992fd33c3 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1683,6 +1683,9 @@ static int iio_chrdev_open(struct inode *inode, struct file *filp)
 	ib->indio_dev = indio_dev;
 	ib->buffer = indio_dev->buffer;
 
+	if (indio_dev->buffer)
+		test_and_set_bit(IIO_BUSY_BIT_POS, &indio_dev->buffer->flags);
+
 	filp->private_data = ib;
 
 	return 0;
@@ -1700,6 +1703,11 @@ static int iio_chrdev_release(struct inode *inode, struct file *filp)
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
index 000000000000..5455f7ff143d
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
+#define IIO_BUFFER_GET_FD_IOCTL		_IOWR('i', 0xb0, int)
+
+#endif /* _UAPI_IIO_BUFFER_H_ */
-- 
2.17.1

