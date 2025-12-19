Return-Path: <linux-iio+bounces-27215-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C80E5CD0890
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 16:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86C72303E494
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 15:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88A23431EC;
	Fri, 19 Dec 2025 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QM87Hb1X"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4207334321B
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 15:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766158053; cv=none; b=Bn79huNpc8CuzlL+oG39S6L4y3oJuJf1C7526qsVAH9h4Xc4fVhsfojLLAVtW/UhKWtLZZdCRo66HJYd9KzvCtufq0DZKrods0pn+V/gMwUICUmLhrNK5v8wmcliELQWyJ8IP2fEj1lFgf4NkEjVa72kJ9FssyX8UjrcOnkYA+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766158053; c=relaxed/simple;
	bh=dJLLUauhnmWqGKOYfczrhvrLNSiS8OpN5WleuiZjxGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o/PV1XyqFEP873g8DTwh5eCAzrX0sAAhfn0mXVOU3iD3VjXVFpzJ0k7lqisi1b3Cw6D4a6rLrQmyIIKJSDHnuvjQ3VA4G54zVst5Io7IDntNRYu79YEdKsUOGMFD1DRJosEKoQQs6XqSY80RL8iNVm2JKuRPsx2yqJAf32aZxkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QM87Hb1X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05159C116C6;
	Fri, 19 Dec 2025 15:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766158052;
	bh=dJLLUauhnmWqGKOYfczrhvrLNSiS8OpN5WleuiZjxGQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QM87Hb1X5gXX/n7enq3iipdHDcLoJJ4Bj9qJcw4Du6m8qvs06iVuqX8A/1bcuOFnF
	 6YNYoTO5lPT7cOvGYj6BCPTpmDbyRR8Z0WontsbU4nYadNvMbqV/7urbrGLhmpuc07
	 R0xWFZ8UPrl4cqPE32b7LoBDqokP3Q8B6XgMvuigq70BePqq9SmL+wdv0VCHFNAcor
	 sUWtSzWhZkkWLetc44Jrss3ajXw9CELaGMJ24HdKzcMeQHONMKVKwDN8SLl3eAVysm
	 WVH6CXuaFvEuQWtPjIY3CRLBKmWKa2NcCUN9oGeDMVOFeksZRPRx75K1rYt+63H7V2
	 67T9MAs+0NkDw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB9FD78789;
	Fri, 19 Dec 2025 15:27:31 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 19 Dec 2025 15:28:12 +0000
Subject: [PATCH v2 1/6] iio: buffer-dma: Use lockdep for locking
 annotations
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251219-iio-dmabuf-improvs-v2-1-caa76de6e873@analog.com>
References: <20251219-iio-dmabuf-improvs-v2-0-caa76de6e873@analog.com>
In-Reply-To: <20251219-iio-dmabuf-improvs-v2-0-caa76de6e873@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766158092; l=1011;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=vAf7WOSJFQhX0O/kDa00FjN6tPjAcLO8ZihWozrJFJ0=;
 b=LjS9zIiGvfYHLsfj61UIgz3Lz7/btI6EQFYT65zTpp2bMvMhBLc95x5NjqfJb2/xfBz+1+Lfx
 4hk/92MgE7hDawt0r9VSe5K+YLlmaQWtZ1XYCKr3Iso3PmonEoqd0/H
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Don't use mutex_is_locked() + WARN_ON() for checking if a specif lock is
taken. Instead use the existing annotations which means
lockdep_assert_held().

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



