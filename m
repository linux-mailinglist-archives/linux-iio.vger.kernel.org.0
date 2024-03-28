Return-Path: <linux-iio+bounces-3857-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4286C89000F
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 14:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5206B225FD
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 13:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41718063B;
	Thu, 28 Mar 2024 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+/FkLRw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB787EF0D;
	Thu, 28 Mar 2024 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711632151; cv=none; b=tRbBXB78kRbMw2H07uKicEl5Ly6Gls0qkxec3QWQcU3Js50mH0IxGkvlzaYvxgPX+exqVju36EljJXMxJJhKr8qBx9+kU/x2PO9lbnUjJz/ymLy9dS88uYLeIt2k48gn2lR8T1NgR5RnZ6VEpWXHspZqLruITHL7t1kKtmtUVSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711632151; c=relaxed/simple;
	bh=LRS3rt6TicXfYuFlOhhxQs3qLQWMSYhItKcuxXNBxbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=He6/Q+cy+3sBwlZs61usfRPFxGTb90/tqkjXqG/mXhvQafLVuHVhtCuf622p3hf55GsBLn4qKJxuXhJowtHiaHj0U+6cppYcifHPlZjETFF7/9kJXYTWr1zv/fti1fAKuYA2MosFSrZ4rHUkwuPbCL8Lxrmx44BpR9zktMfS1l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+/FkLRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28335C433F1;
	Thu, 28 Mar 2024 13:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711632151;
	bh=LRS3rt6TicXfYuFlOhhxQs3qLQWMSYhItKcuxXNBxbc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=V+/FkLRwk+4ZvYVkRyr7Sz1KB448tmnZtwq0z1V0mHMLhpJOxXAJXeeKLlLDo9fPm
	 jYTPMGSCZF9ZvQs/n3watkSP8xqHLAGulneInuXtibkB3QPD998y2xf0PnEN2ZD6UQ
	 wfpIc774v1ERjuWpv5djmdOIT/BfY6fK7UC+74+UIMxE+3lmQY7IbmZy5fhIhC6EwO
	 4pEHUWf/xhd8z2EjXZaJWRnYvWsyt3jABq+5vaNxTz47Kp7n4bKicfcFmxI+py06We
	 P4ozGbGblsY0N6bCYOqqJzoCrk0b48pRw8Hk6jkHcVgcAlg3RTq8Wk/MSGH8wzGpFA
	 ZUj5bmFy5O+/A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CBCCD1287;
	Thu, 28 Mar 2024 13:22:31 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 28 Mar 2024 14:22:26 +0100
Subject: [PATCH 02/10] iio: buffer-dma: Rename
 iio_dma_buffer_data_available()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-iio-backend-axi-dac-v1-2-afc808b3fde3@analog.com>
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
 Paul Cercueil <paul@crapouillou.net>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711632149; l=3293;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=pnGz0IvIMOvc3W8GugiHOr2smQMJ1XHymguYmuxH0E8=;
 b=kZyFUV24Qavk9g5njiC2rh85qnccUwghLRpCof5xrJYL8VffLa8vs8sxnB+GoQHYw0T550tPN
 B+d3HcyykbTAyh+3mesKPNtS2UDDTFPB39JhpxhtHfSzvhxPFWdSmpC
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Paul Cercueil <paul@crapouillou.net>

Change its name to iio_dma_buffer_usage(), as this function can be used
both for the .data_available and the .space_available callbacks.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dma.c       | 11 ++++++-----
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  2 +-
 include/linux/iio/buffer-dma.h                     |  2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index 5610ba67925e..404f9867bdc5 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -547,13 +547,14 @@ int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
 EXPORT_SYMBOL_GPL(iio_dma_buffer_read);
 
 /**
- * iio_dma_buffer_data_available() - DMA buffer data_available callback
+ * iio_dma_buffer_usage() - DMA buffer data_available and
+ * space_available callback
  * @buf: Buffer to check for data availability
  *
- * Should be used as the data_available callback for iio_buffer_access_ops
- * struct for DMA buffers.
+ * Should be used as the data_available and space_available callbacks for
+ * iio_buffer_access_ops struct for DMA buffers.
  */
-size_t iio_dma_buffer_data_available(struct iio_buffer *buf)
+size_t iio_dma_buffer_usage(struct iio_buffer *buf)
 {
 	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buf);
 	struct iio_dma_buffer_block *block;
@@ -586,7 +587,7 @@ size_t iio_dma_buffer_data_available(struct iio_buffer *buf)
 
 	return data_available;
 }
-EXPORT_SYMBOL_GPL(iio_dma_buffer_data_available);
+EXPORT_SYMBOL_GPL(iio_dma_buffer_usage);
 
 /**
  * iio_dma_buffer_set_bytes_per_datum() - DMA buffer set_bytes_per_datum callback
diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index a18c1da292af..ccf6e0b19019 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -117,7 +117,7 @@ static const struct iio_buffer_access_funcs iio_dmaengine_buffer_ops = {
 	.request_update = iio_dma_buffer_request_update,
 	.enable = iio_dma_buffer_enable,
 	.disable = iio_dma_buffer_disable,
-	.data_available = iio_dma_buffer_data_available,
+	.data_available = iio_dma_buffer_usage,
 	.release = iio_dmaengine_buffer_release,
 
 	.modes = INDIO_BUFFER_HARDWARE,
diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
index 18d3702fa95d..52a838ec0e57 100644
--- a/include/linux/iio/buffer-dma.h
+++ b/include/linux/iio/buffer-dma.h
@@ -132,7 +132,7 @@ int iio_dma_buffer_disable(struct iio_buffer *buffer,
 	struct iio_dev *indio_dev);
 int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
 	char __user *user_buffer);
-size_t iio_dma_buffer_data_available(struct iio_buffer *buffer);
+size_t iio_dma_buffer_usage(struct iio_buffer *buffer);
 int iio_dma_buffer_set_bytes_per_datum(struct iio_buffer *buffer, size_t bpd);
 int iio_dma_buffer_set_length(struct iio_buffer *buffer, unsigned int length);
 int iio_dma_buffer_request_update(struct iio_buffer *buffer);

-- 
2.44.0



