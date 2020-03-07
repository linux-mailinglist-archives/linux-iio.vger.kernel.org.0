Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56A3F17CF05
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 16:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgCGPVf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 10:21:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:53084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgCGPVf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Mar 2020 10:21:35 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CCB020674;
        Sat,  7 Mar 2020 15:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583594494;
        bh=zXhA3RoLELcyY2UKL8bcqbSijN27udDZjliB55Zc+PM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eH3omeFiyPeHhZ9l62cNGCJmGil5/S2xcf4vhQoBUjPoOWVnsBYBk4gShULYCrSod
         IdEaczUOrw4cfLWzoM4VAiNV9Vswma2J6qsiaghim6DUNPRFrFW0JuMxPiGK9mCOBn
         vq8r9qma/eAE8YbYkWUXx3i6r9W5gPVV2ZZaRZ1o=
Date:   Sat, 7 Mar 2020 15:21:27 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <benjamin.gaignard@st.com>, <alexandre.torgue@st.com>,
        <olivier.moysan@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 2/2] iio: trigger: stm32-timer: add power management
 support
Message-ID: <20200307152127.404aba78@archlinux>
In-Reply-To: <1583247585-16698-3-git-send-email-fabrice.gasnier@st.com>
References: <1583247585-16698-1-git-send-email-fabrice.gasnier@st.com>
        <1583247585-16698-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 3 Mar 2020 15:59:45 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Add suspend/resume PM sleep ops to stm32-timer-trigger driver.
> Register contents may be lost depending on low power modes.
> When going to low power, enforce the timer isn't active. Gracefully
> restore its state upon resume in case it's been left enabled prior to
> suspend.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Seems sensible. Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/trigger/stm32-timer-trigger.c | 63 +++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
> index 32e1249..37545a8 100644
> --- a/drivers/iio/trigger/stm32-timer-trigger.c
> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
> @@ -75,6 +75,15 @@ static const void *stm32h7_valids_table[][MAX_VALIDS] = {
>  	{ }, /* timer 17 */
>  };
>  
> +struct stm32_timer_trigger_regs {
> +	u32 cr1;
> +	u32 cr2;
> +	u32 psc;
> +	u32 arr;
> +	u32 cnt;
> +	u32 smcr;
> +};
> +
>  struct stm32_timer_trigger {
>  	struct device *dev;
>  	struct regmap *regmap;
> @@ -86,6 +95,7 @@ struct stm32_timer_trigger {
>  	bool has_trgo2;
>  	struct mutex lock; /* concurrent sysfs configuration */
>  	struct list_head tr_list;
> +	struct stm32_timer_trigger_regs bak;
>  };
>  
>  struct stm32_timer_trigger_cfg {
> @@ -812,6 +822,58 @@ static int stm32_timer_trigger_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int __maybe_unused stm32_timer_trigger_suspend(struct device *dev)
> +{
> +	struct stm32_timer_trigger *priv = dev_get_drvdata(dev);
> +
> +	/* Only take care of enabled timer: don't disturb other MFD child */
> +	if (priv->enabled) {
> +		/* Backup registers that may get lost in low power mode */
> +		regmap_read(priv->regmap, TIM_CR1, &priv->bak.cr1);
> +		regmap_read(priv->regmap, TIM_CR2, &priv->bak.cr2);
> +		regmap_read(priv->regmap, TIM_PSC, &priv->bak.psc);
> +		regmap_read(priv->regmap, TIM_ARR, &priv->bak.arr);
> +		regmap_read(priv->regmap, TIM_CNT, &priv->bak.cnt);
> +		regmap_read(priv->regmap, TIM_SMCR, &priv->bak.smcr);
> +
> +		/* Disable the timer */
> +		regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
> +		clk_disable(priv->clk);
> +	}
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused stm32_timer_trigger_resume(struct device *dev)
> +{
> +	struct stm32_timer_trigger *priv = dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (priv->enabled) {
> +		ret = clk_enable(priv->clk);
> +		if (ret)
> +			return ret;
> +
> +		/* restore master/slave modes */
> +		regmap_write(priv->regmap, TIM_SMCR, priv->bak.smcr);
> +		regmap_write(priv->regmap, TIM_CR2, priv->bak.cr2);
> +
> +		/* restore sampling_frequency (trgo / trgo2 triggers) */
> +		regmap_write(priv->regmap, TIM_PSC, priv->bak.psc);
> +		regmap_write(priv->regmap, TIM_ARR, priv->bak.arr);
> +		regmap_write(priv->regmap, TIM_CNT, priv->bak.cnt);
> +
> +		/* Also re-enables the timer */
> +		regmap_write(priv->regmap, TIM_CR1, priv->bak.cr1);
> +	}
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(stm32_timer_trigger_pm_ops,
> +			 stm32_timer_trigger_suspend,
> +			 stm32_timer_trigger_resume);
> +
>  static const struct stm32_timer_trigger_cfg stm32_timer_trg_cfg = {
>  	.valids_table = valids_table,
>  	.num_valids_table = ARRAY_SIZE(valids_table),
> @@ -840,6 +902,7 @@ static struct platform_driver stm32_timer_trigger_driver = {
>  	.driver = {
>  		.name = "stm32-timer-trigger",
>  		.of_match_table = stm32_trig_of_match,
> +		.pm = &stm32_timer_trigger_pm_ops,
>  	},
>  };
>  module_platform_driver(stm32_timer_trigger_driver);

