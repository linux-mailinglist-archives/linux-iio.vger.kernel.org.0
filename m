Return-Path: <linux-iio+bounces-16155-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 373E9A48A38
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 22:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE73716704A
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 21:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABB8225A50;
	Thu, 27 Feb 2025 21:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="etHdWh0w"
X-Original-To: linux-iio@vger.kernel.org
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D32E1A9B2A;
	Thu, 27 Feb 2025 21:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740690173; cv=none; b=PfmEV+XsTi8VUS1ZzIcyhKYQJd9weFYCqsHfe51BtjhLvtYmXvYbsrBO07iikYCqyP9Ss7L86zxVpNjUTRlkuCA9dnUFt56RPOGcUOWejV3MJpEq7k0ZvhLniqjfbHObx/qzZUrSGHMdJlhnTT+RbtzTMNRZPZdz4d6MaVkEqeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740690173; c=relaxed/simple;
	bh=6NYlHZ4xc25oN3QPeOzW7hvvodzJe/fumzzfcMmfcPw=;
	h=Message-Id:Cc:To:From:Date:Subject; b=gEuhVk+QNFxS3BvpHGt55hmQ8n4vK2HhYfrb5X0FHE2TF1MbHSZkO+BShbLmCs2p1RK4/+LJRz5mZ/CfhjCFRBOHNK5g9+fdmMsT3Xrbu+vr/9pPfLZwi3fVnArKF4DsTfXHyyNwj6oCnSaweffau43I6rhy1D7o0sYz61pc07s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=etHdWh0w; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=Subject:Date:From:To:Cc:Message-Id:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References;
	bh=ct8SrB60d6zDrIGtD5NcucoiPwJRvKTewfeK7626vSE=; b=etHdWh0wVNkty5DRaf7xhYUiZT
	BVcp/6G62MwKrAy6ofI/EcesilgaG1GMFVp+VkDSbZdS/FS+RuZx9+gY5wWLD+DMapgtbMRhgXDyp
	A1PbwADor6SrcoCKXkxP9Asj8xXknf6w+gA7MXHQMCtnBIRDe5nYpJ93JyrFRO6Z/jeQwETGUxkl7
	/60HNHQtGPkAF6HsATWJv0gtKFlySdhMSC6MZRQMvAyrBM1dvLkSK8sKYfEhXyotnJmt87CT7Ql/u
	ZSN5EsWq/pyd74K0oiukEGh9yYDW9aMjRIw1uFppTYQTdovMhLViliXL8dQeU6OrnaMVNy8GmshlG
	A4Ea7++Q==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1tnkhQ-0008jC-2c;
	Thu, 27 Feb 2025 21:41:41 +0100
Received: from [170.62.100.249] (helo=localhost)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1tnkhQ-0002zu-3D;
	Thu, 27 Feb 2025 21:41:40 +0100
Message-Id: <D83IPSTKYWNB.1PUBV1530XI86@folker-schwesinger.de>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Folker
 Schwesinger" <dev@folker-schwesinger.de>
To: "Jonathan Cameron" <jic23@kernel.org>, "Lars-Peter Clausen"
 <lars@metafoo.de>, "Nuno Sa" <nuno.sa@analog.com>, "Paul Cercueil"
 <paul@crapouillou.net>, "Peter Zijlstra" <peterz@infradead.org>
From: "Folker Schwesinger" <dev@folker-schwesinger.de>
Date: Thu, 27 Feb 2025 20:27:53 +0100
Subject: [PATCH] iio: buffer-dma: Fix docstrings
X-Authenticated-Sender: dev@folker-schwesinger.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27562/Thu Feb 27 10:48:50 2025)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>

Fix a typo in the docstring of iio_dma_buffer_read() and fix what looks
like a copy-and-paste error in the iio_dma_buffer_write() docstring.

Signed-off-by: Folker Schwesinger <dev@folker-schwesinger.de>
---
 drivers/iio/buffer/industrialio-buffer-dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index 7ea784304ffb..ee294a775e8a 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -624,7 +624,7 @@ static int iio_dma_buffer_io(struct iio_buffer *buffer, size_t n,
 
 /**
  * iio_dma_buffer_read() - DMA buffer read callback
- * @buffer: Buffer to read form
+ * @buffer: Buffer to read from
  * @n: Number of bytes to read
  * @user_buffer: Userspace buffer to copy the data to
  *
@@ -640,7 +640,7 @@ EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_read, "IIO_DMA_BUFFER");
 
 /**
  * iio_dma_buffer_write() - DMA buffer write callback
- * @buffer: Buffer to read form
+ * @buffer: Buffer to write to
  * @n: Number of bytes to read
  * @user_buffer: Userspace buffer to copy the data from
  *

base-commit: faeaa1ec6c63b6676679f321601471772f2a0c9b
-- 
2.48.1

