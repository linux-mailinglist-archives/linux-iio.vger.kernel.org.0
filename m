Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DA14A38B2
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356002AbiA3T2D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355984AbiA3T12 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:27:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FE8C061714
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 11:27:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86403612FD
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED269C340E4;
        Sun, 30 Jan 2022 19:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570847;
        bh=VdFB7U15rkq/H0qzccmJS+Jb3AoTrQPvxuyyYKa++eg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EUpZTg47ihWyylAfgI7IBEGdnxCvlTKqAe1b78ho9t5r4f+u2KLEo2+E/tET/tQep
         B2Gj96jSiYvtm8HcERqHHd8bEHMzv9RcwLDMoRLhHk2BiKGRWAPTOmZL+EH0Z9SJs9
         yaWvJGgPZwf8Y4YvrMExNX5BRTJhf+R89jbd06NihnMFPUWKQyePxaNc41CCeS2iWF
         4bwBFiYrzmu8adnQ2lF6B0NUKa/UEDoDqigw/go5lOVuKgoWB3KABOrMuA6XXQLlFe
         /lpyEETPXXoapJa912fbEcRqd283M3eju8M7GIlnmkTGk4CwNxuUynY3c7AfYPMUH/
         R2vWA+oROtTdQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH v3 50/50] iio:adc:stm32*: Use pm[_sleep]_ptr() etc to avoid need to make pm __maybe_unused
Date:   Sun, 30 Jan 2022 19:31:47 +0000
Message-Id: <20220130193147.279148-51-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220130193147.279148-1-jic23@kernel.org>
References: <20220130193147.279148-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The combinations of either
* pm_sleep_ptr() and DEFINE_SIMPLE_DEV_PM_OPS()
* pm_ptr() and RUNTIME_PM_OPS()/SYSTEM_SLEEP_PM_OPS
Make sure the functions are always visible to the compiler and removed by
it rather than requring #ifdef magic.

This removes the need to mark the functions as __maybe_unused and saves
additional space with some build options as the dev_pm_ops structure
itself can be dropped automatically if CONFIG_PM is not enabled.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Olivier Moysan <olivier.moysan@st.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c         | 11 ++++++-----
 drivers/iio/adc/stm32-dfsdm-core.c        | 19 +++++++++----------
 drivers/iio/dac/stm32-dac-core.c          | 16 ++++++++--------
 drivers/iio/dac/stm32-dac.c               |  9 ++++-----
 drivers/iio/trigger/stm32-timer-trigger.c | 12 ++++++------
 5 files changed, 33 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 1cfefb3b5e56..9704cf0b9753 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -1632,7 +1632,7 @@ static int stm32_dfsdm_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused stm32_dfsdm_adc_suspend(struct device *dev)
