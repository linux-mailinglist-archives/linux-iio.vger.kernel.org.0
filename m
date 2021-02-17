Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAF931D6A2
	for <lists+linux-iio@lfdr.de>; Wed, 17 Feb 2021 09:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhBQIeI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Feb 2021 03:34:08 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:48460 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231866AbhBQIdo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Feb 2021 03:33:44 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11H8ULwO026117;
        Wed, 17 Feb 2021 03:32:51 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36p9gb2hue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Feb 2021 03:32:51 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11H8WnQn007674
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 17 Feb 2021 03:32:49 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 17 Feb 2021 00:32:48 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 17 Feb 2021 00:32:47 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11H8WWlG007757;
        Wed, 17 Feb 2021 03:32:44 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 2/5] iio: Add output buffer support
Date:   Wed, 17 Feb 2021 10:34:35 +0200
Message-ID: <20210217083438.37865-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210217083438.37865-1-alexandru.ardelean@analog.com>
References: <20210217083438.37865-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-17_06:2021-02-16,2021-02-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102170064
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Currently IIO only supports buffer mode for capture devices like ADCs. Add
support for buffered mode for output devices like DACs.

The output buffer implementation is analogous to the input buffer
implementation. Instead of using read() to get data from the buffer write()
is used to copy data into the buffer.

poll() with POLLOUT will wakeup if there is space available for more or
equal to the configured watermark of samples.

Drivers can remove data from a buffer using iio_buffer_remove_sample(), the
function can e.g. called from a trigger handler to write the data to
hardware.

A buffer can only be either a output buffer or an input, but not both. So,
for a device that has an ADC and DAC path, this will mean 2 IIO buffers
(one for each direction).

The direction of the buffer is decided by the new direction field of the
iio_buffer struct and should be set after allocating and before registering
it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio |   7 ++
 drivers/iio/industrialio-buffer.c       | 128 +++++++++++++++++++++++-
 include/linux/iio/buffer.h              |   7 ++
 include/linux/iio/buffer_impl.h         |  11 ++
 4 files changed, 149 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index f2a72d7fbacb..a42b915bf585 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1124,6 +1124,13 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Number of scans contained by the buffer.
 
+What:		/sys/bus/iio/devices/iio:deviceX/bufferY/direction
+KernelVersion:	5.11
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Returns the direction of the data stream of the buffer.
+		The output is "in" or "out".
+
 What:		/sys/bus/iio/devices/iio:deviceX/buffer/enable
 KernelVersion:	2.6.35
 What:		/sys/bus/iio/devices/iio:deviceX/bufferY/enable
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 5d641f8adfbd..b9970c68005d 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -162,6 +162,69 @@ static ssize_t iio_buffer_read(struct file *filp, char __user *buf,
 	return ret;
 }
 
