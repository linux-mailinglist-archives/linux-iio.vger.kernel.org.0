Return-Path: <linux-iio+bounces-24781-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B356FBBE95E
	for <lists+linux-iio@lfdr.de>; Mon, 06 Oct 2025 18:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91EA318852C7
	for <lists+linux-iio@lfdr.de>; Mon,  6 Oct 2025 16:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EA72D9ED8;
	Mon,  6 Oct 2025 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKeZ7ABF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8432A2D9EC9
	for <linux-iio@vger.kernel.org>; Mon,  6 Oct 2025 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759766766; cv=none; b=m0GXDLijoKCuMoNW3Lm2TUTPyLhfW6Yuk/oCulWMyFvb2Z8S6xSQ3RRb2hxyIrIStavll8W3oEKAZLCZs6RiZL4F0uRDy2FW+t/oh1nO1WREM2Z62U0FWPOtyggDTfy86gNopKsGXjbjBp/durVA5QKwGXZHFZoujA5q4pHfNY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759766766; c=relaxed/simple;
	bh=rChQMPXA5lq9q8/pvRfO1WLyn7QIa+D9PQT16nM0sGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HLks5VATgYzuivSCBttyJro8Tok384fKlhT4Gs8umac3aTyBjQBaatKiY0aQ2dqk+SrR1oIbARXejW48jkD78mpzXCMfp6cF6fTY2xQVkc7wxDGjXuNQZqj18WjQmlzO0fOgTpT6Cg6+iOfoLFkAlwDV52FexWQspVmz6DBDaH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKeZ7ABF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D721DC116B1;
	Mon,  6 Oct 2025 16:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759766763;
	bh=rChQMPXA5lq9q8/pvRfO1WLyn7QIa+D9PQT16nM0sGw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bKeZ7ABFoWpWcI63FwNld8hFbvMenPcrIKs1WfYF6ZvSEtk3fPUV767o/dZw5mLUD
	 2ZnFaJ1bVk3QIfijQn1CfaVqQxVd9daXH4cpL/Pg9tMqYb/liIV2N9S7LuTwOjeCHx
	 XYBSQjigxXLAymWf42aZytmjpj512w4R0Cd+GF/yNjmAKOcSPmJVc3jWD049by/iYc
	 6YzLqCdFirMr0nbcQwOIbPpEDC+09WU3C5Xzcup24bLn4FUGa6uc3hIh0qyZJIpV/2
	 5VeNKDSu9gyl0sEcdS5uPpCNNz4ieSvjf3hpdllo6h+BiSa4XEi+K3/m8Y8tQG+3oV
	 kNrHvA6Qyunqg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDDFCCA471;
	Mon,  6 Oct 2025 16:06:03 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 06 Oct 2025 17:06:34 +0100
Subject: [PATCH v2 3/3] iio: buffer-dmaengine: enable .get_dma_dev()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251006-fix-iio-dmabuf-get-dma-device-v2-3-d960bc9084da@analog.com>
References: <20251006-fix-iio-dmabuf-get-dma-device-v2-0-d960bc9084da@analog.com>
In-Reply-To: <20251006-fix-iio-dmabuf-get-dma-device-v2-0-d960bc9084da@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759766793; l=1345;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=yJC4GNQK3Hwol76Ccm2x0viKzmxMmSpwBpEjDDwJ0A8=;
 b=yt/LyhA6kGmbjtgpCQ2rhCXJvcZ3ABbeB5yRdYmrgtH4I/iG06LJEMNR6N6eGLR7AAXqUzEb2
 LEaJz8qGiCACY8xer93OID2mokVC38r0fzRmLYr6YwGASbF++Hic9bs
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Wire up the .get_dma_dev() callback to use the DMA buffer infrastructure's
implementation. This ensures that DMABUF operations use the correct DMA
device for mapping, which is essential for proper operation on systems
where memory is mapped above the 32-bit range.

Without this callback, the core would fall back to using the IIO device's
parent, which may not have the appropriate DMA mask configuration for
high memory access.

Fixes: 7a86d469983a ("iio: buffer-dmaengine: Support new DMABUF based userspace API")
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index e9d9a7d39fe191c2b6e8c196a08cdd26cd3a8d4b..27dd56334345135742d077fab157e2f091d07488 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -177,6 +177,8 @@ static const struct iio_buffer_access_funcs iio_dmaengine_buffer_ops = {
 	.lock_queue = iio_dma_buffer_lock_queue,
 	.unlock_queue = iio_dma_buffer_unlock_queue,
 
+	.get_dma_dev = iio_dma_buffer_get_dma_dev,
+
 	.modes = INDIO_BUFFER_HARDWARE,
 	.flags = INDIO_BUFFER_FLAG_FIXED_WATERMARK,
 };

-- 
2.51.0



