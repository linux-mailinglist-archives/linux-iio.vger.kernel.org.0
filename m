Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE29D108D
	for <lists+linux-iio@lfdr.de>; Wed,  9 Oct 2019 15:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731083AbfJINtP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Oct 2019 09:49:15 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:15486 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729883AbfJINtP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Oct 2019 09:49:15 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x99DkFjD002040;
        Wed, 9 Oct 2019 15:48:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=SzeXX4T9Smreq6AOa2jvBpOacbsjhosjwXdUxXEO0PA=;
 b=0BLfs75UMFf+ATYkn8ppseugj2ielYzq4wi9wZ9Fg403C0aW/jg5w7gVCdF7xDJ4Elxs
 pc/G3Tx21QyfhmKh+DtBc/dyuzCMkP6dBSz6FtN+jav4kay7meXgyEPb5yIeXzd6tO7C
 38Aj/esllr3hdukG7Y+jwEQ1f6DI+isDaiIoJM0wlRUexWft3kzV8/n9AfEhvhPZu1UX
 W0DIC+XE4CYGXjWyqVWNsJxUZ+Nob+r+0fiEh/MQzJWueZQIrsbdJk9MkPnt8oET/gm8
 /F0DHwUabYSZwomAmKG3tesHkD4t7SlSrSkEfw3Oy1EHIS3SH92vZkop3e1r19a5JoRL 5A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vegn0xaqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Oct 2019 15:48:46 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 80A8E100034;
        Wed,  9 Oct 2019 15:48:45 +0200 (CEST)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6F48C21CA92;
        Wed,  9 Oct 2019 15:48:45 +0200 (CEST)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.46) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 9 Oct 2019
 15:48:45 +0200
Received: from localhost (10.48.0.192) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 9 Oct 2019 15:48:44 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] iio: dac: stm32: add power management support
Date:   Wed, 9 Oct 2019 15:48:38 +0200
Message-ID: <1570628918-23474-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.192]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-09_06:2019-10-08,2019-10-09 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for runtime PM & sleep.
Provide pclk to regmap as registers access doesn't need full power
(e.g. regulator). Always restore HFSEL when resuming. It may get lost
depending on low power level that has been achieved.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/dac/stm32-dac-core.c | 138 ++++++++++++++++++++++++++++++---------
 drivers/iio/dac/stm32-dac.c      |  94 +++++++++++++++++++++++++-
 2 files changed, 199 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/dac/stm32-dac-core.c b/drivers/iio/dac/stm32-dac-core.c
index d0fb312..9e6b4cd 100644
--- a/drivers/iio/dac/stm32-dac-core.c
+++ b/drivers/iio/dac/stm32-dac-core.c
@@ -11,6 +11,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 
@@ -50,6 +51,41 @@ static const struct regmap_config stm32_dac_regmap_cfg = {
 	.max_register = 0x3fc,
 };
 
