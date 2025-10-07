Return-Path: <linux-iio+bounces-24814-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 02083BC0D56
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 11:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A162834D815
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 09:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCFF2D73A7;
	Tue,  7 Oct 2025 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGjXa6OS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68522D47E9;
	Tue,  7 Oct 2025 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759828491; cv=none; b=q4HdKTb6y6p1ecle+paT8iWsea7/rf8IgyvZiESzp8LKjHapok1hCqIsFVGZ/1q2Kj9/MGXDRTqBPs/bG/Iopymij9gF4vzfFgfeMwXbFcHII5C4tj1CCrjbmjtlveFis3g2JsMZKhMcyd2W9LoXfte8MMb6zIbWtd+2vbK/sCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759828491; c=relaxed/simple;
	bh=ic5garmDtwPbiYjiCLxAOQWxTze/dBe+/CXDyiu4RvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d7vmq/9zDthdZ44iI9GUg4b00XkVtTlv3T2aja6r7urR17tR1PFH7RBQ6bPTxZYxC5TBJAs5vdEjjAjDh+fkpCE/aeckDEZ/pA71GLfcte+lojqAQeoVERQagcRBa8Y+9GyoIdifaH6H/hRZF+WcTJC+FREBTFiZqaUKnSLDdu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGjXa6OS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7BA65C4CEF7;
	Tue,  7 Oct 2025 09:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759828491;
	bh=ic5garmDtwPbiYjiCLxAOQWxTze/dBe+/CXDyiu4RvQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GGjXa6OSl17w+QUX0AkW6K5TZqNcL9gBhj5Nu2/v6C591UEMiSB9IVQx4hBHhVT/j
	 fosnMHSjsO9tn6UKvMHFyDR6c4YCnvadyKQDuEr9rjjprhfLFeMBI7IDa1+Cau9Iw2
	 zqLVzn0ei/lVc6exhrQu3JqjPGqIsCXQx7wxOHojTQZLsYSR/0uCMlFAknr1nMQ0d+
	 Rzz7lwWvItfQORr619Ce2hv+5G4JBW7S6eHd5rlzN5Aeu4TI2W/PLY8YLXbfAoRKl4
	 z+qj5X6IY0LiBGoIGikc2XFOd56Oh79XqHtUjpx7LUYhrTE82kyZXH7y1G2uR6DKyh
	 vQtHfEWCFqozQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBA7CCD185;
	Tue,  7 Oct 2025 09:14:51 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 07 Oct 2025 10:15:22 +0100
Subject: [PATCH v3 2/3] iio: buffer-dma: support getting the DMA channel
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251007-fix-iio-dmabuf-get-dma-device-v3-2-0c73e2c0653b@analog.com>
References: <20251007-fix-iio-dmabuf-get-dma-device-v3-0-0c73e2c0653b@analog.com>
In-Reply-To: <20251007-fix-iio-dmabuf-get-dma-device-v3-0-0c73e2c0653b@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759828521; l=2111;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=UeNxzat1eGNvUr3sMj3PKl6QY4MQ66nZwzV2A6/tUFQ=;
 b=dQoXcvR61sYTLqbDWDPZoeygYWDSj1moSPYvlHuQybbcJXsobNP5uh7FvkVAnwEoAA+Z2nqoC
 5KtHHpTMkCVAvEtNJdsunsKMtRi4u8dezPeDThc/pTPb53s6jj4NXiw
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
Reviewed-by: David Lechner <dlechner@baylibre.com>
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



