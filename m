Return-Path: <linux-iio+bounces-2626-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 352BB857EEB
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 15:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA45C1F217E5
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 14:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD6D12D773;
	Fri, 16 Feb 2024 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcUArK3b"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA3512D74F
	for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092689; cv=none; b=k2pheHCIEyq11tJO7BpOtQuFHMYSw/yY3RXk0FsNzu6n3oiwH6Syt3nKeUxPjVr5uQ4p55MEyj1rVDw6JjQ8+e26sGLmOwlCE8k038++092hqxLAuvtOHmFdCfRcN1iMLV7L22CXuZFCJeBVBuAsw7GQitSdNnYYva8XOetqIe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092689; c=relaxed/simple;
	bh=32TOGugcvJJh6gm/zGxiRehdrYkiYLBiQNgo6DdJJ0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QNGH6tB+hQt64BQ9/w3/+ObQWATU2kZcwjwQs4lyEqbTenPKgcX5uZTl6ShBQjebZZ/GAEwrG0fGvF+GCkxY7T1OYpwbcoktwCedKCOvTBLhH+ZxlgQurY47IFuY+MKzdrm0XHZZu4eHf4DspdkVqVhfZuDnqEaFJ5K/i4dDNWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcUArK3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A423C43394;
	Fri, 16 Feb 2024 14:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708092689;
	bh=32TOGugcvJJh6gm/zGxiRehdrYkiYLBiQNgo6DdJJ0s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OcUArK3bAEEaorNSKXDw4At2P0c7hII+cJ1WCcocQVWKyIhMuQKYkX0t2OQUxuKpw
	 CXj1hz4SHa06GqTiKpApPyJt4v6H2xf7zjrx+sxxdgIIyyKCWoMDrrClSgXuT7ZqBI
	 SbCpz/QNGey2RbTYqPZC5VmGC3ahEMXYp2U8lPPnuCydyqT42oorBGO9hd8hjyXbEX
	 YQBl1t54HbG41Tvh8P3TH2Yq7g2txYFYjCxtVTQZ4gv9waoY9B8OFTvHNxzx3FT/Zg
	 PaN7R4dPs6dh4+ohwzEZKoXTwK9l+GDFT4DkmwrsuU0bnPBOjEg6aIJA8yiUPtNGnW
	 iP4VEoWHPSiRw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C9CC48BC4;
	Fri, 16 Feb 2024 14:11:29 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 16 Feb 2024 15:10:51 +0100
Subject: [PATCH RFC 2/8] iio: buffer-dma: Rename
 iio_dma_buffer_data_available()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-iio-backend-axi-dds-v1-2-22aed9fb07a1@analog.com>
References: <20240216-iio-backend-axi-dds-v1-0-22aed9fb07a1@analog.com>
In-Reply-To: <20240216-iio-backend-axi-dds-v1-0-22aed9fb07a1@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Paul Cercueil <paul@crapouillou.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708092664; l=3248;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=HpcxNkbUz45lD46m3e2kAC4KFbW46Vx9gXKUdmjhFZs=;
 b=YmhMLNRbwgTjtTILvJaNrZKrCYNqPFA+umVHFSwueBCHFQg83gc+ZB5Vtis4NdPaWyUqcejb7
 RtA7bXBAQxsCmM83UCqwI/z3YGE1L69TDON1QuVoZ157kj45iypGM4D
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Paul Cercueil <paul@crapouillou.net>

Change its name to iio_dma_buffer_usage(), as this function can be used
both for the .data_available and the .space_available callbacks.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
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
2.43.0


