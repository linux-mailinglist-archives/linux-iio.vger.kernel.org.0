Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732B44506A8
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 15:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhKOOZD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Nov 2021 09:25:03 -0500
Received: from aposti.net ([89.234.176.197]:51038 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232000AbhKOOYV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Nov 2021 09:24:21 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 02/15] iio: buffer-dma: Remove unused iio_buffer_block struct
Date:   Mon, 15 Nov 2021 14:19:12 +0000
Message-Id: <20211115141925.60164-3-paul@crapouillou.net>
In-Reply-To: <20211115141925.60164-1-paul@crapouillou.net>
References: <20211115141925.60164-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This structure was never used anywhere, so it can safely be dropped.

It will later be re-introduced as a different structure in a
different header.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 include/linux/iio/buffer-dma.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
index d4ed5ff39d44..a65a005c4a19 100644
--- a/include/linux/iio/buffer-dma.h
+++ b/include/linux/iio/buffer-dma.h
@@ -17,11 +17,6 @@ struct iio_dma_buffer_queue;
 struct iio_dma_buffer_ops;
 struct device;
 
-struct iio_buffer_block {
-	u32 size;
-	u32 bytes_used;
-};
-
 /**
  * enum iio_block_state - State of a struct iio_dma_buffer_block
  * @IIO_BLOCK_STATE_DEQUEUED: Block is not queued
-- 
2.33.0

