Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A73318ADC
	for <lists+linux-iio@lfdr.de>; Thu, 11 Feb 2021 13:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhBKMhA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Feb 2021 07:37:00 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:52262 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231561AbhBKMc2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Feb 2021 07:32:28 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11BCQg5c006990;
        Thu, 11 Feb 2021 07:31:36 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36hr7qg9g1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 07:31:35 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11BCVYMV004858
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Feb 2021 07:31:34 -0500
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Thu, 11 Feb 2021 04:31:33 -0800
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Thu, 11 Feb 2021 04:31:32 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Thu, 11 Feb 2021 04:31:32 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11BCVRdm011921;
        Thu, 11 Feb 2021 07:31:29 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/3] iio: core: Add mmap interface infrastructure
Date:   Thu, 11 Feb 2021 14:33:51 +0200
Message-ID: <20210211123353.78963-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210211123353.78963-1-alexandru.ardelean@analog.com>
References: <20210211123353.78963-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_06:2021-02-10,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110111
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Add the necessary infrastructure to the IIO core to support an mmap based
interface to access the capture data.

The advantage of the mmap based interface compared to the read() based
interface is that it avoids an extra copy of the data between kernel and
userspace. This is particular useful for high-speed devices which produce
several megabytes or even gigabytes of data per second.

The data for the mmap interface is managed at the granularity of so called
blocks. A block is a contiguous region of memory (at the moment both
physically and virtually contiguous). Reducing the granularity from byte
level to block level is done to reduce the userspace-kernelspace
synchronization overhead since performing syscalls for each byte at a
data-rate of a few megabytes is not feasible.

This of course leads to a slightly increased latency. For this reason an
application can choose the size of the blocks as well as how many blocks it
allocates. E.g. two blocks would be a traditional double buffering scheme.
But using a higher number might be necessary to avoid underflow/overflow
situations in the presence of scheduling latencies.

A block can either be owned by kernel space or userspace. When owned by
userspace it save to access the data in the block and process it. When
owned by kernel space the block can be in one of 3 states.

It can be in the incoming queue where all blocks submitted from userspace
are placed and are waiting to be processed by the kernel driver.

It can be currently being processed by the kernel driver, this means it is
actively placing capturing data in it (usually using DMA).

Or it can be in the outgoing queue where all blocks that have been
processed by the kernel are placed. Userspace can dequeue the blocks as
necessary.

As part of the interface 5 new IOCTLs to manage the blocks and exchange
them between userspace and kernelspace. The IOCTLs can be accessed through
a open file descriptor to a IIO device.

IIO_BUFFER_BLOCK_ALLOC_IOCTL(struct iio_buffer_block_alloc_req *):
 Allocates new blocks. Can be called multiple times if necessary. A newly
 allocated block is initially owned by userspace.

IIO_BUFFER_BLOCK_FREE_IOCTL(void):
 Frees all previously allocated blocks. If the backing memory of a block is
 still in use by a kernel driver (i.e. active DMA transfer) it will be
 freed once the kernel driver has released it.

IIO_BUFFER_BLOCK_QUERY_IOCTL(struct iio_buffer_block *):
 Queries information about a block. The id of the block about which
 information is to be queried needs to be set by userspace.

IIO_BUFFER_BLOCK_ENQUEUE_IOCTL(struct iio_buffer_block *):
 Places a block on the incoming queue. This transfers ownership of the
 block from userspace to kernelspace. Userspace must populate the id field
 of the block to indicate which block to enqueue.

IIO_BUFFER_BLOCK_DEQUEUE_IOCTL(struct iio_buffer_block *):
 Removes the first block from the outgoing queue. This transfers ownership
 of the block from kernelspace to userspace. Kernelspace will populate all
 fields of the block. If the queue is empty and the file descriptor is set
 to blocking the IOCTL will block until a new block is available on the
 outgoing queue.

To access the data stored in a block by userspace the block must be mapped
to the process's memory. This is done by calling mmap() on the IIO device
file descriptor. Each block has a unique offset assigned to it which should
be passed to the mmap interface. E.g.

  mmap(0, block.size, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
       block.offset);

A typical workflow for the new interface is:

  BLOCK_ALLOC

  foreach block
     BLOCK_QUERY block
	 mmap block.data.offset
	 BLOCK_ENQUEUE block

  enable buffer

  while !done
	BLOCK_DEQUEUE block
	process data
	BLOCK_ENQUEUE block

  disable buffer

  BLOCK_FREE

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-buffer.c | 157 ++++++++++++++++++++++++++++++
 include/linux/iio/buffer-dma.h    |   5 -
 include/linux/iio/buffer_impl.h   |  11 +++
 include/uapi/linux/iio/buffer.h   |  27 +++++
 4 files changed, 195 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 3aa6702a5811..50228df0b09f 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -16,6 +16,7 @@
 #include <linux/fs.h>
 #include <linux/cdev.h>
 #include <linux/slab.h>
+#include <linux/mm.h>
 #include <linux/poll.h>
 #include <linux/sched/signal.h>
 
