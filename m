Return-Path: <linux-iio+bounces-26682-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA90C9F719
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 16:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B8DF305CF2A
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 15:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139CB326921;
	Wed,  3 Dec 2025 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDRSafH/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C565A325484
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764774657; cv=none; b=NFT1LVLf/9jkVYp8HcGnu+EOdViaA8gvqIDvjHgYQ28CvBaEwnlwyekvbV7otJdM2KbXKzWVh3ifdhUJfWPHw/LGYB1n+scTOnVpZ1iG8/jy+TRm8qPq7Wm2mPCMnTZVcsQXtXqYYWnxim9wmlvFOKxP7gF5ljux2DBc71fb89E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764774657; c=relaxed/simple;
	bh=OaFYzVcxHNpU/0dnE+kOcBVE2F31fveVbCbpvikixzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZOjvZmmSpT8RdkYpZRelEHa4aNBCEaVOJ5sJ2AxzPBHq/4LwJtBi266gmvK6u2tIt23TeuBIlUAWseeqVe/dEjNaKODpdIqGyk4ijci+hyNUaHocHkgGVp+ZxossWW1Z/PuVYxGaZvUMPlxsC9kPOoXhfW5vNs2dVmWM8wHMFzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDRSafH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72F9CC116C6;
	Wed,  3 Dec 2025 15:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764774657;
	bh=OaFYzVcxHNpU/0dnE+kOcBVE2F31fveVbCbpvikixzQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NDRSafH/ThEEQ+BsZmq+2oCXdQNS9HyFi/Iqb11ByYz8frC/7s1uzViRMG//Sh9kN
	 eKOGhondggRPwSH8a1+alqj5d4hJOGuR/1XzXZWe13vB8FAaA3aSCCL0BGigWht2XR
	 FPmRj4VF1Yf0Z2G5mPonDiaJ2RcjsHW6h7Cx2BdFvLwYy3c+cvESRz/J5jd+31hvgK
	 /tlaQwmSU2YCsKT05Tf0js7nRX5BhpPTw5qYS10JsbfFfIINphbvfnLh96MF9gYSSV
	 AO3gVr+EIrGTVvwHgIwZp5xwRxfp5tQghLfGi+DXr0YBpPXP72Ups1lkLW3QFbvdae
	 sXmBNGWYsNCfQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611E0D12D79;
	Wed,  3 Dec 2025 15:10:57 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 03 Dec 2025 15:11:36 +0000
Subject: [PATCH 1/6] iio: buffer-dma: use lockdep instead of WARN()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251203-iio-dmabuf-improvs-v1-1-0e4907ce7322@analog.com>
References: <20251203-iio-dmabuf-improvs-v1-0-0e4907ce7322@analog.com>
In-Reply-To: <20251203-iio-dmabuf-improvs-v1-0-0e4907ce7322@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764774697; l=1113;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=q3xzONCOKbjzU83uO5v2RZKwpfbxm04ZQK8NV2XP1fs=;
 b=hXwu7OyGp+n8oGduTudhJGR7uB4NweKGe7u7oJrOLIXyEXRCaLyTHfyPzKj1W4JFbbJdRH1xd
 7F555Q5kEoKB6ElEfBq4AtEmnB/UZpTds4oww6/YVDTJGGkxWqqYDJ8
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

As documented, WARN() should be used with care given that it can panic
running kernels (depending on command line options). So, instead of
using it to make sure a lock is held, use the annotations we already
have in the kernel for the very same reason.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index ee294a775e8a..617b2d550c2f 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -6,6 +6,7 @@
 
 #include <linux/atomic.h>
 #include <linux/cleanup.h>
+#include <linux/lockdep.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -764,7 +765,7 @@ int iio_dma_buffer_enqueue_dmabuf(struct iio_buffer *buffer,
 	bool cookie;
 	int ret;
 
-	WARN_ON(!mutex_is_locked(&queue->lock));
+	lockdep_assert_held(&queue->lock);
 
 	cookie = dma_fence_begin_signalling();
 

-- 
2.52.0



