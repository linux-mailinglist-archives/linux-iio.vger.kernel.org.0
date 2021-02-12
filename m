Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28168319C8A
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 11:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhBLKTK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 05:19:10 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:4976 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230453AbhBLKTA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2021 05:19:00 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11CAEpMM026135;
        Fri, 12 Feb 2021 05:18:07 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 36hr7qkgjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Feb 2021 05:18:07 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 11CAI651025143
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Feb 2021 05:18:06 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Fri, 12 Feb 2021 05:18:05 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Fri, 12 Feb 2021 05:18:05 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Fri, 12 Feb 2021 05:18:05 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11CAHu5n029319;
        Fri, 12 Feb 2021 05:18:02 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 4/5] iio: buffer-dma: Add output buffer support
Date:   Fri, 12 Feb 2021 12:20:20 +0200
Message-ID: <20210212102021.47276-5-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210212102021.47276-1-alexandru.ardelean@analog.com>
References: <20210212102021.47276-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-12_03:2021-02-12,2021-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120077
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Add support for output buffers to the dma buffer implementation.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c                 |   3 +-
 drivers/iio/buffer/industrialio-buffer-dma.c  | 116 ++++++++++++++++--
 .../buffer/industrialio-buffer-dmaengine.c    |  31 +++--
 include/linux/iio/buffer-dma.h                |   6 +
 include/linux/iio/buffer-dmaengine.h          |   7 +-
 5 files changed, 144 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 45ce97d1f41e..d088ab77ba5c 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -106,6 +106,7 @@ static unsigned int adi_axi_adc_read(struct adi_axi_adc_state *st,
 static int adi_axi_adc_config_dma_buffer(struct device *dev,
 					 struct iio_dev *indio_dev)
 {
+	enum iio_buffer_direction dir = IIO_BUFFER_DIRECTION_IN;
 	struct iio_buffer *buffer;
 	const char *dma_name;
 
@@ -115,7 +116,7 @@ static int adi_axi_adc_config_dma_buffer(struct device *dev,
 	if (device_property_read_string(dev, "dma-names", &dma_name))
 		dma_name = "rx";
 
-	buffer = devm_iio_dmaengine_buffer_alloc(indio_dev->dev.parent,
+	buffer = devm_iio_dmaengine_buffer_alloc(indio_dev->dev.parent, dir,
 						 dma_name, NULL, NULL);
 	if (IS_ERR(buffer))
 		return PTR_ERR(buffer);
diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index 57f2284a292f..36e6e79d2e04 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -223,7 +223,8 @@ void iio_dma_buffer_block_done(struct iio_dma_buffer_block *block)
 	spin_unlock_irqrestore(&queue->list_lock, flags);
 
 	iio_buffer_block_put_atomic(block);
-	wake_up_interruptible_poll(&queue->buffer.pollq, EPOLLIN | EPOLLRDNORM);
+	wake_up_interruptible_poll(&queue->buffer.pollq,
+		(uintptr_t)queue->poll_wakup_flags);
 }
 EXPORT_SYMBOL_GPL(iio_dma_buffer_block_done);
 
@@ -252,7 +253,8 @@ void iio_dma_buffer_block_list_abort(struct iio_dma_buffer_queue *queue,
 	}
 	spin_unlock_irqrestore(&queue->list_lock, flags);
 
-	wake_up_interruptible_poll(&queue->buffer.pollq, EPOLLIN | EPOLLRDNORM);
+	wake_up_interruptible_poll(&queue->buffer.pollq,
+		(uintptr_t)queue->poll_wakup_flags);
 }
 EXPORT_SYMBOL_GPL(iio_dma_buffer_block_list_abort);
 
@@ -353,9 +355,6 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
 		}
 
 		block->block.id = i;
-
-		block->state = IIO_BLOCK_STATE_QUEUED;
-		list_add_tail(&block->head, &queue->incoming);
 	}
 
 out_unlock:
