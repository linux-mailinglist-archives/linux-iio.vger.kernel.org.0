Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F74482B30
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbiABMvo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:51:44 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50486 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiABMvl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:51:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 899F4B80CFC
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BD1C36AEF;
        Sun,  2 Jan 2022 12:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127899;
        bh=eIs1J8MT69pQSI5JTRfa0fp9eweSLFmIgygPNXSUiSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YSk9+REouxsD1irFj3FaVNyaNweJKP2uYkkS5JIVbZPPb/MqjHoAv6DNNQZ1FARKP
         6ybfQYQkC6+wJlaBs4GcvYElPUGQC+8klPxEXgbYgzqqo0jeuvy/HDqAPMxctmhSt3
         D5oH3Ke0CkfZ8PW3pOi1cjqnP17Mf++as0S1nwiBL6I9PRTitA9OcoGNtxBvjPmdH3
         tF5ZVxv+Vws7uOu9n34Qhv0gzrbWlzzRdSdZmvFJl42Iny4JSaMexwRVDC2RDHW7he
         w5DutZMSBNlKNqwqrT5rZxfPqdoWhds0mQm2Fz/BejsPZXzTe8lwE4J5xfuI0b2bVW
         bcSbbKrPO9meA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH v2 17/51] iio:adc:rockchip: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:55:43 +0000
Message-Id: <20220102125617.1259804-18-jic23@kernel.org>
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
Cc: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 drivers/iio/adc/rockchip_saradc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 14b8df4ca9c8..62315df14873 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -481,7 +481,6 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	return devm_iio_device_register(&pdev->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int rockchip_saradc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
@@ -514,9 +513,8 @@ static int rockchip_saradc_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(rockchip_saradc_pm_ops,
+DEFINE_SIMPLE_DEV_PM_OPS(rockchip_saradc_pm_ops,
 			 rockchip_saradc_suspend, rockchip_saradc_resume);
 
 static struct platform_driver rockchip_saradc_driver = {
@@ -524,7 +522,7 @@ static struct platform_driver rockchip_saradc_driver = {
 	.driver		= {
 		.name	= "rockchip-saradc",
 		.of_match_table = rockchip_saradc_match,
-		.pm	= &rockchip_saradc_pm_ops,
+		.pm	= pm_sleep_ptr(&rockchip_saradc_pm_ops),
 	},
 };
 
-- 
2.34.1

