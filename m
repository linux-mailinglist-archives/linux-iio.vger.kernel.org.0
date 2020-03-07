Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9A017CF00
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 16:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgCGPUk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 10:20:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:52536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgCGPUk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Mar 2020 10:20:40 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FC6D20674;
        Sat,  7 Mar 2020 15:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583594439;
        bh=WXObIi33XmoyMwmcEZvaU65yLjmbN66OToWMCu6nPyE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FV+tBombC10mD94wQu/owOffP+3osxZtdkbQHT2q9THGErYc3/8iSvySgWfc89yyw
         NoiEst1cjF1D/c+/yUYQQt5IIACUVC++KmwWImLlyNWgkWnOBcppBH6CsloyMsVl73
         G9iYUgHc4YxqVoeAFFl6RGOgoc9z+8Umw5WMSdFw=
Date:   Sat, 7 Mar 2020 15:20:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <benjamin.gaignard@st.com>, <alexandre.torgue@st.com>,
        <olivier.moysan@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 1/2] iio: trigger: stm32-timer: rename enabled flag
Message-ID: <20200307152034.0d7e01a5@archlinux>
In-Reply-To: <1583247585-16698-2-git-send-email-fabrice.gasnier@st.com>
References: <1583247585-16698-1-git-send-email-fabrice.gasnier@st.com>
        <1583247585-16698-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 3 Mar 2020 15:59:44 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> "clk_enabled" flag reflects enabled state of the timer, for master mode,
> slave mode or trigger (with sampling_frequency). So rename it to "enabled".
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/trigger/stm32-timer-trigger.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
> index 16a3b6b..32e1249 100644
> --- a/drivers/iio/trigger/stm32-timer-trigger.c
> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
> @@ -79,7 +79,7 @@ struct stm32_timer_trigger {
>  	struct device *dev;
>  	struct regmap *regmap;
>  	struct clk *clk;
> -	bool clk_enabled;
> +	bool enabled;
>  	u32 max_arr;
>  	const void *triggers;
>  	const void *valids;
> @@ -140,8 +140,8 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
>  		return -EBUSY;
>  
>  	mutex_lock(&priv->lock);
> -	if (!priv->clk_enabled) {
> -		priv->clk_enabled = true;
> +	if (!priv->enabled) {
> +		priv->enabled = true;
>  		clk_enable(priv->clk);
>  	}
>  
> @@ -185,8 +185,8 @@ static void stm32_timer_stop(struct stm32_timer_trigger *priv)
>  	/* Make sure that registers are updated */
>  	regmap_update_bits(priv->regmap, TIM_EGR, TIM_EGR_UG, TIM_EGR_UG);
>  
> -	if (priv->clk_enabled) {
> -		priv->clk_enabled = false;
> +	if (priv->enabled) {
> +		priv->enabled = false;
>  		clk_disable(priv->clk);
>  	}
>  	mutex_unlock(&priv->lock);
> @@ -305,9 +305,9 @@ static ssize_t stm32_tt_store_master_mode(struct device *dev,
>  		if (!strncmp(master_mode_table[i], buf,
>  			     strlen(master_mode_table[i]))) {
>  			mutex_lock(&priv->lock);
> -			if (!priv->clk_enabled) {
> +			if (!priv->enabled) {
>  				/* Clock should be enabled first */
> -				priv->clk_enabled = true;
> +				priv->enabled = true;
>  				clk_enable(priv->clk);
>  			}
>  			regmap_update_bits(priv->regmap, TIM_CR2, mask,
> @@ -476,8 +476,8 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_ENABLE:
>  		mutex_lock(&priv->lock);
>  		if (val) {
> -			if (!priv->clk_enabled) {
> -				priv->clk_enabled = true;
> +			if (!priv->enabled) {
> +				priv->enabled = true;
>  				clk_enable(priv->clk);
>  			}
>  			regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN,
> @@ -485,8 +485,8 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
>  		} else {
>  			regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN,
>  					   0);
> -			if (priv->clk_enabled) {
> -				priv->clk_enabled = false;
> +			if (priv->enabled) {
> +				priv->enabled = false;
>  				clk_disable(priv->clk);
>  			}
>  		}
> @@ -594,9 +594,9 @@ static int stm32_set_enable_mode(struct iio_dev *indio_dev,
>  	 * enable counter clock, so it can use it. Keeps it in sync with CEN.
>  	 */
>  	mutex_lock(&priv->lock);
> -	if (sms == 6 && !priv->clk_enabled) {
> +	if (sms == 6 && !priv->enabled) {
>  		clk_enable(priv->clk);
> -		priv->clk_enabled = true;
> +		priv->enabled = true;
>  	}
>  	mutex_unlock(&priv->lock);
>  
> @@ -806,7 +806,7 @@ static int stm32_timer_trigger_remove(struct platform_device *pdev)
>  	if (!(val & TIM_CCER_CCXE))
>  		regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
>  
> -	if (priv->clk_enabled)
> +	if (priv->enabled)
>  		clk_disable(priv->clk);
>  
>  	return 0;

