Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED44C20C12D
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jun 2020 14:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgF0MDf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jun 2020 08:03:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgF0MDe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Jun 2020 08:03:34 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EF4B21707;
        Sat, 27 Jun 2020 12:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593259414;
        bh=IoI9DCNTwnstafTE63dgLkKyGVXbdS23eZ+0iexP8vo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2t3lPjcKfZt4gMukt4rOU0/TVn4P2byphL2ZDQze8+viBfOLovXowFEoyibrvmQ4R
         vYKpJ+daZJQ0mdYO+yzADOFCNdgksUsJf0FLpijGvmilvqikZ+0jYDGJv5PW+vdJIM
         BzBQI6/WdoJhdm3m6ugZkBMN4VAGvjc2SZPOlFOs=
Date:   Sat, 27 Jun 2020 13:03:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, xxm@rock-chips.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v6 1/3] iio: adc: rockchip_saradc: move all of probe to
 devm-functions
Message-ID: <20200627130329.66d7102f@archlinux>
In-Reply-To: <20200623233011.2319035-1-heiko@sntech.de>
References: <20200623233011.2319035-1-heiko@sntech.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 24 Jun 2020 01:30:09 +0200
Heiko Stuebner <heiko@sntech.de> wrote:

> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> 
> Parts of the saradc probe rely on devm functions and later parts do not.
> This makes it more difficult to for example enable triggers via their
> devm-functions and would need more undo-work in remove.
> 
> So to make life easier for the driver, move the rest of probe calls
> also to their devm-equivalents.
> 
> This includes moving the clk- and regulator-disabling to a devm_action
> so that they gets disabled both during remove and in the error case
> in probe, after the action is registered.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Looks good to me. Applied to the togreg branch of iio.git with one small
tweak. See inline.

One other thing whilst we are here. Why do we need the build dependence
on ARM?  I just scrapped it and the driver builds fine on x86 so would
be good to get the additional build coverage if we can.

Jonathan

> ---
> changes in v6:
> - move devm actions into separate functions as suggested by Jonathan
> changes in v5:
> - none
> changes in v4:
> - new patch as suggested by Jonathan
> 
>  drivers/iio/adc/rockchip_saradc.c | 72 ++++++++++++++++++++-----------
>  1 file changed, 46 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index 582ba047c4a6..1a7990d60f9f 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -193,6 +193,27 @@ static void rockchip_saradc_reset_controller(struct reset_control *reset)
>  	reset_control_deassert(reset);
>  }
>  
> +static void rockchip_saradc_clk_disable(void *data)
> +{
> +	struct rockchip_saradc *info = data;
> +
> +	clk_disable_unprepare(info->clk);
> +}
> +
> +static void rockchip_saradc_pclk_disable(void *data)
> +{
> +	struct rockchip_saradc *info = data;
> +
> +	clk_disable_unprepare(info->pclk);
> +}
> +
> +static void rockchip_saradc_regulator_disable(void *data)
> +{
> +	struct rockchip_saradc *info = data;
> +
> +	regulator_disable(info->vref);
> +}
> +
>  static int rockchip_saradc_probe(struct platform_device *pdev)
>  {
>  	struct rockchip_saradc *info = NULL;
> @@ -291,17 +312,38 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "failed to enable vref regulator\n");
>  		return ret;
>  	}
> +	ret = devm_add_action_or_reset(&pdev->dev,
> +				       rockchip_saradc_regulator_disable, info);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register devm action, %d\n",
> +			ret);
> +		return ret;
> +	}
>  
>  	ret = clk_prepare_enable(info->pclk);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "failed to enable pclk\n");
> -		goto err_reg_voltage;
> +		return ret;
> +	}
> +	ret = devm_add_action_or_reset(&pdev->dev,
> +				       rockchip_saradc_pclk_disable, info);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register devm action, %d\n",
> +			ret);
> +		return ret;
>  	}
>  
>  	ret = clk_prepare_enable(info->clk);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "failed to enable converter clock\n");
> -		goto err_pclk;
> +		return ret;
> +	}
> +	ret = devm_add_action_or_reset(&pdev->dev,
> +				       rockchip_saradc_clk_disable, info);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register devm action, %d\n",
> +			ret);
> +		return ret;
>  	}
>  
>  	platform_set_drvdata(pdev, indio_dev);
> @@ -315,30 +357,9 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>  	indio_dev->channels = info->data->channels;
>  	indio_dev->num_channels = info->data->num_channels;
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&pdev->dev, indio_dev);
>  	if (ret)
> -		goto err_clk;
> -
> -	return 0;
> -
> -err_clk:
> -	clk_disable_unprepare(info->clk);
> -err_pclk:
> -	clk_disable_unprepare(info->pclk);
> -err_reg_voltage:
> -	regulator_disable(info->vref);
> -	return ret;
> -}
> -
> -static int rockchip_saradc_remove(struct platform_device *pdev)
> -{
> -	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> -	struct rockchip_saradc *info = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -	clk_disable_unprepare(info->clk);
> -	clk_disable_unprepare(info->pclk);
> -	regulator_disable(info->vref);
> +		return ret;
Small tweak rather hidden by how diff presents this but
might as well just

return devm_iio_device_register

>  
>  	return 0;
>  }
> @@ -383,7 +404,6 @@ static SIMPLE_DEV_PM_OPS(rockchip_saradc_pm_ops,
>  
>  static struct platform_driver rockchip_saradc_driver = {
>  	.probe		= rockchip_saradc_probe,
> -	.remove		= rockchip_saradc_remove,
>  	.driver		= {
>  		.name	= "rockchip-saradc",
>  		.of_match_table = rockchip_saradc_match,

