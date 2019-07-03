Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0215E1A7
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2019 12:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfGCKJB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Jul 2019 06:09:01 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:22174 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726871AbfGCKJB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jul 2019 06:09:01 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x63A7AcP000447;
        Wed, 3 Jul 2019 12:08:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=7ApidBu5k8wKKMQ/ewkUXikk4Z6XKDx56afGPAeUBoQ=;
 b=sexKugZ562ZMmFfWBAPRhfz2cuUOvYt9rEBrXaryixYF8EM+LCMtp92vcTPBS8lu0bZd
 mGL3L5MAOQmyWkOx8/kpmqiG1q3bG/fnBHq1Exz1iLdYsQDMyQJhXllU59HMxei173Ai
 Mpwb6pUGu9vYWK5Dn23Hec63sf2FUCmBVeWEdp22XR4+hYEYPO0zOJb/LUPIgjzL95UY
 SmQihoGSvl4kVwKSLS3YWGGztNpzwz1fV71gEe8orPCvZkV9Ui81Rz+ViUpwP+g9aUvu
 5KteqbD6gu5oTP4+Hvv/W9qC/g6MMoobgNe1mX/Prva7HMEj3dA0qAqitqK4a4o35+// 7Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2tdwrv2j5m-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 03 Jul 2019 12:08:29 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2B69334;
        Wed,  3 Jul 2019 10:08:26 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ECC04267F;
        Wed,  3 Jul 2019 10:08:25 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 3 Jul 2019
 12:08:25 +0200
Received: from localhost (10.48.0.167) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 3 Jul 2019 12:08:25 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <alexandre.torgue@st.com>
CC:     <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] iio: adc: stm32-adc: add analog switches supply control
Date:   Wed, 3 Jul 2019 12:08:15 +0200
Message-ID: <1562148496-26789-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562148496-26789-1-git-send-email-fabrice.gasnier@st.com>
References: <1562148496-26789-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.167]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-03_03:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On stm32h7 and stm32mp1, the ADC inputs are multiplexed with analog
switches which have reduced performances when their supply is below 2.7V
(vdda by default):
- 3.3V embedded booster can be used, to get full ADC performances
  (increases power consumption).
- vdd supply can be selected if above 2.7V by setting ANASWVDD syscfg bit,
  on STM32MP1 only.

Make this optional, since this is a trade-off between analog performance
and power consumption.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v2:
- Only enable vdd regulator when needed.
- Rework vdda enabling since: "Add missing vdda-supply to STM32 ADC".
- Booster has been added to the regulator framework. This helps also when
  there are several ADC instances like on stm32h7 (e.g. ADC12 and ADC3), to
  benefit from the use count.
---
 drivers/iio/adc/stm32-adc-core.c | 193 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 192 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 1f7ce51..4299cef 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -14,9 +14,11 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdesc.h>
 #include <linux/irqdomain.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
@@ -51,6 +53,17 @@
 
 #define STM32_ADC_CORE_SLEEP_DELAY_MS	2000
 
+/* SYSCFG registers */
+#define STM32MP1_SYSCFG_PMCSETR		0x04
+#define STM32MP1_SYSCFG_PMCCLRR		0x44
+
+/* SYSCFG bit fields */
+#define STM32MP1_SYSCFG_ANASWVDD_MASK	BIT(9)
+
+/* SYSCFG capability flags */
+#define HAS_VBOOSTER		BIT(0)
+#define HAS_ANASWVDD		BIT(1)
+
 /**
  * stm32_adc_common_regs - stm32 common registers, compatible dependent data
  * @csr:	common status register offset
@@ -74,11 +87,13 @@ struct stm32_adc_priv;
  * @regs:	common registers for all instances
  * @clk_sel:	clock selection routine
  * @max_clk_rate_hz: maximum analog clock rate (Hz, from datasheet)
+ * @has_syscfg: SYSCFG capability flags
  */
 struct stm32_adc_priv_cfg {
 	const struct stm32_adc_common_regs *regs;
 	int (*clk_sel)(struct platform_device *, struct stm32_adc_priv *);
 	u32 max_clk_rate_hz;
+	unsigned int has_syscfg;
 };
 
 /**
@@ -87,22 +102,32 @@ struct stm32_adc_priv_cfg {
  * @domain:		irq domain reference
  * @aclk:		clock reference for the analog circuitry
  * @bclk:		bus clock common for all ADCs, depends on part used
+ * @booster:		booster supply reference
+ * @vdd:		vdd supply reference
  * @vdda:		vdda analog supply reference
  * @vref:		regulator reference
+ * @vdd_uv:		vdd supply voltage (microvolts)
+ * @vdda_uv:		vdda supply voltage (microvolts)
  * @cfg:		compatible configuration data
  * @common:		common data for all ADC instances
  * @ccr_bak:		backup CCR in low power mode
+ * @syscfg:		reference to syscon, system control registers
  */
 struct stm32_adc_priv {
 	int				irq[STM32_ADC_MAX_ADCS];
 	struct irq_domain		*domain;
 	struct clk			*aclk;
 	struct clk			*bclk;
+	struct regulator		*booster;
+	struct regulator		*vdd;
 	struct regulator		*vdda;
 	struct regulator		*vref;
+	int				vdd_uv;
+	int				vdda_uv;
 	const struct stm32_adc_priv_cfg	*cfg;
 	struct stm32_adc_common		common;
 	u32				ccr_bak;
+	struct regmap			*syscfg;
 };
 
 static struct stm32_adc_priv *to_stm32_adc_priv(struct stm32_adc_common *com)
