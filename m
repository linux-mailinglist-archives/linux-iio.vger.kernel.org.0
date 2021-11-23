Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF0545ADE5
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbhKWVJ0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:09:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:39998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234973AbhKWVJ0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:09:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BE9460FE7;
        Tue, 23 Nov 2021 21:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701578;
        bh=GJVBgA70mX58usfy/Ia5w9bcNgzV/TmHXttWscaRBuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F7EqVKuvZItcOhz9A5hU6i+/MRwCknbjEpMA7YOeK9Hut1HLoM6akdVQuGnrZslq/
         R68PXI7tFFt/dWKk/eoAGkJ2iFlyylFWiI6uCIPhYpoMrglq+UCJXHHyyTnS3yIWZs
         jan9pr/FU424lTMfOOEA+5uItvOCz9NU2fUGTegIJPylUPxsx/Sw64rVvDV31e/ydb
         N1xUlKPyFjR4ZcLOqPR5VOnSrNnGjVBzBJ6BFW9ZH/GoDlBPTdVfSr2MM/PDsuKvPP
         QWqqlfFIiDvpuYWHg2UdqNL83twC48PbSn/IlWi9gXMzSz6ys4MChrVKKeujQT5wgn
         YvDpttSDFdGkw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 14/49] iio:adc:exynos_adc: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:09:44 +0000
Message-Id: <20211123211019.2271440-15-jic23@kernel.org>
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
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

The pm_ptr() macro only removes the reference if CONFIG_PM is not
set. It is possible for CONFIG_PM=y without CONFIG_SLEEP, so this
will not always remove the pm_ops structure.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/iio/adc/exynos_adc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 3b3868aa2533..01a801d325a9 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -968,8 +968,7 @@ static int exynos_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int exynos_adc_suspend(struct device *dev)
+static __maybe_unused int exynos_adc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct exynos_adc *info = iio_priv(indio_dev);
@@ -982,7 +981,7 @@ static int exynos_adc_suspend(struct device *dev)
 	return 0;
 }
 
-static int exynos_adc_resume(struct device *dev)
+static __maybe_unused int exynos_adc_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct exynos_adc *info = iio_priv(indio_dev);
@@ -1001,7 +1000,6 @@ static int exynos_adc_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(exynos_adc_pm_ops,
 			exynos_adc_suspend,
@@ -1013,7 +1011,7 @@ static struct platform_driver exynos_adc_driver = {
 	.driver		= {
 		.name	= "exynos-adc",
 		.of_match_table = exynos_adc_match,
-		.pm	= &exynos_adc_pm_ops,
+		.pm	= pm_ptr(&exynos_adc_pm_ops),
 	},
 };
 
-- 
2.34.0

