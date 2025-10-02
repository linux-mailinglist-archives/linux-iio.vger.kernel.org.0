Return-Path: <linux-iio+bounces-24660-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB9DBB442E
	for <lists+linux-iio@lfdr.de>; Thu, 02 Oct 2025 17:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6981E1C1FD7
	for <lists+linux-iio@lfdr.de>; Thu,  2 Oct 2025 15:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CA817332C;
	Thu,  2 Oct 2025 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hc69h56c"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F991B808
	for <linux-iio@vger.kernel.org>; Thu,  2 Oct 2025 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759417560; cv=none; b=tVgZ+e0JEomfNBzCAiuwOvFnufpdWAPHUS4i9nrwzY2JI03X/E85PVQtjrJAWXMqz4blqM2kondKYJpQyshC2/RpFsz4thG/xg8pgD1A7jP80NTW5Gl7y5zyzILZ6euNCInH7ajS46jazzBjMDg+K9iyw9/eYEoBQFMgpZgzWIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759417560; c=relaxed/simple;
	bh=c4hJSA3YwlBRou/PF7hgqaEAdC4ZDRCylMUuk6DTVJ4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BQl48F56goQzoSVSHu9tszEDPbg7XNTJZx3uXY8/ZdBAQPQkxUR7hrsPuq8WrVkSMtRhIaapA53ejtdGKrMIix8AzqUeOxC1+GhNasE4GekfeTxS8O/4IflJU74IyIVxC53idX6tATuEsVMcoQwKXu9KsQjlETsfakpuS5C7+Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hc69h56c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52237C4CEF4;
	Thu,  2 Oct 2025 15:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759417560;
	bh=c4hJSA3YwlBRou/PF7hgqaEAdC4ZDRCylMUuk6DTVJ4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Hc69h56cFJBlxx0vhN5xI6UcOKGN9z7TFln56wIV+f1/q1eabpcr54qmgMAj3w8Z3
	 ib0D1bH36+Er591wKJtsfonF9X0znKSnWIUNZRDfD4YApMJAR4idNiAxHspmR2oCTP
	 +OKoZXHUgpEKTiernYihRt688VkGWmpM528KXrbuUXN5MgY1Aem5OKAqR04zRYLHOC
	 mmXqU9ZkqoIL2Qor7Yq1BxuKexLcUDeQJ7pTblfafFTEwOeGrtonI6ckiKt8zIYth/
	 SjtYklxoGKJDDmmxCXlZVgRGYX2xXmGDZPknuLpYQ8C+8M5zxFu5A+/8X/IvemI5wY
	 rnoL+Ob4ybO5Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A72ACCA471;
	Thu,  2 Oct 2025 15:06:00 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH 0/3] iio: buffer: Fix DMABUF mapping in some systems
Date: Thu, 02 Oct 2025 16:06:27 +0100
Message-Id: <20251002-fix-iio-dmabuf-get-dma-device-v1-0-c1c9945029d0@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPSU3mgC/x2Myw5AMBAAf0X2bJNSjfAr4lDtlj14pEUk4t8tt
 5nDzA2JIlOCNrsh0smJ10WkyDNwk11GQvbiUKrSqEYrDHwh84p+tsMRcKT9Q/TSOkKtG+tqZSr
 tB5DHFkmC/9/1z/MCLvqmO28AAAA=
X-Change-ID: 20250930-fix-iio-dmabuf-get-dma-device-339ac70543db
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759417589; l=2313;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=c4hJSA3YwlBRou/PF7hgqaEAdC4ZDRCylMUuk6DTVJ4=;
 b=Dn+i1lCkYx11dlqRH3vRS3LEFNioXXKGsvX7R61/HdGhgtz1YnqRW6cUM+J0XxhMUp0Acqs1l
 qlJJm4l4wQTDe3bdhYyeNUy/xGn03MXJvRuZrRxi+di7ZyYRr8ReJM1
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

This series fixes an issue with DMABUF support in the IIO subsystem where
the wrong DMA device could be used for buffer mapping operations. This
becomes critical on systems like Xilinx/AMD ZynqMP Ultrascale where memory
can be mapped above the 32-bit address range.

Problem:
--------
The current IIO DMABUF implementation assumes it can use the parent device
of the IIO device for DMA operations. However, this device may not have
the appropriate DMA mask configuration for accessing high memory addresses.
On systems where memory is mapped above 32-bits, this leads to the use of
bounce buffers through swiotlb, significantly impacting performance.

Solution:
---------
This series introduces a new .get_dma_dev() callback in the buffer access
functions that allows buffer implementations to specify the correct DMA
device that should be used for DMABUF operations. The DMA buffer
infrastructure implements this callback to return the device that actually
owns the DMA channel, ensuring proper memory mapping without bounce buffers.

Changes:
--------
1. Add .get_dma_dev() callback to iio_buffer_access_funcs and update core
   DMABUF code to use it when available
2. Implement the callback in the DMA buffer infrastructure
3. Wire up the callback in the dmaengine buffer implementation

This ensures that DMABUF operations use the device with the correct DMA
configuration, eliminating unnecessary bounce buffer usage and improving
performance on high-memory systems.

(AI generated cover. I would not be this formal but I guess is not
that bad :))

---
Nuno Sá (3):
      iio: buffer: support getting dma channel from the buffer
      iio: buffer-dma: support getting the DMA channel
      iio: buffer-dmaengine: enable .get_dma_dev()

 drivers/iio/buffer/industrialio-buffer-dma.c       |  6 +++++
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  2 ++
 drivers/iio/industrialio-buffer.c                  | 28 +++++++++++++++++-----
 include/linux/iio/buffer-dma.h                     |  1 +
 include/linux/iio/buffer_impl.h                    |  2 ++
 5 files changed, 33 insertions(+), 6 deletions(-)
---
base-commit: b9700f87939f0f477e5c00db817f54ab8a97702b
change-id: 20250930-fix-iio-dmabuf-get-dma-device-339ac70543db
--

Thanks!
- Nuno Sá