+static size_t iio_buffer_space_available(struct iio_buffer *buf)
+{
+	if (buf->access->space_available)
+		return buf->access->space_available(buf);
+
+	return SIZE_MAX;
+}
+
+static ssize_t iio_buffer_write(struct file *filp, const char __user *buf,
+				size_t n, loff_t *f_ps)
+{
+	struct iio_dev_buffer_pair *ib = filp->private_data;
+	struct iio_buffer *rb = ib->buffer;
+	struct iio_dev *indio_dev = ib->indio_dev;
+	DEFINE_WAIT_FUNC(wait, woken_wake_function);
+	size_t datum_size;
+	size_t to_wait;
+	int ret;
+
+	if (!rb || !rb->access->write)
+		return -EINVAL;
+
+	datum_size = rb->bytes_per_datum;
+
+	/*
+	 * If datum_size is 0 there will never be anything to read from the
+	 * buffer, so signal end of file now.
+	 */
+	if (!datum_size)
+		return 0;
+
+	if (filp->f_flags & O_NONBLOCK)
+		to_wait = 0;
+	else
+		to_wait = min_t(size_t, n / datum_size, rb->watermark);
+
+	add_wait_queue(&rb->pollq, &wait);
+	do {
+		if (!indio_dev->info) {
+			ret = -ENODEV;
+			break;
+		}
+
+		if (iio_buffer_space_available(rb) < to_wait) {
+			if (signal_pending(current)) {
+				ret = -ERESTARTSYS;
+				break;
+			}
+
+			wait_woken(&wait, TASK_INTERRUPTIBLE,
+				   MAX_SCHEDULE_TIMEOUT);
+			continue;
+		}
+
+		ret = rb->access->write(rb, n, buf);
+		if (ret == 0 && (filp->f_flags & O_NONBLOCK))
+			ret = -EAGAIN;
+	} while (ret == 0);
+	remove_wait_queue(&rb->pollq, &wait);
+
+	return ret;
+}
+
 /**
  * iio_buffer_poll() - poll the buffer to find out if it has data
  * @filp:	File structure pointer for device access
@@ -182,8 +245,19 @@ static __poll_t iio_buffer_poll(struct file *filp,
 		return 0;
 
 	poll_wait(filp, &rb->pollq, wait);
-	if (iio_buffer_ready(indio_dev, rb, rb->watermark, 0))
-		return EPOLLIN | EPOLLRDNORM;
+
+	switch (rb->direction) {
+	case IIO_BUFFER_DIRECTION_IN:
+		if (iio_buffer_ready(indio_dev, rb, rb->watermark, 0))
+			return EPOLLIN | EPOLLRDNORM;
+		break;
+	case IIO_BUFFER_DIRECTION_OUT:
+		if (iio_buffer_space_available(rb) >= rb->watermark)
+			return EPOLLOUT | EPOLLWRNORM;
+		break;
+	}
+
+	/* need a way of knowing if there may be enough data... */
 	return 0;
 }
 
@@ -232,6 +306,16 @@ void iio_buffer_wakeup_poll(struct iio_dev *indio_dev)
 	}
 }
 
