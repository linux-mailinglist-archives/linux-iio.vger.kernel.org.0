Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B91CF9193B
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2019 21:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfHRTSa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Aug 2019 15:18:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfHRTSa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Aug 2019 15:18:30 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92FD121855;
        Sun, 18 Aug 2019 19:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566155908;
        bh=0hKqAm8WRdNsfrQ67ZkPbGirgEewejdFpbrPcSivozo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1TZ6N2etplwW6WNpkTlJG1OuqrzdKNQdGVhqU2Abx3cyjcwNNQRpvYyuYcruK4hD2
         BgOGFulslbxuFsiz/bi/q2rCxdX2khA7TDxvQR/j7b3Y0GSzZBnTA76LMMJ/776Scy
         KZ7FLTXP4218Jy9R8ONLiPo+6SKuy4Ut4+8Sp2IU=
Date:   Sun, 18 Aug 2019 20:18:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: max1027: Use device-managed APIs
Message-ID: <20190818201824.49af545e@archlinux>
In-Reply-To: <20190811125146.21355-1-hslester96@gmail.com>
References: <20190811125146.21355-1-hslester96@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 11 Aug 2019 20:51:46 +0800
Chuhong Yuan <hslester96@gmail.com> wrote:

> Use device-managed APIs to simplify the code.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Great thanks,

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v2:
>   - Delete the debug print and _remove.
> 
>  drivers/iio/adc/max1027.c | 38 +++++++-------------------------------
>  1 file changed, 7 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index da84adfdb819..214883458582 100644
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
> @@ -462,34 +463,10 @@ static int max1027_probe(struct spi_device *spi)
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
> -}
> -
> -static int max1027_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -
> -	pr_debug("%s: remove(spi = 0x%p)\n", __func__, spi);
> -
> -	iio_device_unregister(indio_dev);
> -	iio_triggered_buffer_cleanup(indio_dev);
> -
> -	return 0;
> +	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
>  static struct spi_driver max1027_driver = {
> @@ -498,7 +475,6 @@ static struct spi_driver max1027_driver = {
>  		.of_match_table = of_match_ptr(max1027_adc_dt_ids),
>  	},
>  	.probe		= max1027_probe,
> -	.remove		= max1027_remove,
>  	.id_table	= max1027_id,
>  };
>  module_spi_driver(max1027_driver);

