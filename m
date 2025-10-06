Return-Path: <linux-iio+bounces-24779-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C69F0BBE949
	for <lists+linux-iio@lfdr.de>; Mon, 06 Oct 2025 18:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75FD23B4732
	for <lists+linux-iio@lfdr.de>; Mon,  6 Oct 2025 16:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8BC2D94B7;
	Mon,  6 Oct 2025 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgCUwDKm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDA527A91D;
	Mon,  6 Oct 2025 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759766764; cv=none; b=hUSRPrBgAJjEGznzN9HRds6A0uudTkE9uO/MCZuzWhiiCxH8GoednT9TjUHsNK9jAIH+EQNACDOKQuGpa3dvBxvdvutD51uulHGO6ZYtRwGgQ6SKv2qayE93D1gi7regh42C9zuEfqBrCM+q9Awmv4bSLEq4aNbxFfJftUZccxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759766764; c=relaxed/simple;
	bh=hMu7giAbdbvn5ePahu1iYygDLe3S2U36psm6y+brqik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c66Hwdvy2VW9QHJ6r3K8oxP4MKgTDUstS0CCXCT38nPw9LBAJ5koeinv9D8QeUKFEbdBBhlfPTFAm/GGKD7SjCv3axyjGqB265ZbCfBghXWPp25bQV5gSRHISbtV4WjOEzSck+sFCq9BSg99EtRzm98RjqhGwt+qePrBtV9K7u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgCUwDKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC66BC4CEFF;
	Mon,  6 Oct 2025 16:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759766763;
	bh=hMu7giAbdbvn5ePahu1iYygDLe3S2U36psm6y+brqik=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PgCUwDKmGX+i/qM9SEoy2mTwQuHAnj4CLUef0JSxaISFHlGcFaK9E/vjqK5jE+AM1
	 a61djJpQWf5hUYvSX48m+eNcZLKTDpfi+K0P/haH84adsqA9oxmjvnw14OD0pULngE
	 B3pdNuspkTL3Ub1Q3b+7XNsHZtTgk0/1P76URWfyjhv0mIK6maSqMc3lOJqoi+5EXf
	 9urCkxcUceuEiScjTLl+LpPRH6Ve06iDo5CcYEjPjgHioRu09sSDANHxSyNA1vaiAI
	 9wRhdnMUo5IC3rG+0LHnjY2/NOJf9HYwls4CVcxBeEkjBPYjTZ83w8UVVVXi2wTpWq
	 9qq6SR7SdLLwA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5835CAC5B8;
	Mon,  6 Oct 2025 16:06:03 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 06 Oct 2025 17:06:32 +0100
Subject: [PATCH v2 1/3] iio: buffer: support getting dma channel from the
 buffer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251006-fix-iio-dmabuf-get-dma-device-v2-1-d960bc9084da@analog.com>
References: <20251006-fix-iio-dmabuf-get-dma-device-v2-0-d960bc9084da@analog.com>
In-Reply-To: <20251006-fix-iio-dmabuf-get-dma-device-v2-0-d960bc9084da@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759766793; l=5038;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Eok3Bx4CN1Rhtb1fOuQlhdDCIni3+z1WDGwIF0dt+ls=;
 b=W1oVUaNgHp6n9uQAssMF98nPZYuYb2cVuzRt8K5y4fmOs0gUqF2Cr2jXBciveuh6VmpGrcDbX
 WL2kPKVzBu3BVVNir3Z0ngR3rFb0s2yj7FgT9HxVLQS8purSfDMRnmO
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Add a new buffer accessor .get_dma_dev() in order to get the
struct device responsible for actually providing the dma channel. We
cannot assume that we can use the parent of the IIO device for mapping
the DMA buffer. This becomes important on systems (like the Xilinx/AMD
zynqMP Ultrascale) where memory (or part of it) is mapped above the
32 bit range. On such systems and given that a device by default has
a dma mask of 32 bits we would then need to rely on bounce buffers (to
swiotlb) for mapping memory above the dma mask limit.

