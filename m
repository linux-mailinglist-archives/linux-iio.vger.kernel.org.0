Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49EC3C3B7A
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jul 2021 12:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhGKKWE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Jul 2021 06:22:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231998AbhGKKWD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Jul 2021 06:22:03 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6A2A6124B;
        Sun, 11 Jul 2021 10:19:14 +0000 (UTC)
Date:   Sun, 11 Jul 2021 11:21:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     lars@metafoo.de, sre@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH v2 1/2] iio: adc: rn5t618: Add iio map
Message-ID: <20210711112130.45339212@jic23-huawei>
In-Reply-To: <20210705113637.28908-2-andreas@kemnade.info>
References: <20210705113637.28908-1-andreas@kemnade.info>
        <20210705113637.28908-2-andreas@kemnade.info>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  5 Jul 2021 13:36:36 +0200
Andreas Kemnade <andreas@kemnade.info> wrote:

> Add iio map to allow power driver to read out values as a consumer.
> This approach does not block later addition of devicetree support
> which would be helpful if there is an in-kernel consumer for AIN0/1.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Looks good.  I'm assuming this will go via the power tree, perhaps with
an immutable branch on off chance we have any other changes in the same
driver this cycle.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> Changes in v2:
> - provide consumer mapping via iio_map instead of devicetree
> 
>  drivers/iio/adc/rn5t618-adc.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/iio/adc/rn5t618-adc.c b/drivers/iio/adc/rn5t618-adc.c
> index 7010c4276947..c56fccb2c8e1 100644
> --- a/drivers/iio/adc/rn5t618-adc.c
> +++ b/drivers/iio/adc/rn5t618-adc.c
> @@ -16,6 +16,8 @@
>  #include <linux/completion.h>
>  #include <linux/regmap.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/driver.h>
> +#include <linux/iio/machine.h>
>  #include <linux/slab.h>
>  
>  #define RN5T618_ADC_CONVERSION_TIMEOUT   (msecs_to_jiffies(500))
> @@ -189,6 +191,19 @@ static const struct iio_chan_spec rn5t618_adc_iio_channels[] = {
>  	RN5T618_ADC_CHANNEL(AIN0, IIO_VOLTAGE, "AIN0")
>  };
>  
> +static struct iio_map rn5t618_maps[] = {
> +	IIO_MAP("VADP", "rn5t618-power", "vadp"),
> +	IIO_MAP("VUSB", "rn5t618-power", "vusb"),
> +	{ /* sentinel */ }
> +};
> +
> +static void unregister_map(void *data)
> +{
> +	struct iio_dev *iio_dev = (struct iio_dev *) data;
> +
> +	iio_map_array_unregister(iio_dev);
> +}
> +
>  static int rn5t618_adc_probe(struct platform_device *pdev)
>  {
>  	int ret;
> @@ -239,6 +254,14 @@ static int rn5t618_adc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	ret = iio_map_array_register(iio_dev, rn5t618_maps);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(adc->dev, unregister_map, iio_dev);
> +	if (ret < 0)
> +		return ret;
> +
>  	return devm_iio_device_register(adc->dev, iio_dev);
>  }
>  

