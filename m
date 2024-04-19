Return-Path: <linux-iio+bounces-4353-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E738AAA12
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 10:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4533728559B
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 08:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E3C5FB88;
	Fri, 19 Apr 2024 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W30J6eHv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924F653E0A;
	Fri, 19 Apr 2024 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515137; cv=none; b=JT+T0pXvTBSLiPEGh/fy9fYQ17YOBT8C0LrtHECsqM1RjrwRFVoZeiymFU8f6im8bhFHJjDXp3IFGcQuhjcUG+znFCo/LsZ/TjuCQOKg4gXQYM6MvRtdjApvMylFopcwcVb2utI6FHnm3GNu0gZz0s3ilRfDCPk1BS7YDq8nEfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515137; c=relaxed/simple;
	bh=W7Q9EeQC69HgOXY6yDvreeXfFACrgL2UG7ipn2evH7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fQ5XIpoLCOzcEZQGXdBGL2ijbEFujRWbDoa2VhEzfnX1zDUXV0ZtnwhGjfzMzZjMdCznrN4v3bkFXdQODvYHlt+yU23Nin3F48ytgY1OkLIlSNuAZnj+LXMwKt0r1BzgOGETjBWCUPaNdRUZg4Wirjf8NoTZBt/iW/S5D8hgPUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W30J6eHv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3ED64C4AF0E;
	Fri, 19 Apr 2024 08:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713515137;
	bh=W7Q9EeQC69HgOXY6yDvreeXfFACrgL2UG7ipn2evH7w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=W30J6eHv1JOn/3IPTH9EJ8jh2CpiP1of/Oz49SQytWVymgGqZlbDkmB0xW4eki90L
	 VoTxFeCCDJW/loQmJQ5XOZZj8x5YMpzRLh3KVytjI1z06YlEC7U47QYrfQoqIFG0BN
	 XYUPWghOl3POONzN857/UfYXLG8Io/12mC06oPIHThOwrRp+7Up8iEyWq3zQUeCljy
	 V6fs5hPMir49wh9thAUjRFUUNncjgv68J97fcPhQK4CJv98yDOuwCNqQb2MwE2b+MR
	 D6E+EhfDFvacSbjvCSvVMtrghuvIjjwQYc8V3MIT/CX7I3jWHe2L6sAGISshMGn8Px
	 Nh+aZxHR1TX+Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38712C4345F;
	Fri, 19 Apr 2024 08:25:37 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 19 Apr 2024 10:25:37 +0200
Subject: [PATCH v4 04/10] iio: buffer-dmaengine: Support specifying buffer
 direction
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-iio-backend-axi-dac-v4-4-5ca45b4de294@analog.com>
References: <20240419-iio-backend-axi-dac-v4-0-5ca45b4de294@analog.com>
In-Reply-To: <20240419-iio-backend-axi-dac-v4-0-5ca45b4de294@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Dragos Bogdan <dragos.bogdan@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Paul Cercueil <paul@crapouillou.net>, 
 Alexandru Ardelean <ardeleanalex@gmail.com>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713515134; l=5579;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=u23I6KLSCcrBhm4fnCuOy4udHamrKg4Ga64h2+KE9cI=;
 b=x4GnbGszJM4BngRXaOWF3R2YmYGWhjWeGO+ilRLFaYNQtMcn+TlrwFFvdKkEPo/jj+pQUds8M
 WPTHwfzCv+dCsd4moAnvdoLF+BiEsCk+GU8Z1Gmv24p9uw4mtBVEB21
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Paul Cercueil <paul@crapouillou.net>

Update the devm_iio_dmaengine_buffer_setup() function to support
specifying the buffer direction.

Update the iio_dmaengine_buffer_submit() function to handle input
buffers as well as output buffers.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 41 +++++++++++++++-------
 include/linux/iio/buffer-dmaengine.h               | 25 +++++++++----
 2 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index df05d66afff9..051e1758e020 100644
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
@@ -229,9 +240,10 @@ void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
 }
 EXPORT_SYMBOL_NS_GPL(iio_dmaengine_buffer_free, IIO_DMAENGINE_BUFFER);
 
