Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBC6A6800A
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2019 18:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfGNQMX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jul 2019 12:12:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbfGNQMX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jul 2019 12:12:23 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFB3E2089C;
        Sun, 14 Jul 2019 16:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563120742;
        bh=jQ3cxzxLH7yJHxroHjJKAh+DCw/uGp76CuAc9EnFjIw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pyyR3bpivYqypeLsapWGqEeveNHlVQal+Fd8PBLe2pG3MBL3a/gfEePEhqA9InIEB
         haK1CWVuTHwt3PEPrepUFwd+Lwm/Ay1Vyc95SLYAEGz0fTFBxLIip51TtrcTYWVr8t
         rXRmqptsdQ3KjYI6cH8SwD+sIMq4VP00X+S0m1cc=
Date:   Sun, 14 Jul 2019 17:12:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <robh+dt@kernel.org>, <alexandre.torgue@st.com>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iio: adc: stm32-adc: add analog switches supply
 control
Message-ID: <20190714171205.32facd54@archlinux>
In-Reply-To: <1562148496-26789-3-git-send-email-fabrice.gasnier@st.com>
References: <1562148496-26789-1-git-send-email-fabrice.gasnier@st.com>
        <1562148496-26789-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 3 Jul 2019 12:08:15 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> On stm32h7 and stm32mp1, the ADC inputs are multiplexed with analog
