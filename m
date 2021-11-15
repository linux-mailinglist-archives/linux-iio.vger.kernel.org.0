Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B814506F1
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 15:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236718AbhKOOdi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Nov 2021 09:33:38 -0500
Received: from aposti.net ([89.234.176.197]:51584 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236527AbhKOObR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Nov 2021 09:31:17 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 14/15] iio: buffer-dmaengine: Add support for cyclic buffers
Date:   Mon, 15 Nov 2021 14:22:42 +0000
Message-Id: <20211115142243.60605-3-paul@crapouillou.net>
In-Reply-To: <20211115142243.60605-1-paul@crapouillou.net>
References: <20211115141925.60164-1-paul@crapouillou.net>
 <20211115142243.60605-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Handle the IIO_BUFFER_DMABUF_CYCLIC flag to support cyclic buffers.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/iio/buffer/industrialio-buffer-dma.c      |  1 +
 .../iio/buffer/industrialio-buffer-dmaengine.c    | 15 ++++++++++++---
 include/linux/iio/buffer-dma.h                    |  3 +++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index fb39054d8c15..6658f103ee17 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -933,6 +933,7 @@ int iio_dma_buffer_enqueue_dmabuf(struct iio_buffer *buffer,
 	}
 
 	dma_block->bytes_used = iio_dmabuf->bytes_used ?: dma_block->size;
+	dma_block->cyclic = iio_dmabuf->flags & IIO_BUFFER_DMABUF_CYCLIC;
 
 	switch (dma_block->state) {
 	case IIO_BLOCK_STATE_QUEUED:
diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 57a8b2e4ba3c..952e2160a11e 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -81,9 +81,18 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
 	if (!block->bytes_used || block->bytes_used > max_size)
 		return -EINVAL;
 
-	desc = dmaengine_prep_slave_single(dmaengine_buffer->chan,
-		block->phys_addr, block->bytes_used, dma_dir,
-		DMA_PREP_INTERRUPT);
+	if (block->cyclic) {
+		desc = dmaengine_prep_dma_cyclic(dmaengine_buffer->chan,
+						 block->phys_addr,
+						 block->size,
+						 block->bytes_used,
+						 dma_dir, 0);
+	} else {
+		desc = dmaengine_prep_slave_single(dmaengine_buffer->chan,
+						   block->phys_addr,
+						   block->bytes_used, dma_dir,
+						   DMA_PREP_INTERRUPT);
+	}
 	if (!desc)
 		return -ENOMEM;
 
diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
index 85e55fe35282..27639fdf7b54 100644
--- a/include/linux/iio/buffer-dma.h
+++ b/include/linux/iio/buffer-dma.h
@@ -42,6 +42,7 @@ enum iio_block_state {
  * @phys_addr: Physical address of the blocks memory
  * @queue: Parent DMA buffer queue
  * @state: Current state of the block
+ * @cyclic: True if this is a cyclic buffer
  * @fileio: True if this buffer is used for fileio mode
  * @dmabuf: Underlying DMABUF object
  */
@@ -65,6 +66,8 @@ struct iio_dma_buffer_block {
 	 */
 	enum iio_block_state state;
 
+	bool cyclic;
+
 	bool fileio;
 	struct dma_buf *dmabuf;
 };
-- 
2.33.0

