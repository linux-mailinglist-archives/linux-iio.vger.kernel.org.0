Return-Path: <linux-iio+bounces-24813-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C70DEBC0D62
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 11:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB71B189F3C4
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 09:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311F72D73B9;
	Tue,  7 Oct 2025 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7WyuQIS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BA6288527;
	Tue,  7 Oct 2025 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759828491; cv=none; b=E8MGufa0Fes/JCw7Hu4nosh5IgkM5o/pAbKk0EG1rkpvM832TMXgUHPRNWXAR7oouEdtc2wpaPm79In4y1f9aHOTvWqhASJqc5V2IOTanwuVuyLWpR/NS7qbKd3BFsAfgpVZZUFKJyGH8Ww34ridVSrQLnZxEx8yS+vlvcRGCH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759828491; c=relaxed/simple;
	bh=7ix5FKmh/hONkOptzGkIxX2M47wJgX+yM53Gq77Zul8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gbSAPYPAHOmCGHhK734BN6AV0ru+GCxw3l5PppcUyKydLrtKMslgjhEwmzo8tdTVlppnoIFAPAgo44JjFDzMhCaddsZ+72GtiRJ6bOZHoNKt+ads+d5lnm2Y5iirOc8gh9aJMId1NvES0GdfoacLk2Gf0H5K5u/Ld8UeMRKwqsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7WyuQIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60B01C4CEF1;
	Tue,  7 Oct 2025 09:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759828491;
	bh=7ix5FKmh/hONkOptzGkIxX2M47wJgX+yM53Gq77Zul8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=p7WyuQISlzlFDyvu0nwePc58LC8zUa0CMWjPoLfXfBIIonpXDc/VfXx/wFefbvo2R
	 40MuKPrdhu9bktNSue083NFtIZhnQmG4lXnh1wNd1q352CopJnhf1xIH2mxOWRyBet
	 LqAp6NASqF7iYMD8fh5oLCf3GCZ4krQeyerVtTk9XFDzBW22K59wIfL9I6IgHaa6+j
	 oRLcvHvpAsVH+yryVCBs5xnvxdGB0dO5GDt5srvK4dwEYiYfbSqmVz/YwGcrI79Uxv
	 dBx86VrML4qPGLqKIDz2Ii2uTyvrKWDmZOljKAnHa9jC+rpdxzSvly8QwKzmtpgjaP
	 hz2lCjrSLtC5Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9E5CCA470;
	Tue,  7 Oct 2025 09:14:51 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v3 0/3] iio: buffer: Fix DMABUF mapping in some systems
Date: Tue, 07 Oct 2025 10:15:20 +0100
Message-Id: <20251007-fix-iio-dmabuf-get-dma-device-v3-0-0c73e2c0653b@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACja5GgC/4XNQQ6CMBAF0KuQrh0zbQGtK+9hXJS2wCRCTYuNh
 nB3CytdsZv/k/9mZtEFcpFdipkFlyiSH3OQh4KZXo+dA7I5M4GiQiURWnoDkQc76ObVQuem9QS
 bt8aBlEqbE1altA3LxjO4PNj82z3nnuLkw2d7l/jabjJHFDty4oBguFGqrFAoi1c96ofvjsYPb
 KWT+OXqPU5kzqoaG6PwXFr9xy3L8gUmpCOFGgEAAA==
X-Change-ID: 20250930-fix-iio-dmabuf-get-dma-device-339ac70543db
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759828521; l=2523;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=7ix5FKmh/hONkOptzGkIxX2M47wJgX+yM53Gq77Zul8=;
 b=JrZ6p59yqHwK+wgZVPUX2bedCunVOeS8mP7o2JfoyMxAsfM2LiHDx2pKkK4SuJnAxt9tSTNBB
 pTWjTB5AF7JCbLB24f/KlHNRKIW7Ufo5sesE/ZArf8lcrWiZbLXNDrl
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
Changes in v3:
- Patch 1
  * Add a new iio_buffer_get_dma_dev() helper to get the DMA dev.
- Link to v2: https://lore.kernel.org/r/20251006-fix-iio-dmabuf-get-dma-device-v2-0-d960bc9084da@analog.com

---
Nuno Sá (3):
      iio: buffer: support getting dma channel from the buffer
      iio: buffer-dma: support getting the DMA channel
      iio: buffer-dmaengine: enable .get_dma_dev()

 drivers/iio/buffer/industrialio-buffer-dma.c       |  6 ++++++
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  2 ++
 drivers/iio/industrialio-buffer.c                  | 21 ++++++++++++++++-----
 include/linux/iio/buffer-dma.h                     |  1 +
 include/linux/iio/buffer_impl.h                    |  2 ++
 5 files changed, 27 insertions(+), 5 deletions(-)
---
base-commit: b9700f87939f0f477e5c00db817f54ab8a97702b
change-id: 20250930-fix-iio-dmabuf-get-dma-device-339ac70543db
--

Thanks!
- Nuno Sá



