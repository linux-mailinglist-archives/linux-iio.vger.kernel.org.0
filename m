Return-Path: <linux-iio+bounces-2632-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A02D857EF1
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 15:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CFD31C23B3B
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 14:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A2D12EBD2;
	Fri, 16 Feb 2024 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkX3of4i"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7CB12E1E8
	for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092690; cv=none; b=TkSM7ntC2ptyjzvpvvpM8rV0lpS/DEJkkQ6HBx3RBu+U90o8/2Xkto7Q9/kB+EgzYn+1FEjmSEf8eyUKT7cg2r9CRgY1mGmBGBHa71BkQCCKZmuFSbnG6tpqe6/f5kRQCvAr0abgRivHJmTd1OtH8oobdt3jqNkXZR3kmXyShIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092690; c=relaxed/simple;
	bh=K1bI3qSBsID6idTEBGaHrKCumxe2K3HYxfybRHk0M40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dbfde9L0rWJLBKma9/lxez19WV5gAJ/BxBfnRjStCKti32Q4iUG/87mkdinfExulluOsszfmR8YfIAtv5dh+OCa3bd98NIVs1Bi3PofvLGbqREgAC8KKeqpmAaGkzkvw4YnQk7+xT+XLKZkK7wgBM3aRIA0xQ1xh5V2Jnz0d2eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkX3of4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D9A7C43399;
	Fri, 16 Feb 2024 14:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708092689;
	bh=K1bI3qSBsID6idTEBGaHrKCumxe2K3HYxfybRHk0M40=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kkX3of4i9NyPcU48ivH5plMUxwLJV7FP3BupktQLCSV2JRED3kC1dcwhUbAibkYRo
	 xbtT+pmjjUqqqpPb0M7PMWTiygy0dYLqyXhbDi2+OcdQ4OXoPb2ZSuKLNLIqhJ8rvc
	 VGkATHUXcvdUVqwDf1QCV8KNRwMyQR2uW7gqNm1dyYrgiCrgBKGQxhqg5CEWgpPtDB
	 jo5Q743uxJttlMNtGRXRxmqvcK3Z7PwHroGyxsxsGc3y4wsM7YalNX+lQZ2VRL0C/v
	 3IrLuweZ9+C/ysZZ43aZnCfcCQOvWU28ITjKn4J4W+ySNMqYuAv/BmfxG/9tLG6Jg7
	 ppeu6RfeET3cg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D088C48BF6;
	Fri, 16 Feb 2024 14:11:29 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 16 Feb 2024 15:10:52 +0100
Subject: [PATCH RFC 3/8] iio: buffer-dma: Enable buffer write support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-iio-backend-axi-dds-v1-3-22aed9fb07a1@analog.com>
References: <20240216-iio-backend-axi-dds-v1-0-22aed9fb07a1@analog.com>
In-Reply-To: <20240216-iio-backend-axi-dds-v1-0-22aed9fb07a1@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Paul Cercueil <paul@crapouillou.net>, 
 Alexandru Ardelean <ardeleanalex@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708092664; l=6566;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=L8Ql02GphZ76a78MQMNepoZSe0z1Oo9UelhjeRQ/JC8=;
 b=wVKa+4l8K+gInZdPI43AQx55LuIW2RzzX2POck+SSNsQFlonW2fbmd1laR6qhF7IuxLzdWfij
 k/EUH0EKPiFAkHfaWoOp0OnRnYadULH7RQuNz/mH/kcF8hn5Gi8WXBf
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Paul Cercueil <paul@crapouillou.net>

Adding write support to the buffer-dma code is easy - the write()
function basically needs to do the exact same thing as the read()
function: dequeue a block, read or write the data, enqueue the block
when entirely processed.

Therefore, the iio_buffer_dma_read() and the new iio_buffer_dma_write()
now both call a function iio_buffer_dma_io(), which will perform this
task.

Note that we preemptively reset block->bytes_used to the buffer's size
in iio_dma_buffer_request_update(), as in the future the
iio_dma_buffer_enqueue() function won't reset it.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
---
 drivers/iio/buffer/industrialio-buffer-dma.c | 89 +++++++++++++++++++++++-----
 include/linux/iio/buffer-dma.h               |  2 +
 2 files changed, 75 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index 404f9867bdc5..29cc3083cb7e 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -195,6 +195,18 @@ static void _iio_dma_buffer_block_done(struct iio_dma_buffer_block *block)
 		block->state = IIO_BLOCK_STATE_DONE;
 }
 
