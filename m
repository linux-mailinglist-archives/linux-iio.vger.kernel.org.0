Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2156E1D61DD
	for <lists+linux-iio@lfdr.de>; Sat, 16 May 2020 17:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgEPPPa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 May 2020 11:15:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbgEPPP3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 May 2020 11:15:29 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01277206F4;
        Sat, 16 May 2020 15:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589642129;
        bh=TvYmaQ8eMDWoMjGeOehMDYvi6OnPvQT2KhChiMq4ok8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FZ3yi1BwxUsykmQErmmXwqTLW/ZNxAk8WNI91vX7WEG8VLYS2DBPEyuPHAAcTtwvh
         YtJkiZfSitF0HvmmQRkSgebnfFbbGhas54gr/qCeY2n4k3IdUi24wQQetg7X2xx72+
         LKO2ICfxcZpeT4VaakE3nTWcVWDdwkX4LoMeFjyU=
Date:   Sat, 16 May 2020 16:15:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Stefan Popa" <stefan.popa@analog.com>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: dac: ad5360: Replace indio_dev->mlock with own
 device lock
Message-ID: <20200516161524.06266b79@archlinux>
In-Reply-To: <20200514083921.51966-1-sergiu.cuciurean@analog.com>
References: <20200514083921.51966-1-sergiu.cuciurean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 14 May 2020 11:39:19 +0300
Sergiu Cuciurean <sergiu.cuciurean@analog.com> wrote:

> As part of the general cleanup of indio_dev->mlock, this change replaces
> it with a local lock on the device's state structure.
> This also changes some internal functions to pass the pointer to the
> state-struct vs a ref to indio_dev just to access the state-struct again.
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Applied.  Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5360.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
> index 2ac428b957e3..3e0c9e84e8da 100644
> --- a/drivers/iio/dac/ad5360.c
> +++ b/drivers/iio/dac/ad5360.c
> @@ -67,6 +67,7 @@ struct ad5360_chip_info {
>   * @chip_info:		chip model specific constants, available modes etc
>   * @vref_reg:		vref supply regulators
>   * @ctrl:		control register cache
> + * @lock		lock to protect the data buffer during SPI ops
>   * @data:		spi transfer buffers
>   */
>  
> @@ -75,6 +76,7 @@ struct ad5360_state {
>  	const struct ad5360_chip_info	*chip_info;
>  	struct regulator_bulk_data	vref_reg[3];
>  	unsigned int			ctrl;
> +	struct mutex			lock;
>  
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
> @@ -205,10 +207,11 @@ static int ad5360_write(struct iio_dev *indio_dev, unsigned int cmd,
>  	unsigned int addr, unsigned int val, unsigned int shift)
>  {
>  	int ret;
> +	struct ad5360_state *st = iio_priv(indio_dev);
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	ret = ad5360_write_unlocked(indio_dev, cmd, addr, val, shift);
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret;
>  }
> @@ -229,7 +232,7 @@ static int ad5360_read(struct iio_dev *indio_dev, unsigned int type,
>  		},
>  	};
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  
>  	st->data[0].d32 = cpu_to_be32(AD5360_CMD(AD5360_CMD_SPECIAL_FUNCTION) |
>  		AD5360_ADDR(AD5360_REG_SF_READBACK) |
> @@ -240,7 +243,7 @@ static int ad5360_read(struct iio_dev *indio_dev, unsigned int type,
>  	if (ret >= 0)
>  		ret = be32_to_cpu(st->data[1].d32) & 0xffff;
>  
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret;
>  }
> @@ -261,7 +264,7 @@ static int ad5360_update_ctrl(struct iio_dev *indio_dev, unsigned int set,
>  	struct ad5360_state *st = iio_priv(indio_dev);
>  	unsigned int ret;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  
>  	st->ctrl |= set;
>  	st->ctrl &= ~clr;
> @@ -269,7 +272,7 @@ static int ad5360_update_ctrl(struct iio_dev *indio_dev, unsigned int set,
>  	ret = ad5360_write_unlocked(indio_dev, AD5360_CMD_SPECIAL_FUNCTION,
>  			AD5360_REG_SF_CTRL, st->ctrl, 0);
>  
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret;
>  }
> @@ -479,6 +482,8 @@ static int ad5360_probe(struct spi_device *spi)
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->num_channels = st->chip_info->num_channels;
>  
> +	mutex_init(&st->lock);
> +
>  	ret = ad5360_alloc_channels(indio_dev);
>  	if (ret) {
>  		dev_err(&spi->dev, "Failed to allocate channel spec: %d\n", ret);

