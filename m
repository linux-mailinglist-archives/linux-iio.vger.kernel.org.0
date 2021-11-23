Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B96345ADE7
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbhKWVJc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:09:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:40030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236778AbhKWVJa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:09:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2307160FE6;
        Tue, 23 Nov 2021 21:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701581;
        bh=ArkD3l/qqqfcXZBHJ8wO7zQ2ZQbmZXSfmDPLjf7Ns4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JfILvphqePmP7DTJJNcgXXlGIv85ClsGmsiLZdcyX/OT81+9cSv0+i0yDKy2SJ1/r
         /D+RQhLjFNJOyyz79j0RRpsXPxt7/VqCag6WcnfUQsfJiW/dVOvUzQZZTN3CUGy+kE
         ai2CachLTjUa1ORYzoRqQeiJxxwG7+lqmURsSmwFmOIDAIUSQD7Jlj3/2jj+6lNXRe
         kkkNMgcLljyf/yZ/ZTuwqRNOYnN+b9L10G8jVUbWBqt76dfDpeLdWCfyCwd9lo62Sk
         wZJH8/ionqrKvraySl1VS7r16Tr2RV73lA10wrwTjAtrl5AqHvszlb/V6kRsvyyxhf
         9eQu0061aY0cw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>
Subject: [PATCH 16/49] iio:adc:stm32:Switch from CONFIG_PM guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:09:46 +0000
Message-Id: <20211123211019.2271440-17-jic23@kernel.org>
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
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/stm32-adc-core.c | 12 +++++-------
 drivers/iio/adc/stm32-adc.c      | 16 ++++++----------
 2 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index b6e18eb101f7..316ae84ab961 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -763,28 +763,26 @@ static int stm32_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#if defined(CONFIG_PM)
-static int stm32_adc_core_runtime_suspend(struct device *dev)
+static __maybe_unused int stm32_adc_core_runtime_suspend(struct device *dev)
 {
 	stm32_adc_core_hw_stop(dev);
 
 	return 0;
 }
 
-static int stm32_adc_core_runtime_resume(struct device *dev)
+static __maybe_unused int stm32_adc_core_runtime_resume(struct device *dev)
 {
 	return stm32_adc_core_hw_start(dev);
 }
 
-static int stm32_adc_core_runtime_idle(struct device *dev)
+static __maybe_unused int stm32_adc_core_runtime_idle(struct device *dev)
 {
 	pm_runtime_mark_last_busy(dev);
 
 	return 0;
 }
-#endif
 
-static const struct dev_pm_ops stm32_adc_core_pm_ops = {
+static __maybe_unused const struct dev_pm_ops stm32_adc_core_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
 				pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(stm32_adc_core_runtime_suspend,
@@ -836,7 +834,7 @@ static struct platform_driver stm32_adc_driver = {
 	.driver = {
 		.name = "stm32-adc-core",
 		.of_match_table = stm32_adc_of_match,
-		.pm = &stm32_adc_core_pm_ops,
+		.pm = pm_ptr(&stm32_adc_core_pm_ops),
 	},
 };
 module_platform_driver(stm32_adc_driver);
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 7f1fb36c747c..2d94de6de848 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -2351,8 +2351,7 @@ static int stm32_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#if defined(CONFIG_PM_SLEEP)
-static int stm32_adc_suspend(struct device *dev)
+static __maybe_unused int stm32_adc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 
@@ -2362,7 +2361,7 @@ static int stm32_adc_suspend(struct device *dev)
 	return pm_runtime_force_suspend(dev);
 }
 
-static int stm32_adc_resume(struct device *dev)
+static __maybe_unused int stm32_adc_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	int ret;
@@ -2381,21 +2380,18 @@ static int stm32_adc_resume(struct device *dev)
 
 	return stm32_adc_buffer_postenable(indio_dev);
 }
-#endif
 
-#if defined(CONFIG_PM)
-static int stm32_adc_runtime_suspend(struct device *dev)
+static __maybe_unused int stm32_adc_runtime_suspend(struct device *dev)
 {
 	return stm32_adc_hw_stop(dev);
 }
 
-static int stm32_adc_runtime_resume(struct device *dev)
+static __maybe_unused int stm32_adc_runtime_resume(struct device *dev)
 {
 	return stm32_adc_hw_start(dev);
 }
-#endif
 
-static const struct dev_pm_ops stm32_adc_pm_ops = {
+static __maybe_unused const struct dev_pm_ops stm32_adc_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(stm32_adc_suspend, stm32_adc_resume)
 	SET_RUNTIME_PM_OPS(stm32_adc_runtime_suspend, stm32_adc_runtime_resume,
 			   NULL)
@@ -2452,7 +2448,7 @@ static struct platform_driver stm32_adc_driver = {
 	.driver = {
 		.name = "stm32-adc",
 		.of_match_table = stm32_adc_of_match,
-		.pm = &stm32_adc_pm_ops,
+		.pm = pm_ptr(&stm32_adc_pm_ops),
 	},
 };
 module_platform_driver(stm32_adc_driver);
-- 
2.34.0

