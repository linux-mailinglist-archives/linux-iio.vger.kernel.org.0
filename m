Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9F031BAAD
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 15:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhBOODW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 09:03:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:51078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229968AbhBOODV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Feb 2021 09:03:21 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A62FA64DCF;
        Mon, 15 Feb 2021 14:02:39 +0000 (UTC)
Date:   Mon, 15 Feb 2021 14:02:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: Re: [PATCH] iio: use getter/setter functions
Message-ID: <20210215140236.351b1941@archlinux>
In-Reply-To: <20210209211315.1261791-1-Julia.Lawall@inria.fr>
References: <20210209211315.1261791-1-Julia.Lawall@inria.fr>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  9 Feb 2021 22:13:15 +0100
Julia Lawall <Julia.Lawall@inria.fr> wrote:

> Use getter and setter functions, for a variety of data types.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Hi Julia,

This crossed with a change of variable name in industrialio-core.c
so I've applied with a slight tweak to take that into account.

Applied to the togreg branch of iio.git and pushed out as testing
to let 0-day and friends poke at it.

Thanks,

Jonathan

> 
> ---
>  drivers/iio/adc/palmas_gpadc.c      |    2 +-
>  drivers/iio/chemical/scd30_serial.c |    2 +-
>  drivers/iio/industrialio-core.c     |    2 +-
>  drivers/iio/potentiometer/max5481.c |    4 ++--
>  drivers/iio/potentiometer/max5487.c |    4 ++--
>  5 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/potentiometer/max5487.c b/drivers/iio/potentiometer/max5487.c
> index 7ec51976ec99..1c0d46a96200 100644
> --- a/drivers/iio/potentiometer/max5487.c
> +++ b/drivers/iio/potentiometer/max5487.c
> @@ -92,7 +92,7 @@ static int max5487_spi_probe(struct spi_device *spi)
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> -	dev_set_drvdata(&spi->dev, indio_dev);
> +	spi_set_drvdata(spi, indio_dev);
>  	data = iio_priv(indio_dev);
>  
>  	data->spi = spi;
> @@ -114,7 +114,7 @@ static int max5487_spi_probe(struct spi_device *spi)
>  
>  static int max5487_spi_remove(struct spi_device *spi)
>  {
> -	struct iio_dev *indio_dev = dev_get_drvdata(&spi->dev);
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
>  
>  	iio_device_unregister(indio_dev);
>  
> diff --git a/drivers/iio/potentiometer/max5481.c b/drivers/iio/potentiometer/max5481.c
> index a88ed0eb3adc..6e22b538091f 100644
> --- a/drivers/iio/potentiometer/max5481.c
> +++ b/drivers/iio/potentiometer/max5481.c
> @@ -136,7 +136,7 @@ static int max5481_probe(struct spi_device *spi)
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> -	dev_set_drvdata(&spi->dev, indio_dev);
> +	spi_set_drvdata(spi, indio_dev);
>  	data = iio_priv(indio_dev);
>  
>  	data->spi = spi;
> @@ -163,7 +163,7 @@ static int max5481_probe(struct spi_device *spi)
>  
>  static int max5481_remove(struct spi_device *spi)
>  {
> -	struct iio_dev *indio_dev = dev_get_drvdata(&spi->dev);
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
>  	struct max5481_data *data = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 7db761afa578..4ef7a39cfb1c 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1596,7 +1596,7 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
>  	dev->dev.type = &iio_device_type;
>  	dev->dev.bus = &iio_bus_type;
>  	device_initialize(&dev->dev);
> -	dev_set_drvdata(&dev->dev, (void *)dev);
> +	iio_device_set_drvdata(dev, (void *)dev);
>  	mutex_init(&dev->mlock);
>  	mutex_init(&dev->info_exist_lock);
>  	INIT_LIST_HEAD(&iio_dev_opaque->channel_attr_list);
> diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
> index 889b88768b63..9ae0d7f73155 100644
> --- a/drivers/iio/adc/palmas_gpadc.c
> +++ b/drivers/iio/adc/palmas_gpadc.c
> @@ -517,7 +517,7 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
>  	adc->palmas = dev_get_drvdata(pdev->dev.parent);
>  	adc->adc_info = palmas_gpadc_info;
>  	init_completion(&adc->conv_completion);
> -	dev_set_drvdata(&pdev->dev, indio_dev);
> +	platform_set_drvdata(pdev, indio_dev);
>  
>  	adc->auto_conversion_period = gpadc_pdata->auto_conversion_period_ms;
>  	adc->irq = palmas_irq_get_virq(adc->palmas, PALMAS_GPADC_EOC_SW_IRQ);
> diff --git a/drivers/iio/chemical/scd30_serial.c b/drivers/iio/chemical/scd30_serial.c
> index 06f85eb1a4dd..568b34486c44 100644
> --- a/drivers/iio/chemical/scd30_serial.c
> +++ b/drivers/iio/chemical/scd30_serial.c
> @@ -177,7 +177,7 @@ static int scd30_serdev_command(struct scd30_state *state, enum scd30_cmd cmd, u
>  static int scd30_serdev_receive_buf(struct serdev_device *serdev,
>  				    const unsigned char *buf, size_t size)
>  {
> -	struct iio_dev *indio_dev = dev_get_drvdata(&serdev->dev);
> +	struct iio_dev *indio_dev = serdev_device_get_drvdata(serdev);
>  	struct scd30_serdev_priv *priv;
>  	struct scd30_state *state;
>  	int num;
> 

