Return-Path: <linux-iio+bounces-2628-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88391857EEF
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 15:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 177CFB27A79
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 14:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD9112EBCA;
	Fri, 16 Feb 2024 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+00sXCO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01AF12E1F2
	for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092689; cv=none; b=TTczesKUH+ok8svthfCwpRhESTEVEOQa2IAi9ZHLLQhQoBJ5zvIzBCDtokZOFqNq+MdwiJk8BpmLaZu1A9o3xDX+cmc/uQ107Dv3Wd4LCISSTFDYKgQWhWnplAQx85xtB50sfWBgpyVLGanfpPLGVg8NHu2icotA1CFuidNUTbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092689; c=relaxed/simple;
	bh=zrbBh0Aw33I9O/+ftBMnbcEQC7hb4RDV/E6G2FU8P84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BjShtkrKewuAmeV0FtfrviwsdNLNdZ3FWR0RYTLPU1BFSwNlS024KipwVSaiGtnIQs5Ezzl58OHtsL6b5ZSFAYckm3E7mTmvIqUhSo18FjmBzwMr6kENv07oARsipYTSdDvMwdummxDLMes4CeMQVRbbPanHsMyTVwJbbAJxyac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+00sXCO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FA0FC433A6;
	Fri, 16 Feb 2024 14:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708092689;
	bh=zrbBh0Aw33I9O/+ftBMnbcEQC7hb4RDV/E6G2FU8P84=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=a+00sXCOA6i625ZFbf4YZEenMT1Icjg3t5cAuOGkxkEI2zQgs6fKbuft9h/iIXUz2
	 70BizYD+Hs+ycoc692OGyx6aLOfUsRDuchOYE5nDNGHd5S3c3FqegaagsDpbKNv7EC
	 AptaAtCIRV3spJe0EJSmQ6j0CQa5hezeJP67mnG69CCk4gkp94M5mY5zPxY9vDrPJ/
	 195GI64wccu6CO5FmW7BYWrXNollv/tfXcq3ZJD7tGqd567GWnZLOwybDKYODoOP2r
	 Xsnhifdh4tea2oHHpMkWt7M7vlkeWnz+txOGC68wNDJA1h7zA+/xmwzvt9D+4um9N+
	 CIxksMjg4NPqA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A21AC48BF5;
	Fri, 16 Feb 2024 14:11:29 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 16 Feb 2024 15:10:53 +0100
Subject: [PATCH RFC 4/8] iio: buffer-dmaengine: Support specifying buffer
 direction
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-iio-backend-axi-dds-v1-4-22aed9fb07a1@analog.com>
References: <20240216-iio-backend-axi-dds-v1-0-22aed9fb07a1@analog.com>
In-Reply-To: <20240216-iio-backend-axi-dds-v1-0-22aed9fb07a1@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Paul Cercueil <paul@crapouillou.net>, 
 Alexandru Ardelean <ardeleanalex@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708092664; l=3316;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=/2paaSaUSUtnmD8m+C6v5CZcE58NPbZ+OtcbaI8FBrI=;
 b=agjbEFXThMyCk/MtP+kElOxF8eX9Wykk+QoKm8Lpzk25IIYZy7eV4VCt5/pSUlEWCzphYLhDI
 0O2vg8fYhn5AgFQWj0a4GjemUAMFGeSg4qVEDhsJ7HQaYNc089ie6Lc
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Paul Cercueil <paul@crapouillou.net>

Update the devm_iio_dmaengine_buffer_setup() function to support
specifying the buffer direction.

Update the iio_dmaengine_buffer_submit() function to handle input
buffers as well as output buffers.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 24 +++++++++++++++++-----
 include/linux/iio/buffer-dmaengine.h               |  5 ++++-
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index ccf6e0b19019..d9d72f7cba60 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -64,14 +64,25 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
 	struct dmaengine_buffer *dmaengine_buffer =
 		iio_buffer_to_dmaengine_buffer(&queue->buffer);
 	struct dma_async_tx_descriptor *desc;
+	enum dma_transfer_direction dma_dir;
+	size_t max_size;
 	dma_cookie_t cookie;
 
-	block->bytes_used = min(block->size, dmaengine_buffer->max_size);
-	block->bytes_used = round_down(block->bytes_used,
-			dmaengine_buffer->align);
+	max_size = min(block->size, dmaengine_buffer->max_size);
+	max_size = round_down(max_size, dmaengine_buffer->align);
+
+	if (queue->buffer.direction == IIO_BUFFER_DIRECTION_IN) {
+		block->bytes_used = max_size;
+		dma_dir = DMA_DEV_TO_MEM;
+	} else {
+		dma_dir = DMA_MEM_TO_DEV;
+	}
+
+	if (!block->bytes_used || block->bytes_used > max_size)
+		return -EINVAL;
 
 	desc = dmaengine_prep_slave_single(dmaengine_buffer->chan,
-		block->phys_addr, block->bytes_used, DMA_DEV_TO_MEM,
+		block->phys_addr, block->bytes_used, dma_dir,
 		DMA_PREP_INTERRUPT);
 	if (!desc)
 		return -ENOMEM;
@@ -277,7 +288,8 @@ static struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
  */
 int devm_iio_dmaengine_buffer_setup(struct device *dev,
 				    struct iio_dev *indio_dev,
-				    const char *channel)
+				    const char *channel,
+				    enum iio_buffer_direction dir)
 {
 	struct iio_buffer *buffer;
 
@@ -287,6 +299,8 @@ int devm_iio_dmaengine_buffer_setup(struct device *dev,
 
 	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
 
+	buffer->direction = dir;
+
 	return iio_device_attach_buffer(indio_dev, buffer);
 }
 EXPORT_SYMBOL_NS_GPL(devm_iio_dmaengine_buffer_setup, IIO_DMAENGINE_BUFFER);
diff --git a/include/linux/iio/buffer-dmaengine.h b/include/linux/iio/buffer-dmaengine.h
index cbb8ba957fad..ea9a539bfa20 100644
--- a/include/linux/iio/buffer-dmaengine.h
+++ b/include/linux/iio/buffer-dmaengine.h
@@ -7,6 +7,8 @@
 #ifndef __IIO_DMAENGINE_H__
 #define __IIO_DMAENGINE_H__
 
+#include <linux/iio/buffer.h>
+
 struct iio_dev;
 struct device;
 
@@ -15,6 +17,7 @@ struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
 void iio_dmaengine_buffer_free(struct iio_buffer *buffer);
 int devm_iio_dmaengine_buffer_setup(struct device *dev,
 				    struct iio_dev *indio_dev,
-				    const char *channel);
+				    const char *channel,
+				    enum iio_buffer_direction dir);
 
 #endif

-- 
2.43.0


