Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BEB460956
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 20:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245660AbhK1T1T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 14:27:19 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47816 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357682AbhK1TZT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 14:25:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C11186111C
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 19:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDDDC53FC1;
        Sun, 28 Nov 2021 19:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638127322;
        bh=196Wgt40++SrhHDRfSpe9mUMcSk+a71gds5CrvfTnFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RfHtV01bCdYlrOyPS7vL2xSH+jRb9vUIP5Ig0I67UcY0ThjlOuiIy7j6wT8juGgL2
         dVnTeefqb5//A5pdTQ0uuBankiCKshcBzq2A8S+rQpemkafdFbs8bwUK9RoGg1IvMn
         0qsZGt2wggEcOfaDcjTughfMFYwg9p5sjwc0xQka6FY4s09GyyjUcxn2tVAHSrK8UD
         YSFGVnDoYlUh4agO9A3woGMG3eOp9vWgguA4n9pI07pegzF3IiOrhilMGcvMiL7t3Q
         h3dtaLLRHHGcisQPCeQFEKBYn+kenGEYLEqYYTjSX3ubimw+otgQcsOmLF2uIxNqxL
         urcrVyEixNMFA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH 10/12] iio:adc:envelope-detector: Switch from of headers to mod_devicetable.h
Date:   Sun, 28 Nov 2021 19:26:33 +0000
Message-Id: <20211128192635.2724359-11-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211128192635.2724359-1-jic23@kernel.org>
References: <20211128192635.2724359-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

There is nothing directly using of specific interfces in this driver,
so lets not include the headers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Peter Rosin <peda@axentia.se>
---
 drivers/iio/adc/envelope-detector.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/envelope-detector.c b/drivers/iio/adc/envelope-detector.c
index d73eac36153f..e911c25d106d 100644
--- a/drivers/iio/adc/envelope-detector.c
+++ b/drivers/iio/adc/envelope-detector.c
@@ -31,14 +31,13 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
 #include <linux/iio/consumer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
-- 
2.34.1

