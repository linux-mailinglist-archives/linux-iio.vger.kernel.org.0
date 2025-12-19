Return-Path: <linux-iio+bounces-27216-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C3BCD08D0
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 16:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1B5030EB4E7
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 15:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D903009E1;
	Fri, 19 Dec 2025 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFWImwfQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E70344038
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 15:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766158054; cv=none; b=X610Uy17Rzby0ESm5LheT0DVMQu8zAMx7gfSfImnXJb6K+XA6RHhZknRjoHKzDBo9v6BE0Qn9kF+F71CeZrujzFRQIOCwP47dZx9pMrbVNi006+zLHxSv+aFtN3ViEy0j0x545CeXS+DH59WWrjsWdVTcFk2zrG+YdThMUgttdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766158054; c=relaxed/simple;
	bh=FcIjGmnlnFjsVNCozyAp7+0kGypMnjvr2r4gXQnsUoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nCetzSda+uS0ymGILEfnj4NUmtNkt0BvxngiFq/JlE8GmpG1i4boE6OE1FO85Vae3xOIxGV1+7ChPT4UNHYilE7owckQaU2jX3bEcYwGsViEP4xrJKB38XDXxua20XU569DFOI+3429CughGnkrJoBHTJbZ8k4SDHZx6OlLPsgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFWImwfQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C138C19424;
	Fri, 19 Dec 2025 15:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766158052;
	bh=FcIjGmnlnFjsVNCozyAp7+0kGypMnjvr2r4gXQnsUoE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oFWImwfQP+vrp9gkijTBeXqJS1GLIVFe6m+b+OIyXNfVDfepjAF0pcoNeO/zW9ulE
	 0DxKyULRAOftx3TGk+DoZtFQRXpQAByYdzpMsjDZKCIjID4gA4qb2yUzqlUaPJGpQX
	 g0XamIsjCrWg0bP2keLO8FvvOy8sQ2A5HL2+9GsnOq5POdMtdKx2QKmp8rWOacsd4H
	 BLjb/D495RZbIx4+t7F2PCCAPrLvQEHoLF7rFo2FJFWLXCVxzl1dkN7bBUYsbpeatT
	 ENcEgnzV4NC33GfXxRSVBQvH94sKbonCyPN1NTRdLTqZUzYiy85Ezo7tcScyK38mrl
	 DyvJnRpjotgFA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461B3D78770;
	Fri, 19 Dec 2025 15:27:32 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 19 Dec 2025 15:28:16 +0000
Subject: [PATCH v2 5/6] iio: buffer-dmaengine: Use the cleanup.h API
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251219-iio-dmabuf-improvs-v2-5-caa76de6e873@analog.com>
References: <20251219-iio-dmabuf-improvs-v2-0-caa76de6e873@analog.com>
In-Reply-To: <20251219-iio-dmabuf-improvs-v2-0-caa76de6e873@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766158092; l=1581;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=gczugKBMuRn3hTXaarzlLj4T2DQsus4YqNHHz8e8YNM=;
 b=NWjThoNq9zD9OXpQWVSE92t3Nxcv0sTl3BZougvG0cv8p5Mn4kevOCUd/vTwv4Au1Ziq7YXR1
 X2ALUq4KCueAsVah4ibyuOPgmbNkGsVGc1WXjNAI29BcqtvSbR27eiX
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



