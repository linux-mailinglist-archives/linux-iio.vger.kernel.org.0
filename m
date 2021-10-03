Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752D7420240
	for <lists+linux-iio@lfdr.de>; Sun,  3 Oct 2021 17:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhJCPbP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Oct 2021 11:31:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231143AbhJCPbN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Oct 2021 11:31:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBC9861A50;
        Sun,  3 Oct 2021 15:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633274965;
        bh=czuox0/gmxmJkyLJKVtkWvQGyyY3eldBxAu4qv/IydE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dbfAgs/KiSUh3g29Tgd7KoamthgIcPIz1PLzT+LQvf5naRayDGH5ezhSlkWdtX87/
         +trpw+Tc0ee/khewBdq6waIpfCTgrv+OcgcU/DaXEH9PU9eeucyE4akVeNnSw9bt/Z
         vIdBJM8JZVGXHZosDtmIRac7gHmkYQ2+NnDDtq8U2WLXQbMkS4WuEl5YNBFGnrYk2k
         8fvTH/OQpaM6u82Kd1kM7g5PO8C8gUy+B5KnHY6PmMa19WIBAJqY8Rx16NBdJei8Rm
         G+ephr6WXLFinJi8zTXWUf3DS2DV7uWhBP4czzmRn0xYdbibpynXnRojendgxLeiX/
         qfwQ4PZMc3TAQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 10/11] iio: industrialio-buffer-cb: Bring includes up to date.
Date:   Sun,  3 Oct 2021 16:33:05 +0100
Message-Id: <20211003153306.391766-11-jic23@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211003153306.391766-1-jic23@kernel.org>
References: <20211003153306.391766-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Based on manual inspection of the suggestions from the
include-what-you-use tool.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/buffer/industrialio-buffer-cb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-cb.c b/drivers/iio/buffer/industrialio-buffer-cb.c
index 4c12b7a94af5..3918176384c6 100644
--- a/drivers/iio/buffer/industrialio-buffer-cb.c
+++ b/drivers/iio/buffer/industrialio-buffer-cb.c
@@ -2,11 +2,14 @@
 /* The industrial I/O callback buffer
  */
 
+#include <linux/bitmap.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/export.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/err.h>
-#include <linux/export.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer_impl.h>
 #include <linux/iio/consumer.h>
-- 
2.33.0

