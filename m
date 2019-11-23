Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 405E6107E34
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2019 12:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfKWLga (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Nov 2019 06:36:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:48718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbfKWLga (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Nov 2019 06:36:30 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E4D020714;
        Sat, 23 Nov 2019 11:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574508989;
        bh=w5hRKl3lev3WlHSYRkRgSl5GJDTQTvjT7oNTHcFl+FQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LMCVXVRpBEuJD3ikBz8XGPjj8jKvAWeTK1IIrKUkNJo4kM0L8XFLa3mLVw2hc0r5/
         tJPeDJLPtFEK7TUjPkY9toET/kbFMPXpypqnUEJfmElzbYBH26d4bPW163phpDtu7n
         wmqmqbmZUP1WALPFpAj8Bmmu9QoIvSy/9d8uSmsM=
Date:   Sat, 23 Nov 2019 11:36:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] iio: adc: stm32-adc: Add check on overrun interrupt
Message-ID: <20191123113623.3e58b2d1@archlinux>
In-Reply-To: <1574435294-19510-1-git-send-email-fabrice.gasnier@st.com>
References: <1574435294-19510-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 22 Nov 2019 16:08:14 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Enable overrun interrupt on STM32 ADC. In case data register hasn't been
> read (by CPU or DMA), overrun condition is detected when there's new
> conversion data available. Stop grabbing data and log an error message.
> Use a threaded irq to avoid printing the error message from hard irq
> context.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Absolutely makes sense to notify the user this occurred and to stop
the current process.  It may be useful to give a hint on how
to restart capture?

Is this a condition that can occur under 'normal conditions' such
as something else grabbing the CPU for too long?

I'd just like to understand if we are dealing with a 'fault'
case of just one where things go wrong under weird conditions.

Patch itself looks fine.

Thanks,

Jonathan


> ---
>  drivers/iio/adc/stm32-adc-core.c | 14 +++++------
>  drivers/iio/adc/stm32-adc-core.h |  9 +++++++
>  drivers/iio/adc/stm32-adc.c      | 53 ++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 67 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> index 6537f4f..97655d7 100644
> --- a/drivers/iio/adc/stm32-adc-core.c
> +++ b/drivers/iio/adc/stm32-adc-core.c
> @@ -280,21 +280,21 @@ static int stm32h7_adc_clk_sel(struct platform_device *pdev,
>  static const struct stm32_adc_common_regs stm32f4_adc_common_regs = {
>  	.csr = STM32F4_ADC_CSR,
>  	.ccr = STM32F4_ADC_CCR,
> -	.eoc1_msk = STM32F4_EOC1,
> -	.eoc2_msk = STM32F4_EOC2,
> -	.eoc3_msk = STM32F4_EOC3,
> +	.eoc1_msk = STM32F4_EOC1 | STM32F4_OVR1,
> +	.eoc2_msk = STM32F4_EOC2 | STM32F4_OVR2,
> +	.eoc3_msk = STM32F4_EOC3 | STM32F4_OVR3,
>  	.ier = STM32F4_ADC_CR1,
> -	.eocie_msk = STM32F4_EOCIE,
> +	.eocie_msk = STM32F4_EOCIE | STM32F4_OVRIE,
>  };
>  
>  /* STM32H7 common registers definitions */
>  static const struct stm32_adc_common_regs stm32h7_adc_common_regs = {
>  	.csr = STM32H7_ADC_CSR,
>  	.ccr = STM32H7_ADC_CCR,
> -	.eoc1_msk = STM32H7_EOC_MST,
> -	.eoc2_msk = STM32H7_EOC_SLV,
> +	.eoc1_msk = STM32H7_EOC_MST | STM32H7_OVR_MST,
> +	.eoc2_msk = STM32H7_EOC_SLV | STM32H7_OVR_SLV,
>  	.ier = STM32H7_ADC_IER,
> -	.eocie_msk = STM32H7_EOCIE,
> +	.eocie_msk = STM32H7_EOCIE | STM32H7_OVRIE,
>  };
>  
>  static const unsigned int stm32_adc_offset[STM32_ADC_MAX_ADCS] = {
> diff --git a/drivers/iio/adc/stm32-adc-core.h b/drivers/iio/adc/stm32-adc-core.h
> index 2579d51..2322809 100644
> --- a/drivers/iio/adc/stm32-adc-core.h
> +++ b/drivers/iio/adc/stm32-adc-core.h
> @@ -51,10 +51,12 @@
>  #define STM32F4_ADC_CCR			(STM32_ADCX_COMN_OFFSET + 0x04)
>  
>  /* STM32F4_ADC_SR - bit fields */
> +#define STM32F4_OVR			BIT(5)
>  #define STM32F4_STRT			BIT(4)
>  #define STM32F4_EOC			BIT(1)
>  
>  /* STM32F4_ADC_CR1 - bit fields */
> +#define STM32F4_OVRIE			BIT(26)
>  #define STM32F4_RES_SHIFT		24
>  #define STM32F4_RES_MASK		GENMASK(25, 24)
>  #define STM32F4_SCAN			BIT(8)
> @@ -72,8 +74,11 @@
>  #define STM32F4_ADON			BIT(0)
>  
>  /* STM32F4_ADC_CSR - bit fields */
> +#define STM32F4_OVR3			BIT(21)
>  #define STM32F4_EOC3			BIT(17)
> +#define STM32F4_OVR2			BIT(13)
>  #define STM32F4_EOC2			BIT(9)
> +#define STM32F4_OVR1			BIT(5)
>  #define STM32F4_EOC1			BIT(1)
>  
>  /* STM32F4_ADC_CCR - bit fields */
> @@ -103,10 +108,12 @@
>  
>  /* STM32H7_ADC_ISR - bit fields */
>  #define STM32MP1_VREGREADY		BIT(12)
> +#define STM32H7_OVR			BIT(4)
>  #define STM32H7_EOC			BIT(2)
>  #define STM32H7_ADRDY			BIT(0)
>  
>  /* STM32H7_ADC_IER - bit fields */
> +#define STM32H7_OVRIE			STM32H7_OVR
>  #define STM32H7_EOCIE			STM32H7_EOC
>  
>  /* STM32H7_ADC_CR - bit fields */
> @@ -155,7 +162,9 @@ enum stm32h7_adc_dmngt {
>  #define STM32H7_LINCALFACT_MASK		GENMASK(29, 0)
>  
>  /* STM32H7_ADC_CSR - bit fields */
> +#define STM32H7_OVR_SLV			BIT(20)
>  #define STM32H7_EOC_SLV			BIT(18)
> +#define STM32H7_OVR_MST			BIT(4)
>  #define STM32H7_EOC_MST			BIT(2)
>  
>  /* STM32H7_ADC_CCR - bit fields */
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 3b291d7..9361f92 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -117,7 +117,9 @@ struct stm32_adc_regs {
>   * struct stm32_adc_regspec - stm32 registers definition
>   * @dr:			data register offset
>   * @ier_eoc:		interrupt enable register & eocie bitfield
> + * @ier_ovr:		interrupt enable register & overrun bitfield
>   * @isr_eoc:		interrupt status register & eoc bitfield
> + * @isr_ovr:		interrupt status register & overrun bitfield
>   * @sqr:		reference to sequence registers array
>   * @exten:		trigger control register & bitfield
>   * @extsel:		trigger selection register & bitfield
> @@ -128,7 +130,9 @@ struct stm32_adc_regs {
>  struct stm32_adc_regspec {
>  	const u32 dr;
>  	const struct stm32_adc_regs ier_eoc;
> +	const struct stm32_adc_regs ier_ovr;
>  	const struct stm32_adc_regs isr_eoc;
> +	const struct stm32_adc_regs isr_ovr;
>  	const struct stm32_adc_regs *sqr;
>  	const struct stm32_adc_regs exten;
>  	const struct stm32_adc_regs extsel;
> @@ -337,7 +341,9 @@ static const unsigned int stm32f4_adc_smp_cycles[STM32_ADC_MAX_SMP + 1] = {
>  static const struct stm32_adc_regspec stm32f4_adc_regspec = {
>  	.dr = STM32F4_ADC_DR,
>  	.ier_eoc = { STM32F4_ADC_CR1, STM32F4_EOCIE },
> +	.ier_ovr = { STM32F4_ADC_CR1, STM32F4_OVRIE },
>  	.isr_eoc = { STM32F4_ADC_SR, STM32F4_EOC },
> +	.isr_ovr = { STM32F4_ADC_SR, STM32F4_OVR },
>  	.sqr = stm32f4_sq,
>  	.exten = { STM32F4_ADC_CR2, STM32F4_EXTEN_MASK, STM32F4_EXTEN_SHIFT },
>  	.extsel = { STM32F4_ADC_CR2, STM32F4_EXTSEL_MASK,
> @@ -429,7 +435,9 @@ static const unsigned int stm32h7_adc_smp_cycles[STM32_ADC_MAX_SMP + 1] = {
>  static const struct stm32_adc_regspec stm32h7_adc_regspec = {
>  	.dr = STM32H7_ADC_DR,
>  	.ier_eoc = { STM32H7_ADC_IER, STM32H7_EOCIE },
> +	.ier_ovr = { STM32H7_ADC_IER, STM32H7_OVRIE },
>  	.isr_eoc = { STM32H7_ADC_ISR, STM32H7_EOC },
> +	.isr_ovr = { STM32H7_ADC_ISR, STM32H7_OVR },
>  	.sqr = stm32h7_sq,
>  	.exten = { STM32H7_ADC_CFGR, STM32H7_EXTEN_MASK, STM32H7_EXTEN_SHIFT },
>  	.extsel = { STM32H7_ADC_CFGR, STM32H7_EXTSEL_MASK,
> @@ -506,6 +514,18 @@ static void stm32_adc_conv_irq_disable(struct stm32_adc *adc)
>  			   adc->cfg->regs->ier_eoc.mask);
>  }
>  
> +static void stm32_adc_ovr_irq_enable(struct stm32_adc *adc)
> +{
> +	stm32_adc_set_bits(adc, adc->cfg->regs->ier_ovr.reg,
> +			   adc->cfg->regs->ier_ovr.mask);
> +}
> +
> +static void stm32_adc_ovr_irq_disable(struct stm32_adc *adc)
> +{
> +	stm32_adc_clr_bits(adc, adc->cfg->regs->ier_ovr.reg,
> +			   adc->cfg->regs->ier_ovr.mask);
> +}
> +
>  static void stm32_adc_set_res(struct stm32_adc *adc)
>  {
>  	const struct stm32_adc_regs *res = &adc->cfg->regs->res;
> @@ -1205,6 +1225,19 @@ static int stm32_adc_read_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static irqreturn_t stm32_adc_threaded_isr(int irq, void *data)
> +{
> +	struct stm32_adc *adc = data;
> +	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +	const struct stm32_adc_regspec *regs = adc->cfg->regs;
> +	u32 status = stm32_adc_readl(adc, regs->isr_eoc.reg);
> +
> +	if (status & regs->isr_ovr.mask)
> +		dev_err(&indio_dev->dev, "Overrun interrupt, stopping.\n");
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static irqreturn_t stm32_adc_isr(int irq, void *data)
>  {
>  	struct stm32_adc *adc = data;
> @@ -1212,6 +1245,17 @@ static irqreturn_t stm32_adc_isr(int irq, void *data)
>  	const struct stm32_adc_regspec *regs = adc->cfg->regs;
>  	u32 status = stm32_adc_readl(adc, regs->isr_eoc.reg);
>  
> +	if (status & regs->isr_ovr.mask) {
> +		/*
> +		 * Overrun occurred on regular conversions: data for wrong
> +		 * channel may be read. Unconditionally disable interrupts
> +		 * to stop processing data and print error message.
> +		 */
> +		stm32_adc_ovr_irq_disable(adc);
> +		stm32_adc_conv_irq_disable(adc);
> +		return IRQ_WAKE_THREAD;
> +	}
> +
>  	if (status & regs->isr_eoc.mask) {
>  		/* Reading DR also clears EOC status flag */
>  		adc->buffer[adc->bufi] = stm32_adc_readw(adc, regs->dr);
> @@ -1441,6 +1485,8 @@ static int __stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
>  	/* Reset adc buffer index */
>  	adc->bufi = 0;
>  
> +	stm32_adc_ovr_irq_enable(adc);
> +
>  	if (!adc->dma_chan)
>  		stm32_adc_conv_irq_enable(adc);
>  
> @@ -1481,6 +1527,8 @@ static void __stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
>  	if (!adc->dma_chan)
>  		stm32_adc_conv_irq_disable(adc);
>  
> +	stm32_adc_ovr_irq_disable(adc);
> +
>  	if (adc->dma_chan)
>  		dmaengine_terminate_sync(adc->dma_chan);
>  
> @@ -1818,8 +1866,9 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  	if (adc->irq < 0)
>  		return adc->irq;
>  
> -	ret = devm_request_irq(&pdev->dev, adc->irq, stm32_adc_isr,
> -			       0, pdev->name, adc);
> +	ret = devm_request_threaded_irq(&pdev->dev, adc->irq, stm32_adc_isr,
> +					stm32_adc_threaded_isr,
> +					0, pdev->name, adc);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to request IRQ\n");
>  		return ret;

