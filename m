Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF0945ADE6
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbhKWVJ2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:09:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:40014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234973AbhKWVJ2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:09:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EAFE60FE8;
        Tue, 23 Nov 2021 21:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701579;
        bh=3zznP9KZoQH/pszZBJE+ZtaVR5de8ceJnZFvR9i0Igs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZEAyU8RTd5PoNSDzl4P+0cTr2AlsGeZ4vlhQwUkvTgoLRzDUSrVOo7KoOwbeRBIXb
         Joy38bKFNRuUY0EHCAiBW2TmgBA9RbY3va5W3YyA5wnAQAHGt8GeXowM+PmJzfE2xJ
         SNSYQpwOj7SLyl3nZSrx46HpW4dttOM93ZJO+6nIaZDr1GXEmsv2BoYdvhvz66sGcK
         E2flt1vPvo5luT0PCXKjf/XzLYf6wPTHY9BEeQ0iSnpk4mx95RUnv0HKOiiQToaIA0
         ePjWsc8/GFA3Vqzm4/F5W2YjmYWDNYZg8yQpRIw6wEA2zYF8a04W7SEgG8kUxT940+
         9yULw6cmJnrpA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 15/49] iio:adc:palmas_gpadc: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:09:45 +0000
Message-Id: <20211123211019.2271440-16-jic23@kernel.org>
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
---
 drivers/iio/adc/palmas_gpadc.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index f9c8385c72d3..98d7764e0662 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -653,8 +653,7 @@ static int palmas_gpadc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int palmas_adc_wakeup_configure(struct palmas_gpadc *adc)
+static __maybe_unused int palmas_adc_wakeup_configure(struct palmas_gpadc *adc)
 {
 	int adc_period, conv;
 	int i;
@@ -759,7 +758,7 @@ static int palmas_adc_wakeup_configure(struct palmas_gpadc *adc)
 	return ret;
 }
 
-static int palmas_adc_wakeup_reset(struct palmas_gpadc *adc)
+static __maybe_unused int palmas_adc_wakeup_reset(struct palmas_gpadc *adc)
 {
 	int ret;
 
@@ -777,7 +776,7 @@ static int palmas_adc_wakeup_reset(struct palmas_gpadc *adc)
 	return ret;
 }
 
-static int palmas_gpadc_suspend(struct device *dev)
+static __maybe_unused int palmas_gpadc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct palmas_gpadc *adc = iio_priv(indio_dev);
@@ -800,7 +799,7 @@ static int palmas_gpadc_suspend(struct device *dev)
 	return 0;
 }
 
-static int palmas_gpadc_resume(struct device *dev)
+static __maybe_unused int palmas_gpadc_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct palmas_gpadc *adc = iio_priv(indio_dev);
@@ -822,9 +821,8 @@ static int palmas_gpadc_resume(struct device *dev)
 
 	return 0;
 };
-#endif
 
-static const struct dev_pm_ops palmas_pm_ops = {
+static __maybe_unused const struct dev_pm_ops palmas_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(palmas_gpadc_suspend,
 				palmas_gpadc_resume)
 };
@@ -840,7 +838,7 @@ static struct platform_driver palmas_gpadc_driver = {
 	.remove = palmas_gpadc_remove,
 	.driver = {
 		.name = MOD_NAME,
-		.pm = &palmas_pm_ops,
+		.pm = pm_ptr(&palmas_pm_ops),
 		.of_match_table = of_palmas_gpadc_match_tbl,
 	},
 };
-- 
2.34.0