+static void iio_dma_buffer_queue_wake(struct iio_dma_buffer_queue *queue)
+{
+	__poll_t flags;
+
+	if (queue->buffer.direction == IIO_BUFFER_DIRECTION_IN)
+		flags = EPOLLIN | EPOLLRDNORM;
+	else
+		flags = EPOLLOUT | EPOLLWRNORM;
+
+	wake_up_interruptible_poll(&queue->buffer.pollq, flags);
+}
+
 /**
  * iio_dma_buffer_block_done() - Indicate that a block has been completed
  * @block: The completed block
@@ -212,7 +224,7 @@ void iio_dma_buffer_block_done(struct iio_dma_buffer_block *block)
 	spin_unlock_irqrestore(&queue->list_lock, flags);
 
 	iio_buffer_block_put_atomic(block);
-	wake_up_interruptible_poll(&queue->buffer.pollq, EPOLLIN | EPOLLRDNORM);
+	iio_dma_buffer_queue_wake(queue);
 }
 EXPORT_SYMBOL_GPL(iio_dma_buffer_block_done);
 
@@ -241,7 +253,7 @@ void iio_dma_buffer_block_list_abort(struct iio_dma_buffer_queue *queue,
 	}
 	spin_unlock_irqrestore(&queue->list_lock, flags);
 
-	wake_up_interruptible_poll(&queue->buffer.pollq, EPOLLIN | EPOLLRDNORM);
+	iio_dma_buffer_queue_wake(queue);
 }
 EXPORT_SYMBOL_GPL(iio_dma_buffer_block_list_abort);
 
@@ -335,8 +347,24 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
 			queue->fileio.blocks[i] = block;
 		}
 
-		block->state = IIO_BLOCK_STATE_QUEUED;
-		list_add_tail(&block->head, &queue->incoming);
+		/*
+		 * block->bytes_used may have been modified previously, e.g. by
+		 * iio_dma_buffer_block_list_abort(). Reset it here to the
+		 * block's so that iio_dma_buffer_io() will work.
+		 */
+		block->bytes_used = block->size;
+
+		/*
+		 * If it's an input buffer, mark the block as queued, and
+		 * iio_dma_buffer_enable() will submit it. Otherwise mark it as
+		 * done, which means it's ready to be dequeued.
+		 */
+		if (queue->buffer.direction == IIO_BUFFER_DIRECTION_IN) {
+			block->state = IIO_BLOCK_STATE_QUEUED;
+			list_add_tail(&block->head, &queue->incoming);
+		} else {
+			block->state = IIO_BLOCK_STATE_DONE;
+		}
 	}
 
 out_unlock:
@@ -488,20 +516,12 @@ static struct iio_dma_buffer_block *iio_dma_buffer_dequeue(
 	return block;
 }
 
-/**
- * iio_dma_buffer_read() - DMA buffer read callback
- * @buffer: Buffer to read form
- * @n: Number of bytes to read
- * @user_buffer: Userspace buffer to copy the data to
- *
- * Should be used as the read callback for iio_buffer_access_ops
- * struct for DMA buffers.
- */
-int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
-	char __user *user_buffer)
+static int iio_dma_buffer_io(struct iio_buffer *buffer, size_t n,
+			     char __user *user_buffer, bool is_from_user)
 {
 	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
 	struct iio_dma_buffer_block *block;
+	void *addr;
 	int ret;
 
 	if (n < buffer->bytes_per_datum)
@@ -524,8 +544,13 @@ int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
 	n = rounddown(n, buffer->bytes_per_datum);
 	if (n > block->bytes_used - queue->fileio.pos)
 		n = block->bytes_used - queue->fileio.pos;
+	addr = block->vaddr + queue->fileio.pos;
 
-	if (copy_to_user(user_buffer, block->vaddr + queue->fileio.pos, n)) {
+	if (is_from_user)
+		ret = copy_from_user(addr, user_buffer, n);
+	else
+		ret = copy_to_user(user_buffer, addr, n);
+	if (ret) {
 		ret = -EFAULT;
 		goto out_unlock;
 	}
@@ -544,8 +569,40 @@ int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
 
 	return ret;
 }
+
+/**
+ * iio_dma_buffer_read() - DMA buffer read callback
+ * @buffer: Buffer to read form
+ * @n: Number of bytes to read
+ * @user_buffer: Userspace buffer to copy the data to
+ *
+ * Should be used as the read callback for iio_buffer_access_ops
+ * struct for DMA buffers.
+ */
+int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
+	char __user *user_buffer)
+{
+	return iio_dma_buffer_io(buffer, n, user_buffer, false);
+}
 EXPORT_SYMBOL_GPL(iio_dma_buffer_read);
 
+/**
+ * iio_dma_buffer_write() - DMA buffer write callback
+ * @buffer: Buffer to read form
+ * @n: Number of bytes to read
+ * @user_buffer: Userspace buffer to copy the data from
+ *
+ * Should be used as the write callback for iio_buffer_access_ops
+ * struct for DMA buffers.
+ */
+int iio_dma_buffer_write(struct iio_buffer *buffer, size_t n,
+			 const char __user *user_buffer)
+{
+	return iio_dma_buffer_io(buffer, n,
+				 (__force __user char *)user_buffer, true);
+}
+EXPORT_SYMBOL_GPL(iio_dma_buffer_write);
+
 /**
  * iio_dma_buffer_usage() - DMA buffer data_available and
  * space_available callback
diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
index 52a838ec0e57..6e27e47077d5 100644
--- a/include/linux/iio/buffer-dma.h
+++ b/include/linux/iio/buffer-dma.h
@@ -132,6 +132,8 @@ int iio_dma_buffer_disable(struct iio_buffer *buffer,
 	struct iio_dev *indio_dev);
 int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
 	char __user *user_buffer);
+int iio_dma_buffer_write(struct iio_buffer *buffer, size_t n,
+			 const char __user *user_buffer);
 size_t iio_dma_buffer_usage(struct iio_buffer *buffer);
 int iio_dma_buffer_set_bytes_per_datum(struct iio_buffer *buffer, size_t bpd);
 int iio_dma_buffer_set_length(struct iio_buffer *buffer, unsigned int length);

-- 
2.43.0


