Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69F5420236
	for <lists+linux-iio@lfdr.de>; Sun,  3 Oct 2021 17:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhJCPbA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Oct 2021 11:31:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230504AbhJCPa7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Oct 2021 11:30:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DB6261A4F;
        Sun,  3 Oct 2021 15:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633274952;
        bh=VZK9z9167PNfRFzuwa0Kdi2vwBw0ycQNuXSvaGVPpuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F8FqABb68kvm7JUWRrtsh6zhcwQMpbssve+jyJ9ho7wHdRM/y/CKuOFw1NHPDedG0
         3JuM1YOBLtMJeNZ0CPjdtdWTYaWgkirsZCxq+q+/+om8F4VuH3ORtvAK3UrwF4QuTa
         5BwuERlR2X1XLIYPkF5Bvzq7UOV7yR1yFKiIC2ovbslVchoy65DGSp+CyWzQaXKiiT
         NGL+ZJ+/2DXrKZ2IXALJpMWAicSgp2V/2187J2+kfBsAhIW2rAy5mTXUv3KYgdDCs7
         ketBmFsfW3ZhLVxe7fbdFbzSUFf5DVEP5FPuKWAV4Yo+ss6zbgf+hTYChfem74DXoe
         ZmkMK6lnU/GNg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 01/11] iio: industrialio-core: Reorder header includes to be alphabetical.
Date:   Sun,  3 Oct 2021 16:32:56 +0100
Message-Id: <20211003153306.391766-2-jic23@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211003153306.391766-1-jic23@kernel.org>
References: <20211003153306.391766-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

All includes in alphabetical order, with the IIO specific headers in
a separate block.

Note this is a precursor to refining which headers are included.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-core.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 6afa70c89c80..d6c2875a832e 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -8,22 +8,23 @@
 
 #define pr_fmt(fmt) "iio-core: " fmt
 
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/idr.h>
-#include <linux/kdev_t.h>
-#include <linux/err.h>
+#include <linux/anon_inodes.h>
 #include <linux/device.h>
+#include <linux/cdev.h>
+#include <linux/debugfs.h>
+#include <linux/err.h>
 #include <linux/fs.h>
+#include <linux/idr.h>
+#include <linux/kdev_t.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/poll.h>
 #include <linux/property.h>
 #include <linux/sched.h>
-#include <linux/wait.h>
-#include <linux/cdev.h>
 #include <linux/slab.h>
-#include <linux/anon_inodes.h>
-#include <linux/debugfs.h>
-#include <linux/mutex.h>
+#include <linux/wait.h>
+
 #include <linux/iio/iio.h>
 #include "iio_core.h"
 #include "iio_core_trigger.h"
-- 
2.33.0

