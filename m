Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47B8A4F571
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 13:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfFVLFR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 07:05:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfFVLFR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 07:05:17 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1950C2070B;
        Sat, 22 Jun 2019 11:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561201515;
        bh=coSF7lUUUoxoKk7PJ/blfVziC8roqU2es3HSlaUS9X8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p+uvwiheF6myrYZ9VKdtbBsSq0sAskz4r2jBxi4LavkLcrdCj4ypyzB80w+agKuNl
         UGrE9+ZNSn9NjkBCKUlPRgohApjsRXjVKWXQrVjSZNV59Pr4qFdtuYUPn9bJUYKwuP
         u4e+6Xrcz25tr4TOBeIrA2P9CWD1/PL3sOK1lCLs=
Date:   Sat, 22 Jun 2019 12:05:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <robh+dt@kernel.org>, <alexandre.torgue@st.com>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] iio: adc: stm32-adc: add analog switches supply
 control
Message-ID: <20190622120510.2215e8cc@archlinux>
In-Reply-To: <5ea9f65d-2feb-1ec5-1ca1-0cfd2964f160@st.com>
References: <1560324276-681-1-git-send-email-fabrice.gasnier@st.com>
        <1560324276-681-3-git-send-email-fabrice.gasnier@st.com>
        <20190616160732.124a1eb9@archlinux>
        <f1d4b47a-5910-53fe-5d63-d51da429dacd@st.com>
        <5ea9f65d-2feb-1ec5-1ca1-0cfd2964f160@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 19 Jun 2019 14:38:42 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> On 6/17/19 2:43 PM, Fabrice Gasnier wrote:
> > On 6/16/19 5:07 PM, Jonathan Cameron wrote:  
> >> On Wed, 12 Jun 2019 09:24:35 +0200
> >> Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
> >>  
> >>> On stm32h7 and stm32mp1, the ADC inputs are multiplexed with analog
> >>> switches which have reduced performances when their supply is below 2.7V
> >>> (vdda by default):
> >>> - vdd supply can be selected if above 2.7V by setting ANASWVDD syscfg bit
> >>>   (STM32MP1 only).
> >>> - Voltage booster can be used, to get full ADC performances by setting
> >>>   BOOSTE/EN_BOOSTER syscfg bit (increases power consumption).
> >>>
> >>> Make this optional, since this is a trade-off between analog performance
> >>> and power consumption.
> >>>
> >>> Note: STM32H7 syscfg has a set and clear register for "BOOSTE" control.
> >>> STM32MP1 has separate set and clear registers pair to control EN_BOOSTER
> >>> and ANASWVDD bits.
> >>>
> >>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>  
> >>
> >> A few minor bits inline, but mostly seems fine to me.
> >>
> >> Jonathan
> >>  
> >>> ---
> >>>  drivers/iio/adc/stm32-adc-core.c | 232 ++++++++++++++++++++++++++++++++++++++-
> >>>  1 file changed, 230 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> >>> index 2327ec1..9d41b16 100644
> >>> --- a/drivers/iio/adc/stm32-adc-core.c
> >>> +++ b/drivers/iio/adc/stm32-adc-core.c
> >>> @@ -14,9 +14,11 @@
> >>>  #include <linux/irqchip/chained_irq.h>
> >>>  #include <linux/irqdesc.h>
> >>>  #include <linux/irqdomain.h>
> >>> +#include <linux/mfd/syscon.h>
> >>>  #include <linux/module.h>
> >>>  #include <linux/of_device.h>
> >>>  #include <linux/pm_runtime.h>
> >>> +#include <linux/regmap.h>
> >>>  #include <linux/regulator/consumer.h>
> >>>  #include <linux/slab.h>
> >>>  
> >>> @@ -51,6 +53,20 @@
> >>>  
> >>>  #define STM32_ADC_CORE_SLEEP_DELAY_MS	2000
> >>>  
> >>> +/* SYSCFG registers */
> >>> +#define STM32H7_SYSCFG_PMCR		0x04
> >>> +#define STM32MP1_SYSCFG_PMCSETR		0x04
> >>> +#define STM32MP1_SYSCFG_PMCCLRR		0x44
> >>> +
> >>> +/* SYSCFG bit fields */
> >>> +#define STM32H7_SYSCFG_BOOSTE_MASK	BIT(8)
> >>> +#define STM32MP1_SYSCFG_ANASWVDD_MASK	BIT(9)
> >>> +
> >>> +/* SYSCFG capability flags */
> >>> +#define HAS_VBOOSTER		BIT(0)
> >>> +#define HAS_ANASWVDD		BIT(1)
> >>> +#define HAS_CLEAR_REG		BIT(2)
> >>> +
> >>>  /**
> >>>   * stm32_adc_common_regs - stm32 common registers, compatible dependent data
> >>>   * @csr:	common status register offset
> >>> @@ -58,6 +74,11 @@
> >>>   * @eoc1:	adc1 end of conversion flag in @csr
> >>>   * @eoc2:	adc2 end of conversion flag in @csr
> >>>   * @eoc3:	adc3 end of conversion flag in @csr
> >>> + * @has_syscfg: SYSCFG capability flags
> >>> + * @pmcr:	SYSCFG_PMCSETR/SYSCFG_PMCR register offset
> >>> + * @pmcc:	SYSCFG_PMCCLRR clear register offset
> >>> + * @booste_msk:	SYSCFG BOOSTE / EN_BOOSTER bitmask in PMCR & PMCCLRR
> >>> + * @anaswvdd_msk: SYSCFG ANASWVDD bitmask in PMCR & PMCCLRR
> >>>   */
> >>>  struct stm32_adc_common_regs {
> >>>  	u32 csr;
> >>> @@ -65,6 +86,11 @@ struct stm32_adc_common_regs {
> >>>  	u32 eoc1_msk;
> >>>  	u32 eoc2_msk;
> >>>  	u32 eoc3_msk;
> >>> +	unsigned int has_syscfg;
> >>> +	u32 pmcr;
> >>> +	u32 pmcc;
> >>> +	u32 booste_msk;
> >>> +	u32 anaswvdd_msk;
> >>>  };
> >>>  
> >>>  struct stm32_adc_priv;
> >>> @@ -87,20 +113,26 @@ struct stm32_adc_priv_cfg {
> >>>   * @domain:		irq domain reference
> >>>   * @aclk:		clock reference for the analog circuitry
> >>>   * @bclk:		bus clock common for all ADCs, depends on part used
> >>> + * @vdd:		vdd supply reference
> >>> + * @vdda:		vdda supply reference
> >>>   * @vref:		regulator reference
> >>>   * @cfg:		compatible configuration data
> >>>   * @common:		common data for all ADC instances
> >>>   * @ccr_bak:		backup CCR in low power mode
> >>> + * @syscfg:		reference to syscon, system control registers
> >>>   */
> >>>  struct stm32_adc_priv {
> >>>  	int				irq[STM32_ADC_MAX_ADCS];
> >>>  	struct irq_domain		*domain;
> >>>  	struct clk			*aclk;
> >>>  	struct clk			*bclk;
> >>> +	struct regulator		*vdd;
> >>> +	struct regulator		*vdda;
> >>>  	struct regulator		*vref;
> >>>  	const struct stm32_adc_priv_cfg	*cfg;
> >>>  	struct stm32_adc_common		common;
> >>>  	u32				ccr_bak;
> >>> +	struct regmap			*syscfg;
> >>>  };
> >>>  
> >>>  static struct stm32_adc_priv *to_stm32_adc_priv(struct stm32_adc_common *com)
> >>> @@ -284,6 +316,22 @@ static const struct stm32_adc_common_regs stm32h7_adc_common_regs = {
> >>>  	.ccr = STM32H7_ADC_CCR,
> >>>  	.eoc1_msk = STM32H7_EOC_MST,
> >>>  	.eoc2_msk = STM32H7_EOC_SLV,
> >>> +	.has_syscfg = HAS_VBOOSTER,
> >>> +	.pmcr = STM32H7_SYSCFG_PMCR,
> >>> +	.booste_msk = STM32H7_SYSCFG_BOOSTE_MASK,
> >>> +};
> >>> +
> >>> +/* STM32MP1 common registers definitions */
> >>> +static const struct stm32_adc_common_regs stm32mp1_adc_common_regs = {
> >>> +	.csr = STM32H7_ADC_CSR,
> >>> +	.ccr = STM32H7_ADC_CCR,
> >>> +	.eoc1_msk = STM32H7_EOC_MST,
> >>> +	.eoc2_msk = STM32H7_EOC_SLV,
> >>> +	.has_syscfg =  HAS_VBOOSTER | HAS_ANASWVDD | HAS_CLEAR_REG,  
> >>
> >> Extra space after =  
> > 
> > Hi Jonathan,
> > 
> > Oops, I'll fix it in v2.
> >   
> >>
> >>  
> >>> +	.pmcr = STM32MP1_SYSCFG_PMCSETR,
> >>> +	.pmcc = STM32MP1_SYSCFG_PMCCLRR,
> >>> +	.booste_msk = STM32H7_SYSCFG_BOOSTE_MASK,
> >>> +	.anaswvdd_msk = STM32MP1_SYSCFG_ANASWVDD_MASK,
> >>>  };
> >>>  
> >>>  /* ADC common interrupt for all instances */
> >>> @@ -388,16 +436,145 @@ static void stm32_adc_irq_remove(struct platform_device *pdev,
> >>>  	}
> >>>  }
> >>>  
> >>> +static int stm32_adc_core_switches_supply_en(struct device *dev)
> >>> +{
> >>> +	struct stm32_adc_common *common = dev_get_drvdata(dev);
> >>> +	struct stm32_adc_priv *priv = to_stm32_adc_priv(common);
> >>> +	const struct stm32_adc_common_regs *regs = priv->cfg->regs;
> >>> +	int ret, vdda, vdd = 0;
> >>> +	u32 mask, clrmask, setmask = 0;
> >>> +
> >>> +	/*
> >>> +	 * On STM32H7 and STM32MP1, the ADC inputs are multiplexed with analog
> >>> +	 * switches (via PCSEL) which have reduced performances when their
> >>> +	 * supply is below 2.7V (vdda by default):
> >>> +	 * - Voltage booster can be used, to get full ADC performances
> >>> +	 *   (increases power consumption).
> >>> +	 * - Vdd can be used to supply them, if above 2.7V (STM32MP1 only).
> >>> +	 *
> >>> +	 * This is optional, as this is a trade-off between analog performance
> >>> +	 * and power consumption.
> >>> +	 */
> >>> +	if (!regs->has_syscfg || !priv->vdda || !priv->syscfg) {
> >>> +		dev_dbg(dev, "Not configuring analog switches\n");
> >>> +		return 0;
> >>> +	}
> >>> +
> >>> +	ret = regulator_enable(priv->vdda);
> >>> +	if (ret < 0) {
> >>> +		dev_err(dev, "vdda enable failed %d\n", ret);
> >>> +		return ret;
> >>> +	}
> >>> +
> >>> +	ret = regulator_get_voltage(priv->vdda);
> >>> +	if (ret < 0) {
> >>> +		dev_err(dev, "vdda get voltage failed %d\n", ret);
> >>> +		goto vdda_dis;
> >>> +	}
> >>> +	vdda = ret;
> >>> +  
> >> We only need to do the following block if vdaa is too low.  Should probably
> >> not turn on vdd if there is not chance we are going to use it?  
> > 
> > You're right, then I probably need to move the regulator_get_voltage()
> > call at probe time, to avoid enabling it for nothing at runtime. (e.g.
> > to figure out it's not going to be used).
> > In fact, vdd is used also for other things on the platform (I/Os, other
> > supplies...), and is marked "always-on" in the device tree. But I
> > understand your point.
> > 
> > I'll rework this and send a v2.  
> 
> Hi Jonathan,
> 
> When reworking this part, I figured out the vdda should be described as
> required supply for the STM32 ADC. So I pushed out a fix series to
> address this "Add missing vdda-supply to STM32 ADC". I'll resume v2 of
> this series that has some dependencies on the fix series .

Cool. Given timing  I'm taking fixes and new stuff through the togreg
branch anyway at the moment so dependencies on fixes are easier than
normal for the next week or so ;)

Jonathan

> 
> Thanks
> Best Regards,
> Fabrice
> 
> > 
> > Thanks,
> > Fabrice
> >   
> >>  
> >>> +	if (priv->vdd && regs->has_syscfg & HAS_ANASWVDD) {
> >>> +		ret = regulator_enable(priv->vdd);
> >>> +		if (ret < 0) {
> >>> +			dev_err(dev, "vdd enable failed %d\n", ret);
> >>> +			goto vdda_dis;
> >>> +		}
> >>> +
> >>> +		ret = regulator_get_voltage(priv->vdd);
> >>> +		if (ret < 0) {
> >>> +			dev_err(dev, "vdd get voltage failed %d\n", ret);
> >>> +			goto vdd_dis;
> >>> +		}
> >>> +		vdd = ret;
> >>> +	}
> >>> +
> >>> +	/*
> >>> +	 * Recommended settings for ANASWVDD and EN_BOOSTER:
> >>> +	 * - vdda < 2.7V but vdd > 2.7V: ANASWVDD = 1, EN_BOOSTER = 0 (stm32mp1)
> >>> +	 * - vdda < 2.7V and vdd < 2.7V: ANASWVDD = 0, EN_BOOSTER = 1
> >>> +	 * - vdda >= 2.7V:               ANASWVDD = 0, EN_BOOSTER = 0 (default)
> >>> +	 */
> >>> +	if (vdda < 2700000) {
> >>> +		if (vdd > 2700000) {
> >>> +			dev_dbg(dev, "analog switches supplied by vdd\n");
> >>> +			setmask = regs->anaswvdd_msk;
> >>> +			clrmask = regs->booste_msk;
> >>> +		} else {
> >>> +			dev_dbg(dev, "Enabling voltage booster\n");
> >>> +			setmask = regs->booste_msk;
> >>> +			clrmask = regs->anaswvdd_msk;
> >>> +		}
> >>> +	} else {
> >>> +		dev_dbg(dev, "analog switches supplied by vdda\n");
> >>> +		clrmask = regs->booste_msk | regs->anaswvdd_msk;
> >>> +	}
> >>> +
> >>> +	mask = regs->booste_msk | regs->anaswvdd_msk;
> >>> +	if (regs->has_syscfg & HAS_CLEAR_REG) {
> >>> +		ret = regmap_write(priv->syscfg, regs->pmcc, clrmask);
> >>> +		if (ret) {
> >>> +			dev_err(dev, "syscfg clear failed, %d\n", ret);
> >>> +			goto vdd_dis;
> >>> +		}
> >>> +		mask = setmask;
> >>> +	}
> >>> +
> >>> +	ret = regmap_update_bits(priv->syscfg, regs->pmcr, mask, setmask);
> >>> +	if (ret) {
> >>> +		dev_err(dev, "syscfg update failed, %d\n", ret);
> >>> +		goto vdd_dis;
> >>> +	}
> >>> +
> >>> +	/* Booster voltage can take up to 50 us to stabilize */
> >>> +	if (setmask & regs->booste_msk)
> >>> +		usleep_range(50, 100);
> >>> +
> >>> +	return ret;
> >>> +
> >>> +vdd_dis:
> >>> +	if (priv->vdd && (regs->has_syscfg & HAS_ANASWVDD))
> >>> +		regulator_disable(priv->vdd);
> >>> +vdda_dis:
> >>> +	regulator_disable(priv->vdda);
> >>> +
> >>> +	return ret;
> >>> +}
> >>> +
> >>> +static void stm32_adc_core_switches_supply_dis(struct device *dev)
> >>> +{
> >>> +	struct stm32_adc_common *common = dev_get_drvdata(dev);
> >>> +	struct stm32_adc_priv *priv = to_stm32_adc_priv(common);
> >>> +	const struct stm32_adc_common_regs *regs = priv->cfg->regs;
> >>> +	u32 mask = regs->booste_msk | regs->anaswvdd_msk;
> >>> +
> >>> +	if (!regs->has_syscfg || !priv->vdda || !priv->syscfg)
> >>> +		return;
> >>> +
> >>> +	if (regs->has_syscfg & HAS_CLEAR_REG)
> >>> +		regmap_write(priv->syscfg, regs->pmcc, mask);
> >>> +	else
> >>> +		regmap_update_bits(priv->syscfg, regs->pmcr, mask, 0);
> >>> +
> >>> +	if (priv->vdd && (regs->has_syscfg & HAS_ANASWVDD))
> >>> +		regulator_disable(priv->vdd);
> >>> +
> >>> +	regulator_disable(priv->vdda);
> >>> +}
> >>> +
> >>>  static int stm32_adc_core_hw_start(struct device *dev)
> >>>  {
> >>>  	struct stm32_adc_common *common = dev_get_drvdata(dev);
> >>>  	struct stm32_adc_priv *priv = to_stm32_adc_priv(common);
> >>>  	int ret;
> >>>  
> >>> +	ret = stm32_adc_core_switches_supply_en(dev);
> >>> +	if (ret < 0)
> >>> +		return ret;
> >>> +
> >>>  	ret = regulator_enable(priv->vref);
> >>>  	if (ret < 0) {
> >>>  		dev_err(dev, "vref enable failed\n");
> >>> -		return ret;
> >>> +		goto err_switches_disable;
> >>>  	}
> >>>  
> >>>  	if (priv->bclk) {
> >>> @@ -425,6 +602,8 @@ static int stm32_adc_core_hw_start(struct device *dev)
> >>>  		clk_disable_unprepare(priv->bclk);
> >>>  err_regulator_disable:
> >>>  	regulator_disable(priv->vref);
> >>> +err_switches_disable:
> >>> +	stm32_adc_core_switches_supply_dis(dev);
> >>>  
> >>>  	return ret;
> >>>  }
> >>> @@ -441,6 +620,24 @@ static void stm32_adc_core_hw_stop(struct device *dev)
> >>>  	if (priv->bclk)
> >>>  		clk_disable_unprepare(priv->bclk);
> >>>  	regulator_disable(priv->vref);
> >>> +	stm32_adc_core_switches_supply_dis(dev);
> >>> +}
> >>> +
> >>> +static int stm32_adc_core_syscfg_probe(struct device_node *np,
> >>> +				       struct stm32_adc_priv *priv)
> >>> +{
> >>> +	if (!priv->cfg->regs->has_syscfg)
> >>> +		return 0;
> >>> +
> >>> +	priv->syscfg = syscon_regmap_lookup_by_phandle(np, "st,syscfg");
> >>> +	if (IS_ERR(priv->syscfg)) {
> >>> +		/* Optional */
> >>> +		if (PTR_ERR(priv->syscfg) != -ENODEV)
> >>> +			return PTR_ERR(priv->syscfg);
> >>> +		priv->syscfg = NULL;
> >>> +	}
> >>> +
> >>> +	return 0;
> >>>  }
> >>>  
> >>>  static int stm32_adc_probe(struct platform_device *pdev)
> >>> @@ -475,6 +672,30 @@ static int stm32_adc_probe(struct platform_device *pdev)
> >>>  		return ret;
> >>>  	}
> >>>  
> >>> +	priv->vdda = devm_regulator_get_optional(&pdev->dev, "vdda");
> >>> +	if (IS_ERR(priv->vdda)) {
> >>> +		ret = PTR_ERR(priv->vdda);
> >>> +		if (ret != -ENODEV) {
> >>> +			if (ret != -EPROBE_DEFER)
> >>> +				dev_err(&pdev->dev, "vdda get failed, %d\n",
> >>> +					ret);
> >>> +			return ret;
> >>> +		}
> >>> +		priv->vdda = NULL;
> >>> +	}
> >>> +
> >>> +	priv->vdd = devm_regulator_get_optional(&pdev->dev, "vdd");
> >>> +	if (IS_ERR(priv->vdd)) {
> >>> +		ret = PTR_ERR(priv->vdd);
> >>> +		if (ret != -ENODEV) {
> >>> +			if (ret != -EPROBE_DEFER)
> >>> +				dev_err(&pdev->dev, "vdd get failed, %d\n",
> >>> +					ret);
> >>> +			return ret;
> >>> +		}
> >>> +		priv->vdd = NULL;
> >>> +	}
> >>> +
> >>>  	priv->aclk = devm_clk_get(&pdev->dev, "adc");
> >>>  	if (IS_ERR(priv->aclk)) {
> >>>  		ret = PTR_ERR(priv->aclk);
> >>> @@ -495,6 +716,13 @@ static int stm32_adc_probe(struct platform_device *pdev)
> >>>  		priv->bclk = NULL;
> >>>  	}
> >>>  
> >>> +	ret = stm32_adc_core_syscfg_probe(np, priv);
> >>> +	if (ret) {
> >>> +		if (ret != -EPROBE_DEFER)
> >>> +			dev_err(&pdev->dev, "Can't probe syscfg: %d\n", ret);
> >>> +		return ret;
> >>> +	}
> >>> +
> >>>  	pm_runtime_get_noresume(dev);
> >>>  	pm_runtime_set_active(dev);
> >>>  	pm_runtime_set_autosuspend_delay(dev, STM32_ADC_CORE_SLEEP_DELAY_MS);
> >>> @@ -595,7 +823,7 @@ static const struct stm32_adc_priv_cfg stm32h7_adc_priv_cfg = {
> >>>  };
> >>>  
> >>>  static const struct stm32_adc_priv_cfg stm32mp1_adc_priv_cfg = {
> >>> -	.regs = &stm32h7_adc_common_regs,
> >>> +	.regs = &stm32mp1_adc_common_regs,
> >>>  	.clk_sel = stm32h7_adc_clk_sel,
> >>>  	.max_clk_rate_hz = 40000000,
> >>>  };  
> >>  