+int iio_buffer_remove_sample(struct iio_buffer *buffer, u8 *data)
+{
+	if (!buffer || !buffer->access)
+		return -EINVAL;
+	if (!buffer->access->write)
+		return -ENOSYS;
+	return buffer->access->remove_from(buffer, data);
+}
+EXPORT_SYMBOL_GPL(iio_buffer_remove_sample);
+
 void iio_buffer_init(struct iio_buffer *buffer)
 {
 	INIT_LIST_HEAD(&buffer->demux_list);
@@ -803,6 +887,8 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 	}
 
 	if (insert_buffer) {
+		if (insert_buffer->direction == IIO_BUFFER_DIRECTION_OUT)
+			strict_scanmask = true;
 		bitmap_or(compound_mask, compound_mask,
 			  insert_buffer->scan_mask, indio_dev->masklength);
 		scan_timestamp |= insert_buffer->scan_timestamp;
@@ -945,6 +1031,8 @@ static int iio_update_demux(struct iio_dev *indio_dev)
 	int ret;
 
 	list_for_each_entry(buffer, &iio_dev_opaque->buffer_list, buffer_list) {
+		if (buffer->direction == IIO_BUFFER_DIRECTION_OUT)
+			continue;
 		ret = iio_buffer_update_demux(indio_dev, buffer);
 		if (ret < 0)
 			goto error_clear_mux_table;
@@ -1155,6 +1243,11 @@ int iio_update_buffers(struct iio_dev *indio_dev,
 	mutex_lock(&indio_dev->info_exist_lock);
 	mutex_lock(&indio_dev->mlock);
 
+	if (insert_buffer->direction == IIO_BUFFER_DIRECTION_OUT) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	if (insert_buffer && iio_buffer_is_active(insert_buffer))
 		insert_buffer = NULL;
 
@@ -1273,6 +1366,22 @@ static ssize_t iio_dma_show_data_available(struct device *dev,
 	return sprintf(buf, "%zu\n", iio_buffer_data_available(buffer));
 }
 
+static ssize_t direction_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
+
+	switch (buffer->direction) {
+	case IIO_BUFFER_DIRECTION_IN:
+		return sprintf(buf, "in\n");
+	case IIO_BUFFER_DIRECTION_OUT:
+		return sprintf(buf, "out\n");
+	default:
+		return -EINVAL;
+	}
+}
+
 static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
 		   iio_buffer_write_length);
 static struct device_attribute dev_attr_length_ro = __ATTR(length,
@@ -1285,9 +1394,11 @@ static struct device_attribute dev_attr_watermark_ro = __ATTR(watermark,
 	S_IRUGO, iio_buffer_show_watermark, NULL);
 static DEVICE_ATTR(data_available, S_IRUGO,
 		iio_dma_show_data_available, NULL);
+static DEVICE_ATTR_RO(direction);
 
 static struct attribute *iio_buffer_attrs[] = {
 	&dev_attr_length.attr,
+	&dev_attr_direction.attr,
 	&dev_attr_enable.attr,
 	&dev_attr_watermark.attr,
 	&dev_attr_data_available.attr,
@@ -1401,6 +1512,7 @@ static const struct file_operations iio_buffer_chrdev_fileops = {
 	.owner = THIS_MODULE,
 	.llseek = noop_llseek,
 	.read = iio_buffer_read,
+	.write = iio_buffer_write,
 	.poll = iio_buffer_poll,
 	.unlocked_ioctl = iio_buffer_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
@@ -1920,8 +2032,16 @@ static int iio_buffer_mmap(struct file *filep, struct vm_area_struct *vma)
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
-	if (!(vma->vm_flags & VM_READ))
-		return -EINVAL;
+	switch (buffer->direction) {
+	case IIO_BUFFER_DIRECTION_IN:
+		if (!(vma->vm_flags & VM_READ))
+			return -EINVAL;
+		break;
+	case IIO_BUFFER_DIRECTION_OUT:
+		if (!(vma->vm_flags & VM_WRITE))
+			return -EINVAL;
+		break;
+	}
 
 	return buffer->access->mmap(buffer, vma);
 }
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index b6928ac5c63d..e87b8773253d 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -11,8 +11,15 @@
 
 struct iio_buffer;
 
+enum iio_buffer_direction {
+	IIO_BUFFER_DIRECTION_IN,
+	IIO_BUFFER_DIRECTION_OUT,
+};
+
 int iio_push_to_buffers(struct iio_dev *indio_dev, const void *data);
 
+int iio_buffer_remove_sample(struct iio_buffer *buffer, u8 *data);
+
 /**
  * iio_push_to_buffers_with_timestamp() - push data and timestamp to buffers
  * @indio_dev:		iio_dev structure for device.
diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
index 1d57dc7ccb4f..47bdbf4a4519 100644
--- a/include/linux/iio/buffer_impl.h
+++ b/include/linux/iio/buffer_impl.h
@@ -7,6 +7,7 @@
 #ifdef CONFIG_IIO_BUFFER
 
 #include <uapi/linux/iio/buffer.h>
+#include <linux/iio/buffer.h>
 
 struct iio_dev;
 struct iio_buffer;
@@ -23,6 +24,10 @@ struct iio_buffer;
  * @read:		try to get a specified number of bytes (must exist)
  * @data_available:	indicates how much data is available for reading from
  *			the buffer.
+ * @remove_from:	remove sample from buffer. Drivers should calls this to
+ *			remove a sample from a buffer.
+ * @write:		try to write a number of bytes
+ * @space_available:	returns the amount of bytes available in a buffer
  * @request_update:	if a parameter change has been marked, update underlying
  *			storage.
  * @set_bytes_per_datum:set number of bytes per datum
@@ -61,6 +66,9 @@ struct iio_buffer_access_funcs {
 	int (*store_to)(struct iio_buffer *buffer, const void *data);
 	int (*read)(struct iio_buffer *buffer, size_t n, char __user *buf);
 	size_t (*data_available)(struct iio_buffer *buffer);
+	int (*remove_from)(struct iio_buffer *buffer, void *data);
+	int (*write)(struct iio_buffer *buffer, size_t n, const char __user *buf);
+	size_t (*space_available)(struct iio_buffer *buffer);
 
 	int (*request_update)(struct iio_buffer *buffer);
 
@@ -103,6 +111,9 @@ struct iio_buffer {
 	/**  @bytes_per_datum: Size of individual datum including timestamp. */
 	size_t bytes_per_datum;
 
+	/* @direction: Direction of the data stream (in/out). */
+	enum iio_buffer_direction direction;
+
 	/**
 	 * @access: Buffer access functions associated with the
 	 * implementation.
-- 
2.17.1

