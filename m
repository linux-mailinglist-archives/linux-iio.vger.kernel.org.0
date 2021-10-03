Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0E442023F
	for <lists+linux-iio@lfdr.de>; Sun,  3 Oct 2021 17:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhJCPbM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Oct 2021 11:31:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231146AbhJCPbL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Oct 2021 11:31:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71DB461A38;
        Sun,  3 Oct 2021 15:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633274964;
        bh=yEVNYgQwxw1a1ZsNy8jC366E+pV4t2dQS1OUGoGzW68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SFMZCOycOUJq8OKAE7H6uPy0SHD1Y2ksQrM3UhiwE7aEnSoi7ZKx6W4jQK3YJDZEV
         ee8crJNfPzKTbAZk+DZ2KSvoHaZR0EZnSiTS4Z3GijlAaavZ/tcdC8S5368BnVuyva
         qfJIgQDf+fO2U/uMJ2O3lzv41dh1tTI6KES5dXU3x+k0/k8c98pddtVV1jKQtASxxh
         88MuuXxBNWZ3AhqmfGlPVhlVVRZhYY9krYK9ejrXSJo6FcFpy3ideckx45wjCnepTK
         vr5oxprwWDpIQhpF0KMnm6drv/nZjj9EuOCYFqoHYvLeKuElx9FngKlVggKttzMEvi
         0JAese9igQUUw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 09/11] iio: industrialio-triggered-buffer: Bring includes up to date.
Date:   Sun,  3 Oct 2021 16:33:04 +0100
Message-Id: <20211003153306.391766-10-jic23@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211003153306.391766-1-jic23@kernel.org>
References: <20211003153306.391766-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Based on manual inspection of the suggestions made by the
include-what-you-use tool.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/buffer/industrialio-triggered-buffer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
index f77c4538141e..c1c445853c66 100644
--- a/drivers/iio/buffer/industrialio-triggered-buffer.c
+++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
@@ -4,8 +4,10 @@
  *  Author: Lars-Peter Clausen <lars@metafoo.de>
  */
 
-#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/err.h>
 #include <linux/export.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -14,6 +16,8 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 
+struct attribute;
+
 /**
  * iio_triggered_buffer_setup_ext() - Setup triggered buffer and pollfunc
  * @indio_dev:		IIO device structure
-- 
2.33.0

