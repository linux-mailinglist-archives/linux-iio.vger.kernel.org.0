Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61A145ADE2
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbhKWVJU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:09:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:39948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234770AbhKWVJU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:09:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 587D161002;
        Tue, 23 Nov 2021 21:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701571;
        bh=zmcemhX4xrSn50Y56+iehhczcDkGUI+jtEy/bGqjrdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AJSpS7jzNYZADA/DY0/uh4mMLqoAFFIpXzKO7gyqhAmuIwiKYQ5h7PhqWuxeZ98tg
         m7lwbGwGnfQA1qRNbEToDW2A+1jSZISXe/+g34Uvki6azTtb38negAzUabUGNEPDdg
         7LbpkEbqrD6PeT/j9nK+NJK8H+2IocHwPPz7Uq/RKrn6YaepVMJRqTNhclSEi3XdST
         kwv6cxmcai7O7jdR8bZeITn6kTLta9GA3vG8TYHyeoNBhgr7ggnUMrL56E5SIPZ0EU
         NCGkbLaUmIdXIYZNBmEVKtpuw4yWUH7AzSxShNeDeAhT2zZhhc/71Qsum7xMBAi0n0
         4I2fVt33vVlPA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 11/49] iio:adc:ab8500: Switch from CONFIG_PM guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:09:41 +0000
Message-Id: <20211123211019.2271440-12-jic23@kernel.org>
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
without CONFIG_PM support is simpler and less error prone than the
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/adc/ab8500-gpadc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ab8500-gpadc.c b/drivers/iio/adc/ab8500-gpadc.c
index 4c46a201d4ef..3905213e1bfa 100644
--- a/drivers/iio/adc/ab8500-gpadc.c
+++ b/drivers/iio/adc/ab8500-gpadc.c
@@ -942,8 +942,7 @@ static const struct iio_info ab8500_gpadc_info = {
 	.read_raw = ab8500_gpadc_read_raw,
 };
 
-#ifdef CONFIG_PM
-static int ab8500_gpadc_runtime_suspend(struct device *dev)
+static __maybe_unused int ab8500_gpadc_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ab8500_gpadc *gpadc = iio_priv(indio_dev);
@@ -953,7 +952,7 @@ static int ab8500_gpadc_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int ab8500_gpadc_runtime_resume(struct device *dev)
+static __maybe_unused int ab8500_gpadc_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ab8500_gpadc *gpadc = iio_priv(indio_dev);
@@ -965,7 +964,6 @@ static int ab8500_gpadc_runtime_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
 /**
  * ab8500_gpadc_parse_channel() - process devicetree channel configuration
@@ -1199,7 +1197,7 @@ static int ab8500_gpadc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct dev_pm_ops ab8500_gpadc_pm_ops = {
+static __maybe_unused const struct dev_pm_ops ab8500_gpadc_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
 				pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(ab8500_gpadc_runtime_suspend,
@@ -1212,7 +1210,7 @@ static struct platform_driver ab8500_gpadc_driver = {
 	.remove = ab8500_gpadc_remove,
 	.driver = {
 		.name = "ab8500-gpadc",
-		.pm = &ab8500_gpadc_pm_ops,
+		.pm = pm_ptr(&ab8500_gpadc_pm_ops),
 	},
 };
 builtin_platform_driver(ab8500_gpadc_driver);
-- 
2.34.0

