Return-Path: <linux-iio+bounces-27211-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6C8CD08DB
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 16:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FBA530EF5BE
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 15:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA02344053;
	Fri, 19 Dec 2025 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6KE+9xL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D22133A00C
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 15:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766158053; cv=none; b=ZJzHNbHncjti061fT+bnKKyrbOLxmWzyW4iJzrrr1D3lNbNXkM//V1USKJ3CeUE3gl7osrokTteDdqmwbFVuirRZ6q1Ze6DazYNI0miAGmaBJzGyZQUaCLct/9C9zsLoxfENLiKu+qn0/jEpbSas+n2iSCR15O61tqTvhjOno2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766158053; c=relaxed/simple;
	bh=7B9b4hCxFdQqUBqU1Za9w9/A3ZlUxdSGN+/kRKOVz/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pb6ExAd3pIaLINvtVbCk4K6p1gI0yMffmhJPkvlL1nX759BjrmOZliPbnunseg7qxsID2Kuf5W8GbQZzT48D+HBZsxKlgfrNcHQZTP0Tr5+L9IR1fdYrvXP+6xlhXiXIdONj20oalLjg+Hga0mAw8Ec/Io75acpFszDjsfMOBvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6KE+9xL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CC6CC116D0;
	Fri, 19 Dec 2025 15:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766158052;
	bh=7B9b4hCxFdQqUBqU1Za9w9/A3ZlUxdSGN+/kRKOVz/Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=W6KE+9xLAGjTAD2QiStob0YgdHf9qbcU5KudhsJ/pvDEeFu1cR7jUUNctGk98REwM
	 maWmKbfT4tUL/lIQJZh0uHEULEuycGLAgvNa3bEzRa1nSmXiGPazKztQQ/S0z/feHK
	 BWCZEW46VkQvHc7ETRi9QGE38DB/6JKCQH3X40h2WncuV1iRS0bUkhzY5j+3aqLSPR
	 fU0mD1XhZ3jdcQYtAOwvmGX4I2XcTFlAFtvAPuIxsl59sGULGVa0HP2uiG/mWGXSb5
	 cj/IQ+ojJPqfEnxVEsBsnJbWlXO2iQXl/uGC8s9IDIZLV1UmDzErQGZ0A5YaIyg9gE
	 YUVoo6wRpEXcQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13723D7878A;
	Fri, 19 Dec 2025 15:27:32 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 19 Dec 2025 15:28:14 +0000
Subject: [PATCH v2 3/6] iio: buffer-dma: Turn iio_dma_buffer_init() void
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251219-iio-dmabuf-improvs-v2-3-caa76de6e873@analog.com>
References: <20251219-iio-dmabuf-improvs-v2-0-caa76de6e873@analog.com>
In-Reply-To: <20251219-iio-dmabuf-improvs-v2-0-caa76de6e873@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766158092; l=2345;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=i2mR17oBuj0z0WQHcCbOUfOiriuyh4DEJuWWhy3zyw0=;
 b=5vk0DRlwJYEXk6O/qk1Ym1blSy2VQzmyc27nAAePAi4VOf/m8j8M846eR9o/RRXhOFoMxyN/F
 DVWk4S0SQGmDa0v2D8sE585DHhJ5kRWwjspEffO/O+D6zvY14VHgAsV
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

iio_dma_buffer_init() always return 0. Therefore there's no point in
returning int.

While at it, fix a mismatch between the function declaration and definition
regarding the struct device (dma_dev != dev).

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dma.c | 6 ++----
 include/linux/iio/buffer-dma.h               | 4 ++--
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index 1f918a3e6b93..3ab1349f9ea5 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -820,8 +820,8 @@ EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_set_length, "IIO_DMA_BUFFER");
  * should refer to the device that will perform the DMA to ensure that
  * allocations are done from a memory region that can be accessed by the device.
  */
-int iio_dma_buffer_init(struct iio_dma_buffer_queue *queue,
-	struct device *dev, const struct iio_dma_buffer_ops *ops)
+void iio_dma_buffer_init(struct iio_dma_buffer_queue *queue, struct device *dev,
+			 const struct iio_dma_buffer_ops *ops)
 {
 	iio_buffer_init(&queue->buffer);
 	queue->buffer.length = PAGE_SIZE;
@@ -833,8 +833,6 @@ int iio_dma_buffer_init(struct iio_dma_buffer_queue *queue,
 
 	mutex_init(&queue->lock);
 	spin_lock_init(&queue->list_lock);
-
-	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_init, "IIO_DMA_BUFFER");
 
diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
index 5eb66a399002..91f678e5be71 100644
--- a/include/linux/iio/buffer-dma.h
+++ b/include/linux/iio/buffer-dma.h
@@ -157,8 +157,8 @@ int iio_dma_buffer_set_bytes_per_datum(struct iio_buffer *buffer, size_t bpd);
 int iio_dma_buffer_set_length(struct iio_buffer *buffer, unsigned int length);
 int iio_dma_buffer_request_update(struct iio_buffer *buffer);
 
-int iio_dma_buffer_init(struct iio_dma_buffer_queue *queue,
-	struct device *dma_dev, const struct iio_dma_buffer_ops *ops);
+void iio_dma_buffer_init(struct iio_dma_buffer_queue *queue, struct device *dev,
+			 const struct iio_dma_buffer_ops *ops);
 void iio_dma_buffer_exit(struct iio_dma_buffer_queue *queue);
 void iio_dma_buffer_release(struct iio_dma_buffer_queue *queue);
 

-- 
2.52.0



