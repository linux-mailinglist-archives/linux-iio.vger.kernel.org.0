Return-Path: <linux-iio+bounces-26683-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD9DC9F71C
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 16:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EED6C300B2A7
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 15:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1D4326926;
	Wed,  3 Dec 2025 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9WoJA2G"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57AD32571C
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764774657; cv=none; b=qNeDL7yEqTJ0b1ie/QtOnZiDjvOUhkKKxdxY0HbhUccDcStke8mKHmsDqA5T6KBS7C1RdQvc5KmeJ4aPHd/XayS7M2bsNhj/6AvhUakKEYaPa5qfxTiwJ7fQv8rX86Q8d7IbVoS2PQy8Yu2bKmuJANluECwA9+7jis+l9ZBh1/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764774657; c=relaxed/simple;
	bh=YdCCeSF1SQIBqUetVexQTJcy6L84v6sNqM9xPlse8XE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HLZk/yjCIgh4Vb7iSap7bof9C5HoiROnegDO+FkO5ZC4AvzdUYxFEQPKZE8GB5kSUmEF2wm5EVAZbN9u65tdfeYlul+tZ3gd4tWW8X78khJnuAfDG4TzL5aUqcyM7BZUFgn6fmltmrBSEf8m3d98g5C0ttQ9TQ4EvjDCUZRd76k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9WoJA2G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62BA6C116B1;
	Wed,  3 Dec 2025 15:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764774657;
	bh=YdCCeSF1SQIBqUetVexQTJcy6L84v6sNqM9xPlse8XE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=l9WoJA2Gm49jYTMoBMFtHXaKcRBLR7ThPBZeYhKBW6zjF49H9GUCDZwFXnzud8M+1
	 VnD7fq8fvxcEfJNtI8lylhOVIJPgaKk+1Xphd4fbJz0cXJRzX5UtI0V//F2tDflJom
	 D06IMUIqXrrDoBIkBh9UCzt46po2jl5R8YnNv1s8z4m+mWS7b38N9O4rWAd1PndUmx
	 stJ5xwPabJ/YTCtzhGl6wgKS1oPszdnL2cRYyJaQtdJyWTbknstGTsAVtICsxvtksN
	 AIST9LWig7Uv4u8WCGL1BonYoGXeXPAMCSqry7+sbkOAnpasphpMSmYLIz1RGvhOjw
	 m7Eurk9Mj432w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E944CFD376;
	Wed,  3 Dec 2025 15:10:57 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH 0/6] iio: buffer-dma: Minor cleanups and improvements
Date: Wed, 03 Dec 2025 15:11:35 +0000
Message-Id: <20251203-iio-dmabuf-improvs-v1-0-0e4907ce7322@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACdTMGkC/x3MQQ5AMBBA0avIrE3SVgmuIhalg1lQmYZIGnfXW
 L7F/wkiCVOEvkggdHPkcGTosoB5c8dKyD4bjDK11soic0C/u+lakPdTwh1RVb6zxrR2ahvI4Sm
 08PNPh/F9PyfoX3hkAAAA
X-Change-ID: 20251104-iio-dmabuf-improvs-03d942284b86
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764774697; l=1154;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=YdCCeSF1SQIBqUetVexQTJcy6L84v6sNqM9xPlse8XE=;
 b=GdFk7UYClyxXmOdoZgiDH12p8FGN4MfMRO680emZKNnDVrgZo32xVT1GxdTIzL8bNTkJWq9Cj
 yncNf30XJHaDtGjO7y1peCnfz6wnESgnCz3/3XuLzBe5IK/lVFcqlWW
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

Small series with some minor improvements for IIO DMA buffers:
 * Use lockdep instead of WARN() + mutex API;
 * Use cleanup.h;
 * Turn iio_dma_buffer_init() void;
 * And I could not resist in cleaning up coding style.

Also note that in some of the coding style cleanups I deliberately went
above the 80 col limit as I think it otherwise hurts readability. If not
the case for everyone, I can change it.

---
Nuno Sá (6):
      iio: buffer-dma: use lockdep instead of WARN()
      iio: buffer-dma: Use the cleanup.h API
      iio: buffer-dma: Turn iio_dma_buffer_init() void
      iio: buffer-dma: Fix coding style complains
      iio: buffer-dmaengine: Use the cleanup.h API
      iio: buffer-dmaengine: Fix coding style complains

 drivers/iio/buffer/industrialio-buffer-dma.c       | 186 +++++++++------------
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  22 +--
 include/linux/iio/buffer-dma.h                     |  20 ++-
 3 files changed, 96 insertions(+), 132 deletions(-)
---
base-commit: c5411c8b9ed1caf53604bb1a5be3f487988efc98
change-id: 20251104-iio-dmabuf-improvs-03d942284b86
--

Thanks!
- Nuno Sá



