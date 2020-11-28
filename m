Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35932C7513
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388093AbgK1Vt2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:50322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732538AbgK1TBy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 14:01:54 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EE9824654;
        Sat, 28 Nov 2020 13:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606568677;
        bh=AS491kcEn7jKh+dTN2DjipJSCONVK9RI7M4QUO1+bWA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IiABbyqxpzx3IX+fmZnshBsjQyTtfEL2BZT8r5nxjhrwYN2CmVUrZzlXkCeAxFsdz
         TeOviaUeTsmKofhuHdhRL9/WTruz3H8RKnC9hTVF/viFpir1/7xNx5sm93p2pYp1zb
         8e3pcq3zoDwASCdjOGZFZ4Pyq6W3uf0yOhFclo9c=
Date:   Sat, 28 Nov 2020 13:04:33 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <colin.king@canonical.com>
Subject: Re: [PATCH 1/2] iio: adc: ad7298: convert probe to device-managed
 functions
Message-ID: <20201128130433.320de46e@archlinux>
In-Reply-To: <20201127094038.91714-1-alexandru.ardelean@analog.com>
References: <20201127094038.91714-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 27 Nov 2020 11:40:37 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change converts the probe of this driver to use device-managed
> register functions, and a devm_add_action_or_reset() for the regulator
> disable.
> 
> With this, the exit & error paths can be removed.
> Another side-effect is that this should avoid some static-analyzer's check
> with respect to a potential null dereference of the regulator. The null
> dereference isn't likely to happen (under normal operation), so there isn't
> a requirement to have this fixed/backported in other releases.
> 
> As a note: this is removing spi_set_drvdata() since there is no other
> spi_get_drvdata() (or dev_get_drvdata()) call that need it.
> 
> Cc: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Series applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to work their magic.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7298.c | 46 +++++++++++++---------------------------
>  1 file changed, 15 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
> index fa1047f74a1f..ecdb01bd5b2f 100644
> --- a/drivers/iio/adc/ad7298.c
> +++ b/drivers/iio/adc/ad7298.c
> @@ -279,6 +279,13 @@ static const struct iio_info ad7298_info = {
>  	.update_scan_mode = ad7298_update_scan_mode,
>  };
>  
> +static void ad7298_reg_disable(void *data)
> +{
> +	struct regulator *reg = data;
> +
> +	regulator_disable(reg);
> +}
> +
>  static int ad7298_probe(struct spi_device *spi)
>  {
>  	struct ad7298_state *st;
> @@ -306,9 +313,12 @@ static int ad7298_probe(struct spi_device *spi)
>  		ret = regulator_enable(st->reg);
>  		if (ret)
>  			return ret;
> -	}
>  
> -	spi_set_drvdata(spi, indio_dev);
> +		ret = devm_add_action_or_reset(&spi->dev, ad7298_reg_disable,
> +					       st->reg);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	st->spi = spi;
>  
> @@ -334,37 +344,12 @@ static int ad7298_probe(struct spi_device *spi)
>  	spi_message_add_tail(&st->scan_single_xfer[1], &st->scan_single_msg);
>  	spi_message_add_tail(&st->scan_single_xfer[2], &st->scan_single_msg);
>  
> -	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> +	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
>  			&ad7298_trigger_handler, NULL);
>  	if (ret)
> -		goto error_disable_reg;
> -
> -	ret = iio_device_register(indio_dev);
> -	if (ret)
> -		goto error_cleanup_ring;
> -
> -	return 0;
> -
> -error_cleanup_ring:
> -	iio_triggered_buffer_cleanup(indio_dev);
> -error_disable_reg:
> -	if (st->ext_ref)
> -		regulator_disable(st->reg);
> -
> -	return ret;
> -}
> -
> -static int ad7298_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -	struct ad7298_state *st = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -	iio_triggered_buffer_cleanup(indio_dev);
> -	if (st->ext_ref)
> -		regulator_disable(st->reg);
> +		return ret;
>  
> -	return 0;
> +	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
>  static const struct spi_device_id ad7298_id[] = {
> @@ -378,7 +363,6 @@ static struct spi_driver ad7298_driver = {
>  		.name	= "ad7298",
>  	},
>  	.probe		= ad7298_probe,
> -	.remove		= ad7298_remove,
>  	.id_table	= ad7298_id,
>  };
>  module_spi_driver(ad7298_driver);