Cc: stable@vger.kernel.org
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/industrialio-buffer.c | 28 ++++++++++++++++++++++------
 include/linux/iio/buffer_impl.h   |  2 ++
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index f1448ae1b843fc577599fc1b9cf6d859bba226f1..279c7d716bf5d467d40b5c290789fcbd1f949660 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1627,15 +1627,20 @@ static struct dma_buf_attachment *
 iio_buffer_find_attachment(struct iio_dev_buffer_pair *ib,
 			   struct dma_buf *dmabuf, bool nonblock)
 {
-	struct device *dev = ib->indio_dev->dev.parent;
+	struct device *dma_dev;
 	struct iio_buffer *buffer = ib->buffer;
 	struct dma_buf_attachment *attach = NULL;
 	struct iio_dmabuf_priv *priv;
 
+	if (buffer->access->get_dma_dev)
+		dma_dev = buffer->access->get_dma_dev(buffer);
+	else
+		dma_dev = ib->indio_dev->dev.parent;
+
 	guard(mutex)(&buffer->dmabufs_mutex);
 
 	list_for_each_entry(priv, &buffer->dmabufs, entry) {
-		if (priv->attach->dev == dev
+		if (priv->attach->dev == dma_dev
 		    && priv->attach->dmabuf == dmabuf) {
 			attach = priv->attach;
 			break;
@@ -1655,6 +1660,7 @@ static int iio_buffer_attach_dmabuf(struct iio_dev_buffer_pair *ib,
 	struct iio_buffer *buffer = ib->buffer;
 	struct dma_buf_attachment *attach;
 	struct iio_dmabuf_priv *priv, *each;
+	struct device *dma_dev;
 	struct dma_buf *dmabuf;
 	int err, fd;
 
@@ -1679,7 +1685,12 @@ static int iio_buffer_attach_dmabuf(struct iio_dev_buffer_pair *ib,
 		goto err_free_priv;
 	}
 
-	attach = dma_buf_attach(dmabuf, indio_dev->dev.parent);
+	if (buffer->access->get_dma_dev)
+		dma_dev = buffer->access->get_dma_dev(buffer);
+	else
+		dma_dev = indio_dev->dev.parent;
+
+	attach = dma_buf_attach(dmabuf, dma_dev);
 	if (IS_ERR(attach)) {
 		err = PTR_ERR(attach);
 		goto err_dmabuf_put;
@@ -1719,7 +1730,7 @@ static int iio_buffer_attach_dmabuf(struct iio_dev_buffer_pair *ib,
 	 * combo. If we do, refuse to attach.
 	 */
 	list_for_each_entry(each, &buffer->dmabufs, entry) {
-		if (each->attach->dev == indio_dev->dev.parent
+		if (each->attach->dev == dma_dev
 		    && each->attach->dmabuf == dmabuf) {
 			/*
 			 * We unlocked the reservation object, so going through
@@ -1759,6 +1770,7 @@ static int iio_buffer_detach_dmabuf(struct iio_dev_buffer_pair *ib,
 	struct iio_buffer *buffer = ib->buffer;
 	struct iio_dev *indio_dev = ib->indio_dev;
 	struct iio_dmabuf_priv *priv;
+	struct device *dma_dev;
 	struct dma_buf *dmabuf;
 	int dmabuf_fd, ret = -EPERM;
 
@@ -1769,11 +1781,15 @@ static int iio_buffer_detach_dmabuf(struct iio_dev_buffer_pair *ib,
 	if (IS_ERR(dmabuf))
 		return PTR_ERR(dmabuf);
 
+	if (buffer->access->get_dma_dev)
+		dma_dev = buffer->access->get_dma_dev(buffer);
+	else
+		dma_dev = indio_dev->dev.parent;
+
 	guard(mutex)(&buffer->dmabufs_mutex);
 
 	list_for_each_entry(priv, &buffer->dmabufs, entry) {
-		if (priv->attach->dev == indio_dev->dev.parent
-		    && priv->attach->dmabuf == dmabuf) {
+		if (priv->attach->dev == dma_dev && priv->attach->dmabuf == dmabuf) {
 			list_del(&priv->entry);
 
 			/* Unref the reference from iio_buffer_attach_dmabuf() */
diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
index 0daff9ff20ce49de67fa0f2ac6191882de2f4a67..c0b0e0992a85b2813a126c1a61f13f1ed0b498dd 100644
--- a/include/linux/iio/buffer_impl.h
+++ b/include/linux/iio/buffer_impl.h
@@ -51,6 +51,7 @@ struct sg_table;
  * @enqueue_dmabuf:	called from userspace via ioctl to queue this DMABUF
  *			object to this buffer. Requires a valid DMABUF fd, that
  *			was previouly attached to this buffer.
+ * @get_dma_dev:	called to get the DMA channel associated with this buffer.
  * @lock_queue:		called when the core needs to lock the buffer queue;
  *                      it is used when enqueueing DMABUF objects.
  * @unlock_queue:       used to unlock a previously locked buffer queue
@@ -91,6 +92,7 @@ struct iio_buffer_access_funcs {
 			      struct iio_dma_buffer_block *block,
 			      struct dma_fence *fence, struct sg_table *sgt,
 			      size_t size, bool cyclic);
+	struct device * (*get_dma_dev)(struct iio_buffer *buffer);
 	void (*lock_queue)(struct iio_buffer *buffer);
 	void (*unlock_queue)(struct iio_buffer *buffer);
 

-- 
2.51.0



