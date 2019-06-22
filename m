Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 364D24F65B
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 16:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfFVO6A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 10:58:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfFVO6A (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 10:58:00 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07037208C3;
        Sat, 22 Jun 2019 14:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561215480;
        bh=6ONcomDlYjJApHPD4hTDvu0t0LcRkKO5jTYgIbLvoyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o+Q93BBZR77rMWaudQGjRZp4AtgwK37g1KwcWNxO4lmBrOdeazhAPXBMWk8/JzyCf
         QW7Qw3vPuDpaSqL9Ct0uLM60Fm3qoPm2XsD9IvKByE3ovIeSUufVMapiwNUaeUUv/c
         hk3hU1y9szd57YUHUaubyPyWgpPE6ih0Q7tDyWHg=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Daniel Baluta <daniel.baluta@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 09/14] iio: buffer-dmaengine: SPDX GPL-2.0+
Date:   Sat, 22 Jun 2019 15:55:11 +0100
Message-Id: <20190622145516.3231-10-jic23@kernel.org>
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

Clearly stated in existing headers so just convert to SDPX.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 3 +--
 include/linux/iio/buffer-dmaengine.h               | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 2b5a320f42c5..9a0a02e89e9b 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright 2014-2015 Analog Devices Inc.
  *  Author: Lars-Peter Clausen <lars@metafoo.de>
- *
- * Licensed under the GPL-2 or later.
  */
 
 #include <linux/slab.h>
diff --git a/include/linux/iio/buffer-dmaengine.h b/include/linux/iio/buffer-dmaengine.h
index 5dcddf427bb0..c7dbcd359213 100644
--- a/include/linux/iio/buffer-dmaengine.h
+++ b/include/linux/iio/buffer-dmaengine.h
@@ -1,8 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright 2014-2015 Analog Devices Inc.
  *  Author: Lars-Peter Clausen <lars@metafoo.de>
- *
- * Licensed under the GPL-2 or later.
  */
 
 #ifndef __IIO_DMAENGINE_H__
-- 
2.22.0

