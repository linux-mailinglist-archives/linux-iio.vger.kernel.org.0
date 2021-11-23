Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE3045ADED
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbhKWVJi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:09:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:40074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239354AbhKWVJg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:09:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0953E60FD8;
        Tue, 23 Nov 2021 21:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701587;
        bh=cWgAewwcG7AwiJvlgOKZku80b7MUw4/ViBFgjtFT0Zk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pOk66eL568ywg0xpuD83hm+DTlMr5/BqTk17MGYbAet0oceCkZSBAp0zPC85QzmIJ
         DYr8omtVCwEPOK5NPtvxapk/ULs/V3SBj1Tsj9MibSfA0g4T6S/b784SouNWW3kAAQ
         VDx7UrP8rwWS2e98rfVeeLSqXZkj7Vug2Nhhg35MdWYlJWwX8SzdMVe/9IuP9hdLAi
         s52xdx/hKfbs5jkpVEgoBUEZOA1nI1S6EWpEIL0LuuWA92RRvz9nnQrV1peWZI0ay3
         dKai7VdItumm4Wpk4eR71fyuGPHBjeRepqOAyWgtOSIXhMxrHUwYdJJaUVHWm++z3z
         tYieiLHhFybEQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 19/49] iio:adc:twl6030: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:09:49 +0000
Message-Id: <20211123211019.2271440-20-jic23@kernel.org>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123211019.2271440-1-jic23@kernel.org>
References: <20211123211019.2271440-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM_SLEEP support is simpler and less error prone than the
use of ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

The pm_ptr() macro only removes the reference if CONFIG_PM is not
set. It is possible for CONFIG_PM=y without CONFIG_SLEEP, so this
will not always remove the pm_ops structure.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/twl6030-gpadc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index afdb59e0b526..cf8e4ed749d1 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -944,8 +944,7 @@ static int twl6030_gpadc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int twl6030_gpadc_suspend(struct device *pdev)
+static __maybe_unused int twl6030_gpadc_suspend(struct device *pdev)
 {
 	int ret;
 
@@ -957,7 +956,7 @@ static int twl6030_gpadc_suspend(struct device *pdev)
 	return 0;
 };
 
-static int twl6030_gpadc_resume(struct device *pdev)
+static __maybe_unused int twl6030_gpadc_resume(struct device *pdev)
 {
 	int ret;
 
@@ -968,7 +967,6 @@ static int twl6030_gpadc_resume(struct device *pdev)
 
 	return 0;
 };
-#endif
 
 static SIMPLE_DEV_PM_OPS(twl6030_gpadc_pm_ops, twl6030_gpadc_suspend,
 					twl6030_gpadc_resume);
@@ -978,7 +976,7 @@ static struct platform_driver twl6030_gpadc_driver = {
 	.remove		= twl6030_gpadc_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
-		.pm	= &twl6030_gpadc_pm_ops,
+		.pm	= pm_ptr(&twl6030_gpadc_pm_ops),
 		.of_match_table = of_twl6030_match_tbl,
 	},
 };
-- 
2.34.0

