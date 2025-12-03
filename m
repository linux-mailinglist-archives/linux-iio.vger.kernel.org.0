Return-Path: <linux-iio+bounces-26688-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29286C9F728
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 16:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B7DB3060D49
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 15:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D77325720;
	Wed,  3 Dec 2025 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPTgTS5x"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34561326954
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764774658; cv=none; b=il4peWhhuRHVIYDwn4oYEvr+q5UQld0EIY3/l150A1gGQDVBuBOQIz5UPYGhFAHm8dAbtWTnL+VIcBa9l9iSMeETdbfBVfxJjeh37LVoi6Shv0zAQ+/cV03kIpw9A5H2nWsOhrDWgnAb5qStbI+q/ZI0ycmszFlF4257Wo/9t90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764774658; c=relaxed/simple;
	bh=ncKUr9exv3HeABr5Al7R9a8mhk/3VhFwxl8lc4uYF84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZzKj5PYvvhP9MCeTwA3tkWkpLqu4ayg/M3/BR9IDmAgq0BopzHC+Dzw+IUAeKsQ4ByAJkKyG8p4BGPhie/2h1Vozme2to2e6mjYmKkQWJ973FeEdJF62cA9dvrsSfiGQRReRQRGFwyaeCvNlq5v1s8N8F8HhPo0G/yGiNr0l9Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPTgTS5x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B62D8C19424;
	Wed,  3 Dec 2025 15:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764774657;
	bh=ncKUr9exv3HeABr5Al7R9a8mhk/3VhFwxl8lc4uYF84=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NPTgTS5x0lESgR7t0IwgCdCVG8PEPtkz5JDFfvqqqVvy00u6klLwKzxcE371TO73k
	 CSAmgN30qbYzRfvtD5lbgyS58U9JkkS0Xx5zAdmvQtTxDO3ouWVSJfp2j7qxi5rhfx
	 3J31jd1ohIsQc6c3EwFJtZA7bzgQEGlfFv1cJ2VoBRmZIBf+N1MkFWKkinc3salmeK
	 iRvalg3HfVO52TX0jT4k4iVEd/2ikBN7PD1sTmf7vlwhScHcsseIuo4O9zJO2bLvsr
	 WL/3u10HdYRt/5awDNsBk18oqdZd17KggD4fIDyCWoOGqHIR9/fPWsPVn3jk3hCg6s
	 HjzgTGvI7gmfg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF833D12D79;
	Wed,  3 Dec 2025 15:10:57 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 03 Dec 2025 15:11:41 +0000
Subject: [PATCH 6/6] iio: buffer-dmaengine: Fix coding style complains
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251203-iio-dmabuf-improvs-v1-6-0e4907ce7322@analog.com>
References: <20251203-iio-dmabuf-improvs-v1-0-0e4907ce7322@analog.com>
In-Reply-To: <20251203-iio-dmabuf-improvs-v1-0-0e4907ce7322@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764774697; l=2281;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=69+dyLooRn338nP8fU7ume5QNFgzBMAZG9jZvwNJ6yg=;
 b=crtyyF90MwMdaQqi0OClvYRurthYmZQqItNBMwvtn7EuG3wG7qTnrzo+BOFOgz8DtLM6AE1Ap
 0TPUGDQbZkmBTDs+0tzTZ6gFdNWA3I2dbMAmlLmJNbTJ4sv5A5HIn/k
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



