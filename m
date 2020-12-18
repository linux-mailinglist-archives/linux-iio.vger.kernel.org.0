Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDD12DE073
	for <lists+linux-iio@lfdr.de>; Fri, 18 Dec 2020 10:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgLRJgb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Dec 2020 04:36:31 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25]:47662 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725908AbgLRJgb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 18 Dec 2020 04:36:31 -0500
Received: from localhost.localdomain (unknown [124.16.141.242])
        by APP-05 (Coremail) with SMTP id zQCowACXn7PSd9xfS84SAA--.35060S2;
        Fri, 18 Dec 2020 17:35:15 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        fabrice.gasnier@st.com, krzk@kernel.org, andy.shevchenko@gmail.com,
        olivier.moysan@st.com, etienne.carriere@st.com,
        alexandru.ardelean@analog.com, peter.ujfalusi@ti.com,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: stm32-adc: Remove redundant null check before clk_prepare_enable/clk_disable_unprepare
Date:   Fri, 18 Dec 2020 09:35:12 +0000
Message-Id: <20201218093512.871-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: zQCowACXn7PSd9xfS84SAA--.35060S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr1UWFW5ZFyxKF4DWr1xXwb_yoW5ZFyUpw
        nFyF4Fyrs7Za40vFn8JrWjqFyFqa15Ka4IvF4UG3WrWr4ayr98ZFyrtF1IvFWFyrykK3Zx
        KFyjkFWkuF48uF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY
        04v7MxkIecxEwVAFwVW8uwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
        UI43ZEXa7IU5l1vDUUUUU==
X-Originating-IP: [124.16.141.242]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgYOA10Te2kdngAAsS
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Because clk_prepare_enable() and clk_disable_unprepare() already checked
NULL clock parameter, so the additional checks are unnecessary, just
remove them.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/iio/adc/stm32-adc-core.c | 29 +++++++++++------------------
 drivers/iio/adc/stm32-adc.c      | 14 +++++---------
 2 files changed, 16 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 9d1ad6e38e85..c088cb990193 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -535,20 +535,16 @@ static int stm32_adc_core_hw_start(struct device *dev)
 		goto err_switches_dis;
 	}
 
-	if (priv->bclk) {
-		ret = clk_prepare_enable(priv->bclk);
-		if (ret < 0) {
-			dev_err(dev, "bus clk enable failed\n");
-			goto err_regulator_disable;
-		}
+	ret = clk_prepare_enable(priv->bclk);
+	if (ret < 0) {
+		dev_err(dev, "bus clk enable failed\n");
+		goto err_regulator_disable;
 	}
 
-	if (priv->aclk) {
-		ret = clk_prepare_enable(priv->aclk);
-		if (ret < 0) {
-			dev_err(dev, "adc clk enable failed\n");
-			goto err_bclk_disable;
-		}
+	ret = clk_prepare_enable(priv->aclk);
+	if (ret < 0) {
+		dev_err(dev, "adc clk enable failed\n");
+		goto err_bclk_disable;
 	}
 
 	writel_relaxed(priv->ccr_bak, priv->common.base + priv->cfg->regs->ccr);
@@ -556,8 +552,7 @@ static int stm32_adc_core_hw_start(struct device *dev)
 	return 0;
 
 err_bclk_disable:
-	if (priv->bclk)
-		clk_disable_unprepare(priv->bclk);
+	clk_disable_unprepare(priv->bclk);
 err_regulator_disable:
 	regulator_disable(priv->vref);
 err_switches_dis:
@@ -575,10 +570,8 @@ static void stm32_adc_core_hw_stop(struct device *dev)
 
 	/* Backup CCR that may be lost (depends on power state to achieve) */
 	priv->ccr_bak = readl_relaxed(priv->common.base + priv->cfg->regs->ccr);
-	if (priv->aclk)
-		clk_disable_unprepare(priv->aclk);
-	if (priv->bclk)
-		clk_disable_unprepare(priv->bclk);
+	clk_disable_unprepare(priv->aclk);
+	clk_disable_unprepare(priv->bclk);
 	regulator_disable(priv->vref);
 	stm32_adc_core_switches_supply_dis(priv);
 	regulator_disable(priv->vdda);
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index c067c994dae2..f7c53cea509a 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -546,8 +546,7 @@ static int stm32_adc_hw_stop(struct device *dev)
 	if (adc->cfg->unprepare)
 		adc->cfg->unprepare(indio_dev);
 
-	if (adc->clk)
-		clk_disable_unprepare(adc->clk);
+	clk_disable_unprepare(adc->clk);
 
 	return 0;
 }
@@ -558,11 +557,9 @@ static int stm32_adc_hw_start(struct device *dev)
 	struct stm32_adc *adc = iio_priv(indio_dev);
 	int ret;
 
-	if (adc->clk) {
-		ret = clk_prepare_enable(adc->clk);
-		if (ret)
-			return ret;
-	}
+	ret = clk_prepare_enable(adc->clk);
+	if (ret)
+		return ret;
 
 	stm32_adc_set_res(adc);
 
@@ -575,8 +572,7 @@ static int stm32_adc_hw_start(struct device *dev)
 	return 0;
 
 err_clk_dis:
-	if (adc->clk)
-		clk_disable_unprepare(adc->clk);
+	clk_disable_unprepare(adc->clk);
 
 	return ret;
 }
-- 
2.17.1

