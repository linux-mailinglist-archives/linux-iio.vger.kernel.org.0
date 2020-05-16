Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9243C1D62D6
	for <lists+linux-iio@lfdr.de>; Sat, 16 May 2020 19:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgEPRBr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 May 2020 13:01:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbgEPRBr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 May 2020 13:01:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51EF92065C;
        Sat, 16 May 2020 17:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589648506;
        bh=7QsFKj7aDiV0u0TfxeKG4ZEc/hLCVajx0FV8HvcbpUs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o6QAiMzJhMKNwW7prZLLng13R3+ZGftsXinmPSrLyGjXCIC3sAZFRwQ/kZsUdSiAm
         s8tZrgq0RgWgIpmgiXuXeajgbFAgHUohQsB5/UDAUOfxa9wGyIgmIa6So8GOeuVwMV
         NO72LkUozyh+2eb0udsHr11RPE36ToA96bGIWeH4=
Date:   Sat, 16 May 2020 18:01:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <olivier.moysan@st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] iio: adc: stm32-adc: fix a wrong error message when
 probing interrupts
Message-ID: <20200516180142.5ed10edc@archlinux>
In-Reply-To: <1589290025-23857-1-git-send-email-fabrice.gasnier@st.com>
References: <1589290025-23857-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 12 May 2020 15:27:05 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> A wrong error message is printed out currently, like on STM32MP15:
> - stm32-adc-core 48003000.adc: IRQ index 2 not found.
> 
> This is seen since commit 7723f4c5ecdb ("driver core: platform: Add an
> error message to platform_get_irq*()").
> The STM32 ADC core driver wrongly requests up to 3 interrupt lines. It
> should request only the necessary IRQs, based on the compatible:
> - stm32f4/h7 ADCs share a common interrupt
> - stm32mp1, has one interrupt line per ADC.
> So add the number of required interrupts to the compatible data.
> 
> Fixes: d58c67d1d851 ("iio: adc: stm32-adc: add support for STM32MP1")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.
Whilst it's only an incorrect error message it is likely to make
people think something is broken, hence the stable marking.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-adc-core.c | 34 ++++++++++++++--------------------
>  1 file changed, 14 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> index ebe5dbc..3586369 100644
> --- a/drivers/iio/adc/stm32-adc-core.c
> +++ b/drivers/iio/adc/stm32-adc-core.c
> @@ -65,12 +65,14 @@ struct stm32_adc_priv;
>   * @clk_sel:	clock selection routine
>   * @max_clk_rate_hz: maximum analog clock rate (Hz, from datasheet)
>   * @has_syscfg: SYSCFG capability flags
> + * @num_irqs:	number of interrupt lines
>   */
>  struct stm32_adc_priv_cfg {
>  	const struct stm32_adc_common_regs *regs;
>  	int (*clk_sel)(struct platform_device *, struct stm32_adc_priv *);
>  	u32 max_clk_rate_hz;
>  	unsigned int has_syscfg;
> +	unsigned int num_irqs;
>  };
>  
>  /**
> @@ -375,21 +377,15 @@ static int stm32_adc_irq_probe(struct platform_device *pdev,
>  	struct device_node *np = pdev->dev.of_node;
>  	unsigned int i;
>  
> -	for (i = 0; i < STM32_ADC_MAX_ADCS; i++) {
> +	/*
> +	 * Interrupt(s) must be provided, depending on the compatible:
> +	 * - stm32f4/h7 shares a common interrupt line.
> +	 * - stm32mp1, has one line per ADC
> +	 */
> +	for (i = 0; i < priv->cfg->num_irqs; i++) {
>  		priv->irq[i] = platform_get_irq(pdev, i);
> -		if (priv->irq[i] < 0) {
> -			/*
> -			 * At least one interrupt must be provided, make others
> -			 * optional:
> -			 * - stm32f4/h7 shares a common interrupt.
> -			 * - stm32mp1, has one line per ADC (either for ADC1,
> -			 *   ADC2 or both).
> -			 */
> -			if (i && priv->irq[i] == -ENXIO)
> -				continue;
> -
> +		if (priv->irq[i] < 0)
>  			return priv->irq[i];
> -		}
>  	}
>  
>  	priv->domain = irq_domain_add_simple(np, STM32_ADC_MAX_ADCS, 0,
> @@ -400,9 +396,7 @@ static int stm32_adc_irq_probe(struct platform_device *pdev,
>  		return -ENOMEM;
>  	}
>  
> -	for (i = 0; i < STM32_ADC_MAX_ADCS; i++) {
> -		if (priv->irq[i] < 0)
> -			continue;
> +	for (i = 0; i < priv->cfg->num_irqs; i++) {
>  		irq_set_chained_handler(priv->irq[i], stm32_adc_irq_handler);
>  		irq_set_handler_data(priv->irq[i], priv);
>  	}
> @@ -420,11 +414,8 @@ static void stm32_adc_irq_remove(struct platform_device *pdev,
>  		irq_dispose_mapping(irq_find_mapping(priv->domain, hwirq));
>  	irq_domain_remove(priv->domain);
>  
> -	for (i = 0; i < STM32_ADC_MAX_ADCS; i++) {
> -		if (priv->irq[i] < 0)
> -			continue;
> +	for (i = 0; i < priv->cfg->num_irqs; i++)
>  		irq_set_chained_handler(priv->irq[i], NULL);
> -	}
>  }
>  
>  static int stm32_adc_core_switches_supply_en(struct stm32_adc_priv *priv,
> @@ -824,6 +815,7 @@ static const struct stm32_adc_priv_cfg stm32f4_adc_priv_cfg = {
>  	.regs = &stm32f4_adc_common_regs,
>  	.clk_sel = stm32f4_adc_clk_sel,
>  	.max_clk_rate_hz = 36000000,
> +	.num_irqs = 1,
>  };
>  
>  static const struct stm32_adc_priv_cfg stm32h7_adc_priv_cfg = {
> @@ -831,6 +823,7 @@ static const struct stm32_adc_priv_cfg stm32h7_adc_priv_cfg = {
>  	.clk_sel = stm32h7_adc_clk_sel,
>  	.max_clk_rate_hz = 36000000,
>  	.has_syscfg = HAS_VBOOSTER,
> +	.num_irqs = 1,
>  };
>  
>  static const struct stm32_adc_priv_cfg stm32mp1_adc_priv_cfg = {
> @@ -838,6 +831,7 @@ static const struct stm32_adc_priv_cfg stm32mp1_adc_priv_cfg = {
>  	.clk_sel = stm32h7_adc_clk_sel,
>  	.max_clk_rate_hz = 40000000,
>  	.has_syscfg = HAS_VBOOSTER | HAS_ANASWVDD,
> +	.num_irqs = 2,
>  };
>  
>  static const struct of_device_id stm32_adc_of_match[] = {

