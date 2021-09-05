Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA08400F2D
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 12:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237457AbhIEKyb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 06:54:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhIEKya (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 06:54:30 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34C3C60EE1;
        Sun,  5 Sep 2021 10:53:25 +0000 (UTC)
Date:   Sun, 5 Sep 2021 11:56:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH] iio: adc: ti-ads8344: convert probe to device-managed
Message-ID: <20210905115648.5c02df3d@jic23-huawei>
In-Reply-To: <20210903073707.46892-1-aardelean@deviqon.com>
References: <20210903073707.46892-1-aardelean@deviqon.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  3 Sep 2021 10:37:07 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> This change converts the driver to register via devm_iio_device_register().
> The regulator disable is moved on a devm_add_action_or_reset() hook.
> 
> And the spi_set_drvdata() isn't required anymore.
> And finally, the ads8344_remove() can be removed as well.
> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to see if it can find anything we missed. 
> ---
>  drivers/iio/adc/ti-ads8344.c | 27 ++++++++-------------------
>  1 file changed, 8 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads8344.c b/drivers/iio/adc/ti-ads8344.c
> index a345a30d74fa..c96d2a9ba924 100644
> --- a/drivers/iio/adc/ti-ads8344.c
> +++ b/drivers/iio/adc/ti-ads8344.c
> @@ -133,6 +133,11 @@ static const struct iio_info ads8344_info = {
>  	.read_raw = ads8344_read_raw,
>  };
>  
> +static void ads8344_reg_disable(void *data)
> +{
> +	regulator_disable(data);
> +}
> +
>  static int ads8344_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
> @@ -161,26 +166,11 @@ static int ads8344_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> -	spi_set_drvdata(spi, indio_dev);
> -
> -	ret = iio_device_register(indio_dev);
> -	if (ret) {
> -		regulator_disable(adc->reg);
> +	ret = devm_add_action_or_reset(&spi->dev, ads8344_reg_disable, adc->reg);
> +	if (ret)
>  		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -static int ads8344_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -	struct ads8344 *adc = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -	regulator_disable(adc->reg);
>  
> -	return 0;
> +	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
>  static const struct of_device_id ads8344_of_match[] = {
> @@ -195,7 +185,6 @@ static struct spi_driver ads8344_driver = {
>  		.of_match_table = ads8344_of_match,
>  	},
>  	.probe = ads8344_probe,
> -	.remove = ads8344_remove,
>  };
>  module_spi_driver(ads8344_driver);
>  

