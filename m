Return-Path: <linux-iio+bounces-24661-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA96BB442B
	for <lists+linux-iio@lfdr.de>; Thu, 02 Oct 2025 17:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC7D51C1D8C
	for <lists+linux-iio@lfdr.de>; Thu,  2 Oct 2025 15:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C6216DC28;
	Thu,  2 Oct 2025 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6Z4HqP6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FE333997
	for <linux-iio@vger.kernel.org>; Thu,  2 Oct 2025 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759417560; cv=none; b=YwS0IeNi424pIGkvm0VXRyyOPDDi7DJOB9D6k7dz04iDCHWGZ+DphUpTsDuvb2DO/xTRkzzia3eo3gw1LXs1UgdXwyIyp/mbQzKlsBVWiSXD9mAbRYX81jlg2N7Vo0ZAsQvtLiRXUB+tywELGHm87XwwpT65zXHZXQ+PuLVggWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759417560; c=relaxed/simple;
	bh=ZKZ3faTHDg+RCyRtcpkJQQQ6tqZo8gqaJyDvMtrK+PU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e+GAlTlMBy5dFiZiTDV5dl2gV3hNiANUY85RWH0p31Pp6V6sYXo0X/OFM17VmGEWt0wIVOgYH+2R+iwUPNy08OuHlex3/4Qr96NpVKIZ3N3V3izR/nJ61lwSOGul5E9OXH1PYjaCCnJET71geELjiuLtUtoAygwNbXQjT/AKxeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6Z4HqP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66E09C4CEF9;
	Thu,  2 Oct 2025 15:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759417560;
	bh=ZKZ3faTHDg+RCyRtcpkJQQQ6tqZo8gqaJyDvMtrK+PU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=J6Z4HqP6N+Y/1gyzo+rIwNAcbN0dCrVgep8oa7m4/19VbeGY1h61CA5Vy7JKBck02
	 SieL0SF3zZWo3k6C+Ni6JGIx/+6JXXQqdYRBE80iozbJxrjQRMvJWRixeVYV63ZNuD
	 nNoEgQHbmFWGX9ad7pXYgSN4a39NEV35eWL/VS4gi3sTeXpEtF4zLvJTclAA9CkARu
	 +bNkSOGWufjJLpcDSUlvA46XC47jazd7c512crxhE3jCfuv6+VgPfS3ATq0t+biGhR
	 nq5w0nLuwXEN/2Yyv6Og5OsVLG7/vLmCt/vfA+OwD3UprQDQ3yNaZSwGHHUr3R649X
	 4SNKaBN5caqGQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53138CAC5B0;
	Thu,  2 Oct 2025 15:06:00 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 02 Oct 2025 16:06:28 +0100
Subject: [PATCH 1/3] iio: buffer: support getting dma channel from the
 buffer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251002-fix-iio-dmabuf-get-dma-device-v1-1-c1c9945029d0@analog.com>
References: <20251002-fix-iio-dmabuf-get-dma-device-v1-0-c1c9945029d0@analog.com>
In-Reply-To: <20251002-fix-iio-dmabuf-get-dma-device-v1-0-c1c9945029d0@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759417589; l=5086;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=ddJBu/hYz0gDJzFzZDUZ5HVRpDUBzFtShZwYan4tB9E=;
 b=2bLYsq4c6Mft4uSCAPUxM9aH5Rm/1iZ9H4C8BoUfLxjKmK/iMpD0Fg0lf5HzCKeNfu5DzQSqF
 yBAlW53ZFrGAGeXy7Mjtx3iKzFCNO99SpCeI76OcIf8s7M9e7g3/XOs
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

Fixes: 3e26d9f08fbe ("iio: core: Add new DMABUF interface infrastructure")
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



