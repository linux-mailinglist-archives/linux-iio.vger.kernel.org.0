Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99FD819129B
	for <lists+linux-iio@lfdr.de>; Tue, 24 Mar 2020 15:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgCXOQx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Mar 2020 10:16:53 -0400
Received: from www381.your-server.de ([78.46.137.84]:40612 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgCXOQx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Mar 2020 10:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wTBFHS+Jk4fBHV3cIsPOdwS4G9d6edQADozpLSR69aE=; b=RkSaO/7R3AU1lyqqPZpmwTX4NQ
        q3jYq2AcZgsprolrFJv8+nzP2B0atPvfpvtxL39jO4HAYDhEFiJwIOUucnxiqPDG9eF/dvkszDTnW
        c0oBNBokjuubvgo/8WanXda2H9KvRevjR6PqojS2xmJO3IuyA/HDO7Pl59zxJqiy/FKw+iHKkY89K
        +XUPmLg+D3GfaxPJPdNO14gyPX4zpti0LkNx5KwTzzQcqIZYIN6VdmgQPlmF9DVT8xx5T2IzOBsc1
        EPi1go7gdke+K207dMh/hvl8M/MwzBnKyheX10t7Z0o1gmab2KDZzN4/VVdi9RilvjP18EI3bo2wl
        S8hG7/Gg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jGkMM-0005Nd-Oo; Tue, 24 Mar 2020 15:16:50 +0100
Received: from [82.135.78.113] (helo=lars-desktop.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jGkMM-000Uv9-Fp; Tue, 24 Mar 2020 15:16:50 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: dma-buffer: Cleanup buffer.h/buffer_impl.h includes
Date:   Tue, 24 Mar 2020 15:16:24 +0100
Message-Id: <20200324141624.30597-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25760/Mon Mar 23 14:12:45 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The IIO DMA buffer is a DMA buffer implementation. As such it should
include buffer_impl.h rather than buffer.h.

The include to buffer.h in buffer-dma.h should be buffer_impl.h so it has
access to the struct iio_buffer definition. The code currently only works
because all places that use buffer-dma.h include buffer_impl.h before it.

The include to buffer.h in industrialio-buffer-dma.c and
industrialio-buffer-dmaengine.c can be removed since those files don't
reference any of buffer consumer functions.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/buffer/industrialio-buffer-dma.c       | 1 -
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 1 -
 include/linux/iio/buffer-dma.h                     | 2 +-
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index a74bd9c0587c..d348af8b9705 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -12,7 +12,6 @@
 #include <linux/mutex.h>
 #include <linux/sched.h>
 #include <linux/poll.h>
-#include <linux/iio/buffer.h>
 #include <linux/iio/buffer_impl.h>
 #include <linux/iio/buffer-dma.h>
 #include <linux/dma-mapping.h>
diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index b129693af0fd..8b60dff527c8 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -14,7 +14,6 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-#include <linux/iio/buffer.h>
 #include <linux/iio/buffer_impl.h>
 #include <linux/iio/buffer-dma.h>
 #include <linux/iio/buffer-dmaengine.h>
diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
index 016d8a068353..ff15c61bf319 100644
--- a/include/linux/iio/buffer-dma.h
+++ b/include/linux/iio/buffer-dma.h
@@ -11,7 +11,7 @@
 #include <linux/kref.h>
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
-#include <linux/iio/buffer.h>
+#include <linux/iio/buffer_impl.h>
 
 struct iio_dma_buffer_queue;
 struct iio_dma_buffer_ops;
-- 
2.20.1

