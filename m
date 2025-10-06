Return-Path: <linux-iio+bounces-24780-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AB0BBE955
	for <lists+linux-iio@lfdr.de>; Mon, 06 Oct 2025 18:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E8C3B53FC
	for <lists+linux-iio@lfdr.de>; Mon,  6 Oct 2025 16:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DCD2D97A8;
	Mon,  6 Oct 2025 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+TBm0NM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE1F27F754;
	Mon,  6 Oct 2025 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759766764; cv=none; b=WfZniam4+FSFchDYaVk0chfE0Tml4regBUFuU/rN3t5UwqvmgQ6y7BxySPPdufkix+GHNVljdlrteJ4az7fNRlGnvGro4OoPvukyIzSzVbJdttRCrcavtbpN6z1z5rX0hL+Up3r3V4qf1DG40mhvKb6gBga0bktdpy7Uc11n9yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759766764; c=relaxed/simple;
	bh=BaFLta81w+NLxTP9O9t2OJTctrOyaPOQ8rq/bkeohmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CxY/C8gH3DDYshXpSJR1lCim9JY1DLQc0UzsDeerwx5TvFYVOtlTtFOcsqdMUlc+RgMxyJW3OGZEgT8FRnAJTaX3OTg+29IkHTIci2f/3kOUGsB5aE5XLtfUjlWexUOyDS/DBxGtWmLYJMGWZjY1IvXLy6H8llMzUcGXpfmeOgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+TBm0NM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C99C7C113D0;
	Mon,  6 Oct 2025 16:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759766763;
	bh=BaFLta81w+NLxTP9O9t2OJTctrOyaPOQ8rq/bkeohmM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=D+TBm0NMpTA4ENmCpELSV2glC7uwTNEhjCXASGj0WlQnAAqTivXiMfqJ2Qt+ykw+X
	 B3vmVWqSCHEmzcZ6MvuKhRO1a2qqBpKuuA2uhQps5ke2F0aYH6dw4+EegQu7FVkxcP
	 FJR0SHws2KGyM80Mil2P1Pl1tFMvGt/ea4BwOLWyStnxZmr8+gFtXFPkaJZakiDdT/
	 4DIJPqYYLCmPniFdHs5j4fdgzSGVVxPPd2GafyE3zR4QrPbrt8Oqsya8Wf3cIp9HwG
	 qZjixn7vwFQ0iuT+PRFQo8I04b08CVppMwdcn0hsOMZU5t1dLuI0RQKU0fHs9Y6nIc
	 hSvew3G1OrYnQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25E9CCA476;
	Mon,  6 Oct 2025 16:06:03 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 06 Oct 2025 17:06:33 +0100
Subject: [PATCH v2 2/3] iio: buffer-dma: support getting the DMA channel
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251006-fix-iio-dmabuf-get-dma-device-v2-2-d960bc9084da@analog.com>
References: <20251006-fix-iio-dmabuf-get-dma-device-v2-0-d960bc9084da@analog.com>
In-Reply-To: <20251006-fix-iio-dmabuf-get-dma-device-v2-0-d960bc9084da@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759766793; l=2059;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=GrS7qJFdtb/72HMZOouMQanpI/Z9hVW7H2co7YCJG34=;
 b=Ppedd/xGWnhefbXfUWpH3W3UcSEi2/B4vjHzk2SdCsnqqIjKNGiJWcisVwSxC2UoofQV6W7Jg
 CNM8gtZnJTMBqJUmISGZZtmso1JxOjyMLKyNxRQF6lAMIFRafzFRgcd
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

Cc: stable@vger.kernel.org
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



