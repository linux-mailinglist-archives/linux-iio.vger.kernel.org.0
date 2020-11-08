Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3BA2AABDA
	for <lists+linux-iio@lfdr.de>; Sun,  8 Nov 2020 16:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgKHPSf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Nov 2020 10:18:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:48898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727844AbgKHPSe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Nov 2020 10:18:34 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BECD206B2;
        Sun,  8 Nov 2020 15:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604848714;
        bh=0CKqtqq+aeOYU19z0fE06Ud/SoL1fEHH0qhlYS0YDvA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q9I7aJ5FbsgvzNIO+z+3NEbam63dMAi7KBjxsSj5vfVcm4uc9lcktJmnH7JHQ9noV
         q7Pip2DbokpPTkthZV87efexmfNYuhUWO2FYwR/Y2ZTu3Qj7d+rZ6NirYkDD7QQOAd
         6mnaOyVj4H/j+8PnbUxlJUOd0TwdrqqiOykqmhCU=
Date:   Sun, 8 Nov 2020 15:18:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <alexandre.torgue@st.com>,
        <olivier.moysan@st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] iio: adc: stm32-adc: adapt clock duty cycle for proper
 operation
Message-ID: <20201108151835.5d78ebca@archlinux>
In-Reply-To: <1604681846-31234-1-git-send-email-fabrice.gasnier@st.com>
References: <1604681846-31234-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 6 Nov 2020 17:57:26 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> For proper operation, STM32 ADC should be used with a clock duty cycle
> of 50%, in the range of 49% to 51%. Depending on the clock tree, divider
> can be used in case clock duty cycle is out of this range.
> In case clk_get_scaled_duty_cycle() returns an error, kindly apply a
> divider by default (don't make the probe fail).
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Hi Fabrice,

This sounds like it's a fix for a situation in which the device is not
currently working?  If so, please let me know a fixes tag.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-adc-core.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> index cd870c0..d64a9e8 100644
> --- a/drivers/iio/adc/stm32-adc-core.c
> +++ b/drivers/iio/adc/stm32-adc-core.c
> @@ -202,7 +202,7 @@ static int stm32h7_adc_clk_sel(struct platform_device *pdev,
>  {
>  	u32 ckmode, presc, val;
>  	unsigned long rate;
> -	int i, div;
> +	int i, div, duty;
>  
>  	/* stm32h7 bus clock is common for all ADC instances (mandatory) */
>  	if (!priv->bclk) {
> @@ -226,6 +226,11 @@ static int stm32h7_adc_clk_sel(struct platform_device *pdev,
>  			return -EINVAL;
>  		}
>  
> +		/* If duty is an error, kindly use at least /2 divider */
> +		duty = clk_get_scaled_duty_cycle(priv->aclk, 100);
> +		if (duty < 0)
> +			dev_warn(&pdev->dev, "adc clock duty: %d\n", duty);
> +
>  		for (i = 0; i < ARRAY_SIZE(stm32h7_adc_ckmodes_spec); i++) {
>  			ckmode = stm32h7_adc_ckmodes_spec[i].ckmode;
>  			presc = stm32h7_adc_ckmodes_spec[i].presc;
> @@ -234,6 +239,13 @@ static int stm32h7_adc_clk_sel(struct platform_device *pdev,
>  			if (ckmode)
>  				continue;
>  
> +			/*
> +			 * For proper operation, clock duty cycle range is 49%
> +			 * to 51%. Apply at least /2 prescaler otherwise.
> +			 */
> +			if (div == 1 && (duty < 49 || duty > 51))
> +				continue;
> +
>  			if ((rate / div) <= priv->max_clk_rate)
>  				goto out;
>  		}
> @@ -246,6 +258,10 @@ static int stm32h7_adc_clk_sel(struct platform_device *pdev,
>  		return -EINVAL;
>  	}
>  
> +	duty = clk_get_scaled_duty_cycle(priv->bclk, 100);
> +	if (duty < 0)
> +		dev_warn(&pdev->dev, "bus clock duty: %d\n", duty);
> +
>  	for (i = 0; i < ARRAY_SIZE(stm32h7_adc_ckmodes_spec); i++) {
>  		ckmode = stm32h7_adc_ckmodes_spec[i].ckmode;
>  		presc = stm32h7_adc_ckmodes_spec[i].presc;
> @@ -254,6 +270,9 @@ static int stm32h7_adc_clk_sel(struct platform_device *pdev,
>  		if (!ckmode)
>  			continue;
>  
> +		if (div == 1 && (duty < 49 || duty > 51))
> +			continue;
> +
>  		if ((rate / div) <= priv->max_clk_rate)
>  			goto out;
>  	}