@@ -1370,6 +1371,12 @@ static void iio_buffer_unregister_legacy_sysfs_groups(struct iio_dev *indio_dev)
 	kfree(iio_dev_opaque->legacy_scan_el_group.attrs);
 }
 
+static void iio_buffer_free_blocks(struct iio_buffer *buffer)
+{
+	if (buffer->access->free_blocks)
+		buffer->access->free_blocks(buffer);
+}
+
 static int iio_buffer_chrdev_release(struct inode *inode, struct file *filep)
 {
 	struct iio_dev_buffer_pair *ib = filep->private_data;
@@ -1378,18 +1385,24 @@ static int iio_buffer_chrdev_release(struct inode *inode, struct file *filep)
 
 	wake_up(&buffer->pollq);
 	clear_bit(IIO_BUSY_BIT_POS, &buffer->flags);
+	iio_buffer_free_blocks(buffer);
 	iio_device_put(indio_dev);
 	kfree(ib);
 
 	return 0;
 }
 
+static long iio_buffer_ioctl(struct file *filep, unsigned int cmd, unsigned long arg);
+static int iio_buffer_mmap(struct file *filep, struct vm_area_struct *vma);
+
 static const struct file_operations iio_buffer_chrdev_fileops = {
 	.owner = THIS_MODULE,
 	.llseek = noop_llseek,
 	.read = iio_buffer_read,
 	.poll = iio_buffer_poll,
+	.unlocked_ioctl = iio_buffer_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
+	.mmap = iio_buffer_mmap,
 	.release = iio_buffer_chrdev_release,
 };
 
@@ -1762,6 +1775,150 @@ void iio_buffer_put(struct iio_buffer *buffer)
 }
 EXPORT_SYMBOL_GPL(iio_buffer_put);
 
