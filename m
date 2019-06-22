Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1CB4F657
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 16:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfFVO54 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 10:57:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfFVO5z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 10:57:55 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E758E2087F;
        Sat, 22 Jun 2019 14:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561215475;
        bh=jsekFiH5uXWJl+OE0CYyg4F+9qQB9mAzShFEHGVUQaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yy2IJYvr0CncgSPFqnRXouTjd1Gxiou9rax3UpEDaTqKMrFUlik7+Ni1GjAaoV640
         stMPDHkNkydvpPLSQ/+AI0KBvpJyH/zFjeVeCy+MjnM1YqtIEUxiS5PAu5aPJazCw/
         XBQ/pEP5vAs84BW8EsMfft2LGbNnlpYGJdMZ/zFw=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Daniel Baluta <daniel.baluta@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 06/14] iio:buffer-dma: SPDX headers.
Date:   Sat, 22 Jun 2019 15:55:08 +0100
Message-Id: <20190622145516.3231-7-jic23@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190622145516.3231-1-jic23@kernel.org>
References: <20190622145516.3231-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

GPLv2 as clearly stated in prior headers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/buffer/industrialio-buffer-dma.c | 3 +--
 include/linux/iio/buffer-dma.h               | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index b32bf57910ca..debe0f6c44fb 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright 2013-2015 Analog Devices Inc.
  *  Author: Lars-Peter Clausen <lars@metafoo.de>
- *
- * Licensed under the GPL-2.
  */
 
 #include <linux/slab.h>
diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
index 67c75372b691..b0fa722d0ccf 100644
--- a/include/linux/iio/buffer-dma.h
+++ b/include/linux/iio/buffer-dma.h
@@ -1,8 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright 2013-2015 Analog Devices Inc.
  *  Author: Lars-Peter Clausen <lars@metafoo.de>
- *
- * Licensed under the GPL-2.
  */
 
 #ifndef __INDUSTRIALIO_DMA_BUFFER_H__
-- 
2.22.0

