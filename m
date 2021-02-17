Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2B231D5BD
	for <lists+linux-iio@lfdr.de>; Wed, 17 Feb 2021 08:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhBQHfk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Feb 2021 02:35:40 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:58726 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231736AbhBQHfb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Feb 2021 02:35:31 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11H7LruQ028661;
        Wed, 17 Feb 2021 02:34:39 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36pcjat5xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Feb 2021 02:34:39 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11H7Ychp003755
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 17 Feb 2021 02:34:38 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 17 Feb 2021 02:34:37 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Wed, 17 Feb 2021 02:34:37 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 17 Feb 2021 02:34:37 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11H7YS3g031303;
        Wed, 17 Feb 2021 02:34:33 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v4 2/6] Documentation: iio: add doc for high-speed buffer API
Date:   Wed, 17 Feb 2021 09:36:34 +0200
Message-ID: <20210217073638.21681-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210217073638.21681-1-alexandru.ardelean@analog.com>
References: <20210217073638.21681-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-17_06:2021-02-16,2021-02-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 mlxlogscore=703 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102170054
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change takes the comment from the commit that introduces the IIO
high-speed buffer API, and formats it into rst format.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 Documentation/iio/iio_high_speed_buffers.rst | 100 +++++++++++++++++++
 Documentation/iio/index.rst                  |   2 +
 include/uapi/linux/iio/buffer.h              |   5 +
 3 files changed, 107 insertions(+)
 create mode 100644 Documentation/iio/iio_high_speed_buffers.rst

diff --git a/Documentation/iio/iio_high_speed_buffers.rst b/Documentation/iio/iio_high_speed_buffers.rst
new file mode 100644
index 000000000000..f326e68efe49
--- /dev/null
+++ b/Documentation/iio/iio_high_speed_buffers.rst
@@ -0,0 +1,100 @@
+===================================
+Industrial IO High-Speed Buffer API
+===================================
+
+1. Overview
+===========
+
+Industrial IO supports access to buffers via an mmap interface. The
+advantage of the mmap based interface compared to the read() based
+interface is that it avoids an extra copy of the data between kernel and
+userspace. This is particular useful for high-speed devices which produce
+several megabytes or even gigabytes of data per second.
+
+The data for the mmap interface is managed at the granularity of so called
+blocks. A block is a contiguous region of memory (at the moment both
+physically and virtually contiguous). Reducing the granularity from byte
+level to block level is done to reduce the userspace-kernelspace
+synchronization overhead since performing syscalls for each byte at a
+data-rate of a few megabytes is not feasible.
+
+This of course leads to a slightly increased latency. For this reason an
+application can choose the size of the blocks as well as how many blocks it
+allocates. E.g. two blocks would be a traditional double buffering scheme.
+But using a higher number might be necessary to avoid underflow/overflow
+situations in the presence of scheduling latencies.
+
+A block can either be owned by kernel space or userspace. When owned by
+userspace it is safe to access the data in the block and process it. When
+owned by kernel space the block can be in one of 3 states:
+
+* It can be in the incoming queue where all blocks submitted from userspace
+  are placed and are waiting to be processed by the kernel driver.
+* It can be currently being processed by the kernel driver, this means it is
+  actively placing capturing data in it (usually using DMA).
+* Or it can be in the outgoing queue where all blocks that have been
+  processed by the kernel are placed. Userspace can dequeue the blocks as
+  necessary.
+
+2. Interface
+============
+
+As part of the interface 5 IOCTLs are used to manage the blocks and exchange
+them between userspace and kernelspace. The IOCTLs can be accessed through
+a open file descriptor to a IIO device.
+
+* **IIO_BUFFER_BLOCK_ALLOC_IOCTL(struct iio_buffer_block_alloc_req *)**:
+    Allocates new blocks. Can be called multiple times if necessary. A newly
+    allocated block is initially owned by userspace.
+
+* **IIO_BUFFER_BLOCK_FREE_IOCTL(void)**:
+   Frees all previously allocated blocks. If the backing memory of a block is
+   still in use by a kernel driver (i.e. active DMA transfer) it will be
+   freed once the kernel driver has released it.
+
+* **IIO_BUFFER_BLOCK_QUERY_IOCTL(struct iio_buffer_block *)**:
+   Queries information about a block. The id of the block about which
+   information is to be queried needs to be set by userspace.
+
+* **IIO_BUFFER_BLOCK_ENQUEUE_IOCTL(struct iio_buffer_block *)**:
+   Places a block on the incoming queue. This transfers ownership of the
+   block from userspace to kernelspace. Userspace must populate the id field
+   of the block to indicate which block to enqueue.
+
+* **IIO_BUFFER_BLOCK_DEQUEUE_IOCTL(struct iio_buffer_block *)**:
+   Removes the first block from the outgoing queue. This transfers ownership
+   of the block from kernelspace to userspace. Kernelspace will populate all
+   fields of the block. If the queue is empty and the file descriptor is set
+   to blocking the IOCTL will block until a new block is available on the
+   outgoing queue.
+
+3. Usage
+========
+
+To access the data stored in a block by userspace the block must be mapped
+to the process's memory. This is done by calling mmap() on the IIO device
+file descriptor. Each block has a unique offset assigned to it which should
+be passed to the mmap interface. E.g.
+
+  mmap(0, block.size, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
+       block.offset);
+
+A typical workflow for the new interface is:
+
+  BLOCK_ALLOC
+
+  foreach block
+     BLOCK_QUERY block
+	 mmap block.data.offset
+	 BLOCK_ENQUEUE block
+
+  enable buffer
+
+  while !done
+	BLOCK_DEQUEUE block
+	process data
+	BLOCK_ENQUEUE block
+
+  disable buffer
+
+  BLOCK_FREE
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index 58b7a4ebac51..aaba78770b47 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -9,4 +9,6 @@ Industrial I/O
 
    iio_configfs
 
+   iio_high_speed_buffers
+
    ep93xx_adc
diff --git a/include/uapi/linux/iio/buffer.h b/include/uapi/linux/iio/buffer.h
index d18692d14aa5..5ec8a4fa3332 100644
--- a/include/uapi/linux/iio/buffer.h
+++ b/include/uapi/linux/iio/buffer.h
@@ -7,6 +7,11 @@
 
 #include <linux/types.h>
 
+/**
+ * See for more details:
+ *   Documentation/iio/iio_high_speed_buffers.rst
+ */
+
 /**
  * struct iio_buffer_block_alloc_req - Descriptor for allocating IIO buffer blocks
  * @type:	type of block(s) to allocate (currently unused, reserved)
-- 
2.17.1

