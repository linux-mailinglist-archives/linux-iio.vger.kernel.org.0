Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB11B40E9D6
	for <lists+linux-iio@lfdr.de>; Thu, 16 Sep 2021 20:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbhIPSbJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Sep 2021 14:31:09 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:23122 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241880AbhIPSbE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Sep 2021 14:31:04 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GCmLRX013485;
        Thu, 16 Sep 2021 14:29:33 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3b3v3bbjk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 14:29:32 -0400
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 18GITUR1038899
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Sep 2021 14:29:31 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Thu, 16 Sep 2021 11:29:29 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Thu, 16 Sep 2021 11:29:29 -0700
Received: from ubuntuservermchindri.ad.analog.com ([10.32.224.24])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 18GITO8n025646;
        Thu, 16 Sep 2021 14:29:27 -0400
From:   Mihail Chindris <mihail.chindris@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <alexandru.ardelean@analog.com>,
        Mihail Chindris <mihail.chindris@analog.com>
Subject: [PATCH v5 1/6] iio: Add output buffer support
Date:   Thu, 16 Sep 2021 18:29:09 +0000
Message-ID: <20210916182914.1810-2-mihail.chindris@analog.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210916182914.1810-1-mihail.chindris@analog.com>
References: <20210916182914.1810-1-mihail.chindris@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: zbcrdE9u-bCS0BPHhgOUHrN7TAyMBUf7
X-Proofpoint-GUID: zbcrdE9u-bCS0BPHhgOUHrN7TAyMBUf7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-16_05,2021-09-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160106
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Currently IIO only supports buffer mode for capture devices like ADCs. Add
support for buffered mode for output devices like DACs.

The output buffer implementation is analogous to the input buffer
implementation. Instead of using read() to get data from the buffer write()
is used to copy data into the buffer.

poll() with POLLOUT will wakeup if there is space available.

Drivers can remove data from a buffer using iio_pop_from_buffer(), the
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
Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
---
 drivers/iio/iio_core.h            |   4 +
 drivers/iio/industrialio-buffer.c | 120 +++++++++++++++++++++++++++++-
 drivers/iio/industrialio-core.c   |   1 +
 include/linux/iio/buffer.h        |   7 ++
 include/linux/iio/buffer_impl.h   |  11 +++
 5 files changed, 141 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index 8f4a9b264962..61e318431de9 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -68,12 +68,15 @@ __poll_t iio_buffer_poll_wrapper(struct file *filp,
 				 struct poll_table_struct *wait);
 ssize_t iio_buffer_read_wrapper(struct file *filp, char __user *buf,
 				size_t n, loff_t *f_ps);
+ssize_t iio_buffer_write_wrapper(struct file *filp, const char __user *buf,
+				 size_t n, loff_t *f_ps);
 
 int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev);
 void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev);
 
 #define iio_buffer_poll_addr (&iio_buffer_poll_wrapper)
 #define iio_buffer_read_outer_addr (&iio_buffer_read_wrapper)
+#define iio_buffer_write_outer_addr (&iio_buffer_write_wrapper)
 
 void iio_disable_all_buffers(struct iio_dev *indio_dev);
 void iio_buffer_wakeup_poll(struct iio_dev *indio_dev);
@@ -83,6 +86,7 @@ void iio_device_detach_buffers(struct iio_dev *indio_dev);
 
 #define iio_buffer_poll_addr NULL
 #define iio_buffer_read_outer_addr NULL
+#define iio_buffer_write_outer_addr NULL
 
 static inline int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 {
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index a95cc2da56be..a2a34c5652a7 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -161,6 +161,62 @@ static ssize_t iio_buffer_read(struct file *filp, char __user *buf,
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
+	int ret;
+	size_t written;
+
+	if (!indio_dev->info)
+		return -ENODEV;
+
+	if (!rb || !rb->access->write)
+		return -EINVAL;
+
+	written = 0;
+	add_wait_queue(&rb->pollq, &wait);
+	do {
+		if (indio_dev->info == NULL)
+			return -ENODEV;
+
+		if (!iio_buffer_space_available(rb)) {
+			if (signal_pending(current)) {
+				ret = -ERESTARTSYS;
+				break;
+			}
+
+			wait_woken(&wait, TASK_INTERRUPTIBLE,
+					MAX_SCHEDULE_TIMEOUT);
+			continue;
+		}
+
+		ret = rb->access->write(rb, n - written, buf + written);
+		if (ret == 0 && (filp->f_flags & O_NONBLOCK))
+			ret = -EAGAIN;
+
+		if (ret > 0) {
+			written += ret;
+			if (written != n && !(filp->f_flags & O_NONBLOCK))
+				continue;
+		}
+	} while (ret == 0);
+	remove_wait_queue(&rb->pollq, &wait);
+
+	return ret < 0 ? ret : n;
+}
+
 /**
  * iio_buffer_poll() - poll the buffer to find out if it has data
  * @filp:	File structure pointer for device access
@@ -181,8 +237,18 @@ static __poll_t iio_buffer_poll(struct file *filp,
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
+		if (iio_buffer_space_available(rb))
+			return EPOLLOUT | EPOLLWRNORM;
+		break;
+	}
+
 	return 0;
 }
 
@@ -199,6 +265,19 @@ ssize_t iio_buffer_read_wrapper(struct file *filp, char __user *buf,
 	return iio_buffer_read(filp, buf, n, f_ps);
 }
 
+ssize_t iio_buffer_write_wrapper(struct file *filp, const char __user *buf,
+				 size_t n, loff_t *f_ps)
+{
+	struct iio_dev_buffer_pair *ib = filp->private_data;
+	struct iio_buffer *rb = ib->buffer;
+
+	/* check if buffer was opened through new API */
+	if (test_bit(IIO_BUSY_BIT_POS, &rb->flags))
+		return -EBUSY;
+
+	return iio_buffer_write(filp, buf, n, f_ps);
+}
+
 __poll_t iio_buffer_poll_wrapper(struct file *filp,
 				 struct poll_table_struct *wait)
 {
@@ -231,6 +310,15 @@ void iio_buffer_wakeup_poll(struct iio_dev *indio_dev)
 	}
 }
 
