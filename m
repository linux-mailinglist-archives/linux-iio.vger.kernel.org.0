Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E256A420241
	for <lists+linux-iio@lfdr.de>; Sun,  3 Oct 2021 17:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhJCPbQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Oct 2021 11:31:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231146AbhJCPbO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Oct 2021 11:31:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51D2161A4F;
        Sun,  3 Oct 2021 15:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633274967;
        bh=z6hCbftCu31mLWu+lXRkbD6/zGsZjf1CcFBpcGFhZjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uocifEoN1VO1OwHV4D0/ibDZD8GWByVYJuKqfjU9LaQiYINyzjn65Wg4InIPYaZzr
         tOI+ScMOjSNKr2fdWast4KhOJODAUlT/vLwvPkvx8WvkgI8p82UZweC9+Cjkz92xuv
         fpFhaoC1vIsutNC0qLSNHyzbjjCSfCi9heY3lJJFEsr3qjGvtGhwpD6haPUaoq1V7a
         D934aaurkKDb45182Wnr8WKfcldnu/79OTg8iDOfX0r1Jo2yA6PsDf/zV/MZKc3zSE
         I4o5xZX9lx1Rk2ebgP4W5XWnCXYocivRS2/8IIdn37Jyr9yRkRgmTOkItYYy30BPiV
         vsBYAvNQHB5tg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 11/11] iio: kfifo-buf.c: Bring includes up to date.
Date:   Sun,  3 Oct 2021 16:33:06 +0100
Message-Id: <20211003153306.391766-12-jic23@kernel.org>
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
 drivers/iio/buffer/kfifo_buf.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
index 516eb3465de1..9564fcbb8979 100644
--- a/drivers/iio/buffer/kfifo_buf.c
+++ b/drivers/iio/buffer/kfifo_buf.c
@@ -1,17 +1,20 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#include <linux/slab.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/device.h>
-#include <linux/workqueue.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
 #include <linux/kfifo.h>
+#include <linux/log2.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/slab.h>
+
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/buffer_impl.h>
-#include <linux/sched.h>
-#include <linux/poll.h>
+
+struct attribute;
 
 struct iio_kfifo {
 	struct iio_buffer buffer;
-- 
2.33.0

