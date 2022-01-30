Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3894A388B
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355895AbiA3T0D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355893AbiA3T0C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:26:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C7FC061714
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 11:26:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BEDB3B829AA
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04259C340EF;
        Sun, 30 Jan 2022 19:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570758;
        bh=qr/QTUL36RyykG43Oqzt3hdy+RDjKKItR9LQpopDoeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J5YOn6aaEKu2b2TDYYoMJkbh9KgMeZbOOV9CmVovauCFeJtuvaxhFL6FmdqE4LUjn
         VJk3/6ZORbrIuovWSlp5DuVvCyGPvbsW/ZQ3vSyOGloCcAPIfohHUVnXlciCYSWGKg
         a2CYMKB+9rc4MeW6ECMZYIa51C3r+Qf+ICDVgqVpqxET74wLS8ukVmUVYWVTeo+Y8v
         IrFrT0o9UpVaTFuoSqmJPJog6ZK6e+wfkS9vx7iUBtYDi+KAyYIr05bBUmv/3E6Hy0
         G5Nh+jU6x2Hj1GYUHHxJGwrSG4C7SCHC/KZaW9dkwBL4Oxt3NJYVPqKB413/ggw/LU
         VMOp484yAFEDA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v3 11/50] iio:adc:exynos_adc: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
Date:   Sun, 30 Jan 2022 19:31:08 +0000
Message-Id: <20220130193147.279148-12-jic23@kernel.org>
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
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/exynos_adc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 3b3868aa2533..cff1ba57fb16 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -968,7 +968,6 @@ static int exynos_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int exynos_adc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
@@ -1001,11 +1000,9 @@ static int exynos_adc_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(exynos_adc_pm_ops,
-			exynos_adc_suspend,
-			exynos_adc_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(exynos_adc_pm_ops, exynos_adc_suspend,
+				exynos_adc_resume);
 
 static struct platform_driver exynos_adc_driver = {
 	.probe		= exynos_adc_probe,
@@ -1013,7 +1010,7 @@ static struct platform_driver exynos_adc_driver = {
 	.driver		= {
 		.name	= "exynos-adc",
 		.of_match_table = exynos_adc_match,
-		.pm	= &exynos_adc_pm_ops,
+		.pm	= pm_sleep_ptr(&exynos_adc_pm_ops),
 	},
 };
 
-- 
2.35.1