> switches which have reduced performances when their supply is below 2.7V
> (vdda by default):
> - 3.3V embedded booster can be used, to get full ADC performances
>   (increases power consumption).
> - vdd supply can be selected if above 2.7V by setting ANASWVDD syscfg bit,
>   on STM32MP1 only.
> 
> Make this optional, since this is a trade-off between analog performance
> and power consumption.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Looks good to me.

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
> Changes in v2:
> - Only enable vdd regulator when needed.
> - Rework vdda enabling since: "Add missing vdda-supply to STM32 ADC".
> - Booster has been added to the regulator framework. This helps also when
>   there are several ADC instances like on stm32h7 (e.g. ADC12 and ADC3), to
>   benefit from the use count.
> ---
>  drivers/iio/adc/stm32-adc-core.c | 193 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 192 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> index 1f7ce51..4299cef 100644
> --- a/drivers/iio/adc/stm32-adc-core.c
> +++ b/drivers/iio/adc/stm32-adc-core.c
> @@ -14,9 +14,11 @@
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/irqdesc.h>
>  #include <linux/irqdomain.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  
> @@ -51,6 +53,17 @@
>  
>  #define STM32_ADC_CORE_SLEEP_DELAY_MS	2000
>  
> +/* SYSCFG registers */
> +#define STM32MP1_SYSCFG_PMCSETR		0x04
> +#define STM32MP1_SYSCFG_PMCCLRR		0x44
> +
> +/* SYSCFG bit fields */
> +#define STM32MP1_SYSCFG_ANASWVDD_MASK	BIT(9)
> +
> +/* SYSCFG capability flags */
> +#define HAS_VBOOSTER		BIT(0)
> +#define HAS_ANASWVDD		BIT(1)
> +
>  /**
>   * stm32_adc_common_regs - stm32 common registers, compatible dependent data
>   * @csr:	common status register offset
> @@ -74,11 +87,13 @@ struct stm32_adc_priv;
>   * @regs:	common registers for all instances
>   * @clk_sel:	clock selection routine
>   * @max_clk_rate_hz: maximum analog clock rate (Hz, from datasheet)
> + * @has_syscfg: SYSCFG capability flags
>   */
>  struct stm32_adc_priv_cfg {
>  	const struct stm32_adc_common_regs *regs;
>  	int (*clk_sel)(struct platform_device *, struct stm32_adc_priv *);
>  	u32 max_clk_rate_hz;
> +	unsigned int has_syscfg;
>  };
>  
>  /**
> @@ -87,22 +102,32 @@ struct stm32_adc_priv_cfg {
>   * @domain:		irq domain reference
>   * @aclk:		clock reference for the analog circuitry
>   * @bclk:		bus clock common for all ADCs, depends on part used
> + * @booster:		booster supply reference
> + * @vdd:		vdd supply reference
>   * @vdda:		vdda analog supply reference
>   * @vref:		regulator reference
> + * @vdd_uv:		vdd supply voltage (microvolts)
> + * @vdda_uv:		vdda supply voltage (microvolts)
>   * @cfg:		compatible configuration data
>   * @common:		common data for all ADC instances
>   * @ccr_bak:		backup CCR in low power mode
> + * @syscfg:		reference to syscon, system control registers
>   */
>  struct stm32_adc_priv {
>  	int				irq[STM32_ADC_MAX_ADCS];
>  	struct irq_domain		*domain;
>  	struct clk			*aclk;
>  	struct clk			*bclk;
> +	struct regulator		*booster;
> +	struct regulator		*vdd;
>  	struct regulator		*vdda;
>  	struct regulator		*vref;
> +	int				vdd_uv;
> +	int				vdda_uv;
>  	const struct stm32_adc_priv_cfg	*cfg;
>  	struct stm32_adc_common		common;
>  	u32				ccr_bak;
> +	struct regmap			*syscfg;
>  };
>  
>  static struct stm32_adc_priv *to_stm32_adc_priv(struct stm32_adc_common *com)
> @@ -390,6 +415,82 @@ static void stm32_adc_irq_remove(struct platform_device *pdev,
>  	}
>  }
>  
> +static int stm32_adc_core_switches_supply_en(struct stm32_adc_priv *priv,
> +					     struct device *dev)
> +{
> +	int ret;
> +
> +	/*
> +	 * On STM32H7 and STM32MP1, the ADC inputs are multiplexed with analog
> +	 * switches (via PCSEL) which have reduced performances when their
> +	 * supply is below 2.7V (vdda by default):
> +	 * - Voltage booster can be used, to get full ADC performances
> +	 *   (increases power consumption).
> +	 * - Vdd can be used to supply them, if above 2.7V (STM32MP1 only).
> +	 *
> +	 * Recommended settings for ANASWVDD and EN_BOOSTER:
> +	 * - vdda < 2.7V but vdd > 2.7V: ANASWVDD = 1, EN_BOOSTER = 0 (stm32mp1)
> +	 * - vdda < 2.7V and vdd < 2.7V: ANASWVDD = 0, EN_BOOSTER = 1
> +	 * - vdda >= 2.7V:               ANASWVDD = 0, EN_BOOSTER = 0 (default)
> +	 */
> +	if (priv->vdda_uv < 2700000) {
> +		if (priv->syscfg && priv->vdd_uv > 2700000) {
> +			ret = regulator_enable(priv->vdd);
> +			if (ret < 0) {
> +				dev_err(dev, "vdd enable failed %d\n", ret);
> +				return ret;
> +			}
> +
> +			ret = regmap_write(priv->syscfg,
> +					   STM32MP1_SYSCFG_PMCSETR,
> +					   STM32MP1_SYSCFG_ANASWVDD_MASK);
> +			if (ret < 0) {
> +				regulator_disable(priv->vdd);
> +				dev_err(dev, "vdd select failed, %d\n", ret);
> +				return ret;
> +			}
> +			dev_dbg(dev, "analog switches supplied by vdd\n");
> +
> +			return 0;
> +		}
> +
> +		if (priv->booster) {
> +			/*
> +			 * This is optional, as this is a trade-off between
> +			 * analog performance and power consumption.
> +			 */
> +			ret = regulator_enable(priv->booster);
> +			if (ret < 0) {
> +				dev_err(dev, "booster enable failed %d\n", ret);
> +				return ret;
> +			}
> +			dev_dbg(dev, "analog switches supplied by booster\n");
> +
> +			return 0;
> +		}
> +	}
> +
> +	/* Fallback using vdda (default), nothing to do */
> +	dev_dbg(dev, "analog switches supplied by vdda (%d uV)\n",
> +		priv->vdda_uv);
> +
> +	return 0;
> +}
> +
> +static void stm32_adc_core_switches_supply_dis(struct stm32_adc_priv *priv)
> +{
> +	if (priv->vdda_uv < 2700000) {
> +		if (priv->syscfg && priv->vdd_uv > 2700000) {
> +			regmap_write(priv->syscfg, STM32MP1_SYSCFG_PMCCLRR,
> +				     STM32MP1_SYSCFG_ANASWVDD_MASK);
> +			regulator_disable(priv->vdd);
> +			return;
> +		}
> +		if (priv->booster)
> +			regulator_disable(priv->booster);
> +	}
> +}
> +
>  static int stm32_adc_core_hw_start(struct device *dev)
>  {
>  	struct stm32_adc_common *common = dev_get_drvdata(dev);
> @@ -402,10 +503,21 @@ static int stm32_adc_core_hw_start(struct device *dev)
>  		return ret;
>  	}
>  
> +	ret = regulator_get_voltage(priv->vdda);
> +	if (ret < 0) {
> +		dev_err(dev, "vdda get voltage failed, %d\n", ret);
> +		goto err_vdda_disable;
> +	}
> +	priv->vdda_uv = ret;
> +
> +	ret = stm32_adc_core_switches_supply_en(priv, dev);
> +	if (ret < 0)
> +		goto err_vdda_disable;
> +
>  	ret = regulator_enable(priv->vref);
>  	if (ret < 0) {
>  		dev_err(dev, "vref enable failed\n");
> -		goto err_vdda_disable;
> +		goto err_switches_dis;
>  	}
>  
>  	if (priv->bclk) {
> @@ -433,6 +545,8 @@ static int stm32_adc_core_hw_start(struct device *dev)
>  		clk_disable_unprepare(priv->bclk);
>  err_regulator_disable:
>  	regulator_disable(priv->vref);
> +err_switches_dis:
> +	stm32_adc_core_switches_supply_dis(priv);
>  err_vdda_disable:
>  	regulator_disable(priv->vdda);
>  
> @@ -451,9 +565,80 @@ static void stm32_adc_core_hw_stop(struct device *dev)
>  	if (priv->bclk)
>  		clk_disable_unprepare(priv->bclk);
>  	regulator_disable(priv->vref);
> +	stm32_adc_core_switches_supply_dis(priv);
>  	regulator_disable(priv->vdda);
>  }
>  
> +static int stm32_adc_core_switches_probe(struct device *dev,
> +					 struct stm32_adc_priv *priv)
> +{
> +	struct device_node *np = dev->of_node;
> +	int ret;
> +
> +	/* Analog switches supply can be controlled by syscfg (optional) */
> +	priv->syscfg = syscon_regmap_lookup_by_phandle(np, "st,syscfg");
> +	if (IS_ERR(priv->syscfg)) {
> +		ret = PTR_ERR(priv->syscfg);
> +		if (ret != -ENODEV) {
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(dev, "Can't probe syscfg: %d\n", ret);
> +			return ret;
> +		}
> +		priv->syscfg = NULL;
> +	}
> +
> +	/* Booster can be used to supply analog switches (optional) */
> +	if (priv->cfg->has_syscfg & HAS_VBOOSTER &&
> +	    of_property_read_bool(np, "booster-supply")) {
> +		priv->booster = devm_regulator_get_optional(dev, "booster");
> +		if (IS_ERR(priv->booster)) {
> +			ret = PTR_ERR(priv->booster);
> +			if (ret != -ENODEV) {
> +				if (ret != -EPROBE_DEFER)
> +					dev_err(dev, "can't get booster %d\n",
> +						ret);
> +				return ret;
> +			}
> +			priv->booster = NULL;
> +		}
> +	}
> +
> +	/* Vdd can be used to supply analog switches (optional) */
> +	if (priv->cfg->has_syscfg & HAS_ANASWVDD &&
> +	    of_property_read_bool(np, "vdd-supply")) {
> +		priv->vdd = devm_regulator_get_optional(dev, "vdd");
> +		if (IS_ERR(priv->vdd)) {
> +			ret = PTR_ERR(priv->vdd);
> +			if (ret != -ENODEV) {
> +				if (ret != -EPROBE_DEFER)
> +					dev_err(dev, "can't get vdd %d\n", ret);
> +				return ret;
> +			}
> +			priv->vdd = NULL;
> +		}
> +	}
> +
> +	if (priv->vdd) {
> +		ret = regulator_enable(priv->vdd);
> +		if (ret < 0) {
> +			dev_err(dev, "vdd enable failed %d\n", ret);
> +			return ret;
> +		}
> +
> +		ret = regulator_get_voltage(priv->vdd);
> +		if (ret < 0) {
> +			dev_err(dev, "vdd get voltage failed %d\n", ret);
> +			regulator_disable(priv->vdd);
> +			return ret;
> +		}
> +		priv->vdd_uv = ret;
> +
> +		regulator_disable(priv->vdd);
> +	}
> +
> +	return 0;
> +}
> +
>  static int stm32_adc_probe(struct platform_device *pdev)
>  {
>  	struct stm32_adc_priv *priv;
> @@ -514,6 +699,10 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  		priv->bclk = NULL;
>  	}
>  
> +	ret = stm32_adc_core_switches_probe(dev, priv);
> +	if (ret)
> +		return ret;
> +
>  	pm_runtime_get_noresume(dev);
>  	pm_runtime_set_active(dev);
>  	pm_runtime_set_autosuspend_delay(dev, STM32_ADC_CORE_SLEEP_DELAY_MS);
> @@ -611,12 +800,14 @@ static const struct stm32_adc_priv_cfg stm32h7_adc_priv_cfg = {
>  	.regs = &stm32h7_adc_common_regs,
>  	.clk_sel = stm32h7_adc_clk_sel,
>  	.max_clk_rate_hz = 36000000,
> +	.has_syscfg = HAS_VBOOSTER,
>  };
>  
>  static const struct stm32_adc_priv_cfg stm32mp1_adc_priv_cfg = {
>  	.regs = &stm32h7_adc_common_regs,
>  	.clk_sel = stm32h7_adc_clk_sel,
>  	.max_clk_rate_hz = 40000000,
> +	.has_syscfg = HAS_VBOOSTER | HAS_ANASWVDD,
>  };
>  
>  static const struct of_device_id stm32_adc_of_match[] = {

