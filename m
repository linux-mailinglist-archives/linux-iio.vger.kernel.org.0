Return-Path: <linux-iio+bounces-24663-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6609DBB4434
	for <lists+linux-iio@lfdr.de>; Thu, 02 Oct 2025 17:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4671B7A3589
	for <lists+linux-iio@lfdr.de>; Thu,  2 Oct 2025 15:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F46C17A306;
	Thu,  2 Oct 2025 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4adqsR4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF74B15539A
	for <linux-iio@vger.kernel.org>; Thu,  2 Oct 2025 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759417561; cv=none; b=YXDC7N3Q0iLzHFPYa7xcJJzFwrgbpeAMaBIt2PBzm+QHTad9JSxGOSoHalscZy1xzDw2lt1ISgL6360plAQD0HHsDNYmOqo9k1vFXOKqTb5p0jHmQumgQIkNl1Ghen46pbnksqd4iQYpwbCtFTRqxn2VVCLQO43kElJzqiy/r5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759417561; c=relaxed/simple;
	bh=rChQMPXA5lq9q8/pvRfO1WLyn7QIa+D9PQT16nM0sGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EsEjn+SsZQoBOV6LX9IzeEi6XbYuIeqAWLQRTumfFFdWzppkaZopEe2sAmUw+dHLekMjwdJuLuufP6v1pZGQeQO1bECkMDpAlXyLUhHBjCkcP3v+1asVETztbcnL+CKtxm7my1xg0K03vEnL3lYD7qUmZ0Aqn852zR9GXw9cirg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4adqsR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 863D3C4CEFE;
	Thu,  2 Oct 2025 15:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759417560;
	bh=rChQMPXA5lq9q8/pvRfO1WLyn7QIa+D9PQT16nM0sGw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=q4adqsR4MkL/VAFrtcUzxcOpPSnO2hP0wqKb2w3RvMkY96GnbGMd9K/ziEqYYm8XU
	 JDBC/0/2OBBJBmCE56XGH4RXqtXL/TzvEtbWNlBLTwfW1Q5DZiqu3Y5rSuj0w71EBg
	 5k0+mUh1bBtrEN2AYCa0w22vz3w7fyOKZu5oKTK6w0GPV+NBq39hOOS6IDOOqeOfVb
	 5zWq+gwwMDpRVKbQEvzByahr3iTvbdu2ZKqAr3Q43FHgkPGt3mj3pPdZdMGrN4vYzL
	 5dPiQig3CkzE+DafsvH4zegUg1WkGw0e9md61ogunlJgvSty7rREtQ6JeplfEsiN6u
	 rI01ohr2tDByw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1FDCCD183;
	Thu,  2 Oct 2025 15:06:00 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 02 Oct 2025 16:06:30 +0100
Subject: [PATCH 3/3] iio: buffer-dmaengine: enable .get_dma_dev()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251002-fix-iio-dmabuf-get-dma-device-v1-3-c1c9945029d0@analog.com>
References: <20251002-fix-iio-dmabuf-get-dma-device-v1-0-c1c9945029d0@analog.com>
In-Reply-To: <20251002-fix-iio-dmabuf-get-dma-device-v1-0-c1c9945029d0@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759417589; l=1345;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=yJC4GNQK3Hwol76Ccm2x0viKzmxMmSpwBpEjDDwJ0A8=;
 b=okklS07vDafBxpDvWPNm8fR0XCQshCnyywCnmkl5Y2URNUejiOLLeKWG/GEE+qf5FbA75H/ky
 J0K+m9osg9TDPGfLHFECWqpoq0sxKO3QTx71kJnjzSm1BfgpvBmkvGI
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



