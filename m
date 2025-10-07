Return-Path: <linux-iio+bounces-24812-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C761FBC0D51
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 11:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3514A34D7ED
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 09:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC802D73A5;
	Tue,  7 Oct 2025 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueDGHN+C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67DF1FAC4B
	for <linux-iio@vger.kernel.org>; Tue,  7 Oct 2025 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759828491; cv=none; b=ZAzSnL/rWFYFwAnHSNBC/xYR5taU6I2g0LuPmvHeHUv0UlDFEqgMD48/wPTdW8DWckh1MTJMQPBsVQuC/Wt/DYHGWkID+inT3aiY19gcuK0cYcvRw28mZ2N9CgjOP8mxwq4KuDkf+r5cBOuK4awK1mU493DvH/qV9NFtSLzVDqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759828491; c=relaxed/simple;
	bh=LM4jiKcZlyHmAhc2ba468Jr6YTDFPfE+MhyW0KmVQr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HcRhWfR2iNwcwemeaxMWON/EhbHeGe5b4wgos9LrdZtpmHUDX++PXuxfRO6xn7tAnJ6DQngztW4Vv10hM6AIZAQmeh6xGKD50OBdYWwOUt9JSlsCBqN0Nb/JO4U6+5Hk0aOyHtjs8h+JyFIdiAxqvprXN8p3OGAIWBtEDXMYwGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ueDGHN+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86BC7C113D0;
	Tue,  7 Oct 2025 09:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759828491;
	bh=LM4jiKcZlyHmAhc2ba468Jr6YTDFPfE+MhyW0KmVQr8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ueDGHN+CMJsfug/47wvkmRUSYajXvmd0ab6paLQ889EdEx/AiiptpxobtvY14yfg7
	 NY1NUNAQ9U1V6OOC1rQDVzsWRZDNZA82EDd1uenLleFzOoy3L62+MiEARxXbkb5oOo
	 O+04mX4ojy1cVQiijRZE1mIIKlu/jm8I5+VRXeCluZ+3nFP4NIh7LJq5w7/wl/vblM
	 Z6PVayOyBxzyIEVSbA/U67SXe2EH2O9+xbAfxTlfrW+XYVN1pKOwbNFH8egLgwr/kw
	 pOeqVKhHdz3c4QHoIgm8YjZD0BJeAwqA1sTpleDySSZrBjfFLP1iBmnyNLb5B+beuM
	 jVrigMWm3pHAQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B19DCCA476;
	Tue,  7 Oct 2025 09:14:51 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 07 Oct 2025 10:15:23 +0100
Subject: [PATCH v3 3/3] iio: buffer-dmaengine: enable .get_dma_dev()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251007-fix-iio-dmabuf-get-dma-device-v3-3-0c73e2c0653b@analog.com>
References: <20251007-fix-iio-dmabuf-get-dma-device-v3-0-0c73e2c0653b@analog.com>
In-Reply-To: <20251007-fix-iio-dmabuf-get-dma-device-v3-0-0c73e2c0653b@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759828521; l=1397;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=SH+6aeEgKQBCjds6ZFDBBEeFJ1iJGjBDhHrdT0JOhHI=;
 b=tJE4oFtLFpUyMH84A6JLjdPPiI1wWisReD3XmtJTQKnpJhKfQLDGLqMNZd9hIjCV929Gw+YuT
 rz0aSPq0pqMBYC8ipHVUWJzBO2mPjg4t326W//bEpT4m4gGH377TR72
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
Reviewed-by: David Lechner <dlechner@baylibre.com>
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