@@ -390,6 +415,82 @@ static void stm32_adc_irq_remove(struct platform_device *pdev,
 	}
 }
 
+static int stm32_adc_core_switches_supply_en(struct stm32_adc_priv *priv,
+					     struct device *dev)
+{
+	int ret;
+
+	/*
+	 * On STM32H7 and STM32MP1, the ADC inputs are multiplexed with analog
+	 * switches (via PCSEL) which have reduced performances when their
+	 * supply is below 2.7V (vdda by default):
+	 * - Voltage booster can be used, to get full ADC performances
+	 *   (increases power consumption).
+	 * - Vdd can be used to supply them, if above 2.7V (STM32MP1 only).
+	 *
+	 * Recommended settings for ANASWVDD and EN_BOOSTER:
+	 * - vdda < 2.7V but vdd > 2.7V: ANASWVDD = 1, EN_BOOSTER = 0 (stm32mp1)
+	 * - vdda < 2.7V and vdd < 2.7V: ANASWVDD = 0, EN_BOOSTER = 1
+	 * - vdda >= 2.7V:               ANASWVDD = 0, EN_BOOSTER = 0 (default)
+	 */
+	if (priv->vdda_uv < 2700000) {
+		if (priv->syscfg && priv->vdd_uv > 2700000) {
+			ret = regulator_enable(priv->vdd);
+			if (ret < 0) {
+				dev_err(dev, "vdd enable failed %d\n", ret);
+				return ret;
+			}
+
+			ret = regmap_write(priv->syscfg,
+					   STM32MP1_SYSCFG_PMCSETR,
+					   STM32MP1_SYSCFG_ANASWVDD_MASK);
+			if (ret < 0) {
+				regulator_disable(priv->vdd);
+				dev_err(dev, "vdd select failed, %d\n", ret);
+				return ret;
+			}
+			dev_dbg(dev, "analog switches supplied by vdd\n");
+
+			return 0;
+		}
+
+		if (priv->booster) {
+			/*
+			 * This is optional, as this is a trade-off between
+			 * analog performance and power consumption.
+			 */
+			ret = regulator_enable(priv->booster);
+			if (ret < 0) {
+				dev_err(dev, "booster enable failed %d\n", ret);
+				return ret;
+			}
+			dev_dbg(dev, "analog switches supplied by booster\n");
+
+			return 0;
+		}
+	}
+
+	/* Fallback using vdda (default), nothing to do */
+	dev_dbg(dev, "analog switches supplied by vdda (%d uV)\n",
+		priv->vdda_uv);
+
+	return 0;
+}
+
+static void stm32_adc_core_switches_supply_dis(struct stm32_adc_priv *priv)
+{
+	if (priv->vdda_uv < 2700000) {
+		if (priv->syscfg && priv->vdd_uv > 2700000) {
+			regmap_write(priv->syscfg, STM32MP1_SYSCFG_PMCCLRR,
+				     STM32MP1_SYSCFG_ANASWVDD_MASK);
+			regulator_disable(priv->vdd);
+			return;
+		}
+		if (priv->booster)
+			regulator_disable(priv->booster);
+	}
+}
+
 static int stm32_adc_core_hw_start(struct device *dev)
 {
 	struct stm32_adc_common *common = dev_get_drvdata(dev);
@@ -402,10 +503,21 @@ static int stm32_adc_core_hw_start(struct device *dev)
 		return ret;
 	}
 
