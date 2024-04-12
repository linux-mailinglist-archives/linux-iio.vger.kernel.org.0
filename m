Return-Path: <linux-iio+bounces-4201-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755BE8A2F89
	for <lists+linux-iio@lfdr.de>; Fri, 12 Apr 2024 15:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A19283C3A
	for <lists+linux-iio@lfdr.de>; Fri, 12 Apr 2024 13:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6CA84A48;
	Fri, 12 Apr 2024 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiHS1t7P"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7B683CD1;
	Fri, 12 Apr 2024 13:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928971; cv=none; b=BcfMdILVmB+UfURiLJ9J+L3RgGvbhYEncvv0HmQhASaX9OOH0IPmYbEQqB7qnQvb/6aI4NRdj/dGQG6kHDkL2fbXGDnQreZXCAoqeIocvC+xa/ImmAA438HbAf4CS2pQQQENxOqyh3n5RkL4oMeaSHHd7FSFZD7GFV2hxj2SyXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928971; c=relaxed/simple;
	bh=jtWg8M8oBbqnXFzik8mA6YCbft27rWjssLwcIHaHxe4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S9MTOanMuE9BTaqC14Z3C6+3vzpknT87DG/WkaXrqn79cFsIg1qK00KBPsZI4jT+xLmve2S+CPr6SsOC9DqxtqXFShANHjiKD3Ni1YtCKV1v3uiD9BAQXAORXpWrDHIYocKT3enq8eY0DnNToLMyiDCFR2X+7t0l88mPix1SpvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiHS1t7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B86FC32781;
	Fri, 12 Apr 2024 13:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712928970;
	bh=jtWg8M8oBbqnXFzik8mA6YCbft27rWjssLwcIHaHxe4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kiHS1t7PhuQx0MMqJMj8e4iEI+DX7p7ofXA8ad5MdbxrtvkRH1ouibJKVikNtzSDJ
	 h56pns0CB+iqHSqEkC4vhASD/sTOqJ4NaBFg2N7JjHi327p9gw4LfIPgaCZ8oDMFoh
	 NyRqcxFlT38Pvw8334pzjwEs0KNk1lzAWKHEfDAShSkms+pZsm6I4TPoPrjp+gEVWp
	 h6smMq2dCexJ+4e6Gy26mV+Xyevk2AW+PLned3p7B6Q+5R9YS8Qrl4on9TnVzkriwt
	 K6v1zujnir8JCy2R3TId/qmknNC4yf6WumYtpOw/f3s/fatJxXdjWSDJ+GUAkDkmQ5
	 yxEcBZwWM/y/A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AEBC04FFE;
	Fri, 12 Apr 2024 13:36:10 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 12 Apr 2024 15:36:09 +0200
Subject: [PATCH v3 02/10] iio: buffer-dma: Rename
 iio_dma_buffer_data_available()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-iio-backend-axi-dac-v3-2-3e9d4c5201fb@analog.com>
References: <20240412-iio-backend-axi-dac-v3-0-3e9d4c5201fb@analog.com>
In-Reply-To: <20240412-iio-backend-axi-dac-v3-0-3e9d4c5201fb@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Dragos Bogdan <dragos.bogdan@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Paul Cercueil <paul@crapouillou.net>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712928968; l=3299;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=w1+RpMARaI6i1g4Y9gmt3FBOrx2kCFVX2uygxUuqBiU=;
 b=ZpT92slj49iYbQ1JErM/ACcAhZ4cJlHPEkU7+TK9M9Sr/k0eozKaZGCsGoS2X7gW/q5BRdvzi
 1JxWKnM1UkpBC4Y6IbTzoeNoWW5yCCsS4gvjhRIZZ/Dpa9tTliDlqsS
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
index 5610ba67925ef..404f9867bdc57 100644
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
index 97f3116566f58..df05d66afff90 100644
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
index 18d3702fa95d1..52a838ec0e575 100644
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



