Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855923BA95F
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jul 2021 18:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhGCQMQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Jul 2021 12:12:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhGCQMP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jul 2021 12:12:15 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD6A061935;
        Sat,  3 Jul 2021 16:09:37 +0000 (UTC)
Date:   Sat, 3 Jul 2021 17:12:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, lars@metafoo.de,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, leonard.crestez@nxp.com,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH 3/4] iio: rn5t618: Add devicetree support
Message-ID: <20210703171200.0b6a4d3b@jic23-huawei>
In-Reply-To: <20210703084224.31623-4-andreas@kemnade.info>
References: <20210703084224.31623-1-andreas@kemnade.info>
        <20210703084224.31623-4-andreas@kemnade.info>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  3 Jul 2021 10:42:23 +0200
Andreas Kemnade <andreas@kemnade.info> wrote:

> Add devicetree support to be able to easily get the channels
> from another device.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/iio/adc/rn5t618-adc.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/rn5t618-adc.c b/drivers/iio/adc/rn5t618-adc.c
> index 7010c4276947..feba19f91574 100644
> --- a/drivers/iio/adc/rn5t618-adc.c
> +++ b/drivers/iio/adc/rn5t618-adc.c
> @@ -12,6 +12,7 @@
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/mfd/rn5t618.h>
> +#include <linux/of_device.h>
Why?

mod_devicetable.h probably the one you want.

>  #include <linux/platform_device.h>
>  #include <linux/completion.h>
>  #include <linux/regmap.h>
> @@ -218,6 +219,7 @@ static int rn5t618_adc_probe(struct platform_device *pdev)
>  	init_completion(&adc->conv_completion);
>  
>  	iio_dev->name = dev_name(&pdev->dev);
> +	iio_dev->dev.of_node = pdev->dev.of_node;

That should (now) be set by the IIO core for you via the devm_iio_device_register()
call below if it's not already set.

>  	iio_dev->info = &rn5t618_adc_iio_info;
>  	iio_dev->modes = INDIO_DIRECT_MODE;
>  	iio_dev->channels = rn5t618_adc_iio_channels;
> @@ -242,9 +244,19 @@ static int rn5t618_adc_probe(struct platform_device *pdev)
>  	return devm_iio_device_register(adc->dev, iio_dev);
>  }
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id rn5t618_adc_of_match[] = {
> +	{ .compatible = "ricoh,rc5t619-adc", },
> +	{ .compatible = "ricoh,rn5t618-adc", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, rn5t618_adc_of_match);
> +#endif
> +
>  static struct platform_driver rn5t618_adc_driver = {
>  	.driver = {
> -		.name   = "rn5t618-adc",
> +		.name = "rn5t618-adc",
> +		.of_match_table = of_match_ptr(rn5t618_adc_of_match),

Given cost of that table is totally trivial (and I'm trying to get rid
of this pattern in IIO as it's noisy and adds little :) drop the
of_match_ptr protection and the ifdefs above.

>  	},
>  	.probe = rn5t618_adc_probe,
>  };