+int iio_pop_from_buffer(struct iio_buffer *buffer, void *data)
+{
+	if (!buffer || !buffer->access || !buffer->access->remove_from)
+		return -EINVAL;
+
+	return buffer->access->remove_from(buffer, data);
+}
+EXPORT_SYMBOL_GPL(iio_pop_from_buffer);
+
 void iio_buffer_init(struct iio_buffer *buffer)
 {
 	INIT_LIST_HEAD(&buffer->demux_list);
@@ -1156,6 +1244,9 @@ int iio_update_buffers(struct iio_dev *indio_dev,
 	if (insert_buffer == remove_buffer)
 		return 0;
 
+	if (insert_buffer->direction == IIO_BUFFER_DIRECTION_OUT)
+		ret = -EINVAL;
+
 	mutex_lock(&iio_dev_opaque->info_exist_lock);
 	mutex_lock(&indio_dev->mlock);
 
@@ -1277,6 +1368,22 @@ static ssize_t iio_dma_show_data_available(struct device *dev,
 	return sysfs_emit(buf, "%zu\n", iio_buffer_data_available(buffer));
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
@@ -1289,12 +1396,20 @@ static struct device_attribute dev_attr_watermark_ro = __ATTR(watermark,
 	S_IRUGO, iio_buffer_show_watermark, NULL);
 static DEVICE_ATTR(data_available, S_IRUGO,
 		iio_dma_show_data_available, NULL);
+static DEVICE_ATTR_RO(direction);
 
+/*
+ * When adding new attributes here, put the at the end, at least until
+ * the code that handles the lengh/length_ro & watermark/watermark_ro
+ * assignments gets cleaned up. Otherwise these can create some weird
+ * duplicate attributes errors under some setups.
+ */
 static struct attribute *iio_buffer_attrs[] = {
 	&dev_attr_length.attr,
 	&dev_attr_enable.attr,
 	&dev_attr_watermark.attr,
 	&dev_attr_data_available.attr,
+	&dev_attr_direction.attr,
 };
 
 #define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
@@ -1397,6 +1512,7 @@ static const struct file_operations iio_buffer_chrdev_fileops = {
 	.owner = THIS_MODULE,
 	.llseek = noop_llseek,
 	.read = iio_buffer_read,
+	.write = iio_buffer_write,
 	.poll = iio_buffer_poll,
 	.release = iio_buffer_chrdev_release,
 };
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 2dbb37e09b8c..537a08549a69 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1822,6 +1822,7 @@ static const struct file_operations iio_buffer_fileops = {
 	.owner = THIS_MODULE,
 	.llseek = noop_llseek,
 	.read = iio_buffer_read_outer_addr,
+	.write = iio_buffer_write_outer_addr,
 	.poll = iio_buffer_poll_addr,
 	.unlocked_ioctl = iio_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index b6928ac5c63d..fe2e680d9b5e 100644
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
 
+int iio_pop_from_buffer(struct iio_buffer *buffer, void *data);
+
 /**
  * iio_push_to_buffers_with_timestamp() - push data and timestamp to buffers
  * @indio_dev:		iio_dev structure for device.
diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
index 245b32918ae1..e2ca8ea23e19 100644
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
+ * @remove_from:	remove scan from buffer. Drivers should calls this to
+ *			remove a scan from a buffer.
+ * @write:		try to write a number of bytes
+ * @space_available:	returns the amount of bytes available in a buffer
  * @request_update:	if a parameter change has been marked, update underlying
  *			storage.
  * @set_bytes_per_datum:set number of bytes per datum
@@ -49,6 +54,9 @@ struct iio_buffer_access_funcs {
 	int (*store_to)(struct iio_buffer *buffer, const void *data);
 	int (*read)(struct iio_buffer *buffer, size_t n, char __user *buf);
 	size_t (*data_available)(struct iio_buffer *buffer);
+	int (*remove_from)(struct iio_buffer *buffer, void *data);
+	int (*write)(struct iio_buffer *buffer, size_t n, const char __user *buf);
+	size_t (*space_available)(struct iio_buffer *buffer);
 
 	int (*request_update)(struct iio_buffer *buffer);
 
@@ -80,6 +88,9 @@ struct iio_buffer {
 	/**  @bytes_per_datum: Size of individual datum including timestamp. */
 	size_t bytes_per_datum;
 
+	/* @direction: Direction of the data stream (in/out). */
+	enum iio_buffer_direction direction;
+
 	/**
 	 * @access: Buffer access functions associated with the
 	 * implementation.
-- 
2.27.0