+static int stm32_dac_core_hw_start(struct device *dev)
+{
+	struct stm32_dac_common *common = dev_get_drvdata(dev);
+	struct stm32_dac_priv *priv = to_stm32_dac_priv(common);
+	int ret;
+
+	ret = regulator_enable(priv->vref);
+	if (ret < 0) {
+		dev_err(dev, "vref enable failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(priv->pclk);
+	if (ret < 0) {
+		dev_err(dev, "pclk enable failed: %d\n", ret);
+		goto err_regulator_disable;
+	}
+
+	return 0;
+
+err_regulator_disable:
+	regulator_disable(priv->vref);
+
+	return ret;
+}
+
+static void stm32_dac_core_hw_stop(struct device *dev)
+{
+	struct stm32_dac_common *common = dev_get_drvdata(dev);
+	struct stm32_dac_priv *priv = to_stm32_dac_priv(common);
+
+	clk_disable_unprepare(priv->pclk);
+	regulator_disable(priv->vref);
+}
+
 static int stm32_dac_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -66,6 +102,8 @@ static int stm32_dac_probe(struct platform_device *pdev)
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
+	platform_set_drvdata(pdev, &priv->common);
+
 	cfg = (const struct stm32_dac_cfg *)
 		of_match_device(dev->driver->of_match_table, dev)->data;
 
@@ -74,11 +112,19 @@ static int stm32_dac_probe(struct platform_device *pdev)
 	if (IS_ERR(mmio))
 		return PTR_ERR(mmio);
 
-	regmap = devm_regmap_init_mmio(dev, mmio, &stm32_dac_regmap_cfg);
+	regmap = devm_regmap_init_mmio_clk(dev, "pclk", mmio,
+					   &stm32_dac_regmap_cfg);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 	priv->common.regmap = regmap;
 
+	priv->pclk = devm_clk_get(dev, "pclk");
+	if (IS_ERR(priv->pclk)) {
+		ret = PTR_ERR(priv->pclk);
+		dev_err(dev, "pclk get failed\n");
+		return ret;
+	}
+
 	priv->vref = devm_regulator_get(dev, "vref");
 	if (IS_ERR(priv->vref)) {
 		ret = PTR_ERR(priv->vref);
@@ -86,33 +132,22 @@ static int stm32_dac_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = regulator_enable(priv->vref);
-	if (ret < 0) {
-		dev_err(dev, "vref enable failed\n");
-		return ret;
-	}
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	ret = stm32_dac_core_hw_start(dev);
+	if (ret)
+		goto err_pm_stop;
 
 	ret = regulator_get_voltage(priv->vref);
 	if (ret < 0) {
 		dev_err(dev, "vref get voltage failed, %d\n", ret);
-		goto err_vref;
+		goto err_hw_stop;
 	}
 	priv->common.vref_mv = ret / 1000;
 	dev_dbg(dev, "vref+=%dmV\n", priv->common.vref_mv);
 
-	priv->pclk = devm_clk_get(dev, "pclk");
-	if (IS_ERR(priv->pclk)) {
-		ret = PTR_ERR(priv->pclk);
-		dev_err(dev, "pclk get failed\n");
-		goto err_vref;
-	}
-
-	ret = clk_prepare_enable(priv->pclk);
-	if (ret < 0) {
-		dev_err(dev, "pclk enable failed\n");
-		goto err_vref;
-	}
-
 	priv->rst = devm_reset_control_get_exclusive(dev, NULL);
 	if (!IS_ERR(priv->rst)) {
 		reset_control_assert(priv->rst);
@@ -128,39 +163,79 @@ static int stm32_dac_probe(struct platform_device *pdev)
 					 priv->common.hfsel ?
 					 STM32H7_DAC_CR_HFSEL : 0);
 		if (ret)
-			goto err_pclk;
+			goto err_hw_stop;
 	}
 
-	platform_set_drvdata(pdev, &priv->common);
 
 	ret = of_platform_populate(pdev->dev.of_node, NULL, NULL, dev);
 	if (ret < 0) {
 		dev_err(dev, "failed to populate DT children\n");
-		goto err_pclk;
+		goto err_hw_stop;
 	}
 
+	pm_runtime_put(dev);
+
 	return 0;
 
-err_pclk:
-	clk_disable_unprepare(priv->pclk);
-err_vref:
-	regulator_disable(priv->vref);
+err_hw_stop:
+	stm32_dac_core_hw_stop(dev);
+err_pm_stop:
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_put_noidle(dev);
 
 	return ret;
 }
 
 static int stm32_dac_remove(struct platform_device *pdev)
 {
-	struct stm32_dac_common *common = platform_get_drvdata(pdev);
+	pm_runtime_get_sync(&pdev->dev);
+	of_platform_depopulate(&pdev->dev);
+	stm32_dac_core_hw_stop(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+
+	return 0;
+}
+
+static int __maybe_unused stm32_dac_core_resume(struct device *dev)
+{
+	struct stm32_dac_common *common = dev_get_drvdata(dev);
 	struct stm32_dac_priv *priv = to_stm32_dac_priv(common);
+	int ret;
 
-	of_platform_depopulate(&pdev->dev);
-	clk_disable_unprepare(priv->pclk);
-	regulator_disable(priv->vref);
+	if (priv->common.hfsel) {
+		/* restore hfsel (maybe lost under low power state) */
+		ret = regmap_update_bits(priv->common.regmap, STM32_DAC_CR,
+					 STM32H7_DAC_CR_HFSEL,
+					 STM32H7_DAC_CR_HFSEL);
+		if (ret)
+			return ret;
+	}
+
+	return pm_runtime_force_resume(dev);
+}
+
+static int __maybe_unused stm32_dac_core_runtime_suspend(struct device *dev)
+{
+	stm32_dac_core_hw_stop(dev);
 
 	return 0;
 }
 
+static int __maybe_unused stm32_dac_core_runtime_resume(struct device *dev)
+{
+	return stm32_dac_core_hw_start(dev);
+}
+
+static const struct dev_pm_ops stm32_dac_core_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, stm32_dac_core_resume)
+	SET_RUNTIME_PM_OPS(stm32_dac_core_runtime_suspend,
+			   stm32_dac_core_runtime_resume,
+			   NULL)
+};
+
 static const struct stm32_dac_cfg stm32h7_dac_cfg = {
 	.has_hfsel = true,
 };
