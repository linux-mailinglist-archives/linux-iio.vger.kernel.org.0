Return-Path: <linux-iio+bounces-7934-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4499193D24B
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 13:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9309B20BFA
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 11:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C844178CCF;
	Fri, 26 Jul 2024 11:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1TPJ1q1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE5F1EF01
	for <linux-iio@vger.kernel.org>; Fri, 26 Jul 2024 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721993477; cv=none; b=l3VBY5XkV+TXG9NbHMtkS0qn10afi8r+a23gyeoDC8lJuAn3jCLaq0Y9+HX/CCE56jmttjmNsQnBsH7n1gWcqffzTzCV9Ie5Z5DI5wP++n9AxS773yyRxoSz3a0zV+K2SpHI3/gM1xVUGOF9Dii3WS78rR2uZr96Ud1IQB8LIrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721993477; c=relaxed/simple;
	bh=JlNRETbJ9dBmXVCNM6lUZesgDCjptqkB90Fm4/PaJIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZX1e15uz5Fxr9+X1AyRGbYEE/nosHtXU4NUtYbnV6jSd7GOaoZmNaacO71CJd8U4wFf9u7QhUgLtEf+UyMf/Pa9m3gwRURU23vFA1l8g26M0lP9MxUFfQVR40fnWm73mL1FxU42AjLvuVeiHhiMO62NU2IQptCh/SrJKMyO3uaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1TPJ1q1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C151C32782;
	Fri, 26 Jul 2024 11:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721993476;
	bh=JlNRETbJ9dBmXVCNM6lUZesgDCjptqkB90Fm4/PaJIY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=E1TPJ1q1O/+ywkRzzKbMrN7+7XnVSo/YYg2w1FhDbnIQ5TuwgoN3qm7+ovukeCbZn
	 d5Vla1pi2DNZsvweBxL26RqZ0cwpVxLeMKPv4/Is4FnkAHnJWPxSMmaag+tcSotT7q
	 xR1nc9H+rUJn0s59wYV/0VBcjmP9mifKvZQHyjwsdCqJGPn9GS2Nh8Sbp3DpkSUdxq
	 rngCDFVFYd1FeMIpAP8FFR8lwWGd7+eZX+raWroxeutQVljKjqyWkzQiY3P2VwidxP
	 FiwrX74zc8Fa9O0iA3HjmmZlky/JN1HwKWdGd+QStRWayftPYjSA/LGyllyeva/MPt
	 vNXUk+1RTtukg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896A1C3DA7F;
	Fri, 26 Jul 2024 11:31:16 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 26 Jul 2024 13:31:15 +0200
Subject: [PATCH] iio: buffer-dma: Move exports into IIO_DMA_BUFFER
 namespace
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240726-dev-iio-dma-buf-mod-namespace-v1-1-8877cfe7f68e@analog.com>
X-B4-Tracking: v=1; b=H4sIAAKJo2YC/x3MMQqEMBAF0KvI1A5ojK7rVcQia746RRJJUATx7
 hssX/NuSoiCRENxU8QpSYLPqMuC5s34FSw2m1SldPVRHVucLBLYOsO/Y2EXLHvjkHYzg1vVoNX
 1t9e9pnzsEYtc7z9Oz/MHfQvUJm8AAAA=
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721993475; l=7129;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=76KN45pWp9MF4JylEXizXpsfiEB/qHdPlOkyB2Qqqis=;
 b=Pm8ZzgBv5bDILllFgrdv2Xk+Kb9g8bktMZHTrYRhfqTWWcNTuByfZX27Arq2v/GZVaJYlmjRb
 Iin13ecRPgDDUPRCZH5VBSO/LSxL5Pr/wR+N69pmJFBzqBXA8cAh0jz
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Avoid unnecessary pollution of the global symbol namespace and move
global APIs into a specific namespace. Import that into the places that
use them

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dma.c       | 36 +++++++++++-----------
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  1 +
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index 647f417a045e..dbde1443d6ed 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -248,7 +248,7 @@ void iio_dma_buffer_block_done(struct iio_dma_buffer_block *block)
 	iio_dma_buffer_queue_wake(queue);
 	dma_fence_end_signalling(cookie);
 }
