Return-Path: <linux-iio+bounces-24811-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 210FFBC0D59
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 11:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 581C84F0B3C
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 09:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD6E2D73AB;
	Tue,  7 Oct 2025 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4ovP4ga"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B211991CA;
	Tue,  7 Oct 2025 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759828491; cv=none; b=tAnvkf37SRkKTuhISjk+5zFPnSjD4gEjG1G4Yar2IdKbjp+gPitWjMt1G+QXKcqPHFFl0cwzhFFpwcF8nihM2INh2pu38UYzWOoH/mkOoBjTwJWV7nBLMCwKJAtevwnhHoceb62QEwg/efzNwoNSdaw4gyqYQ6umH9wz7UKuKTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759828491; c=relaxed/simple;
	bh=9s7ap3IPhFQJ0fjBQY2mJoKLoLN3BrhM8aCig8PzD4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c30D3ejNAv4v0usSb2WV1YUuO5PWsNu14FFbG+FmNiKIVPd0KTCqjkZt1fRmsdVLtID2JNtU0YZWYoyI0oREE0sZuNek+looOXqFok8h+I5LLLWZQyc5G0UzGzVudy/FTQubZ88uyFWXWcat6bIIL+nLiw/pjPWNkrW1NfLz54I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4ovP4ga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DD1EC4CEF9;
	Tue,  7 Oct 2025 09:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759828491;
	bh=9s7ap3IPhFQJ0fjBQY2mJoKLoLN3BrhM8aCig8PzD4M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=h4ovP4gaeg6trk9FSD/a6+gDRmTiqJdGjmpAQsvPYAXKQnx7tVy4Un+RTTss4rHJy
	 17ICUG9f0niDgF32xtShC1SwfuryaIPF+uN7kKFm3DCiu8yLGjcZ+QuKdFN5DtXHJ1
	 90p48AX+8NDzzWoVfIHMdpHR5HorSzgax4H8QspWGNynT30Nj1jf8N5lyyn8g5dIAH
	 FXyWfTlHQYxm4Fvp1SyRTIKUdwOwGoVayn1Tpd0IoeK/9AjYRSixVfLrUXnag+qlrd
	 2VnnCNymBQaMQWFn3bc7iC+Vq+gZQFJ02FcyvfIir4bWo7qNUx7PCSQZeHIscmq+Hl
	 boHHl2/uIV3IA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E33ECCD184;
	Tue,  7 Oct 2025 09:14:51 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 07 Oct 2025 10:15:21 +0100
Subject: [PATCH v3 1/3] iio: buffer: support getting dma channel from the
 buffer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251007-fix-iio-dmabuf-get-dma-device-v3-1-0c73e2c0653b@analog.com>
References: <20251007-fix-iio-dmabuf-get-dma-device-v3-0-0c73e2c0653b@analog.com>
In-Reply-To: <20251007-fix-iio-dmabuf-get-dma-device-v3-0-0c73e2c0653b@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759828521; l=5123;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=+7B4M4g0oii5at3ljQ2R7qfIy/Gk+7w2PvcLmO3dnFQ=;
 b=S+OYyfZ4vKAEaGBUvtDa+8sQ+HVdrzhPwoQzPNLaMlmd2e4CbFr5vQNlJnW08EnOifU2qHYn9
 QR4ROsZJrKwD3kylVg6R+3D2quxCIucs0l75zAZxtd0HKcyJV0Oc9JW
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

In the process, add an iio_buffer_get_dma_dev() helper function to get
the proper DMA device.

Cc: stable@vger.kernel.org
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/industrialio-buffer.c | 21 ++++++++++++++++-----
 include/linux/iio/buffer_impl.h   |  2 ++
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index f1448ae1b843fc577599fc1b9cf6d859bba226f1..bbdc0c4a158795750bc441a9f89e84ba0ed75172 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1623,19 +1623,28 @@ static int iio_dma_resv_lock(struct dma_buf *dmabuf, bool nonblock)
 	return 0;
 }
 
+static struct device *iio_buffer_get_dma_dev(const struct iio_dev *indio_dev,
+					     struct iio_buffer *buffer)
+{
+	if (buffer->access->get_dma_dev)
+		return buffer->access->get_dma_dev(buffer);
+
+	return indio_dev->dev.parent;
+}
+
 static struct dma_buf_attachment *
 iio_buffer_find_attachment(struct iio_dev_buffer_pair *ib,
 			   struct dma_buf *dmabuf, bool nonblock)
 {
-	struct device *dev = ib->indio_dev->dev.parent;
 	struct iio_buffer *buffer = ib->buffer;
+	struct device *dma_dev = iio_buffer_get_dma_dev(ib->indio_dev, buffer);
 	struct dma_buf_attachment *attach = NULL;
 	struct iio_dmabuf_priv *priv;
 
 	guard(mutex)(&buffer->dmabufs_mutex);
 
 	list_for_each_entry(priv, &buffer->dmabufs, entry) {
-		if (priv->attach->dev == dev
+		if (priv->attach->dev == dma_dev
 		    && priv->attach->dmabuf == dmabuf) {
 			attach = priv->attach;
 			break;
@@ -1653,6 +1662,7 @@ static int iio_buffer_attach_dmabuf(struct iio_dev_buffer_pair *ib,
 {
 	struct iio_dev *indio_dev = ib->indio_dev;
 	struct iio_buffer *buffer = ib->buffer;
+	struct device *dma_dev = iio_buffer_get_dma_dev(indio_dev, buffer);
 	struct dma_buf_attachment *attach;
 	struct iio_dmabuf_priv *priv, *each;
 	struct dma_buf *dmabuf;
@@ -1679,7 +1689,7 @@ static int iio_buffer_attach_dmabuf(struct iio_dev_buffer_pair *ib,
 		goto err_free_priv;
 	}
 
-	attach = dma_buf_attach(dmabuf, indio_dev->dev.parent);
+	attach = dma_buf_attach(dmabuf, dma_dev);
 	if (IS_ERR(attach)) {
 		err = PTR_ERR(attach);
 		goto err_dmabuf_put;
@@ -1719,7 +1729,7 @@ static int iio_buffer_attach_dmabuf(struct iio_dev_buffer_pair *ib,
 	 * combo. If we do, refuse to attach.
 	 */
 	list_for_each_entry(each, &buffer->dmabufs, entry) {
-		if (each->attach->dev == indio_dev->dev.parent
+		if (each->attach->dev == dma_dev
 		    && each->attach->dmabuf == dmabuf) {
 			/*
 			 * We unlocked the reservation object, so going through
@@ -1758,6 +1768,7 @@ static int iio_buffer_detach_dmabuf(struct iio_dev_buffer_pair *ib,
 {
 	struct iio_buffer *buffer = ib->buffer;
 	struct iio_dev *indio_dev = ib->indio_dev;
+	struct device *dma_dev = iio_buffer_get_dma_dev(indio_dev, buffer);
 	struct iio_dmabuf_priv *priv;
 	struct dma_buf *dmabuf;
 	int dmabuf_fd, ret = -EPERM;
@@ -1772,7 +1783,7 @@ static int iio_buffer_detach_dmabuf(struct iio_dev_buffer_pair *ib,
 	guard(mutex)(&buffer->dmabufs_mutex);
 
 	list_for_each_entry(priv, &buffer->dmabufs, entry) {
-		if (priv->attach->dev == indio_dev->dev.parent
+		if (priv->attach->dev == dma_dev
 		    && priv->attach->dmabuf == dmabuf) {
 			list_del(&priv->entry);
 
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