+static int stm32_dfsdm_adc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 
@@ -1642,7 +1642,7 @@ static int __maybe_unused stm32_dfsdm_adc_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused stm32_dfsdm_adc_resume(struct device *dev)
+static int stm32_dfsdm_adc_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
@@ -1665,14 +1665,15 @@ static int __maybe_unused stm32_dfsdm_adc_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(stm32_dfsdm_adc_pm_ops,
-			 stm32_dfsdm_adc_suspend, stm32_dfsdm_adc_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(stm32_dfsdm_adc_pm_ops,
+				stm32_dfsdm_adc_suspend,
+				stm32_dfsdm_adc_resume);
 
 static struct platform_driver stm32_dfsdm_adc_driver = {
 	.driver = {
 		.name = "stm32-dfsdm-adc",
 		.of_match_table = stm32_dfsdm_adc_match,
-		.pm = &stm32_dfsdm_adc_pm_ops,
+		.pm = pm_sleep_ptr(&stm32_dfsdm_adc_pm_ops),
 	},
 	.probe = stm32_dfsdm_adc_probe,
 	.remove = stm32_dfsdm_adc_remove,
diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
index a627af9a825e..a3d4de6ba4c2 100644
--- a/drivers/iio/adc/stm32-dfsdm-core.c
+++ b/drivers/iio/adc/stm32-dfsdm-core.c
@@ -381,7 +381,7 @@ static int stm32_dfsdm_core_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused stm32_dfsdm_core_suspend(struct device *dev)
+static int stm32_dfsdm_core_suspend(struct device *dev)
 {
 	struct stm32_dfsdm *dfsdm = dev_get_drvdata(dev);
 	struct dfsdm_priv *priv = to_stm32_dfsdm_priv(dfsdm);
@@ -397,7 +397,7 @@ static int __maybe_unused stm32_dfsdm_core_suspend(struct device *dev)
 	return pinctrl_pm_select_sleep_state(dev);
 }
 
-static int __maybe_unused stm32_dfsdm_core_resume(struct device *dev)
+static int stm32_dfsdm_core_resume(struct device *dev)
 {
 	struct stm32_dfsdm *dfsdm = dev_get_drvdata(dev);
 	struct dfsdm_priv *priv = to_stm32_dfsdm_priv(dfsdm);
@@ -414,7 +414,7 @@ static int __maybe_unused stm32_dfsdm_core_resume(struct device *dev)
 	return pm_runtime_force_resume(dev);
 }
 
-static int __maybe_unused stm32_dfsdm_core_runtime_suspend(struct device *dev)
+static int stm32_dfsdm_core_runtime_suspend(struct device *dev)
 {
 	struct stm32_dfsdm *dfsdm = dev_get_drvdata(dev);
 
@@ -423,7 +423,7 @@ static int __maybe_unused stm32_dfsdm_core_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused stm32_dfsdm_core_runtime_resume(struct device *dev)
+static int stm32_dfsdm_core_runtime_resume(struct device *dev)
 {
 	struct stm32_dfsdm *dfsdm = dev_get_drvdata(dev);
 
@@ -431,11 +431,10 @@ static int __maybe_unused stm32_dfsdm_core_runtime_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops stm32_dfsdm_core_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(stm32_dfsdm_core_suspend,
-				stm32_dfsdm_core_resume)
-	SET_RUNTIME_PM_OPS(stm32_dfsdm_core_runtime_suspend,
-			   stm32_dfsdm_core_runtime_resume,
-			   NULL)
+	SYSTEM_SLEEP_PM_OPS(stm32_dfsdm_core_suspend, stm32_dfsdm_core_resume)
+	RUNTIME_PM_OPS(stm32_dfsdm_core_runtime_suspend,
+		       stm32_dfsdm_core_runtime_resume,
+		       NULL)
 };
 
 static struct platform_driver stm32_dfsdm_driver = {
@@ -444,7 +443,7 @@ static struct platform_driver stm32_dfsdm_driver = {
 	.driver = {
 		.name = "stm32-dfsdm",
 		.of_match_table = stm32_dfsdm_of_match,
-		.pm = &stm32_dfsdm_core_pm_ops,
+		.pm = pm_ptr(&stm32_dfsdm_core_pm_ops),
 	},
 };
 
diff --git a/drivers/iio/dac/stm32-dac-core.c b/drivers/iio/dac/stm32-dac-core.c
index bd7a3b20e645..83bf184e3adc 100644
--- a/drivers/iio/dac/stm32-dac-core.c
+++ b/drivers/iio/dac/stm32-dac-core.c
@@ -195,7 +195,7 @@ static int stm32_dac_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused stm32_dac_core_resume(struct device *dev)
+static int stm32_dac_core_resume(struct device *dev)
 {
 	struct stm32_dac_common *common = dev_get_drvdata(dev);
 	struct stm32_dac_priv *priv = to_stm32_dac_priv(common);
@@ -213,23 +213,23 @@ static int __maybe_unused stm32_dac_core_resume(struct device *dev)
 	return pm_runtime_force_resume(dev);
 }
 
-static int __maybe_unused stm32_dac_core_runtime_suspend(struct device *dev)
+static int stm32_dac_core_runtime_suspend(struct device *dev)
 {
 	stm32_dac_core_hw_stop(dev);
 
 	return 0;
 }
 
-static int __maybe_unused stm32_dac_core_runtime_resume(struct device *dev)
+static int stm32_dac_core_runtime_resume(struct device *dev)
 {
 	return stm32_dac_core_hw_start(dev);
 }
 
 static const struct dev_pm_ops stm32_dac_core_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, stm32_dac_core_resume)
-	SET_RUNTIME_PM_OPS(stm32_dac_core_runtime_suspend,
-			   stm32_dac_core_runtime_resume,
-			   NULL)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, stm32_dac_core_resume)
+	RUNTIME_PM_OPS(stm32_dac_core_runtime_suspend,
+		       stm32_dac_core_runtime_resume,
+		       NULL)
 };
 
 static const struct stm32_dac_cfg stm32h7_dac_cfg = {
@@ -253,7 +253,7 @@ static struct platform_driver stm32_dac_driver = {
 	.driver = {
 		.name = "stm32-dac-core",
 		.of_match_table = stm32_dac_of_match,
-		.pm = &stm32_dac_core_pm_ops,
+		.pm = pm_ptr(&stm32_dac_core_pm_ops),
 	},
 };
 module_platform_driver(stm32_dac_driver);
diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
index cd71cc4553a7..b20192a071cb 100644
--- a/drivers/iio/dac/stm32-dac.c
+++ b/drivers/iio/dac/stm32-dac.c
@@ -372,7 +372,7 @@ static int stm32_dac_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused stm32_dac_suspend(struct device *dev)
+static int stm32_dac_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	int channel = indio_dev->channels[0].channel;
@@ -386,9 +386,8 @@ static int __maybe_unused stm32_dac_suspend(struct device *dev)
 	return pm_runtime_force_suspend(dev);
 }
 
-static const struct dev_pm_ops stm32_dac_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(stm32_dac_suspend, pm_runtime_force_resume)
-};
+static DEFINE_SIMPLE_DEV_PM_OPS(stm32_dac_pm_ops, stm32_dac_suspend,
+				pm_runtime_force_resume);
 
 static const struct of_device_id stm32_dac_of_match[] = {
 	{ .compatible = "st,stm32-dac", },
@@ -402,7 +401,7 @@ static struct platform_driver stm32_dac_driver = {
 	.driver = {
 		.name = "stm32-dac",
 		.of_match_table = stm32_dac_of_match,
-		.pm = &stm32_dac_pm_ops,
+		.pm = pm_sleep_ptr(&stm32_dac_pm_ops),
 	},
 };
 module_platform_driver(stm32_dac_driver);
diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index 4f9461e1412c..d72ac4c0bca4 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -827,7 +827,7 @@ static int stm32_timer_trigger_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused stm32_timer_trigger_suspend(struct device *dev)
+static int stm32_timer_trigger_suspend(struct device *dev)
 {
 	struct stm32_timer_trigger *priv = dev_get_drvdata(dev);
 
@@ -849,7 +849,7 @@ static int __maybe_unused stm32_timer_trigger_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused stm32_timer_trigger_resume(struct device *dev)
+static int stm32_timer_trigger_resume(struct device *dev)
 {
 	struct stm32_timer_trigger *priv = dev_get_drvdata(dev);
 	int ret;
@@ -875,9 +875,9 @@ static int __maybe_unused stm32_timer_trigger_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(stm32_timer_trigger_pm_ops,
-			 stm32_timer_trigger_suspend,
-			 stm32_timer_trigger_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(stm32_timer_trigger_pm_ops,
+				stm32_timer_trigger_suspend,
+				stm32_timer_trigger_resume);
 
 static const struct stm32_timer_trigger_cfg stm32_timer_trg_cfg = {
 	.valids_table = valids_table,
@@ -907,7 +907,7 @@ static struct platform_driver stm32_timer_trigger_driver = {
 	.driver = {
 		.name = "stm32-timer-trigger",
 		.of_match_table = stm32_trig_of_match,
-		.pm = &stm32_timer_trigger_pm_ops,
+		.pm = pm_sleep_ptr(&stm32_timer_trigger_pm_ops),
 	},
 };
 module_platform_driver(stm32_timer_trigger_driver);
-- 
2.35.1