-struct iio_buffer *iio_dmaengine_buffer_setup(struct device *dev,
-					      struct iio_dev *indio_dev,
-					      const char *channel)
+struct iio_buffer *iio_dmaengine_buffer_setup_ext(struct device *dev,
+						  struct iio_dev *indio_dev,
+						  const char *channel,
+						  enum iio_buffer_direction dir)
 {
 	struct iio_buffer *buffer;
 	int ret;
@@ -242,6 +254,8 @@ struct iio_buffer *iio_dmaengine_buffer_setup(struct device *dev,
 
 	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
 
+	buffer->direction = dir;
+
 	ret = iio_device_attach_buffer(indio_dev, buffer);
 	if (ret) {
 		iio_dmaengine_buffer_free(buffer);
@@ -250,7 +264,7 @@ struct iio_buffer *iio_dmaengine_buffer_setup(struct device *dev,
 
 	return buffer;
 }
-EXPORT_SYMBOL_NS_GPL(iio_dmaengine_buffer_setup, IIO_DMAENGINE_BUFFER);
+EXPORT_SYMBOL_NS_GPL(iio_dmaengine_buffer_setup_ext, IIO_DMAENGINE_BUFFER);
 
 static void __devm_iio_dmaengine_buffer_free(void *buffer)
 {
@@ -268,20 +282,21 @@ static void __devm_iio_dmaengine_buffer_free(void *buffer)
  * It also appends the INDIO_BUFFER_HARDWARE mode to the supported modes of the
  * IIO device.
  */
-int devm_iio_dmaengine_buffer_setup(struct device *dev,
-				    struct iio_dev *indio_dev,
-				    const char *channel)
+int devm_iio_dmaengine_buffer_setup_ext(struct device *dev,
+					struct iio_dev *indio_dev,
+					const char *channel,
+					enum iio_buffer_direction dir)
 {
 	struct iio_buffer *buffer;
 
-	buffer = iio_dmaengine_buffer_setup(dev, indio_dev, channel);
+	buffer = iio_dmaengine_buffer_setup_ext(dev, indio_dev, channel, dir);
 	if (IS_ERR(buffer))
 		return PTR_ERR(buffer);
 
 	return devm_add_action_or_reset(dev, __devm_iio_dmaengine_buffer_free,
 					buffer);
 }
-EXPORT_SYMBOL_NS_GPL(devm_iio_dmaengine_buffer_setup, IIO_DMAENGINE_BUFFER);
+EXPORT_SYMBOL_NS_GPL(devm_iio_dmaengine_buffer_setup_ext, IIO_DMAENGINE_BUFFER);
 
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_DESCRIPTION("DMA buffer for the IIO framework");
diff --git a/include/linux/iio/buffer-dmaengine.h b/include/linux/iio/buffer-dmaengine.h
index acb60f9a3fff..81d9a19aeb91 100644
--- a/include/linux/iio/buffer-dmaengine.h
+++ b/include/linux/iio/buffer-dmaengine.h
@@ -7,15 +7,28 @@
 #ifndef __IIO_DMAENGINE_H__
 #define __IIO_DMAENGINE_H__
 
+#include <linux/iio/buffer.h>
+
 struct iio_dev;
 struct device;
 
 void iio_dmaengine_buffer_free(struct iio_buffer *buffer);
-struct iio_buffer *iio_dmaengine_buffer_setup(struct device *dev,
-					      struct iio_dev *indio_dev,
-					      const char *channel);
-int devm_iio_dmaengine_buffer_setup(struct device *dev,
-				    struct iio_dev *indio_dev,
-				    const char *channel);
+struct iio_buffer *iio_dmaengine_buffer_setup_ext(struct device *dev,
+						  struct iio_dev *indio_dev,
+						  const char *channel,
+						  enum iio_buffer_direction dir);
+
+#define iio_dmaengine_buffer_setup(dev, indio_dev, channel)	\
+	iio_dmaengine_buffer_setup_ext(dev, indio_dev, channel,	\
+				       IIO_BUFFER_DIRECTION_IN)
+
+int devm_iio_dmaengine_buffer_setup_ext(struct device *dev,
+					struct iio_dev *indio_dev,
+					const char *channel,
+					enum iio_buffer_direction dir);
+
+#define devm_iio_dmaengine_buffer_setup(dev, indio_dev, channel)	\
+	devm_iio_dmaengine_buffer_setup_ext(dev, indio_dev, channel,	\
+					    IIO_BUFFER_DIRECTION_IN)
 
 #endif

-- 
2.44.0



