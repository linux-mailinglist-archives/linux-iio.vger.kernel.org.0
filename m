Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F954506E0
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 15:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbhKOObp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Nov 2021 09:31:45 -0500
Received: from aposti.net ([89.234.176.197]:51560 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236598AbhKOOae (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Nov 2021 09:30:34 -0500
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
Subject: [PATCH 13/15] iio: core: Add support for cyclic buffers
Date:   Mon, 15 Nov 2021 14:22:41 +0000
Message-Id: <20211115142243.60605-2-paul@crapouillou.net>
In-Reply-To: <20211115142243.60605-1-paul@crapouillou.net>
References: <20211115141925.60164-1-paul@crapouillou.net>
 <20211115142243.60605-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Introduce a new flag IIO_BUFFER_DMABUF_CYCLIC in the "flags" field of
the iio_dmabuf uapi structure.

When set, the DMABUF enqueued with the enqueue ioctl will be endlessly
repeated on the TX output, until the buffer is disabled.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/iio/industrialio-buffer.c | 5 +++++
 include/uapi/linux/iio/buffer.h   | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 30910e6c2346..41bc51c88002 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1600,6 +1600,11 @@ static int iio_buffer_enqueue_dmabuf(struct iio_buffer *buffer,
 	if (dmabuf.flags & ~IIO_BUFFER_DMABUF_SUPPORTED_FLAGS)
 		return -EINVAL;
 
+	/* Cyclic flag is only supported on output buffers */
+	if ((dmabuf.flags & IIO_BUFFER_DMABUF_CYCLIC) &&
+	    buffer->direction != IIO_BUFFER_DIRECTION_OUT)
+		return -EINVAL;
+
 	return buffer->access->enqueue_dmabuf(buffer, &dmabuf);
 }
 
diff --git a/include/uapi/linux/iio/buffer.h b/include/uapi/linux/iio/buffer.h
index e4621b926262..2d541d038c02 100644
--- a/include/uapi/linux/iio/buffer.h
+++ b/include/uapi/linux/iio/buffer.h
@@ -7,7 +7,8 @@
 
 #include <linux/types.h>
 
-#define IIO_BUFFER_DMABUF_SUPPORTED_FLAGS	0x00000000
+#define IIO_BUFFER_DMABUF_CYCLIC		(1 << 0)
+#define IIO_BUFFER_DMABUF_SUPPORTED_FLAGS	0x00000001
 
 /**
  * struct iio_dmabuf_alloc_req - Descriptor for allocating IIO DMABUFs
-- 
2.33.0

