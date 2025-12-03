Return-Path: <linux-iio+bounces-26685-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31460C9F71F
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 16:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58F97305ECA9
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 15:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38020326957;
	Wed,  3 Dec 2025 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lge96sFc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E994F325720
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764774658; cv=none; b=lThxDPnlM++jZqMaq11BTnpo+qngl/13iBHhu4cEczc4iqx1BXVjDSXMZsDPluUDZBsSA5ChNCfjyUi+pDSXWUcl90XGN1LjqR7HSRGDmLA3DIxdc5K61SLl1qMRt0mjsgbq65M2ftTmD+mAukPMq5K+HFqJZ3n2xAzIgW+zgYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764774658; c=relaxed/simple;
	bh=I3O/x/GEHjQRFI5CHmtL1PJ1J1Jn9cPGCQWJxOGSu4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UPtFZpMyGnd3YOgxgMT14QhGz/0UvEMBQvD8JNSK1LyOUvm97vzLbdwdursaDWhu8OlIkbWZUcqcw/8s1DiHxJ3YP7ANnL9+/JYQo715nWn2vc6bGIqXb+fgoIzlbJfryq3VSzUZcyivoio/PTDdrYg8F51Ceyj5uy+t3mSxxdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lge96sFc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F3D7C19422;
	Wed,  3 Dec 2025 15:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764774657;
	bh=I3O/x/GEHjQRFI5CHmtL1PJ1J1Jn9cPGCQWJxOGSu4M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lge96sFcMa35QjmrzwdTZRNGufTxTlgwOl4SHvqXgCAznXM6t1cd3dj9L475vrnbH
	 qB2lC0kYyseBfAE5PgtY8p3GM35WRfj4X5x+cnP5iqBFK8umFqoK4Ik/2iV9NejmMX
	 c43wegpippxFErRtRB+1XAs4uq5nbAvfwHasJpqBz0E7AFmJ4X2egJ4m/rRXdQq1I6
	 XLtjiP0NgV9fUV8MZB1emBTSFBiqxGon9iIcfd/nVa4QYkCG8MwR1V81hRfiVmzkID
	 eP5EZdzUYbfeANW+h/5Wtw9WwL69vtWTQ8HSnrokHPg7mmeWq2l+lrLxunu9zP0wVc
	 JLhU3zBw2SBaQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846DAD12D7E;
	Wed,  3 Dec 2025 15:10:57 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 03 Dec 2025 15:11:38 +0000
Subject: [PATCH 3/6] iio: buffer-dma: Turn iio_dma_buffer_init() void
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251203-iio-dmabuf-improvs-v1-3-0e4907ce7322@analog.com>
References: <20251203-iio-dmabuf-improvs-v1-0-0e4907ce7322@analog.com>
In-Reply-To: <20251203-iio-dmabuf-improvs-v1-0-0e4907ce7322@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764774697; l=2345;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=y2MrbcO9+GqoAo7PDN3wtQCQRyiKn0pgHKJogZKJwqk=;
 b=BVwzkiL5ixJvvc3yqk1txmDMJPEx1Ni717V20GIFg0XKd8QU6s+U2WOJ2vCYGI5bVw8iowg6F
 b4ShgHI++5HCOOGIXO8MQ1wi7p4R7yIjbYvDc0pgixBSOGuKudWTmNI
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

iio_dma_buffer_init() always return 0. Therefore there's no point in
returning int.

While at it, fix a mismatch between the function declaration and definition
regarding the struct device (dma_dev != dev).

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dma.c | 6 ++----
 include/linux/iio/buffer-dma.h               | 4 ++--
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index 026b42552a0a..0a6891541ed3 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -819,8 +819,8 @@ EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_set_length, "IIO_DMA_BUFFER");
  * should refer to the device that will perform the DMA to ensure that
  * allocations are done from a memory region that can be accessed by the device.
  */
-int iio_dma_buffer_init(struct iio_dma_buffer_queue *queue,
-	struct device *dev, const struct iio_dma_buffer_ops *ops)
+void iio_dma_buffer_init(struct iio_dma_buffer_queue *queue, struct device *dev,
+			 const struct iio_dma_buffer_ops *ops)
 {
 	iio_buffer_init(&queue->buffer);
 	queue->buffer.length = PAGE_SIZE;
@@ -832,8 +832,6 @@ int iio_dma_buffer_init(struct iio_dma_buffer_queue *queue,
 
 	mutex_init(&queue->lock);
 	spin_lock_init(&queue->list_lock);
-
-	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_init, "IIO_DMA_BUFFER");
 
diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
index 5eb66a399002..91f678e5be71 100644
--- a/include/linux/iio/buffer-dma.h
+++ b/include/linux/iio/buffer-dma.h
@@ -157,8 +157,8 @@ int iio_dma_buffer_set_bytes_per_datum(struct iio_buffer *buffer, size_t bpd);
 int iio_dma_buffer_set_length(struct iio_buffer *buffer, unsigned int length);
 int iio_dma_buffer_request_update(struct iio_buffer *buffer);
 
-int iio_dma_buffer_init(struct iio_dma_buffer_queue *queue,
-	struct device *dma_dev, const struct iio_dma_buffer_ops *ops);
+void iio_dma_buffer_init(struct iio_dma_buffer_queue *queue, struct device *dev,
+			 const struct iio_dma_buffer_ops *ops);
 void iio_dma_buffer_exit(struct iio_dma_buffer_queue *queue);
 void iio_dma_buffer_release(struct iio_dma_buffer_queue *queue);
 

-- 
2.52.0



