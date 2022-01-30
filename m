Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1857B4A388E
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355893AbiA3T0G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:26:06 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35944 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355902AbiA3T0F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:26:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36FC1612EC
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:26:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA09C340EB;
        Sun, 30 Jan 2022 19:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570764;
        bh=USCadHDM+7IU91kMVYE13fzetO10G9GsC7/DL+LdAGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YSf+6Y3ar8YV2uptBsIcy0IgoZORcZepQUOrMCUqEKGRAJ7Y9azHWCAw6JB52hyjp
         Stqd1t/bxUQJ3zj5gyk9T34ourkPRQexq+chFw6F9SlwzCXkvtG3TI+lTQvy9YV5PP
         f2c70vLzKs+nDoxWi2g/RKKMLFBxIagw2KItqrjcCYHwC6vYszhVy2tlbdoG8yWU32
         3h3KNPB/4sFWo7o6G38d58Ifbdd5hdVTVYWB/5ynJUskUVEtHIg9BcpMi6WFdIIntM
         JoNgW0jE5CZge6ZQXlc64vjMVrfxvOzRBdPBp1pRl1K8uPyuXsz+1CTI58iNW0d9jA
         zqo54JrJWfSaQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 14/50] iio:adc:twl6030: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:11 +0000
Message-Id: <20220130193147.279148-15-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220130193147.279148-1-jic23@kernel.org>
References: <20220130193147.279148-1-jic23@kernel.org>
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

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/twl6030-gpadc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index afdb59e0b526..4966997b5319 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -944,7 +944,6 @@ static int twl6030_gpadc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int twl6030_gpadc_suspend(struct device *pdev)
 {
 	int ret;
@@ -968,17 +967,16 @@ static int twl6030_gpadc_resume(struct device *pdev)
 
 	return 0;
 };
-#endif
 
-static SIMPLE_DEV_PM_OPS(twl6030_gpadc_pm_ops, twl6030_gpadc_suspend,
-					twl6030_gpadc_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(twl6030_gpadc_pm_ops, twl6030_gpadc_suspend,
+				twl6030_gpadc_resume);
 
 static struct platform_driver twl6030_gpadc_driver = {
 	.probe		= twl6030_gpadc_probe,
 	.remove		= twl6030_gpadc_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
-		.pm	= &twl6030_gpadc_pm_ops,
+		.pm	= pm_sleep_ptr(&twl6030_gpadc_pm_ops),
 		.of_match_table = of_twl6030_match_tbl,
 	},
 };
-- 
2.35.1

