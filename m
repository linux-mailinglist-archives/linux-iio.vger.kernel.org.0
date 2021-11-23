Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702F745ADEC
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239430AbhKWVJh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:09:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:40054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237964AbhKWVJe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:09:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFFC16023D;
        Tue, 23 Nov 2021 21:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701585;
        bh=5jWEHRBmoLS7XJAh5YmBDGscoU22UHiZj6sFthn0gTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I5X1H/iS3RIh2zFrb4qfSZihj8NNPIxlUW8SP0kku0GvUNWBQolEBwQQE7dFqtZ7A
         gqV6U8+21UrhwT+eOz00hShlpS1dt6KIgYMEPP2rp4Bch3I1NNNssFo9I2BXl8lwNz
         zpKl+8WW9iAVpwMTI3irnExguAJa7lhHJPzB75KJPshPgHmWlKVJSo3FwMeT+tqMEB
         eFK3VWSzNsgrgEIpwbwriccAo3gTXPg2b4FuvrCLoUIHPd6Qa+ld5crWwC7OG9yRvX
         ibxbXI26QuUotmt2tOW4vqQdiPUHf0frP8HAoPRvHcqeSlGAg01crbQL5jKx5/LMJZ
         uefkB1zMr+uUw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH 18/49] iio:adc:rockchip: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:09:48 +0000
Message-Id: <20211123211019.2271440-19-jic23@kernel.org>
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
Cc: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 drivers/iio/adc/rockchip_saradc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 14b8df4ca9c8..fb3b59d76a97 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -481,8 +481,7 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	return devm_iio_device_register(&pdev->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int rockchip_saradc_suspend(struct device *dev)
+static __maybe_unused int rockchip_saradc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct rockchip_saradc *info = iio_priv(indio_dev);
@@ -494,7 +493,7 @@ static int rockchip_saradc_suspend(struct device *dev)
 	return 0;
 }
 
-static int rockchip_saradc_resume(struct device *dev)
+static __maybe_unused int rockchip_saradc_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct rockchip_saradc *info = iio_priv(indio_dev);
@@ -514,7 +513,6 @@ static int rockchip_saradc_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(rockchip_saradc_pm_ops,
 			 rockchip_saradc_suspend, rockchip_saradc_resume);
@@ -524,7 +522,7 @@ static struct platform_driver rockchip_saradc_driver = {
 	.driver		= {
 		.name	= "rockchip-saradc",
 		.of_match_table = rockchip_saradc_match,
-		.pm	= &rockchip_saradc_pm_ops,
+		.pm	= pm_ptr(&rockchip_saradc_pm_ops),
 	},
 };
 
-- 
2.34.0

