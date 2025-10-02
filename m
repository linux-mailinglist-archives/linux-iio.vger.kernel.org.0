Return-Path: <linux-iio+bounces-24662-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5DABB4431
	for <lists+linux-iio@lfdr.de>; Thu, 02 Oct 2025 17:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823721C2626
	for <lists+linux-iio@lfdr.de>; Thu,  2 Oct 2025 15:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F39117A2EA;
	Thu,  2 Oct 2025 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UT026GaG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6FC1547C9
	for <linux-iio@vger.kernel.org>; Thu,  2 Oct 2025 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759417561; cv=none; b=o2q2xSzxjxqUYE8X2QgjDeLJ9LKzmglKK3dKk2bBIOsgG1TbuPe4CuVArM2ODt0NmSlzCYKM9WJXXAZ4wuO67Hh3h+O+2bAr10XbiPU9Y2/zCtFY47L0QathhNGE7yXCF5CSeu2D+wsDJNN3YFYUcyidj1dEuP2sSGKrUcPSWKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759417561; c=relaxed/simple;
	bh=Tmw/JxBrBDAit3p4RlzaRCMWjZJ9BYScOcgu6iJV5JM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t71bSiGt2f4fCYbvLoC7Jz//JWjTJh+KXe85kYTUf+0QCbW7a9U/q+jn8rOH0KP7dkfpGlYOoRfMOmnF9JxlJDha/h+9GQYy4/8B84FNVn69TpfOgyvu/4yD+M4BqE+o723SGMfZIzzc+vLIN0C2cuZ0ZKpyzIKPKy5y7j4x2n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UT026GaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75E34C4CEFC;
	Thu,  2 Oct 2025 15:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759417560;
	bh=Tmw/JxBrBDAit3p4RlzaRCMWjZJ9BYScOcgu6iJV5JM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UT026GaGwP+xO2ZJTfrWDOmEK0YFMqpI47veXGxpL6vkyD5cx/pZj287nSo47nkok
	 E8OcQAoybIBL+7ejQnA04MOz0DCuce6kbJpvOLG5vh1Us9wvHpK8NHopDqlniwyyuk
	 6us20zxqJfHO4NVh5LW1q58wbSuRlYuo1zr5SkT5W5QBgu1VXi/D0XbRbf813NDx8f
	 830yFlShlgPG/Rj90lqIJ0LcBprXuEuZmHEXyGvGMiKoMzQkQeZDgCyyyDGHuU7US0
	 k/knFjrIYqHBEzWRVyy8LRYjsQNJJFM47m1LRaeKrLIqy+KLUQ/U2Vy1S/zcFbqbIH
	 fnJt+40dYbv/A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6893BCAC5B8;
	Thu,  2 Oct 2025 15:06:00 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 02 Oct 2025 16:06:29 +0100
Subject: [PATCH 2/3] iio: buffer-dma: support getting the DMA channel
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251002-fix-iio-dmabuf-get-dma-device-v1-2-c1c9945029d0@analog.com>
References: <20251002-fix-iio-dmabuf-get-dma-device-v1-0-c1c9945029d0@analog.com>
In-Reply-To: <20251002-fix-iio-dmabuf-get-dma-device-v1-0-c1c9945029d0@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759417589; l=2100;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=5q+FTwLRTnkJyA5ddHnx3TXOdhrA4aywlUfGa7XNBZg=;
 b=ArDl4VPgi0Cp+i+3LxzEJ+b9a6pfgh7xOC8qRItxNINBTdA0wu5LYJWynQ4eRI0L7fb3nPbck
 nB0JD7IZN+XAlsM3a1xeffAehzPB+9MYYtdW+k5VuQkb1DfHSaJoYgX
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Implement the .get_dma_dev() callback for DMA buffers by returning the
device that owns the DMA channel. This allows the core DMABUF
infrastructure to properly map DMA buffers using the correct device,
avoiding the need for bounce buffers on systems where memory is mapped
above the 32-bit range.

The function returns the DMA queue's device, which is the actual device
responsible for DMA operations in buffer-dma implementations.

Fixes: d85318900c1c ("iio: buffer-dma: Enable support for DMABUFs")
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dma.c | 6 ++++++
 include/linux/iio/buffer-dma.h               | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index ee294a775e8aa050aca85e422de4c267adee1a33..7a7a9d37339bc1c2ffec58687a42dde16b1412bb 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -786,6 +786,12 @@ int iio_dma_buffer_enqueue_dmabuf(struct iio_buffer *buffer,
 }
 EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_enqueue_dmabuf, "IIO_DMA_BUFFER");
 
+struct device *iio_dma_buffer_get_dma_dev(struct iio_buffer *buffer)
+{
+	return iio_buffer_to_queue(buffer)->dev;
+}
+EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_get_dma_dev, "IIO_DMA_BUFFER");
+
 void iio_dma_buffer_lock_queue(struct iio_buffer *buffer)
 {
 	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
index 5eb66a3990021afb1821297e540656a65916daa7..4f33e6a39797d3ecfddc69c11d6d3985b9212920 100644
--- a/include/linux/iio/buffer-dma.h
+++ b/include/linux/iio/buffer-dma.h
@@ -174,5 +174,6 @@ int iio_dma_buffer_enqueue_dmabuf(struct iio_buffer *buffer,
 				  size_t size, bool cyclic);
 void iio_dma_buffer_lock_queue(struct iio_buffer *buffer);
 void iio_dma_buffer_unlock_queue(struct iio_buffer *buffer);
+struct device *iio_dma_buffer_get_dma_dev(struct iio_buffer *buffer);
 
 #endif

-- 
2.51.0