@@ -437,7 +436,29 @@ int iio_dma_buffer_enable(struct iio_buffer *buffer,
 	struct iio_dma_buffer_block *block, *_block;
 
 	mutex_lock(&queue->lock);
+
+	if (buffer->direction == IIO_BUFFER_DIRECTION_IN)
+		queue->poll_wakup_flags = POLLIN | POLLRDNORM;
+	else
+		queue->poll_wakup_flags = POLLOUT | POLLWRNORM;
+
 	queue->fileio.enabled = !queue->num_blocks;
+	if (queue->fileio.enabled) {
+		unsigned int i;
+
+		for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
+			struct iio_dma_buffer_block *block =
+			    queue->fileio.blocks[i];
+			if (buffer->direction == IIO_BUFFER_DIRECTION_IN) {
+				block->state = IIO_BLOCK_STATE_QUEUED;
+				list_add_tail(&block->head, &queue->incoming);
+			} else {
+				block->state = IIO_BLOCK_STATE_DEQUEUED;
+				list_add_tail(&block->head, &queue->outgoing);
+			}
+		}
+	}
+
 	queue->active = true;
 	list_for_each_entry_safe(block, _block, &queue->incoming, head) {
 		list_del(&block->head);
@@ -567,6 +588,61 @@ int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
 }
 EXPORT_SYMBOL_GPL(iio_dma_buffer_read);
 
+int iio_dma_buffer_write(struct iio_buffer *buf, size_t n,
+	const char __user *user_buffer)
+{
+	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buf);
+	struct iio_dma_buffer_block *block;
+	int ret;
+
+	if (n < buf->bytes_per_datum)
+		return -EINVAL;
+
+	mutex_lock(&queue->lock);
+
+	if (!queue->fileio.enabled) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	if (!queue->fileio.active_block) {
+		block = iio_dma_buffer_dequeue(queue);
+		if (block == NULL) {
+			ret = 0;
+			goto out_unlock;
+		}
+		queue->fileio.pos = 0;
+		queue->fileio.active_block = block;
+	} else {
+		block = queue->fileio.active_block;
+	}
+
+	n = rounddown(n, buf->bytes_per_datum);
+	if (n > block->block.size - queue->fileio.pos)
+		n = block->block.size - queue->fileio.pos;
+
+	if (copy_from_user(block->vaddr + queue->fileio.pos, user_buffer, n)) {
+		ret = -EFAULT;
+		goto out_unlock;
+	}
+
+	queue->fileio.pos += n;
+
+	if (queue->fileio.pos == block->block.size) {
+		queue->fileio.active_block = NULL;
+		block->block.bytes_used = block->block.size;
+		iio_dma_buffer_enqueue(queue, block);
+	}
+
+	ret = n;
+
+out_unlock:
+	mutex_unlock(&queue->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iio_dma_buffer_write);
+
 /**
  * iio_dma_buffer_data_available() - DMA buffer data_available callback
  * @buf: Buffer to check for data availability
@@ -588,12 +664,14 @@ size_t iio_dma_buffer_data_available(struct iio_buffer *buf)
 	 */
 
 	mutex_lock(&queue->lock);
-	if (queue->fileio.active_block)
-		data_available += queue->fileio.active_block->block.size;
+	if (queue->fileio.active_block) {
+		data_available += queue->fileio.active_block->block.bytes_used -
+			queue->fileio.pos;
+	}
 
 	spin_lock_irq(&queue->list_lock);
 	list_for_each_entry(block, &queue->outgoing, head)
-		data_available += block->block.size;
+		data_available += block->block.bytes_used;
 	spin_unlock_irq(&queue->list_lock);
 	mutex_unlock(&queue->lock);
 
@@ -601,6 +679,28 @@ size_t iio_dma_buffer_data_available(struct iio_buffer *buf)
 }
 EXPORT_SYMBOL_GPL(iio_dma_buffer_data_available);
 
