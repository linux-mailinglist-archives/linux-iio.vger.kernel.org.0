Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233AB1B88E9
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 21:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgDYT2s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 15:28:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgDYT2r (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 15:28:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E8FC20714;
        Sat, 25 Apr 2020 19:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587842927;
        bh=uqZb4Ri4kMh3j89fFdv3gFVALSHGMTlVnWc6qy4vE2Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qtctqnX4EHzmCto6jcsMonOxY4SxrquUKXdxJmFtOtGUL5vzo1Y76wHQyRNfObhi8
         npvSjdjNG8wjbnvLRJ3rUmcCvkQLaCNY967BvYHKmiKFvYYO4bbx7imX+xdJu2IVcu
         UCOgM3x9eZpNeWBGWgOkXQ4fK7hEKGeg7mjRgqGc=
Date:   Sat, 25 Apr 2020 20:28:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, xxm@rock-chips.com,
        kever.yang@rock-chips.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v5 1/3] iio: adc: rockchip_saradc: move all of probe to
 devm-functions
Message-ID: <20200425202842.41a2c7e2@archlinux>
In-Reply-To: <20200419100207.58108-1-heiko@sntech.de>
References: <20200419100207.58108-1-heiko@sntech.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 19 Apr 2020 12:02:05 +0200
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
> ---
> changes in v5:
> - none
> changes in v4:
> - new patch as suggested by Jonathan
> 
>  drivers/iio/adc/rockchip_saradc.c | 37 ++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index 582ba047c4a6..270eb7e83823 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -193,6 +193,15 @@ static void rockchip_saradc_reset_controller(struct reset_control *reset)
>  	reset_control_deassert(reset);
>  }
>  
> +static void rockchip_saradc_disable(void *data)
> +{
> +	struct rockchip_saradc *info = data;
> +
> +	clk_disable_unprepare(info->clk);
> +	clk_disable_unprepare(info->pclk);
> +	regulator_disable(info->vref);

You should do these independently.  If you use
a separate devm_add_action_or_reset you can drop the error handling
in probe because that will all be cleaned up automatically as well.

Right now you have a nasty hybrid of managed and unmanaged needing
manual cleanup in some paths.

It will take a few more lines of code, but it will be a lot easier
to review / maintain.

Jonathan


> +}
> +
>  static int rockchip_saradc_probe(struct platform_device *pdev)
>  {
>  	struct rockchip_saradc *info = NULL;
> @@ -304,6 +313,14 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>  		goto err_pclk;
>  	}
>  
> +	ret = devm_add_action_or_reset(&pdev->dev,
> +				       rockchip_saradc_disable, info);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register devm action, %d\n",
> +			ret);
> +		return ret;
> +	}
> +
>  	platform_set_drvdata(pdev, indio_dev);
>  
>  	indio_dev->name = dev_name(&pdev->dev);
> @@ -315,14 +332,12 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>  	indio_dev->channels = info->data->channels;
>  	indio_dev->num_channels = info->data->num_channels;
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&pdev->dev, indio_dev);
>  	if (ret)
> -		goto err_clk;
> +		return ret;
>  
>  	return 0;
>  
> -err_clk:
> -	clk_disable_unprepare(info->clk);
>  err_pclk:
>  	clk_disable_unprepare(info->pclk);

>  err_reg_voltage:
> @@ -330,19 +345,6 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int rockchip_saradc_remove(struct platform_device *pdev)
> -{
> -	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> -	struct rockchip_saradc *info = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -	clk_disable_unprepare(info->clk);
> -	clk_disable_unprepare(info->pclk);
> -	regulator_disable(info->vref);
> -
> -	return 0;
> -}
> -
>  #ifdef CONFIG_PM_SLEEP
>  static int rockchip_saradc_suspend(struct device *dev)
>  {
> @@ -383,7 +385,6 @@ static SIMPLE_DEV_PM_OPS(rockchip_saradc_pm_ops,
>  
>  static struct platform_driver rockchip_saradc_driver = {
>  	.probe		= rockchip_saradc_probe,
> -	.remove		= rockchip_saradc_remove,
>  	.driver		= {
>  		.name	= "rockchip-saradc",
>  		.of_match_table = rockchip_saradc_match,

