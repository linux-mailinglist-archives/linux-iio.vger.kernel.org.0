Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3968185C91
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 14:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgCONSL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 09:18:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728582AbgCONSK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Mar 2020 09:18:10 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A174205ED;
        Sun, 15 Mar 2020 13:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584278290;
        bh=yTPTl73CTAwKU6Ah85qCz1tQR34Dwu1cFkkC/QJoE70=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zjewLdDEvo4y9+eZeZC0RKI5OnCMigfRye3pm4PvjZfWnmtcceo0pbiNGwEAg692R
         YnN0nSjrGapRe6X0Oc1m4VqVCZOz1BH9LEPUx+LLHBSxJcNnNt8+XGwcen9xlBoWOq
         O/boVQUUWsjgtzUJAGiAYvOOs1OSyiHLob20GibU=
Date:   Sun, 15 Mar 2020 13:18:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <Michael.Hennerich@analog.com>, <biabeniamin@outlook.com>
Subject: Re: [PATCH 4/4] iio: adc: ad7476: implement
 devm_add_action_or_reset
Message-ID: <20200315131806.61e1d3f8@archlinux>
In-Reply-To: <20200311084328.17680-4-beniamin.bia@analog.com>
References: <20200311084328.17680-1-beniamin.bia@analog.com>
        <20200311084328.17680-4-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 11 Mar 2020 10:43:28 +0200
Beniamin Bia <beniamin.bia@analog.com> wrote:

> Use devm_add_action_or_reset to automatically disable the device
> when it is removed or an error occurs during probe routine.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Applied,

Thanks,

Jonathan
> ---
>  drivers/iio/adc/ad7476.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index cd7d42df2033..e9984a38fc4c 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -256,6 +256,13 @@ static const struct iio_info ad7476_info = {
>  	.read_raw = &ad7476_read_raw,
>  };
>  
> +static void ad7476_reg_disable(void *data)
> +{
> +	struct ad7476_state *st = data;
> +
> +	regulator_disable(st->reg);
> +}
> +
>  static int ad7476_probe(struct spi_device *spi)
>  {
>  	struct ad7476_state *st;
> @@ -278,6 +285,11 @@ static int ad7476_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> +	ret = devm_add_action_or_reset(&spi->dev, ad7476_reg_disable,
> +				       st);
> +	if (ret)
> +		return ret;
> +
>  	st->convst_gpio = devm_gpiod_get_optional(&spi->dev,
>  						  "adi,conversion-start",
>  						  GPIOD_OUT_LOW);
> @@ -328,18 +340,6 @@ static int ad7476_probe(struct spi_device *spi)
>  	return ret;
>  }
>  
> -static int ad7476_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -	struct ad7476_state *st = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -	iio_triggered_buffer_cleanup(indio_dev);
> -	regulator_disable(st->reg);
> -
> -	return 0;
> -}
> -
>  static const struct spi_device_id ad7476_id[] = {
>  	{"ad7091", ID_AD7091R},
>  	{"ad7091r", ID_AD7091R},
> @@ -377,7 +377,6 @@ static struct spi_driver ad7476_driver = {
>  		.name	= "ad7476",
>  	},
>  	.probe		= ad7476_probe,
> -	.remove		= ad7476_remove,
>  	.id_table	= ad7476_id,
>  };
>  module_spi_driver(ad7476_driver);