+size_t iio_dma_buffer_space_available(struct iio_buffer *buf)
+{
+	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buf);
+	struct iio_dma_buffer_block *block;
+	size_t space_available = 0;
+
+	mutex_lock(&queue->lock);
+	if (queue->fileio.active_block) {
+		space_available += queue->fileio.active_block->block.size -
+			queue->fileio.pos;
+	}
+
+	spin_lock_irq(&queue->list_lock);
+	list_for_each_entry(block, &queue->outgoing, head)
+		space_available += block->block.size;
+	spin_unlock_irq(&queue->list_lock);
+	mutex_unlock(&queue->lock);
+
+	return space_available;
+}
+EXPORT_SYMBOL_GPL(iio_dma_buffer_space_available);
+
 int iio_dma_buffer_alloc_blocks(struct iio_buffer *buffer,
 				struct iio_buffer_block_alloc_req *req)
 {
diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 0736526b36ec..013cc7c1ecf4 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -37,6 +37,8 @@ struct dmaengine_buffer {
 
 	size_t align;
 	size_t max_size;
+
+	bool is_tx;
 };
 
 static struct dmaengine_buffer *iio_buffer_to_dmaengine_buffer(
@@ -64,9 +66,12 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
 	struct dmaengine_buffer *dmaengine_buffer =
 		iio_buffer_to_dmaengine_buffer(&queue->buffer);
 	struct dma_async_tx_descriptor *desc;
+	enum dma_transfer_direction direction;
 	dma_cookie_t cookie;
 
-	block->block.bytes_used = min(block->block.size,
+	if (!dmaengine_buffer->is_tx)
+		block->block.bytes_used = block->block.size;
+	block->block.bytes_used = min(block->block.bytes_used,
 		dmaengine_buffer->max_size);
 	block->block.bytes_used = rounddown(block->block.bytes_used,
 		dmaengine_buffer->align);
@@ -75,8 +80,10 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
 		return 0;
 	}
 
+	direction = dmaengine_buffer->is_tx ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
+
 	desc = dmaengine_prep_slave_single(dmaengine_buffer->chan,
-		block->phys_addr, block->block.bytes_used, DMA_DEV_TO_MEM,
+		block->phys_addr, block->block.bytes_used, direction,
 		DMA_PREP_INTERRUPT);
 	if (!desc)
 		return -ENOMEM;
@@ -117,12 +124,14 @@ static void iio_dmaengine_buffer_release(struct iio_buffer *buf)
 
 static const struct iio_buffer_access_funcs iio_dmaengine_buffer_ops = {
 	.read = iio_dma_buffer_read,
+	.write = iio_dma_buffer_write,
 	.set_bytes_per_datum = iio_dma_buffer_set_bytes_per_datum,
 	.set_length = iio_dma_buffer_set_length,
 	.request_update = iio_dma_buffer_request_update,
 	.enable = iio_dma_buffer_enable,
 	.disable = iio_dma_buffer_disable,
 	.data_available = iio_dma_buffer_data_available,
+	.space_available = iio_dma_buffer_space_available,
 	.release = iio_dmaengine_buffer_release,
 
 	.alloc_blocks = iio_dma_buffer_alloc_blocks,
@@ -162,6 +171,7 @@ static const struct attribute *iio_dmaengine_buffer_attrs[] = {
 /**
  * iio_dmaengine_buffer_alloc() - Allocate new buffer which uses DMAengine
  * @dev: Parent device for the buffer
+ * @direction: Set the direction of the data.
  * @channel: DMA channel name, typically "rx".
  * @ops: Custom iio_dma_buffer_ops, if NULL default ops will be used
  * @driver_data: Driver data to be passed to custom iio_dma_buffer_ops
@@ -174,11 +184,12 @@ static const struct attribute *iio_dmaengine_buffer_attrs[] = {
  * release it.
  */
 static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
-	const char *channel, const struct iio_dma_buffer_ops *ops,
-	void *driver_data)
+	enum iio_buffer_direction direction, const char *channel,
+	const struct iio_dma_buffer_ops *ops, void *driver_data)
 {
 	struct dmaengine_buffer *dmaengine_buffer;
 	unsigned int width, src_width, dest_width;
+	bool is_tx = (direction == IIO_BUFFER_DIRECTION_OUT);
 	struct dma_slave_caps caps;
 	struct dma_chan *chan;
 	int ret;
@@ -187,6 +198,9 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
 	if (!dmaengine_buffer)
 		return ERR_PTR(-ENOMEM);
 
+	if (!channel)
+		channel = is_tx ? "tx" : "rx";
+
 	chan = dma_request_chan(dev, channel);
 	if (IS_ERR(chan)) {
 		ret = PTR_ERR(chan);
@@ -212,6 +226,7 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
 	dmaengine_buffer->chan = chan;
 	dmaengine_buffer->align = width;
 	dmaengine_buffer->max_size = dma_get_max_seg_size(chan->device->dev);
+	dmaengine_buffer->is_tx = is_tx;
 
 	iio_dma_buffer_init(&dmaengine_buffer->queue, chan->device->dev,
 		ops ? ops : &iio_dmaengine_default_ops, driver_data);
@@ -251,6 +266,7 @@ static void __devm_iio_dmaengine_buffer_free(struct device *dev, void *res)
 /**
  * devm_iio_dmaengine_buffer_alloc() - Resource-managed iio_dmaengine_buffer_alloc()
  * @dev: Parent device for the buffer
+ * @direction: Set the direction of the data.
  * @channel: DMA channel name, typically "rx".
  * @ops: Custom iio_dma_buffer_ops, if NULL default ops will be used
  * @driver_data: Driver data to be passed to custom iio_dma_buffer_ops
@@ -262,8 +278,8 @@ static void __devm_iio_dmaengine_buffer_free(struct device *dev, void *res)
  * The buffer will be automatically de-allocated once the device gets destroyed.
  */
 struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
-	const char *channel, const struct iio_dma_buffer_ops *ops,
-	void *driver_data)
+	enum iio_buffer_direction direction, const char *channel,
+	const struct iio_dma_buffer_ops *ops, void *driver_data)
 {
 	struct iio_buffer **bufferp, *buffer;
 
@@ -272,7 +288,8 @@ struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
 	if (!bufferp)
 		return ERR_PTR(-ENOMEM);
 
-	buffer = iio_dmaengine_buffer_alloc(dev, channel, ops, driver_data);
+	buffer = iio_dmaengine_buffer_alloc(dev, direction, channel, ops,
+		driver_data);
 	if (IS_ERR(buffer)) {
 		devres_free(bufferp);
 		return buffer;
diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
index c23fad847f0d..0fd844c7f47a 100644
--- a/include/linux/iio/buffer-dma.h
+++ b/include/linux/iio/buffer-dma.h
@@ -112,6 +112,8 @@ struct iio_dma_buffer_queue {
 
 	void *driver_data;
 
+	unsigned int poll_wakup_flags;
+
 	unsigned int num_blocks;
 	struct iio_dma_buffer_block **blocks;
 	unsigned int max_offset;
@@ -145,6 +147,10 @@ int iio_dma_buffer_set_bytes_per_datum(struct iio_buffer *buffer, size_t bpd);
 int iio_dma_buffer_set_length(struct iio_buffer *buffer, unsigned int length);
 int iio_dma_buffer_request_update(struct iio_buffer *buffer);
 
+int iio_dma_buffer_write(struct iio_buffer *buf, size_t n,
+	const char __user *user_buffer);
+size_t iio_dma_buffer_space_available(struct iio_buffer *buf);
+
 int iio_dma_buffer_init(struct iio_dma_buffer_queue *queue,
 	struct device *dma_dev, const struct iio_dma_buffer_ops *ops,
 	void *driver_data);
diff --git a/include/linux/iio/buffer-dmaengine.h b/include/linux/iio/buffer-dmaengine.h
index 464adee95d4b..009a601c406c 100644
--- a/include/linux/iio/buffer-dmaengine.h
+++ b/include/linux/iio/buffer-dmaengine.h
@@ -7,12 +7,13 @@
 #ifndef __IIO_DMAENGINE_H__
 #define __IIO_DMAENGINE_H__
 
+#include <linux/iio/buffer.h>
+
 struct iio_dma_buffer_ops;
-struct iio_buffer;
 struct device;
 
 struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
-	const char *channel, const struct iio_dma_buffer_ops *ops,
-	void *driver_data);
+	enum iio_buffer_direction direction, const char *channel,
+	const struct iio_dma_buffer_ops *ops, void *driver_data);
 
 #endif
-- 
2.17.1

