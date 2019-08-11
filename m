Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A598C8913A
	for <lists+linux-iio@lfdr.de>; Sun, 11 Aug 2019 12:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfHKKPn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Aug 2019 06:15:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfHKKPn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Aug 2019 06:15:43 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AA722085B;
        Sun, 11 Aug 2019 10:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565518542;
        bh=SEWu7CeMZE+sIKBchbytpnvqbgXLPt/vVHplKoSLth4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P0VzZ/WXBGL5y4j/5zaj49rjhToDb6bUe6VVk/OYJT/51dsWiDKTE2/qqgi9hiAtJ
         It83hAbo+KN/H4rwVNPSR1/Z6bBLfMZeBtuw2n6FNKngt5bv2+CBIN9ytuBtCs38Ci
         gc67rlcEIIunoFM2VVqHrWIps6jI+mV4M7tMMiT8=
Date:   Sun, 11 Aug 2019 11:15:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: max1027: Use device-managed APIs
Message-ID: <20190811111537.1356663f@archlinux>
In-Reply-To: <20190808142646.29567-1-hslester96@gmail.com>
References: <20190808142646.29567-1-hslester96@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


+CC linux-iio

On Thu,  8 Aug 2019 22:26:46 +0800
Chuhong Yuan <hslester96@gmail.com> wrote:

> Use device-managed APIs to simplify the code.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Also one minor comment inline.  I would have picked this up and
made that change but given it didn't go to the linux-iio, please
do a v2 scrapping the debug print and hence remove.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/max1027.c | 30 +++++++-----------------------
>  1 file changed, 7 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index da84adfdb819..f1b90c544b82 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -427,8 +427,9 @@ static int max1027_probe(struct spi_device *spi)
>  		return -ENOMEM;
>  	}
>  
> -	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
> -					 &max1027_trigger_handler, NULL);
> +	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> +					&iio_pollfunc_store_time,
> +					&max1027_trigger_handler, NULL);
>  	if (ret < 0) {
>  		dev_err(&indio_dev->dev, "Failed to setup buffer\n");
>  		return ret;
> @@ -439,7 +440,7 @@ static int max1027_probe(struct spi_device *spi)
>  	if (st->trig == NULL) {
>  		ret = -ENOMEM;
>  		dev_err(&indio_dev->dev, "Failed to allocate iio trigger\n");
> -		goto fail_trigger_alloc;
> +		return ret;
>  	}
>  
>  	st->trig->ops = &max1027_trigger_ops;
> @@ -454,7 +455,7 @@ static int max1027_probe(struct spi_device *spi)
>  					spi->dev.driver->name, st->trig);
>  	if (ret < 0) {
>  		dev_err(&indio_dev->dev, "Failed to allocate IRQ.\n");
> -		goto fail_dev_register;
> +		return ret;
>  	}
>  
>  	/* Disable averaging */
> @@ -462,33 +463,16 @@ static int max1027_probe(struct spi_device *spi)
>  	ret = spi_write(st->spi, &st->reg, 1);
>  	if (ret < 0) {
>  		dev_err(&indio_dev->dev, "Failed to configure averaging register\n");
> -		goto fail_dev_register;
> -	}
> -
> -	ret = iio_device_register(indio_dev);
> -	if (ret < 0) {
> -		dev_err(&indio_dev->dev, "Failed to register iio device\n");
> -		goto fail_dev_register;
> +		return ret;
>  	}
>  
> -	return 0;
> -
> -fail_dev_register:
> -fail_trigger_alloc:
> -	iio_triggered_buffer_cleanup(indio_dev);
> -
> -	return ret;
> +	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
>  static int max1027_remove(struct spi_device *spi)
>  {
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -
>  	pr_debug("%s: remove(spi = 0x%p)\n", __func__, spi);

That's not a message we need to keep.  Hence can get rid of remove entirely.

>  
> -	iio_device_unregister(indio_dev);
> -	iio_triggered_buffer_cleanup(indio_dev);
> -
>  	return 0;
>  }
>  

