Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C872468C35
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 17:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhLERAN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 12:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236066AbhLERAN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 12:00:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADADC061751
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 08:56:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1ACD61118
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 16:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D61C341C4;
        Sun,  5 Dec 2021 16:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638723405;
        bh=DlyfYhWLvYPTkZDcSPd/oH1gezrV6i78JawZCrMvv48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SnXcexSZJPeiIL2GUMNaropRTaA6S4+WXaKpbm0PofZ1Q1UhaNqEMhCpNYzCcma3x
         c/yNzU6FLhTxF5g+5EwQBWZRjMsPALQ4GdSEVHRb1yoEdSS39Vh73qk66mV8lk1VOw
         teA17C5DNqoQCRabhuumneiMe6r0ad5uhw5I6xbXSKdc1gzMy9/vj4/MfpMySLBRxz
         ixZtGa9w4S3GI9goHRr4S7ZHgXvsvT1SY0SAIwvTQBWu2knV43OQ/LgrSBn7zHUdpq
         YNp4g6oX2j2QPYI4fNqgVMFLbTQhmiSuE9DUVvu4ZEMydOyFchJGzfbY+dmv7QVF09
         UbvXp2n2z3LMg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 04/12] iio:dac:lpc18xx_dac: Swap from of* to mod_devicetable.h
Date:   Sun,  5 Dec 2021 17:01:32 +0000
Message-Id: <20211205170140.2783914-5-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205170140.2783914-1-jic23@kernel.org>
References: <20211205170140.2783914-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This driver never used anything from the of specific headers.
mod_devicetable.h provides the struct of_device_id definition.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/dac/lpc18xx_dac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/dac/lpc18xx_dac.c b/drivers/iio/dac/lpc18xx_dac.c
index 5502e4f62f0d..60467c6f2c6e 100644
--- a/drivers/iio/dac/lpc18xx_dac.c
+++ b/drivers/iio/dac/lpc18xx_dac.c
@@ -16,9 +16,8 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 
-- 
2.34.1

