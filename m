Return-Path: <linux-iio+bounces-24778-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAE8BBE94C
	for <lists+linux-iio@lfdr.de>; Mon, 06 Oct 2025 18:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29E134E638D
	for <lists+linux-iio@lfdr.de>; Mon,  6 Oct 2025 16:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9322D94BA;
	Mon,  6 Oct 2025 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kr3ZI0gy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD2C171C9;
	Mon,  6 Oct 2025 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759766764; cv=none; b=Os3jBkuCU5qrOOR2gQu6ITW1Yo8So8lfvEGDfWpEGs8PT89DVCJcGon2fbqkgCGZ589LTZtdwPvbaH+elyEs+JWr8kiF7GhCQJq7JQO5v8+zIx0fUoWvASsgRy2pwofCsF1Cynhlhw5Wk6HaSR+t4nvKsf9YPOYi2HtcR2AOW10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759766764; c=relaxed/simple;
	bh=2HriaveKNvlAzz3g9JtDTugyDiYrNXDtfRXTc0G9D3Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ba9LCi3T9nGxp0nDSOW37Vukk6HpKaHuuCGbNG7e+bKlBJyYi5okhtqg+ySMZ4/u0dS0O5ZBsnAlKCYW4Z3ibIhAMCKa+TcYC2Y9uZsrxmQIZkio5pRzH3QuvQqstvfSwtztSpv9UNe4pIIgnkbc02P/DSztikqnfJWb6qJUhIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kr3ZI0gy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B07DDC4CEF5;
	Mon,  6 Oct 2025 16:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759766763;
	bh=2HriaveKNvlAzz3g9JtDTugyDiYrNXDtfRXTc0G9D3Q=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Kr3ZI0gy4f/7muVsePPhDiBb8b62TEO4LLHpztLZZVh7HT79ZUdvK+iM2w+Vv1zjC
	 oRyVddc0PW7NdUGRNzE/w4XE9RN10zsErnkpuVN1lFvwPQDfabpWyns9gpsPQZFfb4
	 fDl9hQyT7vUGSiWZtsRzChaIbuU+4BBkA6/bNch7bW16hBsuDWbtPHeBWHkMOum2Lh
	 i/gebmtL0m1kBh4OLbt9RSi5qEX91HfBR/yEROcb4IQ8GPPguxqpyKLZAvJ7Oy9A8y
	 sg6KtdqpSQT/6pr5qJA4oCg84E9//9S4YUDR1dIyFQtWBtgy2Jl5ukbf9HIj3NhzpX
	 S6sZGpUfbnGcw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81CBCCA470;
	Mon,  6 Oct 2025 16:06:03 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v2 0/3] iio: buffer: Fix DMABUF mapping in some systems
Date: Mon, 06 Oct 2025 17:06:31 +0100
Message-Id: <20251006-fix-iio-dmabuf-get-dma-device-v2-0-d960bc9084da@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAfp42gC/4WNQQ6CMBBFr2Jm7ZhpCzF15T0Mi9IOMIlQ0yLRE
 O5u4QLu/vvJf3+FzEk4w+20QuJFssSpgD6fwA9u6hklFAZNuiZrCDv5oEjEMLr23WHP8x4xlK1
 nNMY6f6W6MqGF4nglLoPD/2gKD5LnmL7H3aL29jArIv3HvCgk9MpbW9WkbaC7m9wz9hcfR2i2b
 fsBRStkD8sAAAA=
X-Change-ID: 20250930-fix-iio-dmabuf-get-dma-device-339ac70543db
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759766793; l=2563;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=2HriaveKNvlAzz3g9JtDTugyDiYrNXDtfRXTc0G9D3Q=;
 b=N2ZYoKriYdqN0yWcMcoNXHfWYxYeXBT5vn5REZAoZzOctVbo3a8+ikEEI/CA78oWX0ljOgLoX
 YZvKMQ6gHPDAIjZhUJSRYRMASaYP+tRGcFJXw0xwyYRXvD1zbfIKSSG
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
Changes in v2:
- Dropped Fixes tags on the first two patches and Cc stable them instead
  (as prerequisites for the third patch). 
- Link to v1: https://lore.kernel.org/r/20251002-fix-iio-dmabuf-get-dma-device-v1-0-c1c9945029d0@analog.com

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



