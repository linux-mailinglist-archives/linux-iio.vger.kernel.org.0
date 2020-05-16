Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522BE1D61F7
	for <lists+linux-iio@lfdr.de>; Sat, 16 May 2020 17:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgEPPZS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 May 2020 11:25:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgEPPZR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 May 2020 11:25:17 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C5F72065C;
        Sat, 16 May 2020 15:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589642717;
        bh=T0JwmiMwnEPZ35ne+oNIwIDDnaDStjbnxIotzzfP080=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jM1QHtrkkPobQilhC3RLiRCwLiR7e6p4TmG7jCQDIlTzR8ufSDn/1m4kf12Fx7hHf
         QUe8OX3DUfxuzefyqm50+jz+vdKaWwT5C5tzWcjEUIMyESUNyLKsmhKA6cKbx2pMam
         2+aYLE8U5Ky2k54DCmnrtHZx1V1BlW0CEG9ak05Y=
Date:   Sat, 16 May 2020 16:25:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: dac: ad5764: Replace indio_dev->mlock with own
 device lock
Message-ID: <20200516162510.13ba3656@archlinux>
In-Reply-To: <20200514091215.80958-1-sergiu.cuciurean@analog.com>
References: <20200514091215.80958-1-sergiu.cuciurean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 14 May 2020 12:12:12 +0300
Sergiu Cuciurean <sergiu.cuciurean@analog.com> wrote:

> As part of the general cleanup of indio_dev->mlock, this change replaces
> it with a local lock on the device's state structure.
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5764.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5764.c b/drivers/iio/dac/ad5764.c
> index f7ab211604a1..5b0f0fe354f6 100644
> --- a/drivers/iio/dac/ad5764.c
> +++ b/drivers/iio/dac/ad5764.c
> @@ -46,6 +46,7 @@ struct ad5764_chip_info {
>   * @spi:		spi_device
>   * @chip_info:		chip info
>   * @vref_reg:		vref supply regulators
> + * @lock		lock to protect the data buffer during SPI ops
>   * @data:		spi transfer buffers
>   */
>  
> @@ -53,6 +54,7 @@ struct ad5764_state {
>  	struct spi_device		*spi;
>  	const struct ad5764_chip_info	*chip_info;
>  	struct regulator_bulk_data	vref_reg[2];
> +	struct mutex			lock;
>  
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
> @@ -126,11 +128,11 @@ static int ad5764_write(struct iio_dev *indio_dev, unsigned int reg,
>  	struct ad5764_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	st->data[0].d32 = cpu_to_be32((reg << 16) | val);
>  
>  	ret = spi_write(st->spi, &st->data[0].d8[1], 3);
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret;
>  }
> @@ -151,7 +153,7 @@ static int ad5764_read(struct iio_dev *indio_dev, unsigned int reg,
>  		},
>  	};
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  
>  	st->data[0].d32 = cpu_to_be32((1 << 23) | (reg << 16));
>  
> @@ -159,7 +161,7 @@ static int ad5764_read(struct iio_dev *indio_dev, unsigned int reg,
>  	if (ret >= 0)
>  		*val = be32_to_cpu(st->data[1].d32) & 0xffff;
>  
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret;
>  }
> @@ -295,6 +297,8 @@ static int ad5764_probe(struct spi_device *spi)
>  	indio_dev->num_channels = AD5764_NUM_CHANNELS;
>  	indio_dev->channels = st->chip_info->channels;
>  
> +	mutex_init(&st->lock);
> +
>  	if (st->chip_info->int_vref == 0) {
>  		st->vref_reg[0].supply = "vrefAB";
>  		st->vref_reg[1].supply = "vrefCD";

