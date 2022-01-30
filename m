Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F874A388D
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355903AbiA3T0G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:26:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51526 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355898AbiA3T0F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:26:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32C3EB8290B
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:26:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B33C340EF;
        Sun, 30 Jan 2022 19:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570762;
        bh=Tb7eRhMo5tuD5O7j9YOQjj6ILOlAiUJXJoOGyjlnU7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tm4iReUnjaCLQSY1r6I8VKhhpEKYL7BL9IdCZTuBcUT0iya/3JPlt3xfJy/ZZCInQ
         Eimg8UluemUEbJx/gOvVp85RsEIdn6vJJhcmscYHKv6oTqaDUvkXgpMP838uQF1T5m
         9BIOcYjKJdJk+SaEP5qRF6V96XKJyrF646zRfR4WeaytOa6k3qi77JvPl6f068eBMU
         ioFk6hLAZ6TV2jTldKqwORLRfRtDu+ds82t2xDZU5J50DS13XCh1kKELiQ6j7VuNM+
         mEozVt/55rLxxy/u0lnOql6gqTNXA1PmMnGFFZoevy02OpZ5gqdvgopNuu31a52Fwk
         zmHcdHkpPr+GQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH v3 13/50] iio:adc:rockchip: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:10 +0000
Message-Id: <20220130193147.279148-14-jic23@kernel.org>
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
Cc: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 drivers/iio/adc/rockchip_saradc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 14b8df4ca9c8..b87ea7148b58 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -481,7 +481,6 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	return devm_iio_device_register(&pdev->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int rockchip_saradc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
@@ -514,17 +513,17 @@ static int rockchip_saradc_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(rockchip_saradc_pm_ops,
-			 rockchip_saradc_suspend, rockchip_saradc_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(rockchip_saradc_pm_ops,
+				rockchip_saradc_suspend,
+				rockchip_saradc_resume);
 
 static struct platform_driver rockchip_saradc_driver = {
 	.probe		= rockchip_saradc_probe,
 	.driver		= {
 		.name	= "rockchip-saradc",
 		.of_match_table = rockchip_saradc_match,
-		.pm	= &rockchip_saradc_pm_ops,
+		.pm	= pm_sleep_ptr(&rockchip_saradc_pm_ops),
 	},
 };
 
-- 
2.35.1