@@ -182,6 +257,7 @@ static struct platform_driver stm32_dac_driver = {
 	.driver = {
 		.name = "stm32-dac-core",
 		.of_match_table = stm32_dac_of_match,
+		.pm = &stm32_dac_core_pm_ops,
 	},
 };
 module_platform_driver(stm32_dac_driver);
diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
index cce26a3..f22c1d9 100644
--- a/drivers/iio/dac/stm32-dac.c
+++ b/drivers/iio/dac/stm32-dac.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 #include "stm32-dac-core.h"
 
@@ -20,6 +21,8 @@
 #define STM32_DAC_CHANNEL_2		2
 #define STM32_DAC_IS_CHAN_1(ch)		((ch) & STM32_DAC_CHANNEL_1)
 
+#define STM32_DAC_AUTO_SUSPEND_DELAY_MS	2000
+
 /**
  * struct stm32_dac - private data of DAC driver
  * @common:		reference to DAC common data
@@ -49,15 +52,34 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
 				      bool enable)
 {
 	struct stm32_dac *dac = iio_priv(indio_dev);
+	struct device *dev = indio_dev->dev.parent;
 	u32 msk = STM32_DAC_IS_CHAN_1(ch) ? STM32_DAC_CR_EN1 : STM32_DAC_CR_EN2;
 	u32 en = enable ? msk : 0;
 	int ret;
 
+	/* already enabled / disabled ? */
+	mutex_lock(&indio_dev->mlock);
+	ret = stm32_dac_is_enabled(indio_dev, ch);
+	if (ret < 0 || enable == !!ret) {
+		mutex_unlock(&indio_dev->mlock);
+		return ret < 0 ? ret : 0;
+	}
+
+	if (enable) {
+		ret = pm_runtime_get_sync(dev);
+		if (ret < 0) {
+			pm_runtime_put_noidle(dev);
+			mutex_unlock(&indio_dev->mlock);
+			return ret;
+		}
+	}
+
 	ret = regmap_update_bits(dac->common->regmap, STM32_DAC_CR, msk, en);
+	mutex_unlock(&indio_dev->mlock);
 	if (ret < 0) {
 		dev_err(&indio_dev->dev, "%s failed\n", en ?
 			"Enable" : "Disable");
-		return ret;
+		goto err_put_pm;
 	}
 
 	/*
@@ -68,7 +90,20 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
 	if (en && dac->common->hfsel)
 		udelay(1);
 
+	if (!enable) {
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+	}
+
 	return 0;
+
+err_put_pm:
+	if (enable) {
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+	}
+
+	return ret;
 }
 
 static int stm32_dac_get_value(struct stm32_dac *dac, int channel, int *val)
@@ -272,6 +307,7 @@ static int stm32_dac_chan_of_init(struct iio_dev *indio_dev)
 static int stm32_dac_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
 	struct iio_dev *indio_dev;
 	struct stm32_dac *dac;
 	int ret;
@@ -296,9 +332,61 @@ static int stm32_dac_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	return devm_iio_device_register(&pdev->dev, indio_dev);
+	/* Get stm32-dac-core PM online */
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_set_autosuspend_delay(dev, STM32_DAC_AUTO_SUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_enable(dev);
+
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto err_pm_put;
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+
+err_pm_put:
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_put_noidle(dev);
+
+	return ret;
 }
 
+static int stm32_dac_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+
+	pm_runtime_get_sync(&pdev->dev);
+	iio_device_unregister(indio_dev);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+
+	return 0;
+}
+
+static int __maybe_unused stm32_dac_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	int channel = indio_dev->channels[0].channel;
+	int ret;
+
+	/* Ensure DAC is disabled before suspend */
+	ret = stm32_dac_is_enabled(indio_dev, channel);
+	if (ret)
+		return ret < 0 ? ret : -EBUSY;
+
+	return pm_runtime_force_suspend(dev);
+}
+
+static const struct dev_pm_ops stm32_dac_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(stm32_dac_suspend, pm_runtime_force_resume)
+};
+
 static const struct of_device_id stm32_dac_of_match[] = {
 	{ .compatible = "st,stm32-dac", },
 	{},
@@ -307,9 +395,11 @@ MODULE_DEVICE_TABLE(of, stm32_dac_of_match);
 
 static struct platform_driver stm32_dac_driver = {
 	.probe = stm32_dac_probe,
+	.remove = stm32_dac_remove,
 	.driver = {
 		.name = "stm32-dac",
 		.of_match_table = stm32_dac_of_match,
+		.pm = &stm32_dac_pm_ops,
 	},
 };
 module_platform_driver(stm32_dac_driver);
-- 
2.7.4

