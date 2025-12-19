Return-Path: <linux-iio+bounces-27217-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA50CD08D5
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 16:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C827C30EB66E
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 15:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9362334404B;
	Fri, 19 Dec 2025 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2AQdUFk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E4332AABE
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 15:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766158054; cv=none; b=K0QQ3gyxRW7ZeSpPn3bClth/4aspqilGIwTKLrmkRWEl0jZIzHJRhNx+rguirVa900TXjoA7Xu0H3PwgzFdQ7sOMoL6mexdWWBlP/Ds7FlvqJQyvdlczNqGRVKynDYO0wRcagjqRGWu7orsOQTNdTQXT87tvgUetLzHte91IKW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766158054; c=relaxed/simple;
	bh=ncKUr9exv3HeABr5Al7R9a8mhk/3VhFwxl8lc4uYF84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IXxSdCFTmC5pafCDVFWQSItDuMqnxAjTyfPqRkvp0sWj+dyUNzTUqrv33YS/SEKN4hs0Ja7UTjeb5lIie6q7082U/PTo2RJRYOFxqQ2ooBtDCZhQDHNJffEJ5tN0SH/I/3JUL+1sWCIqgVuyvENrkEH++xQpjbiVW2ejSOKRFOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2AQdUFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59B7BC19422;
	Fri, 19 Dec 2025 15:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766158052;
	bh=ncKUr9exv3HeABr5Al7R9a8mhk/3VhFwxl8lc4uYF84=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=j2AQdUFkH8lzuFicwboVRJkQPxcp+r8n0QcEK7PngIxAOSVBMtIe0aPYdlQWhw4u7
	 hIq5lC5ndTGALDjCdp+CNZfQskmpH4Im4YVBQCcZqxn7r+eJJdHKsUhPymLWvvquAL
	 aB60K2gXdCUWBc3tR1PhKSNhymCsKUfm/ZVIxqa7Dq8j/v5txAGEnp+euRiTmYRO5D
	 jseAYTijz3sVjLTI5GO2/aisGVEBny0S10duzfY1eDftr/Nj7MSl0zEp6VvCE2O07E
	 5X5MhvVDQ8pNpNoLtEzlApIs85UQ/nJKOiyMZmAXWiVRlhR1ey7DNHStCHqhd4kZrd
	 XG7fosh1p2QBA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53628D7878F;
	Fri, 19 Dec 2025 15:27:32 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 19 Dec 2025 15:28:17 +0000
Subject: [PATCH v2 6/6] iio: buffer-dmaengine: Fix coding style complains
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251219-iio-dmabuf-improvs-v2-6-caa76de6e873@analog.com>
References: <20251219-iio-dmabuf-improvs-v2-0-caa76de6e873@analog.com>
In-Reply-To: <20251219-iio-dmabuf-improvs-v2-0-caa76de6e873@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766158092; l=2281;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=69+dyLooRn338nP8fU7ume5QNFgzBMAZG9jZvwNJ6yg=;
 b=w+lDj8gABly4J9qcLD2r4dhfj1KuexHs1ZZfaSSVgMiM4wz7rvFlSH6jdsAYwxzHyyezxeZYT
 sCczvIrgbHZBNGHUxORf6YcvOt4GgRm/TdJKivzsbFmY26u/YbpKXLQ
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Just making sure checkpatch is happy. No functional change intended.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index a8a4adb5ed3a..b906ceaff9e1 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -39,14 +39,13 @@ struct dmaengine_buffer {
 	size_t max_size;
 };
 
-static struct dmaengine_buffer *iio_buffer_to_dmaengine_buffer(
-		struct iio_buffer *buffer)
+static struct dmaengine_buffer *iio_buffer_to_dmaengine_buffer(struct iio_buffer *buffer)
 {
 	return container_of(buffer, struct dmaengine_buffer, queue.buffer);
 }
 
 static void iio_dmaengine_buffer_block_done(void *data,
-		const struct dmaengine_result *result)
+					    const struct dmaengine_result *result)
 {
 	struct iio_dma_buffer_block *block = data;
 
@@ -57,7 +56,7 @@ static void iio_dmaengine_buffer_block_done(void *data,
 }
 
 static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
-	struct iio_dma_buffer_block *block)
+					     struct iio_dma_buffer_block *block)
 {
 	struct dmaengine_buffer *dmaengine_buffer =
 		iio_buffer_to_dmaengine_buffer(&queue->buffer);
@@ -184,7 +183,7 @@ static const struct iio_dma_buffer_ops iio_dmaengine_default_ops = {
 };
 
 static ssize_t iio_dmaengine_buffer_get_length_align(struct device *dev,
-	struct device_attribute *attr, char *buf)
+						     struct device_attribute *attr, char *buf)
 {
 	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
 	struct dmaengine_buffer *dmaengine_buffer =
@@ -243,7 +242,7 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct dma_chan *chan)
 	dmaengine_buffer->max_size = dma_get_max_seg_size(chan->device->dev);
 
 	iio_dma_buffer_init(&dmaengine_buffer->queue, chan->device->dev,
-		&iio_dmaengine_default_ops);
+			    &iio_dmaengine_default_ops);
 
 	dmaengine_buffer->queue.buffer.attrs = iio_dmaengine_buffer_attrs;
 	dmaengine_buffer->queue.buffer.access = &iio_dmaengine_buffer_ops;

-- 
2.52.0



