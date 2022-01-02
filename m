Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B50482B2E
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiABMvg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:51:36 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50442 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiABMvf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:51:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC38CB80D63
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE973C36AEE;
        Sun,  2 Jan 2022 12:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127893;
        bh=q7cVSAUQ/xFgnIBCJzRwFHWnmeiVZureIoe1bh4nnuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LLE0eDrrBYt5SLzqCqd5rGHCppEkLhxLmAZdAlFF4Hl6OSwvByz/mSj3rMyjnneJf
         /CUG2l0YHnoVmRzqZdAZ37bw6o8+iUmFUejO9BOSbY0SMCR75UCvZ3SCynW75F61ys
         kgoqES3lEury7KdTXAkPc8+B2vmYKqzPSKLjEF+slAyNm5VXCKdWdtmA4bvuwmk1sY
         mR2iCk4WLfuBeWhMeBnnTHmOB/Q7SMK8SlFzg34cMJhP/7EUSuVll9Z1t4Eu8MjPtP
         li/e4FDCN9vADdQXFC5R7Xu4fmJXzE8xKtPhL3ehJoyLZjPbw0jDNFk9L9BmjHQjMC
         U0tNJ9M3VkJ8g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>
Subject: [PATCH v2 15/51] iio:adc:stm32:Switch from CONFIG_PM guards to pm_ptr()
Date:   Sun,  2 Jan 2022 12:55:41 +0000
Message-Id: <20220102125617.1259804-16-jic23@kernel.org>
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

Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/stm32-adc-core.c | 13 +++++--------
 drivers/iio/adc/stm32-adc.c      | 12 ++++--------
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index b6e18eb101f7..c506dd558958 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -763,7 +763,6 @@ static int stm32_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#if defined(CONFIG_PM)
 static int stm32_adc_core_runtime_suspend(struct device *dev)
 {
 	stm32_adc_core_hw_stop(dev);
@@ -782,14 +781,12 @@ static int stm32_adc_core_runtime_idle(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops stm32_adc_core_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(stm32_adc_core_runtime_suspend,
-			   stm32_adc_core_runtime_resume,
-			   stm32_adc_core_runtime_idle)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	RUNTIME_PM_OPS(stm32_adc_core_runtime_suspend,
+		       stm32_adc_core_runtime_resume,
+		       stm32_adc_core_runtime_idle)
 };
 
 static const struct stm32_adc_priv_cfg stm32f4_adc_priv_cfg = {
@@ -836,7 +833,7 @@ static struct platform_driver stm32_adc_driver = {
 	.driver = {
 		.name = "stm32-adc-core",
 		.of_match_table = stm32_adc_of_match,
-		.pm = &stm32_adc_core_pm_ops,
+		.pm = pm_ptr(&stm32_adc_core_pm_ops),
 	},
 };
 module_platform_driver(stm32_adc_driver);
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 897166d9e45c..a68ecbda6480 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -2352,7 +2352,6 @@ static int stm32_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#if defined(CONFIG_PM_SLEEP)
 static int stm32_adc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
@@ -2382,9 +2381,7 @@ static int stm32_adc_resume(struct device *dev)
 
 	return stm32_adc_buffer_postenable(indio_dev);
 }
-#endif
 
-#if defined(CONFIG_PM)
 static int stm32_adc_runtime_suspend(struct device *dev)
 {
 	return stm32_adc_hw_stop(dev);
@@ -2394,12 +2391,11 @@ static int stm32_adc_runtime_resume(struct device *dev)
 {
 	return stm32_adc_hw_start(dev);
 }
-#endif
 
 static const struct dev_pm_ops stm32_adc_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(stm32_adc_suspend, stm32_adc_resume)
-	SET_RUNTIME_PM_OPS(stm32_adc_runtime_suspend, stm32_adc_runtime_resume,
-			   NULL)
+	SYSTEM_SLEEP_PM_OPS(stm32_adc_suspend, stm32_adc_resume)
+	RUNTIME_PM_OPS(stm32_adc_runtime_suspend, stm32_adc_runtime_resume,
+		       NULL)
 };
 
 static const struct stm32_adc_cfg stm32f4_adc_cfg = {
@@ -2453,7 +2449,7 @@ static struct platform_driver stm32_adc_driver = {
 	.driver = {
 		.name = "stm32-adc",
 		.of_match_table = stm32_adc_of_match,
-		.pm = &stm32_adc_pm_ops,
+		.pm = pm_ptr(&stm32_adc_pm_ops),
 	},
 };
 module_platform_driver(stm32_adc_driver);
-- 
2.34.1

