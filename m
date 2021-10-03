Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B5842023A
	for <lists+linux-iio@lfdr.de>; Sun,  3 Oct 2021 17:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhJCPbI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Oct 2021 11:31:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231140AbhJCPbH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Oct 2021 11:31:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1FCB61A6E;
        Sun,  3 Oct 2021 15:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633274959;
        bh=nT+cRMXj5xw6AugnDASLt7gRyvT2J39h1vAF9RnEXPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VcJwsRinRjgCPBdgTF7MJwz2KAwe3ijeIZGqwc23ikntAyt2Kun1SIz6iHWEqzEhi
         v5MWQmjdFAVDGyE7gUWtGnCcuNPBv6kCf9L8LoDkO0INhETn+12JhNv403npr5yCuP
         2ANxvqEAjNJC3eOj1UDL+NnEd8STCrs/H8hem9zvh6BAuDjJcoZ9I/Avrt9B7kGEnK
         HhMN5LDgG1PEOmhyhNc67K+0Bpgcu+FJQsKH3t57lpmEsmBY30sdnYrnTPkTU+5Kza
         +v75z6b+Ey3fL9toSt2e+KuAWl7vp+hwMlIiNaqFkS687JAB8+X2tuQDdbhOALsguX
         o50fkztR1VpPw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 06/11] iio: inkern: Bring includes up to date.
Date:   Sun,  3 Oct 2021 16:33:01 +0100
Message-Id: <20211003153306.391766-7-jic23@kernel.org>
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
 drivers/iio/inkern.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 72c130d9fecb..2b478261f9a2 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -3,11 +3,16 @@
  *
  * Copyright (c) 2011 Jonathan Cameron
  */
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/export.h>
-#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/math64.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/printk.h>
+#include <linux/slab.h>
+#include <linux/string.h>
 
 #include <linux/iio/iio.h>
 #include "iio_core.h"
-- 
2.33.0

