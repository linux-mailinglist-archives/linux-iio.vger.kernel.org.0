Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D0D4A38AD
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355959AbiA3T1v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355961AbiA3T1V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:27:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF3BC061751
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 11:27:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F661B829A0
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50066C340EB;
        Sun, 30 Jan 2022 19:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570832;
        bh=Vd7HObHjuNZ2aM0j+5Rv/vKlfe3sBosGhkAkaD2IIsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dLUovlzJ7wuHofifAYIuvYKqAVKMQrwY7KPk+40ipHH8UiDuifZzFHoByPxtIlHSz
         +VnX9SLF1CAtSMorUfqbZ4i/aDR0mRtFwjLKmpE4Fco0hXO8b0PTCJfjWcOmroemtd
         SiWeVklkv5k8u4F2dRBYWVefySuebHffkAbJkl9AXbcHeEpb74upzRJrs4m+KpTCsL
         35uFUaH4gAxJPiVuvP1ObhOIC0y09eRk7pCC3m7AC7U+eTOn0TT4ASa7W6zIpsgBuK
         bhOcVNxO8AEumJfd+edH3CJbi14sqlqi5bAYy/02OKhWeDbxIms2McpisCa2w2nuE1
         Dsbvkykhle7sw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>
Subject: [PATCH v3 44/50] iio:adc:stm32:Switch from CONFIG_PM guards to pm_ptr()
Date:   Sun, 30 Jan 2022 19:31:41 +0000
Message-Id: <20220130193147.279148-45-jic23@kernel.org>
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
without CONFIG_PM support is simpler and less error prone than the
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

The new DEFINE_RUNTIME_DEV_PM_OPS() macro reduces boilerplate.

Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/stm32-adc-core.c | 17 ++++++-----------
 drivers/iio/adc/stm32-adc.c      | 12 ++++--------
 2 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index b6e18eb101f7..142656232157 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -763,7 +763,6 @@ static int stm32_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#if defined(CONFIG_PM)
 static int stm32_adc_core_runtime_suspend(struct device *dev)
 {
 	stm32_adc_core_hw_stop(dev);
@@ -782,15 +781,11 @@ static int stm32_adc_core_runtime_idle(struct device *dev)
 
 	return 0;
 }
-#endif
-
-static const struct dev_pm_ops stm32_adc_core_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(stm32_adc_core_runtime_suspend,
-			   stm32_adc_core_runtime_resume,
-			   stm32_adc_core_runtime_idle)
-};
+
+static DEFINE_RUNTIME_DEV_PM_OPS(stm32_adc_core_pm_ops,
+				stm32_adc_core_runtime_suspend,
+				stm32_adc_core_runtime_resume,
+				stm32_adc_core_runtime_idle);
 
 static const struct stm32_adc_priv_cfg stm32f4_adc_priv_cfg = {
 	.regs = &stm32f4_adc_common_regs,
@@ -836,7 +831,7 @@ static struct platform_driver stm32_adc_driver = {
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
2.35.1

