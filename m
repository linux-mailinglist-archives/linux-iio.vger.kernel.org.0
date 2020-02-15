Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0801915FFC3
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2020 19:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgBOSll (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Feb 2020 13:41:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:37868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgBOSlk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Feb 2020 13:41:40 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94AAC2072D;
        Sat, 15 Feb 2020 18:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581792100;
        bh=BjBazr4WmmuTjxM5m3H0niFodBZruveqbCGfq9sC65Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=djgmAQXjqo+MlqzTZc00spUUBrsvrHJZoZRFnHI9BzjfTLivfrp5FNipSdfQfqJLi
         BqANi0V7cfltMJT0voJbWwGrIDwFYflw/eT7iFq6/Z8C/njlTvZQT2zhYZc4DWPJlo
         m2oCHozWKKl/O/5UqGl+ElpKIcR14X8IyJDeTu7w=
Date:   Sat, 15 Feb 2020 18:41:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <benjamin.gaignard@st.com>, <alexandre.torgue@st.com>,
        <olivier.moysan@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] iio: trigger: stm32-timer: disable master mode when
 stopping
Message-ID: <20200215184135.10af9907@archlinux>
In-Reply-To: <1581698795-437-1-git-send-email-fabrice.gasnier@st.com>
References: <1581698795-437-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 14 Feb 2020 17:46:35 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Master mode should be disabled when stopping. This mainly impacts
> possible other use-case after timer has been stopped. Currently,
> master mode remains set (from start routine).
> 
> Fixes: 6fb34812c2a2 ("iio: stm32 trigger: Add support for TRGO2 triggers")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
I 'think' this is tangential to the other changes to this driver recently
and you seem to have prepared this against current mailine.

Hence applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/trigger/stm32-timer-trigger.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
> index 2e0d32a..2f82e8c 100644
> --- a/drivers/iio/trigger/stm32-timer-trigger.c
> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
> @@ -161,7 +161,8 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
>  	return 0;
>  }
>  
> -static void stm32_timer_stop(struct stm32_timer_trigger *priv)
> +static void stm32_timer_stop(struct stm32_timer_trigger *priv,
> +			     struct iio_trigger *trig)
>  {
>  	u32 ccer, cr1;
>  
> @@ -179,6 +180,12 @@ static void stm32_timer_stop(struct stm32_timer_trigger *priv)
>  	regmap_write(priv->regmap, TIM_PSC, 0);
>  	regmap_write(priv->regmap, TIM_ARR, 0);
>  
> +	/* Force disable master mode */
> +	if (stm32_timer_is_trgo2_name(trig->name))
> +		regmap_update_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS2, 0);
> +	else
> +		regmap_update_bits(priv->regmap, TIM_CR2, TIM_CR2_MMS, 0);
> +
>  	/* Make sure that registers are updated */
>  	regmap_update_bits(priv->regmap, TIM_EGR, TIM_EGR_UG, TIM_EGR_UG);
>  }
> @@ -197,7 +204,7 @@ static ssize_t stm32_tt_store_frequency(struct device *dev,
>  		return ret;
>  
>  	if (freq == 0) {
> -		stm32_timer_stop(priv);
> +		stm32_timer_stop(priv, trig);
>  	} else {
>  		ret = stm32_timer_start(priv, trig, freq);
>  		if (ret)

