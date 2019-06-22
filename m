Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 535804F658
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 16:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfFVO56 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 10:57:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfFVO55 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 10:57:57 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 953232089C;
        Sat, 22 Jun 2019 14:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561215476;
        bh=lb3BkFhjUonYFKMNhQz7op9ASdv0NGP/5KvOd4vk5Rs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ouvpHVJbvVp/GP0msSE22pi+Y/ULULpSfjALiEaRKoAXqqQdF6nEQ2DJLMq7vdkj/
         gOT6ScG8gQPYA3ln1CrXgRQk4gMVB+UTeV2c991t5OUuY/VbBZ14czYcg93qX9iNpv
         6PXkazAUCKMHqEnUY3qSn2LPmRMjmuCLwbx/e+FE=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Daniel Baluta <daniel.baluta@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 07/14] iio: buffer-cb: SPDX headers
Date:   Sat, 22 Jun 2019 15:55:09 +0100
Message-Id: <20190622145516.3231-8-jic23@kernel.org>
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

Another simple GPL v2 only.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/buffer/industrialio-buffer-cb.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-cb.c b/drivers/iio/buffer/industrialio-buffer-cb.c
index df21e7dbec40..1628ba36515c 100644
--- a/drivers/iio/buffer/industrialio-buffer-cb.c
+++ b/drivers/iio/buffer/industrialio-buffer-cb.c
@@ -1,8 +1,6 @@
-/* The industrial I/O callback buffer
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The industrial I/O callback buffer
  */
 
 #include <linux/kernel.h>
-- 
2.22.0

