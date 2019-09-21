Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 509E3B9F40
	for <lists+linux-iio@lfdr.de>; Sat, 21 Sep 2019 20:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfIUSCh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Sep 2019 14:02:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:58162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfIUSCh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Sep 2019 14:02:37 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D4FD2080F;
        Sat, 21 Sep 2019 18:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569088955;
        bh=99gy9UsmZhQxHRFU5g9lNPDPnf6xpbwKjEP7XEOVeks=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m6uWIOpS/jJNWVNjA79vLRDA6UNJtpJQ7SHOA5uERmFlS+Anm8NzoHWGLLtV9U5DS
         5I5rrsGC5UbFPovJ9boDNt3QCjANhC0MTUyxQ9ejUbgzOcxspz1oZYlWJmM5Fxp8Ep
         ELF4qyQtig4cNeBYDjHkfRevpq0igeqcwUjqU8a4=
Date:   Sat, 21 Sep 2019 19:02:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH v2 2/2] iio: adc: stm32-adc: fix a race when using
 several adcs with dma and irq
Message-ID: <20190921190230.7e90f20f@archlinux>
In-Reply-To: <1568723896-19063-3-git-send-email-fabrice.gasnier@st.com>
References: <1568723896-19063-1-git-send-email-fabrice.gasnier@st.com>
        <1568723896-19063-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Sep 2019 14:38:16 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> End of conversion may be handled by using IRQ or DMA. There may be a
> race when two conversions complete at the same time on several ADCs.
> EOC can be read as 'set' for several ADCs, with:
> - an ADC configured to use IRQs. EOCIE bit is set. The handler is normally
>   called in this case.
> - an ADC configured to use DMA. EOCIE bit isn't set. EOC triggers the DMA
>   request instead. It's then automatically cleared by DMA read. But the
>   handler gets called due to status bit is temporarily set (IRQ triggered
>   by the other ADC).
> So both EOC status bit in CSR and EOCIE control bit must be checked
> before invoking the interrupt handler (e.g. call ISR only for
> IRQ-enabled ADCs).
> 
> Fixes: 2763ea0585c9 ("iio: adc: stm32: add optional dma support")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Both applied to the fixes-togreg branch of iio.git and marked for
stable.

Thanks,

Jonathan

> ---
> Changes in v2:
> - Keep registers definitions as a whole block to ease readability (add
>   a precursor patch to move them to header file)
> ---
>  drivers/iio/adc/stm32-adc-core.c | 43 +++++++++++++++++++++++++++++++++++++---
>  drivers/iio/adc/stm32-adc-core.h |  1 +
>  2 files changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> index 84ac326..93a096a 100644
> --- a/drivers/iio/adc/stm32-adc-core.c
> +++ b/drivers/iio/adc/stm32-adc-core.c
> @@ -44,6 +44,8 @@
>   * @eoc1:	adc1 end of conversion flag in @csr
>   * @eoc2:	adc2 end of conversion flag in @csr
>   * @eoc3:	adc3 end of conversion flag in @csr
> + * @ier:	interrupt enable register offset for each adc
> + * @eocie_msk:	end of conversion interrupt enable mask in @ier
>   */
>  struct stm32_adc_common_regs {
>  	u32 csr;
> @@ -51,6 +53,8 @@ struct stm32_adc_common_regs {
>  	u32 eoc1_msk;
>  	u32 eoc2_msk;
>  	u32 eoc3_msk;
> +	u32 ier;
> +	u32 eocie_msk;
>  };
>  
>  struct stm32_adc_priv;
> @@ -276,6 +280,8 @@ static const struct stm32_adc_common_regs stm32f4_adc_common_regs = {
>  	.eoc1_msk = STM32F4_EOC1,
>  	.eoc2_msk = STM32F4_EOC2,
>  	.eoc3_msk = STM32F4_EOC3,
> +	.ier = STM32F4_ADC_CR1,
> +	.eocie_msk = STM32F4_EOCIE,
>  };
>  
>  /* STM32H7 common registers definitions */
> @@ -284,8 +290,24 @@ static const struct stm32_adc_common_regs stm32h7_adc_common_regs = {
>  	.ccr = STM32H7_ADC_CCR,
>  	.eoc1_msk = STM32H7_EOC_MST,
>  	.eoc2_msk = STM32H7_EOC_SLV,
> +	.ier = STM32H7_ADC_IER,
> +	.eocie_msk = STM32H7_EOCIE,
>  };
>  
> +static const unsigned int stm32_adc_offset[STM32_ADC_MAX_ADCS] = {
> +	0, STM32_ADC_OFFSET, STM32_ADC_OFFSET * 2,
> +};
> +
> +static unsigned int stm32_adc_eoc_enabled(struct stm32_adc_priv *priv,
> +					  unsigned int adc)
> +{
> +	u32 ier, offset = stm32_adc_offset[adc];
> +
> +	ier = readl_relaxed(priv->common.base + offset + priv->cfg->regs->ier);
> +
> +	return ier & priv->cfg->regs->eocie_msk;
> +}
> +
>  /* ADC common interrupt for all instances */
>  static void stm32_adc_irq_handler(struct irq_desc *desc)
>  {
> @@ -296,13 +318,28 @@ static void stm32_adc_irq_handler(struct irq_desc *desc)
>  	chained_irq_enter(chip, desc);
>  	status = readl_relaxed(priv->common.base + priv->cfg->regs->csr);
>  
> -	if (status & priv->cfg->regs->eoc1_msk)
> +	/*
> +	 * End of conversion may be handled by using IRQ or DMA. There may be a
> +	 * race here when two conversions complete at the same time on several
> +	 * ADCs. EOC may be read 'set' for several ADCs, with:
> +	 * - an ADC configured to use DMA (EOC triggers the DMA request, and
> +	 *   is then automatically cleared by DR read in hardware)
> +	 * - an ADC configured to use IRQs (EOCIE bit is set. The handler must
> +	 *   be called in this case)
> +	 * So both EOC status bit in CSR and EOCIE control bit must be checked
> +	 * before invoking the interrupt handler (e.g. call ISR only for
> +	 * IRQ-enabled ADCs).
> +	 */
> +	if (status & priv->cfg->regs->eoc1_msk &&
> +	    stm32_adc_eoc_enabled(priv, 0))
>  		generic_handle_irq(irq_find_mapping(priv->domain, 0));
>  
> -	if (status & priv->cfg->regs->eoc2_msk)
> +	if (status & priv->cfg->regs->eoc2_msk &&
> +	    stm32_adc_eoc_enabled(priv, 1))
>  		generic_handle_irq(irq_find_mapping(priv->domain, 1));
>  
> -	if (status & priv->cfg->regs->eoc3_msk)
> +	if (status & priv->cfg->regs->eoc3_msk &&
> +	    stm32_adc_eoc_enabled(priv, 2))
>  		generic_handle_irq(irq_find_mapping(priv->domain, 2));
>  
>  	chained_irq_exit(chip, desc);
> diff --git a/drivers/iio/adc/stm32-adc-core.h b/drivers/iio/adc/stm32-adc-core.h
> index 94aa2d2..2579d51 100644
> --- a/drivers/iio/adc/stm32-adc-core.h
> +++ b/drivers/iio/adc/stm32-adc-core.h
> @@ -25,6 +25,7 @@
>   * --------------------------------------------------------
>   */
>  #define STM32_ADC_MAX_ADCS		3
> +#define STM32_ADC_OFFSET		0x100
>  #define STM32_ADCX_COMN_OFFSET		0x300
>  
>  /* STM32F4 - Registers for each ADC instance */