+static int iio_buffer_query_block(struct iio_buffer *buffer,
+				  struct iio_buffer_block __user *user_block)
+{
+	struct iio_buffer_block block;
+	int ret;
+
+	if (!buffer->access->query_block)
+		return -ENOSYS;
+
+	if (copy_from_user(&block, user_block, sizeof(block)))
+		return -EFAULT;
+
+	ret = buffer->access->query_block(buffer, &block);
+	if (ret)
+		return ret;
+
+	if (copy_to_user(user_block, &block, sizeof(block)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int iio_buffer_dequeue_block(struct iio_dev *indio_dev,
+				    struct iio_buffer *buffer,
+				    struct iio_buffer_block __user *user_block,
+				    bool non_blocking)
+{
+	struct iio_buffer_block block;
+	int ret;
+
+	if (!buffer->access->dequeue_block)
+		return -ENOSYS;
+
+	do {
+		if (!iio_buffer_data_available(buffer)) {
+			if (non_blocking)
+				return -EAGAIN;
+
+			ret = wait_event_interruptible(buffer->pollq,
+					iio_buffer_data_available(buffer) ||
+					indio_dev->info == NULL);
+			if (ret)
+				return ret;
+			if (indio_dev->info == NULL)
+				return -ENODEV;
+		}
+
+		ret = buffer->access->dequeue_block(buffer, &block);
+		if (ret == -EAGAIN && non_blocking)
+			ret = 0;
+	} while (ret);
+
+	if (ret)
+		return ret;
+
+	if (copy_to_user(user_block, &block, sizeof(block)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int iio_buffer_enqueue_block(struct iio_buffer *buffer,
+				   struct iio_buffer_block __user *user_block)
+{
+	struct iio_buffer_block block;
+
+	if (!buffer->access->enqueue_block)
+		return -ENOSYS;
+
+	if (copy_from_user(&block, user_block, sizeof(block)))
+		return -EFAULT;
+
+	return buffer->access->enqueue_block(buffer, &block);
+}
+
+static int iio_buffer_alloc_blocks(struct iio_buffer *buffer,
+				   struct iio_buffer_block_alloc_req __user *user_req)
+{
+	struct iio_buffer_block_alloc_req req;
+	int ret;
+
+	if (!buffer->access->alloc_blocks)
+		return -ENOSYS;
+
+	if (copy_from_user(&req, user_req, sizeof(req)))
+		return -EFAULT;
+
+	ret = buffer->access->alloc_blocks(buffer, &req);
+	if (ret)
+		return ret;
+
+	if (copy_to_user(user_req, &req, sizeof(req)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long iio_buffer_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
+{
+	bool non_blocking = filep->f_flags & O_NONBLOCK;
+	struct iio_dev_buffer_pair *ib = filep->private_data;
+	struct iio_dev *indio_dev = ib->indio_dev;
+	struct iio_buffer *buffer = ib->buffer;
+
+	if (!buffer || !buffer->access)
+		return -ENODEV;
+
+	switch (cmd) {
+	case IIO_BUFFER_BLOCK_ALLOC_IOCTL:
+		return iio_buffer_alloc_blocks(buffer,
+			(struct iio_buffer_block_alloc_req __user *)arg);
+	case IIO_BUFFER_BLOCK_FREE_IOCTL:
+		iio_buffer_free_blocks(buffer);
+		return 0;
+	case IIO_BUFFER_BLOCK_QUERY_IOCTL:
+		return iio_buffer_query_block(buffer,
+			(struct iio_buffer_block __user *)arg);
+	case IIO_BUFFER_BLOCK_ENQUEUE_IOCTL:
+		return iio_buffer_enqueue_block(buffer,
+			(struct iio_buffer_block __user *)arg);
+	case IIO_BUFFER_BLOCK_DEQUEUE_IOCTL:
+		return iio_buffer_dequeue_block(indio_dev, buffer,
+			(struct iio_buffer_block __user *)arg, non_blocking);
+	}
+	return -EINVAL;
+}
+
+static int iio_buffer_mmap(struct file *filep, struct vm_area_struct *vma)
+{
+	struct iio_dev_buffer_pair *ib = filep->private_data;
+	struct iio_buffer *buffer = ib->buffer;
+
+	if (!buffer->access || !buffer->access->mmap)
+		return -ENODEV;
+
+	if (!(vma->vm_flags & VM_SHARED))
+		return -EINVAL;
+
+	if (!(vma->vm_flags & VM_READ))
+		return -EINVAL;
+
+	return buffer->access->mmap(buffer, vma);
+}
+
 /**
  * iio_device_attach_buffer - Attach a buffer to a IIO device
  * @indio_dev: The device the buffer should be attached to
diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
index ff15c61bf319..6564bdcdac66 100644
--- a/include/linux/iio/buffer-dma.h
+++ b/include/linux/iio/buffer-dma.h
@@ -17,11 +17,6 @@ struct iio_dma_buffer_queue;
 struct iio_dma_buffer_ops;
 struct device;
 
-struct iio_buffer_block {
-	u32 size;
-	u32 bytes_used;
-};
-
 /**
  * enum iio_block_state - State of a struct iio_dma_buffer_block
  * @IIO_BLOCK_STATE_DEQUEUED: Block is not queued
diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
index 245b32918ae1..0ac809171bb1 100644
--- a/include/linux/iio/buffer_impl.h
+++ b/include/linux/iio/buffer_impl.h
@@ -60,6 +60,17 @@ struct iio_buffer_access_funcs {
 
 	void (*release)(struct iio_buffer *buffer);
 
+	int (*alloc_blocks)(struct iio_buffer *buffer,
+			    struct iio_buffer_block_alloc_req *req);
+	int (*free_blocks)(struct iio_buffer *buffer);
+	int (*enqueue_block)(struct iio_buffer *buffer,
+			     struct iio_buffer_block *block);
+	int (*dequeue_block)(struct iio_buffer *buffer,
+			     struct iio_buffer_block *block);
+	int (*query_block)(struct iio_buffer *buffer,
+			   struct iio_buffer_block *block);
+	int (*mmap)(struct iio_buffer *buffer,	struct vm_area_struct *vma);
+
 	unsigned int modes;
 	unsigned int flags;
 };
diff --git a/include/uapi/linux/iio/buffer.h b/include/uapi/linux/iio/buffer.h
index 13939032b3f6..0e0c95f1c38b 100644
--- a/include/uapi/linux/iio/buffer.h
+++ b/include/uapi/linux/iio/buffer.h
@@ -5,6 +5,33 @@
 #ifndef _UAPI_IIO_BUFFER_H_
 #define _UAPI_IIO_BUFFER_H_
 
+struct iio_buffer_block_alloc_req {
+	__u32 type;
+	__u32 size;
+	__u32 count;
+	__u32 id;
+};
+
+#define IIO_BUFFER_BLOCK_FLAG_TIMESTAMP_VALID	(1 << 0)
+#define IIO_BUFFER_BLOCK_FLAG_CYCLIC		(1 << 1)
+
+struct iio_buffer_block {
+	__u32 id;
+	__u32 size;
+	__u32 bytes_used;
+	__u32 type;
+	__u32 flags;
+	union {
+		__u32 offset;
+	} data;
+	__u64 timestamp;
+};
+
 #define IIO_BUFFER_GET_FD_IOCTL			_IOWR('i', 0x91, int)
+#define IIO_BUFFER_BLOCK_ALLOC_IOCTL		_IOWR('i', 0x92, struct iio_buffer_block_alloc_req)
+#define IIO_BUFFER_BLOCK_FREE_IOCTL		_IO('i',   0x93)
+#define IIO_BUFFER_BLOCK_QUERY_IOCTL		_IOWR('i', 0x93, struct iio_buffer_block)
+#define IIO_BUFFER_BLOCK_ENQUEUE_IOCTL		_IOWR('i', 0x94, struct iio_buffer_block)
+#define IIO_BUFFER_BLOCK_DEQUEUE_IOCTL		_IOWR('i', 0x95, struct iio_buffer_block)
 
 #endif /* _UAPI_IIO_BUFFER_H_ */
-- 
2.17.1

