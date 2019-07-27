Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A773E7790F
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2019 15:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387653AbfG0Nvb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jul 2019 09:51:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387603AbfG0Nvb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Jul 2019 09:51:31 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A867C2084C;
        Sat, 27 Jul 2019 13:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564235490;
        bh=Cyk2T9XTi2a0TzR7BWvMq7y8yRWPttyjSBEcdgvNqIc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FY2TlvGQVDo3WAhahIdOTHDFf7JbrxKqz3fUw2cHrQk4AJmzEFcPrbn5LBFnEgq0b
         GrZzIPgE8parlrNpGHWwAo36ZnrnC7UOJHAuGP8q/XZBCFh4jkomKQppdy0V0KA4fB
         4JMGNF9JZ30C48Njt2VG1hgxvVtCcF7+NvdXyAn0=
Date:   Sat, 27 Jul 2019 14:51:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: [PATCH] iio: maxim_thermocouple: Use device-managed APIs
Message-ID: <20190727145126.07ea374d@archlinux>
In-Reply-To: <20190726104950.19171-1-hslester96@gmail.com>
References: <20190726104950.19171-1-hslester96@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 26 Jul 2019 18:49:50 +0800
Chuhong Yuan <hslester96@gmail.com> wrote:

> Use device-managed APIs to simplify the code.
> The remove functions are redundant now and can
> be deleted.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
+CC Matt as I think this is one of his.

I modified slightly and applied to the togreg branch of iio.git.

See inline for the change.

Thanks,

Jonathan



> ---
>  drivers/iio/temperature/maxim_thermocouple.c | 23 ++++----------------
>  1 file changed, 4 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
> index c613a64c017f..314b6e11e386 100644
> --- a/drivers/iio/temperature/maxim_thermocouple.c
> +++ b/drivers/iio/temperature/maxim_thermocouple.c
> @@ -230,29 +230,15 @@ static int maxim_thermocouple_probe(struct spi_device *spi)
>  	data->spi = spi;
>  	data->chip = chip;
>  
> -	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> +	ret = devm_iio_triggered_buffer_setup(&spi->dev,
> +				indio_dev, NULL,
>  				maxim_thermocouple_trigger_handler, NULL);
>  	if (ret)
>  		return ret;
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&spi->dev, indio_dev);
>  	if (ret)
> -		goto error_unreg_buffer;
> -
> -	return 0;
> -
> -error_unreg_buffer:
> -	iio_triggered_buffer_cleanup(indio_dev);
> -
> -	return ret;
> -}
> -
> -static int maxim_thermocouple_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -
> -	iio_device_unregister(indio_dev);
> -	iio_triggered_buffer_cleanup(indio_dev);
> +		return ret;

Slight tweak. I'll do it whilst applying.
can just 
	return devm_iio_device_register(...) as same effect.

>  
>  	return 0;
>  }
> @@ -277,7 +263,6 @@ static struct spi_driver maxim_thermocouple_driver = {
>  		.of_match_table = maxim_thermocouple_of_match,
>  	},
>  	.probe		= maxim_thermocouple_probe,
> -	.remove		= maxim_thermocouple_remove,
>  	.id_table	= maxim_thermocouple_id,
>  };
>  module_spi_driver(maxim_thermocouple_driver);

