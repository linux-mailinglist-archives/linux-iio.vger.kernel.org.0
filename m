Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44072420238
	for <lists+linux-iio@lfdr.de>; Sun,  3 Oct 2021 17:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhJCPbG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Oct 2021 11:31:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230512AbhJCPbE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Oct 2021 11:31:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D95B161A3A;
        Sun,  3 Oct 2021 15:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633274957;
        bh=uJ58o8qFdDr8bNKNq3id+E9+685neY3ERT2fvcpP3XA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qnxXneSgsAj8+orGmRmJ9/n8bCY9jPXcVQeGaD+E9imvhsEXoiKrtvjH0JuZY03qv
         sVSFWUuyUtrVnKQDGFHrwpPqYg9oF1G8vYySojPiFTbA/GD0gA8DxNwx/euOH6cZWv
         zw+FL/QkFy5zhWRUny2qvBWHAN13u9N/l9dKTHOhcAxio7CtDoG74Irbsq/Fn0Wpvp
         L0XmWAz4u5EKwYtLakG8PSbIqhhAqDbFgtGqxjFzt7XOp4L3jjyHMttIVeQ4WDoPBD
         bcsSYis8Ov8+bgZRj3UDvgaAXwmpA1SRyREC+LVQm4KuY1PuH6QDweRIWZRJHbsq9z
         sJQuSBKXQ2DAg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 04/11] iio: industrialio-event.c: Bring includes up to date.
Date:   Sun,  3 Oct 2021 16:32:59 +0100
Message-Id: <20211003153306.391766-5-jic23@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211003153306.391766-1-jic23@kernel.org>
References: <20211003153306.391766-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Partly as a result of moving code around in IIO and not keeping
includes updated.

Based on manual inspection of the output of
include-what-you-use

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-event.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 1d49714d9832..e807cb9d091d 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -7,14 +7,19 @@
  */
 
 #include <linux/anon_inodes.h>
+#include <linux/bitops.h>
 #include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/kfifo.h>
-#include <linux/module.h>
+#include <linux/kstrtox.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/poll.h>
-#include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 #include <linux/uaccess.h>
 #include <linux/wait.h>
 #include <linux/iio/iio.h>
-- 
2.33.0

