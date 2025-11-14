Return-Path: <linux-iio+bounces-26205-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39284C5C14B
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 09:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54A394EBA87
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 08:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0787D2FE045;
	Fri, 14 Nov 2025 08:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Uc7eAAzP"
X-Original-To: linux-iio@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82731A9FBC;
	Fri, 14 Nov 2025 08:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763110089; cv=none; b=rrWurlRQc3HNsgXtfcxcVlNKxGShFVH6pDX/T9/4l+99e5xWchjolSZcAcoQFMXIBOHHADv+urdw0flC5NJYKmZJcpQ6NBrtio2uMB2eqw3fRKDdxxToSsjC8HQW4eNp/TCBh2pSf94EIk9MUVnuFnx77Tbf6Ja3JYbwpcKMQB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763110089; c=relaxed/simple;
	bh=dEziql4Dj/1OJKBGECLQ1wtAZONm3OcV7ZvHomS47+4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m3Viwx58DbrVMlMd2cNymP5CdOM+U2wCKcXyTaFJ9ROkFxsf84Dw0MRKNm0ZILWuS0iUzG9z6iCXJX9fIv4cz9GVilEGRcnUkuG+T5oGAn8jlM4pbhbNIieUH6F+UE8fwQSvfvl9gbtXOoOyy8eLpwGZoz8C6V8K787L5y0+i9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Uc7eAAzP; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=kG
	j1jOLKRHkqe9IdEN54mdaPhxebafdU0MNUN/iAJPI=; b=Uc7eAAzP5AAD5rxlX8
	G/Nlggx4Wifsu7fo98xRm7yfGTMS8ng6lmPqZHbcjnbel5g4LnCAGxdVjmLKs3vg
	d9CTHmO805fq4Eg8aWOIoX2nQ7LJo2fFdy/IbdOz3wukqoUah0mdltzMGsJid30R
	+9oh5+/4/tCmc/o15VhoOzkRU=
Received: from hello.company.local (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCn0fmq7BZpW6JRDw--.43279S2;
	Fri, 14 Nov 2025 16:47:39 +0800 (CST)
From: Liang Jie <buaajxlj@163.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: liangjie@lixiang.com,
	fanggeng@lixiang.com,
	yangchen11@lixiang.com
Subject: [PATCH] iio: buffer: use dma_buf_unmap_attachment_unlocked() helper
Date: Fri, 14 Nov 2025 16:47:25 +0800
Message-Id: <20251114084725.2079196-1-buaajxlj@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgCn0fmq7BZpW6JRDw--.43279S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrtr1fJw18JF18KFW5WryrtFb_yoW8JF1fpr
	4agw4jyr9rtanFq3WUC3yYqFyYvanYg348uFWkZa43ZF45Xrn2gr17tr1xZr13GrZrAana
	vasFkr4rWF17AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: pexdtyx0omqiywtou0bp/1tbioAQGIGkW6CBtSwAAsT

From: Liang Jie <liangjie@lixiang.com>

Replace open-coded dma_resv_lock()/dma_resv_unlock() around
dma_buf_unmap_attachment() in iio_buffer_dmabuf_release() with the
dma_buf_unmap_attachment_unlocked() helper.

This aligns with the standard DMA-BUF API, avoids duplicating
locking logic and eases future maintenance. No functional change.

Reviewed-by: fanggeng <fanggeng@lixiang.com>
Signed-off-by: Liang Jie <liangjie@lixiang.com>
---
 drivers/iio/industrialio-buffer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index a80f7cc25a27..58330abbf40a 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1563,9 +1563,7 @@ static void iio_buffer_dmabuf_release(struct kref *ref)
 	struct iio_buffer *buffer = priv->buffer;
 	struct dma_buf *dmabuf = attach->dmabuf;
 
-	dma_resv_lock(dmabuf->resv, NULL);
-	dma_buf_unmap_attachment(attach, priv->sgt, priv->dir);
-	dma_resv_unlock(dmabuf->resv);
+	dma_buf_unmap_attachment_unlocked(attach, priv->sgt, priv->dir);
 
 	buffer->access->detach_dmabuf(buffer, priv->block);
 
-- 
2.25.1