+	ret = regulator_get_voltage(priv->vdda);
+	if (ret < 0) {
+		dev_err(dev, "vdda get voltage failed, %d\n", ret);
+		goto err_vdda_disable;
+	}
+	priv->vdda_uv = ret;
+
+	ret = stm32_adc_core_switches_supply_en(priv, dev);
+	if (ret < 0)
+		goto err_vdda_disable;
+
 	ret = regulator_enable(priv->vref);
 	if (ret < 0) {
 		dev_err(dev, "vref enable failed\n");
-		goto err_vdda_disable;
+		goto err_switches_dis;
 	}
 
 	if (priv->bclk) {
@@ -433,6 +545,8 @@ static int stm32_adc_core_hw_start(struct device *dev)
 		clk_disable_unprepare(priv->bclk);
 err_regulator_disable:
 	regulator_disable(priv->vref);
+err_switches_dis:
+	stm32_adc_core_switches_supply_dis(priv);
 err_vdda_disable:
 	regulator_disable(priv->vdda);
 
@@ -451,9 +565,80 @@ static void stm32_adc_core_hw_stop(struct device *dev)
 	if (priv->bclk)
 		clk_disable_unprepare(priv->bclk);
 	regulator_disable(priv->vref);
+	stm32_adc_core_switches_supply_dis(priv);
 	regulator_disable(priv->vdda);
 }
 
+static int stm32_adc_core_switches_probe(struct device *dev,
+					 struct stm32_adc_priv *priv)
+{
+	struct device_node *np = dev->of_node;
+	int ret;
+
+	/* Analog switches supply can be controlled by syscfg (optional) */
+	priv->syscfg = syscon_regmap_lookup_by_phandle(np, "st,syscfg");
+	if (IS_ERR(priv->syscfg)) {
+		ret = PTR_ERR(priv->syscfg);
+		if (ret != -ENODEV) {
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "Can't probe syscfg: %d\n", ret);
+			return ret;
+		}
+		priv->syscfg = NULL;
+	}
+
+	/* Booster can be used to supply analog switches (optional) */
+	if (priv->cfg->has_syscfg & HAS_VBOOSTER &&
+	    of_property_read_bool(np, "booster-supply")) {
+		priv->booster = devm_regulator_get_optional(dev, "booster");
+		if (IS_ERR(priv->booster)) {
+			ret = PTR_ERR(priv->booster);
+			if (ret != -ENODEV) {
+				if (ret != -EPROBE_DEFER)
+					dev_err(dev, "can't get booster %d\n",
+						ret);
+				return ret;
+			}
+			priv->booster = NULL;
+		}
+	}
+
+	/* Vdd can be used to supply analog switches (optional) */
+	if (priv->cfg->has_syscfg & HAS_ANASWVDD &&
+	    of_property_read_bool(np, "vdd-supply")) {
+		priv->vdd = devm_regulator_get_optional(dev, "vdd");
+		if (IS_ERR(priv->vdd)) {
+			ret = PTR_ERR(priv->vdd);
+			if (ret != -ENODEV) {
+				if (ret != -EPROBE_DEFER)
+					dev_err(dev, "can't get vdd %d\n", ret);
+				return ret;
+			}
+			priv->vdd = NULL;
+		}
+	}
+
+	if (priv->vdd) {
+		ret = regulator_enable(priv->vdd);
+		if (ret < 0) {
+			dev_err(dev, "vdd enable failed %d\n", ret);
+			return ret;
+		}
+
+		ret = regulator_get_voltage(priv->vdd);
+		if (ret < 0) {
+			dev_err(dev, "vdd get voltage failed %d\n", ret);
+			regulator_disable(priv->vdd);
+			return ret;
+		}
+		priv->vdd_uv = ret;
+
+		regulator_disable(priv->vdd);
+	}
+
+	return 0;
+}
+
 static int stm32_adc_probe(struct platform_device *pdev)
 {
 	struct stm32_adc_priv *priv;
@@ -514,6 +699,10 @@ static int stm32_adc_probe(struct platform_device *pdev)
 		priv->bclk = NULL;
 	}
 
+	ret = stm32_adc_core_switches_probe(dev, priv);
+	if (ret)
+		return ret;
+
 	pm_runtime_get_noresume(dev);
 	pm_runtime_set_active(dev);
 	pm_runtime_set_autosuspend_delay(dev, STM32_ADC_CORE_SLEEP_DELAY_MS);
@@ -611,12 +800,14 @@ static const struct stm32_adc_priv_cfg stm32h7_adc_priv_cfg = {
 	.regs = &stm32h7_adc_common_regs,
 	.clk_sel = stm32h7_adc_clk_sel,
 	.max_clk_rate_hz = 36000000,
+	.has_syscfg = HAS_VBOOSTER,
 };
 
 static const struct stm32_adc_priv_cfg stm32mp1_adc_priv_cfg = {
 	.regs = &stm32h7_adc_common_regs,
 	.clk_sel = stm32h7_adc_clk_sel,
 	.max_clk_rate_hz = 40000000,
+	.has_syscfg = HAS_VBOOSTER | HAS_ANASWVDD,
 };
 
 static const struct of_device_id stm32_adc_of_match[] = {
-- 
2.7.4

