Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58FA8482B2A
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbiABMvY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:51:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50320 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiABMvY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:51:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21172B80D61
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:51:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E6FC36AF0;
        Sun,  2 Jan 2022 12:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127881;
        bh=HbnEPVVgQ9Kvb7yZUMoAWMuzKm8i0gC/eDb9lq2ikvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j/X2JfQHInpluwmPBoweZ7cum0JR4VJbKyr0CLc2YJeQgKjdjFOhuEcE1qbw+vHoo
         AxFhzVRp8ThwIZaJUo5AA0NT0f1v0b6Vf5xVfV1xlCTK7nMCVKv2oyigAVl+Ysd7f3
         xNTsrKobhX9/0Y0bP/eXitlQ2atljBbXH3tgvbGswE/gFIHHfKe4qr8vw3Nm5Qgd4g
         LyyMYXC9RxvAuhBu+1TL5rDknCoRr2a3FbWGeyLVNzOuv9QiRU5GiRrtkvLVTBq9Mh
         3RXHTWMH1ljR7IOZsSj9Nh6UVy2eOb3x6ouvh4m/kaybT1HjLxPE+G0htr0ya7gu2P
         yPL5bu3ySO6FQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 11/51] iio:adc:ab8500: Switch from CONFIG_PM guards to pm_ptr() etc
Date:   Sun,  2 Jan 2022 12:55:37 +0000
Message-Id: <20220102125617.1259804-12-jic23@kernel.org>
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
without CONFIG_PM support is simpler and less error prone than the
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/adc/ab8500-gpadc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ab8500-gpadc.c b/drivers/iio/adc/ab8500-gpadc.c
index 4c46a201d4ef..e0b19e8221eb 100644
--- a/drivers/iio/adc/ab8500-gpadc.c
+++ b/drivers/iio/adc/ab8500-gpadc.c
@@ -942,7 +942,6 @@ static const struct iio_info ab8500_gpadc_info = {
 	.read_raw = ab8500_gpadc_read_raw,
 };
 
-#ifdef CONFIG_PM
 static int ab8500_gpadc_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
@@ -965,7 +964,6 @@ static int ab8500_gpadc_runtime_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
 /**
  * ab8500_gpadc_parse_channel() - process devicetree channel configuration
@@ -1200,11 +1198,9 @@ static int ab8500_gpadc_remove(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops ab8500_gpadc_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(ab8500_gpadc_runtime_suspend,
-			   ab8500_gpadc_runtime_resume,
-			   NULL)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	RUNTIME_PM_OPS(ab8500_gpadc_runtime_suspend,
+		       ab8500_gpadc_runtime_resume, NULL)
 };
 
 static struct platform_driver ab8500_gpadc_driver = {
@@ -1212,7 +1208,7 @@ static struct platform_driver ab8500_gpadc_driver = {
 	.remove = ab8500_gpadc_remove,
 	.driver = {
 		.name = "ab8500-gpadc",
-		.pm = &ab8500_gpadc_pm_ops,
+		.pm = pm_ptr(&ab8500_gpadc_pm_ops),
 	},
 };
 builtin_platform_driver(ab8500_gpadc_driver);
-- 
2.34.1

