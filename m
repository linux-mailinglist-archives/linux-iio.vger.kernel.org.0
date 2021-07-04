Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AE53BAE23
	for <lists+linux-iio@lfdr.de>; Sun,  4 Jul 2021 19:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhGDSCM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Jul 2021 14:02:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229636AbhGDSCM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Jul 2021 14:02:12 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 772146128D;
        Sun,  4 Jul 2021 17:59:35 +0000 (UTC)
Date:   Sun, 4 Jul 2021 19:01:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Subject: Re: [PATCH] iio: adc: fsl-imx25-gcq: initialize regulators as
 needed
Message-ID: <20210704190158.6676ab99@jic23-huawei>
In-Reply-To: <20210625074325.9237-1-aardelean@deviqon.com>
References: <20210625074325.9237-1-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 25 Jun 2021 10:43:25 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> The driver tries to initialize all possible regulators from the DT, then
> match the external regulators with each channel and then release all unused
> regulators.
> 
> We can change the logic a bit to initialize regulators only when at least
> one channel needs them.
> 
> This change creates a mx25_gcq_ext_regulator_setup() function that is
> called only for the external regulators. If there's already a reference to
> an external regulator, the function will just exit early with no error.
> 
> This way, the driver doesn't need to keep any track of these regulators
> during init.
> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>

whilst I agree this is a bit cleaner, I definitely want to see review from
those more familiar with the device before I take it!

Thanks,

Jonathan

> ---
>  drivers/iio/adc/fsl-imx25-gcq.c | 57 ++++++++++++++++-----------------
>  1 file changed, 28 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
> index ab5139e911c3..31776f80f847 100644
> --- a/drivers/iio/adc/fsl-imx25-gcq.c
> +++ b/drivers/iio/adc/fsl-imx25-gcq.c
> @@ -172,13 +172,37 @@ static const struct regmap_config mx25_gcq_regconfig = {
>  	.reg_stride = 4,
>  };
>  
> +static int mx25_gcq_ext_regulator_setup(struct device *dev,
> +					struct mx25_gcq_priv *priv, u32 refp)
> +{
> +	char reg_name[12];
> +	int ret;
> +
> +	if (priv->vref[refp])
> +		return 0;
> +
> +	ret = snprintf(reg_name, sizeof(reg_name), "vref-%s",
> +		       mx25_gcq_refp_names[refp]);
> +	if (ret < 0)
> +		return ret;
> +
> +	priv->vref[refp] = devm_regulator_get_optional(dev, reg_name);
> +	if (IS_ERR(priv->vref[refp])) {
> +		dev_err(dev,
> +			"Error, trying to use external voltage reference without a %s regulator.",
> +			reg_name);
> +		return PTR_ERR(priv->vref[refp]);
> +	}
> +
> +	return 0;
> +}
> +
>  static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
>  			       struct mx25_gcq_priv *priv)
>  {
>  	struct device_node *np = pdev->dev.of_node;
>  	struct device_node *child;
>  	struct device *dev = &pdev->dev;
> -	unsigned int refp_used[4] = {};
>  	int ret, i;
>  
>  	/*
> @@ -194,19 +218,6 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
>  			     MX25_ADCQ_CFG_IN(i) |
>  			     MX25_ADCQ_CFG_REFN_NGND2);
>  
> -	/*
> -	 * First get all regulators to store them in channel_vref_mv if
> -	 * necessary. Later we use that information for proper IIO scale
> -	 * information.
> -	 */
> -	priv->vref[MX25_ADC_REFP_INT] = NULL;
> -	priv->vref[MX25_ADC_REFP_EXT] =
> -		devm_regulator_get_optional(&pdev->dev, "vref-ext");
> -	priv->vref[MX25_ADC_REFP_XP] =
> -		devm_regulator_get_optional(&pdev->dev, "vref-xp");
> -	priv->vref[MX25_ADC_REFP_YP] =
> -		devm_regulator_get_optional(&pdev->dev, "vref-yp");
> -
>  	for_each_child_of_node(np, child) {
>  		u32 reg;
>  		u32 refp = MX25_ADCQ_CFG_REFP_INT;
> @@ -233,11 +244,10 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
>  		case MX25_ADC_REFP_EXT:
>  		case MX25_ADC_REFP_XP:
>  		case MX25_ADC_REFP_YP:
> -			if (IS_ERR(priv->vref[refp])) {
> -				dev_err(dev, "Error, trying to use external voltage reference without a vref-%s regulator.",
> -					mx25_gcq_refp_names[refp]);
> +			ret = mx25_gcq_ext_regulator_setup(&pdev->dev, priv, refp);
> +			if (ret) {
>  				of_node_put(child);
> -				return PTR_ERR(priv->vref[refp]);
> +				return ret;
>  			}
>  			priv->channel_vref_mv[reg] =
>  				regulator_get_voltage(priv->vref[refp]);
> @@ -253,8 +263,6 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
>  			return -EINVAL;
>  		}
>  
> -		++refp_used[refp];
> -
>  		/*
>  		 * Shift the read values to the correct positions within the
>  		 * register.
> @@ -285,15 +293,6 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
>  	regmap_write(priv->regs, MX25_ADCQ_CR,
>  		     MX25_ADCQ_CR_PDMSK | MX25_ADCQ_CR_QSM_FQS);
>  
> -	/* Remove unused regulators */
> -	for (i = 0; i != 4; ++i) {
> -		if (!refp_used[i]) {
> -			if (!IS_ERR_OR_NULL(priv->vref[i]))
> -				devm_regulator_put(priv->vref[i]);
> -			priv->vref[i] = NULL;
> -		}
> -	}
> -
>  	return 0;
>  }
>  

