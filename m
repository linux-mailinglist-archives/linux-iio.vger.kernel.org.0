Return-Path: <linux-iio+bounces-3858-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BDE89000E
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 14:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE3871F252F7
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 13:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0B8811E9;
	Thu, 28 Mar 2024 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OA3YnRYU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9210E7F48B;
	Thu, 28 Mar 2024 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711632151; cv=none; b=pB70XYP36lafRrX1KuAHPW5TpR9y0DQx9UOKFuUFALc6I4JP6pzSfN5cugGVLrVsSN26wS+xIPzPzoZiaS8dXqMoT1J8xMYjQ/9U8arbaQikElF3hund8lKuvMwAlR0O+fNeGsFVEKQfFeZo8/XvPuxZeDfkgNc5+KBc43NMGAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711632151; c=relaxed/simple;
	bh=U7eugRZ0onsk1ecBmL8dcjYyAcI4CEkYadmrnw5LOJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pr0y5tG2w40jrrBS0nMg+JwSxZ334ndq5yBj1FjzAcOYa49gbEgdfBovIkCrL3geAAUreCwtxz2YxOKSb7sN6aySgZhAA22OTw3DPY4WH94l8drR7QznREItQW2DcHoDwi0Fpbck3n1lzpbI8hvErxe2vksACUCQrTwhKg5/XL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OA3YnRYU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 376A3C433A6;
	Thu, 28 Mar 2024 13:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711632151;
	bh=U7eugRZ0onsk1ecBmL8dcjYyAcI4CEkYadmrnw5LOJw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OA3YnRYUQk0ncNDbU4eo4RppfK/2//v/qGxEFdmuD/09fvUMpEVrZJratl/bHYctn
	 50HTNhzvQw78x8hAvV56KQslGJbNgjStUwqQgtjCBhc9I3pdG3xssjOnDpDVYZ0afD
	 UQRrnfZOn78JNQF+2hKZU8R1UZbir6EJSygYXX3Bd02WnuJOAhoyd05skbCxKIlxcL
	 SmIIoUs4ZZMHDkC5n1pf9uheH1Sd0h+zYzaGj6dmS0EvdoWbf+t545OEhxaz3uoDWi
	 t8mTMgp5WXD9uSJTSRjSeJz5lUKZvuyu95GNB5NPMKk/3BXJvOiV7jRj45u+w4BAzh
	 +25eAJkKB1hdw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1CDCD1284;
	Thu, 28 Mar 2024 13:22:31 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 28 Mar 2024 14:22:28 +0100
Subject: [PATCH 04/10] iio: buffer-dmaengine: Support specifying buffer
 direction
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-iio-backend-axi-dac-v1-4-afc808b3fde3@analog.com>
References: <20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com>
In-Reply-To: <20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Dragos Bogdan <dragos.bogdan@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Paul Cercueil <paul@crapouillou.net>, 
 Alexandru Ardelean <ardeleanalex@gmail.com>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711632149; l=3320;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=K0DaW1NvLTF6FP5FkoLaCwonpUuBlGRixF54Kc6llO8=;
 b=qKgYfHbOONfuB8LpNUZbEdfpaPdzPgaN1hnDNLjaQ6jJDu9/WCIjuUURlRVRGRYTAXNJLN8ZZ
 0q+rWBup17JAckjBnFwFxvBAMpuNFnsg/FTA/VMSXGbxUku/0QpW8xr
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
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 24 +++++++++++++++++-----
 include/linux/iio/buffer-dmaengine.h               |  6 +++++-
 2 files changed, 24 insertions(+), 6 deletions(-)

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
index cbb8ba957fad..f0d750ce2880 100644
--- a/include/linux/iio/buffer-dmaengine.h
+++ b/include/linux/iio/buffer-dmaengine.h
@@ -7,6 +7,8 @@
 #ifndef __IIO_DMAENGINE_H__
 #define __IIO_DMAENGINE_H__
 
+#include <linux/iio/buffer.h>
+
 struct iio_dev;
 struct device;
 
@@ -15,6 +17,8 @@ struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
 void iio_dmaengine_buffer_free(struct iio_buffer *buffer);
 int devm_iio_dmaengine_buffer_setup(struct device *dev,
 				    struct iio_dev *indio_dev,
-				    const char *channel);
+				    const char *channel,
+				    enum iio_buffer_direction dir);
+
 
 #endif

-- 
2.44.0