-EXPORT_SYMBOL_GPL(iio_dma_buffer_block_done);
+EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_block_done, IIO_DMA_BUFFER);
 
 /**
  * iio_dma_buffer_block_list_abort() - Indicate that a list block has been
@@ -287,7 +287,7 @@ void iio_dma_buffer_block_list_abort(struct iio_dma_buffer_queue *queue,
 	iio_dma_buffer_queue_wake(queue);
 	dma_fence_end_signalling(cookie);
 }
-EXPORT_SYMBOL_GPL(iio_dma_buffer_block_list_abort);
+EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_block_list_abort, IIO_DMA_BUFFER);
 
 static bool iio_dma_block_reusable(struct iio_dma_buffer_block *block)
 {
@@ -420,7 +420,7 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(iio_dma_buffer_request_update);
+EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_request_update, IIO_DMA_BUFFER);
 
 static void iio_dma_buffer_fileio_free(struct iio_dma_buffer_queue *queue)
 {
@@ -506,7 +506,7 @@ int iio_dma_buffer_enable(struct iio_buffer *buffer,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(iio_dma_buffer_enable);
+EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_enable, IIO_DMA_BUFFER);
 
 /**
  * iio_dma_buffer_disable() - Disable DMA buffer
@@ -530,7 +530,7 @@ int iio_dma_buffer_disable(struct iio_buffer *buffer,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(iio_dma_buffer_disable);
+EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_disable, IIO_DMA_BUFFER);
 
 static void iio_dma_buffer_enqueue(struct iio_dma_buffer_queue *queue,
 	struct iio_dma_buffer_block *block)
@@ -636,7 +636,7 @@ int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
 {
 	return iio_dma_buffer_io(buffer, n, user_buffer, false);
 }
-EXPORT_SYMBOL_GPL(iio_dma_buffer_read);
+EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_read, IIO_DMA_BUFFER);
 
 /**
  * iio_dma_buffer_write() - DMA buffer write callback
@@ -653,7 +653,7 @@ int iio_dma_buffer_write(struct iio_buffer *buffer, size_t n,
 	return iio_dma_buffer_io(buffer, n,
 				 (__force __user char *)user_buffer, true);
 }
-EXPORT_SYMBOL_GPL(iio_dma_buffer_write);
+EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_write, IIO_DMA_BUFFER);
 
 /**
  * iio_dma_buffer_usage() - DMA buffer data_available and
@@ -696,7 +696,7 @@ size_t iio_dma_buffer_usage(struct iio_buffer *buf)
 
 	return data_available;
 }
-EXPORT_SYMBOL_GPL(iio_dma_buffer_usage);
+EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_usage, IIO_DMA_BUFFER);
 
 struct iio_dma_buffer_block *
 iio_dma_buffer_attach_dmabuf(struct iio_buffer *buffer,
@@ -723,7 +723,7 @@ iio_dma_buffer_attach_dmabuf(struct iio_buffer *buffer,
 
 	return block;
 }
-EXPORT_SYMBOL_GPL(iio_dma_buffer_attach_dmabuf);
+EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_attach_dmabuf, IIO_DMA_BUFFER);
 
 void iio_dma_buffer_detach_dmabuf(struct iio_buffer *buffer,
 				  struct iio_dma_buffer_block *block)
@@ -731,7 +731,7 @@ void iio_dma_buffer_detach_dmabuf(struct iio_buffer *buffer,
 	block->state = IIO_BLOCK_STATE_DEAD;
 	iio_buffer_block_put_atomic(block);
 }
-EXPORT_SYMBOL_GPL(iio_dma_buffer_detach_dmabuf);
+EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_detach_dmabuf, IIO_DMA_BUFFER);
 
 static int iio_dma_can_enqueue_block(struct iio_dma_buffer_block *block)
 {
@@ -784,7 +784,7 @@ int iio_dma_buffer_enqueue_dmabuf(struct iio_buffer *buffer,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(iio_dma_buffer_enqueue_dmabuf);
+EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_enqueue_dmabuf, IIO_DMA_BUFFER);
 
 void iio_dma_buffer_lock_queue(struct iio_buffer *buffer)
 {
@@ -792,7 +792,7 @@ void iio_dma_buffer_lock_queue(struct iio_buffer *buffer)
 
 	mutex_lock(&queue->lock);
 }
-EXPORT_SYMBOL_GPL(iio_dma_buffer_lock_queue);
+EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_lock_queue, IIO_DMA_BUFFER);
 
 void iio_dma_buffer_unlock_queue(struct iio_buffer *buffer)
 {
@@ -800,7 +800,7 @@ void iio_dma_buffer_unlock_queue(struct iio_buffer *buffer)
 
 	mutex_unlock(&queue->lock);
 }
-EXPORT_SYMBOL_GPL(iio_dma_buffer_unlock_queue);
+EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_unlock_queue, IIO_DMA_BUFFER);
 
 /**
  * iio_dma_buffer_set_bytes_per_datum() - DMA buffer set_bytes_per_datum callback
@@ -816,7 +816,7 @@ int iio_dma_buffer_set_bytes_per_datum(struct iio_buffer *buffer, size_t bpd)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(iio_dma_buffer_set_bytes_per_datum);
+EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_set_bytes_per_datum, IIO_DMA_BUFFER);
 
 /**
  * iio_dma_buffer_set_length - DMA buffer set_length callback
@@ -836,7 +836,7 @@ int iio_dma_buffer_set_length(struct iio_buffer *buffer, unsigned int length)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(iio_dma_buffer_set_length);
+EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_set_length, IIO_DMA_BUFFER);
 
 /**
  * iio_dma_buffer_init() - Initialize DMA buffer queue
@@ -864,7 +864,7 @@ int iio_dma_buffer_init(struct iio_dma_buffer_queue *queue,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(iio_dma_buffer_init);
+EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_init, IIO_DMA_BUFFER);
 
 /**
  * iio_dma_buffer_exit() - Cleanup DMA buffer queue
@@ -882,7 +882,7 @@ void iio_dma_buffer_exit(struct iio_dma_buffer_queue *queue)
 
 	mutex_unlock(&queue->lock);
 }
-EXPORT_SYMBOL_GPL(iio_dma_buffer_exit);
+EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_exit, IIO_DMA_BUFFER);
 
 /**
  * iio_dma_buffer_release() - Release final buffer resources
@@ -896,7 +896,7 @@ void iio_dma_buffer_release(struct iio_dma_buffer_queue *queue)
 {
 	mutex_destroy(&queue->lock);
 }
-EXPORT_SYMBOL_GPL(iio_dma_buffer_release);
+EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_release, IIO_DMA_BUFFER);
 
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_DESCRIPTION("DMA buffer for the IIO framework");
diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 12aa1412dfa0..a2246826c11e 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -348,3 +348,4 @@ EXPORT_SYMBOL_NS_GPL(devm_iio_dmaengine_buffer_setup_ext, IIO_DMAENGINE_BUFFER);
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_DESCRIPTION("DMA buffer for the IIO framework");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_DMA_BUFFER);

---
base-commit: 472438c7e0e2261c6737a8321f46ef176eef1c8f
change-id: 20240726-dev-iio-dma-buf-mod-namespace-523e54198484
--

Thanks!
- Nuno Sá



