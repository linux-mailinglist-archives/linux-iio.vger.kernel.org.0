Return-Path: <linux-iio+bounces-26686-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7771C9F722
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 16:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E64F305F49A
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 15:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40501326D43;
	Wed,  3 Dec 2025 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PH8UhPjp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F148D32572D
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764774658; cv=none; b=i0PX8dEQR/Bv73PBtSRBSLsPJQNUfoCfQnZYPfiE6KcLUYZdnkiNseEVga3TckHeC/qfRV/sDrRd6TDbkGbjFSEaoMAOaYHLGQlZLy5xbU66dNGYqwbYTC4k+umMkpA7Wu2Ud3hJbRi4Ujkqoc5VSRw4XggZuCn8JHxxYJc3m7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764774658; c=relaxed/simple;
	bh=FcIjGmnlnFjsVNCozyAp7+0kGypMnjvr2r4gXQnsUoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=paqJQTdFuZWMVbx8XPT9LEaFuOS/DgBQcMtaKBfHfwjQ8OQ/xB+Apd6DT8J/a9QbwUcmXGbTk5zOXQdYYWhBDEX3a6L14rn6qVHPLwBnkTcoE7iKNIuyG5U0Gfs10GM9u739UzjFLsiRp6E6JwcKMsGThVLEDt+6FgzrZUgmSdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PH8UhPjp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A91DFC2BC86;
	Wed,  3 Dec 2025 15:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764774657;
	bh=FcIjGmnlnFjsVNCozyAp7+0kGypMnjvr2r4gXQnsUoE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PH8UhPjpVpk6W223Ywrma/0qVKoDmKELjhi7pXy2OkylC88YrXk/AwnaFv1B1bmwl
	 Q3e5x+7DNfvcpjoE/L+1PAWj/9KUEELrT3HtW+oMrzWXeod7i1qsnDOAUfSYrhNGE6
	 iaYk7yadyaMOJP87YZ6A9/eUtLh7PWWgOkXFXeVjdWMao64ybW5T8/0N7/J2z4k4g/
	 fA8/VBXXkaBg5MIwjna1J0zbNPVohecgQJ/IOIjvTiwkvBnOJW+Z+GFj+c/H+PxVVn
	 2eHcEhsa1UA/Rv2oeKcKC9JCzSrjvO9aUzIsCG9es7NmCGJohS16le20vKCzPrKv8P
	 vmxQIoqnhZy7A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1377D15D80;
	Wed,  3 Dec 2025 15:10:57 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 03 Dec 2025 15:11:40 +0000
Subject: [PATCH 5/6] iio: buffer-dmaengine: Use the cleanup.h API
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251203-iio-dmabuf-improvs-v1-5-0e4907ce7322@analog.com>
References: <20251203-iio-dmabuf-improvs-v1-0-0e4907ce7322@analog.com>
In-Reply-To: <20251203-iio-dmabuf-improvs-v1-0-0e4907ce7322@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764774697; l=1581;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=gczugKBMuRn3hTXaarzlLj4T2DQsus4YqNHHz8e8YNM=;
 b=hsSqmRqOBfbZlirIq0z5cahsjx5QQ73e+HkywFDODEKTNx1m9reLxfe0H91zpbHQeq+NHx26s
 DuSfBzPJ9a5DPDBYy5yWYD3lUdatk0Mp2flJ/pNhaCgkQvxt8FLIULE
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Make use of the cleanup.h API for locks in order to simplify some code
paths.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index e9d9a7d39fe1..a8a4adb5ed3a 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -49,11 +49,9 @@ static void iio_dmaengine_buffer_block_done(void *data,
 		const struct dmaengine_result *result)
 {
 	struct iio_dma_buffer_block *block = data;
-	unsigned long flags;
 
-	spin_lock_irqsave(&block->queue->list_lock, flags);
-	list_del(&block->head);
-	spin_unlock_irqrestore(&block->queue->list_lock, flags);
+	scoped_guard(spinlock_irqsave, &block->queue->list_lock)
+		list_del(&block->head);
 	block->bytes_used -= result->residue;
 	iio_dma_buffer_block_done(block);
 }
@@ -131,9 +129,8 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
 	if (dma_submit_error(cookie))
 		return dma_submit_error(cookie);
 
-	spin_lock_irq(&dmaengine_buffer->queue.list_lock);
-	list_add_tail(&block->head, &dmaengine_buffer->active);
-	spin_unlock_irq(&dmaengine_buffer->queue.list_lock);
+	scoped_guard(spinlock_irq, &dmaengine_buffer->queue.list_lock)
+		list_add_tail(&block->head, &dmaengine_buffer->active);
 
 	dma_async_issue_pending(dmaengine_buffer->chan);
 

-- 
2.52.0



