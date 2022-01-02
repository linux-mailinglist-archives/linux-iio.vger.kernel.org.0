Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072A0482B2C
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbiABMvb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiABMva (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:51:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76851C061574
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 04:51:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31472B80D62
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:51:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F14AC36AEF;
        Sun,  2 Jan 2022 12:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127887;
        bh=ataQ0/NG715KiJXcZnH0xXTgucOdo1SjJj0JC6r7EM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EeWQeW6o2hjZs5R99kyNJbrl7gkeHFqi+PgdTaxZMAV4ItSNEoNms13lXIAowQgw2
         rNoE645qksMNR1VyXOUmNCt4T0Nz/F2fcybxBCHL0XzepTr67mbvANImtCM6hxP6Ma
         Ub++uowO6JWwp9d+IsC6LleSJoPCyeGZxcvovLKGk8qITzvkzvINa/S5+eQwnxW56j
         mu8riUo3urVBvWqqKn8NlCFlk8+rovGhkb5n81+fnyWDzSB403wKM+lMY9mdsgzZVp
         Pqzz6PC8PEO26t0vYecaiFDfoe1md038BHfjSGtVz19+0nlWldIXFafZOgAlV6RUwi
         /VlFvT9oM4jpg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v2 13/51] iio:adc:exynos_adc: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
Date:   Sun,  2 Jan 2022 12:55:39 +0000
Message-Id: <20220102125617.1259804-14-jic23@kernel.org>
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
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/exynos_adc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 3b3868aa2533..166a6436e36f 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -968,7 +968,6 @@ static int exynos_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int exynos_adc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
@@ -1001,11 +1000,10 @@ static int exynos_adc_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(exynos_adc_pm_ops,
-			exynos_adc_suspend,
-			exynos_adc_resume);
+DEFINE_SIMPLE_DEV_PM_OPS(exynos_adc_pm_ops,
+			 exynos_adc_suspend,
+			 exynos_adc_resume);
 
 static struct platform_driver exynos_adc_driver = {
 	.probe		= exynos_adc_probe,
@@ -1013,7 +1011,7 @@ static struct platform_driver exynos_adc_driver = {
 	.driver		= {
 		.name	= "exynos-adc",
 		.of_match_table = exynos_adc_match,
-		.pm	= &exynos_adc_pm_ops,
+		.pm	= pm_sleep_ptr(&exynos_adc_pm_ops),
 	},
 };
 
-- 
2.34.1

