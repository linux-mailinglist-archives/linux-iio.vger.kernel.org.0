Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051A5482B31
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiABMvp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbiABMvn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:51:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1531C061574
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 04:51:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61CB660E98
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11FAC36AEE;
        Sun,  2 Jan 2022 12:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127901;
        bh=uepRjTFk3uHk6O1UwSyI6dErEOVeIPmlsNZ8aL10gmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=psxQ/WVipRERBtQK7FBoaJ4wzDL62Dv+cjx7gKP4mMv9OMUpcQpwtJQURv62t9r01
         DWdMaj1yK9K3XqSNfEqXzW3WZcgjIKHxu75zhKeJ0hJbHvBE2fyhcYBE1zB+GpmFwr
         FKujQTyhIvh4v9RnD/3Lnc+AHeUkFo5YCJLowVbkAT6rVQy5Ri7MBf7tlO0isXBMO+
         pNTJ+IXhZHg/sI/LvjQPmSou+w3vd6LqG57v/DzRtKDnQVhgw4O4MJ8+Vl45bNfBaG
         qaQBymFg6eVdM658mNZ72Cbg9F5WRUeSBTFj1XTM8r+WVQgTVnBSXocR+JlPesevfu
         CgjvJz0eizHPQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 18/51] iio:adc:twl6030: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:55:44 +0000
Message-Id: <20220102125617.1259804-19-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220102125617.1259804-1-jic23@kernel.org>
References: <20220102125617.1259804-1-jic23@kernel.org>
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
index afdb59e0b526..a7cf41c82b46 100644
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
+DEFINE_SIMPLE_DEV_PM_OPS(twl6030_gpadc_pm_ops, twl6030_gpadc_suspend,
+			 twl6030_gpadc_resume);
 
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
2.34.1

